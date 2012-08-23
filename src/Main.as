package {
import flash.display.Sprite;
import flash.events.Event;

[SWF(width = "600", height="480", frameRate="60")]
public class Main extends Sprite {
    private var hermiteRenderer: HermiteRenderer;
    private var canvas: Sprite;

    public function Main()
    {
        if(stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
    }

    private function onAddedToStage( e: Event ): void
    {
        removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
        init();
    }

    private function init(): void
    {
        canvas = new Sprite();
        addChild(canvas);

        hermiteRenderer = new HermiteRenderer(canvas);
        var startPoint:Vector2D = new Vector2D( 25, 100 );
        var endPoint:Vector2D = new Vector2D( 400, 100 );
        var startPointTangent:Vector2D = new Vector2D( 10, 600 );
        var endPointTangent:Vector2D = new Vector2D( 10, 600 );

        hermiteRenderer.drawHermite( startPoint, endPoint, startPointTangent, endPointTangent, 0 );
    }
}
}
