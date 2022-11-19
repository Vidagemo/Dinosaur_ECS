package ecs;

import aseprite.Aseprite.AsepriteFrame;
import aseprite.AseAnim;
import h2d.Bitmap;
import h2d.Tile;
import h2d.Object;
import h2d.Anim;

class Animation extends Component {
    public var animFrame : Array<h2d.Tile>;// use for anim
    public var anim : h2d.Anim;
    public var asepriteFrame : Array<AsepriteFrame>;
    public var aseAnim : AseAnim;
    
    public function new(attachee:Entity, ?animFrame : Array<h2d.Tile>, ?asepriteFrame:Array<AsepriteFrame>, parent:h2d.Object, width:Float, height:Float) {
        super(attachee);//connect Entity
        type = "Animation";//set component type
        this.animFrame = animFrame;
        if (animFrame != null){
            for (i in 0...animFrame.length)animFrame[i] = animFrame[i].center();
            anim = new h2d.Anim(animFrame, 10, parent);
            anim.scaleX = width/animFrame[0].width;
            anim.scaleY = height/animFrame[0].height;
            anim.setPosition(attachee.obj.x, attachee.obj.y);
        }
        this.asepriteFrame = asepriteFrame;
        if (asepriteFrame != null){
            for (i in 0...asepriteFrame.length)asepriteFrame[i].tile = asepriteFrame[i].tile.center();
            aseAnim = new AseAnim(asepriteFrame, parent);
            aseAnim.scaleX = width/aseAnim.frames[0].tile.width;
            aseAnim.scaleY = height/aseAnim.frames[0].tile.height;
            aseAnim.setPosition(attachee.obj.x, attachee.obj.y);
        }
        attachee.width = width;
        attachee.height = height;

    }
    /*
    public function setAxis(dx:Float, dy:Float) {
        if (animFrame != null)anim.move(dx, dy);//set animation location x&y
        if (asepriteFrame != null)aseAnim.move(dx, dy);
    }
    */
    public function changeAnim(?animFrame2:Array<h2d.Tile>, ?asepriteFrame2:Array<AsepriteFrame>) {
        this.animFrame = animFrame2;
        if (animFrame != null){
            for (i in 0...animFrame2.length)animFrame2[i] = animFrame2[i].center();
            anim.play(animFrame2);//change animation
        }
        this.asepriteFrame = asepriteFrame2;
        if (asepriteFrame != null){
            for (i in 0...asepriteFrame2.length)asepriteFrame2[i].tile = asepriteFrame2[i].tile.center();
            aseAnim.play(asepriteFrame2);
        }
    }
    public override function update(dt:Float) {
        if (animFrame != null){
            anim.setPosition(attachee.obj.x, attachee.obj.y);//set animation position
            anim.rotation = attachee.obj.rotation;//set animation rotation
        }
        if (asepriteFrame != null){
            aseAnim.setPosition(attachee.obj.x, attachee.obj.y);
            aseAnim.rotation = attachee.obj.rotation;
        }
    }
}