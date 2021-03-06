private ControlP5 cp5;
ControlFrame cf;

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 30);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet {  
  ControlP5 cp5;
  Object parent;
  PImage guiStats, guiGfx1, guiGfx2, guiGfx3, guiGfx4;
  int w, h;
  
  public void setup() {
    size(w, h);
    //frameRate(25);
    textSize(22);
    fill(0);
    
    cp5 = new ControlP5(this);
        
    cp5.setFont(createFont("Courier", 13));
    cp5.addSlider("pitchAmpThresh").setPosition(10, 30).setSize(120, 20).setRange(0.0, 0.3).setValue(0.02);
    cp5.addSlider("pitchMedian").setPosition(10, 60).setSize(120, 20).setRange(3, 20).setValue(7);
    cp5.addSlider("decayCoeff").setPosition(10, 90).setSize(120, 20).setRange(0.3, 0.9999).setValue(0.98);
    cp5.addSlider("ampThresh").setPosition(10, 120).setSize(120, 20).setRange(0, 0.3).setValue(0.12);
    cp5.addSlider("oscRate").setPosition(10, 150).setSize(120, 20).setRange(1, 100).setValue(30);
    cp5.addSlider("freqLerpRate").setPosition(10, 180).setSize(120, 20).setRange(0, 1).setValue(0.1);
    cp5.addSlider("ampLerpRate").setPosition(10, 210).setSize(120, 20).setRange(0, 1).setValue(0.1);
        
    cp5.addSlider("resolution").setPosition(10, 260).setSize(120, 20).setRange(10, 1024).setValue(gfxResolution);
    cp5.addSlider("nw").setPosition(10, 290).setSize(120, 20).setRange(1, 15).setValue(5);
    cp5.addSlider("nh").setPosition(10, 320).setSize(120, 20).setRange(1, 15).setValue(5);
    cp5.addSlider("rectSizeMult").setPosition(10, 350).setSize(120, 20).setRange(0.1, 3).setValue(1.2);
    cp5.addSlider("offset").setPosition(10, 380).setSize(120, 20).setRange(0, 100).setValue(30);
    cp5.addSlider("strokeWt").setPosition(10, 410).setSize(120, 20).setRange(0, 8).setValue(1);
    cp5.addSlider("alphF").setPosition(10, 440).setSize(120, 20).setRange(0, 255).setValue(20);
    cp5.addSlider("alphS").setPosition(10, 470).setSize(120, 20).setRange(0, 255).setValue(50);
    cp5.addSlider("fade").setPosition(10, 500).setSize(120, 20).setRange(0, 255).setValue(80);

    DropdownList d = cp5.addDropdownList("shaderSelection")
      .setPosition(10, 550).setSize(200, 300);
    d.setItemHeight(20);
    d.setBarHeight(20);
    d.captionLabel().set("shader");
    d.captionLabel().style().marginTop = 3;
    d.captionLabel().style().marginLeft = 3;
    d.valueLabel().style().marginTop = 3;
    for (int i=0; i<shaders.length; i++) {
      d.addItem(shaders[i], i);
    }
    
    
    cp5.addSlider("bitsMx").setPosition(10, 580).setSize(120, 20).setRange(0.01, 1.0).setValue(0.5);
    cp5.addSlider("bitsMy").setPosition(10, 610).setSize(120, 20).setRange(0.01, 1.0).setValue(0.5);
    cp5.addSlider("bitsFade").setPosition(10, 640).setSize(120, 20).setRange(0.01, 1.0).setValue(0.5);
    
    
    cp5.addSlider("outlinesMult").setPosition(10, 690).setSize(120, 20).setRange(1.0, 7.0).setValue(1.0);
    cp5.addSlider("outlinesPhase").setPosition(10, 720).setSize(120, 20).setRange(0.0, 10.0).setValue(0.0);
    cp5.addSlider("outlinesRad").setPosition(10, 750).setSize(120, 20).setRange(0.01, 1.0).setValue(0.9);
    cp5.addSlider("outlinesGive").setPosition(10, 780).setSize(120, 20).setRange(0.01, 1.0).setValue(0.1);
    cp5.addSlider("outlinesR").setPosition(10, 810).setSize(120, 20).setRange(0.01, 1.0).setValue(1.0);
    cp5.addSlider("outlinesG").setPosition(10, 840).setSize(120, 20).setRange(0.01, 1.0).setValue(1.0);
    cp5.addSlider("outlinesB").setPosition(10, 870).setSize(120, 20).setRange(0.01, 1.0).setValue(0.9);
    
    cp5.addSlider("fullR").setPosition(10, 910).setSize(120, 20).setRange(0, 255).setValue(255);
    cp5.addSlider("fullG").setPosition(10, 940).setSize(120, 20).setRange(0, 255).setValue(255);
    cp5.addSlider("fullB").setPosition(10, 970).setSize(120, 20).setRange(0, 255).setValue(0);
    
  }

  public void updateStats(PGraphics pgStats) {
    guiStats = pgStats.get();
  }
  
  public void updateGfx(PGraphics gfxRects, PGraphics gfxBits, PGraphics gfxOutline, PGraphics gfxFull) {
    guiGfx1 = gfxRects.get();
    guiGfx2 = gfxBits.get();
    guiGfx3 = gfxOutline.get();
    guiGfx4 = gfxFull.get();
  }
  
  public void draw() {
    background(36);
    try {
      image(guiStats, 300, 20);
      image(guiGfx1, 300, 300);
      image(guiGfx2, 560, 300);
      image(guiGfx3, 820, 300);
      image(guiGfx4, 1080, 300);
    } catch(Exception e) {
    }
    if (cp5.isVisible()) {
      pushStyle();
      fill(0, 200);
      rect(2, 6, 250, cf.height-12);
      popStyle();
      fill(255);
      text("fps: "+nf(applet.frameRate,2,1)+" ("+nf(this.frameRate,2,1)+")", cf.width-100, 22);
    }
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() {
    return cp5;
  }
  
  void controlEvent(ControlEvent theEvent) 
  {
    if      (theEvent.name().equals("pitchAmpThresh")) {
      sendOscMessage("/pitchAmpThresh", pitchAmpThresh);
    }
    else if (theEvent.name().equals("pitchMedian")) {
      sendOscMessage("/pitchMedian", pitchMedian);
    }
    else if (theEvent.name().equals("decayCoeff")) {
      sendOscMessage("/decayCoeff", decayCoeff);
    } 
    else if (theEvent.name().equals("ampThresh")) {
      ampThresh = theEvent.value();
    }
    else if (theEvent.name().equals("oscRate")) {
      sendOscMessage("/oscRate", oscRate);
    }
    else if (theEvent.name().equals("shaderSelection")) {
      idxShader = (int) theEvent.getValue();
      setupShader();
    } 
    else if (theEvent.name().equals("freqLerpRate")) {
      freqLerpRate = theEvent.value();
    }
    else if (theEvent.name().equals("ampLerpRate")) {
      ampLerpRate = theEvent.value();
    }
    
    
    else if (theEvent.name().equals("resolution")) {
      gfxResolution = (int) theEvent.value();
      if (frameCount > 1) {
        resetGfx = true;        
      }
    }
    else if (theEvent.name().equals("nw")) {
      nw = (int) theEvent.value();
      resetNoisyRects();
    }
    else if (theEvent.name().equals("nh")) {
      nh = (int) theEvent.value();
      resetNoisyRects();
    }
    else if (theEvent.name().equals("rectSizeMult")) {
      rectSizeMult = theEvent.value();
    }
    else if (theEvent.name().equals("offset")) {
      offset = (int) theEvent.value();
    }
    else if (theEvent.name().equals("strokeWt")) {
      strokeWt = (int) theEvent.value();
    }
    else if (theEvent.name().equals("alphF")) {
      alphF = (int) theEvent.value();
    }
    else if (theEvent.name().equals("alphS")) {
      alphS = (int) theEvent.value();
    }
    else if (theEvent.name().equals("fade")) {
      fade = (int) theEvent.value();
    }
    
    else if (theEvent.name().equals("bitsMx")) {
      bitsMx = theEvent.value();
    }
    else if (theEvent.name().equals("bitsMy")) {
      bitsMy = theEvent.value();
    }
    else if (theEvent.name().equals("bitsFade")) {
      bitsFade = theEvent.value();
    }

    else if (theEvent.name().equals("outlinesMult")) {
      outlinesMult = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesPhase")) {
      outlinesPhase = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesRad")) {
      outlinesRad = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesGive")) {
      outlinesGive = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesR")) {
      outlinesR = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesG")) {
      outlinesG = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesB")) {
      outlinesB = theEvent.value();
    }
    
    else if (theEvent.name().equals("fullR")) {
      fullR = theEvent.value();
    }
    else if (theEvent.name().equals("fullG")) {
      fullG = theEvent.value();
    }
    else if (theEvent.name().equals("fullB")) {
      fullB = theEvent.value();
    }
  }
}


