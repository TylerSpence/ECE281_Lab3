ECE281_Lab3
===========

Spence's Lab3

#Schematic
The basic functionality and setup of the code provided is represented by the schematic below. 
![alt tag] (https://raw.github.com/TylerSpence/ECE281_Lab3/master/schematic.jpg)
#Moore and Mealy implementation
The below code is used to implement the moore and mealy machines to the nexys (only one can be used at a time, the other must be commented out).
The code behind the guts of the controllers are the same as in CE3.
```vhdl
Inst_MooreElevatorController: MooreElevatorController PORT MAP(
		clk => ClockBus_Sig(25),
		reset => btn(3),
		stop => switch(1),
		up_down => switch(0),
		floor => floor_sig1 (3 downto 0)
	);

	Inst_MealyElevatorController_Shell: MealyElevatorController_Shell PORT MAP(
		clk => ClockBus_Sig(25),
		reset => btn(3),
		stop => switch(1),
		up_down => switch(0),
		floor => floor_sig1(3 downto 0),
		nextfloor => floor_sig2(3 downto 0)
	);
```
#More Floors
To implement more floors, the logic within case floor state is fairly similar, just with more numbers, as represented bellow.
```vhdl
when floor7 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor5;	
					elsif (up_down='1' and stop='0') then 
						floor_state <= floor11;	
					else 
						floor_state <= floor7;	
					end if;
				when floor11 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor7;
					elsif (up_down='1' and stop='0') then 
						floor_state <= floor13;	
					else
						floor_state <= floor11;	
					end if;
```
To represent this on the output the following changes must be made so that the msb can be represented on the display. 
```vhdl
floor <= "0010" when (floor_state = floor2 ) else
			"0011" when (floor_state = floor3 ) else
			"0101" when (floor_state = floor5 ) else
			"0111" when (floor_state = floor7 ) else
			"0001" when (floor_state = floor11 ) else
			"0011" when (floor_state = floor13 ) else
			"0111" when (floor_state = floor17 ) else
			"1001" when (floor_state = floor19 ) else
			"0010";
digit <= "0000"when (floor_state = floor2 ) else
			"0000" when (floor_state = floor3 ) else
			"0000" when (floor_state = floor5 ) else
			"0000" when (floor_state = floor7 ) else
			"0001" when (floor_state = floor11 ) else
			"0001" when (floor_state = floor13 ) else
			"0001" when (floor_state = floor17 ) else
			"0001" when (floor_state = floor19 ) else
			"0000";
```
With this code used for the implementation
```vhdl
--clk => ClockBus_Sig(25),
	--	reset => btn(3),
	--	stop => switch(1),
	--	up_down => switch(0),
	--	floor => floor_sig1(3 downto 0),
	--	digit => floor_sig2(3 downto 0)
	--);
```
#Changed inputs
For the changed inputs, some more complex logic statements are needed to ensure that the elevator only moves one level at a time.

First, the input logic must be changed to
```vhdl
 input : in STD_LOGIC_VECTOR (3 downto 0);
```
Then, the state logic must be changed (the code below is just one of the floors
```
when floor1 =>	
					if (input = "0000") then floor_state <= floor0;
					elsif (input = "0001") then floor_state <= floor1;
					elsif (input = "0010") then floor_state <= floor2;
					elsif (input = "0011") then floor_state <= floor2;
					elsif (input = "0100") then floor_state <= floor2;
					elsif (input = "0101") then floor_state <= floor2;
					elsif (input = "0110") then floor_state <= floor2;
					elsif (input = "0111") then floor_state <= floor2;
					else floor_state <= floor1;
					end if;
```					
The instantiation is fairly logical
```
Inst_Change_inputs: Change_inputs PORT MAP(
		clk => ClockBus_Sig(25),
		reset => btn(3),
		input => switch (3 downto 0),
		floor => floor_sig1 (3 downto 0)
	);
```	
#Bad Code

#Good Code

#Notes
The only real debugging required was syntax, most of the other issues just arose from thinking about processes in the right way. Captain Silva checked off my basic funtionality in class and the two B funtionalities in his office. 
