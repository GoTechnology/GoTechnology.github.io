function ExecuteScript(strId)
{
  switch (strId)
  {
      case "66LhqL6thbc":
        Script1();
        break;
      case "6qEq5c24hVb":
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
var field1 = player.GetVar("WP_name");
var field2 = player.GetVar("WP_desc");
var field3 = player.GetVar("WP_narr");
var field4 = player.GetVar("WP_appcom");


//Truncate the values to 25 characters using the substring method
//Note: the index for the first character is zero, not 1
var field1 = field1.substring(0, 24);
var field2 = field2.substring(0, 24);
var field3 = field3.substring(0, 39);
var field4 = field4.substring(0, 39);


//Assign our Storyline variables to these updated Javascript variables
player.SetVar("WP_name", field1);
player.SetVar("WP_desc", field2);
player.SetVar("WP_narr", field3);
player.SetVar("WP_appcom", field4);

}

function Script2()
{
  //Open communication between Storyline and Javascript
var player = GetPlayer();

//Create variables in Javascript called field1, field 2...field5
//and assign these new variables to the equivalent variables
//we created in Storyline
var field1 = player.GetVar("WP_name");
var field2 = player.GetVar("WP_desc");
var field3 = player.GetVar("WP_narr");
var field4 = player.GetVar("WP_appcom");


//Truncate the values to 25 characters using the substring method
//Note: the index for the first character is zero, not 1
var field1 = field1.substring(0, 24);
var field2 = field2.substring(0, 24);
var field3 = field3.substring(0, 39);
var field4 = field4.substring(0, 39);


//Assign our Storyline variables to these updated Javascript variables
player.SetVar("WP_name", field1);
player.SetVar("WP_desc", field2);
player.SetVar("WP_narr", field3);
player.SetVar("WP_appcom", field4);
}

