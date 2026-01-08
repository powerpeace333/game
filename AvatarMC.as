// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//AvatarMC

package 
{
    import flash.display.MovieClip;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.geom.ColorTransform;
    import flash.events.MouseEvent;
    import flash.events.Event;
    import flash.display.DisplayObject;
    import flash.events.IOErrorEvent;
    import fl.motion.Color;
    import flash.system.ApplicationDomain;
    import flash.display.Graphics;

    public class AvatarMC extends MovieClip 
    {

        private const MAX_RATIO:Number = 4.6566128752458E-10;
        public var cShadow:MovieClip;
        public var hpBar:MovieClip;
        public var mcChar:mcSkel;
        public var pname:MovieClip;
        public var ignore:MovieClip;
        public var shadow:MovieClip;
        public var Sounds:MovieClip;
        public var fx:MovieClip;
        public var proxy:MovieClip;
        public var bubble:MovieClip;
        private var xDep:*;
        private var yDep:*;
        private var xTar:*;
        private var yTar:Number;
        private var nDuration:*;
        private var nXStep:*;
        private var nYStep:*;
        private var walkSpeed:Number;
        private var op:Point;
        private var tp:Point;
        private var walkTS:Number;
        private var walkD:Number;
        private var headPoint:Point;
        private var cbx:*;
        private var cby:Number;
        private var bLoadingHelm:Boolean = false;
        public var pAV:Avatar;
        public var projClass:Projectile;
        public var spellDur:int = 0;
        public var bBackHair:Boolean = false;
        public var isLoaded:Boolean = false;
        public var STAGE:MovieClip;
        public var world:MovieClip;
        public var px:*;
        public var py:*;
        public var tx:*;
        public var ty:Number;
        public var kv:Killvis = null;
        public var strGender:String;
        public var previousframe:int = -1;
        public var hitboxR:Rectangle;
        private var rootClass:MovieClip;
        private var randNum:Number;
        private var weaponLoad:Boolean = true;
        private var armorLoad:Boolean = true;
        private var classLoad:Boolean = true;
        private var helmLoad:Boolean = true;
        private var hairLoad:Boolean = true;
        private var capeLoad:Boolean = true;
        private var miscLoad:Boolean = true;
        private var testMC:*;
        private var topIndex:int = 0;
        public var isRasterized:Boolean;
        public var helmBackHair:Boolean = false;

        private var objLinks:Object = {};
        private var heavyAssets:Array = [];
        private var totalTransform:Object = {
            "alphaMultiplier":1,
            "alphaOffset":0,
            "redMultiplier":1,
            "redOffset":0,
            "greenMultiplier":1,
            "greenOffset":0,
            "blueMultiplier":1,
            "blueOffset":0
        };
        private var clampedTransform:ColorTransform = new ColorTransform();
        private var animQueue:Array = [];
        public var spFX:Object = {};
        public var defaultCT:ColorTransform = MovieClip(this).transform.colorTransform;
        public var CT3:ColorTransform = new ColorTransform(1, 1, 1, 1, 0xFF, 0xFF, 0xFF, 0);
        public var CT2:ColorTransform = new ColorTransform(1, 1, 1, 1, 127, 127, 127, 0);
        public var CT1:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
        private const NEGA_MAX_RATIO:Number = -(MAX_RATIO);
        private var r:int = (Math.random() * int.MAX_VALUE);
        private var animEvents:Object = new Object();
        private var mcOrder:Object = new Object();

        public function AvatarMC():void
        {
            addFrameScript(0, frame1, 4, frame5, 7, frame8, 9, frame10, 11, frame12, 12, frame13, 13, frame14, 17, frame18, 19, frame20, 22, frame23);
            Sounds.visible = false;
            ignore.visible = false;
            mcChar.addEventListener(MouseEvent.CLICK, onClickHandler);
            mcChar.buttonMode = true;
            mcChar.pvpFlag.mouseEnabled = false;
            mcChar.pvpFlag.mouseChildren = false;
            pname.mouseChildren = false;
            pname.buttonMode = false;
            mcChar.mouseChildren = true;
            bubble.mouseEnabled = (bubble.mouseChildren = false);
            shadow.addEventListener(MouseEvent.CLICK, onClickHandler);
            this.addEventListener(Event.ENTER_FRAME, checkQueue, false, 0, true);
            bubble.visible = false;
            bubble.t = "";
            pname.ti.text = "";
            pname.title.text = "";
            headPoint = new Point(0, (this.mcChar.head.y - (1.4 * this.mcChar.head.height)));
            hideOptionalParts();
        }

        public function fClose():void
        {
            if (pAV != null)
            {
                pAV.unloadPet();
                if (pAV == world.myAvatar)
                {
                    world.setTarget(null);
                }
                else
                {
                    pAV.target = null;
                };
                pAV.pMC = null;
                pAV = null;
            };
            recursiveStop(this);
            world = MovieClip(stage.getChildAt(0)).world;
            mcChar.removeEventListener(MouseEvent.CLICK, onClickHandler);
            pname.removeEventListener(MouseEvent.CLICK, onClickHandler);
            shadow.removeEventListener(MouseEvent.CLICK, onClickHandler);
            this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
            this.removeEventListener(Event.ENTER_FRAME, checkQueue);
            if (world.CHARS.contains(this))
            {
                world.CHARS.removeChild(this);
            };
            if (world.TRASH.contains(this))
            {
                world.TRASH.removeChild(this);
            };
            try
            {
                if (getChildByName("HealIconMC") != null)
                {
                    MovieClip(getChildByName("HealIconMC")).fClose();
                };
            }
            catch(e:Error)
            {
            };
            while (fx.numChildren > 0)
            {
                fx.removeChildAt(0);
            };
        }

        override public function gotoAndPlay(frame:Object, scene:String=null):void
        {
            handleAnimEvent(String(frame));
            super.gotoAndPlay(frame);
        }

        public function disablePNameMouse():void
        {
            mouseEnabled = false;
            pname.mouseEnabled = false;
            pname.mouseChildren = false;
            pname.removeEventListener(MouseEvent.CLICK, onClickHandler);
        }

        public function hasLabel(l:String):Boolean
        {
            var labels:Array = mcChar.currentLabels;
            var i:int;
            while (i < labels.length)
            {
                if (labels[i].name == l)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        private function recursiveStop(mc:MovieClip):void
        {
            var child:DisplayObject;
            var i:int;
            while (i < mc.numChildren)
            {
                child = mc.getChildAt(i);
                if ((child is MovieClip))
                {
                    MovieClip(child).stop();
                    recursiveStop(MovieClip(child));
                };
                i++;
            };
        }

        public function showHPBar():void
        {
            this.hpBar.y = (this.pname.y - 3);
            this.hpBar.visible = true;
            updateHPBar();
        }

        public function hideHPBar():void
        {
            this.hpBar.visible = false;
        }

        public function updateHPBar():void
        {
            var cLeaf:Object;
            var g:MovieClip = (this.hpBar.g as MovieClip);
            var r:MovieClip = (this.hpBar.r as MovieClip);
            if (this.hpBar.visible)
            {
                cLeaf = this.pAV.dataLeaf;
                if (((!(cLeaf == null)) && (!(cLeaf.intHP == null))))
                {
                    g.visible = true;
                    g.width = Math.round(((cLeaf.intHP / cLeaf.intHPMax) * r.width));
                    if (cLeaf.intHP < 1)
                    {
                        g.visible = false;
                    };
                };
            };
        }

        public function updateName():void
        {
            var uoLeaf:* = world.uoTree[pAV.pnm];
            if (uoLeaf == null)
            {
                uoLeaf = world.uoTree[pAV.pnm.toLowerCase()];
            };
            try
            {
                if (uoLeaf.afk)
                {
                    pname.ti.text = ("<AFK> " + pAV.objData.strUsername);
                }
                else
                {
                    pname.ti.text = pAV.objData.strUsername;
                };
                trace(("guild: " + pAV.objData.guild));
                if (pAV.objData.guild != null)
                {
                    pname.tg.text = (("< " + String(pAV.objData.guild.Name)) + " >");
                };
            }
            catch(e:Error)
            {
                trace(("error on set name: " + e));
            };
            //if ((((pAV == world.myAvatar)) && (!((world == null))))){
             //   world.rootClass.discord.update("onRetrieve");
            //};
        }

        private function hideOptionalParts():void
        {
            var killList:* = ["cape", "backhair", "robe", "backrobe", "pvpFlag"];
            var weaponSlots:* = ["weapon", "weaponOff", "weaponFist", "weaponFistOff", "shield"];
            var i:String = "";
            for (i in killList)
            {
                if (typeof(mcChar[killList[i]]) != undefined)
                {
                    mcChar[killList[i]].visible = false;
                };
            };
            for (i in weaponSlots)
            {
                if (typeof(mcChar[weaponSlots[i]]) != undefined)
                {
                    mcChar[weaponSlots[i]].visible = false;
                };
            };
        }

        private function onClickHandler(e:MouseEvent):void
        {
            var avatars:Object;
            var a:*;
            world = (MovieClip(stage.getChildAt(0)).world as MovieClip);
            var tAvt:Avatar = e.currentTarget.parent.pAV;
            if (e.shiftKey)
            {
                world.onWalkClick();
            }
            else
            {
                if (e.altKey)
                {
                    avatars = stage.getObjectsUnderPoint(new Point(e.stageX, e.stageY));
                    for (a in avatars)
                    {
                        if (((avatars[a].parent) && (avatars[a].parent.name == "mcChar")))
                        {
                            world.setTarget(avatars[a].parent.parent.pAV);
                            break;
                        };
                    };
                }
                else
                {
                    if (!e.ctrlKey)
                    {
                        if (((((!(tAvt == world.myAvatar)) && (world.bPvP)) && (!(tAvt.dataLeaf.pvpTeam == world.myAvatar.dataLeaf.pvpTeam))) && (tAvt == world.myAvatar.target)))
                        {
                            world.approachTarget();
                        }
                        else
                        {
                            if (tAvt != world.myAvatar.target)
                            {
                                world.setTarget(tAvt);
                            };
                        };
                    };
                };
            };
        }

        public function loadClass(strFilename:String, sLink:String):void
        {
            if (pAV.objData.eqp.co == null)
            {
                classLoad = false;
                trace("** PMC loadClass >");
                world.queueLoad({
                    "strFile":((((world.rootClass.getFilePath() + "classes/") + strGender) + "/") + strFilename),
                    "callBackA":world.rootClass.onLoadMaster(onLoadClassComplete, world.loaderC),
                    "callBackB":ioErrorHandler,
                    "avt":pAV,
                    "sES":"ar"
                });
            };
        }

        public function onLoadClassComplete(e:Event):void
        {
            trace(("** PMC onLoadClassComplete >" + pAV.objData.eqp.ar.sLink));
            classLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            trace(("on avatar load, rootClass: " + rootClass));
            if (pAV.objData.eqp.co == null)
            {
                loadArmorPieces(pAV.objData.eqp.ar.sLink);
            };
        }

        public function loadMisc(strFilename:String, sLink:String):void
        {
            trace("** PMC loadMisc >");
            miscLoad = false;
            objLinks.mi = sLink;
            world.queueLoad({
                "strFile":(world.rootClass.getFilePath() + strFilename),
                "callBackA":world.rootClass.onLoadMaster(onLoadMiscComplete, world.loaderC),
                "callBackB":ioErrorHandler,
                "avt":pAV,
                "sES":"ac"
            });
        }

        public function onLoadMiscComplete(e:Event):void
        {
            trace(("** PMC onLoadMiscComplete >" + objLinks.gr));
            miscLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            var AssetClass:Class = (world.getClass(objLinks.mi) as Class);
            if (AssetClass != null)
            {
                this.cShadow.visible = true;
                this.cShadow.removeChildAt(0);
                this.cShadow.addChild(new (AssetClass)());
                this.cShadow.scaleX = mcChar.scaleX;
                this.cShadow.scaleY = mcChar.scaleY;
                this.cShadow.mouseEnabled = (this.cShadow.mouseChildren = false);
                this.shadow.alpha = 0;
            }
            else
            {
                this.cShadow.visible = false;
                this.shadow.alpha = 1;
            };
        }

        public function loadArmor(strFilename:String, sLink:String):void
        {
            trace("** PMC loadArmor >");
            objLinks.co = sLink;
            armorLoad = false;
            world.queueLoad({
                "strFile":((((world.rootClass.getFilePath() + "classes/") + strGender) + "/") + strFilename),
				"callBackA":world.rootClass.onLoadMaster(onLoadArmorComplete, world.loaderC),
                "callBackB":ioErrorHandler,
                "avt":pAV,
                "sES":"ar"
            });
        }

        public function onLoadArmorComplete(e:Event):void
        {
            trace(("** PMC onLoadArmorComplete >" + objLinks.co));
            armorLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            clearAnimEvents();
            loadArmorPieces(objLinks.co);
            if (this.name.indexOf("previewMCB") > -1)
            {
                MovieClip(parent.parent).repositionPreview(MovieClip(mcChar));
            };
        }

        public function ioErrorHandler(event:IOErrorEvent):void
        {
            trace(("ioErrorHandler: " + event));
        }

        public function loadArmorPieces(strSkinLinkage:String):void
        {
            var AssetClass:Class;
            var child:DisplayObject;
            var drk:Color;
            trace(">>>>>>>>>>>> loadArmorPieces");
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Head")) as Class);
                child = mcChar.head.getChildByName("face");
                if (child != null)
                {
                    mcChar.head.removeChild(child);
                };
                testMC = mcChar.head.addChildAt(new (AssetClass)(), 0);
                testMC.name = "face";
            }
            catch(err:Error)
            {
                AssetClass = (world.getClass(("mcHead" + strGender)) as Class);
                child = mcChar.head.getChildByName("face");
                if (child != null)
                {
                    mcChar.head.removeChild(child);
                };
                testMC = mcChar.head.addChildAt(new (AssetClass)(), 0);
                testMC.name = "face";
            };
            if (pAV == world.myAvatar)
            {
                world.rootClass.showPortrait(pAV);
            }
            else
            {
                if (pAV == world.myAvatar.target)
                {
                    world.rootClass.showPortraitTarget(pAV);
                };
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Chest")) as Class);
                mcChar.chest.removeChildAt(0);
                mcChar.chest.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Hip")) as Class);
                mcChar.hip.removeChildAt(0);
                mcChar.hip.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "FootIdle")) as Class);
                mcChar.idlefoot.removeChildAt(0);
                mcChar.idlefoot.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Foot")) as Class);
                mcChar.frontfoot.removeChildAt(0);
                mcChar.frontfoot.addChild(new (AssetClass)());
                mcChar.frontfoot.visible = false;
                mcChar.backfoot.removeChildAt(0);
                mcChar.backfoot.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Shoulder")) as Class);
                mcChar.frontshoulder.removeChildAt(0);
                mcChar.frontshoulder.addChild(new (AssetClass)());
                mcChar.backshoulder.removeChildAt(0);
                mcChar.backshoulder.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Hand")) as Class);
                mcChar.fronthand.removeChildAt(0);
                mcChar.fronthand.addChildAt(new (AssetClass)(), 0);
                mcChar.backhand.removeChildAt(0);
                mcChar.backhand.addChildAt(new (AssetClass)(), 0);
                drk = new Color();
                drk.brightness = -1;
                mcChar.backhand.getChildAt(0).transform.colorTransform = drk;
            }
            catch(e:Error)
            {
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Thigh")) as Class);
                mcChar.frontthigh.removeChildAt(0);
                mcChar.frontthigh.addChild(new (AssetClass)());
                mcChar.backthigh.removeChildAt(0);
                mcChar.backthigh.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
            };
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Shin")) as Class);
                mcChar.frontshin.removeChildAt(0);
                mcChar.frontshin.addChild(new (AssetClass)());
                mcChar.backshin.removeChildAt(0);
                mcChar.backshin.addChild(new (AssetClass)());
            }
            catch(e:Error)
            {
            };
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Robe")) as Class);
            if (AssetClass != null)
            {
                mcChar.robe.removeChildAt(0);
                mcChar.robe.addChild(new (AssetClass)());
                mcChar.robe.visible = true;
            }
            else
            {
                mcChar.robe.visible = false;
            };
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "RobeBack")) as Class);
            if (AssetClass != null)
            {
                mcChar.backrobe.removeChildAt(0);
                mcChar.backrobe.addChild(new (AssetClass)());
                mcChar.backrobe.visible = true;
            }
            else
            {
                mcChar.backrobe.visible = false;
            };
            gotoAndPlay("in1");
            isLoaded = true;
            handleAfterAvatarLoad();
        }

        public function handleAfterAvatarLoad():void
        {
            if (((pAV.isCameraTool) || (pAV.isCharPage)))
            {
                return;
            };
            if (((world.rootClass.litePreference.data.bCachePlayers) && (!(isRasterized))))
            {
                if (!pAV.isMyAvatar)
                {
                    mcChar.gotoAndStop("Idle");
                    world.rootClass.rasterize(mcChar);
                    isRasterized = true;
                };
            };
            if (world.rootClass.litePreference.data.bHideNames)
            {
                hideNameSetup();
            };
            if (((world.rootClass.litePreference.data.bHidePlayers) && (!(pAV.isMyAvatar))))
            {
                mcChar.visible = false;
                pname.visible = world.rootClass.litePreference.data.dOptions["showNames"];
                shadow.visible = world.rootClass.litePreference.data.dOptions["showShadows"];
            };
        }

        public function hideNameSetup():void
        {
            if (world.rootClass.litePreference.data.dOptions["hideSelf"])
            {
                if (pAV.isMyAvatar)
                {
                    pname.visible = false;
                }
                else
                {
                    hideNameCleanup();
                };
                return;
            };
            pname.ti.visible = world.rootClass.litePreference.data.dOptions["hideGuild"];
            pname.tg.visible = false;
            pname.title.visible = world.rootClass.litePreference.data.dOptions["hideGuild"];
            if (!mcChar.hasEventListener(MouseEvent.ROLL_OVER))
            {
                mcChar.addEventListener(MouseEvent.ROLL_OVER, onNameHover, false, 0, true);
                mcChar.addEventListener(MouseEvent.ROLL_OUT, onNameOut, false, 0, true);
            };
        }

        public function hideNameCleanup():void
        {
            if (mcChar.hasEventListener(MouseEvent.ROLL_OVER))
            {
                mcChar.removeEventListener(MouseEvent.ROLL_OVER, onNameHover);
                mcChar.removeEventListener(MouseEvent.ROLL_OUT, onNameOut);
            };
            pname.visible = true;
            pname.ti.visible = true;
            pname.tg.visible = true;
            pname.title.visible = true;
        }

        public function onNameHover(e:MouseEvent):void
        {
            if (world.rootClass.litePreference.data.dOptions["hideGuild"])
            {
                pname.tg.visible = true;
            }
            else
            {
                pname.ti.visible = true;
                pname.tg.visible = true;
                pname.title.visible = true;
            };
        }

        public function onNameOut(e:MouseEvent):void
        {
            if (world.rootClass.litePreference.data.dOptions["hideGuild"])
            {
                pname.tg.visible = false;
            }
            else
            {
                pname.ti.visible = false;
                pname.tg.visible = false;
                pname.title.visible = false;
            };
        }

        public function loadArmorPiecesFromDomain(strSkinLinkage:String, pLoaderD:ApplicationDomain):void
        {
            var AssetClass:Class;
            var child:DisplayObject;
            trace((">>>>>>>>>>>> loadArmorPiecesFromDomain > " + strSkinLinkage));
            try
            {
                AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Head")) as Class);
                child = mcChar.head.getChildByName("face");
                if (child != null)
                {
                    mcChar.head.removeChild(child);
                };
                testMC = mcChar.head.addChildAt(new (AssetClass)(), 0);
                testMC.name = "face";
            }
            catch(err:Error)
            {
                AssetClass = (pLoaderD.getDefinition(("mcHead" + strGender)) as Class);
                child = mcChar.head.getChildByName("face");
                if (child != null)
                {
                    mcChar.head.removeChild(child);
                };
                testMC = mcChar.head.addChildAt(new (AssetClass)(), 0);
                testMC.name = "face";
            };
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Chest")) as Class);
            mcChar.chest.removeChildAt(0);
            mcChar.chest.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Hip")) as Class);
            mcChar.hip.removeChildAt(0);
            mcChar.hip.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "FootIdle")) as Class);
            mcChar.idlefoot.removeChildAt(0);
            mcChar.idlefoot.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Foot")) as Class);
            mcChar.frontfoot.removeChildAt(0);
            mcChar.frontfoot.addChild(new (AssetClass)());
            mcChar.frontfoot.visible = false;
            mcChar.backfoot.removeChildAt(0);
            mcChar.backfoot.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Shoulder")) as Class);
            mcChar.frontshoulder.removeChildAt(0);
            mcChar.frontshoulder.addChild(new (AssetClass)());
            mcChar.backshoulder.removeChildAt(0);
            mcChar.backshoulder.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Hand")) as Class);
            mcChar.fronthand.removeChildAt(0);
            mcChar.fronthand.addChildAt(new (AssetClass)(), 0);
            mcChar.backhand.removeChildAt(0);
            mcChar.backhand.addChildAt(new (AssetClass)(), 0);
            var drk:Color = new Color();
            drk.brightness = -1;
            mcChar.backhand.getChildAt(0).transform.colorTransform = drk;
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Thigh")) as Class);
            mcChar.frontthigh.removeChildAt(0);
            mcChar.frontthigh.addChild(new (AssetClass)());
            mcChar.backthigh.removeChildAt(0);
            mcChar.backthigh.addChild(new (AssetClass)());
            AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Shin")) as Class);
            mcChar.frontshin.removeChildAt(0);
            mcChar.frontshin.addChild(new (AssetClass)());
            mcChar.backshin.removeChildAt(0);
            mcChar.backshin.addChild(new (AssetClass)());
            try
            {
                AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "Robe")) as Class);
                if (AssetClass != null)
                {
                    mcChar.robe.removeChildAt(0);
                    mcChar.robe.addChild(new (AssetClass)());
                    mcChar.robe.visible = true;
                }
                else
                {
                    mcChar.robe.visible = false;
                };
            }
            catch(e:Error)
            {
                mcChar.robe.visible = false;
            };
            try
            {
                AssetClass = (pLoaderD.getDefinition(((strSkinLinkage + strGender) + "RobeBack")) as Class);
                if (AssetClass != null)
                {
                    mcChar.backrobe.removeChildAt(0);
                    mcChar.backrobe.addChild(new (AssetClass)());
                    mcChar.backrobe.visible = true;
                }
                else
                {
                    mcChar.backrobe.visible = false;
                };
            }
            catch(e:Error)
            {
                mcChar.backrobe.visible = false;
            };
            gotoAndPlay("in1");
            isLoaded = true;
            handleAfterAvatarLoad();
        }

        public function loadHair():void
        {
            trace("pMC.loadHair >");
            var strFilename:* = pAV.objData.strHairFilename;
            if (((((strFilename == undefined) || (strFilename == null)) || (strFilename == "")) || (strFilename == "none")))
            {
                mcChar.head.hair.visible = false;
                return;
            };
            hairLoad = false;
            world.queueLoad({
                "strFile":(world.rootClass.getFilePath() + strFilename),
                "callBackA":world.rootClass.onLoadMaster(onHairLoadComplete, world.loaderC),
                "avt":pAV,
                "sES":"hair"
            });
        }

        public function onHairLoadComplete(e:Event):void
        {
            var AssetClass:Class;
            trace("onHairLoadComplete >");
            hairLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            try
            {
                trace(("hair linkage: " + ((pAV.objData.strHairName + pAV.objData.strGender) + "Hair")));
                AssetClass = (world.getClass(((pAV.objData.strHairName + pAV.objData.strGender) + "Hair")) as Class);
                if (AssetClass != null)
                {
                    if (mcChar.head.hair.numChildren > 0)
                    {
                        mcChar.head.hair.removeChildAt(0);
                    };
                    mcChar.head.hair.addChild(new (AssetClass)());
                    mcChar.head.hair.visible = true;
                }
                else
                {
                    mcChar.head.hair.visible = false;
                };
                AssetClass = (world.getClass(((pAV.objData.strHairName + pAV.objData.strGender) + "HairBack")) as Class);
                if (AssetClass != null)
                {
                    if (((!(helmBackHair)) || ((helmBackHair) && (!(pAV.dataLeaf.showHelm)))))
                    {
                        if (mcChar.backhair.numChildren > 0)
                        {
                            mcChar.backhair.removeChildAt(0);
                        };
                        mcChar.backhair.addChild(new (AssetClass)());
                        mcChar.backhair.visible = true;
                    };
                    bBackHair = true;
                }
                else
                {
                    mcChar.backhair.visible = false;
                    bBackHair = false;
                };
                if ((((pAV.isMyAvatar) && (!(MovieClip(parent.parent.parent).ui.mcPortrait.visible))) && (!(bLoadingHelm))))
                {
                    world.rootClass.showPortrait(pAV);
                }
                else
                {
                    if (pAV == world.myAvatar.target)
                    {
                        world.rootClass.showPortraitTarget(pAV);
                    };
                };
                if ((("he" in pAV.objData.eqp) && (!(pAV.objData.eqp.he == null))))
                {
                    if (pAV.dataLeaf.showHelm)
                    {
                        mcChar.head.hair.visible = false;
                        mcChar.backhair.visible = helmBackHair;
                    }
                    else
                    {
                        mcChar.head.hair.visible = true;
                        mcChar.backhair.visible = bBackHair;
                    };
                };
            }
            catch(e:Error)
            {
                trace(("onHairLoad Error >" + pAV.objData.strUsername));
            };
        }

        public function loadWeapon(sFile:*, sLink:*):void
        {
            weaponLoad = false;
            world.queueLoad({
                "strFile":(world.rootClass.getFilePath() + sFile),
                "callBackA":world.rootClass.onLoadMaster(onLoadWeaponComplete, world.loaderC),
                "avt":pAV,
                "sES":"weapon"
            });
        }

        public function onLoadWeaponComplete(e:Event):void
        {
            var wItem:Object;
            var AssetClass:Class;
            trace("onLoadWeaponComplete >");
            weaponLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            wItem = pAV.getItemByEquipSlot("Weapon");
            if (mcChar.weaponFist.numChildren > 0)
            {
                mcChar.weaponFist.removeChildAt(0);
            };
            if (mcChar.weaponFistOff.numChildren > 0)
            {
                mcChar.weaponFistOff.removeChildAt(0);
            };
            if (mcChar.weapon.numChildren > 0)
            {
                mcChar.weapon.removeChildAt(0);
            };
            if (mcChar.fronthand.numChildren > 1)
            {
                mcChar.fronthand.removeChildAt(1);
            };
            if (mcChar.backhand.numChildren > 1)
            {
                mcChar.backhand.removeChildAt(1);
            };
            try
            {
                AssetClass = (world.getClass(pAV.objData.eqp.Weapon.sLink) as Class);
                if (wItem.sType == "Gauntlet")
                {
                    mcChar.fronthand.addChildAt(new (AssetClass)(), 1);
                    mcChar.fronthand.getChildAt(1).scaleX = 0.8;
                    mcChar.fronthand.getChildAt(1).scaleY = 0.8;
                    mcChar.fronthand.getChildAt(1).scaleX = (mcChar.fronthand.getChildAt(1).scaleX * -1);
                    mcChar.backhand.addChildAt(new (AssetClass)(), 1);
                    mcChar.backhand.getChildAt(1).scaleX = 0.8;
                    mcChar.backhand.getChildAt(1).scaleY = 0.8;
                    mcChar.backhand.getChildAt(1).scaleX = (mcChar.backhand.getChildAt(1).scaleX * -1);
                    mcChar.weapon.mcWeapon = new MovieClip();
                }
                else
                {
                    mcChar.weapon.mcWeapon = new (AssetClass)();
                    mcChar.weapon.addChild(mcChar.weapon.mcWeapon);
                };
            }
            catch(err:Error)
            {
                trace(" Weapon added to display list manually");
                if (wItem.sType != "Gauntlet")
                {
                    mcChar.weapon.mcWeapon = MovieClip(e.target.content);
                    mcChar.weapon.addChild(mcChar.weapon.mcWeapon);
                };
            };
            mcChar.weapon.visible = false;
            mcChar.weaponOff.visible = false;
            mcChar.weaponFist.visible = false;
            mcChar.weaponFistOff.visible = false;
            if (wItem.sType != "Gauntlet")
            {
                mcChar.weapon.visible = true;
            };
            if (wItem.sType == "Dagger")
            {
                loadWeaponOff(pAV.objData.eqp.Weapon.sFile, pAV.objData.eqp.Weapon.sLink);
            };
            if (world.rootClass.litePreference.data.bDisWepAnim)
            {
                if ((((!(pAV.isMyAvatar)) && (world.rootClass.litePreference.data.dOptions["wepSelf"])) || (!(world.rootClass.litePreference.data.dOptions["wepSelf"]))))
                {
                    world.rootClass.movieClipStopAll(mcChar.weapon);
                };
            };
        }

        public function loadWeaponOff(sFile:*, sLink:*):void
        {
            weaponLoad = false;
            world.queueLoad({
                "strFile":(world.rootClass.getFilePath() + sFile),
                "callBackA":world.rootClass.onLoadMaster(onLoadWeaponOffComplete, world.loaderC),
                "avt":pAV,
                "sES":"weapon"
            });
        }

        public function onLoadWeaponOffComplete(e:Event):void
        {
            var AssetClass:Class;
            trace("onLoadWeaponOffComplete >");
            weaponLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            var wItem:Object = pAV.getItemByEquipSlot("Weapon");
            if (mcChar.weaponOff.numChildren > 0)
            {
                mcChar.weaponOff.removeChildAt(0);
            };
            try
            {
                AssetClass = (world.getClass(pAV.objData.eqp.Weapon.sLink) as Class);
                mcChar.weaponOff.addChild(new (AssetClass)());
            }
            catch(err:Error)
            {
                trace(" weaponOff added to display list manually");
                mcChar.weaponOff.addChild(e.target.content);
            };
            mcChar.weaponOff.visible = true;
            if (world.rootClass.litePreference.data.bDisWepAnim)
            {
                if ((((!(pAV.isMyAvatar)) && (world.rootClass.litePreference.data.dOptions["wepSelf"])) || (!(world.rootClass.litePreference.data.dOptions["wepSelf"]))))
                {
                    world.rootClass.movieClipStopAll(mcChar.weaponOff);
                };
            };
        }

        public function loadCape(sFile:*, sLink:*):void
        {
            capeLoad = false;
            world.queueLoad({
                "strFile":(world.rootClass.getFilePath() + sFile),
                "callBackA":world.rootClass.onLoadMaster(onLoadCapeComplete, world.loaderC),
                "avt":pAV,
                "sES":"cape"
            });
        }

        public function onLoadCapeComplete(e:Event):void
        {
            var AssetClass:Class;
            capeLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            try
            {
                AssetClass = (world.getClass(pAV.objData.eqp.ba.sLink) as Class);
                mcChar.cape.removeChildAt(0);
                mcChar.cape.cape = new (AssetClass)();
                mcChar.cape.addChild(mcChar.cape.cape);
                setCloakVisibility(pAV.dataLeaf.showCloak);
            }
            catch(e)
            {
            };
        }

        public function loadHelm(sFile:*, sLink:*):void
        {
            trace("pMC.loadHelm >");
            helmLoad = false;
            world.queueLoad({
                "strFile":(world.rootClass.getFilePath() + sFile),
                "callBackA":world.rootClass.onLoadMaster(onLoadHelmComplete, world.loaderC),
                "avt":pAV,
                "sES":"helm"
            });
            bLoadingHelm = true;
        }

        public function onLoadHelmComplete(e:Event):void
        {
            trace("pMC.onLoadHelmComplete >");
            helmLoad = true;
            if (((pAV.isMyAvatar) && (pAV.FirstLoad)))
            {
                pAV.updateLoaded();
                if (pAV.LoadCount <= 0)
                {
                    pAV.firstDone();
                    world.rootClass.showTracking("7");
                    world.rootClass.chatF.pushMsg("server", "Character load complete.", "SERVER", "", 0);
                };
            };
            var AssetClass:Class = (world.getClass(pAV.objData.eqp.he.sLink) as Class);
            var AssetClass2:Class = (world.getClass((pAV.objData.eqp.he.sLink + "_backhair")) as Class);
            if (AssetClass != null)
            {
                if (mcChar.head.helm.numChildren > 0)
                {
                    mcChar.head.helm.removeChildAt(0);
                };
                mcChar.head.helm.visible = pAV.dataLeaf.showHelm;
                mcChar.head.hair.visible = (!(mcChar.head.helm.visible));
                mcChar.backhair.visible = ((mcChar.head.hair.visible) && (bBackHair));
                if (AssetClass2 != null)
                {
                    if (pAV.dataLeaf.showHelm)
                    {
                        if (mcChar.backhair.numChildren > 0)
                        {
                            mcChar.backhair.removeChildAt(0);
                        };
                        mcChar.backhair.visible = true;
                        mcChar.backhair.addChild(new (AssetClass2)());
                    };
                    helmBackHair = true;
                }
                else
                {
                    helmBackHair = false;
                };
                mcChar.head.helm.addChild(new (AssetClass)());
                if (pAV == world.myAvatar)
                {
                    world.rootClass.showPortrait(pAV);
                };
                if (pAV == world.myAvatar.target)
                {
                    world.rootClass.showPortraitTarget(pAV);
                };
            };
            bLoadingHelm = false;
        }

        public function setHelmVisibility(b:Boolean):void
        {
            trace(("setHelmVisibility > " + b));
            if (((!(pAV.objData.eqp.he == null)) && (!(pAV.objData.eqp.he.sLink == null))))
            {
                if (b)
                {
                    if (((helmBackHair) && (bBackHair)))
                    {
                        pAV.loadMovieAtES("he", pAV.objData.eqp["he"].sFile, pAV.objData.eqp["he"].sLink);
                        return;
                    };
                    mcChar.head.helm.visible = true;
                    mcChar.head.hair.visible = false;
                    mcChar.backhair.visible = helmBackHair;
                }
                else
                {
                    if (((helmBackHair) && (bBackHair)))
                    {
                        loadHair();
                        return;
                    };
                    mcChar.head.helm.visible = false;
                    mcChar.head.hair.visible = true;
                    mcChar.backhair.visible = bBackHair;
                };
                if (pAV == world.myAvatar)
                {
                    world.rootClass.showPortrait(pAV);
                };
                if (pAV == world.myAvatar.target)
                {
                    world.rootClass.showPortraitTarget(pAV);
                };
            };
        }

        public function setCloakVisibility(b:Boolean):void
        {
            trace(("setCloakVisibility > " + b));
            if (((!(pAV.objData.eqp.ba == null)) && (!(pAV.objData.eqp.ba.sLink == null))))
            {
                if (pAV.isMyAvatar)
                {
                    mcChar.cape.visible = b;
                }
                else
                {
                    if (pAV.isCharPage)
                    {
                        mcChar.cape.visible = b;
                    }
                    else
                    {
                        mcChar.cape.visible = ((b) && (!(world.hideAllCapes)));
                    };
                };
            };
        }

        public function setColor(mc:MovieClip, typ:String, strLocation:String, strShade:String):void
        {
            var intColor:Number = Number(pAV.objData[("intColor" + strLocation)]);
            mc.isColored = true;
            mc.intColor = intColor;
            mc.strLocation = strLocation;
            mc.strShade = strShade;
            changeColor(mc, intColor, strShade);
        }

        public function changeColor(mc:MovieClip, intColor:Number, strShade:String, op:String=""):void
        {
            var newCT:ColorTransform = new ColorTransform();
            if (op == "")
            {
                newCT.color = intColor;
            };
            switch (strShade.toUpperCase())
            {
                case "LIGHT":
                    newCT.redOffset = (newCT.redOffset + 100);
                    newCT.greenOffset = (newCT.greenOffset + 100);
                    newCT.blueOffset = (newCT.blueOffset + 100);
                    break;
                case "DARK":
                    newCT.redOffset = (newCT.redOffset - ((mc.strLocation == "Skin") ? 25 : 50));
                    newCT.greenOffset = (newCT.greenOffset - 50);
                    newCT.blueOffset = (newCT.blueOffset - 50);
                    break;
                case "DARKER":
                    newCT.redOffset = (newCT.redOffset - 125);
                    newCT.greenOffset = (newCT.greenOffset - 125);
                    newCT.blueOffset = (newCT.blueOffset - 125);
                    break;
            };
            if (op == "-")
            {
                newCT.redOffset = (newCT.redOffset * -1);
                newCT.greenOffset = (newCT.greenOffset * -1);
                newCT.blueOffset = (newCT.blueOffset * -1);
            };
            if (((op == "") || (!(mc.transform.colorTransform.redOffset == newCT.redOffset))))
            {
                mc.transform.colorTransform = newCT;
            };
        }

        public function modulateColor(ct:ColorTransform, op:String):void
        {
            var rootClass:MovieClip = (this.stage.getChildAt(0) as MovieClip);
            if (op == "+")
            {
                totalTransform.alphaMultiplier = (totalTransform.alphaMultiplier + ct.alphaMultiplier);
                totalTransform.alphaOffset = (totalTransform.alphaOffset + ct.alphaOffset);
                totalTransform.redMultiplier = (totalTransform.redMultiplier + ct.redMultiplier);
                totalTransform.redOffset = (totalTransform.redOffset + ct.redOffset);
                totalTransform.greenMultiplier = (totalTransform.greenMultiplier + ct.greenMultiplier);
                totalTransform.greenOffset = (totalTransform.greenOffset + ct.greenOffset);
                totalTransform.blueMultiplier = (totalTransform.blueMultiplier + ct.blueMultiplier);
                totalTransform.blueOffset = (totalTransform.blueOffset + ct.blueOffset);
            }
            else
            {
                if (op == "-")
                {
                    totalTransform.alphaMultiplier = (totalTransform.alphaMultiplier - ct.alphaMultiplier);
                    totalTransform.alphaOffset = (totalTransform.alphaOffset - ct.alphaOffset);
                    totalTransform.redMultiplier = (totalTransform.redMultiplier - ct.redMultiplier);
                    totalTransform.redOffset = (totalTransform.redOffset - ct.redOffset);
                    totalTransform.greenMultiplier = (totalTransform.greenMultiplier - ct.greenMultiplier);
                    totalTransform.greenOffset = (totalTransform.greenOffset - ct.greenOffset);
                    totalTransform.blueMultiplier = (totalTransform.blueMultiplier - ct.blueMultiplier);
                    totalTransform.blueOffset = (totalTransform.blueOffset - ct.blueOffset);
                };
            };
            clampedTransform.alphaMultiplier = rootClass.clamp(totalTransform.alphaMultiplier, -1, 1);
            clampedTransform.alphaOffset = rootClass.clamp(totalTransform.alphaOffset, -255, 0xFF);
            clampedTransform.redMultiplier = rootClass.clamp(totalTransform.redMultiplier, -1, 1);
            clampedTransform.redOffset = rootClass.clamp(totalTransform.redOffset, -255, 0xFF);
            clampedTransform.greenMultiplier = rootClass.clamp(totalTransform.greenMultiplier, -1, 1);
            clampedTransform.greenOffset = rootClass.clamp(totalTransform.greenOffset, -255, 0xFF);
            clampedTransform.blueMultiplier = rootClass.clamp(totalTransform.blueMultiplier, -1, 1);
            clampedTransform.blueOffset = rootClass.clamp(totalTransform.blueOffset, -255, 0xFF);
            this.transform.colorTransform = clampedTransform;
        }

        public function updateColor(objData:Object=null):*
        {
            var cData:* = pAV.objData;
            if (objData != null)
            {
                cData = objData;
            };
            var ui:* = MovieClip(stage.getChildAt(0)).ui;
            scanColor(this, cData);
            if ((((!(this.pAV == null)) && (!(ui.mcPortrait.pAV == null))) && (ui.mcPortrait.pAV == this.pAV)))
            {
                scanColor(ui.mcPortrait.mcHead, cData);
            };
            if ((((!(this.pAV == null)) && (!(ui.mcPortraitTarget.pAV == null))) && (ui.mcPortraitTarget.pAV == this.pAV)))
            {
                scanColor(ui.mcPortraitTarget.mcHead, cData);
            };
        }

        private function scanColor(mc:MovieClip, cData:*):void
        {
            var child:DisplayObject;
            if (("isColored" in mc))
            {
                changeColor(mc, Number(cData[("intColor" + mc.strLocation)]), mc.strShade);
            };
            var i:int;
            while (i < mc.numChildren)
            {
                child = mc.getChildAt(i);
                if ((child is MovieClip))
                {
                    scanColor(MovieClip(child), cData);
                };
                i++;
            };
        }

        public function queueAnim(s:String):void
        {
            var petSplit:Array;
            var p:String;
            var pItem:Object;
            var sType:* = undefined;
            var l:String;
            var world:MovieClip = (MovieClip(stage.getChildAt(0)).world as MovieClip);
            if ((((pAV.isMyAvatar) && (world.rootClass.litePreference.data.bDisSelfMAnim)) && (!(s == "Walk"))))
            {
                return;
            };
            if ((((!(pAV.isMyAvatar)) && (!(world.showAnimations))) && (!(s == "Walk"))))
            {
                return;
            };
            if (s.indexOf("Pet") > -1)
            {
                pItem = pAV.getItemByEquipSlot("pe");
                if (s.indexOf(":") > -1)
                {
                    petSplit = s.split(":");
                    s = petSplit[0];
                    try
                    {
                        if (pItem != null)
                        {
                            if (petSplit[1] == "PetAttack")
                            {
                                p = ["Attack1", "Attack2"][Math.round((Math.random() * 1))];
                                if (pAV.petMC.mcChar.currentLabel == "Idle")
                                {
                                    pAV.petMC.mcChar.gotoAndPlay(p);
                                };
                            }
                            else
                            {
                                p = petSplit[1].slice(3);
                                if (pAV.petMC.mcChar.currentLabel == "Idle")
                                {
                                    pAV.petMC.mcChar.gotoAndPlay(p);
                                };
                            };
                        };
                    }
                    catch(e)
                    {
                    };
                }
                else
                {
                    if (pItem != null)
                    {
                        try
                        {
                            p = ["Attack1", "Attack2"][Math.round((Math.random() * 1))];
                            if (pAV.petMC.mcChar.currentLabel == "Idle")
                            {
                                pAV.petMC.mcChar.gotoAndPlay(p);
                            };
                            return;
                        }
                        catch(e)
                        {
                            s = ["Attack1", "Attack2"][Math.round((Math.random() * 1))];
                        };
                    }
                    else
                    {
                        s = ((s.indexOf("1") > -1) ? "Attack1" : "Attack2");
                    };
                };
            };
            var wItem:Object = pAV.getItemByEquipSlot("Weapon");
            if (((s == "Attack1") || (s == "Attack2")))
            {
                if (((!(wItem == null)) && (!(wItem.sType == null))))
                {
                    sType = wItem.sType;
                    if (((wItem.ItemID == 156) || (wItem.ItemID == 12583)))
                    {
                        sType = "Unarmed";
                    };
                    switch (sType)
                    {
                        case "Unarmed":
                            s = ["UnarmedAttack1", "UnarmedAttack2", "KickAttack", "FlipAttack"][Math.round((Math.random() * 3))];
                            break;
                        case "Polearm":
                            s = ["PolearmAttack1", "PolearmAttack2"][Math.round((Math.random() * 1))];
                            break;
                        case "Dagger":
                            s = ["DuelWield/DaggerAttack1", "DuelWield/DaggerAttack2"][Math.round((Math.random() * 1))];
                            break;
                        case "Bow":
                            s = "RangedAttack1";
                            break;
                        case "Whip":
                            s = "WhipAttack";
                            break;
                        case "HandGun":
                            s = ["GunAttack", "GunAttack2"][Math.round((Math.random() * 1))];
                            break;
                        case "Rifle":
                            s = "RifleAttack2";
                            break;
                        case "Gauntlet":
                            s = ["UnarmedAttack1", "UnarmedAttack2", "FistweaponAttack1", "FistweaponAttack2"][Math.round((Math.random() * 3))];
                            break;
                    };
                };
            };
            if (((hasLabel(s)) && (pAV.dataLeaf.intState > 0)))
            {
                pAV.handleItemAnimation();
                l = mcChar.currentLabel;
                if (((world.combatAnims.indexOf(s) > -1) && (world.combatAnims.indexOf(l) > -1)))
                {
                    animQueue.push(s);
                }
                else
                {
                    mcChar.gotoAndPlay(s);
                    if (s.indexOf("Attack") >= 0)
                    {
                        if (((wItem.sType == "Gauntlet") && ((MovieClip(mcChar.fronthand.getChildAt(1)).bAttack == true) || (MovieClip(mcChar.backhand.getChildAt(1)).bAttack == true))))
                        {
                            MovieClip(mcChar.fronthand.getChildAt(1)).gotoAndPlay("Attack");
                            MovieClip(mcChar.backhand.getChildAt(1)).gotoAndPlay("Attack");
                        }
                        else
                        {
                            if (mcChar.weapon.mcWeapon.bAttack == true)
                            {
                                mcChar.weapon.mcWeapon.gotoAndPlay("Attack");
                            };
                        };
                    };
                };
            };
        }

        private function checkQueue(e:Event):Boolean
        {
            var world:MovieClip;
            var l:String;
            var f:int;
            var s:*;
            var wItem:Object;
            if (animQueue.length > 0)
            {
                world = (MovieClip(stage.getChildAt(0)).world as MovieClip);
                l = mcChar.currentLabel;
                f = mcChar.emoteLoopFrame();
                if (((world.combatAnims.indexOf(l) > -1) && (mcChar.currentFrame > (f + 4))))
                {
                    s = animQueue[0];
                    mcChar.gotoAndPlay(s);
                    wItem = pAV.getItemByEquipSlot("Weapon");
                    if (s.indexOf("Attack") >= 0)
                    {
                        if (((wItem.sType == "Gauntlet") && ((MovieClip(mcChar.fronthand.getChildAt(1)).bAttack == true) || (MovieClip(mcChar.backhand.getChildAt(1)).bAttack == true))))
                        {
                            MovieClip(mcChar.fronthand.getChildAt(1)).gotoAndPlay("Attack");
                            MovieClip(mcChar.backhand.getChildAt(1)).gotoAndPlay("Attack");
                        }
                        else
                        {
                            if (mcChar.weapon.mcWeapon.bAttack == true)
                            {
                                mcChar.weapon.mcWeapon.gotoAndPlay("Attack");
                            };
                        };
                    };
                    animQueue.shift();
                    return (true);
                };
            };
            return (false);
        }

        public function clearQueue():void
        {
            animQueue = [];
        }

        private function linearTween(t:*, b:*, c:*, d:*):Number
        {
            return (((c * t) / d) + b);
        }

        public function walkTo(toX:int, toY:int, walkSpeed:int):void
        {
            var dist:Number;
            var turned:Boolean;
            var dx:Number;
            if (((pAV.isMyAvatar) && (pAV.isWorldCamera)))
            {
                return;
            };
            var isOK:Boolean = true;
            try
            {
                STAGE = MovieClip(parent.parent);
            }
            catch(e:Error)
            {
                isOK = false;
            };
            if (isOK)
            {
                op = new Point(this.x, this.y);
                tp = new Point(toX, toY);
                if (((!(pAV.petMC == null)) && (!(pAV.petMC.mcChar == null))))
                {
                    turned = false;
                    if ((op.x - tp.x) < 0)
                    {
                        if (pAV.petMC.mcChar.scaleX < 0)
                        {
                            pAV.petMC.turn("right");
                            turned = true;
                        };
                    }
                    else
                    {
                        if (pAV.petMC.mcChar.scaleX > 0)
                        {
                            pAV.petMC.turn("left");
                            turned = true;
                        };
                    };
                    pAV.petMC.walkTo((toX - 20), (toY + 5), (walkSpeed - 3));
                };
                this.walkSpeed = walkSpeed;
                dist = Point.distance(op, tp);
                walkTS = new Date().getTime();
                walkD = Math.round((1000 * (dist / (walkSpeed * 22))));
                if (walkD > 0)
                {
                    dx = (op.x - tp.x);
                    if (dx < 0)
                    {
                        this.turn("right");
                    }
                    else
                    {
                        this.turn("left");
                    };
                    if (!this.mcChar.onMove)
                    {
                        this.mcChar.onMove = true;
                        if (this.mcChar.currentLabel != "Walk")
                        {
                            this.mcChar.gotoAndPlay("Walk");
                        };
                    };
                    this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
                    this.addEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
                };
            };
        }

        private function onEnterFrameWalk(event:Event):void
        {
            var vX:*;
            var vY:*;
            var bitCollision:Boolean;
            var n:*;
            var nY:*;
            var i:*;
            var j:*;
            var k:int;
            var hitOK:Boolean;
            var aP:Point;
            var aR:Rectangle;
            var now:Number = new Date().getTime();
            var f:Number = ((now - walkTS) / walkD);
            if (f > 1)
            {
                f = 1;
            };
            if (((Point.distance(op, tp) > 0.5) && (this.mcChar.onMove)))
            {
                vX = this.x;
                vY = this.y;
                this.x = Point.interpolate(tp, op, f).x;
                this.y = Point.interpolate(tp, op, f).y;
                bitCollision = false;
                n = 0;
                while (n < STAGE.arrSolid.length)
                {
                    if (this.shadow.hitTestObject(STAGE.arrSolid[n].shadow))
                    {
                        bitCollision = true;
                        n = STAGE.arrSolid.length;
                    };
                    n++;
                };
                if (bitCollision)
                {
                    nY = this.y;
                    this.y = vY;
                    bitCollision = false;
                    i = 0;
                    while (i < STAGE.arrSolid.length)
                    {
                        if (this.shadow.hitTestObject(STAGE.arrSolid[i].shadow))
                        {
                            this.y = nY;
                            bitCollision = true;
                            break;
                        };
                        i++;
                    };
                    if (bitCollision)
                    {
                        this.x = vX;
                        bitCollision = false;
                        j = 0;
                        while (j < STAGE.arrSolid.length)
                        {
                            if (this.shadow.hitTestObject(STAGE.arrSolid[j].shadow))
                            {
                                bitCollision = true;
                                break;
                            };
                            j++;
                        };
                        if (bitCollision)
                        {
                            this.x = vX;
                            this.y = vY;
                            this.stopWalking();
                        };
                    };
                };
                if ((((Math.round(vX) == Math.round(this.x)) && (Math.round(vY) == Math.round(this.y))) && (now > (walkTS + 50))))
                {
                    this.stopWalking();
                };
                if (this.pAV.isMyAvatar)
                {
                    checkPadLabels();
                    k = 0;
                    while (k < STAGE.arrEvent.length)
                    {
                        hitOK = false;
                        world = MovieClip(stage.getChildAt(0)).world;
                        if (world.bPvP)
                        {
                            aP = this.shadow.localToGlobal(new Point(0, 0));
                            aR = STAGE.arrEvent[k].shadow.getBounds(stage);
                            if (aR.containsPoint(aP))
                            {
                                hitOK = true;
                            };
                        }
                        else
                        {
                            if (this.shadow.hitTestObject(STAGE.arrEvent[k].shadow))
                            {
                                hitOK = true;
                            };
                        };
                        if (hitOK)
                        {
                            if (((!(STAGE.arrEvent[k]._entered)) && (MovieClip(STAGE.arrEvent[k]).isEvent)))
                            {
                                STAGE.arrEvent[k]._entered = true;
                                if (this == MovieClip(parent.parent).myAvatar.pMC)
                                {
                                    STAGE.arrEvent[k].dispatchEvent(new Event("enter"));
                                };
                            };
                        }
                        else
                        {
                            if (STAGE.arrEvent[k]._entered)
                            {
                                STAGE.arrEvent[k]._entered = false;
                            };
                        };
                        k++;
                    };
                };
            }
            else
            {
                this.stopWalking();
            };
        }

        public function simulateTo(toX:int, toY:int, walkSpeed:int):Point
        {
            STAGE = MovieClip(parent.parent);
            this.xDep = this.x;
            this.yDep = this.y;
            this.xTar = toX;
            this.yTar = toY;
            this.walkSpeed = walkSpeed;
            this.nDuration = Math.round((Math.sqrt((Math.pow((this.xTar - this.x), 2) + Math.pow((this.yTar - this.y), 2))) / walkSpeed));
            var mvPT:* = new Point();
            if (this.nDuration)
            {
                this.nXStep = 0;
                this.nYStep = 0;
                if (!this.mcChar.onMove)
                {
                    this.mcChar.onMove = true;
                };
                mvPT = simulateWalkLoop();
            }
            else
            {
                mvPT = null;
            };
            this.x = this.xDep;
            this.y = this.yDep;
            this.mcChar.onMove = false;
            return (mvPT);
        }

        private function simulateWalkLoop():Point
        {
            var vX:*;
            var vY:*;
            var bitCollision:Boolean;
            var n:*;
            var nY:*;
            var i:*;
            var j:*;
            while ((((this.nXStep <= this.nDuration) || (this.nYStep <= this.nDuration)) && (this.mcChar.onMove)))
            {
                vX = this.x;
                vY = this.y;
                this.x = linearTween(this.nXStep, this.xDep, (this.xTar - this.xDep), this.nDuration);
                this.y = linearTween(this.nYStep, this.yDep, (this.yTar - this.yDep), this.nDuration);
                bitCollision = false;
                n = 0;
                while (n < STAGE.arrSolid.length)
                {
                    if (this.shadow.hitTestObject(STAGE.arrSolid[n].shadow))
                    {
                        bitCollision = true;
                        n = STAGE.arrSolid.length;
                    };
                    n++;
                };
                if (bitCollision)
                {
                    nY = this.y;
                    this.y = vY;
                    bitCollision = false;
                    i = 0;
                    while (i < STAGE.arrSolid.length)
                    {
                        if (this.shadow.hitTestObject(STAGE.arrSolid[i].shadow))
                        {
                            this.y = nY;
                            bitCollision = true;
                            break;
                        };
                        i++;
                    };
                    if (bitCollision)
                    {
                        this.x = vX;
                        bitCollision = false;
                        j = 0;
                        while (j < STAGE.arrSolid.length)
                        {
                            if (this.shadow.hitTestObject(STAGE.arrSolid[j].shadow))
                            {
                                bitCollision = true;
                                break;
                            };
                            j++;
                        };
                        if (bitCollision)
                        {
                            this.x = vX;
                            this.y = vY;
                            this.mcChar.onMove = false;
                            this.nDuration = -1;
                            return (new Point(this.x, this.y));
                        };
                        if (this.nYStep <= this.nDuration)
                        {
                            this.nYStep++;
                        };
                    }
                    else
                    {
                        if (this.nXStep <= this.nDuration)
                        {
                            this.nXStep++;
                        };
                    };
                }
                else
                {
                    if (this.nXStep <= this.nDuration)
                    {
                        this.nXStep++;
                    };
                    if (this.nYStep <= this.nDuration)
                    {
                        this.nYStep++;
                    };
                };
                if ((((Math.round(vX) == Math.round(this.x)) && (Math.round(vY) == Math.round(this.y))) && ((this.nXStep > 1) || (this.nYStep > 1))))
                {
                    this.mcChar.onMove = false;
                    this.nDuration = -1;
                    return (new Point(this.x, this.y));
                };
            };
            this.mcChar.onMove = false;
            this.nDuration = -1;
            return (new Point(this.x, this.y));
        }

        public function stopWalking():void
        {
            world = MovieClip(stage.getChildAt(0)).world;
            if (this.mcChar.onMove)
            {
                this.removeEventListener(Event.ENTER_FRAME, onEnterFrameWalk);
                if (((this.pAV.isMyAvatar) && (MovieClip(parent.parent).actionReady)))
                {
                    world.testAction(world.getAutoAttack());
                };
            };
            this.mcChar.onMove = false;
            if (this.walkSpeed > 23)
            {
                this.mcChar.gotoAndPlay("Fight");
            }
            else
            {
                this.mcChar.gotoAndPlay("Idle");
            };
        }

        public function checkPadLabels():*
        {
            var pad:*;
            var padNO:*;
            var rootClass:* = MovieClip(stage.getChildAt(0));
            var ui:* = rootClass.ui;
            var l:int;
            while (l < ui.mcPadNames.numChildren)
            {
                pad = MovieClip(ui.mcPadNames.getChildAt(l));
                padNO = new Point(4, 8);
                padNO = pad.cnt.localToGlobal(padNO);
                if (rootClass.distanceO(this, padNO) < 200)
                {
                    if (!pad.isOn)
                    {
                        pad.isOn = true;
                        pad.gotoAndPlay("in");
                    };
                }
                else
                {
                    if (pad.isOn)
                    {
                        pad.isOn = false;
                        pad.gotoAndPlay("out");
                    };
                };
                l++;
            };
        }

        public function turn(strDir:String):void
        {
            if ((((strDir == "right") && (this.mcChar.scaleX < 0)) || ((strDir == "left") && (this.mcChar.scaleX > 0))))
            {
                this.mcChar.scaleX = (this.mcChar.scaleX * -1);
            };
        }

        public function scale(intScale:Number):void
        {
            if ((this.mcChar.scaleX >= 0))
            {
                this.mcChar.scaleX = intScale;
            }
            else
            {
                this.mcChar.scaleX = -(intScale);
            };
            this.mcChar.scaleY = intScale;
            this.shadow.scaleX = (this.shadow.scaleY = intScale);
            this.cShadow.scaleX = (this.cShadow.scaleY = intScale);
            var p:Point = this.mcChar.localToGlobal(headPoint);
            p = this.globalToLocal(p);
            this.pname.y = int(p.y);
            this.bubble.y = int((this.pname.y - this.bubble.height));
            this.ignore.y = int(((this.pname.y - this.ignore.height) - 2));
            drawHitBox();
        }

        public function endAction():void
        {
            var dx:Number;
            var s:String;
            var wItem:Object;
            var sType:*;
            var tChar:* = null;
            if (this.pAV.target != null)
            {
                tChar = this.pAV.target.pMC.mcChar;
            };
            if (!checkQueue(null))
            {
                if (this.mcChar.onMove)
                {
                    this.mcChar.gotoAndPlay("Walk");
                    dx = (this.x - this.xTar);
                    if ((dx < 0))
                    {
                        this.turn("right");
                    }
                    else
                    {
                        this.turn("left");
                    };
                }
                else
                {
                    if (((tChar == null) || ((!(tChar == null)) && ((((tChar.currentLabel == "Die") || (tChar.currentLabel == "Feign")) || (tChar.currentLabel == "Dead")) || ((this.pAV.target.npcType == "player") && ((!("pvpTeam" in this.pAV.dataLeaf)) || (this.pAV.dataLeaf.pvpTeam == this.pAV.target.dataLeaf.pvpTeam)))))))
                    {
                        if (this.mcChar.currentLabel != "Jump")
                        {
                            this.mcChar.gotoAndPlay("Idle");
                        };
                        if (tChar != null)
                        {
                            if (this.pAV.target.dataLeaf.intState == 0)
                            {
                                if (this.pAV == world.myAvatar)
                                {
                                    world.setTarget(null);
                                };
                            };
                        };
                    }
                    else
                    {
                        s = "Fight";
                        wItem = pAV.getItemByEquipSlot("Weapon");
                        if (((!(wItem == null)) && (!(wItem.sType == null))))
                        {
                            sType = wItem.sType;
                            if (wItem.ItemID == 156)
                            {
                                sType = "Unarmed";
                            };
                            switch (sType)
                            {
                                case "Rifle":
                                    s = "RifleFight";
                                    break;
                                case "Gauntlet":
                                    s = "UnarmedFight";
                                    break;
                                case "Unarmed":
                                    s = "UnarmedFight";
                                    break;
                                case "Polearm":
                                    s = "PolearmFight";
                                    break;
                                case "Dagger":
                                    s = "DuelWield/DaggerFight";
                                    break;
                            };
                        };
                        this.mcChar.gotoAndPlay(s);
                    };
                };
            };
        }

        private function drawHitBox():void
        {
            mcChar.hitbox.graphics.clear();
            var hbx:int = -30;
            var hbw:int = 60;
            var hby:int = mcChar.head.y;
            var hbh:int = (-(hby) * 0.8);
            hitboxR = new Rectangle(hbx, hby, hbw, hbh);
            var g:Graphics = mcChar.hitbox.graphics;
            g.lineStyle(0, 0xFFFFFF, 0);
            g.beginFill(0xAA00FF, 0);
            g.moveTo(hbx, hby);
            g.lineTo((hbx + hbw), hby);
            g.lineTo((hbx + hbw), (hby + hbh));
            g.lineTo(hbx, (hby + hbh));
            g.lineTo(hbx, hby);
            g.endFill();
        }

        public function showHealIcon():void
        {
            var icon:HealIconMC;
            if (!getChildByName("HealIconMC"))
            {
                icon = new HealIconMC(pAV, world);
                icon.name = "HealIconMC";
                addChild(icon);
            };
        }

        private function randomNumber(min:Number, max:Number):Number
        {
            randNum = (min + (((max + 1) - min) * XORandom()));
            return ((randNum < max) ? randNum : max);
        }

        private function XORandom():Number
        {
            r = (r ^ (r << 21));
            r = (r ^ (r >>> 35));
            r = (r ^ (r << 4));
            if (r > 0)
            {
                return (r * MAX_RATIO);
            };
            return (r * NEGA_MAX_RATIO);
        }

        public function iaF(iaObject:Object):void
        {
            var armorMC:MovieClip;
            trace("avatar iaF called");
            armorMC = (mcChar.head.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.chest.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.hip.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.idlefoot.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.frontfoot.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.backfoot.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.frontshoulder.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.backshoulder.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.fronthand.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.backhand.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.frontthigh.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.backthigh.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.frontshin.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.backshin.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.robe.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
            armorMC = (mcChar.backrobe.getChildAt(0) as MovieClip);
            if (armorMC != null)
            {
                try
                {
                    armorMC.iaF(iaObject);
                }
                catch(e)
                {
                };
            };
        }

        public function playSound():void
        {
        }

        public function addAnimationListener(strAnim:String, f:Function):void
        {
            if (animEvents[strAnim] == null)
            {
                animEvents[strAnim] = new Array();
            };
            if (!hasAnimationListener(strAnim, f))
            {
                animEvents[strAnim].push(f);
            };
        }

        public function removeAnimationListener(strAnim:String, f:Function):void
        {
            if (animEvents[strAnim] == null)
            {
                return;
            };
            var i:uint;
            while (i < animEvents[strAnim].length)
            {
                if (animEvents[strAnim][i] == f)
                {
                    animEvents[strAnim].splice(i, 1);
                    break;
                };
                i++;
            };
        }

        public function hasAnimationListener(strAnim:String, f:Function):Boolean
        {
            if (animEvents[strAnim] == null)
            {
                return (false);
            };
            var i:uint;
            while (i < animEvents[strAnim].length)
            {
                if (animEvents[strAnim][i] == f)
                {
                    return (true);
                };
                i++;
            };
            return (false);
        }

        private function handleAnimEvent(strAnim:String):void
        {
            var f:Function;
            if (animEvents[strAnim] == null)
            {
                return;
            };
            var i:uint;
            while (i < animEvents[strAnim].length)
            {
                f = animEvents[strAnim][i];
                (f());
                i++;
            };
        }

        public function clearAnimEvents():void
        {
            animEvents = new Object();
        }

        public function get AnimEvent():Object
        {
            return (animEvents);
        }

        public function artLoaded():Boolean
        {
            return (((((((weaponLoad) && (capeLoad)) && (helmLoad)) && (armorLoad)) && (classLoad)) && (hairLoad)) && (miscLoad));
        }

        internal function frame1():*
        {
            mcChar.transform.colorTransform = CT1;
            mcChar.alpha = 0;
            stop();
        }

        internal function frame5():*
        {
            mcChar.transform.colorTransform = CT1;
            mcChar.alpha = 0;
        }

        internal function frame8():*
        {
            stop();
        }

        internal function frame10():*
        {
            mcChar.alpha = 0;
        }

        internal function frame12():*
        {
            mcChar.transform.colorTransform = CT3;
        }

        internal function frame13():*
        {
            mcChar.transform.colorTransform = CT2;
        }

        internal function frame14():*
        {
            mcChar.transform.colorTransform = CT1;
        }

        internal function frame18():*
        {
            stop();
        }

        internal function frame20():*
        {
            mcChar.transform.colorTransform = CT1;
        }

        internal function frame23():*
        {
            stop();
        }


    }
}//package 

