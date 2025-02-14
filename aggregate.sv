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
bit carry;
static int instance_count = 0;

function new(input bit [7:0] temp = 8'h07, input int limit1 = 8'h99, input int limit2 = 0);

super.new(temp, limit1, limit2);
carry = 0;
instance_count++;
endfunction
  
static function int get_inst_count();
return instance_count;
endfunction

function void next();
if (count >= max) begin
carry =1;
count = min;  
end else begin
carry =1
count = count+1;
end
$display("Count Value: %d", this.getcount()); 
endfunction

endclass



class downcounter extends counter;
bit borrow =0;
static int instance_count=-;
  
function new(input bit [7:0] temp = 8'h07, input int limit1 = 0, input int limit2 = 8'h99);
super.new(temp, limit1, limit2);
borrow = 0;
instance_count++;
endfunction

static function int get_inst_count();
return instance_count;
endfunction
  
function void next();
if (count > min) begin
borrow =0;
count = count-1;
end else begin
borrow =1;
count = max;
end
$display("Count Value: %d", this.getcount());
endfunction

endclass


class timer;
upcounter hours, minutes, seconds;

function new(input int h = 0, input int m = 0, input int s = 0);
        hours   = new();  
        minutes = new(); 
        seconds = new(); 
        hours.check_limit(23, 0);   
        minutes.check_limit(59, 0); 
        seconds.check_limit(59, 0); 
        load(h, m, s);
endfunction

function void load(input int h, input int m, input int s);
        hours.load(h);
        minutes.load(m);
        seconds.load(s);
endfunction

function void showval();
$display("Time: %02d:%02d:%02d", hours.getcount(), minutes.getcount(), seconds.getcount());
endfunction

  function void next();
        seconds.next(); 
        if (seconds.carry) begin
            minutes.next();
        end
        if (minutes.carry) begin
            hours.next();
        end
        showval();
    endfunction
endclass

module test;
    timer t1;
    initial begin
        t1 = new(0, 0, 59);
        $display("Initial Timer:");
        t1.showval();
        t1.next(); 
    
        t1.load(0, 59, 59);
        $display("Testing Full Hour Roll-Over:");
        t1.showval();
        t1.next(); 

        t1.load(23, 59, 59);
        $display("Testing Full Day Roll-Over:");
        t1.showval();
        t1.next(); 
    end
endmodule
