Test bench
module tb_uart_tx;
    localparam CLK_FREQ = 10_000_000; 
    localparam BAUDRATE = 1_000_000;  
    localparam BIT_PERIOD_NS = (1_000_000_000 / BAUDRATE);

    logic       clk;
    logic       rst_n;
    logic       tx_start;
    logic [7:0] tx_data;
    logic       tx;
    logic       tx_busy;
    logic       tx_done;

    uart_tx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUDRATE(BAUDRATE)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .tx_done(tx_done)
    );

    always #10 clk = ~clk;

    task send_and_verify(input logic [7:0] data_to_send);
        logic [7:0] rx_payload;
        $display("[TB] Sending Data Byte: 0x%0h", data_to_send);
        @(posedge clk);
        tx_data  <= data_to_send;
        tx_start <= 1'b1;
        @(posedge clk);
        tx_start <= 1'b0;

        wait (tx == 1'b0);
        #(BIT_PERIOD_NS / 2);
        if (tx !== 1'b0) $error("[TB ERROR] Invalid Start bit!");

        for (int i = 0; i < 8; i++) begin
            #BIT_PERIOD_NS;
            rx_payload[i] = tx;
        end

        #BIT_PERIOD_NS;
        if (tx !== 1'b1) $error("[TB ERROR] Missing Stop Bit!");

        if (rx_payload === data_to_send)
            $display("[SUCCESS] Transmitted: 0x%0h | Received: 0x%0h\n", data_to_send, rx_payload);
        else
            $error("[FAIL] Transmitted: 0x%0h | Received: 0x%0h\n", data_to_send, rx_payload);
    endtask

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_uart_tx);
        clk      = 0;
        rst_n    = 0;
        tx_start = 0;
        tx_data  = 8'h00;
        #40 rst_n = 1;
        #40;
        send_and_verify(8'hA5);
        send_and_verify(8'h3C);
        send_and_verify(8'hFF);
        $display("===== ALL TESTS COMPLETED SUCCESSFULLY =====");
        $finish;
    end
endmodule