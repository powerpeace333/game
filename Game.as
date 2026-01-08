// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

// Game

package
{
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.system.ApplicationDomain;
    import it.gotoandplay.smartfoxserver.SmartFoxClient;
    import flash.net.SharedObject;
    import flash.utils.Timer;
    import flash.utils.Dictionary;
    import liteAssets.draw.bankFilters;
    import liteAssets.draw.cellMenu;
    import liteAssets.draw.customDrops;
    import liteAssets.draw.playerAuras;
    import liteAssets.draw.targetAuras;
    import liteAssets.draw.battleAnalyzer;
    import liteAssets.draw.cameraTool;
    import flash.system.LoaderContext;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import it.gotoandplay.smartfoxserver.SFSEvent;
    import flash.media.SoundMixer;
    import fl.motion.Color;
    import flash.utils.getTimer;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.utils.getDefinitionByName;
    import flash.system.Security;
    import flash.display.Sprite;
    import flash.external.ExternalInterface;
    import flash.filters.ColorMatrixFilter;
    import flash.net.URLRequest;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.geom.Point;
    import flash.ui.Keyboard;
    import flash.events.KeyboardEvent;
    import liteAssets.draw.worldCamera;
    import liteAssets.handlers.optionHandler;
    import flash.events.TimerEvent;
    import flash.utils.describeType;
    import flash.utils.ByteArray;
    import flash.filters.GlowFilter;
    import flash.net.URLRequestMethod;
    import com.adobe.serialization.json.JSON;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    import flash.display.StageDisplayState;
    import flash.events.FocusEvent;
    import flash.net.navigateToURL;
    import flash.net.URLVariables;
    import flash.net.URLRequestHeader;
    import flash.media.SoundTransform;
    import flash.geom.Matrix;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.utils.getQualifiedClassName;
    import liteAssets.draw.statsPanel;
    import flash.text.*;
    import it.gotoandplay.smartfoxserver.*;
    import liteAssets.draw.*;
    import flash.external.*;
    import flash.events.*;
    import flash.net.*;
    import flash.events.*;
    import flash.net.*;

    public class Game extends MovieClip
    {

        public static var ISWEB:Boolean = true;
        public static var ISMOBILE:Boolean = false;
        public static var root:DisplayObject;
        public static var serverName:String;
        public static var serverPort:int = 5588;
        public static var serverIP:String = "";
        public static var serverGamePath:String = "";
        public static var serverFilePath:String = "";
        public static var serverURL:String = "";
        public static var staticURL:String = "https://127.0.0.1/";
        public static var cLoginZone:String = "zone_master";
        public static var clientToken:String = "SPIDER#0001";
        public static var bPTR:Boolean = false;
        public static var loginInfo:Object = new Object();
        public static var objLogin:Object;
        public static var mcUpgradeWindow:MovieClip;
        public static var mcACWindow:MovieClip;
        public static var strToken:String;
        public static const ASSETS_LOADED:String = "main_assets_loaded";
        public static var ASSETS_READY:String = "";
        public static const FB_APP_NAME:String = "AQW";
        public static const FB_APP_URL:String = "www.aq.com";
        public static const FB_APP_ID:String = "51356733862";
        public static const FB_APP_SEC:String = "This should never be stored in the client";

        public var MsgBox:MovieClip;
        public var mcAccount:MovieClip;
        public var mcExtSWF:MovieClip;
        public var ui:MovieClip;
        public var mcLogin:MovieClip;
        public var loader:*;
        public var csLoader:URLLoader;
        public var csbLoaded:Number;
        public var csbTotal:Number;
        public var clientVersion:Number = 3.003;
        public var sToken:String;
        public var world:World;
        public var bagSpace:String = "interface/spiderbag.swf";
        public var iSlotCost:* = 200;
        public var iMaxBagSlots:* = 1000;
        public var iMaxBankSlots:* = 250;
        public var iMaxHouseSlots:* = 155;
        private var swfObj:String = "AQWGame";
        public var showFB:Boolean = false;
        public var fbL:fbLinkWindow;
        public var titleDomain:ApplicationDomain;
        public var mcO:MovieClip;
        public var elmType:String;
        public var handleSessionEvent:Function;
        public var sfc:SmartFoxClient;
        public var chatF:*;
        public var sFilePath:String = "";
        public var userPreference:SharedObject;
        public var litePreference:SharedObject;
        public var objServerInfo:Object;
        public var sfcSocial:Boolean = false;
        public var ldrMC:LoaderMC;
        public var mcConnDetail:ConnDetailMC;
        public var querystring:Object;
        public var ts_login_server:Number;
        public var ts_login_client:Number;
        public var aaaloop:int = 0;
        public var totalPingTime:Number = 0;
        public var pingCount:int = 0;
        public var arrRanks:Array;
        public var iRankMax:int = 10;
        public var arrHP:Array;
        private var aswc:Apop;
        public var hasPreviewed:Boolean;
        public var intLevelCap:int;
        public var PCstBase:int;
        public var PCstRatio:Number;
        public var PCstGoal:int;
        public var GstBase:int;
        public var GstRatio:Number;
        public var GstGoal:int;
        public var PChpBase1:int;
        public var PChpBase100:int;
        public var PChpGoal1:int;
        public var PChpGoal100:int;
        public var PChpDelta:int;
        public var intHPperEND:int;
        public var intAPtoDPS:int;
        public var intSPtoDPS:int;
        public var bigNumberBase:int;
        public var resistRating:Number;
        public var modRating:Number;
        public var baseDodge:Number;
        public var baseBlock:Number;
        public var baseParry:Number;
        public var baseCrit:Number;
        public var baseHit:Number;
        public var baseHaste:Number;
        public var baseMiss:Number;
        public var baseResist:Number;
        public var baseCritValue:Number;
        public var baseBlockValue:Number;
        public var baseResistValue:Number;
        public var baseEventValue:Number;
        public var PCDPSMod:Number = 0.85;
        public var curveExponent:Number = 0.66;
        public var statsExponent:Number = 1.33;
        public var stats:Array;
        public var orderedStats:Array;
        public var ratiosBySlot:Object;
        public var I0pct:Number = 0.8;
        public var I2pct:Number = 1.25;
        public var classCatMap:Object;
        private var coreValues:Object;
        private var travelMapData:Object;
        private var WorldMapData:worldMap;
        private var skipR2:Boolean = false;
        private var apop_:apopCore;
        public var apopTree:Object;
        public var curID:String;
        public var serialCmdMode:Boolean = false;
        public var serialCmd:Object;
        private var conn:*;
        public var confirmTime:int = 0;
        public var quests:Boolean = false;
        public var bits:Array;
        private var fbc:MovieClip;
        public var mcGameMenu:MovieClip;
        public var firstMenu:Boolean = true;
        public var bPassword:Boolean = true;
        internal var cancelTargetTimer:Timer;
        public var keyDict:Dictionary;
        private var travelLoaderMC:*;
        public var TRAVEL_DATA_READY:Boolean = false;
        private var bLoaded:Number = 0;
        private var bTotal:Number = 0;
        private var weakPass:Array;
        public var extCall:ExternalCalls;
        public var FBConnectCallback:Function;
        public var sBG:String = "generic2.swf";
        public var IsEU:Boolean = false;
        public var TempLoginName:* = "";
        public var TempLoginPass:* = "";
        public var intChatMode:int;
        public var serverPath:String;
        private var characters:SharedObject;
        public var csShowServers:Boolean = false;
        public var mcCharSelect:*;
        internal var visualLoader:*;
        internal var interfaceLoaded:Number = 0;
        internal var interfaceTotal:Number = 0;
        public var newInstance:Boolean = false;
        public var BOOK_DATA_READY:* = null;
        public var bolLoader:Loader;
        public var bolContent:MovieClip;
        public var bankFiltersMC:bankFilters;
        public var cMenuUI:cellMenu;
        public var cDropsUI:customDrops;
        public var pAurasUI:playerAuras;
        public var tAurasUI:targetAuras;
        public var bAnalyzer:battleAnalyzer;
        public var cameraToolMC:cameraTool;
        internal var petDisable:Timer;
        public var portraitsCnt:Array;
        public var pinnedQuests:String;
        internal var disableTimer:Timer;
        public var regExLineSpace:RegExp;
        public var showServers:Boolean = false;
        public var baseClassStats:Object;
        private var statsNewClass:Boolean = false;
        private var mcStatsPanel:MovieClip;

        public var cVersion:String = String(clientVersion);
        public var failedServers:* = {};
        private var rn:RandomNumber = new RandomNumber();
        public var assetsDomain:ApplicationDomain = new ApplicationDomain();
        public var assetsContext:LoaderContext = new LoaderContext(false, assetsDomain);
        public const EMAIL_REGEX:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
        public var mixer:SoundFX = new SoundFX(assetsDomain);
        public var params:Object = {};
        public var uoPref:Object = {};
        public var litePref:Array = [];
        public var loginLoader:URLLoader = new URLLoader();

        public var loaderDomain = null;
        public var ctrlTrade:MovieClip;
        public var tradeItem1:MovieClip;
        public var tradeItem2:MovieClip;
        public var tradeItem3:MovieClip;
        public var auctionItem1:MovieClip;
        public var auctionItem2:MovieClip;
        public var auctionItem3:MovieClip;
        public var auctionLayout:MovieClip;
        public var auctionPanel:MovieClip;
        public var auctionTabs:MovieClip;
        // public var mcWorldBoss:MovieClip;
        // public var discord:Discord;
        public var mcWorldBoss:MovieClip;

        {
            MovieClip.prototype.removeAllChildren = function():void
            {
                var i:* = (this.numChildren - 1);
                while (i >= 0)
                {
                    this.removeChildAt(i);
                    i--;
                };
            };
        }

        public function Game()
        {
            var isNewClass:Boolean;
            var onExtensionResponseHandler:Function;
            ldrMC = new LoaderMC(MovieClip(this));
            // discord = new Discord(MovieClip(this));
            assetsDomain = new ApplicationDomain();
            assetsContext = new LoaderContext(false, assetsDomain);
            assetsContext.checkPolicyFile = false;
            assetsContext.allowCodeImport = true;
            mixer = new SoundFX(assetsDomain);
            querystring = {};
            arrRanks = [0];
            arrHP = [];
            stats = ["STR", "END", "DEX", "INT", "WIS", "LCK"];
            orderedStats = ["STR", "INT", "DEX", "WIS", "END", "LCK"];
            ratiosBySlot = {
                    "he": 0.25,
                    "ar": 0.25,
                    "ba": 0.2,
                    "Weapon": 0.33
                };
            classCatMap = {
                    "M1": {},
                    "M2": {},
                    "M3": {},
                    "M4": {},
                    "C1": {},
                    "C2": {},
                    "C3": {},
                    "S1": {}
                };
            coreValues = {
                    "PCstRatio": 7.47,
                    "PChpDelta": 1640,
                    "PChpBase1": 360,
                    "baseHit": 0,
                    "intSPtoDPS": 10,
                    "resistRating": 17,
                    "curveExponent": 0.66,
                    "baseCritValue": 1.5,
                    "PChpGoal100": 4000,
                    "intLevelCap": 100,
                    "baseMiss": 0.1,
                    "baseParry": 0.03,
                    "GstBase": 12,
                    "modRating": 3,
                    "baseResistValue": 0.7,
                    "baseBlockValue": 0.7,
                    "intHPperEND": 5,
                    "baseHaste": 0,
                    "baseBlock": 0,
                    "statsExponent": 1,
                    "PChpBase100": 2000,
                    "intAPtoDPS": 10,
                    "PCstBase": 15,
                    "baseCrit": 0.05,
                    "baseEventValue": 0.05,
                    "GstGoal": 572,
                    "PChpGoal1": 400,
                    "GstRatio": 5.6,
                    "intLevelMax": 100,
                    "bigNumberBase": 8,
                    "PCstGoal": 762,
                    "baseDodge": 0.04,
                    "PCDPSMod": 0.85
                };
            apopTree = new Object();
            serialCmd = {
                    "cmd": "",
                    "si": 0,
                    "servers": [],
                    "callBack": serialCmdDone,
                    "active": false
                };
            bits = [1, 2, 4, 8, 16, 32, 64, 128, 0x0100, 0x0200, 0x0400, 0x0800, 0x1000, 0x2000, 0x4000, 0x8000, 0x10000, 0x20000, 0x40000, 0x80000, 0x100000, 0x200000, 0x400000, 0x800000, 0x1000000, 0x2000000, 0x4000000, 0x8000000, 0x10000000, 0x20000000, 0x40000000, 0x80000000];
            cancelTargetTimer = new Timer(5000, 1);
            weakPass = new Array("0", "1111", "11111", "111111", "11111111", "112233", "1212", "121212", "123123", "1234", "12345", "123456", "1234567", "12345678", "1313", "131313", "2000", "2112", "2222", "232323", "3333", "4128", "4321", "4444", "5150", "5555", "654321", "6666", "666666", "6969", "696969", "7777", "777777", "7777777", "8675309", "987654", "aaaa", "aaaaaa", "abc123", "abgrtyu", "access", "access14", "action", "albert", "alex", "alexis", "amanda", "amateur", "andrea", "andrew", "angel", "angela", "angels", "animal", "anthony", "apollo", "apple", "apples", "arsenal", "arthur", "asdf", "asdfgh", "ashley", "asshole", "august", "austin", "baby", "badboy", "bailey", "banana", "barney", "baseball", "batman", "beach", "bear", "beaver", "beavis", "beer", "bigcock", "bigdaddy", "bigdick", "bigdog", "bigtits", "bill", "billy", "birdie", "bitch", "bitches", "biteme", "black", "blazer", "blonde", "blondes", "blowjob", "blowme", "blue", "bond007", "bonnie", "booboo", "boobs", "booger", "boomer", "booty", "boston", "brandon", "brandy", "braves", "brazil", "brian", "bronco", "broncos", "bubba", "buddy", "bulldog", "buster", "butter", "butthead", "calvin", "camaro", "cameron", "canada", "captain", "carlos", "carter", "casper", "charles", "charlie", "cheese", "chelsea", "chester", "chevy", "chicago", "chicken", "chris", "cocacola", "cock", "coffee", "college", "compaq", "computer", "cookie", "cool", "cooper", "corvette", "cowboy", "cowboys", "cream", "crystal", "cumming", "cumshot", "cunt", "dakota", "dallas", "daniel", "danielle", "dave", "david", "debbie", "dennis", "diablo", "diamond", "dick", "dirty", "doctor", "doggie", "dolphin", "dolphins", "donald", "dragon", "dreams", "driver", "eagle", "eagle1", "eagles", "edward", "einstein", "enjoy", "enter", "eric", "erotic", "extreme", "falcon", "fender", "ferrari", "fire", "firebird", "fish", "fishing", "florida", "flower", "flyers", "football", "ford", "forever", "frank", "fred", "freddy", "freedom", "fuck", "fucked", "fucker", "fucking", "fuckme", "fuckyou", "gandalf", "gateway", "gators", "gemini", "george", "giants", "ginger", "girl", "girls", "golden", "golf", "golfer", "gordon", "great", "green", "gregory", "guitar", "gunner", "hammer", "hannah", "happy", "hardcore", "harley", "heather", "hello", "helpme", "hentai", "hockey", "hooters", "horney", "horny", "hotdog", "house", "hunter", "hunting", "iceman", "iloveyou", "internet", "iwantu", "jack", "jackie", "jackson", "jaguar", "jake", "james", "japan", "jasmine", "jason", "jasper", "jennifer", "jeremy", "jessica", "john", "johnny", "johnson", "jordan", "joseph", "joshua", "juice", "junior", "justin", "kelly", "kevin", "killer", "king", "kitty", "knight", "ladies", "lakers", "lauren", "leather", "legend", "letmein", "little", "london", "love", "lover", "lovers", "lucky", "maddog", "madison", "maggie", "magic", "magnum", "marine", "mark", "marlboro", "martin", "marvin", "master", "matrix", "matt", "matthew", "maverick", "maxwell", "melissa", "member", "mercedes", "merlin", "michael", "michelle", "mickey", "midnight", "mike", "miller", "mine", "mistress", "money", "monica", "monkey", "monster", "morgan", "mother", "mountain", "movie", "muffin", "murphy", "music", "mustang", "naked", "nascar", "nathan", "naughty", "ncc1701", "newyork", "nicholas", "nicole", "nipple", "nipples", "oliver", "orange", "ou812", "packers", "panther", "panties", "paris", "parker", "pass", "password", "patrick", "paul", "peaches", "peanut", "penis", "pepper", "peter", "phantom", "phoenix", "player", "please", "pookie", "porn", "porno", "porsche", "power", "prince", "princess", "private", "purple", "pussies", "pussy", "qazwsx", "qwert", "qwerty", "qwertyui", "rabbit", "rachel", "pokemon", "racing", "raiders", "rainbow", "ranger", "rangers", "rebecca", "redskins", "redsox", "redwings", "richard", "robert", "rock", "rocket", "rosebud", "runner", "rush2112", "russia", "samantha", "sammy", "samson", "sandra", "saturn", "scooby", "scooter", "scorpio", "scorpion", "scott", "secret", "sexsex", "sexy", "shadow", "shannon", "shaved", "shit", "sierra", "silver", "skippy", "slayer", "slut", "smith", "smokey", "snoopy", "soccer", "sophie", "spanky", "sparky", "spider", "squirt", "srinivas", "star", "stars", "startrek", "starwars", "steelers", "steve", "steven", "sticky", "stupid", "success", "suckit", "summer", "sunshine", "super", "superman", "surfer", "swimming", "sydney", "taylor", "teens", "tennis", "teresa", "test", "tester", "testing", "theman", "thomas", "thunder", "thx1138", "tiffany", "tiger", "tigers", "tigger", "time", "tits", "tomcat", "topgun", "toyota", "travis", "trouble", "trustno1", "tucker", "turtle", "united", "vagina", "victor", "victoria", "video", "viking", "viper", "voodoo", "voyager", "walter", "warrior", "welcome", "whatever", "white", "william", "willie", "wilson", "winner", "winston", "winter", "wizard", "wolf", "women", "xavier", "xxxx", "xxxxx", "xxxxxx", "xxxxxxxx", "yamaha", "yankee", "yankees", "yellow", "young", "zxcvbn", "zxcvbnm", "zzzzzz", "artix", "aqworlds", "adventure", "mechquest", "dragonfable", "123456789", "1234567890", "987654321", "0123456789", "12345678910", "qwertyuiop", "123123123", "asdfghjkl", "123321", "0987654321", "147258369", "789456123", "159753", "741852963", "minecraft", "147852369", "0123456", "qwerty123", "123654789", "naruto", "9876543210", "12341234", "123qwe", "159357", "123654", "gabriel", "123456789a");
            // characters = SharedObject.getLocal("AQWChars", "/", true);
            characters = SharedObject.getLocal("AQWChars", "/");
            petDisable = new Timer(0);
            portraitsCnt = [];
            disableTimer = new Timer(50, 1);
            regExLineSpace = /(\r\n)/gi;
            if (loaderInfo.hasOwnProperty("uncaughtErrorEvents"))
            {
                loaderInfo.uncaughtErrorEvents.addEventListener("uncaughtError", onUncaughtError);
            };
            super();
            var onConnectionHandler:Function = function(e:SFSEvent)
            {
                if (e.params.success)
                {
                    sfc.login(cLoginZone, ((((clientToken + "~") + loginInfo.strUsername) + "~") + clientVersion), loginInfo.strToken);
                    if (world != null)
                    {
                        world.uiLock = true;
                    };
                }
                else
                {
                    trace("failed");
                    if (serialCmdMode)
                    {
                        serialCmdNext();
                    };
                };
            };
            var isWarned:Function = function():Boolean
            {
                var curTS:Number;
                var iDiff:Number;
                if (("logoutWarningTS" in userPreference.data))
                {
                    curTS = new Date().getTime();
                    iDiff = ((userPreference.data.logoutWarningTS + (userPreference.data.logoutWarningDur * 1000)) - curTS);
                    if (iDiff > 60000)
                    {
                        userPreference.data.logoutWarningDur = 60;
                        userPreference.data.logoutWarningTS = curTS;
                        try
                        {
                            userPreference.flush();
                        }
                        catch (e:Error)
                        {
                            trace(e.message);
                        };
                    };
                    if (iDiff > 1000)
                    {
                        return (true);
                    };
                };
                return (false);
            };
            var onConnectionLostHandler:Function = function(e:SFSEvent)
            {
                if (!serialCmdMode)
                {
                    if (world != null)
                    {
                        world.exitCombat();
                        world.setTarget(null);
                        world.killTimers();
                        world.killListeners();
                        world.clearLoaders(true);
                        try
                        {
                            world.removeChild(world.map);
                        }
                        catch (e)
                        {
                        };
                        removeChild(world);
                        world = null;
                        SoundMixer.stopAll();
                        firstMenu = true;
                    };
                    if (sfc.isConnected)
                    {
                        sfc.disconnect();
                    };
                    if (showServers)
                    {
                        gotoAndPlay("Login");
                    }
                    else
                    {
                        gotoAndPlay(((((charCount() > 0) && (litePreference.data.bCharSelect)) && (!(isWarned()))) ? "Select" : "Login"));
                    };
                    if (e.params != null)
                    {
                        if (e.params.disconnect == true)
                        {
                            mcConnDetail.showDisconnect("Communication with server has been lost. Please check your internet connection and try again.");
                        };
                    };
                };
                newInstance = true;
            };
            var onLoginHandler:Function = function(e:SFSEvent)
            {
            };
            var onLogoutHandler:Function = function(e:SFSEvent)
            {
                if (!serialCmdMode)
                {
                    if (world != null)
                    {
                        world.exitCombat();
                        world.setTarget(null);
                        world.killTimers();
                        world.killListeners();
                        world.clearLoaders(true);
                        try
                        {
                            world.removeChild(world.map);
                        }
                        catch (e)
                        {
                        };
                        removeChild(world);
                        world = null;
                        SoundMixer.stopAll();
                        firstMenu = true;
                    };
                    if (sfc.isConnected)
                    {
                        sfc.disconnect();
                    };
                    if (FacebookConnect.isLoggedIn)
                    {
                        FacebookConnect.Logout();
                    };
                    if (showServers)
                    {
                        gotoAndPlay("Login");
                    }
                    else
                    {
                        gotoAndPlay(((((charCount() > 0) && (litePreference.data.bCharSelect)) && (!(isWarned()))) ? "Select" : "Login"));
                    };
                }
                else
                {
                    if (sfc.isConnected)
                    {
                        sfc.disconnect();
                    };
                    serialCmdNext();
                };
                newInstance = true;
            };
            var onMultiConnectionHandler:Function = function(e:SFSEvent)
            {
                if (e.params.success)
                {
                    this.sfc.login(cLoginZone, ((clientToken + "~") + this.sLogin), loginInfo.strToken);
                }
                else
                {
                    trace("failed");
                };
            };
            var onMultiConnectionLostHandler:Function = function(e:SFSEvent)
            {
                trace("");
                trace("** A MULTI CONNECTION WAS LOST");
                trace("");
            };
            var onMultiLogoutHandler:Function = function(e:SFSEvent)
            {
                trace("");
                trace("** A MULTI CONNECTION WAS LOGGED OUT");
                trace("");
            };
            var onMultiLoginHandler:Function = function(e:SFSEvent)
            {
            };
            var onJoinRoomHandler:Function = function(e:SFSEvent)
            {
            };
            var onUserEnterRoomHandler:Function = function(e:SFSEvent)
            {
            };
            var onUserLeaveRoomHandler:Function = function(e:SFSEvent)
            {
            };
            var onUserVariablesUpdateHandler:Function = function(e:SFSEvent)
            {
            };
            var onRoomListUpdateHandler:Function = function(e:SFSEvent)
            {
            };
            var onRoomVariablesUpdateHandler:Function = function(e:SFSEvent)
            {
            };
            var onRoomAddedHandler:Function = function(e:SFSEvent)
            {
            };
            var onPublicMessageHandler:Function = function(e:SFSEvent)
            {
            };
            var onPrivateMessageHandler:Function = function(e:SFSEvent)
            {
            };
            var onModeratorMessage:Function = function(e:SFSEvent)
            {
                var msg:* = e.params.message;
                var muo:* = e.params.sender;
            };
            var onObjectReceivedHandler:Function = function(e:SFSEvent)
            {
                var uo:*;
                var rObj:*;
                var pMC:MovieClip;
                var modal:*;
                var modalO:*;
                trace("OBJ HANDLER");
                if (sfcSocial)
                {
                    uo = e.params.sender;
                    rObj = e.params.obj;
                    switch (rObj.typ)
                    {
                        case "flourish":
                            if (world.CHARS.getChildByName(rObj.oName) != null)
                            {
                                MovieClip(world.CHARS.getChildByName(rObj.oName)).userName = uo.getName();
                                MovieClip(world.CHARS.getChildByName(rObj.oName)).gotoAndPlay(rObj.oFrame);
                            };
                            break;
                        case "danceRequest":
                            if (rObj.cell == world.strFrame)
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = "Would you care to dance?";
                                modalO.params = {};
                                modalO.params.emote1 = "/dance";
                                modalO.params.sender = uo;
                                modalO.callback = world.danceRequest;
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "danceDenied":
                            if (rObj.cell == world.strFrame)
                            {
                                chatF.submitMsg("/cry", "emotea", sfc.myUserName);
                            };
                            break;
                    };
                };
            };
            var onRoundTripResponseHandler:Function = function(evt:SFSEvent):void
            {
                var time:int = evt.params.elapsed;
                totalPingTime = (totalPingTime + (time / 2));
                pingCount++;
                var avg:int = int(Math.round((totalPingTime / pingCount)));
                trace((("Average lag: " + avg) + " milliseconds"));
            };
            onExtensionResponseHandler = function(e:SFSEvent)
            {
                var resObj:* = undefined;
                var protocol:* = undefined;
                var i:int;
                var s:String;
                var j:int;
                var o:Object;
                var a:Array;
                var b:Array;
                var mc:MovieClip;
                var tuo:* = undefined;
                var typ:String;
                var nam:String;
                var val:* = undefined;
                var msg:String;
                var msgT:String;
                var snd:String;
                var rcp:String;
                var org:* = undefined;
                var cmd:String;
                var anims:Array;
                var animIndex:uint;
                var monAvt:Avatar;
                var avtAvt:Avatar;
                var Mon:Avatar;
                var avt:Avatar;
                var pMC:MovieClip;
                var unm:String;
                var uid:int;
                var rmId:int;
                var MonMapID:int;
                var MonID:int;
                var prop:String;
                var uoName:* = undefined;
                var uoLeaf:Object;
                var monLeaf:Object;
                var cLeaf:Object;
                var tLeaf:Object;
                var actObj:Object;
                var cell:String;
                var st:int;
                var sta:String;
                var evt:String;
                var modal:MovieClip;
                var modalO:Object;
                var modalRR:* = undefined;
                var modalORR:Object;
                var silentMute:int;
                var filter:int;
                var updateID:String;
                var updateA:Array;
                var updateN:String;
                var updateO:Object;
                var iSel:Object;
                var eSel:Object;
                var now:Number;
                var newmon:Object;
                var cluster:* = undefined;
                var strMsg:* = undefined;
                var strLabel:* = undefined;
                var str:* = undefined;
                var slots:int;
                var dt:* = undefined;
                var motd:* = undefined;
                var vars:Array;
                var MonMapIDs:* = undefined;
                var id:* = undefined;
                var strMonName:String;
                var rand:int;
                var clMon:* = undefined;
                var tAvt:Avatar;
                var cAvt:Avatar;
                var strF:String;
                var ulo:* = undefined;
                var myLeaf:* = undefined;
                var adShown:Boolean;
                var testDate:Date;
                var dropItem:* = undefined;
                var anim:Object;
                var ai:int;
                var slot:int;
                var supressMupltiples:* = undefined;
                var isYou:* = undefined;
                var sMsg:* = undefined;
                var bi:int;
                var branchA:Object;
                var mID:String;
                var psES:* = undefined;
                var deltaXP:int;
                var xp:* = undefined;
                var xpB:* = undefined;
                var deltaGold:int;
                var deltaCoin:int;
                var gold:* = undefined;
                var coin:* = undefined;
                var deltaCP:int;
                var iRank:* = undefined;
                var txtBonusCP:String;
                var flo:* = undefined;
                var friend:* = undefined;
                var fct:Function;
                var item:* = undefined;
                var dID:* = undefined;
                var dItem:* = undefined;
                var iData:* = undefined;
                var isOK:Boolean;
                var bItem:* = undefined;
                var dropitem:* = undefined;
                var ItemID:* = undefined;
                var itemObj:* = undefined;
                var fi:* = undefined;
                var iobj:* = undefined;
                var itemArr:* = undefined;
                var dropindex:* = undefined;
                var dropID:* = undefined;
                var dropQty:int;
                var qi:String;
                var qr:String;
                var qj:String;
                var qk:String;
                var qat:Array;
                var ri:* = undefined;
                var fgWin:* = undefined;
                var m:* = undefined;
                var k:* = undefined;
                var bpObj:* = undefined;
                var blanki:* = undefined;
                var actBar:* = undefined;
                var delIcon:* = undefined;
                var actIconClass:Class;
                var actIcon:* = undefined;
                var actIconMC:* = undefined;
                var blankMC:* = undefined;
                var isNotUnlocked:Boolean;
                var existing:* = undefined;
                var c:Color;
                var stuS:String;
                var hasteCoeff:Number;
                var cd:* = undefined;
                var stu:String;
                var mcPath:* = undefined;
                resObj = e.params.dataObj;
                protocol = e.params.type;
                i = 0;
                s = "";
                j = 0;
                prop = "";
                var updated:Object = {};
                silentMute = 0;
                filter = 0;
                var cInf:String = "";
                var tInf:String = "";
                var cTyp:String = "";
                var cID:int = -1;
                var tTyp:String = "";
                var tID:int = -1;
                var ul:Array = [];
                var dat:Date = new Date();
                now = dat.getTime();
                if (protocol == "str")
                {
                    cmd = resObj[0];
                    trace(("responseObject STR: " + cmd));
                    switch (cmd)
                    {
                        default:
                            break;
                        case "loginResponse":
                            showTracking("5");
                            if ((((resObj[2] == 1) || (resObj[2] == "true")) || (resObj[2] == "True")))
                            {
                                mcConnDetail.showConn("Loading Character Data...");
                                sfc.myUserId = Number(resObj[3]);
                                sfc.myUserName = String(resObj[4]);
                                ts_login_client = now;
                                dt = stringToDate(resObj[6]);
                                ts_login_server = dt.getTime();
                                trace(date_server);
                                motd = "Message of The Day: Staff will never ask for your password! If someone asks for your password, report them for Griefing. NEVER share your password!";
                                chatF.pushMsg("moderator", motd, "SERVER", "", 0);
                                vars = resObj[7].split(",");
                                retrieveInfo(vars);
                                confirmTime = getTimer();
                            }
                            else
                            {
                                mcConnDetail.showError(resObj[5]);
                            };
                            break;
                        case "loginIterator":
                            if (((resObj[2] == 1) || (resObj[2] == "true")))
                            {
                                sfc.myUserId = Number(resObj[3]);
                                sfc.myUserName = String(resObj[4]);
                                chatF.submitMsg(serialCmd.cmd, "serialCmd", ((serialCmdMode) ? "iterator" : sfc.myUserName));
                            }
                            else
                            {
                                mcConnDetail.showError("Login Failed!");
                            };
                            break;
                        case "iterator":
                            sfc.logout();
                            break;
                        case "loginMulti":
                            if (!((resObj[2] == 1) || (resObj[2] == "true")))
                            {
                                mcConnDetail.showError("Login Failed!");
                            };
                            break;
                        case "notify":
                            typ = "server";
                            msg = resObj[2];
                            msg = chatF.cleanChars(msg);
                            msg = chatF.cleanStr(msg);
                            chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            MsgBox.notify(msg);
                            break;
                        case "logoutWarning":
                            userPreference.data.logoutWarning = String(resObj[2]);
                            userPreference.data.logoutWarningDur = Number(resObj[3]);
                            userPreference.data.logoutWarningTS = now;
                            try
                            {
                                userPreference.flush();
                            }
                            catch (e:Error)
                            {
                                trace(e.message);
                            };
                            break;
                        case "multiLoginWarning":
                            mcConnDetail.showError("Your AQWorlds game account has been logged on from another window session or computer.");
                            break;
                        case "server":
                            if (serialCmdMode)
                            {
                                msg = resObj[2];
                                trace(msg);
                                mcLogin.il.cmd.msgBox.text = (mcLogin.il.cmd.msgBox.text + (((("[" + serialCmd.servers[(serialCmd.si - 1)].sName) + "]: ") + msg) + "\n"));
                                mcLogin.il.cmd.msgBox.scrollV = mcLogin.il.cmd.msgBox.maxScrollV;
                                break;
                            };
                            typ = "server";
                            msg = resObj[2];
                            msg = chatF.cleanChars(msg);
                            msg = chatF.cleanStr(msg);
                            chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            break;
                        case "serverf":
                            msg = String(resObj[2]);
                            typ = "server";
                            str = chatF.cleanStr(msg);
                            unm = String(resObj[3]);
                            uid = int(resObj[4]);
                            rmId = int(resObj[5]);
                            msg = chatF.cleanChars(msg);
                            msgT = stripWhite(msg.toLowerCase());
                            if (chatF.strContains(msgT, chatF.illegalStrings))
                            {
                                silentMute = 1;
                            };
                            msgT = stripWhiteStrict(msg.toLowerCase());
                            if (chatF.strContains(msgT, ["email", "password"]))
                            {
                                silentMute = 1;
                            };
                            if (!silentMute)
                            {
                                chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            };
                            break;
                        case "moderator":
                            if (sfcSocial)
                            {
                                typ = "moderator";
                                msg = resObj[2];
                                msg = chatF.cleanChars(msg);
                                msg = chatF.cleanStr(msg);
                                chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            };
                            break;
                        case "administrator":
                            if (sfcSocial)
                            {
                                typ = "administrator";
                                msg = resObj[2];
                                msg = chatF.cleanChars(msg);
                                msg = chatF.cleanStr(msg);
                                chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            };
                            break;
                        case "wheel":
                            if (sfcSocial)
                            {
                                typ = "wheel";
                                msg = resObj[2];
                                msg = chatF.cleanChars(msg);
                                msg = chatF.cleanStr(msg);
                                chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            };
                            break;
                        case "gsupdate":
                            try
                            {
                                world.map.killCount(resObj[2]);
                            }
                            catch (e)
                            {
                                trace(e);
                            };
                            break;
                        case "frostupdate":
                            try
                            {
                                world.map.frostWar(resObj[2], resObj[3]);
                            }
                            catch (e)
                            {
                                trace(e);
                            };
                            break;
                        case "warning":
                            typ = "warning";
                            msg = resObj[2];
                            msg = chatF.cleanChars(msg);
                            msg = chatF.cleanStr(msg);
                            chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            break;
                        case "respawnMon":
                            if (sfcSocial)
                            {
                                MonMapIDs = resObj[2].split(",");
                                for (id in MonMapIDs)
                                {
                                    Mon = world.getMonster(MonMapIDs[id]);
                                    monLeaf = world.monTree[MonMapIDs[id]];
                                    if ((((!(monLeaf == null)) && (!(Mon.objData == null))) && (Mon.objData.strFrame == world.strFrame)))
                                    {
                                        monLeaf.targets = {};
                                        strMonName = "";
                                        if (Number(world.objExtra["bMonName"]) == 1)
                                        {
                                            rand = int(Math.round((Math.random() * (world.chaosNames.length - 1))));
                                            if (world.chaosNames[rand] == world.myAvatar.objData.strUsername)
                                            {
                                                rand = ((rand == 0) ? ((rand = (rand + 1)), rand) : ((rand = (rand - 1)), rand));
                                            };
                                            strMonName = world.chaosNames[rand];
                                        };
                                        Mon.pMC.respawn(strMonName);
                                        Mon.pMC.x = Mon.pMC.ox;
                                        Mon.pMC.y = Mon.pMC.oy;
                                        if (((Mon.objData.bRed == 1) && (world.myAvatar.dataLeaf.intState > 0)))
                                        {
                                            world.aggroMon(MonMapIDs[id]);
                                        };
                                    };
                                };
                            };
                            break;
                        case "resTimed":
                            if ((((resObj.length > 2) && (!(String(resObj[2]) == null))) && (!(String(resObj[3]) == null))))
                            {
                                world.moveToCell(String(resObj[2]), String(resObj[3]));
                            }
                            else
                            {
                                world.moveToCell(world.spawnPoint.strFrame, world.spawnPoint.strPad);
                            };
                            world.map.transform.colorTransform = world.defaultCT;
                            world.CHARS.transform.colorTransform = world.defaultCT;
                            break;
                        case "exitArea":
                            uid = int(resObj[2]);
                            unm = String(resObj[3]);
                            world.manageAreaUser(String(resObj[3]), "-");
                            avt = world.avatars[uid];
                            if (avt != null)
                            {
                                if (avt == world.myAvatar.target)
                                {
                                    world.setTarget(null);
                                };
                                if (((!(avt.objData == null)) && (world.isPartyMember(avt.objData.strUsername))))
                                {
                                    world.updatePartyFrame({
                                                "unm": avt.objData.strUsername,
                                                "range": false
                                            });
                                };
                                world.destroyAvatar(uid);
                                delete world.uoTree[unm];
                                if (ui.mcInterface.areaList.currentLabel == "hold")
                                {
                                    areaListGet();
                                };
                            };
                            break;
                        case "uotls":
                            trace("uotls");
                            o = {};
                            a = resObj[3].split(",");
                            i = 0;
                            while (i < a.length)
                            {
                                o[a[i].split(":")[0]] = a[i].split(":")[1];
                                i = (i + 1);
                            };
                            userTreeWrite(String(resObj[2]), o);
                            if (ui.mcInterface.areaList.currentLabel == "hold")
                            {
                                areaListGet();
                            };
                            break;
                        case "mtls":
                            o = {};
                            a = resObj[3].split(",");
                            i = 0;
                            while (i < a.length)
                            {
                                o[a[i].split(":")[0]] = a[i].split(":")[1];
                                i = (i + 1);
                            };
                            monsterTreeWrite(int(resObj[2]), o);
                            break;
                        case "spcs":
                            MonMapID = int(resObj[2]);
                            MonID = int(resObj[3]);
                            monLeaf = world.monTree[MonMapID];
                            newmon = {};
                            i = 0;
                            while (i < world.mondef.length)
                            {
                                if (world.mondef[i].MonID == MonID)
                                {
                                    newmon = world.mondef[i];
                                    i = world.mondef.length;
                                };
                                i = (i + 1);
                            };
                            monLeaf.intHP = 0;
                            monLeaf.intMP = 0;
                            monLeaf.intHPMax = newmon.intHPMax;
                            monLeaf.intMPMax = newmon.intMPMax;
                            monLeaf.intState = 0;
                            monLeaf.iLvl = newmon.iLvl;
                            monLeaf.MonID = MonID;
                            cluster = world.getMonsterCluster(MonMapID);
                            i = 0;
                            while (i < cluster.length)
                            {
                                clMon = cluster[i];
                                if (monLeaf.MonID == clMon.objData.MonID)
                                {
                                    if (monLeaf.strFrame == world.strFrame)
                                    {
                                        world.CHARS.addChild(clMon.pMC);
                                    };
                                    clMon.dataLeaf = monLeaf;
                                }
                                else
                                {
                                    if (monLeaf.strFrame == world.strFrame)
                                    {
                                        world.TRASH.addChild(clMon.pMC);
                                    };
                                    clMon.dataLeaf = null;
                                };
                                i = (i + 1);
                            };
                            break;
                        case "cc":
                            strMsg = chatF.getCCText(resObj[2]);
                            unm = String(resObj[3]);
                            if (chatF.ignoreList.data.users != undefined)
                            {
                                if (chatF.ignoreList.data.users.indexOf(unm) > -1)
                                {
                                    filter = 1;
                                };
                            };
                            if (filter == 0)
                            {
                                chatF.pushMsg("zone", strMsg, unm, "", 0);
                            };
                            break;
                        case "emotea":
                            strLabel = String(resObj[2]);
                            uid = int(resObj[3]);
                            pMC = world.getMCByUserID(uid);
                            if (pMC != null)
                            {
                                pMC.mcChar.gotoAndPlay(strToProperCase(strLabel));
                            };
                            break;
                        case "em":
                            unm = String(resObj[2]);
                            msg = chatF.cleanStr(String(resObj[3]));
                            while (msg.indexOf("  ") > -1)
                            {
                                msg = msg.split("  ").join(" ");
                            };
                            msg = chatF.cleanChars(msg);
                            msgT = stripWhiteStrict(msg.toLowerCase());
                            if (chatF.strContains(msgT, chatF.illegalStrings))
                            {
                                silentMute = 1;
                            };
                            if (!silentMute)
                            {
                                chatF.pushMsg("event", msg, unm, "", 0);
                            };
                            break;
                        case "chatm":
                            str = String(resObj[2]);
                            str = chatF.cleanStr(str, true, false, Boolean(int(resObj[6])));
                            unm = String(resObj[3]);
                            uid = int(resObj[4]);
                            rmId = int(resObj[5]);
                            typ = str.substr(0, str.indexOf("~"));
                            msg = str.substr((str.indexOf("~") + 1));
                            msg = chatF.cleanChars(msg);
                            if (chatF.ignoreList.data.users != undefined)
                            {
                                if (chatF.ignoreList.data.users.indexOf(unm.toLowerCase()) > -1)
                                {
                                    filter = 1;
                                };
                            };
                            if (!filter)
                            {
                                chatF.pushMsg(typ, msg, ((unm.toLowerCase() == unm) ? (unm.charAt(0).toUpperCase() + unm.slice(1)) : unm), uid, 0, int(resObj[6]));
                            };
                            break;
                        case "whisper":
                            typ = "whisper";
                            msg = resObj[2];
                            snd = String(resObj[3]);
                            rcp = String(resObj[4]);
                            org = resObj[5];
                            msg = chatF.cleanStr(msg);
                            msg = chatF.cleanChars(msg);
                            silentMute = 0;
                            if (msg.indexOf(":=sm") > -1)
                            {
                                msg = msg.substr(0, msg.indexOf(":=sm"));
                                if (unm != sfc.myUserName)
                                {
                                    silentMute = 1;
                                };
                            };
                            if (chatF.ignoreList.data.users != undefined)
                            {
                                if (chatF.ignoreList.data.users.indexOf(snd.toLowerCase()) > -1)
                                {
                                    filter = 1;
                                };
                            };
                            if (((!(filter)) && ((!(silentMute)) || ((silentMute) && (snd == rcp)))))
                            {
                                if (snd.toLowerCase() != sfc.myUserName.toLowerCase())
                                {
                                    chatF.pmSourceA = [snd];
                                    if (chatF.pmSourceA.length > 20)
                                    {
                                        chatF.pmSourceA.splice(0, (chatF.pmSourceA.length - 20));
                                    };
                                };
                                if (org == 1)
                                {
                                    chatF.pushMsg(typ, msg, snd, rcp, 0);
                                    chatF.pushMsg(typ, msg, snd, rcp, 1);
                                }
                                else
                                {
                                    chatF.pushMsg(typ, msg, snd, rcp, org, int(resObj[6]));
                                };
                            };
                            break;
                        case "mute":
                            chatF.muteMe(int(resObj[2]));
                            break;
                        case "unmute":
                            chatF.unmuteMe();
                            break;
                        case "mvna":
                            if (((world.uoTree[sfc.myUserName].freeze == null) || (!(world.uoTree[sfc.myUserName].freeze))))
                            {
                                world.uoTree[sfc.myUserName].freeze = true;
                            };
                            break;
                        case "mvnb":
                            if (world.uoTree[sfc.myUserName].freeze != null)
                            {
                                delete world.uoTree[sfc.myUserName].freeze;
                            };
                            break;
                        case "gtc":
                            if (((!(String(resObj[2]) == null)) && (!(String(resObj[3]) == null))))
                            {
                                world.moveToCell(String(resObj[2]), String(resObj[3]));
                            };
                            break;
                        case "mtcid":
                            if (resObj.length > 2)
                            {
                                world.moveToCellByIDb(Number(resObj[2]));
                            };
                            break;
                        case "hi":
                            trace("");
                            trace("****> SFS Ping response, unlocking all actions, canceling logout timer");
                            trace("");
                            world.connMsgOut = false;
                            world.connTestTimer.reset();
                            world.unlockActions();
                            break;
                        case "Dragon Buff":
                            world.map.doDragonBuff();
                            break;
                        case "trap door":
                            world.map.doTrapDoor(resObj[2]);
                            break;
                        case "gMOTD":
                            world.myAvatar.objData.guild.MOTD = resObj[2];
                            break;
                        case "buyGSlots":
                            slots = int(resObj[2]);
                            if (!isNaN(slots))
                            {
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - (slots * 200));
                            };
                            if (ui.mcPopup.currentLabel == "GuildPanel")
                            {
                                ui.mcPopup.updateGuildWindow();
                            };
                            break;
                        case "gRename":
                            world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - 1000);
                            break;
                        case "fbRes":
                            if (resObj[4] != null)
                            {
                                typ = "warning";
                                msg = resObj[4];
                                msg = chatF.cleanChars(msg);
                                msg = chatF.cleanStr(msg);
                                chatF.pushMsg(typ, msg, "SERVER", "", 0);
                            };
                            break;
                        case "elmSwitch":
                            try
                            {
                                world.map.setupElement(String(resObj[2]));
                            }
                            catch (e)
                            {
                                trace(("error sending element: " + e));
                            };
                    };
                };
                if (protocol == "json")
                {
                    cmd = resObj.cmd;
                    trace(("responseObject JSON: " + cmd));
                    strF = "";
                    switch (cmd)
                    {
                        default:
                            trace("*>> Unhandled CMD <<*");
                            break;
                        case "who":
                            ulo = {};
                            ulo.typ = "userListA";
                            ulo.ul = resObj.users;
                            ui.mcOFrame.fOpenWith(ulo);
                            break;
                        case "al":
                            areaListShow(resObj);
                            break;
                        case "getinfo":
                            for (prop in resObj)
                            {
                                if (prop != "cmd")
                                {
                                    trace(((("USER INFO >  " + prop) + " : ") + resObj[prop]));
                                };
                            };
                            break;
                        case "reloadmap":
                            if (world.strMapName == resObj.sName)
                            {
                                world.setMapEvents(null);
                                world.strMapFileName = resObj.sFileName;
                                world.reloadCurrentMap();
                            };
                            break;
                        case "moveToArea":
                            if (((resObj.areaName.indexOf("battleon") > -1) && (resObj.areaName.indexOf("battleontown") < 0)))
                            {
                                world.rootClass.openMenu();
                                world.rootClass.firstMenu = false;
                            }
                            else
                            {
                                if (!world.rootClass.firstMenu)
                                {
                                    world.rootClass.menuClose();
                                };
                            };
                            world.mapLoadInProgress = true;
                            world.strAreaName = resObj.areaName;
                            world.initObjExtra(resObj.sExtra);
                            world.areaUsers = [];
                            myLeaf = null;
                            world.modID = -1;
                            if (world.uoTreeLeaf(sfc.myUserName) != null)
                            {
                                myLeaf = copyObj(world.uoTreeLeaf(sfc.myUserName));
                            };
                            world.uoTree = {};
                            if (myLeaf != null)
                            {
                                world.uoTree[sfc.myUserName] = myLeaf;
                            };
                            if (resObj.monName != null)
                            {
                                world.chaosNames = resObj.monName.split(",");
                            };
                            if (resObj.pvpTeam != null)
                            {
                                myLeaf.pvpTeam = resObj.pvpTeam;
                                world.bPvP = true;
                                ui.mcPortrait.pvpIcon.visible = true;
                                ui.mcPortrait.partyLead.y = 18;
                                world.setPVPFactionData(resObj.PVPFactions);
                                if (world.objExtra["bChaos"] == null)
                                {
                                    updatePVPScore(resObj.pvpScore);
                                    showPVPScore();
                                };
                            }
                            else
                            {
                                ui.mcPortrait.pvpIcon.visible = false;
                                ui.mcPortrait.partyLead.y = 0;
                                delete myLeaf.pvpTeam;
                                world.bPvP = false;
                                hidePVPScore();
                                world.setPVPFactionData(null);
                            };
                            if (resObj.pvpScore != null)
                            {
                                updatePVPScore(resObj.pvpScore);
                            };
                            bi = 0;
                            while (bi < resObj.uoBranch.length)
                            {
                                branchA = resObj.uoBranch[bi];
                                unm = branchA.uoName;
                                uoLeaf = {};
                                for (s in branchA)
                                {
                                    nam = s;
                                    val = branchA[s];
                                    if ((((((nam.toLowerCase().indexOf("int") > -1) || (nam.toLowerCase() == "tx")) || (nam.toLowerCase() == "ty")) || (nam.toLowerCase() == "sp")) || (nam.toLowerCase() == "pvpTeam")))
                                    {
                                        val = int(val);
                                    };
                                    uoLeaf[nam] = val;
                                };
                                if (unm != sfc.myUserName)
                                {
                                    uoLeaf.auras = [];
                                };
                                uoLeaf.targets = {};
                                world.uoTreeLeafSet(unm, uoLeaf);
                                world.manageAreaUser(unm, "+");
                                bi = (bi + 1);
                            };
                            world.monTree = {};
                            world.monsters = [];
                            bi = 0;
                            while (bi < resObj.monBranch.length)
                            {
                                branchA = resObj.monBranch[bi];
                                monLeaf = {};
                                mID = "1";
                                for (s in branchA)
                                {
                                    nam = s;
                                    val = branchA[s];
                                    if (nam.toLowerCase().indexOf("monmapid") > -1)
                                    {
                                        mID = val;
                                    };
                                    if ((((nam.toLowerCase().indexOf("int") > -1) || (nam.toLowerCase().indexOf("monid") > -1)) || (nam.toLowerCase().indexOf("monmapid") > -1)))
                                    {
                                        val = int(val);
                                    };
                                    monLeaf[nam] = val;
                                };
                                monLeaf.auras = [];
                                monLeaf.targets = {};
                                monLeaf.strBehave = "walk";
                                world.monTree[mID] = monLeaf;
                                bi = (bi + 1);
                            };
                            if (("event" in resObj))
                            {
                                world.setMapEvents(resObj.event);
                            }
                            else
                            {
                                world.setMapEvents(null);
                            };
                            if (("cellMap" in resObj))
                            {
                                world.setCellMap(resObj.cellMap);
                            }
                            else
                            {
                                world.setCellMap(null);
                            };
                            if (world.strFrame != "")
                            {
                                world.exitCell();
                            };
                            world.killLoaders();
                            world.clearMonstersAndProps();
                            world.clearAllAvatars();
                            world.avatars[sfc.myUserId] = world.myAvatar;
                            world.strMapName = resObj.strMapName;
                            world.strMapFileName = resObj.strMapFileName;
                            world.intType = resObj.intType;
                            world.intKillCount = resObj.intKillCount;
                            world.objLock = ((resObj.objLock != null) ? resObj.objLock : null);
                            world.mondef = resObj.mondef;
                            world.monmap = resObj.monmap;
                            world.curRoom = Number(resObj.areaId);
                            world.actionResultsMon = {};
                            world.actionResults = {};
                            world.mapBoundsMC = null;
                            chatF.chn.zone.rid = world.curRoom;
                            if (("houseData" in resObj))
                            {
                                world.initHouseData(resObj.houseData);
                            }
                            else
                            {
                                world.initHouseData(null);
                            };
                            world.updatePartyFrame();
                            world.clearLoaders();
                            s = resObj.strMapFileName;
                            world.loadMap(s);
                            elmType = resObj.elmType;
                            if (world.rootClass.hasPreviewed)
                            {
                                for (psES in world.myAvatar.objData.eqp)
                                {
                                    if (world.myAvatar.objData.eqp[psES].wasCreated)
                                    {
                                        delete world.myAvatar.objData.eqp[psES];
                                        world.myAvatar.unloadMovieAtES(psES);
                                    }
                                    else
                                    {
                                        if (world.myAvatar.objData.eqp[psES].isPreview)
                                        {
                                            if (psES == "pe")
                                            {
                                                if (world.myAvatar.objData.eqp["pe"])
                                                {
                                                    world.myAvatar.unloadPet();
                                                };
                                            };
                                            world.myAvatar.objData.eqp[psES].sType = world.myAvatar.objData.eqp[psES].oldType;
                                            world.myAvatar.objData.eqp[psES].sFile = world.myAvatar.objData.eqp[psES].oldFile;
                                            world.myAvatar.objData.eqp[psES].sLink = world.myAvatar.objData.eqp[psES].oldLink;
                                            world.myAvatar.loadMovieAtES(psES, world.myAvatar.objData.eqp[psES].oldFile, world.myAvatar.objData.eqp[psES].oldLink);
                                            world.myAvatar.objData.eqp[psES].isPreview = null;
                                        };
                                    };
                                };
                                world.rootClass.hasPreviewed = false;
                            };
                            if (((world.myAvatar.items) && (world.myAvatar.items.length > 0)))
                            {
                                saveChar();
                            };
                            break;
                        case "initUserData":
                            try
                            {
                                avt = world.getAvatarByUserID(resObj.uid);
                                uoLeaf = avt.dataLeaf;
                                if (((!(avt == null)) && (!(uoLeaf == null))))
                                {
                                    avt.initAvatar({"data": resObj.data});
                                    if (avt.isMyAvatar)
                                    {
                                        loadGameMenu();
                                        avt.objData.strHomeTown = avt.objData.strMapName;
                                        if (avt.objData.guild != null)
                                        {
                                            chatF.chn.guild.act = 1;
                                            if (String(avt.objData.guild.MOTD) != "undefined")
                                            {
                                                chatF.pushMsg("guild", ("Message of the day: " + String(avt.objData.guild.MOTD)), "SERVER", "", 0);
                                            };
                                        };
                                        if (Game.serverFilePath.indexOf("content.aq.com") == -1)
                                        {
                                            world.rootClass.extCall.showIt("login");
                                        };
                                        if (avt.objData.iUpg > 0)
                                        {
                                            if (avt.objData.iUpgDays < 0)
                                            {
                                                chatF.pushMsg("moderator", "Your membership has expired. Please visit our website to renew your membership.", "SERVER", "", 0);
                                            }
                                            else
                                            {
                                                if (avt.objData.iUpgDays < 7)
                                                {
                                                    chatF.pushMsg("moderator", (("Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1)) + " days. Please visit our website to renew your membership."), "SERVER", "", 0);
                                                };
                                            };
                                        };
                                        updateXPBar();
                                        ui.mcInterface.mcGold.strGold.text = avt.objData.intGold;
                                        if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                        {
                                            MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                        };
                                        trace(("resObj.uid: " + resObj.uid));
                                        world.getInventory(resObj.uid);
                                        world.initAchievements();
                                        readIA1Preferences();
                                    };
                                };
                            }
                            catch (e:Error)
                            {
                                trace("initUserData > ");
                                trace(e);
                            };
                            break;
                        case "initUserDatas":
                            a = resObj.a;
                            i = 0;
                            while (i < a.length)
                            {
                                o = a[i];
                                try
                                {
                                    avt = world.getAvatarByUserID(o.uid);
                                    uoLeaf = avt.dataLeaf;
                                    if (((!(avt == null)) && (!(uoLeaf == null))))
                                    {
                                        avt.initAvatar({"data": o.data});
                                        if (((avt.isMyAvatar) && ((avt.items == null) || (avt.items.length < 1))))
                                        {
                                            loadGameMenu();
                                            avt.objData.strHomeTown = avt.objData.strMapName;
                                            if (avt.objData.guild != null)
                                            {
                                                chatF.chn.guild.act = 1;
                                                if (String(avt.objData.guild.MOTD) != "undefined")
                                                {
                                                    chatF.pushMsg("guild", ("Message of the day: " + String(avt.objData.guild.MOTD)), "SERVER", "", 0);
                                                };
                                            };
                                            if (Game.serverFilePath.indexOf("content.aq.com") == -1)
                                            {
                                                world.rootClass.extCall.showIt("login");
                                            };
                                            if (avt.objData.iUpg > 0)
                                            {
                                                if (avt.objData.iUpgDays < 0)
                                                {
                                                    chatF.pushMsg("moderator", "Your membership has expired. Please visit our website to renew your membership.", "SERVER", "", 0);
                                                }
                                                else
                                                {
                                                    if (avt.objData.iUpgDays < 7)
                                                    {
                                                        chatF.pushMsg("moderator", (("Your membership will expire in " + (Number(avt.objData.iUpgDays) + 1)) + " days. Please visit our website to renew your membership."), "SERVER", "", 0);
                                                    };
                                                };
                                            };
                                            if (((!(avt.objData.dRefReset == null)) && ((avt.objData.iRefGold > 0) || (avt.objData.iRefExp > 0))))
                                            {
                                                modalRR = new ModalMC();
                                                modalORR = {};
                                                modalORR.strBody = (((("You earned <font color='#FFCC00'><b>" + Math.ceil(avt.objData.iRefGold)) + " Gold</b></font> and <font color='#990099'><b>") + Math.ceil(avt.objData.iRefExp)) + " XP</b></font><br/> from Referred Friends.");
                                                modalORR.callback = world.sendRewardReferralRequest;
                                                modalORR.btns = "mono";
                                                ui.ModalStack.addChild(modalRR);
                                                modalRR.init(modalORR);
                                            };
                                            updateXPBar();
                                            ui.mcInterface.mcGold.strGold.text = avt.objData.intGold;
                                            if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                            {
                                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                            };
                                            world.getInventory(o.uid);
                                            world.initAchievements();
                                            readIA1Preferences();
                                        };
                                    };
                                }
                                catch (e:Error)
                                {
                                    trace("initUserDatas > ");
                                    trace(e);
                                };
                                i = (i + 1);
                            };
                            break;
                        case "changeColor":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!(avt == null)) && (avt.bitData)))
                            {
                                if (avt.isMyAvatar)
                                {
                                    showPortrait(avt);
                                }
                                else
                                {
                                    if (resObj.HairID != null)
                                    {
                                        avt.objData.HairID = resObj.HairID;
                                        avt.objData.strHairName = resObj.strHairName;
                                        avt.objData.strHairFilename = resObj.strHairFilename;
                                        if (((!(avt.pMC == null)) && (!(avt.pMC.stage == null))))
                                        {
                                            avt.pMC.loadHair();
                                        };
                                    };
                                    avt.objData.intColorSkin = resObj.intColorSkin;
                                    avt.objData.intColorHair = resObj.intColorHair;
                                    avt.objData.intColorEye = resObj.intColorEye;
                                    if (((!(avt.pMC == null)) && (!(avt.pMC.stage == null))))
                                    {
                                        avt.pMC.updateColor();
                                    };
                                };
                            }
                            else
                            {
                                trace("can't set data!");
                            };
                            break;
                        case "changeArmorColor":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!(avt == null)) && (avt.bitData)))
                            {
                                if (!avt.isMyAvatar)
                                {
                                    avt.objData.intColorBase = resObj.intColorBase;
                                    avt.objData.intColorTrim = resObj.intColorTrim;
                                    avt.objData.intColorAccessory = resObj.intColorAccessory;
                                    if (((!(avt.pMC == null)) && (!(avt.pMC.stage == null))))
                                    {
                                        avt.pMC.updateColor();
                                    };
                                };
                            }
                            else
                            {
                                trace("can't set data!");
                            };
                            break;
                        case "changeUsernameColor":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (avt.bitData)
                            {
                                if (avt.isMyAvatar)
                                {
                                    MsgBox.notify("Username Color successfully changed.");
                                };
                                avt.objData.strUsernameColor = resObj.UsernameColor;
                                avt.initAvatar({data: avt.objData});
                            };
                            break;
                        case "popupmsg":
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = resObj.strMsg;
                            modalO.params = {};
                            modalO.glow = resObj.strGlow;
                            modalO.btns = "mono";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            break;
                        case "updateChatColor":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (avt.bitData)
                            {
                                if (avt.isMyAvatar)
                                {
                                    MsgBox.notify("Chat Color successfully changed.");
                                };
                                avt.objData.strChatColor = resObj.chatColor;
                            };
                            break;
                        case "loadOffer":
                            if (resObj.bitSuccess)
                            {
                                if (((!((resObj.itemsA == null))) && (!((resObj.itemsA == "undefined")))))
                                {
                                    world.addItemsToTradeA(resObj.itemsA);
                                };
                                if (((!((resObj.itemsB == null))) && (!((resObj.itemsB == "undefined")))))
                                {
                                    world.addItemsToTradeB(resObj.itemsB);
                                };
                                if (ui.mcPopup.currentLabel == "TradePanel")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcTrade")).update({eventType: "refreshBank"});
                                }
                                else
                                {
                                    ui.mcPopup.fOpen("TradePanel");
                                };
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = "Error loading trade items!  Try logging out and back in to fix this problem.";
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "tradeDeal":
                            if (resObj.bitSuccess)
                            {
                                if (("onHold" in resObj) && (resObj.onHold == 1))
                                {
                                    ctrlTrade.btnDeal.alpha = 0.5;
                                    ctrlTrade.btnDeal.mouseEnabled = false;
                                }
                                else
                                {
                                    if (ui.mcPopup.currentLabel == "TradePanel")
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcTrade")).notify = false;
                                        MovieClip(ui.mcPopup.getChildByName("mcTrade")).fClose();
                                    }
                                }
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = resObj.msg;
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "tradeCancel":
                            trace("Received cancel");
                            if (resObj.bitSuccess)
                            {
                                world.myAvatar.tradeToInvReset();
                                trace("Reset initiated");
                                if (ui.mcPopup.currentLabel == "TradePanel")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcTrade")).notify = false;
                                    MovieClip(ui.mcPopup.getChildByName("mcTrade")).fClose();
                                }
                            }
                            break;
                        case "tradeLock":
                            if (resObj.bitSuccess)
                            {
                                ctrlTrade.txtTargetGold.text = resObj.gold;
                                ctrlTrade.txtTargetCoins.text = resObj.coins;

                                if (("Deal" in resObj) && (resObj.Deal == 1))
                                {
                                    ctrlTrade.btnDeal.alpha = 1;
                                    ctrlTrade.btnDeal.mouseEnabled = true;
                                }
                                if (("Self" in resObj) && (resObj.Self == 1))
                                {
                                    ctrlTrade.txtMyGold.mouseEnabled = false;
                                    ctrlTrade.txtMyCoins.mouseEnabled = false;
                                    ctrlTrade.txtLock.text = "Unlock";
                                    tradeItem1.alpha = 0.5;
                                }
                                else
                                {
                                    tradeItem2.alpha = 0.5;
                                }
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = resObj.msg;
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "tradeUnlock":
                            if (resObj.bitSuccess)
                            {
                                ctrlTrade.txtLock.text = "Lock";
                                ctrlTrade.btnDeal.alpha = 0.5;
                                ctrlTrade.btnDeal.mouseEnabled = false;
                                ctrlTrade.txtMyGold.mouseEnabled = true;
                                ctrlTrade.txtMyCoins.mouseEnabled = true;
                                tradeItem1.alpha = 1;
                                tradeItem2.alpha = 1;
                            }
                            break;
                        case "tradeFromInv":
                            if (((("bSuccess" in resObj)) && ((resObj.bSuccess == 1))))
                            {
                                world.myAvatar.tradeFromInv(resObj.ItemID, resObj.Type, resObj.Quantity);
                                world.checkAllQuestStatus();
                                if (ui.mcPopup.currentLabel == "TradePanel")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcTrade")).update({eventType: "refreshItems"});
                                };
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = resObj.msg;
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "tradeToInv":
                            if (resObj.Type == 1)
                            {
                                world.myAvatar.tradeToInvA(resObj.ItemID);
                            }
                            else
                            {
                                world.myAvatar.tradeToInvB(resObj.ItemID);
                            }
                            world.checkAllQuestStatus();
                            if (ui.mcPopup.currentLabel == "TradePanel")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcTrade")).update({eventType: "refreshItems"});
                            };
                            break;
                        case "tradeSwapInv":
                            world.myAvatar.tradeSwapInv(resObj.invItemID, resObj.tradeItemID);
                            world.checkAllQuestStatus();
                            if (ui.mcPopup.currentLabel == "TradePanel")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcTrade")).update({eventType: "refreshItems"});
                            };
                            break;
                        case "getAchievement":
                            showAchievement(resObj.name, resObj.id);
                            mixer.playSound("Achievement");
                            break;
                        case "updateAvatar":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (avt.bitData)
                            {
                                if (resObj.bitSuccess == 1)
                                {
                                    avt.objData.bInvisible = resObj.invisible;
                                    avt.initAvatar({data: avt.objData});
                                };
                            };
                            break;
                        case "buyAuctionItem":
                            if (resObj.bitSuccess)
                            {
                                item = copyObj(resObj.item);
                                item.CharItemID = resObj.CharItemID;

                                showItemDrop(item, false);
                                world.invTree[item.ItemID] = item;

                                world.myAvatar.auctionToInv(item);

                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshItems"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshBank"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshInventory"});

                                world.updateQuestProgress("item", item);
                            }
                            else
                            {
                                MsgBox.notify(resObj.strMessage);
                            }
                            break;
                        case "sellAuctionItem":
                            if (resObj.bitSuccess)
                            {
                                world.myAvatar.removeItem(resObj.CharItemID, resObj.Quantity);
                                world.checkAllQuestStatus();

                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshItems"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshBank"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshInventory"});
                            }
                            else
                            {
                                MsgBox.notify(resObj.strMessage);
                            }
                            break;
                        case "retrieveAuctionItem":
                            if (resObj.bitSuccess)
                            {
                                if ("item" in resObj)
                                {
                                    item = copyObj(resObj.item);
                                    item.CharItemID = resObj.CharItemID;

                                    showItemDrop(item, false);
                                    world.invTree[item.ItemID] = item;
                                    world.myAvatar.addItem(item);
                                    world.updateQuestProgress("item", item);
                                }

                                world.myAvatar.removeRetrieve(resObj.AuctionID);
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshItems"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshBank"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshInventory"});
                            }
                            else
                            {
                                MsgBox.notify(resObj.strMessage);
                            }
                            break;
                        case "retrieveAuctionItems":
                            if (resObj.bitSuccess)
                            {
                                i = 0;
                                while (i < resObj.items.length)
                                {
                                    iobj = copyObj(resObj.items[i]);

                                    world.invTree[iobj.ItemID] = copyObj(iobj);
                                    if (!("bSold" in resObj.items[i]))
                                    {
                                        world.myAvatar.addItem(iobj);
                                        showItemDrop(iobj, false);
                                    }

                                    world.updateQuestProgress("item", iobj);
                                    world.myAvatar.removeRetrieve(resObj.items[i].AuctionID);

                                    i = (i + 1);
                                };

                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshItems"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshBank"});
                                MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshInventory"});
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = resObj.strMessage;
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            }
                            break;
                        case "loadAuction":
                            if (resObj.bitSuccess)
                            {
                                if (((!((resObj.items == null))) && (!((resObj.items == "undefined")))))
                                {
                                    world.addItemsToAuction(resObj.items);
                                };
                                if (ui.mcPopup.currentLabel == "AuctionPanel")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshItems"});
                                    MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshBank"});
                                    MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshInventory"});
                                }
                                else
                                {
                                    ui.mcPopup.fOpen("AuctionPanel");
                                };
                                world.rootClass.auctionTabs.onSearch = false;
                            }
                            else
                            {
                                MsgBox.notify(resObj.strMessage);
                            };
                            break;
                        case "loadRetrieve":
                            if (resObj.bitSuccess)
                            {
                                if (((!((resObj.items == null))) && (!((resObj.items == "undefined")))))
                                {
                                    world.addItemsToRetrieve(resObj.items);
                                };
                                if (ui.mcPopup.currentLabel == "AuctionPanel")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshItems"});
                                    MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshBank"});
                                    MovieClip(ui.mcPopup.getChildByName("mcAuction")).update({eventType: "refreshInventory"});
                                }
                                else
                                {
                                    ui.mcPopup.fOpen("AuctionPanel");
                                };
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = "Error loading auction items!  Try logging out and back in to fix this problem.";
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "loadTitle":
                            if (resObj.bitSuccess)
                            {
                                ui.mcPopup.mcTitleBoard.distributeList(resObj.lists);
                            };
                            break;
                        case "equipTitle":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!(avt == null)) && (avt.bitData)))
                            {
                                if (resObj.bitSuccess == 1)
                                {
                                    if (avt.isMyAvatar)
                                    {
                                        MsgBox.notify("Your title has been successfully changed.");
                                    };
                                    avt.objData.title = resObj.title;
                                    avt.objData.title.id = resObj.titleId;
                                    avt.objData.title.Name = resObj.titleName;
                                    avt.objData.title.Color = resObj.titleColor;
                                    avt.pMC.pname.title.textColor = resObj.titleColor;
                                    avt.pMC.pname.title.text = resObj.titleName;
                                    avt.pMC.pname.title.visible = true;
                                    ui.mcPopup.mcTitleBoard.btnText.text = "Unequip";
                                };
                            };
                            break;
                        case "unequipTitle":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!(avt == null)) && (avt.bitData)))
                            {
                                if (resObj.bitSuccess == 1)
                                {
                                    if (avt.isMyAvatar)
                                    {
                                        MsgBox.notify("Successfully unequipped the title.");
                                    };
                                    avt.pMC.pname.title.textColor = 0xFFFFFF;
                                    avt.pMC.pname.title.text = "";
                                    avt.pMC.pname.title.visible = false;
                                    avt.objData.title = null;
                                    ui.mcPopup.mcTitleBoard.btnText.text = "Equip";
                                };
                            };
                            break;
                        case "updateRebirth":
                            world.myAvatar.objData.intRebirth = resObj.intRebirth;
                            showAchievement("Rebirth", resObj.intRebirth);
                            mixer.playSound("Achievement");
                            break;
                        case "refreshItems":
                            if (ui.mcPopup.currentLabel == "Inventory")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({eventType: "refreshCoins"});
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                            eventType: "refreshItems",
                                            sInstruction: "closeWindows"
                                        });
                            };
                            break;
                        case "sendLinkedItems":
                            if (resObj.bitSuccess)
                            {
                                i = 0;
                                while (i < resObj.items.length)
                                {
                                    iobj = copyObj(resObj.items[i]);
                                    world.linkTree[iobj.CharItemID] = copyObj(iobj);
                                    i = (i + 1);
                                };
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = resObj.strMessage;
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            }
                            break;
                        case "updateGoldCoins":
                            if ("intGold" in resObj)
                            {
                                world.myAvatar.objData.intGold = Number(resObj.intGold);
                                ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                            };
                            if ("intCoins" in resObj)
                            {
                                world.myAvatar.objData.intCoins = Number(resObj.intCoins);
                                // ui.mcInterface.mcGold.strCoins.text = world.myAvatar.objData.intCoins;
                            };
                            if ("intCrystal" in resObj)
                            {
                                world.myAvatar.objData.intCrystal = Number(resObj.intCrystal);
                            };
                            if ("intUpgradeDays" in resObj)
                            {
                                world.myAvatar.objData.iUpgDays = Number(resObj.intUpgradeDays);
                                if (resObj.intUpgradeDays > 0)
                                {
                                    avt = world.getAvatarByUserName(world.myAvatar.objData.strUsername);
                                    avt.objData.iUpgDays = resObj.intUpgradeDays;
                                    avt.objData.iUpg = 1;
                                    avt.initAvatar({data: avt.objData});
                                };
                            };
                            if (ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                            };
                            if (ui.mcPopup.currentLabel == "MergeShop" || ui.mcPopup.currentLabel == "Shop")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshCoins"});
                            };
                            mixer.playSound("Coins");
                            break;
                        case "balance":
                            if (resObj.intExp != null)
                            {
                                world.myAvatar.objData.intExp = resObj.intExp;
                                updateXPBar();
                            };
                            if (resObj.intGold != null)
                            {
                                world.myAvatar.objData.intGold = resObj.intGold;
                                ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                };
                            };
                            if (resObj.intCoins != null)
                            {
                                world.myAvatar.objData.intCoins = resObj.intCoins;
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                };
                            };
                            break;
                        case "addGoldExp":
                            if (((!(resObj.intExp == null)) && (resObj.intExp > 0)))
                            {
                                if (bAnalyzer)
                                {
                                    if (!bAnalyzer.isRunning())
                                    {
                                        return;
                                    };
                                    bAnalyzer.addExp(resObj.intExp);
                                };
                                deltaXP = resObj.intExp;
                                world.myAvatar.objData.intExp = (world.myAvatar.objData.intExp + deltaXP);
                                updateXPBar();
                                xp = new xpDisplay();
                                xp.t.ti.text = (deltaXP + " xp");
                                xpB = null;
                                if (("bonusExp" in resObj))
                                {
                                    xpB = new xpDisplayBonus();
                                    xpB.t.ti.text = String((("+ " + resObj.bonusExp) + " xp!"));
                                    xp.t.ti.text = ((deltaXP - resObj.bonusExp) + " xp");
                                };
                                if (((!(resObj.typ == null)) && (resObj.typ == "m")))
                                {
                                    Mon = world.getMonster(resObj.id);
                                    xp.x = Mon.pMC.mcChar.x;
                                    xp.y = (Mon.pMC.mcChar.y - 40);
                                    Mon.pMC.addChild(xp);
                                    if (xpB != null)
                                    {
                                        xpB.x = xp.x;
                                        xpB.y = xp.y;
                                        Mon.pMC.addChild(xpB);
                                    };
                                }
                                else
                                {
                                    xp.x = world.myAvatar.pMC.mcChar.x;
                                    xp.y = (world.myAvatar.pMC.pname.y + 10);
                                    world.myAvatar.pMC.addChild(xp);
                                    if (xpB != null)
                                    {
                                        xpB.x = xp.x;
                                        xpB.y = xp.y;
                                        world.myAvatar.pMC.addChild(xpB);
                                    };
                                };
                            };
                            if (((!(resObj.intGold == null)) && (resObj.intGold > 0)))
                            {
                                if (bAnalyzer)
                                {
                                    if (!bAnalyzer.isRunning())
                                    {
                                        return;
                                    };
                                    bAnalyzer.addGold(resObj.intGold);
                                };
                                mixer.playSound("Coins");
                                deltaGold = resObj.intGold;
                                world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold + resObj.intGold);
                                ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                };
                                gold = new goldDisplay();
                                gold.t.ti.text = (deltaGold + " g");
                                gold.tMask.ti.text = (deltaGold + " g");
                                if (((!(resObj.typ == null)) && (resObj.typ == "m")))
                                {
                                    Mon = world.getMonster(resObj.id);
                                    gold.x = Mon.pMC.mcChar.x;
                                    gold.y = (Mon.pMC.mcChar.y - 20);
                                    Mon.pMC.addChild(gold);
                                }
                                else
                                {
                                    gold.x = world.myAvatar.pMC.mcChar.x;
                                    gold.y = (world.myAvatar.pMC.pname.y - 30);
                                    world.myAvatar.pMC.addChild(gold);
                                };
                            };
                            if (((!(resObj.intCoins == null)) && (resObj.intCoins > 0)))
                            {
                                mixer.playSound("Coins");
                                deltaCoin = resObj.intCoins;
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins + resObj.intCoins);
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                };
                                coin = new coinDisplay();
                                coin.t.ti.text = (deltaCoin + " c");
                                coin.tMask.ti.text = (deltaCoin + " c");
                                if (((!(resObj.typ == null)) && (resObj.typ == "m")))
                                {
                                    Mon = world.getMonster(resObj.id);
                                    coin.x = Mon.pMC.mcChar.x;
                                    coin.y = (Mon.pMC.mcChar.y - 50);
                                    Mon.pMC.addChild(coin);
                                }
                                else
                                {
                                    coin.x = world.myAvatar.pMC.mcChar.x;
                                    coin.y = (world.myAvatar.pMC.pname.y - 60);
                                    world.myAvatar.pMC.addChild(coin);
                                };
                            };
                            if (resObj.iCP != null)
                            {
                                deltaCP = resObj.iCP;
                                world.myAvatar.objData.iCP = (world.myAvatar.objData.iCP + deltaCP);
                                world.myAvatar.updateArmorRep();
                                iRank = world.myAvatar.objData.iRank;
                                world.myAvatar.updateRep();
                                if (iRank != world.myAvatar.objData.iRank)
                                {
                                    world.myAvatar.rankUp(world.myAvatar.objData.strClassName, world.myAvatar.objData.iRank);
                                    FB_showFeedDialog("Rank Up!", (((("reached Rank " + world.myAvatar.objData.iRank) + " ") + world.myAvatar.objData.strClassName) + " in AQWorlds!"), "aqw-rankup.jpg");
                                };
                                txtBonusCP = "";
                                if (resObj.bonusCP == null)
                                {
                                    resObj.bonusCP = 0;
                                }
                                else
                                {
                                    txtBonusCP = ((" + " + resObj.bonusCP) + "(Bonus)");
                                };
                                chatF.pushMsg("server", ((((("Class Points for " + world.myAvatar.objData.strClassName) + " increased by ") + (deltaCP - resObj.bonusCP)) + txtBonusCP) + "."), "SERVER", "", 0);
                            };
                            if (resObj.FactionID != null)
                            {
                                if (resObj.bonusRep == null)
                                {
                                    resObj.bonusRep = 0;
                                };
                                world.myAvatar.addRep(resObj.FactionID, resObj.iRep, resObj.bonusRep);
                            };

                            break;
                        case "levelUp":
                            world.myAvatar.objData.intLevel = resObj.intLevel;
                            world.myAvatar.objData.intExpToLevel = resObj.intExpToLevel;
                            // world.myAvatar.objData.intExp = resObj.xp;
                            world.myAvatar.objData.intExp = 0;
                            updateXPBar();
                            showPortraitBox(world.myAvatar, ui.mcPortrait);
                            world.myAvatar.levelUp();
                            if (("updatePStats" in world.map))
                            {
                                world.map.updatePStats();
                            };

                            break;
                        case "loadInventoryBig":
                            trace("loadInventoryBig");
                            world.myAvatar.iBankCount = int(resObj.bankCount);
                            world.addItemsToBank(resObj.items);
                            world.myAvatar.initInventory(resObj.items);
                            world.initHouseInventory({
                                        "sHouseInfo": world.myAvatar.objData.sHouseInfo,
                                        "items": resObj.hitems
                                    });
                            world.myAvatar.initFactions(resObj.factions);
                            world.myAvatar.initGuild(resObj.guild);
                            world.uiLock = false;
                            world.myAvatar.invLoaded = true;
                            try
                            {
                                if (("eventTrigger" in MovieClip(world.map)))
                                {
                                    world.map.eventTrigger({"cmd": "userLoaded"});
                                };
                            }
                            catch (e)
                            {
                            };
                            world.myAvatar.checkItemAnimation();
                            adShown = false;
                            testDate = new Date();
                            if (!FacebookConnect.isLoggedIn)
                            {
                            };
                            if (((world.myAvatar.objData.iUpg < 1) && (!(world.map.noPopup == true))))
                            {
                                testDate.setDate((testDate.getDate() - 3));
                                if ((((world.myAvatar.objData.dCreated > testDate) && (world.myAvatar.objData.intHits > 1)) && (Math.random() < 0.2)))
                                {
                                    adShown = true;
                                    world.loadMovieFront("interface/DragonHeroOffer-28Feb13.swf", "Inline Asset");
                                };
                            };
                            if ((((world.myAvatar.objData.intActivationFlag == 1) && (world.myAvatar.objData.intHits < 16)) && (!(world.map.noPopup == true))))
                            {
                                if (((world.myAvatar.objData.intHits == 5) || (world.myAvatar.objData.intHits == 15)))
                                {
                                    world.loadMovieFront("interface/ConfirmedEmailPopup.swf", "Inline Asset");
                                };
                            };

                            break;
                        case "friends":
                            world.myAvatar.initFriendsList(resObj.friends);
                            if (resObj.showList)
                            {
                                flo = {};
                                flo.typ = "userListFriends";
                                for each (friend in world.myAvatar.friends)
                                {
                                    friend.bOffline = ((friend.sServer == objServerInfo.sName) ? 0 : ((friend.sServer == "Offline") ? 2 : 1));
                                };
                                world.myAvatar.friends.sortOn("sName", Array.CASEINSENSITIVE);
                                world.myAvatar.friends.sortOn(["bOffline", "sServer", "sName"], [Array.NUMERIC, Array.CASEINSENSITIVE, Array.CASEINSENSITIVE]);
                                flo.ul = world.myAvatar.friends;
                                ui.mcOFrame.fOpenWith(flo);
                                mcO.fClose();
                            };
                            break;
                        case "initInventory":
                            world.myAvatar.initInventory(resObj.items);
                            if (("eventTrigger" in MovieClip(world.map)))
                            {
                                world.map.eventTrigger({"cmd": "userLoaded"});
                            };
                            break;
                        case "loadHouseInventory":
                            world.initHouseInventory(resObj);
                            break;
                        case "house":
                            MsgBox.notify(resObj.msg);
                            break;
                        case "buyBagSlots":
                            world.dispatchEvent(new Event("buyBagSlots"));
                            if (resObj.bitSuccess == 1)
                            {
                                mixer.playSound("Heal");
                                world.myAvatar.objData.iBagSlots = (world.myAvatar.objData.iBagSlots + Number(resObj.iSlots));
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - (Number(resObj.iSlots) * iSlotCost));
                                MsgBox.notify((("You now have " + world.myAvatar.objData.iBagSlots) + " inventory spaces!"));
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshSlots"});
                                };
                                if (((ui.mcPopup.currentLabel == "Shop") || (ui.mcPopup.currentLabel == "HouseShop")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshSlots"});
                                };
                            };
                            break;
                        case "buyBankSlots":
                            world.dispatchEvent(new Event("buyBankSlots"));
                            if (resObj.bitSuccess == 1)
                            {
                                mixer.playSound("Heal");
                                world.myAvatar.objData.iBankSlots = (world.myAvatar.objData.iBankSlots + Number(resObj.iSlots));
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - (Number(resObj.iSlots) * iSlotCost));
                                MsgBox.notify((("You now have " + world.myAvatar.objData.iBankSlots) + " bank spaces!"));
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshSlots"});
                                };
                                if (((ui.mcPopup.currentLabel == "Shop") || (ui.mcPopup.currentLabel == "HouseShop")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshSlots"});
                                };
                            };
                            break;
                        case "buyHouseSlots":
                            world.dispatchEvent(new Event("buyHouseSlots"));
                            if (resObj.bitSuccess == 1)
                            {
                                mixer.playSound("Heal");
                                world.myAvatar.objData.iHouseSlots = (world.myAvatar.objData.iHouseSlots + Number(resObj.iSlots));
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - (Number(resObj.iSlots) * iSlotCost));
                                MsgBox.notify((("You now have " + world.myAvatar.objData.iHouseSlots) + " house inventory spaces!"));
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshSlots"});
                                };
                                if (((ui.mcPopup.currentLabel == "Shop") || (ui.mcPopup.currentLabel == "HouseShop")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshSlots"});
                                };
                            };
                            break;
                        case "callfct":
                            try
                            {
                                fct = world.map[resObj.fctNam];
                                (fct(resObj.fctParams));
                            }
                            catch (e)
                            {
                                trace(e);
                            };
                            break;
                        case "genderSwap":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!(avt == null)) && (avt.bitData)))
                            {
                                if (resObj.bitSuccess == 1)
                                {
                                    if (avt.isMyAvatar)
                                    {
                                        MsgBox.notify("Your gender has been successfully changed.");
                                        avt.objData.intCoins = (avt.objData.intCoins - resObj.intCoins);
                                    };
                                    avt.objData.strGender = resObj.gender;
                                    avt.objData.HairID = resObj.HairID;
                                    avt.objData.strHairName = resObj.strHairName;
                                    avt.objData.strHairFilename = resObj.strHairFilename;
                                    avt.initAvatar({"data": avt.objData});
                                };
                            };
                            break;
                        case "loadBank":
                            if (resObj.bitSuccess)
                            {
                                if (((!(resObj.items == null)) && (!(resObj.items == "undefined"))))
                                {
                                    world.addItemsToBank(resObj.items);
                                };
                                if (ui.mcPopup.currentLabel == "Bank")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType": "refreshBank"});
                                };
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = "Error loading bank items!  Try logging out and back in to fix this problem.";
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "bankFromInv":
                            if ((("bSuccess" in resObj) && (resObj.bSuccess == 1)))
                            {
                                world.myAvatar.bankFromInv(resObj.ItemID);
                                world.checkAllQuestStatus();
                                if (((ui.mcPopup.currentLabel == "Bank") || (ui.mcPopup.currentLabel == "HouseBank")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType": "refreshItems"});
                                };
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                                };
                            }
                            else
                            {
                                modal = new ModalMC();
                                modalO = {};
                                modalO.strBody = resObj.msg;
                                modalO.params = {};
                                modalO.glow = "red,medium";
                                modalO.btns = "mono";
                                ui.ModalStack.addChild(modal);
                                modal.init(modalO);
                            };
                            break;
                        case "bankToInv":
                            world.myAvatar.bankToInv(resObj.ItemID);
                            world.checkAllQuestStatus();
                            if (((ui.mcPopup.currentLabel == "Bank") || (ui.mcPopup.currentLabel == "HouseBank")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType": "refreshItems"});
                            };
                            if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                            };
                            break;
                        case "bankSwapInv":
                            world.myAvatar.bankSwapInv(resObj.invItemID, resObj.bankItemID);
                            world.checkAllQuestStatus();
                            if (((ui.mcPopup.currentLabel == "Bank") || (ui.mcPopup.currentLabel == "HouseBank")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcBank")).update({"eventType": "refreshItems"});
                            };
                            if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                            };
                            break;
                        case "loadShop":
                            if ((((((!(world.shopinfo == null)) && ("ShopID" in world.shopinfo)) && (world.shopinfo.ShopID == resObj.shopinfo.ShopID)) && ("bLimited" in world.shopinfo)) && (world.shopinfo.bLimited)))
                            {
                                trace(" >>>> Shop reload detected");
                                i = 0;
                                while (i < resObj.shopinfo.items.length)
                                {
                                    world.shopinfo.items.push(resObj.shopinfo.items[i]);
                                    world.shopinfo.items.shift();
                                    i = (i + 1);
                                };
                                if (((ui.mcPopup.currentLabel == "Shop") || (ui.mcPopup.currentLabel == "HouseShop")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshItems"});
                                }
                                else
                                {
                                    ui.mcPopup.fOpen("Shop");
                                };
                            }
                            else
                            {
                                world.shopinfo = resObj.shopinfo;
                                if (resObj.shopinfo.bHouse == 1)
                                {
                                    trace("House Shop");
                                    ui.mcPopup.fOpen("HouseShop");
                                }
                                else
                                {
                                    if (isMergeShop(resObj.shopinfo))
                                    {
                                        ui.mcPopup.fOpen("MergeShop");
                                    }
                                    else
                                    {
                                        ui.mcPopup.fOpen("Shop");
                                    };
                                };
                            };
                            break;
                        case "loadEnhShop":
                            world.enhShopID = resObj.shopinfo.ShopID;
                            world.enhShopItems = resObj.shopinfo.items;
                            ui.mcPopup.fOpen("EnhShop");
                            break;
                        case "enhanceItemShop":
                            if (resObj.iCost != null)
                            {
                                if (("bCoins" in resObj) && (resObj.bCoins))
                                {
                                    world.myAvatar.objData.intCoins = world.myAvatar.objData.intCoins - Number(resObj.iCost);
                                }
                                else if (("bCrystal" in resObj) && (resObj.bCrystal))
                                {
                                    world.myAvatar.objData.intCrystal = world.myAvatar.objData.intCrystal - Number(resObj.iCost);
                                }
                                else
                                {
                                    world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold - Number(resObj.iCost));
                                    ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                                };
                                if (ui.mcPopup.currentLabel == "Inventory")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                };
                                if (ui.mcPopup.currentLabel == "Shop")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshCoins"});
                                };
                            };
                            iSel = null;
                            eSel = null;
                            for each (o in world.myAvatar.items)
                            {
                                if (o.ItemID == resObj.ItemID)
                                {
                                    iSel = o;
                                };
                            };
                            iSel.iEnh = resObj.EnhID;
                            iSel.EnhID = resObj.EnhID;
                            iSel.EnhPatternID = resObj.EnhPID;
                            iSel.EnhLvl = resObj.EnhLvl;
                            iSel.EnhDPS = resObj.EnhDPS;
                            iSel.EnhRng = resObj.EnhRng;
                            iSel.EnhRty = resObj.EnhRty;
                            iSel.ProcID = resObj.ProcID;
                            mixer.playSound("Good");
                            if (ui.mcPopup.currentLabel == "Inventory")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                            "eventType": "refreshItems",
                                            "sInstruction": "previewEquipOnly"
                                        });
                            };
                            if (ui.mcPopup.currentLabel == "Shop")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                            "eventType": "refreshItems",
                                            "sInstruction": "closeWindows"
                                        });
                            };
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (((((("You have upgraded <b>" + iSel.sName) + "</b> with <b>") + resObj.EnhName) + "</b>, level <b>") + resObj.EnhLvl) + "</b>!");
                            modalO.params = {};
                            modalO.glow = "white,medium";
                            modalO.btns = "mono";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            break;
                        case "enhanceItemLocal":
                            iSel = null;
                            eSel = null;
                            for each (o in world.myAvatar.items)
                            {
                                if (o.ItemID == resObj.ItemID)
                                {
                                    iSel = o;
                                };
                            };
                            iSel.iEnh = resObj.EnhID;
                            iSel.EnhID = resObj.EnhID;
                            iSel.EnhPatternID = resObj.EnhPID;
                            iSel.EnhLvl = resObj.EnhLvl;
                            iSel.EnhDPS = resObj.EnhDPS;
                            iSel.EnhRng = resObj.EnhRng;
                            iSel.EnhRty = resObj.EnhRty;
                            iSel.ProcID = resObj.ProcID;
                            mixer.playSound("Good");
                            if (ui.mcPopup.currentLabel == "Inventory")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                            "eventType": "refreshItems",
                                            "sInstruction": "previewEquipOnly"
                                        });
                            };
                            if (ui.mcPopup.currentLabel == "Shop")
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                            "eventType": "refreshItems",
                                            "sInstruction": "closeWindows"
                                        });
                            };
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (((((("You have upgraded " + iSel.sName) + " with ") + resObj.EnhName) + ", level ") + resObj.EnhLvl) + "!");
                            modalO.params = {};
                            modalO.glow = "white,medium";
                            modalO.btns = "mono";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            break;
                        case "loadHairShop":
                            world.hairshopinfo = resObj;
                            openCharacterCustomize();
                            break;
                        case "buyItem":
                            if (resObj.bitSuccess == 0)
                            {
                                if ((("bSoldOut" in resObj) && (resObj.bSoldOut)))
                                {
                                    if (world.shopinfo.bLimited)
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                                    "eventType": "refreshShop",
                                                    "sInstruction": "closeWindows"
                                                });
                                    };
                                    modal = new ModalMC();
                                    modalO = {};
                                    modalO.strBody = (resObj.strMessage + " is no longer in stock.");
                                    modalO.params = {};
                                    modalO.glow = "red,medium";
                                    modalO.btns = "mono";
                                    ui.ModalStack.addChild(modal);
                                    modal.init(modalO);
                                }
                                else
                                {
                                    if (resObj.strMessage != null)
                                    {
                                        MsgBox.notify(resObj.strMessage);
                                    };
                                };
                            }
                            else
                            {
                                item = copyObj(world.shopBuyItem);
                                item.CharItemID = resObj.CharItemID;
                                item.bBank = resObj.bBank;
                                if (item.bCoins == 1)
                                {
                                    item.iHrs = 0;
                                    world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins - Number(item.iCost));
                                }
                                else if (item.bCrystal == 1)
                                {
                                    item.iHrs = 0;
                                    world.myAvatar.objData.intCrystal = (world.myAvatar.objData.intCrystal - Number(item.iCost));
                                }
                                else
                                {
                                    world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold - Number(item.iCost));
                                    ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                                    if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                    };
                                };
                                showItemDrop(item, false);
                                if (world.invTree[item.ItemID] == null)
                                {
                                    world.invTree[item.ItemID] = copyObj(resObj);
                                    world.invTree[item.ItemID].iQty = 0;
                                };
                                world.myAvatar.addItem(item);
                                if (item.bHouse == 1)
                                {
                                    if (((item.sType == "House") && (!(world.isHouseEquipped()))))
                                    {
                                        world.sendEquipItemRequest(item);
                                        world.myAvatar.getItemByID(item.ItemID).bEquip = 1;
                                    };
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshCoins"});
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                                "eventType": "refreshItems",
                                                "sInstruction": "closeWindows"
                                            });
                                    if (world.shopinfo.bLimited)
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshShop"});
                                    };
                                    if (ui.mcPopup.currentLabel == "HouseInventory")
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                                    "eventType": "refreshItems",
                                                    "sInstruction": "closeWindows"
                                                });
                                    };
                                }
                                else
                                {
                                    if (ui.mcPopup.currentLabel == "Shop")
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshCoins"});
                                        MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                                    "eventType": "refreshItems",
                                                    "sInstruction": "closeWindows"
                                                });
                                        if (world.shopinfo.bLimited)
                                        {
                                            MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshShop"});
                                        };
                                    }
                                    else
                                    {
                                        if (ui.mcPopup.currentLabel == "MergeShop")
                                        {
                                            MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshCoins"});
                                            MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshItems"});
                                        }
                                        else
                                        {
                                            if (ui.mcPopup.currentLabel == "Inventory")
                                            {
                                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                                            "eventType": "refreshItems",
                                                            "sInstruction": "closeWindows"
                                                        });
                                            };
                                        };
                                    };
                                };
                                world.updateQuestProgress("item", item);
                            };
                            break;
                        case "sellItem":
                            world.myAvatar.removeItem(resObj.CharItemID);
                            if (resObj.bCrystal == 1)
                            {
                                world.myAvatar.objData.intCrystal = (world.myAvatar.objData.intCrystal + resObj.intAmount);
                            }
                            else if (resObj.bCoins == 1)
                            {
                                world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins + resObj.intAmount);
                            }
                            else
                            {
                                world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold + resObj.intAmount);
                                ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                            };
                            if (((ui.mcPopup.currentLabel == "Shop") || (ui.mcPopup.currentLabel == "HouseShop")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshCoins"});
                                MovieClip(ui.mcPopup.getChildByName("mcShop")).update({
                                            "eventType": "refreshItems",
                                            "sInstruction": "closeWindows"
                                        });
                            }
                            else
                            {
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({
                                                "eventType": "refreshItems",
                                                "sInstruction": "closeWindows"
                                            });
                                };
                            };
                            world.checkAllQuestStatus();
                            break;
                        case "removeItem":
                            if (resObj.iQty != null)
                            {
                                world.myAvatar.removeItem(resObj.CharItemID, resObj.iQty);
                            }
                            else
                            {
                                world.myAvatar.removeItem(resObj.CharItemID);
                            };
                            if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                            };
                            world.checkAllQuestStatus();
                            break;
                        case "updateClass":
                            isNewClass = true;
                            statsNewClass = true;
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (((!(avt == null)) && (!(avt.objData == null))))
                            {
                                avt.objData.strClassName = resObj.sClassName;
                                avt.objData.iCP = resObj.iCP;
                                avt.objData.sClassCat = resObj.sClassCat;
                                avt.updateRep();
                                if (resObj.uid == sfc.myUserId)
                                {
                                    if (("sDesc" in resObj))
                                    {
                                        avt.objData.sClassDesc = resObj.sDesc;
                                    };
                                    if (("sStats" in resObj))
                                    {
                                        avt.objData.sClassStats = resObj.sStats;
                                    };
                                    if (("aMRM" in resObj))
                                    {
                                        avt.objData.aClassMRM = resObj.aMRM;
                                    };
                                };
                            };

                            break;
                        case "equipItem":
                            avt = world.getAvatarByUserID(resObj.uid);
                            tLeaf = world.getUoLeafById(resObj.uid);
                            if (avt != null)
                            {
                                if (((!(avt.pMC == null)) && (!(avt.objData == null))))
                                {
                                    avt.objData.eqp[resObj.strES] = {};
                                    avt.objData.eqp[resObj.strES].sFile = ((resObj.sFile == "undefined") ? "" : resObj.sFile);
                                    avt.objData.eqp[resObj.strES].sLink = resObj.sLink;
                                    if (("sType" in resObj))
                                    {
                                        avt.objData.eqp[resObj.strES].sType = resObj.sType;
                                    };
                                    if (("ItemID" in resObj))
                                    {
                                        avt.objData.eqp[resObj.strES].ItemID = resObj.ItemID;
                                    };
                                    if (("sMeta" in resObj))
                                    {
                                        avt.objData.eqp[resObj.strES].sMeta = resObj.sMeta;
                                    };
                                    avt.loadMovieAtES(resObj.strES, resObj.sFile, resObj.sLink);
                                };
                                if (avt.isMyAvatar)
                                {
                                    avt.equipItem(resObj.ItemID);
                                    if (MovieClip(ui.mcPopup.getChildByName("mcInventory")) != null)
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                                    };
                                    if (ui.mcPopup.mcTempInventory != null)
                                    {
                                        ui.mcPopup.mcTempInventory.mcItemList.refreshList();
                                        ui.mcPopup.mcTempInventory.refreshDetail();
                                    };
                                };
                            };
                            break;
                        case "unequipItem":
                            avt = world.getAvatarByUserID(resObj.uid);
                            if (avt != null)
                            {
                                if (avt.pMC != null)
                                {
                                    delete avt.objData.eqp[resObj.strES];
                                    avt.unloadMovieAtES(resObj.strES);
                                };
                                if (avt.isMyAvatar)
                                {
                                    avt.unequipItem(resObj.ItemID);
                                    if (ui.mcPopup.currentLabel == "Inventory")
                                    {
                                        MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                                    };
                                    if (ui.mcPopup.mcTempInventory != null)
                                    {
                                        ui.mcPopup.mcTempInventory.mcItemList.refreshList();
                                        ui.mcPopup.mcTempInventory.refreshDetail();
                                    };
                                };
                            };
                            break;
                        case "dropItem":
                            for (dID in resObj.items)
                            {
                                dItem = null;
                                if (world.invTree[dID] == null)
                                {
                                    world.invTree[dID] = copyObj(resObj.items[dID]);
                                    world.invTree[dID].iQty = 0;
                                    dItem = resObj.items[dID];
                                }
                                else
                                {
                                    dItem = copyObj(world.invTree[dID]);
                                    for (iData in resObj.items[dID])
                                    {
                                        if (resObj.items[dID][iData] != dItem[iData])
                                        {
                                            dItem[iData] = resObj.items[dID][iData];
                                            if (iData != "iQty")
                                            {
                                                world.invTree[dID][iData] = resObj.items[dID][iData];
                                            };
                                        };
                                    };
                                };
                                if (resObj.Wheel != null)
                                {
                                    try
                                    {
                                        world.map.doWheelDrop(dItem);
                                    }
                                    catch (e)
                                    {
                                    };
                                }
                                else
                                {
                                    dItem.dID = dID;
                                    dItem.dQty = int(resObj.items[dID].iQty);
                                    isOK = true;
                                    if (litePreference.data.blackList)
                                    {
                                        for each (bItem in litePreference.data.blackList)
                                        {
                                            if (isNaN(parseInt(bItem.value)))
                                            {
                                                litePreference.data.blackList.splice(litePreference.data.blackList.indexOf(bItem.value), 1);
                                            }
                                            else
                                            {
                                                if (dItem.ItemID == parseInt(bItem.value))
                                                {
                                                    isOK = false;
                                                };
                                            };
                                        };
                                        litePreference.flush();
                                    };
                                    if (isOK)
                                    {
                                        showItemDrop(dItem, true);
                                    };
                                };
                            };
                            break;
                        case "referralReward":
                            for (dID in resObj.items)
                            {
                                dItem = null;
                                if (world.invTree[dID] == null)
                                {
                                    world.invTree[dID] = copyObj(resObj.items[dID]);
                                    world.invTree[dID].iQty = 0;
                                    dItem = resObj.items[dID];
                                }
                                else
                                {
                                    dItem = copyObj(world.invTree[dID]);
                                    dItem.iQty = int(resObj.items[dID].iQty);
                                };
                            };
                            dropItem = new DFrameMC(dItem);
                            ui.dropStack.addChild(dropItem);
                            dropItem.init();
                            dropItem.fY = (dropItem.y = -(dropItem.fHeight + 8));
                            dropItem.fX = (dropItem.x = -(dropItem.fWidth / 2));
                            cleanDropStack();
                            break;
                        case "getDrop":
                            i = 0;
                            while (i < ui.dropStack.numChildren)
                            {
                                mc = (ui.dropStack.getChildAt(i) as MovieClip);
                                if (((!(mc.fData == null)) && (mc.fData.ItemID == resObj.ItemID)))
                                {
                                    if (resObj.bSuccess == 1)
                                    {
                                        mc.gotoAndPlay("out");
                                    }
                                    else
                                    {
                                        modal = new ModalMC();
                                        modalO = {};
                                        modalO.strBody = "Item could not be added to your inventory! Please make sure your inventory is not full or the item is already present in your inventory/bank.";
                                        modalO.params = {};
                                        modalO.glow = "red,medium";
                                        modalO.btns = "mono";
                                        ui.ModalStack.addChild(modal);
                                        modal.init(modalO);
                                        mc.cnt.ybtn.mouseEnabled = true;
                                        mc.cnt.ybtn.mouseChildren = true;
                                    };
                                };
                                i = (i + 1);
                            };
                            if (resObj.bSuccess == 1)
                            {
                                dropitem = copyObj(world.invTree[resObj.ItemID]);
                                dropitem.CharItemID = resObj.CharItemID;
                                dropitem.bBank = resObj.bBank;
                                dropitem.iQty = int(resObj.iQty);
                                dropitem.iQtyNow = int(resObj.iQtyNow);
                                if (resObj.EnhID != null)
                                {
                                    dropitem.EnhID = int(resObj.EnhID);
                                    dropitem.EnhLvl = int(resObj.EnhLvl);
                                    dropitem.EnhPatternID = int(resObj.EnhPatternID);
                                    dropitem.EnhRty = int(resObj.EnhRty);
                                };
                                world.myAvatar.addItem(dropitem);
                                world.updateQuestProgress("item", dropitem);
                                if (resObj.showDrop == 1)
                                {
                                    showItemDrop(dropitem, false);
                                };
                                if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                                };
                                if ((((ui.mcPopup.currentLabel == "HouseShop") || (ui.mcPopup.currentLabel == "Shop")) || (ui.mcPopup.currentLabel == "MergeShop")))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshItems"});
                                };
                                if (resObj.pendingID != null)
                                {
                                    world.myAvatar.updatePending(int(resObj.pendingID));
                                };
                                if (((cDropsUI) && (litePreference.data.bCustomDrops)))
                                {
                                    cDropsUI.acceptDrop(dropitem);
                                };
                            };
                            break;
                        case "addItems":
                            for (ItemID in resObj.items)
                            {
                                if (world.invTree[ItemID] == null)
                                {
                                    itemObj = copyObj(resObj.items[ItemID]);
                                }
                                else
                                {
                                    itemObj = copyObj(world.invTree[ItemID]);
                                    itemObj.iQty = int(resObj.items[ItemID].iQty);
                                };
                                showItemDrop(itemObj, true);
                                world.myAvatar.addTempItem(itemObj);
                                world.updateQuestProgress("item", itemObj);
                                if (itemObj.sMeta == "doUpdate")
                                {
                                    try
                                    {
                                        world.map.doUpdate();
                                    }
                                    catch (e)
                                    {
                                    };
                                };
                            };
                            break;
                        case "liveDrop":
                            if (resObj.Item != null)
                            {
                                item = copyObj(resObj.Item);
                                item.CharItemID = resObj.CharItemID;
                                item.bBank = resObj.bBank;
                                item.iQty = int(resObj.iQty);
                                if (resObj.EnhID != null)
                                {
                                    item.EnhID = int(resObj.EnhID);
                                    item.EnhLvl = int(resObj.EnhLvl);
                                    item.EnhPatternID = int(resObj.EnhPatternID);
                                    item.EnhRty = int(resObj.EnhRty);
                                };
                                showItemDrop(item, false);
                                world.myAvatar.addItem(item);
                                world.updateQuestProgress("item", item);
                                if (ui.mcPopup.currentLabel == "Inventory" || ui.mcPopup.currentLabel == "HouseInventory")
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                                };
                                if ((ui.mcPopup.currentLabel == "Shop") || (ui.mcPopup.currentLabel == "MergeShop"))
                                {
                                    MovieClip(ui.mcPopup.getChildByName("mcShop")).update({"eventType": "refreshItems"});
                                };
                            }
                            break;
                        case "Wheel":
                            dropItem = copyObj(resObj.dropItems["661"]);
                            dropItem.CharItemID = resObj.charItem1;
                            if (world.invTree["661"] == null)
                            {
                                dropItem.bBank = 0;
                            };
                            trace(("dropQty: " + resObj.dropQty));
                            dropItem.iQty = ((resObj.dropQty != null) ? Number(resObj.dropQty) : 1);
                            world.myAvatar.addItem(dropItem);
                            dropItem = copyObj(resObj.dropItems["660"]);
                            dropItem.CharItemID = resObj.charItem2;
                            if (world.invTree["660"] == null)
                            {
                                dropItem.bBank = 0;
                            };
                            dropItem.iQty = 1;
                            world.myAvatar.addItem(dropItem);
                            if (resObj.Item != null)
                            {
                                dropItem = copyObj(resObj.Item);
                                dropItem.CharItemID = resObj.CharItemID;
                                dropItem.bBank = 0;
                                dropItem.iQty = 1;
                                world.myAvatar.addItem(dropItem);
                            };
                            if (((ui.mcPopup.currentLabel == "Inventory") || (ui.mcPopup.currentLabel == "HouseInventory")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                            };
                            try
                            {
                                world.map.doWheelDrop(resObj.Item, resObj.dropQty);
                            }
                            catch (e)
                            {
                                trace(("error in wheel function: " + e));
                            };
                        case "powerGem":
                            for (ItemID in resObj.items)
                            {
                                if (world.invTree[ItemID] == null)
                                {
                                    itemObj = copyObj(resObj.items[ItemID]);
                                }
                                else
                                {
                                    itemObj = copyObj(world.invTree[ItemID]);
                                    itemObj.iQty = int(resObj.items[ItemID].iQty);
                                };
                                showItemDrop(itemObj, false);
                                world.myAvatar.addItem(itemObj);
                            };
                            break;
                        case "forceAddItem":
                            for (fi in resObj.items)
                            {
                                iobj = copyObj(resObj.items[fi]);
                                world.myAvatar.addItem(iobj);
                            };
                            break;
                        case "warvalues":
                            world.map.updateWarValues(resObj.wars);
                            break;
                        case "turnIn":
                            if (((!(resObj.sItems == null)) && (resObj.sItems.length >= 3)))
                            {
                                itemArr = resObj.sItems.split(",");
                                dropindex = 0;
                                while (dropindex < itemArr.length)
                                {
                                    dropID = itemArr[dropindex].split(":")[0];
                                    dropQty = int(itemArr[dropindex].split(":")[1]);
                                    if (world.invTree[dropID].bTemp == 0)
                                    {
                                        world.myAvatar.removeItemByID(dropID, dropQty);
                                    }
                                    else
                                    {
                                        world.myAvatar.removeTempItem(dropID, dropQty);
                                    };
                                    dropindex++;
                                };
                            };
                            if (((ui.mcPopup.currentLabel == "HouseInventory") || (ui.mcPopup.currentLabel == "Inventory")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshItems"});
                            };
                            break;
                        case "getQuest":
                            break;
                        case "getQuests":
                            for (qi in resObj.quests)
                            {
                                if (world.questTree[qi] == null)
                                {
                                    o = resObj.quests[qi];
                                    world.questTree[qi] = o;
                                    for (qr in o.oReqd)
                                    {
                                        if (world.invTree[qr] == null)
                                        {
                                            world.invTree[qr] = o.oReqd[qr];
                                            world.invTree[qr].iQty = 0;
                                        };
                                    };
                                    for (qj in o.oItems)
                                    {
                                        if (world.invTree[qj] == null)
                                        {
                                            world.invTree[qj] = o.oItems[qj];
                                            world.invTree[qj].iQty = 0;
                                        };
                                    };
                                    qk = "";
                                    qat = ["itemsS", "itemsC", "itemsR", "itemsrand"];
                                    i = 0;
                                    while (i < qat.length)
                                    {
                                        s = qat[i];
                                        if (o.oRewards[s] != null)
                                        {
                                            for (ri in o.oRewards[s])
                                            {
                                                if (isNaN(ri))
                                                {
                                                    qk = ri.ItemID;
                                                }
                                                else
                                                {
                                                    qk = o.oRewards[s][ri].ItemID;
                                                };
                                                if (world.invTree[qk] == null)
                                                {
                                                    world.invTree[qk] = copyObj(o.oRewards[s][ri]);
                                                    world.invTree[qk].iQty = 0;
                                                };
                                            };
                                        };
                                        i = (i + 1);
                                    };
                                };
                            };
                            if (ui.ModalStack.numChildren > 0)
                            {
                                MovieClip(ui.ModalStack.getChildAt(0)).open();
                            };
                            break;
                        case "getQuests2":
                            for (qi in resObj.quests)
                            {
                                if (world.questTree[qi] == null)
                                {
                                    o = resObj.quests[qi];
                                    world.questTree[qi] = o;
                                    for (qr in o.oReqd)
                                    {
                                        if (world.invTree[qr] == null)
                                        {
                                            world.invTree[qr] = o.oReqd[qr];
                                            world.invTree[qr].iQty = 0;
                                        };
                                    };
                                    for (qj in o.oItems)
                                    {
                                        if (world.invTree[qj] == null)
                                        {
                                            world.invTree[qj] = o.oItems[qj];
                                            world.invTree[qj].iQty = 0;
                                        };
                                    };
                                    qk = "";
                                    qat = ["itemsS", "itemsC", "itemsR", "itemsrand"];
                                    i = 0;
                                    while (i < qat.length)
                                    {
                                        s = qat[i];
                                        if (o.oRewards[s] != null)
                                        {
                                            for (ri in o.oRewards[s])
                                            {
                                                if (isNaN(ri))
                                                {
                                                    qk = ri.ItemID;
                                                }
                                                else
                                                {
                                                    qk = o.oRewards[s][ri].ItemID;
                                                };
                                                if (world.invTree[qk] == null)
                                                {
                                                    world.invTree[qk] = copyObj(o.oRewards[s][ri]);
                                                    world.invTree[qk].iQty = 0;
                                                };
                                            };
                                        };
                                        i = (i + 1);
                                    };
                                };
                            };
                            createApop();
                            break;
                        case "ccqr":
                            if (resObj.bSuccess == 0)
                            {
                                MsgBox.notify("Quest Complete Failed!");
                            }
                            else
                            {
                                if (("eventTrigger" in MovieClip(world.map)))
                                {
                                    world.map.eventTrigger({
                                                "cmd": "questComplete",
                                                "args": resObj.QuestID
                                            });
                                };
                                world.completeQuest(resObj.QuestID);
                                if (ui.ModalStack.numChildren)
                                {
                                    fgWin = ui.ModalStack.getChildAt(0);
                                    if (((!(fgWin == null)) && (fgWin.toString().indexOf("QFrameMC") > -1)))
                                    {
                                        fgWin.turninResult(resObj.QuestID);
                                    };
                                };
                                showQuestpopup(resObj);
                                if (apop_ != null)
                                {
                                    apop_.questComplete(int(resObj.QuestID));
                                };
                                if (world.rootClass.litePreference.data.bReaccept)
                                {
                                    if (world.questTree[resObj.QuestID])
                                    {
                                        if (world.questTree[resObj.QuestID].hasOwnProperty("bOnce"))
                                        {
                                            if (world.questTree[resObj.QuestID].bOnce > 0)
                                            {
                                                break;
                                            };
                                        };
                                        if (getQuestValidationString(world.questTree[resObj.QuestID]) == "")
                                        {
                                            world.acceptQuest(int(resObj.QuestID));
                                        };
                                    };
                                };
                            };
                            break;
                        case "updateQuest":
                            world.setQuestValue(resObj.iIndex, resObj.iValue);
                            break;
                        case "showQuestLink":
                            world.showQuestLink(resObj);
                            break;
                        case "dailylogin":
                            break;
                        case "initMonData":
                            for (m in resObj.mon)
                            {
                                world.updateMonster(resObj.mon[m]);
                            };
                            break;
                        case "aura+":
                        case "aura*":
                        case "aura-":
                        case "aura--":
                        case "aura++":
                        case "aura+p":
                            world.handleAuraEvent(cmd, resObj);
                            break;
                        case "clearAuras":
                            tAvt = world.myAvatar;
                            tLeaf = tAvt.dataLeaf;
                            world.showAuraChange({
                                        "cmd": "aura-",
                                        "auras": tLeaf.auras
                                    }, tAvt, tLeaf);
                            tLeaf.auras = [];
                            break;
                        case "uotls":
                            userTreeWrite(resObj.unm, resObj.o);
                            break;
                        case "mtls":
                            monsterTreeWrite(resObj.id, resObj.o, resObj.targets);
                            break;
                        case "cb":
                            if (resObj.m != null)
                            {
                                for (updateID in resObj.m)
                                {
                                    monsterTreeWrite(int(updateID), resObj.m[updateID]);
                                };
                            };
                            if (resObj.p != null)
                            {
                                for (updateID in resObj.p)
                                {
                                    userTreeWrite(updateID, resObj.p[updateID]);
                                };
                            };
                            if (resObj.anims != null)
                            {
                                if (sfcSocial)
                                {
                                    for each (o in resObj.anims)
                                    {
                                        if (resObj.isProc)
                                        {
                                            doAnim(o, resObj.isProc);
                                        }
                                        else
                                        {
                                            doAnim(o);
                                        };
                                    };
                                };
                            };
                            if (resObj.a != null)
                            {
                                i = 0;
                                while (i < resObj.a.length)
                                {
                                    world.handleAuraEvent(resObj.a[i].cmd, resObj.a[i]);
                                    i = (i + 1);
                                };
                            };
                            break;
                        case "ct":
                            anim = new Object();
                            if (resObj.m != null)
                            {
                                for (updateID in resObj.m)
                                {
                                    monsterTreeWrite(int(updateID), resObj.m[updateID]);
                                };
                            };
                            if (resObj.p != null)
                            {
                                for (updateID in resObj.p)
                                {
                                    userTreeWrite(updateID, resObj.p[updateID]);
                                };
                            };
                            if (resObj.a != null)
                            {
                                j = 0;
                                while (j < resObj.a.length)
                                {
                                    try
                                    {
                                        k = 0;
                                        while (k < resObj.a[j].auras.length)
                                        {
                                            if (resObj.a[j].auras[k].spellOn != null)
                                            {
                                                anim[resObj.a[j].auras[k].spellOn] = resObj.a[j].auras[k].dur;
                                            };
                                            k++;
                                        };
                                    }
                                    catch (e)
                                    {
                                    };
                                    world.handleAuraEvent(resObj.a[j].cmd, resObj.a[j]);
                                    j = (j + 1);
                                };
                            };
                            if (resObj.sara != null)
                            {
                                for each (o in resObj.sara)
                                {
                                    world.handleSAR(o);
                                };
                            };
                            if (resObj.sarsa != null)
                            {
                                for each (o in resObj.sarsa)
                                {
                                    world.handleSARS(o);
                                };
                            };
                            if (resObj.anims != null)
                            {
                                if (sfcSocial)
                                {
                                    for each (o in resObj.anims)
                                    {
                                        trace(anim[o.strl]);
                                        if (resObj.isProc)
                                        {
                                            doAnim(o, resObj.isProc, anim[o.strl]);
                                        }
                                        else
                                        {
                                            doAnim(o, false, anim[o.strl]);
                                        };
                                    };
                                };
                            };
                            if (resObj.pvp != null)
                            {
                                switch (resObj.pvp.cmd)
                                {
                                    case "PVPS":
                                        updatePVPScore(resObj.pvp.pvpScore);
                                        break;
                                    case "PVPC":
                                        world.PVPResults.pvpScore = resObj.pvp.pvpScore;
                                        world.PVPResults.team = resObj.pvp.team;
                                        updatePVPScore(resObj.pvp.pvpScore);
                                        togglePVPPanel("results");
                                        break;
                                };
                            };
                            if (((world.myAvatar.objData.eqp["pe"]) && (world.rootClass.litePreference.data.bBattlepet)))
                            {
                                for each (bpObj in resObj.anims)
                                {
                                    if (((bpObj.tInf.indexOf("m:") > -1) && (bpObj.cInf.indexOf("p:") > -1)))
                                    {
                                        if (world.getAvatarByUserID(Number(bpObj.cInf.split(":")[1])).isMyAvatar)
                                        {
                                            if (bpObj.animStr == world.actions.active[0].anim)
                                            {
                                                world.myAvatar.pMC.queueAnim("PetAttack");
                                            };
                                        };
                                    };
                                };
                            };
                            if (litePreference.data.bAuras)
                            {
                                pAurasUI.handleAura(resObj);
                                tAurasUI.handleAura(resObj);
                            };
                            break;
                        case "sar":
                            world.handleSAR(resObj);
                            break;
                        case "sars":
                            world.handleSARS(resObj);
                            break;
                        case "showAuraResult":
                            world.showAuraImpact(resObj);
                            break;
                        case "anim":
                            if (sfcSocial)
                            {
                                doAnim(resObj);
                            };
                            break;
                        case "sAct":
                            trace(("IS A NEW CLASS? " + isNewClass));
                            if (isNewClass)
                            {
                                world.actions = {};
                                world.actions.active = [];
                                world.actions.passive = [];
                                world.actionMap = [null, null, null, null, null, null];
                                blanki = 0;
                                while (blanki < 6)
                                {
                                    ui.mcInterface.actBar.getChildByName(("blank" + blanki)).visible = true;
                                    actBar = ui.mcInterface.actBar;
                                    delIcon = actBar.getChildByName(("i" + (blanki + 1)));
                                    if (delIcon != null)
                                    {
                                        delIcon.removeEventListener(MouseEvent.CLICK, actIconClick);
                                        delIcon.removeEventListener(MouseEvent.MOUSE_OVER, actIconOver);
                                        delIcon.removeEventListener(MouseEvent.MOUSE_OUT, actIconOut);
                                        if (delIcon.icon2 != null)
                                        {
                                            delIcon.removeEventListener(Event.ENTER_FRAME, world.countDownAct);
                                            if (delIcon.icon2.mask != null)
                                            {
                                                actBar.removeChild(delIcon.icon2.mask);
                                                delIcon.icon2.mask = null;
                                            };
                                            actBar.removeChild(delIcon.icon2);
                                        };
                                        actBar.removeChild(delIcon);
                                    };
                                    ui.mcInterface.actBar.getChildByName(("txtCD" + blanki)).visible = false;
                                    ui.mcInterface.actBar.getChildByName(("txtCD" + blanki)).mouseEnabled = false;
                                    blanki++;
                                };
                            };
                            ai = 0;
                            slot = 0;
                            ai = 0;
                            while (ai < resObj.actions.active.length)
                            {
                                if (!isNewClass)
                                {
                                    isNotUnlocked = (ui.mcInterface.actBar.getChildByName(("i" + (ai + 1))).cnt.transform.colorTransform.toString().indexOf("0.09765625") > -1);
                                    if (((resObj.actions.active[ai].isOK) && (isNotUnlocked)))
                                    {
                                        existing = ui.mcInterface.actBar.getChildByName(("i" + (ai + 1)));
                                        existing.addEventListener(MouseEvent.CLICK, actIconClick, false, 0, true);
                                        existing.buttonMode = true;
                                        existing.cnt.transform.colorTransform = new ColorTransform();
                                        world.getActionByRef(world.actionMap[ai]).isOK = true;
                                    };
                                }
                                else
                                {
                                    actObj = resObj.actions.active[ai];
                                    actObj.sArg1 = "";
                                    actObj.sArg2 = "";
                                    world.actions.active.push(actObj);
                                    actObj.ts = 0;
                                    actObj.actID = -1;
                                    actObj.lock = false;
                                    world.actionMap[ai] = actObj.ref;
                                    actIconClass = (getDefinitionByName("ib2") as Class);
                                    actIcon = new (actIconClass)();
                                    actIconMC = ui.mcInterface.actBar.addChild(actIcon);
                                    slot = ((ai < (resObj.actions.active.length - 1)) ? ai : 5);
                                    blankMC = ui.mcInterface.actBar.getChildByName(("blank" + slot));
                                    actIconMC.x = blankMC.x;
                                    actIconMC.width = 42;
                                    actIconMC.height = 39;
                                    actIconMC.name = String(("i" + (ai + 1)));
                                    actIconMC.actionIndex = ai;
                                    actIconMC.actObj = actObj;
                                    actIconMC.icon2 = null;
                                    actIconMC.tQty.visible = false;
                                    actIconMC.y = (actIconMC.y - 6);
                                    updateIcons([actIconMC], actObj.icon.split(","), null);
                                    blankMC.visible = false;
                                    actIconMC.addEventListener(MouseEvent.MOUSE_OVER, actIconOver, false, 0, true);
                                    actIconMC.addEventListener(MouseEvent.MOUSE_OUT, actIconOut, false, 0, true);
                                    actIconMC.mouseChildren = false;
                                    if (((!(actObj.auto == null)) && (actObj.auto == true)))
                                    {
                                        world.actions.auto = world.actions.active[ai];
                                    }
                                    else
                                    {
                                        world.actions.active[ai].auto = false;
                                    };
                                    if (actObj.isOK)
                                    {
                                        actIconMC.addEventListener(MouseEvent.CLICK, actIconClick, false, 0, true);
                                        actIconMC.buttonMode = true;
                                    }
                                    else
                                    {
                                        c = new Color();
                                        c.setTint(0x333333, 0.9);
                                        actIconMC.cnt.transform.colorTransform = c;
                                    };
                                };
                                ai = (ai + 1);
                            };
                            world.myAvatar.dataLeaf.passives = [];
                            if (resObj.actions.passive != null)
                            {
                                ai = 0;
                                while (ai < resObj.actions.passive.length)
                                {
                                    actObj = copyObj(resObj.actions.passive[ai]);
                                    actObj.sArg1 = "";
                                    actObj.sArg2 = "";
                                    world.actions.passive.push(actObj);
                                    if (actObj.auras != null)
                                    {
                                        i = 0;
                                        while (i < actObj.auras.length)
                                        {
                                            world.myAvatar.dataLeaf.passives.push(actObj.auras[i]);
                                            i = (i + 1);
                                        };
                                    };
                                    ai = (ai + 1);
                                };
                            };
                            if (litePreference.data.bAuras)
                            {
                                pAurasUI.classChanged();
                                tAurasUI.classChanged();
                            };
                            isNewClass = false;
                            break;
                        case "seia":
                            if (resObj.iRes == 1)
                            {
                                ai = 0;
                                while (ai < world.actions.active.length)
                                {
                                    o = world.actions.active[ai];
                                    if (o.ref == "i1")
                                    {
                                        if (("tgtMax" in o))
                                        {
                                            delete o.tgtMax;
                                        };
                                        if (("tgtMin" in o))
                                        {
                                            delete o.tgtMin;
                                        };
                                        if (("auras" in o))
                                        {
                                            delete o.auras;
                                        };
                                        if (o.OldCD == null)
                                        {
                                            o.OldCD = o.cd;
                                        };
                                        for (s in resObj.o)
                                        {
                                            if (((((!(s == "nam")) && (!(s == "ref"))) && (!(s == "desc"))) && (!(s == "typ"))))
                                            {
                                                o[s] = resObj.o[s];
                                            };
                                        };
                                    };
                                    ai = (ai + 1);
                                };
                            };
                            break;
                        case "stu":
                            avt = world.myAvatar;
                            unm = sfc.myUserName;
                            uoLeaf = world.uoTreeLeaf(unm);
                            if (resObj.wDPS != null)
                            {
                                uoLeaf.wDPS = resObj.wDPS;
                            };
                            if (resObj.mDPS != null)
                            {
                                uoLeaf.mDPS = resObj.mDPS;
                            };
                            if (uoLeaf.sta == null)
                            {
                                uoLeaf.sta = {};
                            };
                            for (stuS in resObj.sta)
                            {
                                uoLeaf.sta[stuS] = resObj.sta[stuS];
                                if (stats.indexOf(stuS.substr(1)) > -1)
                                {
                                    uoLeaf.sta[stuS] = int(uoLeaf.sta[stuS]);
                                }
                                else
                                {
                                    uoLeaf.sta[stuS] = Number(uoLeaf.sta[stuS]);
                                };
                                if (stuS.toLowerCase().indexOf("$tha") > -1)
                                {
                                    actObj = world.getAutoAttack();
                                    if ((((!(actObj == null)) && (!(uoLeaf == null))) && (!(uoLeaf.sta == null))))
                                    {
                                        cd = Math.round((actObj.cd * (1 - Math.min(Math.max(uoLeaf.sta.$tha, -1), 0.5))));
                                        if (world.autoActionTimer.running)
                                        {
                                            world.autoActionTimer.delay = (world.autoActionTimer.delay - (world.autoActionTimer.delay - cd));
                                            world.autoActionTimer.delay = (world.autoActionTimer.delay + 100);
                                            world.autoActionTimer.reset();
                                            world.autoActionTimer.start();
                                        }
                                        else
                                        {
                                            world.autoActionTimer.delay = cd;
                                        };
                                    }
                                    else
                                    {
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("Login event order error");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                        trace("**");
                                    };
                                    hasteCoeff = (1 - Math.min(Math.max(uoLeaf.sta.$tha, -1), 0.5));
                                    world.GCD = Math.round((hasteCoeff * world.GCDO));
                                    for each (actObj in world.actions.active)
                                    {
                                        if (((((actObj.isOK) && (!(world.getActIcons(actObj)[0] == null))) && (world.getActIcons(actObj)[0].icon2 == null)) && ((now - actObj.ts) < (actObj.cd * hasteCoeff))))
                                        {
                                            world.coolDownAct(actObj, ((actObj.cd * hasteCoeff) - (now - actObj.ts)), now);
                                        };
                                    };
                                };
                                if (stuS.toLowerCase().indexOf("$cmc") > -1)
                                {
                                    world.updateActBar();
                                };
                            };
                            if (resObj.tempSta != null)
                            {
                                uoLeaf.tempSta = resObj.tempSta;
                                if (("updatePStats" in world.map))
                                {
                                    world.map.updatePStats();
                                };
                            };
                            if (avt != null)
                            {
                                world.updatePortrait(avt);
                            };
                            if (statsNewClass)
                            {
                                baseClassStats = new Object();
                                for (stu in resObj.sta)
                                {
                                    baseClassStats[stu] = resObj.sta[stu];
                                };
                                if (mcStatsPanel)
                                {
                                    mcStatsPanel.updateBase();
                                };
                                statsNewClass = false;
                            };
                            if (mcStatsPanel)
                            {
                                mcStatsPanel.update();
                            };
                            break;
                        case "event":
                            world.map.eventTrigger(resObj);
                            break;
                        case "modinfo":
                            world.map.showModInfo(resObj);
                            break;
                        case "modinc":
                            if (resObj.bSuccess)
                            {
                                world.map.hideLoading();
                                world.map.show(resObj.events);
                                world.modID = int(resObj.mID);
                            }
                            else
                            {
                                chatF.pushMsg("warning", resObj.msg, "SERVER", "", 0);
                            };
                            break;
                        case "ia":
                            if (("iaPathMC" in resObj))
                            {
                                try
                                {
                                    mc = world;
                                    mcPath = resObj.iaPathMC.split(".");
                                    while (mcPath.length > 0)
                                    {
                                        s = String(mcPath.shift());
                                        if (mc.getChildByName(s) != null)
                                        {
                                            mc = (mc.getChildByName(s) as MovieClip);
                                        }
                                        else
                                        {
                                            mc = mc[s];
                                        };
                                    };
                                }
                                catch (e:Error)
                                {
                                };
                            }
                            else
                            {
                                if (resObj.str != null)
                                {
                                    avt = world.getAvatarByUserID(int(resObj.str));
                                    if (avt != null)
                                    {
                                        mc = avt.pMC;
                                    };
                                }
                                else
                                {
                                    mc = MovieClip(world.CHARS.getChildByName(resObj.oName));
                                };
                            };
                            if (((!(mc == null)) && (!(mc == world))))
                            {
                                try
                                {
                                    switch (resObj.typ)
                                    {
                                        case "rval":
                                            mc.userName = resObj.unm;
                                            mc.iaF(resObj);
                                            break;
                                        case "str":
                                            if (resObj.str == null)
                                            {
                                                mc.userName = resObj.unm;
                                            };
                                            mc.iaF(resObj);
                                            break;
                                        case "flourish":
                                            mc.userName = resObj.unm;
                                            mc.gotoAndPlay(resObj.oFrame);
                                            break;
                                    };
                                }
                                catch (e:Error)
                                {
                                    trace(("error: " + e));
                                };
                            };
                            break;
                        case "siau":
                            world.updateCellMap(resObj);
                            break;
                        case "umsg":
                            addUpdate(resObj.s);
                            break;
                        case "gi":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (((resObj.owner + " has invited you to join the guild ") + resObj.gName) + ". Do you accept?");
                            modalO.callback = world.doGuildAccept;
                            modalO.params = {
                                    "guildID": resObj.guildID,
                                    "owner": resObj.owner
                                };
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", ((resObj.owner + " has invited you to join the guild ") + resObj.gName), "SERVER", "", 0);
                            break;
                        case "gd":
                            chatF.pushMsg("server", (resObj.unm + " has declined your invitation."), "SERVER", "", 0);
                            break;
                        case "ga":
                            avt = world.getAvatarByUserName(resObj.unm);
                            if (avt != null)
                            {
                                avt.updateGuild(resObj.guild);
                                if (avt.isMyAvatar)
                                {
                                    chatF.chn.guild.act = 1;
                                    chatF.pushMsg("server", "You have joined the guild.", "SERVER", "", 0);
                                }
                                else
                                {
                                    if (world.myAvatar.objData.guild.Name == avt.objData.guild.Name)
                                    {
                                        chatF.pushMsg("server", (avt.pnm + " has joined the guild."), "SERVER", "", 0);
                                        world.myAvatar.updateGuild(resObj.guild);
                                    };
                                };
                            }
                            else
                            {
                                if (resObj.guild.Name == world.myAvatar.objData.guild.Name)
                                {
                                    chatF.pushMsg("server", (resObj.unm + " has joined the guild."), "SERVER", "", 0);
                                    world.myAvatar.updateGuild(resObj.guild);
                                };
                            };
                            break;
                        case "gr":
                            avt = world.getAvatarByUserName(resObj.unm);
                            if (avt != null)
                            {
                                avt.updateGuild(null);
                                if (avt.isMyAvatar)
                                {
                                    chatF.chn.guild.act = 0;
                                    chatF.pushMsg("server", "You have been removed from the guild.", "SERVER", "", 0);
                                }
                                else
                                {
                                    if (world.myAvatar.objData.guild.Name == avt.objData.guild.Name)
                                    {
                                        chatF.pushMsg("server", (avt.pnm + " has been removed from the guild."), "SERVER", "", 0);
                                        world.myAvatar.updateGuild(resObj.guild);
                                    };
                                };
                            };
                            if (world.myAvatar.objData.guild != null)
                            {
                                if (world.myAvatar.objData.guild.Name == resObj.guild.Name)
                                {
                                    chatF.pushMsg("server", (resObj.unm + " has been removed from the guild."), "SERVER", "", 0);
                                    world.myAvatar.updateGuild(resObj.guild);
                                };
                            };
                            break;
                        case "guildDelete":
                            avt = world.getAvatarByUserName(resObj.unm);
                            if (avt != null)
                            {
                                avt.updateGuild(null);
                                if (avt.isMyAvatar)
                                {
                                    chatF.pushMsg("server", resObj.msg, "SERVER", "", 0);
                                };
                            };
                            break;
                        case "gMOTD":
                            world.myAvatar.objData.guild.MOTD = resObj.MOTD[0];
                            break;
                        case "updateGuild":
                            try
                            {
                                if (world.myAvatar.objData != null)
                                {
                                    world.myAvatar.updateGuild(resObj.guild);
                                };
                            }
                            catch (e)
                            {
                            };
                            if (resObj.msg != null)
                            {
                                chatF.pushMsg("server", resObj.msg, "SERVER", "", 0);
                            };
                            break;
                        case "gc":
                            avt = world.getAvatarByUserID(resObj.uid);
                            avt.initGuild(resObj.guild);
                            break;
                        case "interior":
                            break;
                        case "guildhall":
                            break;
                        case "guildinv":
                            break;
                        case "startTrade":
                            toggleTradePanel(resObj.userid);
                            world.tradeinfo = {
                                    itemsA: [],
                                    itemsB: [],
                                    hasRequested: {}
                                };
                            break;
                        case "ti":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.owner + " has requested you to trade. Do you accept?");
                            modalO.callback = world.doTradeAccept;
                            modalO.params = {unm: resObj.owner};
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.owner + " has requested you to trade."), "SERVER", "", 0);
                            break;
                        case "pi":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.owner + " has invited you to join their group.  Do you accept?");
                            modalO.callback = world.doPartyAccept;
                            modalO.params = {"pid": resObj.pid};
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.owner + " has invited you to a group."), "SERVER", "", 0);
                            break;
                        case "pa":
                            if (world.partyOwner == "")
                            {
                                world.partyOwner = resObj.owner;
                            };
                            supressMupltiples = false;
                            if (world.partyID == -1)
                            {
                                world.partyID = resObj.pid;
                                chatF.chn.party.act = 1;
                                if (resObj.owner.toLowerCase() != sfc.myUserName)
                                {
                                    chatF.pushMsg("server", "You have joined the party.", "SERVER", "", 0);
                                    supressMupltiples = true;
                                };
                            };
                            i = 0;
                            while (i < resObj.ul.length)
                            {
                                unm = resObj.ul[i];
                                if (unm.toLowerCase() != sfc.myUserName)
                                {
                                    world.addPartyMember(unm);
                                    if (!supressMupltiples)
                                    {
                                        chatF.pushMsg("server", (unm + " has joined the party."), "SERVER", "", 0);
                                    };
                                };
                                i = (i + 1);
                            };
                            break;
                        case "pr":
                            isYou = false;
                            nam = world.partyOwner;
                            world.partyOwner = resObj.owner;
                            if (nam != world.partyOwner)
                            {
                                chatF.pushMsg("server", (world.partyOwner + " is now the party leader."), "SERVER", "", 0);
                            };
                            if (resObj.unm.toLowerCase() == sfc.myUserName.toLowerCase())
                            {
                                isYou = true;
                                chatF.chn.party.act = 0;
                            };
                            if (resObj.typ == "k")
                            {
                                if (isYou)
                                {
                                    chatF.pushMsg("server", "You have been removed from the party", "SERVER", "", 0);
                                }
                                else
                                {
                                    chatF.pushMsg("server", (resObj.unm + " has been removed from the party"), "SERVER", "", 0);
                                };
                            }
                            else
                            {
                                if (resObj.typ == "l")
                                {
                                    if (isYou)
                                    {
                                        chatF.pushMsg("server", "You have left the party", "SERVER", "", 0);
                                    }
                                    else
                                    {
                                        chatF.pushMsg("server", (resObj.unm + " has left the party"), "SERVER", "", 0);
                                    };
                                };
                            };
                            world.removePartyMember(String(resObj.unm).toLowerCase());
                            break;
                        case "pp":
                            nam = world.partyOwner;
                            world.partyOwner = resObj.owner;
                            if (nam != world.partyOwner)
                            {
                                chatF.pushMsg("server", (world.partyOwner + " is now the party leader."), "SERVER", "", 0);
                            };
                            world.updatePartyFrame();
                            break;
                        case "ps":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.unm + " wants to summon you to them.  Do you accept?");
                            modalO.callback = world.acceptPartySummon;
                            modalO.params = resObj;
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.unm + " is trying to summon you to them."), "SERVER", "", 0);
                            break;
                        case "pd":
                            chatF.pushMsg("server", (resObj.unm + " has declined your invitation."), "SERVER", "", 0);
                            break;
                        case "pc":
                            if (world.partyID > -1)
                            {
                                chatF.pushMsg("server", "Your party has been disbanded", "SERVER", "", 0);
                            };
                            world.partyID = -1;
                            world.partyOwner = "";
                            world.partyMembers = [];
                            world.updatePartyFrame();
                            chatF.chn.party.act = 0;
                            if (chatF.chn.cur == chatF.chn.party)
                            {
                                chatF.chn.cur = chatF.chn.zone;
                            };
                            if (chatF.chn.lastPublic == chatF.chn.party)
                            {
                                chatF.chn.lastPublic = chatF.chn.zone;
                            };
                            break;
                        case "PVPQ":
                            world.handlePVPQueue(resObj);
                            break;
                        case "PVPI":
                            world.receivePVPInvite(resObj);
                            break;
                        case "PVPE":
                            relayPVPEvent(resObj);
                            break;
                        case "PVPS":
                            updatePVPScore(resObj.pvpScore);
                            break;
                        case "PVPC":
                            world.PVPResults.pvpScore = resObj.pvpScore;
                            world.PVPResults.team = resObj.team;
                            updatePVPScore(resObj.pvpScore);
                            togglePVPPanel("results");
                            break;
                        case "pvpbreakdown":
                            break;
                        case "di":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.owner + " has challenged you to a duel.  Do you accept?");
                            modalO.callback = world.doDuelAccept;
                            modalO.params = {"unm": resObj.owner};
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.owner + " has challenged you to a duel."), "SERVER", "", 0);
                            break;
                        case "WorldBossInvite":
                            wbTime = new Date((ts_login_server + (resObj.spawnTime - ts_login_client)));
                            timeOut = new Date((ts_login_server + ((resObj.spawnTime + resObj.timeLimit) - ts_login_client)));
                            millisecondDifference = (timeOut.valueOf() - wbTime.valueOf());
                            seconds = (millisecondDifference / 1000);
                            // mixer.playSound("WBDrachenguardSpawn");
                            ui.mcWorldBoss.visible = true;
                            showBossBox(resObj.monFile, resObj.monLink);
                            ui.mcWorldBoss.strName.text = resObj.monName;
                            ui.mcWorldBoss.btnJoin.alpha = 1;
                            ui.mcWorldBoss.btnJoin.mouseEnabled = true;
                            ui.mcWorldBoss.roomName = resObj.room;
                            ui.mcWorldBoss.setTimer(seconds);
                            break;
                        case "DuelEX":
                            world.duelExpire();
                            break;
                        case "loadFactions":
                            world.myAvatar.initFactions(resObj.factions);
                            break;
                        case "addFaction":
                            world.myAvatar.addFaction(resObj.faction);
                            break;
                        case "loadFriendsList":
                            world.myAvatar.initFriendsList(resObj.friends);
                            break;
                        case "requestFriend":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.strBody = (resObj.unm + " has invited you to be friends. Do you accept?");
                            modalO.callback = world.addFriend;
                            modalO.params = {
                                    "ID": resObj.ID,
                                    "unm": resObj.unm
                                };
                            modalO.btns = "dual";
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            chatF.pushMsg("server", (resObj.unm + " has invited you to be friends."), "SERVER", "", 0);
                            break;
                        case "addFriend":
                            world.myAvatar.addFriend(resObj.friend);
                            break;
                        case "updateFriend":
                            world.myAvatar.updateFriend(resObj.friend);
                            break;
                        case "deleteFriend":
                            world.myAvatar.deleteFriend(resObj.ID);
                            break;
                        case "isModerator":
                            modal = null;
                            modalO = null;
                            modal = new ModalMC();
                            modalO = {};
                            modalO.btns = "mono";
                            if (resObj.val)
                            {
                                modalO.strBody = (resObj.unm + " is staff!");
                                modalO.glow = "gold,medium";
                                chatF.pushMsg("server", (resObj.unm + " is staff!"), "SERVER", "", 0);
                            }
                            else
                            {
                                modalO.strBody = (resObj.unm + " is NOT staff!");
                                modalO.glow = "red,medium";
                                chatF.pushMsg("warning", (resObj.unm + " is NOT staff!"), "SERVER", "", 0);
                            };
                            ui.ModalStack.addChild(modal);
                            modal.init(modalO);
                            break;
                        case "loadWarVars":
                            world.objResponse["loadWarVars"] = resObj;
                            world.dispatchEvent(new Event("loadWarVars"));
                            break;
                        case "setAchievement":
                            world.updateAchievement(resObj.field, resObj.index, resObj.value);
                            break;
                        case "loadQuestStringData":
                            world.objQuestString = resObj.obj;
                            world.dispatchEvent(new Event("QuestStringData_Complete"));
                            break;
                        case "getAdData":
                            if (resObj.bSuccess == 1)
                            {
                                world.adData = resObj.bh;
                                world.dispatchEvent(new Event("getAdData"));
                            };
                            break;
                        case "getAdReward":
                            world.myAvatar.objData.iDailyAds = (world.myAvatar.objData.iDailyAds + 1);
                            world.adData = null;
                            if (world.myAvatar.objData.iDailyAds < world.myAvatar.objData.iDailyAdCap)
                            {
                                world.sendGetAdDataRequest();
                            };
                            world.myAvatar.objData.intGold = (world.myAvatar.objData.intGold + int(resObj.iGold));
                            ui.mcInterface.mcGold.strGold.text = world.myAvatar.objData.intGold;
                            if (((ui.mcPopup.currentLabel == "HouseInventory") || (ui.mcPopup.currentLabel == "Inventory")))
                            {
                                MovieClip(ui.mcPopup.getChildByName("mcInventory")).update({"eventType": "refreshCoins"});
                            };
                            world.myAvatar.objData.intCoins = (world.myAvatar.objData.intCoins + int(resObj.iCoins));
                            sMsg = (("Congratulations! You just received <font color='#FFCC00'><b>" + resObj.iGold) + " Gold</b></font>");
                            if (resObj.iCoins > 0)
                            {
                                sMsg = (sMsg + ((" and <font color='#990099'><b>" + resObj.iCoins) + " Adventure Coins</b></font>"));
                            };
                            sMsg = (sMsg + " from Ballyhoo.");
                            showMessageBox(sMsg);
                            break;
                        case "xpboost":
                            manageXPBoost(resObj);
                            break;
                        case "gboost":
                            manageGBoost(resObj);
                            break;
                        case "repboost":
                            manageRepBoost(resObj);
                            break;
                        case "cpboost":
                            manageCPBoost(resObj);
                            break;
                        case "gettimes":
                            a = [];
                            for (s in resObj.o)
                            {
                                o = resObj.o[s];
                                o.s = s;
                                a.push(o);
                            };
                            a.sortOn("t", (Array.NUMERIC | Array.DESCENDING));
                            trace(" ** GETTIMES START **");
                            i = 0;
                            while (i < a.length)
                            {
                                o = a[i];
                                trace(((((((((o.s + ",") + o.t) + ",") + o.n) + ",") + numToStr((o.t / o.n))) + ",") + Math.round(o.d)));
                                i = (i + 1);
                            };
                            trace(" ** GETTIMES END **");
                            break;
                        case "clockTick":
                            if (("eventTrigger" in MovieClip(world.map)))
                            {
                                world.map.eventTrigger(resObj);
                            };
                            break;
                        case "castWait":
                            try
                            {
                                world.map.fishGame.castingWait(resObj.wait, resObj.derp);
                            }
                            catch (e)
                            {
                            };
                            break;
                        case "CatchResult":
                            world.myAvatar.addRep(20, resObj.catchResult.myRep);
                            try
                            {
                                world.map.fishGame.showCatch(resObj);
                            }
                            catch (e)
                            {
                            };
                            break;
                        case "alchOnStart":
                            world.map.alchemyGame.onStart(resObj);
                            break;
                        case "alchComplete":
                            world.map.alchemyGame.checkComplete(resObj);
                            break;
                        case "spellOnStart":
                            world.map.mcGame.spellOnStart(resObj);
                            break;
                        case "spellComplete":
                            world.map.mcGame.spellComplete(resObj);
                            break;
                        case "spellWaitTimer":
                            world.map.mcGame.spellWaitTimer(resObj);
                            break;
                        case "playerDeath":
                            if (("eventTrigger" in MovieClip(world.map)))
                            {
                                world.map.eventTrigger(resObj);
                            };
                            break;
                        case "getScrolls":
                            trace("getScrolls recieved");
                            try
                            {
                                world.scrollData = resObj.scrolls;
                                world.map.initScrollData();
                            }
                            catch (e)
                            {
                                trace("error finding function");
                            };
                            break;
                        case "turninscroll":
                            if (resObj.IDs != null)
                            {
                                i = 0;
                                while (i < resObj.IDs.length)
                                {
                                    world.myAvatar.updateScrolls(int(resObj.IDs[i]));
                                    i = (i + 1);
                                };
                                s = "";
                                i = 0;
                                while (i < 500)
                                {
                                    s = (s + String.fromCharCode(0));
                                    i = (i + 1);
                                };
                                world.myAvatar.objData.pending = s;
                                try
                                {
                                    world.map.displayTurnins(resObj.IDs);
                                }
                                catch (e)
                                {
                                    trace("error displaying turnins");
                                };
                            };
                            break;
                        case "getapop":
                            if (resObj.apopData != null)
                            {
                                trace(("apopID: " + resObj.apopData.apopID));
                                apopTree[String(resObj.apopData.apopID)] = resObj.apopData;
                                if (!resObj.bQuests)
                                {
                                    createApop();
                                };
                            };
                    };
                };
                try
                {
                    if (world.map.Events != null)
                    {
                        trace("events not null");
                        if (world.map.Events[cmd] != null)
                        {
                            trace(("sending: " + cmd));
                            world.map.responseEvent(cmd, resObj);
                        };
                    };
                }
                catch (e)
                {
                    trace(("error in responseEvent: " + e));
                };
            };
            addFrameScript(0, frame1, 11, frame12, 12, frame13, 21, frame22, 31, frame32, 42, frame43, 52, frame53);
            // Security.allowDomain("*.aq.com");
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            sfc = new SmartFoxClient();
            sfc.debug = true;
            sfc.smartConnect = false;
            sfc.addEventListener(SFSEvent.onConnection, onConnectionHandler);
            sfc.addEventListener(SFSEvent.onConnectionLost, onConnectionLostHandler);
            sfc.addEventListener(SFSEvent.onLogin, onLoginHandler);
            sfc.addEventListener(SFSEvent.onLogout, onLogoutHandler);
            sfc.addEventListener(SFSEvent.onObjectReceived, onObjectReceivedHandler);
            sfc.addEventListener(SFSEvent.onRoundTripResponse, onRoundTripResponseHandler);
            sfc.addEventListener(SFSEvent.onExtensionResponse, onExtensionResponseHandler);
            classCatMap.M1.ratios = [0.27, 0.3, 0.22, 0.05, 0.1, 0.06];
            classCatMap.M2.ratios = [0.2, 0.22, 0.33, 0.05, 0.1, 0.1];
            classCatMap.M3.ratios = [0.24, 0.2, 0.2, 0.24, 0.07, 0.05];
            classCatMap.M4.ratios = [0.3, 0.18, 0.3, 0.02, 0.06, 0.14];
            classCatMap.C1.ratios = [0.06, 0.2, 0.11, 0.33, 0.15, 0.15];
            classCatMap.C2.ratios = [0.08, 0.27, 0.1, 0.3, 0.1, 0.15];
            classCatMap.C3.ratios = [0.06, 0.23, 0.05, 0.28, 0.28, 0.1];
            classCatMap.S1.ratios = [0.22, 0.18, 0.21, 0.08, 0.08, 0.23];
            userPreference = SharedObject.getLocal("AQWUserPref", "/");
            litePreference = SharedObject.getLocal("AQLite_Data", "/");
            inituoPref();
            initlitePref();
            initKeybindPref();
            if (userPreference.data.quality == null)
            {
                userPreference.data.quality = "AUTO";
            };
            initArrRep();
            if (litePreference.data.bChatUI)
            {
                chatF = new Chat2(this);
                intChatMode = 1;
            }
            else
            {
                chatF = new Chat();
                chatF.rootClass = this;
                intChatMode = 0;
            };
            addChildAt(new Sprite(), 0);
        }

        public static function gTrace(str:*):*
        {
            if (Game.ISWEB)
            {
                if (!ExternalInterface.available)
                {
                    return;
                };
                ExternalInterface.call("console.log", str);
            }
            else
            {
                trace(str);
            };
        }

        public static function trim(p_string:String):String
        {
            if (p_string == null)
            {
                return ("");
            };
            return (p_string.replace(/^\s+|\s+$/g, ""));
        }

        public static function XMLtoObject(objXML:XML):*
        {
            var a:*;
            var o:*;
            var strChildName:*;
            var objTarget:* = {};
            for (a in objXML.attributes())
            {
                objTarget[String(objXML.attributes()[a].name())] = String(objXML.attributes()[a]);
            };
            for (o in objXML.children())
            {
                strChildName = objXML.children()[o].name();
                if (objTarget[strChildName] == undefined)
                {
                    objTarget[strChildName] = [];
                };
                objTarget[strChildName].push(XMLtoObject(objXML.children()[o]));
            };
            return (objTarget);
        }

        public static function convertXMLtoObject(objXML:XML):*
        {
            var a:*;
            var o:*;
            var childNode:XML;
            var strChildName:*;
            var objTarget:* = {};
            for (a in objXML.attributes())
            {
                objTarget[String(objXML.attributes()[a].name())] = String(objXML.attributes()[a]);
            };
            for (o in objXML.children())
            {
                childNode = objXML.children()[o];
                if (childNode.nodeKind() == "text")
                {
                    if (childNode == parseFloat(childNode).toString())
                    {
                        return (parseFloat(childNode));
                    };
                    return (childNode);
                };
                if (childNode.nodeKind() == "element")
                {
                    strChildName = objXML.children()[o].name();
                    if (objTarget[strChildName] == null)
                    {
                        objTarget[strChildName] = convertXMLtoObject(objXML.children()[o]);
                    }
                    else
                    {
                        if (!(objTarget[strChildName] is Array))
                        {
                            objTarget[strChildName] = [objTarget[strChildName]];
                        };
                        objTarget[strChildName].push(convertXMLtoObject(objXML.children()[o]));
                    };
                };
            };
            return (objTarget);
        }

        private static function makeGrayscale(clip:DisplayObject, darkenPercent:int = 0, grayLvl:Number = 0.33):void
        {
            var color:Color;
            if (clip == null)
            {
                return;
            };
            var grayScaleMatrix:Array = [grayLvl, grayLvl, grayLvl, 0, 0, grayLvl, grayLvl, grayLvl, 0, 0, grayLvl, grayLvl, grayLvl, 0, 0, grayLvl, grayLvl, grayLvl, 1, 0];
            var matrix:ColorMatrixFilter = new ColorMatrixFilter(grayScaleMatrix);
            clip.filters = [matrix];
            if (darkenPercent != 0)
            {
                color = new Color();
                color.brightness = -(darkenPercent / 100);
                clip.transform.colorTransform = color;
            };
        }

        public function onRemoveChildrens(param1:MovieClip):*
        {
            var _loc2_:* = param1.numChildren - 1;
            while (_loc2_ >= 0)
            {
                param1.removeChildAt(_loc2_);
                _loc2_--;
            }
        }

        public function onLoadMaster(param1:Function, param2:LoaderContext):Function
        {
            var callback:Function = param1;
            var context:LoaderContext = param2;
            return function(param1:Event):void
            {
                var _loc2_:* = (URLLoader(param1.target).data);
                byteLoader = new Loader();
                if (callback != null)
                {
                    byteLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, callback);
                }
                byteLoader.loadBytes(_loc2_, context);
            };
        }

        public function loadAccountCreation(strFilename:String):*
        {
            mcAccount.removeChildAt(0);
            var ldr:Loader = new Loader();
            trace((("newchar " + Game.serverFilePath) + strFilename));
            ldr.load(new URLRequest((Game.serverFilePath + strFilename)), new LoaderContext(false, new ApplicationDomain(null)));
            mcAccount.addChild(ldr);
        }

        public function onCSComplete(e:Event):void
        {
            trace("completed");
            mcCharSelect = e.currentTarget.content;
            this.addChildAt(mcCharSelect, 1);
            csLoader.removeEventListener(Event.COMPLETE, onCSComplete);
            csLoader.removeEventListener(ProgressEvent.PROGRESS, onCSProgress);
            csLoader.removeEventListener(IOErrorEvent.IO_ERROR, onCSError);
        }

        public function onCSProgress(event:ProgressEvent):void
        {
            csbLoaded = event.bytesLoaded;
            csbTotal = event.bytesTotal;
            var percent:int = int(((csbLoaded / csbTotal) * 100));
            var barProg:Number = (csbLoaded / csbTotal);
            loader.mcPct.text = (percent + "%");
            if (csbLoaded >= csbTotal)
            {
                loader.parent.removeChild(loader);
                loader = null;
            };
        }

        public function onCSError(e:IOErrorEvent):void
        {
            trace(("Charselect load failed: " + e));
            if (loader)
            {
                loader.parent.removeChild(loader);
                loader = null;
            };
            gotoAndPlay("Login");
        }

        public function monsterTreeWrite(MonMapID:int, monLeafO:Object, targets:* = null):void
        {
            var typ:String;
            var nam:String;
            var val:*;
            var monAvt:Avatar;
            var avtAvt:Avatar;
            var Mon:Avatar;
            var avt:Avatar;
            var pMC:MovieClip;
            var intStateO:int;
            var s:String;
            var ri:int;
            var unm:String;
            var tx:*;
            var ty:*;
            var i:int;
            var prop:String = "";
            var updated:Object = {};
            var monLeaf:Object = world.monTree[MonMapID];
            if (monLeaf != null)
            {
                intStateO = -1;
                if (((!(monLeaf == null)) && (!(monLeaf.intState == null))))
                {
                    intStateO = monLeaf.intState;
                };
                for (s in monLeafO)
                {
                    nam = s;
                    val = monLeafO[s];
                    updated[nam] = val;
                    if (nam.toLowerCase().indexOf("int") > -1)
                    {
                        val = int(val);
                    };
                    if (nam == "react")
                    {
                        val = val.split(",");
                        ri = 0;
                        while (ri < val.length)
                        {
                            val[ri] = int(val[ri]);
                            ri++;
                        };
                    };
                    monLeaf[nam] = val;
                };
                prop = "";
                for (prop in updated)
                {
                    nam = prop;
                    val = updated[prop];
                    if (nam.toLowerCase().indexOf("evt:") < 0)
                    {
                        Mon = world.getMonster(MonMapID);
                        if (Mon != null)
                        {
                            if (nam.toLowerCase().indexOf("hp") > -1)
                            {
                                if (((!(Mon == null)) && (!(Mon.objData == null))))
                                {
                                    val = int(val);
                                    Mon.objData[prop] = val;
                                    if (world.myAvatar.target == Mon)
                                    {
                                        world.updatePortrait(Mon);
                                    };
                                    if (((!(world.objLock == null)) && ((nam == "intHP") && (val <= 0))))
                                    {
                                        world.intKillCount++;
                                        world.updatePadNames();
                                    };
                                    if (((!(Mon.objData == null)) && ("boolean")))
                                    {
                                        if (Mon.objData.strFrame == world.strFrame)
                                        {
                                            if (val <= 0)
                                            {
                                                if (((bAnalyzer) && ((targets) || (updated["targets"].length > 0))))
                                                {
                                                    if (!bAnalyzer.isRunning())
                                                    {
                                                        return;
                                                    };
                                                    for each (unm in ((targets) ? targets : updated["targets"]))
                                                    {
                                                        if (world.myAvatar.objData.strUsername.toLowerCase() == unm.toLowerCase())
                                                        {
                                                            bAnalyzer.addKill();
                                                        };
                                                    };
                                                };
                                                Mon.pMC.stopWalking();
                                                world.removeAuraFX(Mon.pMC, "all");
                                                Mon.pMC.die();
                                                monLeaf.auras = [];
                                                monLeaf.targets = {};
                                                Mon.target = null;
                                                if (("eventTrigger" in MovieClip(world.map)))
                                                {
                                                    world.map.eventTrigger({
                                                                "cmd": "monDeath",
                                                                "args": MonMapID,
                                                                "targets": monLeafO.targets
                                                            });
                                                };
                                                if (world.myAvatar.dataLeaf.targets[Mon.objData.MonMapID] != null)
                                                {
                                                    delete world.myAvatar.dataLeaf.targets[Mon.objData.MonMapID];
                                                };
                                            };
                                        };
                                    };
                                };
                            };
                            if (nam.toLowerCase().indexOf("state") > -1)
                            {
                                if (((!(Mon == null)) && (!(Mon.objData == null))))
                                {
                                    val = int(val);
                                    Mon.objData[prop] = val;
                                    if (val != 2)
                                    {
                                        Mon.dataLeaf.auras = [];
                                    };
                                    if (((!(Mon.objData.strFrame == null)) && (Mon.objData.strFrame == world.strFrame)))
                                    {
                                        if ((((val == 1) && (!(Mon.pMC == null))) && ((!(Mon.pMC.x == Mon.pMC.ox)) || (!(Mon.pMC.y == Mon.pMC.oy)))))
                                        {
                                            Mon.pMC.walkTo(Mon.pMC.ox, Mon.pMC.oy, world.WALKSPEED);
                                        };
                                    };
                                    if (val != 2)
                                    {
                                        monLeaf.targets = {};
                                    };
                                };
                            };
                            if (nam.toLowerCase().indexOf("dx") > -1)
                            {
                                val = int(val);
                                if ((((!(Mon.objData == null)) && (!(Mon.objData.strFrame == null))) && (Mon.objData.strFrame == world.strFrame)))
                                {
                                    tx = int(world.monTree[MonMapID].dx);
                                    ty = int(world.monTree[MonMapID].dy);
                                    Mon.pMC.walkTo(tx, ty, world.WALKSPEED);
                                };
                            };
                        };
                    };
                };
            };
        }

        public function userTreeWrite(uoName:String, uoLeafO:Object):void
        {
            var typ:String;
            var nam:String;
            var val:*;
            var monAvt:Avatar;
            var avtAvt:Avatar;
            var Mon:Avatar;
            var avt:Avatar;
            var pMC:MovieClip;
            var s:String;
            var intStateO:int;
            var i:int;
            var prop:String = "";
            var updated:Object = {};
            var uoLeafSet:Object = {};
            var uoLeaf:Object = world.uoTree[uoName.toLowerCase()];
            avt = world.getAvatarByUserName(uoName);
            for (s in uoLeafO)
            {
                nam = s;
                val = uoLeafO[s];
                if ((((((nam.toLowerCase().indexOf("int") > -1) || (nam.toLowerCase() == "tx")) || (nam.toLowerCase() == "ty")) || (nam.toLowerCase() == "sp")) || (nam.toLowerCase() == "pvpTeam")))
                {
                    val = int(val);
                };
                if ((((((((((sfcSocial) && (!(uoLeaf == null))) && (!(world.myAvatar.dataLeaf == null))) && (nam.toLowerCase() == "inthp")) && (!(uoName.toLowerCase() == sfc.myUserName))) && (uoLeaf.strFrame == world.myAvatar.dataLeaf.strFrame)) && ((!(world.bPvP)) || (uoLeaf.pvpTeam == world.myAvatar.dataLeaf.pvpTeam))) && (val > 0)) && (!(world.getFirstHeal() == null))))
                {
                    if (((val <= uoLeaf.intHP) && (((uoLeaf.intHP - val) >= (uoLeaf.intHPMax * 0.15)) || (val <= (uoLeaf.intHPMax * 0.5)))))
                    {
                        try
                        {
                            avt.pMC.showHealIcon();
                        }
                        catch (e:Error)
                        {
                        };
                    };
                    if (val > Math.round((uoLeaf.intHPMax * 0.5)))
                    {
                        try
                        {
                            if (avt.pMC.getChildByName("HealIconMC") != null)
                            {
                                MovieClip(avt.pMC.getChildByName("HealIconMC")).fClose();
                            };
                        }
                        catch (e:Error)
                        {
                        };
                    };
                };
                if (nam.toLowerCase() == "afk")
                {
                    val = (val == "true");
                };
                updated[nam] = val;
                uoLeafSet[nam] = val;
            };
            intStateO = -1;
            if (world.uoTree[uoName.toLowerCase()] != null)
            {
                intStateO = world.uoTree[uoName.toLowerCase()].intState;
            };
            world.uoTreeLeafSet(uoName, uoLeafSet);
            uoLeaf = world.uoTree[uoName.toLowerCase()];
            if (world.isPartyMember(uoName))
            {
                world.updatePartyFrame({"unm": uoLeaf.strUsername});
            };
            prop = "";
            for (prop in updated)
            {
                val = updated[prop];
                if (prop.toLowerCase() == "strframe")
                {
                    world.manageAreaUser(uoName, "+");
                    if (updated[prop] != world.strFrame)
                    {
                        pMC = world.getMCByUserID(world.getUserByName(uoName).getId());
                        if (((!(pMC == null)) && (!(pMC.stage == null))))
                        {
                            pMC.pAV.hideMC();
                            if (pMC.pAV == world.myAvatar.target)
                            {
                                world.setTarget(null);
                            };
                        };
                    }
                    else
                    {
                        if (updated.sp != null)
                        {
                            pMC = world.getMCByUserID(world.getUserByName(uoName).getId());
                            if (pMC != null)
                            {
                                pMC.walkTo(updated.tx, updated.ty, world.WALKSPEED);
                            };
                        }
                        else
                        {
                            world.objectByID(uoLeaf.entID);
                        };
                    };
                };
                if (prop.toLowerCase() == "sp")
                {
                    if (updated.strFrame == world.strFrame)
                    {
                    };
                };
                if (avt != null)
                {
                    if (((prop.toLowerCase().indexOf("inthp") > -1) || (prop.toLowerCase().indexOf("intmp") > -1)))
                    {
                        val = int(val);
                        if (avt.objData != null)
                        {
                            avt.objData[prop] = val;
                        };
                        if (((avt.isMyAvatar) || (world.myAvatar.target == avt)))
                        {
                            world.updatePortrait(avt);
                        };
                        if (avt.isMyAvatar)
                        {
                            world.updateActBar();
                        };
                        if (((!(avt.pMC == null)) && (world.showHPBar)))
                        {
                            avt.pMC.updateHPBar();
                        };
                    };
                    if (prop.toLowerCase().indexOf("intlevel") > -1)
                    {
                        val = int(val);
                        if (avt.objData != null)
                        {
                            avt.objData[prop] = val;
                            if (((!(avt.isMyAvatar)) && (world.myAvatar.target == avt)))
                            {
                                showPortraitBox(avt, ui.mcPortraitTarget);
                            };
                        };
                    };
                    if (prop.toLowerCase().indexOf("intstate") > -1)
                    {
                        val = int(val);
                        if (((!(avt.objData == null)) && (world.uoTree[uoName.toLowerCase()].strFrame == world.strFrame)))
                        {
                            if (((val == 1) && (intStateO == 0)))
                            {
                                avt.pMC.gotoAndStop("Idle");
                                avt.pMC.scale(world.SCALE);
                            };
                            if (((val == 1) && (intStateO == 2)))
                            {
                                if (("eventTrigger" in MovieClip(world.map)))
                                {
                                };
                            };
                        };
                        if (avt.objData != null)
                        {
                            avt.objData[prop] = val;
                        };
                        if ((((val == 0) && (world.uoTree[uoName.toLowerCase()].strFrame == world.strFrame)) && (!(avt.pMC == null))))
                        {
                            avt.pMC.stopWalking();
                            avt.pMC.mcChar.gotoAndPlay("Feign");
                            world.removeAuraFX(avt.pMC, "all");
                            if (avt.pMC.getChildByName("HealIconMC") != null)
                            {
                                MovieClip(avt.pMC.getChildByName("HealIconMC")).fClose();
                            };
                            if (avt.isMyAvatar)
                            {
                                world.cancelAutoAttack();
                                world.actionReady = false;
                                world.bitWalk = false;
                                world.map.transform.colorTransform = world.deathCT;
                                world.CHARS.transform.colorTransform = world.deathCT;
                                avt.pMC.transform.colorTransform = world.defaultCT;
                                world.showResCounter();
                            };
                        };
                        if (val != 2)
                        {
                            uoLeaf.targets = {};
                        };
                    };
                    if (prop.toLowerCase().indexOf("afk") > -1)
                    {
                        if (avt.pMC != null)
                        {
                            avt.pMC.updateName();
                        };
                    };
                    if (prop == "showCloak")
                    {
                        if (avt.pMC != null)
                        {
                            avt.pMC.setCloakVisibility(val);
                        };
                    };
                    if (prop == "showHelm")
                    {
                        if (avt.pMC != null)
                        {
                            avt.pMC.setHelmVisibility(val);
                        };
                    };
                    if (prop.toLowerCase().indexOf("cast") > -1)
                    {
                        if (avt.pMC != null)
                        {
                            if (val.t > -1)
                            {
                                avt.pMC.stopWalking();
                                avt.pMC.queueAnim("Use");
                            }
                            else
                            {
                                avt.pMC.endAction();
                                if (avt == world.myAvatar)
                                {
                                    ui.mcCastBar.fClose();
                                };
                            };
                        };
                    };
                };
            };
        }

        public function doAnim(anim:Object, isProc:Boolean = false, dur:* = null):void
        {
            var anims:Array;
            var animIndex:uint;
            var animStr:String;
            var pMC:MovieClip;
            var cLeaf:Object;
            var tLeaf:Object;
            var tAvt:Avatar;
            var cAvt:Avatar;
            var aura:Object;
            var buffer:* = undefined;
            var xBuffer:* = undefined;
            var yBuffer:* = undefined;
            var animString:String;
            var i:int;
            var cTyp:String = "";
            var cID:int = -1;
            var tTyp:String = "";
            var tID:int = -1;
            var tAvts:Array = [];
            var tInfA:Array = [];
            var strF:String = "";
            cAvt = null;
            tAvt = null;
            var cReg:Point = new Point(0, 0);
            var tReg:Point = new Point(0, 0);
            if (((!(anim.cInf == null)) && (!(anim.tInf == null))))
            {
                cTyp = String(anim.cInf.split(":")[0]);
                cID = int(anim.cInf.split(":")[1]);
                switch (cTyp)
                {
                    case "p":
                        cAvt = world.getAvatarByUserID(cID);
                        cLeaf = world.getUoLeafById(cID);
                        break;
                    case "m":
                        cAvt = world.getMonster(cID);
                        cLeaf = world.monTree[cID];
                        if (anim.msg != null)
                        {
                            if (anim.msg.indexOf("<mon>") > -1)
                            {
                                anim.msg = anim.msg.split("<mon>").join(cAvt.objData.strMonName);
                            };
                            addUpdate(anim.msg);
                        };
                        break;
                };
                tInfA = anim.tInf.split(",");
                i = 0;
                while (i < tInfA.length)
                {
                    tTyp = String(tInfA[i].split(":")[0]);
                    tID = int(tInfA[i].split(":")[1]);
                    switch (tTyp)
                    {
                        case "p":
                            tAvt = world.getAvatarByUserID(tID);
                            tLeaf = world.getUoLeafById(tID);
                            break;
                        case "m":
                            tAvt = world.getMonster(tID);
                            tLeaf = world.monTree[tID];
                            break;
                    };
                    tAvts.push(tAvt);
                    i = (i + 1);
                };
                if (tAvts[0] != null)
                {
                    tAvt = tAvts[0];
                };
                if (tAvt != null)
                {
                    tLeaf = tAvt.dataLeaf;
                };
                if (((((((!(cAvt == null)) && (!(cAvt.pMC == null))) && (!(tAvt == null))) && (!(tAvt.pMC == null))) && (!(cLeaf == null))) && (!(tLeaf == null))))
                {
                    aura = {};
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
                                if (aura.cat == "disabled")
                                {
                                    return;
                                };
                            };
                        }
                        catch (e:Error)
                        {
                            trace(("doAnim > " + e));
                        };
                    };
                    animStr = anim.animStr;
                    switch (cTyp)
                    {
                        case "p":
                            if (cAvt.objData != null)
                            {
                                if (cAvt != world.myAvatar)
                                {
                                    cAvt.target = tAvt;
                                };
                                strF = String(cLeaf.strFrame);
                                cAvt.pMC.spFX.strl = "";
                                if ((((!(strF == null)) && (strF == world.strFrame)) && (cLeaf.intState > 0)))
                                {
                                    if (cAvt != tAvt)
                                    {
                                        if ((tAvt.pMC.x - cAvt.pMC.x) >= 0)
                                        {
                                            cAvt.pMC.turn("right");
                                        }
                                        else
                                        {
                                            cAvt.pMC.turn("left");
                                        };
                                    };
                                    if (anim.strl != null)
                                    {
                                        cAvt.pMC.spFX.strl = anim.strl;
                                    };
                                    if (anim.fx != null)
                                    {
                                        cAvt.pMC.spFX.fx = anim.fx;
                                    };
                                    if (tAvts != null)
                                    {
                                        cAvt.pMC.spFX.avts = tAvts;
                                    };
                                    if (!isNaN(dur))
                                    {
                                        cAvt.pMC.spellDur = dur;
                                    };
                                    if (animStr.indexOf(",") > -1)
                                    {
                                        animStr = animStr.split(",")[Math.round((Math.random() * (animStr.split(",").length - 1)))];
                                    };
                                    if (((!(animStr == "Thrash")) || (!(cAvt.pMC.mcChar.currentLabel == "Thrash"))))
                                    {
                                        cAvt.pMC.queueAnim(animStr);
                                    };
                                    if (((isProc) && (cAvt.pMC.mcChar.weapon.mcWeapon.isProc)))
                                    {
                                        cAvt.pMC.mcChar.weapon.mcWeapon.gotoAndPlay("Proc");
                                    };
                                };
                            };
                            break;
                        case "m":
                            if (cAvt.objData != null)
                            {
                                if (cAvt != world.myAvatar)
                                {
                                    cAvt.target = tAvt;
                                };
                                strF = String(cLeaf.strFrame);
                                cReg = cAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                cReg = world.CHARS.globalToLocal(cReg);
                                tReg = world.CHARS.globalToLocal(tReg);
                                if ((((!(strF == null)) && (strF == world.strFrame)) && (cLeaf.intState > 0)))
                                {
                                    if (cAvt != tAvt)
                                    {
                                        if ((tReg.x - cReg.x) >= 0)
                                        {
                                            cAvt.pMC.turn("right");
                                        }
                                        else
                                        {
                                            cAvt.pMC.turn("left");
                                        };
                                    };
                                    if (((((!(anim.fx == "p")) && (!(anim.fx == "w"))) && (!(anim.fx == ""))) && (((Math.abs((cReg.x - tReg.x)) * world.SCALE) > 160) || ((Math.abs((cReg.y - tReg.y)) * world.SCALE) > 15))))
                                    {
                                        buffer = int((110 + (Math.random() * 50)));
                                        xBuffer = (((tReg.x - cReg.x) >= 0) ? -(buffer) : buffer);
                                        xBuffer = int((xBuffer * world.SCALE));
                                        if ((((tReg.x + xBuffer) < 0) || ((tReg.x + xBuffer) > 960)))
                                        {
                                            xBuffer = (xBuffer * -1);
                                        };
                                        buffer = int(((Math.random() * 30) - 15));
                                        yBuffer = (((tReg.y - cReg.y) >= 0) ? -(buffer) : buffer);
                                        yBuffer = int((yBuffer * world.SCALE));
                                        cAvt.pMC.walkTo((tReg.x + xBuffer), (tReg.y + yBuffer), 32);
                                    };
                                    if (cAvt.pMC.spFX != null)
                                    {
                                        cAvt.pMC.spFX.avt = cAvt.target;
                                    };
                                    cReg = cAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    tReg = tAvt.pMC.mcChar.localToGlobal(new Point(0, 0));
                                    if (cAvt != tAvt)
                                    {
                                        if ((tReg.x - cReg.x) >= 0)
                                        {
                                            cAvt.pMC.turn("right");
                                        }
                                        else
                                        {
                                            cAvt.pMC.turn("left");
                                        };
                                    };
                                    if (litePreference.data.bDisMonAnim)
                                    {
                                        return;
                                    };
                                    if (animStr.length > 1)
                                    {
                                        if (animStr.indexOf(",") > -1)
                                        {
                                            if (world.objExtra["bChar"] == 1)
                                            {
                                                animString = cAvt.pMC.Animation;
                                                MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(animString);
                                            }
                                            else
                                            {
                                                anims = animStr.split(",");
                                                animIndex = uint(Math.round((Math.random() * (anims.length - 1))));
                                                MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(anims[animIndex]);
                                            };
                                        }
                                        else
                                        {
                                            if (world.objExtra["bChar"] == 1)
                                            {
                                                animString = cAvt.pMC.Animation;
                                                MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(animString);
                                            }
                                            else
                                            {
                                                MovieClip(cAvt.pMC.getChildAt(1)).gotoAndPlay(animStr);
                                            };
                                        };
                                    };
                                };
                            };
                            break;
                    };
                };
            };
        }

        public function key_StageLogin(e:KeyboardEvent):*
        {
            if (e.target == stage)
            {
                if ((e.keyCode == Keyboard.ENTER))
                {
                    stage.focus = mcLogin.ni;
                };
            };
        }

        public function isSpecificItem(item:String):Boolean
        {
            switch (item)
            {
                case "Lucky Suit Treasure Chest":
                case "Unlucky Suit Treasure Chest":
                case "Apocalyptic LichMoglin on your Back":
                    return (true);
            };
            return (false);
        }

        public function hasBankItem():Boolean
        {
            var item:*;
            for each (item in world.myAvatar.items)
            {
                if (((((item.sName.indexOf(" Bank") > -1) || ((item.sType == "Pet") && (item.sName.indexOf(" Moglin Plush Pet") > -1))) || (item.sDesc.indexOf(" Bank Pet ") > -1)) || (isSpecificItem(item.sName))))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function key_StageGame(e:KeyboardEvent):*
        {
            var mons:Array;
            var cacheFrame:String;
            var tgt:uint;
            var cameraToolMC:MovieClip;
            var worldCameraMC:MovieClip;
            var _cd:int;
            if (((e.target) && (e.target.name == "btnSetKeybindActive")))
            {
                return;
            };
            if (!("text" in e.target))
            {
                if (((e.keyCode == Keyboard.ENTER) || (String.fromCharCode(e.charCode) == "/")))
                {
                    chatF.openMsgEntry();
                };
                if (isNumpadKey(e.keyCode))
                {
                    e.keyCode = (e.keyCode - 48);
                };
                if (String.fromCharCode(e.charCode) == "w" && (world.myAvatar.isStaff()))
                {
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus)))))))
                    {
                        toggleTradePanel();
                    };
                };
                if ((String.fromCharCode(e.charCode) == "m") && (world.myAvatar.isStaff()))
                {
                    if ((((stage.focus == null)) || (((!((stage.focus == null))) && (!(("text" in stage.focus)))))))
                    {
                        toggleAuctionPanel();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Target Random Monster"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        mons = world.getMonstersByCell(world.strFrame);
                        cacheFrame = world.strFrame;
                        if (mons.length > 0)
                        {
                            tgt = uint(Math.round((Math.random() * (mons.length - 1))));
                            while ((((((mons.length > 1) && (!(mons[tgt]))) && (!(mons[tgt].pMC))) && (mons[tgt].dataLeaf.intState == 0)) && (world.myAvatar.target == mons[tgt])))
                            {
                                if (world.strFrame != cacheFrame)
                                {
                                    break;
                                };
                                tgt = uint(Math.round((Math.random() * (mons.length - 1))));
                            };
                            if (world.strFrame == cacheFrame)
                            {
                                if (((((mons[tgt]) && (mons[tgt].pMC)) && (mons[tgt].dataLeaf.strFrame == world.strFrame)) && (!(mons[tgt].dataLeaf.intState == 0))))
                                {
                                    world.setTarget(mons[tgt]);
                                };
                            };
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["Travel Menu's Travel"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        if (ui.getChildByName("mcTravelMenu"))
                        {
                            (ui.getChildByName("mcTravelMenu") as MovieClip).dispatchTravel();
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["Camera Tool"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        if (((stage.getChildByName("worldCameraMC")) || (getChildByName("cameraToolMC"))))
                        {
                            return;
                        };
                        cameraToolMC = new cameraTool(this);
                        cameraToolMC.name = "cameraToolMC";
                        cameraToolMC.x = -7;
                        addChild(cameraToolMC);
                        world.visible = false;
                    };
                };
                if (e.keyCode == litePreference.data.keys["World Camera"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        if (((stage.getChildByName("worldCameraMC")) || (getChildByName("cameraToolMC"))))
                        {
                            if (stage.getChildByName("worldCameraMC"))
                            {
                                MovieClip(stage.getChildByName("worldCameraMC")).dispatchExit();
                            };
                            return;
                        };
                        worldCameraMC = new worldCamera(this);
                        worldCameraMC.name = "worldCameraMC";
                        stage.addChild(worldCameraMC);
                    };
                };
                if ((String.fromCharCode(e.charCode) == ">"))
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        if (((!(chatF.pmSourceA[0] == null)) && (chatF.pmSourceA[0].length >= 1)))
                        {
                            chatF.openPMsg(chatF.pmSourceA[0]);
                            if (intChatMode)
                            {
                                ui.mcInterface.ncText.text = "> ";
                            }
                            else
                            {
                                ui.mcInterface.te.text = "> ";
                            };
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["Inventory"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        ui.mcInterface.mcMenu.toggleInventory();
                    };
                };
                if (((e.keyCode == litePreference.data.keys["Bank"]) && ((world.myAvatar.isStaff()) || (hasBankItem()))))
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        world.toggleBank();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Quest Log"])
                {
                    if ((((!(stage.focus == ui.mcInterface.te)) && (!(stage.focus == ui.mcInterface.ncText))) && (!(stage.focus == ui.mcInterface.ncText))))
                    {
                        world.toggleQuestLog();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Friends List"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        if (ui.mcOFrame.isOpen)
                        {
                            ui.mcOFrame.fClose();
                        }
                        else
                        {
                            world.showFriendsList();
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["Character Panel"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        toggleCharpanel("overview");
                    };
                };
                if (e.keyCode == litePreference.data.keys["Player HP Bar"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        world.toggleHPBar();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Options"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        if (ui.mcPopup.currentLabel == "Option")
                        {
                            ui.mcPopup.onClose();
                        }
                        else
                        {
                            ui.mcPopup.fOpen("Option");
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["Area List"])
                {
                    if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
                    {
                        if (!ui.mcOFrame.isOpen)
                        {
                            world.sendWhoRequest();
                        }
                        else
                        {
                            ui.mcOFrame.fClose();
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["Jump"])
                {
                    if (((!(stage.focus == ui.mcInterface.te)) && (!(stage.focus == ui.mcInterface.ncText))))
                    {
                        world.myAvatar.pMC.mcChar.gotoAndPlay("Jump");
                    };
                };
                if (e.keyCode == litePreference.data.keys["Rest"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        world.rest();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Hide Monsters"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        world.toggleMonsters();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Hide Players"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        optionHandler.cmd(MovieClip(this), "Hide Players");
                    };
                };
                if (e.keyCode == litePreference.data.keys["Cancel Target"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        if (cancelTargetTimer.running)
                        {
                            return;
                        };
                        if (((!(world.autoActionTimer == null)) && (world.autoActionTimer.running)))
                        {
                            world.cancelAutoAttack();
                            world.myAvatar.pMC.mcChar.gotoAndStop("Idle");
                        };
                        if (world.myAvatar.target != null)
                        {
                            world.setTarget(null);
                        };
                        if (!cancelTargetTimer.hasEventListener(TimerEvent.TIMER))
                        {
                            cancelTargetTimer.addEventListener(TimerEvent.TIMER, hasCanceledAlready, false, 0, true);
                        };
                        _cd = parseInt(world.getActionByRef(world.actionMap[0]).cd);
                        cancelTargetTimer.delay = ((_cd < 2000) ? 2000 : _cd);
                        cancelTargetTimer.start();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Hide UI"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        optionHandler.cmd(MovieClip(this), "Hide UI");
                    };
                };
                if (e.keyCode == litePreference.data.keys["Battle Analyzer"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        optionHandler.cmd(MovieClip(this), "Battle Analyzer");
                    };
                };
                if (e.keyCode == litePreference.data.keys["Decline All Drops"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        optionHandler.cmd(MovieClip(this), "Decline All Drops");
                    };
                };
                if (e.keyCode == litePreference.data.keys["Stats Overview"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        toggleStatspanel();
                    };
                };
                if (e.keyCode == litePreference.data.keys["Battle Analyzer Toggle"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        if (bAnalyzer)
                        {
                            bAnalyzer.toggle();
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["Custom Drops UI"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        if (((ui.mcPortrait.iconDrops) && (ui.mcPortrait.iconDrops.visible)))
                        {
                            ui.mcPortrait.iconDrops.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
                        };
                    };
                };
                if (e.keyCode == litePreference.data.keys["@ Debugger - Cell Menu"])
                {
                    if (((!(e.target == ui.mcInterface.te)) && (!(e.target == ui.mcInterface.ncText))))
                    {
                        if (cMenuUI)
                        {
                            cMenuUI.toggle();
                        };
                    };
                };
            };
        }

        private function hasCanceledAlready(e:TimerEvent):void
        {
            cancelTargetTimer.removeEventListener(TimerEvent.TIMER, hasCanceledAlready);
            stage.focus = null;
        }

        public function key_TextLogin(e:KeyboardEvent):*
        {
            if (e.target != stage)
            {
                if ((e.keyCode == Keyboard.ENTER))
                {
                    onLoginClick(null);
                };
            };
        }

        public function key_ChatEntry(e:KeyboardEvent):*
        {
            if (e.keyCode == Keyboard.ENTER)
            {
                chatF.submitMsg(((intChatMode) ? ui.mcInterface.ncText.text : ui.mcInterface.te.text), chatF.chn.cur.typ, chatF.pmNm);
            };
            if (e.keyCode == Keyboard.ESCAPE)
            {
                chatF.closeMsgEntry();
            };
        }

        public function talk(params:*):*
        {
            if (params.accept)
            {
                chatF.submitMsg(params.emote1, "emote", sfc.myUserName);
            }
            else
            {
                chatF.submitMsg(params.emote2, "emote", sfc.myUserName);
            };
        }

        public function isNumpadKey(code:uint):Boolean
        {
            return ((code >= 96) && (code <= 105));
        }

        public function key_actBar(e:KeyboardEvent):*
        {
            var actMapID:int;
            var action:String;
            var actionObj:*;
            if (((e.target) && (e.target.name == "btnSetKeybindActive")))
            {
                return;
            };
            if (((stage.focus == null) || ((!(stage.focus == null)) && (!("text" in stage.focus)))))
            {
                if (isNumpadKey(e.keyCode))
                {
                    e.keyCode = (e.keyCode - 48);
                };
                switch (e.keyCode)
                {
                    case litePreference.data.keys["Auto Attack"]:
                        actMapID = 0;
                        world.approachTarget();
                        return;
                    case litePreference.data.keys["Skill 1"]:
                        actMapID = 1;
                        if (world.actionMap[actMapID] != null)
                        {
                            actionObj = world.getActionByRef(world.actionMap[actMapID]);
                            if (actionObj.isOK)
                            {
                                world.testAction(actionObj);
                            };
                        };
                        break;
                    case litePreference.data.keys["Skill 2"]:
                        actMapID = 2;
                        if (world.actionMap[actMapID] != null)
                        {
                            actionObj = world.getActionByRef(world.actionMap[actMapID]);
                            if (actionObj.isOK)
                            {
                                world.testAction(actionObj);
                            };
                        };
                        break;
                    case litePreference.data.keys["Skill 3"]:
                        actMapID = 3;
                        if (world.actionMap[actMapID] != null)
                        {
                            actionObj = world.getActionByRef(world.actionMap[actMapID]);
                            if (actionObj.isOK)
                            {
                                world.testAction(actionObj);
                            };
                        };
                        break;
                    case litePreference.data.keys["Skill 4"]:
                        actMapID = 4;
                        if (world.actionMap[actMapID] != null)
                        {
                            actionObj = world.getActionByRef(world.actionMap[actMapID]);
                            if (actionObj.isOK)
                            {
                                world.testAction(actionObj);
                            };
                        };
                        break;
                    case litePreference.data.keys["Skill 5"]:
                        actMapID = 5;
                        if (world.actionMap[actMapID] != null)
                        {
                            actionObj = world.getActionByRef(world.actionMap[actMapID]);
                            if (actionObj.isOK)
                            {
                                world.testAction(actionObj);
                            };
                        };
                        break;
                };
            };
        }

        public function getKeyboardDict():Dictionary
        {
            var updateName:String;
            var keyDescription:XML = describeType(Keyboard);
            var keyNames:XMLList = keyDescription.constant.@name;
            var keyboardDict:Dictionary = new Dictionary();
            var len:int = keyNames.length();
            var i:int;
            while (i < len)
            {
                updateName = keyNames[i];
                if ((((keyNames[i].indexOf("NUMBER_") > -1) || (keyNames[i].indexOf("STRING_") > -1)) || (keyNames[i].indexOf("KEYNAME_") > -1)))
                {
                    updateName = keyNames[i].split("_")[1];
                };
                keyboardDict[Keyboard[keyNames[i]]] = updateName;
                i++;
            };
            return (keyboardDict);
        }

        public function decHex(val:*):*
        {
            return (val.toString(16));
        }

        public function hexDec(val:*):*
        {
            return (parseInt(val, 16));
        }

        public function modColor(col:*, amt:*, op:*):String
        {
            var a:*;
            var b:*;
            var c:*;
            var out:* = "";
            var i:* = 0;
            while (i < 3)
            {
                a = hexDec(col.substr((i * 2), 2));
                b = hexDec(amt.substr((i * 2), 2));
                switch (op)
                {
                    case "-":
                    default:
                        c = (a - b);
                        if (c < 0)
                        {
                            c = 0;
                        };
                        c = decHex(c);
                        break;
                    case "+":
                        c = (a + b);
                        if (c > 0xFF)
                        {
                            c = 0xFF;
                        };
                        c = decHex(c);
                };
                out = (out + String(((c.length < 2) ? ("0" + c) : c)));
                i++;
            };
            return (out);
        }

        internal function replaceString(str:String, find:String, replace:String):String
        {
            var startIndex:Number = 0;
            var oldIndex:Number = 0;
            var newString:String = "";
            while ((startIndex = str.indexOf(find, startIndex)) != -1)
            {
                newString = (newString + (str.substring(oldIndex, startIndex) + replace));
                oldIndex = (startIndex = (startIndex + find.length));
            };
            return ((newString == "") ? str : newString);
        }

        public function stripWhite(str:String):String
        {
            str = str.split("\r").join("");
            str = str.split("\t").join("");
            str = str.split(" ").join("");
            return (str);
        }

        public function stripWhiteStrict(str:String):String
        {
            str = stripWhite(str);
            var i:int;
            while (i < chatF.strictComparisonChars.length)
            {
                str = str.split(chatF.strictComparisonChars.substr(i, 1)).join("");
                i++;
            };
            return (str);
        }

        public function stripWhiteStrictB(str:String):String
        {
            str = stripWhite(str);
            var i:int;
            while (i < chatF.strictComparisonCharsB.length)
            {
                str = str.split(chatF.strictComparisonCharsB.substr(i, 1)).join("");
                i++;
            };
            return (str);
        }

        public function stripMarks(str:String):String
        {
            var i:int;
            while (i < chatF.markChars.length)
            {
                str = str.split(chatF.markChars.substr(i, 1)).join("");
                i++;
            };
            return (str);
        }

        public function stripDuplicateVowels(s:String):String
        {
            s = s.replace(chatF.regExpA, "a");
            s = s.replace(chatF.regExpE, "e");
            s = s.replace(chatF.regExpI, "i");
            s = s.replace(chatF.regExpO, "o");
            s = s.replace(chatF.regExpU, "u");
            s = s.replace(chatF.regExpSPACE, " ");
            return (s);
        }

        public function maskStringBetween(input:String, indeces:Array):String
        {
            var j:int;
            var i:int;
            var s:String = "";
            if (((indeces.length > 0) && ((indeces.length % 2) == 0)))
            {
                j = 0;
                i = 0;
                while (i < input.length)
                {
                    if (((i >= indeces[j]) && (i <= indeces[(j + 1)])))
                    {
                        if (input.charAt(i) == " ")
                        {
                            s = (s + " ");
                        }
                        else
                        {
                            s = (s + "*");
                        };
                        if (i == indeces[(j + 1)])
                        {
                            j = (j + 2);
                        };
                    }
                    else
                    {
                        s = (s + input.charAt(i));
                    };
                    i++;
                };
            }
            else
            {
                trace("");
                trace("Utility.maskStringBetween() > Malformed indeces array.  Must be in format [start,end, start,end, etc]");
                trace("");
            };
            return (s);
        }

        public function arraySort(a:String, b:String):int
        {
            if (a == "House")
            {
                return (1);
            };
            if (a > b)
            {
                return (1);
            };
            if (a < b)
            {
                return (-1);
            };
            return (0);
        }

        public function convertBubbleText(str:String):String
        {
            var s:String;
            s = world.myAvatar.objData.strUsername;
            if (str.indexOf("@name"))
            {
                str = str.split("@name").join(s);
            };
            s = String(world.myAvatar.objData.intLevel);
            if (str.indexOf("@level"))
            {
                str = str.split("@level").join(s);
            };
            s = world.myAvatar.objData.strClassName;
            if (str.indexOf("@class"))
            {
                str = str.split("@class").join(s);
            };
            s = ((world.myAvatar.objData.strGender.toLowerCase() == "m") ? "Mr." : "Mrs.");
            if (str.indexOf("@prefix"))
            {
                str = str.split("@prefix").join(s);
            };
            s = ((world.myAvatar.objData.strGender.toLowerCase() == "m") ? "He" : "She");
            if (str.indexOf("@He"))
            {
                str = str.split("@prefix").join(s);
            };
            s = ((world.myAvatar.objData.strGender.toLowerCase() == "m") ? "Him" : "Her");
            if (str.indexOf("@Him"))
            {
                str = str.split("@prefix").join(s);
            };
            s = ((world.myAvatar.objData.strGender.toLowerCase() == "m") ? "His" : "Her");
            if (str.indexOf("@His"))
            {
                str = str.split("@prefix").join(s);
            };
            s = ((world.myAvatar.objData.strGender.toLowerCase() == "m") ? "he" : "she");
            if (str.indexOf("@he"))
            {
                str = str.split("@prefix").join(s);
            };
            s = ((world.myAvatar.objData.strGender.toLowerCase() == "m") ? "him" : "her");
            if (str.indexOf("@him"))
            {
                str = str.split("@prefix").join(s);
            };
            s = ((world.myAvatar.objData.strGender.toLowerCase() == "m") ? "his" : "her");
            if (str.indexOf("@his"))
            {
                str = str.split("@prefix").join(s);
            };
            return (str);
        }

        public function strToProperCase(str:String):String
        {
            str = (str.slice(0, 1).toUpperCase() + str.slice(1, str.length).toLowerCase());
            return (str);
        }

        public function strSetCharAt(str:String, index:int, strChar:String):String
        {
            return ((str.substring(0, index) + strChar) + str.substring((index + 1), str.length));
        }

        public function strNumWithCommas(num:Number):String
        {
            var s:String = "";
            var n:String = num.toString();
            var i:int;
            var j:int;
            i = (n.length - 1);
            while (i > -1)
            {
                if (j == 3)
                {
                    j = 0;
                    s = ((n.charAt(i) + ",") + s);
                }
                else
                {
                    s = (n.charAt(i) + s);
                };
                j++;
                i--;
            };
            return (s);
        }

        public function numToStr(n:Number, decimals:int = 2):String
        {
            var s:String = n.toString();
            if (s.indexOf(".") == -1)
            {
                s = (s + ".");
            };
            var a:Array = s.split(".");
            while (a[1].length < decimals)
            {
                a[1] = (a[1] + "0");
            };
            if (a[1].length > decimals)
            {
                a[1] = a[1].substr(0, decimals);
            };
            if (decimals > 0)
            {
                s = ((a[0] + ".") + a[1]);
            }
            else
            {
                s = a[0];
            };
            return (s);
        }

        public function copyObj(obj:Object):Object
        {
            var objB:ByteArray = new ByteArray();
            objB.writeObject(obj);
            objB.position = 0;
            return (objB.readObject());
        }

        public function copyConstructor(obj:*):*
        {
            var objB:ByteArray = new ByteArray();
            objB.writeObject(obj);
            objB.position = 0;
            return (objB.readObject() as Class);
        }

        public function distanceO(oa:*, ob:*):Number
        {
            return (Math.sqrt((Math.pow(int((ob.x - oa.x)), 2) + Math.pow(int((ob.y - oa.y)), 2))));
        }

        public function distanceP(ax:*, ay:*, bx:*, by:*):Number
        {
            return (Math.sqrt((Math.pow((bx - ax), 2) + Math.pow((by - ay), 2))));
        }

        public function distanceXY(ax:*, ay:*, bx:*, by:*):Object
        {
            return ({
                        "dx": (bx - ax),
                        "dy": (by - ay)
                    });
        }

        public function isHouseItem(obj:Object):Boolean
        {
            return (((obj.sType == "House") || (obj.sType == "Floor Item")) || (obj.sType == "Wall Item"));
        }

        internal function validateArmor(item:*):*
        {
            var i:uint;
            var j:uint;
            var reqIDs:Array = [];
            var reqClass:Object = {};
            var classRank:int;
            var maxRank:int = 10;
            var classOK:Boolean = true;
            var doCheck:Boolean;
            var orCheck:Boolean;
            var itemID:int = item.ItemID;
            switch (itemID)
            {
                default:
                    break;
                case 319:
                case 2083:
                    doCheck = true;
                    reqIDs = [16, 15654, 407, 20, 15651, 409];
                    break;
                case 409:
                    orCheck = true;
                    reqIDs = [20, 15651];
                    break;
                case 408:
                    orCheck = true;
                    reqIDs = [17, 15653];
                    break;
                case 410:
                    orCheck = true;
                    reqIDs = [18, 15652];
                    break;
                case 407:
                    orCheck = true;
                    reqIDs = [16, 15654];
            };
            if (doCheck)
            {
                i = 0;
                while (i < reqIDs.length)
                {
                    if (world.myAvatar.getCPByID(reqIDs[i]) < 302500)
                    {
                        classOK = false;
                    }
                    else
                    {
                        classOK = true;
                        if (i < 2)
                        {
                            i = 2;
                        };
                        if (((i < 5) && (i > 2)))
                            break;
                    };
                    i++;
                };
                return (classOK);
            };
            if (orCheck)
            {
                j = 0;
                while (j < reqIDs.length)
                {
                    if (world.myAvatar.getCPByID(reqIDs[j]) >= item.iReqCP)
                    {
                        return (true);
                    };
                    j++;
                };
                return (false);
            };
            return (!((Number(item.iClass) > 0) && (world.myAvatar.getCPByID(item.iClass) < item.iReqCP)));
        }

        public function getItemInfoString(obj:Object):String
        {
            var iRank:int;
            var iSpillCP:*;
            var iRankRep:int;
            var iSpillRep:*;
            var HPTgt:*;
            var TTD:*;
            var iDPS:*;
            var iRng:*;
            var wSPD:*;
            var wDPS:*;
            var wDMG:*;
            var wDMN:*;
            var wDMX:*;
            var strItemInfo:* = (("<font size='14'><b>" + obj.sName) + "</b></font><br>");
            if (((!(validateArmor(obj))) && (obj.iClass > 0)))
            {
                strItemInfo = (strItemInfo + "<font size='11' color='#CC0000'>");
                iRank = getRankFromPoints(obj.iReqCP);
                iSpillCP = (obj.iReqCP - arrRanks[(iRank - 1)]);
                if (iSpillCP > 0)
                {
                    strItemInfo = (strItemInfo + (((((("Requires " + iSpillCP) + " Class Points on ") + obj.sClass) + ", Rank ") + iRank) + "."));
                }
                else
                {
                    strItemInfo = (strItemInfo + (((("Requires " + obj.sClass) + ", Rank ") + iRank) + "."));
                };
                strItemInfo = (strItemInfo + "</font><br>");
            };
            if (((obj.FactionID > 1) && (world.myAvatar.getRep(obj.FactionID) < obj.iReqRep)))
            {
                strItemInfo = (strItemInfo + "<font size='11' color='#CC0000'>");
                iRankRep = getRankFromPoints(obj.iReqRep);
                iSpillRep = (obj.iReqRep - arrRanks[(iRank - 1)]);
                if (iSpillRep > 0)
                {
                    strItemInfo = (strItemInfo + (((((("Requires " + iSpillRep) + " Reputation on ") + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                }
                else
                {
                    strItemInfo = (strItemInfo + (((("Requires " + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                };
                strItemInfo = (strItemInfo + "</font><br>");
            };
            if (((obj.iQSindex >= 0) && (world.getQuestValue(obj.iQSindex) < int(obj.iQSvalue))))
            {
                strItemInfo = (strItemInfo + (("<font size='11' color='#CC0000'>Requires completion of quest \"" + obj.sQuest) + '".</font><br>'));
            };
            strItemInfo = (strItemInfo + ("<font color='#009900'><b>" + getDisplaysType(obj)));
            if ((((!(obj.sES == "None")) && (!(obj.sES == "co"))) && (!(obj.sES == "mi"))))
            {
                if (obj.EnhID > 0)
                {
                    strItemInfo = (strItemInfo + (", Lvl " + obj.EnhLvl));
                    if (obj.sES == "Weapon")
                    {
                        HPTgt = getBaseHPByLevel(obj.EnhLvl);
                        TTD = 20;
                        iDPS = 1;
                        iRng = (obj.iRng / 100);
                        wSPD = 2;
                        wDPS = Math.round(((HPTgt / TTD) * iDPS));
                        wDMG = Math.round((wDPS * wSPD));
                        wDMN = Math.floor((wDMG - (wDMG * iRng)));
                        wDMX = Math.ceil((wDMG + (wDMG * iRng)));
                        strItemInfo = (strItemInfo + ((((("<br>" + wDMN) + " - ") + wDMX) + " ") + obj.sElmt));
                    };
                }
                else
                {
                    strItemInfo = (strItemInfo + " Design");
                };
            };
            obj.sDesc = obj.sDesc.replace(regExLineSpace, "\n");
            strItemInfo = (strItemInfo + (("</b></font><br>" + obj.sDesc) + "<br>"));
            return (strItemInfo);
        }

        public function getItemInfoStringB(obj:Object):String
        {
            var iRank:int;
            var iSpillCP:*;
            var iRankRep:int;
            var iSpillRep:*;
            var strItemInfo:* = (("<font size='12'><b>" + obj.sName) + "</b></font><br>");
            if (((!(validateArmor(obj))) && (obj.iClass > 0)))
            {
                strItemInfo = (strItemInfo + "<font size='10' color='#CC0000'>");
                iRank = getRankFromPoints(obj.iReqCP);
                iSpillCP = (obj.iReqCP - arrRanks[(iRank - 1)]);
                if (iSpillCP > 0)
                {
                    strItemInfo = (strItemInfo + (((((("Requires " + iSpillCP) + " Class Points on ") + obj.sClass) + ", Rank ") + iRank) + "."));
                }
                else
                {
                    strItemInfo = (strItemInfo + (((("Requires " + obj.sClass) + ", Rank ") + iRank) + "."));
                };
                strItemInfo = (strItemInfo + "</font><br>");
            };
            if (((obj.FactionID > 1) && (world.myAvatar.getRep(obj.FactionID) < obj.iReqRep)))
            {
                strItemInfo = (strItemInfo + "<font size='10' color='#CC0000'>");
                iRankRep = getRankFromPoints(obj.iReqRep);
                iSpillRep = (obj.iReqRep - arrRanks[(iRank - 1)]);
                if (iSpillRep > 0)
                {
                    strItemInfo = (strItemInfo + (((((("Requires " + iSpillRep) + " Reputation on ") + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                }
                else
                {
                    strItemInfo = (strItemInfo + (((("Requires " + obj.sFaction) + ", Rank ") + iRankRep) + "."));
                };
                strItemInfo = (strItemInfo + "</font><br>");
            };
            if (((obj.iQSindex >= 0) && (world.getQuestValue(obj.iQSindex) < int(obj.iQSvalue))))
            {
                strItemInfo = (strItemInfo + (("<font size='11' color='#CC0000'>Requires completion of quest \"" + obj.sQuest) + '".</font><br>'));
            };
            if ((((!(obj.sMeta == null)) && (getDisplaysType(obj) == "Pet")) && (obj.sMeta.indexOf("Necromancer") > -1)))
            {
                strItemInfo = (strItemInfo + ("<font color='#00CCFF'><b>Battle " + getDisplaysType(obj)));
            }
            else
            {
                strItemInfo = (strItemInfo + ("<font color='#00CCFF'><b>" + getDisplaysType(obj)));
                if (obj.iStk > 1)
                {
                    strItemInfo = (strItemInfo + (((" - " + obj.iQty) + "/") + obj.iStk));
                };
            };
            if (obj.sType.toLowerCase() == "enhancement")
            {
                strItemInfo = (strItemInfo + (", Level " + obj.iLvl));
            };
            if (((((!(obj.sES == "None")) && (!(obj.sES == "co"))) && (!(obj.sES == "pe"))) && (!(obj.sES == "mi"))))
            {
                if (obj.EnhID > 0)
                {
                    strItemInfo = (strItemInfo + (", Level " + obj.EnhLvl));
                    if (obj.sES == "ar")
                    {
                        strItemInfo = (strItemInfo + ("<br>Rank " + getRankFromPoints(obj.iQty)));
                    };
                }
                else
                {
                    if (obj.sType.toLowerCase() != "enhancement")
                    {
                        strItemInfo = (strItemInfo + " Design");
                    };
                };
            };
            if (((((((obj.sES == "Weapon") || (obj.sES == "co")) || (obj.sES == "he")) || (obj.sES == "ba")) || (obj.sES == "pe")) || (obj.sES == "am")))
            {
                if (obj.sType.toLowerCase() != "enhancement")
                {
                    strItemInfo = (strItemInfo + (("<br>" + getRarityString(obj.iRty)) + " Rarity"));
                };
            };
            if (obj.sType.toLowerCase() != "enhancement")
            {
                obj.sDesc = obj.sDesc.replace(regExLineSpace, "\n");
                strItemInfo = (strItemInfo + (("</b></font><br><font size='10' color='#FFFFFF'>" + obj.sDesc) + "<br></font>"));
            }
            else
            {
                strItemInfo = (strItemInfo + "</b></font><br><font size='10' color='#FFFFFF'>");
                strItemInfo = (strItemInfo + "Enhancements are special items which can apply stats to your weapons and armor. Select a weapon or armor item from the list on the right, and click the <font color='#00CCFF'>\"Enhancements\"</font> button that appears below its preview.");
            };
            return (strItemInfo);
        }

        public function getIconByType(sType:String):String
        {
            var iconStr:String = "";
            switch (sType.toLowerCase())
            {
                case "axe":
                case "bow":
                case "dagger":
                case "gun":
                case "mace":
                case "polearm":
                case "staff":
                case "sword":
                case "wand":
                case "armor":
                    iconStr = ("iw" + sType.toLowerCase());
                    break;
                case "cape":
                case "helm":
                case "pet":
                case "class":
                    iconStr = ("ii" + sType.toLowerCase());
                    break;
                default:
                    iconStr = "iibag";
            };
            return (iconStr);
        }

        public function getIconBySlot(slot:String):String
        {
            var iconStr:String = "";
            switch (slot.toLowerCase())
            {
                case "weapon":
                    iconStr = "iwsword";
                    break;
                case "back":
                case "ba":
                    iconStr = "iicape";
                    break;
                case "head":
                case "he":
                    iconStr = "iihelm";
                    break;
                case "armor":
                case "ar":
                    iconStr = "iiclass";
                    break;
                case "class":
                    iconStr = "iiclass";
                    break;
                case "pet":
                case "pe":
                    iconStr = "iipet";
                    break;
                default:
                    iconStr = "iibag";
            };
            return (iconStr);
        }

        public function getDisplaysType(item:Object):*
        {
            var s:String = ((item.sType != null) ? item.sType : "Unknown");
            var t:String = s.toLowerCase();
            if (((t == "clientuse") || (t == "serveruse")))
            {
                s = "Item";
            };
            return (s);
        }

        public function stringToDate(strODBC:String):Date
        {
            var numYear:* = Number(strODBC.substr(0, 4));
            var numMonth:* = (Number(strODBC.substr(5, 2)) - 1);
            var numDate:* = Number(strODBC.substr(8, 2));
            var numHour:* = Number(strODBC.substr(11, 2));
            var numMins:* = Number(strODBC.substr(14, 2));
            var numSecs:* = Number(strODBC.substr(17));
            return (new Date(numYear, numMonth, numDate, numHour, numMins, numSecs));
        }

        internal function traceObject(obj:*, n:* = 1):*
        {
            var i:*;
            var v:*;
            var s:* = "";
            while (s.length < n)
            {
                s = (s + " ");
            };
            n++;
            if (((typeof (obj) == "object") && (!(obj.length == null))))
            {
                i = 0;
                while (i < obj.length)
                {
                    trace((((s + i) + ": ") + obj[i]));
                    i++;
                };
            }
            else
            {
                for (v in obj)
                {
                    trace((((s + v) + ": ") + obj[v]));
                    if (typeof (obj[v]) == "object")
                    {
                        traceObject(obj[v], n);
                    };
                };
            };
        }

        public function max(num1:int, num2:int):int
        {
            if (num1 > num2)
            {
                return (num1);
            };
            return (num2);
        }

        public function clamp(val:Number, mn:Number, mx:Number):Number
        {
            if (val < mn)
            {
                return (mn);
            };
            if (val > mx)
            {
                return (mx);
            };
            return (val);
        }

        public function isValidEmail(email:String):Boolean
        {
            return (Boolean(email.match(EMAIL_REGEX)));
        }

        public function closeToolTip():void
        {
            var tt:*;
            try
            {
                tt = MovieClip(stage.getChildAt(0)).ui.ToolTip;
                tt.close();
            }
            catch (e:Error)
            {
            };
        }

        public function updateIcons(actIcons:Array, iconArray:Array, item:Object = null):*
        {
            var actIconMC:MovieClip;
            var iconShapeClass:Class;
            var iconShape:*;
            var iconShapeMC:*;
            var aw:*;
            var ah:*;
            var bw:*;
            var bh:*;
            var i:int;
            var j:int;
            i = 0;
            while (i < actIcons.length)
            {
                actIconMC = actIcons[i];
                actIconMC.cnt.removeChildAt(0);
                actIconMC.item = item;
                if (actIconMC.item == null)
                {
                    actIconMC.tQty.visible = false;
                };
                while (j < iconArray.length)
                {
                    iconShapeClass = (world.getClass(iconArray[j]) as Class);
                    iconShape = new (iconShapeClass)();
                    iconShapeMC = actIconMC.cnt.addChild(iconShape);
                    aw = int(((42 - 8) + (4 * j)));
                    ah = int(((39 - 8) + (4 * j)));
                    bw = iconShapeMC.width;
                    bh = iconShapeMC.height;
                    if (bw > bh)
                    {
                        iconShapeMC.scaleX = (iconShapeMC.scaleY = (aw / bw));
                    }
                    else
                    {
                        iconShapeMC.scaleX = (iconShapeMC.scaleY = (ah / bh));
                    };
                    iconShapeMC.x = ((actIconMC.bg.width / 2) - (iconShapeMC.width / 2));
                    iconShapeMC.y = ((actIconMC.bg.height / 2) - (iconShapeMC.height / 2));
                    j++;
                };
                i++;
            };
        }

        public function updateActionObjIcon(actionObj:Object):void
        {
            var icon1:MovieClip;
            var item:Object;
            var iQty:int;
            var i:int;
            var actIcons:Array = world.getActIcons(actionObj);
            var j:* = 0;
            while (j < actIcons.length)
            {
                icon1 = actIcons[j];
                item = icon1.item;
                if (item != null)
                {
                    iQty = 0;
                    while (i < world.myAvatar.items.length)
                    {
                        if (world.myAvatar.items[i].ItemID == item.ItemID)
                        {
                            iQty = int(world.myAvatar.items[i].iQty);
                        };
                        i++;
                    };
                    if (iQty > 0)
                    {
                        icon1.tQty.visible = true;
                        icon1.tQty.text = iQty;
                    }
                    else
                    {
                        world.unequipUseableItem(item);
                    };
                };
                j++;
            };
        }

        public function drawChainsSmooth(entities:Array, c:int, spfxMC:MovieClip):void
        {
            var pSrc:Point;
            var pTgt:Point;
            var ei:int;
            var steps:Array;
            var i:int;
            var j:int;
            var n:int;
            var p:Point;
            var fxArr:Array;
            var mc:MovieClip;
            var sign:int;
            var b:int;
            ei = 1;
            while (ei < entities.length)
            {
                pSrc = new Point(0, 0);
                pTgt = new Point(0, 0);
                pSrc = entities[(ei - 1)].localToGlobal(pSrc);
                pTgt = entities[ei].localToGlobal(pTgt);
                steps = [];
                i = 0;
                j = 0;
                n = int(Math.ceil((Point.distance(pSrc, pTgt) / c)));
                if ((n % 2) == 1)
                {
                    n = (n + 1);
                };
                p = new Point();
                fxArr = [spfxMC.fx0, spfxMC.fx1, spfxMC.fx2];
                sign = -1;
                i = 0;
                while (i < fxArr.length)
                {
                    steps = [];
                    sign = int(((Math.random() > 0.5) ? 1 : -1));
                    b = 0;
                    j = 1;
                    while (j < n)
                    {
                        p = Point.interpolate(pSrc, pTgt, (1 - (j / n)));
                        if ((++b % 2) == 1)
                        {
                            p.x = (p.x + (sign * Math.round((Math.random() * 30))));
                            p.y = (p.y + (sign * Math.round((Math.random() * 30))));
                            sign = -(sign);
                        };
                        steps.push(p);
                        j++;
                    };
                    steps.push(pTgt);
                    mc = fxArr[i];
                    mc.graphics.lineStyle(2, 0xFFFFFF, 1);
                    mc.graphics.moveTo(pSrc.x, pSrc.y);
                    j = 0;
                    while (j < steps.length)
                    {
                        mc.graphics.curveTo(steps[j].x, steps[j].y, steps[(j + 1)].x, steps[(j + 1)].y);
                        j = (j + 2);
                    };
                    i++;
                };
                ei++;
            };
        }

        public function drawChainsLinear(entities:Array, c:int, spfxMC:MovieClip):void
        {
            var pSrc:Point;
            var pTgt:Point;
            var sMC:MovieClip;
            var tMC:MovieClip;
            var ei:int;
            var steps:Array;
            var i:int;
            var j:int;
            var n:int;
            var p:Point;
            var fxArr:Array;
            var mc:MovieClip;
            ei = 1;
            while (ei < entities.length)
            {
                sMC = entities[(ei - 1)];
                tMC = entities[ei];
                pSrc = new Point(0, (-(sMC.height) * 0.5));
                pTgt = new Point(0, (-(tMC.height) * 0.5));
                pSrc = sMC.localToGlobal(pSrc);
                pTgt = tMC.localToGlobal(pTgt);
                steps = [];
                i = 0;
                j = 0;
                n = int(Math.ceil((Point.distance(pSrc, pTgt) / c)));
                p = new Point();
                fxArr = [spfxMC.fx0, spfxMC.fx1, spfxMC.fx2];
                i = 0;
                while (i < fxArr.length)
                {
                    steps = [];
                    j = 1;
                    while (j < n)
                    {
                        p = Point.interpolate(pSrc, pTgt, (1 - (j / (n + 1))));
                        p.x = (p.x + Math.round(((Math.random() * 25) - 13)));
                        p.y = (p.y + Math.round(((Math.random() * 25) - 13)));
                        steps.push(p);
                        j++;
                    };
                    mc = fxArr[i];
                    mc.graphics.lineStyle(5, 0xFFFFFF, 1);
                    mc.graphics.moveTo(pSrc.x, pSrc.y);
                    j = 0;
                    while (j < steps.length)
                    {
                        mc.graphics.lineTo(steps[j].x, steps[j].y);
                        j++;
                    };
                    mc.graphics.lineTo(pTgt.x, pTgt.y);
                    i++;
                };
                ei++;
            };
        }

        public function drawFunnel(targetMCs:Array, cnt:MovieClip):void
        {
            var g:MovieClip;
            cnt.numLines = 3;
            cnt.lineThickness = 3;
            cnt.lineColors = [0x9900AA, 0, 0x220066];
            cnt.glowColors = [0];
            cnt.glowStrength = 4;
            cnt.glowSize = 4;
            cnt.dur = 500;
            cnt.del = 100;
            cnt.p1StartingValue = 0.12;
            cnt.p2StartingValue = 0.24;
            cnt.p3StartingValue = 0.36;
            cnt.p1EndingValue = 0.66;
            cnt.p2EndingValue = 0.825;
            cnt.p3EndingValue = 0.99;
            cnt.p1ScaleFactor = 0.5;
            cnt.p3ScaleFactor = 0.5;
            cnt.easingExponent = 1.5;
            cnt.targetMCs = targetMCs;
            cnt.filterArr = [];
            cnt.fxArr = [];
            cnt.ts = new Date().getTime();
            var glowI:int;
            var lineI:int;
            glowI = 0;
            while (glowI < cnt.glowColors.length)
            {
                cnt.filterArr.push([new GlowFilter(cnt.glowColors[glowI], 1, cnt.glowSize, cnt.glowSize, cnt.glowStrength, 1, false, false)]);
                glowI++;
            };
            glowI = 0;
            lineI = 0;
            var fi:int;
            while (fi < cnt.numLines)
            {
                g = (cnt.addChild(new MovieClip()) as MovieClip);
                g.filters = cnt.filterArr[glowI];
                if (++glowI >= cnt.glowColors.length)
                {
                    glowI = 0;
                };
                g.lineColor = cnt.lineColors[lineI];
                if (++lineI >= cnt.lineColors.length)
                {
                    lineI = 0;
                };
                cnt.fxArr.push(g);
                fi++;
            };
            cnt.addEventListener(Event.ENTER_FRAME, funnelEF, false, 0, true);
        }

        internal function funnelEF(e:Event):void
        {
            var mc:MovieClip;
            var fakeNow:Number;
            var fakeTS:Number;
            var pMid1o:Point;
            var pMid1t:Point;
            var pMid2o:Point;
            var pMid2t:Point;
            var pMid3o:Point;
            var pMid3t:Point;
            var lineColor:Number;
            var d:Number;
            var m:Number;
            var cnt:MovieClip = MovieClip(e.currentTarget);
            var now:Number = new Date().getTime();
            var p1:Point = new Point();
            var p2:Point = new Point();
            var p3:Point = new Point();
            var sign:int = 1;
            var sMC:MovieClip = cnt.targetMCs[0];
            var tMC:MovieClip = cnt.targetMCs[1];
            var pSrc:Point = sMC.localToGlobal(new Point(0, (-(sMC.height) / 2)));
            var pTgt:Point = tMC.localToGlobal(new Point(0, (-(tMC.height) / 2)));
            var pTgtW:* = tMC.width;
            var pTgtH:* = tMC.height;
            var dir:int = -1;
            var glowI:int;
            var lineI:int;
            var angle:Number = Math.atan2((pSrc.y - pTgt.y), (pSrc.x - pTgt.x));
            angle = (angle - (Math.PI / 2));
            var i:int;
            while (i < cnt.fxArr.length)
            {
                mc = cnt.fxArr[i];
                fakeTS = cnt.ts;
                fakeNow = (now - (i * cnt.del));
                if (fakeNow > (fakeTS + cnt.dur))
                {
                    if (mc.visible)
                    {
                        mc.visible = false;
                        mc.graphics.clear();
                    };
                    if (i == (cnt.fxArr.length - 1))
                    {
                        cnt.removeEventListener(Event.ENTER_FRAME, funnelEF);
                        if (cnt.parent != null)
                        {
                            cnt.parent.removeChild(cnt);
                        };
                    };
                }
                else
                {
                    if (fakeNow >= cnt.ts)
                    {
                        d = ((fakeNow - fakeTS) / cnt.dur);
                        d = Math.pow((1 - d), cnt.easingExponent);
                        sign = (((i % 2) == 0) ? 1 : -1);
                        pMid1o = new Point((Point.interpolate(pSrc, pTgt, cnt.p1StartingValue).x + Point.polar((sign * (tMC.height / cnt.p1ScaleFactor)), angle).x), (Point.interpolate(pSrc, pTgt, cnt.p1StartingValue).y + Point.polar((sign * (tMC.height / cnt.p1ScaleFactor)), angle).y));
                        pMid1t = new Point(Point.interpolate(pSrc, pTgt, cnt.p1EndingValue).x, Point.interpolate(pSrc, pTgt, cnt.p1EndingValue).y);
                        pMid2o = new Point(Point.interpolate(pSrc, pTgt, cnt.p2StartingValue).x, pTgt.y);
                        pMid2t = new Point(Point.interpolate(pSrc, pTgt, cnt.p2EndingValue).x, Point.interpolate(pSrc, pTgt, cnt.p2EndingValue).y);
                        pMid3o = new Point((Point.interpolate(pSrc, pTgt, cnt.p3StartingValue).x + Point.polar((-(sign) * (tMC.height / cnt.p3ScaleFactor)), angle).x), (Point.interpolate(pSrc, pTgt, cnt.p3StartingValue).y + Point.polar((-(sign) * (tMC.height / cnt.p3ScaleFactor)), angle).y));
                        pMid3t = new Point(Point.interpolate(pSrc, pTgt, cnt.p3EndingValue).x, Point.interpolate(pSrc, pTgt, cnt.p3EndingValue).y);
                        p1 = Point.interpolate(pMid1o, pMid1t, d);
                        p2 = Point.interpolate(pMid2o, pMid2t, d);
                        p3 = Point.interpolate(pMid3o, pMid3t, d);
                        lineColor = mc.lineColor;
                        mc.graphics.clear();
                        mc.graphics.lineStyle(cnt.lineThickness, lineColor, 1);
                        mc.graphics.moveTo(pTgt.x, pTgt.y);
                        mc.graphics.curveTo(p1.x, p1.y, p2.x, p2.y);
                        mc.graphics.curveTo(p3.x, p3.y, pSrc.x, pSrc.y);
                        m = Math.cos(((((fakeNow - fakeTS) / cnt.dur) * Math.PI) * 2));
                        m = ((m / 2) + 0.5);
                        m = (1 - m);
                        mc.alpha = m;
                    };
                };
                i++;
            };
        }

        public function updateCoreValues(o:Object):void
        {
            if (o.intLevelCap != null)
            {
                intLevelCap = o.intLevelCap;
            };
            if (o.PCstBase != null)
            {
                PCstBase = o.PCstBase;
            };
            if (o.PCstRatio != null)
            {
                PCstRatio = o.PCstRatio;
            };
            if (o.PCstGoal != null)
            {
                PCstGoal = o.PCstGoal;
            };
            if (o.GstBase != null)
            {
                GstBase = o.GstBase;
            };
            if (o.GstRatio != null)
            {
                GstRatio = o.GstRatio;
            };
            if (o.GstGoal != null)
            {
                GstGoal = o.GstGoal;
            };
            if (o.PChpBase1 != null)
            {
                PChpBase1 = o.PChpBase1;
            };
            if (o.PChpBase100 != null)
            {
                PChpBase100 = o.PChpBase100;
            };
            if (o.PChpGoal1 != null)
            {
                PChpGoal1 = o.PChpGoal1;
            };
            if (o.PChpGoal100 != null)
            {
                PChpGoal100 = o.PChpGoal100;
            };
            if (o.PChpDelta != null)
            {
                PChpDelta = o.PChpDelta;
            };
            if (o.intHPperEND != null)
            {
                intHPperEND = o.intHPperEND;
            };
            if (o.intAPtoDPS != null)
            {
                intAPtoDPS = o.intAPtoDPS;
            };
            if (o.intSPtoDPS != null)
            {
                intSPtoDPS = o.intSPtoDPS;
            };
            if (o.bigNumberBase != null)
            {
                bigNumberBase = o.bigNumberBase;
            };
            if (o.resistRating != null)
            {
                resistRating = o.resistRating;
            };
            if (o.modRating != null)
            {
                modRating = o.modRating;
            };
            if (o.baseDodge != null)
            {
                baseDodge = o.baseDodge;
            };
            if (o.baseBlock != null)
            {
                baseBlock = o.baseBlock;
            };
            if (o.baseParry != null)
            {
                baseParry = o.baseParry;
            };
            if (o.baseCrit != null)
            {
                baseCrit = o.baseCrit;
            };
            if (o.baseHit != null)
            {
                baseHit = o.baseHit;
            };
            if (o.baseHaste != null)
            {
                baseHaste = o.baseHaste;
            };
            if (o.baseMiss != null)
            {
                baseMiss = o.baseMiss;
            };
            if (o.baseResist != null)
            {
                baseResist = o.baseResist;
            };
            if (o.baseCritValue != null)
            {
                baseCritValue = o.baseCritValue;
            };
            if (o.baseBlockValue != null)
            {
                baseBlockValue = o.baseBlockValue;
            };
            if (o.baseResistValue != null)
            {
                baseResistValue = o.baseResistValue;
            };
            if (o.baseEventValue != null)
            {
                baseEventValue = o.baseEventValue;
            };
            if (o.PCDPSMod != null)
            {
                PCDPSMod = o.PCDPSMod;
            };
            if (o.curveExponent != null)
            {
                curveExponent = o.curveExponent;
            };
            if (o.statsExponent != null)
            {
                statsExponent = o.statsExponent;
            };
        }

        internal function spaceBy(i:int, n:int):String
        {
            var s:String = String(i);
            while (s.length < n)
            {
                s = (s + " ");
            };
            return (s);
        }

        internal function spaceNumBy(i:Number, n:int):String
        {
            var s:String = i.toString();
            s = s.substr(0, n);
            while (s.length < n)
            {
                s = (s + " ");
            };
            return (s);
        }

        internal function showRatings():void
        {
            var b:*;
            var c:*;
            var bias1:*;
            var bias2:*;
            var bias3:*;
            var val:*;
            var cat:*;
            var o:*;
            var hpTgt:*;
            var tDPS:*;
            var sp1pc:*;
            trace("showRatings >");
            var cLeaf:* = world.myAvatar.dataLeaf;
            var stat:* = "";
            var lvl:* = 1;
            var i:* = 0;
            var j:* = 0;
            lvl = 1;
            while (lvl <= 35)
            {
                if (lvl == 0)
                {
                    lvl = 1;
                };
                b = getInnateStats(lvl);
                c = getIBudget(lvl, 1);
                bias1 = -1;
                bias2 = -1;
                bias3 = -1;
                val = -1;
                cat = cLeaf.sCat;
                o = copyObj(cLeaf.sta);
                resetTableValues(o);
                hpTgt = getBaseHPByLevel(lvl);
                tDPS = ((hpTgt / 20) * 0.7);
                sp1pc = (((2.25 * tDPS) / (100 / intAPtoDPS)) / 2);
                trace(("Level " + lvl));
                i = 0;
                while (i < stats.length)
                {
                    stat = stats[i];
                    val = o[("$" + stat)];
                    switch (stat)
                    {
                        case "STR":
                            bias1 = sp1pc;
                            o.$ap = (o.$ap + (val * 2));
                            o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.4));
                            trace(((((((((((("  " + spaceBy(hpTgt, 5)) + "  |  ") + spaceBy(val, 4)) + "  |  ") + spaceNumBy(bias1, 4)) + "  |  ") + spaceNumBy(b, 6)) + "  |  ") + spaceNumBy(c, 6)) + "  |  ") + spaceNumBy(o.$tcr, 6)));
                            break;
                    };
                    i++;
                };
                trace("");
                lvl = (lvl + 1);
            };
        }

        public function applyCoreStatRatings(o:Object, uoLeaf:Object):void
        {
            var wLvl:int = 1;
            var iDPS:* = 100;
            var wItem:Object = world.myAvatar.getEquippedItemBySlot("Weapon");
            if (wItem != null)
            {
                if (wItem.EnhLvl != null)
                {
                    wLvl = wItem.EnhLvl;
                };
                if (wItem.EnhDPS != null)
                {
                    iDPS = Number(wItem.EnhDPS);
                };
                if (iDPS == 0)
                {
                    iDPS = 100;
                };
            };
            iDPS = (iDPS / 100);
            var iLvl:int = uoLeaf.intLevel;
            var stat:String = "";
            var b:int = getInnateStats(iLvl);
            var bias1:Number = -1;
            var bias2:Number = -1;
            var bias3:Number = -1;
            var val:int = -1;
            var cat:String = world.myAvatar.objData.sClassCat;
            var hpTgt:int = getBaseHPByLevel(iLvl);
            var TTD:int = 20;
            var tDPS:* = ((hpTgt / 20) * 0.7);
            var sp1pc:Number = (((2.25 * tDPS) / (100 / intAPtoDPS)) / 2);
            resetTableValues(o);
            var i:int;
            while (i < stats.length)
            {
                stat = stats[i];
                val = (o[("_" + stat)] + o[("^" + stat)]);
                switch (stat)
                {
                    case "STR":
                        bias1 = sp1pc;
                        if (cat == "M1")
                        {
                            o.$sbm = (o.$sbm - (((val / bias1) / 100) * 0.3));
                        };
                        if (cat == "S1")
                        {
                            o.$ap = (o.$ap + Math.round((val * 1.4)));
                        }
                        else
                        {
                            o.$ap = (o.$ap + (val * 2));
                        };
                        if ((((((cat == "M1") || (cat == "M2")) || (cat == "M3")) || (cat == "M4")) || (cat == "S1")))
                        {
                            if (cat == "M4")
                            {
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.7));
                            }
                            else
                            {
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.4));
                            };
                        };
                        break;
                    case "INT":
                        bias1 = sp1pc;
                        o.$cmi = (o.$cmi - ((val / bias1) / 100));
                        if (((cat.substr(0, 1) == "C") || (cat == "M3")))
                        {
                            o.$cmo = (o.$cmo + ((val / bias1) / 100));
                        };
                        if (cat == "S1")
                        {
                            o.$sp = (o.$sp + Math.round((val * 1.4)));
                        }
                        else
                        {
                            o.$sp = (o.$sp + (val * 2));
                        };
                        if ((((((cat == "C1") || (cat == "C2")) || (cat == "C3")) || (cat == "M3")) || (cat == "S1")))
                        {
                            if (cat == "C2")
                            {
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.5));
                            }
                            else
                            {
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.3));
                            };
                        };
                        break;
                    case "DEX":
                        bias1 = sp1pc;
                        if ((((((cat == "M1") || (cat == "M2")) || (cat == "M3")) || (cat == "M4")) || (cat == "S1")))
                        {
                            if (cat.substr(0, 1) != "C")
                            {
                                o.$thi = (o.$thi + (((val / bias1) / 100) * 0.2));
                            };
                            if (((cat == "M2") || (cat == "M4")))
                            {
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.5));
                            }
                            else
                            {
                                o.$tha = (o.$tha + (((val / bias1) / 100) * 0.3));
                            };
                            if (cat == "M1")
                            {
                                if (o._tbl > 0.01)
                                {
                                    o.$tbl = (o.$tbl + (((val / bias1) / 100) * 0.5));
                                };
                            };
                        };
                        if (((!(cat == "M2")) && (!(cat == "M3"))))
                        {
                            o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.3));
                        }
                        else
                        {
                            o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.5));
                        };
                        break;
                    case "WIS":
                        bias1 = sp1pc;
                        if (((((cat == "C1") || (cat == "C2")) || (cat == "C3")) || (cat == "S1")))
                        {
                            if (cat == "C1")
                            {
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.7));
                            }
                            else
                            {
                                o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.4));
                            };
                            o.$thi = (o.$thi + (((val / bias1) / 100) * 0.2));
                        };
                        o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.3));
                        break;
                    case "LCK":
                        bias1 = sp1pc;
                        o.$sem = (o.$sem + (((val / bias1) / 100) * 2));
                        if (cat == "S1")
                        {
                            o.$ap = (o.$ap + Math.round((val * 1)));
                            o.$sp = (o.$sp + Math.round((val * 1)));
                            o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.3));
                            o.$thi = (o.$thi + (((val / bias1) / 100) * 0.1));
                            o.$tha = (o.$tha + (((val / bias1) / 100) * 0.3));
                            o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.25));
                            o.$scm = (o.$scm + (((val / bias1) / 100) * 2.5));
                        }
                        else
                        {
                            if (((((cat == "M1") || (cat == "M2")) || (cat == "M3")) || (cat == "M4")))
                            {
                                o.$ap = (o.$ap + Math.round((val * 0.7)));
                            };
                            if (((((cat == "C1") || (cat == "C2")) || (cat == "C3")) || (cat == "M3")))
                            {
                                o.$sp = (o.$sp + Math.round((val * 0.7)));
                            };
                            o.$tcr = (o.$tcr + (((val / bias1) / 100) * 0.2));
                            o.$thi = (o.$thi + (((val / bias1) / 100) * 0.1));
                            o.$tha = (o.$tha + (((val / bias1) / 100) * 0.1));
                            o.$tdo = (o.$tdo + (((val / bias1) / 100) * 0.1));
                            o.$scm = (o.$scm + (((val / bias1) / 100) * 5));
                        };
                        break;
                };
                i++;
            };
            o.wDPS = (Math.round((((getBaseHPByLevel(wLvl) / TTD) * iDPS) * PCDPSMod)) + Math.round((o.$ap / intAPtoDPS)));
            o.mDPS = (Math.round((((getBaseHPByLevel(wLvl) / TTD) * iDPS) * PCDPSMod)) + Math.round((o.$sp / intSPtoDPS)));
        }

        public function coeffToPct(c:Number):String
        {
            return (Number((c * 100)).toFixed(2));
        }

        public function getIBudget(lvl:int, iRty:int):int
        {
            if (lvl < 1)
            {
                lvl = 1;
            };
            if (lvl > intLevelCap)
            {
                lvl = intLevelCap;
            };
            if (iRty < 1)
            {
                iRty = 1;
            };
            lvl = Math.round(((lvl + iRty) - 1));
            var b:int = Math.round((GstBase + (Math.pow(((lvl - 1) / (intLevelCap - 1)), statsExponent) * (GstGoal - GstBase))));
            return (b);
        }

        public function getInnateStats(lvl:int):int
        {
            if (lvl < 1)
            {
                lvl = 1;
            };
            if (lvl > intLevelCap)
            {
                lvl = intLevelCap;
            };
            return (Math.round((PCstBase + (Math.pow(((lvl - 1) / (intLevelCap - 1)), statsExponent) * (PCstGoal - PCstBase)))));
        }

        public function getBaseHPByLevel(lvl:*):*
        {
            if (lvl < 1)
            {
                lvl = 1;
            };
            if (lvl > intLevelCap)
            {
                lvl = intLevelCap;
            };
            return (Math.round((PChpBase1 + (Math.pow(((lvl - 1) / (intLevelCap - 1)), curveExponent) * PChpDelta))));
        }

        public function catCodeToName(cat:String):String
        {
            switch (cat)
            {
                case "M1":
                    return ("Fighter");
                case "M2":
                    return ("Thief");
                case "M3":
                    return ("Hybrid");
                case "M4":
                    return ("Armsman");
                case "C1":
                    return ("Wizard");
                case "C2":
                    return ("Healer");
                case "C3":
                    return ("spellbreaker");
                case "S1":
                    return ("Lucky");
                default:
                    return (null);
            };
        }

        public function resetTableValues(o:Object):void
        {
            o._ap = 0;
            o.$ap = 0;
            o._sp = 0;
            o.$sp = 0;
            o._tbl = 0;
            o._tpa = 0;
            o._tdo = 0;
            o._tcr = 0;
            o._thi = 0;
            o._tha = 0;
            o._tre = 0;
            o.$tbl = baseBlock;
            o.$tpa = baseParry;
            o.$tdo = baseDodge;
            o.$tcr = baseCrit;
            o.$thi = baseHit;
            o.$tha = baseHaste;
            o.$tre = baseResist;
            o._cpo = 1;
            o._cpi = 1;
            o._cao = 1;
            o._cai = 1;
            o._cmo = 1;
            o._cmi = 1;
            o._cdo = 1;
            o._cdi = 1;
            o._cho = 1;
            o._chi = 1;
            o._cmc = 1;
            o.$cpo = 1;
            o.$cpi = 1;
            o.$cao = 1;
            o.$cai = 1;
            o.$cmo = 1;
            o.$cmi = 1;
            o.$cdo = 1;
            o.$cdi = 1;
            o.$cho = 1;
            o.$chi = 1;
            o.$cmc = 1;
            o._scm = baseCritValue;
            o._sbm = baseBlockValue;
            o._srm = baseResistValue;
            o._sem = baseEventValue;
            o.$scm = baseCritValue;
            o.$sbm = baseBlockValue;
            o.$srm = baseResistValue;
            o.$sem = baseEventValue;
            o._shb = 0;
            o._smb = 0;
            o.$shb = 0;
            o.$smb = 0;
        }

        public function getCategoryStats(cat:String, lvl:int):Object
        {
            var ist:* = getInnateStats(lvl);
            var ratios:* = classCatMap[cat].ratios;
            var o:* = {};
            var stat:* = "";
            var i:int;
            while (i < stats.length)
            {
                stat = stats[i];
                o[stat] = Math.round((ratios[i] * ist));
                i++;
            };
            return (o);
        }

        public function applyAuraEffect(e:*, o:*):*
        {
            switch (e.typ)
            {
                case "+":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] + Number(e.val));
                    break;
                case "-":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] - Number(e.val));
                    break;
                case "*":
                    o[("$" + e.sta)] = Math.round((o[("$" + e.sta)] * Number(e.val)));
                    break;
            };
        }

        public function removeAuraEffect(e:*, o:*):*
        {
            switch (e.typ)
            {
                case "+":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] - Number(e.val));
                    break;
                case "-":
                    o[("$" + e.sta)] = (o[("$" + e.sta)] + Number(e.val));
                    break;
                case "*":
                    o[("$" + e.sta)] = Math.round((o[("$" + e.sta)] / Number(e.val)));
            };
        }

        public function getStatsA(item:Object, slot:String):Object
        {
            var iEnhTemplate:Object;
            var lvl:int = ((item.sType.toLowerCase() == "enhancement") ? item.iLvl : item.EnhLvl);
            var rty:int = ((item.sType.toLowerCase() == "enhancement") ? item.iRty : item.EnhRty);
            var iBudget:int = Math.round((getIBudget(lvl, rty) * ratiosBySlot[slot]));
            var val:* = -1;
            var statBufferOrder:* = ["iEND", "iSTR", "iINT", "iDEX", "iWIS", "iLCK"];
            var statJ:* = 0;
            var statName:* = "";
            var statVals:* = {};
            var valTotal:* = 0;
            var i:int;
            var o:Object = {};
            world.initPatternTree();
            if (item.PatternID != null)
            {
                iEnhTemplate = world.enhPatternTree[item.PatternID];
            };
            if (item.EnhPatternID != null)
            {
                iEnhTemplate = world.enhPatternTree[item.EnhPatternID];
            };
            if (iEnhTemplate != null)
            {
                i = 0;
                while (i < stats.length)
                {
                    statName = ("i" + stats[i]);
                    if (iEnhTemplate[statName] != null)
                    {
                        statVals[statName] = Math.round(((iBudget * iEnhTemplate[statName]) / 100));
                        valTotal = (valTotal + statVals[statName]);
                    };
                    i++;
                };
                statJ = 0;
                while (valTotal < iBudget)
                {
                    statName = statBufferOrder[statJ];
                    if (statVals[statName] != null)
                    {
                        statVals[statName]++;
                        valTotal++;
                    };
                    statJ++;
                    if (statJ > (statBufferOrder.length - 1))
                    {
                        statJ = 0;
                    };
                };
                i = 0;
                while (i < stats.length)
                {
                    val = statVals[("i" + stats[i])];
                    if (((!(val == null)) && (!(val == "0"))))
                    {
                        o[("$" + stats[i])] = val;
                    };
                    i++;
                };
            };
            return (o);
        }

        public function getFullStatName(s:String):String
        {
            var statName:String = "";
            s = s.toLowerCase();
            if (s.indexOf("str") > -1)
            {
                statName = "Strength";
            };
            if (s.indexOf("int") > -1)
            {
                statName = "Intellect";
            };
            if (s.indexOf("dex") > -1)
            {
                statName = "Dexterity";
            };
            if (s.indexOf("wis") > -1)
            {
                statName = "Wisdom";
            };
            if (s.indexOf("end") > -1)
            {
                statName = "Endurance";
            };
            if (s.indexOf("lck") > -1)
            {
                statName = "Luck";
            };
            if (s.indexOf("tha") > -1)
            {
                statName = "Haste";
            };
            if (s.indexOf("thi") > -1)
            {
                statName = "Hit";
            };
            if (s.indexOf("tcr") > -1)
            {
                statName = "Critcal Hit";
            };
            if (s.indexOf("tcm") > -1)
            {
                statName = "Crit Value";
            };
            if (s.indexOf("tdo") > -1)
            {
                statName = "Evasion";
            };
            return (statName);
        }

        public function getRarityString(n:int):String
        {
            var o:Object;
            var aRarity:Array = [ {
                        "val": 0,
                        "sName": "Unknown"
                    }, {
                        "val": 10,
                        "sName": "Unknown"
                    }, {
                        "val": 11,
                        "sName": "Common"
                    }, {
                        "val": 12,
                        "sName": "Weird"
                    }, {
                        "val": 13,
                        "sName": "Awesome"
                    }, {
                        "val": 14,
                        "sName": "1% Drop"
                    }, {
                        "val": 15,
                        "sName": "5% Drop"
                    }, {
                        "val": 16,
                        "sName": "Boss Drop"
                    }, {
                        "val": 17,
                        "sName": "Secret"
                    }, {
                        "val": 18,
                        "sName": "Junk"
                    }, {
                        "val": 19,
                        "sName": "Impossible"
                    }, {
                        "val": 20,
                        "sName": "Artifact"
                    }, {
                        "val": 21,
                        "sName": "Limited Time Drop"
                    }, {
                        "val": 22,
                        "sName": "Dumb"
                    }, {
                        "val": 23,
                        "sName": "Crazy"
                    }, {
                        "val": 24,
                        "sName": "Expensive"
                    }, {
                        "val": 30,
                        "sName": "Rare"
                    }, {
                        "val": 35,
                        "sName": "Epic"
                    }, {
                        "val": 40,
                        "sName": "Import Item"
                    }, {
                        "val": 50,
                        "sName": "Seasonal Item"
                    }, {
                        "val": 55,
                        "sName": "Seasonal Rare"
                    }, {
                        "val": 60,
                        "sName": "Event Item"
                    }, {
                        "val": 65,
                        "sName": "Event Rare"
                    }, {
                        "val": 70,
                        "sName": "Limited Rare"
                    }, {
                        "val": 75,
                        "sName": "Collector's Rare"
                    }, {
                        "val": 80,
                        "sName": "Promotional Item"
                    }, {
                        "val": 90,
                        "sName": "Ultra Rare"
                    }, {
                        "val": 95,
                        "sName": "Super Mega Ultra Rare"
                    }, {
                        "val": 100,
                        "sName": "Legendary Item"
                    }, {
                        "val": 101,
                        "sName": "Store Exclusive"
                    }, {
                        "val": 102,
                        "sName": "Scroll Exclusive"
                    }, {
                        "val": 103,
                        "sName": "Personal Item"
                    }];
            var i:int = (aRarity.length - 1);
            while (i > -1)
            {
                o = aRarity[i];
                if (n >= o.val)
                {
                    return (o.sName);
                };
                i--;
            };
            return ("Common");
        }

        public function toggleItemEquip(item:Object):Boolean
        {
            var uoLeaf:* = world.getUoLeafById(world.myAvatar.uid);
            var isOK:Boolean;
            if (uoLeaf.intState != 1)
            {
                MsgBox.notify("Action cannot be performed during combat!");
            }
            else
            {
                if (world.bPvP)
                {
                    MsgBox.notify("Items may not be equipped or unequipped during a PvP match!");
                }
                else
                {
                    if (item.bEquip == 1)
                    {
                        if (((item.sES == "Weapon") || (item.sES == "ar")))
                        {
                            MsgBox.notify("Selected Item cannot be unequipped!");
                        }
                        else
                        {
                            isOK = true;
                            if (item.sType.toLowerCase() != "item")
                            {
                                world.sendUnequipItemRequest(item);
                            }
                            else
                            {
                                world.unequipUseableItem(item);
                            };
                        };
                    }
                    else
                    {
                        if (((item.bUpg == 1) && (!(world.myAvatar.isUpgraded()))))
                        {
                            showUpgradeWindow();
                        }
                        else
                        {
                            if (int(item.EnhLvl) > int(world.myAvatar.objData.intLevel))
                            {
                                MsgBox.notify("Level requirement not met!");
                            }
                            else
                            {
                                if (((!(item.sType.toLowerCase() == "item")) && (((((!(item.sES == "mi")) && (!(item.sES == "co"))) && (!(item.sES == "pe"))) && (!(item.sES == "am"))) && (!(item.EnhID > 0)))))
                                {
                                    MsgBox.notify("Selected item requires enhancement!");
                                }
                                else
                                {
                                    if (item.sType.toLowerCase() != "item")
                                    {
                                        isOK = world.sendEquipItemRequest(item);
                                    }
                                    else
                                    {
                                        isOK = true;
                                        world.equipUseableItem(item);
                                    };
                                };
                            };
                        };
                    };
                };
            };
            return (isOK);
        }

        public function tryEnhance(item:Object, enh:Object, shopRequest:Boolean = false):void
        {
            if (((!(item == null)) && (!(enh == null))))
            {
                if (enh.iLvl > world.myAvatar.objData.intLevel)
                {
                    MsgBox.notify("Level requirement not met!");
                }
                else
                {
                    if (item.EnhID == enh.ItemID)
                    {
                        MsgBox.notify("Selected Enhancement already applied to item!");
                    }
                    else
                    {
                        if (shopRequest)
                        {
                            world.sendEnhItemRequestShop(item, enh);
                        }
                        else
                        {
                            world.sendEnhItemRequestLocal(item, enh);
                        };
                    };
                };
            };
        }

        public function doIHaveEnhancements():Boolean
        {
            var item:Object;
            for each (item in world.myAvatar.items)
            {
                if (item.sType.toLowerCase() == "enhancement")
                {
                    return (true);
                };
            };
            return (false);
        }

        public function isItemEnhanceable(item:Object):Boolean
        {
            return (["Weapon", "he", "ba", "pe", "ar"].indexOf(item.sES) >= 0);
        }

        public function resetInvTreeByItemID(ItemID:int):*
        {
            var item:Object;
            try
            {
                item = world.invTree[ItemID];
                if (("EnhID" in item))
                {
                    item.EnhID = -1;
                };
                if (("EnhRty" in item))
                {
                    item.EnhRty = -1;
                };
                if (("EnhDPS" in item))
                {
                    item.EnhDPS = -1;
                };
                if (("EnhRng" in item))
                {
                    item.EnhRng = -1;
                };
                if (("EnhLvl" in item))
                {
                    item.EnhLvl = -1;
                };
                if (("EnhPatternID" in item))
                {
                    item.EnhPatternID = -1;
                };
            }
            catch (e:Error)
            {
                trace(e);
            };
        }

        public function isMergeShop(shopInfo:Object):Boolean
        {
            var item:Object;
            for each (item in shopInfo.items)
            {
                if (("turnin" in item))
                {
                    return (true);
                };
            };
            return (false);
        }

        public function recursiveStop(mc:MovieClip):void
        {
            var child:DisplayObject;
            var i:int;
            while (i < mc.numChildren)
            {
                child = mc.getChildAt(i);
                if ((child is MovieClip))
                {
                    mc = MovieClip(child);
                    if (mc.totalFrames > 1)
                    {
                        mc.gotoAndStop(mc.totalFrames);
                    }
                    else
                    {
                        mc.stop();
                    };
                    recursiveStop(MovieClip(child));
                };
                i++;
            };
        }

        public function getTravelMapData():void
        {
            if (ui.getChildByName("travelLoaderMC"))
            {
                return;
            };
            travelLoaderMC = new ((world.getClass("mcLoader") as Class))();
            travelLoaderMC.x = 400;
            travelLoaderMC.y = 211;
            travelLoaderMC.name = "travelLoaderMC";
            ui.addChild(travelLoaderMC);
            var strUrl:String = ("api/data/travelmap?v=" + world.objInfo["sVersion"]);
            var mapLoader:URLLoader = new URLLoader();
            if ((((this.loaderInfo.url.toLowerCase().indexOf("file://") >= 0) || (this.loaderInfo.url.toLowerCase().indexOf("cdn.aq.com") >= 0)) || (this.loaderInfo.url.toLowerCase().indexOf("aqworldscdn.aq.com") >= 0)))
            {
                strUrl = ("https://game.aq.com/game/" + strUrl);
            }
            else
            {
                strUrl = (params.sURL + strUrl);
            };
            var request:URLRequest = new URLRequest(strUrl);
            request.method = URLRequestMethod.GET;
            mapLoader.addEventListener(Event.COMPLETE, onTravelMapComplete, false, 0, true);
            mapLoader.addEventListener(ProgressEvent.PROGRESS, onTravelMapProgress, false, 0, true);
            mapLoader.addEventListener(IOErrorEvent.IO_ERROR, onTravelError, false, 0, true);
            mapLoader.load(request);
        }

        private function onTravelMapComplete(e:Event):void
        {
            var strData:String = String(e.target.data);
            var jso:Object = com.adobe.serialization.json.JSON.decode(strData);
            travelMapData = jso;
            WorldMapData = new worldMap(travelMapData);
            TRAVEL_DATA_READY = true;
            ui.mcPopup.mcMap.removeChildAt(0);
            var ldr:Loader = new Loader();
            ldr.load(new URLRequest((serverFilePath + world.objInfo.sMap)), new LoaderContext(false, ApplicationDomain.currentDomain));
            ui.mcPopup.mcMap.addChild(ldr);
        }

        private function onTravelMapProgress(event:ProgressEvent):void
        {
            bLoaded = event.bytesLoaded;
            bTotal = event.bytesTotal;
            var percent:int = int(((bLoaded / bTotal) * 100));
            var barProg:Number = (bLoaded / bTotal);
            travelLoaderMC.mcPct.text = (percent + "%");
            if (bLoaded >= bTotal)
            {
                travelLoaderMC.parent.removeChild(travelLoaderMC);
                travelLoaderMC = null;
            };
        }

        private function onTravelError(e:IOErrorEvent):void
        {
            trace(("travel map load failed: " + e));
            if (travelLoaderMC)
            {
                travelLoaderMC.parent.removeChild(travelLoaderMC);
                travelLoaderMC = null;
            };
        }

        public function checkPasswordStrength(pwd:String):int
        {
            var bits:Number = 0;
            var pwdArr:Array = pwd.split("");
            var charsSeen:Array = new Array();
            var nonAlpha:uint;
            var prevChar:String = pwdArr[0];
            var distinct:Boolean;
            var pass:String = pwd.toLowerCase();
            var k:uint;
            while (k < weakPass.length)
            {
                if (pass == weakPass[k])
                {
                    return (-1);
                };
                k++;
            };
            var i:uint;
            while (i < pwdArr.length)
            {
                if (((!(distinct)) && (!(prevChar == pwdArr[i]))))
                {
                    distinct = true;
                };
                if (i == 0)
                {
                    bits = (bits + 4);
                    charsSeen.push(pwdArr[i]);
                }
                else
                {
                    if (i < 8)
                    {
                        if (!isRepeat(charsSeen, pwdArr[i]))
                        {
                            charsSeen.push(pwdArr[i]);
                            bits = (bits + 2);
                        }
                        else
                        {
                            bits = (bits + 2);
                        };
                    }
                    else
                    {
                        if (i < 21)
                        {
                            if (!isRepeat(charsSeen, pwdArr[i]))
                            {
                                charsSeen.push(pwdArr[i]);
                                bits = (bits + 1.5);
                            }
                            else
                            {
                                bits = (bits + 1.5);
                            };
                        }
                        else
                        {
                            if (!isRepeat(charsSeen, pwdArr[i]))
                            {
                                charsSeen.push(pwdArr[i]);
                                bits = (bits + 1);
                            }
                            else
                            {
                                bits = (bits + 1);
                            };
                        };
                    };
                };
                if (((nonAlpha < 6) && (!(isAlphaChar(pwdArr[i])))))
                {
                    bits++;
                    nonAlpha++;
                };
                i++;
            };
            return ((distinct) ? bits : -1);
        }

        private function isAlphaChar(c:String):Boolean
        {
            var charCode:uint = c.charCodeAt(0);
            return ((((charCode >= 65) && (charCode < 123)) || ((charCode >= 48) && (charCode < 58))) ? true : false);
        }

        private function isRepeat(chars:Array, c:String):Boolean
        {
            var i:uint;
            while (i < chars.length)
            {
                if (chars[i] == c)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function loadGameMenu():void
        {
            var ldr:URLLoader = new URLLoader();
            ldr = new URLLoader(new URLRequest(serverFilePath + "gameMenu/" + world.objInfo.gMenu));
            ldr.dataFormat = URLLoaderDataFormat.BINARY;
            ldr.addEventListener(Event.COMPLETE, onLoadMaster(gameMenuCallBack, assetsContext));
            ldr.addEventListener(IOErrorEvent.IO_ERROR, gameMenuErrorHandler);
        }

        /*public function loadGameMenu():void
        {
            var ldr:Loader = new Loader();
            var urlReq:URLRequest = new URLRequest(((serverFilePath + "gameMenu/") + world.objInfo.gMenu));
            trace(((serverFilePath + "gameMenu/") + world.objInfo.gMenu));
            ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, gameMenuCallBack, false, 0, true);
            ldr.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, gameMenuErrorHandler, false, 0, true);
            ldr.load(urlReq, assetsContext);
        }*/

        public function MenuShow():void
        {
            try
            {
                if (!mcGameMenu)
                {
                    return;
                };
                if (mcGameMenu.currentLabel == "Open")
                {
                    mcGameMenu.gotoAndPlay("Close");
                }
                else
                {
                    mcGameMenu.gotoAndStop("Open");
                };
            }
            catch (e)
            {
            };
        }

        private function gameMenuCallBack(e:Event):void
        {
            try
            {
                ui.removeChild(mcGameMenu);
            }
            catch (e)
            {
            };
            mcGameMenu = null;
            var menuClass:* = (assetsDomain.getDefinition("GameMenu") as Class);
            mcGameMenu = MovieClip(new (menuClass)());
            mcGameMenu.name = "gameMenu";
            mcGameMenu.visible = (!(world.strMapName == "reenstest"));
            mcGameMenu.x = 750;
            ui.addChild(mcGameMenu);
        }

        private function gameMenuErrorHandler(e:IOErrorEvent):void
        {
            trace("menu loading error");
            trace(e);
        }

        public function menuClose():void
        {
            try
            {
                if (firstMenu)
                {
                    firstMenu = false;
                }
                else
                {
                    if (mcGameMenu.currentLabel != "Close")
                    {
                        mcGameMenu.gotoAndPlay("Close");
                    };
                };
            }
            catch (e)
            {
            };
        }

        public function openMenu():void
        {
            try
            {
                if (mcGameMenu.currentLabel != "Open")
                {
                    mcGameMenu.gotoAndPlay("Open");
                };
            }
            catch (e)
            {
            };
        }

        public function isMobile():Boolean
        {
            return (ISMOBILE);
        }

        public function getFilePath():String
        {
            return (serverFilePath);
        }

        public function getGamePath():String
        {
            return (serverGamePath);
        }

        public function initWorld():void
        {
            if (world != null)
            {
                world.killTimers();
                world.killListeners();
                this.removeChild(world);
                world = null;
            };
            world = new World(MovieClip(this));
            this.addChildAt(world, getChildIndex(ui));
        }

        public function grayAll(content:DisplayObjectContainer):void
        {
            var child:DisplayObjectContainer;
            var i:int;
            var n:int;
            if (content == null)
            {
                return;
            };
            if (((content is MovieClip) && (!(content == this))))
            {
                (content as MovieClip).stop();
            };
            if (content.numChildren)
            {
                n = content.numChildren;
                while (i < n)
                {
                    if ((content.getChildAt(i) is DisplayObjectContainer))
                    {
                        child = (content.getChildAt(i) as DisplayObjectContainer);
                        if (child.numChildren)
                        {
                            makeGrayscale(child);
                        }
                        else
                        {
                            if ((child is MovieClip))
                            {
                                makeGrayscale((child as MovieClip));
                            };
                        };
                    };
                    i++;
                };
            };
        }

        public function testJSCallback():void
        {
            trace("callback recieved from webpage");
        }

        public function onAddedToStage(e:Event):void
        {
            Game.root = this;
            this.stage.showDefaultContextMenu = false;
            stage.stageFocusRect = false;
            mcConnDetail = new ConnDetailMC(this);
            serverGamePath = staticURL;
            serverFilePath = staticURL + "gamefiles/";
            sFilePath = staticURL;
            trace(("serverFilePath: " + serverFilePath));
            gotoAndPlay((((charCount() > 0) && (litePreference.data.bCharSelect)) ? "Select" : "Login"));
            if (userPreference.data.quality != "AUTO")
            {
                stage.quality = userPreference.data.quality;
            };
            mcLogin.testClientAssets.visible = false;
        }

        public function init():void
        {
            var v:*;
            ISWEB = params.isWeb;
            ISMOBILE = params.isMobile;
            extCall = new ExternalCalls(true, params.strSourceID, (this as MovieClip));
            for (v in params)
            {
                trace(((("params[" + v) + "]= ") + params[v]));
            };
            if (MsgBox)
            {
                MsgBox.visible = false;
            };
            IsEU = params.isEU;
            trace(("isEU = " + IsEU));
            readQueryString();
            if (((mcLogin) && (mcLogin.fbConnect)))
            {
                mcLogin.fbConnect.visible = showFB;
            };
            extCall.setGameObject(swfObj);
            if (params.sURL == null)
            {
                params.sURL = "https://www.aq.com/game/";
            };
            serverPath = params.sURL;
            FacebookConnect.RegisterGame(this);
            if (params.doSignup)
            {
                params.doSignup = false;
                gotoAndPlay("Account");
            };
        }

        public function FBMessage(cmd:*, retVal:*):*
        {
            trace(((("sendMessage: " + cmd) + " --- retVal: ") + retVal));
            FacebookConnect.handleFBMessage(cmd, retVal);
        }

        public function SendMessage(cmd:*, retVal:*):*
        {
            trace("got callback");
        }

        public function FB_showFeedDialog(header:String, job:String, image:String):void
        {
            if (ISWEB)
            {
                extCall.showFeedDialog(header, job, image);
            };
        }

        public function toggleFullScreen():void
        {
            var screenRectangle:Rectangle;
            if (stage["displayState"] == StageDisplayState.NORMAL)
            {
                screenRectangle = new Rectangle(0, 0, 960, 550);
                try
                {
                    stage["fullScreenSourceRect"] = screenRectangle;
                    stage["displayState"] = StageDisplayState.FULL_SCREEN;
                }
                catch (error:Error)
                {
                };
            }
            else
            {
                stage["displayState"] = StageDisplayState.NORMAL;
            };
        }

        public function showBallyhooAd(sZone:String):void
        {
            stage["displayState"] = StageDisplayState.NORMAL;
            extCall.showIt(sZone);
        }

        public function callJSFunction(sFunc:String):void
        {
            extCall.callJSFunction(sFunc);
        }

        private function readQueryString():*
        {
            var _queryString:*;
            var v:*;
            var allParams:Array;
            var i:*;
            var index:*;
            var keyValuePair:String;
            var paramKey:String;
            var paramValue:String;
            try
            {
                _queryString = "";
                if (ISWEB)
                {
                    _queryString = extCall.getQueryString();
                };
                if (_queryString)
                {
                    allParams = _queryString.split("&");
                    i = 0;
                    index = -1;
                    while (i < allParams.length)
                    {
                        keyValuePair = allParams[i];
                        if ((index = keyValuePair.indexOf("=")) > 0)
                        {
                            paramKey = keyValuePair.substring(0, index);
                            paramValue = keyValuePair.substring((index + 1));
                            querystring[paramKey] = paramValue;
                        };
                        i++;
                    };
                };
                for (v in querystring)
                {
                    trace(((v + ": ") + querystring[v]));
                };
            }
            catch (e:Error)
            {
            };
        }

        public function initLogin():void
        {
            var curTS:Number;
            var iDiff:Number;
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, key_StageLogin);
            mcLogin.ni.tabIndex = 1;
            mcLogin.pi.tabIndex = 2;
            mcLogin.ni.removeEventListener(FocusEvent.FOCUS_IN, onUserFocus);
            mcLogin.ni.removeEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.pi.removeEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.btnLogin.removeEventListener(MouseEvent.CLICK, onLoginClick);
            mcLogin.btnFBLogin.removeEventListener(MouseEvent.CLICK, onFBLoginClick);
            mcLogin.mcForgotPassword.removeEventListener(MouseEvent.CLICK, onForgotPassword);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, key_StageLogin);
            mcLogin.ni.addEventListener(FocusEvent.FOCUS_IN, onUserFocus);
            mcLogin.ni.addEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.pi.addEventListener(KeyboardEvent.KEY_DOWN, key_TextLogin);
            mcLogin.btnLogin.addEventListener(MouseEvent.CLICK, onLoginClick);
            mcLogin.btnFBLogin.addEventListener(MouseEvent.CLICK, onFBLoginClick);
            mcLogin.mcForgotPassword.addEventListener(MouseEvent.CLICK, onForgotPassword);
            mcLogin.mcManageAccount.addEventListener(MouseEvent.CLICK, onManageClick);
            loadUserPreference();
            mcLogin.warning.s = String("Sorry! You have been disconnected. \n You will be able to login after $s seconds.");
            mcLogin.warning.visible = false;
            mcLogin.warning.alpha = 0;
            if (params.sURL != null)
            {
                mcLogin.mcLogo.txtTitle.htmlText = ('<font color="#FFB231">New Release:</font> ' + params.sTitle);
            };
            if (("logoutWarningTS" in userPreference.data))
            {
                curTS = new Date().getTime();
                iDiff = ((userPreference.data.logoutWarningTS + (userPreference.data.logoutWarningDur * 1000)) - curTS);
                if (iDiff > 60000)
                {
                    userPreference.data.logoutWarningDur = 60;
                    userPreference.data.logoutWarningTS = curTS;
                    try
                    {
                        userPreference.flush();
                    }
                    catch (e:Error)
                    {
                        trace(e.message);
                    };
                };
                if (iDiff > 1000)
                {
                    initLoginWarning();
                };
            };
        }

        public function onBtnDn(e:MouseEvent):void
        {
            var urlNotes:String;
            urlNotes = ((params.test) ? "https://www.aq.com/gamedesignnotes/AQW-Spider-OMGClient-PatchNotess-8456" : ("https://www./gamedesignnotes/AQW-Spider-AQWClient2-PatchNotes-8484"));
            navigateToURL(new URLRequest(urlNotes), "_blank");
        }

        public function loadTitle():void
        {
            var strBG:String;
            var sTitle:String;
            var sURL:String;
            strBG = "Generic2.swf";
            sTitle = "The Skyguard";
            sURL = "https://www.aq.com/game/";
            if (params.sURL != null)
            {
                sURL = params.sURL;
                strBG = params.sBG;
                sTitle = params.sTitle;
            }
            else
            {
                params.sURL = sURL;
            };
            trace(((("sURL: " + sURL) + " --- sBG:") + strBG));
            BGLoader.LoadBG(this, sURL, mcLogin, strBG, sTitle);
            mcLogin.testClientAssets.cVersion.text = ("Version " + cVersion);
            mcLogin.testClientAssets.dnBtn.addEventListener(MouseEvent.CLICK, onBtnDn, false, 0, true);
            mcLogin.testClientAssets.banner.visible = (params.test as Boolean);
        }

        private function initLoginWarning():void
        {
            var mc:MovieClip;
            var ts:Number;
            var lts:Number;
            var ldur:Number;
            mc = (mcLogin.warning as MovieClip);
            mc.visible = true;
            mc.alpha = 100;
            mcLogin.btnLogin.visible = false;
            mcLogin.mcOr.visible = false;
            mcLogin.btnFBLogin.visible = false;
            mcLogin.mcForgotPassword.visible = false;
            mcLogin.mcPassword.visible = false;
            ts = new Date().getTime();
            lts = userPreference.data.logoutWarningTS;
            ldur = userPreference.data.logoutWarningDur;
            mc.n = Math.round((((lts + (ldur * 1000)) - ts) / 1000));
            mc.ti.text = ((mc.s.split("$s")[0] + mc.n) + mc.s.split("$s")[1]);
            mc.timer = new Timer(1000);
            mc.timer.addEventListener(TimerEvent.TIMER, loginWarningTimer, false, 0, true);
            mc.timer.start();
        }

        private function loginWarningTimer(e:TimerEvent):void
        {
            var mc:MovieClip;
            mc = (mcLogin.warning as MovieClip);
            if (mc.n-- < 1)
            {
                mc.visible = false;
                mc.alpha = 0;
                mcLogin.mcPassword.visible = true;
                mcLogin.btnLogin.visible = true;
                mcLogin.mcOr.visible = true;
                mcLogin.btnFBLogin.visible = true;
                mcLogin.mcForgotPassword.visible = true;
                mc.timer.removeEventListener(TimerEvent.TIMER, loginWarningTimer);
            }
            else
            {
                mc.ti.text = ((mc.s.split("$s")[0] + mc.n) + mc.s.split("$s")[1]);
                mc.timer.reset();
                mc.timer.start();
            };
        }

        private function initInterface():*
        {
            var i:int;
            var txtKey:*;
            updateCoreValues(coreValues);
            ui.mcFPS.visible = false;
            ui.mcRes.visible = false;
            ui.mcPopup.visible = false;
            ui.mcPortrait.visible = false;
            ui.mcPortrait.iconBoostXP.visible = false;
            ui.mcPortrait.iconBoostG.visible = false;
            ui.mcPortrait.iconBoostRep.visible = false;
            ui.mcPortrait.iconBoostCP.visible = false;
            ui.mcPopup.visible = false;
            hidePortraitTarget();
            ui.visible = false;
            ui.mcInterface.mcXPBar.mcXP.scaleX = 0;
            ui.mcInterface.mcRepBar.mcRep.scaleX = 0;
            ui.mcUpdates.uproto.visible = false;
            ui.mcUpdates.uproto.y = -400;
            ui.mcUpdates.mouseChildren = (ui.mcUpdates.mouseEnabled = false);
            hideMCPVPQueue();
            stage.removeEventListener(KeyboardEvent.KEY_UP, key_actBar);
            stage.removeEventListener(KeyboardEvent.KEY_DOWN, key_StageGame);
            ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OVER, xpBarMouseOver);
            ui.mcInterface.mcXPBar.removeEventListener(MouseEvent.MOUSE_OUT, xpBarMouseOut);
            ui.mcInterface.mcRepBar.removeEventListener(MouseEvent.MOUSE_OVER, onRepBarMouseOver);
            ui.mcInterface.mcRepBar.removeEventListener(MouseEvent.MOUSE_OUT, onRepBarMouseOut);
            ui.mcPortraitTarget.removeEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.removeEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.iconBoostXP.removeEventListener(MouseEvent.MOUSE_OVER, oniconBoostXPOver);
            ui.mcPortrait.iconBoostXP.removeEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.mcPortrait.iconBoostG.removeEventListener(MouseEvent.MOUSE_OVER, oniconBoostGoldOver);
            ui.mcPortrait.iconBoostG.removeEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.mcPortrait.iconBoostRep.removeEventListener(MouseEvent.MOUSE_OVER, oniconBoostRepOver);
            ui.mcPortrait.iconBoostRep.removeEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.mcPortrait.iconBoostCP.removeEventListener(MouseEvent.MOUSE_OVER, oniconBoostCPOver);
            ui.mcPortrait.iconBoostCP.removeEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.btnTargetPortraitClose.removeEventListener(MouseEvent.CLICK, onTargetPortraitCloseClick);
            ui.btnMonster.removeEventListener(MouseEvent.CLICK, onBtnMonsterClick);
            ui.mcPVPQueue.removeEventListener(MouseEvent.CLICK, onMCPVPQueueClick);
            ui.mcInterface.tl.mouseEnabled = false;
            chatF.init();
            stage.addEventListener(KeyboardEvent.KEY_UP, key_actBar);
            ui.mcInterface.mcXPBar.strXP.visible = false;
            ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OVER, xpBarMouseOver);
            ui.mcInterface.mcXPBar.addEventListener(MouseEvent.MOUSE_OUT, xpBarMouseOut);
            ui.mcInterface.mcRepBar.strRep.visible = false;
            ui.mcInterface.mcRepBar.addEventListener(MouseEvent.MOUSE_OVER, onRepBarMouseOver);
            ui.mcInterface.mcRepBar.addEventListener(MouseEvent.MOUSE_OUT, onRepBarMouseOut);
            ui.mcPortraitTarget.addEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.addEventListener(MouseEvent.CLICK, portraitClick);
            ui.mcPortrait.iconBoostXP.addEventListener(MouseEvent.MOUSE_OVER, oniconBoostXPOver);
            ui.mcPortrait.iconBoostXP.addEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.mcPortrait.iconBoostG.addEventListener(MouseEvent.MOUSE_OVER, oniconBoostGoldOver);
            ui.mcPortrait.iconBoostG.addEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.mcPortrait.iconBoostRep.addEventListener(MouseEvent.MOUSE_OVER, oniconBoostRepOver);
            ui.mcPortrait.iconBoostRep.addEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.mcPortrait.iconBoostCP.addEventListener(MouseEvent.MOUSE_OVER, oniconBoostCPOver);
            ui.mcPortrait.iconBoostCP.addEventListener(MouseEvent.MOUSE_OUT, oniconBoostOut);
            ui.btnTargetPortraitClose.addEventListener(MouseEvent.CLICK, onTargetPortraitCloseClick);
            ui.btnMonster.addEventListener(MouseEvent.CLICK, onBtnMonsterClick);
            ui.mcPVPQueue.addEventListener(MouseEvent.CLICK, onMCPVPQueueClick);
            ui.iconQuest.visible = false;
            ui.iconQuest.buttonMode = true;
            ui.iconQuest.addEventListener(MouseEvent.CLICK, oniconQuestClick);
            ui.mcInterface.tl.mouseEnabled = false;
            ui.mcInterface.areaList.mouseEnabled = false;
            ui.mcInterface.areaList.title.mouseEnabled = false;
            ui.mcInterface.areaList.title.bMinMax.addEventListener(MouseEvent.CLICK, areaListClick);
            if (litePreference.data.bCustomDrops)
            {
                if (cDropsUI)
                {
                    cDropsUI.cleanup();
                };
                cDropsUI = new customDrops(this);
            };
            if (litePreference.data.bDebugger)
            {
                if (cMenuUI)
                {
                    cMenuUI.cleanup();
                };
                cMenuUI = new cellMenu(this);
            };
            if (((litePreference.data.bAuras) && (!(ui.mcInterface.getChildByName("playerAuras")))))
            {
                pAurasUI = new playerAuras(this);
                ui.mcPortrait.addChild(pAurasUI);
                tAurasUI = new targetAuras(this);
                ui.mcPortraitTarget.addChild(tAurasUI);
            };
            if (intChatMode)
            {
                ui.mcInterface.bMinMax.visible = false;
                ui.mcInterface.bShortTall.visible = false;
                ui.mcInterface.bCannedChat.visible = false;
                ui.mcInterface.tt.visible = false;
                ui.mcInterface.tebg.visible = false;
                ui.mcInterface.bsend.visible = false;
                ui.mcInterface.nc.visible = true;
                ui.mcInterface.ncChatOpen.visible = false;
                ui.mcInterface.ncCannedChat.visible = true;
                ui.mcInterface.ncHistory.visible = true;
                ui.mcInterface.ncTxtBG.visible = true;
                ui.mcInterface.ncPrefix.visible = true;
                ui.mcInterface.ncText.visible = true;
                ui.mcInterface.ncSendText.visible = true;
            }
            else
            {
                ui.mcInterface.bMinMax.visible = true;
                ui.mcInterface.bShortTall.visible = true;
                ui.mcInterface.bCannedChat.visible = true;
                ui.mcInterface.tt.visible = true;
                ui.mcInterface.tebg.visible = true;
                ui.mcInterface.bsend.visible = true;
                ui.mcInterface.nc.visible = false;
                ui.mcInterface.ncChatOpen.visible = false;
                ui.mcInterface.ncCannedChat.visible = false;
                ui.mcInterface.ncHistory.visible = false;
                ui.mcInterface.ncTxtBG.visible = false;
                ui.mcInterface.ncPrefix.visible = false;
                ui.mcInterface.ncText.visible = false;
                ui.mcInterface.ncSendText.visible = false;
            };
            keyDict = getKeyboardDict();
            i = 0;
            while (i < 6)
            {
                txtKey = ui.mcInterface.getChildByName(("keyA" + i));
                trace(litePreference.data.keys["Auto Attack"]);
                trace(keyDict[litePreference.data.keys["Auto Attack"]]);
                if (i == 0)
                {
                    txtKey.text = ((litePreference.data.keys["Auto Attack"] == null) ? " " : keyDict[litePreference.data.keys["Auto Attack"]]);
                }
                else
                {
                    txtKey.text = ((litePreference.data.keys[("Skill " + i)] == null) ? " " : keyDict[litePreference.data.keys[("Skill " + i)]]);
                };
                txtKey.mouseEnabled = false;
                i++;
            };
            (ui.mcWorldBoss.visible = false);
        }

        public function traceHack(msg:String):void
        {
            chatF.pushMsg("server", msg, "SERVER", "", 0);
        }

        private function onUserFocus(event:FocusEvent):*
        {
            if (mcLogin.ni.text == "click here")
            {
                mcLogin.ni.text = "";
            };
        }

        private function loadUserPreference():*
        {
            if (userPreference.data.bitCheckedUsername)
            {
                mcLogin.ni.text = ((TempLoginName != "") ? TempLoginName : userPreference.data.strUsername);
                mcLogin.chkUserName.bitChecked = true;
            };
            if (userPreference.data.bitCheckedPassword)
            {
                mcLogin.pi.text = ((TempLoginPass != "") ? TempLoginPass : userPreference.data.strPassword);
                mcLogin.chkPassword.bitChecked = true;
            };
            mcLogin.chkUserName.checkmark.visible = mcLogin.chkUserName.bitChecked;
            mcLogin.chkPassword.checkmark.visible = mcLogin.chkPassword.bitChecked;
        }

        private function saveUserPreference():*
        {
            userPreference.data.bitCheckedUsername = mcLogin.chkUserName.bitChecked;
            userPreference.data.bitCheckedPassword = mcLogin.chkPassword.bitChecked;
            if (mcLogin.chkUserName.bitChecked)
            {
                userPreference.data.strUsername = mcLogin.ni.text;
            }
            else
            {
                userPreference.data.strUsername = "";
            };
            if (mcLogin.chkPassword.bitChecked)
            {
                userPreference.data.strPassword = mcLogin.pi.text;
            }
            else
            {
                userPreference.data.strPassword = "";
            };
            try
            {
                userPreference.flush();
            }
            catch (e:Error)
            {
                trace(e.message);
            };
        }

        private function onCreateNewAccount(event:MouseEvent):void
        {
            mixer.playSound("Click");
            gotoAndPlay("Account");
        }

        private function onForgotPassword(event:MouseEvent):void
        {
            navigateToURL(new URLRequest("https://account.aq.com/Login/Forgot"));
        }

        private function onManageClick(e:MouseEvent):void
        {
            navigateToURL(new URLRequest("https://account.aq.com/"));
        }

        private function onAccountRecovery(event:MouseEvent):void
        {
            mixer.playSound("Click");
            navigateToURL(new URLRequest("https://www.aq.com/help/aw-account-recovery.asp"));
        }

        private function onLoginClick(event:MouseEvent):void
        {
            if ((("btnLogin" in mcLogin) && (mcLogin.btnLogin.visible)))
            {
                if (((!(mcLogin.ni.text == "")) && (!(mcLogin.pi.text == ""))))
                {
                    try
                    {
                        saveUserPreference();
                    }
                    catch (e)
                    {
                    };
                    if (FacebookConnect.isLoggedIn)
                    {
                        FacebookConnect.Logout();
                    };
                    login(mcLogin.ni.text.toLowerCase(), mcLogin.pi.text);
                };
            };
        }

        public function CallFBConnect(callback:Function):void
        {
            this.addEventListener(FacebookConnectEvent.ONCONNECT, FBLoginCreate);
            trace("======> Setting FBConnectCallback <======");
            FBConnectCallback = callback;
            FacebookConnect.RequestFBConnect();
        }

        public function GetFBMe():Object
        {
            return (FacebookConnect.Me);
        }

        public function isFBLoggedIn():Boolean
        {
            return (FacebookConnect.isLoggedIn);
        }

        public function FBIP():String
        {
            return (FacebookConnect.IPAddr);
        }

        public function GetFBToken():String
        {
            return (FacebookConnect.AccessToken);
        }

        private function onFBLoginClick(e:MouseEvent):void
        {
            if ((("btnLogin" in mcLogin) && (mcLogin.btnLogin.visible)))
            {
                mcConnDetail.showConn("Connecting to Facebook");
                this.addEventListener(FacebookConnectEvent.ONCONNECT, FBLogin);
                FacebookConnect.RequestFBConnect();
            };
        }

        public function FBLogin(fbevt:FacebookConnectEvent):void
        {
            var rand:Number;
            var request:URLRequest;
            var variables:URLVariables;
            var loader:URLLoader;
            this.removeEventListener(FacebookConnectEvent.ONCONNECT, FBLogin);
            if (fbevt.params.success)
            {
                params.FBID = FacebookConnect.Me.id;
                params.token = FacebookConnect.AccessToken;
                rand = rn.rand();
                mcConnDetail.showConn("Loading Server List...");
                request = new URLRequest(params.loginURL);
                variables = new URLVariables();
                variables.fbid = FacebookConnect.Me.id;
                variables.fbtoken = FacebookConnect.AccessToken;
                FacebookConnect.isLoggedIn = true;
                request.data = variables;
                request.method = URLRequestMethod.POST;
                loader = new URLLoader();
                loader.addEventListener(Event.COMPLETE, onLoginComplete);
                loader.load(request);
            }
            else
            {
                mcConnDetail.showError(fbevt.params.message);
            };
        }

        public function FBLoginCreate(fbevt:FacebookConnectEvent):void
        {
            this.removeEventListener(FacebookConnectEvent.ONCONNECT, FBLoginCreate);
            if (this.FBConnectCallback != null)
            {
                trace("======> Game:  FBConnectCallback <======");
                try
                {
                    FBConnectCallback();
                }
                catch (e:Error)
                {
                    trace(("Error FBConnectCallback: " + e.message));
                };
            };
            trace("======> Game: FBConnectCallback Null <======");
            FBConnectCallback = null;
        }

        public function getFBUser():void
        {
            if (ISWEB)
            {
                extCall.getFBUser();
            };
        }

        public function login(strUsername:String, strPassword:String):*
        {
            var rand:Number;
            var url:String;
            var request:URLRequest;
            var variables:URLVariables;
            var arrAllowLocal:Array = new Array("zhoom", "ztest00", "ztest01", "ztest02", "iterator", "zdhz", "yorumi");
            mcConnDetail.showConn("Authenticating Account Info...");
            loginInfo.strUsername = strUsername;
            loginInfo.strPassword = strPassword;
            rand = rn.rand();
            url = ("cf-userlogin.asp?ran=" + rand);
            url = ((params.loginURL + "?ran=") + rand);
            trace(("LoginURL: " + url));
            request = new URLRequest(url);
            variables = new URLVariables();
            variables.user = strUsername;
            variables.pass = strPassword;
            variables.option = ((ISWEB) ? "0" : "1");
            if (checkPasswordStrength(strPassword) < 18)
            {
                bPassword = false;
            };
            if (params.strSourceID == "FACEBOOK")
            {
                variables.strSourceID = params.strSourceID;
                variables.fbid = params.FBID;
                variables.fbtoken = params.token;
            }
            else
            {
                if (params.strSourceID == "TAGGED")
                {
                    variables.strSourceID = params.strSourceID;
                    variables.SrcUserID = params.SrcUserID;
                    variables.token = params.token;
                };
            };
            trace(("Sending: " + variables));
            request.data = variables;
            request.method = URLRequestMethod.POST;
            loginLoader.removeEventListener(Event.COMPLETE, onLoginComplete);
            loginLoader.addEventListener(Event.COMPLETE, onLoginComplete);
            loginLoader.addEventListener(IOErrorEvent.IO_ERROR, onLoginError, false, 0, true);
            try
            {
                loginLoader.load(request);
            }
            catch (error:Error)
            {
                trace("Unable to load URL");
            };
        }

        public function onLoginError(e:Event):void
        {
            trace(("Login Failed!" + e));
        }

        public function onLoginComplete(event:Event):void
        {
            var _obj:Object;
            trace(("LoginComplete:" + event.target.data));
            try
            {
                _obj = com.adobe.serialization.json.JSON.decode(event.target.data);
                if (_obj.login)
                {
                    objLogin = _obj.login;
                    objLogin.servers = _obj.servers;
                }
                else
                {
                    objLogin = _obj;
                };
                loginLoader.removeEventListener(Event.COMPLETE, onLoginComplete);
                if (objLogin.bSuccess == 1)
                {
                    try
                    {
                        loginInfo.strUsername = objLogin.unm.toLowerCase();
                    }
                    catch (e)
                    {
                        trace("caught loginInfo.strUsername null");
                    };
                    if (loginInfo.strUsername != null)
                    {
                        if (((((loginInfo.strUsername.toLowerCase() == "iterator") || (loginInfo.strUsername.toLowerCase() == "iterator2")) || (loginInfo.strUsername.toLowerCase() == "iterator3")) || (loginInfo.strUsername.toLowerCase() == "iterator4")))
                        {
                            serialCmdMode = true;
                        }
                        else
                        {
                            serialCmdMode = false;
                        };
                    }
                    else
                    {
                        serialCmdMode = false;
                    };
                    if (objLogin.FBID != null)
                    {
                        trace("!! LoginComplete found FBInfo !!");
                        if (FacebookConnect.Me == null)
                        {
                            FacebookConnect.Me = new Object();
                        };
                        FacebookConnect.Me.id = objLogin.FBID;
                        if (objLogin.FBName != null)
                        {
                            FacebookConnect.Me.name = objLogin.FBName;
                        };
                    };
                    if (fbL != null)
                    {
                        fbL.destroy();
                    };
                    trace("GOT HERE?");
                    if (ISWEB)
                    {
                        extCall.getFBUser();
                    };
                    mcConnDetail.hideConn();
                    loginInfo.strToken = objLogin.sToken;
                    sToken = loginInfo.strToken;
                    strToken = loginInfo.strToken;
                    if (ISWEB)
                    {
                        extCall.setToken(loginInfo);
                    };
                    if (serialCmdMode)
                    {
                        mcLogin.testClientAssets.visible = false;
                        mcLogin.gotoAndStop("Iterator");
                    }
                    else
                    {
                        mcLogin.gotoAndStop("Servers");
                        trace("This Should work?");
                    };
                }
                else
                {
                    if (objLogin.sMsg.indexOf("Facebook") > -1)
                    {
                        mcConnDetail.hideConn();
                        fbL = new fbLinkWindow(mcLogin.fbConnect, (this as MovieClip));
                        mcLogin.fbConnect.visible = true;
                    }
                    else
                    {
                        mcConnDetail.showError(objLogin.sMsg);
                    };
                };
            }
            catch (e)
            {
                trace("caught LoginComplete error");
            };
            resetsOnNewSession();
        }

        public function resetsOnNewSession():void
        {
            if (((chatF) && (intChatMode == 1)))
            {
                chatF.clearEverything();
            };
            if (((litePreference.data.bDebugger) && (objLogin.iAccess < 30)))
            {
                optionHandler.cmd(MovieClip(this), "@ Debugger");
            };
        }

        public function deepCopy(tgt:*, src:*):void
        {
            var prop:*;
            for (prop in src)
            {
                if (typeof ((src as Object)[prop]) == "object")
                {
                    (tgt as Object)[prop] = new Object();
                    deepCopy((tgt as Object)[prop], (src as Object)[prop]);
                }
                else
                {
                    if ((src as Object)[prop])
                    {
                        (tgt as Object)[prop] = (src as Object)[prop];
                    };
                };
            };
        }

        public function deepCopyArr(tgt:*, src:*):void
        {
            var prop:*;
            for each (prop in src)
            {
                tgt.push(prop);
            };
        }

        public function saveChar():void
        {
            var _objData:Object;
            var ctr:int;
            var _:*;
            var _loginInfo:Object;
            if (((FacebookConnect.isLoggedIn) || (!(litePreference.data.bCharSelect))))
            {
                return;
            };
            _objData = new Object();
            deepCopy(_objData, world.myAvatar.objData);
            _objData["showHelm"] = world.myAvatar.dataLeaf.showHelm;
            _objData["showCloak"] = world.myAvatar.dataLeaf.showCloak;
            if (((characters.data.users) && (characters.data.users[world.myAvatar.pnm.toLowerCase()])))
            {
                (characters.data.users[world.myAvatar.pnm.toLowerCase()] as Object).data = _objData;
                (characters.data.users[world.myAvatar.pnm.toLowerCase()] as Object).server = objServerInfo.sName;
            }
            else
            {
                ctr = 0;
                for (_ in characters.data.users)
                {
                    ctr++;
                };
                if (ctr >= 5)
                {
                    return;
                };
                (loginInfo as Object).bAsk = false;
                _loginInfo = new Object();
                deepCopy(_loginInfo, loginInfo);
                characters.data.users[world.myAvatar.pnm.toLowerCase()] = {
                        "index": -1,
                        "data": _objData,
                        "server": objServerInfo.sName,
                        "loginInfo": _loginInfo
                    };
            };
            characters.flush();
        }

        public function charCount():int
        {
            var ctr:int;
            var _:*;
            if (!characters.data.users)
            {
                characters.data.users = new Object();
                characters.data.retro = true;
                characters.flush();
                return (0);
            };
            ctr = 0;
            for (_ in characters.data.users)
            {
                ctr++;
            };
            return (ctr);
        }

        public function retroLowercase():void
        {
            var notOK:Boolean;
            var pname:*;
            var i:int;
            if (charCount() == 0)
            {
                return;
            };
            if (characters.data.retro)
            {
                return;
            };
            trace("Retro lowercase");
            notOK = false;
            for (pname in characters.data.users)
            {
                i = 0;
                while (i < pname.length)
                {
                    if (pname.charAt(i) != pname.charAt(i).toLowerCase())
                    {
                        notOK = true;
                        break;
                    };
                    i++;
                };
                if (notOK)
                    break;
            };
            if (notOK)
            {
                resetChars();
            }
            else
            {
                characters.data.retro = true;
            };
        }

        public function resetChars():void
        {
            characters.data.users = null;
            delete characters.data.users;
            characters.flush();
        }

        private function assetsToBytesMenu(param1:Event):*
        {
            var _local2:ByteArray = null;
            var _local3:Loader = new Loader();
            _local2 = (param1.target as URLLoader).data;
            _local3.contentLoaderInfo.addEventListener(Event.COMPLETE, gameMenuCallBack);
            _local3.loadBytes(_loc2_, assetsContext);
        }

        private function loadExternalAssets():void
        {
            var l:URLLoader = new URLLoader();
            trace("loadExternalAssets");
            mcConnDetail.showConn("Initializing Client...");
            (ASSETS_READY = false);
            l.dataFormat = URLLoaderDataFormat.BINARY;
            l.addEventListener(ProgressEvent.PROGRESS, assetsLoaderProgress, false, 0, true);
            l.addEventListener(IOErrorEvent.IO_ERROR, assetsLoaderErrorHandler, false, 0, true);
            l.addEventListener(Event.COMPLETE, assetsLoaderCallback);
            l.load(new URLRequest(serverFilePath + "interface/Assets/" + world.objInfo.sAssets));
        }
        /*private function loadExternalAssets():void
        {
            var l:Loader;
            var u:*;
            trace("loadExternalAssets");
            mcConnDetail.showConn("Initializing Client...");
            l = new Loader();
            u = new URLRequest(((serverFilePath + "interface/Assets/") + world.objInfo.sAssets));
            l.contentLoaderInfo.addEventListener(Event.COMPLETE, assetsLoaderCallback, false, 0, true);
            l.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, assetsLoaderErrorHandler, false, 0, true);
            l.load(u, assetsContext);
        }*/

        private function assetsLoaderProgress(param1:ProgressEvent):void
        {
            mcConnDetail.showConn("Loading Asset... " + int(param1.currentTarget.bytesLoaded / param1.currentTarget.bytesTotal * 100) + "%", true);
        }

        private function assetsLoaderCallback(param1:Event):void
        {
            var _local1:ByteArray = null;
            var _local2:Loader = new Loader();
            _local1 = (param1.target as URLLoader).data;
            _local2.contentLoaderInfo.addEventListener(Event.COMPLETE, onAssetsFinal);
            _local2.loadBytes(_local1, assetsContext);
        }
        /*private function assetsLoaderCallback(e:Event):void
        {
            trace("assetsLoaderCallback()");
            ASSETS_READY = world.objInfo.sAssets;
            resumeOnLoginResponse();
        }*/

        public function onAssetsFinal(param1:Event):void
        {
            trace("assetsLoaderCallback()");
            ASSETS_READY = true;
            resumeOnLoginResponse();
        }

        private function resumeOnLoginResponse():void
        {
            mcConnDetail.showConn("Joining Lobby..");
            sfc.sendXtMessage("zm", "firstJoin", [], "str", 1);
            if (chatF.ignoreList.data.users.length > 0)
            {
                sfc.sendXtMessage("zm", "cmd", ["ignoreList", chatF.ignoreList.data.users], "str", 1);
            }
            else
            {
                sfc.sendXtMessage("zm", "cmd", ["ignoreList", "$clearAll"], "str", 1);
            };
        }

        private function assetsLoaderErrorHandler(e:IOErrorEvent):void
        {
            trace("[WARNING] External Assets failed to load!");
            trace(e);
            mcConnDetail.showError("Client Initialization Failed!");
        }

        public function connectTo(strIP:String, iPort:int = 5588):*
        {
            trace(("connecting to:" + strIP));
            serverIP = strIP;
            mixer.playSound("ClickBig");
            mcConnDetail.showConn("Connecting to game server...");
            if (sfc.isConnected)
            {
                sfc.disconnect();
            };
            sfc.connect(strIP, iPort);
            if (!isMobile())
            {
                gotoAndPlay("Game");
            }
            else
            {
                gotoAndPlay("Mobile");
            }
        }

        public function requestInterface(tInterface:String):void
        {
            var interfaceLoader:Loader;
            visualLoader = new mcLoader();
            visualLoader.x = 400;
            visualLoader.y = 211;
            this.addChild(visualLoader);
            interfaceLoader = new Loader();
            interfaceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onInterfaceComplete, false, 0, true);
            interfaceLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onInterfaceProgress, false, 0, true);
            interfaceLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onInterfaceError, false, 0, true);
            interfaceLoader.load(new URLRequest(((getFilePath() + "interface/") + tInterface)));
        }

        public function onInterfaceComplete(e:Event):void
        {
            this.addChild(e.currentTarget.content);
        }

        public function onInterfaceProgress(e:ProgressEvent):void
        {
            var percent:int;
            interfaceLoaded = e.bytesLoaded;
            interfaceTotal = e.bytesTotal;
            percent = int(((interfaceLoaded / interfaceTotal) * 100));
            var barProg:Number = (interfaceLoaded / interfaceTotal);
            visualLoader.mcPct.text = (percent + "%");
            if (interfaceLoaded >= interfaceTotal)
            {
                visualLoader.parent.removeChild(visualLoader);
                visualLoader = null;
            };
        }

        public function onInterfaceError(e:IOErrorEvent):void
        {
            trace(("Failed to load interface: " + e));
        }

        public function requestAPI(api:String, data:*, completeCallback:*, ioCallback:*, force:Boolean = false):void
        {
            var loader:URLLoader;
            var headers:Array;
            var variables:URLVariables;
            var request:URLRequest;
            var key:*;
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, completeCallback, false, 0, true);
            loader.addEventListener(IOErrorEvent.IO_ERROR, ioCallback, false, 0, true);
            headers = [new URLRequestHeader("ccid", world.myAvatar.objData.CharID), new URLRequestHeader("token", loginInfo.strToken)];
            variables = new URLVariables();
            if (data != null)
            {
                for (key in data)
                {
                    variables[key] = ((key == "layout") ? com.adobe.serialization.json.JSON.encode(data[key]) : data[key]);
                };
            };
            request = new URLRequest((((serverGamePath + "api/char/") + api) + ((force) ? ("?v=" + Math.random()) : "")));
            request.requestHeaders = headers;
            if (data != null)
            {
                request.data = variables;
            };
            trace(variables);
            request.method = URLRequestMethod.POST;
            loader.load(request);
        }

        public function getBank():void
        {
            requestAPI("bank", {"layout": {"cat": "all"}}, onBankComplete, onBankError, true);
        }

        public function onBankComplete(e:Event):void
        {
            trace("Bank load complete");
            world.myAvatar.initBank(com.adobe.serialization.json.JSON.decode(e.target.data));
        }

        public function onBankError(e:IOErrorEvent):void
        {
            mcConnDetail.showConn("Error loading bank information");
        }

        public function onUncaughtError(e:*):void
        {
            var error:* = e.error;
            var errorInfo:String = "";
            if ((error is Error))
            {
                errorInfo = ((((Error(error).name + ": ") + Error(error).message) + "\n") + Error(error).getStackTrace());
            }
            else
            {
                if ((error is ErrorEvent))
                {
                    errorInfo = ErrorEvent(error).text;
                }
                else
                {
                    errorInfo = error.toString();
                };
            };
            reportError(errorInfo);
        }

        public function reportError(errorInfo:String):void
        {
            trace(("Global Error Caught: " + errorInfo));
            requestAPI("log", {"error": errorInfo}, null, null, true);
        }

        public function retrieveInfo(clientvars:Array):void
        {
            var loader:URLLoader;
            var val:*;
            if (serverGamePath.indexOf("content.aq") == -1)
            {
                for each (val in clientvars)
                {
                    world.objInfo[val.split("=")[0]] = val.substr((val.indexOf("=") + 1));
                };
                if (ASSETS_READY == clientvars["sAssets"])
                {
                    BOOK_DATA_READY = null;
                    resumeOnLoginResponse();
                }
                else
                {
                    BOOK_DATA_READY = null;
                    loadExternalAssets();
                };
                return;
            };
            loader = new URLLoader();
            loader.addEventListener(Event.COMPLETE, onInfoComplete, false, 0, true);
            loader.addEventListener(IOErrorEvent.IO_ERROR, onInfoError, false, 0, true);
            loader.load(new URLRequest(((serverGamePath + "api/data/clientvars?v=") + Math.random())));
        }

        public function retrieveBook():void
        {
            var loader_BoL:URLLoader;
            if (ui.getChildByName("travelLoaderMC"))
            {
                return;
            };
            travelLoaderMC = new ((world.getClass("mcLoader") as Class))();
            travelLoaderMC.x = 400;
            travelLoaderMC.y = 211;
            travelLoaderMC.name = "travelLoaderMC";
            ui.addChild(travelLoaderMC);
            loader_BoL = new URLLoader();
            loader_BoL.addEventListener(Event.COMPLETE, onBoLComplete, false, 0, true);
            loader_BoL.addEventListener(ProgressEvent.PROGRESS, onBoLProgress, false, 0, true);
            loader_BoL.addEventListener(IOErrorEvent.IO_ERROR, onBoLError, false, 0, true);
            var version:String = ((world.objInfo.hasOwnProperty("sVersion")) ? world.objInfo["sVersion"] : String(Math.random()));
            loader_BoL.load(new URLRequest(((serverGamePath + "api/data/booklore?v=") + version)));
        }

        public function onInfoComplete(e:Event):void
        {
            var sInfo:Object;
            var i:*;
            sInfo = com.adobe.serialization.json.JSON.decode(e.target.data);
            for (i in sInfo)
            {
                world.objInfo[i] = sInfo[i];
            };
            if (ASSETS_READY == sInfo["sAssets"])
            {
                BOOK_DATA_READY = null;
                resumeOnLoginResponse();
            }
            else
            {
                BOOK_DATA_READY = null;
                loadExternalAssets();
            };
        }

        public function onInfoError(e:IOErrorEvent):void
        {
            mcConnDetail.showConn("Error loading client vars");
        }

        public function onBoLComplete(e:Event):void
        {
            var sInfo:Object;
            sInfo = com.adobe.serialization.json.JSON.decode(e.target.data);
            world.bookData = sInfo;
            BOOK_DATA_READY = sInfo;
            ui.mcPopup.mcBook.removeChildAt(0);
            if (bolContent)
            {
                if (newInstance)
                {
                    newInstance = false;
                    bolContent.gotoAndStop("NavMenu");
                };
                ui.mcPopup.mcBook.addChild(bolContent);
                return;
            };
            bolLoader = new Loader();
            bolLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBoLContentComplete, false, 0, true);
            bolLoader.load(new URLRequest((Game.serverFilePath + world.objInfo.sBook)), new LoaderContext(false, ApplicationDomain.currentDomain));
        }

        public function onBoLContentComplete(e:Event):void
        {
            trace("BoL Completed");
            bolContent = e.currentTarget.content;
            ui.mcPopup.mcBook.addChild(bolContent);
        }

        private function onBoLProgress(event:ProgressEvent):void
        {
            var percent:int;
            bLoaded = event.bytesLoaded;
            bTotal = event.bytesTotal;
            percent = int(((bLoaded / bTotal) * 100));
            var barProg:Number = (bLoaded / bTotal);
            travelLoaderMC.mcPct.text = (percent + "%");
            if (bLoaded >= bTotal)
            {
                travelLoaderMC.parent.removeChild(travelLoaderMC);
                travelLoaderMC = null;
            };
        }

        private function onBoLError(e:IOErrorEvent):void
        {
            trace(("BoL load failed: " + e));
            if (travelLoaderMC)
            {
                travelLoaderMC.parent.removeChild(travelLoaderMC);
                travelLoaderMC = null;
            };
        }

        public function serialCmdInit(cmd:String):void
        {
            var sl:*;
            var cmdBar:*;
            sl = mcLogin.il;
            cmdBar = sl.cmd;
            cmdBar.btnUnselectAll.visible = false;
            cmdBar.btnSelectAll.visible = false;
            cmdBar.btnGo.visible = false;
            serialCmd.si = 0;
            serialCmd.cmd = cmd;
            serialCmd.active = true;
            serialCmdNext();
        }

        private function serialCmdNext():void
        {
            var date_now:Date;
            var sl:*;
            var prevServer:*;
            date_now = new Date();
            sl = mcLogin.il.iClass;
            var cmdBar:* = mcLogin.il.cmd;
            if (serialCmd.si > 0)
            {
                prevServer = sl.getServerItemByIP(serialCmd.servers[(serialCmd.si - 1)].sIP, serialCmd.servers[(serialCmd.si - 1)].iPort);
                if (prevServer != null)
                {
                    sl.serverOn(prevServer);
                    prevServer.t3.text = (((date_now.getTime() - serialCmd.ts) / 1000) + " s");
                    prevServer.t3.visible = true;
                };
            };
            trace(((("DEBUG: " + serialCmd.si) + "\t") + serialCmd.servers.length));
            if (serialCmd.si < serialCmd.servers.length)
            {
                trace(("connecting to: " + serialCmd.servers[serialCmd.si].sName));
                sfc.connect(serialCmd.servers[serialCmd.si].sIP, serialCmd.servers[serialCmd.si].iPort);
                serialCmd.si++;
                serialCmd.ts = date_now.getTime();
            }
            else
            {
                serialCmdDone();
            };
        }

        private function serialCmdDone():void
        {
            var sl:*;
            var cmdBar:*;
            sl = mcLogin.il;
            cmdBar = sl.cmd;
            cmdBar.btnUnselectAll.visible = true;
            cmdBar.btnSelectAll.visible = true;
            cmdBar.btnGo.visible = true;
            serialCmd.active = false;
        }

        public function readIA1Preferences():void
        {
            uoPref.bCloak = (world.getAchievement("ia1", 0) == 0);
            uoPref.bHelm = (world.getAchievement("ia1", 1) == 0);
            uoPref.bPet = (world.getAchievement("ia1", 2) == 0);
            uoPref.bWAnim = (world.getAchievement("ia1", 3) == 0);
            uoPref.bGoto = (world.getAchievement("ia1", 4) == 0);
            uoPref.bMusicOn = (world.getAchievement("ia1", 6) == 0);
            uoPref.bFriend = (world.getAchievement("ia1", 7) == 0);
            uoPref.bParty = (world.getAchievement("ia1", 8) == 0);
            uoPref.bGuild = (world.getAchievement("ia1", 9) == 0);
            uoPref.bWhisper = (world.getAchievement("ia1", 10) == 0);
            uoPref.bTT = (world.getAchievement("ia1", 11) == 0);
            uoPref.bFBShare = (world.getAchievement("ia1", 12) == 1);
            uoPref.bDuel = (world.getAchievement("ia1", 13) == 0);
            world.hideAllCapes = (world.getAchievement("ia1", 14) == 1);
            world.hideOtherPets = (world.getAchievement("ia1", 15) == 1);
            world.showAnimations = (world.getAchievement("ia1", 17) == 0);
            uoPref.bProf = (world.getAchievement("ia1", 18) == 0);
            uoPref.bFBShard = false;
            mixer.stf = new SoundTransform(((litePreference.data.dOptions["iSoundFX"] != null) ? litePreference.data.dOptions["iSoundFX"] : 1));
            SoundMixer.soundTransform = new SoundTransform(((litePreference.data.dOptions["iSoundAll"] != null) ? litePreference.data.dOptions["iSoundAll"] : 1));
        }

        public function inituoPref():void
        {
            uoPref.bCloak = true;
            uoPref.bHelm = true;
            uoPref.bPet = true;
            uoPref.bWAnim = true;
            uoPref.bGoto = true;
            uoPref.bMusicOn = true;
            uoPref.bFriend = true;
            uoPref.bParty = true;
            uoPref.bGuild = true;
            uoPref.bWhisper = true;
            uoPref.bTT = true;
            uoPref.bFBShare = false;
            uoPref.bDuel = true;
        }

        public function initKeybindPref(force:Boolean = false):void
        {
            if (((litePreference.data.keys) && (!(force))))
            {
                return;
            };
            litePreference.data.keys = {};
            litePreference.data.keys["Camera Tool"] = 219;
            litePreference.data.keys["World Camera"] = 221;
            litePreference.data.keys["Target Random Monster"] = 84;
            litePreference.data.keys["Inventory"] = 73;
            litePreference.data.keys["Bank"] = 66;
            litePreference.data.keys["Quest Log"] = 76;
            litePreference.data.keys["Friends List"] = 70;
            litePreference.data.keys["Character Panel"] = 67;
            litePreference.data.keys["Player HP Bar"] = 86;
            litePreference.data.keys["Options"] = 79;
            litePreference.data.keys["Area List"] = 85;
            litePreference.data.keys["Jump"] = 32;
            litePreference.data.keys["Auto Attack"] = 49;
            litePreference.data.keys["Skill 1"] = 50;
            litePreference.data.keys["Skill 2"] = 51;
            litePreference.data.keys["Skill 3"] = 52;
            litePreference.data.keys["Skill 4"] = 53;
            litePreference.data.keys["Skill 5"] = 54;
            litePreference.data.keys["Travel Menu's Travel"] = 89;
            litePreference.data.keys["World Camera's Hide"] = 72;
            litePreference.data.keys["Rest"] = 88;
            litePreference.data.keys["Hide Monsters"] = null;
            litePreference.data.keys["Hide Players"] = null;
            litePreference.data.keys["Cancel Target"] = 27;
            litePreference.data.keys["Hide UI"] = null;
            litePreference.data.keys["Battle Analyzer"] = null;
            litePreference.data.keys["Decline All Drops"] = null;
            litePreference.data.keys["Stats Overview"] = null;
            litePreference.data.keys["Battle Analyzer Toggle"] = null;
            litePreference.data.keys["Custom Drops UI"] = null;
            litePreference.data.keys["@ Debugger - Cell Menu"] = 192;
        }

        public function debugMessage(s:String):void
        {
            if (!litePreference.data.bDebugger)
            {
                return;
            };
            chatF.pushMsg("warning", s, "SERVER", "", 0);
        }

        public function initlitePref():void
        {
            if (litePreference.data.dOptions == null)
            {
                litePreference.data.dOptions = {};
            };
            if (litePreference.data.dOptions["termsAgree"] == null)
            {
                litePreference.data.dOptions["termsAgree"] = true;
            };
            litePref = [ {
                        "strName": "@ Debugger",
                        "bEnabled": litePreference.data.bDebugger,
                        "sDesc": "Debug Mode!\nPress ` to hide/show the cell & pads menu!",
                        "minAccess": 30,
                        "extra": [ {
                                "strName": "Disable Linkage Errors",
                                "bEnabled": litePreference.data.dOptions["debugLinkage"],
                                "sDesc": "Avoid receiving linkage error messages"
                            }]
                    }, {
                        "strName": "Allow Quest Log Turn-Ins",
                        "bEnabled": litePreference.data.bQuestLog,
                        "sDesc": "Allows you to turn-in quests using your quest log on the bottom right screen!"
                    }, {
                        "strName": "Auto-Untarget Dead Targets",
                        "bEnabled": litePreference.data.bUntargetDead,
                        "sDesc": "This will untarget targets that are dead."
                    }, {
                        "strName": "Auto-Untarget Self",
                        "bEnabled": litePreference.data.bUntargetSelf,
                        "sDesc": "This will prevent you from targetting yourself."
                    }, {
                        "strName": "Battle Analyzer",
                        "extra": "btn",
                        "sDesc": "This will allow you to monitor your damage dealt, gold earned, and many more!"
                    }, {
                        "strName": "Battlepets",
                        "bEnabled": litePreference.data.bBattlepet,
                        "sDesc": "Allows your battlepet to fight alongside you without a battlepet class equipped."
                    }, {
                        "strName": "Static Player Art",
                        "bEnabled": litePreference.data.bCachePlayers,
                        "sDesc": "Reduces the graphics of other players. \n!WARNING! Having this enabled may or may not show some of the other player's colors. You will not be able to see their equipment changes with this enabled either.\nYou must change rooms after turning this feature off in order for changes to take effect"
                    }, /*{
                "strName":"Char Page",
                "special":1,
                "sDesc":"Search Character Pages"
            }, {
                "strName":"Character Select Screen",
                "bEnabled":litePreference.data.bCharSelect,
                "sDesc":"Allows you to replace the login screen with a character select screen."
            },*/ {
                        "strName": "Chat Settings",
                        "bEnabled": litePreference.data.bChatFilter,
                        "sDesc": "Allow the customization of the game's chat window with the options below!",
                        "extra": [ {
                                "strName": "Timestamps",
                                "bEnabled": litePreference.data.dOptions["timeStamps"],
                                "sDesc": "Adding timestamps to chat messages (Server Time)\nOnly works on the old chat ui!"
                            }, {
                                "strName": "Disable Red Messages",
                                "bEnabled": litePreference.data.dOptions["disRed"],
                                "sDesc": "Avoid receiving combat warning messages in chat"
                            }]
                    }, {
                        "strName": "Chat UI",
                        "bEnabled": litePreference.data.bChatUI,
                        "sDesc": "If enabled, you will switch to the new Chat UI.",
                        "extra": [ {
                                "strName": "Minimal Mode",
                                "bEnabled": litePreference.data.dOptions["chatMinimal"],
                                "sDesc": "Less intrusive on your gameplay!\nHover over the message box to make the messages visible\nScroll over the message box to scroll!"
                            }, {
                                "strName": "Collapse on Unfocus",
                                "bEnabled": litePreference.data.dOptions["chatCollapse"],
                                "sDesc": "The Chat UI will collapse when your mouse is not focusing it"
                            }, {
                                "strName": "Disable AutoScroll to Bottom",
                                "bEnabled": litePreference.data.dOptions["chatScroll"],
                                "sDesc": "The Chat UI will not automatically scroll to the bottom on a new message"
                            }]
                    }, {
                        "strName": "Class Actives/Auras UI",
                        "bEnabled": litePreference.data.bAuras,
                        "sDesc": "Work in Progress. No proper stack limit and icons yet.\nAllows you to view your buffs/auras underneath your player portrait and for your enemies as well!",
                        "extra": [ {
                                "strName": "Disable ToolTips",
                                "bEnabled": litePreference.data.dOptions["disAuraTips"],
                                "sDesc": "Prevents you from seeing tooltips when hovering over an aura."
                            }]
                    }, {
                        "strName": "Color Sets",
                        "bEnabled": litePreference.data.bColorSets,
                        "sDesc": "Save your colors with this tool that appears when you go customizing your hair or armor colors!"
                    }, {
                        "strName": "Custom Drops UI",
                        "bEnabled": litePreference.data.bCustomDrops,
                        "sDesc": "Shift+Click to block an item drop!\nYour bank items must be loaded to detect if you already have an item",
                        "extra": [ {
                                "strName": "Invert Menu",
                                "bEnabled": litePreference.data.dOptions["invertMenu"],
                                "sDesc": "The drop menu will appear at the top of the screen rather than appearing at the bottom"
                            }, {
                                "strName": "Warn When Declining A Drop",
                                "bEnabled": litePreference.data.dOptions["warnDecline"],
                                "sDesc": "A confirmation box will appear to confirm if you want to decline an item drop"
                            }, {
                                "strName": "Hide Temporary Drop Notifications",
                                "bEnabled": litePreference.data.dOptions["hideTemp"],
                                "sDesc": "This will hide temporary drop notifications"
                            }, {
                                "strName": "Opened Menu",
                                "bEnabled": litePreference.data.dOptions["openMenu"],
                                "sDesc": "The Custom Drops UI will start up opened rather than closed"
                            }, {
                                "strName": "Draggable Mode",
                                "bEnabled": litePreference.data.dOptions["dragMode"],
                                "sDesc": "The Custom Drops UI will be draggable rather than being attached to the screen"
                            }, {
                                "strName": "Lock Position",
                                "bEnabled": litePreference.data.dOptions["lockMode"],
                                "sDesc": "The draggable Custom Drops UI will not be moved from where it was last placed"
                            }, {
                                "strName": "Reset Position",
                                "extra": "btn",
                                "sDesc": "If the Drop UI somehow goes off-screen and you can't see it, then use this to get it back!\nWorks only for \"Draggable Mode\""
                            }, {
                                "strName": "Quantity Warnings",
                                "bEnabled": litePreference.data.dOptions["termsAgree"],
                                "sDesc": "By disabling this feature you understand help from player support for unaccepted drops will be limited"
                            }]
                    }, {
                        "strName": "Disable Chat Scrolling",
                        "bEnabled": litePreference.data.bDisChatScroll,
                        "sDesc": "Prevents you from scrolling the chat\nOnly works on the old chat ui!"
                    }, {
                        "strName": "Disable Damage Numbers",
                        "bEnabled": litePreference.data.bDisDmgDisplay,
                        "sDesc": "Disables all damage numbers from showing as well as the white flash/strobe effect"
                    }, {
                        "strName": "Disable Damage Strobe",
                        "bEnabled": litePreference.data.bDisDmgStrobe,
                        "sDesc": "Prevents the white flash/strobe effect whenever a monster or player is damaged!"
                    }, {
                        "strName": "Disable Monster Animations",
                        "bEnabled": litePreference.data.bDisMonAnim,
                        "sDesc": "Disables monster animations with the benefit of performance"
                    }, {
                        "strName": "Disable Self Animations",
                        "bEnabled": litePreference.data.bDisSelfMAnim,
                        "sDesc": "Disables your player's movement animations except for walking for the benefit of performance"
                    }, {
                        "strName": "Disable Skill Animations",
                        "bEnabled": litePreference.data.bDisSkillAnim,
                        "sDesc": 'There are two types of animations: Class Skill Animations & Player Movement Animations\nThis feature disables Class Skill Animations only while the regular "Animations" setting will disable both Class Skill Animations & Player Movement Animations',
                        "extra": [ {
                                "strName": "Show Your Skill Animations Only",
                                "bEnabled": litePreference.data.dOptions["animSelf"],
                                "sDesc": 'Only works if "Disable Skill Animations" is enabled!\nAdds an exception to "Disable Skill Animations" to show your skill animations only'
                            }]
                    }, {
                        "strName": "Disable Quest Popup",
                        "bEnabled": litePreference.data.bDisQPopup,
                        "sDesc": "Prevent the Quest Complete Popup if it becomes too intrusive"
                    }, {
                        "strName": "Disable Quest Tracker",
                        "bEnabled": litePreference.data.bDisQTracker,
                        "sDesc": "Prevent the Quest Tracker from opening"
                    }, {
                        "strName": "Disable Weapon Animations",
                        "bEnabled": litePreference.data.bDisWepAnim,
                        "sDesc": "Disables weapon animations\nYou can disable a specific player's weapon animations by targetting them and clicking on their portrait!",
                        "extra": [ {
                                "strName": "Keep Your Weapon Animations Only",
                                "bEnabled": litePreference.data.dOptions["wepSelf"],
                                "sDesc": 'Only works if "Disable Weapon Animation" is enabled!\nHaving this enabled will allow your weapon animations to continue working while others have theirs disabled'
                            }]
                    }, {
                        "strName": "Decline All Drops",
                        "extra": "btn",
                        "sDesc": "Declines all the drops on your screen"
                    }, {
                        "strName": "Display FPS",
                        "extra": "btn",
                        "sDesc": "Toggles the Frames Per Second Display"
                    }, {
                        "strName": "Draggable Drops",
                        "bEnabled": litePreference.data.bDraggable,
                        "sDesc": 'Allows you to drag, or move around, the drops on your screen\nToggling this on with drops already on your screen will not make those drops draggable\nOnly works if "Custom Drops UI" is not enabled'
                    }, {
                        "strName": "Freeze / Lock Monster Position",
                        "bEnabled": litePreference.data.bFreezeMons,
                        "sDesc": "This will freeze monsters on the map in place to prevent players from luring/dragging monsters all over the map"
                    }, {
                        "strName": "Invisible Monsters",
                        "bEnabled": litePreference.data.bHideMons,
                        "sDesc": "Make monsters invisible. You can target them by clicking on their shadow"
                    }, {
                        "strName": "Hide Players",
                        "bEnabled": litePreference.data.bHidePlayers,
                        "sDesc": "This will hide players on the map\nYou can hide specific players by clicking on their portraits (targetting them)!",
                        "extra": [ {
                                "strName": "Show Name Tags",
                                "bEnabled": litePreference.data.dOptions["showNames"],
                                "sDesc": "Only works if \"Hide Players\" is enabled!\nHaving this enabled will allow you to still see name tags of players even though they're hidden."
                            }, {
                                "strName": "Show Shadows",
                                "bEnabled": litePreference.data.dOptions["showShadows"],
                                "sDesc": 'Only works if "Hide Players" is enabled!\nHaving this enabled will allow you to still see player shadows and clicking on the shadows will target them.'
                            }]
                    }, {
                        "strName": "Hide Player Names",
                        "bEnabled": litePreference.data.bHideNames,
                        "sDesc": "Hides player names\nHover over a player to reveal their name & guild",
                        "extra": [ {
                                "strName": "Hide Guild Names Only",
                                "bEnabled": litePreference.data.dOptions["hideGuild"],
                                "sDesc": "Player names will be visible, and guild names will be hidden"
                            }, {
                                "strName": "Hide Your Name Only",
                                "bEnabled": litePreference.data.dOptions["hideSelf"],
                                "sDesc": 'Only your name will be hidden.\nEnabling this setting will not make "Hide Guild Names Only" work.'
                            }]
                    }, {
                        "strName": "Hide UI",
                        "bEnabled": litePreference.data.bHideUI,
                        "sDesc": "Hides player & target portraits located on the top left as well as the map name & area list located on the bottom right"
                    }, {
                        "strName": "Item Drops Block List",
                        "extra": "btn",
                        "sDesc": 'Shift+Click dropped items while using "Custom Drops UI" to add items to block!'
                    }, {
                        "strName": "Keybinds",
                        "extra": "btn",
                        "sDesc": "Customize game keybinds.\nYou can not bind ENTER or /.\nUse BACKSPACE to delete a bind."
                    }, {
                        "strName": "Reaccept Quest After Turn-In",
                        "bEnabled": litePreference.data.bReaccept,
                        "sDesc": "After turning in a quest, it will try to reaccept the quest if possible"
                    }, {
                        "strName": "Show Monster Type",
                        "bEnabled": litePreference.data.bMonsType,
                        "sDesc": "Display the monster's type as a tag under their name"
                    }, {
                        "strName": "Smooth Background",
                        "bEnabled": litePreference.data.bSmoothBG,
                        "sDesc": "Removes map background pixelation\nYou must reload the map or move to a new area to see changes take affect"
                    }, {
                        "strName": "Travel Menu",
                        "extra": "btn",
                        "sDesc": 'Jump between multiple maps with a press of a button!\nThe keybind to jump maps is rebindable within "Keybinds"!'
                    }, {
                        "strName": "Quest Pinner",
                        "bEnabled": litePreference.data.bQuestPin,
                        "sDesc": '1. Open quests from any NPC\n2. Press the "Pin Quests" button (left)\n3. You can now access it from anywhere by clicking on the yellow (!) quest log icon at the top left!\nShift+Click the yellow (!) quest log icon to open the Quest Tracker!\nShift+Click the quest pinner icon to clear your pinned quests!'
                    }, {
                        "strName": "Quest Progress Notifications",
                        "bEnabled": litePreference.data.bQuestNotif,
                        "sDesc": "Quest Progress will continue to notify/update you even when you've completed the quest"
                    }, {
                        "strName": "Visual Skill CDs",
                        "bEnabled": litePreference.data.bSkillCD,
                        "sDesc": "Visual skill cooldowns!"
                    }];
        }

        public function isTestClient():Boolean
        {
            var tServers:Array;
            var server:*;
            tServers = ["Dev Grotto", "Dev04"];
            for each (server in tServers)
            {
                if (objServerInfo.sName.toLowerCase() == server.toLowerCase())
                {
                    return (true);
                };
            };
            return (false);
        }

        public function castSpellFX(param1:*, param2:*, param3:*, param4:*):*
        {
            cameraToolMC.castSpellFX();
        }

        public function movieClipStopAll(container:MovieClip):void
        {
            var i:uint;
            i = 0;
            while (i < container.numChildren)
            {
                if ((container.getChildAt(i) is MovieClip))
                {
                    try
                    {
                        (container.getChildAt(i) as MovieClip).gotoAndStop(0);
                        movieClipStopAll((container.getChildAt(i) as MovieClip));
                    }
                    catch (exception)
                    {
                    };
                };
                i++;
            };
        }

        public function rasterizePart(avt:DisplayObject):Bitmap
        {
            var avtMatrix:Matrix;
            var avtGBounds:Rectangle;
            var avtOffset:Point;
            var avtBMD:BitmapData;
            var avtBM:Bitmap;
            avtMatrix = avt.transform.matrix;
            avtGBounds = avt.getBounds(avt.parent);
            avtOffset = new Point((avt.x - avtGBounds.left), (avt.y - avtGBounds.top));
            avtMatrix.tx = avtOffset.x;
            avtMatrix.ty = avtOffset.y;
            avtBMD = new BitmapData(avtGBounds.width, avtGBounds.height, true, 0);
            avtBMD.draw(avt, avtMatrix, avt.transform.colorTransform, null, null, true);
            avtBM = new Bitmap(avtBMD);
            avtBM.smoothing = true;
            avtBM.x = (avtBM.x - avtOffset.x);
            avtBM.y = (avtBM.y - avtOffset.y);
            return (avtBM);
        }

        public function rasterize(avtDisplay:MovieClip):void
        {
            movieClipRasterizeInner(avtDisplay);
        }

        public function movieClipRasterizeInner(container:MovieClip):void
        {
            var i:uint;
            var toRasterize:MovieClip;
            var spriteWrapper:Sprite;
            var rasterized:*;
            i = 0;
            for (; i < container.numChildren; i++)
            {
                if ((container.getChildAt(i) is MovieClip))
                {
                    try
                    {
                        toRasterize = (container.getChildAt(i) as MovieClip);
                        if (toRasterize.visible == false)
                        {
                            continue;
                        };
                        toRasterize.getChildAt(0).visible = false;
                        spriteWrapper = new Sprite();
                        spriteWrapper.addChild(rasterizePart(toRasterize.getChildAt(0)));
                        rasterized = toRasterize.addChildAt(spriteWrapper, 0);
                        movieClipRasterizeInner((container.getChildAt(i) as MovieClip));
                    }
                    catch (exception)
                    {
                    };
                };
            };
        }

        public function getQuestValidationString(qData:Object):String
        {
            var iRank:int;
            var iSpillCP:*;
            var iFactionRank:int;
            var iSpillRep:*;
            var strText:String;
            var i:int;
            var obj:Object;
            var iQty:int;
            var iClassRank:int;
            var iSpillClassPoints:*;
            if (((!(qData.sField == null)) && (!(world.getAchievement(qData.sField, qData.iIndex) == 0))))
            {
                if (qData.sField == "im0")
                {
                    return ("Monthly Quests are only available once per month.");
                };
                if (qData.sField == "iw0")
                {
                    return ("Weekly Quests are only available once per week.");
                };
                return ("Daily Quests are only available once per day.");
            };
            if (((qData.bUpg == 1) && (!(world.myAvatar.isUpgraded()))))
            {
                return ("Upgrade is required for this quest!");
            };
            if (((qData.iSlot >= 0) && (world.getQuestValue(qData.iSlot) < (qData.iValue - 1))))
            {
                return ("Quest has not been unlocked!");
            };
            if (qData.iLvl > world.myAvatar.objData.intLevel)
            {
                return (("Unlocks at Level " + qData.iLvl) + ".");
            };
            if (((qData.iClass > 0) && (world.myAvatar.getCPByID(qData.iClass) < qData.iReqCP)))
            {
                iRank = getRankFromPoints(qData.iReqCP);
                iSpillCP = (qData.iReqCP - arrRanks[(iRank - 1)]);
                if (iSpillCP > 0)
                {
                    return (((((("Requires " + iSpillCP) + " Class Points on ") + qData.sClass) + ", Rank ") + iRank) + ".");
                };
                return (((("Requires " + qData.sClass) + ", Rank ") + iRank) + ".");
            };
            if (((qData.FactionID > 1) && (world.myAvatar.getRep(qData.FactionID) < qData.iReqRep)))
            {
                iFactionRank = getRankFromPoints(qData.iReqRep);
                iSpillRep = (qData.iReqRep - arrRanks[(iFactionRank - 1)]);
                if (iSpillRep > 0)
                {
                    return (((((("Requires " + iSpillRep) + " Reputation for ") + qData.sFaction) + ", Rank ") + iFactionRank) + ".");
                };
                return (((("Requires " + qData.sFaction) + ", Rank ") + iFactionRank) + ".");
            };
            if (((!(qData.reqd == null)) && (!(hasRequiredItemsForQuest(qData)))))
            {
                strText = "Required Item(s): ";
                i = 0;
                while (i < qData.reqd.length)
                {
                    obj = world.invTree[qData.reqd[i].ItemID];
                    iQty = qData.reqd[i].iQty;
                    if (obj.sES == "ar")
                    {
                        iClassRank = getRankFromPoints(iQty);
                        iSpillClassPoints = (iQty - arrRanks[(iClassRank - 1)]);
                        if (iSpillClassPoints > 0)
                        {
                            strText = (strText + (iSpillClassPoints + " Class Points on "));
                        };
                        strText = (strText + ((obj.sName + ", Rank ") + iClassRank));
                    }
                    else
                    {
                        strText = (strText + obj.sName);
                        if (iQty > 1)
                        {
                            strText = (strText + ("x" + iQty));
                        };
                    };
                    strText = (strText + ", ");
                    i++;
                };
                strText = (strText.substr(0, (strText.length - 2)) + ".");
                return (strText);
            };
            return ("");
        }

        private function hasRequiredItemsForQuest(quest:Object):Boolean
        {
            var i:int;
            var qItemID:*;
            var qItemQ:int;
            if (((!(quest.reqd == null)) && (quest.reqd.length > 0)))
            {
                i = 0;
                while (i < quest.reqd.length)
                {
                    qItemID = quest.reqd[i].ItemID;
                    qItemQ = int(quest.reqd[i].iQty);
                    if (((world.invTree[qItemID] == null) || (int(world.invTree[qItemID].iQty) < qItemQ)))
                    {
                        return (false);
                    };
                    i++;
                };
            };
            return (true);
        }

        public function xTryMe(curItem:Object):*
        {
            var sES:String;
            switch (curItem.sES)
            {
                case "Weapon":
                case "he":
                case "ba":
                case "pe":
                case "ar":
                case "co":
                    sES = curItem.sES;
                    sES = ((sES == "ar") ? "co" : sES);
                    if (sES == "pe")
                    {
                        if (world.myAvatar.objData.eqp["pe"])
                        {
                            world.myAvatar.unloadPet();
                        };
                    };
                    if (!world.myAvatar.objData.eqp[sES])
                    {
                        world.myAvatar.objData.eqp[sES] = {};
                        world.myAvatar.objData.eqp[sES].wasCreated = true;
                    };
                    if (((world.myAvatar.objData.eqp[sES].isPreview) || (world.myAvatar.objData.eqp[sES].wasCreated)))
                    {
                        if (world.myAvatar.objData.eqp[sES].sFile == curItem.sFile)
                        {
                            if (world.myAvatar.objData.eqp[sES].wasCreated)
                            {
                                delete world.myAvatar.objData.eqp[sES];
                                world.myAvatar.unloadMovieAtES(sES);
                            }
                            else
                            {
                                if (world.myAvatar.objData.eqp[sES].isPreview)
                                {
                                    if (sES == "pe")
                                    {
                                        if (world.myAvatar.objData.eqp["pe"])
                                        {
                                            world.myAvatar.unloadPet();
                                        };
                                    };
                                    world.myAvatar.objData.eqp[sES].sType = world.myAvatar.objData.eqp[sES].oldType;
                                    world.myAvatar.objData.eqp[sES].sFile = world.myAvatar.objData.eqp[sES].oldFile;
                                    world.myAvatar.objData.eqp[sES].sLink = world.myAvatar.objData.eqp[sES].oldLink;
                                    world.myAvatar.loadMovieAtES(sES, world.myAvatar.objData.eqp[sES].oldFile, world.myAvatar.objData.eqp[sES].oldLink);
                                    world.myAvatar.objData.eqp[sES].isPreview = null;
                                };
                            };
                            return;
                        };
                    };
                    if (!world.myAvatar.objData.eqp[sES].isPreview)
                    {
                        world.myAvatar.objData.eqp[sES].isPreview = true;
                        if (!world.myAvatar.objData.eqp[sES].isShowable)
                        {
                            if (("sType" in curItem))
                            {
                                world.myAvatar.objData.eqp[sES].oldType = world.myAvatar.objData.eqp[sES].sType;
                            };
                            world.myAvatar.objData.eqp[sES].oldFile = world.myAvatar.objData.eqp[sES].sFile;
                            world.myAvatar.objData.eqp[sES].oldLink = world.myAvatar.objData.eqp[sES].sLink;
                        };
                    };
                    if (("sType" in curItem))
                    {
                        world.myAvatar.objData.eqp[sES].sType = curItem.sType;
                    };
                    world.myAvatar.objData.eqp[sES].sFile = ((curItem.sFile == "undefined") ? "" : curItem.sFile);
                    world.myAvatar.objData.eqp[sES].sLink = curItem.sLink;
                    world.myAvatar.loadMovieAtES(sES, curItem.sFile, curItem.sLink);
                    if (((sES == "pe") && (!(curItem.sName.indexOf("Bank Pet") == -1))))
                    {
                        petDisable.addEventListener(TimerEvent.TIMER, onPetDisable, false, 0, true);
                        petDisable.start();
                    };
                    hasPreviewed = true;
                    break;
            };
        }

        internal function onPetDisable(e:TimerEvent):void
        {
            if (!world.myAvatar.petMC.mcChar)
            {
                return;
            };
            world.myAvatar.petMC.mcChar.mouseEnabled = false;
            world.myAvatar.petMC.mcChar.mouseChildren = false;
            world.myAvatar.petMC.mcChar.enabled = false;
            petDisable.reset();
            petDisable.removeEventListener(TimerEvent.TIMER, onPetDisable);
        }

        public function showPortrait(avt:Avatar):*
        {
            if (litePreference.data.bHideUI)
            {
                return;
            };
            showPortraitBox(avt, ui.mcPortrait);
            world.updatePortrait(avt);
            ui.iconQuest.visible = true;
            ui.monsterIcon.visible = true;
        }

        public function hidePortrait():void
        {
            ui.monsterIcon.visible = false;
            ui.mcPortrait.visible = false;
            ui.iconQuest.visible = false;
        }

        public function showPortraitTarget(avt:Avatar):*
        {
            if (litePreference.data.bHideUI)
            {
                return;
            };
            showPortraitBox(((Number(world.objExtra["bChar"]) == 1) ? world.myAvatar : avt), ui.mcPortraitTarget);
            ui.mcPortraitTarget.pvpIcon.visible = world.bPvP;
            world.updatePortrait(avt);
            ui.btnTargetPortraitClose.visible = true;
        }

        public function hidePortraitTarget():void
        {
            var mc:MovieClip;
            var child:DisplayObject;
            mc = (ui.mcPortraitTarget.mcHead as MovieClip);
            child = mc.head.getChildByName("face");
            if (child != null)
            {
                mc.head.removeChild(child);
            };
            while (mc.backhair.numChildren > 0)
            {
                mc.backhair.removeChildAt(0);
            };
            while (mc.head.hair.numChildren > 0)
            {
                mc.head.hair.removeChildAt(0);
            };
            while (mc.head.helm.numChildren > 0)
            {
                mc.head.helm.removeChildAt(0);
            };
            ui.mcPortraitTarget.visible = false;
            ui.btnTargetPortraitClose.visible = false;
        }

        public function showPortraitBox(avt:Avatar, mcPortraitBox:MovieClip):*
        {
            var AssetClass:Class;
            var mc:MovieClip;
            var child:DisplayObject;
            var bBackHair:Boolean;
            var sSkinLink:String;
            var AssetClass2:Class;
            mc = (mcPortraitBox.mcHead as MovieClip);
            bBackHair = false;
            mcPortraitBox.pAV = avt;
            if (avt.npcType == "monster")
            {
                AssetClass = world.getClass(("mcHead" + avt.objData.strLinkage));
                child = mc.head.getChildByName("face");
                if (child != null)
                {
                    mc.head.removeChild(child);
                };
                mc.head.addChildAt(new (AssetClass)(), 0).name = "face";
                mc.head.hair.visible = false;
                mc.head.helm.visible = false;
                mc.backhair.visible = false;
            }
            else
            {
                try
                {
                    sSkinLink = avt.objData.eqp.ar.sLink;
                    if (avt.objData.eqp.co != null)
                    {
                        sSkinLink = avt.objData.eqp.co.sLink;
                    };
                    AssetClass = world.getClass(((sSkinLink + avt.objData.strGender) + "Head"));
                    child = mc.head.getChildByName("face");
                    if (child != null)
                    {
                        mc.head.removeChild(child);
                    };
                    mc.head.addChildAt(new (AssetClass)(), 0).name = "face";
                }
                catch (err:Error)
                {
                    AssetClass = world.getClass(("mcHead" + avt.objData.strGender));
                    child = mc.head.getChildByName("face");
                    if (child != null)
                    {
                        mc.head.removeChild(child);
                    };
                    mc.head.addChildAt(new (AssetClass)(), 0).name = "face";
                };
                AssetClass = world.getClass(((avt.objData.strHairName + avt.objData.strGender) + "Hair"));
                while (mc.head.hair.numChildren > 0)
                {
                    mc.head.hair.removeChildAt(0);
                };
                try
                {
                    mc.head.hair.addChild(new (AssetClass)());
                }
                catch (e:Error)
                {
                };
                mc.head.hair.visible = true;
                try
                {
                    AssetClass = world.getClass(((avt.objData.strHairName + avt.objData.strGender) + "HairBack"));
                    while (mc.backhair.numChildren > 0)
                    {
                        mc.backhair.removeChildAt(0);
                    };
                    mc.backhair.addChild(new (AssetClass)());
                    mc.backhair.visible = true;
                    bBackHair = true;
                }
                catch (err:Error)
                {
                    mc.backhair.visible = false;
                };
                if (((!(avt.objData.eqp.he == null)) && (!(avt.objData.eqp.he.sLink == null))))
                {
                    try
                    {
                        AssetClass = world.getClass(avt.objData.eqp.he.sLink);
                        AssetClass2 = (world.getClass((avt.objData.eqp.he.sLink + "_backhair")) as Class);
                        while (mc.head.helm.numChildren > 0)
                        {
                            mc.head.helm.removeChildAt(0);
                        };
                        mc.head.helm.addChild(new (AssetClass)());
                        mc.head.helm.visible = avt.dataLeaf.showHelm;
                        mc.head.hair.visible = (!(mc.head.helm.visible));
                        if (AssetClass2 != null)
                        {
                            if (avt.dataLeaf.showHelm)
                            {
                                if (mc.backhair.numChildren > 0)
                                {
                                    mc.backhair.removeChildAt(0);
                                };
                                mc.backhair.visible = true;
                                mc.backhair.addChild(new (AssetClass2)());
                            };
                        }
                        else
                        {
                            mc.backhair.visible = ((mc.head.hair.visible) && (bBackHair));
                        };
                    }
                    catch (err:Error)
                    {
                        mc.head.helm.visible = false;
                    };
                }
                else
                {
                    mc.head.helm.visible = false;
                };
            };
            mcPortraitBox.visible = true;
            ui.mcPortrait.iconDrops.initRoot(this);
            ui.mcPortrait.iconDrops.visible = litePreference.data.bCustomDrops;
        }

        private function showBossBox(MonsterFile:Object, MonsterLink:Object)
        {
            var _loc3_:* = new URLLoader();
            strSkinLinkage = MonsterLink;
            _loc3_.dataFormat = URLLoaderDataFormat.BINARY;
            _loc3_.addEventListener(IOErrorEvent.IO_ERROR, this.ioErrorHandler, false, 0, true);
            _loc3_.addEventListener(Event.COMPLETE, onLoadMaster(onLoadSkinComplete, assetsContext));
            _loc3_.load(new URLRequest(serverFilePath + "mon/" + MonsterFile));
        }

        private function onLoadSkinComplete(evt:Event)
        {
            var AssetClass:Class;
            var mc:MovieClip;
            var child:DisplayObject;
            mc = (ui.mcWorldBoss.mcHead as MovieClip);
            AssetClass = (world.getClass("mcHead" + strSkinLinkage) as Class);
            child = mc.head.getChildByName("face");
            if (child != null)
            {
                mc.head.removeChild(child);
            };
            (mc.head.addChildAt(new (AssetClass)(), 0).name = "face");
            (mc.head.hair.visible = false);
            (mc.head.helm.visible = false);
            (mc.backhair.visible = false);
        }

        private function ioErrorHandler(event:IOErrorEvent):void
        {
            trace(("ioErrorHandler: " + event));
        }

        public function oniconQuestClick(e:MouseEvent):void
        {
            if (litePreference.data.bQuestPin)
            {
                if (e.shiftKey)
                {
                    ui.mcQTracker.toggle();
                    return;
                };
                world.showQuests(pinnedQuests, "q");
            }
            else
            {
                ui.mcQTracker.toggle();
            };
        }

        public function manageXPBoost(o:Object):void
        {
            var modal:*;
            var modalO:*;
            ui.mcPortrait.iconBoostXP.visible = (o.op == "+");
            if (o.op == "+")
            {
                world.myAvatar.objData.iBoostXP = o.iSecsLeft;
                ui.mcPortrait.iconBoostXP.boostTS = new Date().getTime();
                ui.mcPortrait.iconBoostXP.iBoostXP = o.iSecsLeft;
                ui.mcPortrait.iconBoostXP.bShowShop = o.bShowShop;
                addUpdate("You have activated the Experience Boost!  All Experience rewards are doubled while the effect holds.");
                chatF.pushMsg("server", (("You have activated the Experience Boost!  All Experience rewards are doubled while the effect holds. " + Math.ceil((o.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete world.myAvatar.objData.iBoostXP;
                delete ui.mcPortrait.iconBoostXP.boostTS;
                delete ui.mcPortrait.iconBoostXP.iBoostXP;
                addUpdate("The Experience Boost has faded!  Experience rewards are no longer doubled.");
                chatF.pushMsg("server", "The Experience Boost has faded!  Experience rewards are no longer doubled.", "SERVER", "", 0);
                if (((!(ui.mcPortrait.iconBoostXP.bShowShop == null)) && (ui.mcPortrait.iconBoostXP.bShowShop)))
                {
                    modal = new ModalMC();
                    modalO = {};
                    modalO.strBody = "Your Experience Boost has faded!\tExperience rewards are no longer doubled.  Would you like to purchase a new Experience Boost?";
                    modalO.params = {};
                    modalO.callback = openExpBoostStore;
                    modalO.glow = "red,medium";
                    ui.ModalStack.addChild(modal);
                    modal.init(modalO);
                };
            };
        }

        public function manageGBoost(o:Object):void
        {
            var modal:*;
            var modalO:*;
            ui.mcPortrait.iconBoostG.visible = (o.op == "+");
            if (o.op == "+")
            {
                world.myAvatar.objData.iBoostG = o.iSecsLeft;
                ui.mcPortrait.iconBoostG.boostTS = new Date().getTime();
                ui.mcPortrait.iconBoostG.iBoostG = o.iSecsLeft;
                ui.mcPortrait.iconBoostG.bShowShop = o.bShowShop;
                addUpdate("You have activated the Gold Boost!  All Gold rewards are doubled while the effect holds.");
                chatF.pushMsg("server", (("You have activated the Gold Boost!  All Gold rewards are doubled while the effect holds. " + Math.ceil((o.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete world.myAvatar.objData.iBoostG;
                delete ui.mcPortrait.iconBoostG.boostTS;
                delete ui.mcPortrait.iconBoostG.iBoostG;
                addUpdate("The Gold Boost has faded!  Gold rewards are no longer doubled.");
                chatF.pushMsg("server", "The Gold Boost has faded!  Gold rewards are no longer doubled.", "SERVER", "", 0);
                if (((!(ui.mcPortrait.iconBoostG.bShowShop == null)) && (ui.mcPortrait.iconBoostG.bShowShop)))
                {
                    modal = new ModalMC();
                    modalO = {};
                    modalO.strBody = "Your Gold Boost has faded!  Gold rewards are no longer doubled.  Would you like to purchase a new Gold Boost?";
                    modalO.params = {};
                    modalO.callback = openExpBoostStore;
                    modalO.glow = "red,medium";
                    ui.ModalStack.addChild(modal);
                    modal.init(modalO);
                };
            };
        }

        public function manageRepBoost(o:Object):void
        {
            var modal:*;
            var modalO:*;
            ui.mcPortrait.iconBoostRep.visible = (o.op == "+");
            if (o.op == "+")
            {
                world.myAvatar.objData.iBoostRep = o.iSecsLeft;
                ui.mcPortrait.iconBoostRep.boostTS = new Date().getTime();
                ui.mcPortrait.iconBoostRep.iBoostRep = o.iSecsLeft;
                ui.mcPortrait.iconBoostRep.bShowShop = o.bShowShop;
                addUpdate("You have activated the Reputation Boost!  All Reputation rewards are doubled while the effect holds.");
                chatF.pushMsg("server", (("You have activated the Reputation Boost!  All Reputation rewards are doubled while the effect holds. " + Math.ceil((o.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete world.myAvatar.objData.iBoostRep;
                delete ui.mcPortrait.iconBoostRep.boostTS;
                delete ui.mcPortrait.iconBoostRep.iBoostRep;
                addUpdate("The Reputation Boost has faded!  Reputation rewards are no longer doubled.");
                chatF.pushMsg("server", "The Reputation Boost has faded!  Reputation rewards are no longer doubled.", "SERVER", "", 0);
                if (((!(ui.mcPortrait.iconBoostRep.bShowShop == null)) && (ui.mcPortrait.iconBoostRep.bShowShop)))
                {
                    modal = new ModalMC();
                    modalO = {};
                    modalO.strBody = "Your Reputation Boost has faded!\tReputation rewards are no longer doubled.  Would you like to purchase a new Reputation Boost?";
                    modalO.params = {};
                    modalO.callback = openExpBoostStore;
                    modalO.glow = "red,medium";
                    ui.ModalStack.addChild(modal);
                    modal.init(modalO);
                };
            };
        }

        public function manageCPBoost(o:Object):void
        {
            var modal:*;
            var modalO:*;
            ui.mcPortrait.iconBoostCP.visible = (o.op == "+");
            if (o.op == "+")
            {
                world.myAvatar.objData.iBoostCP = o.iSecsLeft;
                ui.mcPortrait.iconBoostCP.boostTS = new Date().getTime();
                ui.mcPortrait.iconBoostCP.iBoostCP = o.iSecsLeft;
                ui.mcPortrait.iconBoostCP.bShowShop = o.bShowShop;
                addUpdate("You have activated the ClassPoint Boost!  All ClassPoint rewards are doubled while the effect holds.");
                chatF.pushMsg("server", (("You have activated the ClassPoint Boost!  All ClassPoint rewards are doubled while the effect holds. " + Math.ceil((o.iSecsLeft / 60))) + " minute(s) remaining."), "SERVER", "", 0);
            }
            else
            {
                delete world.myAvatar.objData.iBoostCP;
                delete ui.mcPortrait.iconBoostCP.boostTS;
                delete ui.mcPortrait.iconBoostCP.iBoostCP;
                addUpdate("The ClassPoint Boost has faded!  ClassPoint rewards are no longer doubled.");
                chatF.pushMsg("server", "The ClassPoint Boost has faded!  ClassPoint rewards are no longer doubled.", "SERVER", "", 0);
                if (((!(ui.mcPortrait.iconBoostCP.bShowShop == null)) && (ui.mcPortrait.iconBoostCP.bShowShop)))
                {
                    modal = new ModalMC();
                    modalO = {};
                    modalO.strBody = "Your ClassPoint Boost has faded!\tClassPoint rewards are no longer doubled.  Would you like to purchase a new ClassPoint Boost?";
                    modalO.params = {};
                    modalO.callback = openExpBoostStore;
                    modalO.glow = "red,medium";
                    ui.ModalStack.addChild(modal);
                    modal.init(modalO);
                };
            };
        }

        public function oniconBoostXPOver(e:MouseEvent):void
        {
            var mc:MovieClip;
            var now:Number;
            var n:Number;
            var m:int;
            var s:String;
            mc = MovieClip(e.currentTarget);
            now = new Date().getTime();
            n = Math.max(((mc.boostTS + (mc.iBoostXP * 1000)) - now), 0);
            m = 0;
            s = "All Experience gains are doubled.\n";
            if (n < 120000)
            {
                m = int(Math.floor((n / 60000)));
                s = (s + String((m + " minute(s), ")));
                m = int(Math.round(((n % 60000) / 1000)));
                s = (s + String((m + " second(s) remaining.")));
            }
            else
            {
                m = int(Math.round((n / 60000)));
                s = (s + String((m + " minutes remaining.")));
            };
            ui.ToolTip.openWith({"str": s});
        }

        public function oniconBoostGoldOver(e:MouseEvent):void
        {
            var mc:MovieClip;
            var now:Number;
            var n:Number;
            var m:int;
            var s:String;
            mc = MovieClip(e.currentTarget);
            now = new Date().getTime();
            n = Math.max(((mc.boostTS + (mc.iBoostG * 1000)) - now), 0);
            m = 0;
            s = "All Gold gains are doubled.\n";
            if (n < 120000)
            {
                m = int(Math.floor((n / 60000)));
                s = (s + String((m + " minute(s), ")));
                m = int(Math.round(((n % 60000) / 1000)));
                s = (s + String((m + " second(s) remaining.")));
            }
            else
            {
                m = int(Math.round((n / 60000)));
                s = (s + String((m + " minutes remaining.")));
            };
            ui.ToolTip.openWith({"str": s});
        }

        public function oniconBoostRepOver(e:MouseEvent):void
        {
            var mc:MovieClip;
            var now:Number;
            var n:Number;
            var m:int;
            var s:String;
            mc = MovieClip(e.currentTarget);
            now = new Date().getTime();
            n = Math.max(((mc.boostTS + (mc.iBoostRep * 1000)) - now), 0);
            m = 0;
            s = "All Reputation gains are doubled.\n";
            if (n < 120000)
            {
                m = int(Math.floor((n / 60000)));
                s = (s + String((m + " minute(s), ")));
                m = int(Math.round(((n % 60000) / 1000)));
                s = (s + String((m + " second(s) remaining.")));
            }
            else
            {
                m = int(Math.round((n / 60000)));
                s = (s + String((m + " minutes remaining.")));
            };
            ui.ToolTip.openWith({"str": s});
        }

        public function oniconBoostCPOver(e:MouseEvent):void
        {
            var mc:MovieClip;
            var now:Number;
            var n:Number;
            var m:int;
            var s:String;
            mc = MovieClip(e.currentTarget);
            now = new Date().getTime();
            n = Math.max(((mc.boostTS + (mc.iBoostCP * 1000)) - now), 0);
            m = 0;
            s = "All ClassPoint gains are doubled.\n";
            if (n < 120000)
            {
                m = int(Math.floor((n / 60000)));
                s = (s + String((m + " minute(s), ")));
                m = int(Math.round(((n % 60000) / 1000)));
                s = (s + String((m + " second(s) remaining.")));
            }
            else
            {
                m = int(Math.round((n / 60000)));
                s = (s + String((m + " minutes remaining.")));
            };
            ui.ToolTip.openWith({"str": s});
        }

        public function openExpBoostStore(params:Object):void
        {
            if (params.accept)
            {
                world.sendLoadShopRequest(184);
            };
        }

        public function oniconBoostOut(e:MouseEvent):void
        {
            ui.ToolTip.close();
        }

        public function updateXPBar():void
        {
            var overflow:Number;
            var avo:*;
            var xc:*;
            var xm:*;
            var xp:*;
            overflow = (world.myAvatar.objData.intExp / world.myAvatar.objData.intExpToLevel);
            ui.mcInterface.mcXPBar.mcXP.scaleX = ((overflow > 1) ? 1 : overflow);
            avo = world.myAvatar.objData;
            xc = avo.intExp;
            xm = avo.intExpToLevel;
            xp = int(((xc / xm) * 100));
            if (xp >= 100)
            {
                xp = 100;
            };
            ui.mcInterface.mcXPBar.strXP.text = (((((((("Level " + world.myAvatar.objData.intLevel) + " : ") + xc) + " / ") + xm) + "  (") + xp) + "%)");
        }

        public function xpBarMouseOver(e:MouseEvent):*
        {
            MovieClip(e.currentTarget).strXP.visible = true;
        }

        public function xpBarMouseOut(e:MouseEvent):*
        {
            MovieClip(e.currentTarget).strXP.visible = false;
        }

        public function updateRepBar():void
        {
            var xc:*;
            var xm:*;
            var xp:*;
            xc = world.myAvatar.objData.iCurCP;
            xm = world.myAvatar.objData.iCPToRank;
            if (xm <= 0)
            {
                ui.mcInterface.mcRepBar.mcRep.scaleX = 0.1;
                ui.mcInterface.mcRepBar.mcRep.visible = false;
                ui.mcInterface.mcRepBar.strRep.text = ((world.myAvatar.objData.strClassName + ", Rank ") + world.myAvatar.objData.iRank);
            }
            else
            {
                xp = int(((xc / xm) * 100));
                if (xp >= 100)
                {
                    xp = 100;
                };
                ui.mcInterface.mcRepBar.mcRep.scaleX = (xc / xm);
                ui.mcInterface.mcRepBar.mcRep.visible = true;
                ui.mcInterface.mcRepBar.strRep.text = (((((((((world.myAvatar.objData.strClassName + ", Rank ") + world.myAvatar.objData.iRank) + " : ") + xc) + "/") + xm) + "  (") + xp) + "%)");
            };
        }

        public function onRepBarMouseOver(e:MouseEvent):*
        {
            MovieClip(e.currentTarget).strRep.visible = true;
        }

        public function onRepBarMouseOut(e:MouseEvent):*
        {
            MovieClip(e.currentTarget).strRep.visible = false;
        }

        public function disabledDelay(e:TimerEvent):void
        {
            trace("50MS SKILL DELAY");
        }

        public function actIconClick(e:MouseEvent):*
        {
            var actObj:*;
            actObj = MovieClip(e.currentTarget).actObj;
            if (((!(actObj.auto == null)) && (actObj.auto == true)))
            {
                world.approachTarget();
            }
            else
            {
                world.testAction(actObj);
            };
        }

        public function determineIndex(supposedPos:Number):Number
        {
            var relPos:Number;
            relPos = 10;
            if (supposedPos <= 3)
            {
                relPos = supposedPos;
            }
            else
            {
                if (supposedPos == 4)
                {
                    relPos = 5;
                }
                else
                {
                    if (supposedPos <= 6)
                    {
                        relPos = 4;
                    };
                };
            };
            return (relPos);
        }

        public function actIconOver(e:MouseEvent):*
        {
            var mc:MovieClip;
            var actObj:*;
            var s:String;
            mc = MovieClip(e.currentTarget);
            if (((uoPref.bTT) || (!(world.myAvatar.dataLeaf.intState == 2))))
            {
                if (mc.item == null)
                {
                    actObj = mc.actObj;
                    if (actObj != null)
                    {
                        actObj.desc = actObj.desc.replace(regExLineSpace, "\n");
                        s = (("<b>" + actObj.nam) + "</b>\n");
                        if (!actObj.isOK)
                        {
                            s = (s + (("<font color='#FF0000'>Unlocks at Rank " + String(determineIndex(mc.actionIndex))) + "!</font>\n"));
                        };
                        if (actObj.typ != "passive")
                        {
                            if (actObj.mp > 0)
                            {
                                s = (s + (("<font color='#0033AA'>" + actObj.mp) + "</font> mana, "));
                            };
                            s = (s + ((("<font color='#AA3300'>" + (actObj.cd / 1000)) + "</font> sec cooldown") + "\n"));
                        };
                        switch (actObj.typ)
                        {
                            case "p":
                            case "ph":
                            case "aa":
                                s = (s + "Physical");
                                break;
                            case "m":
                                s = (s + "Magical");
                                break;
                            case "ma":
                                s = (s + "True Damage");
                                break;
                            case "pm":
                            case "mp":
                                s = (s + "Hybrid");
                                break;
                            case "passive":
                                s = (s + "<font color='#0033AA'>Passive Ability</font>");
                                break;
                        };
                        s = (s + "\n");
                        if (actObj.typ != "passive")
                        {
                            if (actObj.range <= 301)
                            {
                                s = (s + "A <font color='#AA3300'>short range</font> ");
                            }
                            else
                            {
                                if (actObj.range >= 3000)
                                {
                                    s = (s + "An <font color='#0033AA'>infinite range</font> ");
                                }
                                else
                                {
                                    if (actObj.range >= 808)
                                    {
                                        s = (s + "A <font color='#0033AA'>long range</font> ");
                                    }
                                    else
                                    {
                                        s = (s + "A <font color='#AA3300'>medium range</font> ");
                                    };
                                };
                            };
                            if (!actObj.damage)
                            {
                                s = (s + "status skill that applies to ");
                            }
                            else
                            {
                                s = (s + ((((actObj.damage < 0) ? "skill" : "attack") + " that ") + ((actObj.damage < 0) ? "heals " : "deals damage to ")));
                            };
                            if (actObj.tgt == "f")
                            {
                                s = (s + ("<font color='#0033AA'>" + ((actObj.tgtMax) || (1))));
                                s = (s + ((actObj.tgtMax > 1) ? " friendly targets.</font>" : " target.</font>"));
                            }
                            else
                            {
                                if (actObj.tgt == "s")
                                {
                                    s = (s + "<font color='#0033AA'>yourself.</font>");
                                }
                                else
                                {
                                    s = (s + ("<font color='#AA3300'>" + ((actObj.tgtMax) || (1))));
                                    s = (s + ((actObj.tgtMax > 1) ? " hostile targets.</font>" : " target.</font>"));
                                };
                            };
                            s = (s + "\n\n");
                        };
                        if (actObj.sArg2 != "")
                        {
                            s = (s + actObj.sArg2);
                        }
                        else
                        {
                            s = (s + actObj.desc);
                        };
                        ui.ToolTip.openWith({
                                    "str": s,
                                    "lowerright": true
                                });
                    };
                }
                else
                {
                    ui.ToolTip.openWith({
                                "str": ((mc.item.sName + "\n") + mc.item.sDesc),
                                "lowerright": true
                            });
                };
            };
        }

        public function actIconOut(e:MouseEvent):*
        {
            var tt:*;
            tt = MovieClip(stage.getChildAt(0)).ui.ToolTip;
            tt.close();
        }

        public function portraitClick(e:MouseEvent):*
        {
            var mc:*;
            var params:*;
            mc = MovieClip(e.currentTarget);
            if (mc.pAV.npcType == "player")
            {
                params = {};
                params.ID = mc.pAV.objData.CharID;
                params.strUsername = mc.pAV.objData.strUsername;
                if (mc.pAV != world.myAvatar)
                {
                    ui.cMenu.fOpenWith("user", params);
                }
                else
                {
                    ui.cMenu.fOpenWith("self", params);
                };
            }
            else
            {
                if (mc.pAV.npcType == "monster")
                {
                    params = {};
                    params.ID = mc.pAV.objData.MonMapID;
                    params.strUsername = mc.pAV.objData.strMonName;
                    params.target = world.getMonster(params.ID).pMC;
                    ui.cMenu.fOpenWith("mons", params);
                };
            };
        }

        private function onTargetPortraitCloseClick(evt:MouseEvent):void
        {
            world.cancelTarget();
        }

        private function onBtnMonsterClick(evt:MouseEvent):void
        {
            world.toggleMonsters();
        }

        public function showMap():void
        {
            ui.mcInterface.mcMenu.mcMenuButtons.visible = true;
            ui.mcPopup.fOpen("Map");
        }

        public function logout():void
        {
            if (((intChatMode) && (chatF.bTall)))
            {
                ui.mcInterface.nc.ncShortTall.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
            saveChar();
            trace("logout called");
            // sfc.sendXtMessage("zm", "cmd", ["logout"], "str", 1);
            if (world != null)
            {
                world.killTimers();
                world.killListeners();
                try
                {
                    world.removeChild(world.map);
                }
                catch (e)
                {
                };
                this.removeChild(world);
                (world = null);
            };
            SoundMixer.stopAll();
            (firstMenu = true);
            if (sfc.isConnected)
            {
                sfc.disconnect();
            };
            if (this.currentLabel != "Login")
            {
                FacebookConnect.Logout();
                // gotoAndPlay("Login");
                gotoAndPlay(((charCount() > 0) && (litePreference.data.bCharSelect)) ? "Select" : "Login");
            };
            // discord.update("onLogin");
        }

        public function showServerList():void
        {
            if (((intChatMode) && (chatF.bTall)))
            {
                ui.mcInterface.nc.ncShortTall.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            };
            saveChar();
            showServers = true;
            // sfc.sendXtMessage("zm", "cmd", ["logout"], "str", 1);
            if (sfc.isConnected)
            {
                sfc.disconnect();
            };
            if (((((FacebookConnect.isLoggedIn) && ((loginInfo.strPassword == null)))) && (ISWEB)))
            {
                extCall.fbLogin();
            }
            else
            {
                login(loginInfo.strUsername, loginInfo.strPassword);
            };
        }

        public function showUpgradeWindow(tempObjData:Object = null):void
        {
            var mc:MovieClip;
            if (mcUpgradeWindow == null)
            {
                mcUpgradeWindow = new MCUpgradeWindow();
            };
            mc = (mcUpgradeWindow as MovieClip);
            var objData:* = ((tempObjData != null) ? tempObjData : world.myAvatar.objData);
            mc.btnClose.addEventListener(MouseEvent.CLICK, hideUpgradeWindow, false, 0, true);
            mc.btnClose2.addEventListener(MouseEvent.CLICK, hideUpgradeWindow, false, 0, true);
            mc.btnBuy.addEventListener(MouseEvent.CLICK, onUpgradeClick, false, 0, true);
            addChild(mcUpgradeWindow);
            try
            {
                ui.mouseChildren = false;
                world.mouseChildren = false;
            }
            catch (e:Error)
            {
            };
            try
            {
                mcLogin.sl.mouseChildren = false;
            }
            catch (e:Error)
            {
            };
        }

        public function hideUpgradeWindow(e:MouseEvent):void
        {
            removeChild(mcUpgradeWindow);
            try
            {
                ui.mouseChildren = true;
                world.mouseChildren = true;
            }
            catch (e:Error)
            {
            };
            try
            {
                mcLogin.sl.mouseChildren = true;
            }
            catch (e:Error)
            {
            };
        }

        public function onUpgradeClick(evt:Event):void
        {
            var strUpgradeURL:String;
            mixer.playSound("Click");
            if (ISWEB)
            {
                extCall.setUpPayment(sToken);
            }
            else
            {
                strUpgradeURL = ((("https://www.aq.com/order-now/direct/default.asp?cid=" + world.myAvatar.objData.CharID) + "&token=") + loginInfo.strToken);
                navigateToURL(new URLRequest(strUpgradeURL), "_blank");
            };
        }

        public function showACWindow():void
        {
            var mc:MovieClip;
            if (mcACWindow == null)
            {
                mcACWindow = new MCACWindow();
            };
            mc = (mcACWindow as MovieClip);
            mc.btnClose.addEventListener(MouseEvent.CLICK, hideACWindow, false, 0, true);
            mc.btnClose2.addEventListener(MouseEvent.CLICK, hideACWindow, false, 0, true);
            mc.btnBuy.addEventListener(MouseEvent.CLICK, onUpgradeClick, false, 0, true);
            mc.btnUpgrade.addEventListener(MouseEvent.CLICK, onUpgradeClick, false, 0, true);
            addChild(mcACWindow);
            try
            {
                ui.mouseChildren = false;
                world.mouseChildren = false;
            }
            catch (e:Error)
            {
            };
            try
            {
                mcLogin.sl.mouseChildren = false;
            }
            catch (e:Error)
            {
            };
        }

        public function hideACWindow(e:MouseEvent):void
        {
            removeChild(mcACWindow);
            try
            {
                ui.mouseChildren = true;
                world.mouseChildren = true;
            }
            catch (e:Error)
            {
            };
            try
            {
                mcLogin.sl.mouseChildren = true;
            }
            catch (e:Error)
            {
            };
        }

        public function initArrHP():void
        {
            var intLevelCap:int;
            var intHPBase1:int;
            var intHPConst1:int;
            var intScaling1:Number;
            var intHPBase2:int;
            var intHPConst2:int;
            var intScaling2:Number;
            var intHPBase3:int;
            var intHPConst3:int;
            var intScaling3:Number;
            var i:*;
            intLevelCap = 100;
            intHPBase1 = 550;
            intHPConst1 = 275;
            intScaling1 = 0.8;
            intHPBase2 = 720;
            intHPConst2 = 200;
            intScaling2 = 0.92;
            intHPBase3 = 350;
            intHPConst3 = 3650;
            intScaling3 = 1.1;
            i = 0;
            while (i < intLevelCap)
            {
                if (i > 19)
                {
                    arrHP.push(Math.round((intHPBase3 + (Math.pow((i / intLevelCap), intScaling3) * intHPConst3))));
                }
                else
                {
                    if (i > 7)
                    {
                        arrHP.push(Math.round((intHPBase2 + (Math.pow((i / 20), intScaling2) * intHPConst2))));
                    }
                    else
                    {
                        arrHP.push(Math.round((intHPBase1 + (Math.pow((i / 8), intScaling1) * intHPConst1))));
                    };
                };
                i++;
            };
        }

        public function initArrRep():void
        {
            var iCPToRank:int;
            var i:*;
            iCPToRank = 0;
            i = 1;
            while (i < 10)
            {
                iCPToRank = (Math.pow((i + 1), 3) * 100);
                if (i > 1)
                {
                    arrRanks.push((iCPToRank + arrRanks[(i - 1)]));
                }
                else
                {
                    arrRanks.push((iCPToRank + 100));
                };
                i++;
            };
        }

        public function getRankFromPoints(rep:int):int
        {
            var rank:int;
            var i:*;
            rank = 1;
            if (rep < 0)
            {
                rep = 0;
            };
            i = 1;
            while (i < arrRanks.length)
            {
                if (rep < arrRanks[i])
                {
                    return (rank);
                };
                rank++;
                i++;
            };
            return (rank);
        }

        public function attachOnModalStack(strLinkage:String):MovieClip
        {
            var mc:MovieClip;
            var AssetClass:Class;
            var addOK:*;
            var tempClass:*;
            AssetClass = (world.getClass(strLinkage) as Class);
            addOK = true;
            if (ui.ModalStack.numChildren)
            {
                mc = MovieClip(ui.ModalStack.getChildAt(0));
                tempClass = (mc.constructor as Class);
                if (tempClass == AssetClass)
                {
                    addOK = false;
                };
            };
            if (addOK)
            {
                clearModalStack();
                mc = MovieClip(ui.ModalStack.addChild(new (AssetClass)()));
                ui.ModalStack.mouseChildren = true;
            };
            return (mc);
        }

        public function getInstanceFromModalStack(sClassName:String):MovieClip
        {
            var i:int;
            i = 0;
            while (i < ui.ModalStack.numChildren)
            {
                if (getQualifiedClassName((ui.ModalStack.getChildAt(i) == sClassName)))
                {
                    return (ui.ModalStack.getChildAt(i));
                };
                i++;
            };
            return (null);
        }

        public function isDialoqueUp():Boolean
        {
            var i:int;
            var di:*;
            var nm:*;
            i = 0;
            while (i < world.FG.numChildren)
            {
                di = world.FG.getChildAt(i);
                nm = String((di as MovieClip));
                if (nm.indexOf("dlg_") > -1)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function clearModalStack():Boolean
        {
            var i:int;
            if (isGreedyModalInStack())
            {
                return (false);
            };
            i = 0;
            while (((ui.ModalStack.numChildren > 0) && (i < 100)))
            {
                i++;
                ui.ModalStack.removeChildAt(0);
            };
            stage.focus = null;
            return (true);
        }

        public function closeModalByStrBody(s:String):void
        {
            var i:int;
            var child:MovieClip;
            i = 0;
            i = 0;
            while (i < ui.ModalStack.numChildren)
            {
                child = (ui.ModalStack.getChildAt(i) as MovieClip);
                if (((child.cnt.strBody.htmlText.indexOf(s) > -1) && (!(child.currentLabel == "out"))))
                {
                    child.fClose();
                };
                i++;
            };
        }

        public function isGreedyModalInStack():Boolean
        {
            var i:int;
            var child:MovieClip;
            i = 0;
            i = 0;
            while (i < ui.ModalStack.numChildren)
            {
                child = (ui.ModalStack.getChildAt(i) as MovieClip);
                if (((("greedy" in child) && (!(child.greedy == null))) && (child.greedy == true)))
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        public function clearPopups(exemptLabels:Array = null):void
        {
            if (ui.mcPopup.currentLabel == "House")
            {
                ui.mcPopup.mcHouseMenu.hideItemHandle();
            };
            if (((exemptLabels == null) || (exemptLabels.indexOf(ui.mcPopup.currentLabel) < 0)))
            {
                ui.mcPopup.onClose();
            };
            world.removeMovieFront();
            clearModalStack();
        }

        public function clearPopupsQ():void
        {
            if (((!(ui.mcPopup.currentLabel == "House")) && (!(ui.mcPopup.currentLabel == "HouseShop"))))
            {
                ui.mcPopup.onClose();
            };
        }

        public function addUpdate(str:String, isBad:Boolean = false):void
        {
            var mcu:MovieClip;
            var mc:MovieClip;
            var i:int;
            mcu = ui.mcUpdates;
            mc = (mcu.addChildAt(new uProto(), 1) as MovieClip);
            mc.y = 0;
            mc.x = mcu.uproto.x;
            mc.t1.ti.htmlText = str;
            if (isBad)
            {
                mc.t1.ti.textColor = 0xFF0000;
            };
            mc.gotoAndPlay("in");
            i = 2;
            if (mcu.numChildren > 2)
            {
                i = 2;
                while (i < mcu.numChildren)
                {
                    if (i < 4)
                    {
                        mcu.getChildAt(i).y = (mcu.getChildAt(i).y - 18);
                    }
                    else
                    {
                        MovieClip(mcu.getChildAt(i)).stop();
                        mcu.removeChildAt(i);
                        i--;
                    };
                    i++;
                };
            };
        }

        public function clearUpdates():void
        {
            var mcu:MovieClip;
            mcu = ui.mcUpdates;
            while (mcu.numChildren > 1)
            {
                mcu.removeChildAt(1);
            };
        }

        public function showItemDrop(itemObj:*, isConditional:*):void
        {
            var dropItem:*;
            if (((litePreference.data.bCustomDrops) && ((itemObj.bTemp == 0) && (isConditional))))
            {
                cDropsUI.showItem(itemObj);
                return;
            };
            if (((litePreference.data.bCustomDrops) && ((itemObj.bTemp == 0) && (!(isConditional)))))
            {
                dropItem = new DFrameMC(itemObj);
                ui.dropStack.addChild(dropItem);
                dropItem.init();
                dropItem.fY = (dropItem.y = -(dropItem.fHeight + 8));
                dropItem.fX = (dropItem.x = -(dropItem.fWidth / 2));
                cleanDropStack();
                return;
            };
            if ((((litePreference.data.bCustomDrops) && ((!(itemObj.bTemp == 0)) || (!(isConditional)))) && (litePreference.data.dOptions["hideTemp"])))
            {
                return;
            };
            if (((!(itemObj.bTemp == 0)) || (!(isConditional))))
            {
                dropItem = new DFrameMC(itemObj);
            }
            else
            {
                dropItem = new DFrame2MC(itemObj);
            };
            ui.dropStack.addChild(dropItem);
            dropItem.init();
            dropItem.fY = (dropItem.y = -(dropItem.fHeight + 8));
            dropItem.fX = (dropItem.x = -(dropItem.fWidth / 2));
            cleanDropStack();
        }

        public function cleanDropStack():void
        {
            var itemA:MovieClip;
            var itemB:MovieClip;
            var i:*;
            itemA = null;
            itemB = null;
            i = (ui.dropStack.numChildren - 2);
            while (i > -1)
            {
                itemA = (ui.dropStack.getChildAt(i) as MovieClip);
                itemB = (ui.dropStack.getChildAt((i + 1)) as MovieClip);
                itemA.fY = (itemA.y = (itemB.fY - (itemB.fHeight + 8)));
                i--;
            };
        }

        public function dropStackBoost():void
        {
            ui.dropStack.y = 438;
        }

        public function dropStackReset():void
        {
            ui.dropStack.y = 493;
        }

        public function showAchievement(aName:String, aPts:int):void
        {
            var achievement:mcAchievement;
            var mc:MovieClip;
            achievement = new mcAchievement();
            mc = (ui.dropStack.addChild(achievement) as MovieClip);
            mc.cnt.tBody.text = aName;
            mc.cnt.tPts.text = aPts;
            mc.fWidth = 348;
            mc.fHeight = 90;
            mc.fX = (mc.x = -(mc.fWidth / 2));
            mc.fY = (mc.y = -(mc.fHeight + 8));
            cleanDropStack();
        }

        public function showQuestpopup(resObj:Object):void
        {
            var qp:mcQuestpopup;
            var mc:MovieClip;
            var s:String;
            var o:Object;
            var rw:int;
            if (litePreference.data.bDisQPopup)
            {
                return;
            };
            qp = new mcQuestpopup();
            qp.cnt.mcAC.visible = false;
            mc = (ui.dropStack.addChild(qp) as MovieClip);
            mc.cnt.tName.text = resObj.sName;
            mc.cnt.rewards.tRewards.htmlText = "";
            s = "";
            o = resObj.rewardObj;
            trace(("rewardtype: " + resObj.rewardType));
            if (resObj.rewardType == "ac")
            {
                s = (("<font color='#FFFFFF'>" + resObj.intAmount) + "</font>");
                s = (s + "<font color='#FFCC00'> Adventure Coins</font>");
                mc.cnt.mcAC.visible = true;
            }
            else
            {
                if ((("intGold" in o) && (o.intGold > 0)))
                {
                    s = (("<font color='#FFFFFF'>" + o.intGold) + "</font>");
                    s = (s + "<font color='#FFCC00'>g</font>");
                };
                if ((("intExp" in o) && (o.intExp > 0)))
                {
                    if (s.length > 0)
                    {
                        s = (s + "<font color='#FFFFFF'>, </font>");
                    };
                    s = (s + (("<font color='#FFFFFF'>" + o.intExp) + "</font>"));
                    s = (s + "<font color='#FF00FF'>xp</font>");
                };
                if ((("iRep" in o) && (o.iRep > 0)))
                {
                    if (s.length > 0)
                    {
                        s = (s + "<font color='#FFFFFF'>, </font>");
                    };
                    s = (s + (("<font color='#FFFFFF'>" + o.iRep) + "</font>"));
                    s = (s + "<font color='#00CCFF'>rep</font>");
                };
                if ((("guildRep" in o) && (o.guildRep > 0)))
                {
                    if (s.length > 0)
                    {
                        s = (s + "<font color='#FFFFFF'>, </font>");
                    };
                    s = (s + (("<font color='#FFFFFF'>" + o.guildRep) + "</font>"));
                    s = (s + "<font color='#00CCFF'>guild rep</font>");
                };
            };
            mc.cnt.rewards.tRewards.htmlText = s;
            mc.fWidth = 240;
            mc.fHeight = 70;
            rw = (mc.cnt.rewards.tRewards.x + mc.cnt.rewards.tRewards.textWidth);
            mc.cnt.rewards.x = Math.round(((mc.fWidth / 2) - (rw / 2)));
            mc.fX = (mc.x = -(mc.fWidth / 2));
            mc.fY = (mc.y = -(mc.fHeight + 8));
            mixer.playSound("Good");
            cleanDropStack();
        }

        public function toggleCharpanel(typ:String = ""):void
        {
            var mc:MovieClip;
            mc = ui.mcPopup;
            if (!isGreedyModalInStack())
            {
                if (mc.currentLabel != "Charpanel")
                {
                    clearPopups();
                    clearPopupsQ();
                    mc.fData = {"typ": typ};
                    mc.visible = true;
                    mc.gotoAndPlay("Charpanel");
                }
                else
                {
                    mc.mcCharpanel.fClose();
                };
            };
        }

        public function toggleStatspanel(typ:String = ""):void
        {
            if (ui.getChildByName("mcStatsPanel"))
            {
                mcStatsPanel.cleanup();
                mcStatsPanel = null;
                return;
            };
            mcStatsPanel = new statsPanel(this);
            ui.addChild(mcStatsPanel);
            mcStatsPanel.name = "mcStatsPanel";
            mcStatsPanel.x = 474;
            mcStatsPanel.y = 240;
        }

        public function toggleRedeem():void
        {
            var _local2:MovieClip;
            _local2 = ui.mcPopup;
            if (!isGreedyModalInStack())
            {
                if (_local2.currentLabel != "mcRedeem")
                {
                    clearPopups();
                    clearPopupsQ();
                    (_local2.visible = true);
                    _local2.gotoAndPlay("Redeem");
                }
                else
                {
                    _local2.onClose();
                };
            };
        }

        public function toggleDailyLogin():void
        {
            var _local2:MovieClip;
            _local2 = ui.mcPopup;
            if (!isGreedyModalInStack())
            {
                if (_local2.currentLabel != "mcDailyLogin")
                {
                    clearPopups();
                    clearPopupsQ();
                    (_local2.visible = true);
                    _local2.gotoAndPlay("DailyLogin");
                }
                else
                {
                    _local2.onClose();
                };
            };
        }

        public function toggleRebirth():void
        {
            var _local2:MovieClip;
            _local2 = ui.mcPopup;
            if (!isGreedyModalInStack())
            {
                if (_local2.currentLabel != "mcRebirth")
                {
                    clearPopups();
                    clearPopupsQ();
                    (_local2.visible = true);
                    _local2.gotoAndPlay("Rebirth");
                }
                else
                {
                    _local2.onClose();
                };
            };
        }

        public function toggleTitleList():void
        {
            var _local2:MovieClip;
            (_local2 = ui.mcPopup);
            if (!isGreedyModalInStack())
            {
                if (_local2.currentLabel != "TitleBoard")
                {
                    clearPopups();
                    clearPopupsQ();
                    (_local2.visible = true);
                    _local2.gotoAndPlay("TitleBoard");
                }
                else
                {
                    _local2.onClose();
                };
            };
        }

        public function toggleTradePanel(_arg1:String = ""):void
        {
            var _local2:MovieClip;
            _local2 = ui.mcPopup;
            if (!isGreedyModalInStack())
            {
                if (_local2.currentLabel != "TradePanel")
                {
                    clearPopups();
                    clearPopupsQ();
                    (_local2.tradeId = _arg1);
                    (_local2.visible = true);
                    _local2.gotoAndPlay("TradePanel");
                }
                else
                {
                    _local2.onClose();
                };
            };
        }

        public function toggleAuctionPanel(_arg1:String = ""):void
        {
            var _local2:MovieClip;
            _local2 = ui.mcPopup;
            if (!isGreedyModalInStack())
            {
                if (_local2.currentLabel != "AuctionPanel")
                {
                    clearPopups();
                    clearPopupsQ();
                    (_local2.fData = {typ: _arg1});
                    (_local2.visible = true);
                    _local2.gotoAndPlay("AuctionPanel");
                }
                else
                {
                    _local2.onClose();
                };
            };

        }

        public function togglePVPPanel(typ:String = ""):void
        {
            var mc:MovieClip;
            mc = ui.mcPopup;
            if (!isGreedyModalInStack())
            {
                if (mc.currentLabel != "PVPPanel")
                {
                    clearPopups();
                    clearPopupsQ();
                    mc.fData = {"typ": typ};
                    mc.visible = true;
                    mc.gotoAndPlay("PVPPanel");
                }
                else
                {
                    mc.onClose();
                };
            };
        }

        public function showPVPScore():void
        {
            var bar:MovieClip;
            var i:int;
            var o:Object;
            var a:Array;
            var bx:int;
            ui.mcPVPScore.visible = true;
            ui.mcPVPScore.y = 2;
            i = 0;
            a = [ {"sName": "Team A"}, {"sName": "Team B"}];
            bx = 200;
            if (world.PVPFactions.length > 0)
            {
                a = world.PVPFactions;
            };
            i = 0;
            while (i < a.length)
            {
                o = a[i];
                try
                {
                    bar = ui.mcPVPScore.getChildByName(("bar" + i));
                    bar.tTeam.text = o.sName;
                    if ((((bar.tTeam.x + bar.tTeam.width) - bar.tTeam.textWidth) - 6) < bx)
                    {
                        bx = Math.round((((bar.tTeam.x + bar.tTeam.width) - bar.tTeam.textWidth) - 6));
                    };
                }
                catch (e:Error)
                {
                    trace("*** >");
                    trace("*** > PvP Faction data could not be found or set.");
                    trace("*** >");
                };
                i = (i + 1);
            };
            i = 0;
            while (i < a.length)
            {
                o = a[i];
                try
                {
                    bar = ui.mcPVPScore.getChildByName(("bar" + i));
                    bar.cap.x = bx;
                }
                catch (e:Error)
                {
                };
                i = (i + 1);
            };
        }

        public function hidePVPScore():void
        {
            ui.mcPVPScore.visible = false;
            ui.mcPVPScore.y = -300;
        }

        public function showMCPVPQueue():void
        {
            var w:Object;
            w = world.getWarzoneByWarzoneName(world.PVPQueue.warzone);
            ui.mcPVPQueue.t1.text = w.nam;
            ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME, MCPVPQueueEF);
            ui.mcPVPQueue.t2label.visible = false;
            ui.mcPVPQueue.t2.visible = false;
            if (world.PVPQueue.avgWait > -1)
            {
                ui.mcPVPQueue.t2label.visible = true;
                ui.mcPVPQueue.t2.visible = true;
                ui.mcPVPQueue.addEventListener(Event.ENTER_FRAME, MCPVPQueueEF, false, 0, true);
            };
            ui.mcPVPQueue.visible = true;
            ui.mcPVPQueue.y = 84;
        }

        public function hideMCPVPQueue():void
        {
            ui.mcPVPQueue.removeEventListener(Event.ENTER_FRAME, MCPVPQueueEF);
            ui.mcPVPQueue.visible = false;
            ui.mcPVPQueue.y = -300;
        }

        public function onMCPVPQueueClick(e:MouseEvent):void
        {
            var params:*;
            params = {};
            try
            {
                params.strUsername = world.myAvatar.objData.strUsername;
                ui.cMenu.fOpenWith("pvpqueue", params);
            }
            catch (e:Error)
            {
            };
        }

        public function MCPVPQueueEF(e:Event):void
        {
            var now:Number;
            var mins:*;
            now = new Date().getTime();
            mins = Math.ceil(((((world.PVPQueue.avgWait * 1000) - (now - world.PVPQueue.ts)) / 1000) / 60));
            ui.mcPVPQueue.t2.htmlText = (('<font color="#FFFFFF"' + mins) + '</font><font color="#999999"m</font>');
            if (mins <= 1)
            {
                ui.mcPVPQueue.t2.htmlText = ("<" + ui.mcPVPQueue.t2.htmlText);
            };
        }

        public function updatePVPScore(a:Array):void
        {
            var o:Object;
            var mc:MovieClip;
            var i:int;
            var dx:int;
            o = {};
            i = 0;
            while (i < a.length)
            {
                o = a[i];
                mc = (ui.mcPVPScore.getChildByName(("bar" + i)) as MovieClip);
                if (mc != null)
                {
                    mc.ti.text = (o.v + "/1000");
                    dx = int(int(((o.v / 1000) * mc.bar.width)));
                    dx = Math.max(Math.min(dx, mc.bar.width), 0);
                    mc.bar.x = (-(mc.bar.width) + dx);
                };
                i++;
            };
        }

        public function relayPVPEvent(o:Object):void
        {
            if (o.typ == "kill")
            {
                if (o.team == world.myAvatar.dataLeaf.pvpTeam)
                {
                    if (o.val == "Restorer")
                    {
                        addUpdate(getPVPMessage(o.val, true));
                    };
                    if (o.val == "Brawler")
                    {
                        addUpdate(getPVPMessage(o.val, true));
                    };
                    if (o.val == "Captain")
                    {
                        addUpdate(getPVPMessage(o.val, true));
                    };
                    if (o.val == "General")
                    {
                        addUpdate("Victory! The enemy general has been defeated!");
                    };
                    if (o.val == "Knight")
                    {
                        addUpdate("A knight of the enemy has fallen! Victory draws closer!");
                    };
                }
                else
                {
                    if (o.val == "Restorer")
                    {
                        addUpdate(getPVPMessage(o.val, false), true);
                    };
                    if (o.val == "Brawler")
                    {
                        addUpdate(getPVPMessage(o.val, false), true);
                    };
                    if (o.val == "Captain")
                    {
                        addUpdate(getPVPMessage(o.val, false), true);
                    };
                    if (o.val == "General")
                    {
                        addUpdate("Oh no!  Our general has been defeated!", true);
                    };
                    if (o.val == "Knight")
                    {
                        addUpdate("A knight has fallen to the enemy!");
                    };
                };
            };
        }

        private function getPVPMessage(val:String, isMyTeam:Boolean):String
        {
            switch (val)
            {
                case "Restorer":
                    if (isMyTeam)
                    {
                        return ((world.strMapName == "dagepvp") ? "An enemy Blade Master has been defeated! Dage's healing powers are waning!" : "An enemy Restorer has been defeated! The Captain's healing powers are waning!");
                    }
                    else
                    {
                        return ((world.strMapName == "dagepvp") ? "A Blade Master has been defeated!\t Dage's healing powers are waning!" : "A Restorer has been defeated!\t Our Captain's healing powers are waning!");
                    };
                case "Brawler":
                    if (isMyTeam)
                    {
                        return ((world.strMapName == "dagepvp") ? "An enemy Legion Guard has been defeated!  Dage's attacks grow weaker!" : "An enemy Brawler has been defeated!  The Captain's attacks grow weaker!");
                    }
                    else
                    {
                        return ((world.strMapName == "dagepvp") ? "A Legion Guard has been defeated!\tRally to Dage's defense!" : "A Brawler has been defeated!\tRally to the Captain's defense!");
                    };
                case "Captain":
                    if (isMyTeam)
                    {
                        return ((world.strMapName == "dagepvp") ? "Dage has been defeated!" : "The enemy captain has been defeated!");
                    }
                    else
                    {
                        return ((world.strMapName == "dagepvp") ? "Dage has been fallen to the enemy!" : "Our Captain has been fallen to the enemy!");
                    };
            };
            return ("");
        }

        public function mcSetColor(oMC:MovieClip, strLocation:String, strShade:String):*
        {
            var mc:MovieClip;
            var typ:String;
            if (currentLabel == "Select")
            {
                mcCharSelect.mcSetColor(oMC, strLocation, strShade);
                return;
            };
            mc = oMC;
            var go:Boolean;
            typ = "none";
            while ((((!(mc == null)) && (!(mc.parent == null))) && (!(mc.parent == mc.stage))))
            {
                if (("pAV" in mc))
                {
                    if (mc.name.indexOf("previewMC") > -1)
                    {
                        typ = "e";
                    }
                    else
                    {
                        if (mc.name.indexOf("Dummy") > -1)
                        {
                            typ = "d";
                        }
                        else
                        {
                            if (mc.name.indexOf("mcPortraitTarget") > -1)
                            {
                                typ = "c";
                            }
                            else
                            {
                                if (mc.name.indexOf("mcPortrait") > -1)
                                {
                                    typ = "b";
                                }
                                else
                                {
                                    typ = "a";
                                };
                            };
                        };
                    };
                    break;
                };
                mc = MovieClip(mc.parent);
            };
            if (typ != "none")
            {
                mc.pAV.pMC.setColor(oMC, typ, strLocation, strShade);
            };
        }

        public function areaListClick(e:MouseEvent):void
        {
            var mc:*;
            mc = MovieClip(e.currentTarget.parent.parent);
            switch (mc.currentLabel)
            {
                case "init":
                    mc.gotoAndPlay("in");
                    break;
                case "hold":
                    mc.gotoAndPlay("out");
                    break;
            };
        }

        public function updateAreaName():void
        {
            var strAreaText:String;
            strAreaText = (String(world.areaUsers.length) + " player");
            if (world.areaUsers.length > 1)
            {
                strAreaText = (strAreaText + "(s)");
            };
            strAreaText = (strAreaText + " in <font color ='#FFFF00'>");
            if (world.strAreaName.indexOf(":") > -1)
            {
                strAreaText = (strAreaText + (world.strAreaName.split(":")[0] + " (party)"));
            }
            else
            {
                strAreaText = (strAreaText + world.strAreaName);
            };
            strAreaText = (strAreaText + "</font>");
            ui.mcInterface.areaList.title.t1.htmlText = strAreaText;
        }

        public function areaListGet():void
        {
            var ul:Object;
            var userList:Object;
            var i:String;
            var tuoLeaf:*;
            ul = {};
            userList = sfc.getRoom(world.curRoom).getUserList();
            for (i in userList)
            {
                tuoLeaf = world.uoTree[userList[i].getName()];
                if (tuoLeaf != null)
                {
                    ul[i] = {
                            "strUsername": tuoLeaf.strUsername,
                            "intLevel": tuoLeaf.intLevel
                        };
                };
            };
            areaListShow(ul);
        }

        public function areaListNameClick(e:MouseEvent):void
        {
            var ti:*;
            var params:*;
            ti = MovieClip(e.currentTarget);
            params = {};
            params.ID = ti.objData.ID;
            params.strUsername = ti.objData.strUsername;
            if (ti.objData.strUsername == world.myAvatar.objData.strUsername)
            {
                ui.cMenu.fOpenWith("self", params);
            }
            else
            {
                ui.cMenu.fOpenWith("user", params);
            };
        }

        public function areaListShow(ul:Object):void
        {
            var mc:MovieClip;
            var ind:int;
            var i:String;
            var item:*;
            mc = ui.mcInterface.areaList;
            if (mc.currentLabel == "hold")
            {
                while (mc.cnt.numChildren > 0)
                {
                    mc.cnt.removeChildAt(0);
                };
            };
            ind = 0;
            for (i in ul)
            {
                item = mc.cnt.addChild(new aProto());
                item.objData = ul[i];
                item.txtName.text = ul[i].strUsername;
                item.txtLevel.text = ul[i].intLevel;
                item.addEventListener(MouseEvent.CLICK, areaListNameClick, false, 0, true);
                item.buttonMode = true;
                item.y = -(int((ind * 14)));
                ind++;
            };
            mc.cnt.iproto.visible = (mc.currentLabel == "hold");
            mc.visible = true;
        }

        public function showFBShare(o:Object):void
        {
            var fbTab:FacebookTabMC;
            trace(((("showFBShare > " + o.isActive) + ", ") + uoPref.bFBShare));
            var mc:MovieClip = MovieClip(o.parent);
            var FBShareTabClass:Class = (getDefinitionByName("FacebookTabMC") as Class);
            if (((uoPref.bFBShare) && (o.isActive)))
            {
                trace("  trying to show the tab");
                try
                {
                    fbTab = (o.parent.getChildByName("fbTab") as FacebookTabMC);
                }
                catch (error:Error)
                {
                    trace(error);
                };
                if (fbTab == null)
                {
                    fbTab = new (FBShareTabClass)();
                    fbTab.name = "fbTab";
                    fbTab.filters = [new GlowFilter(12892822, 1, 10, 10, 2, 2, false, false)];
                    o.parent.addChild(fbTab);
                    trace(" tab drawn");
                };
                fbTab.init(o);
                fbTab.visible = true;
                if (("position" in o))
                {
                    fbTab.positionBy(o);
                };
            }
            else
            {
                try
                {
                    o.parent.getChildByName("fbTab").visible = false;
                }
                catch (error:Error)
                {
                };
            };
        }

        public function closeFBC():void
        {
            trace("closeFBC()");
            if (fbc != null)
            {
                fbc.fClose();
            };
        }

        public function getAppName():String
        {
            return (Game.FB_APP_NAME);
        }

        public function getAppID():String
        {
            return (Game.FB_APP_ID);
        }

        public function getAppSec():String
        {
            return (Game.FB_APP_SEC);
        }

        public function getAppURL():String
        {
            return (Game.FB_APP_URL);
        }

        public function getUserName():String
        {
            if (((((!(world == null)) && (!(world.myAvatar == null))) && (!(world.myAvatar.objData == null))) && ("strUserName" in world.myAvatar.objData)))
            {
                return (world.myAvatar.objData.strUserName);
            };
            return ("");
        }

        public function toggleFaction():void
        {
            if (ui.mcPopup.currentLabel != "Faction")
            {
                ui.mcPopup.fOpen("Faction");
            }
            else
            {
                if (("cnt" in MovieClip(ui.mcPopup)))
                {
                    MovieClip(MovieClip(ui.mcPopup).cnt).xClick();
                };
            };
        }

        public function hideInterface():void
        {
            ui.visible = false;
        }

        public function showInterface():void
        {
            ui.visible = true;
        }

        public function loadExternalSWF(strFilename:String):void
        {
            if (((strFilename.indexOf("https://") == -1) || (strFilename.indexOf("https://") == -1)))
            {
                if (((strFilename.length > 1) && (strFilename.charAt(0) == "/")))
                {
                    strFilename = strFilename.substr(1, (strFilename.length - 1));
                };
                strFilename = ("maps/" + strFilename);
            };
            if (world.myAvatar.objData.intAccessLevel >= 40)
                chatF.pushMsg("server", "Cutscene: https://www.aq.com/game/gamefiles/" + strFilename, "SERVER", "", 0);
            ldrMC.loadFile(mcExtSWF, strFilename, "Game Files");
            hideInterface();
            world.visible = false;
        }

        public function clearExternamSWF():void
        {
            while (mcExtSWF.numChildren > 0)
            {
                mcExtSWF.removeChildAt(0);
            };
            world.visible = true;
            showInterface();
        }

        public function openCharacterCustomize():void
        {
            ui.mcPopup.fOpen("Customize");
        }

        public function openArmorCustomize():void
        {
            ui.mcPopup.fOpen("ArmorColor");
        }

        public function openGuildCustomize():void
        {
            ui.mcPopup.fOpen("GuildColor");
        }

        public function openUsernameCustomize():void
        {
            ui.mcPopup.fOpen("UsernameColor");
        }

        public function showFactionInterface():void
        {
            ui.mcPopup.fOpen("Faction");
        }

        public function showConfirmtaionBox(sMsg:String, fHandler:Function):void
        {
            var modal:* = undefined;
            var modalO:* = undefined;
            modal = new ModalMC();
            modalO = {};
            modalO.strBody = sMsg;
            modalO.btns = "dual";
            modalO.params = {};
            modalO.callback = function(params:Object):*
            {
                fHandler(params.accept);
            };
            ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function showMessageBox(sMsg:String, fHandler:Function = null):void
        {
            var modal:* = undefined;
            var modalO:* = undefined;
            modal = new ModalMC();
            modalO = {};
            modalO.strBody = sMsg;
            modalO.btns = "mono";
            modalO.params = {};
            modalO.callback = function(params:Object):*
            {
                if (fHandler != null)
                {
                    fHandler();
                };
            };
            ui.ModalStack.addChild(modal);
            modal.init(modalO);
        }

        public function getServerTime():Date
        {
            var date_now:Date;
            var ts:*;
            date_now = new Date();
            ts = (ts_login_server + (date_now.getTime() - ts_login_client));
            return (new Date(ts));
        }

        public function get date_server():Date
        {
            return (getServerTime());
        }

        public function showTracking(qsVal:String):void
        {
            var uid:*;
            try
            {
                uid = ((objLogin.userid != null) ? objLogin.userid : 0);
                // extCall.logQuestProgress(uid, qsVal);
            }
            catch (e)
            {
            };
        }

        public function removeApop():void
        {
            if (apop == null)
            {
                return;
            };
            apop_ = null;
            world.removeMovieFront();
        }

        public function createApop():void
        {
            if (apop_ != null)
            {
                removeApop();
            };
            apop_ = new apopCore((this as MovieClip), apopTree[curID]);
            apop_.x = 270;
            apop_.y = 20;
            world.FG.addChild(apop_);
            world.FG.mouseChildren = true;
        }

        public function rand(min:Number = 0, max:Number = 1):Number
        {
            return (rn.rand(min, max));
        }

        public function get TravelMap():Object
        {
            return (travelMapData);
        }

        public function get apop():apopCore
        {
            return (apop_);
        }

        public function get objWorldMap():*
        {
            return (WorldMapData);
        }

        public function getLogin():Object
        {
            return (objLogin);
        }

        internal function frame1():*
        {
            retroLowercase();
            stop();
        }

        internal function frame12():*
        {
            init();
            showTracking("2");
        }

        internal function frame13():*
        {
            loadTitle();
            if (showServers)
            {
                if ((((FacebookConnect.isLoggedIn) && (loginInfo.strPassword == null)) && (ISWEB)))
                {
                    extCall.fbLogin();
                }
                else
                {
                    login(loginInfo.strUsername, loginInfo.strPassword);
                };
                showServers = false;
            }
            else
            {
                if (csShowServers)
                {
                    mcLogin.gotoAndPlay("Servers");
                    csShowServers = false;
                };
            };
            // discord.update("onLogin");
            stop();
        }

        internal function frame22():*
        {
            trace("at game");
            initInterface();
            initWorld();
            stop();
        }

        internal function frame32():*
        {
            if (params.vars != null)
            {
                loadAccountCreation(("newuser/" + params.vars.sCharCreate));
            }
            else
            {
                loadAccountCreation("newuser/AQW-Landing-MERGETEST.swf");
            };
            stop();
        }

        internal function frame43():*
        {
            trace("at game");
            initInterface();
            initWorld();
            stop();
        }

        internal function frame53():*
        {
            init();
            gotoAndPlay("Login");
            /*if (mcCharSelect)
            {
                trace(("children count: " + this.numChildren));
                mcCharSelect = null;
            };
            loader = new mcLoader();
            loader.x = 400;
            loader.y = 211;
            this.addChild(loader);
            csLoader = new URLLoader();
			csLoader.dataFormat = URLLoaderDataFormat.BINARY;
            csLoader.addEventListener(Event.COMPLETE, onLoadMaster(onCSComplete,assetsContext));
            csLoader.addEventListener(ProgressEvent.PROGRESS, onCSProgress, false, 0, true);
            csLoader.addEventListener(IOErrorEvent.IO_ERROR, onCSError, false, 0, true);
            //csLoader.load(new URLRequest(((getFilePath() + "interface/CharSelect/charselect.swf?v=") + params.vars.sVersion)));
            csLoader.load(new URLRequest(((getFilePath() + "interface/CharSelect/charselect.swf?v=") + Math.random())));
            csbLoaded = 0;
            csbTotal = 0;
            stop();*/
        }

    }
} // package