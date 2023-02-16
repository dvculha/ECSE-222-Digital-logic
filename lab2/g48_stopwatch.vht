-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "03/19/2019 14:42:33"
                                                            
-- Vhdl Test Bench template for design  :  g48_stopwatch
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g48_stopwatch_vhd_tst IS
END g48_stopwatch_vhd_tst;
ARCHITECTURE g48_stopwatch_arch OF g48_stopwatch_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL HEX0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX2 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX4 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX5 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL start : STD_LOGIC;
SIGNAL stop : STD_LOGIC;
COMPONENT g48_stopwatch
	PORT (
	clk : IN STD_LOGIC;
	HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	reset : IN STD_LOGIC;
	start : IN STD_LOGIC;
	stop : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g48_stopwatch
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	HEX0 => HEX0,
	HEX1 => HEX1,
	HEX2 => HEX2,
	HEX3 => HEX3,
	HEX4 => HEX4,
	HEX5 => HEX5,
	reset => reset,
	start => start,
	stop => stop
	);

--init process to loop clock values
init : PROCESS 
BEGIN
		--FPGA board's clock has 50 MHz frequency
		--this means one period every 20 ns (so change clk every 10 ns)
		
		clk <= '1';
		WAIT FOR 1ns;
		clk <= '0';
		WAIT FOR 1ns;                                                      
END PROCESS init;                                            

--test clock divider's reset, enable, and counting functionalities                                      
stopwatch_test : PROCESS                                                                                 
BEGIN
		--set initial values
		reset <= '1';	
      start <= '1';
		stop <='1';
		
		WAIT FOR 5ns;
		--test start
		start <= '0';
		WAIT FOR 5ns;
		start <='1';
		WAIT FOR 5ns;
		
		--test stop
		stop <= '0';
		WAIT FOR 5ns;
		stop <='1';
				
		--test reset
		reset <= '0';
		WAIT FOR 5ns;
		reset <= '1';
		
		--test counting
		start <= '0';
		WAIT FOR 1ns;
		start <= '1';
WAIT;                                                       
END PROCESS stopwatch_test;
END g48_stopwatch_arch;
