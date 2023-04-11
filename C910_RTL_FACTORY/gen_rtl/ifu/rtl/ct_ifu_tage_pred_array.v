/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

// &ModuleBeg; @22
module ct_ifu_tage_pred_array(
  tage_pred_array_clk_en,
  tage_pre_data_out,
  tage_pred_array_cen_b,
  tage_pred_array_din,
  tage_pred_array_gwen,
  tage_pred_array_index,
  tage_pred_bwen,
  cp0_ifu_icg_en,
  cp0_yy_clk_en,
  forever_cpuclk,
  pad_yy_icg_scan_en
);

// &Ports; @23
input           tage_pre_array_clk_en; 
input           tage_pred_array_cen_b; 
input   [63:0]  tage_pred_array_din;  
input           tage_pred_array_gwen; 
input   [9 :0]  tage_pred_array_index; 
input   [63:0]  tage_pred_bwen;       
input           cp0_ifu_icg_en;      
input           cp0_yy_clk_en;       
input           forever_cpuclk;      
input           pad_yy_icg_scan_en;  
output  [63:0]  tage_pre_data_out;    

// &Regs; @24

// &Wires; @25
wire            tage_pre_array_clk_en; 
wire            tage_pre_clk;         
wire    [2:0]   tage_pre_data_out;    
wire            tage_pre_en;          
wire            tage_pred_array_cen_b; 
wire    [2:0]   tage_pred_array_din;  
wire            tage_pred_array_gwen; 
wire    [9 :0]  tage_pred_array_index; 
wire    [2:0]   tage_pred_bwen;       
wire            cp0_ifu_icg_en;      
wire            cp0_yy_clk_en;       
wire            forever_cpuclk;      
wire            pad_yy_icg_scan_en;  


//Gate Clk
gated_clk_cell  x_tage_pre_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (tage_pre_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (tage_pre_en        ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in(forever_cpuclk), @29
//          .external_en(1'b0), @30
//          .global_en(cp0_yy_clk_en), @31
//          .module_en(cp0_ifu_icg_en), @32
//          .local_en(tage_pre_en), @33
//          .clk_out(tage_pre_clk) @34
//         ); @35

assign tage_pre_en = tage_pre_array_clk_en;

//Instance Logic
// &Instance("ct_spsram_1024x64", "x_ct_spsram_1024x64"); @40
ct_spsram_2048x32_split  x_ct_spsram_2048x32_split (
  .A                    (tage_pred_array_index),
  .CEN                  (tage_pred_array_cen_b),
  .CLK                  (tage_pre_clk         ),
  .D                    (tage_pred_array_din  ),
  .GWEN                 (tage_pred_array_gwen ),
  .Q                    (tage_pre_data_out    ),
  .WEN                  (tage_pred_bwen       )
);

// &Connect( @41
//          .CLK    (tage_pre_clk         ), @42
//          .Q      (tage_pre_data_out    ), @43
//          .CEN    (tage_pred_array_cen_b), @44
//          .WEN    (tage_pred_bwen       ), @45
//          .D      (tage_pred_array_din  ), @46
//          .A      (tage_pred_array_index), @47
//          .GWEN   (tage_pred_array_gwen ) @48
//        ); @49

// &ModuleEnd; @51
endmodule


