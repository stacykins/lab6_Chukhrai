`timescale 1ns / 1ps

module test_sum;
    reg [7:0] Ain, Bin;
    reg Ci;
    wire [7:0] res_my, res_ref;
    wire cm, cr;

    // Підключення модулів
    my_sum my_block (Ain, Bin, Ci, res_my, cm);
    ref_sum ref_block (Ain, Bin, Ci, res_ref, cr);

    initial begin
        // Заголовок стовпчиків
        $display("Time\tAin\t\tBin\t\tCi\tres_my\t\tcm\tres_ref\t\tcr");
        
        // Моніторинг результатів у двійковому форматі (%b)
        $monitor("%0d\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
                 $time, Ain, Bin, Ci, res_my, cm, res_ref, cr);

        // --- Нові тестові значення ---

        // 1. Просте додавання (5 + 10 = 15)
        Ain = 8'b00000101; Bin = 8'b00001010; Ci = 0;

        // 2. Тест на заповнення розрядів (127 + 1 = 128)
        #50 Ain = 8'b01111111; Bin = 8'b00000001;

        // 3. Тест на виникнення перенесення (255 + 1 = 256 -> сума 0, Co = 1)
        #50 Ain = 8'b11111111; Bin = 8'b00000001;

        // 4. Додавання великих чисел (170 + 85 = 255)
        #50 Ain = 8'b10101010; Bin = 8'b01010101;

        // 5. Тест вхідного перенесення Ci (0 + 0 + 1 = 1)
        #50 Ain = 8'b00000000; Bin = 8'b00000000; Ci = 1;

        // 6. Максимальне значення з Ci (255 + 255 + 1)
        #50 Ain = 8'b11111111; Bin = 8'b11111111; Ci = 1;

        // 7. Випадкові значення (100 + 50 + 0)
        #50 Ain = 8'b01100100; Bin = 8'b00110010; Ci = 0;

        #50 $finish;
    end
endmodule
