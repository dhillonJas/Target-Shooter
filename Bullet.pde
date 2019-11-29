public class Bullet
{
    private PVector position = new PVector();

    public Bullet(float x,float z)
    {
      position.x = x;
      position.z = z;
    }
    
    public void show()
    {
      position.z -= 0.9;
      pushMatrix();
      translate(position.x,0.4,position.z);
      stroke(255,0,0);
      sphere(0.15);
      stroke(0,0,0);
      popMatrix();
    }
    
    public void hit()
    {
      float xVal = position.x;
      if(position.x < 0)
        xVal = -1 * xVal;
        
      boolean stay = true;
      float point = 0;
      for(int i = 0; i < targets.size() && stay; i++)
      {
        //the ball hits a target
        if(xVal >= 0.65 && (int)position.z == (int)targets.get(i).position.z && nfp(position.x,1,2).charAt(0) == nfp(targets.get(i).position.x,1,2).charAt(0))
        {
          //no more bullet
          bullet = null;
          //the position of bullet
          if(xVal >= 0.95)  point = 0;
          else if(xVal >= 0.9)  point = 5;
          else if(xVal >= 0.85)  point = 15;
          else if(xVal >= 0.8)  point = 20;
          else if(xVal >= 0.75)  point = 30;
          else if(xVal >= 0.7)  point = 35;
          else if(xVal >= 0.65)  point = 45;
          
          //how the ball affects the points
          if(targets.get(i).blue)
          {
            if(points > 0)
              points -= xVal * 200 - point;
            blueShot++;
          }
          else
            points += xVal * 100 - point;
  
          //removing the hit target and adding another one
          targets.get(i).addRemove();
          //if the target is a powerup
          if(targets.get(i).powerup != null)
            targets.get(i).powerup.effect();
          stay = false;
        }
      }
      //if the ball misses any target
      if(position.z < targetZ && stay)
      {
        bullet = null;
        missedShot++;
      }
    }
}
