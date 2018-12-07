library IEEE;
use IEEE.std_logic_1164.all;
use work.package_components.all;

entity bul_pos is
	port (
		clk, rst, dir						: in std_logic;
		bullet_fired, bullet_hit 		: in std_logic;
		curr_bullet_active				: in std_logic;
		curr_bullet_x, curr_bullet_y	: in integer;
		curr_tank_x, curr_tank_y		: in integer;
		new_bullet_x, new_bullet_y		: out integer;
		new_bullet_active					: out std_logic
	);
end entity bul_pos;

architecture behavioral of bul_pos is
begin

	position_proc: process (clk, rst)
	begin
	
		-- if reset is active high, then dont allow new bullet to show
		-- also prime bullet to form based on direction
		if (rst = '1') then
			new_bullet_active <= '0';
			if (dir = '0') then
				new_bullet_x <= 320;
				new_bullet_y <= curr_tank_y + 60;
			elsif (dir = '1') then
				new_bullet_x <= 320;
				new_bullet_y <= curr_tank_y + 15;
			else
				new_bullet_x <= 0;
				new_bullet_y <= 0;
			end if;
	
		-- update bullet on clock
		elsif rising_edge(clk) then
			new_bullet_active <= '0';
			new_bullet_x <= curr_tank_x + 60;
			new_bullet_y <= curr_bullet_y;
			
			-- when bullet is fired, update position accordingly
			if ((bullet_fired = '1') and (curr_bullet_active = '0')) then
				new_bullet_active <= '1';
				new_bullet_x <= curr_tank_x + 60;
				new_bullet_y <= curr_bullet_y;
				
			-- if bullet is still in the air	
			elsif (curr_bullet_active = '1') then
				new_bullet_active <= '1';
				new_bullet_x <= curr_bullet_x;
				
				-- decide which direction the bullet is sent to
				if (dir = '0') then
					new_bullet_y <= curr_bullet_y + 1;
				elsif (dir = '1') then
					new_bullet_y <= curr_bullet_y - 1;
				else
					new_bullet_y <= curr_bullet_y;
				end if;

				if ((curr_bullet_y > 475) or (curr_bullet_y < 5) or bullet_hit = '1') then
					new_bullet_active <= '0';
					if (dir = '0') then
						new_bullet_x <= curr_tank_x + 60;
						new_bullet_y <= curr_tank_y + 40;
					elsif (dir = '1') then
						new_bullet_x <= curr_tank_x + 60;
						new_bullet_y <= curr_tank_y + 15;
					else
						new_bullet_x <= 0;
						new_bullet_y <= 0;
					end if;
				end if;
			end if;
		end if;

	end process position_proc;
end architecture behavioral;