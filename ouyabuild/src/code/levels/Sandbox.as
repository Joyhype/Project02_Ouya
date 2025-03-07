package code.levels
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.core.Starling;
	import starling.animation.Juggler;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.events.KeyboardEvent;
	import starling.display.MovieClip;

	import code.objects.Player;
	import code.objects.Coin;


	import flash.events.TimerEvent;
 	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

	public class Sandbox extends Sprite
	{
		
		public var bg:Image;
		public var coin:Coin;
		public var _staticBG:Image;

		public function Sandbox()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, stageSetup);
		}

		private function stageSetup(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, stageSetup);
			drawBG();
		}


		public function drawBG():void {
			_staticBG = new Image(Assets.getTexture("staticBG"));
			this.addChild(_staticBG);
		}
	}
}