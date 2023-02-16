--ECSE 222 Lab 2
--Group 48
--Dafne Culha (260785524), Cheng Lin (260787697)
--17 Mar 2019

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ALL;

--entity declaration for stopwatch
--stopwatch takes in four inputs from FPGA board (start, stop, rest, and clk) and outputs to six 7-segment LEDs
entity g48_stopwatch is
	
	Port (start : in std_logic;
			stop : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0);
			HEX2 : out std_logic_vector(6 downto 0);
			HEX3 : out std_logic_vector(6 downto 0);
			HEX4 : out std_logic_vector(6 downto 0);
			HEX5 : out std_logic_vector(6 downto 0)
			);
end g48_stopwatch;

--create architecture for stopwatch
architecture behaviour of g48_stopwatch is
	
	--import the clock divider component
	component g48_clock_divider is
		Port(enable : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			en_out : out std_logic);
	end component g48_clock_divider;	
	
	--import counter component
	component g48_counter is
		Port (enable : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			count : out std_logic_vector(3 downto 0));
	end component g48_counter;
	
	--import 7 seg decoder component
	component g48_7_segment_decoder is
		Port( code: in std_logic_vector(3 downto 0);
			segments: out std_logic_vector(6 downto 0));
	end component g48_7_segment_decoder;
	
	--create signal to hold current count values for each digit (inputs to HEX0-HEX5)
	signal count_temp0 : std_logic_vector(3 downto 0) := "0000";
	signal count_temp1 : std_logic_vector(3 downto 0) := "0000";
	signal count_temp2 : std_logic_vector(3 downto 0) := "0000";
	signal count_temp3 : std_logic_vector(3 downto 0) := "0000";
	signal count_temp4 : std_logic_vector(3 downto 0) := "0000";
	signal count_temp5 : std_logic_vector(3 downto 0) := "0000";
	
	--create signal to hold enable for stopwatch (controlled by the start/stop inputs)
	signal enable_stopwatch : std_logic := '0';
	
	--create signal to hold output of clock divider
	signal en_out_divider : std_logic := '0';
	
	--create signals for reset input of each counter (active low)
	signal reset0 : std_logic := '1';
	signal reset1 : std_logic := '1';
	signal reset2 : std_logic := '1';
	signal reset3 : std_logic := '1';
	signal reset4 : std_logic := '1';
	signal reset5 : std_logic := '1';
	
	--create signals for enable input of each counter (active high)
	--(not including counter0 because it takes in the stopwatch's enable input)
	signal enable1 : std_logic := '0';
	signal enable2 : std_logic := '0';
	signal enable3 : std_logic := '0';
	signal enable4 : std_logic := '0';
	signal enable5 : std_logic := '0';
	
begin

	--create clock divider
	--clock divider is controlled by enable_stopwatch, rst, clk
	--it outputs en_out_divider which acts as the clock for all other digits
	clock_divider : g48_clock_divider PORT MAP(enable => enable_stopwatch,
														reset => reset, clk => clk, en_out => en_out_divider);
	
	--create 6 counters
	--each counter outputs its count to count_temp[x] variable
	counter0 : g48_counter PORT MAP(enable => enable_stopwatch, reset => reset0,
											clk => en_out_divider, count => count_temp0);
					
	counter1 : g48_counter PORT MAP(enable => enable1, reset => reset1,
											clk => en_out_divider, count => count_temp1);
											
	counter2 : g48_counter PORT MAP(enable => enable2, reset => reset2,
											clk => en_out_divider, count => count_temp2);
											
	counter3 : g48_counter PORT MAP(enable => enable3, reset => reset3,
											clk => en_out_divider, count => count_temp3);
											
	counter4 : g48_counter PORT MAP(enable => enable4, reset => reset4,
											clk => en_out_divider, count => count_temp4);
											
	counter5 : g48_counter PORT MAP(enable => enable5, reset => reset5,
											clk => en_out_divider, count => count_temp5);

	--declare a process block since this is a sequential circuit
	--define clk, start, stop and reset in sensitivity list as variables we keep track of
	--all other variables are synchronized with clk
	Process(clk, start, stop, reset) begin
				
		--check value of start first because it is asynchronous (takes priority)
		--start is active low
		if(start = '0') then
			enable_stopwatch <= '1'; --if start = 0, enable stopwatch
			
		--check value of stop (active low)
		elsif(stop = '0') then
			enable_stopwatch <= '0'; --if stop = 0, turn enable off
		
		--check value of reset (active low)
		elsif(reset = '0') then
			reset0 <= '0'; --if reset =0, set all resets for each counter to 0
			reset1 <= '0';
			reset2 <= '0';
			reset3 <= '0';
			reset4 <= '0';
			reset5 <= '0';
		
		--check for rising edge
		elsif(rising_edge(clk)) then
		
			--check if digit 0, 1, 2, 4, are 9 (need to be reset to 0)
			--similarly, check if digit  3 and 5 are 5
			
			--if digit 0 = 9, enable digit 1
			--(digit 1 will count up during this one cycle, then be shut off)
			if (count_temp0 = "1001") then
				enable1 <= '1';
			--the moment digit 0 hits 10, reset it
			--(the duration of one cycle where count_temp0 = 10 is too small for us to see)
			elsif (count_temp0 = "1010") then
				reset0 <= '0';
				enable1 <= '0';
			--otherwise keep reset = 1 and enable = 0
			else
			  reset0  <= '1';
			  enable1 <= '0';
			end if;
			
			--repeat same logic for digit 1
			--digit 2 is only enabled if digit 0 and digit 1 are at their max
			if (count_temp0 = "1001") and (count_temp1 = "1001") then
				enable2 <= '1';
			elsif (count_temp1 = "1010") then
				reset1 <= '0'; --reset when count_temp1 = 10
				enable2 <= '0';
			else
				reset1 <= '1';
				enable2 <= '0';
			end if;
			
			--digit 2
			if (count_temp0 = "1001") and (count_temp1 = "1001") and (count_temp2 = "1001") then
				enable3 <= '1';
			elsif (count_temp2 = "1010") then
				reset2 <= '0'; --reset when count_temp2 = 10
				enable3 <= '0';
			else
			  reset2 <= '1';
			  enable3 <= '0';
			end if;
			
			--digit 3
			if (count_temp0 = "1001") and (count_temp1 = "1001") and (count_temp2 = "1001") and (count_temp3 = "0101") then
				enable4 <= '1';
			elsif (count_temp3 = "0110") then
				reset3 <= '0'; --reset when count_temp3 = 6
				enable4 <= '0';
			else
				reset3 <= '1';
				enable4 <= '0';
			end if;
			
			--digit 4
			if (count_temp0 = "1001") and (count_temp1 = "1001") and (count_temp2 = "1001") and (count_temp3 = "0101") and (count_temp4 = "1001") then
				enable5 <= '1';
			elsif (count_temp4 = "1010") then
				reset4 <= '0'; --reset when count_temp4 = 10
				enable5 <= '0';
			else
				reset4 <= '1';
				enable5 <= '0';
			end if;
			
			--digit 5
			if count_temp5 = "0110" then
			  reset5 <= '0'; --reset when count_temp5 = 9
			else
			  reset5 <= '1';
			end if;
		end if;
		
	end Process;
	
	--assign inputs/outputs to decoders
	
	--decoder for counter 0
	decoder0: g48_7_segment_decoder PORT MAP(code => count_temp0,
							segments => HEX0);
	--decoder for counter 1
	decoder1: g48_7_segment_decoder PORT MAP(code => count_temp1,
							segments => HEX1);
	--decoder for counter 2
	decoder2: g48_7_segment_decoder PORT MAP(code => count_temp2,
							segments => HEX2);
	--decoder for counter 3
	decoder3: g48_7_segment_decoder PORT MAP(code => count_temp3,
							segments => HEX3);
	--decoder for counter 4
	decoder4: g48_7_segment_decoder PORT MAP(code => count_temp4,
							segments => HEX4);
	--decoder for counter 5
	decoder5: g48_7_segment_decoder PORT MAP(code => count_temp5,
							segments => HEX5);
							
end behaviour;