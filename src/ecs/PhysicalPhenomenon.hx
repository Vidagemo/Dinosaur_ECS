package ecs;
 
class PhysicalPhenomenon extends Component{
    public var velocity : Vector2;//obj velocity
    public var onGround : Bool;
    public var gravity : Float;//gravity value
    public var friction : Float;//friction value
    public var affectedByGravity : Bool;
    public var affectedByFriction : Bool;
    public function new(attachee:Entity, affectedByGravity:Bool, affectedByFriction:Bool, 
                        onGound:Bool = false, gravity:Float = 0, friction:Float = 0) {

        super(attachee);
        type = "PhysicalPhenomenon";
        this.gravity = gravity;
        this.friction = friction;
        this.onGround = onGound;
        this.affectedByGravity = affectedByGravity;
        this.affectedByFriction = affectedByFriction;
        this.velocity = new Vector2();
    }
    public override function update(dt:Float) {
        attachee.obj.x += velocity.x;
        attachee.obj.y += velocity.y;
        if (affectedByGravity){
            velocity.y += gravity;
            //trace(velocity.y);
        }
        if (affectedByFriction){
            velocity.x *= friction;
            if (Math.abs(velocity.x) <= 1){
                velocity.x = 0;
            }
        }
        //if (velocity.y != 0)velocity.y = 0;
    }
}