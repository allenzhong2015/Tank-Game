LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity update_clk_val is
	port (
		clk 							: in std_logic;
		check_a, check_b			: in std_logic;
		d_a1, d_a2, d_b1, d_b2	: in integer;
		q_a1, q_a2, q_b1, q_b2	: inout integer;
		exist_a, exist_b			: inout std_logic
	);
end entity update_clk_val;

architecture behavioral of update_clk_val is

begin
	update_val: process(clk, check_a, check_b, q_a1, q_a2, q_b1, q_b2, d_a1, d_a2, d_b1, d_b2, exist_a, exist_b) is
	begin
		-- signals need to be updated in rising_edge(clk), otherwise it keeps the same value
		q_a1 <= q_a1;
		q_a2 <= q_a2;
		q_b1 <= q_b1;
		q_b2 <= q_b2;
		
		exist_a <= exist_a;
		exist_b <= exist_b;
		
		if (rising_edge(clk)) then
			q_a1 <= d_a1;
			q_a2 <= d_a2;
			q_b1 <= d_b1;
			q_b2 <= d_b2;
			
			exist_a <= check_a;
			exist_b <= check_b;
		end if;
	end process update_val;
end architecture behavioral;