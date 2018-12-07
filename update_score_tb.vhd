library IEEE;
library STD; 

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all; 
use std.textio.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity update_score_tb is
end entity update_score_tb;


architecture behavioral of update_score_tb is

	component update_score is
		port(
		clk, rst, marked1, marked2		: in std_logic;
		score1, score2					: inout integer;
		game_over						: inout integer;
		score_out1, score_out2			: out std_logic_vector(6 downto 0)
		);
	end component update_score;
	
	signal clk, rst, marked1, marked2		: std_logic;
	signal score1, score2					: integer;
	signal game_over						: integer;
	signal score_out1, score_out2			: std_logic_vector(6 downto 0);
	
begin
	
	update_score_go : update_score
		port map(
			clk => clk,
			rst => rst,
			marked1 => marked1,
			marked2 => marked2,
			score1 => score1,
			score2 => score2,
			game_over => game_over,
			score_out1 => score_out1,
			score_out2 => score_out2
		);
		
   update_score_process: process is
   begin
		clk <= '0';
		rst <= '0';
		wait for 5 ns;
		rst <= '1';
		clk <= not clk;
		wait for 5 ns; 
		clk <= not clk;
		rst <= '0';
		wait for 5 ns;
		clk <= not clk;
		marked1 <= '1';
		marked2 <= '0';
		wait for 5 ns;
		clk <= not clk;
		wait for 5 ns;
		clk <= not clk;
		marked1 <= '1';
		marked2 <= '1';
		wait for 5 ns;
		clk <= not clk;
		wait for 5 ns;
		clk <= not clk;
		marked1 <= '1';
		marked2 <= '1';
		wait for 5 ns;
		wait;
   end process;

end architecture behavioral;