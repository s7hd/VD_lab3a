class simple_class;
bit [7:0] count;
  
function void load(input bit [7:0] count);
this.count = count;
endfunction

function int getcount();
return count;
endfunction

endclass
