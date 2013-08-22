package {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

[SWF(width="800", height="800", frameRate="60")]
public class Main extends Sprite {
    private var hermiteRenderer: HermiteRenderer;
    private var canvas: Sprite;

    private var startPoint:Vector2D;
    private var endPoint:Vector2D;
    private var startPointTangent:Vector2D;
    private var endPointTangent:Vector2D;

    private var p0handle: Sprite;
    private var p1handle: Sprite;
    private var dp0handle: Sprite;
    private var dp1handle: Sprite;

    private var draggedHandle: Sprite = null;

    public function Main()
    {
        if(stage) {
            init();
        } else {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
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

        startPoint = new Vector2D( 10, 400 );
        endPoint = new Vector2D( 400, 400 );
        startPointTangent = new Vector2D( 0, 400 );
        endPointTangent = new Vector2D( 0, -400 );

        p0handle = makeHandle(0x000000, startPoint.x,  startPoint.y);
        p1handle = makeHandle(0x000000, endPoint.x, endPoint.y);
        dp0handle = makeHandle(0, startPoint.x + startPointTangent.x,  startPoint.y + startPointTangent.y);
        dp1handle = makeHandle(0, endPoint.x + endPointTangent.x,  endPoint.y + endPointTangent.y);

        stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownOnControlPoint, false, 0, true);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveWithControlPoint, false, 0, true);
        stage.addEventListener(MouseEvent.MOUSE_UP,  onMouseUpWithControlPoint, false, 0, true);

        render();
    }

    private function render(): void {
        graphics.clear();
        canvas.graphics.clear();
        graphics.lineStyle(0, 2);
        graphics.moveTo(p0handle.x,  p0handle.y);
        graphics.lineTo(dp0handle.x,  dp0handle.y);

        graphics.moveTo(p1handle.x,  p1handle.y);
        graphics.lineTo(dp1handle.x,  dp1handle.y);

        hermiteRenderer.drawHermite( startPoint, endPoint, startPointTangent, endPointTangent, 0 );
    }

    private function makeHandle(color: uint, x: Number,  y: Number): Sprite {
        var handle: Sprite = new Sprite();
        with(handle.graphics) {
            beginFill(color);
            drawCircle(0, 0, 4);
            endFill();
        }

        handle.x = x;
        handle.y = y;

        canvas.addChild(handle);
        return handle;
    }

    private function onMouseDownOnControlPoint(e: MouseEvent): void {
        draggedHandle = e.target as Sprite;
    }

    private function onMouseMoveWithControlPoint(e: MouseEvent): void {
        if(draggedHandle) {
            draggedHandle.x = e.stageX;
            draggedHandle.y = e.stageY;

            if(draggedHandle == p0handle) {
                startPoint.x = p0handle.x;
                startPoint.y = p0handle.y;
                dp0handle.x = startPoint.x + startPointTangent.x;
                dp0handle.y = startPoint.y + startPointTangent.y;
            }

            if(draggedHandle == dp0handle) {
                startPointTangent.x = dp0handle.x - p0handle.x;
                startPointTangent.y = dp0handle.y - p0handle.y;
            }

            if(draggedHandle == p1handle) {
                endPoint.x = p1handle.x;
                endPoint.y = p1handle.y;
                dp1handle.x = endPoint.x + endPointTangent.x;
                dp1handle.y = endPoint.y + endPointTangent.y;
            }

            if(draggedHandle == dp1handle) {
                endPointTangent.x = dp1handle.x - p1handle.x;
                endPointTangent.y = dp1handle.y - p1handle.y;
            }

            render();
        }
    }

    private function onMouseUpWithControlPoint(e:MouseEvent): void {
        draggedHandle = null;
    }
}
}
