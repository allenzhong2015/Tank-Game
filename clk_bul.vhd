library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.package_components.all;

entity clk_bul is
	port (
		clk, rst								: in std_logic;
		bullet_clk							: out std_logic
	);
end entity clk_bul;

architecture behavioral of clk_bul is

begin

	clk_bullet : process(clk, rst) is
		variable counter : integer := 0;
	
	begin
	
		-- initalize counter
		counter := counter;
		
		-- if reset is active high, set counter and clk to 0
		if (rst = '1') then
			counter := 0;
			bullet_clk <= '0';
			
		-- otherwise, increment counter by 1 at every rising clock edge. 	
		elsif (rising_edge(clk)) then
			counter := counter + 1;
			-- speed of bullet
			if (counter >= 100000 and counter < 200000) then
				bullet_clk <= '1';
			elsif (counter >= 200000) then
				counter := 0;
				bullet_clk <= '0';
			end if;
			
		end if;
	end process clk_bullet;
end architecture behavioral;