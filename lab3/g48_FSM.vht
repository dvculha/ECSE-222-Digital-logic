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
-- Generated on "04/01/2019 15:41:53"
                                                            
-- Vhdl Test Bench template for design  :  g48_FSM
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g48_FSM_vhd_tst IS
END g48_FSM_vhd_tst;
ARCHITECTURE g48_FSM_arch OF g48_FSM_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC;
SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL direction : STD_LOGIC;
SIGNAL enable : STD_LOGIC;
SIGNAL reset : STD_LOGIC;
COMPONENT g48_FSM
	PORT (
	clk : IN STD_LOGIC;
	count : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	direction : IN STD_LOGIC;
	enable : IN STD_LOGIC;
	reset : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : g48_FSM
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	count => count,
	direction => direction,
	enable => enable,
	reset => reset
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
		enable <= '1';
		direction <='1';
		
		--test reset
		WAIT FOR 45ns;
		reset<='0';
		WAIT FOR 10ns;
		reset <= '1';
		
		--test enable
		WAIT FOR 34ns;
		enable <= '0';
		WAIT FOR 25ns;
		enable <= '1';
		
		--test direction
		WAIT FOR 34ns;
		direction <='0';
		WAIT FOR 41ns;
		reset<='0';
		WAIT FOR 2ns;
		reset <='1';
		
WAIT;                                                        
END PROCESS always;                                          
END g48_FSM_arch;
