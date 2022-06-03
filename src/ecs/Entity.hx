package ecs;
import h2d.Object;
import ecs.*;
class Entity {
    public var name : String;
    public var obj : h2d.Object;
    public var width : Float;
    public var height : Float;
    public var scene : h2d.Scene;
    public var components = new List<Component>();//Entity components
    public var entityEvents = new List<Void->Void>();//Entity customize function
    public function new(s:h2d.Scene, name:String) {
        this.scene = s;
        this.name = name;
        this.obj = new h2d.Object(s);
    }
    public function addComponent(c:Component) {//add new component
        components.add(c);
    }
    public function removeComponent(c:Component) {//remove component
        components.remove(c);
    }
    public function getComponent(type:String):Component{//get component
        var comps = components.filter(function(c) return c.type == type);
        if(comps.length > 0){
            return comps.first();
        }
        return null;
    }
    public function update(dt:Float) {//update component list
        for (event in entityEvents){
            event();
        }
        for (item in components){
            item.update(dt);
        }
    }
}
