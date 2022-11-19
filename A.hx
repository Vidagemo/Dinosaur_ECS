class A extends hxd.App{
    public var six(get, set):Int;
    public var x(default, never):Int = 10;
    public var y : Int;
    public function get_six():Int
    {
        return 6;
    }
    public function set_six(v:Int):Int
    {
        return v*6;
    }
    public function output() {
        //x = 10;
        return 50;
    }
}
