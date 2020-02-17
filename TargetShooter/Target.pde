public class Target
{
  private PVector position = new PVector();
  public boolean blue;
  private PowerUp powerup;
  
  public Target(int z)
  {
    int side = (int)random(2);
    position.x = 1;
    if(side % 2 == 0)
      position.x = -1;
    position.y = 0.21;
    position.z = z;
    int civ = (int)random(2);
    blue = true;
    if(civ % 2 == 0)
      blue = false;
    
    //to generate a random powerup
    int power = (int)random(100);
    if(power < 30)
    {
      if(power < 5)
        powerup = new RecoverAll();
      else if(power < 15)
        powerup = new SlowSpeed();
      else if(power < 25)
        powerup = new AddBall();
      else 
        powerup = new AddTarget();
    }
  }
  
  public int getZ()
  {
    return (int)position.z;
  }
  
  public void addRemove()
  {
    targets.remove(this);
    targets.add(new Target(targetZ));
    targetZ -= (int)random(1,3);
  }
  
  public void showTarget()
  {
    pushMatrix();
    translate(position.x, position.y, position.z);
    beginShape(QUAD);
    if(blue)
      fill(35,235,195);
    else if(powerup != null)
      fill(powerup.colour());
    else
      fill(220,20,60);
    vertex(-0.2,1,0,0,0);
    vertex(0.2,1,0,1,0);
    vertex(0.2,-1,0,1,1);
    vertex(-0.2,-1,0,0,1);
    endShape();
    popMatrix();
  }
  
  public void notVisible()
  {  
    if(currPos[2] < position.z)
      addRemove();
  }
}
