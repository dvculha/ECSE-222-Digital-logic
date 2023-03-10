--ECSE 222 Lab 1
--Group 48
--Dafne Culha (260785524), Cheng Lin (260787697)
--28 Feb 2019

--entity and architecture declaration for a decoder that converts a 4-bit hexadecimal digit to a 7-bit vector for a 7 seg display

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--create 7 segment decoder entity
entity g48_7_segment_decoder is
	--input is a 4-bit binary number
	--output is a 7-bit encoded value for the seven segment display
	Port( code: in std_logic_vector(3 downto 0);
			segments: out std_logic_vector(6 downto 0));
end g48_7_segment_decoder;

--create architecture for decoder
architecture behaviour of g48_7_segment_decoder is
begin

	--use single selected signal assignment to set segments vector
	--using boolean statements to set vectors is too complicated
	
	segments <= "1000000" when code = "0000" else
					"1111001" when code = "0001" else
					"0100100" when code = "0010" else
					"0110000" when code = "0011" else
					"0011001" when code = "0100" else
					"0010010" when code = "0101" else
					"0000010" when code = "0110" else
					"1111000" when code = "0111" else
					"0000000" when code = "1000" else
					"0010000" when code = "1001" else
					"0001000" when code = "1010" else
					"0000011" when code = "1011" else
					"1000110" when code = "1100" else
					"0100001" when code = "1101" else
					"0000110" when code = "1110" else
					"0001110" when code = "1111";
					
end behaviour;