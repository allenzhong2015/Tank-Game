library IEEE;
library STD; 

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all; 
use std.textio.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;


entity tank_tb is
end entity tank_tb;


architecture behavioral of tank_tb is

	component tank is
		port(
			clk : in std_logic;
			rst : in std_logic;
			move : out integer
		);
	end component tank;
	
	signal clk : std_logic;
	signal rst : std_logic;
	signal move : integer;
	
begin
	
	tank1: tank
		port map(
			clk => clk,
			rst => rst,
			move => move
		);
		
   tank_process: process is
   begin
		rst <= '1';
		clk <= '0';
		wait for 5 ns;
		rst <= '0';
		clk <= not clk;
		wait for 5 ns;
		clk <= not clk;
		wait for 5 ns;
		clk <= not clk;
		wait;

   end process tank_process;
end architecture behavioral;