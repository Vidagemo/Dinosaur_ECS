package role;


import hxd.Key;
import hxd.Res;
import ecs.*;

class Mystery_box extends Entity{
    public var appearance : Appearance;
    public var physical : PhysicalPhenomenon;
    public var collider : Collider;
    public function new(s:h2d.Scene, x:Int, y:Int) {
        super(s, "mystery_box");
        obj.setPosition(x, y);
        appearance = new Appearance(this, Res.mystery_box.toTile(), scene, 80, 80);
        physical = new PhysicalPhenomenon(this, false, false, true);
        collider = new Collider(this, "box", true, false, new Vector2(0, 0), "ground", ["character"]);
        //new Appearance(this, Res.mystery_box.toTile(), scene, 100, 100);
        //new PhysicalPhenomenon(this, false, false, true);
        //collider = new Collider(this, "box", true, false, new Vector2(0, 0));
        collider.colliderEvents.add(onTop);
    }
    function onTop() {
        /*
        var x = collider.collidedWith.first().direction.x;
        var y = collider.collidedWith.first().direction.y;
        trace("x: "+x);
        trace("y: "+y);
        */
        while (collider.collidedWith.length != 0){
            var c = collider.collidedWith.pop();
            if (collider.touchTop){
                c.attachee.obj.y = obj.y-height/2-c.attachee.height/2+3;
                c.collider.pp.affectedByGravity = false;
                //trace(c.collider.pp.onGround);
                c.collider.pp.onGround = true;
                if (Key.isDown(Key.SPACE))c.collider.pp.onGround = false;
            }
            if (collider.touchLeft){
                //c.attachee.obj.x = obj.x-width/2-c.attachee.width/2+3;
            }
            if (collider.touchRight){
                //c.attachee.obj.x = obj.x+width/2+c.attachee.width/2+3;
            }
            /*
            else if (collider.touchBottom){
                //c.attachee.obj.y = obj.y+height/2+c.attachee.height/2+3;
                //trace("bottom: "+collider.touchBottom); 
                //c.collider.pp.velocity.y = 0;
            }
            */
            /*
                trace("touchTop: "+collider.touchTop);
                trace("touchBottom: "+collider.touchBottom);
                trace("touchLeft: "+collider.touchLeft);
                trace("touchRight: "+collider.touchRight);
            */
        }
    }
}