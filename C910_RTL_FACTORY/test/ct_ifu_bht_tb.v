//~ `New testbench
`timescale  1ns / 1ps

module tb_ct_ifu_bht;

// ct_ifu_bht Parameters
parameter PERIOD    = 10;
parameter PC_WIDTH  = 40;

// ct_ifu_bht Inputs
reg   cp0_ifu_bht_en                       = 1 ;
reg   cp0_ifu_icg_en                       = 1 ;
reg   cp0_yy_clk_en                        = 1 ;
reg   cpurst_b                             = 0 ;
reg   forever_cpuclk                       = 0 ;

reg   ifctrl_bht_inv                       = 0 ;
reg   ifctrl_bht_pipedown                  = 0 ;
reg   ifctrl_bht_stall                     = 0 ;
reg   ipctrl_bht_con_br_gateclk_en         = 0 ;
reg   ipctrl_bht_con_br_taken              = 0 ;
reg   ipctrl_bht_con_br_vld                = 0 ;
reg   ipctrl_bht_more_br                   = 0 ;
reg   ipctrl_bht_vld                       = 0 ;
reg   ipdp_bht_h0_con_br                   = 0 ;
reg   [38:0]  ipdp_bht_vpc                 = 0 ;
reg   iu_ifu_bht_check_vld                 = 0 ;
reg   iu_ifu_bht_condbr_taken              = 0 ;
reg   iu_ifu_bht_pred                      = 0 ;
reg   iu_ifu_chgflw_vld                    = 0 ;
reg   [24:0]  iu_ifu_chk_idx               = 0 ;
reg   [38:0]  iu_ifu_cur_pc                = 0 ;
reg   lbuf_bht_active_state                = 0 ;
reg   lbuf_bht_con_br_taken                = 0 ;
reg   lbuf_bht_con_br_vld                  = 0 ;
reg   pad_yy_icg_scan_en                   = 0 ;
reg   pcgen_bht_chgflw                     = 0 ;
reg   pcgen_bht_chgflw_short               = 0 ;
reg   [6 :0]  pcgen_bht_ifpc               = 0 ;
reg   [9 :0]  pcgen_bht_pcindex            = 0 ;
reg   pcgen_bht_seq_read                   = 0 ;
reg   rtu_ifu_flush                        = 0 ;
reg   rtu_ifu_retire0_condbr               = 0 ;
reg   rtu_ifu_retire0_condbr_taken         = 0 ;
reg   rtu_ifu_retire1_condbr               = 0 ;
reg   rtu_ifu_retire1_condbr_taken         = 0 ;
reg   rtu_ifu_retire2_condbr               = 0 ;
reg   rtu_ifu_retire2_condbr_taken         = 0 ;

// ct_ifu_bht Outputs
wire  bht_ifctrl_inv_done                  ;
wire  bht_ifctrl_inv_on                    ;
wire  [7 :0]  bht_ind_btb_rtu_ghr          ;
wire  [7 :0]  bht_ind_btb_vghr             ;
wire  [31:0]  bht_ipdp_pre_array_data_ntake ;
wire  [31:0]  bht_ipdp_pre_array_data_taken ;
wire  [15:0]  bht_ipdp_pre_offset_onehot   ;
wire  [1 :0]  bht_ipdp_sel_array_result    ;
wire  [21:0]  bht_ipdp_vghr                ;
wire  [31:0]  bht_lbuf_pre_ntaken_result   ;
wire  [31:0]  bht_lbuf_pre_taken_result    ;
wire  [21:0]  bht_lbuf_vghr                ;


initial
begin
    forever #(PERIOD/2)  forever_cpuclk=~forever_cpuclk;
end

initial
begin
    #(PERIOD*2) cpurst_b  =  1;
end

ct_ifu_bht #(
    .PC_WIDTH ( PC_WIDTH ))
 u_ct_ifu_bht (
    .cp0_ifu_bht_en                 ( cp0_ifu_bht_en                        ),
    .cp0_ifu_icg_en                 ( cp0_ifu_icg_en                        ),
    .cp0_yy_clk_en                  ( cp0_yy_clk_en                         ),
    .cpurst_b                       ( cpurst_b                              ),
    .forever_cpuclk                 ( forever_cpuclk                        ),
    .ifctrl_bht_inv                 ( ifctrl_bht_inv                        ),
    .ifctrl_bht_pipedown            ( ifctrl_bht_pipedown                   ),
    .ifctrl_bht_stall               ( ifctrl_bht_stall                      ),
    .ipctrl_bht_con_br_gateclk_en   ( ipctrl_bht_con_br_gateclk_en          ),
    .ipctrl_bht_con_br_taken        ( ipctrl_bht_con_br_taken               ),
    .ipctrl_bht_con_br_vld          ( ipctrl_bht_con_br_vld                 ),
    .ipctrl_bht_more_br             ( ipctrl_bht_more_br                    ),
    .ipctrl_bht_vld                 ( ipctrl_bht_vld                        ),
    .ipdp_bht_h0_con_br             ( ipdp_bht_h0_con_br                    ),
    .ipdp_bht_vpc                   ( ipdp_bht_vpc                   [38:0] ),
    .iu_ifu_bht_check_vld           ( iu_ifu_bht_check_vld                  ),
    .iu_ifu_bht_condbr_taken        ( iu_ifu_bht_condbr_taken               ),
    .iu_ifu_bht_pred                ( iu_ifu_bht_pred                       ),
    .iu_ifu_chgflw_vld              ( iu_ifu_chgflw_vld                     ),
    .iu_ifu_chk_idx                 ( iu_ifu_chk_idx                 [24:0] ),
    .iu_ifu_cur_pc                  ( iu_ifu_cur_pc                  [38:0] ),
    .lbuf_bht_active_state          ( lbuf_bht_active_state                 ),
    .lbuf_bht_con_br_taken          ( lbuf_bht_con_br_taken                 ),
    .lbuf_bht_con_br_vld            ( lbuf_bht_con_br_vld                   ),
    .pad_yy_icg_scan_en             ( pad_yy_icg_scan_en                    ),
    .pcgen_bht_chgflw               ( pcgen_bht_chgflw                      ),
    .pcgen_bht_chgflw_short         ( pcgen_bht_chgflw_short                ),
    .pcgen_bht_ifpc                 ( pcgen_bht_ifpc                 [6 :0] ),
    .pcgen_bht_pcindex              ( pcgen_bht_pcindex              [9 :0] ),
    .pcgen_bht_seq_read             ( pcgen_bht_seq_read                    ),
    .rtu_ifu_flush                  ( rtu_ifu_flush                         ),
    .rtu_ifu_retire0_condbr         ( rtu_ifu_retire0_condbr                ),
    .rtu_ifu_retire0_condbr_taken   ( rtu_ifu_retire0_condbr_taken          ),
    .rtu_ifu_retire1_condbr         ( rtu_ifu_retire1_condbr                ),
    .rtu_ifu_retire1_condbr_taken   ( rtu_ifu_retire1_condbr_taken          ),
    .rtu_ifu_retire2_condbr         ( rtu_ifu_retire2_condbr                ),
    .rtu_ifu_retire2_condbr_taken   ( rtu_ifu_retire2_condbr_taken          ),

    .bht_ifctrl_inv_done            ( bht_ifctrl_inv_done                   ),
    .bht_ifctrl_inv_on              ( bht_ifctrl_inv_on                     ),
    .bht_ind_btb_rtu_ghr            ( bht_ind_btb_rtu_ghr            [7 :0] ),
    .bht_ind_btb_vghr               ( bht_ind_btb_vghr               [7 :0] ),
    .bht_ipdp_pre_array_data_ntake  ( bht_ipdp_pre_array_data_ntake  [31:0] ),
    .bht_ipdp_pre_array_data_taken  ( bht_ipdp_pre_array_data_taken  [31:0] ),
    .bht_ipdp_pre_offset_onehot     ( bht_ipdp_pre_offset_onehot     [15:0] ),
    .bht_ipdp_sel_array_result      ( bht_ipdp_sel_array_result      [1 :0] ),
    .bht_ipdp_vghr                  ( bht_ipdp_vghr                  [21:0] ),
    .bht_lbuf_pre_ntaken_result     ( bht_lbuf_pre_ntaken_result     [31:0] ),
    .bht_lbuf_pre_taken_result      ( bht_lbuf_pre_taken_result      [31:0] ),
    .bht_lbuf_vghr                  ( bht_lbuf_vghr                  [21:0] )
);

initial
begin
    // BHT invalid
    #PERIOD
    ifctrl_bht_stall = 1;
    pcgen_bht_pcindex = 10'b10_0101_0010;
    #PERIOD
    ifctrl_bht_stall = 0;
    //$finish;
end

endmodule