function ExecuteScript(strId)
{
  switch (strId)
  {
      case "63AAREWnAja":
        Script1();
        break;
      case "5avrXH0SJpK":
        Script2();
        break;
  }
}

function Script1()
{
  //Open communication between Storyline and Javascript
var player = GetPlayer();

//Create variables in Javascript called field1, field 2...field5
//and assign these new variables to the equivalent variables
//we created in Storyline
var field1 = player.GetVar("AP_name_1");


//Truncate the values to 25 characters using the substring method
//Note: the index for the first character is zero, not 1
var field1 = field1.substring(0, 24);



//Assign our Storyline variables to these updated Javascript variables
player.SetVar("AP_name_1", field1);

}

function Script2()
{
  //Open communication between Storyline and Javascript
var player = GetPlayer();

//Create variables in Javascript called field1, field 2...field5
//and assign these new variables to the equivalent variables
//we created in Storyline
var field1 = player.GetVar("AP_name_2");



//Truncate the values to 25 characters using the substring method
//Note: the index for the first character is zero, not 1
var field1 = field1.substring(0, 24);



//Assign our Storyline variables to these updated Javascript variables
player.SetVar("AP_name_2", field1);

}

