library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
	port(opcode: in std_logic;
		  r0, r1: in std_logic_vector(7 downto 0);
	     output: out std_logic_vector(7 downto 0));
end alu;

architecture behavior of alu is

begin
	process (opcode, r0, r1)
	begin
		case opcode is
			when '0' =>
				if to_integer(unsigned(r0)) + to_integer(unsigned(r1)) > 255 then
					output <= "11111111";
				else 
					output <= std_logic_vector(unsigned(r0) + unsigned(r1));
				end if;
			when '1' => 
				if to_integer(unsigned(r0)) - to_integer(unsigned(r1)) <= 0 then
					output <= "00000000";
				else 
					output <= std_logic_vector(unsigned(r0) - unsigned(r1));
				end if;
		end case;
	end process;
end behavior;
