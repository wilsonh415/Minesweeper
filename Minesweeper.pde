import de.bezier.guido.*;

public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 20;
boolean restart = false;
private MSButton[][] buttons; 
private ArrayList <MSButton> bombs = new ArrayList <MSButton>();


public void setup () {
    size(400, 400);
    textAlign(CENTER,CENTER);
    
   
    Interactive.make(this);

    buttons = new MSButton[NUM_ROWS][NUM_COLS];

    for(int i = 0; i < buttons.length; i ++) {
        for(int j = 0; j < buttons[i].length; j++) {
            buttons[i][j] = new MSButton(i,j);
        }
    }
    
    for(int i = 0; i < NUM_BOMBS; i ++)
        setBombs();
}
public void setBombs() {
    //your code
    int xBomb = (int)(Math.random()*NUM_COLS);
    int yBomb = (int)(Math.random()*NUM_ROWS);
    if(!bombs.contains(buttons[yBomb][xBomb]))
    {
        bombs.add(buttons[yBomb][xBomb]);
    }
}

public void mousePressed() {
    if(mousePressed == true) {
        boolean restart = true;
        redraw();
    }
}


public void draw () {
    background( 0 );
    if(isWon()) {
        displayWinningMessage();
    }
}
public boolean isWon() {
    //your code here
    return false;
}
public void displayLosingMessage() {
    //your code here
    textSize(15);
    fill(255,0,0);
    text("Better Luck Next Time!",200,200);
}
public void displayWinningMessage() {
    textSize(15);
    text("Congrats!", 200,200);
}

public class MSButton {
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc ) {
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
    public boolean isMarked() {
        return marked;
    }
    public boolean isClicked() {
        return clicked;
    }
 
    
    public void mousePressed () {
        clicked = true;
   
        if(keyPressed == true) {
            if(marked == true) {
                marked = false; 
            }
            if(marked == false) {
                marked = true;
                clicked = false; }
        }
        else if(bombs.contains(this)) {
            displayLosingMessage();
        }
        else if(countBombs(this.r,this.c) > 0) {
            setLabel(""+(countBombs(this.r,this.c)));
        }
        else {
            if(isValid(r,c-1) && buttons[r][c-1].clicked == false)
                buttons[r][c-1].mousePressed();
       
            if(isValid(r-1,c) && buttons[r-1][c].clicked == false)
                buttons[r-1][c].mousePressed();
        
            if(isValid(r,c+1) && buttons[r][c+1].clicked == false)
                buttons[r][c+1].mousePressed();
        
            if(isValid(r+1,c) && buttons[r+1][c].clicked == false)
                buttons[r+1][c].mousePressed();
        }
        
    }

    public void draw () {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel) {
        label = newLabel;
    }
    public boolean isValid(int r, int c) {
        //your code here
        if(r < 20 && r >= 0 && c < 20 && c >= 0)
            return true;
        else
            return false;
    }
    public int countBombs(int row, int col) {
        int numBombs = 0;
        //your code here
        if(isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
            numBombs++; 
        if(isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;
        if(isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        return numBombs;
    }
}