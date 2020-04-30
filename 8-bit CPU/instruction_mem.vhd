
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity instruction_mem is
	port(address: in std_logic_vector(3 downto 0);
		  instruction: out std_logic_vector(7 downto 0));
end instruction_mem;

architecture behavior of instruction_mem is
	type rom_type is array (0 to 15) of std_logic_vector(7 downto 0);
   signal rom: rom_type := ("00000001",
									 "00001100",
									 "10000001",
									 "11000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000",
									 "00000000");
			 
   signal read_address: std_logic_vector(0 to 3);	  
begin
	process (address, rom, read_address)
	begin
		read_address <= address;
		instruction <= rom(conv_integer(read_address));
	end process;
end behavior;