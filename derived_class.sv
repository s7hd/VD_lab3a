class counter;
bit [7:0] count;
  
function new (input  bit [7:0] temp = 8'h00);
this.count = temp;
endfunction
  
function void load(input bit [7:0] count);
this.count = count;
endfunction

function int getcount();
return count;
endfunction

endclass

class upcounter extends counter;

function new(8'h07);
super.new(8'h07);
endfunction

function void next();
this.count = this.count+1;
$display("Count Value: %d", this.getcount());
endfunction

endclass

class downcounter extends counter;

function new(8'h07);
super.new(8'h07);
endfunction

function void next();
this.count = this.count-1;
$display("Count Value: %d", this.getcount());
endfunction

endclass
