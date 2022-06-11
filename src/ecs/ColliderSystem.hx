package ecs;

class ColliderSystem {
    public static var collidersInScene = new List<Collider>();
    //public static var factionList = new List<{faction:String, touch:Array<String>}>();
    static var c1hittedWay : Vector2;
    static var c2hittedWay : Vector2;
    //initialize
    /*
    public static function init() {
        //factionList.add({faction:("box"), touch:["a", "b"]});
    }
    */
    //main system 
    public static function checkCollider() {
        //trace(1);
        for (c1 in collidersInScene){
            for (c2 in collidersInScene){
                if (c1 != c2){
                    if (checkFaction(c1, c2) && checkColliderType(c1, c2)){
                        c1.addCollided(c2.attachee, c2, c1hittedWay);
                        c2.addCollided(c1.attachee, c1, c2hittedWay);
                    }else {
                        c1.removeCollided(c2.attachee);
                        c2.removeCollided(c1.attachee);
                    }
                }
            }
        }
    }
    static function checkFaction(c1:Collider, c2:Collider):Bool {
        /*
        var type = factionList.filter(function (tmp) return tmp.faction == f1);
        for (f1 in type.first().touch){
            if (f1 == f2)return true;
        }
        return false;
        */
        for (item in c2.touch){
            if (c1.faction == item)return true;
        }
        return false;
    }
    static function checkColliderType(c1:Collider, c2:Collider):Bool {
        // check collider is dynamic
        if (!c1.isDynamic && !c2.isDynamic)return false;
        //trace(1);
        // check collider is box or circle
        if (c1.colliderType == "circle" && c2.colliderType == "circle"){
            if (circleCollided(c1, c2))return true;
        }else if (c1.colliderType == "box"){
            if (boxCollided(c1, c2))return true;
        }else if (c1.colliderType == "circle" && c2.colliderType == "box"){
            if (boxCollided(c2, c1))return true;
        }
        return false;
    }
    static function circleCollided(c1:Collider, c2:Collider):Bool {
        var center1 = c1.getCenter();
        var center2 = c2.getCenter();
        if (distance(center1, center2, c1.attachee.width, c2.attachee.width)){
            c1hittedWay = new Vector2(center2.x - center1.x, center2.y - center1.y);
            c2hittedWay = new Vector2(center1.x - center2.x, center1.y - center2.y);
            return true;
        } 
        return false;
    }
    static function boxCollided(c1:Collider, c2:Collider):Bool {
        var center1 = c1.getCenter();
        var center2 = c2.getCenter();
        var widthLimit = (c1.attachee.width+c2.attachee.width)/2;
        var heightLimit = (c1.attachee.height+c2.attachee.height)/2;
        var hitc1 = new Vector2(center2.x-center1.x, center2.y-center1.y);
        if ((Math.abs(hitc1.x) <= widthLimit) && (Math.abs(hitc1.y) <= heightLimit)){
             
            return true;
        }
        return false;
    }
    static function distance(center1:Vector2, center2:Vector2, c1field:Float, c2field:Float):Bool {
        var x:Float = Math.abs(center1.x - center2.x);
        var y:Float = Math.abs(center1.y - center2.y);
        if ((x+y) > c1field+c2field)return false;
        if (Math.sqrt(x*x+y*y) <= c1field+c2field)return true;
        return false;    
    }
}

