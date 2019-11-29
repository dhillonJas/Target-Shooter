public abstract class PowerUp
{
  public abstract void effect();
}

public class AddTarget extends PowerUp
{
  public void effect()
  {
    blueShot--;
  }
}

public class AddBall extends PowerUp
{
  public void effect()
  { 
    missedShot--; 
  }
}

public class SlowSpeed extends PowerUp
{
  public void effect(){}
}

public class RecoverAll extends PowerUp
{
  public void effect()
  {
    missedShot = 0;
    blueShot = 0;
  }
}
