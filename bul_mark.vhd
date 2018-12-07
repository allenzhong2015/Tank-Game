library IEEE;
use IEEE.std_logic_1164.all;
use work.package_components.all;

entity bul_mark is
	port (
		temp1_x, temp1_y : in integer;
		temp2_x, temp2_y	: in integer;

		hit: out std_logic
	);
end entity bul_mark;

architecture behavioral of bul_mark is
	signal bullet_left, bullet_right, bullet_top, bullet_bottom : integer;
	signal temp_left, temp_right, temp_top, temp_bottom			: integer;

begin
	bounding_boxes: process (temp1_x, temp1_y, temp2_x, temp2_y)
	begin
	-- bullet hit box range
		bullet_left 	<= temp1_x - 5;		bullet_right 	<= temp1_x + 5;
		bullet_top 		<= temp1_y - 5;
		bullet_bottom 	<= temp1_y + 5;
		
	-- tank hit box range
		temp_left 		<= temp2_x;		temp_right 		<= temp2_x + 100;
		temp_top 		<= temp2_y;
		temp_bottom 	<= temp2_y + 100;
	end process bounding_boxes;
	
	-- use helper file to check if there is hit box is marked on either tanks
	collision_test: detect_collision
		port map (bullet_left, bullet_right, bullet_top, bullet_bottom, temp_left, temp_right, temp_top, temp_bottom, hit);
		
end architecture behavioral;
	