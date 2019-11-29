/*
AUTHOR -  Jasdeep Singh

INFO -    A simple game where you try to take down as many red targets
          as possible without missing not more than three shots and
          without shooting not more than blue targets.
          
HITZONE - The area from which you can take down the targets is shown 
          by the red lines when the game is paused. To shoot the
          targets one will have to click outside these lines. The 
          closer to the line, the lesser points you get. The closer 
          to the border, the more points you get.
          
POINTS -  The points are added for each red target hit and deducted 
          two time for each blue target hit. The points are shown at 
          the top left screen when the game is paused or over. 
          
CREDITS - The pictures used in showing points on the screen.
          Author - Coloringbuddymike
*/
PImage[] numbers = new PImage[10];
float [] currPos = { 0, 0, 0 };
final int VISIBLE = 8;
void setup() {
  //frameRate(1);
  size(1280, 720, P3D);
  surface.setResizable(true);
  hint(DISABLE_OPTIMIZED_STROKE);
  strokeWeight(3.5);
  level();
  textureMode(NORMAL);
  for(int i = 0; i < numbers.length; i++)
    numbers[i] = loadImage("assets/" + i + ".png");
}
ArrayList<Target> targets = new ArrayList<Target>();
Bullet bullet;
boolean start = false;

float speed = 0.08;
int points = 0;
float ballX = currPos[0], ballZ = currPos[2];
int blueShot = 0, missedShot = 0;
int targetZ = -10;
void draw() {
  resetMatrix();

  frustum(-float(width)/height, float(width)/height, 1, -1, 2, 9);
  //frustum(-1,1, 1, -1, 2, 9);
  clear();
  //background(0,0,0); //<>//
  
  // view
  translate(0, -1, -2);
  translate(-currPos[0], 0, -currPos[2]);
  //println(position[0], position[1], position[2]);
  
  for (int z = (int)(currPos[2]) - VISIBLE; z <= 0; z++) 
  {      
      // checkerboard
      if (z % 2 == 0) 
        fill(0,0,128);
      else 
        fill(255,255,127);
       
      beginShape(QUADS);
      vertex(-.8, 0, z-0.5);
      vertex(+.8, 0, z-0.5);
      vertex(+.8, 0, z+0.5);
      vertex(-.8, 0, z+0.5);
      endShape();
  }
  //showing the targets
  for(int i = 0; i < targets.size(); i++)
     targets.get(i).showTarget();
  
  //if the target is behind the player
  targets.get(0).notVisible();
  
  //showing the bullet and checking if it hits anything  
  if(bullet != null)
  {
    bullet.show();
    bullet.hit();
  }
  
  if(start)
    currPos[2] -= speed;
  else
    paused();
    
  if(blueShot == 3 || missedShot == 3)
    start = false; //<>//
}

void keyPressed() {
  switch (key) {
  case 's':
    if(missedShot < 3 && blueShot < 3)
      start = !start;
    break;
  case 'r':
    currPos[2] = 0;
    ballX = currPos[0];
    ballZ = currPos[2];
    targets.clear();
    targetZ = -10;
    level();
    blueShot = 0;
    missedShot = 0;
    points = 0;
    break;
  }
}

void mousePressed()
{
  if(start)
  {
      ballX = 2.0 * mouseX / width - 1;
      ballZ = currPos[2];
      bullet = new Bullet(ballX, ballZ);
  }
}

void level() //<>//
{
   for(int i = 0; i < VISIBLE; i++)
   {
     targets.add(new Target(targetZ));
     targetZ = targets.get(i).getZ() - (int)random(1,3);
   }
}

void paused()
{
  stroke(219,0,0);
  line(-1.15,2,currPos[2],-1.15,0,currPos[2]);
  line(1.15,2,currPos[2],1.15,0,currPos[2]);
  stroke(0);
  //converting the points to a string and using the
  //appropriate texture from the array
  String pts = nfs(points,5);
  int index = 5;
  for(float i = 0; i < 0.65; i += 0.13)
  {
    beginShape(QUADS);
    texture(numbers[pts.charAt(index--) - 48]);
    vertex(-1.26 - i, 2,currPos[2],0,0);
    vertex(-1.26 - i, 1.8,currPos[2],0,1);
    vertex(-1.13 - i, 1.8,currPos[2],1,1);
    vertex(-1.13 - i, 2,currPos[2],1,0);
    endShape();
  }
  int num = 0;
  for(float i = 0; num < 3 - blueShot; i += 0.2)
  {
    beginShape(QUAD);
    fill(35,235,195);
    vertex(-1.33 - i, 1.2,currPos[2]);
    vertex(-1.33 - i, 1,currPos[2]);
    vertex(-1.2 - i, 1,currPos[2]);
    vertex(-1.2 - i, 1.2,currPos[2]);
    num++;
    endShape();
  }
  
  //num = 0;
  ////pushMatrix();
  //for(int i = 0; num < 3; i++)
  //{
  //  translate(-1.33,0.6, currPos[2]);      
  //  stroke(255,0,0);
  //  sphere(0.1);
  //  stroke(0,0,0);
  //}
  ////popMatrix();
}
