package role;
import hxd.Key;
import aseprite.Dictionary;
import ase.AnimationDirection;
import aseprite.AseAnim;
import h2d.Tile;
import hxd.res.Image;
import hxd.Res;
import ecs.*;
class Turtle extends Entity {
    public var aseanim : AseAnim;
    public var animation : Animation;
    public var image : Image;
    public var physical : PhysicalPhenomenon;
    var air : Array<h2d.Tile> = [];
    public function new(s:h2d.Scene) {
        super(s, "turtle");
        obj.setPosition(180, 388);
        //trace(Res._7.name);
        //trace(Res._7.getFormat);
        //image = new Image(Res._7.entry);
        air = [Res.dinosaur_air.toTile()];
        animation = new Animation(this, null, Res._7_aseprite.toAseprite().getTag("walk"), s, 160, 160);
        animation.aseAnim.loop = true;
        physical = new PhysicalPhenomenon(this, false, false, false, 0, 0);
        entityEvents.add(move);
        //animation.setAxis(400, 400);
    }
    function move() {
        if (Key.isDown(Key.A) || Key.isDown(Key.D) || Key.isDown(Key.W) || Key.isDown(Key.S)){
            if (Key.isDown(Key.A)){
                physical.velocity.x = -10;
            }
            if (Key.isDown(Key.D)){
                physical.velocity.x = 10;
            }
            if (Key.isDown(Key.W)){
                physical.velocity.y = -10;
            }
            if (Key.isDown(Key.S)){
                physical.velocity.y = 10;
            }
        }else {
            physical.velocity.x = 0;
            physical.velocity.y = 0;
        }
    }
}