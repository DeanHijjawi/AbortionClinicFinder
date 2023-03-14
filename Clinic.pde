public class Location{
  private String name;
  private String address;
  protected double lattitude;
  protected double longitude;
  
  public Location(String name, String address, double lattitude, double longitude){
    this.name = name;
    this.address = address;
    this.lattitude = Math.PI * lattitude/180;
    this.longitude = Math.PI * longitude/180;
  }
  
  public String getName(){return name;}
  public String getAddress(){return address;}
  public void setAddress(String s){address = s;}
  public double getLattitude(){return (180*lattitude/Math.PI);}
  public double getLongitude(){return (180*longitude/Math.PI);}
  
  public double angleTo(Location other){
    double l1 = this.lattitude;
    double l2 = other.lattitude;
    double ld = this.longitude - other.longitude;
    return Math.acos(Math.sin(l1)*Math.sin(l2) + Math.cos(l1)*Math.cos(l2)*Math.cos(ld));
  }
  
  public void display(int type){
    float x = (float) (width*(getLongitude() + 120)/(120 - 102));
    float y = (float) (120 + (height - 120)*(42 - getLattitude())/(42 - 28));

    if(type == 0){
      fill(0);
      ellipse(x, y, 5, 5);
    } else if(type == 1){
      fill(0, 255, 0);
      ellipse(x, y, 5, 5);
    } else {
      fill(255, 0, 0);
      ellipse(x, y, 5, 5);
    }
    
    if(closest != null && (timer == 0 && this == here) || (timer != 0 && timer <= clinics.length && this == clinics[timer - 1])){
      textAlign(CENTER, TOP);
      textSize(10);
      text(name, x, y);
      fill(0);
      textSize(15);
      textAlign(LEFT, BOTTOM);
      text(name + "\n" + address, 5, height - 5);
    }
  }
}
