public abstract class PowerUp
{
  public abstract void effect();
  public abstract color colour();
}

public class AddTarget extends PowerUp
{
  public void effect()
  {
    blueShot--;
  }

  public color colour()
  {
    return color(255, 203, 197);
  }
}

public class AddBall extends PowerUp
{
  public void effect()
  { 
    missedShot--;
  }

  public color colour()
  {
    return color(205, 255, 255);
  }
}

public class SlowSpeed extends PowerUp
{
  public void effect() 
  {
    speed = 0.05;
  }

  public color colour()
  {
    return color(255,252,139);
  }
}

public class RecoverAll extends PowerUp
{
  public void effect()
  {
    missedShot = 0;
    blueShot = 0;
  }

  public color colour()
  {
    return color(165, 214, 16);
  }
}
