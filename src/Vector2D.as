package
{
	public class Vector2D
	{
		public var x:Number;
		public var y:Number;
		
		public function Vector2D( x:Number, y:Number )
		{
			this.x = x;
			this.y = y;
		}
		
		public function equalTo( otherVector:Vector2D ):Boolean 
		{
			return ( x == otherVector.x && y == otherVector.y );
		}
		
		public function toString():String
		{
			return new String( "<" + x + "," + y + ">" );
		}
	}
}