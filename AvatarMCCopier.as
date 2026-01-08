// Decompiled by AS3 Sorcerer 6.30
// www.as3sorcerer.com

//AvatarMCCopier

package 
{
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.Event;

    public class AvatarMCCopier 
    {

        private var world:*;
        private var rootClass:*;
        private var mcChar:MovieClip;
        private var objLinks:Object = {};
        private var pAV:Avatar;
        private var strGender:String;
        private var helmEquipped:Boolean = false;

        public function AvatarMCCopier(_world:MovieClip):void
        {
            world = _world;
        }

        public function copyTo(_mcChar:MovieClip):void
        {
            var i:*;
            var sES:*;
            mcChar = _mcChar;
            MovieClip(mcChar.parent).pAV = world.myAvatar;
            pAV = world.myAvatar;
            strGender = pAV.objData.strGender;
            var killList:* = ["cape", "backhair", "robe", "backrobe"];
            for (i in killList)
            {
                if (typeof(mcChar[killList[i]]) != undefined)
                {
                    mcChar[killList[i]].visible = false;
                };
            };
            if (((!(pAV.dataLeaf.showHelm)) || ((!("he" in pAV.objData.eqp)) && (pAV.objData.eqp.he == null))))
            {
				world.queueLoad({
					"strFile":(world.rootClass.getFilePath() + pAV.objData.eqp[sES].sFile),
					"callBackA":world.rootClass.onLoadMaster(onLoadWeaponComplete, world.loaderC),
					"avt":pAV
				});
            };
            for (sES in world.myAvatar.objData.eqp)
            {
                switch (sES)
                {
                    case "Weapon":
                        if (pAV.objData.eqp.Weapon.sType == "Gauntlet")
                        {
                            mcChar.weapon.visible = false;
                            break;
                        };
                        world.queueLoad({
                            "strFile":(world.rootClass.getFilePath() + pAV.objData.eqp[sES].sFile),
                            "callBackA":world.rootClass.onLoadMaster(onLoadWeaponComplete, world.loaderC),
							"avt":pAV,
							"sES":sES
                        });
                        break;
                    case "he":
                        if (pAV.dataLeaf.showHelm)
                        {
                            //onLoadHelmComplete(null);
							world.queueLoad({
								"strFile":(world.rootClass.getFilePath() + pAV.objData.eqp[sES].sFile),
								"callBackA":this.world.rootClass.onLoadMaster(onLoadHelmComplete, world.loaderC),
								"avt":pAV,
								"sES":sES
							});
                        };
                        break;
                    case "ba":
                        if (pAV.dataLeaf.showCloak)
                        {
                            //onLoadCapeComplete(null);
							world.queueLoad({
								"strFile":(this.world.rootClass.getFilePath() + pAV.objData.eqp[sES].sFile),
								"callBackA":this.world.rootClass.onLoadMaster(onLoadCapeComplete, world.loaderC),
								"avt":pAV,
								"sES":sES
							});
                        };
                        break;
                    case "ar":
                        if (world.myAvatar.objData.eqp.co == null)
                        {
                            objLinks.ar = pAV.objData.eqp.ar.sLink;
                            //onLoadArmorComplete(null);
							world.queueLoad({
								"strFile":(world.rootClass.getFilePath() + "classes/" + strGender + "/" + pAV.objData.eqp[sES].sFile),
								"callBackA":world.rootClass.onLoadMaster(onLoadArmorComplete, world.loaderC),
								"avt":pAV,
								"sES":sES
							});
                        };
                        break;
                    case "co":
                        objLinks.ar = pAV.objData.eqp.co.sLink;
                        //onLoadArmorComplete(null);
						world.queueLoad({
							"strFile":(world.rootClass.getFilePath() + "classes/" + strGender + "/" + this.pAV.objData.eqp[sES].sFile),
							"callBackA":world.rootClass.onLoadMaster(onLoadArmorComplete, world.loaderC),
							"avt":pAV,
							"sES":sES
						});
                        break;
                };
            };
        }

        public function loadArmorPieces(strSkinLinkage:String):void
        {
            var AssetClass:Class;
            var child:DisplayObject;
            try
            {
                AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Head")) as Class);
                mcChar.head.addChildAt(new (AssetClass)(), 0);
                mcChar.head.removeChildAt(1);
            }
            catch(err:Error)
            {
                AssetClass = (world.getClass(("mcHead" + strGender)) as Class);
                mcChar.head.addChildAt(new (AssetClass)(), 0);
                mcChar.head.removeChildAt(1);
            };
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Chest")) as Class);
            mcChar.chest.removeChildAt(0);
            mcChar.chest.addChild(new (AssetClass)());
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Hip")) as Class);
            mcChar.hip.removeChildAt(0);
            mcChar.hip.addChild(new (AssetClass)());
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "FootIdle")) as Class);
            mcChar.idlefoot.removeChildAt(0);
            mcChar.idlefoot.addChild(new (AssetClass)());
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Foot")) as Class);
            mcChar.frontfoot.removeChildAt(0);
            mcChar.frontfoot.addChild(new (AssetClass)());
            mcChar.frontfoot.visible = false;
            mcChar.backfoot.removeChildAt(0);
            mcChar.backfoot.addChild(new (AssetClass)());
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Shoulder")) as Class);
            mcChar.frontshoulder.removeChildAt(0);
            mcChar.frontshoulder.addChild(new (AssetClass)());
            mcChar.backshoulder.removeChildAt(0);
            mcChar.backshoulder.addChild(new (AssetClass)());
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Hand")) as Class);
            mcChar.fronthand.removeChildAt(0);
            mcChar.fronthand.addChild(new (AssetClass)());
            mcChar.backhand.removeChildAt(0);
            mcChar.backhand.addChild(new (AssetClass)());
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Thigh")) as Class);
            mcChar.frontthigh.removeChildAt(0);
            mcChar.frontthigh.addChild(new (AssetClass)());
            mcChar.backthigh.removeChildAt(0);
            mcChar.backthigh.addChild(new (AssetClass)());
            AssetClass = (world.getClass(((strSkinLinkage + strGender) + "Shin")) as Class);
            mcChar.frontshin.removeChildAt(0);
            mcChar.frontshin.addChild(new (AssetClass)());
            mcChar.backshin.removeChildAt(0);
            mcChar.backshin.addChild(new (AssetClass)());
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
        }

        public function onLoadArmorComplete(e:Event):void
        {
            loadArmorPieces(objLinks.ar);
        }

        public function onHairLoadComplete(e:Event):void
        {
            var AssetClass:Class;
            if (helmEquipped)
            {
                return;
            };
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
                if (mcChar.backhair.numChildren > 0)
                {
                    mcChar.backhair.removeChildAt(0);
                };
                mcChar.backhair.addChild(new (AssetClass)());
                mcChar.backhair.visible = true;
            }
            else
            {
                mcChar.backhair.visible = false;
            };
        }

        public function loadWeapon(sFile:*, sLink:*):void
        {
            if (pAV.objData.eqp.Weapon.sType == "Gauntlet")
            {
                mcChar.weapon.visible = false;
                return;
            };
			world.queueLoad({
				"strFile":(world.rootClass.getFilePath() + sFile),
				"callBackA":world.rootClass.onLoadMaster(onLoadWeaponComplete, world.loaderC),
				"avt":pAV,
                "sES":"weapon"
			});
        }

        public function onLoadWeaponComplete(e:Event):void
        {
            var AssetClass:Class;
            mcChar.weapon.removeChildAt(0);
            try
            {
                AssetClass = (world.getClass(pAV.objData.eqp.Weapon.sLink) as Class);
                mcChar.weapon.addChild(new (AssetClass)());
            }
            catch(err:Error)
            {
                mcChar.weapon.addChild(e.target.content);
            };
            mcChar.weapon.visible = true;
            if (("eventTrigger" in MovieClip(world.map)))
            {
                world.map.eventTrigger({"cmd":"copyAvatarMCCompleted"});
            };
        }

        public function onLoadCapeComplete(e:Event):void
        {
            var AssetClass:Class = (world.getClass(pAV.objData.eqp.ba.sLink) as Class);
            mcChar.cape.removeChildAt(0);
            mcChar.cape.cape = new (AssetClass)();
            mcChar.cape.addChild(mcChar.cape.cape);
            mcChar.cape.visible = true;
        }

        public function onLoadHelmComplete(e:Event):void
        {
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
                if (AssetClass2 != null)
                {
                    if (pAV.dataLeaf.showHelm)
                    {
                        mcChar.backhair.visible = true;
                        mcChar.backhair.addChild(new (AssetClass2)());
                    };
                }
                else
                {
                    mcChar.backhair.visible = ((mcChar.head.hair.visible) && (pAV.pMC.bBackHair));
                };
                mcChar.head.helm.addChild(new (AssetClass)());
                helmEquipped = true;
            }
            else
            {
                world.rootClass.chatF.pushMsg("warning", "Could not resolve Helm definition.", "SERVER", "", 0);
            };
        }


    }
}//package 

