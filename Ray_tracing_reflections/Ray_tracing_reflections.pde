import controlP5.*;
ControlP5 cp5;

Source source;
ArrayList<Wall> walls;
int sceneX=800;
int sceneY=800;
boolean[] keys;
void setup() {
  keys=new boolean[255];
  int nWalls=5;
  size(800, 800,P2D);
  source=new Source(new PVector(sceneX/2, sceneY/2), 125, 0.51, 0);
  walls=new ArrayList<Wall>();
  for (int i=0; i<nWalls; i++) {
    float x1=random(0, sceneX);
    float y1=random(0, sceneY);
    float x2=random(0, sceneX);
    float y2=random(0, sceneY);
    walls.add(new Wall(x1, y1, x2, y2));
  }
  walls.add(new Wall(0, 0, sceneX, 0));
  walls.add(new Wall(sceneX, 0, sceneX, sceneY));
  walls.add(new Wall(0, sceneY, 0, 0));
  walls.add(new Wall(0, sceneY, sceneX, sceneY));
  source.setReflections(1);
  source.setLum(2000);
  source.setAperture(20);
  source.scatters=20;
  
  setSliders();
}

void draw() {
  readInputs();
  
  background(0);
  
  //source.pos.x=mouseX;
  //source.pos.y=mouseY;
  source.show();
  for (Wall wall : walls) {
    wall.show();
  }
  ArrayList<Ray> rays;
  rays=source.getRays(walls);
  for (Ray ray : rays) {
    if (ray!=null) {
      ray.show();
      
    }
  }
}
