// Cercles qui apparaissent, diminuent de rayon et se 
// déplacent. 


void setup() {
  size(640, 360);
  frameRate(10);
  colorMode(RGB,255);
  background(0,0,0,50); 
}

// Caractéristiques des cercles
// N.B. Le centre de coordonnées est en haut à gauche. 

//List<Double> data = new Continuous(5, 2.5).generate(1000);

int n_bubbles = 8;
int n_trailing = 5; // actually number of trailing + lead bubbles

float[] cx = new float[n_bubbles];
float[][] cy = new float[n_bubbles][n_trailing];
float[][] width_ellipse = new float[n_bubbles][n_trailing];
float[] drift_rate = new float[n_bubbles];
float[] cx_prev = new float[n_bubbles];
float[][] cy_prev = new float[n_bubbles][n_trailing];
float[][] width_ellipse_prev = new float[n_bubbles][n_trailing];
float[] drift_rate_prev = new float[n_bubbles];
float[][] trailing_dist = new float[n_bubbles][n_trailing];

float shrink_rate = 1; 
int opacity;


void draw(){
  noStroke();  
      
  // loop on circles
  for (int i=0;i<n_bubbles;i++){
         
    // store info from previous frame
    drift_rate_prev[i] = drift_rate[i];
    cx_prev[i] = cx[i];
    cy_prev[i][0] = cy[i][0];
    
    // define trailing bubble positions and sizes, and store info from previous frame for trailing bubbles
    trailing_dist[i][0]    = 0;
    for (int j=1;j<n_trailing;j++){
      cy_prev[i][j] = cy[i][j];
      width_ellipse[i][j] = sqrt((1-0.1*j))*width_ellipse[i][0];
      trailing_dist[i][j] = 1.2*j* width_ellipse[i][1];
      cy[i][j]            = cy[i][0] + trailing_dist[i][j];
    }
    
    
    // draw in black over previous frame with thicker lines to erase properly
    for (int j=0;j<n_trailing;j++){
      stroke(0,0,0);
      fill(0);
      strokeWeight(2);
      ellipse(cx_prev[i], cy_prev[i][j], width_ellipse[i][j], width_ellipse[i][j]); 
    }        
   
    
    // move bubble
    drift_rate[i]  = 10. / sqrt(width_ellipse[i][0]); 
    cy[i][0] = (cy[i][0] - drift_rate[i]);
    
    
    // prevent circle from growing back when radius is negative
    width_ellipse[i][0]  = max(width_ellipse[i][0] - shrink_rate,0); 
    
    
    if ((cy_prev[i][4] < 0) || (width_ellipse[i][0] <= 0)) {    // bubble has left domaine or is small enough
       // inject new bubble 
       cx[i] = random(640);
       cy[i][0] = random(360);
       width_ellipse[i][0] = random(50); 
    }  
    
    // trailing bubbles info
    trailing_dist[i][0]    = 0;
    for (int j=1;j<n_trailing;j++){
      width_ellipse[i][j] = sqrt((1-0.1*j))*width_ellipse[i][0];
      trailing_dist[i][j] = 1.2*j* width_ellipse[i][1];
      cy[i][j]            = cy[i][0] + trailing_dist[i][j];      
    }
    
    
    // draw bubbles
    
    // lead bubble
    stroke(255,255,255);
    noFill();
    strokeWeight(1);
    ellipse(cx[i], cy[i][0], width_ellipse[i][0], width_ellipse[i][0]); 
    
    // trailing bubbles in shades of grey
    for (int j=1;j<n_trailing;j++){
      opacity = 100-(2*j-1)*10;
      stroke(255,255,255,opacity);
      noFill();
      strokeWeight(1);
      ellipse(cx[i], cy[i][j], width_ellipse[i][j], width_ellipse[i][j]); 
    }
    
   
  }

}