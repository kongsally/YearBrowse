import de.voidplus.leapmotion.*;
import processing.video.*;
LeapMotion leap;
import http.requests.*;
Capture cam;
color c;
int prevYear = 1800;
int currYear = year();
float x;
float y;

void setup() {
  size(800,600);
  
  cam = new Capture(this, width, height);
  cam.start();
  
  PFont ubuntu;
  ubuntu = loadFont("Ubuntu-Bold-48.vlw");
  textFont(ubuntu);
  
  leap = new LeapMotion(this).withGestures();
  frameRate(30);
}

void draw() {
   if (cam.available()) {
    cam.read();
  } 
  
  image(cam, 0, 0);
  
  if(leap.getHands().size() != 0) {
   Hand hand = leap.getHands().get(0);
   
    int     hand_id          = hand.getId();
    PVector hand_position    = hand.getPosition();
    PVector hand_stabilized  = hand.getStabilizedPosition();
    PVector hand_direction   = hand.getDirection();
    PVector hand_dynamics    = hand.getDynamics();
    float   hand_roll        = hand.getRoll();
    float   hand_pitch       = hand.getPitch();
    float   hand_yaw         = hand.getYaw();
    float   hand_time        = hand.getTimeVisible();
    PVector sphere_position  = hand.getSpherePosition();
    float   sphere_radius    = hand.getSphereRadius();
    
    
   float[] handPos = hand_position.array();
     x = map(handPos[0], 200, 600, 0, width); 
     y = map(handPos[1], 100, 600, 0, height);
    float r = 50;
    ellipse(width - x, y, r, r);
    
    int randomNum = (int) map(600-handPos[1], 0, 600, 1500, year() + 10);  
    currYear = randomNum - (randomNum%10);
  
    if(prevYear != currYear) {

          String url = "http://numbersapi.com/" + 
                        currYear + "/year?fragment";
          GetRequest get = new GetRequest(url);
          get.send();
          String fact = get.getContent();
          
          fill(255);
          textSize(64);
          text("Year: " + currYear, 80, 100);  
          textSize(32); 
          text(fact, 50, 150, width-275, height - 100);
     
    }  
    prevYear = currYear;
     
  }
}

