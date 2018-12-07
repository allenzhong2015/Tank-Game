library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pixelGenerator is
	port(
			clk, ROM_clk, rst_n, video_on, eof 					: in std_logic;
			pixel_row, pixel_column						    		: in std_logic_vector(9 downto 0);
			tank_a_x, tank_b_x										: in integer;
			score_a, score_b											: in integer;
			bullet_a_y, bullet_b_y, bullet_a_x, bullet_b_x 	: in integer;
			red_out, green_out, blue_out							: out std_logic_vector(7 downto 0)
		);
end entity pixelGenerator;

architecture behavioral of pixelGenerator is

constant color_red 	 	 : std_logic_vector(2 downto 0) := "000";
constant color_green	 : std_logic_vector(2 downto 0) := "001";
constant color_blue 	 : std_logic_vector(2 downto 0) := "010";
constant color_yellow 	 : std_logic_vector(2 downto 0) := "011";
constant color_magenta 	 : std_logic_vector(2 downto 0) := "100";
constant color_cyan 	 : std_logic_vector(2 downto 0) := "101";
constant color_black 	 : std_logic_vector(2 downto 0) := "110";
constant color_white	 : std_logic_vector(2 downto 0) := "111";

component colorROM is
	port
	(
		address		: in std_logic_vector (2 downto 0);
		clock		: in std_logic  := '1';
		q			: out std_logic_vector (29 downto 0)
	);
end component colorROM;


signal tanka_offset : integer := 100;
signal tankb_offset : integer := 380;
signal bullet_offset : integer := 5;

signal colorAddress : std_logic_vector (2 downto 0);
signal color        : std_logic_vector (29 downto 0);

signal pixel_row_int, pixel_column_int : natural;

begin

--------------------------------------------------------------------------------------------
	
	red_out <= color(23 downto 16);
	green_out <= color(15 downto 8);
	blue_out <= color(7 downto 0);

	pixel_row_int <= to_integer(unsigned(pixel_row));
	pixel_column_int <= to_integer(unsigned(pixel_column));
	
--------------------------------------------------------------------------------------------	
	
	colors : colorROM
		port map(colorAddress, ROM_clk, color);
	
--------------------------------------------------------------------------------------------	
	pixelDraw : process(clk, rst_n) is
	
	begin
					
		if (rising_edge(clk)) then
			-- when winner isn't decided, allow tank and bullet movements
			if (score_a < 3 and score_b < 3) then
				-- tank color
				if (pixel_row_int < tanka_offset and pixel_column_int > (tank_a_x) and pixel_column_int < (tanka_offset + tank_a_x)) then
					colorAddress <= color_magenta;
				elsif (pixel_row_int > tankb_offset and pixel_column_int >(tank_b_x) and pixel_column_int < (tanka_offset + tank_b_x)) then
					colorAddress <= color_yellow;
				-- bullet color
				elsif (pixel_row_int < (bullet_a_y + bullet_offset) and pixel_row_int > (bullet_a_y - bullet_offset) and pixel_column_int > (bullet_a_x - bullet_offset) and pixel_column_int < (bullet_a_x + bullet_offset)) then
					colorAddress <= color_magenta;
				elsif (pixel_row_int < (bullet_b_y + bullet_offset) and pixel_row_int > (bullet_b_y - bullet_offset) and pixel_column_int > (bullet_b_x - bullet_offset) and pixel_column_int < (bullet_b_x + bullet_offset)) then
					colorAddress <= color_yellow;
				-- background color
				else
					colorAddress <= color_black;
				end if;
				
			-- when purple tank wins, allow only purple to show and background
			elsif (score_a >= 3) then 
				if (pixel_row_int < tanka_offset and pixel_column_int > (tank_a_x) and pixel_column_int < (tanka_offset + tank_a_x)) then
					colorAddress <= color_magenta;
				else 
					colorAddress <= color_black;
				end if;
				
			-- when white tank wins, allow only yellow to show and background
			elsif (score_b >= 3) then
				if (pixel_row_int > tankb_offset and pixel_column_int >(tank_b_x) and pixel_column_int < (tanka_offset + tank_b_x)) then
					colorAddress <= color_yellow;
				else
					colorAddress <= color_black;
				end if;
			end if;
		end if;
		
	end process pixelDraw;	

--------------------------------------------------------------------------------------------
	
end architecture behavioral;		