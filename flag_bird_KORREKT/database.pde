class DB{

SQLite db;


void getDatabase(processing.core.PApplet _p){
  db = new SQLite( _p, "flag_database.sqlite" );  // open database file
}

void getData(){

    if ( db.connect() )
    {
        // list table names
        db.query( "SELECT name as \"Name\" FROM SQLITE_MASTER where type=\"table\"" );
        while (db.next())
        {
            println( db.getString("Name") );
        }
        
        // read all in table "table_one"
      db.query( "SELECT * FROM player;" );
        
        while (db.next())
        {
            println( db.getString("username") );
            //println( db.getInt("field_two") );
        }
    }
}

void setData(int brugerID, int score){
      db.query("INSERT INTO Highscore (Score,Player_ID) VALUES (" + score + ","+brugerID+");");
  
}

int getHigh(){
  int score = 0;
          db.query( "SELECT MAX(score) from Highscore" );
          while(db.next()){
             score = db.getInt("max(score)");  
          }
    return score;
}

}
