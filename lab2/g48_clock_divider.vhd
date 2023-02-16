--ECSE 222 Lab 2
--Group 48
--Dafne Culha (260785524), Cheng Lin (260787697)
--17 Mar 2019

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--declare clock divider entity with three boolean inputs (enable, reset, clk)
--and one boolean output (en_out)

entity g48_clock_divider is
	--declare a time factor, T
	--Because 10 miliseconds elapses 500000 PLL events, a change in clk occurs every 500000 PLL events
	Generic (constant T : integer := 500000
			);
	
	Port (enable : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			en_out : out std_logic
			);
end g48_clock_divider;

--create architecture for clock divider
architecture behaviour of g48_clock_divider is

	--create signal to hold current count value
	--create signal to hold temporary en_out value
	signal T_temp : integer := T-1;
	signal en_out_temp : std_logic := '0';

begin
	--declare a process block since this is a sequential circuit
	--define clk and reset in sensitivity list as variables we keep track of
	--all other variables are synchronized with clk
	Process(clk, reset) begin
		
		--check the value of reset first because it is an asynchronous signal (takes priority)
		--reset is active low
		if(reset = '0') then
			T_temp <= T-1; --if reset = 0, restart T_temp
			en_out_temp <= '0';
		
		--check for rising edge
		elsif(rising_edge(clk)) then
			
			--check if enable is on (enable is active high)
			if(enable = '1') then
				T_temp <= T_temp - 1; --if enable = 1, decrease count
			else
				T_temp <= T_temp; --if enable = 0, do nothing
			end if;
			
			--check value of T_temp
			if(T_temp > 0) then
				en_out_temp <= '0';
			else
				en_out_temp <= '1'; --if T_temp = 0, output 1 and restart count
				T_temp <= T-1;
			end if;
		end if;
			
	end Process;
	
	--assign en_out_temp to en_out
	en_out <= en_out_temp;
	
end behaviour;