package sprites;

import kha.Color;

import n4.entities.NSprite;
import n4.NGame;
import n4.math.NPoint;

import n4.util.NColorUtil;

import n4.effects.particles.NParticleEmitter;

class Player extends NSprite {
    private var speed:Float = 10;
    private var maxVelocityTimer:Float = 5;
    public var spedUp:Bool = false;
    public function new(?X:Float = 0, ?Y:Float = 0) {
        // Define a constructor for Player matching the base constructor
        super(X, Y);

        // Create a 20x20 blue square as the image
		makeGraphic(20, 20, Color.Red);

        // set movement drag (this is like friction)
        drag.set(5, 5);
        // set a maximum velocity
        maxVelocity.set(200, 200);
		angularVelocity = Math.PI / 2;
    }

    override public function update(dt:Float) {
        // particles
        Registry.PS.emitter
			.emitSquare(x + 10, y + 10, 8, NParticleEmitter.velocitySpread(50),
				NColorUtil.randCol(0.9, 0.1, 0.1, 0.1),
				0.3
			);

        // call our movement function
        movement();

        maxVelocityTimer += dt;
        // call the base update
        super.update(dt);
    }

    private function movement() {
        var up:Bool = false;
        var down:Bool = false;
        var left:Bool = false;
        var right:Bool = false;

        up = NGame.keys.pressed(["UP", "W"]);
        down = NGame.keys.pressed(["DOWN", "S"]);
        left = NGame.keys.pressed(["LEFT", "A"]);
        right = NGame.keys.pressed(["RIGHT", "D"]);

        var speedUp:Bool = NGame.keys.pressed(["SPACE", " "]);

        if (speedUp && maxVelocityTimer > 5) {
            maxVelocity.set(400, 400);

            for (i in 0...30) 
                Registry.PS.emitter
                    .emitSquare(x + 10, y + 10, 8, NParticleEmitter.velocitySpread(300),
                    NColorUtil.randCol(0.9, 0.9, 0.1, 0.3),
                    0.3
                );

            maxVelocityTimer = 0;
            spedUp = true;
        }

        if (spedUp && maxVelocityTimer > 1) {
            maxVelocity.set(200, 200);
            spedUp = false;
        }

        if (up || down || left || right)
        {
            // Cancel double directions
            if (up && down)
                up = down = false;
            if (left && right)
                left = right = false;
            var mA = 0;
            // movement angle; this will keep total speed uniform
            // even when moving diagonally
            if (left || right || up || down)
            {
                if (up)
                {
                    mA = -90;
                    if (left)
                    {
                        mA -= 45;
                    }
                    if (right)
                    {
                        mA += 45;
                    }
                }
                else if (down)
                {
                    mA = 90;
                    if (left)
                    {
                        mA += 45;
                    }
                    if (right)
                    {
                        mA -= 45;
                    }
                }
                else if (left)
                {
                    mA = 180;
                }
                else if (right)
                {
                    mA = 0;
                }
            }
            var movementVel = new NPoint(speed, 0);
            velocity.addPoint(movementVel.rotate(new NPoint(0, 0), mA));
        }
    }
}