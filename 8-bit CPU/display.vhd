library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display is
	port(clk: std_logic;
		  first: in std_logic_vector(7 downto 0);
		  seg0, seg1, seg2: out std_logic_vector(6 downto 0));
end display;

architecture behavior of display is

signal unit2, ten2, hund2: std_logic_vector(3 downto 0);

begin
	process
	variable first0, unit10, ten10, hund10: integer;
	begin
		wait until(rising_edge(clk));
		first0 := to_integer(unsigned(first));
		unit10 := first0 mod 10;
		first0 := first0 / 10;
		ten10 := first0 mod 10;
		first0 := first0 / 10;
		hund10 := first0 mod 10;
		unit2 <= std_logic_vector(to_unsigned(unit10, unit2'length));
		ten2 <= std_logic_vector(to_unsigned(ten10, ten2'length));
		hund2 <= std_logic_vector(to_unsigned(hund10, hund2'length));
		case unit2 is
			when "0000" => seg0 <= "1000000";
			when "0001" => seg0 <= "1111001";
			when "0010" => seg0 <= "0100100";
			when "0011" => seg0 <= "0110000";
			when "0100" => seg0 <= "0011001";
			when "0101" => seg0 <= "0010010";
			when "0110" => seg0 <= "0000010";
			when "0111" => seg0 <= "1111000";
			when "1000" => seg0 <= "0000000";
			when "1001" => seg0 <= "0011000";
			when others => seg0 <= "1111111";
		end case;
		
		case ten2 is
			when "0000" => seg1 <= "1000000";
			when "0001" => seg1 <= "1111001";
			when "0010" => seg1 <= "0100100";
			when "0011" => seg1 <= "0110000";
			when "0100" => seg1 <= "0011001";
			when "0101" => seg1 <= "0010010";
			when "0110" => seg1 <= "0000010";
			when "0111" => seg1 <= "1111000";
			when "1000" => seg1 <= "0000000";
			when "1001" => seg1 <= "0011000";
			when others => seg1 <= "1111111";
		end case;
		
		case hund2 is
			when "0000" => seg2 <= "1000000";
			when "0001" => seg2 <= "1111001";
			when "0010" => seg2 <= "0100100";
			when "0011" => seg2 <= "0110000";
			when "0100" => seg2 <= "0011001";
			when "0101" => seg2 <= "0010010";
			when "0110" => seg2 <= "0000010";
			when "0111" => seg2 <= "1111000";
			when "1000" => seg2 <= "0000000";
			when "1001" => seg2 <= "0011000";
			when others => seg2 <= "1111111";
		end case;
	end process;
end;