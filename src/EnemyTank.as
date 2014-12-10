package  
{
	import flash.events.Event;
	import flash.events.TouchEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	/**
	 * ...
	 * @author Daniël Brand
	 */
	public class EnemyTank extends TankBase
	{
		private var tankBody:TankBodyEnemyArt;
		private var shootTimer:Timer;
		public function EnemyTank() 
		{
			tankBody = new TankBodyEnemyArt();
			this.addChild(tankBody);
			tankTurret = new TankTurretArt();
			this.addChild(tankTurret);
			
			shootTimer = new Timer(400+Math.random()*2200);
			shootTimer.addEventListener(TimerEvent.TIMER, shoot);
			shootTimer.start();
		}
		private function shoot(e:TimerEvent):void
		{
			var se:ShootEvent = new ShootEvent("onShoot");
			se.shooter = this;
			dispatchEvent(se);
		}
		override public function loop(e:Event):void
		{
			if (Main.tank1 != null)
			{
				targetPosition.x = Main.tank1.x - this.x;
				targetPosition.y = Main.tank1.y - this.y;
				super.loop(e);
			}
		}
		override public function destroy():void
		{
			shootTimer.removeEventListener(TimerEvent.TIMER, shoot);
			shootTimer.stop();
			shootTimer = null;
			super.destroy();//zo voer je ook alle anderen taken in een functie uit(die in de functie zitten die ik override)
			
		}
		
	}

}