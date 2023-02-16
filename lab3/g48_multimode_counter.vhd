--ECSE 222 Lab 2
--Group 48
--Dafne Culha (260785524), Cheng Lin (260787697)
--01 Apr 2019


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.ALL;

--declare an entity with five boolean inputs (start, stop, direction, reset, clk)
--and two 7-bit vector outputs for two 7-seg displays

entity g48_multimode_counter is
	Port (start : in std_logic;
			stop : in std_logic;
			direction : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			HEX0 : out std_logic_vector(6 downto 0);
			HEX1 : out std_logic_vector(6 downto 0));
			
end g48_multimode_counter;

--declare architecture for FSM
architecture behaviour of g48_multimode_counter is
	
	--import the FSM component
	component g48_FSM is
		Port (enable : in std_logic;
				direction : in std_logic;
				reset : in std_logic;
				clk : in std_logic;
				count : out std_logic_vector(3 downto 0));
	end component g48_FSM;
	
	--import the clock divider component
	component g48_clock_divider is
		Port(enable : in std_logic;
			reset : in std_logic;
			clk : in std_logic;
			en_out : out std_logic);
	end component g48_clock_divider;	
	
	--import 7 seg decoder component
	component g48_7_segment_decoder is
		Port(code: in std_logic_vector(3 downto 0);
			segments: out std_logic_vector(6 downto 0));
	end component g48_7_segment_decoder;
		
	--declare signal to hold clock from divider
	signal divided_clk : std_logic;
	--declare signal to hold temporary enable, instantiate as 0
	signal enable_temp : std_logic := '0';
	
	--declare signal to hold temporary count
	signal count_temp : std_logic_vector(3 downto 0);
	--declare signals to hold BCD digits of count_temp
	signal digit0 : std_logic_vector(3 downto 0);
	signal digit1 : std_logic_vector(3 downto 0);
	
begin
	
	--create clock divider
	--clock divider is controlled by reset, clk, and enable_temp variables
	--it outputs divided_clk which acts as the clock for to FSM
	clock_divider : g48_clock_divider PORT MAP(enable => enable_temp,
																reset => reset,
																clk => clk,
																en_out => divided_clk);

	--create an FSM component
	FSM : g48_FSM PORT MAP(enable => enable_temp,
									direction => direction,
									reset => reset,
									clk => divided_clk,
									count => count_temp);
	
	--declare a process block since this is a sequential circuit with memory
	--define start and stop in sensitivity list as variables we keep track of
	
	Process(start, stop, count_temp) begin
	
		--check value of start (active low)
		if(start = '0') then
			enable_temp <= '1'; --if start = 0, enable stopwatch
			
		--check value of stop (active low)
		elsif(stop = '0') then
			enable_temp <= '0'; --if stop = 0, turn enable off
			
		end if;
		
		--convert count_temp to BCD digits stored in digit0 and digit1
		--start by checking if count_temp is greater than 9
		if(count_temp > "1001")then
		--if count_temp greater than 9, convert to BCD
			digit0 <= std_logic_vector(unsigned(count_temp) + "0110"); --conver to BCD by adding 6
			digit1 <= "0001";
			
		else
		--if count_temp is less than 9, set digit0 = count_temp and digit1 = 0
			digit0 <= count_temp;
			digit1 <= "0000";
		end if;
		
	end Process;
	
	--decoder for counter 0
	decoder0: g48_7_segment_decoder PORT MAP(code => digit0,
							segments => HEX0);
	--decoder for counter 1
	decoder1: g48_7_segment_decoder PORT MAP(code => digit1,
							segments => HEX1);
	
end behaviour;