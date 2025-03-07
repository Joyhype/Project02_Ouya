package code.objects
{
	//STARLING LIBRARIES
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
	//LIBRARIES
	import flash.events.KeyboardEvent; 
	import flash.events.Event;
	import flash.events.TimerEvent;
 	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Timer;
    //LOCAL
    import code.objects.Player;
    import code.objects.Gun;
    import code.objects.Bullet;
    import code.achievements.Medals;

	public class Enemies extends Sprite
	{
		//..SPRITES
		//public var e1:Image; 
		public var e1:symEnemy01;
		public var _enemies:Array = new Array();
	
		public static var ENEMYDROP:Number = 5; 
		public static var ENEMYSPEED:Number = 2;
		public static var ENEMYROTATION:Number = Math.random()*5;
		public static var MAX_SPEED:Number = 5;

		private var speedIncrease:Timer;
		private var addEnemies:Timer; 

		//-------------------------------------------------------------------------|
		//##SETUP------------------------------------------------------------------|
		//-------------------------------------------------------------------------|
		public function Enemies()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, stageSetup);
		}

		public function stageSetup(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, stageSetup);
			this.addEventListener(Event.ENTER_FRAME, updateEnemies);
			speedIncrease = new Timer( 10000 , 9999 );  
			speedIncrease.addEventListener(TimerEvent.TIMER, onIncreaseVelocity);
			speedIncrease.start();

			addEnemies = new Timer( 5000, 9999);
			addEnemies.addEventListener(TimerEvent.TIMER, onAddEnemies);
			addEnemies.start();
			
			enemyArray();
		}
		//-------------------------------------------------------------------------|
		
		//-------------------------------------------------------------------------|
		public function enemyArray():void {
			var length:Number = ENEMYDROP;

			for ( var i:Number = 0; i < length; i++) {
				createEnemy01();
				e1.x = 120 + (i * (1920 - 240) / 4); 
			}
		}
		
		public function onIncreaseVelocity(e:TimerEvent):void {
			updateVelocity();
			for ( var i:Number = 2; i < _enemies.length; i++) {
		     	if (_enemies[i].y >= 1080) {
					updateVelocity();
				}
		    }
		}

		public function onAddEnemies(e:TimerEvent):void {
			enemyArray();
			ENEMYDROP = 4;
			//TODO: Implement Enemy Drop Patterns?
		}

		public function updateVelocity():void {
			ENEMYSPEED += 0.3;
		}

		//-------------------------------------------------------------------------|

		 //------------------------------------------------------------------------|
		//##MOVEENMIES-------------------------------------------------------------|
		//-------------------------------------------------------------------------|
		public function moveEnemies():void {
			for ( var i:Number = 0; i < _enemies.length; i++) {
		        _enemies[i].y += ENEMYSPEED;
		        _enemies[i].rotation += ENEMYROTATION;
		    }
		}

		public function checkBounds():void {
			for ( var i:Number = 0; i < _enemies.length; i++) {
		     	if (_enemies[i].y >= 1080) {
					_enemies[i].y = -900 - Math.random() * 500;
				}
		    }
		
		}

		public function collisionDetection():void {
			for ( var i:Number = 0; i < _enemies.length; i++) {
				//for every bullet in gun.bullets
				for(var j:Number = Bullet.bullets.length -1; j >= 0; j--) {
					var b:Bullet = Bullet.bullets[j];
					if (b != null) {
						if (_enemies[i].hitTestObject(b.sprite)){
							trace('**Bullet Has Hit Enemy', '=', i);
							Starling.current.nativeOverlay.removeChild(_enemies[i]);
							_enemies.splice(i,1);
							Bullet.bullets[j].remove();	
						}	
					}
					
				}
		    }
		}

		//-------------------------------------------------------------------------|
		//##UPDATE-----------------------------------------------------------------|
		//-------------------------------------------------------------------------|

        public function updateEnemies(e:Event):void {
        	moveEnemies();
        	if (ENEMYSPEED >= MAX_SPEED) {
				ENEMYSPEED = MAX_SPEED;
				//speedIncrease.stop();
			}
			for ( var i:Number = 0; i < _enemies.length; i++) {
		     	if (_enemies[i].y >= 1080) {
					Starling.current.nativeOverlay.removeChild(_enemies[i]);
					_enemies.splice(i, 1)
				}
		    }
        }

        //-------------------------------------------------------------------------|

		//-------------------------------------------------------------------------|
		//##CREATE ENEMIES---------------------------------------------------------|
		//-------------------------------------------------------------------------|
		public function createEnemy01():void {
			e1 = new symEnemy01();
			e1.y = -200 - Math.random() * 500;
			Starling.current.nativeOverlay.addChild(e1);
			_enemies.push(e1);
		}
		//-------------------------------------------------------------------------|
	}
}