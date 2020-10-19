library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO is

	generic(
		dataWidth: integer := 8
		);	
		
	port(
		clk: in std_logic;
		w_enable: in std_logic;
		r_enable: in std_logic;
		dataIn: in std_logic_vector(dataWidth - 1 downto 0);
		dataOut: out std_logic_vector(dataWidth - 1 downto 0);
		FlagBanner: out std_logic_vector(3 downto 0) --F=3, AF=2, AE=1, E=0
		);
		
end FIFO;

architecture behavior of FIFO is

type FIFO_structure is array (0 to 7) of std_logic_vector(dataWidth-1 downto 0);
signal i_FIFO: FIFO_structure := (others => (others => '0'));  

signal locations_used: integer := 0;  --FIFO has depth = 8, if < 8 then the FIFO is not full;
signal w_location_ptr: integer := 0;  --points to the location that we will write to
signal r_location_ptr: integer := 0;  --points to the location that we will read from
signal F_flag: std_logic;
signal AF_flag: std_logic;
signal AE_flag: std_logic;
signal E_flag: std_logic;

begin
	process (clk)
	begin
		if rising_edge(clk) then
			--Can we write to FIFO
			if (w_enable = '1' and r_enable = '0') then
				--check if locations used is less than depth
				if (locations_used < 8) then
					--check if full
					if(F_flag = '0') then
						i_FIFO(w_location_ptr) <= dataIn; --write data to location
						locations_used <= locations_used + 1;
						w_location_ptr <= w_location_ptr + 1;
					end if;
					--control ptr overflow
					if (w_location_ptr = 8) then
						w_location_ptr <= 0;
					end if;
				end if;
				
			--Can we read from FIFO
			elsif (w_enable = '0' and r_enable = '1') then
				--check if locations used is greater than 0
				if(locations_used > 0) then
					--check if empty
					if (E_flag = '0') then
						dataOut <= i_FIFO(r_location_ptr); --read data from location
						locations_used <= locations_used - 1;
						r_location_ptr <= r_location_ptr + 1;
					end if;
					--control ptr overflow
					if (r_location_ptr = 8) then
						r_location_ptr <= 0;
					end if;
				end if;
			end if;	
			
		end if;
	end process;
	
	F_flag <= '1' when locations_used = 8 else '0';
	AF_flag <= '1' when locations_used = 7 else '0';
	AE_flag <= '1' when locations_used = 1 else '0';
	E_flag <= '1' when locations_used = 0 else '0';
	
	FlagBanner(3) <= F_flag;
	FlagBanner(2) <= AF_flag;
	FlagBanner(1) <= AE_flag;
	FlagBanner(0) <= E_flag;
	
end behavior;
