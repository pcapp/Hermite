package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class HermiteRenderer
	{
        private var canvas: Sprite;

		public function HermiteRenderer( canvas: Sprite )
		{
            this.canvas = canvas;
        }

		public function drawPixel( x:uint, y:uint ):void 
		{
			canvas.graphics.beginFill( 0x000000 );
			canvas.graphics.drawRect( x, y, 1, 1 );
			canvas.graphics.endFill();
		}
		
		public function drawHermite( startPoint:Vector2D, endPoint:Vector2D, startPointTangent:Vector2D, endPointTangent:Vector2D, depth:uint ):void 
		{
			var curve:HermiteCurve = new HermiteCurve( startPoint, endPoint, startPointTangent, endPointTangent );
			var dx:Number = endPoint.x - startPoint.x;
			var dy:Number = endPoint.y - startPoint.y;
			var maxDistance:Number = 1; // 1 pixel
			var midPoint:Vector2D = curve.evaluateAt( .5 );
			
			drawPixel( midPoint.x, midPoint.y );
			
			if( ( dx*dx + dy*dy ) > (maxDistance * maxDistance ) )
			{
				var segment0:HermiteCurve = createReparameterizedSegment( curve, 0, .5 );
				var segment1:HermiteCurve = createReparameterizedSegment( curve, .5, 1 );
				drawHermite( segment0.startPoint, segment0.endPoint, segment0.startPointTangent, segment0.endPointTangent, depth + 1 );
				drawHermite( segment1.startPoint, segment1.endPoint, segment1.startPointTangent, segment1.endPointTangent, depth + 1 );
			}
		}
		
		private function makeVectorComponentsIntegral( v:Vector2D ):void
		{
			v.x = Math.round( v.x );
			v.y = Math.round( v.y );
		}
		
		private function createReparameterizedSegment( originalCurve:HermiteCurve, u_i:Number, u_j:Number )
		{	
			var q_0:Vector2D = originalCurve.evaluateAt( u_i );
			var q_1:Vector2D = originalCurve.evaluateAt( u_j );
			var q_0v:Vector2D = new Vector2D( originalCurve.evaluateDerivativeAt( u_i ).x * ( u_j - u_i ), originalCurve.evaluateDerivativeAt( u_i ).y * ( u_j - u_i ) );
			var q_1v:Vector2D = new Vector2D( originalCurve.evaluateDerivativeAt( u_j ).x * ( u_j - u_i ), originalCurve.evaluateDerivativeAt( u_j ).y * ( u_j - u_i ) );

			return new HermiteCurve( q_0, q_1, q_0v, q_1v );
		}
	}
}