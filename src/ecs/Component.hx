package ecs;

class Component {
    public var attachee : Entity;
    public var type:String = "Component";
    public function new(attachee_:Entity) {
        this.attachee = attachee_;
        attachee.addComponent(this);//add new component in Entity
    }
    
    public function update(dt:Float) {
        
    }
}