package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Daniel Brand
	 */
	public class Main extends Sprite 
	{
		public static var tank1:Tank;
		private var enemies:Array;
		private var bullets:Vector.<Bullet>;
		private var chests:Vector.<Chest>;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			enemies = new Array();
			
			tank1 = new Tank();//niet meer hier
			this.addChild(tank1);//maar wel hier
			
			for (var i:int = 0; i < 10; i++)
			{
				var enemy:EnemyTank = new EnemyTank();
				enemies.push(enemy);
				addChild(enemy);
				enemy.x = Math.random() * stage.stageWidth;
				enemy.y = Math.random() * stage.stageHeight;
				enemy.addEventListener("onShoot", createBullet);
			}
			
			this.addChild(tank1);//maar wel hier
			
			tank1.x = 300;
			tank1.y = 300;
			
			tank1.addEventListener("onShoot", createBullet);
						
			bullets = new Vector.<Bullet>();
			
			chests = new Vector.<Chest>();
			
			createChests();
			
			
			this.addEventListener(Event.ENTER_FRAME, loop);
		}		
		
		private function createChests():void 
		{
				for (var u:int = 0; u < 18; u++)
				{
					var chest:Chest = new Chest();
					chests.push(chest);
					addChild(chest);
					chest.x = 256;
					chest.y = 20 + u * 41;
				}
				for (var y:int = 0; y <18; y++)
				{
					var chest:Chest = new Chest();
					chests.push(chest);
					addChild(chest);
					chest.x = 512;
					chest.y = 20 + y * 41;
				}
				for (var t:int = 0; t < 18; t++)
				{
					var chest:Chest = new Chest();
					chests.push(chest);
					addChild(chest);
					chest.x = 768;
					chest.y = 20 + t * 41;
				}
				for (var r:int = 0; r < 18; r++)
				{
					var chest:Chest = new Chest();
					chests.push(chest);
					addChild(chest);
					chest.x = 1024;
					chest.y = 20 + r * 41;
				}
			/*
			for (var i:int = 0; i < 150; i++) 
			{
				
				var chest:Chest = new Chest();
				chests.push(chest);
				addChild(chest);
				chest.x = Math.random() * stage.stageWidth;
				chest.y = Math.random() * stage.stageHeight;
				chest.scaleX = chest.scaleY = tank1.scaleX;
			}
			*/
		}
		
		private function loop(e:Event):void 
		{
			if (tank1 != null)
			{
				if (tank1.x < 0 || tank1.x > 1280)
				{
					tank1.x = 640;
					tank1.y = 360;
				}
				if (tank1.y < 0 || tank1.y > 720)
				{
					tank1.x = 640;
					tank1.y = 360; 
				}
				for (var i:int = 0; i < bullets.length; i++ )
				{
					var toRemove:Boolean = false;
					
					bullets[i].update();
					for (var j:int = 0; j < chests.length; j++) 
					{
						if (chests[j].hitTestPoint(bullets[i].x, bullets[i].y, true))
						{
							toRemove = true;
							
							chests[j].lives--;
							if (chests[j].lives <= 0)
							{
								removeChild(chests[j]);
								chests.splice(j, 1);
							}
						}
					}
					for (var k:int = 0; k < enemies.length; k++)
					{
						if (enemies[k].hitTestPoint(bullets[i].x, bullets[i].y, true))
						{
							toRemove = true;
							enemies[k].lives--;
							if (enemies[k].lives <= 1)
							{
								enemies[k].destroy();
								removeChild(enemies[k]);
								enemies.splice(k, 1);
							}
						}
					}
					if (tank1.hitTestPoint(bullets[i].x, bullets[i].y, true))
					{
						toRemove = true;
						tank1.lives--;
						if (tank1.lives <= 0)
							{
								tank1.destroy();
								removeChild(tank1);
								tank1 = null;
								break;
							}
					}
					
					if (bullets[i].x > stage.stageWidth ||
					bullets[i].x < 0 ||
					bullets[i].y > stage.stageHeight ||
					bullets[i].y < 0)
					{
						
						toRemove = true;
						
					}				
					if (toRemove)//haalt de bullet weg
					{
						removeChild(bullets[i]);//verwijderen uit de display list
						bullets.splice(i, 1);//verwijderen uit de array geheugen
					}				
					
				}
			}
		}
		private function createBullet(e:ShootEvent):void 
		{
			if (tank1 != null)
			{
				var r:Number = e.shooter.turretAngle + e.shooter.rotation;
				var tPos:Point = new Point(e.shooter.x, e.shooter.y);
				var b:Bullet = new Bullet(r,tPos);//hier wordt de rotatie van bullet berekend		
				//b.rotation = tank1.turretAngle + tank1.rotation;
				bullets.push(b);			
				addChild(b);
				b.scaleX = b.scaleY = tank1.scaleX;
			}
		}
		
	}
	
}