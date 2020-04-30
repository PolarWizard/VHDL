library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registers is
	port(clk, wData_enable: std_logic;
        r0, r1, write_r0: in std_logic_vector(2 downto 0);
		  write_data: in std_logic_vector(7 downto 0);
		  read_r0, read_r1: out std_logic_vector(7 downto 0));
end registers;

architecture behavior of registers is

type register_array is array (0 to 3) of std_logic_vector(0 to 7);
signal which_register: register_array;

begin
	process (clk, r0, r1, write_r0, wData_enable, write_data)
	begin
		if rising_edge(clk) then
			if wData_enable = '1' then
				which_register(to_integer(unsigned(write_r0))) <= write_data;
			end if;
		end if;
	end process;
	read_r0 <= which_register(to_integer(unsigned(r0)));
	read_r1 <= which_register(to_integer(unsigned(r1)));
end behavior;