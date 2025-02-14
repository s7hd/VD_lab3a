class counter;
bit [7:0] count;
int max, min;

function new (input  bit [7:0] temp = 8'h00, input int limit1 = 255, input int limit2 = 0);
check_limit(limit1, limit2);  
check_set(temp);            
endfunction

function void load(input bit [7:0] new_value);
check_set(new_value);
$display("New Count Loaded: %d", count);
endfunction

function void check_limit(input int limit1, input int limit2);
max = (limit1 > limit2) ? limit1 : limit2;
min = (limit1 < limit2) ? limit1 : limit2;
endfunction

function void check_set(input bit [7:0] temp);
if (temp > max) begin
count = max;
$display("Warning: Initial count exceeds max limit. Set to max.");
end else if (temp < min) begin
count = min;
$display("Warning: Initial count below min limit. Set to min.");
end else begin
count = temp;
end
endfunction

function int getcount();
return count;
endfunction
  
endclass



class upcounter extends counter;

function new(input bit [7:0] temp = 8'h07, input int limit1 = 8'h99, input int limit2 = 0);
super.new(temp, limit1, limit2);
endfunction

function void next();
if (count >= max) begin
count = min;
end else begin
count = count+1;
end
$display("Count Value: %d", this.getcount());       
endfunction

endclass

class downcounter extends counter;

function new(input bit [7:0] temp = 8'h07, input int limit1 = 0, input int limit2 = 8'h99);
super.new(temp, limit1, limit2);
endfunction

function void next();
if (count > min) begin
count = count-1;
end else begin
count = max;
end
$display("Count Value: %d", this.getcount());
endfunction

endclass
