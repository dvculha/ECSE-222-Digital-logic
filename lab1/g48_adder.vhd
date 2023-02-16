--ECSE 222 Lab 1
--Group 48
--Dafne Culha (260785524), Cheng Lin (260787697)
--28 Feb 2019

--entity and architecture declaration for an adder that adds two 5-bit binary digits
--then converts both the inputs and sum to three 14-bit vectors corresponding to inputs for six (3x2) 7 seg displays
--the numbers displayed on the 7-seg LEDs are in hexadecimal format

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ALL;

--declare adder entity
entity g48_adder is
	--input is two 5-bit binary numbers
	--output is three 14-bit vectors corresponding to the 14 inputs for two 7 seg displays each
	Port(A, B: in std_logic_vector(4 downto 0);
			decoded_A: out std_logic_vector(13 downto 0);
			decoded_B: out std_logic_vector(13 downto 0);
			decoded_AplusB: out std_logic_vector(13 downto 0)
			);
end g48_adder;

--declare architecture for adder
architecture behaviour of g48_adder is

	--import 7 seg decoder component
	component g48_7_segment_decoder is
		Port( code: in std_logic_vector(3 downto 0);
			segments: out std_logic_vector(6 downto 0));
	end component g48_7_segment_decoder;
	
	--instantiate a signal to temporarily hold sum of A and B
	signal AplusB: std_logic_vector(5 downto 0);
	
	--instantiate 4-bit signals to hold the values for the second (/most significant) digit of each number
	
	signal A1: std_logic_vector(3 downto 0); --values for most significant digit of A
	signal B1: std_logic_vector(3 downto 0); --values for most significant digit of B
	signal AplusB1: std_logic_vector(3 downto 0); --values for most significant digit of A plus B
	
begin
	--add 5-bit inputs like normal 5-bit numbers
	--concatenate '0' to left of each input to hold carry-out of sum
	AplusB <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
									
	--assign values to the 4-bit signals for the second (/most significant) digit
	--append zero's to the left so the values are 4 bits
	A1 <= "000" & A(4);
	B1 <= "000" & B(4);
	AplusB1 <= "00" & AplusB(5 downto 4);
	
	--instantiate decoder components to convert each 4-digit binary into 7-seg encoded input
	--first (/least significant) 7-seg takes in the value dictated by bit 3 to 0
	--second (/most significant) 7-seg takes in the value dictated by the extra signals instantiated above
	--each decoder outputs to its corresponding "decoded_{}" vector
	
	--most significant digit of A
	decoderA1: g48_7_segment_decoder PORT MAP(code => A1,
							segments => decoded_A(13 downto 7));
	--least significant digit of A
	decoderA0: g48_7_segment_decoder PORT MAP(code => A(3 downto 0),
							segments => decoded_A(6 downto 0));
	
	--most significant digit of B
	decoderB1: g48_7_segment_decoder PORT MAP(code => B1,
							segments => decoded_B(13 downto 7));
	--least significant digit of B
	decoderB0: g48_7_segment_decoder PORT MAP(code => B(3 downto 0),
							segments => decoded_B(6 downto 0));
	
	--most significant digit of sum
	decoderAplusB1: g48_7_segment_decoder PORT MAP(code => AplusB1,
							segments => decoded_AplusB(13 downto 7));
	--least significant digit of sum
	decoderAplusB0: g48_7_segment_decoder PORT MAP(code => AplusB(3 downto 0),
							segments => decoded_AplusB(6 downto 0));
							
end behaviour;