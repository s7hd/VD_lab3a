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
