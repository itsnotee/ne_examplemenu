NEMenu.CreateMenu('nemenu:Example', 'Example Menu', '~g~Example menu', 'ne_examplemenu', 'header')
NEMenu.CreateSubMenu('nemenu:ButtonSubMenu', 'nemenu:Example', '~g~Example sub menu')

local isMenuOpen = false

local _checked = false

local _comboBoxItems = { 'F', 'I', 'V', 'E', 'M' }
local _comboBoxIndex = 1

local _variantNotif = nil
local _variantTable = { 'F', 'I', 'V', 'E', 'M' }
local _variantIndex = 1

local _colorNotif = nil
local _colorTable = { 1, 2, 3 }
local _colorIndex = 1
local _colorsList = {
	{255,0,0},
	{0,255,0},
	{0,0,255}
}

local _inputText = nil

local _altSprite = false

AddEventHandler('nemenu:closeMenu', function(menu)
	if menu == 'nemenu:Example' then
		isMenuOpen = false
	end
end)

Citizen.CreateThread(function()
    NE.UI.KeysRegister('F4', 'example_menu', 'Open the example menu', function()
		isMenuOpen = true
		NEMenu.OpenMenu('nemenu:Example')

		while isMenuOpen do
			if NEMenu.Begin('nemenu:Example') then
				NEMenu.Separator('~b~Button')
				NEMenu.Button('Normale button')
				NEMenu.Button('Button with subText', '~g~subText')
				NEMenu.Button('Button with emoji subText', '👋')
				NEMenu.Button('Emoji button', nil, '👋')
				NEMenu.Button('Normale button center',  nil, nil, true)
	
				NEMenu.Separator()
				NEMenu.Separator('~b~MenuButton')
				NEMenu.MenuButton('Normale MenuButton', 'nemenu:ButtonSubMenu')
				NEMenu.MenuButton('MenuButton with subText', 'nemenu:ButtonSubMenu', '~g~subText')
				NEMenu.MenuButton('MenuButton with emoji subText', 'nemenu:ButtonSubMenu', nil, '👋')
				NEMenu.MenuButton('Normale MenuButton center', 'nemenu:ButtonSubMenu', nil, nil, true)
	
				NEMenu.Separator()
				NEMenu.Separator('~b~ExtraButton')
				if NEMenu.CheckBox('CheckBox', _checked) then
					_checked = not _checked
				end
	
				local _, comboBoxIndex = NEMenu.ComboBox('Combobox Button', nil, _comboBoxItems, _comboBoxIndex)
				if _comboBoxIndex ~= comboBoxIndex then
					_comboBoxIndex = comboBoxIndex
				end
	
				local pressed, inputText = NEMenu.InputButton('Input Button', 'Input text:', _inputText, 10, _inputText)
				if pressed then
					if inputText then
						_inputText = inputText
					end
				end
	
				if NEMenu.SpriteButton('Sprite Button', 'commonmenu', _altSprite and 'shop_gunclub_icon_b' or 'shop_garage_icon_b') then
					_altSprite = not _altSprite
				end
	
				NEMenu.Button('Button with Image')
				if NEMenu.IsItemHovered() then
					NEMenu.Image('ne_examplemenu', 'image')
				end
	
				NEMenu.Button('Button with ToolTip')
				if NEMenu.IsItemHovered() then
					NEMenu.ToolTip('This is ~r~ToolTip~s~.')
				end
	
				NEMenu.Button('Button with Description')
				if NEMenu.IsItemHovered() then
					NEMenu.Description('This is ~r~Description~s~.')
				end
	
				NEMenu.Button('Button with Variation')
				if NEMenu.IsItemHovered() then
					local pressed = NEMenu.Variation('Variante', _variantTable, _variantIndex, function(variant)
						if _variantIndex ~= variant then
							_variantIndex = variant
						end
					end) 
					
					if pressed then
						NE.UI.RemoveNotification(_variantNotif)
						NE.UI.ShowNotification(_variantTable[_variantIndex], function(notifId)
							_variantNotif = notifId
						end)
					end
				end
	
				NEMenu.Button('Button with Color Variation')
				if NEMenu.IsItemHovered() then
					local pressed = NEMenu.Color('Color', _colorTable, _colorIndex, _colorsList, function(color)
						if _colorIndex ~= color then
							_colorIndex = color
						end
					end)

					if pressed then
						NE.UI.RemoveNotification(_colorNotif)
						NE.UI.ShowNotification('R: '.._colorsList[_colorIndex][1]..' G: '.._colorsList[_colorIndex][2]..' B: '.._colorsList[_colorIndex][3], function(notifId)
							_colorNotif = notifId
						end)
					end
				end
				
				if NEMenu.Button('~r~Close Menu') then -- You don't need a button to close the menu if the menu is not open in "locked" mode. "Example: NEMenu.OpenMenu("nemenu:Example") or NEMenu.OpenMenu("nemenu:Example", true)"
					NEMenu.CloseMenu()
				end
				if NEMenu.IsItemHovered() then
					NEMenu.Description('Press ~b~ENTER~s~ to close the ~r~Example menu~s~.')
				end
	
				NEMenu.End() -- This function is required to operate your menu.
			elseif NEMenu.Begin('nemenu:ButtonSubMenu') then
				NEMenu.MenuButton('Go back', 'nemenu:Example', nil, '➡️')
	
				NEMenu.End() -- This function is required to operate your menu.
			end
	
			Citizen.Wait(0)
		end
	end)
end)
