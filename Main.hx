import role.*;
import hxd.Res;
import ecs.*;
class Main extends hxd.App{
    //public var dinosaur : Dinosaur;
    public var turtle : Turtle;
    public var mystery_box : Mystery_box;
    override function init() {
        engine.backgroundColor = 0xF3F3F3;
        //dinosaur = new Dinosaur(s2d);
        turtle = new Turtle(s2d);
        //mystery_box = new Mystery_box(s2d, 800, 600);
        generatePlatform();
        //ColliderSystem.init();
    } 
    
    function generatePlatform() {
        var startx = 800;
        var starty = 500;
        var interval = 80;
        var limitx = startx+interval*4;
        while (startx <= limitx){
            mystery_box = new Mystery_box(s2d, startx, starty);
            startx += interval;
        }
    }
    
    override function update(dt:Float) {
        //dinosaur.update(dt);
        turtle.update(dt);
        ColliderSystem.checkCollider();
    }
    static function main() {
        Res.initEmbed();
        new Main();
    }
}