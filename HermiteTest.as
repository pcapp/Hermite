package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class HermiteTest extends Sprite
	{
		public function HermiteTest():void 
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStageHandler );
		}
		
		public function onAddedToStageHandler( e:Event ):void
		{
			var startPoint:Vector2D = new Vector2D( 25, 50 );
			var endPoint:Vector2D = new Vector2D( 75, 50 );
			var startPointTangent:Vector2D = new Vector2D( 10, 200 );
			var endPointTangent:Vector2D = new Vector2D( 10, 200 );
			drawPanel_mc.drawHermite( startPoint, endPoint, startPointTangent, endPointTangent, 0 );
		}
	}
}