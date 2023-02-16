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
-- Generated on "04/02/2019 14:48:14"
                                                            
-- Vhdl Test Bench template for design  :  g48_multimode_counter
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g48_multimode_counter_vhd_tst IS
END g48_multimode_counter_vhd_tst;
ARCHITECTURE g48_multimode_counter_arch OF g48_multimode_counter_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL direction : STD_LOGIC;
SIGNAL HEX0 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL HEX1 : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL reset : STD_LOGIC;
SIGNAL start : STD_LOGIC;
SIGNAL stop : STD_LOGIC;
COMPONENT g48_multimode_counter
	PORT (
	clk : IN STD_LOGIC;
	direction : IN STD_LOGIC;
	HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	reset : IN STD_LOGIC;
	start : IN STD_LOGIC;
	stop : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g48_multimode_counter
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	direction => direction,
	HEX0 => HEX0,
	HEX1 => HEX1,
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

always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
		--set initial values
		reset <= '1';	
      start <= '1';
		stop <= '1';
		direction <='1';
		
		--test reset
		WAIT FOR 450ns;
		reset<='0';
		WAIT FOR 100ns;
		reset <= '1';
		
		--test start
		WAIT FOR 340ns;
		start <= '0';
		WAIT FOR 20ns;
		start <= '1';
		
		--test stop
		WAIT FOR 340ns;
		stop <= '0';
		WAIT FOR 20ns;
		stop <= '1';
		start <= '0';
		WAIT FOR 2ns;
		start<='1';
		
		--test direction
		WAIT FOR 340ns;
		direction <='0';
		WAIT FOR 410ns;
		reset<='0';
		WAIT FOR 20ns;
		reset <='1';
		
WAIT;                                                        
END PROCESS always; 

	
END g48_multimode_counter_arch;
