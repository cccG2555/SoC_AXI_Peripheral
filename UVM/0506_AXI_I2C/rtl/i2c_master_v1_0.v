
`timescale 1 ns / 1 ps

module i2c_master_v1_0 #(
    // Users to add parameters here

    // User parameters ends
    // Do not modify the parameters beyond this line


    // Parameters of Axi Slave Bus Interface S00_AXI
    parameter integer C_S00_AXI_DATA_WIDTH = 32,
    parameter integer C_S00_AXI_ADDR_WIDTH = 4
) (
    // Users to add ports here


    output wire scl,
    inout  wire sda,

    // User ports ends
    // Do not modify the ports beyond this line


    // Ports of Axi Slave Bus Interface S00_AXI
    input wire s00_axi_aclk,
    input wire s00_axi_aresetn,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
    input wire [2 : 0] s00_axi_awprot,
    input wire s00_axi_awvalid,
    output wire s00_axi_awready,
    input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
    input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
    input wire s00_axi_wvalid,
    output wire s00_axi_wready,
    output wire [1 : 0] s00_axi_bresp,
    output wire s00_axi_bvalid,
    input wire s00_axi_bready,
    input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
    input wire [2 : 0] s00_axi_arprot,
    input wire s00_axi_arvalid,
    output wire s00_axi_arready,
    output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
    output wire [1 : 0] s00_axi_rresp,
    output wire s00_axi_rvalid,
    input wire s00_axi_rready
);

    wire w_cmd_start, w_cmd_write, w_cmd_read, w_cmd_stop, w_ack_in, w_done, w_ack_out, w_busy;
    wire [7:0] w_tx_data, w_rx_data;


    // Instantiation of Axi Bus Interface S00_AXI
    i2c_master_v1_0_S00_AXI #(
        .C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
    ) i2c_master_v1_0_S00_AXI_inst (


        .cmd_start(w_cmd_start),
        .cmd_write(w_cmd_write),
        .cmd_read(w_cmd_read),
        .cmd_stop(w_cmd_stop),
        .tx_data(w_tx_data),
        .ack_in(w_ack_in),
        .rx_data(w_rx_data),
        .done(w_done),
        .ack_out(w_ack_out),
        .busy(w_busy),




        .S_AXI_ACLK(s00_axi_aclk),
        .S_AXI_ARESETN(s00_axi_aresetn),
        .S_AXI_AWADDR(s00_axi_awaddr),
        .S_AXI_AWPROT(s00_axi_awprot),
        .S_AXI_AWVALID(s00_axi_awvalid),
        .S_AXI_AWREADY(s00_axi_awready),
        .S_AXI_WDATA(s00_axi_wdata),
        .S_AXI_WSTRB(s00_axi_wstrb),
        .S_AXI_WVALID(s00_axi_wvalid),
        .S_AXI_WREADY(s00_axi_wready),
        .S_AXI_BRESP(s00_axi_bresp),
        .S_AXI_BVALID(s00_axi_bvalid),
        .S_AXI_BREADY(s00_axi_bready),
        .S_AXI_ARADDR(s00_axi_araddr),
        .S_AXI_ARPROT(s00_axi_arprot),
        .S_AXI_ARVALID(s00_axi_arvalid),
        .S_AXI_ARREADY(s00_axi_arready),
        .S_AXI_RDATA(s00_axi_rdata),
        .S_AXI_RRESP(s00_axi_rresp),
        .S_AXI_RVALID(s00_axi_rvalid),
        .S_AXI_RREADY(s00_axi_rready)
    );

    // Add user logic here

    I2C_Master U_I2C_MASTER (  // Top I2C Master
        .clk(s00_axi_aclk),
        .rst(~s00_axi_aresetn),
        .cmd_start(w_cmd_start),
        .cmd_write(w_cmd_write),
        .cmd_read(w_cmd_read),
        .cmd_stop(w_cmd_stop),
        .tx_data(w_tx_data),
        .ack_in(w_ack_in),
        .rx_data(w_rx_data),
        .done(w_done),
        .ack_out(w_ack_out),
        .busy(w_busy),
        .scl(scl),
        .sda(sda)
    );



    // User logic ends

endmodule







/*
module I2C_Master (  // Top I2C Master
    input        clk,
    input        rst,
    // command port
    input        cmd_start,
    input        cmd_write,
    input        cmd_read,
    input        cmd_stop,
    input  [7:0] tx_data,
    input        ack_in,
    // internal output
    output [7:0] rx_data,
    output       done,
    output       ack_out,
    output       busy,
    // external port
    output       scl,
    inout        sda
);
    wire sda_o, sda_i;

    assign sda_i = sda;
    assign sda   = (sda_o) ? 1'bz : 1'b0;  // GND (Open Drain logic)


    i2c_master u_i2c_master (
        .clk      (clk),
        .rst      (rst),
        .cmd_start(cmd_start),
        .cmd_write(cmd_write),
        .cmd_read (cmd_read),
        .cmd_stop (cmd_stop),
        .tx_data  (tx_data),
        .ack_in   (ack_in),
        .rx_data  (rx_data),
        .done     (done),
        .ack_out  (ack_out),
        .busy     (busy),
        .scl      (scl),
        .sda_o    (sda_o),
        .sda_i    (sda_i)
    );

endmodule


module i2c_master (
    input            clk,
    input            rst,
    // command port
    input            cmd_start,
    input            cmd_write,
    input            cmd_read,
    input            cmd_stop,
    input      [7:0] tx_data,
    input            ack_in,
    // internal output
    output reg [7:0] rx_data,
    output reg       done,
    output reg       ack_out,
    output           busy,
    // external port
    output           scl,
    output           sda_o,
    input            sda_i
);

    // State definitions using localparam
    localparam IDLE = 3'd0;
    localparam START = 3'd1;
    localparam WAIT_CMD = 3'd2;
    localparam DATA = 3'd3;
    localparam DATA_ACK = 3'd4;
    localparam STOP = 3'd5;

    reg [2:0] state;

    // SCL Frequency calculation: 100MHz / (100kHz * 4) = 250
    localparam FREQ = ((100_000_000) / (100_000 * 4));

    reg [$clog2(FREQ)-1:0] div_cnt;
    reg                    qtr_tick;
    reg scl_r, sda_r;
    reg [1:0] step;
    reg [7:0] tx_shift_reg, rx_shift_reg;
    reg       is_read;
    reg       ack_in_r;
    reg [2:0] bit_cnt;

    assign scl   = scl_r;
    assign sda_o = sda_r;
    assign busy  = (state != IDLE);

    // qtr_tick generator
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            div_cnt  <= 8'd0;
            qtr_tick <= 1'b0;
        end else begin
            if (div_cnt == FREQ - 1) begin
                div_cnt  <= 8'd0;
                qtr_tick <= 1'b1;
            end else begin
                div_cnt  <= div_cnt + 1'b1;
                qtr_tick <= 1'b0;
            end
        end
    end

    // state machine
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state        <= IDLE;
            rx_data      <= 8'd0;
            done         <= 1'b0;
            ack_out      <= 1'b1;
            scl_r        <= 1'b1;
            sda_r        <= 1'b1;
            step         <= 2'd0;
            tx_shift_reg <= 8'd0;
            rx_shift_reg <= 8'd0;
            is_read      <= 1'b0;
            bit_cnt      <= 3'd0;
            ack_in_r     <= 1'b1;
        end else begin
            case (state)
                IDLE: begin
                    scl_r <= 1'b1;
                    sda_r <= 1'b1;
                    done  <= 1'b0;
                    if (cmd_start) begin
                        state <= START;
                        step  <= 2'd0;
                    end
                end

                START: begin
                    if (qtr_tick) begin
                        case (step)
                            2'd0: begin
                                scl_r <= 1'b1;
                                sda_r <= 1'b1;
                                step  <= 2'd1;
                            end
                            2'd1: begin
                                sda_r <= 1'b0;
                                step  <= 2'd2;
                            end
                            2'd2: begin
                                step <= 2'd3;
                            end
                            2'd3: begin
                                scl_r <= 1'b0;
                                step  <= 2'd0;
                                done  <= 1'b1;
                                state <= WAIT_CMD;
                            end
                        endcase
                    end
                end

                WAIT_CMD: begin
                    done <= 1'b0;
                    if (cmd_write) begin
                        tx_shift_reg <= tx_data;
                        bit_cnt      <= 3'd0;
                        is_read      <= 1'b0;
                        state        <= DATA;
                    end else if (cmd_read) begin
                        rx_shift_reg <= 8'h0;
                        bit_cnt      <= 3'd0;
                        is_read      <= 1'b1;
                        ack_in_r     <= ack_in;
                        state        <= DATA;
                    end else if (cmd_stop) begin
                        state <= STOP;
                    end else if (cmd_start) begin
                        state <= START;
                    end
                end

                DATA: begin
                    if (qtr_tick) begin
                        case (step)
                            2'd0: begin
                                scl_r <= 1'b0;
                                sda_r <= is_read ? 1'b1 : tx_shift_reg[7];
                                step  <= 2'd1;
                            end
                            2'd1: begin
                                scl_r <= 1'b1;
                                step  <= 2'd2;
                            end
                            2'd2: begin
                                scl_r <= 1'b1;
                                if (is_read) begin
                                    rx_shift_reg <= {rx_shift_reg[6:0], sda_i};
                                end
                                step <= 2'd3;
                            end
                            2'd3: begin
                                scl_r <= 1'b0;
                                if (!is_read) begin
                                    tx_shift_reg <= {tx_shift_reg[6:0], 1'b0};
                                end
                                step <= 2'd0;
                                if (bit_cnt == 3'd7) begin
                                    bit_cnt <= 3'd0;
                                    state   <= DATA_ACK;
                                end else begin
                                    bit_cnt <= bit_cnt + 1'b1;
                                end
                            end
                        endcase
                    end
                end

                DATA_ACK: begin
                    if (qtr_tick) begin
                        case (step)
                            2'd0: begin
                                scl_r <= 1'b0;
                                if (is_read) begin
                                    sda_r <= ack_in_r;
                                end else begin
                                    sda_r <= 1'b1; // Master release SDA to receive ACK
                                end
                                step <= 2'd1;
                            end
                            2'd1: begin
                                scl_r <= 1'b1;
                                step  <= 2'd2;
                            end
                            2'd2: begin
                                scl_r <= 1'b1;
                                if (!is_read) begin
                                    ack_out <= sda_i;
                                end
                                if (is_read) begin
                                    rx_data <= rx_shift_reg;
                                end
                                step <= 2'd3;
                            end
                            2'd3: begin
                                scl_r <= 1'b0;
                                done  <= 1'b1;
                                step  <= 2'd0;
                                state <= WAIT_CMD;
                            end
                        endcase
                    end
                end

                STOP: begin
                    if (qtr_tick) begin
                        case (step)
                            2'd0: begin
                                scl_r <= 1'b0;
                                sda_r <= 1'b0;
                                step  <= 2'd1;
                            end
                            2'd1: begin
                                scl_r <= 1'b1;
                                step  <= 2'd2;
                            end
                            2'd2: begin
                                sda_r <= 1'b1;
                                step  <= 2'd3;
                            end
                            2'd3: begin
                                step  <= 2'd0;
                                done  <= 1'b1;
                                state <= IDLE;
                            end
                        endcase
                    end
                end

                default: begin
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
*/
