library IEEE;
use IEEE.std_logic_1164.all;
use work.package_components.all;

entity VGA_top_level is
	port(
			CLOCK_50 										: in std_logic;
			RESET_N											: in std_logic;
			tank_a, tank_b									: in integer;
			score_a, score_b								: in integer;
			bullet_a_x, bullet_a_y, bullet_b_x, bullet_b_y	: in integer;
	
			--VGA 
			VGA_RED, VGA_GREEN, VGA_BLUE 					: out std_logic_vector(7 downto 0); 
			HORIZ_SYNC, VERT_SYNC, VGA_BLANK, VGA_CLK	: out std_logic

		);
end entity VGA_top_level;

architecture structural of VGA_top_level is

--Signals for VGA sync
signal pixel_row_int 										: std_logic_vector(9 downto 0);
signal pixel_column_int 									: std_logic_vector(9 downto 0);
signal video_on_int											: std_logic;
signal VGA_clk_int											: std_logic;
signal eof														: std_logic;
begin

--------------------------------------------------------------------------------------------		

		videoGen : pixelGenerator
		port map(CLOCK_50, VGA_clk_int, RESET_N, video_on_int, eof, pixel_row_int, pixel_column_int, tank_a, tank_b, score_a, score_b, bullet_a_y, bullet_b_y, bullet_a_x, bullet_b_x, VGA_RED, VGA_GREEN, VGA_BLUE);
		
--------------------------------------------------------------------------------------------
--This section should not be modified in your design.  This section handles the VGA timing signals
--and outputs the current row and column.  You will need to redesign the pixelGenerator to choose
--the color value to output based on the current position.

	videoSync : VGA_SYNC
		port map(CLOCK_50, HORIZ_SYNC, VERT_SYNC, video_on_int, VGA_clk_int, eof, pixel_row_int, pixel_column_int);

	VGA_BLANK <= video_on_int;

	VGA_CLK <= VGA_clk_int;

--------------------------------------------------------------------------------------------	

end architecture structural;