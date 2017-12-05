library ieee;
use ieee.std_logic_1164.all;
--Alexander Torabi
--Abraham yesgat
--TestBench for controller
entity tb_game_controller is

end tb_game_controller;

architecture behaviour of tb_game_controller is

    Port (
        clk             : in std_logic; -- Clock for the system
        rst             : in std_logic; -- Resets the state machine

        -- Inputs
        shoot           : in std_logic; -- User shoot
        move_left       : in std_logic; -- User left
        move_right      : in std_logic; -- User right
		  
		  -- Outputs
       current_state_num: out std_logic_vector (2 downto 0)
         );
end component;

 	type state is ( init, pre_game, gameplay, game_over);
 	signal clk: std_logic :='0';
	signal rst: std_logic :='0';
	signal shoot: std_logic:='0';
	signal move_left:std_logic:='0';
	signal move_right:std_logic:='0';
	constant clk_period : time := 1 ns;
	signal current_state_num : std_logic_vector (2 downto 0);

	begin
	
	
	clk_process : process 
   begin
        clk <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;
	
	
		dut : game_controller
		port map(
		clk  =>clk,
		rst  =>rst,
		
		-- Inputs
		shoot  =>shoot,
		move_left  =>move_left,
		
		move_right =>move_right,


		-- Outputs
		current_state_num => current_state_num
		);


	--Test to see if are game works and in what states we are in
	-- 
	
	test_state:process
	begin
	wait for clk_period*3;
	--
	rst <= '1';
	wait for clk_period;
	assert current_state_num = "111" report "Error" severity Error;
	
	rst <= '0';

-- Check that we are in the ini state
	wait for clk_period;
	assert current_state_num = "000" report "Error" severity Error;

	
	shoot <= '1';
	wait for clk_period;
	assert current_state_num = "001" report "Error" severity Error;
  
  shoot<= '0';
  wait for clk_period;

	wait for 100000ms;
	assert current_state_num = "010" report "Error" severity Error;


	shoot <= '1';
	wait for clk_period;
	assert current_state_num = "111" report "Error" severity Error; 
	
	end process;
end behaviour;
