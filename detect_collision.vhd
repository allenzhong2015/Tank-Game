library IEEE;
use IEEE.std_logic_1164.all;
use work.package_components.all;

entity detect_collision is
	port (
		box1_left, box1_right, box1_top, box1_bottom : in integer;
		box2_left, box2_right, box2_top, box2_bottom : in integer;
		collision : out std_logic
	);
end entity detect_collision;

architecture behavioral of detect_collision is
	signal overlap_left, overlap_right, overlap_top, overlap_bottom : std_logic;
	--signal collision_1, collision_2	: std_logic;

	begin
		
	collision_proc: process (box1_left, box1_right, box1_top, box1_bottom, box2_left, box2_right, box2_top, box2_bottom)
	
		begin
			-- initalize signals
			overlap_left 	<= '0';
			overlap_right 	<= '0';
			overlap_top 	<= '0';
			overlap_bottom <= '0';
			collision 		<= '0';

			
			-- if box 1 left side is between box 2 left and right sides, then set to high 
			if ((box1_left >= box2_left) and (box1_left <= box2_right)) then
				overlap_left <= '1';
			end if;
			
			-- if box 1 right side is between box 2 left and right sides, then set to high 
			if ((box1_right >= box2_left) and (box1_right <= box2_right)) then
				overlap_right <= '1';
			end if;
			
			-- if box 1 top side is between box 2 top and bottom sides, then set to high 
			if ((box1_top >= box2_top) and (box1_top <= box2_bottom)) then
				overlap_top <= '1';
			end if;
		
			-- if box 1 bottom side is between box 2 top and bottom sides, then set to high 
			if ((box1_bottom >= box2_top) and (box1_bottom <= box2_bottom)) then
				overlap_bottom <= '1';
			end if;
			
			-- if bullet's left or right are inbetween tank's left and right 
			-- and
			-- if bullet's top or bottom are inbetween tank's top and bottom
			-- set to high
			if (((overlap_left or overlap_right) and (overlap_top or overlap_bottom)) = '1') then
				collision <= '1';
			end if;
			
		end process collision_proc;
		
end architecture behavioral;