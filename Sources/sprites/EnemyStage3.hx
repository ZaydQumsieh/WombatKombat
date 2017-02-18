/*package sprites;

import kha.Color;

import n4.entities.NSprite;
import n4.NGame;

import n4.math.NPoint;
import n4.math.NVector;
import n4.math.NAngle;

import n4.util.NColorUtil;

import n4.effects.particles.NParticleEmitter;

class EnemyStage3 extends Enemy {
    private var speedInaccuracy:Float = Math.random();
    private var speed:Float = 5;

    public function new(?X:Float = 0, ?Y:Float = 0) {
        
        // Define a constructor for Player matching the base constructor
        super(X, Y);

        // Create a 20x20 blue square as the image
		makeGraphic(40, 40, Color.fromFloats(0.9, 0.9, 0.1));

        // set movement drag (this is like friction)
        drag.set(Math.random() * 5 + 30, Math.random() * 5 + 30);
        // set a maximum velocity
        maxVelocity.set(Math.random() * 50 + 75, Math.random() * 50 + 75);

		angularVelocity = Math.PI / 2;
    }

    override public function update(dt:Float) {
        // call our movement function
        movement();
        // call the base update
        super.update(dt);

        Registry.PS.emitter
            .emitSquare(x + 2.5, y + 2.5, 16, NParticleEmitter.velocitySpread(width * 2),
				NColorUtil.randCol(0.9, 0.9, 0.1, 0.1),
				0.3
			);
        
        makeGraphic(width - 0.1, height - 0.1, Color.fromFloats(0.9, 0.9, 0.1));

       if (width == 10) {
            var shploo = new EnemyStage2(x + 5, y + 5);
			add(shploo);
            var sclood = new EnemyStage2(x - 5, y - 5);
			add(sclood); 

            destroy();
        }
    }

    private function movement() {
        var player = Registry.PS.player;

        // move toward player
        var posVelocity = new NVector(x, y).subtractPoint(new NPoint(player.x, player.y))
            .toVector().normalize().scale(5 * speedInaccuracy + speed)
            .rotate(new NPoint(0, 0), 180);
        velocity.add(posVelocity.x, posVelocity.y);
    }

	private function acquireTarget():EnemyStage1 {
		var target:EnemyStage1 = null;
		var minDistance = 2;
		return target;
	}
}*/