library ieee;
use ieee.std_logic_1164.all;

entity control_unit is
	port(clk, start: in std_logic;
		  opcode: in std_logic_vector(1 downto 0);
		  write_data, alu_op, mux0_sel, pc_inc: out std_logic := '0');
end control_unit;

architecture behavior of control_unit is
	type statetype is (fetch, buff3r);
	signal state: statetype := fetch;
	signal next_state: statetype := fetch;
	signal a1, a2, a3, a4: std_logic;
begin
	process (clk, opcode)
	begin
		if rising_edge(clk) then
			if start = '0' then
				state <= fetch;
			else
				case state is
					when fetch =>
						write_data <= '0';
						alu_op <= '0';
						mux0_sel <= '0'; 
						pc_inc <= '0';
						if opcode = "00" then
							state <= buff3r;
							write_data <= '1';
							alu_op <= '0';
							mux0_sel <= '1'; 
							pc_inc <= '1';
						elsif opcode = "01" then
							state <= buff3r;
							write_data <= '1';
							alu_op <= '0';
							mux0_sel <= '0'; 
							pc_inc <= '1';
						elsif opcode = "10" then
							state <= buff3r;
							write_data <= '1';
							alu_op <= '1';
							mux0_sel <= '0'; 
							pc_inc <= '1';
						elsif opcode = "11" then
							state <= buff3r;
							write_data <= '0';
							alu_op <= '0';
							mux0_sel <= '0'; 
							pc_inc <= '0';
						end if;
					when buff3r =>
						state <= fetch;
						write_data <= '0';
						alu_op <= '0';
						mux0_sel <= '0'; 
						pc_inc <= '0';
				end case;
			end if;
		end if;
	end process;
end behavior;
		