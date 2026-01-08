// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

// World

package
{
    import flash.display.MovieClip;
    import flash.display.Loader;
    import flash.display.BitmapData;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.utils.Timer;
    import flash.geom.ColorTransform;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.events.ProgressEvent;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.utils.getDefinitionByName;
    import flash.events.MouseEvent;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.Bitmap;
    import flash.geom.Matrix;
    import flash.media.Sound;
    import flash.utils.getQualifiedClassName;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.text.TextFormat;
    import flash.filters.GlowFilter;
    import flash.utils.*;
    import flash.external.*;

    public class World extends MovieClip
    {

        public static var currentInstance:World;

        private const TICK_MAX:* = 24;

        public var uiLock:Boolean = false;
        public var objSession:Object = new Object();
        public var objResponse:Object = new Object();
        public var objQuestString:*;
        public var objInfo:Object = new Object();
        internal var FEATURE_COLLISION:Boolean = true;
        internal var CELL_MODE:String = "normal";
        public var SCALE:Number = 1;
        public var WALKSPEED:Number = 8;
        public var bitWalk:Boolean = false;
        internal var lastWalk:Date = new Date();
        public var strAreaName:String;
        public var strMapName:String;
        public var strMapFileName:String;
        public var intType:int;
        public var intKillCount:int;
        public var objLock:*;
        public var objExtra:*;
        public var objHouseData:*;
        public var objGuildData:*;
        public var returnInfo:Object;
        public var strFrame:String = "";
        public var strPad:String = "";
        public var spawnPoint:Object = new Object();
        public var FG:MovieClip;
        public var CHARS:MovieClip;
        public var TRASH:MovieClip;
        public var map:MovieClip;
        public var mapBoundsMC:MovieClip = null;
        public var zSortArr:Array = new Array();
        public var ldr_map:URLLoader = new URLLoader();
        internal var preLMC:*;
        internal var zManager:MovieClip;
        public var EFAO:Object = {
                "zc": 0,
                "zn": 1,
                "xpc": 0,
                "xpn": 50,
                "xpb": false
            };
        public var arrEvent:Array;
        public var arrEventR:Array;
        public var arrSolid:Array;
        public var arrSolidR:Array;
        public var avatars:Object = new Object();
        public var myAvatar:Avatar;
        public var mondef:Array;
        public var monswf:Array;
        public var monmap:Array;
        public var monsters:Array = new Array();
        public var combatAnims:Array = ["Attack1", "Attack2", "Attack3", "Attack4", "Hit", "Knockout", "Getup", "Stab", "Thrash", "Castgood", "Cast1", "Cast2", "Cast3", "Sword/ShieldFight", "Sword/ShieldAttack1", "Sword/ShieldAttack2", "ShieldBlock", "DuelWield/DaggerFight", "DuelWield/DaggerAttack1", "DuelWield/DaggerAttack2", "FistweaponFight", "FistweaponAttack1", "FistweaponAttack2", "PolearmFight", "PolearmAttack1", "PolearmAttack2", "RangedFight", "RangedAttack1", "UnarmedFight", "UnarmedAttack1", "UnarmedAttack2", "KickAttack", "FlipAttack", "Dodge"];
        public var staticAnims:Array = ["Fall", "Knockout", "Die"];
        public var bankController:BankController;
        public var shopinfo:Object;
        public var shopBuyItem:Object;
        public var enhShopID:int = -1;
        public var enhShopItems:Array;
        public var enhItem:Object;
        public var hairshopinfo:Object;
        public var mapEvents:Object;
        public var adData:Object;
        public var cellMap:Object;
        private var tbmd:BitmapData;
        public var scrollData:Object;
        public var loaderD:ApplicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
        public var loaderC:LoaderContext = new LoaderContext(false, loaderD);
        public var loaderContents:* = [];
        public var loaderContentsFileNames:* = [];
        public var loaderQueue:Array = [];
        public var playerDomains:Object = {};
        public var loaderManager:Object = {
                "i0": {
                    "n": "i0",
                    "loaderData": null,
                    "timer": new Timer(5000, 1),
                    "ldr": new URLLoader(),
                    "free": true,
                    "url": ""
                },
                "i1": {
                    "n": "i1",
                    "loaderData": null,
                    "timer": new Timer(5000, 1),
                    "ldr": new URLLoader(),
                    "free": true,
                    "url": ""
                },
                "i2": {
                    "n": "i2",
                    "loaderData": null,
                    "timer": new Timer(5000, 1),
                    "ldr": new URLLoader(),
                    "free": true,
                    "url": ""
                },
                "i3": {
                    "n": "i3",
                    "loaderData": null,
                    "timer": new Timer(5000, 1),
                    "ldr": new URLLoader(),
                    "free": true,
                    "url": ""
                },
                "i4": {
                    "n": "i4",
                    "loaderData": null,
                    "timer": new Timer(5000, 1),
                    "ldr": new URLLoader(),
                    "free": true,
                    "url": ""
                },
                "i5": {
                    "n": "i5",
                    "loaderData": null,
                    "timer": new Timer(5000, 1),
                    "ldr": new URLLoader(),
                    "free": true,
                    "url": ""
                }
            };
        public var mapLoadInProgress:Boolean = false;
        private var mapW:int = 960;
        private var mapH:int = 550;
        private var mapNW:int = mapW;
        private var mapNH:int = mapH;
        private var mapBmps:Array = [];
        private var mapTimer:Timer = new Timer(2000);
        public var actions:Object = new Object();
        internal var restTimer:Timer = new Timer(2000, 1);
        internal var AATestTimer:Timer = new Timer(700, 1);
        internal var connTestTimer:Timer = new Timer(5000, 1);
        internal var autoActionTimer:Timer = new Timer(2000, 1);
        internal var afkTimer:Timer = new Timer(120000, 1);
        internal var mvTimer:Timer = new Timer(1000, 1);
        internal var mvTimerObj:Object;
        internal var actionTimer:Timer;
        internal var actionMap:Array = new Array();
        internal var autoAction:Object;
        internal var actionReady:Boolean = false;
        internal var actionResults:Object = new Object();
        internal var actionResultsMon:Object = new Object();
        internal var actionID:Number = 0;
        internal var actionIDLimit:Number = 30;
        internal var actionIDMon:Number = 0;
        internal var actionIDLimitMon:Number = 30;
        internal var actionDamage:*;
        internal var actionRangeSpamTS:Number = 0;
        internal var actionResultID:Number = 0;
        internal var actionResultIDLimit:Number = 30;
        internal var minLatencyOneWay:* = 20;
        internal var TcpAckDel:* = 170;
        internal var connMsgOut:* = false;
        public var mData:mapData;
        public var cHandle:cutsceneHandler;
        public var sController:soundController;
        public var chaosNames:Array = new Array();
        public var hideAllCapes:Boolean = false;
        public var hideOtherPets:Boolean = false;
        public var showAnimations:Boolean = true;
        public var showMonsters:Boolean = true;
        public var lock:Object = {
                "loadShop": {
                    "cd": 3000,
                    "ts": 0
                },
                "loadEnhShop": {
                    "cd": 3000,
                    "ts": 0
                },
                "loadHairShop": {
                    "cd": 3000,
                    "ts": 0
                },
                "equipItem": {
                    "cd": 1500,
                    "ts": 0
                },
                "unequipItem": {
                    "cd": 1500,
                    "ts": 0
                },
                "buyItem": {
                    "cd": 1000,
                    "ts": 0
                },
                "sellItem": {
                    "cd": 1000,
                    "ts": 0
                },
                "getMapItem": {
                    "cd": 1000,
                    "ts": 0
                },
                "tryQuestComplete": {
                    "cd": 1250,
                    "ts": 0
                },
                "acceptQuest": {
                    "cd": 1000,
                    "ts": 0
                },
                "doIA": {
                    "cd": 1000,
                    "ts": 0
                },
                "rest": {
                    "cd": 1900,
                    "ts": 0
                },
                "who": {
                    "cd": 3000,
                    "ts": 0
                },
                "tfer": {
                    "cd": 3000,
                    "ts": 0
                }
            };
        public var invTree:Object = {};
        public var uoTree:Object = {};
        public var monTree:Object = {};
        public var waveTree:Object = {};
        public var questTree:Object = {};
        public var enhPatternTree:Object = {};
        public var enhp:Array = [ {
                    "ID": 1,
                    "sName": "Adventurer",
                    "sDesc": "none",
                    "iSTR": 16,
                    "iDEX": 16,
                    "iEND": 18,
                    "iINT": 16,
                    "iWIS": 16,
                    "iLCK": 0
                }, {
                    "ID": 2,
                    "sName": "Fighter",
                    "sDesc": "M1",
                    "iSTR": 44,
                    "iDEX": 13,
                    "iEND": 43,
                    "iINT": 0,
                    "iWIS": 0,
                    "iLCK": 0
                }, {
                    "ID": 3,
                    "sName": "Thief",
                    "sDesc": "M2",
                    "iSTR": 30,
                    "iDEX": 45,
                    "iEND": 25,
                    "iINT": 0,
                    "iWIS": 0,
                    "iLCK": 0
                }, {
                    "ID": 4,
                    "sName": "Armsman",
                    "sDesc": "M4",
                    "iSTR": 38,
                    "iDEX": 36,
                    "iEND": 26,
                    "iINT": 0,
                    "iWIS": 0,
                    "iLCK": 0
                }, {
                    "ID": 5,
                    "sName": "Hybrid",
                    "sDesc": "M3",
                    "iSTR": 28,
                    "iDEX": 20,
                    "iEND": 25,
                    "iINT": 27,
                    "iWIS": 0,
                    "iLCK": 0
                }, {
                    "ID": 6,
                    "sName": "Wizard",
                    "sDesc": "C1",
                    "iSTR": 0,
                    "iDEX": 0,
                    "iEND": 10,
                    "iINT": 50,
                    "iWIS": 20,
                    "iLCK": 20
                }, {
                    "ID": 7,
                    "sName": "Healer",
                    "sDesc": "C2",
                    "iSTR": 0,
                    "iDEX": 0,
                    "iEND": 40,
                    "iINT": 45,
                    "iWIS": 15,
                    "iLCK": 0
                }, {
                    "ID": 8,
                    "sName": "Spellbreaker",
                    "sDesc": "C3",
                    "iSTR": 0,
                    "iDEX": 0,
                    "iEND": 20,
                    "iINT": 40,
                    "iWIS": 30,
                    "iLCK": 10
                }, {
                    "ID": 9,
                    "sName": "Lucky",
                    "sDesc": "S1",
                    "iSTR": 10,
                    "iDEX": 10,
                    "iEND": 10,
                    "iINT": 10,
                    "iWIS": 10,
                    "iLCK": 50
                }, {
                    "ID": 23,
                    "sName": "Depths",
                    "sDesc": "S1",
                    "iSTR": 0,
                    "iDEX": 0,
                    "iEND": 0,
                    "iINT": 50,
                    "iWIS": 0,
                    "iLCK": 50
                }];
        public var defaultCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        public var whiteCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0);
        public var iconCT:ColorTransform = new ColorTransform(0.5, 0.5, 0.5, 1, -50, -50, -50, 0);
        public var rarityCA:Array = [0x666666, 0xFFFFFF, 0x66FF00, 2663679, 0xFF00FF, 0xFFCC00, 0xFF0000];
        public var deathCT:ColorTransform = new ColorTransform(0.7, 0.7, 1, 1, -20, -20, 20, 0);
        public var monCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 30, 0, 0, 0);
        public var avtCT:ColorTransform = new ColorTransform(1, 1, 1, 1, 40, 40, 70, 0);
        public var avtWCT:ColorTransform = new ColorTransform(0, 0, 0, 0, 0xFF, 0xFF, 0xFF, 0);
        public var avtMCT:ColorTransform = new ColorTransform(0, 0, 0, 0, 30, 0, 0, 0);
        public var avtPCT:ColorTransform = new ColorTransform(0, 0, 0, 0, 40, 40, 70, 0);
        public var statusPoisonCT:ColorTransform = new ColorTransform(-0.3, -0.3, -0.3, 0, 0, 20, 0, 0);
        public var statusStoneCT:ColorTransform = new ColorTransform(-1.3, -1.3, -1.3, 0, 100, 100, 100, 0);
        public var statusFreezeCT:ColorTransform = new ColorTransform(-0.3, -0.3, -0.3, 0, -50, 80, 0xFF, 0);
        public var GCD:int = 1500;
        public var GCDO:int = 1500;
        public var GCDTS:Number = 0;
        public var curRoom:int = 1;
        public var modID:int = -1;
        public var partyID:int = -1;
        public var guildID:int = -1;
        public var bPvP:Boolean = false;
        public var partyMembers:Array = [];
        public var partyOwner:String = "";
        public var areaUsers:Array = [];
        public var showHPBar:Boolean = false;
        public var rootClass:MovieClip;
        public var PVPMaps:Array = [ {
                    "nam": "It's Us Or Them",
                    "desc": "This cozy PvP map is ideal for players new to PvP in AQW.",
                    "warzone": "usorthem",
                    "label": "usorthem",
                    "icon": "tower",
                    "hidden": true
                }, {
                    "nam": "Bludrut Brawl!",
                    "desc": "A larger map requiring communication, coordination, and a whole lot of DPS.",
                    "warzone": "bludrutbrawl",
                    "label": "bludrutbrawl",
                    "icon": "swords",
                    "hidden": false
                }, {
                    "nam": "Chaos Brawl!",
                    "desc": "A larger map requiring communication, coordination, and a whole lot of DPS.",
                    "warzone": "chaosbrawl",
                    "label": "chaosbrawl",
                    "icon": "swords",
                    "hidden": false
                }, {
                    "nam": "Frost Brawl!",
                    "desc": "A larger map requiring communication, coordination, and a whole lot of DPS.",
                    "warzone": "frostbrawl",
                    "label": "frostbrawl",
                    "icon": "swords",
                    "hidden": false
                }, {
                    "nam": "Darkovia Brawl!",
                    "desc": "Join in the ancient war between werewolves and vampires!",
                    "warzone": "darkoviapvp",
                    "label": "darkoviapvp",
                    "icon": "swords",
                    "hidden": true
                }, {
                    "nam": "Dage PVP!",
                    "desc": "Needs Description!",
                    "warzone": "dagepvp",
                    "label": "dagepvp",
                    "icon": "swords",
                    "hidden": true
                }, {
                    "nam": "Dage 1V1!",
                    "desc": "Needs Description!",
                    "warzone": "dage1v1",
                    "label": "dage1v1",
                    "icon": "swords",
                    "hidden": true
                }, {
                    "nam": "Doomwood Arena",
                    "desc": "This arena is for one on one duels.",
                    "warzone": "doomarena",
                    "label": "doomarena",
                    "icon": "swords",
                    "hidden": true
                }];
        public var PVPQueue:Object = {
                "warzone": "",
                "ts": -1,
                "avgWait": -1
            };
        public var PVPResults:Object = {
                "pvpScore": [],
                "team": 0
            };
        public var PVPFactions:Array = [];
        public var bookData:Object;
        public var hasModified:Boolean = false;
        public var frameCopy:Array;
        private var houseFrame:String = "";
        private var houseJson:Object;
        private var finishedCells:Array;
        private var convertTimer:Timer;
        private var activeCell:String;
        public var arrHouseItemQueue:* = [];
        public var ldr_House:URLLoader = new URLLoader();
        private var ticksum:Number = 0;
        private var ticklist:* = new Array();
        private var bfps:Boolean = false;
        private var fpsTS:Number = 0;
        private var fpsQualityCounter:int = 0;
        private var fpsArrayQuality:Array = new Array();
        internal var arrQuality:Array = new Array("LOW", "MEDIUM", "HIGH");

        public var tradeinfo:Object;
        public var auctioninfo:Object;
        public var retrieveinfo:Object;

        public function World(gameRoot:MovieClip)
        {
            this.auctioninfo = {
                    items: [],
                    hasRequested: {}
                };
            this.retrieveinfo = {
                    items: [],
                    hasRequested: {}
                };
            this.tradeinfo = {
                    itemsA: [],
                    itemsB: [],
                    hasRequested: {}
                };
            super();
            rootClass = gameRoot;
            currentInstance = this;
            bankController = new BankController();
            map = new MovieClip();
            this.addChild(map);
            CHARS = new MovieClip();
            var CHARSO:DisplayObject = this.addChild(CHARS);
            CHARS.mouseEnabled = false;
            CHARSO.x = 0;
            CHARSO.y = 0;
            rootClass.ui.monsterIcon.redX.visible = false;
            TRASH = new MovieClip();
            this.addChild(TRASH);
            TRASH.mouseEnabled = false;
            TRASH.visible = false;
            TRASH.y = -1000;
            zManager = new MovieClip();
            this.addChild(zManager);
            FG = new MovieClip();
            this.addChild(FG);
            zManager.removeEventListener(Event.ENTER_FRAME, onZmanagerEnterFrame);
            autoActionTimer.removeEventListener("timer", autoActionHandler);
            restTimer.removeEventListener("timer", restRequest);
            AATestTimer.removeEventListener("timer", AATest);
            connTestTimer.removeEventListener("timer", connTest);
            afkTimer.removeEventListener("timer", afkTimerHandler);
            mvTimer.removeEventListener("timer", mvTimerHandler);
            mapTimer.removeEventListener(TimerEvent.TIMER, mapResizeCheck);
            zManager.addEventListener(Event.ENTER_FRAME, onZmanagerEnterFrame, false, 0, true);
            autoActionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, autoActionHandler);
            restTimer.addEventListener("timer", restRequest);
            AATestTimer.addEventListener("timer", AATest);
            connTestTimer.addEventListener("timer", connTest);
            afkTimer.addEventListener("timer", afkTimerHandler);
            mvTimer.addEventListener("timer", mvTimerHandler);
            mapTimer.addEventListener(TimerEvent.TIMER, mapResizeCheck, false, 0, true);
            mapTimer.start();
            initLoaders();
            initCutscenes();
        }

        public static function get GameRoot():MovieClip
        {
            return (currentInstance.rootClass);
        }

        public static function get Bank():BankController
        {
            return (currentInstance.bankController);
        }

        public function initPatternTree():void
        {
            var o:*;
            for each (o in enhp)
            {
                enhPatternTree[o.ID] = o;
            };
        }

        public function initGuildhallData(gd:Array):void
        {
            var s:*;
            trace(("gd: " + gd));
            var i:uint;
            while (i < gd.length)
            {
                trace(("i: " + i));
                for (s in gd[i])
                {
                    trace(((((("gd[" + i) + "].[") + s) + "]: ") + gd[i][s]));
                };
                i++;
            };
        }

        public function killTimers():void
        {
            autoActionTimer.reset();
            restTimer.reset();
            AATestTimer.reset();
            connTestTimer.reset();
            afkTimer.reset();
            rootClass.chatF.mute.timer.reset();
            autoActionTimer.removeEventListener("timer", autoActionHandler);
            restTimer.removeEventListener("timer", restRequest);
            AATestTimer.removeEventListener("timer", AATest);
            connTestTimer.removeEventListener("timer", connTest);
            afkTimer.removeEventListener("timer", afkTimerHandler);
            mvTimer.removeEventListener("timer", mvTimerHandler);
            rootClass.chatF.mute.timer.removeEventListener("timer", rootClass.chatF.unmuteMe);
        }

        public function killListeners():void
        {
            zManager.removeEventListener(Event.ENTER_FRAME, onZmanagerEnterFrame);
            removeChild(zManager);
        }

        public function queueLoad(loaderData:*):*
        {
            loaderData.retries = 1;
            loaderQueue.push(loaderData);
            var l:* = getFreeLoader();
            if (l != null)
            {
                loadNext(l);
            };
        }

        public function loaderCallback(e:Event):*
        {
            var ldr:* = e.target;
            var l:* = getLoaderHost(ldr);
            if (l != null)
            {
                if (l.callBackA != null)
                {
                    l.callBackA(e);
                };
            };
            closeLoader(l, true);
        }

        public function loaderHTTP(e:HTTPStatusEvent):void
        {
            var l:*;
            var str:String;
            if (((!(e.status == 200)) && (rootClass.litePreference.data.bDebugger)))
            {
                l = getLoaderHostByLoaderInfo(e.currentTarget);
                trace(((("Loader queue http request: " + l.url) + ";") + e.status));
                str = ((("Queue: " + l.url) + ";") + e.status);
                rootClass.debugMessage(str);
                closeLoader(l, false, false);
            };
        }

        public function loaderErrorHandler(e:IOErrorEvent):*
        {
            var s:String = e.toString();
            var u:String = s.substr((s.indexOf("URL: ") + 5));
            u = u.substr(0, (u.length - 1));
            var l:* = getLoaderHostByURL(u);
            rootClass.debugMessage(((("Failed to load, Linkage: " + l.loaderData.sES) + ", File: ") + l.loaderData.sFile));
            if (l != null)
            {
                if (l.callBackB != null)
                {
                    l.callBackB(e);
                };
            };
            closeLoader(l, false, false);
        }

        private function loaderProgressHandler(e:Event):*
        {
            var loaderInfo:* = e.currentTarget;
            var l:* = getLoaderHostByLoaderInfo(loaderInfo);
            if (l != null)
            {
                l.isOpen = true;
            };
        }

        private function loaderTimerComplete(e:TimerEvent):void
        {
            var l:* = getLoaderHostByTimer(Timer(e.currentTarget));
            if (l != null)
            {
                l.timer.reset();
                if (!l.isOpen)
                {
                    if (l.loaderData.retries-- > 0)
                    {
                        loaderQueue.push(l.loaderData);
                    };
                    closeLoader(l, false, true);
                };
            };
        }

        public function getLoaderHost(ldr:*):*
        {
            var i:*;
            for (i in loaderManager)
            {
                if (loaderManager[i].ldr == ldr)
                {
                    return (loaderManager[i]);
                };
            };
            return (null);
        }

        public function getLoaderHostByLoaderInfo(_loaderInfo:*):Object
        {
            var i:*;
            for (i in loaderManager)
            {
                if (loaderManager[i].ldr == _loaderInfo)
                {
                    return (loaderManager[i]);
                };
            };
            return (null);
        }

        public function getLoaderHostByTimer(t:Timer):Object
        {
            var i:*;
            for (i in loaderManager)
            {
                if (loaderManager[i].timer == t)
                {
                    return (loaderManager[i]);
                };
            };
            return (null);
        }

        public function getLoaderHostByURL(u:String):Object
        {
            var i:*;
            for (i in loaderManager)
            {
                if (u.indexOf(loaderManager[i].url) > -1)
                {
                    return (loaderManager[i]);
                };
            };
            return (null);
        }

        public function getFreeLoader():Object
        {
            var i:*;
            if (loaderQueue.length > 0)
            {
                for (i in loaderManager)
                {
                    if (loaderManager[i].free)
                    {
                        loaderManager[i].free = false;
                        return (loaderManager[i]);
                    };
                };
                return (null);
            };
            return (null);
        }

        public function closeLoader(ldrObj:Object, isOK:Boolean = true, isLoaded:Boolean = true, doNext:Boolean = true):void
        {
            if (isLoaded)
            {
                try
                {
                    ldrObj.ldr.unload();
                }
                catch (e:Error)
                {
                };
            };
            ldrObj.free = true;
            ldrObj.isOpen = false;
            ldrObj.loaderData = null;
            ldrObj.timer.reset();
            var l:* = getFreeLoader();
            if (((!(l == null)) && (doNext)))
            {
                loadNext(l);
            };
        }

        public function initLoaders():void
        {
            var lmi:Object;
            var i:*;
            for (i in loaderManager)
            {
                lmi = loaderManager[i];
                lmi.timer.addEventListener(TimerEvent.TIMER_COMPLETE, loaderTimerComplete, false, 0, true);
                lmi.ldr.addEventListener(Event.COMPLETE, loaderCallback, false, 0, true);
                lmi.ldr.addEventListener(IOErrorEvent.IO_ERROR, loaderErrorHandler, false, 0, true);
                lmi.ldr.addEventListener(HTTPStatusEvent.HTTP_STATUS, loaderHTTP, false, 0, true);
                lmi.ldr.addEventListener(ProgressEvent.PROGRESS, loaderProgressHandler, false, 0, true);
            };
        }

        public function clearLoaders(clearPlayerDomains:Boolean = false):*
        {
            var lmi:Object;
            var i:* = undefined;
            for (i in loaderManager)
            {
                lmi = loaderManager[i];
                try
                {
                    lmi.ldr.close();
                }
                catch (e:Error)
                {
                };
                try
                {
                    lmi.ldr.unload();
                }
                catch (e:Error)
                {
                };
                lmi.free = true;
                lmi.isOpen = false;
                lmi.loaderData = null;
                lmi.timer.reset();
                lmi.callBackA = null;
                lmi.callBackB = null;
            };
            if (clearPlayerDomains)
            {
                playerDomains = {};
            };
            loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
            loaderC = new LoaderContext(false, loaderD);
            loaderC.checkPolicyFile = false;
            loaderC.allowCodeImport = true;
            loaderQueue = [];
        }

        public function killLoaders():*
        {
            var lmi:Object;
            var i:*;
            for (i in loaderManager)
            {
                lmi = loaderManager[i];
                lmi.free = true;
                lmi.isOpen = false;
                lmi.loaderData = null;
                lmi.timer.reset();
                lmi.callBackA = null;
                lmi.callBackB = null;
            };
            loaderQueue = [];
        }

        public function loadNext(l:Object):*
        {
            if (loaderQueue.length > 0)
            {
                loadNextWith(l, loaderQueue.shift());
            };
        }

        private function loadNextWith(l:Object, loaderData:Object):void
        {
            var u:URLRequest;
            var c:LoaderContext = loaderC;
            c.checkPolicyFile = false;
            c.allowCodeImport = true;
            if (l != null)
            {
                l.free = false;
                if (loaderData.callBackA != null)
                {
                    l.callBackA = loaderData.callBackA;
                }
                else
                {
                    l.callBackA = null;
                };
                if (loaderData.callBackB != null)
                {
                    l.callBackB = loaderData.callBackB;
                }
                else
                {
                    l.callBackB = null;
                };
                if ((((!(loaderData.avt == null)) && (loaderData.avt == myAvatar)) && (!(loaderData.sES == null))))
                {
                    c = mapPlayerAssetClass(loaderData.sES);
                };
                u = new URLRequest(loaderData.strFile);
                l.ldr.dataFormat = URLLoaderDataFormat.BINARY;
                l.ldr.load(u);
                l.url = u.url;
                l.isOpen = false;
                l.loaderData = loaderData;
                l.timer.reset();
                l.timer.start();
            }
            else
            {
                trace();
                trace("** No available loader found, event flow may terminate");
                trace();
            };
        }

        private function mapPlayerAssetClass(sES:String):LoaderContext
        {
            if (playerDomains[sES] == null)
            {
                playerDomains[sES] = {};
                playerDomains[sES].loaderD = new ApplicationDomain(ApplicationDomain.currentDomain);
                playerDomains[sES].loaderC = new LoaderContext(false, playerDomains[sES].loaderD);
                playerDomains[sES].loaderC.checkPolicyFile = false;
                playerDomains[sES].loaderC.allowCodeImport = true;
            };
            return (playerDomains[sES].loaderC);
        }

        public function getClass(assetLinkageID:String):Class
        {
            var c:Class;
            var sES:String;
            var o:Object = {};
            try
            {
                c = (getDefinitionByName(assetLinkageID) as Class);
                if (c != null)
                {
                    return (c);
                };
            }
            catch (e:Error)
            {
            };
            try
            {
                c = (rootClass.assetsDomain.getDefinition(assetLinkageID) as Class);
                if (c != null)
                {
                    return (c);
                };
            }
            catch (e:Error)
            {
            };
            try
            {
                c = (loaderD.getDefinition(assetLinkageID) as Class);
                if (c != null)
                {
                    return (c);
                };
            }
            catch (e:Error)
            {
            };
            for (sES in playerDomains)
            {
                if (playerDomains[sES].loaderD.hasDefinition(assetLinkageID))
                {
                    return (playerDomains[sES].loaderD.getDefinition(assetLinkageID) as Class);
                };
            };
            trace((("getClass() could not find " + assetLinkageID) + "!"));
            if (!rootClass.litePreference.data.dOptions["debugLinkage"])
            {
                rootClass.debugMessage(("Failed to find Linkage: " + assetLinkageID));
            };
            return (null);
        }

        public function loadMap(strFilename:String):*
        {
            if (strFilename.indexOf("cdn.aq.com") == -1)
            {
                strFilename = ((rootClass.getFilePath() + "maps/") + strFilename);
            };
            trace(("loadMap: " + strFilename));
            rootClass.mcConnDetail.showConn("Loading Map Files...");
            if (map != null)
            {
                map.gotoAndStop("Wait");
                this.removeChild(map);
                map = null;
            };
            ldr_map = new URLLoader(new URLRequest(strFilename));
            ldr_map.dataFormat = URLLoaderDataFormat.BINARY;
            ldr_map.addEventListener(IOErrorEvent.IO_ERROR, this.onMapLoadError, false, 0, true);
            ldr_map.addEventListener(ProgressEvent.PROGRESS, this.onMapLoadProgress, false, 0, true);
            ldr_map.addEventListener(Event.COMPLETE, rootClass.onLoadMaster(onMapLoadComplete, loaderC));
            /*ldr_map.contentLoaderInfo.removeEventListener(Event.COMPLETE, onMapLoadComplete);
            ldr_map.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onMapLoadError);
            ldr_map.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onMapHTTPError);
            ldr_map.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onMapLoadProgress);
            ldr_map = new Loader();
            ldr_map.contentLoaderInfo.addEventListener(Event.COMPLETE, onMapLoadComplete, false, 0, true);
            ldr_map.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onMapLoadError, false, 0, true);
            ldr_map.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onMapHTTPError, false, 0, true);
            ldr_map.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onMapLoadProgress, false, 0, true);
            ldr_map.load(new URLRequest(strFilename));*/
            rootClass.clearPopups();
        }

        public function removeMapListeners():void
        {
            ldr_map.removeEventListener(Event.COMPLETE, rootClass.onLoadMaster(onMapLoadComplete, loaderC));
            ldr_map.removeEventListener(IOErrorEvent.IO_ERROR, this.onMapLoadError);
            ldr_map.removeEventListener(ProgressEvent.PROGRESS, this.onMapLoadProgress);
            /*ldr_map.contentLoaderInfo.removeEventListener(Event.COMPLETE, onMapLoadComplete);
            ldr_map.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onMapLoadError);
            ldr_map.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, onMapHTTPError);
            ldr_map.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onMapLoadProgress);*/
        }

        private function onMapHTTPError(e:HTTPStatusEvent):void
        {
            var str:String;
            if (((!(e.status == 200)) && (rootClass.litePreference.data.bDebugger)))
            {
                mapLoadInProgress = false;
                trace(("Map http request: " + e.status));
                str = ((("Map File: " + ldr_map.contentLoaderInfo.url) + ";") + e.status);
                rootClass.debugMessage(str);
                removeMapListeners();
                rootClass.mcConnDetail.showError(str);
            };
        }

        private function onMapLoadProgress(evt:ProgressEvent):void
        {
            var percent:int = int(Math.floor(((evt.bytesLoaded / evt.bytesTotal) * 100)));
            rootClass.mcConnDetail.showConn((("Loading Map... " + percent) + "%"));
        }

        private function onMapLoadError(e:IOErrorEvent):*
        {
            trace(("Mapload failed: " + e));
            mapLoadInProgress = false;
            if (rootClass.litePreference.data.bDebugger)
            {
                rootClass.debugMessage(("Failed to load Map: " + e));
            }
            else
            {
                rootClass.mcConnDetail.showError("Loading Map Files... Failed!");
            };
        }

        private function onMapLoadComplete(e:Event):*
        {
            trace(("Mapload complete: " + e));
            trace(e.target.url);
            rootClass.ui.visible = true;
            mapLoadInProgress = false;
            // map = MovieClip(ldr_map.content);
            map = MovieClip(Loader(e.target.loader).content);
            addChildAt(map, 0).x = 0;
            CHARS.x = 0;
            resetSpawnPoint();
            if (((!(mondef == null)) && (mondef.length)))
            {
                initMonsters(mondef, monmap);
            }
            else
            {
                enterMap();
            };
            if (isMyHouse())
            {
                rootClass.ui.mcPopup.fOpen("House");
            };
            if (((rootClass.cMenuUI) && (rootClass.cMenuUI.isMenuOpen())))
            {
                rootClass.cMenuUI.reDraw();
            };

            updatePortraitCustomize();
        }

        public function reloadCurrentMap():void
        {
            clearMonstersAndProps();
            loadMap(((strMapFileName + "?") + Math.random()));
        }

        public function enterMap():void
        {
            var uoLeaf:* = uoTreeLeaf(rootClass.sfc.myUserName);
            if (((intType == 0) || (returnInfo == null)))
            {
                trace(((("moving to cell: " + uoLeaf.strFrame) + " pad: ") + uoLeaf.strPad));
                moveToCell(uoLeaf.strFrame, uoLeaf.strPad);
            }
            else
            {
                moveToCell(returnInfo.strCell, returnInfo.strPad);
                returnInfo = null;
            };
            initMapEvents();
            rootClass.mcConnDetail.hideConn();
            if (!rootClass.litePreference.data.bHideUI)
            {
                rootClass.ui.mcInterface.areaList.visible = true;
            };
            if (myAvatar != null)
            {
                rootClass.showPortrait(myAvatar);
            };
        }

        public function setReturnInfo(strMap:String, strCell:String, strPad:String):void
        {
            returnInfo = new Object();
            returnInfo.strMap = strMap;
            returnInfo.strCell = strCell;
            returnInfo.strPad = strPad;
        }

        public function exitCell():void
        {
            mvTimerKill();
            exitCombat();
            rootClass.clearPopups(["House"]);
            if (myAvatar != null)
            {
                myAvatar.targets = {};
                if (myAvatar.pMC != null)
                {
                    myAvatar.pMC.stopWalking();
                };
                if (myAvatar.petMC != null)
                {
                    myAvatar.petMC.stopWalking();
                };
                if (myAvatar.target != null)
                {
                    setTarget(null);
                };
            };
            if (strFrame != "Wait")
            {
                clearMonstersAndProps();
                hideAllAvatars();
            };
            rootClass.sfcSocial = false;
            rootClass.ui.mcInterface.areaList.gotoAndStop("init");
        }

        public function moveToCell(strF:String, strP:String, silent:Boolean = false):void
        {
            var xtArr:*;
            var uoLeaf:*;
            afkPostpone();
            if ((((objLock == null) || (objLock[strF] == null)) || (objLock[strF] <= intKillCount)))
            {
                if (uoTree[rootClass.sfc.myUserName].freeze == null)
                {
                    xtArr = [];
                    actionReady = false;
                    bitWalk = false;
                    uoLeaf = {};
                    uoLeaf.strFrame = strF;
                    uoLeaf.strPad = strP;
                    if (strP.toLowerCase() != "none")
                    {
                        uoLeaf.tx = 0;
                        uoLeaf.ty = 0;
                    };
                    uoTreeLeafSet(rootClass.sfc.myUserName, uoLeaf);
                    strFrame = strF;
                    strPad = strP;
                    if (((strAreaName.indexOf("battleon") < 0) || (strAreaName.indexOf("battleontown") > -1)))
                    {
                        rootClass.menuClose();
                    };
                    if (!silent)
                    {
                        rootClass.sfc.sendXtMessage("zm", "moveToCell", [strF, strP], "str", curRoom);
                    };
                    exitCell();
                    map.gotoAndPlay("Blank");
                };
            };
        }

        public function moveToCellByIDa(id:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "mtcid", [id], "str", curRoom);
        }

        public function moveToCellByIDb(id:int):void
        {
            var mc:MovieClip;
            var i:int;
            while (i < arrEvent.length)
            {
                mc = (arrEvent[i] as MovieClip);
                if (((("tID" in mc) && (mc.tID == id)) || ((mc.name.indexOf("ia") == 0) && (int(mc.name.substr(2)) == id))))
                {
                    moveToCell(mc.tCell, mc.tPad, true);
                };
                i++;
            };
        }

        public function hideAllAvatars():void
        {
            var i:*;
            for (i in avatars)
            {
                if (((!(avatars[i] == null)) && (!(avatars[i].pMC == null))))
                {
                    avatars[i].hideMC();
                };
            };
        }

        public function clearAllAvatars():void
        {
            var i:String;
            for (i in avatars)
            {
                destroyAvatar(Number(i));
            };
            avatars = new Object();
        }

        public function clearMonstersAndProps():void
        {
            var child:DisplayObject;
            var pad:*;
            var i:int;
            i = 0;
            while (i < CHARS.numChildren)
            {
                child = CHARS.getChildAt(i);
                if (((child.hasOwnProperty("isProp")) && (MovieClip(child).isProp)))
                {
                    CHARS.removeChild(child);
                    i--;
                }
                else
                {
                    if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                    {
                        child.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick);
                        CHARS.removeChild(child);
                        i--;
                    }
                    else
                    {
                        if (((child.hasOwnProperty("isMonster")) && (MovieClip(child).isMonster)))
                        {
                            MovieClip(child).fClose();
                            i--;
                        };
                    };
                };
                i++;
            };
            i = 0;
            while (i < TRASH.numChildren)
            {
                child = TRASH.getChildAt(i);
                if (((child.hasOwnProperty("isMonster")) && (MovieClip(child).isMonster)))
                {
                    MovieClip(child).fClose();
                    i--;
                };
                i++;
            };
            i = 0;
            while (i < monsters.length)
            {
                monsters[i].pMC = null;
                i++;
            };
            while (rootClass.ui.mcPadNames.numChildren)
            {
                pad = rootClass.ui.mcPadNames.getChildAt(0);
                MovieClip(pad).stop();
                rootClass.ui.mcPadNames.removeChild(pad);
            };
        }

        public function setMapEvents(evtArgs:Object):void
        {
            mapEvents = evtArgs;
        }

        public function initMapEvents():void
        {
            if ((("eventUpdate" in map) && (!(mapEvents == null))))
            {
                map.eventUpdate({
                            "cmd": "event",
                            "args": mapEvents
                        });
            };
            mapEvents = null;
        }

        public function setCellMap(o:Object):void
        {
            cellMap = o;
        }

        public function updateCellMap(o:Object):void
        {
            var s:String;
            var mc:MovieClip;
            var p:String;
            var cell:Object = {};
            for (s in cellMap)
            {
                cell = cellMap[s];
                if (((!(cell.ias == null)) && (!(cell.ias[o.ID] == null))))
                {
                    for (p in o)
                    {
                        cell.ias[o.ID][p] = o[p];
                    };
                };
            };
            try
            {
                mc = MovieClip(CHARS.getChildByName(("ia" + o.ID)));
                mc.update();
                return;
            }
            catch (e:Error)
            {
            };
            try
            {
                mc = MovieClip(map.getChildByName(("ia" + o.ID)));
                mc.update();
            }
            catch (e:Error)
            {
            };
        }

        public function onWalkClick():void
        {
            var aura:Object;
            var p:Point;
            var mvPT:* = undefined;
            var cLeaf:Object = myAvatar.dataLeaf;
            for each (aura in cLeaf.auras)
            {
                try
                {
                    if (aura.cat != null)
                    {
                        if (aura.cat == "stun")
                        {
                            return;
                        };
                        if (aura.cat == "stone")
                        {
                            return;
                        };
                        if (aura.cat == "freeze")
                        {
                            return;
                        };
                        if (aura.cat == "disabled")
                        {
                            return;
                        };
                    };
                }
                catch (e:Error)
                {
                    trace(("world.onWalkClick > " + e));
                };
            };
            p = new Point(mouseX, mouseY);
            if (bitWalk)
            {
                afkPostpone();
                if (((((mouseX >= 0) && (mouseX <= 960)) && (mouseY >= 0)) && (mouseY <= 500)))
                {
                    p = CHARS.globalToLocal(p);
                    p.x = Math.round(p.x);
                    p.y = Math.round(p.y);
                    mvPT = myAvatar.pMC.simulateTo(p.x, p.y, WALKSPEED);
                    if (mvPT != null)
                    {
                        myAvatar.pMC.walkTo(mvPT.x, mvPT.y, WALKSPEED);
                        if (bPvP)
                        {
                            pushMove(myAvatar.pMC, mvPT.x, mvPT.y, WALKSPEED);
                        }
                        else
                        {
                            if (clickOnEventTest(mvPT.x, mvPT.y))
                            {
                                pushMove(myAvatar.pMC, mvPT.x, mvPT.y, WALKSPEED);
                            }
                            else
                            {
                                moveRequest({
                                            "mc": myAvatar.pMC,
                                            "tx": mvPT.x,
                                            "ty": mvPT.y,
                                            "sp": WALKSPEED
                                        });
                            };
                        };
                    };
                };
            };
        }

        public function clickOnEventTest(tx:int, ty:int):Boolean
        {
            var shadowR:Rectangle = myAvatar.pMC.shadow.getBounds(this);
            var eventR:Rectangle = new Rectangle();
            shadowR.x = (tx - (shadowR.width / 2));
            shadowR.y = (ty - (shadowR.height / 2));
            var k:int;
            while (k < arrEvent.length)
            {
                eventR = arrEvent[k].shadow.getBounds(this);
                if (shadowR.intersects(eventR))
                {
                    return (true);
                };
                k++;
            };
            return (false);
        }

        public function moveRequest(o:Object):void
        {
            if (!mvTimer.running)
            {
                pushMove(o.mc, o.tx, o.ty, o.sp);
                mvTimer.reset();
                mvTimer.start();
            }
            else
            {
                mvTimerObj = o;
            };
        }

        public function mvTimerHandler(e:TimerEvent):void
        {
            var o:Object = {};
            if (mvTimerObj != null)
            {
                pushMove(mvTimerObj.mc, mvTimerObj.tx, mvTimerObj.ty, mvTimerObj.sp);
                mvTimerObj = null;
                mvTimer.reset();
                mvTimer.start();
            };
        }

        public function mvTimerKill():void
        {
            mvTimer.reset();
            mvTimerObj = null;
        }

        public function pushMove(mc:MovieClip, tx:int, ty:int, sp:int):*
        {
            var uoLeafSet:* = {};
            uoLeafSet.tx = int(tx);
            uoLeafSet.ty = int(ty);
            uoLeafSet.sp = int(sp);
            uoTreeLeafSet(rootClass.sfc.myUserName, uoLeafSet);
            if (bitWalk)
            {
                rootClass.sfc.sendXtMessage("zm", "mv", [tx, ty, sp], "str", curRoom);
            };
        }

        public function monstersToPads():*
        {
            var i:*;
            var mon:*;
            for (i in monsters)
            {
                mon = monsters[i];
                if (((!(mon.objData == null)) && (mon.objData.strFrame == strFrame)))
                {
                    mon.pMC.walkTo(mon.pMC.ox, mon.pMC.oy, (WALKSPEED * 1.4));
                };
            };
        }

        public function updatePadNames():*
        {
            var padN:*;
            var i:int;
            while (i < rootClass.ui.mcPadNames.numChildren)
            {
                padN = MovieClip(rootClass.ui.mcPadNames.getChildAt(i));
                if ((((objLock == null) || (objLock[padN.tCell] == null)) || (objLock[padN.tCell] <= intKillCount)))
                {
                    padN.cnt.lock.visible = false;
                }
                else
                {
                    padN.cnt.lock.visible = true;
                };
                i++;
            };
        }

        public function cellSetup(intScale:Number, intSpeed:Number, strMode:String):void
        {
            var bmp:Bitmap;
            var child:DisplayObject;
            var j:uint;
            var c:DisplayObject;
            var monArr:*;
            var Mons:Array;
            var Mon:Avatar;
            var oref:*;
            trace("cellSetup");
            CELL_MODE = strMode;
            SCALE = intScale;
            WALKSPEED = intSpeed;
            arrSolid = new Array();
            arrEvent = new Array();
            var bmd:BitmapData = new BitmapData(960, 550, true, 0);
            var bma:Array = [];
            trace(("extra: " + objExtra["bMonName"]));
            var monName:* = (Number(objExtra["bMonName"]) == 1);
            var i:int;
            while (i < map.numChildren)
            {
                child = map.getChildAt(i);
                if ((child is MovieClip))
                {
                    if (MovieClip(child).hasPads)
                    {
                        trace("movieclip has pads");
                        j = 0;
                        while (j < MovieClip(child).numChildren)
                        {
                            c = MovieClip(child).getChildAt(j);
                            if ((((c is MovieClip) && (MovieClip(c).isEvent)) && (!(MovieClip(c).isProp))))
                            {
                                arrEvent.push(MovieClip(c));
                            };
                            if (((c is MovieClip) && (MovieClip(c).isSolid)))
                            {
                                arrSolid.push(MovieClip(child));
                            };
                            j++;
                        };
                    };
                };
                if (((child is MovieClip) && (MovieClip(child).isSolid)))
                {
                    arrSolid.push(MovieClip(child));
                };
                if (((child is MovieClip) && ("walk" in child)))
                {
                    MovieClip(child).btnWalkingArea.useHandCursor = false;
                };
                if ((((child is MovieClip) && (MovieClip(child).isEvent)) && (!(MovieClip(child).isProp))))
                {
                    arrEvent.push(MovieClip(child));
                };
                if (((child is MovieClip) && (MovieClip(child).isMonster)))
                {
                    monArr = [];
                    Mons = getMonsters(MovieClip(child).MonMapID);
                    for each (Mon in Mons)
                    {
                        if (Mon == null)
                        {
                            trace("No Monster Definition found for Pad!");
                        }
                        else
                        {
                            Mon.pMC = createMonsterMC(MovieClip(child), Mon.objData.MonID, monName);
                            Mon.pMC.scale(SCALE);
                            Mon.pMC.pAV = Mon;
                            Mon.pMC.setData();
                            if (Mon.dataLeaf == null)
                            {
                                TRASH.addChild(Mon.pMC);
                            }
                            else
                            {
                                if (rootClass.litePreference.data.bMonsType)
                                {
                                    Mon.pMC.pname.typ.text = (("< " + Mon.pMC.pAV.objData.sRace) + " >");
                                    Mon.pMC.pname.typ.visible = (!(Mon.pMC.pAV.objData.sRace == "None"));
                                }
                                else
                                {
                                    Mon.pMC.pname.typ.visible = false;
                                };
                            };
                        };
                    };
                };
                if (((child is MovieClip) && (MovieClip(child).isProp)))
                {
                    oref = CHARS.addChild(child);
                    if (MovieClip(oref).isEvent)
                    {
                        arrEvent.push(MovieClip(oref));
                        MovieClip(oref).isEvent = false;
                    };
                    i--;
                };
                if ((((((child is MovieClip) && (child.width > 700)) && (!("isSolid" in child))) && (!("walk" in child))) && (!("btnSkip" in child))))
                {
                    MovieClip(child).mouseEnabled = false;
                    MovieClip(child).mouseChildren = false;
                };
                if ((((((child is MovieClip) && (child.width >= 960)) && (!("isSolid" in child))) && (!("walk" in child))) && (!("btnSkip" in child))))
                {
                };
                i++;
            };
            buildBoundingRects();
            if (map.bounds != null)
            {
                mapBoundsMC = (map.getChildByName("bounds") as MovieClip);
            };
            if (!rootClass.litePreference.data.bSmoothBG)
            {
                rebuildMapBMP(map);
            };
            playerInit();
            updateMonsters();
            updatePadNames();
            if (objHouseData != null)
            {
                updateHouseItems();
            };
        }

        private function buildBoundingRects():void
        {
            var r:Rectangle;
            var m:MovieClip;
            var i:int;
            arrEventR = [];
            arrSolidR = [];
            i = 0;
            while (i < arrEvent.length)
            {
                m = arrEvent[i];
                r = m.getBounds(rootClass.stage);
                arrEventR.push(r);
                i++;
            };
            i = 0;
            while (i < arrSolid.length)
            {
                m = arrSolid[i];
                r = m.getBounds(rootClass.stage);
                arrSolidR.push(r);
                i++;
            };
        }

        public function killWalkObjects():void
        {
            var child:DisplayObject;
            var i:int;
            while (i < map.numChildren)
            {
                child = map.getChildAt(i);
                if (((child is MovieClip) && (MovieClip(child).isEvent)))
                {
                    removeEventListener("enter", MovieClip(child).onEnter);
                };
                i++;
            };
        }

        public function exitQuest():void
        {
            if (returnInfo != null)
            {
                rootClass.sfc.sendXtMessage("zm", "cmd", ["tfer", rootClass.sfc.myUserName, returnInfo.strMap, returnInfo.strCell, returnInfo.strPad], "str", curRoom);
            };
        }

        public function gotoTown(strNewMap:String, strSpawnCell:String, strSpawnPad:String):void
        {
            var uoLeaf:* = uoTree[rootClass.sfc.myUserName];
            if (uoLeaf.intState == 0)
            {
                rootClass.chatF.pushMsg("warning", "You are dead!", "SERVER", "", 0);
            }
            else
            {
                if (((!(rootClass.world.myAvatar.invLoaded)) || (!(rootClass.world.myAvatar.pMC.artLoaded()))))
                {
                    rootClass.MsgBox.notify("Character still being loaded.");
                }
                else
                {
                    if (coolDown("tfer"))
                    {
                        rootClass.MsgBox.notify(("Joining " + strNewMap));
                        setReturnInfo(strNewMap, strSpawnCell, strSpawnPad);
                        rootClass.sfc.sendXtMessage("zm", "cmd", ["tfer", rootClass.sfc.myUserName, strNewMap, strSpawnCell, strSpawnPad], "str", curRoom);
                        if (((strAreaName.indexOf("battleon") < 0) || (strAreaName.indexOf("battleontown") > -1)))
                        {
                            rootClass.menuClose();
                        };
                    }
                    else
                    {
                        rootClass.MsgBox.notify("You must wait 5 seconds before joining another map.");
                    };
                };
            };
        }

        public function gotoQuest(strNewMap:String, strSpawnCell:String, strSpawnPad:String):void
        {
            gotoTown(strNewMap, strSpawnCell, strSpawnPad);
        }

        public function openApop(obj:*):*
        {
            var apopmc:MovieClip;
            if (((isMovieFront("Apop")) || ((!("frame" in obj)) || (("frame" in obj) && ("cnt" in obj)))))
            {
                rootClass.menuClose();
                apopmc = attachMovieFront("Apop");
                apopmc.update(obj);
            };
        }

        public function setSpawnPoint(strFrame:*, strPad:*):void
        {
            spawnPoint.strFrame = strFrame;
            spawnPoint.strPad = strPad;
        }

        public function resetSpawnPoint():void
        {
            spawnPoint.strFrame = "Enter";
            spawnPoint.strPad = "Spawn";
        }

        public function initObjExtra(strExtra:String):void
        {
            var arrExtra:Array;
            var i:int;
            var arrVar:Array;
            objExtra = new Object();
            if (((!(strExtra == null)) && (!(strExtra == ""))))
            {
                arrExtra = strExtra.split(",");
                i = 0;
                while (i < arrExtra.length)
                {
                    arrVar = arrExtra[i].split("=");
                    objExtra[arrVar[0]] = arrVar[1];
                    i++;
                };
            };
        }

        public function initObjInfo(sInfo:String):void
        {
            var arrInfo:Array;
            var i:int;
            var arrVar:Array;
            objInfo = new Object();
            if (((!(sInfo == null)) && (!(sInfo == ""))))
            {
                arrInfo = sInfo.split(",");
                i = 0;
                while (i < arrInfo.length)
                {
                    arrVar = arrInfo[i].split("=");
                    objInfo[arrVar[0]] = arrVar[1];
                    i++;
                };
            };
        }

        private function rasterize(a:Array, moveChild:Boolean = false):void
        {
            var o:Object;
            var regP:Point;
            var tMatrix:Matrix;
            var bmpName:String;
            var bmpBG:DisplayObject;
            trace("rasterize");
            mapNW = rootClass.stage.stageWidth;
            trace("line 572");
            var r:Number = (mapNW / mapW);
            var n:int;
            mapNH = Math.round((mapH * r));
            trace("line 577");
            for each (o in a)
            {
                o.child.x = o.x;
                if (o.bmd != null)
                {
                    o.bmd.dispose();
                };
                o.bmd = new BitmapData(mapNW, mapNH, true, 0x999999);
                regP = new Point(0, 0);
                regP = o.child.globalToLocal(regP);
                tMatrix = new Matrix((r * o.child.transform.matrix.a), 0, 0, (r * o.child.transform.matrix.d), -((regP.x * r) * o.child.transform.matrix.a), -((regP.y * r) * o.child.transform.matrix.d));
                o.bmd.draw(o.child, tMatrix, o.child.transform.colorTransform, null, new Rectangle(0, 0, mapNW, mapNH), false);
                o.bm = new Bitmap(o.bmd);
                bmpName = String(("bmp" + n));
                bmpBG = o.child.parent.getChildByName(bmpName);
                if (bmpBG != null)
                {
                    o.child.parent.removeChild(bmpBG);
                };
                o.bmDO = o.child.parent.addChildAt(o.bm, (o.child.parent.getChildIndex(o.child) + 1));
                o.bmDO.name = bmpName;
                o.bmDO.width = mapW;
                o.bmDO.height = mapH;
                o.child.visible = false;
                if (moveChild)
                {
                    o.child.x = (o.child.x + 1200);
                };
                n++;
            };
        }

        private function rebuildMapBMP(mc:MovieClip):void
        {
            var child:MovieClip;
            var i:int;
            clearMapBmps();
            i = 0;
            while (i < mc.numChildren)
            {
                child = (mc.getChildAt(i) as MovieClip);
                if (((((((((((((child is MovieClip) && (child.width >= 960)) && (child.name.toLowerCase().indexOf("bmp") == -1)) && (child.name.toLowerCase().indexOf("cs") == -1)) && (child.name.toLowerCase().indexOf("bounds") == -1)) && (((child as MovieClip) == null) || (MovieClip(child).totalFrames < 15))) && (!("isSolid" in child))) && (!("isFloor" in child))) && (!("isWall" in child))) && (!("walk" in child))) && (!("btnSkip" in child))) && (!("noBmp" in child))))
                {
                    trace(("RASTERIZING " + child.name));
                    mapBmps.push({
                                "child": child,
                                "x": child.x,
                                "bmDO": null
                            });
                };
                i++;
            };
            rasterize(mapBmps);
        }

        private function mapResizeCheck(e:TimerEvent):void
        {
            if (((!(map == null)) && (mapBmps.length > 0)))
            {
                if (mapNW != rootClass.stage.stageWidth)
                {
                    rasterize(mapBmps);
                };
            };
        }

        private function clearMapBmps():void
        {
            var o:Object;
            if (mapBmps.length > 0)
            {
                for each (o in mapBmps)
                {
                    o.bmDO.parent.removeChild(o.bmDO);
                    if (o.bmd != null)
                    {
                        o.bmd.dispose();
                    };
                    o.child = null;
                    o.bmd = null;
                    o.bm = null;
                };
            };
            mapBmps = [];
        }

        public function initMap():mapData
        {
            mData = new mapData(rootClass);
            return (mData);
        }

        public function initCutscenes():cutsceneHandler
        {
            cHandle = new cutsceneHandler(rootClass);
            return (cHandle);
        }

        public function initSound(sClass:Sound):soundController
        {
            sController = new soundController(sClass, rootClass);
            return (sController);
        }

        public function gotoHouse(unm:String):void
        {
            unm = unm.toLowerCase();
            if (((!(objHouseData == null)) && (objHouseData.unm == unm)))
            {
                return;
            };
            rootClass.sfc.sendXtMessage("zm", "house", [unm], "str", 1);
        }

        public function isHouseEquipped():Boolean
        {
            var j:int;
            while (j < myAvatar.houseitems.length)
            {
                if (myAvatar.houseitems[j].bEquip)
                {
                    return (true);
                };
                j++;
            };
            return (false);
        }

        public function isMyHouse():*
        {
            return ((!(objHouseData == null)) && (objHouseData.unm == myAvatar.objData.strUsername.toLowerCase()));
        }

        public function showHouseOptions(mode:String):void
        {
            var mc:MovieClip = rootClass.ui.mcPopup.mcHouseOptions;
            switch (mode)
            {
                case "default":
                case "save":
                default:
                    mc.visible = true;
                    mc.bg.x = 0;
                    mc.cnt.x = 0;
                    mc.tTitle.x = 5;
                    mc.bExpand.x = 190;
                    mc.bg.visible = true;
                    mc.cnt.visible = true;
                    mc.tTitle.visible = true;
                    mc.bExpand.visible = false;
                    break;
                case "hide":
                    mc.visible = true;
                    mc.bg.x = 181;
                    mc.cnt.x = 181;
                    mc.tTitle.x = 186;
                    mc.bExpand.x = 120;
                    mc.bg.visible = false;
                    mc.cnt.visible = false;
                    mc.tTitle.visible = false;
                    mc.bExpand.visible = true;
            };
        }

        public function hideHouseOptions():void
        {
            var i:int;
            var mc:MovieClip = rootClass.ui.mcPopup.mcHouseOptions;
            if (mc.visible)
            {
                i = 0;
                while (i < mc.numChildren)
                {
                    mc.getChildAt(i).x = 190;
                    i++;
                };
            };
            mc.visible = false;
        }

        public function onHouseOptionsDesignClick(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            toggleHouseEdit();
        }

        public function onHouseOptionsSaveClick(e:MouseEvent):void
        {
            if (hasModified)
            {
                rootClass.mixer.playSound("Click");
                saveHouseSetup();
            };
        }

        public function onHouseOptionsHideClick(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            showHouseOptions("hide");
        }

        public function onHouseOptionsExpandClick(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            showHouseOptions("default");
        }

        public function onHouseOptionsFloorClick(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            showHouseInventory(70);
        }

        public function onHouseOptionsWallClick(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            showHouseInventory(72);
        }

        public function onHouseOptionsMiscClick(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            showHouseInventory(73);
        }

        public function onHouseOptionsHouseReset(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            var modal:* = new ModalMC();
            var modalO:* = {};
            modalO.params = {};
            modalO.strBody = "Are you sure you want to reset the entire house?";
            modalO.callback = confirmClear;
            modalO.btns = "dual";
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function confirmClear(e:Object):void
        {
            var i:int;
            var child:DisplayObject;
            if (e.accept)
            {
                i = 0;
                while (i < CHARS.numChildren)
                {
                    child = CHARS.getChildAt(i);
                    if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                    {
                        CHARS.removeChild(child);
                        i--;
                    };
                    i++;
                };
                objHouseData.sHouseInfo = "";
                objHouseData.arrPlacement = new Array();
                initEquippedItems(objHouseData.arrPlacement);
                sendSaveHouseSetup(objHouseData.sHouseInfo);
            };
        }

        public function callbackC(e:Event):void
        {
            trace(e.target.data);
            if (e.target.data == "cleared")
            {
                rootClass.addUpdate("House cleared successfully.");
                rootClass.chatF.pushMsg("server", "House cleared successfully.", "SERVER", "", 0);
                cleanEverything();
            }
            else
            {
                rootClass.chatF.pushMsg("warning", (("Error clearing your house. (CODE: " + e.target.data) + ")"), "SERVER", "", 0);
            };
        }

        public function cleanEverything():void
        {
            var child:DisplayObject;
            var i:int;
            while (i < CHARS.numChildren)
            {
                child = CHARS.getChildAt(i);
                if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                {
                    CHARS.removeChild(child);
                    i--;
                };
                i++;
            };
            objHouseData.sHouseInfo = "";
            objHouseData.sData = new Object();
            objHouseData.arrPlacement = new Array();
            initEquippedItems(objHouseData.arrPlacement);
        }

        public function onHouseOptionsHouseClick(e:MouseEvent):void
        {
            rootClass.mixer.playSound("Click");
            gotoTown("buyhouse", "Enter", "Spawn");
        }

        public function showHouseInventory(id:int):*
        {
            if (myAvatar.houseitems != null)
            {
                sendLoadShopRequest(id);
            };
        }

        public function discardHouseChanges(obj:Object):*
        {
            var child:DisplayObject;
            var i:int;
            var copyChild:*;
            var ctr:int;
            if (obj.accept)
            {
                saveHouseSetup();
            }
            else
            {
                hasModified = false;
                if (rootClass.ui.mcPopup.mcHouseItemHandle.visible)
                {
                    rootClass.ui.mcPopup.mcHouseItemHandle.tgt = null;
                    rootClass.ui.mcPopup.mcHouseItemHandle.x = 1000;
                    rootClass.ui.mcPopup.mcHouseItemHandle.visible = false;
                };
                i = 0;
                while (i < CHARS.numChildren)
                {
                    child = CHARS.getChildAt(i);
                    if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                    {
                        CHARS.removeChild(child);
                        i--;
                    };
                    i++;
                };
                if (isLegacy())
                {
                    i = 0;
                    while (i < objHouseData.arrPlacement.length)
                    {
                        if (strFrame == objHouseData.arrPlacement[i].c)
                        {
                            objHouseData.arrPlacement.splice(i, 1);
                            i--;
                        };
                        i++;
                    };
                    for each (copyChild in frameCopy)
                    {
                        objHouseData.arrPlacement.push(copyChild);
                    };
                }
                else
                {
                    objHouseData.arrPlacement[strFrame] = new Object();
                    objHouseData.arrPlacement[strFrame]["xi"] = new Array();
                    ctr = 0;
                    for each (copyChild in frameCopy)
                    {
                        objHouseData.arrPlacement[strFrame]["xi"].push(copyChild);
                        ctr++;
                    };
                    if (ctr == 0)
                    {
                        objHouseData.arrPlacement[strFrame] = null;
                    };
                };
                updateHouseItems();
            };
            if (((!(hasModified)) && (rootClass.ui.mcPopup.mcHouseMenu.visible)))
            {
                toggleHouseEdit();
            };
        }

        public function toggleHouseEdit():void
        {
            var modal:*;
            var modalO:*;
            var i:int;
            var child:DisplayObject;
            var cell:*;
            if (((isMyHouse()) && (!(myAvatar.houseitems == null))))
            {
                if (rootClass.ui.mcPopup.mcHouseMenu.visible)
                {
                    if (hasModified)
                    {
                        modal = new ModalMC();
                        modalO = {};
                        modalO.params = {};
                        modalO.strBody = "Do you want to Save (Yes) or Undo (No) the room?";
                        modalO.callback = discardHouseChanges;
                        modalO.btns = "dual";
                        rootClass.ui.ModalStack.addChild(modal);
                        modal.init(modalO);
                        return;
                    };
                    rootClass.ui.mcPopup.mcHouseMenu.hideEditMenu();
                    setEditMode(false);
                }
                else
                {
                    if (arrHouseItemQueue.length > 0)
                    {
                        rootClass.showMessageBox("Please wait for your house items to finish loading on your screen before being able to edit them.");
                        return;
                    };
                    if (isLegacy())
                    {
                        frameCopy = new Array();
                        i = 0;
                        while (i < CHARS.numChildren)
                        {
                            child = CHARS.getChildAt(i);
                            if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                            {
                                if (MovieClip(child).isStable)
                                {
                                    frameCopy.push({
                                                "c": strFrame,
                                                "ID": MovieClip(child).ItemID,
                                                "x": child.x,
                                                "y": child.y
                                            });
                                };
                            };
                            i++;
                        };
                    }
                    else
                    {
                        frameCopy = new Array();
                        if (objHouseData.arrPlacement[strFrame])
                        {
                            for each (cell in objHouseData.arrPlacement[strFrame]["xi"])
                            {
                                frameCopy.push(cell);
                            };
                        };
                    };
                    rootClass.ui.mcPopup.mcHouseMenu.showEditMenu();
                    setEditMode(true);
                };
            };
        }

        private function houseBounds(e:Event):void
        {
            if (((((!(isMyHouse())) || (!(strFrame == houseFrame))) || (bitWalk)) || (!(strMapName == "house"))))
            {
                houseFrame = "";
                this.removeEventListener(Event.ENTER_FRAME, houseBounds);
                toggleHouseEdit();
                setEditMode(false);
            };
        }

        public function setEditMode(enabled:Boolean):*
        {
            var player:*;
            if (enabled)
            {
                houseFrame = strFrame;
                for each (player in avatars)
                {
                    if (player.pMC)
                    {
                        player.pMC.visible = false;
                        player.unloadPet();
                    };
                };
                myAvatar.isWorldCamera = true;
                bitWalk = false;
                this.addEventListener(Event.ENTER_FRAME, houseBounds, false, 0, true);
            }
            else
            {
                for each (player in avatars)
                {
                    if (player.pMC)
                    {
                        player.pMC.visible = true;
                        player.loadPet();
                    };
                };
                myAvatar.isWorldCamera = false;
                bitWalk = true;
            };
        }

        public function redeemCode(strCode:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "redeemCode", [strCode], "str", this.curRoom);
        }

        public function sendConvertCoinsToCrystal(amount:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "convertCoinsCrystal", [amount], "str", this.curRoom);
        }

        public function sendConvertCrystalToCoins(amount:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "convertCrystalCoins", [amount], "str", this.curRoom);
        }

        public function loadHouseInventory():*
        {
            rootClass.sfc.sendXtMessage("zm", "loadHouseInventory", [], "str", curRoom);
        }

        public function updateHouseItems():void
        {
            var i:int;
            var houseItem:Object;
            var cell:*;
            if (objHouseData != null)
            {
                if (isMyHouse())
                {
                    initEquippedItems(objHouseData.arrPlacement);
                };
                if (isLegacy())
                {
                    i = 0;
                    while (i < objHouseData.arrPlacement.length)
                    {
                        if (strFrame == objHouseData.arrPlacement[i].c)
                        {
                            houseItem = getHouseItem(objHouseData.arrPlacement[i].ID);
                            if (houseItem != null)
                            {
                                loadHouseItem(houseItem, objHouseData.arrPlacement[i].x, objHouseData.arrPlacement[i].y);
                            };
                        };
                        i++;
                    };
                }
                else
                {
                    for (cell in objHouseData.arrPlacement)
                    {
                        if (strFrame == cell)
                        {
                            if (objHouseData.arrPlacement[cell])
                            {
                                i = 0;
                                while (i < objHouseData.arrPlacement[cell]["xi"].length)
                                {
                                    houseItem = getHouseItem(objHouseData.arrPlacement[cell]["xi"][i]["ID"]);
                                    if (houseItem != null)
                                    {
                                        loadHouseItem(houseItem, objHouseData.arrPlacement[cell]["xi"][i]["x"], objHouseData.arrPlacement[cell]["xi"][i]["y"], objHouseData.arrPlacement[cell]["xi"][i]["f"]);
                                    };
                                    i++;
                                };
                            };
                        };
                    };
                };
            };
        }

        public function attachHouseItem(obj:Object):void
        {
            var AssetClass:Class = (loaderD.getDefinition(obj.item.sLink) as Class);
            var mc:* = new (AssetClass)();
            mc.f = obj.f;
            mc.x = obj.x;
            mc.y = obj.y;
            mc.ItemID = obj.item.ItemID;
            mc.item = obj.item;
            mc.isHouseItem = true;
            mc.isStable = false;
            mc.addEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick, false, 0, true);
            if (mc.f)
            {
                mc.scaleX = (mc.scaleX * -1);
            };
            var child:MovieClip = (CHARS.addChild(mc) as MovieClip);
            child.name = ("mc" + getQualifiedClassName(child));
            houseItemValidate(mc);
        }

        public function onHouseItemClick(e:Event):void
        {
            var mc:MovieClip = (e.currentTarget as MovieClip);
            if (((isMyHouse()) && (rootClass.ui.mcPopup.mcHouseMenu.visible)))
            {
                rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(MovieClip(e.currentTarget));
                rootClass.ui.mcPopup.mcHouseMenu.onHandleMoveClick(e.clone());
            }
            else
            {
                if (((mc.btnButton == null) || (!(mc.btnButton.hasEventListener(MouseEvent.CLICK)))))
                {
                    onWalkClick();
                };
            };
        }

        public function houseItemValidate(mc:MovieClip):void
        {
            var i:int;
            var child:DisplayObject;
            var obj:* = getHouseItem(mc.ItemID);
            if (obj.sType == "Floor Item")
            {
                mc.isStable = false;
                mc.addEventListener(Event.ENTER_FRAME, onHouseItemEnterFrame, false, 0, true);
            }
            else
            {
                if (obj.sType == "Wall Item")
                {
                    mc.isStable = true;
                    i = 0;
                    while (i < map.numChildren)
                    {
                        child = map.getChildAt(i);
                        if ((((child is MovieClip) && (MovieClip(child).isFloor)) && (MovieClip(child).hitTestObject(mc))))
                        {
                            mc.isStable = false;
                            break;
                        };
                        i++;
                    };
                    if (!mc.isStable)
                    {
                        mc.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 150, 0, 0, 0);
                    }
                    else
                    {
                        mc.transform.colorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
                    };
                };
            };
        }

        public function onHouseItemEnterFrame(e:Event):void
        {
            var child:DisplayObject;
            var r:Rectangle;
            var mc:MovieClip = (e.currentTarget as MovieClip);
            if (!mc)
            {
                mc.removeEventListener(Event.ENTER_FRAME, onHouseItemEnterFrame);
            };
            var i:int;
            while (i < map.numChildren)
            {
                child = map.getChildAt(i);
                if ((((child is MovieClip) && (MovieClip(child).isFloor)) && (MovieClip(child).hitTestPoint(mc.x, mc.y))))
                {
                    mc.removeEventListener(Event.ENTER_FRAME, onHouseItemEnterFrame);
                    mc.isStable = true;
                    break;
                };
                i++;
            };
            if (!mc.isStable)
            {
                r = mc.getBounds(rootClass.stage);
                if ((r.y + (r.height / 2)) > 495)
                {
                    mc.isStable = true;
                    mc.y = Math.ceil((r.y - (r.y - mc.y)));
                    mc.removeEventListener(Event.ENTER_FRAME, onHouseItemEnterFrame);
                }
                else
                {
                    mc.y = (mc.y + 10);
                };
                if (rootClass.ui.mcPopup.mcHouseMenu.visible)
                {
                    rootClass.ui.mcPopup.mcHouseMenu.drawItemHandle(mc);
                };
            };
        }

        public function isLegacy():Boolean
        {
            return (true);
        }

        public function initHouseData(obj:Object):void
        {
            objHouseData = obj;
            if (objHouseData != null)
            {
                if (!isLegacy())
                {
                    objHouseData.arrPlacement = objHouseData.sData;
                    rootClass.chatF.pushMsg("server", "You are using JSON", "SERVER", "", 0);
                }
                else
                {
                    objHouseData.arrPlacement = createItemPlacementArray(objHouseData.sHouseInfo);
                };
                verifyItemQty();
            };
        }

        public function initMassConvert():void
        {
            if (objHouseData != null)
            {
                if (objHouseData.sHouseInfo != "")
                {
                    if (isLegacy())
                    {
                        massConvert();
                    };
                };
            };
        }

        public function verifyItemQty():void
        {
            var i:int;
            var ID:*;
            var item:*;
            var cell:*;
            var placementQty:* = {};
            if (isLegacy())
            {
                i = 0;
                while (i < objHouseData.arrPlacement.length)
                {
                    ID = objHouseData.arrPlacement[i].ID;
                    if (placementQty[ID] == null)
                    {
                        placementQty[ID] = 1;
                    }
                    else
                    {
                        placementQty[ID]++;
                    };
                    item = getHouseItem(ID);
                    if (((item == null) || (item.iQty < placementQty[ID])))
                    {
                        rootClass.chatF.pushMsg("warning", ((("Missing " + ((item == null) ? "1" : (placementQty[ID] - item.iQty))) + " of House item #") + ID), "SERVER", "", 0);
                    };
                    i++;
                };
            }
            else
            {
                for (cell in objHouseData.arrPlacement)
                {
                    if (cell == strFrame)
                    {
                        if (objHouseData.arrPlacement[cell])
                        {
                            i = 0;
                            while (i < objHouseData.arrPlacement[cell]["xi"].length)
                            {
                                ID = objHouseData.arrPlacement[cell]["xi"][i]["ID"];
                                if (placementQty[ID] == null)
                                {
                                    placementQty[ID] = 1;
                                }
                                else
                                {
                                    placementQty[ID]++;
                                };
                                item = getHouseItem(ID);
                                if (((item == null) || (item.iQty < placementQty[ID])))
                                {
                                    rootClass.chatF.pushMsg("warning", (("House item #" + ID) + " was not found."), "SERVER", "", 0);
                                };
                                i++;
                            };
                        };
                    };
                };
            };
        }

        public function getHouseItem(ID:int):Object
        {
            var j:int;
            var i:int;
            if (isMyHouse())
            {
                j = 0;
                while (j < myAvatar.houseitems.length)
                {
                    if (myAvatar.houseitems[j].ItemID == ID)
                    {
                        return (myAvatar.houseitems[j]);
                    };
                    j++;
                };
            }
            else
            {
                i = 0;
                while (i < objHouseData.items.length)
                {
                    if (objHouseData.items[i].ItemID == ID)
                    {
                        return (objHouseData.items[i]);
                    };
                    i++;
                };
            };
            return (null);
        }

        public function removeSelectedItem():void
        {
            var mc:MovieClip;
            if (objHouseData.selectedMC == null)
            {
                rootClass.MsgBox.notify("Please selected an item to be removed.");
            }
            else
            {
                mc = objHouseData.selectedMC;
                mc.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick);
                unequipHouseItem(mc.ItemID);
                CHARS.removeChild(mc);
                delete objHouseData.selectedMC;
            };
        }

        public function equipHouse(item:Object):void
        {
            var modal:* = new ModalMC();
            var modalO:* = {};
            modalO.strBody = (("Are you sure you want to equip '" + item.sName) + "'?");
            modalO.params = {"item": item};
            modalO.callback = equipHouseRequest;
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function equipHouseRequest(params:*):void
        {
            if (params.accept)
            {
                rootClass.world.sendEquipItemRequest(params.item);
                rootClass.world.equipHouseByID(params.item.ItemID);
            };
        }

        public function equipHouseByID(ID:int):void
        {
            var j:int;
            while (j < myAvatar.houseitems.length)
            {
                myAvatar.houseitems[j].bEquip = ((myAvatar.houseitems[j].ItemID == ID) ? 1 : 0);
                j++;
            };
            if (rootClass.ui.mcPopup.currentLabel == "HouseInventory")
            {
                MovieClip(rootClass.ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
            };
        }

        public function massConvert():void
        {
            var houseEntry:*;
            houseJson = new Object();
            for each (houseEntry in createItemPlacementArray(objHouseData.sHouseInfo))
            {
                if (!frameExists(houseEntry.c))
                {
                    trace(("Skipping frame " + houseEntry.c));
                }
                else
                {
                    if (!houseJson.hasOwnProperty(houseEntry.c))
                    {
                        houseJson[houseEntry.c] = new Object();
                        houseJson[houseEntry.c]["xi"] = new Array();
                    };
                    houseJson[houseEntry.c]["xi"].push({
                                "ID": parseInt(houseEntry.ID),
                                "x": parseInt(houseEntry.x),
                                "y": parseInt(houseEntry.y)
                            });
                };
            };
            finishedCells = new Array();
            retrieveUnsentCell();
            convertTimer = new Timer(500, 1);
            convertTimer.addEventListener(TimerEvent.TIMER, onSendConvert, false, 0, true);
            convertTimer.start();
        }

        public function retrieveUnsentCell():void
        {
            var cellEntry:*;
            for (cellEntry in houseJson)
            {
                trace(("Cell? " + cellEntry));
                if (finishedCells.indexOf(cellEntry) == -1)
                {
                    activeCell = cellEntry;
                    trace(("Working on frame: " + cellEntry));
                    finishedCells.push(cellEntry);
                    return;
                };
            };
            trace("No more frames found");
            if (convertTimer)
            {
                convertTimer.removeEventListener(TimerEvent.TIMER, onSendConvert);
                convertTimer.reset();
                convertTimer = null;
            };
        }

        public function onSendConvert(e:TimerEvent):void
        {
            var entry:*;
            rootClass.mcConnDetail.showConn((("Converting frame " + activeCell) + " from legacy house data..."), false, true);
            rootClass.chatF.pushMsg("server", (("Saving room " + activeCell) + "..."), "SERVER", "", 0);
            rootClass.requestAPI("HouseSaveRoom", {
                        "frame": activeCell,
                        "layout": houseJson[activeCell]
                    }, callbackA, callbackB, true);
            for each (entry in houseJson[activeCell]["xi"])
            {
                trace(((((((activeCell + " | ") + entry.ID) + ", ") + entry.x) + ", ") + entry.y));
            };
            retrieveUnsentCell();
        }

        public function saveHouseSetup():void
        {
            var i:int;
            var child:DisplayObject;
            var strNewSetup:String;
            var cellObj:Object;
            var childData:*;
            i = 0;
            while (i < CHARS.numChildren)
            {
                child = CHARS.getChildAt(i);
                if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                {
                    if (!MovieClip(child).isStable)
                    {
                        rootClass.showMessageBox((MovieClip(child).item.sName + " is not properly placed!"));
                        return;
                    };
                };
                i++;
            };
            if (isLegacy())
            {
                i = 0;
                while (i < objHouseData.arrPlacement.length)
                {
                    if (strFrame == objHouseData.arrPlacement[i].c)
                    {
                        objHouseData.arrPlacement.splice(i, 1);
                        i--;
                    };
                    i++;
                };
                i = 0;
                while (i < CHARS.numChildren)
                {
                    child = CHARS.getChildAt(i);
                    if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                    {
                        if (MovieClip(child).isStable)
                        {
                            objHouseData.arrPlacement.push({
                                        "c": strFrame,
                                        "ID": MovieClip(child).ItemID,
                                        "x": child.x,
                                        "y": child.y
                                    });
                        }
                        else
                        {
                            rootClass.chatF.pushMsg("warning", (MovieClip(child).item.sName + " was removed for being in an invalid position."), "SERVER", "", 0);
                            unequipHouseItem(MovieClip(child).ItemID);
                            child.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick);
                            CHARS.removeChild(child);
                        };
                    };
                    i++;
                };
                strNewSetup = createItemPlacementString(objHouseData.arrPlacement);
                trace(objHouseData.sHouseInfo);
                trace(strNewSetup);
                if (objHouseData.sHouseInfo != strNewSetup)
                {
                    sendSaveHouseSetup(strNewSetup);
                    objHouseData.sHouseInfo = strNewSetup;
                };
            }
            else
            {
                cellObj = new Object();
                cellObj["xi"] = new Array();
                i = 0;
                while (i < CHARS.numChildren)
                {
                    child = CHARS.getChildAt(i);
                    if (((child.hasOwnProperty("isHouseItem")) && (MovieClip(child).isHouseItem)))
                    {
                        if (MovieClip(child).isStable)
                        {
                            childData = {
                                    "ID": MovieClip(child).ItemID,
                                    "x": child.x,
                                    "y": child.y
                                };
                            if (MovieClip(child).scaleX < 0)
                            {
                                childData["f"] = 1;
                            };
                            cellObj["xi"].push(childData);
                        }
                        else
                        {
                            rootClass.chatF.pushMsg("warning", (MovieClip(child).item.sName + " was removed for being in an invalid position."), "SERVER", "", 0);
                            unequipHouseItem(MovieClip(child).ItemID);
                            child.removeEventListener(MouseEvent.MOUSE_DOWN, onHouseItemClick);
                            CHARS.removeChild(child);
                        };
                    };
                    i++;
                };
                objHouseData.arrPlacement[strFrame] = cellObj;
                rootClass.requestAPI("HouseSaveRoom", {
                            "frame": strFrame,
                            "layout": cellObj
                        }, callbackA, callbackB, true);
            };
            hasModified = false;
        }

        public function callbackA(e:Event):void
        {
            trace(e.target.data);
            if (e.target.data == "success")
            {
                rootClass.addUpdate("House saved successfully.");
                rootClass.chatF.pushMsg("server", "House saved successfully.", "SERVER", "", 0);
                if (convertTimer)
                {
                    convertTimer.start();
                };
            }
            else
            {
                rootClass.chatF.pushMsg("warning", (("Error saving your house. (CODE: " + e.target.data) + ")"), "SERVER", "", 0);
            };
            rootClass.mcConnDetail.hideConn();
        }

        public function callbackB(e:IOErrorEvent):void
        {
            rootClass.chatF.pushMsg("warning", "IOError occurred.", "SERVER", "", 0);
        }

        public function createItemPlacementString(arrPlacement:Array):String
        {
            var i:int;
            var v:*;
            var s:String = "";
            if (arrPlacement.length > 0)
            {
                i = 0;
                while (i < arrPlacement.length)
                {
                    for (v in arrPlacement[i])
                    {
                        s = ((((s + v) + ":") + arrPlacement[i][v]) + ",");
                    };
                    s = s.substring(0, (s.length - 1));
                    s = (s + "|");
                    i++;
                };
                s = s.substring(0, (s.length - 1));
            };
            return (s);
        }

        public function createItemPlacementArray(strPlacement:String):Array
        {
            var arrItems:*;
            var i:int;
            var item:*;
            var pairs:*;
            var j:int;
            var arr:Array = [];
            if (strPlacement.length > 0)
            {
                arrItems = strPlacement.split("|");
                i = 0;
                while (i < arrItems.length)
                {
                    item = {};
                    pairs = arrItems[i].split(",");
                    j = 0;
                    while (j < pairs.length)
                    {
                        item[pairs[j].split(":")[0]] = pairs[j].split(":")[1];
                        j++;
                    };
                    if (getHouseItem(parseInt(item["ID"])) != null)
                    {
                        arr.push(item);
                    };
                    i++;
                };
            };
            return (arr);
        }

        public function sendSaveHouseSetup(sHouseInfo:*):void
        {
            rootClass.sfc.sendXtMessage("zm", "housesave", [sHouseInfo], "str", 1);
        }

        public function frameExists(hiFrame:String):Boolean
        {
            var cell:*;
            for each (cell in rootClass.world.map.currentScene.labels)
            {
                if (cell.name == hiFrame)
                {
                    return (true);
                };
            };
            return (false);
        }

        public function initEquippedItems(arrPlacement:*):void
        {
            var j:int;
            var i:int;
            var cell:*;
            if (!objHouseData)
            {
                return;
            };
            if (isLegacy())
            {
                j = 0;
                while (j < myAvatar.houseitems.length)
                {
                    if (myAvatar.houseitems[j].sType != "House")
                    {
                        myAvatar.houseitems[j].bEquip = 0;
                        i = 0;
                        while (i < arrPlacement.length)
                        {
                            if (((myAvatar.houseitems[j].ItemID == arrPlacement[i].ID) && (frameExists(arrPlacement[i].c))))
                            {
                                myAvatar.houseitems[j].bEquip = (myAvatar.houseitems[j].bEquip + 1);
                            };
                            i++;
                        };
                    };
                    j++;
                };
            }
            else
            {
                j = 0;
                while (j < myAvatar.houseitems.length)
                {
                    if (myAvatar.houseitems[j].sType != "House")
                    {
                        myAvatar.houseitems[j].bEquip = 0;
                        for (cell in arrPlacement)
                        {
                            if (frameExists(cell))
                            {
                                if (arrPlacement[cell])
                                {
                                    i = 0;
                                    while (i < arrPlacement[cell]["xi"].length)
                                    {
                                        if (myAvatar.houseitems[j].ItemID == arrPlacement[cell]["xi"][i].ID)
                                        {
                                            myAvatar.houseitems[j].bEquip = (myAvatar.houseitems[j].bEquip + 1);
                                        };
                                        i++;
                                    };
                                };
                            };
                        };
                    };
                    j++;
                };
            };
        }

        public function initHouseInventory(resObj:*):void
        {
            myAvatar.houseitems = ((resObj.items == null) ? [] : resObj.items);
            initEquippedItems(createItemPlacementArray(resObj.sHouseInfo));
            var a:Array = myAvatar.houseitems;
            var i:int;
            while (i < a.length)
            {
                a[i].iQty = int(a[i].iQty);
                rootClass.world.invTree[a[i].ItemID] = a[i];
                i++;
            };
        }

        public function unequipHouseItem(ID:int):void
        {
            var j:int;
            while (j < myAvatar.houseitems.length)
            {
                if (myAvatar.houseitems[j].ItemID == ID)
                {
                    myAvatar.houseitems[j].bEquip--;
                };
                j++;
            };
        }

        public function loadHouseItem(item:Object, x:int, y:int, f:int = 0):void
        {
            try
            {
                attachHouseItem({
                            "item": item,
                            "x": x,
                            "y": y,
                            "f": f
                        });
            }
            catch (err:Error)
            {
                arrHouseItemQueue.push({
                            "item": item,
                            "typ": "A",
                            "x": x,
                            "y": y,
                            "f": f
                        });
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItem();
                };
            };
        }

        public function loadNextHouseItem():void
        {
            ldr_House.dataFormat = URLLoaderDataFormat.BINARY;
            ldr_House.load(new URLRequest(rootClass.getFilePath() + arrHouseItemQueue[0].item.sFile));
            if (!ldr_House.hasEventListener(Event.COMPLETE))
            {
                ldr_House.addEventListener(Event.COMPLETE, rootClass.onLoadMaster(onHouseItemComplete, loaderC));
                ldr_House.addEventListener(IOErrorEvent.IO_ERROR, onHouseItemError);
            };
        }

        public function onHouseItemError(e:IOErrorEvent):void
        {
            rootClass.debugMessage(e.text);
            var loaderEntry:* = arrHouseItemQueue[0];
            if (loaderEntry.typ == "A")
            {
                arrHouseItemQueue.splice(0, 1);
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItem();
                };
            }
            else
            {
                arrHouseItemQueue.splice(0, 1);
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItemB();
                };
            };
        }

        public function onHouseItemComplete(e:Event):void
        {
            var loaderEntry:* = arrHouseItemQueue[0];
            if (loaderEntry.typ == "A")
            {
                attachHouseItem(loaderEntry);
                arrHouseItemQueue.splice(0, 1);
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItem();
                };
            }
            else
            {
                rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem(loaderEntry);
                arrHouseItemQueue.splice(0, 1);
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItemB();
                };
            };
        }

        public function loadHouseItemB(item:Object):void
        {
            try
            {
                rootClass.ui.mcPopup.mcHouseMenu.previewHouseItem({"item": item});
            }
            catch (err:Error)
            {
                rootClass.ui.mcPopup.mcHouseMenu.preview.t2.visible = true;
                rootClass.ui.mcPopup.mcHouseMenu.preview.cnt.visible = false;
                rootClass.ui.mcPopup.mcHouseMenu.preview.bAdd.visible = false;
                arrHouseItemQueue.push({
                            "item": item,
                            "typ": "B"
                        });
                if (arrHouseItemQueue.length > 0)
                {
                    loadNextHouseItemB();
                };
            };
        }

        public function loadNextHouseItemB():void
        {
            var item:Object = arrHouseItemQueue[0].item;
            var s:String = item.sFile;
            if (item.sType == "House")
            {
                s = (("maps/" + item.sFile.substr(0, -4)) + "_preview.swf");
            };
            ldr_House.dataFormat = URLLoaderDataFormat.BINARY;
            ldr_House.load(new URLRequest(rootClass.getFilePath() + s));
            if (!ldr_House.hasEventListener(Event.COMPLETE))
            {
                ldr_House.addEventListener(Event.COMPLETE, rootClass.onLoadMaster(onHouseItemComplete, loaderC));
                ldr_House.addEventListener(IOErrorEvent.IO_ERROR, onHouseItemError);
            };
        }

        public function playerInit():*
        {
            var s:*;
            var userList:*;
            var i:*;
            var a:Array;
            var uid:int;
            trace("------------------------------ Player Init");
            trace((" > " + rootClass.sfc.ipAddress));
            trace(("sfc: " + rootClass.sfc));
            var roomList:* = rootClass.sfc.getAllRooms();
            for (s in roomList)
            {
                trace(("s: " + s));
            };
            trace(("getroom: " + rootClass.sfc.getRoom(curRoom)));
            userList = rootClass.sfc.getRoom(curRoom).getUserList();
            trace("line 6");
            a = [];
            uid = 0;
            for (i in userList)
            {
                a.push(userList[i].getId());
            };
            if (a.length > 0)
            {
                objectByIDArray(a);
            };
            myAvatar = avatars[rootClass.sfc.myUserId];
            trace(("line 27: " + myAvatar));
            myAvatar.isMyAvatar = true;
            myAvatar.pMC.disablePNameMouse();
            rootClass.sfcSocial = true;
        }

        public function objectByIDArray(a:Array):*
        {
            var i:int;
            var uid:int;
            var uo:*;
            var unm:String;
            var uoLeaf:Object;
            var strF:String;
            trace("** WORLD objectByIDArray >");
            var b:Array = [];
            i = 0;
            while (i < a.length)
            {
                uid = a[i];
                uoLeaf = getUoLeafById(uid);
                if (uoLeaf != null)
                {
                    unm = uoLeaf.uoName;
                    strF = String(uoLeaf.strFrame);
                    if (uid == rootClass.sfc.myUserId)
                    {
                        strF = strFrame;
                    };
                    if (avatars[uid] == null)
                    {
                        avatars[uid] = new Avatar(rootClass);
                        avatars[uid].uid = uid;
                        avatars[uid].pnm = unm;
                    };
                    avatars[uid].dataLeaf = uoLeaf;
                    if (((avatars[uid].pMC == null) && (strF == strFrame)))
                    {
                        avatars[uid].pMC = createAvatarMC(uid);
                        b.push(uid);
                    };
                    updateUserDisplay(uid);
                }
                else
                {
                    trace(("login failed for uid: " + uid));
                };
                i++;
            };
            if (b.length > 0)
            {
                getUserDataByIds(b);
            };
        }

        public function objectByID(uid:Number):*
        {
            var unm:*;
            var strF:*;
            trace("** WORLD objectByID >");
            var uoLeaf:* = getUoLeafById(uid);
            if (uoLeaf != null)
            {
                unm = uoLeaf.uoName;
                trace((" unm : " + unm));
                strF = String(uoLeaf.strFrame);
                if (uid == rootClass.sfc.myUserId)
                {
                    strF = strFrame;
                };
                if (avatars[uid] == null)
                {
                    avatars[uid] = new Avatar(rootClass);
                    avatars[uid].uid = uid;
                    avatars[uid].pnm = unm;
                };
                avatars[uid].dataLeaf = uoLeaf;
                if (((avatars[uid].pMC == null) && (strF == strFrame)))
                {
                    avatars[uid].pMC = createAvatarMC(uid);
                    getUserDataById(uid);
                };
                updateUserDisplay(uid);
            };
        }

        public function createAvatarMC(uid:Number):AvatarMC
        {
            trace("** WORLD createAvatarMC >");
            var _local_2:AvatarMC = new AvatarMC();
            _local_2.name = ("a" + uid);
            _local_2.x = -600;
            _local_2.y = 0;
            _local_2.pAV = avatars[uid];
            _local_2.world = this;
            return (_local_2);
        }

        public function destroyAvatar(uid:Number):*
        {
            if (avatars[uid] != null)
            {
                if (avatars[uid].pMC != null)
                {
                    if (!avatars[uid].isMyAvatar)
                    {
                        avatars[uid].pMC.fClose();
                        delete avatars[uid];
                    };
                };
            };
        }

        public function updateUserDisplay(uid:Number):*
        {
            var intState:*;
            var spawnPad:*;
            var pt:*;
            trace(("** WORLD updateUserDisplay > " + uid));
            var umc:* = getMCByUserID(uid);
            var uoLeaf:* = getUoLeafById(uid);
            var strF:* = String(uoLeaf.strFrame);
            if (strF == strFrame)
            {
                umc.tx = int(uoLeaf.tx);
                umc.ty = int(uoLeaf.ty);
                intState = int(uoLeaf.intState);
                spawnPad = null;
                if (((("strPad" in uoLeaf) && (!(uoLeaf.strPad.toLowerCase() == "none"))) && (uoLeaf.strPad in map)))
                {
                    spawnPad = map[uoLeaf.strPad];
                };
                if (((!(umc.tx == 0)) || (!(umc.ty == 0))))
                {
                    if (!testTxTy(new Point(umc.tx, umc.ty), umc))
                    {
                        pt = solveTxTy(new Point(umc.tx, umc.ty), umc);
                        if (pt != null)
                        {
                            umc.x = pt.x;
                            umc.y = pt.y;
                        }
                        else
                        {
                            umc.x = int((960 / 2));
                            umc.y = int((550 / 2));
                        };
                    }
                    else
                    {
                        umc.x = umc.tx;
                        umc.y = umc.ty;
                    };
                }
                else
                {
                    if (spawnPad != null)
                    {
                        umc.x = int(((spawnPad.x + int((Math.random() * 10))) - 5));
                        umc.y = int(((spawnPad.y + int((Math.random() * 10))) - 5));
                    }
                    else
                    {
                        umc.x = int((960 / 2));
                        umc.y = int((550 / 2));
                    };
                };
                umc.scale(SCALE);
                if (intState)
                {
                    umc.mcChar.gotoAndStop("Idle");
                }
                else
                {
                    umc.mcChar.gotoAndStop("Dead");
                };
                if (showHPBar)
                {
                    umc.showHPBar();
                }
                else
                {
                    umc.hideHPBar();
                };
                if (uid == rootClass.sfc.myUserId)
                {
                    bitWalk = true;
                };
                if (((CELL_MODE == "normal") || (uid == rootClass.sfc.myUserId)))
                {
                    umc.pAV.showMC();
                }
                else
                {
                    umc.pAV.hideMC();
                };
                if ((((bPvP) && (!(uoLeaf.pvpTeam == null))) && (uoLeaf.pvpTeam > -1)))
                {
                    umc.mcChar.pvpFlag.visible = true;
                    umc.mcChar.pvpFlag.gotoAndStop(new Array("a", "b", "c")[uoLeaf.pvpTeam]);
                }
                else
                {
                    umc.mcChar.pvpFlag.visible = false;
                };
                if (umc.isLoaded)
                {
                    umc.gotoAndPlay("in2");
                }
                else
                {
                    umc.gotoAndPlay("hold");
                };
                if (umc.isLoaded)
                {
                    umc.pAV.isMyAvatar = (uid == rootClass.sfc.myUserId);
                    umc.handleAfterAvatarLoad();
                };
            };
        }

        public function repairAvatars():void
        {
            var avt:Avatar;
            rootClass.chatF.pushMsg("server", "Attempting to repair incomplete Avatars...", "SERVER", "", 0);
            var isProblem:Boolean;
            for each (avt in avatars)
            {
                if (!avt.pMC.isLoaded)
                {
                    isProblem = true;
                    if (avt.objData != null)
                    {
                        rootClass.chatF.pushMsg("server", (" > repairing " + avt.objData.strUsername), "SERVER", "", 0);
                        avt.initAvatar(avt.objData);
                    }
                    else
                    {
                        if (avt.pnm != null)
                        {
                            rootClass.chatF.pushMsg("warning", ((" *> Data load incomplete for " + avt.pnm) + ", repair cannot continue."), "SERVER", "", 0);
                        }
                        else
                        {
                            rootClass.chatF.pushMsg("warning", " *> Avatar instantiated but no data exists at all!", "SERVER", "", 0);
                        };
                    };
                };
            };
            if (!isProblem)
            {
                rootClass.chatF.pushMsg("server", " > No incomplete Avatars found!", "SERVER", "", 0);
            };
        }

        private function solveTxTy(po:Point, umc:MovieClip):Point
        {
            var pt:Point;
            var pf:Point;
            var j:int;
            var step:int = 20;
            var xs:int = int((960 / step));
            var ys:int = int((550 / step));
            var pArr:Array = [];
            var i:int;
            while (i <= xs)
            {
                j = 0;
                while (j <= ys)
                {
                    pt = new Point((i * step), (j * step));
                    if (testTxTy(pt, umc))
                    {
                        pArr.push({
                                    "x": pt.x,
                                    "y": pt.y,
                                    "d": Math.abs(Point.distance(po, pt))
                                });
                    };
                    j++;
                };
                i++;
            };
            if (pArr.length)
            {
                pArr.sortOn(["d"], [Array.NUMERIC]);
                pf = new Point(((pArr[0].x + int((Math.random() * 10))) - 5), ((pArr[0].y + int((Math.random() * 10))) - 5));
                while ((!(testTxTy(pf, umc))))
                {
                    pf = new Point(((pArr[0].x + int((Math.random() * 10))) - 5), ((pArr[0].y + int((Math.random() * 10))) - 5));
                };
                return (pf);
            };
            return (null);
        }

        private function testTxTy(pt:Point, umc:MovieClip):Boolean
        {
            var sw:int = umc.shadow.width;
            var sh:int = umc.shadow.height;
            var sx:int = int((pt.x - (sw / 2)));
            var sy:int = int((pt.y - (sh / 2)));
            var rs:Rectangle = new Rectangle(sx, sy, sw, sh);
            var rb:Rectangle;
            var mc:MovieClip;
            var pass:Boolean;
            var i:int;
            while (i < arrSolid.length)
            {
                mc = MovieClip(arrSolid[i].shadow);
                rb = new Rectangle(mc.x, mc.y, mc.width, mc.height);
                pass = (!(rb.intersects(rs)));
                i++;
            };
            return (pass);
        }

        public function updatePortrait(avt:Avatar):*
        {
            var avtPortraits:Array;
            var avtPortrait:MovieClip;
            var numStars:int;
            var dataLeaf:*;
            var pVal:*;
            var pMax:*;
            var pBar:*;
            var i:int;
            var j:int;
            if (avt != myAvatar)
            {
                avtPortraits = [rootClass.ui.mcPortraitTarget];
            }
            else
            {
                if (avt == myAvatar.target)
                {
                    avtPortraits = [rootClass.ui.mcPortraitTarget, rootClass.ui.mcPortrait];
                }
                else
                {
                    avtPortraits = [rootClass.ui.mcPortrait];
                };
            };
            i = 0;
            while (i < avtPortraits.length)
            {
                dataLeaf = {};
                avtPortrait = avtPortraits[i];
                avtPortrait.strName.mouseEnabled = false;
                avtPortrait.strClass.mouseEnabled = false;
                if (avt.npcType == "monster")
                {
                    dataLeaf = monTree[avt.objData.MonMapID];
                    avtPortrait.strName.text = avt.objData.strMonName.toUpperCase();
                    avtPortrait.strClass.text = ((avt.objData.sRace != "None") ? avt.objData.sRace : "Monster");
                    if (("stars" in avtPortrait))
                    {
                        numStars = int(Math.round((Math.pow((avt.objData.intLevel * 1.3), 0.5) / 2)));
                        j = 1;
                        while (j < 6)
                        {
                            if (j <= numStars)
                            {
                                avtPortrait.stars.getChildByName(("s" + j)).visible = true;
                            }
                            else
                            {
                                avtPortrait.stars.getChildByName(("s" + j)).visible = false;
                            };
                            j++;
                        };
                    };
                };
                if (avt.npcType == "player")
                {
                    dataLeaf = uoTree[avt.pnm];
                    avtPortrait.strName.text = avt.objData.strUsername.toUpperCase();
                    avtPortrait.strClass.text = ((avt.objData.strClassName + ", Rank ") + avt.objData.iRank);
                    if (("stars" in avtPortrait))
                    {
                        j = 1;
                        while (j < 6)
                        {
                            avtPortrait.stars.getChildByName(("s" + j)).visible = false;
                            j++;
                        };
                    };
                };
                if (((avt.npcType == "monster") || (avt.npcType == "player")))
                {
                    avtPortrait.strLevel.text = avt.objData.intLevel;
                    pVal = 0;
                    pMax = 0;
                    pBar = null;
                    pVal = dataLeaf.intHP;
                    pMax = dataLeaf.intHPMax;
                    pBar = avtPortrait.HP;
                    if (dataLeaf.intHP >= 0)
                    {
                        pBar.strIntHP.text = String(dataLeaf.intHP);
                    }
                    else
                    {
                        pBar.strIntHP.text = "X";
                    };
                    if (pVal < 0)
                    {
                        pVal = 0;
                    };
                    if (pVal > pMax)
                    {
                        pVal = pMax;
                    };
                    pBar.intHPbar.x = Math.min(-(pBar.intHPbar.width * (1 - (pVal / pMax))), 0);
                    pVal = dataLeaf.intMP;
                    pMax = dataLeaf.intMPMax;
                    pBar = avtPortrait.MP;
                    if (dataLeaf.intMP >= 0)
                    {
                        pBar.strIntMP.text = String(dataLeaf.intMP);
                    }
                    else
                    {
                        pBar.strIntMP.text = "X";
                    };
                    if (pVal < 0)
                    {
                        pVal = 0;
                    };
                    if (pVal > pMax)
                    {
                        pVal = pMax;
                    };
                    pBar.intMPbar.x = Math.min(-(pBar.intMPbar.width * (1 - (pVal / pMax))), 0);
                };
                i++;
            };
        }

        public function updatePortraitCustomize():void
        {
            var avt:Avatar;
            avt = rootClass.world.myAvatar;
            if (avt != null)
            {
                avt.initAvatar({"data": avt.objData});
            }
        }

        public function getAvatarByUserID(uid:int):Avatar
        {
            var sID:String = String(uid);
            if ((sID in avatars))
            {
                return (avatars[sID]);
            };
            return (null);
        }

        public function getAvatarByUserName(unm:String):Avatar
        {
            var s:String;
            for (s in avatars)
            {
                if ((((!(avatars[s] == null)) && (!(avatars[s].pnm == null))) && (avatars[s].pnm.toLowerCase() == unm.toLowerCase())))
                {
                    return (avatars[s]);
                };
            };
            return (null);
        }

        public function getMCByUserName(unm:*):AvatarMC
        {
            var s:String;
            for (s in avatars)
            {
                if ((((!(avatars[s] == null)) && (!(avatars[s].pnm == null))) && (avatars[s].pnm.toLowerCase() == unm.toLowerCase())))
                {
                    if (avatars[s].pMC != null)
                    {
                        return (avatars[s].pMC);
                    };
                };
            };
            return (null);
        }

        public function getMCByUserID(uid:*):AvatarMC
        {
            if (((!(avatars[uid] == undefined)) && (!(avatars[uid].pMC == null))))
            {
                return (avatars[uid].pMC);
            };
            return (null);
        }

        public function getUserByName(str:*):*
        {
            var i:*;
            var r:*;
            var j:*;
            var tuo:*;
            var rl:Array = rootClass.sfc.getAllRooms();
            for (i in rl)
            {
                r = rl[i];
                for (j in r.getUserList())
                {
                    tuo = r.getUserList()[j];
                    if (String(tuo.getName()) == str)
                    {
                        return (tuo);
                    };
                };
            };
            return (null);
        }

        public function getUserById(uid:Number):*
        {
            return (rootClass.sfc.getRoom(curRoom).getUser(Number(uid)));
        }

        public function getUoLeafById(uid:*):Object
        {
            var o:Object;
            for each (o in uoTree)
            {
                if (o.entID == uid)
                {
                    return (o);
                };
            };
            return (null);
        }

        public function getUoLeafByName(unm:String):Object
        {
            var o:Object;
            unm = unm.toLowerCase();
            for each (o in uoTree)
            {
                if (o.uoName == unm)
                {
                    return (o);
                };
            };
            return (null);
        }

        public function getUserDataById(uid:*):*
        {
            trace("** WORLD getUserDataById >");
            rootClass.sfc.sendXtMessage("zm", "retrieveUserData", [uid], "str", curRoom);
        }

        public function getUserDataByIds(a:Array):*
        {
            trace("** WORLD getUserDataByIds >");
            rootClass.sfc.sendXtMessage("zm", "retrieveUserDatas", a, "str", curRoom);
        }

        public function getUsersByCell(s:String):Array
        {
            var aID:String;
            var returns:Array = [];
            for (aID in avatars)
            {
                if (avatars[aID].dataLeaf.strFrame == s)
                {
                    returns.push(avatars[aID]);
                };
            };
            return (returns);
        }

        public function getAllAvatarsInCell():Array
        {
            var a:Array = [];
            a = getMonstersByCell(myAvatar.dataLeaf.strFrame);
            a = a.concat(getUsersByCell(myAvatar.dataLeaf.strFrame));
            return (a);
        }

        private function lookAtValue(str:String, index:int):Number
        {
            return (parseInt(str.charAt(index), 36));
        }

        private function updateValue(str:*, index:int, value:Number):String
        {
            var strChar:String;
            if (((value >= 0) && (value < 10)))
            {
                strChar = String(value);
            }
            else
            {
                if (((value >= 10) && (value < 36)))
                {
                    strChar = String.fromCharCode((value + 55));
                }
                else
                {
                    strChar = "0";
                };
            };
            return (rootClass.strSetCharAt(str, index, strChar));
        }

        public function getQuestValue(index:Number):Number
        {
            var res:int;
            var qString:String;
            if (((!(myAvatar == null)) && (!(myAvatar.objData == null))))
            {
                res = int((index / 100));
                qString = ((res > 0) ? ("strQuests" + (res + 1)) : "strQuests");
                if (myAvatar.objData[qString] == null)
                {
                    return (-1);
                };
                return (lookAtValue(myAvatar.objData[qString], (index - (res * 100))));
            };
            return (-1);
        }

        public function setQuestValue(index:Number, value:Number):void
        {
            var res:int = int((index / 100));
            var qString:String = ((res > 0) ? ("strQuests" + (res + 1)) : "strQuests");
            if ((qString in myAvatar.objData))
            {
                myAvatar.objData[qString] = updateValue(myAvatar.objData[qString], (index - (res * 100)), value);
            };
        }

        public function sendUpdateQuestRequest(index:Number, value:Number):void
        {
            rootClass.sfc.sendXtMessage("zm", "updateQuest", [index, value], "str", curRoom);
        }

        public function setHomeTownCurrent():void
        {
            rootClass.sfc.sendXtMessage("zm", "setHomeTown", [], "str", curRoom);
            myAvatar.objData.strHomeTown = myAvatar.objData.strMapName;
        }

        public function setHomeTown(strMapName:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "setHomeTown", [strMapName], "str", curRoom);
            myAvatar.objData.strHomeTown = strMapName;
        }

        private function isHouseOrRegularFull():Boolean
        {
            return (((rootClass.ui.mcPopup.currentLabel == "Bank") && (myAvatar.items.length >= myAvatar.objData.iBagSlots)) || ((rootClass.ui.mcPopup.currentLabel == "HouseBank") && (myAvatar.houseitems.length >= myAvatar.objData.iBagSlots)));
        }

        public function sendBankFromInvRequest(item:Object):*
        {
            var modal:ModalMC;
            var modalO:Object;
            if (item.bEquip)
            {
                modal = new ModalMC();
                modalO = {};
                modalO.strBody = "You must unequip the item before storing it in the bank!";
                modalO.params = {};
                modalO.glow = "red,medium";
                modalO.btns = "mono";
                rootClass.ui.ModalStack.addChild(modal);
                modal.init(modalO);
            }
            else
            {
                if (((item.bCoins == 0) && (myAvatar.iBankCount >= myAvatar.objData.iBankSlots)))
                {
                    modal = new ModalMC();
                    modalO = {};
                    modalO.strBody = "You have exceeded your maximum bank storage for non-AC items!";
                    modalO.params = {};
                    modalO.glow = "red,medium";
                    modalO.btns = "mono";
                    rootClass.ui.ModalStack.addChild(modal);
                    modal.init(modalO);
                }
                else
                {
                    rootClass.sfc.sendXtMessage("zm", "bankFromInv", [item.ItemID, item.CharItemID], "str", curRoom);
                };
            };
        }

        public function sendBankToInvRequest(item:Object):*
        {
            var modal:*;
            var modalO:*;
            if (isHouseOrRegularFull())
            {
                modal = new ModalMC();
                modalO = {};
                modalO.strBody = "You have exceeded your maximum inventory storage!";
                modalO.params = {};
                modalO.glow = "red,medium";
                modalO.btns = "mono";
                rootClass.ui.ModalStack.addChild(modal);
                modal.init(modalO);
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "bankToInv", [item.ItemID, item.CharItemID], "str", curRoom);
            };
        }

        public function sendBankSwapInvRequest(itemB:Object, itemI:Object):*
        {
            var modal:ModalMC;
            var modalO:Object;
            if (itemI.bEquip)
            {
                modal = new ModalMC();
                modalO = {};
                modalO.strBody = "You must unequip the item before storing it in the bank!";
                modalO.params = {};
                modalO.glow = "red,medium";
                modalO.btns = "mono";
                rootClass.ui.ModalStack.addChild(modal);
                modal.init(modalO);
            }
            else
            {
                if ((((itemI.bCoins == 0) && (itemB.bCoins == 1)) && (myAvatar.iBankCount >= myAvatar.objData.iBankSlots)))
                {
                    modal = new ModalMC();
                    modalO = {};
                    modalO.strBody = "You have exceeded your maximum bank storage for non-AC items!";
                    modalO.params = {};
                    modalO.glow = "red,medium";
                    modalO.btns = "mono";
                    rootClass.ui.ModalStack.addChild(modal);
                    modal.init(modalO);
                }
                else
                {
                    rootClass.sfc.sendXtMessage("zm", "bankSwapInv", [itemI.ItemID, itemI.CharItemID, itemB.ItemID, itemB.CharItemID], "str", curRoom);
                };
            };
        }

        public function getInventory(uid:*):*
        {
            rootClass.sfc.sendXtMessage("zm", "retrieveInventory", [uid], "str", curRoom);
        }

        public function sendChangeColorRequest(intColorSkin:int, intColorHair:int, intColorEye:int, HairID:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "changeColor", [intColorSkin, intColorHair, intColorEye, HairID, hairshopinfo.HairShopID], "str", curRoom);
        }

        public function sendChangeArmorColorRequest(intColorBase:int, intColorTrim:int, intColorAccessory:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "changeArmorColor", [intColorBase, intColorTrim, intColorAccessory], "str", curRoom);
        }

        public function sendChangeGuildColorRequest(intColor:int):void
        {
            this.rootClass.sfc.sendXtMessage("zm", "changeGuildColor", [intColor], "str", this.curRoom);
        }

        public function sendChangeUsernameColorRequest(intColor:int):void
        {
            this.rootClass.sfc.sendXtMessage("zm", "changeUsernameColor", [intColor], "str", this.curRoom);
        }

        public function sendLoadBankRequest(sTypes:Array = null):void
        {
            if (sTypes == null || sTypes.length == 0 || sTypes[0] == "*")
            {
                sTypes = ["All"]; // Changed to All explicitly just in case, or we can use *
            };
            bankinfo.addRequestedTypes(sTypes);
            rootClass.sfc.sendXtMessage("zm", "loadBank", sTypes, "str", curRoom);
        }

        public function sendLoadAuctionRequest(sTypes:Array = null):void
        {
            var _local2:String;
            if (sTypes[0] == "*")
            {
                sTypes = ["All"];
            };
            for each (_local2 in sTypes)
            {
                this.auctioninfo.hasRequested[_local2] = true;
            };
            this.rootClass.sfc.sendXtMessage("zm", "loadAuction", sTypes, "str", this.curRoom);
        }

        public function sendLoadRetrieveRequest(sTypes:Array = null):void
        {
            var _local2:String;
            if (sTypes[0] == "*")
            {
                sTypes = ["All"];
            };
            for each (_local2 in sTypes)
            {
                this.retrieveinfo.hasRequested[_local2] = true;
            };
            this.rootClass.sfc.sendXtMessage("zm", "loadRetrieve", sTypes, "str", this.curRoom);
        }

        public function sendReloadShopRequest(intShopID:int):void
        {
            if ((((!(shopinfo == null)) && (shopinfo.ShopID == intShopID)) && (!(shopinfo.bLimited == null))))
            {
                rootClass.sfc.sendXtMessage("zm", "reloadShop", [intShopID], "str", curRoom);
            };
        }

        public function sendLoadShopRequest(intShopID:int):void
        {
            if (((shopinfo == null) || ((!(shopinfo.ShopID == intShopID)) || (shopinfo.bLimited))))
            {
                if (coolDown("loadShop"))
                {
                    rootClass.menuClose();
                    rootClass.sfc.sendXtMessage("zm", "loadShop", [intShopID], "str", curRoom);
                };
            }
            else
            {
                rootClass.menuClose();
                if (shopinfo.bHouse == 1)
                {
                    rootClass.ui.mcPopup.fOpen("HouseShop");
                }
                else
                {
                    if (rootClass.isMergeShop(shopinfo))
                    {
                        rootClass.ui.mcPopup.fOpen("MergeShop");
                    }
                    else
                    {
                        rootClass.ui.mcPopup.fOpen("Shop");
                    };
                };
            };
        }

        public function sendLoadHairShopRequest(intHairShopID:int):void
        {
            if (((hairshopinfo == null) || (!(hairshopinfo.HairShopID == intHairShopID))))
            {
                rootClass.sfc.sendXtMessage("zm", "loadHairShop", [intHairShopID], "str", curRoom);
            }
            else
            {
                rootClass.openCharacterCustomize();
            };
        }

        public function sendLoadEnhShopRequest(intShopID:int):void
        {
            var modal:ModalMC = new ModalMC();
            var modalO:Object = {};
            modalO.strBody = "Old enhancement shops are disabled on the PTR.  Please visit Battleon for the new shops.";
            modalO.params = {};
            modalO.btns = "mono";
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function sendEnhItemRequest(item:Object):void
        {
            enhItem = item;
            rootClass.sfc.sendXtMessage("zm", "enhanceItem", [item.ItemID, item.EnhID, enhShopID], "str", curRoom);
        }

        public function sendEnhItemRequestShop(item:Object, enh:Object):void
        {
            if (coolDown("buyItem"))
            {
                enhItem = item;
                rootClass.sfc.sendXtMessage("zm", "enhanceItemShop", [item.ItemID, enh.ItemID, shopinfo.ShopID], "str", curRoom);
            };
        }

        public function sendEnhItemRequestLocal(item:Object, enh:Object):void
        {
            if (coolDown("buyItem"))
            {
                enhItem = item;
                rootClass.sfc.sendXtMessage("zm", "enhanceItemLocal", [item.ItemID, enh.ItemID], "str", curRoom);
            };
        }

        public function sendBuyItemRequest(item:Object):void
        {
            if (coolDown("buyItem"))
            {
                if ((item.bStaff == 1) && (myAvatar.objData.intAccessLevel < 40))
                {
                    rootClass.MsgBox.notify("Test Item: Cannot be purchased yet!");
                }
                else if ((!(shopinfo.sField == "")) && (!(getAchievement(shopinfo.sField, shopinfo.iIndex) == 1)))
                {
                    rootClass.MsgBox.notify("Item Locked: Special requirement not met.");
                }
                else if ((item.bUpg == 1) && (!(myAvatar.isUpgraded())))
                {
                    rootClass.showUpgradeWindow();
                }
                else if ((item.FactionID > 1) && (myAvatar.getRep(item.FactionID) < item.iReqRep))
                {
                    rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
                }
                else if (!rootClass.validateArmor(item))
                {
                    rootClass.MsgBox.notify("Item Locked: Class Requirement not met.");
                }
                else if ((item.iQSindex >= 0) && (getQuestValue(item.iQSindex) < int(item.iQSvalue)))
                {
                    rootClass.MsgBox.notify("Item Locked: Quest Requirement not met.");
                }
                else if (((myAvatar.isItemInInventory(item.ItemID)) || (myAvatar.isItemInBank(item.ItemID))) && (myAvatar.isItemStackMaxed(item.ItemID)))
                {
                    rootClass.MsgBox.notify((("You cannot have more than " + item.iStk) + " of that item!"));
                }
                else if ((item.bCoins == 0) && (item.iCost > myAvatar.objData.intGold))
                {
                    rootClass.MsgBox.notify("Insufficient Funds!");
                }
                else if ((item.bCoins == 1) && (item.iCost > myAvatar.objData.intCoins))
                {
                    rootClass.MsgBox.notify("Insufficient Funds!");
                }
                else if ((item.bCrystal == 1) && (item.iCost > myAvatar.objData.intCrystal))
                {
                    rootClass.MsgBox.notify("Insufficient Funds!");
                }
                else if (((!(rootClass.isHouseItem(item))) && (myAvatar.items.length >= myAvatar.objData.iBagSlots)) || ((rootClass.isHouseItem(item)) && (myAvatar.houseitems.length >= myAvatar.objData.iHouseSlots)))
                {
                    rootClass.MsgBox.notify("Inventory Full!");
                }
                else
                {
                    if (((shopBuyItem == null) || (!(shopBuyItem.ShopItemID == item.ShopItemID))))
                    {
                        shopBuyItem = item;
                    };
                    rootClass.sfc.sendXtMessage("zm", "buyItem", [shopBuyItem.ItemID, shopinfo.ShopID, shopBuyItem.ShopItemID], "str", curRoom);
                };
            };
        }

        public function sendBuyAuctionItemRequest(item:Object):void
        {
            if (this.coolDown("buyItem"))
            {
                if ((item.bStaff == 1) && (myAvatar.objData.intAccessLevel < 40))
                {
                    rootClass.MsgBox.notify("Test Item: Cannot be purchased yet!");
                }
                else if ((item.bUpg == 1) && (!(myAvatar.isUpgraded())))
                {
                    rootClass.showUpgradeWindow();
                }
                else if ((item.FactionID > 1) && (myAvatar.getRep(item.FactionID) < item.iReqRep))
                {
                    rootClass.MsgBox.notify("Item Locked: Reputation Requirement not met.");
                }
                else if (!rootClass.validateArmor(item))
                {
                    rootClass.MsgBox.notify("Item Locked: Class Requirement not met.");
                }
                else if ((item.iQSindex >= 0) && (getQuestValue(item.iQSindex) < int(item.iQSvalue)))
                {
                    rootClass.MsgBox.notify("Item Locked: Quest Requirement not met.");
                }
                else if (((myAvatar.isItemInInventory(item.ItemID)) || (myAvatar.isItemInBank(item.ItemID))) && (myAvatar.isItemStackMaxed(item.ItemID)))
                {
                    rootClass.MsgBox.notify((("You cannot have more than " + item.iStk) + " of that item!"));
                }
                else if (((!(rootClass.isHouseItem(item))) && (myAvatar.items.length >= myAvatar.objData.iBagSlots)) || ((rootClass.isHouseItem(item)) && (myAvatar.houseitems.length >= myAvatar.objData.iHouseSlots)))
                {
                    rootClass.MsgBox.notify("Inventory Full!");
                }
                else
                {
                    rootClass.sfc.sendXtMessage("zm", "buyAuctionItem", [item.AuctionID], "str", this.curRoom);
                };
            };
        }

        public function sendSellItemRequest(item:Object):void
        {
            if (coolDown("sellItem"))
            {
                rootClass.sfc.sendXtMessage("zm", "sellItem", [item.ItemID, item.iQty, item.CharItemID], "str", curRoom);
            };
        }

        public function sendRemoveItemRequest(item:Object, iQty:int = 1):void
        {
            if (iQty == 1)
            {
                rootClass.sfc.sendXtMessage("zm", "removeItem", [item.ItemID, item.CharItemID], "str", curRoom);
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "removeItem", [item.ItemID, item.CharItemID, iQty], "str", curRoom);
            };
        }

        public function sendRemoveTempItemRequest(ItemID:int, count:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "removeTempItem", [ItemID, count], "str", curRoom);
            myAvatar.removeTempItem(ItemID, count);
        }

        public function sendEquipItemRequest(item:Object):Boolean
        {
            var isOK:Boolean = true;
            if (((!(item == null)) && (!(myAvatar.isItemEquipped(item.ItemID)))))
            {
                if (coolDown("equipItem"))
                {
                    rootClass.sfc.sendXtMessage("zm", "equipItem", [item.ItemID], "str", curRoom);
                }
                else
                {
                    isOK = false;
                };
            }
            else
            {
                isOK = false;
            };
            return (isOK);
        }

        public function sendForceEquipRequest(intItemID:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "forceEquipItem", [intItemID], "str", curRoom);
        }

        public function sendUnequipItemRequest(item:Object):void
        {
            if (((!(item == null)) && (myAvatar.isItemEquipped(item.ItemID))))
            {
                if (coolDown("unequipItem"))
                {
                    rootClass.sfc.sendXtMessage("zm", "unequipItem", [item.ItemID], "str", curRoom);
                };
            };
        }

        public function sendChangeClassRequest(ClassID:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "changeClass", [ClassID], "str", curRoom);
        }

        public function selfMute(dur:int = 1):void
        {
            rootClass.sfc.sendXtMessage("zm", "cmd", ["mute", dur, myAvatar.objData.strUsername.toLowerCase()], "str", rootClass.world.curRoom);
        }

        public function equipUseableItem(item:Object):void
        {
            var actionObj:Object;
            var invItem:Object;
            var i:int;
            i = 0;
            while (i < actions.active.length)
            {
                if (actions.active[i].ref == "i1")
                {
                    actionObj = actions.active[i];
                };
                i++;
            };
            actionObj.sArg1 = String(item.ItemID);
            actionObj.sArg2 = String(item.sDesc);
            rootClass.updateIcons(getActIcons(actionObj), [item.sFile], item);
            rootClass.updateActionObjIcon(actionObj);
            i = 0;
            while (i < myAvatar.items.length)
            {
                invItem = myAvatar.items[i];
                if (((invItem.sType.toLowerCase() == "item") && (!(invItem.sLink.toLowerCase() == "none"))))
                {
                    if (invItem.ItemID == item.ItemID)
                    {
                        invItem.bEquip = 1;
                        rootClass.sfc.sendXtMessage("zm", "geia", [invItem.sLink, invItem.sMeta], "str", rootClass.world.curRoom);
                    }
                    else
                    {
                        invItem.bEquip = 0;
                    };
                };
                i++;
            };
            if (rootClass.ui.mcPopup.mcInventory != null)
            {
                rootClass.ui.mcPopup.mcInventory.mcItemList.refreshList();
                rootClass.ui.mcPopup.mcInventory.refreshDetail();
            };
        }

        public function unequipUseableItem(item:Object = null):void
        {
            var actionObj:Object;
            var invItem:Object;
            var i:int;
            i = 0;
            while (i < actions.active.length)
            {
                if (actions.active[i].ref == "i1")
                {
                    actionObj = actions.active[i];
                };
                i++;
            };
            actionObj.sArg1 = "";
            actionObj.sArg2 = "";
            rootClass.updateIcons(getActIcons(actionObj), ["icu1"], null);
            if (item == null)
            {
                i = 0;
                while (i < myAvatar.items.length)
                {
                    invItem = myAvatar.items[i];
                    if (String(invItem.ItemID) == actionObj.sArg1)
                    {
                        item = invItem;
                    };
                    i++;
                };
            };
            item.bEquip = 0;
            if (rootClass.ui.mcPopup.mcInventory != null)
            {
                rootClass.ui.mcPopup.mcInventory.mcItemList.refreshList();
                rootClass.ui.mcPopup.mcInventory.refreshDetail();
            };
        }

        public function tryUseItem(item:Object):void
        {
            if (item.sType.toLowerCase() == "clientuse")
            {
                switch (item.sLink)
                {
                };
            }
            else
            {
                if (item.sType.toLowerCase() == "serveruse")
                {
                    sendUseItemRequest(item);
                };
            };
        }

        public function sendUseItemRequest(item:Object):void
        {
            rootClass.sfc.sendXtMessage("zm", "serverUseItem", ["+", item.ItemID], "str", -1);
        }

        public function sendUseItemArrayRequest(arr:Array):void
        {
            rootClass.sfc.sendXtMessage("zm", "serverUseItem", arr, "str", -1);
        }

        public function bankHasRequested(sTypes:Array):Boolean
        {
            return (bankinfo.hasRequested(sTypes));
        }

        public function tradeHasRequested(_arg1:Array):Boolean
        {
            var _local2:String;
            for each (_local2 in _arg1)
            {
                if (!(_local2 in this.tradeinfo.hasRequested))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function auctionHasRequested(_arg1:Array):Boolean
        {
            var _local2:String;
            for each (_local2 in _arg1)
            {
                if (!(_local2 in this.auctioninfo.hasRequested))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function retrieveHasRequested(_arg1:Array):Boolean
        {
            var _local2:String;
            for each (_local2 in _arg1)
            {
                if (!(_local2 in this.retrieveinfo.hasRequested))
                {
                    return (false);
                };
            };
            return (true);
        }

        public function addItemsToBank(items:Array):void
        {
            bankinfo.addItemsToBank(items);
            if (((!(rootClass.ui.mcPopup == null)) && (rootClass.ui.mcPopup.currentLabel == "Bank")))
            {
                if (rootClass.ui.mcPopup.getChildByName("mcBank") != null)
                {
                    rootClass.ui.mcPopup.getChildByName("mcBank").update({"eventType": "refreshBank"});
                };
            };
            if (myAvatar.bank == null)
            {
                myAvatar.bank = [];
            };
        }

        public function addItemsToTradeA(_arg1:Array):void
        {
            var _local3:Object;
            var _local4:Object;
            var _local2:Boolean = true;
            for each (_local3 in _arg1)
            {
                _local2 = true;
                for each (_local4 in this.tradeinfo.itemsA)
                {
                    if (_local4.ItemID == _local3.ItemID)
                    {
                        trace("Existed");
                        _local4.iQty = _local3.iQty;
                        _local2 = false;
                        break;
                    };
                };
                if (_local2)
                {
                    this.tradeinfo.itemsA.push(_local3);
                };
            };
        }

        public function addItemsToTradeB(_arg1:Array):void
        {
            var _local3:Object;
            var _local4:Object;
            var _local2:Boolean = true;
            for each (_local3 in _arg1)
            {
                _local2 = true;
                for each (_local4 in this.tradeinfo.itemsB)
                {
                    if (_local4.ItemID == _local3.ItemID)
                    {
                        _local2 = false;
                        break;
                    };
                };
                if (_local2)
                {
                    this.tradeinfo.itemsB.push(_local3);
                };
            };
        }

        public function addItemsToAuction(_arg1:Array):void
        {
            var _local3:Object;
            var _local4:Object;
            var _local2:Boolean = true;
            for each (_local3 in _arg1)
            {
                _local2 = true;
                for each (_local4 in this.auctioninfo.items)
                {
                    if (_local4.AuctionID == _local3.AuctionID)
                    {
                        _local2 = false;
                        break;
                    };
                };
                if (_local2)
                {
                    this.auctioninfo.items.push(_local3);
                };
            };
        }

        public function addItemsToRetrieve(_arg1:Array):void
        {
            var _local3:Object;
            var _local4:Object;
            var _local2:Boolean = true;
            for each (_local3 in _arg1)
            {
                _local2 = true;
                for each (_local4 in this.retrieveinfo.items)
                {
                    if (_local4.AuctionID == _local3.AuctionID)
                    {
                        _local2 = false;
                        break;
                    };
                };
                if (_local2)
                {
                    this.retrieveinfo.items.push(_local3);
                };
            };
        }

        public function toggleBank():void
        {
            if (!bankinfo.hasRequested(["*"]))
            {
                bankinfo.addRequestedTypes(["*"]);
                sendLoadBankRequest(["*"]);
            };

            if (!uiLock)
            {
                if (rootClass.ui.mcPopup.currentLabel == "Bank")
                {
                    MovieClip(rootClass.ui.mcPopup.getChildByName("mcBank")).fClose();
                }
                else
                {
                    rootClass.ui.mcPopup.fOpen("Bank");
                };
            };
        }

        public function toggleHouseBank():void
        {
            if (!bankinfo.hasRequested(["*"]))
            {
                bankinfo.addRequestedTypes(["*"]);
                sendLoadBankRequest(["*"]);
            };

            if (!uiLock)
            {
                if (rootClass.ui.mcPopup.currentLabel == "HouseBank")
                {
                    MovieClip(rootClass.ui.mcPopup.getChildByName("mcBank")).fClose();
                }
                else
                {
                    rootClass.ui.mcPopup.fOpen("HouseBank");
                };
            };
        }

        public function sendReport(args:Array):void
        {
            rootClass.sfc.sendXtMessage("zm", "cmd", args, "str", rootClass.world.curRoom);
        }

        public function sendWhoRequest():void
        {
            if (coolDown("who"))
            {
                rootClass.sfc.sendXtMessage("zm", "cmd", ["who"], "str", curRoom);
            };
        }

        public function sendRewardReferralRequest(params:*):void
        {
            rootClass.sfc.sendXtMessage("zm", "rewardReferral", [], "str", curRoom);
        }

        public function sendGetAdDataRequest():void
        {
            if (rootClass.world.myAvatar.objData.iDailyAds < rootClass.world.myAvatar.objData.iDailyAdCap)
            {
                rootClass.sfc.sendXtMessage("zm", "getAdData", [], "str", curRoom);
            };
        }

        public function sendGetAdRewardRequest():void
        {
            if (rootClass.world.myAvatar.objData.iDailyAds < rootClass.world.myAvatar.objData.iDailyAdCap)
            {
                rootClass.sfc.sendXtMessage("zm", "getAdReward", [], "str", curRoom);
            };
        }

        public function sendWarVarsRequest():void
        {
            rootClass.sfc.sendXtMessage("zm", "loadWarVars", [], "str", curRoom);
        }

        public function loadQuestStringData():void
        {
            rootClass.sfc.sendXtMessage("zm", "loadQuestStringData", [], "str", curRoom);
        }

        public function buyBagSlots(iSlots:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "buyBagSlots", [iSlots], "str", curRoom);
        }

        public function buyBankSlots(iSlots:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "buyBankSlots", [iSlots], "str", curRoom);
        }

        public function buyHouseSlots(iSlots:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "buyHouseSlots", [iSlots], "str", curRoom);
        }

        public function sendLoadFriendsListRequest():*
        {
            rootClass.sfc.sendXtMessage("zm", "loadFriendsList", [], "str", curRoom);
        }

        public function sendLoadFactionRequest():*
        {
            rootClass.sfc.sendXtMessage("zm", "loadFactions", [], "str", curRoom);
        }

        public function initAchievements():void
        {
            var _local_2:* = myAvatar.objData;
            with (_local_2)
            {
                ip0 = uint(ip0);
                ia0 = uint(ia0);
                ia1 = uint(ia1);
                id0 = uint(id0);
                id1 = uint(id1);
                id2 = uint(id2);
                im0 = uint(im0);
                iq0 = uint(iq0);
            };
        }

        public function getAchievement(field:String, index:int):int
        {
            if (((index < 0) || (index > 31)))
            {
                return (-1);
            };
            var iA:* = myAvatar.objData[field];
            if (iA == null)
            {
                return (-1);
            };
            return (((iA & Math.pow(2, index)) == 0) ? 0 : 1);
        }

        public function setAchievement(field:String, index:int, value:int = 1):void
        {
            var arrAchievementFields:* = ["ia0", "iq0"];
            if (((((arrAchievementFields.indexOf(field) >= 0) && (index >= 0)) && (index < 32)) && (!(getAchievement(field, index) == value))))
            {
                rootClass.sfc.sendXtMessage("zm", "setAchievement", [field, index, value], "str", curRoom);
            };
        }

        public function updateAchievement(field:String, index:int, value:int):void
        {
            if (value == 0)
            {
                myAvatar.objData[field] = (myAvatar.objData[field] & (~(Math.pow(2, index))));
            }
            else
            {
                if (value == 1)
                {
                    myAvatar.objData[field] = (myAvatar.objData[field] | Math.pow(2, index));
                };
            };
            rootClass.readIA1Preferences();
        }

        public function showFriendsList():void
        {
            var flo:*;
            var friend:*;
            trace(("friends: " + myAvatar.friends));
            if ((((!(myAvatar.friends == null)) && (myAvatar.friendsLoaded)) && (((new Date().getTime() - myAvatar.friendsLoaded) / 1000) < 30)))
            {
                flo = {};
                flo.typ = "userListFriends";
                for each (friend in myAvatar.friends)
                {
                    friend.bOffline = ((friend.sServer == rootClass.objServerInfo.sName) ? 0 : ((friend.sServer == "Offline") ? 2 : 1));
                };
                myAvatar.friends.sortOn("sName", Array.CASEINSENSITIVE);
                myAvatar.friends.sortOn(["bOffline", "sServer", "sName"], [Array.NUMERIC, Array.CASEINSENSITIVE, Array.CASEINSENSITIVE]);
                flo.ul = myAvatar.friends;
                rootClass.ui.mcOFrame.fOpenWith(flo);
            }
            else
            {
                myAvatar.friendsLoaded = new Date().getTime();
                rootClass.sfc.sendXtMessage("zm", "getfriendlist", [], "str", -1);
            };
        }

        public function showGuildList():void
        {
            if (myAvatar.objData.guild != null)
            {
                rootClass.ui.mcPopup.fOpen("GuildPanel");
            }
            else
            {
                rootClass.MsgBox.notify("You need to create or join a guild first.");
            };
        }

        public function showIgnoreList():void
        {
            var flo:Object;
            if (((!(rootClass.chatF.ignoreList.data.users == null)) && (rootClass.chatF.ignoreList.data.users.length > 0)))
            {
                flo = {};
                flo.typ = "userListIgnore";
                rootClass.ui.mcOFrame.fOpenWith(flo);
            }
            else
            {
                rootClass.chatF.pushMsg("warning", "Your ignore list is empty.", "SERVER", "", 0);
            };
        }

        public function isModerator(strUsername:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "isModerator", [strUsername], "str", -1);
        }

        public function toggleName(uid:*, state:String):*
        {
            if (state == "on")
            {
                getMCByUserID(uid).pname.visible = true;
            };
            if (state == "off")
            {
                getMCByUserID(uid).pname.visible = false;
            };
        }

        public function toggleHPBar():void
        {
            var uid:String;
            var umc:MovieClip;
            var avt:Avatar;
            showHPBar = (!(showHPBar));
            for (uid in avatars)
            {
                avt = avatars[uid];
                if (avt.pMC != null)
                {
                    umc = avt.pMC;
                    if (showHPBar)
                    {
                        umc.showHPBar();
                    }
                    else
                    {
                        umc.hideHPBar();
                    };
                };
            };
        }

        public function resPlayer():*
        {
            afkPostpone();
            rootClass.sfc.sendXtMessage("zm", "resPlayerTimed", [rootClass.sfc.myUserId], "str", curRoom);
        }

        public function showResCounter():*
        {
            trace("line 1131");
            var mcr:* = MovieClip(rootClass.ui.mcRes);
            if (mcr.currentLabel == "in")
            {
                return;
            };
            mcr.gotoAndPlay("in");
            mcr.resC = 10;
            trace("line 1136");
            trace("line 1146");
            if (mcr.resTimer == null)
            {
                mcr.resTimer = new Timer(1000);
                mcr.resTimer.addEventListener("timer", resTimer);
            }
            else
            {
                mcr.resTimer.reset();
            };
            trace("line 1153");
            mcr.resTimer.start();
        }

        public function resTimer(e:TimerEvent):*
        {
            var mcr:* = MovieClip(rootClass.ui.mcRes);
            mcr.resC--;
            if (mcr.resC > 0)
            {
                mcr.mcTomb.ti.text = ("0" + mcr.resC);
            }
            else
            {
                mcr.mcTomb.ti.text = "00";
                e.target.reset();
                mcr.visible = false;
                mcr.gotoAndStop(1);
                resPlayer();
            };
        }

        public function danceRequest(params:*):*
        {
            var obj:*;
            if (params.accept)
            {
                rootClass.chatF.submitMsg(params.emote1, "emote", rootClass.sfc.myUserName);
            }
            else
            {
                obj = {};
                obj.typ = "danceDenied";
                obj.cell = strFrame;
                rootClass.sfc.sendObjectToGroup(obj, [params.sender.getId()], curRoom);
            };
        }

        public function rest():void
        {
            if (!restTimer.running)
            {
                myAvatar.pMC.mcChar.gotoAndPlay("Rest");
                rootClass.sfc.sendXtMessage("zm", "emotea", ["rest"], "str", 1);
                restStart();
            };
        }

        public function restStart():*
        {
            afkPostpone();
            restTimer.reset();
            restTimer.start();
        }

        public function restRequest(e:TimerEvent):*
        {
            var uoLeaf:* = getUoLeafById(myAvatar.uid);
            if (((((!(uoLeaf.intHP == uoLeaf.intHPMax)) || (!(uoLeaf.intMP == uoLeaf.intMPMax))) && (myAvatar.pMC.mcChar.currentLabel == "Rest")) && (uoLeaf.intState == 1)))
            {
                if (coolDown("rest"))
                {
                    rootClass.sfc.sendXtMessage("zm", "restRequest", [""], "str", 1);
                    restTimer.reset();
                    restTimer.start();
                }
                else
                {
                    restStart();
                };
            }
            else
            {
                restTimer.reset();
            };
        }

        public function afkToggle():void
        {
            var uoLeaf:* = uoTree[rootClass.sfc.myUserName];
            if (uoLeaf != null)
            {
                rootClass.sfc.sendXtMessage("zm", "afk", [(!(uoLeaf.afk))], "str", 1);
            };
        }

        public function afkTimerHandler(e:Event):void
        {
            var uoLeaf:* = uoTree[rootClass.sfc.myUserName];
            if (uoLeaf != null)
            {
                rootClass.sfc.sendXtMessage("zm", "afk", [true], "str", 1);
            };
        }

        public function afkPostpone():void
        {
            afkTimer.reset();
            afkTimer.start();
            var now:* = new Date().getTime();
            var uoLeaf:* = uoTree[rootClass.sfc.myUserName];
            if ((((!(uoLeaf == null)) && (uoLeaf.afk)) && ((uoLeaf.afkts == null) || (now > (uoLeaf.afkts + 500)))))
            {
                rootClass.sfc.sendXtMessage("zm", "afk", [false], "str", 1);
                uoLeaf.afkts = now;
            };
        }

        public function hideAllPets(includeMine:Boolean = true):void
        {
            var i:*;
            for (i in avatars)
            {
                if (!((!(includeMine)) && (avatars[i] == myAvatar)))
                {
                    if (avatars[i] != null)
                    {
                        avatars[i].unloadPet();
                    };
                };
            };
        }

        public function showAllPets(includeMine:Boolean = true):void
        {
            var i:*;
            var uoLeaf:Object;
            var strF:*;
            for (i in avatars)
            {
                if (!((!(includeMine)) && (avatars[i] == myAvatar)))
                {
                    uoLeaf = getUoLeafById(i);
                    strF = String(uoLeaf.strFrame);
                    if (strF == strFrame)
                    {
                        avatars[i].loadPet();
                    };
                };
            };
        }

        public function updateMonsters():*
        {
            var i:int;
            if (monmap != null)
            {
                i = 0;
                while (i < monmap.length)
                {
                    if (monmap[i].strFrame == strFrame)
                    {
                        updateMonster(monmap[i]);
                    };
                    i++;
                };
            };
        }

        public function updateMonster(monmapo:Object):void
        {
            var mondef:* = getMonsterDefinition(monmapo.MonID);
            var Mon:* = getMonster(monmapo.MonMapID);
            if (Mon.pMC == null)
            {
                trace((">> Monster Pad Missing - MonMapID:" + monmapo.MonMapID));
                return;
            };
            Mon.objData.intMPMax = int(Mon.objData.intMPMax);
            Mon.objData.intHPMax = int(Mon.objData.intMPMax);
            var monLeaf:* = monTree[monmapo.MonMapID];
            if (((!(monLeaf.MonID == Mon.objData.MonID)) || (monLeaf.intState == 0)))
            {
                Mon.pMC.visible = false;
            };
            if (((Mon.pMC.x < myAvatar.pMC.x) && (monLeaf.intState == 1)))
            {
                Mon.pMC.turn("right");
            }
            else
            {
                if (monLeaf.intState == 1)
                {
                    Mon.pMC.turn("left");
                };
            };
            trace(Mon.pMC.scaleX);
            Mon.pMC.updateNamePlate();
        }

        public function createMonsterMC(monPad:MovieClip, MonID:int, randomName:Boolean = false):MonsterMC
        {
            var monMC:MonsterMC;
            var rand:int;
            var AssetClass:Class;
            var mondef:* = getMonsterDefinition(MonID);
            if (randomName)
            {
                rand = int(Math.round((Math.random() * (chaosNames.length - 1))));
                trace("chaos names");
                trace(chaosNames);
                if (chaosNames[rand] != rootClass.world.myAvatar.objData.strUsername)
                {
                    monMC = new MonsterMC(chaosNames[rand]);
                }
                else
                {
                    rand = ((rand == 0) ? ++rand : --rand);
                    monMC = new MonsterMC(chaosNames[rand]);
                };
                trace(("mon name: " + chaosNames[rand]));
            }
            else
            {
                if (Number((objExtra["bChar"] == 1)))
                {
                    monMC = new MonsterMC(myAvatar.objData.strUsername);
                }
                else
                {
                    monMC = new MonsterMC(mondef.strMonName);
                };
            };
            CHARS.addChild(monMC);
            monMC.x = monPad.x;
            monMC.y = monPad.y;
            monMC.ox = monMC.x;
            monMC.oy = monMC.y;
            if (Number((objExtra["bChar"] == 1)))
            {
                monMC.removeChildAt(1);
                monMC.addChildAt((new dummyMC() as MovieClip), 1);
                copyAvatarMC((monMC.getChildAt(1) as MovieClip));
            }
            else
            {
                AssetClass = (loaderD.getDefinition(mondef.strLinkage) as Class);
                monMC.removeChildAt(1);
                monMC.addChildAt(new (AssetClass)(), 1);
            };
            monMC.mouseEnabled = false;
            monMC.bubble.mouseEnabled = (monMC.bubble.mouseChildren = false);
            monMC.init();
            if (("strDir" in monPad))
            {
                if (monPad.strDir.toLowerCase() == "static")
                {
                    monMC.isStatic = true;
                };
            };
            if (("noMove" in monPad))
            {
                monMC.noMove = monPad.noMove;
            };
            if (rootClass.litePreference.data.bFreezeMons)
            {
                monMC.noMove = true;
            };
            return (monMC);
        }

        public function getMonDataById():*
        {
        }

        public function retrieveMonData():*
        {
            rootClass.sfc.sendXtMessage("zm", "retrieveMonData", [], "str", 1);
        }

        private function getMonID(MonMapID:int):int
        {
            var i:String;
            var monLeaf:*;
            for (i in monTree)
            {
                monLeaf = monTree[i];
                if (monLeaf.MonMapID == MonMapID)
                {
                    return (monLeaf.MonID);
                };
            };
            return (-1);
        }

        private function getMonsterDefinition(MonID:int):Object
        {
            var i:int;
            while (i < mondef.length)
            {
                if (mondef[i].MonID == MonID)
                {
                    return (mondef[i]);
                };
                i++;
            };
            return (null);
        }

        public function getMonster(MonMapID:int):Avatar
        {
            var i:int;
            while (i < monsters.length)
            {
                if (((monsters[i].objData.MonMapID == MonMapID) && (monsters[i].objData.MonID == monTree[MonMapID].MonID)))
                {
                    return (monsters[i]);
                };
                i++;
            };
            return (null);
        }

        public function getMonsters(MonMapID:int):Array
        {
            var returns:Array = [];
            var i:int;
            while (i < monsters.length)
            {
                if (monsters[i].objData.MonMapID == MonMapID)
                {
                    returns.push(monsters[i]);
                };
                i++;
            };
            if (returns.length > 0)
            {
                return (returns);
            };
            return (null);
        }

        public function getMonsterCluster(MonMapID:int):Array
        {
            var cluster:* = [];
            var i:int;
            while (i < monsters.length)
            {
                if (monsters[i].objData.MonMapID == MonMapID)
                {
                    cluster.push(monsters[i]);
                };
                i++;
            };
            return (cluster);
        }

        public function getMonstersByCell(s:String):Array
        {
            var returns:Array = [];
            var i:int;
            while (i < monsters.length)
            {
                if (((!(monsters[i].dataLeaf == null)) && (monsters[i].dataLeaf.strFrame == s)))
                {
                    returns.push(monsters[i]);
                };
                i++;
            };
            return (returns);
        }

        public function initMonsters(md:Array, mp:Array):*
        {
            var monObj:Object;
            var j:int;
            var Mon:*;
            var prop:*;
            var monLeaf:*;
            var i:int;
            if (((!(md == null)) && (!(mp == null))))
            {
                monswf = new Array();
                monsters = new Array();
                monObj = null;
                i = 0;
                while (i < mp.length)
                {
                    j = 0;
                    while (j < md.length)
                    {
                        if (mp[i].MonID == md[j].MonID)
                        {
                            monObj = md[j];
                        };
                        j++;
                    };
                    monsters.push(new Avatar(rootClass));
                    Mon = monsters[(monsters.length - 1)];
                    Mon.npcType = "monster";
                    if (Mon.objData == null)
                    {
                        Mon.objData = {};
                    };
                    for (prop in monObj)
                    {
                        Mon.objData[prop] = monObj[prop];
                    };
                    for (prop in mp[i])
                    {
                        Mon.objData[prop] = mp[i][prop];
                    };
                    monLeaf = monTree[String(Mon.objData.MonMapID)];
                    monLeaf.strFrame = String(Mon.objData.strFrame);
                    if (monLeaf.MonID == Mon.objData.MonID)
                    {
                        Mon.dataLeaf = monTree[Mon.objData.MonMapID];
                    }
                    else
                    {
                        Mon.dataLeaf = null;
                    };
                    i++;
                };
                i = 0;
                while (i < md.length)
                {
                    trace(((((i + "  ") + rootClass.getFilePath()) + "mon/") + md[i].strMonFileName));
                    queueLoad({
                                "strFile": ((rootClass.getFilePath() + "mon/") + md[i].strMonFileName),
                                "callBackA": rootClass.onLoadMaster(onMonLoadComplete, loaderC)
                            });
                    i++;
                };
            };
        }

        private function onMonLoadComplete(event:Event):*
        {
            monswf.push(MovieClip(Loader(event.target.loader).content));
            trace(((((("      >>>> successful " + Loader(event.target.loader).contentLoaderInfo.url) + " ") + monswf.length) + " / ") + mondef.length));
            if (monswf.length == mondef.length)
            {
                enterMap();
            };
        }

        public function toggleMonsters():*
        {
            var child:DisplayObject;
            rootClass.ui.monsterIcon.redX.visible = showMonsters;
            showMonsters = (!(showMonsters));
            var i:int;
            while (i < CHARS.numChildren)
            {
                child = CHARS.getChildAt(i);
                if (((child.hasOwnProperty("isMonster")) && (MovieClip(child).isMonster)))
                {
                    MovieClip(child).setVisible();
                };
                i++;
            };
        }

        public function setTarget(avt:*):*
        {
            if (((((!(myAvatar == null)) && (!(avt == null))) && (avt.npcType == "player")) && (avt.isMyAvatar)))
            {
                if (rootClass.litePreference.data.bUntargetSelf)
                {
                    return;
                };
            };
            if (((!(myAvatar == null)) && (!(myAvatar.target == avt))))
            {
                if (myAvatar.target != null)
                {
                    if (myAvatar.target.npcType == "monster")
                    {
                        if ((((bPvP) && (!(myAvatar.target.dataLeaf.react == null))) && (myAvatar.target.dataLeaf.react[myAvatar.dataLeaf.pvpTeam] == 1)))
                        {
                            myAvatar.target.pMC.modulateColor(avtPCT, "-");
                        }
                        else
                        {
                            myAvatar.target.pMC.modulateColor(avtMCT, "-");
                        };
                    };
                    if (myAvatar.target.npcType == "player")
                    {
                        if (((bPvP) && (!(myAvatar.target.dataLeaf.pvpTeam == myAvatar.dataLeaf.pvpTeam))))
                        {
                            myAvatar.target.pMC.modulateColor(avtMCT, "-");
                        }
                        else
                        {
                            myAvatar.target.pMC.modulateColor(avtPCT, "-");
                        };
                    };
                };
                if (avt != null)
                {
                    if (((!(bPvP)) && (avt.npcType == "player")))
                    {
                        if (autoActionTimer != null)
                        {
                            cancelAutoAttack();
                        };
                    };
                    myAvatar.target = avt;
                    if (myAvatar.target.npcType == "monster")
                    {
                        if ((((bPvP) && (!(myAvatar.target.dataLeaf.react == null))) && (myAvatar.target.dataLeaf.react[myAvatar.dataLeaf.pvpTeam] == 1)))
                        {
                            myAvatar.target.pMC.modulateColor(avtPCT, "+");
                        }
                        else
                        {
                            myAvatar.target.pMC.modulateColor(avtMCT, "+");
                        };
                    };
                    if (myAvatar.target.npcType == "player")
                    {
                        if (((bPvP) && (!(myAvatar.target.dataLeaf.pvpTeam == myAvatar.dataLeaf.pvpTeam))))
                        {
                            myAvatar.target.pMC.modulateColor(avtMCT, "+");
                        }
                        else
                        {
                            myAvatar.target.pMC.modulateColor(avtPCT, "+");
                        };
                    };
                    rootClass.showPortraitTarget(avt);
                }
                else
                {
                    rootClass.hidePortraitTarget();
                    if (myAvatar.dataLeaf.intState > 0)
                    {
                        exitCombat();
                    };
                    myAvatar.target = null;
                };
            };
        }

        public function cancelTarget():void
        {
            if (((!(autoActionTimer == null)) && (autoActionTimer.running)))
            {
                cancelAutoAttack();
                myAvatar.pMC.mcChar.gotoAndStop("Idle");
                return;
            };
            if (myAvatar.target != null)
            {
                setTarget(null);
                return;
            };
        }

        public function approachTarget():*
        {
            var tLeaf:Object;
            var moveOK:Boolean;
            var cReg:Point;
            var tReg:Point;
            var distance:Number;
            var range:Number;
            var tries:int;
            var buffer:int;
            var xBuffer:int;
            var yBuffer:int;
            var xTarget:int;
            var yTarget:int;
            var cAvt:*;
            var tAvt:*;
            var pAvt:*;
            var tgtMin:int;
            var tgtMax:int;
            var targets:Array;
            var scan:Array;
            trace("approach target");
            var clickOK:Boolean = true;
            var cLeaf:Object = uoTree[rootClass.sfc.myUserName];
            var actionObj:Object = getAutoAttack();
            if (myAvatar.target != null)
            {
                trace("target not null");
                if (myAvatar.target.npcType == "monster")
                {
                    tLeaf = monTree[myAvatar.target.objData.MonMapID];
                }
                else
                {
                    if (myAvatar.target.npcType == "player")
                    {
                        tLeaf = myAvatar.target.dataLeaf;
                    };
                };
                if ((((tLeaf == null) || (cLeaf.intState == 0)) || (tLeaf.intState == 0)))
                {
                    clickOK = false;
                };
                trace(("bPvP ? " + bPvP));
                trace(("myAvatar.target.npcType ? " + (myAvatar.target.npcType == "player")));
                if ((((bPvP) && (((!(tLeaf.react == null)) && (tLeaf.react[cLeaf.pvpTeam] == 1)) || (cLeaf.pvpTeam == tLeaf.pvpTeam))) || ((!(bPvP)) && (myAvatar.target.npcType == "player"))))
                {
                    clickOK = false;
                };
                if (clickOK)
                {
                    rootClass.mixer.playSound("ClickBig");
                    if (actionObj != null)
                    {
                        if (actionRangeCheck(actionObj))
                        {
                            testAction(actionObj);
                        }
                        else
                        {
                            actionReady = true;
                            moveOK = false;
                            cReg = myAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
                            tReg = myAvatar.target.pMC.mcChar.localToGlobal(new Point(0, 0));
                            if (actionObj.range > 301)
                            {
                                distance = Point.distance(cReg, tReg);
                                range = (actionObj.range * SCALE);
                                range = (range * 0.9);
                                if (range < distance)
                                {
                                    tReg = Point.interpolate(cReg, tReg, (range / distance));
                                };
                                moveOK = (!(padHit(tReg.x, tReg.y, myAvatar.pMC.shadow.getBounds(rootClass.stage))));
                            }
                            else
                            {
                                tries = 0;
                                while (((tries < 100) && (!(moveOK))))
                                {
                                    buffer = int(int((50 + (Math.random() * 110))));
                                    if (tries > 50)
                                    {
                                        buffer = (buffer * -1);
                                    };
                                    xBuffer = (((tReg.x - cReg.x) >= 0) ? -(buffer) : buffer);
                                    yBuffer = int(((Math.random() * 40) - 20));
                                    xBuffer = Math.ceil((xBuffer * SCALE));
                                    yBuffer = Math.floor((yBuffer * SCALE));
                                    xTarget = (tReg.x + xBuffer);
                                    yTarget = (tReg.y + yBuffer);
                                    moveOK = (!(padHit(xTarget, yTarget, myAvatar.pMC.shadow.getBounds(rootClass.stage))));
                                    tries++;
                                };
                                tReg.x = (tReg.x + xBuffer);
                                tReg.y = (tReg.y + yBuffer);
                            };
                            if (moveOK)
                            {
                                myAvatar.pMC.walkTo(tReg.x, tReg.y, (WALKSPEED * 2));
                                pushMove(myAvatar.pMC, tReg.x, tReg.y, (WALKSPEED * 2));
                            }
                            else
                            {
                                rootClass.chatF.pushMsg("server", "No path found!", "SERVER", "", 0);
                            };
                        };
                    };
                };
            }
            else
            {
                trace("target null");
                cAvt = myAvatar;
                tAvt = null;
                pAvt = null;
                tgtMin = (("tgtMin" in actionObj) ? actionObj.tgtMin : 1);
                tgtMax = (("tgtMax" in actionObj) ? actionObj.tgtMax : 1);
                targets = [];
                scan = getAllAvatarsInCell();
                for each (tAvt in scan)
                {
                    tLeaf = tAvt.dataLeaf;
                    if ((((!(tLeaf == null)) && ((((!(bPvP)) && (tAvt.npcType == "monster")) || (((bPvP) && (tAvt.npcType == "player")) && (!(cLeaf.pvpTeam == tLeaf.pvpTeam)))) || ((((bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 0)))) && (actionRangeCheck(actionObj, tAvt))))
                    {
                        setTarget(tAvt);
                        testAction(actionObj);
                        return;
                    };
                };
                rootClass.chatF.pushMsg("warning", "No target selected!", "SERVER", "", 0);
            };
        }

        public function padHit(tx:int, ty:int, tr:Rectangle):Boolean
        {
            var br:Rectangle;
            var mc:MovieClip;
            var i:int;
            if (((((tx < 0) || (tx > 960)) || (ty < 10)) || (ty > 530)))
            {
                return (false);
            };
            tr.x = int((tx - (tr.width / 2)));
            tr.y = int((ty - (tr.height / 2)));
            i = 0;
            while (i < arrEvent.length)
            {
                mc = arrEvent[i];
                if ((("strSpawnCell" in mc) || ("tCell" in mc)))
                {
                    br = arrEventR[i];
                    if (tr.intersects(br))
                    {
                        return (true);
                    };
                };
                i++;
            };
            return (false);
        }

        public function drawRects(a:Array):void
        {
            var r:Rectangle;
            var c:Array = [0xFF0000, 0xFF00, 0xFF];
            var s:Sprite = new Sprite();
            var g:Graphics = s.graphics;
            var i:int;
            i = 0;
            while (i < a.length)
            {
                r = a[i];
                g.moveTo(r.x, r.y);
                g.beginFill(c[i], 0.3);
                g.lineTo((r.x + r.width), r.y);
                g.lineTo((r.x + r.width), (r.y + r.height));
                g.lineTo(r.x, (r.y + r.height));
                g.lineTo(r.x, r.y);
                g.endFill();
                i++;
            };
        }

        public function testAction(actionObj:Object, forceAARangeError:Boolean = false):*
        {
            var tLeaf:Object;
            var aura:Object;
            var pet:* = undefined;
            var tgtOK:Boolean;
            var sAvt:Avatar;
            var to:Object;
            var now:Number;
            trace(("testAction > " + actionObj.nam));
            var a:int;
            var b:int;
            var c:int;
            var cLeaf:Object = uoTreeLeaf(rootClass.sfc.myUserName);
            var cAvt:* = myAvatar;
            var tAvt:* = null;
            var pAvt:* = null;
            var tgtMin:int = (("tgtMin" in actionObj) ? actionObj.tgtMin : 1);
            var tgtMax:int = (("tgtMax" in actionObj) ? actionObj.tgtMax : 1);
            var targets:Array = [];
            var scan:Array = getAllAvatarsInCell();
            a = 0;
            while (a < scan.length)
            {
                tAvt = scan[a];
                if ((((tAvt.dataLeaf == null) || (tAvt.dataLeaf.intState == 0)) || ((tAvt.pMC == null) || (tAvt.pMC.x == null))))
                {
                    scan.splice(a, 1);
                    a = (a - 1);
                    if (tAvt == myAvatar.target)
                    {
                        setTarget(null);
                    };
                };
                a = (a + 1);
            };
            a = 0;
            tAvt = null;
            if (((!(myAvatar.target == null)) && (scan.indexOf(myAvatar.target) > -1)))
            {
                scan.unshift(scan.splice(scan.indexOf(myAvatar.target), 1)[0]);
            };
            afkPostpone();
            var errMsg:String = "none";
            var forceAAloop:Boolean;
            if (!actionTimeCheck(actionObj))
            {
                errMsg = (("Ability '" + actionObj.nam) + "' is not ready yet.");
            };
            if ((((errMsg == "none") && (!(actionObj.mp == null))) && (Math.round((actionObj.mp * cLeaf.sta["$cmc"])) > cLeaf.intMP)))
            {
                errMsg = "Not enough mana!";
            };
            if (((errMsg == "none") && (!(actionObj.sp == null))))
            {
                if (!checkSP(actionObj.sp, cLeaf))
                {
                    errMsg = "Not Enough Spirit Power!";
                };
            };
            if ((((errMsg == "none") && (actionObj.ref == "i1")) && (actionObj.sArg1 == "")))
            {
                errMsg = "No item assigned to that slot!";
            };
            if ((((((errMsg == "none") && (!(myAvatar.target == null))) && ("filter" in actionObj)) && ("sRace" in myAvatar.target.objData)) && (!(myAvatar.target.objData.sRace.toLowerCase() == actionObj.filter.toLowerCase()))))
            {
                errMsg = (("Target is not a " + actionObj.filter) + "!");
            };
            if (errMsg == "none")
            {
                for each (aura in cLeaf.auras)
                {
                    try
                    {
                        if (aura.cat != null)
                        {
                            if (aura.cat == "stun")
                            {
                                errMsg = "Cannot act while stunned!";
                            };
                            if (aura.cat == "stone")
                            {
                                errMsg = "Cannot act while petrified!";
                            };
                            if (aura.cat == "freeze")
                            {
                                errMsg = "Cannot act while frozen!";
                            };
                            if (aura.cat == "disabled")
                            {
                                errMsg = "Cannot act while disabled!";
                            };
                            if (errMsg != "none")
                            {
                                forceAAloop = true;
                            };
                        };
                    }
                    catch (e:Error)
                    {
                        trace(("combat.auraPreFlight > " + e));
                    };
                };
            };
            if (errMsg == "none")
            {
                if (actionObj.pet != null)
                {
                    pet = cAvt.getItemByEquipSlot("pe");
                    if (cAvt.getItemByEquipSlot("pe") == null)
                    {
                        if (cAvt.checkTempItem(actionObj.pet, 1))
                        {
                            summonPet(actionObj.pet, true);
                        }
                        else
                        {
                            summonPet(actionObj.pet, false);
                        };
                    };
                }
                else
                {
                    if (actionObj.checkPet != null)
                    {
                        if (cAvt.getItemByEquipSlot("pe").sMeta.indexOf(actionObj.checkPet) == -1)
                        {
                            errMsg = "No battle pet equipped.";
                        };
                    };
                };
            };
            if (((errMsg == "none") || (forceAAloop)))
            {
                if (myAvatar.target != null)
                {
                    tAvt = myAvatar.target;
                    if (myAvatar.target.npcType == "monster")
                    {
                        tLeaf = monTree[tAvt.objData.MonMapID];
                    }
                    else
                    {
                        if (tAvt.npcType == "player")
                        {
                            tLeaf = tAvt.dataLeaf;
                        };
                    };
                };
                switch (actionObj.tgt)
                {
                    case "h":
                        if (tAvt == null)
                        {
                            if (tgtMin > 0)
                            {
                                for each (tAvt in scan)
                                {
                                    tLeaf = tAvt.dataLeaf;
                                    if ((((!(tLeaf == null)) && ((((!(bPvP)) && (tAvt.npcType == "monster")) || (((bPvP) && (tAvt.npcType == "player")) && (!(cLeaf.pvpTeam == tLeaf.pvpTeam)))) || ((((bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 0)))) && (actionRangeCheck(actionObj, tAvt))))
                                    {
                                        setTarget(tAvt);
                                        testAction(actionObj);
                                        return;
                                    };
                                };
                                errMsg = "No target selected!";
                                if (actionObj.typ == "aa")
                                {
                                    cancelAutoAttack();
                                };
                            };
                        }
                        else
                        {
                            if (((((!(bPvP)) && (tAvt.npcType == "player")) || (((bPvP) && (tAvt.npcType == "player")) && (cLeaf.pvpTeam == tLeaf.pvpTeam))) || ((((bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1))))
                            {
                                errMsg = "Can't attack that target!";
                                if (actionObj.typ == "aa")
                                {
                                    cancelAutoAttack();
                                };
                            };
                            if (((tgtMin > 0) && (tAvt.dataLeaf.intState == 0)))
                            {
                                errMsg = "Your target is dead!";
                            };
                        };
                        break;
                    case "f":
                        if (tAvt == null)
                        {
                            setTarget(myAvatar);
                            tAvt = myAvatar;
                            tLeaf = tAvt.dataLeaf;
                        };
                        if (((((!(bPvP)) && (tAvt.npcType == "monster")) || ((bPvP) && (!(cLeaf.pvpTeam == tLeaf.pvpTeam)))) || ((((bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1))))
                        {
                            tAvt = myAvatar;
                        };
                        tLeaf = tAvt.dataLeaf;
                        break;
                    case "s":
                        if (tAvt == null)
                        {
                            setTarget(myAvatar);
                            tAvt = myAvatar;
                        };
                        if (((!(tAvt == null)) && (!(tAvt == myAvatar))))
                        {
                            tAvt = myAvatar;
                        };
                        tLeaf = tAvt.dataLeaf;
                        break;
                };
                pAvt = tAvt;
                if ((((errMsg == "none") && (!(actionRangeCheck(actionObj, pAvt)))) || (forceAAloop)))
                {
                    if (!forceAAloop)
                    {
                        errMsg = "You are out of range!  Move closer to your target!";
                    };
                    if (actionObj.typ == "aa")
                    {
                        autoActionTimer.delay = 500;
                        autoActionTimer.reset();
                        autoActionTimer.start();
                    };
                };
                tgtOK = true;
                if (errMsg == "none")
                {
                    while (scan.length > 0)
                    {
                        tAvt = scan[0];
                        tLeaf = tAvt.dataLeaf;
                        tgtOK = true;
                        if (tLeaf.intState == 0)
                        {
                            tgtOK = false;
                        };
                        if ((((!(tAvt == null)) && ("filter" in actionObj)) && ("sRace" in tAvt.objData)))
                        {
                            if (tAvt.objData.sRace.toLowerCase() != actionObj.filter.toLowerCase())
                            {
                                tgtOK = false;
                            };
                        };
                        switch (actionObj.tgt)
                        {
                            case "h":
                                if (((((!(bPvP)) && (tAvt.npcType == "player")) || (((bPvP) && (tAvt.npcType == "player")) && (cLeaf.pvpTeam == tLeaf.pvpTeam))) || ((((bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1))))
                                {
                                    tgtOK = false;
                                };
                                break;
                            case "f":
                                if (((((!(bPvP)) && (tAvt.npcType == "monster")) || ((bPvP) && (!(cLeaf.pvpTeam == tLeaf.pvpTeam)))) || ((((bPvP) && (tAvt.npcType == "monster")) && (!(tLeaf.react == null))) && (tLeaf.react[cLeaf.pvpTeam] == 1))))
                                {
                                    tgtOK = false;
                                };
                                break;
                            case "s":
                                if (((!(tAvt == null)) && (!(tAvt == myAvatar))))
                                {
                                    tgtOK = false;
                                };
                                break;
                        };
                        if (tgtOK)
                        {
                            sAvt = myAvatar;
                            if (((actionObj.fx == "c") && (targets.length > 0)))
                            {
                                sAvt = targets[(targets.length - 1)].avt;
                            };
                            a = Math.abs((tAvt.pMC.x - sAvt.pMC.x));
                            b = Math.abs((tAvt.pMC.y - sAvt.pMC.y));
                            c = Math.pow(((a * a) + (b * b)), 0.5);
                            if (actionRangeCheck(actionObj, tAvt))
                            {
                                targets.push({
                                            "avt": tAvt,
                                            "d": c,
                                            "hp": tLeaf.intHP
                                        });
                            };
                        };
                        scan.shift();
                    };
                };
                targets.sortOn("hp", Array.NUMERIC);
                if (pAvt != null)
                {
                    a = 0;
                    while (a < targets.length)
                    {
                        to = targets[a];
                        if (to.avt == pAvt)
                        {
                            targets.unshift(targets.splice(a, 1)[0]);
                        };
                        a = (a + 1);
                    };
                };
                if (targets.length > tgtMax)
                {
                    targets = targets.splice(0, tgtMax);
                };
                if (targets.length > 0)
                {
                    if (pAvt != null)
                    {
                        if (((!(targets[0].avt == null)) && (!(targets[0].avt.dataLeaf == null))))
                        {
                            tAvt = targets[0].avt;
                            tLeaf = tAvt.dataLeaf;
                        }
                        else
                        {
                            tAvt = null;
                            tLeaf = null;
                        };
                    }
                    else
                    {
                        tAvt = null;
                        tLeaf = null;
                    };
                };
            };
            if (errMsg == "none")
            {
                if (cLeaf.intState != 0)
                {
                    if ((((!(actionObj.lock)) && ((tLeaf == null) || (!(tLeaf.intState == 0)))) && (targets.length >= tgtMin)))
                    {
                        doAction(actionObj, targets);
                    };
                    if (((myAvatar.target == null) || ((tLeaf == null) || (tLeaf.intState == 0))))
                    {
                        exitCombat();
                    };
                };
            }
            else
            {
                now = new Date().getTime();
                if (((errMsg == "You are out of range!  Move closer to your target!") && ((!(actionObj.typ == "aa")) || (forceAARangeError))))
                {
                    if ((now - actionRangeSpamTS) > 3000)
                    {
                        actionRangeSpamTS = now;
                        rootClass.chatF.pushMsg("warning", errMsg, "SERVER", "", 0);
                    };
                }
                else
                {
                    if (actionObj.typ != "aa")
                    {
                        rootClass.chatF.pushMsg("warning", errMsg, "SERVER", "", 0);
                    };
                };
            };
        }

        public function summonPet(petID:int, hasPet:Boolean):*
        {
            if (hasPet)
            {
                rootClass.sfc.sendXtMessage("zm", "equipItem", [petID], "str", curRoom);
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "summonPet", [petID], "str", curRoom);
            };
        }

        public function autoActionHandler(e:TimerEvent):*
        {
            trace("* autoActionHandler >");
            if (((((rootClass.litePreference.data.bUntargetDead) && (!(myAvatar.target.isMyAvatar))) && (!(myAvatar.target == null))) && (myAvatar.target.dataLeaf.intState == 0)))
            {
                cancelTarget();
                return;
            };
            if ((((((!(myAvatar.dataLeaf == null)) && (!(myAvatar.dataLeaf.intState == 0))) && (!(myAvatar.target == null))) && (!(myAvatar.target.dataLeaf == null))) && (!(myAvatar.target.dataLeaf.intState == 0))))
            {
                testAction(getAutoAttack(), true);
            }
            else
            {
                exitCombat();
            };
        }

        public function getAutoAttack():Object
        {
            var i:* = 0;
            while (i < actions.active.length)
            {
                if ((((!(actions.active[i] == null)) && (!(actions.active[i].auto == null))) && (actions.active[i].auto == true)))
                {
                    return (actions.active[i]);
                };
                i++;
            };
            return (null);
        }

        public function exitCombat():*
        {
            var i:int;
            actionReady = false;
            if (((!(actions == null)) && (!(actions.active == null))))
            {
                i = 0;
                while (i < actions.active.length)
                {
                    actions.active[i].lock = false;
                    i++;
                };
            };
            if (myAvatar != null)
            {
                if (((((!(myAvatar.pMC == null)) && (!(myAvatar.pMC.mcChar == null))) && (!(myAvatar.pMC.mcChar.onMove))) && (!(myAvatar.pMC.mcChar.currentLabel == "Rest"))))
                {
                    myAvatar.pMC.mcChar.gotoAndStop("Idle");
                };
                if (myAvatar.dataLeaf != null)
                {
                    myAvatar.dataLeaf.targets = {};
                };
                cancelAutoAttack();
                myAvatar.pMC.clearQueue();
            };
        }

        public function cancelAutoAttack():*
        {
            var icon:MovieClip;
            if (autoActionTimer != null)
            {
                autoActionTimer.reset();
            };
            if (AATestTimer != null)
            {
                AATestTimer.reset();
            };
            var i:* = 0;
            while (i < actionMap.length)
            {
                try
                {
                    if (actionMap[i] == "aa")
                    {
                        icon = MovieClip(rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i + 1))));
                        icon.bg.gotoAndStop(1);
                    };
                }
                catch (e:Error)
                {
                    trace(e);
                };
                i++;
            };
        }

        public function doAction(actionObj:*, targets:*):*
        {
            var tAvt:Avatar;
            trace(("doAction > " + actionObj.nam));
            afkPostpone();
            if (targets.length > 0)
            {
                tAvt = targets[0].avt;
                if (tAvt != myAvatar)
                {
                    if ((tAvt.pMC.x - myAvatar.pMC.x) >= 0)
                    {
                        myAvatar.pMC.turn("right");
                    }
                    else
                    {
                        myAvatar.pMC.turn("left");
                    };
                };
            };
            var i:int;
            while (i < targets.length)
            {
                tAvt = targets[i].avt;
                switch (tAvt.npcType)
                {
                    case "monster":
                        if (myAvatar.dataLeaf.targets[tAvt.objData.MonMapID] == null)
                        {
                            myAvatar.dataLeaf.targets[tAvt.objData.MonMapID] = "m";
                        };
                        break;
                    case "player":
                        if (myAvatar.dataLeaf.targets[tAvt.objData.uid] == null)
                        {
                            myAvatar.dataLeaf.targets[tAvt.objData.uid] = "p";
                        };
                        break;
                };
                i++;
            };
            getActionResult(actionObj, targets);
        }

        public function aggroMap(cInf:String, tInf:String, isHeal:*):void
        {
            var mi:*;
            var testMonLeaf:*;
            var cType:String = cInf.split(":")[0];
            var cID:String = cInf.split(":")[1];
            var tType:String = tInf.split(":")[0];
            var tID:String = tInf.split(":")[1];
            var unmC:String = "";
            var unmT:String = "";
            var cLeaf:Object = {};
            var tLeaf:Object = {};
            if (cType == "p")
            {
                cLeaf = getUoLeafById(cID);
            }
            else
            {
                cLeaf = monTree[cID];
            };
            if (tType == "p")
            {
                tLeaf = getUoLeafById(tID);
            }
            else
            {
                tLeaf = monTree[tID];
            };
            if (!("targets" in cLeaf))
            {
                cLeaf.targets = {};
            };
            if (!("targets" in tLeaf))
            {
                tLeaf.targets = {};
            };
            if (tType == "m")
            {
                if (!(tID in cLeaf.targets))
                {
                    cLeaf.targets[tID] = tType;
                };
                if (!(cID in tLeaf.targets))
                {
                    tLeaf.targets[cID] = cType;
                };
            };
            if ((((cType == "p") && (tType == "p")) && (isHeal)))
            {
                for (mi in monTree)
                {
                    testMonLeaf = monTree[mi];
                    if (((!(testMonLeaf.targets[tID] == null)) && (!(cID in testMonLeaf.targets))))
                    {
                        testMonLeaf.targets[cID] = cType;
                    };
                };
            };
        }

        private function actionTimeCheck(actionObj:*):Boolean
        {
            var cd:int;
            trace("actionTimeCheck >");
            var now:Number = new Date().getTime();
            var hasteCoeff:Number = (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha, -1), 0.5));
            if (actionObj.auto)
            {
                if (autoActionTimer.running)
                {
                    trace("AA TIMER SELF-CLIPPING");
                    return (false);
                };
                return (true);
            };
            if ((now - GCDTS) < GCD)
            {
                return (false);
            };
            if (actionObj.OldCD != null)
            {
                cd = Math.round((actionObj.OldCD * hasteCoeff));
            }
            else
            {
                cd = Math.round((actionObj.cd * hasteCoeff));
            };
            trace(((("ActionObj: " + actionObj.nam) + " cooldown: ") + actionObj.cd));
            if ((now - actionObj.ts) >= cd)
            {
                delete actionObj.OldCD;
                return (true);
            };
            return (false);
        }

        private function actionRangeCheck(actionObj:*, tAvt:Avatar = null):Boolean
        {
            var cReg:Point;
            var tReg:Point;
            var a:*;
            var b:*;
            var c:*;
            var range:*;
            trace("actionRangeCheck >");
            if (((tAvt == null) && (!(myAvatar.target == null))))
            {
                tAvt = myAvatar.target;
            };
            if (tAvt == myAvatar)
            {
                return (true);
            };
            if ((("tgtMin" in actionObj) && (actionObj.tgtMin == 0)))
            {
                return (true);
            };
            if (tAvt == null)
            {
                return (false);
            };
            cReg = myAvatar.pMC.mcChar.localToGlobal(new Point(0, 0));
            tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
            a = Math.abs((tReg.x - cReg.x));
            b = Math.abs((tReg.y - cReg.y));
            c = Math.pow(((a * a) + (b * b)), 0.5);
            range = (actionObj.range * SCALE);
            if (actionObj.range <= 301)
            {
                if (((a <= range) && (b <= (30 * SCALE))))
                {
                    return (true);
                };
                return (false);
            };
            if (c <= range)
            {
                return (true);
            };
            return (false);
        }

        public function aggroAllMon():*
        {
            var mID:*;
            var arrMon:* = [];
            for (mID in monTree)
            {
                if (monTree[mID].strFrame == strFrame)
                {
                    arrMon.push(mID);
                };
            };
            aggroMons(arrMon);
        }

        public function aggroMon(mID:*):*
        {
            var arrMon:*;
            arrMon = [];
            arrMon.push(mID);
            aggroMons(arrMon);
        }

        public function aggroMons(arrMon:*):*
        {
            if (arrMon.length)
            {
                rootClass.sfc.sendXtMessage("zm", "aggroMon", arrMon, "str", curRoom);
            };
        }

        public function castSpellFX(cAvt:*, spFX:*, spell:*, dur:int = 0):*
        {
            var tAvt:Avatar;
            var AssetClass:Class;
            var spellFX:*;
            var targetMCs:Array;
            var i:int;
            if (((cAvt) && (cAvt.isCameraTool)))
            {
                return;
            };
            if (((!(showAnimations)) || (((cAvt) && (!(cAvt.isMyAvatar))) && (!(cAvt.pMC.mcChar.visible)))))
            {
                return;
            };
            if (rootClass.litePreference.data.bDisSkillAnim)
            {
                if (((!(rootClass.litePreference.data.dOptions["animSelf"])) || (((rootClass.litePreference.data.dOptions["animSelf"]) && (cAvt)) && (!(cAvt.isMyAvatar)))))
                {
                    return;
                };
            };
            if ((((!(spFX.strl == null)) && (!(spFX.strl == ""))) && (!(spFX.avts == null))))
            {
                targetMCs = [];
                i = 0;
                if (spFX.fx == "c")
                {
                    if (spFX.strl == "lit1")
                    {
                        targetMCs.push(cAvt.pMC.mcChar);
                        i = 0;
                        while (i < spFX.avts.length)
                        {
                            tAvt = spFX.avts[i];
                            if ((((!(tAvt == null)) && (!(tAvt.pMC == null))) && (!(tAvt.pMC.mcChar == null))))
                            {
                                targetMCs.push(tAvt.pMC.mcChar);
                            };
                            i++;
                        };
                        if (targetMCs.length > 1)
                        {
                            AssetClass = (getClass("sp_C1") as Class);
                            if (AssetClass != null)
                            {
                                spellFX = new (AssetClass)();
                                spellFX.mouseEnabled = false;
                                spellFX.mouseChildren = false;
                                spellFX.visible = true;
                                spellFX.world = MovieClip(this);
                                spellFX.strl = spFX.strl;
                                rootClass.drawChainsLinear(targetMCs, 33, MovieClip(CHARS.addChild(spellFX)));
                            };
                        };
                    };
                }
                else
                {
                    if (spFX.fx == "f")
                    {
                        targetMCs.push(cAvt.pMC.mcChar);
                        tAvt = spFX.avts[0];
                        if ((((!(tAvt == null)) && (!(tAvt.pMC == null))) && (!(tAvt.pMC.mcChar == null))))
                        {
                            targetMCs.push(tAvt.pMC.mcChar);
                        };
                        if (targetMCs.length > 1)
                        {
                            spellFX = new MovieClip();
                            spellFX.mouseEnabled = false;
                            spellFX.mouseChildren = false;
                            spellFX.visible = true;
                            spellFX.world = MovieClip(this);
                            spellFX.strl = spFX.strl;
                            rootClass.drawFunnel(targetMCs, MovieClip(CHARS.addChild(spellFX)));
                        };
                    }
                    else
                    {
                        i = 0;
                        while (i < spFX.avts.length)
                        {
                            tAvt = spFX.avts[i];
                            AssetClass = (getClass(spFX.strl) as Class);
                            if (AssetClass != null)
                            {
                                spellFX = new (AssetClass)();
                                spellFX.spellDur = dur;
                                if (spell != null)
                                {
                                    spellFX.transform = spell.transform;
                                };
                                CHARS.addChild(spellFX);
                                spellFX.mouseEnabled = false;
                                spellFX.mouseChildren = false;
                                spellFX.visible = true;
                                spellFX.world = MovieClip(this);
                                spellFX.strl = spFX.strl;
                                spellFX.tMC = tAvt.pMC;
                                switch (spFX.fx)
                                {
                                    case "p":
                                        spellFX.x = cAvt.pMC.x;
                                        spellFX.y = (cAvt.pMC.y - (cAvt.pMC.mcChar.height * 0.5));
                                        spellFX.dir = (((tAvt.pMC.x - cAvt.pMC.x) >= 0) ? 1 : -1);
                                        break;
                                    case "w":
                                        spellFX.x = spellFX.tMC.x;
                                        spellFX.y = (spellFX.tMC.y + 3);
                                        if (cAvt != null)
                                        {
                                            if (spellFX.tMC.x < cAvt.pMC.x)
                                            {
                                                spellFX.scaleX = (spellFX.scaleX * -1);
                                            };
                                        };
                                        break;
                                };
                            }
                            else
                            {
                                trace();
                                trace(("*>*>*> Could not load class " + spFX.strl));
                                trace();
                            };
                            i++;
                        };
                    };
                };
            };
        }

        public function showSpellFXHit(spObj:*):*
        {
            var spFX:*;
            spFX = {};
            switch (spObj.strl)
            {
                case "sp_ice1":
                    spFX.strl = "sp_ice2";
                    break;
                case "sp_el3":
                    spFX.strl = "sp_el2";
                    break;
                case "sp_ed3":
                    spFX.strl = "sp_ed1";
                    break;
                case "sp_ef1":
                case "sp_ef6":
                    spFX.strl = "sp_ef2";
                    break;
            };
            spFX.fx = "w";
            spFX.avts = [spObj.tMC.pAV];
            castSpellFX(null, spFX, null);
        }

        public function doCastIA(iaState:Object):void
        {
        }

        public function getActionByActID(actID:int):Object
        {
            var actObj:Object;
            var i:int;
            actObj = null;
            i = 0;
            while (i < actions.active.length)
            {
                if (actions.active[i].actID == actID)
                {
                    actObj = actions.active[i];
                };
                i++;
            };
            return (actObj);
        }

        public function getActionByRef(actRef:String):Object
        {
            var actObj:*;
            for each (actObj in actions.active)
            {
                if (actObj.ref == actRef)
                {
                    return (actObj);
                };
            };
            for each (actObj in actions.passive)
            {
                if (actObj.ref == actRef)
                {
                    return (actObj);
                };
            };
            return (null);
        }

        public function handleSAR(resObj:Object):void
        {
            var o:Object;
            var cTyp:String;
            var cID:int;
            var source:*;
            var tSource:*;
            o = {};
            cTyp = "";
            cID = -1;
            var tTyp:String = "";
            var tID:int = -1;
            if (resObj.iRes == 1)
            {
                if (rootClass.bAnalyzer)
                {
                    if (!rootClass.bAnalyzer.isRunning)
                    {
                        return;
                    };
                    source = resObj.actionResult.cInf.split(":");
                    tSource = resObj.actionResult.tInf.split(":");
                    if (source[0] == "p")
                    {
                        if (source[1] == rootClass.sfc.myUserId)
                        {
                            if (resObj.actionResult.hp >= 0)
                            {
                                rootClass.bAnalyzer.addDamage(resObj.actionResult.hp);
                            }
                            else
                            {
                                rootClass.bAnalyzer.addHeal((resObj.actionResult.hp * -1));
                            };
                        };
                    }
                    else
                    {
                        if (tSource[0] == "p")
                        {
                            if (tSource[1] == rootClass.sfc.myUserId)
                            {
                                if (resObj.actionResult.hp >= 0)
                                {
                                    rootClass.bAnalyzer.addReceived(resObj.actionResult.hp);
                                }
                                else
                                {
                                    rootClass.bAnalyzer.addHeal((resObj.actionResult.hp * -1));
                                };
                            };
                        };
                    };
                };
                if (resObj.actionResult.typ == "d")
                {
                    showAuraImpact(resObj.actionResult);
                    o = rootClass.copyObj(resObj.actionResult);
                    o.a = [rootClass.copyObj(resObj.actionResult)];
                }
                else
                {
                    aggroMap(resObj.actionResult.cInf, resObj.actionResult.tInf, (resObj.actionResult.hp >= 0));
                    cTyp = resObj.actionResult.cInf.split(":")[0];
                    cID = int(resObj.actionResult.cInf.split(":")[1]);
                    tTyp = resObj.actionResult.tInf.split(":")[0];
                    tID = int(resObj.actionResult.tInf.split(":")[1]);
                    o = rootClass.copyObj(resObj.actionResult);
                    o.a = [rootClass.copyObj(resObj.actionResult)];
                    if (((cTyp == "p") && (cID == rootClass.sfc.myUserId)))
                    {
                        showActionResult(o, o.actID);
                    }
                    else
                    {
                        showIncomingAttackResult(o);
                    };
                };
            };
            if (resObj.iRes == 0)
            {
                switch (resObj.actionResult.cInf.split(":")[0])
                {
                    case "p":
                        showActionResult(null, resObj.actID);
                        break;
                };
            };
        }

        public function handleSARS(resObj:Object):void
        {
            var cTyp:String;
            var cID:int;
            var cInf:String;
            var actionResult:Object;
            var a:Array;
            var i:int;
            var o:Object = {};
            cTyp = "";
            cID = -1;
            var tTyp:String = "";
            var tID:int = -1;
            cInf = resObj.cInf;
            cInf = resObj.cInf;
            cTyp = cInf.split(":")[0];
            cID = int(cInf.split(":")[1]);
            actionResult = {};
            if (resObj.iRes == 1)
            {
                a = [];
                i = 0;
                while (i < resObj.a.length)
                {
                    if (rootClass.bAnalyzer)
                    {
                        if (!rootClass.bAnalyzer.isRunning)
                        {
                            return;
                        };
                        if (cTyp == "p")
                        {
                            if (cID == rootClass.sfc.myUserId)
                            {
                                if (resObj.a[i].hp >= 0)
                                {
                                    rootClass.bAnalyzer.addDamage(resObj.a[i].hp);
                                }
                                else
                                {
                                    rootClass.bAnalyzer.addHeal((resObj.a[i].hp * -1));
                                };
                            };
                        }
                        else
                        {
                            if (resObj.a[i].tInf.split(":")[0] == "p")
                            {
                                if (resObj.a[i].tInf.split(":")[1] == rootClass.sfc.myUserId)
                                {
                                    if (resObj.a[i].hp >= 0)
                                    {
                                        rootClass.bAnalyzer.addReceived(resObj.a[i].hp);
                                    }
                                    else
                                    {
                                        rootClass.bAnalyzer.addHeal((resObj.a[i].hp * -1));
                                    };
                                };
                            };
                        };
                    };
                    actionResult = resObj.a[i];
                    aggroMap(cInf, actionResult.tInf, (actionResult.hp >= 0));
                    i++;
                };
                if (((cTyp == "p") && (cID == rootClass.sfc.myUserId)))
                {
                    showActionResult(rootClass.copyObj(resObj), resObj.actID);
                }
                else
                {
                    showIncomingAttackResult(rootClass.copyObj(resObj));
                };
            };
            if (resObj.iRes == 0)
            {
                switch (cInf.split(":")[0])
                {
                    case "p":
                        showActionResult(null, resObj.actID);
                        break;
                };
            };
        }

        public function getActionResult(actionObj:*, targets:*):*
        {
            var xtArr:*;
            var cmd:*;
            var tgtStr:String;
            var tAvt:Avatar;
            var i:int;
            var now:Number;
            var icon:*;
            trace(("GAR > " + actionObj.nam));
            xtArr = [];
            cmd = "gar";
            tgtStr = "";
            i = 0;
            xtArr.push(actionID);
            if (targets.length > 0)
            {
                i = 0;
                while (i < targets.length)
                {
                    tAvt = targets[i].avt;
                    if (i > 0)
                    {
                        tgtStr = (tgtStr + ",");
                    };
                    tgtStr = (tgtStr + (actionObj.ref + ">"));
                    if (tAvt.npcType == "monster")
                    {
                        tgtStr = (tgtStr + ("m:" + tAvt.objData.MonMapID));
                    };
                    if (tAvt.npcType == "player")
                    {
                        tgtStr = (tgtStr + ("p:" + tAvt.uid));
                    };
                    i++;
                };
            }
            else
            {
                tgtStr = (tgtStr + (actionObj.ref + ">"));
            };
            xtArr.push(tgtStr);
            if (actionObj.ref == "i1")
            {
                xtArr.push(actionObj.sArg1);
            };
            xtArr.push("wvz");
            rootClass.sfc.sendXtMessage("zm", cmd, xtArr, "str", 1);
            if (((!(map.getAction == null)) && (map.getAction == true)))
            {
                try
                {
                    map.sendAction(actionObj.ref);
                }
                catch (e)
                {
                };
            };
            now = new Date().getTime();
            actionObj.lock = true;
            actionObj.actID = actionID;
            actionID++;
            if (actionID > actionIDLimit)
            {
                actionID = 0;
            };
            actionObj.lastTS = actionObj.ts;
            actionObj.ts = now;
            if (actionObj.typ != "aa")
            {
                coolDownAct(actionObj);
                globalCoolDownExcept(actionObj);
                if (((!(autoActionTimer.running)) && (actionObj.tgt == "h")))
                {
                    testAction(getAutoAttack());
                };
            }
            else
            {
                if (rootClass.litePreference.data.bSkillCD)
                {
                    coolDownAct(actionObj);
                }
                else
                {
                    i = 0;
                    while (i < actionMap.length)
                    {
                        if (actionMap[i] == actionObj.ref)
                        {
                            icon = MovieClip(rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i + 1))));
                            if (icon.bg.currentLabel != "pulse")
                            {
                                icon.bg.gotoAndPlay("pulse");
                            };
                        };
                        i++;
                    };
                };
                actionReady = false;
            };
            actionResults[actionResultID] = {};
        }

        public function showActionResult(actionResult:*, actID:*):*
        {
            var dat:*;
            var actObj:*;
            var originTS:*;
            var returnTS:*;
            var latency:*;
            var cd:*;
            var aacd:*;
            dat = new Date();
            actObj = getActionByActID(actID);
            if (actObj != null)
            {
                actObj.lock = false;
                actObj.actID = -1;
                originTS = actObj.ts;
                returnTS = dat.getTime();
                latency = int(((returnTS - originTS) / 2));
                if (actObj.typ == "aa")
                {
                    cd = Math.round((actObj.cd * (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha, -1), 0.5))));
                    aacd = (cd - int((returnTS - originTS)));
                    if (aacd > cd)
                    {
                        aacd = cd;
                    };
                    if (aacd < (cd - 100))
                    {
                        aacd = (cd - 100);
                    };
                    autoActionTimer.delay = aacd;
                    autoActionTimer.reset();
                    autoActionTimer.start();
                };
                if (actionResult == null)
                {
                    actObj.ts = actObj.lastTS;
                }
                else
                {
                    actObj.ts = Math.max(int((returnTS - latency)), (originTS + minLatencyOneWay));
                    unlockActionsExcept(actObj);
                    rootClass.updateActionObjIcon(actObj);
                };
            };
            if (actionResult != null)
            {
                playActionSound(actionResult);
                if (actionResult.type != "none")
                {
                    actionResults[actionResultID] = new ActionImpactTimer();
                    actionResults[actionResultID].world = MovieClip(this);
                    actionResults[actionResultID].actionResult = actionResult;
                    actionResults[actionResultID].showImpact(250);
                    if (++actionResultID > actionResultIDLimit)
                    {
                        actionResultID = 0;
                    };
                };
            };
        }

        public function showIncomingAttackResult(actionResult:Object):void
        {
            playActionSound(actionResult);
            actionResultsMon[actionIDMon] = new ActionImpactTimer();
            actionResultsMon[actionIDMon].world = MovieClip(this);
            actionResultsMon[actionIDMon].actionResult = actionResult;
            actionResultsMon[actionIDMon].showImpact(350);
            actionIDMon++;
            if (actionIDMon > actionIDLimitMon)
            {
                actionIDMon = 0;
            };
        }

        public function playActionSound(resObj:Object):void
        {
            var actionResult:Object;
            if (((resObj.a.length > 0) && (!(resObj.a[0].type == null))))
            {
                actionResult = resObj.a[0];
                switch (actionResult.type)
                {
                    case "hit":
                        if (actionResult.hp >= 0)
                        {
                            if (Math.random() < 0.5)
                            {
                                rootClass.mixer.playSound("Hit1");
                            }
                            else
                            {
                                rootClass.mixer.playSound("Hit2");
                            };
                        }
                        else
                        {
                            rootClass.mixer.playSound("Heal");
                        };
                        break;
                    case "crit":
                        if (actionResult.hp >= 0)
                        {
                            rootClass.mixer.playSound("Hit3");
                        }
                        else
                        {
                            rootClass.mixer.playSound("Heal");
                        };
                        break;
                    case "miss":
                        rootClass.mixer.playSound("Miss");
                        break;
                    case "none":
                        rootClass.mixer.playSound("Good");
                        break;
                };
            };
        }

        public function showActionImpact(resObj:*):*
        {
            var tMC:MovieClip;
            var actionFX:*;
            var actionDamage:*;
            var entType:String;
            var entID:int;
            var resultsT:Array;
            var resultsI:int;
            var tf:TextFormat;
            var i:int;
            var a:Array;
            var o:Object;
            if (rootClass.litePreference.data.bDisDmgDisplay)
            {
                return;
            };
            actionFX = null;
            actionDamage = null;
            entType = "";
            entID = 0;
            var results:Array = ["GOOD", "GREAT!", "MASSIVE!!"];
            resultsT = [0xFFFFFF, 0xFFFFFF, 0xFFFFFF];
            var resultsF:Array = [2381688, 0, 0];
            resultsI = 0;
            tf = new TextFormat();
            i = 0;
            a = resObj.a;
            o = {};
            i = 0;
            while (i < a.length)
            {
                o = a[i];
                entType = o.tInf.split(":")[0];
                entID = int(o.tInf.split(":")[1]);
                switch (entType)
                {
                    case "p":
                        tMC = avatars[entID].pMC;
                        break;
                    case "m":
                        tMC = getMonster(entID).pMC;
                        break;
                };
                if ((((!(tMC == null)) && (!(tMC.pAV == null))) && (!(tMC.pAV.dataLeaf == null))))
                {
                    switch (o.type)
                    {
                        case "hit":
                            actionDamage = new hitDisplay();
                            actionDamage.t.ti.autoSize = "center";
                            if (o.hp >= 0)
                            {
                                resultsI = 0;
                                actionDamage.t.ti.text = o.hp;
                                actionDamage.t.ti.textColor = resultsT[resultsI];
                                actionDamage.t.ti.filters = [new GlowFilter(0, 1, 5, 5, 5, 1, false, false)];
                                actionDamage.t.ti.setTextFormat(tf);
                            }
                            else
                            {
                                actionDamage.t.ti.text = (("+" + -(o.hp)) + "+");
                                actionDamage.t.ti.textColor = 65450;
                            };
                            wound(tMC, "damage");
                            break;
                        case "crit":
                            actionDamage = new critDisplay();
                            actionDamage.t.ti.autoSize = "center";
                            if (o.hp > 0)
                            {
                                actionDamage.t.ti.text = o.hp;
                                actionDamage.t.ti.textColor = 16750916;
                                actionDamage.t.ti.filters = [new GlowFilter(0x330000, 1, 5, 5, 5, 1, false, false)];
                            }
                            else
                            {
                                actionDamage.t.ti.text = -(o.hp);
                                actionDamage.t.ti.textColor = 65450;
                            };
                            wound(tMC, "damage");
                            break;
                        case "miss":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Miss!";
                            break;
                        case "dodge":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Dodge!";
                            if (isMoveOK(tMC.pAV.dataLeaf))
                            {
                                tMC.queueAnim("Dodge");
                            };
                            break;
                        case "parry":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Parry!";
                            if (isMoveOK(tMC.pAV.dataLeaf))
                            {
                                tMC.queueAnim("Dodge");
                            };
                            break;
                        case "block":
                            actionDamage = new avoidDisplay();
                            actionDamage.t.ti.text = "Block!";
                            if (isMoveOK(tMC.pAV.dataLeaf))
                            {
                                tMC.queueAnim("Block");
                            };
                            break;
                        case "none":
                    };
                    if (actionDamage != null)
                    {
                        tMC.addChild(actionDamage);
                        actionDamage.x = tMC.mcChar.x;
                        actionDamage.y = (tMC.pname.y + 10);
                    };
                    if (actionFX != null)
                    {
                        tMC.addChild(actionFX);
                        actionFX.x = tMC.mcChar.x;
                        actionFX.y = (tMC.pname.y + (tMC.mcChar.height / 2));
                    };
                };
                i++;
            };
        }

        public function showAuraImpact(auraObj:*):*
        {
            var tMC:MovieClip;
            var entType:*;
            var entID:*;
            var actionDamage:*;
            if (rootClass.litePreference.data.bDisDmgDisplay)
            {
                return;
            };
            entType = auraObj.tInf.split(":")[0];
            entID = int(auraObj.tInf.split(":")[1]);
            actionDamage = null;
            switch (entType)
            {
                case "p":
                    if ((((!(avatars[entID] == null)) && ("pMC" in avatars[entID])) && (!(avatars[entID].pMC == null))))
                    {
                        tMC = avatars[entID].pMC;
                    };
                    break;
                case "m":
                    if ((((!(getMonster(entID) == null)) && ("pMC" in getMonster(entID))) && (!(getMonster(entID).pMC == null))))
                    {
                        tMC = getMonster(entID).pMC;
                    };
                    break;
            };
            if (tMC != null)
            {
                actionDamage = new dotDisplay();
                actionDamage.hpDisplay = auraObj.hp;
                actionDamage.init();
                tMC.addChild(actionDamage);
                actionDamage.x = (tMC.mcChar.x + (-60 + Math.floor((Math.random() * 60))));
                actionDamage.y = ((tMC.pname.y + 10) + (0 + Math.floor((Math.random() * 60))));
            };
        }

        public function showAuraChange(resObj:Object, tAvt:Avatar, tLeaf:Object):*
        {
            var tMC:MovieClip;
            var actionDamage:* = undefined;
            var cLeaf:Object;
            var i:int;
            var nc:int;
            var gap:int;
            var child:DisplayObject;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            var aura:Object;
            var existingAura:Object;
            var dateObj:Date;
            var isOK:Boolean;
            var tFilters:Array;
            var tFilter:* = undefined;
            var auras:* = undefined;
            var ai:* = undefined;
            var actObj:* = undefined;
            var icon1:* = undefined;
            var filterIndex:int;
            trace("showAuraChange > ");
            tMC = tAvt.pMC;
            actionDamage = null;
            var cAvt:Avatar;
            cLeaf = null;
            if (tMC != null)
            {
                i = 0;
                nc = tMC.numChildren;
                gap = 1;
                if (resObj.cInf != null)
                {
                    cTyp = String(resObj.cInf.split(":")[0]);
                    cID = int(resObj.cInf.split(":")[1]);
                    switch (cTyp)
                    {
                        case "p":
                            cAvt = getAvatarByUserID(cID);
                            cLeaf = getUoLeafById(cID);
                            break;
                        case "m":
                            cAvt = getMonster(cID);
                            cLeaf = monTree[cID];
                            break;
                    };
                };
                if (resObj.auras != null)
                {
                    gap = resObj.auras.length;
                };
                i = 0;
                while (i < nc)
                {
                    child = tMC.getChildAt(i);
                    if ((((!(child == null)) && (!(child.toString() == null))) && (child.toString().indexOf("auraDisplay") > -1)))
                    {
                        child.y = (child.y - (int((child.height + 3)) * gap));
                    };
                    i = (i + 1);
                };
                aura = {};
                existingAura = {};
                dateObj = new Date();
                isOK = true;
                if (tLeaf.auras == null)
                {
                    tLeaf.auras = [];
                };
                if (tLeaf.passives == null)
                {
                    tLeaf.passives = [];
                };
                switch (resObj.cmd)
                {
                    case "aura+":
                    case "aura++":
                    case "aura+p":
                        i = 0;
                        while (i < resObj.auras.length)
                        {
                            aura = resObj.auras[i];
                            aura.cLeaf = cLeaf;
                            if (resObj.cmd == "aura+p")
                            {
                                aura.passive = true;
                            }
                            else
                            {
                                aura.passive = false;
                            };
                            if (!aura.passive)
                            {
                                if (aura.t != null)
                                {
                                    aura.ts = dateObj.getTime();
                                };
                                if (((((tAvt == myAvatar) || (tAvt == myAvatar.target)) || ((!(tLeaf.targets == null)) && (!(tLeaf.targets[rootClass.sfc.myUserId] == null)))) || (resObj.cmd == "aura++")))
                                {
                                    actionDamage = new auraDisplay();
                                    actionDamage.t.ti.text = (aura.nam + "!");
                                    if (aura.nam == "Spirit Power")
                                    {
                                        actionDamage.t.ti.text = ((aura.nam + " ") + aura.val);
                                    };
                                    trace(("potionType: " + aura.potionType));
                                    if (aura.potionType != null)
                                    {
                                        if (aura.potionType.toLowerCase() == "tonic")
                                        {
                                            tAvt.objData.Tonic = true;
                                        };
                                        if (aura.potionType.toLowerCase() == "elixir")
                                        {
                                            tAvt.objData.Elixir = true;
                                        };
                                    };
                                    if (aura.nam == "Skill Locked")
                                    {
                                        ai = 0;
                                        while (ai < actions.active.length)
                                        {
                                            actObj = actions.active[ai];
                                            if (actObj.nam == aura.val)
                                            {
                                                icon1 = rootClass.ui.mcInterface.actBar.getChildByName(("i" + (ai + 1)));
                                                icon1.actObj.skillLock = true;
                                            };
                                            ai++;
                                        };
                                    };
                                    tMC.addChild(actionDamage);
                                    actionDamage.x = ((tMC.mcChar.scaleX < 0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                                    actionDamage.y = ((tMC.pname.y + 25) + ((actionDamage.height + 3) * i));
                                    if (aura.fx != null)
                                    {
                                        addAuraFX(tMC, aura.fx);
                                    };
                                };
                                if (aura.s != null)
                                {
                                    switch (aura.s)
                                    {
                                        case "s":
                                            if (tMC.mcChar.currentLabel != "Fall")
                                            {
                                                tMC.clearQueue();
                                                tMC.mcChar.gotoAndPlay("Fall");
                                            };
                                            break;
                                    };
                                };
                                if (aura.cat != null)
                                {
                                    isOK = true;
                                    for each (existingAura in tLeaf.auras)
                                    {
                                        try
                                        {
                                            if (((!(existingAura.cat == null)) && (existingAura.cat == aura.cat)))
                                            {
                                                isOK = false;
                                            };
                                        }
                                        catch (e:Error)
                                        {
                                            trace(("combat.applyAuras > " + e));
                                        };
                                    };
                                    if (isOK)
                                    {
                                        switch (aura.cat)
                                        {
                                            case "paralyze":
                                            case "stone":
                                                tMC.modulateColor(statusStoneCT, "+");
                                                tMC.mcChar.stop();
                                                break;
                                            case "freeze":
                                                tMC.modulateColor(statusFreezeCT, "+");
                                                tMC.mcChar.stop();
                                                break;
                                            case "clean":
                                                tFilters = tMC.mcChar.filters;
                                                tFilters.push(new GlowFilter(0xFFFFFF, 1, 30, 30, 2, 2));
                                                tMC.mcChar.filters = tFilters;
                                                break;
                                        };
                                    };
                                };
                                if (((!(aura.animOn == null)) && ((cLeaf == null) || (cLeaf.intState == 2))))
                                {
                                    if (aura.animOn.indexOf("fadeFX:") > -1)
                                    {
                                        removeAuraFX(tMC, aura.animOn.split(":")[1], "fade");
                                    }
                                    else
                                    {
                                        if (aura.animOn.indexOf("useFX:") > -1)
                                        {
                                            removeAuraFX(tMC, aura.animOn.split(":")[1], "use");
                                        }
                                        else
                                        {
                                            if (aura.animOn.indexOf("removeFX:") > -1)
                                            {
                                                removeAuraFX(tMC, aura.animOn.split(":")[1]);
                                            }
                                            else
                                            {
                                                tMC.mcChar.gotoAndPlay(aura.animOn);
                                            };
                                        };
                                    };
                                };
                                if (aura.msgOn != null)
                                {
                                    if (aura.msgOn.charAt(0) == "@")
                                    {
                                        if (tAvt == myAvatar)
                                        {
                                            rootClass.addUpdate(aura.msgOn.substr(1));
                                        };
                                    }
                                    else
                                    {
                                        rootClass.addUpdate(aura.msgOn);
                                    };
                                };
                                if (aura.isNew)
                                {
                                    tLeaf.auras.push(aura);
                                }
                                else
                                {
                                    updateAuraData(cLeaf, aura, tLeaf);
                                };
                            }
                            else
                            {
                                tLeaf.passives.push(aura);
                            };
                            i = (i + 1);
                        };
                        break;
                    case "aura-":
                    case "aura--":
                        auras = [];
                        if (resObj.auras != null)
                        {
                            auras = resObj.auras;
                        }
                        else
                        {
                            if (resObj.aura != null)
                            {
                                auras = [resObj.aura];
                            };
                        };
                        i = 0;
                        while (i < auras.length)
                        {
                            aura = auras[i];
                            if (removeAura(aura, tLeaf, tMC))
                            {
                                if (((((tAvt == myAvatar) || (tAvt == myAvatar.target)) || ((!(tLeaf.targets == null)) && (!(tLeaf.targets[rootClass.sfc.myUserId] == null)))) || (resObj.cmd == "aura--")))
                                {
                                    actionDamage = new auraDisplay();
                                    actionDamage.t.ti.text = (("*" + aura.nam) + " fades*");
                                    actionDamage.t.ti.textColor = 0x999999;
                                    tMC.addChild(actionDamage);
                                    actionDamage.x = ((tMC.mcChar.scaleX < 0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                                    actionDamage.y = (tMC.pname.y + 25);
                                };
                                if (aura.potionType != null)
                                {
                                    if (aura.potionType.toLowerCase() == "tonic")
                                    {
                                        tAvt.objData.Tonic = false;
                                    };
                                    if (aura.potionType.toLowerCase() == "elixir")
                                    {
                                        tAvt.objData.Elixir = false;
                                    };
                                };
                                if (aura.s != null)
                                {
                                    switch (aura.s)
                                    {
                                        case "s":
                                            if (tMC.mcChar.currentLabel == "Fall")
                                            {
                                                if (isStatusGone("s", tLeaf))
                                                {
                                                    tMC.mcChar.gotoAndPlay("Getup");
                                                };
                                            };
                                            break;
                                    };
                                };
                                if (aura.cat != null)
                                {
                                    isOK = true;
                                    for each (existingAura in tLeaf.auras)
                                    {
                                        try
                                        {
                                            if (((!(existingAura.cat == null)) && (existingAura.cat == aura.cat)))
                                            {
                                                isOK = false;
                                            };
                                        }
                                        catch (e:Error)
                                        {
                                            trace(("combat.applyAuras > " + e));
                                        };
                                    };
                                    if (isOK)
                                    {
                                        switch (aura.cat)
                                        {
                                            case "stone":
                                                tMC.modulateColor(statusStoneCT, "-");
                                                tMC.mcChar.play();
                                                break;
                                            case "freeze":
                                                tMC.modulateColor(statusFreezeCT, "-");
                                                tMC.mcChar.play();
                                                break;
                                            case "clean":
                                                tFilters = tMC.mcChar.filters;
                                                filterIndex = 0;
                                                while (filterIndex < tFilters.length)
                                                {
                                                    tFilter = tFilters[filterIndex];
                                                    if (((tFilter is GlowFilter) && (GlowFilter(tFilter).color == 0xFFFFFF)))
                                                    {
                                                        tFilters.splice(filterIndex, 1);
                                                        filterIndex = (filterIndex - 1);
                                                    };
                                                    filterIndex = (filterIndex + 1);
                                                };
                                                tMC.mcChar.filters = tFilters;
                                                break;
                                        };
                                    };
                                };
                                if (aura.nam == "Skill Locked")
                                {
                                    ai = 0;
                                    while (ai < actions.active.length)
                                    {
                                        actObj = actions.active[ai];
                                        if (actObj.nam == aura.val)
                                        {
                                            icon1 = rootClass.ui.mcInterface.actBar.getChildByName(("i" + (ai + 1)));
                                            icon1.actObj.skillLock = false;
                                            icon1.cnt.alpha = 1;
                                        };
                                        ai++;
                                    };
                                };
                                if (aura.animOff != null)
                                {
                                    tMC.mcChar.gotoAndPlay(aura.animOff);
                                };
                                if (aura.msgOff != null)
                                {
                                    if (aura.msgOff.charAt(0) == "@")
                                    {
                                        if (tAvt == myAvatar)
                                        {
                                            rootClass.addUpdate(aura.msgOff.substr(1));
                                        };
                                    }
                                    else
                                    {
                                        rootClass.addUpdate(aura.msgOff);
                                    };
                                };
                            };
                            i = (i + 1);
                        };
                        break;
                    case "aura*":
                        actionDamage = new auraDisplay();
                        actionDamage.t.ti.text = "* IMMUNE *";
                        tMC.addChild(actionDamage);
                        actionDamage.x = ((tMC.mcChar.scaleX < 0) ? 35 : (-(actionDamage.t.ti.textWidth) - 35));
                        actionDamage.y = ((tMC.pname.y + 25) + ((actionDamage.height + 3) * i));
                        break;
                };
            };
        }

        public function updateAuraData(cLeaf:Object, aura:Object, tLeaf:Object):void
        {
            var existingAura:Object;
            for each (existingAura in tLeaf.auras)
            {
                if (((existingAura.nam == aura.nam) && (existingAura.cLeaf == cLeaf)))
                {
                    existingAura.dur = aura.dur;
                    existingAura.val = aura.val;
                };
            };
        }

        public function handleAuraEvent(cmd:String, resObj:Object):void
        {
            var cLeaf:Object;
            var tLeaf:Object;
            var cAvt:Avatar;
            var tAvt:Avatar;
            var cTyp:String;
            var cID:int;
            var tTyp:String;
            var tID:int;
            var forceAura:Boolean;
            trace("handleAuraEvent >");
            if (rootClass.sfcSocial)
            {
                forceAura = false;
                if (((cmd.indexOf("++") > -1) || (cmd.indexOf("--") > -1)))
                {
                    forceAura = true;
                };
                cAvt = null;
                tAvt = null;
                if (resObj.cInf != null)
                {
                    cTyp = String(resObj.cInf.split(":")[0]);
                    cID = int(resObj.cInf.split(":")[1]);
                    switch (cTyp)
                    {
                        case "p":
                            cAvt = getAvatarByUserID(cID);
                            cLeaf = getUoLeafById(cID);
                            break;
                        case "m":
                            cAvt = getMonster(cID);
                            cLeaf = monTree[cID];
                            break;
                    };
                };
                if (resObj.tInf != null)
                {
                    tTyp = String(resObj.tInf.split(":")[0]);
                    tID = int(resObj.tInf.split(":")[1]);
                    switch (tTyp)
                    {
                        case "p":
                            try
                            {
                                tAvt = getAvatarByUserID(tID);
                                tLeaf = getUoLeafById(tID);
                                if (((forceAura) || (tLeaf.strFrame == strFrame)))
                                {
                                    if (rootClass.sfcSocial)
                                    {
                                        showAuraChange(resObj, tAvt, tLeaf);
                                    };
                                };
                            }
                            catch (e:Error)
                            {
                            };
                            break;
                        case "m":
                            try
                            {
                                tAvt = getMonster(tID);
                                tLeaf = monTree[tID];
                                if (((forceAura) || ((cLeaf == null) || ((!(cLeaf.targets[tID] == null)) && (tLeaf.strFrame == strFrame)))))
                                {
                                    if (rootClass.sfcSocial)
                                    {
                                        showAuraChange(resObj, tAvt, tLeaf);
                                    };
                                };
                            }
                            catch (e:Error)
                            {
                                trace((" HAE > " + e));
                            };
                            break;
                    };
                };
            };
        }

        public function removeAura(aura:Object, tLeaf:Object, tMC:MovieClip):Boolean
        {
            var foundIt:Boolean;
            var i:int;
            trace(("removeAura > " + aura.nam));
            if (rootClass.sfcSocial)
            {
                foundIt = false;
                i = 0;
                i = 0;
                while (i < tLeaf.auras.length)
                {
                    if (tLeaf.auras[i].nam == aura.nam)
                    {
                        if (((!(tMC == null)) && (!(tLeaf.auras[i].fx == null))))
                        {
                            removeAuraFX(tMC, tLeaf.auras[i].fx, "fade");
                        };
                        tLeaf.auras.splice(i, 1);
                        i = tLeaf.auras.length;
                        foundIt = true;
                    };
                    i++;
                };
                i = 0;
                while (i < tLeaf.passives.length)
                {
                    if (tLeaf.passives[i].nam == aura.nam)
                    {
                        tLeaf.passives.splice(i, 1);
                        i = tLeaf.passives.length;
                        foundIt = false;
                    };
                    i++;
                };
                trace(("returning " + foundIt));
                return (foundIt);
            };
            trace("Unsocial, returning false");
            return (false);
        }

        public function addAuraFX(tMC:MovieClip, fxName:String):void
        {
            var c:Class;
            var fx:MovieClip;
            trace(("addAuraFX  > " + fxName));
            try
            {
                if (tMC.fx.getChildByName(fxName) == null)
                {
                    c = getClass(fxName);
                    fx = MovieClip(tMC.fx.addChild(new (c)()));
                    fx.name = fxName;
                    fx.y = -30;
                };
            }
            catch (e:Error)
            {
                trace(e);
            };
            trace("");
        }

        public function removeAuraFX(tMC:MovieClip, fxName:String, fxLabel:String = null):void
        {
            var i:int;
            var fx:MovieClip;
            trace((("removeAuraFX  > " + fxName) + ((fxLabel != null) ? (" " + fxLabel) : "")));
            i = 0;
            i = 0;
            while (i < tMC.fx.numChildren)
            {
                fx = MovieClip(tMC.fx.getChildAt(i));
                if (((fxName == "all") || (fx.name == fxName)))
                {
                    if (fxLabel != null)
                    {
                        try
                        {
                            MovieClip(fx.getChildByName("inner")).gotoAndPlay(fxLabel);
                        }
                        catch (fxe:Error)
                        {
                            trace(("fx play error > " + fxe));
                        };
                    }
                    else
                    {
                        MovieClip(tMC.fx.removeChildAt(i)).stop();
                        i = (i - 1);
                    };
                };
                i = (i + 1);
            };
        }

        public function isStatusGone(statusStr:String, tLeaf:Object):Boolean
        {
            var i:*;
            i = 0;
            while (i < tLeaf.auras.length)
            {
                if (((!(tLeaf.auras[i].s == null)) && (tLeaf.auras[i].s == statusStr)))
                {
                    return (false);
                };
                i++;
            };
            return (true);
        }

        public function isMoveOK(tLeaf:Object):Boolean
        {
            var isOK:Boolean;
            var aura:Object;
            isOK = true;
            aura = {};
            if (tLeaf.auras != null)
            {
                for each (aura in tLeaf.auras)
                {
                    try
                    {
                        if (aura.cat != null)
                        {
                            if (aura.cat == "stun")
                            {
                                isOK = false;
                            };
                            if (aura.cat == "stone")
                            {
                                isOK = false;
                            };
                            if (aura.cat == "disabled")
                            {
                                isOK = false;
                            };
                        };
                    }
                    catch (e:Error)
                    {
                        trace(("doAnim > " + e));
                    };
                };
                return (isOK);
            };
            return (false);
        }

        public function wound(obj:*, typ:*):*
        {
            var flickermc:*;
            if (rootClass.litePreference.data.bDisDmgStrobe)
            {
                return;
            };
            if (typ == "damage")
            {
                flickermc = new MovieClip();
                flickermc.name = "flickermc";
                flickermc.maxF = 3;
                flickermc.curF = 0;
                flickermc.addEventListener(Event.ENTER_FRAME, flickerFrame);
                if (obj.contains(flickermc))
                {
                    obj.flickermc.removeEventListener(Event.ENTER_FRAME, flickerFrame);
                    obj.removeChild(flickermc);
                };
                obj.addChild(flickermc);
            };
        }

        public function flickerFrame(e:Event):*
        {
            var mc:*;
            mc = MovieClip(e.currentTarget);
            if (((!(mc.parent == null)) && (!(mc.parent.stage == null))))
            {
                if (mc.curF == 0)
                {
                    mc.parent.modulateColor(avtWCT, "+");
                };
                if (mc.curF == 1)
                {
                    mc.parent.modulateColor(avtWCT, "-");
                };
                if (mc.curF == 2)
                {
                    mc.parent.modulateColor(avtWCT, "+");
                };
                if (mc.curF >= mc.maxF)
                {
                    mc.parent.modulateColor(avtWCT, "-");
                    mc.removeEventListener(Event.ENTER_FRAME, flickerFrame);
                    mc.parent.removeChild(mc);
                };
                mc.curF++;
            }
            else
            {
                mc.removeEventListener(Event.ENTER_FRAME, flickerFrame);
            };
        }

        public function unlockActionsExcept(ao:*):*
        {
            var actIcons:*;
            var ai:*;
            var j:*;
            var actObj:*;
            var i:*;
            var icon1:*;
            actIcons = [];
            ai = 0;
            ai = 0;
            while (ai < actions.active.length)
            {
                actObj = actions.active[ai];
                if ((((!(actObj.ref == ao.ref)) && (actObj.lock == true)) && (actObj.ts < ao.ts)))
                {
                    i = 0;
                    while (i < actionMap.length)
                    {
                        if (actionMap[i] == actObj.ref)
                        {
                            actIcons.push(("i" + (i + 1)));
                        };
                        i++;
                    };
                };
                ai++;
            };
            j = 0;
            while (j < actIcons.length)
            {
                icon1 = rootClass.ui.mcInterface.actBar.getChildByName(actIcons[j]);
                if (icon1.actObj != null)
                {
                    icon1.actObj.lock = false;
                };
                j++;
            };
        }

        public function unlockActions():*
        {
            var ai:*;
            var actObj:*;
            ai = 0;
            while (ai < actions.active.length)
            {
                actObj = actions.active[ai];
                actObj.lock = false;
                ai++;
            };
        }

        public function updateActBar():void
        {
            var j:*;
            var icon1:*;
            var locked:*;
            if ((((!(myAvatar == null)) && (!(myAvatar.dataLeaf == null))) && (!(myAvatar.dataLeaf.sta == null))))
            {
                j = 0;
                while (j < rootClass.ui.mcInterface.actBar.numChildren)
                {
                    icon1 = rootClass.ui.mcInterface.actBar.getChildAt(j);
                    if ((("actObj" in icon1) && (!(icon1.actObj == null))))
                    {
                        locked = icon1.actObj.skillLock;
                        locked = ((locked == null) ? false : locked);
                        if (((myAvatar.dataLeaf.intMP >= Math.round((icon1.actObj.mp * myAvatar.dataLeaf.sta["$cmc"]))) && (!(locked))))
                        {
                            if (icon1.cnt.alpha < 1)
                            {
                                icon1.cnt.alpha = 1;
                            };
                        }
                        else
                        {
                            if (icon1.cnt.alpha == 1)
                            {
                                icon1.cnt.alpha = 0.4;
                            };
                        };
                    };
                    j++;
                };
            };
        }

        public function getActIcons(actionObj:Object):Array
        {
            var actIcons:Array;
            var icon1:MovieClip;
            var i:*;
            actIcons = [];
            i = 0;
            while (i < actionMap.length)
            {
                if (actionMap[i] == actionObj.ref)
                {
                    icon1 = (rootClass.ui.mcInterface.actBar.getChildByName(("i" + (i + 1))) as MovieClip);
                    if (icon1 != null)
                    {
                        actIcons.push(icon1);
                    };
                };
                i++;
            };
            return (actIcons);
        }

        public function globalCoolDownExcept(exemptAction:Object):void
        {
            var now:Number;
            var actIcon:MovieClip;
            var actionObj:Object;
            now = new Date().getTime();
            for each (actionObj in actions.active)
            {
                if (actionObj.isOK)
                {
                    actIcon = getActIcons(actionObj)[0];
                    if (actIcon != null)
                    {
                        try
                        {
                            if ((((!(actionObj == exemptAction)) && (!(actionObj.ref == "aa"))) && (((!("icon2" in actIcon)) || (actIcon.icon2 == null)) || (((actionObj.ts + actionObj.cd) > now) && (((actionObj.ts + actionObj.cd) - now) < GCD)))))
                            {
                                coolDownAct(actionObj, GCD, now);
                            };
                        }
                        catch (e:Error)
                        {
                        };
                    };
                };
            };
            GCDTS = now;
        }

        public function checkCooldown(actionObj:Object):*
        {
            var actIcons:Array;
            var icon1:MovieClip;
            var i:int;
            var bmd:*;
            var bm:*;
            var icon2:*;
            actIcons = getActIcons(actionObj);
            while (i < actIcons.length)
            {
                icon1 = actIcons[i];
                if (icon1.icon2 != null)
                {
                    icon1.bitmapData.dispose();
                    bmd = new BitmapData(50, 50, true, 0);
                    bmd.draw(icon1, null, iconCT);
                    bm = new Bitmap(bmd);
                    icon2 = rootClass.ui.mcInterface.actBar.addChild(bm);
                    icon1.icon2 = icon2;
                };
                i++;
            };
        }

        public function coolDownAct(actionObj:Object, cd:int = -1, ts:Number = -1):*
        {
            var actIcons:Array;
            var icon1:MovieClip;
            var j:int;
            var icon2:*;
            var iMask:MovieClip;
            var bmd:*;
            var bm:*;
            var k:int;
            var iconF:DisplayObject;
            actIcons = getActIcons(actionObj);
            j = 0;
            while (j < actIcons.length)
            {
                icon1 = actIcons[j];
                icon2 = null;
                iMask = null;
                if (icon1.icon2 == null)
                {
                    bmd = new BitmapData(50, 50, true, 0);
                    bmd.draw(icon1, null, iconCT);
                    bm = new Bitmap(bmd);
                    icon2 = rootClass.ui.mcInterface.actBar.addChild(bm);
                    icon1.icon2 = icon2;
                    if (cd == -1)
                    {
                        iconF = rootClass.ui.mcInterface.actBar.addChild(new iconFlare());
                        icon2.transform = (iconF.transform = icon1.transform);
                        icon1.ts = actionObj.ts;
                        icon1.cd = actionObj.cd;
                    }
                    else
                    {
                        icon2.transform = icon1.transform;
                        icon1.ts = ts;
                        icon1.cd = cd;
                    };
                    iMask = (rootClass.ui.mcInterface.actBar.addChild(new ActMask()) as MovieClip);
                    iMask.scaleX = 0.33;
                    iMask.scaleY = 0.33;
                    iMask.x = int(((icon2.x + (icon2.width / 2)) - (iMask.width / 2)));
                    iMask.y = int(((icon2.y + (icon2.height / 2)) - (iMask.height / 2)));
                    k = 0;
                    while (k < 4)
                    {
                        iMask[(("e" + k) + "oy")] = iMask[("e" + k)].y;
                        k++;
                    };
                    icon2.mask = iMask;
                }
                else
                {
                    icon2 = icon1.icon2;
                    iMask = icon2.mask;
                    if (cd == -1)
                    {
                        icon1.ts = actionObj.ts;
                        icon1.cd = actionObj.cd;
                    }
                    else
                    {
                        icon1.ts = ts;
                        icon1.cd = cd;
                    };
                };
                if (((cd == -1) && (rootClass.litePreference.data.bSkillCD)))
                {
                    switch (actionObj.ref)
                    {
                        case "aa":
                            icon1.ref = "txtCD0";
                            break;
                        case "i1":
                            icon1.ref = "txtCD5";
                            break;
                        default:
                            icon1.ref = ("txtCD" + actionObj.ref.slice(1));
                    };
                    rootClass.ui.mcInterface.actBar.setChildIndex(rootClass.ui.mcInterface.actBar.getChildByName(icon1.ref), (rootClass.ui.mcInterface.actBar.numChildren - 1));
                    rootClass.ui.mcInterface.actBar.getChildByName(icon1.ref).text = String(Number((icon1.cd / 1000)).toFixed(1));
                    rootClass.ui.mcInterface.actBar.getChildByName(icon1.ref).visible = true;
                };
                iMask.e0.stop();
                iMask.e1.stop();
                iMask.e2.stop();
                iMask.e3.stop();
                icon1.removeEventListener(Event.ENTER_FRAME, countDownAct);
                icon1.addEventListener(Event.ENTER_FRAME, countDownAct, false, 0, true);
                j++;
            };
        }

        public function countDownAct(e:Event):void
        {
            var dat:*;
            var ti:*;
            var ct1:*;
            var ct2:*;
            var cd:*;
            var tp:*;
            var mc:*;
            var fr:*;
            var i:*;
            var iMask:*;
            dat = new Date();
            ti = dat.getTime();
            ct1 = MovieClip(e.target);
            ct2 = ct1.icon2;
            cd = Math.round((ct1.cd * (1 - Math.min(Math.max(myAvatar.dataLeaf.sta.$tha, -1), 0.5))));
            tp = ((ti - ct1.ts) / cd);
            mc = Math.floor((tp * 4));
            fr = (int(((tp * 360) % 90)) + 1);
            if (!ct1.actObj.lock)
            {
                if (tp < 0.99)
                {
                    if (ct1.ref)
                    {
                        rootClass.ui.mcInterface.actBar.getChildByName(ct1.ref).text = String(Number((Number((1 - tp)) * (ct1.cd / 1000))).toFixed(1));
                    };
                    i = 0;
                    while (i < 4)
                    {
                        if (i < mc)
                        {
                            ct2.mask[("e" + i)].y = -300;
                        }
                        else
                        {
                            ct2.mask[("e" + i)].y = ct2.mask[(("e" + i) + "oy")];
                            if (i > mc)
                            {
                                ct2.mask[("e" + i)].gotoAndStop(0);
                            };
                        };
                        i++;
                    };
                    MovieClip(ct2.mask[("e" + mc)]).gotoAndStop(fr);
                }
                else
                {
                    if (ct1.ref)
                    {
                        rootClass.ui.mcInterface.actBar.getChildByName(ct1.ref).visible = false;
                    };
                    iMask = ct2.mask;
                    ct2.mask = null;
                    ct2.parent.removeChild(iMask);
                    ct1.removeEventListener(Event.ENTER_FRAME, countDownAct);
                    ct2.parent.removeChild(ct2);
                    ct2.bitmapData.dispose();
                    ct1.icon2 = null;
                };
            };
        }

        public function healByIcon(tAvt:Avatar):void
        {
            var actObj:Object;
            actObj = getFirstHeal();
            if (actObj != null)
            {
                setTarget(tAvt);
                testAction(actObj);
            };
        }

        public function getFirstHeal():Object
        {
            var i:*;
            try
            {
                i = 0;
                while (i < actions.active.length)
                {
                    if (((((!(actions.active[i] == null)) && (!(actions.active[i].damage == null))) && (actions.active[i].damage < 0)) && (actions.active[i].isOK)))
                    {
                        return (actions.active[i]);
                    };
                    i++;
                };
            }
            catch (e:Error)
            {
            };
            return (null);
        }

        public function AATest(e:Event):*
        {
            trace("TIMER AATest > DISABLED");
        }

        public function connTest(e:Event):*
        {
            trace("TIMER connTest > Failed!  This should not appear, test was removed.");
        }

        internal function checkSP(sp:int, leaf:Object):Boolean
        {
            var i:*;
            i = 0;
            while (i < leaf.auras.length)
            {
                if (leaf.auras[i].nam == "Spirit Power")
                {
                    if (sp <= leaf.auras[i].val)
                    {
                        return (true);
                    };
                    return (false);
                };
                i++;
            };
            return (false);
        }

        public function acceptQuest(QuestID:int):void
        {
            if (questTree[QuestID] == null)
            {
                getQuests([QuestID]);
            };
            if (questTree[QuestID].status == null)
            {
                questTree[QuestID].status = "p";
                rootClass.ui.mcQTracker.updateQuest();
            };
            if (!rootClass.ui.mcQTracker.visible)
            {
                rootClass.ui.mcQTracker.toggle();
            };
            rootClass.sfc.sendXtMessage("zm", "acceptQuest", [QuestID], "str", curRoom);
        }

        public function tryQuestComplete(QuestID:int, choiceID:int = -1, warQuest:Boolean = false):void
        {
            rootClass.sfc.sendXtMessage("zm", "tryQuestComplete", [QuestID, choiceID, warQuest, "wvz"], "str", curRoom);
        }

        public function getMapItem(MergeID:int):void
        {
            if (coolDown("getMapItem"))
            {
                rootClass.sfc.sendXtMessage("zm", "getMapItem", [MergeID], "str", curRoom);
            };
        }

        public function isQuestInProgress(QuestID:int):Boolean
        {
            return ((!(questTree[QuestID] == null)) && (!(questTree[QuestID].status == null)));
        }

        public function getQuests(QuestIDs:Array):void
        {
            rootClass.sfc.sendXtMessage("zm", "getQuests", QuestIDs, "str", curRoom);
        }

        public function getQuest(QuestID:int):void
        {
        }

        public function showQuestList(qMode:String, strQuestIDs:String, strTurnInIDs:String):void
        {
            var QFrame:*;
            var qIDs:*;
            var tIDs:*;
            var missing:*;
            var i:*;
            var qID:String;
            if (!rootClass.isGreedyModalInStack())
            {
                rootClass.clearPopupsQ();
                QFrame = rootClass.attachOnModalStack("QFrameMC");
                qIDs = strQuestIDs.split(",");
                tIDs = strTurnInIDs.split(",");
                QFrame.sIDs = qIDs;
                QFrame.tIDs = tIDs;
                QFrame.world = this;
                QFrame.rootClass = rootClass;
                QFrame.qMode = qMode;
                missing = [];
                i = 0;
                while (i < qIDs.length)
                {
                    qID = qIDs[i];
                    if (questTree[qID] == null)
                    {
                        missing.push(qID);
                    }
                    else
                    {
                        if (questTree[qID].strDynamic != null)
                        {
                            questTree[qID] = null;
                            delete questTree[qID];
                            missing.push(qID);
                        };
                    };
                    i++;
                };
                if (((missing.length > 0) && (!(strQuestIDs == ""))))
                {
                    getQuests(missing);
                }
                else
                {
                    QFrame.open();
                };
            };
        }

        public function getApop(intID:String):void
        {
            var apopObj:Object;
            var missing:*;
            var sc:Object;
            var i:uint;
            var qArray:Array;
            var j:uint;
            if (int(intID) < 1)
            {
                return;
            };
            if (rootClass.curID != intID)
            {
                rootClass.curID = intID;
                rootClass.sfc.sendXtMessage("zm", "getApop", [intID], "str", curRoom);
                return;
            };
            apopObj = rootClass.apopTree[intID];
            missing = new Array();
            i = 0;
            for (; i < apopObj.arrScenes.length; i++)
            {
                sc = apopObj.arrScenes[i];
                if (sc.qID == null)
                {
                    trace(((("sc.sceneID: " + sc.sceneID) + " arrQuests: ") + sc.arrQuests));
                    if (sc.arrQuests != null)
                    {
                        qArray = String(sc.arrQuests).split(",");
                        j = 0;
                        while (j < qArray.length)
                        {
                            if (questTree[qArray[j]] == null)
                            {
                                missing.push(qArray[j]);
                                rootClass.quests = true;
                            }
                            else
                            {
                                if (questTree[qArray[j]].strDynamic != null)
                                {
                                    questTree[qArray[j]] = null;
                                    delete questTree[qArray[j]];
                                    missing.push(qArray[j]);
                                    rootClass.quests = true;
                                };
                            };
                            j++;
                        };
                        continue;
                    };
                }
                else
                {
                    if (questTree[sc.qID] == null)
                    {
                        missing.push(sc.qID);
                        rootClass.quests = true;
                    }
                    else
                    {
                        if (questTree[sc.qID].strDynamic != null)
                        {
                            questTree[sc.qID] = null;
                            delete questTree[sc.qID];
                            missing.push(sc.qID);
                            rootClass.quests = true;
                        };
                    };
                };
            };
            if (missing.length > 0)
            {
                rootClass.quests = true;
                rootClass.sfc.sendXtMessage("zm", "getQuests2", missing, "str", curRoom);
            }
            else
            {
                rootClass.quests = false;
                rootClass.createApop();
            };
        }

        public function showQuests(strQuestIDs:String, qMode:String):void
        {
            showQuestList(qMode, strQuestIDs, strQuestIDs);
        }

        public function showQuestLink(o:Object):void
        {
            var itemOpen:String;
            var itemClose:String;
            var msg:String;
            itemOpen = "$({";
            itemClose = "})$";
            msg = "";
            if (o.unm.toLowerCase() != rootClass.sfc.myUserName)
            {
                msg = (msg + ((o.unm + " issues a Call to Arms for ") + itemOpen));
                msg = (msg + ["quest", o.quest.sName, o.quest.QuestID, o.quest.iLvl, o.unm].toString());
                msg = (msg + (itemClose + "!"));
            }
            else
            {
                msg = (msg + (("You issue a Call to Arms for " + o.quest.sName) + "!"));
            };
            rootClass.chatF.pushMsg("event", msg, "SERVER", "", 0);
        }

        public function getActiveQuests():String
        {
            var str:String;
            var questID:*;
            var quest:*;
            str = "";
            for (questID in questTree)
            {
                quest = questTree[questID];
                if (quest.status != null)
                {
                    if (str.length)
                    {
                        str = (str + ("," + questID));
                    }
                    else
                    {
                        str = (str + questID);
                    };
                };
            };
            return (str);
        }

        public function checkAllQuestStatus(specificID:* = null):*
        {
            var a:Array;
            var questID:String;
            var quest:*;
            var cParams:*;
            var p:*;
            var i:int;
            var qItemID:*;
            var qItemQ:*;
            var date:*;
            a = [];
            if (specificID != null)
            {
                a = [String(specificID)];
            }
            else
            {
                for (questID in questTree)
                {
                    a.push(questID);
                };
            };
            for each (questID in a)
            {
                quest = questTree[questID];
                cParams = {};
                if (quest.status != null)
                {
                    if (((!(quest.turnin == null)) && (quest.turnin.length > 0)))
                    {
                        cParams.sItems = true;
                        i = 0;
                        while (i < quest.turnin.length)
                        {
                            qItemID = quest.turnin[i].ItemID;
                            qItemQ = quest.turnin[i].iQty;
                            if (((invTree[qItemID] == null) || (invTree[qItemID].iQty < qItemQ)))
                            {
                                cParams.sItems = false;
                                break;
                            };
                            i++;
                        };
                    };
                    if (quest.iTime != null)
                    {
                        cParams.iTime = false;
                        if (quest.ts != null)
                        {
                            date = new Date();
                            if ((date.getTime() - quest.ts) <= quest.iTime)
                            {
                                cParams.iTime = true;
                            };
                        };
                    };
                    quest.status = "c";
                    for (p in cParams)
                    {
                        if (cParams[p] == false)
                        {
                            quest.status = "p";
                        };
                    };
                };
            };
            rootClass.ui.mcQTracker.updateQuest();
        }

        public function updateQuestProgress(typ:String, o:Object):void
        {
            var questID:*;
            var quest:*;
            var cParams:*;
            var i:int;
            var qItemID:*;
            var qItemQ:*;
            var item:*;
            for (questID in questTree)
            {
                quest = questTree[questID];
                cParams = {};
                if (quest.status != null)
                {
                    if (rootClass.litePreference.data.bQuestNotif)
                    {
                        if ((((typ == "item") && (!(quest.turnin == null))) && (quest.turnin.length > 0)))
                        {
                            cParams.sItems = true;
                            i = 0;
                            while (i < quest.turnin.length)
                            {
                                qItemID = quest.turnin[i].ItemID;
                                qItemQ = quest.turnin[i].iQty;
                                if ((((o.ItemID == qItemID) && (!(invTree[qItemID] == null))) && (invTree[qItemID].iQty > qItemQ)))
                                {
                                    item = invTree[qItemID];
                                    rootClass.ui.mcQTracker.updateQuest();
                                    rootClass.addUpdate(((((((quest.sName + ": ") + item.sName) + " ") + invTree[qItemID].iQty) + "/") + qItemQ));
                                };
                                i++;
                            };
                        };
                    };
                };
                if (((!(quest.status == null)) && (quest.status == "p")))
                {
                    if ((((typ == "item") && (!(quest.turnin == null))) && (quest.turnin.length > 0)))
                    {
                        cParams.sItems = true;
                        i = 0;
                        while (i < quest.turnin.length)
                        {
                            qItemID = quest.turnin[i].ItemID;
                            qItemQ = quest.turnin[i].iQty;
                            if ((((o.ItemID == qItemID) && (!(invTree[qItemID] == null))) && (invTree[qItemID].iQty <= qItemQ)))
                            {
                                item = invTree[qItemID];
                                rootClass.addUpdate(((((((quest.sName + ": ") + item.sName) + " ") + invTree[qItemID].iQty) + "/") + qItemQ));
                            };
                            i++;
                        };
                    };
                    checkAllQuestStatus(questID);
                    if (quest.status == "c")
                    {
                        rootClass.addUpdate((quest.sName + " complete!"));
                        rootClass.mixer.playSound("Good");
                    };
                };
            };
        }

        public function canTurnInQuest(questID:int):Boolean
        {
            var quest:*;
            var i:int;
            var qItemID:*;
            var qItemQ:*;
            quest = questTree[questID];
            if (((!(quest.turnin == null)) && (quest.turnin.length > 0)))
            {
                i = 0;
                while (i < quest.turnin.length)
                {
                    qItemID = quest.turnin[i].ItemID;
                    qItemQ = quest.turnin[i].iQty;
                    if (((invTree[qItemID] == null) || (invTree[qItemID].iQty < qItemQ)))
                    {
                        return (false);
                    };
                    if (myAvatar.isItemEquipped(qItemID))
                    {
                        rootClass.MsgBox.notify("Cannot turn in equipped item(s)!");
                        return (false);
                    };
                    i++;
                };
            };
            return (true);
        }

        public function abandonQuest(QuestID:int):void
        {
            questTree[QuestID].status = null;
            rootClass.ui.mcQTracker.updateQuest();
        }

        public function completeQuest(questID:int):void
        {
            if (questTree[questID] != null)
            {
                questTree[questID].status = null;
                rootClass.ui.mcQTracker.updateQuest();
            };
        }

        public function toggleQuestLog():void
        {
            var mcQFrame:*;
            mcQFrame = rootClass.getInstanceFromModalStack("QFrameMC");
            if (mcQFrame == null)
            {
                if (rootClass.litePreference.data.bQuestLog)
                {
                    showQuests(getActiveQuests(), "q");
                }
                else
                {
                    showQuests("", "l");
                };
            }
            else
            {
                mcQFrame.open();
            };
        }

        public function isPartyMember(unm:String):Boolean
        {
            var i:int;
            unm = unm.toLowerCase();
            if (unm != rootClass.sfc.myUserName)
            {
                i = 0;
                while (i < partyMembers.length)
                {
                    if (partyMembers[i].toLowerCase() == unm)
                    {
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }

        public function doPartyAccept(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "gp", ["pa", obj.pid], "str", 1);
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "gp", ["pd", obj.pid], "str", 1);
            };
        }

        public function doCTAAccept(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "gp", ["ctaa", obj.unm], "str", 1);
                showQuests(obj.QuestID, "q");
            };
        }

        public function doCTAClick(e:MouseEvent):void
        {
            var mc:MovieClip;
            var modal:ModalMC;
            var modalO:Object;
            mc = (e.currentTarget as MovieClip);
            modal = new ModalMC();
            modalO = {};
            modalO.strBody = (("Would you like to join the next avabilable party for " + mc.sName) + "?");
            modalO.callback = doCTAAccept;
            modalO.params = {
                    "QuestID": mc.QuestID,
                    "unm": mc.unm
                };
            modalO.btns = "dual";
            rootClass.ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function addPartyMember(unm:String):*
        {
            partyMembers.push(unm);
            updatePartyFrame();
        }

        public function removePartyMember(unm:String):*
        {
            var pi:*;
            if (unm != rootClass.sfc.myUserName)
            {
                pi = partyMembers.indexOf(unm);
                if (pi > -1)
                {
                    partyMembers.splice(pi, 1);
                };
            }
            else
            {
                partyID = -1;
                partyOwner = "";
                partyMembers = [];
            };
            updatePartyFrame();
        }

        public function updatePartyFrame(obj:Object = null):*
        {
            var panel:MovieClip;
            var pVal:int;
            var pMax:int;
            var pBar:MovieClip;
            var i:int;
            var dataLeaf:Object;
            var members:Array;
            var range:Boolean;
            var reposition:Boolean;
            var pm:String;
            var panels:*;
            var panelName:*;
            panel = null;
            pVal = 0;
            pMax = 0;
            pBar = null;
            i = 0;
            dataLeaf = null;
            members = [];
            range = true;
            reposition = false;
            if ((((!(obj == null)) && (!(obj.range == null))) && (obj.range == false)))
            {
                range = false;
            };
            if (obj != null)
            {
                members = [obj.unm];
            }
            else
            {
                reposition = true;
                members = partyMembers;
            };
            if (members.length > 0)
            {
                pm = "";
                if (obj == null)
                {
                    panels = [];
                    i = 0;
                    i = 0;
                    while (i < rootClass.ui.mcPartyFrame.numChildren)
                    {
                        panels.push(MovieClip(rootClass.ui.mcPartyFrame.getChildAt(i)));
                        i++;
                    };
                    i = 0;
                    i = 0;
                    while (i < panels.length)
                    {
                        panel = panels[i];
                        panelName = panel.strName.text;
                        if (partyMembers.indexOf(panelName) == -1)
                        {
                            panel.removeEventListener(MouseEvent.CLICK, onPartyPanelClick);
                            rootClass.ui.mcPartyFrame.removeChild(panel);
                        };
                        i++;
                    };
                };
                i = 0;
                while (i < members.length)
                {
                    pm = members[i];
                    panel = getPartyPanelByName(pm);
                    dataLeaf = uoTree[pm.toLowerCase()];
                    if (dataLeaf == null)
                    {
                        panel.HP.visible = false;
                        panel.MP.visible = false;
                        panel.txtRange.visible = true;
                    }
                    else
                    {
                        if (range)
                        {
                            pVal = dataLeaf.intHP;
                            pMax = dataLeaf.intHPMax;
                            pBar = panel.HP;
                            if (pVal >= 0)
                            {
                                pBar.strIntHP.text = (pBar.strIntHPs.text = String(dataLeaf.intHP));
                            }
                            else
                            {
                                pBar.strIntHP.text = (pBar.strIntHPs.text = "X");
                            };
                            if (pVal < 0)
                            {
                                pVal = 0;
                            };
                            pBar.intHPbar.x = -(pBar.intHPbar.width * (1 - (pVal / pMax)));
                            pVal = dataLeaf.intMP;
                            pMax = dataLeaf.intMPMax;
                            pBar = panel.MP;
                            if (pVal >= 0)
                            {
                                pBar.strIntMP.text = (pBar.strIntMPs.text = String(dataLeaf.intMP));
                            }
                            else
                            {
                                pBar.strIntMP.text = (pBar.strIntMPs.text = "X");
                            };
                            if (pVal < 0)
                            {
                                pVal = 0;
                            };
                            pBar.intMPbar.x = -(pBar.intMPbar.width * (1 - (pVal / pMax)));
                            panel.HP.visible = true;
                            panel.MP.visible = true;
                            panel.txtRange.visible = false;
                        }
                        else
                        {
                            panel.HP.visible = false;
                            panel.MP.visible = false;
                            panel.txtRange.visible = true;
                        };
                    };
                    if (reposition)
                    {
                        panel.y = int(((panel.height + 2) * i));
                    };
                    panel.partyLead.visible = (pm.toLowerCase() == partyOwner.toLowerCase());
                    i++;
                };
            }
            else
            {
                i = 0;
                while (((rootClass.ui.mcPartyFrame.numChildren > 0) && (i < 10)))
                {
                    panel = MovieClip(rootClass.ui.mcPartyFrame.getChildAt(0));
                    panel.removeEventListener(MouseEvent.CLICK, onPartyPanelClick);
                    rootClass.ui.mcPartyFrame.removeChildAt(0);
                    i++;
                };
            };
            rootClass.ui.mcPortrait.partyLead.visible = (partyOwner.toLowerCase() == rootClass.sfc.myUserName);
        }

        public function createPartyPanel(obj:Object):MovieClip
        {
            var panel:*;
            var panelsn:* = (rootClass.ui.mcPartyFrame.numChildren + 1);
            panel = MovieClip(rootClass.ui.mcPartyFrame.addChild(new PartyPanel()));
            panel.strName.text = obj.unm;
            panel.HP.visible = false;
            panel.MP.visible = false;
            panel.txtRange.visible = false;
            panel.addEventListener(MouseEvent.CLICK, onPartyPanelClick, false, 0, true);
            panel.buttonMode = true;
            return (panel);
        }

        public function getPartyPanelByName(unm:String):MovieClip
        {
            var panelsn:*;
            var panel:MovieClip;
            var i:int;
            panelsn = rootClass.ui.mcPartyFrame.numChildren;
            panel = null;
            i = 0;
            while (i < panelsn)
            {
                panel = MovieClip(rootClass.ui.mcPartyFrame.getChildAt(i));
                if (panel.strName.text == unm)
                {
                    return (panel);
                };
                i++;
            };
            return (createPartyPanel({"unm": unm}));
        }

        public function onPartyPanelClick(e:MouseEvent):void
        {
            var mc:*;
            var params:*;
            var tAvt:Avatar;
            mc = MovieClip(e.currentTarget);
            params = {};
            params.strUsername = mc.strName.text;
            if (e.shiftKey)
            {
                tAvt = getAvatarByUserName(params.strUsername.toLowerCase());
                if (((((!(tAvt == null)) && (!(tAvt.pMC == null))) && (!(tAvt.dataLeaf == null))) && (tAvt.dataLeaf.strFrame == myAvatar.dataLeaf.strFrame)))
                {
                    setTarget(tAvt);
                };
            }
            else
            {
                rootClass.ui.cMenu.fOpenWith("party", params);
            };
        }

        public function partyInvite(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "gp", ["pi", unm], "str", 1);
        }

        public function partyKick(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "gp", ["pk", unm], "str", 1);
        }

        public function partyLeave():void
        {
            rootClass.sfc.sendXtMessage("zm", "gp", ["pl"], "str", 1);
        }

        public function partySummon(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "gp", ["ps", unm], "str", 1);
        }

        public function acceptPartySummon(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "gp", ["psa"], "str", 1);
                if (obj.strF == null)
                {
                    rootClass.sfc.sendXtMessage("zm", "cmd", ["goto", obj.unm], "str", 1);
                }
                else
                {
                    moveToCell(obj.strF, obj.strP);
                };
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "gp", ["psd", obj.unm], "str", 1);
            };
        }

        public function partyUpdate(nam:String, val:String):void
        {
        }

        public function partyPromote(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "gp", ["pp", unm], "str", 1);
        }

        public function _SafeStr_1(unm:*):*
        {
            var cLeaf:*;
            var tLeaf:*;
            unm = unm.toLowerCase();
            cLeaf = uoTree[rootClass.sfc.myUserName];
            tLeaf = uoTree[String(unm).toLowerCase()];
            if (((cLeaf.intState == 1) && ((cLeaf.pvpTeam == null) || (cLeaf.pvpTeam == -1))))
            {
                if (((!(tLeaf == null)) && (!(cLeaf.uoName == tLeaf.uoName))))
                {
                    if ((("nogoto" in map) && (map.nogoto)))
                    {
                        rootClass.chatF.pushMsg("warning", "/goto can't target players within this map.", "SERVER", "", 0);
                        return;
                    };
                    if (cLeaf.strFrame != tLeaf.strFrame)
                    {
                        moveToCell(tLeaf.strFrame, tLeaf.strPad);
                    };
                }
                else
                {
                    rootClass.sfc.sendXtMessage("zm", "cmd", ["goto", unm], "str", 1);
                };
            };
        }

        public function pull(unm:*):*
        {
            unm = unm.toLowerCase();
            rootClass.sfc.sendXtMessage("zm", "cmd", ["pull", unm], "str", 1);
        }

        public function requestFriend(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "requestFriend", [unm], "str", 1);
        }

        public function addFriend(params:Object):void
        {
            if (params.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "addFriend", [params.unm], "str", 1);
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "declineFriend", [params.unm], "str", 1);
            };
        }

        public function deleteFriend(ID:int, unm:*):void
        {
            rootClass.sfc.sendXtMessage("zm", "deleteFriend", [ID, unm], "str", 1);
        }

        public function guildInvite(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "guild", ["gi", unm], "str", 1);
        }

        public function guildRemove(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "guild", ["gr", obj.userName], "str", 1);
            };
        }

        public function guildPromote(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "guild", ["gp", unm], "str", 1);
        }

        public function guildDemote(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "guild", ["gd", unm], "str", 1);
        }

        public function doGuildAccept(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "guild", ["ga", obj.guildID, obj.owner], "str", 1);
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "guild", ["gdi", obj.guildID, obj.owner], "str", 1);
            };
        }

        public function setGuildMOTD(msg:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "guild", ["motd", msg], "str", 1);
        }

        public function createGuild(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "guild", ["gc", obj.guildName], "str", 1);
            };
        }

        public function addMemSlots(ammount:int):void
        {
            rootClass.sfc.sendXtMessage("zm", "guild", ["slots", ammount], "str", 1);
        }

        public function renameGuild(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "guild", ["rename", obj.guildName], "str", 1);
            };
        }

        public function requestPVPQueue(warzone:String, factionID:int = -1):void
        {
            rootClass.sfc.sendXtMessage("zm", "PVPQr", [warzone, factionID], "str", rootClass.world.curRoom);
        }

        public function handlePVPQueue(o:Object):void
        {
            var mc:MovieClip;
            if (o.bitSuccess == 1)
            {
                PVPQueue.warzone = o.warzone;
                PVPQueue.ts = new Date().getTime();
                PVPQueue.avgWait = o.avgWait;
                rootClass.showMCPVPQueue();
            }
            else
            {
                PVPQueue.warzone = "";
                PVPQueue.ts = -1;
                PVPQueue.avgWait = -1;
                rootClass.hideMCPVPQueue();
            };
            mc = rootClass.ui.mcPopup;
            if (((mc.currentLabel == "PVPPanel") && (!(mc.mcPVPPanel == null))))
            {
                mc.mcPVPPanel.updateBody();
            };
            rootClass.closeModalByStrBody("A new Warzone battle has started!");
        }

        public function updatePVPAvgWait(i:int):void
        {
            PVPQueue.avgWait = i;
        }

        public function duelExpire():*
        {
            rootClass.closeModalByStrBody("has challenged you to a duel.");
        }

        public function receivePVPInvite(o:Object):*
        {
            var modal:*;
            var modalO:*;
            var w:*;
            modal = new ModalMC();
            modalO = {};
            w = getWarzoneByWarzoneName(o.warzone);
            modalO.strBody = (("A new Warzone battle has started!  Will you join " + w.nam) + "?");
            modalO.greedy = true;
            modalO.params = {};
            modalO.callback = replyToPVPInvite;
            rootClass.ui.ModalStack.addChild(modal);
            rootClass.ui.mcPopup.onClose();
            rootClass.hideMCPVPQueue();
            modal.init(modalO);
        }

        public function replyToPVPInvite(o:Object):void
        {
            if (o.accept)
            {
                sendPVPInviteAccept();
            }
            else
            {
                sendPVPInviteDecline();
            };
        }

        public function sendPVPInviteAccept():void
        {
            rootClass.sfc.sendXtMessage("zm", "PVPIr", ["1"], "str", rootClass.world.curRoom);
        }

        public function sendPVPInviteDecline():void
        {
            rootClass.sfc.sendXtMessage("zm", "PVPIr", ["0"], "str", rootClass.world.curRoom);
        }

        public function sendDuelInvite(unm:String):void
        {
            rootClass.sfc.sendXtMessage("zm", "duel", [unm], "str", 1);
        }

        public function doDuelAccept(obj:Object):void
        {
            if (obj.accept)
            {
                rootClass.sfc.sendXtMessage("zm", "da", [obj.unm], "str", 1);
            }
            else
            {
                rootClass.sfc.sendXtMessage("zm", "dd", [obj.unm], "str", 1);
            };
        }

        public function getWarzoneByName(nam:String):*
        {
            var i:int;
            i = 0;
            while (i < PVPMaps.length)
            {
                if (PVPMaps[i].nam == nam)
                {
                    return (PVPMaps[i]);
                };
                i++;
            };
            return (null);
        }

        public function getWarzoneByWarzoneName(s:String):*
        {
            var i:int;
            i = 0;
            while (i < PVPMaps.length)
            {
                if (PVPMaps[i].warzone == s)
                {
                    return (PVPMaps[i]);
                };
                i++;
            };
            return (null);
        }

        public function setPVPFactionData(a:Array):void
        {
            if (a != null)
            {
                PVPFactions = a;
            }
            else
            {
                PVPFactions = [];
            };
        }

        public function attachMovieFront(strLinkage:*):MovieClip
        {
            var mc:MovieClip;
            var AssetClass:Class;
            var addOK:*;
            var tempClass:*;
            AssetClass = (getClass(strLinkage) as Class);
            addOK = true;
            if (FG.numChildren)
            {
                mc = MovieClip(FG.getChildAt(0));
                tempClass = (mc.constructor as Class);
                if (tempClass == AssetClass)
                {
                    addOK = false;
                };
            };
            if (addOK)
            {
                removeMovieFront();
                mc = MovieClip(FG.addChild(new (AssetClass)()));
                FG.mouseChildren = true;
            };
            return (mc);
        }

        public function attachMovieFrontMenu(strLinkage:*):MovieClip
        {
            var mc:MovieClip;
            var AssetClass:Class;
            var addOK:*;
            var tempClass:*;
            AssetClass = (getClass(strLinkage) as Class);
            addOK = true;
            if (FG.numChildren)
            {
                mc = MovieClip(FG.getChildAt(0));
                tempClass = (mc.constructor as Class);
                if (tempClass == AssetClass)
                {
                    addOK = false;
                };
            };
            if (addOK)
            {
                removeMovieFront();
                mc = MovieClip(FG.addChild(new (AssetClass)()));
                FG.mouseChildren = true;
            };
            return (mc);
        }

        public function removeMovieFront():*
        {
            var i:int;
            i = 0;
            while (((FG.numChildren > 0) && (i < 100)))
            {
                i++;
                FG.removeChildAt(0);
            };
            rootClass.ldrMC.closeHistory();
            rootClass.stage.focus = null;
        }

        public function getMovieFront():*
        {
            if (((FG.numChildren > 0) && (!(FG.getChildAt(0) == null))))
            {
                return (FG.getChildAt(0));
            };
            return (null);
        }

        public function isMovieFront(strLinkage:String):Boolean
        {
            var mc:MovieClip;
            var AssetClass:Class;
            var isMF:*;
            var tempClass:*;
            AssetClass = (this.getClass(strLinkage) as Class);
            isMF = false;
            if (FG.numChildren)
            {
                mc = MovieClip(FG.getChildAt(0));
                tempClass = (mc.constructor as Class);
                if (tempClass == AssetClass)
                {
                    isMF = true;
                };
            };
            return (isMF);
        }

        public function loadMovieFront(strFile:String, strType:String = "Game Files"):void
        {
            removeMovieFront();
            rootClass.ldrMC.loadFile(FG, strFile, strType);
        }

        public function replyToTradeInvite(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.sendTradeInviteAccept();
            }
            else
            {
                this.sendTradeInviteDecline();
            };
        }

        public function sendTradeInviteAccept():void
        {
            this.rootClass.sfc.sendXtMessage("zm", "ti", ["1"], "str", this.rootClass.world.curRoom);
        }

        public function sendTradeInviteDecline():void
        {
            this.rootClass.sfc.sendXtMessage("zm", "ti", ["0"], "str", this.rootClass.world.curRoom);
        }

        public function sendTradeInvite(_arg1:String):void
        {
            this.rootClass.sfc.sendXtMessage("zm", "ti", [_arg1], "str", 1);
        }

        public function doTradeAccept(_arg1:Object):void
        {
            if (_arg1.accept)
            {
                this.rootClass.sfc.sendXtMessage("zm", "tia", [_arg1.unm], "str", 1);
            }
            else
            {
                this.rootClass.sfc.sendXtMessage("zm", "tid", [_arg1.unm], "str", 1);
            };
        }

        public function sendLoadOfferRequest(_arg1:Array = null):void
        {
            var _local2:String;
            if (_arg1[0] == "*")
            {
                _arg1 = ["All"];
            };
            for each (_local2 in _arg1)
            {
                this.tradeinfo.hasRequested[_local2] = true;
            };
            this.rootClass.sfc.sendXtMessage("zm", "loadOffer", _arg1, "str", this.curRoom);
        }

        public function sendTradeFromInvRequest(_arg1:Object)
        {
            var _local2:ModalMC;
            var _local3:Object;
            if (_arg1.bEquip == 1)
            {
                _local2 = new ModalMC();
                _local3 = {};
                _local3.strBody = "You must unequip the item before offering it!";
                _local3.params = {};
                _local3.glow = "red,medium";
                _local3.btns = "mono";
                this.rootClass.ui.ModalStack.addChild(_local2);
                _local2.init(_local3);
            }
            else
            {
                this.rootClass.sfc.sendXtMessage("zm", "tradeFromInv", [_arg1.ItemID, _arg1.CharItemID, _arg1.TradeID, _arg1.Quantity], "str", this.curRoom);
            };
        }

        public function sendTradeToInvRequest(_arg1:Object)
        {
            var _local2:*;
            var _local3:*;
            this.rootClass.sfc.sendXtMessage("zm", "tradeToInv", [_arg1.ItemID, _arg1.CharItemID, _arg1.TradeID], "str", this.curRoom);
        }

        public function sendTradeSwapInvRequest(_arg1:Object, _arg2:Object)
        {
            var _local3:ModalMC;
            var _local4:Object;
            if (_arg2.bEquip == 1)
            {
                _local3 = new ModalMC();
                _local4 = {};
                _local4.strBody = "You must unequip the item before offering it!";
                _local4.params = {};
                _local4.glow = "red,medium";
                _local4.btns = "mono";
                this.rootClass.ui.ModalStack.addChild(_local3);
                _local3.init(_local4);
            }
            else
            {
                this.rootClass.sfc.sendXtMessage("zm", "tradeSwapInv", [_arg2.ItemID, _arg2.CharItemID, _arg1.ItemID, _arg1.CharItemID, _arg1.TradeID], "str", this.curRoom);
            };
        }

        public function showPreL():*
        {
            if (((preLMC == null) || (!(MovieClip(this).contains(preLMC)))))
            {
                preLMC = new PreL();
                addChild(preLMC);
                preLMC.x = ((960 / 2) - (preLMC.width / 2));
                preLMC.y = ((550 / 2) - (preLMC.height / 2));
            };
        }

        public function toggleFPS():void
        {
            rootClass.ui.mcFPS.visible = (!(rootClass.ui.mcFPS.visible));
        }

        private function calculateFPS():void
        {
            var now:Number;
            var delta_t:int;
            var temp:int;
            var avg_fps:*;
            var fpsArraySum:Number;
            var i:int;
            var fpsArrayAvg:Number;
            var iCurQuality:int;
            try
            {
                if (fpsTS != 0)
                {
                    now = new Date().getTime();
                    delta_t = (now - fpsTS);
                    temp = 0;
                    if (ticklist.length == TICK_MAX)
                    {
                        temp = ticklist.shift();
                    };
                    ticklist.push(delta_t);
                    ticksum = ((ticksum + delta_t) - temp);
                    avg_fps = (1000 / (ticksum / ticklist.length));
                    if (rootClass.ui.mcFPS.visible)
                    {
                        rootClass.ui.mcFPS.txtFPS.text = avg_fps.toPrecision(4);
                    };
                    if ((((rootClass.userPreference.data.quality == "AUTO") && (ticklist.length == TICK_MAX)) && ((++fpsQualityCounter % 24) == 0)))
                    {
                        fpsArrayQuality.push(avg_fps);
                        if (fpsArrayQuality.length == 5)
                        {
                            fpsArraySum = 0;
                            i = 0;
                            while (i < fpsArrayQuality.length)
                            {
                                fpsArraySum = (fpsArraySum + fpsArrayQuality[i]);
                                i++;
                            };
                            fpsArrayAvg = (fpsArraySum / fpsArrayQuality.length);
                            iCurQuality = arrQuality.indexOf(rootClass.stage.quality);
                            if (((fpsArrayAvg < 12) && (iCurQuality > 0)))
                            {
                                rootClass.stage.quality = arrQuality[(iCurQuality - 1)];
                            };
                            if (((fpsArrayAvg >= 12) && (iCurQuality < 2)))
                            {
                                rootClass.stage.quality = arrQuality[(iCurQuality + 1)];
                            };
                            fpsArrayQuality = new Array();
                        };
                    };
                };
                fpsTS = new Date().getTime();
            }
            catch (e)
            {
            };
        }

        public function onZmanagerEnterFrame(evt:Event):*
        {
            var zMC:MovieClip;
            var i:int;
            var j:int;
            var mcIndex:int;
            var now:Number;
            calculateFPS();
            zSortArr = [];
            i = 0;
            while (i < CHARS.numChildren)
            {
                zMC = MovieClip(CHARS.getChildAt(i));
                zSortArr.push({
                            "mc": zMC,
                            "oy": zMC.y
                        });
                i++;
            };
            zSortArr.sortOn("oy", Array.NUMERIC);
            j = 0;
            while (j < zSortArr.length)
            {
                zMC = zSortArr[j].mc;
                mcIndex = CHARS.getChildIndex(zMC);
                if (mcIndex != j)
                {
                    CHARS.swapChildrenAt(mcIndex, j);
                };
                j++;
            };
            if (EFAO.xpc++ > EFAO.xpn)
            {
                EFAO.xpc = 0;
                try
                {
                    if (rootClass.stage == null)
                    {
                        killTimers();
                        killListeners();
                        return;
                    };
                    now = new Date().getTime();
                    if (((!(rootClass.stage == null)) && (!(myAvatar.objData.iBoostXP == null))))
                    {
                        if ((rootClass.ui.mcPortrait.iconBoostXP.boostTS + (rootClass.ui.mcPortrait.iconBoostXP.iBoostXP * 1000)) < (now + 1000))
                        {
                            rootClass.sfc.sendXtMessage("zm", "serverUseItem", ["-", "xpboost"], "str", -1);
                        };
                    };
                    if (((!(rootClass.stage == null)) && (!(myAvatar.objData.iBoostG == null))))
                    {
                        if ((rootClass.ui.mcPortrait.iconBoostG.boostTS + (rootClass.ui.mcPortrait.iconBoostG.iBoostG * 1000)) < (now + 1000))
                        {
                            rootClass.sfc.sendXtMessage("zm", "serverUseItem", ["-", "gboost"], "str", -1);
                        };
                    };
                    if (((!(rootClass.stage == null)) && (!(myAvatar.objData.iBoostRep == null))))
                    {
                        if ((rootClass.ui.mcPortrait.iconBoostRep.boostTS + (rootClass.ui.mcPortrait.iconBoostRep.iBoostRep * 1000)) < (now + 1000))
                        {
                            rootClass.sfc.sendXtMessage("zm", "serverUseItem", ["-", "repboost"], "str", -1);
                        };
                    };
                    if (((!(rootClass.stage == null)) && (!(myAvatar.objData.iBoostCP == null))))
                    {
                        if ((rootClass.ui.mcPortrait.iconBoostCP.boostTS + (rootClass.ui.mcPortrait.iconBoostCP.iBoostCP * 1000)) < (now + 1000))
                        {
                            rootClass.sfc.sendXtMessage("zm", "serverUseItem", ["-", "cpboost"], "str", -1);
                        };
                    };
                }
                catch (e:Error)
                {
                };
            };
        }

        public function iaTrigger(obj:MovieClip):*
        {
            var xtArr:*;
            var i:int;
            if (coolDown("doIA"))
            {
                xtArr = [];
                xtArr.push(obj.iaType);
                xtArr.push(obj.name);
                if (("iaPathMC" in obj))
                {
                    xtArr.push(myAvatar.dataLeaf.strFrame);
                }
                else
                {
                    xtArr.push(obj.iaFrame);
                };
                if (("iaStr" in obj))
                {
                    xtArr.push(obj.iaStr);
                };
                if (("iaPathMC" in obj))
                {
                    xtArr.push(obj.iaPathMC);
                };
                trace(((("xtArr: " + xtArr) + " str: ") + obj.isStr));
                i = 0;
                while (i < xtArr.length)
                {
                    trace(((i + " isNull: ") + (xtArr[i] == null)));
                    i++;
                };
                rootClass.sfc.sendXtMessage("zm", "ia", xtArr, "str", 1);
            };
        }

        public function actCastRequest(o:Object):void
        {
            var xtArr:Array;
            var params:Array;
            var co:Object;
            xtArr = ["castr"];
            params = [];
            switch (o.typ)
            {
                case "sia":
                    if (coolDown("doIA"))
                    {
                        co = {};
                        co.typ = "sia";
                        co.callback = actCastTrigger;
                        co.args = o;
                        co.dur = Number(o.sAccessCD);
                        co.txt = o.sMsg;
                        rootClass.ui.mcCastBar.fOpenWith(co);
                        params.push(1);
                        params.push(o.ID);
                    };
                    break;
            };
            if (params.length > 0)
            {
                rootClass.sfc.sendXtMessage("zm", xtArr, params, "str", 1);
            };
        }

        public function actCastTrigger(o:Object):void
        {
            switch (o.typ)
            {
                case "sia":
                    siaTrigger(o);
                    break;
            };
        }

        public function siaTrigger(o:Object):void
        {
            rootClass.sfc.sendXtMessage("zm", ["castt"], [], "str", 1);
        }

        public function uoTreeLeaf(uoName:*):Object
        {
            if (uoTree[uoName.toLowerCase()] == null)
            {
                uoTree[uoName.toLowerCase()] = {};
            };
            return (uoTree[uoName.toLowerCase()]);
        }

        public function myLeaf():Object
        {
            return (uoTreeLeaf(rootClass.sfc.myUserName));
        }

        public function uoTreeLeafSet(uoName:*, uoLeafSet:Object):*
        {
            var uoLeaf:*;
            var prop:*;
            var avt:*;
            if (uoTree[uoName.toLowerCase()] == null)
            {
                uoTree[uoName.toLowerCase()] = {};
            };
            uoLeaf = uoTree[uoName.toLowerCase()];
            var xtArr:* = [];
            for (prop in uoLeafSet)
            {
                uoLeaf[prop] = uoLeafSet[prop];
                avt = getAvatarByUserName(uoName);
                if (((!(avt == null)) && (!(avt.objData == null))))
                {
                    avt.objData[prop] = uoLeafSet[prop];
                };
            };
        }

        public function manageAreaUser(unm:String, op:String):void
        {
            var i:int;
            unm = unm.toLowerCase();
            if (op == "+")
            {
                if (areaUsers.indexOf(unm) == -1)
                {
                    areaUsers.push(unm);
                };
            }
            else
            {
                i = areaUsers.indexOf(unm);
                if (i > -1)
                {
                    areaUsers.splice(i, 1);
                };
            };
            // rootClass.discord.update("onRetrieve");
            rootClass.updateAreaName();
        }

        public function updateAreaUserCount():void
        {
        }

        public function setAllCloakVisibility():void
        {
            var avatarsInCell:Array;
            var avtr:Avatar;
            avatarsInCell = getUsersByCell(myAvatar.dataLeaf.strFrame);
            for each (avtr in avatarsInCell)
            {
                avtr.pMC.setCloakVisibility(avtr.dataLeaf.showCloak);
            };
        }

        public function coolDown(eventStr:String):Boolean
        {
            var event:*;
            var dat:*;
            var ct:*;
            var delta:*;
            event = lock[eventStr];
            dat = new Date();
            ct = dat.getTime();
            delta = (ct - event.ts);
            if (delta < event.cd)
            {
                rootClass.chatF.pushMsg("warning", "Action taken too quickly, try again in a moment.", "SERVER", "", 0);
                return (false);
            };
            event.ts = ct;
            return (true);
        }

        public function copyAvatarMC(mcChar:MovieClip):void
        {
            var copier:AvatarMCCopier;
            copier = new AvatarMCCopier(this);
            copier.copyTo(mcChar);
        }

        public function doLoadPet(avt:Avatar):Boolean
        {
            if (((!(rootClass.uoPref.bPet)) && (avt == myAvatar)))
            {
                return (false);
            };
            if (((!(avt == myAvatar)) && (hideOtherPets)))
            {
                return (false);
            };
            return (true);
        }

        public function get Scale():Number
        {
            return (SCALE);
        }

        public function get bankinfo():BankController
        {
            return (bankController);
        }

    }
} // package

// _SafeStr_1 = "goto" (String#7375)