///Left off at step 9

import de.bezier.guido.*;

public final static int NUM_ROWS = 20;

public final static int NUM_COLS = 20;

public final static int NUM_BOMBS = 5;

private MSButton[][] buttons; //2d array of minesweeper buttons

private ArrayList <MSButton> bombs = new ArrayList <MSButton>();

int play =0;

 

void setup ()

{

  size(400, 400);

  textAlign(CENTER, CENTER);

 

  // make the manager

  Interactive.make( this );

 

  buttons = new MSButton[NUM_ROWS][NUM_COLS];

 

  for (int r =0; r < NUM_ROWS; r++)

    for (int c =0; c < NUM_COLS; c++)

      buttons[r][c] = new MSButton(r, c);

  setBombs();

}

public void setBombs()

{

  while (bombs.size() < NUM_BOMBS)

  {

    int r = (int)(Math.random()*10);

    int c = (int)(Math.random()*10);

    if (!bombs.contains(buttons[r][c]))

    {

      bombs.add(buttons[r][c]);

      System.out.println(r + ", " + c);

    }

  }

}

public void draw ()

{

  background( 0 );

  if (isWon()){

  displayWinningMessage();

}

}

public boolean isWon()

{

  

  for (int r = 0; r < NUM_ROWS; r++)

    for (int c = 0; c < NUM_COLS; c++)

      if(buttons[r][c].isClicked() == false && !bombs.contains(buttons[r][c]))

      {

        return false;

      }

      return true;

}

 

public void displayLosingMessage()

{

play =2;

  buttons[9][6].setLabel("Y");

  buttons[9][7].setLabel("O");

  buttons[9][8].setLabel("U");

  buttons[9][10].setLabel("L");

  buttons[9][11].setLabel("O");

  buttons[9][12].setLabel("S");

  buttons[9][13].setLabel("E");

}

public void displayWinningMessage()

{

 play=1;

  

  buttons[9][6].setLabel("Y");

  buttons[9][7].setLabel("O");

  buttons[9][8].setLabel("U");

  buttons[9][10].setLabel("W");

  buttons[9][11].setLabel("I");

  buttons[9][12].setLabel("N");

  buttons[9][13].setLabel("!");

}

 

public class MSButton

{

  private int r, c;

  private float x, y, width, height;

  private boolean clicked, marked;

  private String label;

 

  public MSButton ( int rr, int cc )

  {

    width = 400/NUM_COLS;

    height = 400/NUM_ROWS;

    r = rr;

    c = cc; 

    x = c*width;

    y = r*height;

    label = "";

    marked = clicked = false;

    Interactive.add( this ); // register it with the manager

  }

  public boolean isMarked()

  {

    return marked;

  }

  public boolean isClicked()

  {

    return clicked;

  }

  // called by manager

 

  public void mousePressed () 

  {

   if(play==0)

   {

    clicked = true;

 

    if (mouseButton == RIGHT && marked ==true) {

      marked = false;

      clicked = false;

    }  if (mouseButton == RIGHT&&marked ==false) {

      marked = true;

      clicked = false;

    } else  if (bombs.contains(this)==true)

    {

      displayLosingMessage();

    } else if (countBombs(r, c)>0) {

      setLabel(""+countBombs(r, c));

    } else

    {

      if (isValid(r, c-1) && (buttons[r][c-1].isClicked() == false))

      {

        buttons[r][c-1].mousePressed();

      }

      if (isValid(r, c+1) && (buttons[r][c+1].isClicked() == false))

      {

        buttons[r][c+1].mousePressed();

      }

      if (isValid(r-1, c) && (buttons[r-1][c].isClicked() == false))

      {

        buttons[r-1][c].mousePressed();

      }

      if (isValid(r+1, c) && (buttons[r+1][c].isClicked() == false))

      {

        buttons[r+1][c].mousePressed();

      }

      if (isValid(r+1, c-1) && (buttons[r+1][c-1].isClicked() == false))

      {

        buttons[r+1][c-1].mousePressed();

      }

      if (isValid(r+1, c+1) && (buttons[r+1][c+1].isClicked() == false))

      {

        buttons[r+1][c+1].mousePressed();

      }

      if (isValid(r+1, c-1) && (buttons[r+1][c-1].isClicked() == false))

      {

        buttons[r+1][c-1].mousePressed();

      }

      if (isValid(r-1, c-1) && (buttons[r-1][c-1].isClicked() == false))

      {

        buttons[r-1][c-1].mousePressed();

      }

    }

  }

  }

  public void draw () 

  {    

    if (marked)

      fill(0);

    else if ( clicked && bombs.contains(this) ) 

      fill(255, 0, 0);

    else if (clicked)

      fill( 200 );

    else 

    fill( 100 );

 

    rect(x, y, width, height);

    fill(0);

    text(label, x+width/2, y+height/2);

  }

  public void setLabel(String newLabel)

  {

    label = newLabel;

  }

  public boolean isValid(int r, int c)

  {

    if (r>=0 && c>=0 && r<NUM_ROWS && c<NUM_COLS)

    {

      return true;

    }

    return false;

  }

  public int countBombs(int row, int col)

  {

    int numBombs = 0;

    if (isValid(row, col-1)&&bombs.contains(buttons[row][col-1]))

      numBombs++;

 

    if (isValid(row, col+1)&&bombs.contains(buttons[row][col+1]))

      numBombs++;

 

    if (isValid(row-1, col)&&bombs.contains(buttons[row-1][col]))

      numBombs++;

 

    if (isValid(row+1, col)&&bombs.contains(buttons[row+1][col]))

      numBombs++;

 

    if (isValid(row+1, col+1)&&bombs.contains(buttons[row+1][col+1]))

      numBombs++;

 

    if (isValid(row-1, col-1)&&bombs.contains(buttons[row-1][col-1]))

      numBombs++;

 

    if (isValid(row+1, col-1)&&bombs.contains(buttons[row+1][col-1]))

      numBombs++;

 

    if (isValid(row-1, col+1)&&bombs.contains(buttons[row-1][col+1]))

      numBombs++;

    return numBombs;

  }

}