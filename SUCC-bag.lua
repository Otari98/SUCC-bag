local _G = getfenv(0)

local weapon, armor, container, consumable, tradeGoods, projectile, QUIVER, recipe, reagent, miscellaneous =  GetAuctionItemClasses(1)
local BAG, SOUL_BAG, HERB_BAG, ENCHANTING_BAG = GetAuctionItemSubClasses(3)

local L = {
	['Sort button'] = 'Sort button',
	['Quality color above bag color'] = 'Quality color above bag color',
	['Ammo bag'] = 'Ammo bag',
	['Enchanting'] = 'Enchanting',
	['Herb bag'] = 'Herb bag',
	['Soul bag'] = 'Soul bag',
	['BG marks'] = 'BG marks',
	['Highlight'] = 'Highlight',
	['Quest item'] = 'Quest item',
	['Regular bag'] = 'Regular bag',
	['Backdrop'] = 'Backdrop',
	['Border'] = 'Border',
	['Item spacing'] = 'Item spacing',
	['Bank Columns'] = 'Bank Columns',
	['Bag Columns'] = 'Bag Columns',
	['SUCC-bag options'] = 'SUCC-bag options',
	['Right Click: Reverse order'] = 'Right Click: Reverse order',
	['Left Click: Sort'] = 'Left Click: Sort',
	['Left Click: Unlock this frame'] = 'Left Click: Unlock this frame',
	['Left Click: Lock this frame'] = 'Left Click: Lock this frame',
	['Right Click: Options'] = 'Right Click: Options',
	['Quest'] = 'Quest',
	['Mark of Honor'] = 'Mark of Honor',
}

if GetLocale() == 'zhCN' then
	-- L['Sort button'] = ''
	-- L['Quality color above bag color'] = ''
	-- L['Ammo bag'] = ''
	-- L['Enchanting'] = ''
	-- L['Herb bag'] = ''
	-- L['Soul bag'] = ''
	-- L['BG marks'] = ''
	-- L['Highlight'] = ''
	-- L['Quest item'] = ''
	-- L['Regular bag'] = ''
	-- L['Backdrop'] = ''
	-- L['Border'] = ''
	-- L['Item spacing'] = ''
	-- L['Bank Columns'] = ''
	-- L['Bag Columns'] = ''
	-- L['SUCC-bag options'] = ''
	-- L['Right Click: Reverse order'] = ''
	-- L['Left Click: Sort'] = ''
	-- L['Left Click: Unlock this frame'] = ''
	-- L['Left Click: Lock this frame'] = ''
	-- L['Right Click: Options'] = '',
	-- L['Quest'] = ''
	-- L['Mark of Honor'] = '',
elseif GetLocale() == 'deDE' then
	-- L['Sort button'] = ''
	-- L['Quality color above bag color'] = ''
	-- L['Ammo bag'] = ''
	-- L['Enchanting'] = ''
	-- L['Herb bag'] = ''
	-- L['Soul bag'] = ''
	-- L['BG marks'] = ''
	-- L['Highlight'] = ''
	-- L['Quest item'] = ''
	-- L['Regular bag'] = ''
	-- L['Backdrop'] = ''
	-- L['Border'] = ''
	-- L['Item spacing'] = ''
	-- L['Bank Columns'] = ''
	-- L['Bag Columns'] = ''
	-- L['SUCC-bag options'] = ''
	-- L['Right Click: Reverse order'] = ''
	-- L['Left Click: Sort'] = ''
	-- L['Left Click: Unlock this frame'] = ''
	-- L['Left Click: Lock this frame'] = ''
	-- L['Right Click: Options'] = '',
	-- L['Quest'] = ''
	-- L['Mark of Honor'] = '',
elseif GetLocale() == 'esES' then
	-- L['Sort button'] = ''
	-- L['Quality color above bag color'] = ''
	-- L['Ammo bag'] = ''
	-- L['Enchanting'] = ''
	-- L['Herb bag'] = ''
	-- L['Soul bag'] = ''
	-- L['BG marks'] = ''
	-- L['Highlight'] = ''
	-- L['Quest item'] = ''
	-- L['Regular bag'] = ''
	-- L['Backdrop'] = ''
	-- L['Border'] = ''
	-- L['Item spacing'] = ''
	-- L['Bank Columns'] = ''
	-- L['Bag Columns'] = ''
	-- L['SUCC-bag options'] = ''
	-- L['Right Click: Reverse order'] = ''
	-- L['Left Click: Sort'] = ''
	-- L['Left Click: Unlock this frame'] = ''
	-- L['Left Click: Lock this frame'] = ''
	-- L['Right Click: Options'] = '',
	-- L['Quest'] = ''
	-- L['Mark of Honor'] = '',
elseif GetLocale() == 'ptBR' then
	-- L['Sort button'] = ''
	-- L['Quality color above bag color'] = ''
	-- L['Ammo bag'] = ''
	-- L['Enchanting'] = ''
	-- L['Herb bag'] = ''
	-- L['Soul bag'] = ''
	-- L['BG marks'] = ''
	-- L['Highlight'] = ''
	-- L['Quest item'] = ''
	-- L['Regular bag'] = ''
	-- L['Backdrop'] = ''
	-- L['Border'] = ''
	-- L['Item spacing'] = ''
	-- L['Bank Columns'] = ''
	-- L['Bag Columns'] = ''
	-- L['SUCC-bag options'] = ''
	-- L['Right Click: Reverse order'] = ''
	-- L['Left Click: Sort'] = ''
	-- L['Left Click: Unlock this frame'] = ''
	-- L['Left Click: Lock this frame'] = ''
	-- L['Right Click: Options'] = '',
	-- L['Quest'] = ''
	-- L['Mark of Honor'] = '',
elseif GetLocale() == 'ruRU' then
	-- L['Sort button'] = ''
	-- L['Quality color above bag color'] = ''
	-- L['Ammo bag'] = ''
	-- L['Enchanting'] = ''
	-- L['Herb bag'] = ''
	-- L['Soul bag'] = ''
	-- L['BG marks'] = ''
	-- L['Highlight'] = ''
	-- L['Quest item'] = ''
	-- L['Regular bag'] = ''
	-- L['Backdrop'] = ''
	-- L['Border'] = ''
	-- L['Item spacing'] = ''
	-- L['Bank Columns'] = ''
	-- L['Bag Columns'] = ''
	-- L['SUCC-bag options'] = ''
	-- L['Right Click: Reverse order'] = ''
	-- L['Left Click: Sort'] = ''
	-- L['Left Click: Unlock this frame'] = ''
	-- L['Left Click: Lock this frame'] = ''
	-- L['Right Click: Options'] = '',
	-- L['Quest'] = ''
	-- L['Mark of Honor'] = '',
end

local function isSortingAddonLoaded()
	return SortBags ~= nil and SortBankBags ~= nil or Clean_Up ~= nil
end

local function sortItems(where, reversed)
	if SortBags ~= nil and SortBankBags ~= nil then
		local oldReversed = GetSortBagsRightToLeft()
		SetSortBagsRightToLeft(reversed)
		if where == 'bags' then
			SortBags()
		elseif where == 'bank' then
			SortBankBags()
		end
		SetSortBagsRightToLeft(oldReversed)
	elseif Clean_Up ~= nil then
		Clean_Up(where, reversed)
	end
end

local function SUCC_bagDefaults()
	SUCC_bagOptions = {}
	SUCC_bagOptions.colors = {}
	SUCC_bagOptions.colors.border = {1, 1, 1}
	SUCC_bagOptions.colors.backdrop = {0.3, 0.3, 0.3}
	SUCC_bagOptions.colors.highlight = {1, 0.2, 0.2}
	SUCC_bagOptions.colors.quest = {0.96, 0.64, 0.94, enabled = true}
	SUCC_bagOptions.colors.ammo = {0.8, 0.8, 0.3, enabled = true}
	SUCC_bagOptions.colors.BG = {0.98, 0.95, 0, enabled = true}
	SUCC_bagOptions.colors.bag = {}
	SUCC_bagOptions.colors.bag[BAG] = {0.3, 0.3, 0.3}
	SUCC_bagOptions.colors.bag[SOUL_BAG] = {0.678, 0.549, 1, enabled = true}
	SUCC_bagOptions.colors.bag[HERB_BAG] = {0.3, 0.8, 0.3, enabled = true}
	SUCC_bagOptions.colors.bag[ENCHANTING_BAG] = {0.5, 0.4, 0.8, enabled = true}
	SUCC_bagOptions.colors.override = false
	SUCC_bagOptions.layout = {}
	SUCC_bagOptions.layout.spacing = 4
	SUCC_bagOptions.layout.columns ={}
	SUCC_bagOptions.layout.columns.bag = 11
	SUCC_bagOptions.layout.columns.bank = 11
	SUCC_bagOptions.Clean_Up = 1
	SUCC_bagOptions.position = {}
	SUCC_bagOptions.position['SUCC_bag'] = {1000.0, 380.0, locked = false}
	SUCC_bagOptions.position['SUCC_bagBank'] = {640.0, 440.0, locked = false}
	SUCC_bagOptions.position['SUCC_bagKeyring'] = {760.0, 740.0, locked = false}
	return SUCC_bagOptions
end

-- debug
local print = print or function(mes)
	DEFAULT_CHAT_FRAME:AddMessage(mes)
end

local function	moneyToString(money)
	local coins = {}
	local wealth = GetMoney()
	local string = ''
	coins['|cFFFFFF00g|cFFFFFFFF '] = floor(money / (COPPER_PER_SILVER * SILVER_PER_GOLD))
	coins['|cFFAAAAAAs|cFFFFFFFF '] = floor((money - (coins['|cFFFFFF00g|cFFFFFFFF '] * COPPER_PER_SILVER * SILVER_PER_GOLD)) / COPPER_PER_SILVER)
	coins['|cFFEE9944c'] = mod(money, COPPER_PER_SILVER)
	for k, i in pairs(coins) do
		if i > 0 then
			if wealth < money then
				i = '|cFFFF0000' .. i
			end
			string = string .. i .. k
		end
	end
	return string
end

local function FrameTrimToSize(frame)
	local frameName = frame:GetName()
	local slot, height, width
	if not frame.size or frame.size == 0 then
		height = 64
		width = 256
	else
		local slot = frame.size + 1
		local button = _G[frameName .. 'Item'.. slot]
		while button do
			button:Hide()
			slot = slot + 1
			button = _G[frameName .. 'Item'.. slot]
		end
		if frame.size < frame.cols then
			width = (37 + frame.space) * frame.size + 14 - frame.space
		else
			width = (37 + frame.space) * frame.cols + 14 - frame.space
		end
		height = (37 + frame.space) * math.ceil(frame.size / frame.cols)  + 32 - frame.space
	end
	frame:SetWidth(width)
	frame:SetHeight(height)
end

local function TitleLayout(frame)
	if not frame.slotFrame then return end
	if frame.cuBag and SUCC_bagOptions.Clean_Up == 1 then
		frame.title:ClearAllPoints()
		frame.title:SetPoint('LEFT', frame.cuBag, 'RIGHT', 3, 0)
		frame.cuBag:SetPoint('LEFT', frame.lockButton, 'RIGHT', 3, 0)
		if not frame.cuBag:IsVisible() then frame.cuBag:Show() end
	else
		if frame.cuBag then frame.cuBag:Hide() end
		frame.title:ClearAllPoints()
		frame.title:SetPoint('LEFT', frame.lockButton, 'RIGHT', 3, 0)
	end
end

local function SlotFrameSetup(frame)
	frame.slotFrame:SetFrameLevel(0)
	frame.slotFrame:SetPoint('TOPRIGHT', frame, 'TOPLEFT', 8, -16)
	frame.slotFrame:SetBackdrop({
		bgFile = 'Interface\\AddOns\\SUCC-bag\\Textures\\marble',
		edgeFile = 'Interface\\AddOns\\SUCC-bag\\Textures\\BagSlotFrame',
		tile = true,
		tileSize = 128,
		edgeSize = 32,
		insets = {
			left = 5,
			right = 0,
			top = 5,
			bottom = 5
		}
	})
	frame.slotFrame:SetBackdropBorderColor(unpack(SUCC_bagOptions.colors.border))
	frame.slotFrame:SetBackdropColor(unpack(SUCC_bagOptions.colors.backdrop))
	frame.slotFrame:Hide()
end

local function FrameLayout(frame, cols)
	if not frame.size then return end
	local frameName = frame:GetName()
	if not cols then
		cols = frame.cols or SUCC_bagOptions.layout.columns.bag or 8
	end
	frame.cols = cols
	local space = SUCC_bagOptions.layout.spacing or 4
	frame.space = space
	local rows = math.ceil(frame.size / cols)
	local button = _G[frameName .. 'Item1']
	if button then
		local index = 1
		button:ClearAllPoints()
		button:SetPoint('TOPLEFT', frame, 9, -25)
		for i = 1, rows, 1 do
			for j = 1, cols, 1 do
				index = index + 1
				button = _G[frameName .. 'Item' .. index]
				if not button then break end
				button:ClearAllPoints()
				button:SetPoint('LEFT', frameName .. 'Item' .. index - 1, 'RIGHT', space, 0)
			end
			button = _G[frameName .. 'Item' .. index]
			if not button then break end
			button:ClearAllPoints()
			button:SetPoint('TOP', frameName .. 'Item' .. index - cols, 'BOTTOM', 0, -space)
		end
	end
	if frame.slotFrame then
		local totalslots = table.getn(frame.slotFrame.slot)
		local bagcols, slot = math.ceil(totalslots / rows), 2
		frame.slotFrame.slot[1]:ClearAllPoints()
		frame.slotFrame.slot[1]:SetPoint('TOPLEFT', frame.slotFrame, 7, -9)
		frame.slotFrame:SetWidth((37 + SUCC_bagOptions.layout.spacing) * bagcols + 14 - SUCC_bagOptions.layout.spacing)
		for i = 1, rows, 1 do
			if bagcols > 1 then
				for j = 2, bagcols, 1 do
					if not frame.slotFrame.slot[slot] then break end
					frame.slotFrame.slot[slot]:ClearAllPoints()
					frame.slotFrame.slot[slot]:SetPoint('LEFT', frame.slotFrame.slot[slot - 1], 'RIGHT', space, 0)
					slot = slot + 1
				end
			end
			if not frame.slotFrame.slot[slot] then
				frame.slotFrame:SetHeight((37 + SUCC_bagOptions.layout.spacing) * i  + 14 - SUCC_bagOptions.layout.spacing)
				break
			end
			frame.slotFrame.slot[slot]:ClearAllPoints()
			frame.slotFrame.slot[slot]:SetPoint('TOP', frame.slotFrame.slot[slot - bagcols], 'BOTTOM', 0, -space)
			slot = slot + 1
		end
	end
	FrameTrimToSize(frame)
end

local function GetBagColorInfo(bagID)
	if bagID > 0 then
		local link = GetInventoryItemLink('player', ContainerIDToInventoryID(bagID))
		if link then
			local _, _, id = string.find(link, 'item:(%d+)')
			local _, _, _, _, itemType, subType = GetItemInfo(id)
			if itemType == QUIVER then
				return SUCC_bagOptions.colors.ammo
			else
				return SUCC_bagOptions.colors.bag[subType], subType == BAG
			end
		end
	end
	return SUCC_bagOptions.colors.bag[BAG], true
end

local function ItemUpdateBorder(button, option)
	if option then
		button:GetNormalTexture():SetVertexColor(unpack(SUCC_bagOptions.colors.highlight))
	elseif not button:GetParent().colorLocked then
		local bagID = button:GetParent():GetID()
		local bagColorInfo, isRegularBag = GetBagColorInfo(bagID)
		if isRegularBag or SUCC_bagOptions.colors.override or not bagColorInfo.enabled then
			local link = GetContainerItemLink(bagID, button:GetID())
			if link then
				local _, _, id = string.find(link, 'item:(%d+)')
				local n, _, q, _, _, t = GetItemInfo(id)
				if n ~= nil and string.find(n, L['Mark of Honor']) and SUCC_bagOptions.colors.BG.enabled then
					button:GetNormalTexture():SetVertexColor(unpack(SUCC_bagOptions.colors.BG))
					return
				elseif t == L['Quest'] and SUCC_bagOptions.colors.quest.enabled then
					button:GetNormalTexture():SetVertexColor(unpack(SUCC_bagOptions.colors.quest))
					return
				elseif q ~= nil and q > 1 then
					button:GetNormalTexture():SetVertexColor(GetItemQualityColor(q))
					return
				end
			end
		end
		if bagColorInfo.enabled == nil or bagColorInfo.enabled then
			button:GetNormalTexture():SetVertexColor(unpack(bagColorInfo))
		else
			button:GetNormalTexture():SetVertexColor(unpack(SUCC_bagOptions.colors.bag[BAG]))
		end
	end
end

local function HighlightBagSlots(bagID, option)
	local frame = _G['SUCC_bagDummyBag' .. bagID]
	if frame then
		local items = {frame:GetChildren()}
		if option then frame.colorLocked = 1 else  frame.colorLocked = nil end
		for _, item in pairs(items) do
			ItemUpdateBorder(item, option)
		end
	end
end

local function ItemUpdate(item)
	local texture, itemCount, readable, locked
	texture, itemCount, locked, _, readable = GetContainerItemInfo(item:GetParent():GetID(), item:GetID())
	ItemUpdateBorder(item)
	if texture then
		ContainerFrame_UpdateCooldown(item:GetParent():GetID() , item)
		item.hasItem = 1
	else
		_G[item:GetName() .. 'Cooldown']:Hide()
		item.hasItem = nil
	end
	SetItemButtonDesaturated(item, locked, 0.5, 0.5, 0.5)
	SetItemButtonTexture( item, texture )
	SetItemButtonCount( item, itemCount )
	local showSell = nil
	if GameTooltip:IsOwned(item) then
		if texture then
			local hasCooldown, repairCost = GameTooltip:SetBagItem(item:GetParent():GetID(),item:GetID())
			if InRepairMode() and (repairCost > 0) then
				GameTooltip:AddLine(REPAIR_COST, 1, 1, 1)
				SetTooltipMoney(GameTooltip, repairCost)
				GameTooltip:Show()
			elseif MerchantFrame:IsShown() and not locked then
				showSell = 1
			end
		else
			GameTooltip:Hide()
		end
		if showSell then
			ShowContainerSellCursor(item:GetParent():GetID(), item:GetID())
		elseif readable then
			ShowInspectCursor()
		else
			ResetCursor()
		end
	end
end

local function ItemCreate(name, parent)
	local button
	if parent:GetID() == -1 then
		button = CreateFrame('Button', name, parent, 'BankItemButtonGenericTemplate')
		CreateFrame('Model', name .. 'Cooldown', button, 'CooldownFrameTemplate')
	else
		button = CreateFrame('Button', name, parent, 'ContainerFrameItemButtonTemplate')
	end
	button:SetNormalTexture('Interface\\AddOns\\SUCC-bag\\Textures\\Slot')
	button.bg = button:CreateTexture(nil, 'BACKGROUND')
	button.bg:SetTexture[[Interface\PaperDoll\UI-Backpack-EmptySlot]]
	button.bg:SetAlpha(.75)
	button.bg:SetAllPoints()
	button:SetAlpha(parent:GetParent():GetAlpha())
	return button
end

local dummyBag = {}

local function CreateDummyBag(parent, bagID)
	local dummyBag = CreateFrame('Frame', 'SUCC_bagDummyBag' .. bagID, parent)
	dummyBag:SetID(bagID)
	return dummyBag
end

local function AddBag(frame, bagID)
	if not dummyBag[bagID] then
		dummyBag[bagID] = CreateDummyBag(frame, bagID)
	end
	if dummyBag.removed == bagID then dummyBag.removed = nil return end
	local frameName = frame:GetName()
	local slot = frame.size
	local bagSize
	if bagID == KEYRING_CONTAINER then
		bagSize = GetKeyRingSize()
	else
		bagSize = GetContainerNumSlots(bagID)
	end
	dummyBag[bagID].size = bagSize
	for index = 1, bagSize, 1 do
		slot = slot + 1
		local item = _G[frameName .. 'Item'.. slot] or ItemCreate(frameName .. 'Item'.. slot, dummyBag[bagID])
		item:SetID(index)
		item:SetParent(dummyBag[bagID])
		item:Show()
		ItemUpdate(item)
	end
	frame.size = frame.size + bagSize
end

local function FrameGenerate(frame)
	frame.size = 0
	local frameName = frame:GetName()
	if frame.moneyFrame then
		MoneyFrame_Update(frameName .. 'MoneyFrame', GetMoney())
	end
	for _, bagID in pairs(frame.bags) do
		AddBag(frame, bagID)
	end
	FrameLayout(frame)
	frame:Show()
end

local function RemoveBag(frame, bagID, bagSize)
	if dummyBag[bagID] and dummyBag[bagID].size ~= bagSize then
		FrameGenerate(frame)
		return 1
	else
		return nil
	end
end

local function FrameUpdate(frame, bagID)
	local frameName = frame:GetName()
	local startSlot = 1
	local endSlot
	if not bagID then
		endSlot = frame.size
	else
		if bagID == KEYRING_CONTAINER then
			endSlot = GetKeyRingSize()
			frameName = SUCC_bag.keyring:GetName()
		else
			if not frame.size --[[or RemoveBag(frame, bagID, GetContainerNumSlots(bagID))]] then return end
			for _, bag in pairs(frame.bags) do
				if bag == bagID then
					endSlot = startSlot + GetContainerNumSlots(bag) - 1
					break
				else
					startSlot = startSlot + GetContainerNumSlots(bag)
				end
			end
		end
	end
	for slot = startSlot, endSlot do
		local item = _G[frameName .. 'Item' .. slot]
		if item then
			ItemUpdate(item)
		end
	end
end

local function FrameUpdateLock(frame)
	if not frame.size then return end
	local frameName = frame:GetName()
	for slot = 1, frame.size do
		local item = _G[frameName .. 'Item' .. slot]
		local _, _, locked = GetContainerItemInfo(item:GetParent():GetID(), item:GetID())
		SetItemButtonDesaturated(item, locked, 0.5, 0.5, 0.5)
	end
end

local function SUCC_search()
	local search = CreateFrame('Frame', nil, SUCC_bag)
	search:SetPoint('TOPLEFT', SUCC_bag, 'BOTTOMLEFT', 4, 4)
	search:SetHeight(29)
	search:SetWidth(115) -- 132
	search:SetBackdrop({
		bgFile = 'Interface\\AddOns\\SUCC-bag\\Textures\\marble',
		edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
		tile = true, tileSize = 8, edgeSize = 16,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	search:SetBackdropBorderColor(.5,.5,.5,1)
	search:SetBackdropColor(unpack(SUCC_bagOptions.colors.backdrop))

	search.text = search:CreateFontString(nil, 'HIGH', 'GameTooltipTextSmall')
	local font, size = search.text:GetFont()
	
	search.edit = CreateFrame('EditBox', nil, search, 'InputBoxTemplate')
	search.edit:SetMaxLetters(14)	
	search.edit:SetPoint('LEFT', search, 'LEFT', 10, 0)
	search.edit:SetHeight(20)
	search.edit:SetWidth(100)
	search.edit:SetFont(font, size, 'OUTLINE')
	search.edit:SetAutoFocus(false)
	search.edit:SetText(SEARCH)
	search.edit:SetTextColor(1,1,1,1)

	search.button = CreateFrame('Button', nil, search.edit)
	search.button:SetFrameStrata('LOW')	
	search.button:SetWidth(25)
	search.button:SetHeight(25)
	search.button:SetPoint('LEFT', search.edit, 'RIGHT', 0, 0)
	search.button:SetBackdrop({
		bgFile = 'Interface\\AddOns\\SUCC-bag\\Textures\\marble',
		edgeFile = 'Interface\\Tooltips\\UI-Tooltip-Border',
		tile = true, tileSize = 8, edgeSize = 16,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	search.button:SetBackdropBorderColor(.5,.5,.5,1)
	search.button:SetBackdropColor(unpack(SUCC_bagOptions.colors.backdrop))
	search.button:EnableMouse(true) 
	search.button:Hide()
	
	search.icon = search.edit:CreateTexture(nil, 'OVERLAY')
	search.icon:SetPoint('CENTER', search.button, 'CENTER', 1, 0)
	search.icon:SetWidth(27)
	search.icon:SetHeight(27)
	search.icon:SetTexture('Interface\\Buttons\\UI-Panel-MinimizeButton-Disabled')
	search.icon:Hide()

	local function buttons(frame, a)
		if not frame:IsShown() then return end
		local name = frame:GetName()
		for slot=1, frame.size do
			_G[name..'Item'..slot]:SetAlpha(a)
		end
	end

	local function searchBag(frame)
		if not frame:IsShown() then return end
		local name = frame:GetName()
		for slot = 1, frame.size do
			local item = _G[name..'Item'..slot]
			local _, itemCount = GetContainerItemInfo(item:GetParent():GetID(), item:GetID())
			if itemCount then
				local itemLink = GetContainerItemLink(item:GetParent():GetID(), item:GetID())
				local itemstring = string.sub(itemLink, string.find(itemLink, "%[")+1, string.find(itemLink, "%]")-1)
				if strfind(strlower(itemstring), strlower(string.gsub(this:GetText(), "([^%w])", "%%%1"))) then
					item:SetAlpha(1)
				end
			end
		end
	end

	local function reset()        
		search.edit:SetText(SEARCH)
		buttons(SUCC_bag, 1)
		buttons(SUCC_bag.bank, 1)
		buttons(SUCC_bag.keyring, 1)
		search.button:Hide()
		search.icon:Hide()
        search.edit:UnregisterEvent('BAG_UPDATE')
	end

	search.edit:SetScript('OnEditFocusGained', function()
		search.edit:SetText('')
        search.edit:RegisterEvent('BAG_UPDATE')
	end)

	search.edit:SetScript('OnEditFocusLost', function()
		reset()			
	end)

	search.edit:SetScript('OnTabPressed', function()
		search.edit:ClearFocus()
		reset()
	end)

	search.button:SetScript('OnClick', function()
		search.edit:ClearFocus()
		reset()
	end)	

	search.edit:SetScript('OnTextChanged', function()
		if this:GetText() == SEARCH then return end
		buttons(SUCC_bag, .25)
		buttons(SUCC_bag.bank, .25)
		buttons(SUCC_bag.keyring, .25)

		searchBag(SUCC_bag)
		searchBag(SUCC_bag.bank)
		searchBag(SUCC_bag.keyring)

		if not search.button:IsVisible() then
			search.button:Show()
			search.icon:Show()
		end
	end)

    search.edit:SetScript('OnEvent', function()
        if this:GetText() == SEARCH then return end
		buttons(SUCC_bag, .25)
		buttons(SUCC_bag.bank, .25)
		buttons(SUCC_bag.keyring, .25)

		searchBag(SUCC_bag)
		searchBag(SUCC_bag.bank)
		searchBag(SUCC_bag.keyring)

		if not search.button:IsVisible() then
			search.button:Show()
			search.icon:Show()
		end
    end)
end

local function Essentials(frame)
	local t = frame:GetName()
	if not SUCC_bagOptions.position then
		SUCC_bagOptions.position = {}
	end
	if not SUCC_bagOptions.position[t] then
		SUCC_bagOptions.position[t] = {frame:GetCenter()}
	end
	frame:SetScript('OnMouseDown', function()
		if not SUCC_bagOptions.position[t].locked then
			this:StartMoving()
		end
	end)
	frame:SetScript('OnMouseUp', function()
		if not SUCC_bagOptions.position[t].locked then
			this:StopMovingOrSizing()
			SUCC_bagOptions.position[t] = {frame:GetCenter()}
		end
	end)
	frame:SetToplevel()
	frame:EnableMouse()
	frame:SetMovable()
	frame:SetUserPlaced(true)
	frame:SetClampedToScreen()
	frame:SetPoint('CENTER', UIParent, 'BOTTOMLEFT', unpack(SUCC_bagOptions.position[t] or {frame:GetCenter()}))
	frame:SetBackdrop({
		bgFile = 'Interface\\AddOns\\SUCC-bag\\Textures\\marble',
		edgeFile = 'Interface\\AddOns\\SUCC-bag\\Textures\\BagFrame',
		tile = true,
		tileSize = 128,
		edgeSize = 32,
		insets = {
			left = 5,
			right = 5,
			top = 22,
			bottom = 5
		},
	})
	frame:SetBackdropBorderColor(unpack(SUCC_bagOptions.colors.border))
	frame:SetBackdropColor(unpack(SUCC_bagOptions.colors.backdrop))
	frame:Hide()
	tinsert(UISpecialFrames, t)
	frame.closeButton = CreateFrame('Button', t .. 'CloseButton', frame, 'UIPanelCloseButton')
	frame.closeButton:SetPoint('TOPRIGHT', frame, 4, 4)
	frame.closeButton:SetScript('OnClick', function() SBFrameClose(frame) end)
	frame.title = frame:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	frame.title:SetPoint('TOPLEFT', frame, 11, -6)
	frame.title.t = string.sub(t, 9, -1)
	frame.title:SetText(frame.title.t ~= '' and frame.title.t ~= nil and frame.title.t or BAG)
	if frame.slotFrame then
		SlotFrameSetup(frame)
		frame.toggleButton = CreateFrame('Button', t .. 'ToggleButton', frame)
		frame.toggleButton:SetHeight(12)
		frame.toggleButton:SetWidth(12)
		frame.toggleButton:SetPoint('TOPLEFT', 10, -6)
		frame.toggleButton:SetNormalTexture('Interface\\QuestFrame\\UI-Quest-BulletPoint')
		frame.toggleButton:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
		frame.toggleButton:SetPushedTexture('Interface\\QuestFrame\\UI-Quest-BulletPoint')
		frame.toggleButton:GetNormalTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
		frame.toggleButton:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		frame.toggleButton:SetScript('OnClick', function()
			local slotFrame = frame.slotFrame
			if arg1 == 'RightButton' then
				ToggleKeyRing()
			else
				PlaySound('igMainMenuOption')
				if slotFrame:IsVisible() then
					slotFrame:Hide()
				else
					slotFrame:Show()
				end
			end
		end)
		frame.toggleButton:SetScript('OnEnter', function()
			GameTooltip:SetOwner(this, 'ANCHOR_LEFT')
			GameTooltip:AddLine('Left Click: Open bags', 1, 1, 1)
			GameTooltip:AddLine('Right Click: Open keyring' , 0.3, 0.8, 1)
			GameTooltip:Show()
		end)
		frame.toggleButton:SetScript('OnLeave', function() GameTooltip:Hide() end)

		frame.lockButton = CreateFrame('Button', t .. 'LockButton', frame)
		frame.lockButton:SetHeight(12)
		frame.lockButton:SetWidth(12)
		frame.lockButton:SetPoint('LEFT', frame.toggleButton, 'RIGHT', 3, 0)
		frame.lockButton:SetNormalTexture('Interface\\QuestFrame\\UI-Quest-BulletPoint')
		frame.lockButton:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
		frame.lockButton:SetPushedTexture('Interface\\QuestFrame\\UI-Quest-BulletPoint')
		frame.lockButton:GetNormalTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
		frame.lockButton:GetNormalTexture():SetVertexColor(1, 0.8, 0.5)
		frame.lockButton:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
		frame.lockButton:SetScript('OnShow', function()
			if SUCC_bagOptions.position[t].locked then
				frame.lockButton:GetNormalTexture():SetVertexColor(1, 0.8, 0.5, 1)
			else
				frame.lockButton:GetNormalTexture():SetVertexColor(1, 0.8, 0.5, 0.5)
			end
		end)
		frame.lockButton:SetScript('OnEnter', function()
			GameTooltip:SetOwner(this, 'ANCHOR_LEFT')
			if SUCC_bagOptions.position[t].locked then
				GameTooltip:AddLine(L['Left Click: Unlock this frame'], 1, 1, 1)
			else
				GameTooltip:AddLine(L['Left Click: Lock this frame'], 1, 1, 1)
			end
			GameTooltip:AddLine(L['Right Click: Options'], 0.3, 0.8, 1)
			GameTooltip:Show()
		end)
		frame.lockButton:SetScript('OnLeave', function() GameTooltip:Hide() end)
		frame.lockButton:SetScript('OnClick', function()
			if arg1 == 'RightButton' then
				SlashCmdList['SUCC_BAG']()
			else
				SUCC_bagOptions.position[t].locked = not SUCC_bagOptions.position[t].locked
				this:GetScript('OnShow')()
				this:GetScript('OnEnter')()
				PlaySound('igMainMenuOption')
			end
		end)

		if isSortingAddonLoaded() then
			frame.cuBag = CreateFrame('Button', t .. 'CU_button', frame)
			frame.cuBag:SetHeight(12)
			frame.cuBag:SetWidth(12)
			frame.cuBag:SetNormalTexture('Interface\\QuestFrame\\UI-Quest-BulletPoint')
			frame.cuBag:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
			frame.cuBag:SetPushedTexture('Interface\\QuestFrame\\UI-Quest-BulletPoint')
			frame.cuBag:GetNormalTexture():SetVertexColor(0.1, 1, 0.3)
			frame.cuBag:GetNormalTexture():SetTexCoord(0.25, 0.75, 0.25, 0.75)
			frame.cuBag:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
			frame.cuBag:SetScript('OnClick', function()
				local c = frame.title.t ~= '' and frame.title.t ~= nil and string.lower(frame.title.t) or 'bags'
				sortItems(c, arg1 == 'RightButton')
			end)
			frame.cuBag:SetScript('OnEnter', function()
				GameTooltip:SetOwner(this, 'ANCHOR_LEFT')
				GameTooltip:AddLine(L['Left Click: Sort'], 1, 1, 1)
				GameTooltip:AddLine(L['Right Click: Reverse order'], 0.3, 0.8, 1)
				GameTooltip:Show()
			end)
			frame.cuBag:SetScript('OnLeave', function() GameTooltip:Hide() end)
		end
		frame.slotFrame:SetScript('OnHide', function() frame.toggleButton:GetNormalTexture():SetVertexColor(1, 1, 1) end)
		frame.slotFrame:SetScript('OnShow', function() frame.toggleButton:GetNormalTexture():SetVertexColor(1, 0, 0) end)
		TitleLayout(frame)
		frame.moneyFrame = CreateFrame('Frame', t .. 'MoneyFrame', frame, 'SmallMoneyFrameTemplate')
		frame.moneyFrame:SetPoint('RIGHT', frame.closeButton, 'LEFT', 12, 0)
	end
end

local function BankUpdateBagSlotStatus()
	local slots, full = GetNumBankSlots()
	for i=1, NUM_BANKBAGSLOTS, 1 do
		local button = _G['SUCC_bagBBag'..i]
		local tooltipText
		if button then
			if i <= slots then
				SetItemButtonTextureVertexColor(button, 1.0,1.0,1.0)
				button.tooltipText = BANK_BAG
				button:SetScript('OnClick', function()
					if not CursorHasItem() then
						if IsShiftKeyDown() then
							PickupBagFromSlot(this:GetInventorySlot())
							this:SetChecked(not this:GetChecked())	-- slot name issue
						else
							if not this:GetChecked() then
								HighlightBagSlots(this:GetID())
							else
								HighlightBagSlots(this:GetID(), 'highlight')
							end
							PlaySound('igMainMenuOptionFaerTab')
						end
					else
						this:SetChecked(not this:GetChecked())
						PutItemInBag(this:GetInventorySlot())
					end
				end)
			else
				SetItemButtonTextureVertexColor(button, 1.0,0.1,0.1)
				local cost = GetBankSlotCost(slots)
				SUCC_bag.bank.nextSlotCost = cost
				button.tooltipText = BANK_BAG_PURCHASE
				button:SetScript('OnClick', function()
					this:SetChecked(not this:GetChecked())	-- slot name issue
					PlaySound('igMainMenuOption')
					StaticPopup_Show('CONFIRM_BUY_SUCCBANK_SLOT')
				end)
			end
		end
	end
end

local function PrepareBank(frame)
	if frame.bank then return frame.bank end
	frame.bank = CreateFrame('Frame', 'SUCC_bagBank', UIParent)
	-- frame.bank:SetPoint('TOPLEFT', 53, -116)
	frame.bank.bags = {-1, 5, 6, 7, 8, 9, 10}
	frame.bank.cols = SUCC_bagOptions.layout.columns.bank or 8
	frame.bank.slotFrame = CreateFrame('Frame', 'SUCC_bagBankSlotFrame', frame.bank)
	frame.bank.slotFrame.slot = {}
	for i = 1, NUM_BANKBAGSLOTS, 1 do
		frame.bank.slotFrame.slot[i] = CreateFrame('CheckButton', 'SUCC_bagBBag' .. i, frame.bank.slotFrame, 'BankItemButtonBagTemplate')
		frame.bank.slotFrame.slot[i]:SetID(i + 4)
		frame.bank.slotFrame.slot[i]:SetNormalTexture('Interface\\AddOns\\SUCC-bag\\Textures\\Slot')
		frame.bank.slotFrame.slot[i]:SetCheckedTexture('Interface\\Buttons\\CheckButtonHilight')
		frame.bank.slotFrame.slot[i]:SetScript('OnReceiveDrag', function()
			PutItemInBag(this:GetInventorySlot())
		end)
		frame.bank.slotFrame.slot[i]:SetScript('OnEnter', function()
			HighlightBagSlots(this:GetID(), 'highlight')
			GameTooltip:SetOwner(this, 'ANCHOR_RIGHT')
			if not GameTooltip:SetInventoryItem('player', this:GetInventorySlot()) then
				GameTooltip:SetText(this.tooltipText)
				local cost = GetBankSlotCost(GetNumBankSlots())
				SetTooltipMoney(GameTooltip, cost)
				if GetMoney() >= cost then
					SetMoneyFrameColor('GameTooltipMoneyFrame', 1, 1, 1)
				else
					SetMoneyFrameColor('GameTooltipMoneyFrame', 1, 0.1, 0.1)
				end
				GameTooltip:Show()
			end
			CursorUpdate()
		end)
		frame.bank.slotFrame.slot[i]:SetScript('OnLeave', function()
			if not this:GetChecked() then
				HighlightBagSlots(this:GetID())
			end
			GameTooltip:Hide()
			SetMoneyFrameColor('GameTooltipMoneyFrame', 1, 1, 1)
			ResetCursor()
		end)
	end
	StaticPopupDialogs['CONFIRM_BUY_SUCCBANK_SLOT'] = {
		text = CONFIRM_BUY_BANK_SLOT,
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PurchaseSlot()
		end,
		OnShow = function()
			MoneyFrame_Update(this:GetName()..'MoneyFrame', frame.bank.nextSlotCost)
		end,
		hasMoneyFrame = 1,
		timeout = 0,
		hideOnEscape = 1,
	}
	Essentials(frame.bank)
	frame.bank:SetScript('OnHide', function()
        for slot=1, SUCC_bag.bank.size do
            _G[SUCC_bag.bank:GetName()..'Item'..slot]:SetAlpha(1)
        end
		CloseBankFrame()
		PlaySound('igMainMenuClose')
	end)
	return frame.bank
end

local function OnEvent()
	if event == 'BAG_UPDATE' or event == 'BAG_UPDATE_COOLDOWN' then
		if dummyBag[arg1] then
			FrameUpdate(dummyBag[arg1]:GetParent(), arg1)
		end
	elseif event == 'BAG_CLOSED' then
		if dummyBag[arg1] then
			dummyBag.removed = arg1
			dummyBag[arg1].size = 0
			local parent = dummyBag[arg1]:GetParent()
			if parent:IsVisible() then
				FrameGenerate(parent)
			end
		end
	elseif event == 'ITEM_LOCK_CHANGED' then
		if this:IsVisible() then
			FrameUpdateLock(this)
		end
	elseif event == 'BANKFRAME_OPENED' then
		this:RegisterEvent('PLAYERBANKSLOTS_CHANGED')
		this:RegisterEvent('PLAYER_MONEY')
		SBFrameOpen(this, 1)
		SBFrameOpen(this.bank)
		PlaySound('igMainMenuOpen')
		BankUpdateBagSlotStatus()
	elseif event == 'BANKFRAME_CLOSED' then
		this:UnregisterEvent('PLAYERBANKSLOTS_CHANGED')
		this:UnregisterEvent('PLAYER_MONEY')
		SBFrameClose(this, 1)
		SBFrameClose(SUCC_bag.bank)
	elseif event == 'PLAYERBANKSLOTS_CHANGED' then
		FrameUpdate(SUCC_bag.bank, -1)
	elseif event == 'PLAYER_MONEY' or event == 'PLAYERBANKBAGSLOTS_CHANGED' then
		BankUpdateBagSlotStatus()
	elseif event == 'ADDON_LOADED' and arg1 == 'SUCC-bag' then
		SUCC_bagOptions = SUCC_bagOptions or SUCC_bagDefaults()
		if SUCC_bagOptions.colors.bag[BAG].enabled == nil then
			SUCC_bagOptions.colors.quest.enabled = true
			SUCC_bagOptions.colors.ammo.enabled = true
			SUCC_bagOptions.colors.BG.enabled = true
			SUCC_bagOptions.colors.bag[BAG].enabled = true
			SUCC_bagOptions.colors.bag[SOUL_BAG].enabled = true
			SUCC_bagOptions.colors.bag[HERB_BAG].enabled = true
			SUCC_bagOptions.colors.bag[ENCHANTING_BAG].enabled = true
		end
		this:UnregisterEvent('ADDON_LOADED')
		BankFrame:UnregisterEvent('BANKFRAME_OPENED')
		this:RegisterEvent('BAG_CLOSED')
		this:RegisterEvent('BAG_UPDATE')
		this:RegisterEvent('ITEM_LOCK_CHANGED')
		this:RegisterEvent('BAG_UPDATE_COOLDOWN')
		this:RegisterEvent('CURSOR_UPDATE')
		this:RegisterEvent('BANKFRAME_OPENED')
		this:RegisterEvent('BANKFRAME_CLOSED')
		-- this:RegisterEvent('PLAYER_ENTERING_WORLD')
		this.bags = {0, 1, 2, 3, 4}
		Essentials(this)
		Essentials(this.keyring)
		PrepareBank(this)
		ToggleBag = function() SBFrameToggle(SUCC_bag) end
		ToggleBackpack = ToggleBag
		OpenAllBags = ToggleBag
		OpenBag = function() SBFrameOpen(SUCC_bag) end
		OpenBackpack = OpenBag
		CloseBag = function() SBFrameClose(SUCC_bag) end
		CloseBackpack = CloseBag
		CloseAllBags = function() SBFrameClose(SUCC_bag) end
		ToggleKeyRing = function() SBFrameToggle(SUCC_bag.keyring) end
		SUCC_search()
		-- configuration
		SLASH_SUCC_BAG1 = '/succbag'
		print('|cFFF6A3EFSUCC-bag loaded. /succbag - configuration')
	-- elseif event == 'PLAYER_ENTERING_WORLD' then
	-- 	SBFrameClose(SUCC_bag.bank)
	end
end

SUCC_bag = CreateFrame('Frame', 'SUCC_bag', UIParent)
-- SUCC_bag:SetPoint('BOTTOMRIGHT', UIParent, -55, 55)
SUCC_bag:RegisterEvent('ADDON_LOADED')
SUCC_bag:SetScript('OnEvent', OnEvent)
SUCC_bag:SetScript('OnShow', function()
	PlaySound('igInventoryOepn')
end)
SUCC_bag:SetScript('OnHide', function()
    for slot=1, (SUCC_bag.size or 0) do
        _G[SUCC_bag:GetName()..'Item'..slot]:SetAlpha(1)
    end
	PlaySound('igInventoryClose')
end)
SUCC_bag.slotFrame = CreateFrame('Frame', 'SUCC_bagSlotFrame', SUCC_bag)
SUCC_bag.slotFrame.slot = {}
for i = 1, NUM_BAG_SLOTS, 1 do
	SUCC_bag.slotFrame.slot[i] = CreateFrame('CheckButton', 'SUCC_bagIBag' .. i - 1 ..'Slot', SUCC_bag.slotFrame, 'BagSlotButtonTemplate')
	SUCC_bag.slotFrame.slot[i]:SetNormalTexture('Interface\\AddOns\\SUCC-bag\\Textures\\Slot')
	SUCC_bag.slotFrame.slot[i]:SetScript('OnClick', function()
		local bagID = this:GetID()
		if not CursorHasItem() then
			if IsShiftKeyDown() then
				BagSlotButton_OnDrag()
			else
				PlaySound('igMainMenuOptionFaerTab')
				if not this:GetChecked() then
					HighlightBagSlots(bagID - 19)
				else
					HighlightBagSlots(bagID - 19, 'highlight')
				end
			end
		else
			this:SetChecked(not this:GetChecked())
			PutItemInBag(bagID)
		end
	end)
	SUCC_bag.slotFrame.slot[i]:SetScript('OnEnter', function()
		HighlightBagSlots(this:GetID() - 19, 'highlight')
		BagSlotButton_OnEnter()
	end)
	SUCC_bag.slotFrame.slot[i]:SetScript('OnLeave', function()
		if not this:GetChecked() then
			HighlightBagSlots(this:GetID() - 19)
		end
		GameTooltip:Hide()
		ResetCursor()
	end)
	SUCC_bag.slotFrame.slot[i]:SetScript('OnReceiveDrag', function()
		PutItemInBag(this:GetID())
	end)
end

SUCC_bag.keyring = CreateFrame('Frame', 'SUCC_bagKeyring', UIParent)
-- SUCC_bag.keyring:SetPoint('BOTTOMRIGHT', UIParent, -55, 55)
SUCC_bag.keyring.bags = {-2}
SUCC_bag.keyring:SetScript('OnShow', function()
	if SUCC_bag:IsVisible() then
		this:ClearAllPoints()
		this:SetPoint('BOTTOMLEFT', SUCC_bag, 'TOPLEFT', 0, 0)
	end
	PlaySound('KeyRingOpen')
end)
SUCC_bag.keyring:SetScript('OnHide', function()
    for slot=1, (SUCC_bag.keyring.size or 0)do
        _G[SUCC_bag.keyring:GetName()..'Item'..slot]:SetAlpha(1)
    end
	PlaySound('KeyRingClose')
end)

-- overrides
function SBFrameOpen(frame, automatic)
	FrameGenerate(frame)
	if frame and not automatic then
		frame.manOpened = 1
	end
end

function SBFrameClose(frame, automatic)
	if not(automatic and frame.manOpened) then
		frame:Hide()
		frame.manOpened = nil
	end
end

function SBFrameToggle(frame)
	if frame:IsVisible() then
		SBFrameClose(frame)
	else
		SBFrameOpen(frame)
	end
end


-- configuration

local menu

local function SlidersState(frame, disable)
	local frameName = frame:GetName()
	local thumb = _G[frameName .. 'Thumb']
	local string = _G[frameName .. 'Text']
	local low = _G[frameName .. 'Low']
	local high = _G[frameName .. 'High']
	if disable == 1 then
		thumb:Hide()
		string:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		low:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		high:SetVertexColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
		frame:EnableMouse(false)
	else
		thumb:Show()
		string:SetVertexColor(NORMAL_FONT_COLOR.r , NORMAL_FONT_COLOR.g , NORMAL_FONT_COLOR.b)
		low:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		high:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
		frame:EnableMouse()
	end
end

local function SetColumns()
	local l, n = this:GetValue(), string.sub(this:GetName(), 5, -8)
	SUCC_bagOptions.layout.columns[n] = l
	if n == 'bag' then
		FrameLayout(SUCC_bag, l)
		FrameLayout(SUCC_bag.keyring, l)
	else
		FrameLayout(SUCC_bag.bank, l)
	end
	this:GetScript('OnEnter')()
end

local function SetColor()
	local r, g, b = ColorPickerFrame:GetColorRGB()
	ColorPickerFrame.frame.swatch:SetVertexColor(r, g, b)
	ColorPickerFrame.frame.func(r, g, b)
end

local function ResetColor(reset)
	local r, g, b = unpack(reset)
	ColorPickerFrame.frame.swatch:SetVertexColor(r, g, b)
	ColorPickerFrame.frame.func(r, g, b)
end

local function ColorPicker(frame, reset)
	ColorPickerFrame:ClearAllPoints()
	ColorPickerFrame:SetPoint('LEFT', menu, 'RIGHT')
	ColorPickerFrame:SetToplevel()
	ColorPickerFrame.frame = frame
	ColorPickerFrame.func = SetColor
	ColorPickerFrame.cancelFunc = ResetColor
	ColorPickerFrame:SetColorRGB(unpack(reset))
	ColorPickerFrame.previousValues = reset
	ShowUIPanel(ColorPickerFrame)
end

local function CreateMenuFrame()
	local function CreateColorButton(name, text, color, relativeto, anchorbelow, hascheckbox)
		local button = CreateFrame('Button', name, menu)
		button:SetWidth(90)
		button:SetHeight(16)
		if relativeto then
			local point, relativepoint, x, y = 'LEFT', 'RIGHT', 40, 0
			if anchorbelow then
				point, relativepoint, x, y = 'TOP', 'BOTTOM', 0, 0
			end
			button:SetPoint(point, relativeto, relativepoint, x, y)
		end
		button.text = button:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
		button.text:SetPoint('Left', button)
		button.text:SetText(text)
		button.swatch = button:CreateTexture(button:GetName() .. 'SwatchBg', 'BACKGROUND')
		button.swatch:SetTexture('Interface\\ChatFrame\\ChatFrameColorSwatch')
		button.swatch:SetPoint('RIGHT', button)
		button.swatch:SetWidth(16)
		button.swatch:SetHeight(16)
		button.swatch:SetVertexColor(unpack(color))
		button:SetScript('OnClick', function() ColorPicker(this, color) end)
		if hascheckbox then
			button.enable = CreateFrame('CheckButton', name..'Enabled', button, 'UICheckButtonTemplate')
			button.enable:SetPoint('LEFT', button, 'RIGHT', 0, 0)
			button.enable:SetWidth(18)
			button.enable:SetHeight(18)
			button.enable:SetScript('OnShow', function() this:SetChecked(color.enabled) end)
			button.enable:SetScript('OnClick', function()
				color.enabled = not color.enabled
				this:SetChecked(color.enabled)
				PlayClickSound()
				if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
				if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
				if SUCC_bag.keyring:IsVisible() then FrameUpdate(SUCC_bag.keyring) end
			end)
		end
		return button
	end

	local function CreateSlider(name, text, minValue, maxValue, initValue, valueStep, relativePoint, anchorbelow)
		local slider = CreateFrame('Slider', name, menu, 'OptionsSliderTemplate')
		slider:SetWidth(90)
		slider:SetHeight(20)
		if relativePoint then
			local point, relativepoint, x, y = 'LEFT', 'RIGHT', 40, 0
			if anchorbelow then
				point, relativepoint, x, y = 'TOP', 'BOTTOM', 0, -20
			end
			slider:SetPoint(point, relativePoint, relativepoint, x, y)
		end
		slider:SetMinMaxValues(minValue, maxValue)
		slider:SetValue(initValue)
		slider:SetValueStep(valueStep)
		_G[name .. 'Text']:SetText(text)
		_G[name .. 'Low']:SetText(minValue)
		_G[name .. 'High']:SetText(maxValue)
		slider:SetScript('OnEnter', function()
			GameTooltip:SetOwner(_G[this:GetName()..'Thumb'], 'ANCHOR_LEFT', 20, -5)
			GameTooltip:SetText(this:GetValue(), 1, 1, 1)
			GameTooltip:Show()
		end)
		slider:SetScript('OnLeave', function()
			GameTooltip:Hide()
		end)
		return slider
	end

	menu = CreateFrame('Frame', 'SUCC_bagMenu', UIParent)
	menu:SetWidth(300)
	menu:SetHeight(300)
	menu:SetPoint('CENTER', UIParent)
	menu:SetBackdrop(
		{
			bgFile   = 'Interface\\Tooltips\\UI-Tooltip-Background',
			edgeFile = 'Interface\\DialogFrame\\UI-DialogBox-Border',
			insets   = {left = 11, right = 12, top = 12, bottom = 11},
		}
	)
	menu:SetBackdropColor(0, 0, 0, .7)
	menu:SetToplevel()
	menu:SetMovable()
	menu:SetUserPlaced(false)
	menu:RegisterForDrag('LeftButton')
	menu:EnableMouse()
	menu:SetScript('OnDragStart', function() menu:StartMoving() end)
	menu:SetScript('OnDragStop', function() menu:StopMovingOrSizing() end)
	menu:Hide()
	tinsert(UISpecialFrames, 'SUCC_bagMenu')

	menu.header = menu:CreateTexture(nil, 'ARTWORK')
	menu.header:SetWidth(256) menu.header:SetHeight(64)
	menu.header:SetPoint('TOP', menu, 0, 12)
	menu.header:SetTexture('Interface\\DialogFrame\\UI-DialogBox-Header')
	menu.header.t = menu:CreateFontString(nil, 'ARTWORK', 'GameFontNormal')
	menu.header.t:SetPoint('TOP', menu.header, 0, -14)
	menu.header.t:SetText(L['SUCC-bag options'])

	menu.bag = {}
	menu.bank = {}

	menu.bag.columns = CreateSlider('SBC_bagColumns', L['Bag Columns'], 4, 32, SUCC_bagOptions.layout.columns.bag, 1)
	menu.bag.columns:SetPoint('TOPLEFT', menu, 35, -45)
	menu.bag.columns:SetScript('OnValueChanged', SetColumns)

	menu.bank.columns = CreateSlider('SBC_bankColumns', L['Bank Columns'], 4, 32, SUCC_bagOptions.layout.columns.bank, 1, menu.bag.columns)
	menu.bank.columns:SetScript('OnValueChanged', SetColumns)

	menu.spacing = CreateSlider('SBC_itemSpacing', L['Item spacing'], 0, 20, SUCC_bagOptions.layout.spacing, 1, menu.bag.columns, 1)
	menu.spacing:SetScript('OnValueChanged', function()
		local l, n = this:GetValue(), string.sub(this:GetName(), 1, -8)
		SUCC_bagOptions.layout.spacing = l
		if SUCC_bag:IsVisible() then FrameLayout(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameLayout(SUCC_bag.bank) end
		if SUCC_bag.keyring:IsVisible() then FrameLayout(SUCC_bag.keyring) end
	end)

	menu.border = CreateColorButton('SBC_borderColor', L['Border'], SUCC_bagOptions.colors.border)
	menu.border:SetPoint('TOP', menu.spacing, 'BOTTOM', 0, -25)
	menu.border.func = function(r, g, b)
		SUCC_bagOptions.colors.border[1] = r
		SUCC_bagOptions.colors.border[2] = g
		SUCC_bagOptions.colors.border[3] = b
		SUCC_bag:SetBackdropBorderColor(r, g, b)
		SUCC_bag.bank:SetBackdropBorderColor(r, g, b)
		SUCC_bag.keyring:SetBackdropBorderColor(r, g, b)
		SUCC_bag.slotFrame:SetBackdropBorderColor(r, g, b)
		SUCC_bag.bank.slotFrame:SetBackdropBorderColor(r, g, b)
	end

	menu.backdrop  = CreateColorButton('SBC_backdropColor', L['Backdrop'], SUCC_bagOptions.colors.backdrop, menu.border)
	menu.backdrop.func = function(r, g, b)
		SUCC_bagOptions.colors.backdrop[1] = r
		SUCC_bagOptions.colors.backdrop[2] = g
		SUCC_bagOptions.colors.backdrop[3] = b
		SUCC_bag:SetBackdropColor(r, g, b)
		SUCC_bag.bank:SetBackdropColor(r, g, b)
		SUCC_bag.keyring:SetBackdropColor(r, g, b)
		SUCC_bag.slotFrame:SetBackdropColor(r, g, b)
		SUCC_bag.bank.slotFrame:SetBackdropColor(r, g, b)
	end

	menu.item = CreateColorButton('SBC_itemColor', L['Regular bag'], SUCC_bagOptions.colors.bag[BAG], menu.border, 1)
	menu.item.func = function(r, g, b)
		SUCC_bagOptions.colors.bag[BAG][1] = r
		SUCC_bagOptions.colors.bag[BAG][2] = g
		SUCC_bagOptions.colors.bag[BAG][3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
		if SUCC_bag.keyring:IsVisible() then FrameUpdate(SUCC_bag.keyring) end
	end

	menu.quest = CreateColorButton('SBC_questColor', L['Quest item'], SUCC_bagOptions.colors.quest, menu.item, nil, 1)
	menu.quest.func = function(r, g, b)
		SUCC_bagOptions.colors.quest[1] = r
		SUCC_bagOptions.colors.quest[2] = g
		SUCC_bagOptions.colors.quest[3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end

	menu.highlight = CreateColorButton('SBC_highlightColor', L['Highlight'], SUCC_bagOptions.colors.highlight, menu.item, 1)
	menu.highlight.func = function(r, g, b)
		SUCC_bagOptions.colors.highlight[1] = r
		SUCC_bagOptions.colors.highlight[2] = g
		SUCC_bagOptions.colors.highlight[3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end

	menu.bg = CreateColorButton('SBC_BGColor', L['BG marks'], SUCC_bagOptions.colors.BG, menu.highlight, nil, 1)
	menu.bg.func = function(r, g, b)
		SUCC_bagOptions.colors.BG[1] = r
		SUCC_bagOptions.colors.BG[2] = g
		SUCC_bagOptions.colors.BG[3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end

	menu.soul = CreateColorButton('SBC_soulColor', L['Soul bag'], SUCC_bagOptions.colors.bag[SOUL_BAG], menu.highlight, 1, 1)
	menu.soul.func = function(r, g, b)
		SUCC_bagOptions.colors.bag[SOUL_BAG][1] = r
		SUCC_bagOptions.colors.bag[SOUL_BAG][2] = g
		SUCC_bagOptions.colors.bag[SOUL_BAG][3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end

	menu.herb = CreateColorButton('SBC_herbColor', L['Herb bag'], SUCC_bagOptions.colors.bag[HERB_BAG], menu.soul, nil, 1)
	menu.herb.func = function(r, g, b)
		SUCC_bagOptions.colors.bag[HERB_BAG][1] = r
		SUCC_bagOptions.colors.bag[HERB_BAG][2] = g
		SUCC_bagOptions.colors.bag[HERB_BAG][3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end

	menu.enchanting = CreateColorButton('SBC_enchantingColor', L['Enchanting'], SUCC_bagOptions.colors.bag[ENCHANTING_BAG], menu.soul, 1, 1)
	menu.enchanting.func = function(r, g, b)
		SUCC_bagOptions.colors.bag[ENCHANTING_BAG][1] = r
		SUCC_bagOptions.colors.bag[ENCHANTING_BAG][2] = g
		SUCC_bagOptions.colors.bag[ENCHANTING_BAG][3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end

	menu.ammo = CreateColorButton('SBC_ammoColor', L['Ammo bag'], SUCC_bagOptions.colors.ammo, menu.enchanting, nil, 1)
	menu.ammo.func = function(r, g, b)
		SUCC_bagOptions.colors.ammo[1] = r
		SUCC_bagOptions.colors.ammo[2] = g
		SUCC_bagOptions.colors.ammo[3] = b
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end

	menu.override = CreateFrame('CheckButton', 'SBC_ColorBagOverride', menu, 'UICheckButtonTemplate')
	menu.override:SetHeight(25)
	menu.override:SetWidth(25)
	menu.override:SetPoint('TOPRIGHT', menu.ammo, 'BOTTOMRIGHT', 4, -10)
	menu.override:SetChecked(SUCC_bagOptions.colors.override)
	menu.override:SetScript('OnClick', function()
		if this:GetChecked() == 1 then
			SUCC_bagOptions.colors.override = true
		else
			SUCC_bagOptions.colors.override = false
		end
		if SUCC_bag:IsVisible() then FrameUpdate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameUpdate(SUCC_bag.bank) end
	end)
	menu.override.t = menu.override:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
	menu.override.t:SetPoint('RIGHT', menu.override, 'LEFT', 10, 0)
	menu.override.t:SetWidth(200)
	menu.override.t:SetText(L['Quality color above bag color'])

	if isSortingAddonLoaded() then
		menu.cleanup = CreateFrame('CheckButton', 'SBC_cleanUp', menu, 'UICheckButtonTemplate')
		menu.cleanup:SetHeight(25)
		menu.cleanup:SetWidth(25)
		menu.cleanup:SetPoint('TOPRIGHT', menu.bank.columns, 'BOTTOMRIGHT', 4, -21)
		menu.cleanup:SetChecked(SUCC_bagOptions.Clean_Up)
		menu.cleanup:SetScript('OnClick', function()
			if this:GetChecked() == 1 then
				SUCC_bagOptions.Clean_Up = 1
			else
				SUCC_bagOptions.Clean_Up = nil
			end
			TitleLayout(SUCC_bag)
			TitleLayout(SUCC_bag.bank)
		end)
		menu.cleanup.t = menu.cleanup:CreateFontString(nil, 'OVERLAY', 'GameFontNormal')
		menu.cleanup.t:SetPoint('RIGHT', menu.cleanup, 'LEFT', 10, 0)
		menu.cleanup.t:SetWidth(90)
		menu.cleanup.t:SetText(L['Sort button'])
	end

	menu.reset = CreateFrame('Button', nil, menu, 'UIPanelButtonTemplate')
	menu.reset:SetWidth(100) menu.reset:SetHeight(25)
	menu.reset:SetText(RESET)
	menu.reset:SetPoint('BOTTOMLEFT', menu, 25, 20)
	menu.reset:SetScript('OnClick', function()
		SUCC_bagOptions = SUCC_bagDefaults()
		menu.border.func(unpack(SUCC_bagOptions.colors.border))
		menu.backdrop.func(unpack(SUCC_bagOptions.colors.backdrop))
		menu.bag.columns:SetValue(SUCC_bagOptions.layout.columns.bag)
		menu.bank.columns:SetValue(SUCC_bagOptions.layout.columns.bank)
		menu.spacing:SetValue(SUCC_bagOptions.layout.spacing)
		if SUCC_bag:IsVisible() then FrameGenerate(SUCC_bag) end
		if SUCC_bag.bank:IsVisible() then FrameGenerate(SUCC_bag.bank) end
		if SUCC_bag.keyring:IsVisible() then FrameGenerate(SUCC_bag.keyring) end
	end)

	menu.close = CreateFrame('Button', nil, menu, 'UIPanelButtonTemplate')
	menu.close:SetWidth(100) menu.close:SetHeight(25)
	menu.close:SetText(CLOSE)
	menu.close:SetPoint('BOTTOMRIGHT', menu, -25, 20)
	menu.close:SetScript('OnClick', function() menu:Hide() end)
end

SlashCmdList['SUCC_BAG'] = function()
	if not menu then CreateMenuFrame() end
	if menu:IsShown() then menu:Hide() else menu:Show() end
end
