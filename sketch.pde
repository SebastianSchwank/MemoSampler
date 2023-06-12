boolean[][] game_conciouss;
boolean[][] game_silly;

int tgt;

int size = 8;

void clear_Game(){
  tgt = (int)random(size*size-1);
  for(int i = 0; i < size; i++){
    for(int j = 0; j < size; j++){
      game_conciouss[i][j] = false;
      game_silly[i][j] = false;
    }
  }
}

void setup(){
  game_conciouss = new boolean[size][size];
  game_silly = new boolean[size][size];
  clear_Game();
}

boolean sampleSilly(int sample){
  if(sample == tgt){
    return true;
  }
  game_silly[(int)(sample%((int)((size))))][(int)(sample/((int)((size+1))))] = true;
  return false;
}

boolean sampleConciouss(int sample){
  
  boolean sampled = false;
  
  if(sample == tgt){
    return true;
  }
  while(!sampled){
    int x = ((int)random(size));
    int y = ((int)random(size));
    sample = (int)(random(x+y*size));
    if(sample == tgt){
    return true;
    }
    if(game_conciouss[x][y] == false){
      game_conciouss[x][y] = true;
      return false;
    }
  }
  return false;
}

int num_Runs = 0;

float last_Silly = 0.0;
float last_Concy = 0.0;

float stat_Silly = 0.0;
float stat_Concy = 0.0;

int samplesDone_Silly = 0;
int samplesDone_Concy = 0;

boolean con_Sampled = false;
boolean sil_Sampled = false;

void draw(){
  delay(5);
  
  int sample = (int)random(size*size-1);
  if((!con_Sampled)){
    samplesDone_Concy++;
    con_Sampled = (sampleConciouss(sample));
  }
  
  if((!sil_Sampled)){
    samplesDone_Silly++;
    sil_Sampled = (sampleSilly(sample));
  }
  
  for(int i = 0; i < size; i++){
    for(int j = 0; j < size; j++){
      color c = color(0);
      if(game_conciouss[i][j] == true) c = color(255);
      set(i+128,j+128,c);
      c = color(0);
      if(game_silly[i][j] == true) c = color(255);
      set(i+128,j+256,c);
    }
  }
  
  if(sil_Sampled&&con_Sampled){
    clear_Game();
    last_Silly = stat_Silly;
    last_Concy = stat_Concy;
    stat_Silly = ((num_Runs*stat_Silly)+samplesDone_Silly)/(num_Runs+1);
    stat_Concy = ((num_Runs*stat_Concy)+samplesDone_Concy)/(num_Runs+1);
    //print(stat_Silly);
    //print(",");
    //println(stat_Concy);
    line(num_Runs+64,last_Silly+364,num_Runs+65,stat_Silly+364);
    line(num_Runs+64,last_Concy+364,num_Runs+65,stat_Concy+364);
    num_Runs++;
    sil_Sampled = false;
    con_Sampled = false;
    samplesDone_Silly = 0;
    samplesDone_Concy = 0;
  }
  
}