class Source {
  int nRays;
  float fov;
  PVector pos;
  float heading;
  int reflections=0;
  float lum=255;
  float aperture=20;
  float baseHeading;
  int scatters=1;
  float fovScatter=1;

  Source(PVector pos, int nRays, float fov, float heading) {
    this.pos=pos;
    this.fov=fov;
    this.nRays=nRays;
    this.heading=heading;
    this.baseHeading=heading;
  }

  void show() {
    strokeWeight(10);
    stroke(255);
    point(pos.x, pos.y);
  }

  ArrayList<Ray> getRays(ArrayList<Wall> walls) {
    ArrayList<Ray> rays=new  ArrayList<Ray>();
    for (int i=0; i<nRays; i++) {
      Ray closest=null;
      Wall closestWall=null;
      float angle= heading + map(i, -1, nRays-1, -fov/2, fov/2);
      //float angle=heading+random(-fov/2,fov/2);
      
      float rayx=pos.x+map(i,-1,nRays,-aperture/2,aperture/2)*sin(-(baseHeading));
      float rayy=pos.y+map(i,-1,nRays,-aperture/2,aperture/2)*cos(-(baseHeading));
      for (Wall wall : walls) {
        float dx=wall.x1-wall.x2;
        float dy=wall.y1-wall.y2;
        float dist=((rayx-wall.x2)*dy-(rayy-wall.y2)*dx)/( sin(angle)*dx-cos(angle)*dy);
        float x=rayx+cos(angle)*dist;
        float y=rayy+sin(angle)*dist;

        if (dist>0&&
          (x-wall.x1)*(x-wall.x2)<1&&(y-wall.y1)*(y-wall.y2)<1) {
          if (closest==null) {
            closest=new Ray(new PVector(rayx,rayy), dist, angle,lum/nRays,fov/nRays,wall.getAngle());
            closestWall=wall;
          } else if (closest.dist>dist) {
            closest=new Ray(new PVector(rayx,rayy), dist, angle,lum/nRays,fov/nRays,wall.getAngle());
            closestWall=wall;
          }
        }
      }
      rays.add(closest);
      if(closest!=null&&reflections>0){
        float h=2*closestWall.getAngle()-closest.angle;
        Source source=new Source(new PVector(closest.getX(0.99),closest.getY(0.99)),scatters, fovScatter,h);
        source.setReflections(reflections-1);
        source.setLum(closest.lum);
        source.setAperture(2*closest.dist*sin(closest.disp/2));
        source.setBaseHeading(PI/2+closestWall.getAngle());
        source.fovScatter=fovScatter;
        ArrayList<Ray> rays2=source.getRays(walls);
        for(Ray ray:rays2){
          rays.add(ray);
        }
        
      }
    }
    return rays;
  }
  
  void move(float prm){
    pos.add(new PVector(prm*cos(heading),prm*sin(heading)));
  }
  void rot(float prm){
    heading+=prm;
    baseHeading+=prm;
  }
  
  void setReflections(int reflections){
    this.reflections=reflections;
  }
  void setLum(float lum){
    this.lum=lum;
  }
  void setAperture(float ap){
    this.aperture=ap;
  }
  void setBaseHeading(float h){
    this.baseHeading=h;
  }
}
