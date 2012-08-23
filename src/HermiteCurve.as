package
{
	public class HermiteCurve
	{
		private var _startPoint:Vector2D;
		private var _endPoint:Vector2D;
		private var _startPointTangent:Vector2D;
		private var _endPointTangent:Vector2D;
		
		public function HermiteCurve( startPoint:Vector2D, endPoint:Vector2D, startPointTangent:Vector2D, endPointTangent:Vector2D )
		{
			_startPoint = startPoint;
			_endPoint = endPoint;
			_startPointTangent = startPointTangent;
			_endPointTangent = endPointTangent;
		}
		
		public function printInfo():void
		{
			trace( "p_0: " + _startPoint.toString() );
			trace( "p_1: " + _endPoint.toString() );
			trace( "p_0u: " + _startPointTangent.toString() );
			trace( "p_1u: " + _endPointTangent.toString() );
		}
		
		public function evaluateAt( u:Number ):Vector2D
		{
			var result:Vector2D = null;
			var x:Number;
			var y:Number;
			
			if ( ( u >= 0 ) && ( u <= 1 ) )
			{
				x = f1(u) * _startPoint.x + f2(u) * _endPoint.x + f3(u) * _startPointTangent.x + f4(u) * _endPointTangent.x;
				y = f1(u) * _startPoint.y + f2(u) * _endPoint.y + f3(u) * _startPointTangent.y + f4(u) * _endPointTangent.y;
			
				result = new Vector2D( x, y );
			}
			
			return result;
		}
		
		public function evaluateDerivativeAt( u:Number ):Vector2D
		{
			var df1_du:Number = 6 * u * u - 6 * u;
			var df2_du:Number = -6 * u * u + 6 * u;
			var df3_du:Number = 3 * u * u - 4 * u + 1;
			var df4_du:Number = 3 * u * u - 2 * u;
			
			var x:Number = df1_du * _startPoint.x + df2_du * _endPoint.x + df3_du * _startPointTangent.x + df4_du * _endPointTangent.x;
			var y:Number = df1_du * _startPoint.y + df2_du * _endPoint.y + df3_du * _startPointTangent.y + df4_du * _endPointTangent.y;
		
			return new Vector2D( x, y );
		}
		
		private function f1( u:Number ):Number 
		{
			return ( 2 * u * u * u - 3 * u * u + 1 );
		}
		
		private function f2( u:Number ):Number
		{
			return ( -2 * u * u * u + 3 * u * u );
		}
		
		private function f3( u:Number ):Number
		{
			return ( u * u * u - 2 * u * u + u );
		}
		
		private function f4( u:Number ):Number
		{
			return ( u * u * u - u * u );
		}
		 
		public function get startPoint():Vector2D
		{
			return _startPoint;
		}
		public function get endPoint():Vector2D
		{
			return _endPoint;
		}
		
		public function get startPointTangent():Vector2D
		{
			return _startPointTangent;
		}
		
		public function get endPointTangent():Vector2D
		{
			return _endPointTangent;
		}
	}
}