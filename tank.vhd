library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity tank is
	port(
		clk, rst : in std_logic;
		move 		: out integer
	);
end entity tank;

architecture behavioral of tank is

begin
	-- takes in clock and reset for async
	tank_proc : process(clk, rst) is
		-- direction
		-- '1' tank goes right
		-- '-1' tank goes left
		variable direction, position : integer;
	
	begin
		-- initialize position
		position := position;
	
		-- if reset is active high, set position of the tanks to return to center of the x-axis
		if (rst = '1') then
			position := 270;
			direction := 1;
		
		-- because the VGA display has a resolution of 480 x 640, the width of the display is 640
		-- since the tanks have a size of 100 x 100, we have to take into account the boundaries of the display
		elsif (rising_edge(clk)) then
			if (position >= 540) then
				direction := -1;
			elsif(position <= 0) then
				direction := 1;
			end if;
		
		-- decides if tank moves right or left	
		position := position + direction;
	   
		end if;

		move <= position;
	
	end process tank_proc;
end architecture behavioral;