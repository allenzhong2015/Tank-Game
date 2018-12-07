library IEEE;
library STD; 

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all; 
use std.textio.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;


entity detect_collision_tb is
end entity detect_collision_tb;


architecture behavioral of detect_collision_tb is

	component detect_collision is
		port(
			box1_left, box1_right, box1_top, box1_bottom : in integer;
			box2_left, box2_right, box2_top, box2_bottom : in integer;
			collision : out std_logic
		);
	end component detect_collision;
	
		signal box1_left, box1_right, box1_top, box1_bottom : integer;
		signal box2_left, box2_right, box2_top, box2_bottom : integer;
		signal collision : std_logic;
	
begin
	
	coll_detect : detect_collision
		port map(
			box1_left => box1_left,
			box1_right => box1_right,
			box1_top => box1_top,
			box1_bottom => box1_bottom,
			box2_left => box2_left,
			box2_right => box2_right,
			box2_top => box2_top,
			box2_bottom => box2_bottom,
			collision => collision 
		);
		
   coll_process: process is
   begin
		box1_left <= 5;
		box1_right <= 4;
		box1_top <= 4;
		box1_bottom <= 5; 
		
		box2_left <= 5;
		box2_right <= 6;
		box2_top <= 2;
		box2_bottom <= 3; 
		wait for 5 ns;
		
		box1_left <= 5;
		box1_right <= 4;
		box1_top <= 3;
		box1_bottom <= 5; 
		
		box2_left <= 4;
		box2_right <= 6;
		box2_top <= 2;
		box2_bottom <= 4;
		wait;

   end process coll_process;
end architecture behavioral;