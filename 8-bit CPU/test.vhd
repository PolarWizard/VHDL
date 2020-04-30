library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity test is
	port(start, clk, clk3: in std_logic;
		  alu_opcode, write_enable, mux0_sel, pc_inc: out std_logic;
		  regist3r: out std_logic_vector(2 downto 0);
		  disp0, disp1, disp2: out std_logic_vector(6 downto 0);
		  alu_ans, data_in_register, instruction: out std_logic_vector(7 downto 0));
end test;

architecture structural of test is

signal clk2: std_logic;
signal output_pc: std_logic_vector(3 downto 0);
signal output_iMem: std_logic_vector(7 downto 0);
signal out_op: std_logic_vector(1 downto 0);
signal out_r0, out_r1: std_logic_vector(2 downto 0);
signal out_extend: std_logic_vector(7 downto 0);
signal out_mux0: std_logic_vector(7 downto 0);
signal out_data0, out_data1: std_logic_vector(7 downto 0);
signal out_ex0, out_ex1: std_logic_vector(7 downto 0);
signal out_alu: std_logic_vector(7 downto 0);
signal enable1, enable2, enable3, enable4: std_logic;

begin
	clock: entity work.Clock_Divider port map(clk => clk,
															clock_out => clk2);
															
	disp: entity work.display port map(first => out_data0,
												  clk => clk,
												  seg0 => disp0, 
												  seg1 => disp1,
												  seg2 => disp2);
												  
	cu: entity work.control_unit port map(clk => clk,
													  start => start,
													  opcode => output_iMem(7)&output_iMem(6),
													  write_data => enable1,
													  alu_op => enable2,
													  mux0_sel => enable3,
													  pc_inc => enable4);

	pc1: entity work.pc port map(clk => clk,
										  pc_plusplus => enable4,
										  pc_output => output_pc);
										  
	iMem: entity work.instruction_mem port map(address => output_pc,
															 instruction => output_iMem);
												 
	sign_extender: entity work.sign_extend port map(immediate_3 => output_iMem(2)&output_iMem(1)&output_iMem(0),
																   immediate_8 => out_extend);
												 
	mux0: entity work.mux port map(a => out_extend,
											 b => out_alu,
											 sel => enable3,
											 output => out_mux0);	 									 
												 
	regs: entity work.registers port map(clk => clk3,
													 wData_enable => enable1,
													 r0 => output_iMem(5)&output_iMem(4)&output_iMem(3),
													 r1 => output_iMem(2)&output_iMem(1)&output_iMem(0),
													 write_r0 => output_iMem(5)&output_iMem(4)&output_iMem(3),
													 write_data => out_mux0,
													 read_r0 => out_data0,
													 read_r1 => out_data1);
													 
	alu1: entity work.alu port map(opcode => enable2,
											 r0 => out_data0,
											 r1 => out_data1,
											 output => out_alu);
	instruction <= output_iMem;											 
	data_in_register <= out_data0;								 
	regist3r <= output_iMem(5)&output_iMem(4)&output_iMem(3);
	alu_ans <= out_mux0;
	alu_opcode <= enable2;
	write_enable <= enable1;
	mux0_sel <= enable3;
	pc_inc <= enable4;
end structural;