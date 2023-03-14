public Location[] clinics;
public Location here;
public Location closest;
public boolean clicking;
public int timer;
public int fun;
public String input;
private PImage map;
  
public void setup(){
  fun = 0;
  size(600, 600);
  input = "";
  map = loadImage("map.jpg");
  
  String[] clinicStrings = loadStrings("clinics.txt");
  clinics = new Location[clinicStrings.length];
  for(int i = 0; i < clinicStrings.length; i++){
    String toLoad = clinicStrings[i];
    int divide1 = toLoad.indexOf("/");
    int divide2 = toLoad.indexOf("/", divide1 + 1);
    int divide3 = toLoad.indexOf("/", divide2 + 1);
    clinics[i] = new Location(toLoad.substring(divide2 + 1, divide3), toLoad.substring(divide3 + 1), num(toLoad.substring(0, divide1)), num(toLoad.substring(divide1 + 1, divide2)));
  }
}

public void draw(){
  background(255);
  textSize(15);
  fill(0);
  textAlign(LEFT, TOP);
  if(closest == null){
    if(clicking){
      text("Click on your current location", 5, 5);
      image(map, 0, 120, width, height - 120);
      for(Location c : clinics){c.display(0);}
    } else {
      timer++; timer %= 80;
      text("Input Lattitude and Longitude (decimals, with a single space in between):\nPress Enter while leaving the lattitude and longitude empty if you just want to click on the map.", 5, 5);
      textAlign(LEFT, BOTTOM);
      if(timer < 40){text(input + "|", 5, height - 5);} else {text(input, 5, height - 5);}
    }
  } else {
    text("Go to " + closest.getName() + "\n" + closest.getAddress() + "\nLattitude: " + closest.getLattitude() + "\nLongitude: " + closest.getLongitude(), 5, 5);
    image(map, 0, 120, width, height - 120);
    for(Location c : clinics){
      if(c != closest){
        c.display(0);
      }
    }
    closest.display(1);
    here.display(2);
  }
}

public double num(String s){
  if(s.length() == 0){
    return 0;
  } else if(s.charAt(0) == '-'){
    return -num(s.substring(1));
  } else if(s.charAt(0) == '.'){
    double ans = 0;
    for(int i = 1; i < s.length(); i++){
      ans += Math.pow(10, -i) * digit(s.charAt(i));
    }
    return ans;
  } else if(s.indexOf(".") == -1){
    return 10*num(s.substring(0, s.length() - 1)) + digit(s.charAt(s.length() - 1));
  } else {
    int i = s.indexOf(".");
    return num(s.substring(0, i)) + num(s.substring(i));
  }
}

public int digit(char c){
  if(c == '0'){return 0;}
  else if(c == '1'){return 1;}
  else if(c == '2'){return 2;}
  else if(c == '3'){return 3;}
  else if(c == '4'){return 4;}
  else if(c == '5'){return 5;}
  else if(c == '6'){return 6;}
  else if(c == '7'){return 7;}
  else if(c == '8'){return 8;}
  else if(c == '9'){return 9;}
  else {return -1;}
}

public void enter(){
  if(closest == null){
    if(input.trim().equals("")){
      clicking = true;
    } else {
      int divide = input.indexOf(" ");
      calculateForLocation(num(input.substring(0, divide)), num(input.substring(divide + 1)));
    }
  }
}

public void calculateForLocation(double lattitude, double longitude){
  here = new Location("Your Location", "Do you really expect me to know your address?", lattitude, longitude);
  double bestScore = here.angleTo(clinics[0]);
  closest = clinics[0];
  for(int i = 1; i < clinics.length; i++){
    double score = here.angleTo(clinics[i]);
    if(score < bestScore){
      bestScore = score;
      closest = clinics[i];
    }
  }
  timer = 0; //Change meaning of timer to be an indexer
}

public void easterEgg(){
  fun++;
  if(fun == 0){here.setAddress("Do you really expect me to know your address?");}
  else if (fun == 1){here.setAddress("I might not know your address, but did you know that Ness is Sans?");}
  else if (fun == 2){here.setAddress("If I knew your address, that would be creepy, wouldn't it?");}
  else if (fun == 3){here.setAddress("Fortunately, I don't know your address. I'm too lazy to calculate it.");}
  else if (fun == 4){here.setAddress("Shouldn't you be finding an abortion clinic?");}
  else if (fun == 5){here.setAddress("This message seems like a waste of your time.");}
  else if (fun == 6){here.setAddress("It's my fault for writing it, I guess.");}
  else if (fun == 7){here.setAddress("I'll stop wasting your time.");}
  else if (fun == 8){here.setAddress("Have a nice day.");}
  else if (fun == 9){here.setAddress("Some address.");}
}

public boolean isInNum(char c){return (c == '0') || (c == '1') || (c == '2') || (c == '3') || (c == '4') || (c == '5') || (c == '6') || (c == '7') || (c == '8') || (c == '9') || (c == '.') || (c == ' ') || (c == '-');}

public void keyPressed(){
  if(key == CODED){
    if(keyCode == RETURN || keyCode == ENTER){enter();}
    else if(closest != null){
      if(keyCode == LEFT){timer--; if(timer < 0){timer = clinics.length;} if(timer == 0){easterEgg();}}
      else if(keyCode == RIGHT){timer++; if(timer > clinics.length){timer = 0; easterEgg();}}
    }
  } else {
    if(key == BACKSPACE || key == DELETE){if(input.length() > 0){input = input.substring(0, input.length() - 1);} timer = 0;}
    else if(key == '\n'){enter();}
    else if(isInNum(key)){input += key; timer = 0;}
  }
}

public void mousePressed(){if(clicking){calculateForLocation(42 - 14.0*(mouseY - 120)/(height - 120), 18.0*mouseX/width -120);}}
