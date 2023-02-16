--ECSE 222 Lab 2
--Group 48
--Dafne Culha (260785524), Cheng Lin (260787697)
--17 Mar 2019

--entity declaration for a counter that counts up to 15

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--declare counter entity with three boolean inputs (enalble, reset, clk)
--and one 3-bit vector output (count)

entity g48_counter is
	Port (enable : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			count : out std_logic_vector(3 downto 0)
			);
end g48_counter;

--declare architecture for counter
architecture behaviour of g48_counter is
	
	--create signal to hold current count value which will be assigned to the output vector count
	signal count_temp : std_logic_vector(3 downto 0) := "0000";
	
begin
	--declare a process block since this is a sequential circuit
	--define clk and reset in sensitivity list as variables we keep track of
	--all other variables are synchronized with clk so we don't list them
	Process(clk, reset) begin
		
		--check the value of reset first because it is an asynchronous signal (takes priority)
		if(reset = '0') then
			count_temp <= "0000"; --restart count if reset = 0
		
		--check for rising edge of clk
		elsif(rising_edge(clk)) then
			
			--check if enable is on (enable is active high)
			--add one to count if enable = 1
			if(enable = '1') then
				count_temp <= std_logic_vector(unsigned(count_temp) + 1);
			else
				count_temp <= count_temp; --if enable = 0, do nothing
			end if;
		end if;
	end Process;
	
	--assign count_temp to count
	--(this is outside process block because this wiring is always non-sequential)
	count <= count_temp;
	
end behaviour;