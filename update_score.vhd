LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity update_score is
	port (
		clk, rst, marked1, marked2		: in std_logic;
		score1, score2						: inout integer;
		game_over							: inout integer;
		score_out1, score_out2			: out std_logic_vector(6 downto 0)
	);
end entity update_score;

architecture behavioral of update_score is

begin
	
	score_proc: process(clk, rst)
		variable counter1, counter2 : integer;
		
	begin
		-- if reset is active high, set everything back to 0, and counter to 50MHz
		if (rst = '1') then
			score1 <= 0;
			score2 <= 0;
			game_over <= 0;
			counter1 := 50000000;
			counter2 := 50000000;
		-- at every rising_edge, if score is less than 3 and a tank has been marked by a bullet, increment respective score and set respective counter to 0
		elsif (rising_edge(clk)) then
			if(marked1 = '1' and score1 < 3 and counter1 >= 25000000) then
				score1 <= score1 + 1;
				counter1 := 0;
			elsif (counter1 < 100000000) then
				counter1 := counter1 + 1;
			else
				counter1 := counter1;
			end if;

			if(marked2 = '1' and score2 < 3 and counter2 >= 25000000) then
				score2 <= score2 + 1;
				counter2 := 0;
			elsif (counter2 < 100000000) then
				counter2 := counter2 + 1;
			else
				counter2 := counter2;
			end if;
		end if;
		
		-- scoreboard
		score_1: case score1 is 
			when 0 =>
				score_out1 <= "1000000";
			when 1 =>
				score_out1 <= "1111001";
			when 2 =>
				score_out1 <= "0100100";
			when 3 =>
				score_out1 <= "0110000";
				game_over <= 1;
			when others =>
				score_out1 <= "0001110";
				game_over <= 0;
			end case;
		
		score_2: case score2 is 
			when 0 =>
				score_out2 <= "1000000";
			when 1 =>
				score_out2 <= "1111001";
			when 2 =>
				score_out2 <= "0100100";
			when 3 =>
				score_out2 <= "0110000";
				game_over <= 2;
			when others =>
				score_out2 <= "0001110";
				game_over <= 0;
		end case;

		end process score_proc;
end architecture behavioral;