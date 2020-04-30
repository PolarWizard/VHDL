library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity pc is
	port(clk, pc_plusplus: in std_logic;
		  pc_output: out std_logic_vector(3 downto 0));
end pc;

architecture behavior of pc is
signal count: std_logic_vector(3 downto 0);
begin
	process(clk, pc_plusplus)
	begin
		if rising_edge(clk) then
			if pc_plusplus = '1' then
				count <= count + 1;
			end if;
		end if;
	end process;
	
	pc_output <= count;
	
end behavior;
	