library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.package_components.all;

entity clk_tank is
	port (
		clk, rst		: in std_logic;
		speed			: in integer;
		tank_clk		: out std_logic
	);
end entity clk_tank;

architecture behavioral of clk_tank is

begin
	tank_clock: process(clk, rst) is
	
		variable counter : integer := 0;
	
	begin
	
		-- initialize counter
		counter := counter;
		
		-- if reset is active high, set counter and clk back to 0
		if (rst = '1') then
			counter := 0;
			tank_clk <= '0';
			
		-- otherwise, increment counter by 1 at every rising clock edge. 
		elsif (rising_edge(clk)) then
			counter := counter + 1;
			-- affects speed of the tanks
			-- speed of 1, 2, 3
			if ((counter >= (100000 / speed)) and (counter < (400000 / speed))) then
				tank_clk <= '1';
			elsif (counter >= (400000 / speed)) then
				counter := 0;
				tank_clk <= '0';
			end if;
		end if;
	end process tank_clock;
end architecture behavioral;