library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.package_components.all;

entity tank_game is
	port (
		-- clock and reset
		clk, rst													: in std_logic;
		-- PS2
		keyboard_clk, keyboard_data						: in std_logic;
		-- DE2LCD 
		LCD_RS, LCD_E, LCD_ON, RESET_LED, SEC_LED		: OUT	STD_LOGIC;
		LCD_RW													: BUFFER STD_LOGIC;
		DATA_BUS													: INOUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
		-- Score
		score_disp_a, score_disp_b 						: out std_logic_vector(6 downto 0);
		-- VGA
		VGA_RED, VGA_GREEN, VGA_BLUE 						: out std_logic_vector(7 downto 0); 
		HORIZ_SYNC, VERT_SYNC, VGA_BLANK, VGA_CLK		: out std_logic	
	);
end entity tank_game;

architecture behavioral of tank_game is

signal not_rst								: std_logic;
signal game_over 							: integer;
signal scan_code_signal 				: std_logic_vector( 7 downto 0 );
signal scan_readyo_signal 				: std_logic;
signal hist2_signal, hist1_signal, hist0_signal: std_logic_vector(7 downto 0);	

-- player signals
signal player1, player2, player1_score, player2_score			: integer;	
signal player1_speed, player2_speed									: integer;
signal player1_pos_x, player1_pos_y, player2_pos_x, player2_pos_y	: integer;
signal player1_clk, player2_clk										: std_logic;

-- bullet signals
signal player1_curr_bullet_x, player1_curr_bullet_y, player1_new_bullet_x, player1_new_bullet_y	: integer;
signal player2_curr_bullet_x, player2_curr_bullet_y, player2_new_bullet_x, player2_new_bullet_y	: integer;

-- bullet logic signals
signal bullet_clk	: std_logic;
signal player1_hit, player2_hit 	: std_logic;		
signal player1_shoots, player1_bullet_active, player1_new_bullet 	: std_logic;
signal player2_shoots, player2_bullet_active, player2_new_bullet	: std_logic;
	
begin

	-- set opposite of reset
	not_rst <= not rst;
	
	-- initalize coordinates of both tanks on the VGA display
	player1_pos_x <= player1;
	player1_pos_y <= 0;

	player2_pos_x <= player2;
	player2_pos_y <= 399;

	-- INPUTS
	keyboard_map : ps2 
		port map(keyboard_clk, keyboard_data, clk, not_rst, scan_code_signal, scan_readyo_signal, hist2_signal, hist1_signal, hist0_signal);

	lcd_display : de2lcd 
	   port map(not_rst, clk, game_over, LCD_RS, LCD_E, LCD_ON, RESET_LED, SEC_LED, LCD_RW, DATA_BUS);
	
	player1_clk_map: clk_tank
		port map (clk, rst, player1_speed, player1_clk); 
	
	player2_clk_map: clk_tank
		port map (clk, rst, player2_speed, player2_clk);
		
	player1_map: tank
		port map (player1_clk, rst, player1);
		
	player2_map: tank
		port map (player2_clk, rst, player2);

	bullet_clock: clk_bul
		port map (clk, rst, bullet_clk);
		
	update_bullet_values : update_clk_val
		port map (clk, player1_new_bullet, player2_new_bullet, player1_new_bullet_x, player1_new_bullet_y, player2_new_bullet_x, player2_new_bullet_y, player1_curr_bullet_x, player1_curr_bullet_y, player2_curr_bullet_x, player2_curr_bullet_y, player1_bullet_active, player2_bullet_active); 

	player1_bullet_map: bul_pos
		port map (bullet_clk, rst, '0', player1_shoots, player1_hit, player1_bullet_active, player1_curr_bullet_x, player1_curr_bullet_y, player1_pos_x, player1_pos_y, player1_new_bullet_x, player1_new_bullet_y, player1_new_bullet);

	player2_bullet_map: bul_pos
		port map (bullet_clk, rst, '1', player2_shoots, player2_hit, player2_bullet_active, player2_curr_bullet_x, player2_curr_bullet_y, player2_pos_x, player2_pos_y, player2_new_bullet_x, player2_new_bullet_y, player2_new_bullet);

	collision_1: bul_mark
		port map (player1_new_bullet_x, player1_new_bullet_y, player2_pos_x, player2_pos_y, player1_hit);

	collision_2: bul_mark
		port map (player2_new_bullet_x, player2_new_bullet_y, player1_pos_x, player1_pos_y, player2_hit);
		
	control_map : speedup_controls
		port map (scan_readyo_signal, rst, hist0_signal, hist1_signal, hist2_signal, player1_shoots, player2_shoots, player1_speed, player2_speed);
	
	-- OUTPUTS	
	score_map: update_score
		port map (clk, rst, player1_hit, player2_hit, player1_score, player2_score, game_over, score_disp_a, score_disp_b);
		
	VGA_map: VGA_top_level
		port map (clk, rst, player1, player2, player1_score, player2_score, player1_new_bullet_x, player1_new_bullet_y, player2_new_bullet_x, player2_new_bullet_y, VGA_RED, VGA_GREEN, VGA_BLUE, HORIZ_SYNC, VERT_SYNC, VGA_BLANK, VGA_CLK);
		
end architecture behavioral;