package role;

import hxd.Key;
import hxd.Res;
import ecs.*;

class Dinosaur extends Entity {
    public var animation : Animation;
    public var physical : PhysicalPhenomenon;
    public var collider : Collider;
    var walk : Array<h2d.Tile> = [];
    var air : Array<h2d.Tile> = [];
    public function  new(s:h2d.Scene) {
        super(s, "dinosaur");
        obj.setPosition(180, 688);
        air = [Res.dinosaur_air.toTile()];
        walk = [Res.dinosaur_left.toTile(), Res.dinosaur_right.toTile()];
        animation = new Animation(this, air, null, scene, 160, 160);
        physical = new PhysicalPhenomenon(this, true, false, true, 2);
        collider = new Collider(this, "box", true, true, new Vector2(0, 0), "character", ["ground"]);
        entityEvents.add(move);
        //collider.colliderEvents.add(test);
    }
    /*
    function test() {
        var y = collider.collidedWith.first().direction.y;
        trace(y);
    }
    */
    function move() {
        if (obj.y > scene.height-height/2){
            physical.velocity.y = 0;
            obj.y = scene.height-height/2;
            physical.onGround = true;
        }
        //trace("physical: "+physical.onGround);
        if (physical.onGround){
            if (Key.isDown(Key.SPACE)){
                physical.affectedByGravity = true;
                physical.onGround = false;
                //physical.velocity.x = 0;
                physical.velocity.y = -40;
                animation.changeAnim(air);
            }
            //trace("onground: "+physical.onGround);
        }
        if (Key.isDown(Key.A) || Key.isDown(Key.D)){
            if (Key.isDown(Key.A)){
                physical.velocity.x = -10;
            }
            if (Key.isDown(Key.D)){
                physical.velocity.x = 10;
            } 
        }else physical.velocity.x = 0;
        
        if (!Key.isDown(Key.A) && !Key.isDown(Key.D))animation.changeAnim(air);
        else if (animation.anim.frames != walk)animation.changeAnim(walk);
        if (collider.collidedWith.length == 0){
            physical.affectedByGravity = true;
        }
    }
}