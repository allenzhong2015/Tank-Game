LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity speedup_controls is
	port (
		scan_readyo_signal, rst : in std_logic;
		hist0, hist1, hist2	: in std_logic_vector(7 downto 0);
		bullet_1, bullet_2	: inout std_logic;
		speed_a, speed_b		: out integer
	);
end entity speedup_controls;

architecture behavioral of speedup_controls is

begin

	speedup_proc: process(scan_readyo_signal, rst)
		variable speed_a_temp, speed_b_temp : integer;
		
	begin	
		speed_a_temp := speed_a_temp;
		speed_b_temp := speed_b_temp;
		
		if (rst = '1') then
			speed_a_temp := 1;
			speed_b_temp := 1;
			bullet_1 <= '0';
		   bullet_2 <= '0';
			
		elsif (falling_edge(scan_readyo_signal)) then
			
			-- 'Q' key -> slow down purple tank
			if(hist0 = x"15" and not (hist1 =x"F0" and hist2 = x"15")) then
				if (speed_a_temp > 1) then
					speed_a_temp := speed_a_temp - 1;
				else
					speed_a_temp := speed_a_temp;
				end if;		
			-- 'W' key -> speed up purple tank
			elsif(hist0 = x"1D" and not (hist1 =x"F0" and hist2 =x"1D")) then
				if (speed_a_temp < 3) then
					speed_a_temp := speed_a_temp + 1;
				else
					speed_a_temp := speed_a_temp;
				end if;	
			-- 'E' key -> shoot purple tank's bullet
			elsif (hist0 = x"24" and not (hist1 =x"F0" and hist2 = x"24")) then 
				bullet_1 <= '1';	
			else
				speed_a_temp := speed_a_temp;
				bullet_1 <= '0';
			end if;
			
			-- '1' key -> slow down yellow tank
			if(hist0 = x"69" and not (hist1 =x"F0" and hist2 = x"69")) then 
				if (speed_b_temp > 1) then
					speed_b_temp := speed_b_temp - 1;
				else
					speed_b_temp := speed_b_temp;
				end if;
			-- '2' key -> speed up yellow tank
			elsif(hist0 = x"72" and not (hist1 =x"F0" and hist2 = x"72")) then
				if (speed_b_temp < 3) then
					speed_b_temp := speed_b_temp + 1;
				else
					speed_b_temp := speed_b_temp;
				end if;
			-- '3' key -> shoot yellow tank's bullet
			elsif (hist0 = x"7A" and not (hist1 =x"F0" and hist2 = x"7A"))then 
				bullet_2 <= '1';
			else
				speed_b_temp := speed_b_temp;
				bullet_2 <= '0';
			end if;	
		end if;
		
		speed_a <= speed_a_temp;
		speed_b <= speed_b_temp;
	end process speedup_proc;

end architecture behavioral;