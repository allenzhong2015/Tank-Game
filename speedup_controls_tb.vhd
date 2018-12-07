library IEEE;
library STD; 

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all; 
use std.textio.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity speedup_controls_tb is
end entity speedup_controls_tb;


architecture behavioral of speedup_controls_tb is

	component speedup_controls is
		port(
		scan_readyo_signal, rst : in std_logic;
		hist0, hist1, hist2	: in std_logic_vector(7 downto 0);
		bullet_1, bullet_2	: inout std_logic;
		speed_a, speed_b		: out integer
		);
	end component speedup_controls;
	
		signal scan_readyo_signal, rst : std_logic;
		signal hist0, hist1, hist2	: std_logic_vector(7 downto 0);
		signal bullet_1, bullet_2	: std_logic;
		signal speed_a, speed_b	: integer;
	
begin
	
	speedup_controls_go : speedup_controls
		port map(
			scan_readyo_signal,
			rst, 
			hist0, 
			hist1, 
			hist2, 
			bullet_1, 
			bullet_2,	
			speed_a, 
			speed_b	
		);
		
   speedup_controls_process: process is
   begin
		rst <= '1';
		wait for 5 ns; 
		rst <= '0';
		scan_readyo_signal <= '1';
		wait for 5 ns; 
		scan_readyo_signal <= '0';
		hist0 <= x"15"; 
		hist1 <= x"00";
		hist2 <= x"00";
		wait for 5 ns; 
		scan_readyo_signal <= '1';
		wait for 5 ns; 
		scan_readyo_signal <= '0';
		hist0 <= x"1D"; 
		hist1 <= x"00";
		hist2 <= x"00";
		wait for 5 ns;
		scan_readyo_signal <= '1';
		wait for 5 ns; 
		scan_readyo_signal <= '0';
		hist0 <= x"1D"; 
		hist1 <= x"00";
		hist2 <= x"00";
		wait for 5 ns;
		scan_readyo_signal <= '1';
		wait for 5 ns; 
		scan_readyo_signal <= '0';
		hist0 <= x"24"; 
		hist1 <= x"00";
		hist2 <= x"00";
		wait for 5 ns; 
		scan_readyo_signal <= '1';
		wait for 5 ns; 
		scan_readyo_signal <= '0';
		hist0 <= x"69"; 
		hist1 <= x"00";
		hist2 <= x"00";
		wait for 5 ns; 
		scan_readyo_signal <= '1';
		wait for 5 ns; 
		scan_readyo_signal <= '0';
		hist0 <= x"72"; 
		hist1 <= x"00";
		hist2 <= x"00";
		wait for 5 ns; 
		scan_readyo_signal <= '1';
		wait for 5 ns; 
		scan_readyo_signal <= '0';
		hist0 <= x"7A"; 
		hist1 <= x"00";
		hist2 <= x"00";
		wait for 5 ns; 
		wait;
   end process;

end architecture behavioral;