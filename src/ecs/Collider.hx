package ecs;

import hxd.Event;

class Collider extends Component {
    public var colliderType : String;
    public var faction : String;//?
    public var touch : Array<String>;//?
    public var isTrigger : Bool;
    public var isDynamic : Bool;
    public var pp : PhysicalPhenomenon;
    public var touchTop : Bool;
    public var touchBottom : Bool;
    public var touchLeft : Bool;
    public var touchRight : Bool;
    var center : Vector2;
    public var collidedWith = new List<{attachee:Entity, collider:Collider,direction:Vector2}>();
                                    //{who hit, collided direction}
    public var colliderEvents = new List<Void->Void>();
    public function new(attachee:Entity, colliderType:String, isTrigger:Bool = false, 
                        isDynamic:Bool = false, center:Vector2, faction:String, touch:Array<String>) {
        super(attachee);
        type = "Collider";
        this.colliderType = colliderType;
        this.isTrigger = isTrigger;
        this.isDynamic = isDynamic;
        this.center = center;
        this.faction = faction;//?
        this.touch = touch;//?
        ColliderSystem.collidersInScene.add(this);
        var component = attachee.getComponent("PhysicalPhenomenon");
        if (component != null){
            pp = cast(component, PhysicalPhenomenon);
        }
    }
    //main system
    public function addCollided(e:Entity, c:Collider, direction:Vector2) {
        if (collidedWith.filter(function(tmp) return tmp.attachee == e).length == 0) {
            // record collided data
            collidedWith.add({attachee:e, collider:c, direction:direction});
            //collidedWith.add({attachee:e, collider:c, direction: new Vector2(0, 0)});
            // execute collider events
            for (event in colliderEvents){
                event();
            }
        }
    }
    public function removeCollided(e:Entity) {
        //remove collided data
        collidedWith = collidedWith.filter(function (tmp) return tmp.attachee != e);     
    }
    public function getCenter():Vector2 {
        return new Vector2(attachee.obj.x+center.x, attachee.obj.y+center.y);
    }
    public function touchSide(theta:Vector2) {// ?
        if (Math.abs(theta.y/theta.x)>=1){
            touchTop = theta.y<=0?true:false;
            touchBottom = theta.y>0?true:false;
            touchRight = false;
            touchRight = false;
        }else {
            touchLeft = theta.x<=0?true:false;
            touchRight = theta.x>0?true:false;
            touchTop = false;
            touchBottom = false;
        }
        //trace("x: "+Math.abs(delta.x/pp.velocity.x));
        //trace("y: "+Math.abs(delta.y/pp.velocity.y));
        //trace("top:"+touchTop);
        //trace("bottom: "+touchBottom);
        //trace("left: "+touchLeft);
        //trace("right: "+touchRight);
    }
}