library ieee;
use ieee.std_logic_1164.all;

entity mux is
	port(a, b: in std_logic_vector(7 downto 0);
		  sel: in std_logic;
	     output: out std_logic_vector(7 downto 0));
end mux;

architecture behavior of mux  is

begin
	process (a, b, sel)
	begin 
		case sel is
			when '1' =>
				output <= a;
			when '0' =>
				output <= b;
		end case;
	end process;
end behavior;