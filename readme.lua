First proper and public drift script for FiveM! Use and share as you like.

Script works on simple principle - increasing and decreasing values in handling model in real time upon pressing left Shift.

Applies appropriately for AWD vehicles too.

How script recognizes if drift mode is on or off? By checking value "fInitialDragCoeff" - if it has been hugely increased (value over 80.0), then drift mode is on and vice versa.


Other values like "removeFromfTractionCurveMax" are being increased and decreased respectively. Since I was lazy to create proper config, go through the code and find them yourselves. It's simple code anyway.


Drift script works the best with semi-realistic handlings. If you have a shitty handling by default, drifting will be shitty as well, unless you will make changes in values yourself.

Also any engine upgrade will be respected, so you don't need to be worried about loosing any power after revoking drift script!

By default, the drift script is only allowed for road and personal vehicles. I really wasn't interested to see drifting busses, but if you will change the code, anything's possible, right?



Bugs:

Some vehicles can upon hitting drift settings got stuck on the spot and wheels will disappear. One of the value isn't converted as a solely number anymore. Look at the print in your client's console, to see something like 

0.512335abE

Solution:

Simply change car's default value in it's handling file by few units - 

instead of 

0.511112 

to 

0.511110

This will solve the problem with vehicle getting incorrect values.


We had a lot of fun with whole FiveM community and I am pleased to share this with all of you! Code is done entirely by me. Use and share as you like. If you want to make me happy, throw below in comments some videos featuring the script! :)

