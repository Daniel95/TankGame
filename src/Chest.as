package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Daniel Brand
	 */
	public class Chest extends Sprite
	{
		private var chestArt:MovieClip;
		public var lives:int = 3;
		public function Chest() 
		{
			chestArt = new ChestArt();
			addChild(chestArt);
		}
		
	}

}