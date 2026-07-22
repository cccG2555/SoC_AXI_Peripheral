`include "define.svh"

`include "uvm_macros.svh"
import uvm_pkg::*;

`define AXI_DATA_WIDTH 32
`define AXI_ADDR_WIDTH 4


interface axi_i2c_if (
		input logic clk,
		input logic rstn
);
    // Users ports
	logic cmd_start;
	logic cmd_write;
	logic cmd_read;
	logic cmd_stop;
	logic ack_in;
	logic ack_out;
	logic rw;
	logic [4:0] num_tr;
	


    logic [7:0] i2c_s_tx_data;
    logic [7:0] i2c_s_rx_data;
    logic       i2c_s_done;
    logic       i2c_s_busy;
    // Ports of Axi
    logic [    `AXI_ADDR_WIDTH-1 : 0]	   awaddr;
    logic [                         2 : 0] awprot;
    logic                                  awvalid;
    logic                                  awready;
    logic [    `AXI_DATA_WIDTH-1 : 0]	   wdata;
    logic [(`AXI_DATA_WIDTH/8)-1 : 0]	   wstrb;
    logic                                  wvalid;
    logic                                  wready;
    logic [                         1 : 0] bresp;
    logic                                  bvalid;
    logic                                  bready;
    logic [    `AXI_ADDR_WIDTH-1 : 0]	   araddr;
    logic [                         2 : 0] arprot;
    logic                                  arvalid;
    logic                                  arready;
    logic [    `AXI_DATA_WIDTH-1 : 0]	   rdata;
    logic [                         1 : 0] rresp;
    logic                                  rvalid;
    logic                                  rready;

	clocking drv_cb @(posedge clk);
		default input #1step output #0;
		// Users ports
		output i2c_s_tx_data;
		input i2c_s_rx_data;
		input i2c_s_done;
		input i2c_s_busy;
    	// Ports of Axi
    	output awaddr;
    	output awprot;
    	output awvalid;
    	input  awready;
    	output wdata;
    	output wstrb;
    	output wvalid;
    	input  wready;
    	input  bresp;
    	input  bvalid;
    	output bready;
    	output araddr;
    	output arprot;
    	output arvalid;
    	input  arready;
    	input  rdata;
    	input  rresp;
    	input  rvalid;
    	output rready;

		output cmd_start;
		output cmd_write;
		output cmd_read;
		output cmd_stop;
		output ack_in;
		input ack_out;
		output rw;
		output num_tr;
	endclocking

	clocking mon_cb @(posedge clk);
		default input #1step output #0;
		// Users ports
		input i2c_s_tx_data;
		input i2c_s_rx_data;
		input i2c_s_done;
		input i2c_s_busy;
    	// Ports of Axi
    	input awaddr;
    	input awprot;
    	input awvalid;
    	input awready;
    	input wdata;
    	input wstrb;
    	input wvalid;
    	input wready;
    	input bresp;
    	input bvalid;
    	input bready;
    	output araddr;
    	output arprot;
    	output arvalid;
    	input arready;
    	input rdata;
    	input rresp;
    	input rvalid;
    	output rready;

		input cmd_start;
		input cmd_write;
		input cmd_read;
		input cmd_stop;
		input ack_in;
		input ack_out;
		input rw;
		input num_tr;
	endclocking

endinterface



class axi_i2c_seq_item extends uvm_sequence_item;
		rand logic [4:0] num_tr;
		logic ack_in;
		logic ack_out;
		logic cmd_start;
		rand logic cmd_write;
		rand logic cmd_read;
		logic cmd_stop;
		logic [4:0] num_tr;

		rand logic	[7:0]	i2c_m_tx_data;
		logic		[7:0]	i2c_m_rx_data;
		rand logic	[7:0]	i2c_s_tx_data;
		logic		[7:0]	i2c_s_rx_data;


		`uvm_object_utils_begin(axi_i2c_seq_item)
			`uvm_field_int(num_tr, UVM_ALL_ON)
			`uvm_field_int(ack_in, UVM_ALL_ON)
			`uvm_field_int(ack_out, UVM_ALL_ON)
			`uvm_field_int(cmd_start, UVM_ALL_ON)
			`uvm_field_int(cmd_write, UVM_ALL_ON)
			`uvm_field_int(cmd_read, UVM_ALL_ON)
			`uvm_field_int(cmd_stop, UVM_ALL_ON)
			`uvm_field_int(num_tr, UVM_ALL_ON)
			`uvm_field_int(i2c_m_tx_data, UVM_ALL_ON)
			`uvm_field_int(i2c_m_rx_data, UVM_ALL_ON)
			`uvm_field_int(i2c_s_tx_data, UVM_ALL_ON)
			`uvm_field_int(i2c_s_rx_data, UVM_ALL_ON)
		`uvm_object_utils_end
		
	
	
		constraint c_i2c_tx_data {
			i2c_m_tx_data inside {[8'h00:8'hff]};
			i2c_s_tx_data inside {[8'h00:8'hff]};
		}

		constraint c_r_w {
			cmd_write == ~cmd_read;
		}

		constraint c_num_tr {
			num_tr inside {[1:16]};
		}


		function new(string name = "seq_item");
			super.new(name);
		endfunction

		function string convert2string();
			return $sformatf("RW=%0b/%0b, num_tr=%0d, [Master] tx_data=0x%0h, [Slave] tx_data=0x%0h", cmd_read, cmd_write, num_tr, i2c_m_tx_data, i2c_s_tx_data);
			//return $sformatf("RW=%0b/%0b, num_tr=%0d, [Master] tx_data=0x%0h, rx_data=0x%0h, [Slave] tx_data=0x%0h, rx_data=0x%0h", cmd_read, cmd_write, num_tr, i2c_m_tx_data, i2c_m_rx_data, i2c_s_tx_data, i2c_s_rx_data);
		endfunction

endclass




class axi_i2c_seq extends uvm_sequence #(axi_i2c_seq_item);
	`uvm_object_utils(axi_i2c_seq)
	int num_trans = 10;

	function new(string name = "axi_i2c_seq");
		super.new(name);
	endfunction

	task body();
		axi_i2c_seq_item item;
		repeat(num_trans) begin
			item = axi_i2c_seq_item::type_id::create("item");
			start_item(item);
			if (!item.randomize()) begin
				`uvm_fatal(get_type_name(), "randomization failed")
			end
			`uvm_info(get_type_name(), $sformatf("seq send : %s", item.convert2string()), UVM_MEDIUM)
			finish_item(item);
		end
	endtask
endclass



class axi_i2c_driver extends uvm_driver #(axi_i2c_seq_item);
	`uvm_component_utils(axi_i2c_driver)
	virtual axi_i2c_if v_if;
	logic [31:0] ctrl_reg;
	logic [31:0] axi_rdata;
	event i2c_start_ev, i2c_done_ev;
	logic r_w;	// 1: READ, 0: WRITE was the previous operation

	function new(string name = "axi_i2c_drv", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual axi_i2c_if)::get(this, "", "v_if", v_if)) begin
			`uvm_fatal(get_type_name(), "cannot access to interface")	
		end
		// cpol=0, cpha=0, clk_div=4
		ctrl_reg = {16'h0, 8'h04, 6'h0, 1'b0, 1'b0};
	endfunction

	virtual task run_phase(uvm_phase phase);
		// drive item to interface
		axi_i2c_seq_item item;
		wait(v_if.rstn==1);	// necessary?

		v_if.wstrb = 4'hf;

		forever begin
			seq_item_port.get_next_item(item);

			`uvm_info(get_type_name(), $sformatf("got item : %s", item.convert2string()), UVM_HIGH)
			
			// for coverage
			v_if.drv_cb.num_tr <= item.num_tr;

			i2c_master_start(item);
			i2c_master_addr(item);

//			->i2c_start_ev;
			
			if (item.cmd_write) begin
				i2c_master_write(item);
			end else if (item.cmd_read) begin
				i2c_master_read(item);
			end

			i2c_master_stop();
			
			//->i2c_start_ev;
		
			//@(i2c_done_ev);
			do begin
				axi_read(8'hc, axi_rdata);
			end while (axi_rdata[0]==1);	// busy check

			seq_item_port.item_done();
		end
	endtask


	task i2c_master_start(axi_i2c_seq_item item);
		do begin
			axi_read(8'hc, axi_rdata);
		end while (axi_rdata[0]==1);


		// slave tx_data
		v_if.i2c_s_tx_data <= item.i2c_s_tx_data;
		// master tx_data
		axi_write(8'h4, {24'b0, item.i2c_m_tx_data});


		// start 1
		axi_write(8'h0, {27'b0, 4'b0, 1'b1});
		@(v_if.drv_cb);
		// start 0
		axi_write(8'h0, {27'b0, 4'b0, 1'b0});
		
		
		do begin
			axi_read(8'hc, axi_rdata);
		end while (axi_rdata[1]==0);
		
		
		
		@(v_if.drv_cb);
	endtask


	task i2c_master_addr(axi_i2c_seq_item item);
		// addr
		if (item.cmd_write) begin
			axi_write(8'h4, {7'h12, 1'b0});
		end else if (item.cmd_read) begin
			axi_write(8'h4,{7'h12, 1'b1});
		end
	
		axi_write(8'h0, {30'b0, 1'b1, 1'b0});
		@(v_if.drv_cb);
		axi_write(8'h0, {30'b0, 1'b0, 1'b0});
		do begin
			axi_read(8'hc, axi_rdata);
		end while (axi_rdata[1]==0);
		
		axi_write(8'h0, 32'b0);
		@(v_if.drv_cb);
	endtask


	task i2c_master_write(axi_i2c_seq_item item);
		for (int i=0;i<item.num_tr; i++) begin
			// slave tx_data
			//v_if.i2c_s_tx_data <= item.i2c_s_tx_data;
			// master tx_data
			axi_write(8'h4, {24'b0, item.i2c_m_tx_data});
			// ack_in=1, cmd_write=1
			axi_write(8'h0, {27'b0, 1'b1, 2'b0, 1'b1, 1'b0});
			@(v_if.drv_cb);
			@(v_if.drv_cb);
			axi_write(8'h0, {27'b0, 1'b1, 2'b0, 1'b0, 1'b0});
			v_if.drv_cb.rw <= 1'b0;	// write
			@(v_if.drv_cb);
			
			do begin
				axi_read(8'hc, axi_rdata);
			end while (axi_rdata[1]==0);
			
			@(v_if.drv_cb);
			->i2c_start_ev;
			@(i2c_done_ev);
		end
	endtask

	task i2c_master_read(axi_i2c_seq_item item);
		for (int i=0; i<item.num_tr; i++) begin
			v_if.drv_cb.rw <= 1'b1;	// notify monitor READ
			// slave tx_data
			v_if.i2c_s_tx_data <= item.i2c_s_tx_data;
			// master tx_data
			//axi_write(8'h4, {24'b0, item.i2c_m_tx_data});

			if (i == (item.num_tr - 1)) begin
				// NACK
				axi_write(8'h0, {27'b0, 1'b1, 1'b0, 1'b1, 2'b0});
			@(v_if.drv_cb);
			@(v_if.drv_cb);
				// prevent duplicated READ
				axi_write(8'h0, {27'b0, 1'b1, 1'b0, 1'b0, 2'b0});
			end else begin
				// ACK
				axi_write(8'h0, {27'b0, 1'b0, 1'b0, 1'b1, 2'b0});
			@(v_if.drv_cb);
			@(v_if.drv_cb);
				// prevent duplicated READ
				axi_write(8'h0, {27'b0, 1'b0, 1'b0, 1'b0, 2'b0});
			end
			// check done
			@(v_if.drv_cb);
			
			do begin
				axi_read(8'hc, axi_rdata);
			end while (axi_rdata[1]==0);
			@(v_if.drv_cb);
			@(v_if.drv_cb);

			->i2c_start_ev;
			@(i2c_done_ev);
		end
	endtask

	task i2c_master_stop();
		// cmd_stop
		axi_write(8'h0, {27'b0, 1'b0, 1'b1, 3'b0});
		@(v_if.drv_cb);
		axi_write(8'h0, {27'b0, 1'b0, 1'b0, 3'b0});
		
		@(v_if.drv_cb);
	endtask
	


	task axi_write(input logic [31:0] waddr, input logic [31:0] wdata);
		fork
			axi_aw(waddr);
			axi_w(wdata);
		join
			axi_b();
	endtask
	task axi_read(input logic [31:0] raddr, output logic [31:0] rdata);
		fork
			axi_ar(raddr);
			axi_r(rdata);
		join
	endtask


	task axi_aw(logic [31:0] addr);
		`uvm_info("axi_aw", "start", UVM_DEBUG)
		v_if.drv_cb.awaddr <= addr;
		v_if.drv_cb.awvalid <= 1;
		wait(v_if.drv_cb.awready==1);
		v_if.drv_cb.awvalid <= 0;
		`uvm_info("axi_aw", "end", UVM_DEBUG)
	endtask
	task axi_w(logic [31:0] data);
		`uvm_info("axi_w", "start", UVM_DEBUG)
		v_if.drv_cb.wdata <= data;
		v_if.drv_cb.wvalid <= 1;
		wait(v_if.drv_cb.wready==1);
		v_if.drv_cb.wvalid <= 0;
		`uvm_info("axi_w", "end", UVM_DEBUG)
	endtask
	task axi_b();
		`uvm_info("axi_b", "start", UVM_DEBUG)
		v_if.drv_cb.bready <= 1;
		wait(v_if.drv_cb.bvalid==1);
		v_if.drv_cb.bready <= 0;
		`uvm_info("axi_b", "end", UVM_DEBUG)
	endtask
	task axi_ar(logic [31:0] addr);
		`uvm_info("axi_ar", "start", UVM_DEBUG)
		v_if.drv_cb.araddr <= addr;
		v_if.drv_cb.arvalid <= 1;
		wait(v_if.drv_cb.arready==1);
		v_if.drv_cb.arvalid <= 0;
		`uvm_info("axi_ar", "end", UVM_DEBUG)
	endtask
	task axi_r(output logic [31:0] data);
		`uvm_info("axi_r", "start", UVM_DEBUG)
		v_if.drv_cb.rready <= 0;
		v_if.drv_cb.rready <= 1;
		
		do begin
			@(v_if.drv_cb);
		end while (v_if.drv_cb.rvalid != 1'b1);

		data = v_if.drv_cb.rdata;
		v_if.drv_cb.rready <= 0;
		@(v_if.drv_cb);
		`uvm_info("axi_r", "end", UVM_DEBUG)
	endtask
endclass


class axi_i2c_monitor extends uvm_monitor;
	`uvm_component_utils(axi_i2c_monitor)
	virtual axi_i2c_if v_if;
	uvm_analysis_port #(axi_i2c_seq_item) ap;

	logic [31:0] axi_rdata;
	event i2c_start_ev, i2c_done_ev;

	function new(string name = "axi_i2c_mon", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual axi_i2c_if)::get(this, "", "v_if", v_if)) begin
			`uvm_fatal(get_type_name(), "cannot access to interface")
		end
		ap = new("ap", this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			axi_i2c_seq_item item = axi_i2c_seq_item::type_id::create("item", this);


			`uvm_info(get_type_name(), $sformatf("monitor wating i2c_start_ev"), UVM_HIGH)
			@(i2c_start_ev);

			// wait until SPI Master busy 0
			`uvm_info(get_type_name(), $sformatf("monitor got i2c_start_ev"), UVM_HIGH)
			
			do begin
				axi_read(8'hc, axi_rdata);
			//end while (axi_rdata[0]==1);	// busy check
			end while (axi_rdata[1]==0);	// done check for burst
			
		
			@(v_if.drv_cb);
			@(v_if.drv_cb);

			if (v_if.mon_cb.rw) begin
				item.cmd_write = 1'b0;
				item.cmd_read = 1'b1;
			end else begin
				item.cmd_write = 1'b1;
				item.cmd_read = 1'b0;
			end
			item.i2c_s_tx_data = v_if.i2c_s_tx_data;
			item.i2c_s_rx_data = v_if.i2c_s_rx_data;

			axi_read(4'h4, axi_rdata);
			item.i2c_m_tx_data = axi_rdata[7:0];
			@(v_if.mon_cb);
			axi_read(4'h8, axi_rdata);
			item.i2c_m_rx_data = axi_rdata[7:0];

			// for coverage
			item.num_tr = v_if.mon_cb.num_tr;

			`uvm_info(get_type_name(), $sformatf("monitor read : %s", item.convert2string()), UVM_HIGH)

			ap.write(item);
			->i2c_done_ev;
		end
	endtask


	task axi_read(input logic [31:0] raddr, output logic [31:0] rdata);
		fork
			axi_ar(raddr);
			axi_r(rdata);
		join
		`uvm_info(get_type_name(), $sformatf("%saxi_rdata=%0h%s", `CLR_RED, rdata, `CLR_RESET), UVM_DEBUG)
	endtask

	task axi_ar(logic [31:0] addr);
		`uvm_info("axi_ar", "start", UVM_DEBUG)
		v_if.mon_cb.araddr <= addr;
		v_if.mon_cb.arvalid <= 1;
		wait(v_if.mon_cb.arready==1);
		v_if.mon_cb.arvalid <= 0;
		`uvm_info("axi_ar", "end", UVM_DEBUG)
	endtask
	task axi_r(output logic [31:0] data);
		`uvm_info("axi_r", "start", UVM_DEBUG)
		wait(v_if.arvalid==1);
		v_if.mon_cb.rready <= 1;
		wait(v_if.mon_cb.rvalid==1);
		v_if.mon_cb.rready <= 0;
		@(v_if.drv_cb);
		data = v_if.mon_cb.rdata;
		`uvm_info("axi_r", "end", UVM_DEBUG)
	endtask

endclass

class axi_i2c_agent extends uvm_agent;
	`uvm_component_utils(axi_i2c_agent)

	axi_i2c_driver drv;
	axi_i2c_monitor mon;
	uvm_sequencer #(axi_i2c_seq_item) sqr;
	event i2c_start_ev, i2c_done_ev;

	function new(string name = "axi_i2c_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv = axi_i2c_driver::type_id::create("drv", this);
		mon = axi_i2c_monitor::type_id::create("mon", this);
		sqr = uvm_sequencer#(axi_i2c_seq_item)::type_id::create("sqr", this);

		drv.i2c_start_ev = i2c_start_ev;
		drv.i2c_done_ev = i2c_done_ev;
		mon.i2c_start_ev = i2c_start_ev;
		mon.i2c_done_ev = i2c_done_ev;
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
endclass

class axi_i2c_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(axi_i2c_scoreboard)
	uvm_analysis_imp #(axi_i2c_seq_item, axi_i2c_scoreboard) ap_imp;
	int pass_cnt = 0;
	int fail_cnt = 0;
	int err_cnt = 0;

	function new(string name = "axi_i2c_scb", uvm_component parent);
		super.new(name, parent);
		ap_imp = new("ap_imp", this);
	endfunction

	function void write(axi_i2c_seq_item item);
         if ((item.cmd_write)&&(!item.cmd_read)) begin
             // WRITE
             if (item.i2c_m_tx_data == item.i2c_s_rx_data) begin
                 `uvm_info(get_type_name(), $sformatf("%s[PASS]%s M->S : 0x%0h", `CLR_GRN, `CLR_RESET, item.i2c_m_tx_data    ), UVM_MEDIUM)
                 pass_cnt++;
             end else begin
                 `uvm_error(get_type_name(), $sformatf("%s[FAIL]%s M->S : 0x%0h -> 0x%0h", `CLR_RED, `CLR_RESET, item    .i2c_m_tx_data, item.i2c_s_rx_data))
                 fail_cnt++;
             end
         end else if (!(item.cmd_write)&(item.cmd_read)) begin
             // READ
             if (item.i2c_m_rx_data == item.i2c_s_tx_data) begin
                 `uvm_info(get_type_name(), $sformatf("%s[PASS]%s S->M : 0x%0h", `CLR_GRN, `CLR_RESET, item.i2c_s_tx_data), UVM_MEDIUM)
                 pass_cnt++;
             end else begin
                 `uvm_error(get_type_name(), $sformatf("%s[FAIL]%s S->M : 0x%0h -> 0x%0h", `CLR_RED, `CLR_RESET, item.i2c_s_tx_data, item.i2c_m_rx_data))
                 fail_cnt++;
             end
         end else begin
             `uvm_error(get_type_name(), $sformatf("[SCB] !!! ERROR !!! write(%0b)/read(%0b) cmd in same time", item.cmd_write, item.cmd_read))
             err_cnt++;
         end
     endfunction


	virtual function void report_phase(uvm_phase phase);
		super.report_phase(phase);
         `uvm_info(get_type_name(), $sformatf("\n\n ====== Scoreboard Result ====== "), UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("pass_cnt = %0d/%0d", pass_cnt, pass_cnt+fail_cnt), UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("fail_cnt = %0d/%0d", fail_cnt, pass_cnt+fail_cnt), UVM_LOW)
         `uvm_info(get_type_name(), $sformatf(" ====== Scoreboard Result ====== \n\n"), UVM_LOW)
	endfunction
endclass



class axi_i2c_coverage extends uvm_subscriber#(axi_i2c_seq_item);
	`uvm_component_utils(axi_i2c_coverage)

	logic [7:0] cov_tx_data_m, cov_tx_data_s;
	logic [4:0] cov_num_tr;

     covergroup cg_data;
         cp_tx_data_m: coverpoint cov_tx_data_m {
             bins zero = {8'h00};
             bins all_1 = {8'hff};
             bins alt_01 = {8'h55};
             bins alt_10 = {8'haa};
             bins lsb_only = {8'h01};
             bins msb_only = {8'h80};
             bins range0 = {[8'h00:8'h0f]};
             bins range1 = {[8'h10:8'h1f]};
             bins range2 = {[8'h20:8'h2f]};
             bins range3 = {[8'h30:8'h3f]};
             bins range4 = {[8'h40:8'h4f]};
             bins range5 = {[8'h50:8'h5f]};
             bins range6 = {[8'h60:8'h6f]};
             bins range7 = {[8'h70:8'h7f]};
             bins range8 = {[8'h80:8'h8f]};
             bins range9 = {[8'h90:8'h9f]};
             bins rangea = {[8'ha0:8'haf]};
             bins rangeb = {[8'hb0:8'hbf]};
             bins rangec = {[8'hc0:8'hcf]};
             bins ranged = {[8'hd0:8'hdf]};
             bins rangee = {[8'he0:8'hef]};
             bins rangef = {[8'hf0:8'hff]};
         }
         cp_tx_data_s: coverpoint cov_tx_data_s {
             bins zero = {8'h00};
             bins all_1 = {8'hff};
             bins alt_01 = {8'h55};
             bins alt_10 = {8'haa};
             bins lsb_only = {8'h01};
             bins msb_only = {8'h80};
             bins range0 = {[8'h00:8'h0f]};
             bins range1 = {[8'h10:8'h1f]};
             bins range2 = {[8'h20:8'h2f]};
             bins range3 = {[8'h30:8'h3f]};
             bins range4 = {[8'h40:8'h4f]};
             bins range5 = {[8'h50:8'h5f]};
             bins range6 = {[8'h60:8'h6f]};
             bins range7 = {[8'h70:8'h7f]};
             bins range8 = {[8'h80:8'h8f]};
             bins range9 = {[8'h90:8'h9f]};
             bins rangea = {[8'ha0:8'haf]};
             bins rangeb = {[8'hb0:8'hbf]};
             bins rangec = {[8'hc0:8'hcf]};
             bins ranged = {[8'hd0:8'hdf]};
             bins rangee = {[8'he0:8'hef]};
             bins rangef = {[8'hf0:8'hff]};
         }
		cp_num_tr: coverpoint cov_num_tr {
             bins low = {[1:8]};
             bins high = {[9:16]};
         }
     endgroup

	 function new(string name = "axi_i2c_cov", uvm_component parent);
		super.new(name, parent);
		cg_data = new();
	 endfunction

	 function void write(axi_i2c_seq_item item);
		cov_tx_data_m = item.i2c_m_tx_data;
		cov_tx_data_s = item.i2c_s_tx_data;
		cov_num_tr = item.num_tr;
		cg_data.sample();
	 endfunction

     function void report_phase(uvm_phase phase);
         `uvm_info(get_type_name(), "\n\n ===== Coverage Report ===== ", UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("coverage cg_data=%.1f%%", cg_data.get_coverage()), UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("coverage i2c_m_tx_data=%.1f%%", cg_data.cp_tx_data_m.get_coverage()), UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("coverage i2c_s_tx_data=%.1f%%", cg_data.cp_tx_data_s.get_coverage()), UVM_LOW)
		`uvm_info(get_type_name(), $sformatf("coverage num_tr=%.1f%%", cg_data.cp_num_tr.get_coverage()), UVM_LOW)
         `uvm_info(get_type_name(), " ===== Coverage Report ===== \n\n", UVM_LOW)
     endfunction

endclass

class axi_i2c_env extends uvm_env;
	`uvm_component_utils(axi_i2c_env)

	axi_i2c_agent agt;
	axi_i2c_scoreboard scb;
	axi_i2c_coverage cov;

	function new(string name = "axi_i2c_env", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agt = axi_i2c_agent::type_id::create("agt", this);
		scb = axi_i2c_scoreboard::type_id::create("scb", this);
		cov = axi_i2c_coverage::type_id::create("cov", this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agt.mon.ap.connect(scb.ap_imp);
		agt.mon.ap.connect(cov.analysis_export);
	endfunction
endclass


class axi_i2c_test extends uvm_test;
	`uvm_component_utils(axi_i2c_test)

	axi_i2c_env env;

	function new(string name = "axi_i2c_env", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = axi_i2c_env::type_id::create("env", this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		axi_i2c_seq seq;
		phase.raise_objection(this);
		seq = axi_i2c_seq::type_id::create("seq", this);
		seq.num_trans = 2000;
		seq.start(env.agt.sqr);
		phase.drop_objection(this);
	endtask
endclass



module tb_axi_i2c_uvm();

	logic clk, rstn;
	tri1 w_sda;
	wire w_scl;

	axi_i2c_if v_if(clk, rstn);

i2c_master_v1_0 #(
    .C_S00_AXI_DATA_WIDTH(32),
    .C_S00_AXI_ADDR_WIDTH(4)
) dut_m (
    .scl(w_scl),
    .sda(w_sda),
    // Ports of Axi Slave Bus Interface S00_AXI
    .s00_axi_aclk(clk),
    .s00_axi_aresetn(rstn),
    	.s00_axi_awaddr(v_if.awaddr),
    	.s00_axi_awprot(v_if.awprot),
    	.s00_axi_awvalid(v_if.awvalid),
    	.s00_axi_awready(v_if.awready),
    	.s00_axi_wdata(v_if.wdata),
    	.s00_axi_wstrb(v_if.wstrb),
    	.s00_axi_wvalid(v_if.wvalid),
    	.s00_axi_wready(v_if.wready),
    	.s00_axi_bresp(v_if.bresp),
    	.s00_axi_bvalid(v_if.bvalid),
    	.s00_axi_bready(v_if.bready),
    	.s00_axi_araddr(v_if.araddr),
    	.s00_axi_arprot(v_if.arprot),
    	.s00_axi_arvalid(v_if.arvalid),
    	.s00_axi_arready(v_if.arready),
    	.s00_axi_rdata(v_if.rdata),
    	.s00_axi_rresp(v_if.rresp),
    	.s00_axi_rvalid(v_if.rvalid),
    	.s00_axi_rready(v_if.rready)
);


i2c_slave dut_s (
    .clk(clk),
    .rst(~rstn),
    .tx_data(v_if.i2c_s_tx_data),
    .scl(w_scl),      // inout actually?
    .sda(w_sda),
    .rx_data(v_if.i2c_s_rx_data),
    .sending(v_if.i2c_s_busy),
    .done(v_if.i2c_s_done)
);



	always #5 clk = ~clk;

	initial begin
		clk = 0;
		rstn = 0;
		repeat(3) @(posedge clk);
		rstn = 1;
		@(posedge clk);
	end

	initial begin
		uvm_config_db#(virtual axi_i2c_if)::set(null, "*", "v_if", v_if);
		run_test("axi_i2c_test");

		#100;
		$finish;
	end

	initial begin
		$fsdbDumpfile("novas.fsdb");
		$fsdbDumpfile(0, tb_axi_i2c_uvm, "+all");
	end

endmodule
