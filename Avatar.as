// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

// Avatar

package
{
    import flash.display.MovieClip;
    import flash.filters.GlowFilter;
    import flash.display.Loader;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.events.IOErrorEvent;

    public class Avatar
    {

        public var rootClass:*;
        public var uid:int;
        public var pMC:MovieClip;
        public var pnm:String;
        public var objData:Object = null;
        public var dataLeaf:Object = {};
        public var guild:Object = {};
        public var npcType:String = "player";
        public var target:* = null;
        public var targets:Object = {};
        public var isMyAvatar:Boolean = false;
        public var friends:Array = [];
        public var classes:Array;
        public var factions:Array = [];
        private var _bank:Array;

        public var items:Array;
        public var houseitems:Array;
        public var tempitems:Array = [];
        public var bitData:Boolean = false;
        public var strFrame:String = "";
        public var petMC:PetMC;
        public var sLinkPet:String = "";
        public var friendsLoaded:Number;
        public var strProj:String = "";
        public var invLoaded:Boolean = false;
        private var loadCount:int = 0;
        private var firstLoad:Boolean = true;
        private var specialAnimation:Object = new Object();
        public var isCharPage:Boolean = false;
        public var isCameraTool:Boolean = false;
        public var isWorldCamera:Boolean = false;
        public var filtered_list:Array;

        public function Avatar(GameRoot:MovieClip)
        {
            rootClass = GameRoot;
        }

        public function initAvatar(obj:Object):*
        {
            var sES:*;
            trace("** AVATAR initAvatar >");
            var world:* = rootClass.world;
            var uoLeaf:* = world.uoTree[pnm];
            objData = obj.data;
            if (("intGold" in objData))
            {
                objData.intGold = Number(objData.intGold);
            };
            if (("intCoins" in objData))
            {
                objData.intCoins = Number(objData.intCoins);
            };
            if (("dUpgExp" in objData))
            {
                objData.dUpgExp = rootClass.stringToDate(objData.dUpgExp);
            };
            if (("dMutedTill" in objData))
            {
                objData.dMutedTill = rootClass.stringToDate(objData.dMutedTill);
            };
            if (("dCreated" in objData))
            {
                objData.dCreated = rootClass.stringToDate(objData.dCreated);
            };
            pMC.strGender = objData.strGender;
            updateRep();
            pMC.updateName();
            if ("bInvisible" in objData && objData.bInvisible)
            {
                pMC.pname.visible = false;
                pMC.mcChar.visible = false;
                pMC.shadow.visible = false;
                pMC.cShadow.visible = false;
            }
            else
            {
                pMC.pname.visible = true;
                pMC.mcChar.visible = true;
                pMC.shadow.visible = true;
                pMC.cShadow.visible = true;
            };
            trace(("objData.iUpgDays: " + objData.iUpgDays));
            switch (Number(obj.data.intAccessLevel))
            {
                case 100:
                case 50:
                    pMC.pname.ti.textColor = 12283391;
                    pMC.pname.filters = [new GlowFilter(0, 1, 3, 3, 64, 1)];
                    break;
                case 60:
                    pMC.pname.ti.textColor = 16698168;
                    pMC.pname.filters = [new GlowFilter(0, 1, 3, 3, 64, 1)];
                    break;
                case 40:
                    pMC.pname.ti.textColor = 5308200;
                    pMC.pname.filters = [new GlowFilter(0, 1, 3, 3, 64, 1)];
                    break;
                case 30:
                    pMC.pname.ti.textColor = 52881;
                    pMC.pname.filters = [new GlowFilter(0, 1, 3, 3, 64, 1)];
                    break;
                default:
                    if (isUpgraded())
                    {
                        pMC.pname.ti.textColor = 9229823;
                    };
                    pMC.pname.filters = [new GlowFilter(0, 1, 3, 3, 64, 1)];
            };
            if (objData.strUsernameColor != "0xFFFFFF")
            {
                this.pMC.pname.ti.textColor = objData.strUsernameColor;
                this.pMC.pname.filters = [new GlowFilter(0, 1, 3, 3, 64, 1)];
            };
            if (objData.guild != null)
            {
                pMC.pname.tg.text = (("< " + String(objData.guild.Name)) + " >");
                if (objData.guild.Color)
                {
                    this.pMC.pname.tg.textColor = objData.guild.Color;
                };
            };
            if (objData.title != null)
            {
                pMC.pname.title.text = String(objData.title.Name);
                pMC.pname.title.textColor = String(objData.title.Color);
            };
            pMC.ignore.visible = rootClass.chatF.isIgnored(obj.data.strUsername);
            trace(((("username: " + objData.strUsername) + " objData.eqp: ") + objData.eqp));
            if (objData.eqp != null)
            {
                for (sES in objData.eqp)
                {
                    loadCount++;
                    loadMovieAtES(sES, objData.eqp[sES].sFile, objData.eqp[sES].sLink);
                    updateItemAnimation(objData.eqp[sES].sMeta);
                };
            };
            pMC.loadHair();
            bitData = true;
        }

        public function loadMovieAtES(sES:*, sFile:*, sLink:*):void
        {
            if (((pMC.isRasterized) && (!(sES == "pe"))))
            {
                return;
            };
            trace(("** AVATAR loadMovieAtES > " + sES));
            if (sES != null)
            {
                switch (sES)
                {
                    case "Weapon":
                        pMC.loadWeapon(sFile, sLink);
                        break;
                    case "he":
                        pMC.loadHelm(sFile, sLink);
                        break;
                    case "ba":
                        pMC.loadCape(sFile, sLink);
                        break;
                    case "ar":
                        pMC.loadClass(sFile, sLink);
                        break;
                    case "co":
                        pMC.loadArmor(sFile, sLink);
                        break;
                    case "pe":
                        loadPet();
                        break;
                    case "mi":
                        pMC.loadMisc(sFile, sLink);
                        break;
                };
            };
        }

        public function unloadMovieAtES(sES:*):void
        {
            if (((pMC.isRasterized) && (!(sES == "pe"))))
            {
                return;
            };
            trace("** AVATAR unloadMovieAtES >");
            if (sES != null)
            {
                switch (sES)
                {
                    case "he":
                        pMC.mcChar.head.helm.visible = false;
                        if (((pMC.helmBackHair) && (pMC.bBackHair)))
                        {
                            pMC.helmBackHair = false;
                            pMC.loadHair();
                        }
                        else
                        {
                            pMC.mcChar.head.hair.visible = true;
                            pMC.mcChar.backhair.visible = pMC.bBackHair;
                            if (this == rootClass.world.myAvatar)
                            {
                                rootClass.showPortrait(this);
                            };
                            if (this == rootClass.world.myAvatar.target)
                            {
                                rootClass.showPortraitTarget(this);
                            };
                        };
                        break;
                    case "ba":
                        pMC.mcChar.cape.visible = false;
                        break;
                    case "pe":
                        unloadPet();
                        break;
                    case "co":
                        pMC.loadClass(objData.eqp["ar"].sFile, objData.eqp["ar"].sLink);
                        break;
                    case "mi":
                        pMC.cShadow.visible = false;
                        pMC.shadow.alpha = 1;
                        break;
                };
            };
        }

        public function loadPet():void
        {
            var ldr:*;
            if ((((((rootClass.world.doLoadPet(this)) && (!(objData == null))) && (!(objData.eqp == null))) && (!(objData.eqp["pe"] == null))) && (rootClass.world.CHARS.contains(pMC))))
            {
                if (this.petMC == null)
                {
                    this.petMC = new PetMC();
                    this.petMC.mouseEnabled = (this.petMC.mouseChildren = false);
                    this.petMC.WORLD = this.rootClass.world;
                    this.petMC.pAV = this;
                };
                ldr = new URLLoader(new URLRequest(this.rootClass.getFilePath() + this.objData.eqp["pe"].sFile));
                ldr.dataFormat = URLLoaderDataFormat.BINARY;
                ldr.addEventListener(Event.COMPLETE, rootClass.onLoadMaster(onLoadPetComplete, rootClass.world.loaderC));
                ldr.addEventListener(IOErrorEvent.IO_ERROR, onLoadPetError);
            };
        }
        /*public function loadPet():void
        {
            var ldr:*;
            if ((((((rootClass.world.doLoadPet(this)) && (!(objData == null))) && (!(objData.eqp == null))) && (!(objData.eqp["pe"] == null))) && (rootClass.world.CHARS.contains(pMC))))
            {
                if (((petMC == null) || (!(petMC))))
                {
                    petMC = new PetMC();
                    petMC.mouseEnabled = (petMC.mouseChildren = false);
                    petMC.WORLD = rootClass.world;
                    petMC.pAV = this;
                };
                ldr = new Loader();
                ldr.load(new URLRequest((rootClass.getFilePath() + objData.eqp["pe"].sFile)), rootClass.world.loaderC);
                ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadPetComplete, false, 0, true);
                ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadPetError, false, 0, true);
            };
        }*/

        private function onLoadPetError(e:Event):void
        {
            trace("Loading Pet.. Failed!");
            unloadPet();
        }

        public function onLoadPetComplete(e:Event):void
        {
            var AssetClass:Class;
            try
            {
                AssetClass = (rootClass.world.loaderD.getDefinition(objData.eqp["pe"].sLink) as Class);
                petMC.removeChildAt(1);
                petMC.mcChar = MovieClip(petMC.addChildAt(new (AssetClass)(), 1));
                petMC.mcChar.name = "mc";
            }
            catch (e:Error)
            {
            };
            if (((!(isMyAvatar)) && (rootClass.world.hideOtherPets)))
            {
                return;
            };
            if (rootClass.world.uoTree[objData.strUsername.toLowerCase()].strFrame == rootClass.world.strFrame)
            {
                if (((petMC.stage == null) && (petMC.getChildByName("defaultmc") == null)))
                {
                    MovieClip(rootClass.world.CHARS.addChild(petMC)).name = ("pet_" + uid);
                };
                petMC.scale(pMC.mcChar.scaleY);
                petPos();
            };
        }

        public function petPos():void
        {
            petMC.x = (pMC.x - 20);
            petMC.y = (pMC.y + 5);
        }

        public function unloadPet():void
        {
            if (petMC != null)
            {
                if (petMC.stage != null)
                {
                    rootClass.world.CHARS.removeChild(petMC);
                };
                petMC = null;
            };
        }

        public function showMC():void
        {
            if (pMC != null)
            {
                if (rootClass.world.TRASH.contains(pMC))
                {
                    rootClass.world.CHARS.addChild(rootClass.world.TRASH.removeChild(pMC));
                }
                else
                {
                    rootClass.world.CHARS.addChild(pMC);
                };
                showPetMC();
            };
        }

        public function hideMC():void
        {
            if (pMC != null)
            {
                if (rootClass.world.CHARS.contains(pMC))
                {
                    rootClass.world.TRASH.addChild(rootClass.world.CHARS.removeChild(pMC));
                }
                else
                {
                    rootClass.world.TRASH.addChild(pMC);
                };
                hidePetMC();
            };
        }

        public function showPetMC():void
        {
            if (petMC == null)
            {
                loadPet();
            }
            else
            {
                if (((petMC.stage == null) && (petMC.getChildByName("defaultmc") == null)))
                {
                    rootClass.world.CHARS.addChild(petMC);
                    petMC.scale(pMC.mcChar.scaleY);
                    petPos();
                };
            };
        }

        public function hidePetMC():void
        {
            if (((!(petMC == null)) && (!(petMC.stage == null))))
            {
                rootClass.world.CHARS.removeChild(petMC);
            };
        }

        public function initFactions(arrFactions:Array):void
        {
            var i:int;
            if (arrFactions == null)
            {
                factions = [];
            }
            else
            {
                factions = arrFactions;
                i = 0;
                while (i < factions.length)
                {
                    initFaction(factions[i]);
                    i++;
                };
            };
        }

        public function addFaction(faction:Object):void
        {
            if (((!(faction == null)) && (!(factions == null))))
            {
                factions.push(faction);
                initFaction(faction);
            };
        }

        public function addRep(ID:int, rep:int, bonus:int = 0):void
        {
            var iOldRank:int;
            var txtBonus:String;
            var faction:* = getFaction(ID);
            if (faction != null)
            {
                iOldRank = faction.iRank;
                faction.iRep = (faction.iRep + rep);
                initFaction(faction);
                if (faction.iRank > iOldRank)
                {
                    rankUp(faction.sName, faction.iRank);
                    rootClass.FB_showFeedDialog("Rank Up!", (((("reached Rank " + faction.iRank) + " for ") + faction.sName) + " Reputation in AQWorlds!"), "aqw-rankup.jpg");
                };
                txtBonus = "";
                if (bonus > 0)
                {
                    txtBonus = ((" + " + bonus) + "(Bonus)");
                };
                rootClass.chatF.pushMsg("server", ((((("Reputation for " + faction.sName) + " increased by ") + (rep - bonus)) + txtBonus) + "."), "SERVER", "", 0);
            };
        }

        public function initFaction(faction:*):void
        {
            faction.iRep = int(faction.iRep);
            faction.iRank = rootClass.getRankFromPoints(faction.iRep);
            faction.iRepToRank = 0;
            if (faction.iRank < rootClass.iRankMax)
            {
                faction.iRepToRank = (rootClass.arrRanks[faction.iRank] - rootClass.arrRanks[(faction.iRank - 1)]);
            };
            faction.iSpillRep = (faction.iRep - rootClass.arrRanks[(faction.iRank - 1)]);
        }

        public function getRep(arg:Object):int
        {
            var faction:* = getFaction(arg);
            return ((faction == null) ? 0 : faction.iRep);
        }

        public function getFaction(arg:Object):Object
        {
            return ((isNaN(Number(arg))) ? getFactionByName(String(arg)) : getFactionByID(int(arg)));
        }

        private function getFactionByID(ID:int):Object
        {
            var i:int;
            while (i < factions.length)
            {
                if (factions[i].FactionID == ID)
                {
                    return (factions[i]);
                };
                i++;
            };
            return (null);
        }

        private function getFactionByName(sName:String):Object
        {
            var i:int;
            while (i < factions.length)
            {
                if (factions[i].sName == sName)
                {
                    return (factions[i]);
                };
                i++;
            };
            return (null);
        }

        public function initFriendsList(arrFriends:Array):void
        {
            if (arrFriends != null)
            {
                friends = arrFriends;
            };
        }

        public function addFriend(obj:Object):void
        {
            if (obj != null)
            {
                friends.push(obj);
                if (rootClass.ui.mcOFrame.currentLabel == "Idle")
                {
                    rootClass.ui.mcOFrame.update();
                };
            };
        }

        public function updateFriend(obj:Object):void
        {
            var i:int;
            if (obj != null)
            {
                i = 0;
                while (i < friends.length)
                {
                    if (friends[i].ID == obj.ID)
                    {
                        friends[i] = obj;
                        break;
                    };
                    i++;
                };
                if (rootClass.ui.mcOFrame.currentLabel == "Idle")
                {
                    rootClass.ui.mcOFrame.update();
                };
            };
        }

        public function deleteFriend(ID:int):void
        {
            var i:int;
            while (i < friends.length)
            {
                if (friends[i].ID == ID)
                {
                    friends.splice(i, 1);
                    break;
                };
                i++;
            };
            if (rootClass.ui.mcOFrame.currentLabel == "Idle")
            {
                rootClass.ui.mcOFrame.update();
            };
        }

        public function isFriend(ID:int):Boolean
        {
            var i:* = 0;
            while (i < friends.length)
            {
                if (friends[i].ID == ID)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function isFriendName(unm:String):Boolean
        {
            var i:* = 0;
            while (i < friends.length)
            {
                if (friends[i].sName.toLowerCase() == unm.toLowerCase())
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        internal function initGuild(Guild:Object):void
        {
            guild = Guild;
            if (Guild != null)
            {
                pMC.pname.tg.text = (("< " + String(Guild.Name)) + " >");
                rootClass.chatF.chn.guild.act = 1;
                objData.guild = Guild;
            };
        }

        public function updateGuild(Guild:Object):void
        {
            objData.guild = Guild;
            if (objData.guild != null)
            {
                pMC.pname.tg.text = (("< " + String(objData.guild.Name)) + " >");
            }
            else
            {
                pMC.pname.tg.text = "";
            };
        }

        public function initInventory(arrItems:Array):void
        {
            var i:*;
            trace("** AVATAR initInventory >");
            if (arrItems == null)
            {
                items = [];
            }
            else
            {
                items = arrItems;
                i = 0;
                while (i < items.length)
                {
                    items[i].iQty = int(items[i].iQty);
                    rootClass.world.invTree[items[i].ItemID] = items[i];
                    i++;
                };
            };
        }

        public function cleanInventory():void
        {
            var item:*;
            var i:* = 0;
            while (i < items.length)
            {
                item = items[i];
                if (item.iQty == null)
                {
                    item.iQty = 1;
                };
                i++;
            };
        }

        public function auctionReset():void
        {
            rootClass.world.auctioninfo.items.splice(0);
            rootClass.auctionTabs.fRefresh({"filter": '*'});
        }

        public function retrieveReset():void
        {
            rootClass.world.retrieveinfo.items.splice(0);
            rootClass.auctionTabs.fRefresh({"test": ''});
        }

        public function inventoryReset():void
        {
            rootClass.world.myAvatar.items.splice(0);
            rootClass.inventoryTabs.fRefresh({"filter": "*"});
        }

        public function removeRetrieve(AuctionId:int):void
        {
            var _local3:*;
            var _local2:int;
            var test:*;
            while (_local2 < rootClass.world.retrieveinfo.items.length)
            {
                if (rootClass.world.retrieveinfo.items[_local2].AuctionID == AuctionId)
                {
                    _local3 = rootClass.world.retrieveinfo.items[_local2];
                    test = rootClass.world.retrieveinfo.items.splice(_local2, 1)[0];
                    return;
                };
                _local2++;
            };
        }

        public function auctionToInv(item:Object):void
        {
            var AuctionId = item.AuctionID;
            var itemId = item.ItemID;
            var _local3:*;
            var _local2:int;
            var test:*;
            while (_local2 < rootClass.world.auctioninfo.items.length)
            {
                if (rootClass.world.auctioninfo.items[_local2].AuctionID == AuctionId)
                {
                    _local3 = rootClass.world.auctioninfo.items[_local2];
                    test = rootClass.world.auctioninfo.items.splice(_local2, 1)[0];
                    if (isItemInInventory(itemId))
                    {
                        trace("Found");
                        _local3.iQty += rootClass.world.invTree[itemId].iQty;
                        var _local4:int;
                        while (_local4 < items.length)
                        {
                            if (items[_local4].ItemID == itemId)
                            {
                                items[_local4].iQty = _local3.iQty;
                                items[_local4].CharItemID = item.CharItemID;
                                trace("Updated existing");
                                break;
                            }
                            _local4++;
                        }
                    }
                    else
                    {
                        test.CharItemID = item.CharItemID;
                        items.push(test);
                    }

                    rootClass.world.invTree[itemId] = _local3;
                    rootClass.world.invTree[itemId].CharItemID = item.CharItemID;
                    return;
                };
                _local2++;
            };
        }

        public function get bank():Array
        {
            if (((this.isMyAvatar) && (!((((rootClass == null) || (rootClass.world == null)) || (rootClass.world.bankinfo == null))))))
            {
                if (rootClass.world.bankinfo.isLoaded)
                {
                    return (rootClass.world.bankinfo.BankArray);
                };
            };
            return (this._bank);
        }

        public function set bank(_arg_1:Array):void
        {
            this._bank = _arg_1;
        }

        public function initBank(arrItems:Array):void
        {
            if (((this.isMyAvatar) && (!((((rootClass == null) || (rootClass.world == null)) || (rootClass.world.bankinfo == null))))))
            {
                rootClass.world.bankinfo.reset();
                rootClass.world.addItemsToBank(arrItems);
            };
            this.bank = arrItems;
        }

        public function bankFromInv(ItemID:int):void
        {
            var i:int;
            i = 0;
            while (i < items.length)
            {
                if (items[i].ItemID == ItemID)
                {
                    rootClass.world.addItemsToBank(rootClass.copyObj(items.splice(i, 1)));
                    rootClass.world.invTree[ItemID].iQty = 0;
                    removeFromFiltered(ItemID);
                    rootClass.world.bankinfo.bankFromInv(ItemID);
                    return;
                };
                i++;
            };
            i = 0;
            while (i < houseitems.length)
            {
                if (houseitems[i].ItemID == ItemID)
                {
                    rootClass.world.addItemsToBank(rootClass.copyObj(houseitems.splice(i, 1)));
                    rootClass.world.invTree[ItemID].iQty = 0;
                    removeFromFiltered(ItemID);
                    rootClass.world.bankinfo.bankFromInv(ItemID);
                    return;
                };
                i++;
            };
        }

        public function bankToInv(ItemID:int):void
        {
            var item:Object = rootClass.world.bankinfo.bankToInv(ItemID);
            if (item == null)
            {
                return;
            };
            var isHouse:Boolean = ((item.bHouse != null) ? (int(item.bHouse) == 1) : false);
            (((((isHouse) || (item.sType == "House")) || (item.sType == "Floor Item")) || (item.sType == "Wall Item")) ? houseitems : items).push(item);
            rootClass.world.invTree[ItemID] = item;
        }

        public function bankSwapInv(invItemID:int, bankItemID:int):void
        {
            var bankItem:Object;
            var invItem:Object;
            var isHouse:Boolean;
            var i:int;
            i = 0;
            while (i < items.length)
            {
                if (items[i].ItemID == invItemID)
                {
                    invItem = items.splice(i, 1)[0];
                    break;
                };
                i++;
            };
            i = 0;
            while (i < houseitems.length)
            {
                if (houseitems[i].ItemID == invItemID)
                {
                    invItem = houseitems.splice(i, 1)[0];
                    break;
                };
                i++;
            };
            bankItem = rootClass.world.bankinfo.bankToInv(bankItemID);
            if (((!(bankItem == null)) && (!(invItem == null))))
            {
                rootClass.world.bankinfo.addItem(rootClass.copyObj(invItem));
                rootClass.world.invTree[invItemID].iQty = 0;
                isHouse = ((bankItem.bHouse != null) ? (int(bankItem.bHouse) == 1) : false);
                (((((isHouse) || (bankItem.sType == "House")) || (bankItem.sType == "Floor Item")) || (bankItem.sType == "Wall Item")) ? houseitems : items).push(bankItem);
                rootClass.world.invTree[bankItemID] = bankItem;
                rootClass.world.bankinfo.bankFromInv(invItemID);
            };
        }

        public function tradeFromInv(_arg1:int, _arg2:int, _arg3:int):void
        {
            var _local2:int;
            var test:int;
            while (_local2 < items.length)
            {
                if (items[_local2].ItemID == _arg1)
                {
                    var initItem:Object = rootClass.copyObj(items[_local2]);
                    var test2:* = rootClass.copyObj(items.splice(_local2, 1));
                    var _local4:int;
                    while (_local4 < test2.length)
                    {
                        if (test2[_local4].ItemID == _arg1)
                        {
                            test2[_local4].iQty = _arg3;
                            trace(" Quantity Set: " + _arg3);
                        }
                        _local4++;
                    }

                    rootClass.world.addItemsToTradeA(test2);

                    initItem.iQty -= _arg3;
                    if (initItem.iQty > 0)
                    {
                        trace("Quantity item: " + initItem.iQty);
                        rootClass.world.invTree[_arg1].iQty = initItem.iQty;
                        items.push(rootClass.world.invTree[_arg1]);
                    }
                    else
                    {
                        rootClass.world.invTree[_arg1].iQty = 0;
                    }
                    return;
                };
                _local2++;
            };
        }

        public function tradeToInvReset():void
        {
            var _local3:*;
            var _local2:int;
            var test:*;
            while (_local2 < rootClass.world.tradeinfo.itemsA.length)
            {
                _local3 = rootClass.world.tradeinfo.itemsA[_local2];
                trace("Offer Item: " + _local3.ItemID);
                if (isItemInInventory(_local3.ItemID))
                {
                    trace("Found");
                    _local3.iQty += rootClass.world.invTree[_local3.ItemID].iQty;
                    var _local4:int;
                    while (_local4 < items.length)
                    {
                        if (items[_local4].ItemID == _local3.ItemID)
                        {
                            items[_local4].iQty = _local3.iQty;
                            trace("Updated existing: " + _local3.ItemID);
                            break;
                        }
                        _local4++;
                    }
                }
                else
                {
                    trace("Adding back item: " + _local3.ItemID);
                    items.push(_local3);
                }

                rootClass.world.invTree[_local3.ItemID] = _local3;
                _local2++;
            };
        }

        public function tradeToInvA(_arg1:int):void
        {
            var _local3:*;
            var _local2:int;
            var test:*;
            while (_local2 < rootClass.world.tradeinfo.itemsA.length)
            {
                if (rootClass.world.tradeinfo.itemsA[_local2].ItemID == _arg1)
                {
                    _local3 = rootClass.world.tradeinfo.itemsA[_local2];
                    test = rootClass.world.tradeinfo.itemsA.splice(_local2, 1)[0];
                    if (isItemInInventory(_arg1))
                    {
                        trace("Found");
                        _local3.iQty += rootClass.world.invTree[_arg1].iQty;
                        var _local4:int;
                        while (_local4 < items.length)
                        {
                            if (items[_local4].ItemID == _arg1)
                            {
                                items[_local4].iQty = _local3.iQty;
                                trace("Updated existing");
                                break;
                            }
                            _local4++;
                        }
                    }
                    else
                    {
                        items.push(test);
                    }

                    rootClass.world.invTree[_arg1] = _local3;
                    return;
                };
                _local2++;
            };
        }

        public function tradeToInvB(_arg1:int):void
        {
            var _local2:int;
            while (_local2 < rootClass.world.tradeinfo.itemsB.length)
            {
                if (rootClass.world.tradeinfo.itemsB[_local2].ItemID == _arg1)
                {
                    rootClass.world.tradeinfo.itemsB.splice(_local2, 1)[0];
                    return;
                };
                _local2++;
            };
        }

        public function tradeSwapInv(_arg1:int, _arg2:int):void
        {
            var _local3:Object;
            var _local4:Object;
            var _local5:int;
            _local5 = 0;
            while (_local5 < items.length)
            {
                if (items[_local5].ItemID == _arg1)
                {
                    _local4 = items.splice(_local5, 1)[0];
                    break;
                };
                _local5++;
            };
            _local5 = 0;
            while (_local5 < rootClass.world.tradeinfo.itemsA.length)
            {
                if (rootClass.world.tradeinfo.itemsA[_local5].ItemID == _arg2)
                {
                    _local3 = rootClass.world.tradeinfo.itemsA.splice(_local5, 1)[0];
                    break;
                };
                _local5++;
            };
            if (((!((_local3 == null))) && (!((_local4 == null)))))
            {
                rootClass.world.tradeinfo.itemsA.push(rootClass.copyObj(_local4));
                rootClass.world.invTree[_arg1].iQty = 0;
                items.push(_local3);
                rootClass.world.invTree[_arg2] = _local3;
            };
        }

        public function removeItem(CharItemID:int, iQty:int = 1):void
        {
            var item:Object = {};
            var i:int;
            while (i < items.length)
            {
                item = items[i];
                if (item.CharItemID == CharItemID)
                {
                    if (((item.sES == "ar") || ((item.iQty - iQty) < 1)))
                    {
                        item.iQty = 0;
                        rootClass.resetInvTreeByItemID(item.ItemID);
                        removeFromFiltered(item.ItemID);
                        items.splice(i, 1);
                    }
                    else
                    {
                        item.iQty = (item.iQty - iQty);
                    };
                    return;
                };
                i++;
            };
            var j:int;
            while (j < houseitems.length)
            {
                if (houseitems[j].CharItemID == CharItemID)
                {
                    if (houseitems[j].iQty > 1)
                    {
                        houseitems[j].iQty--;
                    }
                    else
                    {
                        houseitems[j].iQty = 0;
                        houseitems.splice(j, 1);
                        removeFromFiltered(item.ItemID);
                    };
                    return;
                };
                j++;
            };
        }

        public function removeItemByID(ItemID:int, iQty:int = 1):void
        {
            var i:int;
            i = 0;
            while (i < items.length)
            {
                if (items[i].ItemID == ItemID)
                {
                    if (((items[i].sES == "ar") || (items[i].iQty <= iQty)))
                    {
                        items[i].iQty = 0;
                        items.splice(i, 1);
                    }
                    else
                    {
                        items[i].iQty = (items[i].iQty - iQty);
                    };
                    return;
                };
                i++;
            };
            i = 0;
            while (i < houseitems.length)
            {
                if (houseitems[i].ItemID == ItemID)
                {
                    if (houseitems[i].iQty <= iQty)
                    {
                        houseitems[i].iQty = 0;
                        houseitems.splice(i, 1);
                    }
                    else
                    {
                        houseitems[i].iQty = (houseitems[i].iQty - iQty);
                    };
                    return;
                };
                i++;
            };
        }

        public function removeFromFiltered(ItemID:int):void
        {
            if (!filtered_list)
            {
                return;
            };
            if (((filtered_list) && (filtered_list.length < 1)))
            {
                return;
            };
            var i:int;
            while (i < filtered_list.length)
            {
                if (filtered_list[i].ItemID == ItemID)
                {
                    filtered_list.splice(i, 1);
                    break;
                };
                i++;
            };
        }

        public function get filtered_inventory():Array
        {
            return (((filtered_list) && (filtered_list.length > 0)) ? filtered_list : ((((rootClass.ui.mcPopup.currentLabel == "HouseInventory") || (rootClass.ui.mcPopup.currentLabel == "HouseBank")) ? houseitems : items)));
        }

        public function addItem(item:Object):void
        {
            var arrItems:Array;
            if (Boolean(item.bBank))
            {
                addToBank(item);
                return;
            };
            var isHouse:Boolean = ((item.bHouse != null) ? (int(item.bHouse) == 1) : false);
            arrItems = (((((isHouse) || (item.sType == "House")) || (item.sType == "Floor Item")) || (item.sType == "Wall Item")) ? houseitems : items);
            var i:int;
            while (i < arrItems.length)
            {
                if (arrItems[i].ItemID == item.ItemID)
                {
                    if (item.hasOwnProperty("iQtyNow"))
                    {
                        arrItems[i].iQty = int(item.iQtyNow);
                    }
                    else
                    {
                        arrItems[i].iQty = (arrItems[i].iQty + int(item.iQty));
                    };
                    return;
                };
                i++;
            };
            item.iQty = int(item.iQty);
            rootClass.world.invTree[item.ItemID] = item;
            arrItems.push(item);
        }

        public function addToBank(item:*):void
        {
            var tItem:*;
            var _bank:* = rootClass.world.bankinfo.bankItems;
            if (_bank == null)
            {
                return;
            };
            for each (tItem in _bank)
            {
                if (tItem.ItemID == item.ItemID)
                {
                    if (item.hasOwnProperty("iQtyNow"))
                    {
                        tItem.iQty = int(item.iQtyNow);
                    }
                    else
                    {
                        tItem.iQty = (tItem.iQty + int(item.iQty));
                    };
                    rootClass.world.bankinfo.hasModified();
                    return;
                };
            };
            rootClass.world.bankinfo.addItem(rootClass.copyObj(item));
        }

        public function varVal(str:String):*
        {
            var rootClass:* = MovieClip(pMC.mcChar.stage.getChildAt(0));
            var world:* = rootClass.world;
            return (rootClass.sfc.getRoom(world.curRoom).getUser(uid).getVariable(str));
        }

        public function getItemByID(ID:int):Object
        {
            var i:int;
            while (i < items.length)
            {
                if (items[i].ItemID == ID)
                {
                    return (items[i]);
                };
                i++;
            };
            var j:int;
            while (j < houseitems.length)
            {
                if (houseitems[j].ItemID == ID)
                {
                    return (houseitems[j]);
                };
                j++;
            };
            var k:int;
            while (k < tempitems.length)
            {
                if (tempitems[k].ItemID == ID)
                {
                    return (tempitems[k]);
                };
                k++;
            };
            return (null);
        }

        public function getItemIDByName(sName:String):int
        {
            var i:int;
            while (i < items.length)
            {
                if (items[i].sName == sName)
                {
                    return (items[i].ItemID);
                };
                i++;
            };
            var j:int;
            while (j < houseitems.length)
            {
                if (houseitems[j].sName == sName)
                {
                    return (houseitems[j].ItemID);
                };
                j++;
            };
            var k:int;
            while (k < tempitems.length)
            {
                if (tempitems[k].sName == sName)
                {
                    return (tempitems[k].ItemID);
                };
                k++;
            };
            return (-1);
        }

        public function isItemInBank(ItemID:Number):Boolean
        {
            var i:int;
            if (bank != null)
            {
                i = 0;
                while (i < bank.length)
                {
                    if (bank[i].ItemID == ItemID)
                    {
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }

        public function isItemInInventory(arg:Object):Boolean
        {
            var i:int;
            var j:int;
            var ID:int = ((isNaN(Number(arg))) ? getItemIDByName(String(arg)) : int(arg));
            if (ID > 0)
            {
                i = 0;
                while (i < items.length)
                {
                    if (items[i].ItemID == ID)
                    {
                        return (true);
                    };
                    i++;
                };
                j = 0;
                while (j < houseitems.length)
                {
                    if (houseitems[j].ItemID == ID)
                    {
                        return (true);
                    };
                    j++;
                };
            };
            return (false);
        }

        public function isItemStackMaxed(ItemID:Number):Boolean
        {
            var i:int;
            if (bank != null)
            {
                i = 0;
                while (i < bank.length)
                {
                    if (((bank[i].ItemID == ItemID) && (bank[i].iQty >= bank[i].iStk)))
                    {
                        return (true);
                    };
                    i++;
                };
            };
            if (items != null)
            {
                i = 0;
                while (i < items.length)
                {
                    if (((items[i].ItemID == ItemID) && (items[i].iQty >= items[i].iStk)))
                    {
                        return (true);
                    };
                    i++;
                };
            };
            if (houseitems != null)
            {
                i = 0;
                while (i < houseitems.length)
                {
                    if (((houseitems[i].ItemID == ItemID) && (houseitems[i].iQty >= houseitems[i].iStk)))
                    {
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }

        public function addTempItem(item:Object):void
        {
            var i:int;
            while (i < tempitems.length)
            {
                if (tempitems[i].ItemID == item.ItemID)
                {
                    tempitems[i].iQty = (tempitems[i].iQty + int(item.iQty));
                    return;
                };
                i++;
            };
            tempitems.push(item);
            rootClass.world.invTree[item.ItemID] = item;
        }

        public function removeTempItem(ItemID:int, iQty:int):void
        {
            var i:int;
            while (i < tempitems.length)
            {
                if (tempitems[i].ItemID == ItemID)
                {
                    if (tempitems[i].iQty > iQty)
                    {
                        tempitems[i].iQty = (tempitems[i].iQty - iQty);
                    }
                    else
                    {
                        tempitems[i].iQty = 0;
                        tempitems.splice(i, 1);
                    };
                    return;
                };
                i++;
            };
        }

        public function checkTempItem(ItemID:int, iQty:int):Boolean
        {
            var i:int;
            while (i < tempitems.length)
            {
                if (((tempitems[i].ItemID == ItemID) && (tempitems[i].iQty >= iQty)))
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function getTempItemQty(ItemID:int):int
        {
            var i:int;
            while (i < tempitems.length)
            {
                if (tempitems[i].ItemID == ItemID)
                {
                    return (tempitems[i].iQty);
                };
                i++;
            };
            return (-1);
        }

        public function unequipItemAtES(sES:String):void
        {
            var i:int;
            i = 0;
            while (i < items.length)
            {
                if (items[i].sES == sES)
                {
                    items[i].bEquip = 0;
                    removeItemAnimation(items[i].sMeta);
                };
                i++;
            };
            i = 0;
            while (i < tempitems.length)
            {
                if (tempitems[i].sES == sES)
                {
                    tempitems[i].bEquip = 0;
                };
                i++;
            };
        }

        public function equipItem(ItemID:int):void
        {
            var i:int;
            rootClass.world.afkPostpone();
            if (((!(items == null)) && (items.length > 0)))
            {
                i = 0;
                while (i < items.length)
                {
                    if (items[i].ItemID == ItemID)
                    {
                        trace(("item found: " + items[i].ItemID));
                        unequipItemAtES(items[i].sES);
                        items[i].bEquip = 1;
                        updateItemAnimation(items[i].sMeta);
                        return;
                    };
                    i++;
                };
            };
            if (((!(tempitems == null)) && (tempitems.length > 0)))
            {
                i = 0;
                while (i < tempitems.length)
                {
                    if (tempitems[i].ItemID == ItemID)
                    {
                        unequipItemAtES(tempitems[i].sES);
                        tempitems[i].bEquip = 1;
                        return;
                    };
                    i++;
                };
            };
        }

        public function unequipItem(ItemID:int):void
        {
            var i:int;
            trace("unequip called");
            if (((!(items == null)) && (items.length > 0)))
            {
                i = 0;
                while (i < items.length)
                {
                    if (items[i].ItemID == ItemID)
                    {
                        items[i].bEquip = 0;
                        removeItemAnimation(items[i].sMeta);
                        return;
                    };
                    i++;
                };
            };
            if (((!(tempitems == null)) && (tempitems.length > 0)))
            {
                i = 0;
                while (i < tempitems.length)
                {
                    if (tempitems[i].ItemID == ItemID)
                    {
                        tempitems[i].bEquip = 0;
                        return;
                    };
                    i++;
                };
            };
        }

        public function checkItemAnimation():void
        {
            var i:uint;
            while (i < items.length)
            {
                if (items[i].bEquip == 1)
                {
                    updateItemAnimation(items[i].sMeta);
                };
                i++;
            };
        }

        private function updateItemAnimation(strMeta:String):void
        {
            var tokenData:Array;
            if (strMeta == null)
            {
                return;
            };
            if (((strMeta.indexOf("anim") < 0) && (strMeta.indexOf("proj") < 0)))
            {
                return;
            };
            var tempAnim:String = "";
            var tempChance:Number = -1;
            var animTokens:Array = strMeta.split(",");
            var i:uint;
            while (i < animTokens.length)
            {
                tokenData = animTokens[i].split(":");
                if (tokenData[0] == "anim")
                {
                    tempAnim = tokenData[1];
                }
                else
                {
                    if (tokenData[0] == "chance")
                    {
                        tempChance = Number(tokenData[1]);
                    };
                    if (tokenData[0] == "proj")
                    {
                        strProj = tokenData[1];
                    };
                };
                i++;
            };
            if (((!(tempAnim == "")) && (tempChance > 0)))
            {
                specialAnimation[tempAnim] = tempChance;
            };
        }

        private function removeItemAnimation(strMeta:String):*
        {
            var s:String;
            trace(("strMeta: " + strMeta));
            if (strMeta == null)
            {
                return;
            };
            if (strMeta.indexOf("proj") > -1)
            {
                strProj = "";
            };
            for (s in specialAnimation)
            {
                if (strMeta.indexOf(s) > -1)
                {
                    delete specialAnimation[s];
                    return;
                };
            };
        }

        public function isItemEquipped(ItemID:int):Boolean
        {
            var item:* = getItemByID(ItemID);
            if ((((item == null) || (item.bEquip == null)) || (item.bEquip == 0)))
            {
                return (false);
            };
            return (true);
        }

        public function getClassArmor(strClassName:String):Object
        {
            var i:int;
            while (i < items.length)
            {
                if (((items[i].sName == strClassName) && (items[i].sES == "ar")))
                {
                    return (items[i]);
                };
                i++;
            };
            return (null);
        }

        public function getEquippedItemBySlot(slot:String):Object
        {
            var i:int;
            while (i < items.length)
            {
                if (((items[i].bEquip == 1) && (items[i].sES == slot)))
                {
                    return (items[i]);
                };
                i++;
            };
            return (null);
        }

        public function getItemByEquipSlot(slot:String):Object
        {
            if ((((!(objData == null)) && (!(objData.eqp == null))) && (!(objData.eqp[slot] == null))))
            {
                return (objData.eqp[slot]);
            };
            return (null);
        }

        public function updateArmorRep():void
        {
            var armor:* = getClassArmor(objData.strClassName);
            armor.iQty = Number(objData.iCP);
        }

        public function getArmorRep(strClassName:String = ""):int
        {
            if (strClassName == "")
            {
                strClassName = objData.strClassName;
            };
            var armor:* = getClassArmor(strClassName);
            if (armor != null)
            {
                return (armor.iQty);
            };
            return (0);
        }

        public function getCPByID(ID:int):int
        {
            var armor:* = getItemByID(ID);
            if (armor != null)
            {
                return (armor.iQty);
            };
            return (-1);
        }

        public function updateRep():void
        {
            var oldRank:* = objData.iRank;
            var iCP:* = objData.iCP;
            var iRank:int = rootClass.getRankFromPoints(iCP);
            var iCPToRank:int;
            var world:* = rootClass.world;
            if (iRank < rootClass.iRankMax)
            {
                iCPToRank = (rootClass.arrRanks[iRank] - rootClass.arrRanks[(iRank - 1)]);
            };
            objData.iCurCP = (iCP - rootClass.arrRanks[(iRank - 1)]);
            objData.iRank = iRank;
            objData.iCPToRank = iCPToRank;
            if (((isMyAvatar) && (!(oldRank == iRank))))
            {
                world.updatePortrait(this);
            };
            if (isMyAvatar)
            {
                rootClass.updateRepBar();
            };
        }

        public function levelUp():void
        {
            healAnimation();
            var mcLevelUp:* = pMC.addChild(new LevelUpDisplay());
            mcLevelUp.t.ti.text = objData.intLevel;
            mcLevelUp.x = pMC.mcChar.x;
            mcLevelUp.y = (pMC.pname.y + 10);
            rootClass.FB_showFeedDialog("Level Up!", (("reached Level " + objData.intLevel) + " in AQWorlds!"), "aqw-levelup.jpg");
        }

        public function rankUp(strText:String, iRank:int):void
        {
            healAnimation();
            var mcRankUp:* = pMC.addChild(new RankUpDisplay());
            mcRankUp.t.ti.text = ((strText + ", Rank ") + iRank);
            mcRankUp.x = pMC.mcChar.x;
            mcRankUp.y = (pMC.pname.y + 10);
        }

        public function healAnimation():void
        {
            rootClass.mixer.playSound("Heal");
            var mcHeal:* = pMC.parent.addChild(new sp_eh1());
            mcHeal.x = pMC.x;
            mcHeal.y = pMC.y;
        }

        public function isUpgraded():Boolean
        {
            return (int(objData.iUpgDays) >= 0);
        }

        public function hasUpgraded():Boolean
        {
            return (int(objData.iUpg) > 0);
        }

        public function isVerified():Boolean
        {
            return (((objData.intAQ > 0) || (objData.intDF > 0)) || (objData.intMQ > 0));
        }

        public function isStaff():Boolean
        {
            return (objData.intAccessLevel >= 40);
        }

        public function isEmailVerified():Boolean
        {
            return (objData.intActivationFlag == 5);
        }

        public function updatePending(i:int):void
        {
            var s:String;
            var j:uint;
            if (objData.pending == null)
            {
                s = "";
                j = 0;
                while (j < 500)
                {
                    s = (s + String.fromCharCode(0));
                    j++;
                };
                objData.pending = s;
            };
            var pos:int = Math.floor((i >> 3));
            var bit:int = (i % 8);
            var code:int = objData.pending.charCodeAt(pos);
            code = (code | (1 << bit));
            objData.pending = ((objData.pending.substr(0, pos) + String.fromCharCode(code)) + objData.pending.substr((pos + 1)));
        }

        public function updateScrolls(i:int):void
        {
            var s:String;
            var j:uint;
            if (objData.scrolls == null)
            {
                s = "";
                j = 0;
                while (j < 500)
                {
                    s = (s + String.fromCharCode(0));
                    j++;
                };
                objData.scrolls = s;
            };
            var pos:int = Math.floor((i >> 3));
            var bit:int = (i % 8);
            var code:int = objData.scrolls.charCodeAt(pos);
            code = (code | (1 << bit));
            objData.scrolls = ((objData.scrolls.substr(0, pos) + String.fromCharCode(code)) + objData.scrolls.substr((pos + 1)));
        }

        public function handleItemAnimation():void
        {
            var s:String;
            var AssetClass:Class;
            var mc:MovieClip;
            trace("handle Animation");
            var rand:Number = (Math.random() * 100);
            for (s in specialAnimation)
            {
                trace((("rand: " + rand) + " specialAnimations[s]"));
                if (rand < specialAnimation[s])
                {
                    AssetClass = (rootClass.world.getClass(s) as Class);
                    if (AssetClass != null)
                    {
                        mc = (new (AssetClass)() as MovieClip);
                        mc.x = pMC.x;
                        mc.y = pMC.y;
                        trace("x and y set");
                        if (pMC.mcChar.scaleX < 0)
                        {
                            mc.scaleX = (mc.scaleX * -1);
                        };
                        rootClass.world.CHARS.addChild(mc);
                    };
                    return;
                };
            };
        }

        public function get FirstLoad():Boolean
        {
            return (firstLoad);
        }

        public function get LoadCount():int
        {
            return (loadCount);
        }

        public function updateLoaded():void
        {
            trace(("loadCount: " + loadCount));
            loadCount--;
        }

        public function firstDone():void
        {
            firstLoad = false;
        }

        public function get iBankCount():int
        {
            return (rootClass.world.bankinfo.Count);
        }

        public function set iBankCount(value:int):void
        {
            rootClass.world.bankinfo.Count = value;
        }

    }
} // package