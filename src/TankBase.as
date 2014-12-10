package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Daniël Brand
	 */
	public class TankBase extends MovieClip
	{
		//protected var tankBody:TankBodyArt;
		protected var tankTurret:TankTurretArt;
		
		public var turretAngle:Number = 0;
		
		public var targetPosition:Point;
		
		public var lives:int = 6;
		
		public function TankBase() 
		{
			this.addEventListener(Event.ENTER_FRAME, loop);
			targetPosition = new Point();
			//tankBody = new TankBodyArt();
			//this.addChild(tankBody);
			//tankTurret = new TankTurretArt();
			//this.addChild(tankTurret);	
			
			this.scaleX = this.scaleY = 0.2;
		}
		public function loop(e:Event):void 
		{
			//turret rotatie
			var dx:Number = targetPosition.x;
			var dy:Number = targetPosition.y;
			
			var radian = Math.atan2(dy, dx);
			var angle:Number = radian * 180 / Math.PI;//omzetten van radian naar angle
			
			tankTurret.rotation = angle;
			turretAngle = tankTurret.rotation;//hiermee kun je in de main ook de turretangle lezen 
						
		}
		public function destroy():void
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);
		}
	}

}