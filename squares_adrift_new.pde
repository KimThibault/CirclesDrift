

void setup() {
  size(640, 360);
  frameRate(10);
  colorMode(RGB,255);
  background(0,0,0,50); 
}

// Caractéristiques des carres
// N.B. Le centre de coordonnées est en haut à gauche. 


int n_bubbles = 8;
float range = 4;

float[] x = new float[n_bubbles];
float[] y = new float[n_bubbles];
float[] width = new float[n_bubbles];
float[] drift_rate = new float[n_bubbles];
float[] x_prev = new float[n_bubbles];
float[] y_prev = new float[n_bubbles];
float[] drift_rate_prev = new float[n_bubbles];


void draw(){
  noStroke();  
      
  // loop on squares
  for (int i=0;i<n_bubbles;i++){
         
    // store info from previous frame
    drift_rate_prev[i] = drift_rate[i];
    x_prev[i] = x[i];
    y_prev[i] = y[i];
    
    
    
    // draw in black over previous frame with thicker lines to erase properly
    stroke(0,0,0);
    fill(0);
    strokeWeight(1.2);
    rect(x_prev[i], y_prev[i], width[i], width[i]); 
      

    // move squares  
    x[i] = (x[i]  - drift_rate[i]); 
    y[i] = (y[i]  - drift_rate[i]);  
    
     
    if ((y_prev[i] < 0) || ( y[i] <= 0 )) {    // square has left domain
       // inject new bubble 
       x[i] = random(640);
       width[i] = random(80); 
       y[i] = x[i]/2 + width[i]*(random(range)-range/2);
       drift_rate[i] = 5.;
    }  
    
   
    
    // draw squares
    
    stroke(255,255,255);
    noFill();
    strokeWeight(1);
    rect(x[i],y[i],width[i],width[i]); 
    
   
    
   
  }

}