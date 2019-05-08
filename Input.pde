void keyPressed() {
  if (key>=0&&key<255) {
    keys[key]=true;
  }
}
void keyReleased() {
  if (key>=0&&key<255) {
    keys[key]=false;
  }
}

void setSliders(){
  cp5=new ControlP5(this);
  cp5.addSlider("FOV").setPosition(50,50).setSize(200,20).setRange(0,2*PI);
  cp5.getController("FOV").setValue(source.fov);
  
  cp5.addSlider("APERTURE").setPosition(50,100).setSize(200,20).setRange(0,100);
  cp5.getController("APERTURE").setValue(source.aperture);
  
  cp5.addSlider("REFLECTIONS").setPosition(50,150).setSize(200,20).setRange(0,4).snapToTickMarks(true).setNumberOfTickMarks(5);
  cp5.getController("REFLECTIONS").setValue(source.reflections);
  
  cp5.addSlider("N RAYS").setPosition(50,200).setSize(200,20).setRange(0,300).snapToTickMarks(true).setNumberOfTickMarks(301);
  cp5.getController("N RAYS").setValue(source.nRays);
  
  cp5.addSlider("N SCATTERS").setPosition(50,250).setSize(200,20).setRange(1,10).snapToTickMarks(true).setNumberOfTickMarks(10);
  cp5.getController("N SCATTERS").setValue(source.scatters);
  
  cp5.addSlider("FOV SCATTERS").setPosition(50,300).setSize(200,20).setRange(0,PI);
  cp5.getController("FOV SCATTERS").setValue(source.scatters);
  
  cp5.addSlider("LUMINOSITY").setPosition(50,350).setSize(200,20).setRange(0,10000);
  cp5.getController("LUMINOSITY").setValue(source.lum);
  
  
}

void readInputs(){
  if (keyPressed) {
    if (keys['d']) {
      source.rot(0.05);
    }
    if (keys['a']) {
      source.rot(-0.05);
    }
    if (keys['w']) {
      source.move(3);
    }
    if (keys['s']) {
      source.move(-2);
    }
  }
  
  
  float newFov=cp5.getController("FOV").getValue();
  source.fov=newFov;
  float newAperture=cp5.getController("APERTURE").getValue();
  source.setAperture(newAperture);
  int newRef=int(cp5.getController("REFLECTIONS").getValue());
  source.setReflections(newRef);
  int newRays=int(cp5.getController("N RAYS").getValue());
  source.nRays=newRays;
  int newSc=int(cp5.getController("N SCATTERS").getValue());
  source.scatters=newSc;
  float newFovSc=cp5.getController("FOV SCATTERS").getValue();
  source.fovScatter=newFovSc;
  float newLum=cp5.getController("LUMINOSITY").getValue();
  source.lum=newLum;
}
