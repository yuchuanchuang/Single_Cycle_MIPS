// this is a test bench feeds initial instruction and data
// the processor output is not verified

`timescale 1 ns/10 ps

`define CYCLE 5 // You can modify your clock frequency

`define DMEM_INIT "D_mem"
`define SDFFILE   "./CHIP_syn.sdf"	// Modify your SDF file name

// For different condition (I_mem, TestBed)
`ifdef noHazard
    `define IMEM_INIT "I_mem_noHazard"
    `include "./TestBed_noHazard.v"
`endif
`ifdef hasHazard
	`define IMEM_INIT "I_mem_hasHazard"
	`include "./TestBed_hasHazard.v"
`endif	
`ifdef BrPred
	`define IMEM_INIT "I_mem_BrPred"
	`include "./TestBed_BrPred.v"
`endif
`ifdef L2Cache
	`define IMEM_INIT "I_mem_L2Cache"
	`include "./TestBed_L2Cache.v"
`endif
`ifdef L2Cache_10
	`define IMEM_INIT "I_mem_L2Cache_10"
	`include "./TestBed_L2Cache_10.v"
`endif
`ifdef L2Cache_15
	`define IMEM_INIT "I_mem_L2Cache_15"
	`include "./TestBed_L2Cache_15.v"
`endif
`ifdef L2Cache_20
	`define IMEM_INIT "I_mem_L2Cache_20"
	`include "./TestBed_L2Cache_20.v"
`endif
`ifdef L2Cache_25
	`define IMEM_INIT "I_mem_L2Cache_25"
	`include "./TestBed_L2Cache_25.v"
`endif
`ifdef L2Cache_30
	`define IMEM_INIT "I_mem_L2Cache_30"
	`include "./TestBed_L2Cache_30.v"
`endif
`ifdef L2Cache_35
	`define IMEM_INIT "I_mem_L2Cache_35"
	`include "./TestBed_L2Cache_35.v"
`endif
`ifdef L2Cache_40
	`define IMEM_INIT "I_mem_L2Cache_40"
	`include "./TestBed_L2Cache_40.v"
`endif
`ifdef L2Cache_45
	`define IMEM_INIT "I_mem_L2Cache_45"
	`include "./TestBed_L2Cache_45.v"
`endif
`ifdef L2Cache_50
	`define IMEM_INIT "I_mem_L2Cache_50"
	`include "./TestBed_L2Cache_50.v"
`endif
`ifdef L2Cache_55
	`define IMEM_INIT "I_mem_L2Cache_55"
	`include "./TestBed_L2Cache_55.v"
`endif
`ifdef L2Cache_60
	`define IMEM_INIT "I_mem_L2Cache_60"
	`include "./TestBed_L2Cache_60.v"
`endif
`ifdef L2Cache_65
	`define IMEM_INIT "I_mem_L2Cache_65"
	`include "./TestBed_L2Cache_65.v"
`endif
`ifdef L2Cache_70
	`define IMEM_INIT "I_mem_L2Cache_70"
	`include "./TestBed_L2Cache_70.v"
`endif
`ifdef L2Cache_75
	`define IMEM_INIT "I_mem_L2Cache_75"
	`include "./TestBed_L2Cache_75.v"
`endif
`ifdef L2Cache_80
	`define IMEM_INIT "I_mem_L2Cache_80"
	`include "./TestBed_L2Cache_80.v"
`endif
`ifdef L2Cache_85
	`define IMEM_INIT "I_mem_L2Cache_85"
	`include "./TestBed_L2Cache_85.v"
`endif
`ifdef L2Cache_90
	`define IMEM_INIT "I_mem_L2Cache_90"
	`include "./TestBed_L2Cache_90.v"
`endif
`ifdef L2Cache_100
	`define IMEM_INIT "I_mem_L2Cache_110"
	`include "./TestBed_L2Cache_110.v"
`endif
`ifdef L2Cache_150
	`define IMEM_INIT "I_mem_L2Cache_130"
	`include "./TestBed_L2Cache_130.v"
`endif
`ifdef L2Cache_150
	`define IMEM_INIT "I_mem_L2Cache_150"
	`include "./TestBed_L2Cache_150.v"
`endif
`ifdef L2Cache_150
	`define IMEM_INIT "I_mem_L2Cache_150"
	`include "./TestBed_L2Cache_150.v"
`endif
`ifdef L2Cache_150
	`define IMEM_INIT "I_mem_L2Cache_170"
	`include "./TestBed_L2Cache_170.v"
`endif
`ifdef L2Cache_200
	`define IMEM_INIT "I_mem_L2Cache_190"
	`include "./TestBed_L2Cache_190.v"
`endif
`ifdef L2Cache_p1p2p3
	`define IMEM_INIT "I_mem_L2Cache_p1p2p3"
	`include "./TestBed_L2Cache_p1p2p3.v"
`endif
`ifdef Assembly
	`define IMEM_INIT "I_mem_Assembly"
	`include "./TestBed_Assembly.v"
`endif
`ifdef MultDiv
	`define IMEM_INIT "I_mem_MultDiv"
	// `include "./TestBed_MultDiv.v"
`endif			

module Final_tb;

	reg clk;
	reg [31:0]  clk_counter=0;
	reg rst_n;
	
	wire mem_read_D;
	wire mem_write_D;
	wire [31:4] mem_addr_D;
	wire [127:0] mem_wdata_D;
	wire [127:0] mem_rdata_D;
	wire mem_ready_D;

	wire mem_read_I;
	wire mem_write_I;
	wire [31:4] mem_addr_I;
	wire [127:0] mem_wdata_I;
	wire [127:0] mem_rdata_I;
	wire mem_ready_I;
	
	wire [29:0]	DCACHE_addr;
	wire [31:0]	DCACHE_wdata;
	wire 		DCACHE_wen;
	
	wire [7:0] error_num;
	wire [15:0] duration;
	wire finish;	



	//************counter****************//
	wire [31:0] cont_w_D_l1;
	wire [31:0] cont_r_D_l1;
	wire [31:0] cont_miss_w_D_l1;
	wire [31:0] cont_miss_r_D_l1;
	wire [31:0] cont_wb_w_D_l1;
	wire [31:0] cont_wb_r_D_l1;

	wire [31:0] cont_w_I_l1;
	wire [31:0] cont_r_I_l1;
	wire [31:0] cont_miss_w_I_l1;
	wire [31:0] cont_miss_r_I_l1;
	wire [31:0] cont_wb_w_I_l1;
	wire [31:0] cont_wb_r_I_l1;

	wire [31:0] cont_w_D_l2;
	wire [31:0] cont_r_D_l2;
	wire [31:0] cont_miss_w_D_l2;
	wire [31:0] cont_miss_r_D_l2;
	wire [31:0] cont_wb_w_D_l2;
	wire [31:0] cont_wb_r_D_l2;

	wire [31:0] cont_w_I_l2;
	wire [31:0] cont_r_I_l2;
	wire [31:0] cont_miss_w_I_l2;
	wire [31:0] cont_miss_r_I_l2;
	wire [31:0] cont_wb_w_I_l2;
	wire [31:0] cont_wb_r_I_l2;
	// Note the design is connected at testbench, include:
	// 1. CHIP (MIPS + D_cache + I_chache)
	// 2. slow memory for data
	// 3. slow memory for instruction
	
	CHIP chip0 (clk,
				rst_n,
//----------for slow_memD------------	
				mem_read_D,
				mem_write_D,
				mem_addr_D,
				mem_wdata_D,
				mem_rdata_D,
				mem_ready_D,
//----------for slow_memI------------
				mem_read_I,
				mem_write_I,
				mem_addr_I,
				mem_wdata_I,
				mem_rdata_I,
				mem_ready_I,
//----------for TestBed--------------				
				DCACHE_addr,
				DCACHE_wdata,
				DCACHE_wen,
				
				cont_w_D_l1,
				cont_r_D_l1,
				cont_miss_w_D_l1,
				cont_miss_r_D_l1,
				cont_wb_w_D_l1,
				cont_wb_r_D_l1,

				cont_w_I_l1,
				cont_r_I_l1,
				cont_miss_w_I_l1,
				cont_miss_r_I_l1,
				cont_wb_w_I_l1,
				cont_wb_r_I_l1,

				cont_w_D_l2,
				cont_r_D_l2,
				cont_miss_w_D_l2,
				cont_miss_r_D_l2,
				cont_wb_w_D_l2,
				cont_wb_r_D_l2,

				cont_w_I_l2,
				cont_r_I_l2,
				cont_miss_w_I_l2,
				cont_miss_r_I_l2,
				cont_wb_w_I_l2,
				cont_wb_r_I_l2
				);
	
	slow_memory slow_memD(
		clk,
		mem_read_D,
		mem_write_D,
		mem_addr_D,
		mem_wdata_D,
		mem_rdata_D,
		mem_ready_D
	);

	slow_memory slow_memI(
		clk,
		mem_read_I,
		mem_write_I,
		mem_addr_I,
		mem_wdata_I,
		mem_rdata_I,
		mem_ready_I
	);

	TestBed testbed(
		clk,
		rst_n,
		DCACHE_addr,
		DCACHE_wdata,
		DCACHE_wen,
		error_num,
		duration,
		finish,
		cont_w_D_l1,
		cont_r_D_l1,
		cont_miss_w_D_l1,
		cont_miss_r_D_l1,
		cont_wb_w_D_l1,
		cont_wb_r_D_l1,

		cont_w_I_l1,
		cont_r_I_l1,
		cont_miss_w_I_l1,
		cont_miss_r_I_l1,
		cont_wb_w_I_l1,
		cont_wb_r_I_l1,

		cont_w_D_l2,
		cont_r_D_l2,
		cont_miss_w_D_l2,
		cont_miss_r_D_l2,
		cont_wb_w_D_l2,
		cont_wb_r_D_l2,

		cont_w_I_l2,
		cont_r_I_l2,
		cont_miss_w_I_l2,
		cont_miss_r_I_l2,
		cont_wb_w_I_l2,
		cont_wb_r_I_l2
	);
	
`ifdef SDF
    initial $sdf_annotate(`SDFFILE, chip0);
`endif
	
// Initialize the data memory
	initial begin
		$display("-----------------------------------------------------\n");
	 	$display("START!!! Simulation Start .....\n");
	 	$display("-----------------------------------------------------\n");
		$readmemb (`DMEM_INIT, slow_memD.mem ); // initialize data in DMEM
		$readmemb (`IMEM_INIT, slow_memI.mem ); // initialize data in IMEM

		// waveform dump
	    $dumpfile("Final.vcd");
	    $dumpvars;
	    //$fsdbDumpfile("Final.fsdb");			
		//$fsdbDumpvars(0,Final_tb,"+mda");
	
		clk = 0;
		rst_n = 1'b1;
		#2 rst_n = 1'b0;
		#(`CYCLE*8.5) rst_n = 1'b1;
     
		#(`CYCLE*1000000)	 $finish; // calculate clock cycles for all operation
		$display("-----------------------------------------------------\n");
		$display("Error!!! There is something wrong with your code ...!\n");
	 	$display("------The test result is .....FAIL ------------------\n");
	 	$display("-----------------------------------------------------\n");
	 	$finish;
	end
		
	always #(`CYCLE*0.5) clk = ~clk;
	always @(posedge clk) begin
		clk_counter = clk_counter + 1;
		//$display("clk_counter: ", clk_counter);
	end
	always@(finish)
	    if(finish) begin
	    	$display("Counter of L1 DCache write op:", cont_w_D_l1);
			$display("Counter of L1 DCache read op:", cont_r_D_l1);
			$display("Counter of L1 DCache write miss:", cont_miss_w_D_l1);
			$display("Counter of L1 DCache read miss:", cont_miss_r_D_l1);
			$display("Counter of L1 DCache write write back:", cont_wb_w_D_l1);
			$display("Counter of L1 DCache read write back:", cont_wb_r_D_l1);

			$display("Counter of L1 ICache write op:", cont_w_I_l1);
			$display("Counter of L1 ICache read op:", cont_r_I_l1);
			$display("Counter of L1 ICache write miss:", cont_miss_w_I_l1);
			$display("Counter of L1 ICache read miss:", cont_miss_r_I_l1);
			$display("Counter of L1 ICache write write back:", cont_wb_w_I_l1);
			$display("Counter of L1 ICache read write back:", cont_wb_r_I_l1);

			$display("Counter of L2 DCache write op:", cont_w_D_l2);
			$display("Counter of L2 DCache read op:", cont_r_D_l2);
			$display("Counter of L2 DCache write miss:", cont_miss_w_D_l2);
			$display("Counter of L2 DCache read miss:", cont_miss_r_D_l2);
			$display("Counter of L2 DCache write write back:", cont_wb_w_D_l2);
			$display("Counter of L2 DCache read write back:", cont_wb_r_D_l2);

			$display("Counter of L2 ICache write op:", cont_w_I_l2);
			$display("Counter of L2 ICache read op:", cont_r_I_l2);
			$display("Counter of L2 ICache write miss:", cont_miss_w_I_l2);
			$display("Counter of L2 ICache read miss:", cont_miss_r_I_l2);
			$display("Counter of L2 ICache write write back:", cont_wb_w_I_l2);
			$display("Counter of L2 ICache read write back:", cont_wb_r_I_l2);
	       	#(`CYCLE) $finish;
	    end	   
	
endmodule
