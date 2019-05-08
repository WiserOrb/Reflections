class Ray{
  float dist;
  float angle;
  PVector pos;
  float lum;
  float disp;
  float angInc;
  Ray(PVector pos,float dist,float angle,float lum,float disp,float angInc){
    this.dist=dist;
    this.angle=angle;
    this.pos=pos;
    this.lum=lum;
    this.disp=disp;
    this.angInc=angInc;
  }
  
  
  void show(){
    lum=max(lum,1);
    stroke(255,lum);
    strokeWeight(10);
    float x=pos.x+dist*cos(angle);
    float y=pos.y+dist*sin(angle);
    line(pos.x,pos.y,x,y);
  }
  
  float getX(){
    return getX(1);
  }
  float getY(){
    return getY(1);
  }
  
  float getX(float scale){
    return pos.x + dist*cos(angle)*scale;
  }
  
  float getY(float scale){
    return pos.y + dist*sin(angle)*scale;
  }
}
