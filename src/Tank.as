package  
{
	import flash.events.KeyboardEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Daniel Brand
	 */
	public class Tank extends TankBase
	{
		private var tankBody:TankBodyArt;
		//private var tankTurret:TankTurretArt;
		
		private var controlDir:Point;		
		private var speed:Number = 0;
		
		public function Tank() 
		{
			tankBody = new TankBodyArt();
			this.addChild(tankBody);
			tankTurret = new TankTurretArt();
			this.addChild(tankTurret);
			
			this.addEventListener(Event.ADDED_TO_STAGE, init);

			controlDir = new Point(0,0);
		}		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}		
		private function onClick(e:MouseEvent):void 
		{
			var se:ShootEvent = new ShootEvent("onShoot");
			se.shooter = this;
			dispatchEvent(se);
		}		
		override public function loop(e:Event):void 
		{		
			speed = controlDir.y * -5;			
			this.rotation += controlDir.x * 3; 
			
			
			//berekenen van beweging over x en y as nav rotatie
			var radian:Number = this.rotation * Math.PI / 180;//van graden naar radians
			var xMove:Number = Math.cos(radian);				
			var yMove:Number = Math.sin(radian);	
			this.x += xMove * speed;
			this.y += yMove * speed;
			
			targetPosition.x = mouseX;
			targetPosition.y = mouseY;
			
			super.loop(e);//zorgt ervoor dat de code in tankbase loop ook nog wordt uitgevoert	
		}
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.W)
			{
				// speler drukt op W				
				controlDir.y = 0;
			}
			if (e.keyCode == Keyboard.A)
			{
				// speler drukt op a				
				controlDir.x = 0;
			}
			if (e.keyCode == Keyboard.S)
			{
				// speler drukt op s				
				controlDir.y = 0;
			}
			if (e.keyCode == Keyboard.D)
			{
				// speler drukt op d					
				controlDir.x = 0;
			}
		}		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.W)
			{
				// speler heeft de W losgelaten
				controlDir.y = -1;
				/*
				while (controlDir.y >= -20)
				{
					controlDir.y += -0.2;
				}
				*/
				//controlDir.y = -1;
				//controlDir.y += -1;
				/*
				for (var i:int = 1; i < 5; i++ )
				{
					controlDir.y += -0.2;
					controlDir.y <= -1;
				}
				*/
			}
			if (e.keyCode == Keyboard.A)
			{
				// speler heeft de W losgelaten
				
				controlDir.x = -1;
			}
			if (e.keyCode == Keyboard.S)
			{
				// speler heeft de W losgelaten
				
				controlDir.y = 0.5;
			}
			if (e.keyCode == Keyboard.D)
			{
				// speler heeft de W losgelaten
				
				controlDir.x = 1;
			}
		}
		override public function destroy():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.removeEventListener(MouseEvent.CLICK, onClick);
			super.destroy();
		}
		
	}

}