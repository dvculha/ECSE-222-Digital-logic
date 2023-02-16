--ECSE 222 Lab 2
--Group 48
--Dafne Culha (260785524), Cheng Lin (260787697)
--01 Apr 2019


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--declare a FSM entity with four boolean inputs (enable, direction, reset, clk)
--and one 4-bit vector output (count)

--this FSM will act as a bi-directional counter

entity g48_FSM is
	Port (enable : in std_logic;
			direction : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			count : out std_logic_vector(3 downto 0));
			
end g48_FSM;


--declare architecture for FSM
architecture behaviour of g48_FSM is
	--create a state_type signal type to hold each of the counter's state
	--each consecutive letter corresponds to the following number in the sequence
	--A->1, B->2, C->4, D->8, etc.
	type state_type is (A,B,C,D,E,F,G,H,I,J,K,L,M,N,O);
	
	--create signal to hold state of count
	signal count_temp : state_type := A;

begin

	--declare a process block since this is a sequential circuit
	--define clk and reset in sensitivity list as variables we keep track of
	--all other variables are synchronized with clk
	
	Process(clk, reset) begin
		--check the value of reset first because it is an asynchronous signal
		--reset is active low
		if(reset = '0') then
			--if direction is 1, we are counting up
			--reset counter to state A
			if (direction = '1') then
				count_temp <= A;
			--otherwise we are counting down, reset counter to state O
			else
				count_temp <= O;
			end if;
		
		--check for rising edge of clk
		elsif(rising_edge(clk)) then
			
			--check if enable is on (enable is active high)
			if(enable = '1') then
				--check for counting direction
				--direction = 1 means count up, direction = 0 means count down)
				case count_temp is
					--when count_temp = A, we either increment to B or decrement to O
					when A =>
						if (direction = '1') then
							count_temp <= B;
						else
							count_temp <= O;
						end if;
					when B =>
						if (direction = '1') then
							count_temp <= C;
						else
							count_temp <= A;
						end if;
					when C =>
						if (direction = '1') then
							count_temp <= D;
						else
							count_temp <= B;
						end if;
					when D =>
						if (direction = '1') then
							count_temp <= E;
						else
							count_temp <= C;
						end if;
					when E =>
						if (direction = '1') then
							count_temp <= F;
						else
							count_temp <= D;
						end if;
					when F =>
						if (direction = '1') then
							count_temp <= G;
						else
							count_temp <= E;
						end if;
					when G =>
						if (direction = '1') then
							count_temp <= H;
						else
							count_temp <= F;
						end if;
					when H =>
						if (direction = '1') then
							count_temp <= I;
						else
							count_temp <= G;
						end if;
					when I =>
						if (direction = '1') then
							count_temp <= J;
						else
							count_temp <= H;
						end if;
					when J =>
						if (direction = '1') then
							count_temp <= K;
						else
							count_temp <= I;
						end if;
					when K =>
						if (direction = '1') then
							count_temp <= L;
						else
							count_temp <= J;
						end if;
					when L =>
						if (direction = '1') then
							count_temp <= M;
						else
							count_temp <= K;
						end if;
					when M =>
						if (direction = '1') then
							count_temp <= N;
						else
							count_temp <= L;
						end if;
					when N =>
						if (direction = '1') then
							count_temp <= O;
						else
							count_temp <= M;
						end if;
					when O =>
						if (direction = '1') then
							count_temp <= A;
						else
							count_temp <= N;
						end if;
				end case;
					
			else
			--if enable = 0, do nothing
				count_temp <= count_temp;
			end if;
		end if;
	end Process;
	
	--set count output for a given count_temp state
	count <= "0001" when count_temp = A else
				"0010" when count_temp = B else
				"0100" when count_temp = C else
				"1000" when count_temp = D else
				"0011" when count_temp = E else
				"0110" when count_temp = F else
				"1100" when count_temp = G else
				"1011" when count_temp = H else
				"0101" when count_temp = I else
				"1010" when count_temp = J else
				"0111" when count_temp = K else
				"1110" when count_temp = L else
				"1111" when count_temp = M else
				"1101" when count_temp = N else
				"1001" when count_temp = O;

end behaviour;