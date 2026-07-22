`include "define.svh"

`include "uvm_macros.svh"
import uvm_pkg::*;

`define AXI_DATA_WIDTH 32
`define AXI_ADDR_WIDTH 4
//`define SPI_BASE_ADDR 32'h44A00000


interface axi_spi_if (
		input logic clk,
		input logic rstn
);
    // Users ports
    /*
	logic sclk;
    logic mosi;
    logic miso;
    logic cs_n;
	*/
    logic [7:0] spi_s_tx_data;
    logic [7:0] spi_s_rx_data;
    logic       spi_s_done;
    logic       spi_s_busy;
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
		output spi_s_tx_data;
		input spi_s_rx_data;
		input spi_s_done;
		input spi_s_busy;
	/*
    	input sclk;
    	input mosi;
    	output miso;
    	input cs_n;
	*/
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
	endclocking

	clocking mon_cb @(posedge clk);
		default input #1step output #0;
		input spi_s_tx_data;
		input spi_s_rx_data;
		input spi_s_done;
		input spi_s_busy;
		// Users ports
    /*
		input sclk;
    	input mosi;
    	input miso;
    	input cs_n;
	*/
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
	endclocking

endinterface



class axi_spi_seq_item extends uvm_sequence_item;
		rand logic	[7:0]	spi_m_tx_data;
		logic		[7:0]	spi_m_rx_data;
		rand logic	[7:0]	spi_s_tx_data;
		logic		[7:0]	spi_s_rx_data;
		//logic				spi_s_done;
		//`logic				spi_s_busy;
/*
    	logic sclk;
    	logic mosi;
    	logic miso;
    	logic cs_n;
*/
    	// Ports of Axi
    	//logic [    `AXI_ADDR_WIDTH-1 : 0]		awaddr;
//    	logic [                         2 : 0]	awprot;
//    	logic									awvalid;
//    	logic									awready;
    	//logic [    `AXI_DATA_WIDTH-1 : 0]		wdata;
//    	logic [(AXI_DATA_WIDTH/8)-1 : 0]		wstrb;
//    	logic									wvalid;
//    	logic									wready;
//    	logic[                         1 : 0]	bresp;
//    	logic									bvalid;
//    	logic									bready;
    	//logic [    `AXI_ADDR_WIDTH-1 : 0]		araddr;
//    	logic [                         2 : 0]	arprot;
//    	logic									arvalid;
//    	logic									arready;
    	//logic[    `AXI_DATA_WIDTH-1 : 0]			rdata;
//    	logic[                         1 : 0]	rresp;
//    	logic									rvalid;
//    	logic									rready;


		`uvm_object_utils_begin(axi_spi_seq_item)
			`uvm_field_int(spi_m_tx_data, UVM_ALL_ON)
			`uvm_field_int(spi_m_rx_data, UVM_ALL_ON)
			`uvm_field_int(spi_s_tx_data, UVM_ALL_ON)
			`uvm_field_int(spi_s_rx_data, UVM_ALL_ON)
		//	`uvm_field_int(spi_s_done, UVM_ALL_ON)
		//	`uvm_field_int(spi_s_busy, UVM_ALL_ON)
		//	`uvm_field_int(awaddr, UVM_ALL_ON)
		//	`uvm_field_int(wdata, UVM_ALL_ON)
		//	`uvm_field_int(araddr, UVM_ALL_ON)
		//	`uvm_field_int(rdata, UVM_ALL_ON)
	/*
			`uvm_field_int(sclk, UVM_ALL_ON)
			`uvm_field_int(mosi, UVM_ALL_ON)
			`uvm_field_int(miso, UVM_ALL_ON)
			`uvm_field_int(cs_n, UVM_ALL_ON)
			// Ports of Axi
			`uvm_field_int(awaddr, UVM_ALL_ON)
			`uvm_field_int(awprot, UVM_ALL_ON)
			`uvm_field_int(awvalid, UVM_ALL_ON)
			`uvm_field_int(awready, UVM_ALL_ON)
			`uvm_field_int(wdata, UVM_ALL_ON)
			`uvm_field_int(wstrb, UVM_ALL_ON)
			`uvm_field_int(wvalid, UVM_ALL_ON)
			`uvm_field_int(wready, UVM_ALL_ON)
			`uvm_field_int(bresp, UVM_ALL_ON)
			`uvm_field_int(bvalid, UVM_ALL_ON)
			`uvm_field_int(bready, UVM_ALL_ON)
			`uvm_field_int(araddr, UVM_ALL_ON)
			`uvm_field_int(arprot, UVM_ALL_ON)
			`uvm_field_int(arvalid, UVM_ALL_ON)
			`uvm_field_int(arready, UVM_ALL_ON)
			`uvm_field_int(rdata, UVM_ALL_ON)
			`uvm_field_int(rresp, UVM_ALL_ON)
			`uvm_field_int(rvalid, UVM_ALL_ON)
			`uvm_field_int(rready, UVM_ALL_ON)
	*/
		`uvm_object_utils_end
		
	
	
		constraint c_spi_tx_data {
			spi_m_tx_data inside {[8'h00:8'hff]};
			spi_s_tx_data inside {[8'h00:8'hff]};
		}


		function new(string name = "seq_item");
			super.new(name);
		endfunction

		function string convert2string();
			return $sformatf("spi_m_tx_data=0x%02h, spi_s_tx_data=0x%02h", spi_m_tx_data, spi_s_tx_data);
		endfunction

endclass




class axi_spi_seq extends uvm_sequence #(axi_spi_seq_item);
	`uvm_object_utils(axi_spi_seq)
	int num_trans = 10;

	function new(string name = "axi_spi_seq");
		super.new(name);
	endfunction

	task body();
		axi_spi_seq_item item;
		repeat(num_trans) begin
			item = axi_spi_seq_item::type_id::create("item");
			start_item(item);
			if (!item.randomize()) begin
				`uvm_fatal(get_type_name(), "randomization failed")
			end
			`uvm_info(get_type_name(), $sformatf("seq send : %s", item.convert2string()), UVM_MEDIUM)
			finish_item(item);
		end
	endtask
endclass



class axi_spi_driver extends uvm_driver #(axi_spi_seq_item);
	`uvm_component_utils(axi_spi_driver)
	virtual axi_spi_if v_if;
	logic [31:0] ctrl_reg;
	logic [31:0] axi_rdata;
	event spi_start_ev, spi_done_ev;

	function new(string name = "axi_spi_drv", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual axi_spi_if)::get(this, "", "v_if", v_if)) begin
			`uvm_fatal(get_type_name(), "cannot access to interface")	
		end
		// cpol=0, cpha=0, clk_div=4
		ctrl_reg = {16'h0, 8'h04, 6'h0, 1'b0, 1'b0};
	endfunction

	virtual task run_phase(uvm_phase phase);
		// drive item to interface
		axi_spi_seq_item item;
		wait(v_if.rstn==1);	// necessary?

		v_if.wstrb = 4'hf;

		forever begin
			seq_item_port.get_next_item(item);

			wait(!v_if.drv_cb.spi_s_busy);
			// INIT
			axi_write(4'h0, ctrl_reg);
			// SPI Slave
			v_if.spi_s_tx_data = item.spi_s_tx_data;
			// SPI Master spi_start=1, tx_data
			axi_write(4'h4, {1'b1, 23'h0, item.spi_m_tx_data});
			read_if();
			// wait until SPI Master busy 1
			axi_read(4'h8, axi_rdata);
			read_if();
			
			// spi_start=0
			axi_write(4'h4, {1'b0, 23'h0, item.spi_m_tx_data});

			->spi_start_ev;
		
			@(spi_done_ev);
			seq_item_port.item_done();
		end
	endtask

	task read_if();
		`uvm_info(get_type_name(), $sformatf("[Interface] SPI_Slave : tx:0x%0h, rx:0x%0h, done:%0b, busy:%0b", v_if.spi_s_tx_data, v_if.spi_s_rx_data, v_if.spi_s_done, v_if.spi_s_busy), UVM_DEBUG);
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
		`uvm_info(get_type_name(), $sformatf("%saxi_rdata=%0h%s", `CLR_RED, rdata, `CLR_RESET), UVM_DEBUG)
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
		//wait(v_if.wvalid==1);
		v_if.drv_cb.bready <= 1;
		wait(v_if.drv_cb.bvalid==1);
		`uvm_info("axi_b", "tttttttttttttttstart", UVM_DEBUG)
		//@(v_if.drv_cb);
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
		//wait(v_if.arvalid==1);
		v_if.drv_cb.rready <= 1;
		wait(v_if.drv_cb.rvalid==1);
		v_if.drv_cb.rready <= 0;
		@(v_if.drv_cb);
		data = v_if.drv_cb.rdata;
		`uvm_info("axi_r", "end", UVM_DEBUG)
	endtask
endclass


class axi_spi_monitor extends uvm_monitor;
	`uvm_component_utils(axi_spi_monitor)
	virtual axi_spi_if v_if;
	uvm_analysis_port #(axi_spi_seq_item) ap;

	logic [31:0] axi_rdata;
	event spi_start_ev, spi_done_ev;

	function new(string name = "axi_spi_mon", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual axi_spi_if)::get(this, "", "v_if", v_if)) begin
			`uvm_fatal(get_type_name(), "cannot access to interface")
		end
		ap = new("ap", this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			axi_spi_seq_item item = axi_spi_seq_item::type_id::create("item", this);


			`uvm_info(get_type_name(), $sformatf("monitor wating spi_start_ev"), UVM_HIGH)
			@(spi_start_ev);

			read_if();

			// wait until SPI Master busy 0
			`uvm_info(get_type_name(), $sformatf("monitor got spi_start_ev"), UVM_HIGH)
			axi_read(4'h8, axi_rdata);
			while (axi_rdata[9]==1) begin
				read_if();
				axi_read(4'h8, axi_rdata);
				@(v_if.mon_cb);
			end

			read_if();

			item.spi_s_tx_data = v_if.spi_s_tx_data;
			item.spi_s_rx_data = v_if.spi_s_rx_data;

			axi_read(4'h4, axi_rdata);
			item.spi_m_tx_data = axi_rdata[7:0];
			@(v_if.mon_cb);
			axi_read(4'h8, axi_rdata);
			item.spi_m_rx_data = axi_rdata[7:0];

			`uvm_info(get_type_name(), $sformatf("monitor read : %s", item.convert2string()), UVM_HIGH)

			// wait done
			// monitor signals
			
			// printf
			ap.write(item);
			->spi_done_ev;
		end
	endtask


	task read_if();
		`uvm_info(get_type_name(), $sformatf("[Interface] SPI_Slave : tx:0x%0h, rx:0x%0h, done:%0b, busy:%0b", v_if.spi_s_tx_data, v_if.spi_s_rx_data, v_if.spi_s_done, v_if.spi_s_busy), UVM_DEBUG)
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

class axi_spi_agent extends uvm_agent;
	`uvm_component_utils(axi_spi_agent)

	axi_spi_driver drv;
	axi_spi_monitor mon;
	uvm_sequencer #(axi_spi_seq_item) sqr;
	event spi_start_ev, spi_done_ev;

	function new(string name = "axi_spi_agent", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv = axi_spi_driver::type_id::create("drv", this);
		mon = axi_spi_monitor::type_id::create("mon", this);
		sqr = uvm_sequencer#(axi_spi_seq_item)::type_id::create("sqr", this);

		drv.spi_start_ev = spi_start_ev;
		drv.spi_done_ev = spi_done_ev;
		mon.spi_start_ev = spi_start_ev;
		mon.spi_done_ev = spi_done_ev;
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
endclass

class axi_spi_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(axi_spi_scoreboard)
	uvm_analysis_imp #(axi_spi_seq_item, axi_spi_scoreboard) ap_imp;
	int pass_cnt = 0;
	int fail_cnt = 0;

	function new(string name = "spi_axi_scb", uvm_component parent);
		super.new(name, parent);
		ap_imp = new("ap_imp", this);
	endfunction

	function void write(axi_spi_seq_item item);
		if ((item.spi_m_tx_data == item.spi_s_rx_data) && (item.spi_m_rx_data == item.spi_s_tx_data)) begin
			`uvm_info(get_type_name(), $sformatf("%s[PASS]%s M->S : 0x%0h, S->M : 0x%0h", `CLR_GRN, `CLR_RESET, item.spi_m_tx_data, item.spi_s_tx_data), UVM_MEDIUM)
			pass_cnt++;
		end else begin
			`uvm_error(get_type_name(), $sformatf("%s[FAIL]%s M->S : 0x%0h -> 0x%0h, S->M : 0x%0h -> 0x%0h", `CLR_RED, `CLR_RESET, item.spi_m_tx_data, item.spi_s_rx_data, item.spi_s_tx_data, item.spi_m_rx_data))
			fail_cnt++;
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



class axi_spi_coverage extends uvm_subscriber#(axi_spi_seq_item);
	`uvm_component_utils(axi_spi_coverage)

	logic [7:0] cov_tx_data_m, cov_tx_data_s;

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
     endgroup

	 function new(string name = "axi_spi_cov", uvm_component parent);
		super.new(name, parent);
		cg_data = new();
	 endfunction

	 function void write(axi_spi_seq_item item);
		cov_tx_data_m = item.spi_m_tx_data;
		cov_tx_data_s = item.spi_s_tx_data;
		cg_data.sample();
	 endfunction

     function void report_phase(uvm_phase phase);
         `uvm_info(get_type_name(), "\n\n ===== Coverage Report ===== ", UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("coverage cg_data=%.1f%%", cg_data.get_coverage()), UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("coverage spi_m_tx_data=%.1f%%", cg_data.cp_tx_data_m.get_coverage()), UVM_LOW)
         `uvm_info(get_type_name(), $sformatf("coverage spi_s_tx_data=%.1f%%", cg_data.cp_tx_data_s.get_coverage()), UVM_LOW)
         `uvm_info(get_type_name(), " ===== Coverage Report ===== \n\n", UVM_LOW)
     endfunction

endclass

class axi_spi_env extends uvm_env;
	`uvm_component_utils(axi_spi_env)

	axi_spi_agent agt;
	axi_spi_scoreboard scb;
	axi_spi_coverage cov;

	function new(string name = "axi_spi_env", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agt = axi_spi_agent::type_id::create("agt", this);
		scb = axi_spi_scoreboard::type_id::create("scb", this);
		cov = axi_spi_coverage::type_id::create("cov", this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agt.mon.ap.connect(scb.ap_imp);
		agt.mon.ap.connect(cov.analysis_export);
	endfunction
endclass


class axi_spi_test extends uvm_test;
	`uvm_component_utils(axi_spi_test)

	axi_spi_env env;

	function new(string name = "axi_spi_env", uvm_component parent);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = axi_spi_env::type_id::create("env", this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		axi_spi_seq seq;
		phase.raise_objection(this);
		seq = axi_spi_seq::type_id::create("seq", this);
		seq.num_trans = 1000;
		seq.start(env.agt.sqr);
		phase.drop_objection(this);
	endtask
endclass



module tb_axi_spi_uvm();

	logic clk, rstn;
	wire sclk, mosi, miso, cs_n;

	axi_spi_if v_if(clk, rstn);


	SPI_Master_v1_0 #(
		.C_S00_AXI_DATA_WIDTH(`AXI_DATA_WIDTH),
		.C_S00_AXI_ADDR_WIDTH(`AXI_ADDR_WIDTH)
	) dut_m (
    
		// Users to add ports here
    	.sclk(sclk),
    	.mosi(mosi),
    	.miso(miso),
    	.cs_n(cs_n),
    	// User ports ends

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



	spi_slave dut_s (
	    .clk(clk),
	    .reset(~rstn),
	    .sclk(sclk),
	    .cs_n(cs_n),
	    .mosi(mosi),
	    .miso(miso),
	    .tx_data(v_if.spi_s_tx_data),
	    .rx_data(v_if.spi_s_rx_data),
	    .done(v_if.spi_s_done),
	    .busy(v_if.spi_s_busy)
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
		uvm_config_db#(virtual axi_spi_if)::set(null, "*", "v_if", v_if);
		run_test("axi_spi_test");

		#100;
		$finish;
	end

	initial begin
		$fsdbDumpfile("novas.fsdb");
		$fsdbDumpfile(0, tb_axi_spi_uvm, "+all");
	end

endmodule
