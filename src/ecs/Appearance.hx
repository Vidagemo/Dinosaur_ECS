package ecs;

import h2d.Tile;
import h2d.Object;
import h2d.Bitmap;
/*
typedef Point = {x:Int, y:Int}
typedef Point3 = { > Point, z:Int}

typedef IterableWithLength<T> = {
    > Iterable<T>, 
    var length(default, null):Int;
}  
*/
class Appearance extends Component {
    public var bmp : h2d.Bitmap;
    //var d(default, null):Int;
    public function new(attachee:Entity, t:h2d.Tile, s:h2d.Scene, width:Float, height:Float) {
        super(attachee);//connect Entity
        type = "Apperance";//set component type
        attachee.width = width;
        attachee.height = height;
        var tt = t.center();
        bmp = new Bitmap(tt, s);//Embed tile in sence
        //var test = Tile.fromColor(0xff66c4 ,10, 10, 1);
        //var bit = new Bitmap(test, bmp);
        bmp.scaleX = attachee.width/t.width;
        bmp.scaleY = attachee.height/t.height;
        bmp.setPosition(attachee.obj.x, attachee.obj.y);
        //var d:Point3 = {x:3, y:23, z:2}
    }
    public override function update(dt:Float) {
        bmp.setPosition(attachee.obj.x, attachee.obj.y);//update bmp position
    }
}
