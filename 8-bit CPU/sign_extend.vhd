library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sign_extend is
	port(immediate_3: in std_logic_vector(2 downto 0);
		  immediate_8: out std_logic_vector(7 downto 0));
end sign_extend;

architecture behavior of sign_extend is
begin
	immediate_8 <= std_logic_vector(resize(unsigned(immediate_3), immediate_8'length));
end behavior;