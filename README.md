# EstrasGui
-----------------------------\
------------------------------\
-------------------------------|
----------\
----------|
----------
----------/
-------------------------------|
-------------------------------| stras GUI
-------------------------------|
----------\
----------|
----------/
-------------------------------|
------------------------------/
-----------------------------/
#DOCUMENTATION
First Off, We need to get the module, to do that type: 

local module = require(script.EstrasGUI)

Next we need to make the main frame, or the menu, to do that type:

local frame = module.NewFrame("Example",UDim2.new(0,0,0),nil,"Default") --[1] = Gui Name, [2] = Position, [3] = Parent (nil = Player.PlayerGui), [4] = Theme

There are:
"Dark"
"Moon"
"Rise"
"Grim"
"Default" --None/Nil = Default

Time to get into text buttons, ints, and string inputs, but first we need to make a new tab

local tab = frame.NewTab("Example") --TabName

this tab will show up on the left side of the menu, and when clicked it will show all tabs that are stored in it, but to make tabs do:

local newDropdown = tab.NewDropdown("Example") --DropdownName

now its time for the ints, buttons, and strings, lets start with strings/inputs

local newText = newDropdown.NewString("NameOfInput","placeholder",int) --The int is the max amount of letters possible in the text

but how do we get the text in itv or how do we get when the text is changed you may ask?

to get when the text changes do

newText.Inputed:Connect(function(text) -- "Text" is the text in the box

end)

but what if we want to get the text now?

newText.GetText() returns the text thats currently in the box

but what if we want only numbers inputed
introducing newDropdown.NewInt()

local newInt = newDropdown.NewInt("NameOfInt",start_number,"Placeholder",{min_number,max_number})

it has the same functions as frame.newText

#now for bools, to make a bool value, simpoly type

local newBool = newDropdown.NewBool("BoolName")

bools have 2 returns

newBool.Changed:Connect(function(value) end) --Value will be either true or false

newBool.Current --Current Value For Bool

local newButton = newDropdown.NewButton("ButtonName")
newButton.Clicked

For starters though, a very helpful thing in this module is module.sortAcustom
it returns the owners name, game id, game name - all combined into one string, good for script/game hubs
you can do:
if module.sortAcustom == "whatever_the_one_you_saved_Was" then
--Code--

end
Thats it!
