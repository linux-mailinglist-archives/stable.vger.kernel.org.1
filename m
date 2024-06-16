Return-Path: <stable+bounces-52314-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A21909D4E
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62AB4281670
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A0A18C35A;
	Sun, 16 Jun 2024 12:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nsmo6Y9J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA50918C34E;
	Sun, 16 Jun 2024 12:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718539457; cv=none; b=dgOlJX5EyOuQ0Rvyr6iUj1zt/j9UZsjudSgOWrkjk/bjKXB/nLfKW4qQ7prKUhUPHYs6JavGxalYoDd6xzEbVBvGZOsbWnn2xTTA13ce7RJqvnPuvi8gwEwLIqPUvDbLpGR8S3bcSBBPcIjOVS1mvcmqzoQxTIOLni7HKJJJjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718539457; c=relaxed/simple;
	bh=DzJsYY+ZktF7+YRJgzQRknlcJI8owbiPnDLAqoHC77g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFa/coULvDuwqjZ5+UJjBr7dZKIFtDnK9Syto/etRp9J2cQqLCQPkO10hz6USE2bnUFEDiU5eyb5tGcAH169/B42svinIkoW2jJUMJdffEEdw4ozGnVgvKc6ytvZkmTn5F21rihWXEhuKg3YvPdPiFY9vAyjNyf0E9u2HcV5PmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nsmo6Y9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59021C4AF1D;
	Sun, 16 Jun 2024 12:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718539456;
	bh=DzJsYY+ZktF7+YRJgzQRknlcJI8owbiPnDLAqoHC77g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nsmo6Y9JortlP5xChQaOatCVfR5Q/y2pIr3eer5yKrp38TSR43GngliF6tG9+Guyl
	 L/AFGS/mbYtaV7haHnlyIHRGoCPTxql4r1sHW2fB61/ittHWRemVNMoDp/iUpzYPsP
	 xcjJOD8J7XlDsaYVIUMfZ/wh0dSr3cXqkAJrznWM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.161
Date: Sun, 16 Jun 2024 14:04:05 +0200
Message-ID: <2024061605-underdog-unloving-dc80@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061605-monkhood-baggage-db52@gregkh>
References: <2024061605-monkhood-baggage-db52@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
index cf456f8d9ddc..c87677f5e2a2 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2680.yaml
@@ -37,15 +37,15 @@ properties:
       active low.
     maxItems: 1
 
-  dovdd-supply:
+  DOVDD-supply:
     description:
       Definition of the regulator used as interface power supply.
 
-  avdd-supply:
+  AVDD-supply:
     description:
       Definition of the regulator used as analog power supply.
 
-  dvdd-supply:
+  DVDD-supply:
     description:
       Definition of the regulator used as digital power supply.
 
@@ -59,9 +59,9 @@ required:
   - reg
   - clocks
   - clock-names
-  - dovdd-supply
-  - avdd-supply
-  - dvdd-supply
+  - DOVDD-supply
+  - AVDD-supply
+  - DVDD-supply
   - reset-gpios
   - port
 
@@ -82,9 +82,9 @@ examples:
                 clock-names = "xvclk";
                 reset-gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 
-                dovdd-supply = <&sw2_reg>;
-                dvdd-supply = <&sw2_reg>;
-                avdd-supply = <&reg_peri_3p15v>;
+                DOVDD-supply = <&sw2_reg>;
+                DVDD-supply = <&sw2_reg>;
+                AVDD-supply = <&reg_peri_3p15v>;
 
                 port {
                         ov2680_to_mipi: endpoint {
diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index 8fdfbc763d70..835b6db00c27 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -68,6 +68,18 @@ properties:
   phy-names:
     const: pcie
 
+  vpcie1v5-supply:
+    description: The 1.5v regulator to use for PCIe.
+
+  vpcie3v3-supply:
+    description: The 3.3v regulator to use for PCIe.
+
+  vpcie12v-supply:
+    description: The 12v regulator to use for PCIe.
+
+  iommu-map: true
+  iommu-map-mask: true
+
 required:
   - compatible
   - reg
@@ -121,5 +133,7 @@ examples:
              clock-names = "pcie", "pcie_bus";
              power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
              resets = <&cpg 319>;
+             vpcie3v3-supply = <&pcie_3v3>;
+             vpcie12v-supply = <&pcie_12v>;
          };
     };
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index 0feecd376c69..9aed3a58f39e 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -94,7 +94,8 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [emmc, emmc_rst]
+                  items:
+                    enum: [emmc, emmc_rst]
           - if:
               properties:
                 function:
@@ -102,8 +103,9 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [esw, esw_p0_p1, esw_p2_p3_p4, rgmii_via_esw,
-                         rgmii_via_gmac1, rgmii_via_gmac2, mdc_mdio]
+                  items:
+                    enum: [esw, esw_p0_p1, esw_p2_p3_p4, rgmii_via_esw,
+                           rgmii_via_gmac1, rgmii_via_gmac2, mdc_mdio]
           - if:
               properties:
                 function:
@@ -120,10 +122,11 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [i2s_in_mclk_bclk_ws, i2s1_in_data, i2s2_in_data,
-                         i2s3_in_data, i2s4_in_data, i2s_out_mclk_bclk_ws,
-                         i2s1_out_data, i2s2_out_data, i2s3_out_data,
-                         i2s4_out_data]
+                  items:
+                    enum: [i2s_in_mclk_bclk_ws, i2s1_in_data, i2s2_in_data,
+                           i2s3_in_data, i2s4_in_data, i2s_out_mclk_bclk_ws,
+                           i2s1_out_data, i2s2_out_data, i2s3_out_data,
+                           i2s4_out_data]
           - if:
               properties:
                 function:
@@ -156,10 +159,11 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [pcie0_0_waken, pcie0_1_waken, pcie1_0_waken,
-                         pcie0_0_clkreq, pcie0_1_clkreq, pcie1_0_clkreq,
-                         pcie0_pad_perst, pcie1_pad_perst, pcie_pereset,
-                         pcie_wake, pcie_clkreq]
+                  items:
+                    enum: [pcie0_0_waken, pcie0_1_waken, pcie1_0_waken,
+                           pcie0_0_clkreq, pcie0_1_clkreq, pcie1_0_clkreq,
+                           pcie0_pad_perst, pcie1_pad_perst, pcie_pereset,
+                           pcie_wake, pcie_clkreq]
           - if:
               properties:
                 function:
@@ -175,11 +179,12 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [pwm_ch1_0, pwm_ch1_1, pwm_ch1_2, pwm_ch2_0, pwm_ch2_1,
-                         pwm_ch2_2, pwm_ch3_0, pwm_ch3_1, pwm_ch3_2, pwm_ch4_0,
-                         pwm_ch4_1, pwm_ch4_2, pwm_ch4_3, pwm_ch5_0, pwm_ch5_1,
-                         pwm_ch5_2, pwm_ch6_0, pwm_ch6_1, pwm_ch6_2, pwm_ch6_3,
-                         pwm_ch7_0, pwm_0, pwm_1]
+                  items:
+                    enum: [pwm_ch1_0, pwm_ch1_1, pwm_ch1_2, pwm_ch2_0, pwm_ch2_1,
+                           pwm_ch2_2, pwm_ch3_0, pwm_ch3_1, pwm_ch3_2, pwm_ch4_0,
+                           pwm_ch4_1, pwm_ch4_2, pwm_ch4_3, pwm_ch5_0, pwm_ch5_1,
+                           pwm_ch5_2, pwm_ch6_0, pwm_ch6_1, pwm_ch6_2, pwm_ch6_3,
+                           pwm_ch7_0, pwm_0, pwm_1]
           - if:
               properties:
                 function:
@@ -257,33 +262,34 @@ patternProperties:
           pins:
             description: |
               An array of strings. Each string contains the name of a pin.
-            enum: [GPIO_A, I2S1_IN, I2S1_OUT, I2S_BCLK, I2S_WS, I2S_MCLK, TXD0,
-                   RXD0, SPI_WP, SPI_HOLD, SPI_CLK, SPI_MOSI, SPI_MISO, SPI_CS,
-                   I2C_SDA, I2C_SCL, I2S2_IN, I2S3_IN, I2S4_IN, I2S2_OUT,
-                   I2S3_OUT, I2S4_OUT, GPIO_B, MDC, MDIO, G2_TXD0, G2_TXD1,
-                   G2_TXD2, G2_TXD3, G2_TXEN, G2_TXC, G2_RXD0, G2_RXD1, G2_RXD2,
-                   G2_RXD3, G2_RXDV, G2_RXC, NCEB, NWEB, NREB, NDL4, NDL5, NDL6,
-                   NDL7, NRB, NCLE, NALE, NDL0, NDL1, NDL2, NDL3, MDI_TP_P0,
-                   MDI_TN_P0, MDI_RP_P0, MDI_RN_P0, MDI_TP_P1, MDI_TN_P1,
-                   MDI_RP_P1, MDI_RN_P1, MDI_RP_P2, MDI_RN_P2, MDI_TP_P2,
-                   MDI_TN_P2, MDI_TP_P3, MDI_TN_P3, MDI_RP_P3, MDI_RN_P3,
-                   MDI_RP_P4, MDI_RN_P4, MDI_TP_P4, MDI_TN_P4, PMIC_SCL,
-                   PMIC_SDA, SPIC1_CLK, SPIC1_MOSI, SPIC1_MISO, SPIC1_CS,
-                   GPIO_D, WATCHDOG, RTS3_N, CTS3_N, TXD3, RXD3, PERST0_N,
-                   PERST1_N, WLED_N, EPHY_LED0_N, AUXIN0, AUXIN1, AUXIN2,
-                   AUXIN3, TXD4, RXD4, RTS4_N, CST4_N, PWM1, PWM2, PWM3, PWM4,
-                   PWM5, PWM6, PWM7, GPIO_E, TOP_5G_CLK, TOP_5G_DATA,
-                   WF0_5G_HB0, WF0_5G_HB1, WF0_5G_HB2, WF0_5G_HB3, WF0_5G_HB4,
-                   WF0_5G_HB5, WF0_5G_HB6, XO_REQ, TOP_RST_N, SYS_WATCHDOG,
-                   EPHY_LED0_N_JTDO, EPHY_LED1_N_JTDI, EPHY_LED2_N_JTMS,
-                   EPHY_LED3_N_JTCLK, EPHY_LED4_N_JTRST_N, WF2G_LED_N,
-                   WF5G_LED_N, GPIO_9, GPIO_10, GPIO_11, GPIO_12, UART1_TXD,
-                   UART1_RXD, UART1_CTS, UART1_RTS, UART2_TXD, UART2_RXD,
-                   UART2_CTS, UART2_RTS, SMI_MDC, SMI_MDIO, PCIE_PERESET_N,
-                   PWM_0, GPIO_0, GPIO_1, GPIO_2, GPIO_3, GPIO_4, GPIO_5,
-                   GPIO_6, GPIO_7, GPIO_8, UART0_TXD, UART0_RXD, TOP_2G_CLK,
-                   TOP_2G_DATA, WF0_2G_HB0, WF0_2G_HB1, WF0_2G_HB2, WF0_2G_HB3,
-                   WF0_2G_HB4, WF0_2G_HB5, WF0_2G_HB6]
+            items:
+              enum: [GPIO_A, I2S1_IN, I2S1_OUT, I2S_BCLK, I2S_WS, I2S_MCLK, TXD0,
+                     RXD0, SPI_WP, SPI_HOLD, SPI_CLK, SPI_MOSI, SPI_MISO, SPI_CS,
+                     I2C_SDA, I2C_SCL, I2S2_IN, I2S3_IN, I2S4_IN, I2S2_OUT,
+                     I2S3_OUT, I2S4_OUT, GPIO_B, MDC, MDIO, G2_TXD0, G2_TXD1,
+                     G2_TXD2, G2_TXD3, G2_TXEN, G2_TXC, G2_RXD0, G2_RXD1, G2_RXD2,
+                     G2_RXD3, G2_RXDV, G2_RXC, NCEB, NWEB, NREB, NDL4, NDL5, NDL6,
+                     NDL7, NRB, NCLE, NALE, NDL0, NDL1, NDL2, NDL3, MDI_TP_P0,
+                     MDI_TN_P0, MDI_RP_P0, MDI_RN_P0, MDI_TP_P1, MDI_TN_P1,
+                     MDI_RP_P1, MDI_RN_P1, MDI_RP_P2, MDI_RN_P2, MDI_TP_P2,
+                     MDI_TN_P2, MDI_TP_P3, MDI_TN_P3, MDI_RP_P3, MDI_RN_P3,
+                     MDI_RP_P4, MDI_RN_P4, MDI_TP_P4, MDI_TN_P4, PMIC_SCL,
+                     PMIC_SDA, SPIC1_CLK, SPIC1_MOSI, SPIC1_MISO, SPIC1_CS,
+                     GPIO_D, WATCHDOG, RTS3_N, CTS3_N, TXD3, RXD3, PERST0_N,
+                     PERST1_N, WLED_N, EPHY_LED0_N, AUXIN0, AUXIN1, AUXIN2,
+                     AUXIN3, TXD4, RXD4, RTS4_N, CST4_N, PWM1, PWM2, PWM3, PWM4,
+                     PWM5, PWM6, PWM7, GPIO_E, TOP_5G_CLK, TOP_5G_DATA,
+                     WF0_5G_HB0, WF0_5G_HB1, WF0_5G_HB2, WF0_5G_HB3, WF0_5G_HB4,
+                     WF0_5G_HB5, WF0_5G_HB6, XO_REQ, TOP_RST_N, SYS_WATCHDOG,
+                     EPHY_LED0_N_JTDO, EPHY_LED1_N_JTDI, EPHY_LED2_N_JTMS,
+                     EPHY_LED3_N_JTCLK, EPHY_LED4_N_JTRST_N, WF2G_LED_N,
+                     WF5G_LED_N, GPIO_9, GPIO_10, GPIO_11, GPIO_12, UART1_TXD,
+                     UART1_RXD, UART1_CTS, UART1_RTS, UART2_TXD, UART2_RXD,
+                     UART2_CTS, UART2_RTS, SMI_MDC, SMI_MDIO, PCIE_PERESET_N,
+                     PWM_0, GPIO_0, GPIO_1, GPIO_2, GPIO_3, GPIO_4, GPIO_5,
+                     GPIO_6, GPIO_7, GPIO_8, UART0_TXD, UART0_RXD, TOP_2G_CLK,
+                     TOP_2G_DATA, WF0_2G_HB0, WF0_2G_HB1, WF0_2G_HB2, WF0_2G_HB3,
+                     WF0_2G_HB4, WF0_2G_HB5, WF0_2G_HB6]
 
           bias-disable: true
 
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index dfebf425ca49..8fe31a7083db 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -141,6 +141,7 @@ allOf:
           unevaluatedProperties: false
 
         pcie-phy:
+          type: object
           description:
             Documentation/devicetree/bindings/phy/rockchip-pcie-phy.txt
 
diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index 41a62fd2ae1f..c1fa379f5f3e 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -20,6 +20,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -68,6 +73,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
diff --git a/Documentation/driver-api/fpga/fpga-region.rst b/Documentation/driver-api/fpga/fpga-region.rst
index 2636a27c11b2..2d03b5fb7657 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -46,10 +46,16 @@ API to add a new FPGA region
 ----------------------------
 
 * struct fpga_region - The FPGA region struct
-* devm_fpga_region_create() - Allocate and init a region struct
-* fpga_region_register() -  Register an FPGA region
+* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
+* __fpga_region_register_full() -  Create and register an FPGA region using the
+  fpga_region_info structure to provide the full flexibility of options
+* __fpga_region_register() -  Create and register an FPGA region using standard
+  arguments
 * fpga_region_unregister() -  Unregister an FPGA region
 
+Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
+automatically set the module that registers the FPGA region as the owner.
+
 The FPGA region's probe function will need to get a reference to the FPGA
 Manager it will be using to do the programming.  This usually would happen
 during the region's probe function.
@@ -75,11 +81,14 @@ following APIs to handle building or tearing down that list.
 .. kernel-doc:: include/linux/fpga/fpga-region.h
    :functions: fpga_region
 
+.. kernel-doc:: include/linux/fpga/fpga-region.h
+   :functions: fpga_region_info
+
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: devm_fpga_region_create
+   :functions: __fpga_region_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register
+   :functions: __fpga_region_register
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_unregister
diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 01b2a69b0cb0..a8a2aa2ae897 100644
--- a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
+++ b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
@@ -205,6 +205,7 @@ Adaptive coalescing can be switched on/off through `ethtool(8)`'s
 More information about Adaptive Interrupt Moderation (DIM) can be found in
 Documentation/networking/net_dim.rst
 
+.. _`RX copybreak`:
 RX copybreak
 ============
 The rx_copybreak is initialized by default to ENA_DEFAULT_RX_COPYBREAK
@@ -315,3 +316,34 @@ Rx
 - The new SKB is updated with the necessary information (protocol,
   checksum hw verify result, etc), and then passed to the network
   stack, using the NAPI interface function :code:`napi_gro_receive()`.
+
+Dynamic RX Buffers (DRB)
+------------------------
+
+Each RX descriptor in the RX ring is a single memory page (which is either 4KB
+or 16KB long depending on system's configurations).
+To reduce the memory allocations required when dealing with a high rate of small
+packets, the driver tries to reuse the remaining RX descriptor's space if more
+than 2KB of this page remain unused.
+
+A simple example of this mechanism is the following sequence of events:
+
+::
+
+        1. Driver allocates page-sized RX buffer and passes it to hardware
+                +----------------------+
+                |4KB RX Buffer         |
+                +----------------------+
+
+        2. A 300Bytes packet is received on this buffer
+
+        3. The driver increases the ref count on this page and returns it back to
+           HW as an RX buffer of size 4KB - 300Bytes = 3796 Bytes
+               +----+--------------------+
+               |****|3796 Bytes RX Buffer|
+               +----+--------------------+
+
+This mechanism isn't used when an XDP program is loaded, or when the
+RX packet is less than rx_copybreak bytes (in which case the packet is
+copied out of the RX buffer into the linear part of a new skb allocated
+for it and the RX buffer remains the same size, see `RX copybreak`_).
diff --git a/Makefile b/Makefile
index bfc863d71978..730bbf583015 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 160
+SUBLEVEL = 161
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index a83b9d4f172e..add54f4e7be9 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -58,7 +58,7 @@ cpu@3 {
 	gic: interrupt-controller@f1001000 {
 		compatible = "arm,gic-400";
 		reg = <0x0 0xf1001000 0x0 0x1000>,  /* GICD */
-		      <0x0 0xf1002000 0x0 0x100>;   /* GICC */
+		      <0x0 0xf1002000 0x0 0x2000>;  /* GICC */
 		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index 6e5f8465669e..a5ff8cfedf34 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -9,8 +9,8 @@ / {
 	compatible = "nvidia,norrin", "nvidia,tegra132", "nvidia,tegra124";
 
 	aliases {
-		rtc0 = "/i2c@7000d000/as3722@40";
-		rtc1 = "/rtc@7000e000";
+		rtc0 = &as3722;
+		rtc1 = &tegra_rtc;
 		serial0 = &uarta;
 	};
 
diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index b0bcda8cc51f..5bfd497f6367 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -573,7 +573,7 @@ spi@7000de00 {
 		status = "disabled";
 	};
 
-	rtc@7000e000 {
+	tegra_rtc: rtc@7000e000 {
 		compatible = "nvidia,tegra124-rtc", "nvidia,tegra20-rtc";
 		reg = <0x0 0x7000e000 0x0 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
index a80c578484ba..b6d70d0073e7 100644
--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -60,7 +60,7 @@ bluetooth {
 		vddrf-supply = <&vreg_l1_1p3>;
 		vddch0-supply = <&vdd_ch0_3p3>;
 
-		local-bd-address = [ 02 00 00 00 5a ad ];
+		local-bd-address = [ 00 00 00 00 00 00 ];
 
 		max-speed = <3200000>;
 	};
diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 03f52f84a4f3..bc2dcc8a0000 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -28,6 +28,7 @@
 	14470:	.long 14471f - 14470b;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
+		.align 2;				\
 		.popsection;				\
 	14471:
 #else
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 94108e2e0917..05d3f772a9b9 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -250,6 +250,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 		case PSR_AA32_MODE_SVC:
 		case PSR_AA32_MODE_ABT:
 		case PSR_AA32_MODE_UND:
+		case PSR_AA32_MODE_SYS:
 			if (!vcpu_el1_is_32bit(vcpu))
 				return -EINVAL;
 			break;
@@ -270,7 +271,7 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	if (*vcpu_cpsr(vcpu) & PSR_MODE32_BIT) {
 		int i, nr_reg;
 
-		switch (*vcpu_cpsr(vcpu)) {
+		switch (*vcpu_cpsr(vcpu) & PSR_AA32_MODE_MASK) {
 		/*
 		 * Either we are dealing with user mode, and only the
 		 * first 15 registers (+ PC) must be narrowed to 32bit.
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 9f3663facaa0..198c4c919c67 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -430,7 +430,9 @@ resume:
 	movec	%a0,%dfc
 
 	/* restore status register */
-	movew	%a1@(TASK_THREAD+THREAD_SR),%sr
+	movew	%a1@(TASK_THREAD+THREAD_SR),%d0
+	oriw	#0x0700,%d0
+	movew	%d0,%sr
 
 	rts
 
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 4fab34791758..060394b00037 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -451,30 +451,18 @@ void mac_poweroff(void)
 
 void mac_reset(void)
 {
-	if (macintosh_config->adb_type == MAC_ADB_II &&
-	    macintosh_config->ident != MAC_MODEL_SE30) {
-		/* need ROMBASE in booter */
-		/* indeed, plus need to MAP THE ROM !! */
-
-		if (mac_bi_data.rombase == 0)
-			mac_bi_data.rombase = 0x40800000;
-
-		/* works on some */
-		rom_reset = (void *) (mac_bi_data.rombase + 0xa);
-
-		local_irq_disable();
-		rom_reset();
 #ifdef CONFIG_ADB_CUDA
-	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
-	           macintosh_config->adb_type == MAC_ADB_CUDA) {
+	if (macintosh_config->adb_type == MAC_ADB_EGRET ||
+	    macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
+	} else
 #endif
 #ifdef CONFIG_ADB_PMU
-	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
+	if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
+	} else
 #endif
-	} else if (CPU_IS_030) {
-
+	if (CPU_IS_030) {
 		/* 030-specific reset routine.  The idea is general, but the
 		 * specific registers to reset are '030-specific.  Until I
 		 * have a non-030 machine, I can't test anything else.
@@ -522,6 +510,18 @@ void mac_reset(void)
 		    "jmp %/a0@\n\t" /* jump to the reset vector */
 		    ".chip 68k"
 		    : : "r" (offset), "a" (rombase) : "a0");
+	} else {
+		/* need ROMBASE in booter */
+		/* indeed, plus need to MAP THE ROM !! */
+
+		if (mac_bi_data.rombase == 0)
+			mac_bi_data.rombase = 0x40800000;
+
+		/* works on some */
+		rom_reset = (void *)(mac_bi_data.rombase + 0xa);
+
+		local_irq_disable();
+		rom_reset();
 	}
 
 	/* should never get here */
diff --git a/arch/microblaze/kernel/Makefile b/arch/microblaze/kernel/Makefile
index 15a20eb814ce..46dcc3b6a00f 100644
--- a/arch/microblaze/kernel/Makefile
+++ b/arch/microblaze/kernel/Makefile
@@ -7,7 +7,6 @@ ifdef CONFIG_FUNCTION_TRACER
 # Do not trace early boot code and low level code
 CFLAGS_REMOVE_timer.o = -pg
 CFLAGS_REMOVE_intc.o = -pg
-CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_process.o = -pg
 endif
diff --git a/arch/microblaze/kernel/cpu/cpuinfo-static.c b/arch/microblaze/kernel/cpu/cpuinfo-static.c
index 85dbda4a08a8..03da36dc6d9c 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo-static.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo-static.c
@@ -18,7 +18,7 @@ static const char family_string[] = CONFIG_XILINX_MICROBLAZE0_FAMILY;
 static const char cpu_ver_string[] = CONFIG_XILINX_MICROBLAZE0_HW_VER;
 
 #define err_printk(x) \
-	early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
+	pr_err("ERROR: Microblaze " x "-different for kernel and DTS\n");
 
 void __init set_cpuinfo_static(struct cpuinfo *ci, struct device_node *cpu)
 {
diff --git a/arch/parisc/kernel/parisc_ksyms.c b/arch/parisc/kernel/parisc_ksyms.c
index 00297e8e1c88..317508493b81 100644
--- a/arch/parisc/kernel/parisc_ksyms.c
+++ b/arch/parisc/kernel/parisc_ksyms.c
@@ -21,6 +21,7 @@ EXPORT_SYMBOL(memset);
 #include <linux/atomic.h>
 EXPORT_SYMBOL(__xchg8);
 EXPORT_SYMBOL(__xchg32);
+EXPORT_SYMBOL(__cmpxchg_u8);
 EXPORT_SYMBOL(__cmpxchg_u32);
 EXPORT_SYMBOL(__cmpxchg_u64);
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 9bcf345cb208..c25f160bb997 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -513,7 +513,7 @@ struct hvcall_mpp_data {
 	unsigned long backing_mem;
 };
 
-int h_get_mpp(struct hvcall_mpp_data *);
+long h_get_mpp(struct hvcall_mpp_data *mpp_data);
 
 struct hvcall_mpp_x_data {
 	unsigned long coalesced_bytes;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6c196b941355..c2fff9a33928 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1886,10 +1886,10 @@ notrace void __trace_hcall_exit(long opcode, long retval, unsigned long *retbuf)
  * h_get_mpp
  * H_GET_MPP hcall returns info in 7 parms
  */
-int h_get_mpp(struct hvcall_mpp_data *mpp_data)
+long h_get_mpp(struct hvcall_mpp_data *mpp_data)
 {
-	int rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	long rc;
 
 	rc = plpar_hcall9(H_GET_MPP, retbuf);
 
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index a291b5a94d4d..fea4dfa54e3c 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -112,8 +112,8 @@ struct hvcall_ppp_data {
  */
 static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
-	unsigned long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	long rc;
 
 	rc = plpar_hcall9(H_GET_PPP, retbuf);
 
@@ -192,7 +192,7 @@ static void parse_ppp_data(struct seq_file *m)
 	struct hvcall_ppp_data ppp_data;
 	struct device_node *root;
 	const __be32 *perf_level;
-	int rc;
+	long rc;
 
 	rc = h_get_ppp(&ppp_data);
 	if (rc)
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index c55ccec0a169..d9d366829370 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -569,10 +569,12 @@ static const struct fsl_msi_feature ipic_msi_feature = {
 	.msiir_offset = 0x38,
 };
 
+#ifdef CONFIG_EPAPR_PARAVIRT
 static const struct fsl_msi_feature vmpic_msi_feature = {
 	.fsl_pic_ip = FSL_PIC_IP_VMPIC,
 	.msiir_offset = 0,
 };
+#endif
 
 static const struct of_device_id fsl_of_msi_ids[] = {
 	{
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 5ca2860cc06c..851c967c49cc 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -231,7 +231,7 @@ ret_from_syscall_rejected:
 	andi t0, t0, _TIF_SYSCALL_WORK
 	bnez t0, handle_syscall_trace_exit
 
-ret_from_exception:
+SYM_CODE_START_NOALIGN(ret_from_exception)
 	REG_L s0, PT_STATUS(sp)
 	csrc CSR_STATUS, SR_IE
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -245,6 +245,7 @@ ret_from_exception:
 	andi s0, s0, SR_SPP
 #endif
 	bnez s0, resume_kernel
+SYM_CODE_END(ret_from_exception)
 
 resume_userspace:
 	/* Interrupts must be disabled here so flags are checked atomically */
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 894ae66421a7..94721c484d63 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -18,6 +18,18 @@ register unsigned long sp_in_global __asm__("sp");
 
 #ifdef CONFIG_FRAME_POINTER
 
+extern asmlinkage void ret_from_exception(void);
+
+static inline int fp_is_valid(unsigned long fp, unsigned long sp)
+{
+	unsigned long low, high;
+
+	low = sp + sizeof(struct stackframe);
+	high = ALIGN(sp, THREAD_SIZE);
+
+	return !(fp < low || fp > high || fp & 0x07);
+}
+
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
@@ -41,27 +53,32 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 
 	for (;;) {
-		unsigned long low, high;
 		struct stackframe *frame;
 
 		if (unlikely(!__kernel_text_address(pc) || (level++ >= 0 && !fn(arg, pc))))
 			break;
 
-		/* Validate frame pointer */
-		low = sp + sizeof(struct stackframe);
-		high = ALIGN(sp, THREAD_SIZE);
-		if (unlikely(fp < low || fp > high || fp & 0x7))
+		if (unlikely(!fp_is_valid(fp, sp)))
 			break;
+
 		/* Unwind stack frame */
 		frame = (struct stackframe *)fp - 1;
 		sp = fp;
-		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
+		if (regs && (regs->epc == pc) && fp_is_valid(frame->ra, sp)) {
+			/* We hit function where ra is not saved on the stack */
 			fp = frame->ra;
 			pc = regs->ra;
 		} else {
 			fp = frame->fp;
 			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 						   &frame->ra);
+			if (pc == (unsigned long)ret_from_exception) {
+				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
+					break;
+
+				pc = ((struct pt_regs *)sp)->epc;
+				fp = ((struct pt_regs *)sp)->s0;
+			}
 		}
 
 	}
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 1aa11a8f57dd..05fed61c5e3b 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -27,7 +27,6 @@ int __bootdata(is_full_image) = 1;
 struct initrd_data __bootdata(initrd_data);
 
 u64 __bootdata_preserved(stfle_fac_list[16]);
-u64 __bootdata_preserved(alt_stfle_fac_list[16]);
 struct oldmem_data __bootdata_preserved(oldmem_data);
 
 void error(char *x)
diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index 646b12981f20..0f6ff2008a15 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -161,28 +161,86 @@
 
 typedef struct { unsigned char bytes[16]; } cpacf_mask_t;
 
-/**
- * cpacf_query() - check if a specific CPACF function is available
- * @opcode: the opcode of the crypto instruction
- * @func: the function code to test for
- *
- * Executes the query function for the given crypto instruction @opcode
- * and checks if @func is available
- *
- * Returns 1 if @func is available for @opcode, 0 otherwise
+/*
+ * Prototype for a not existing function to produce a link
+ * error if __cpacf_query() or __cpacf_check_opcode() is used
+ * with an invalid compile time const opcode.
  */
-static __always_inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
+void __cpacf_bad_opcode(void);
+
+static __always_inline void __cpacf_query_rre(u32 opc, u8 r1, u8 r2,
+					      cpacf_mask_t *mask)
 {
 	asm volatile(
-		"	lghi	0,0\n" /* query function */
-		"	lgr	1,%[mask]\n"
-		"	spm	0\n" /* pckmo doesn't change the cc */
-		/* Parameter regs are ignored, but must be nonzero and unique */
-		"0:	.insn	rrf,%[opc] << 16,2,4,6,0\n"
-		"	brc	1,0b\n"	/* handle partial completion */
-		: "=m" (*mask)
-		: [mask] "d" ((unsigned long)mask), [opc] "i" (opcode)
-		: "cc", "0", "1");
+		"	la	%%r1,%[mask]\n"
+		"	xgr	%%r0,%%r0\n"
+		"	.insn	rre,%[opc] << 16,%[r1],%[r2]\n"
+		: [mask] "=R" (*mask)
+		: [opc] "i" (opc),
+		  [r1] "i" (r1), [r2] "i" (r2)
+		: "cc", "r0", "r1");
+}
+
+static __always_inline void __cpacf_query_rrf(u32 opc,
+					      u8 r1, u8 r2, u8 r3, u8 m4,
+					      cpacf_mask_t *mask)
+{
+	asm volatile(
+		"	la	%%r1,%[mask]\n"
+		"	xgr	%%r0,%%r0\n"
+		"	.insn	rrf,%[opc] << 16,%[r1],%[r2],%[r3],%[m4]\n"
+		: [mask] "=R" (*mask)
+		: [opc] "i" (opc), [r1] "i" (r1), [r2] "i" (r2),
+		  [r3] "i" (r3), [m4] "i" (m4)
+		: "cc", "r0", "r1");
+}
+
+static __always_inline void __cpacf_query(unsigned int opcode,
+					  cpacf_mask_t *mask)
+{
+	switch (opcode) {
+	case CPACF_KDSA:
+		__cpacf_query_rre(CPACF_KDSA, 0, 2, mask);
+		break;
+	case CPACF_KIMD:
+		__cpacf_query_rre(CPACF_KIMD, 0, 2, mask);
+		break;
+	case CPACF_KLMD:
+		__cpacf_query_rre(CPACF_KLMD, 0, 2, mask);
+		break;
+	case CPACF_KM:
+		__cpacf_query_rre(CPACF_KM, 2, 4, mask);
+		break;
+	case CPACF_KMA:
+		__cpacf_query_rrf(CPACF_KMA, 2, 4, 6, 0, mask);
+		break;
+	case CPACF_KMAC:
+		__cpacf_query_rre(CPACF_KMAC, 0, 2, mask);
+		break;
+	case CPACF_KMC:
+		__cpacf_query_rre(CPACF_KMC, 2, 4, mask);
+		break;
+	case CPACF_KMCTR:
+		__cpacf_query_rrf(CPACF_KMCTR, 2, 4, 6, 0, mask);
+		break;
+	case CPACF_KMF:
+		__cpacf_query_rre(CPACF_KMF, 2, 4, mask);
+		break;
+	case CPACF_KMO:
+		__cpacf_query_rre(CPACF_KMO, 2, 4, mask);
+		break;
+	case CPACF_PCC:
+		__cpacf_query_rre(CPACF_PCC, 0, 0, mask);
+		break;
+	case CPACF_PCKMO:
+		__cpacf_query_rre(CPACF_PCKMO, 0, 0, mask);
+		break;
+	case CPACF_PRNO:
+		__cpacf_query_rre(CPACF_PRNO, 2, 4, mask);
+		break;
+	default:
+		__cpacf_bad_opcode();
+	}
 }
 
 static __always_inline int __cpacf_check_opcode(unsigned int opcode)
@@ -206,10 +264,21 @@ static __always_inline int __cpacf_check_opcode(unsigned int opcode)
 	case CPACF_KMA:
 		return test_facility(146);	/* check for MSA8 */
 	default:
-		BUG();
+		__cpacf_bad_opcode();
+		return 0;
 	}
 }
 
+/**
+ * cpacf_query() - check if a specific CPACF function is available
+ * @opcode: the opcode of the crypto instruction
+ * @func: the function code to test for
+ *
+ * Executes the query function for the given crypto instruction @opcode
+ * and checks if @func is available
+ *
+ * Returns 1 if @func is available for @opcode, 0 otherwise
+ */
 static __always_inline int cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 {
 	if (__cpacf_check_opcode(opcode)) {
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 834b1ec5dd7a..d2ba82873abf 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -833,8 +833,8 @@ static ssize_t reipl_nvme_scpdata_write(struct file *filp, struct kobject *kobj,
 		scpdata_len += padding;
 	}
 
-	reipl_block_nvme->hdr.len = IPL_BP_FCP_LEN + scpdata_len;
-	reipl_block_nvme->nvme.len = IPL_BP0_FCP_LEN + scpdata_len;
+	reipl_block_nvme->hdr.len = IPL_BP_NVME_LEN + scpdata_len;
+	reipl_block_nvme->nvme.len = IPL_BP0_NVME_LEN + scpdata_len;
 	reipl_block_nvme->nvme.scp_data_len = scpdata_len;
 
 	return count;
@@ -1603,9 +1603,9 @@ static int __init dump_nvme_init(void)
 	}
 	dump_block_nvme->hdr.len = IPL_BP_NVME_LEN;
 	dump_block_nvme->hdr.version = IPL_PARM_BLOCK_VERSION;
-	dump_block_nvme->fcp.len = IPL_BP0_NVME_LEN;
-	dump_block_nvme->fcp.pbt = IPL_PBT_NVME;
-	dump_block_nvme->fcp.opt = IPL_PB0_NVME_OPT_DUMP;
+	dump_block_nvme->nvme.len = IPL_BP0_NVME_LEN;
+	dump_block_nvme->nvme.pbt = IPL_PBT_NVME;
+	dump_block_nvme->nvme.opt = IPL_PB0_NVME_OPT_DUMP;
 	dump_capabilities |= DUMP_TYPE_NVME;
 	return 0;
 }
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index b7ce6c7c84c6..50cb4c3d3682 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -154,7 +154,7 @@ unsigned int __bootdata_preserved(zlib_dfltcc_support);
 EXPORT_SYMBOL(zlib_dfltcc_support);
 u64 __bootdata_preserved(stfle_fac_list[16]);
 EXPORT_SYMBOL(stfle_fac_list);
-u64 __bootdata_preserved(alt_stfle_fac_list[16]);
+u64 alt_stfle_fac_list[16];
 struct oldmem_data __bootdata_preserved(oldmem_data);
 
 unsigned long VMALLOC_START;
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index cc513add48eb..6056f2ae0263 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -20,7 +20,10 @@ KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS))
 KBUILD_AFLAGS_32 += -m31 -s
 
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
-KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin
+KBUILD_CFLAGS_32 := $(filter-out -mpacked-stack,$(KBUILD_CFLAGS))
+KBUILD_CFLAGS_32 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin -fasynchronous-unwind-tables
 
 LDFLAGS_vdso32.so.dbg += -shared -soname=linux-vdso32.so.1 \
 	--hash-style=both --build-id=sha1 -melf_s390 -T
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index 42d918d50a1f..498d56757c4d 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -25,7 +25,11 @@ KBUILD_AFLAGS_64 := $(filter-out -m64,$(KBUILD_AFLAGS))
 KBUILD_AFLAGS_64 += -m64 -s
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
-KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin
+KBUILD_CFLAGS_64 := $(filter-out -mpacked-stack,$(KBUILD_CFLAGS_64))
+KBUILD_CFLAGS_64 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_64))
+KBUILD_CFLAGS_64 := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_64))
+KBUILD_CFLAGS_64 := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_64))
+KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
 ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 1a374d021e25..88020b4ddbab 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1229,8 +1229,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 	EMIT6_DISP_LH(0xeb000000, is32 ? (op32) : (op64),		\
 		      (insn->imm & BPF_FETCH) ? src_reg : REG_W0,	\
 		      src_reg, dst_reg, off);				\
-	if (is32 && (insn->imm & BPF_FETCH))				\
-		EMIT_ZERO(src_reg);					\
+	if (insn->imm & BPF_FETCH) {					\
+		/* bcr 14,0 - see atomic_fetch_{add,and,or,xor}() */	\
+		_EMIT2(0x07e0);						\
+		if (is32)                                               \
+			EMIT_ZERO(src_reg);				\
+	}								\
 } while (0)
 		case BPF_ADD:
 		case BPF_ADD | BPF_FETCH:
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 1c7f358ef0be..5db45517bb1e 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -44,17 +44,12 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
 	if (OPCODE_RTE(opcode))
 		return -EFAULT;	/* Bad breakpoint */
 
+	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
 	p->opcode = opcode;
 
 	return 0;
 }
 
-void __kprobes arch_copy_kprobe(struct kprobe *p)
-{
-	memcpy(p->ainsn.insn, p->addr, MAX_INSN_SIZE * sizeof(kprobe_opcode_t));
-	p->opcode = *p->addr;
-}
-
 void __kprobes arch_arm_kprobe(struct kprobe *p)
 {
 	*p->addr = BREAKPOINT_INSTRUCTION;
diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
index 3e07074e0098..06fed5a21e8b 100644
--- a/arch/sh/lib/checksum.S
+++ b/arch/sh/lib/checksum.S
@@ -33,7 +33,8 @@
  */
 
 /*	
- * asmlinkage __wsum csum_partial(const void *buf, int len, __wsum sum);
+ * unsigned int csum_partial(const unsigned char *buf, int len,
+ *                           unsigned int sum);
  */
 
 .text
@@ -45,31 +46,11 @@ ENTRY(csum_partial)
 	   * Fortunately, it is easy to convert 2-byte alignment to 4-byte
 	   * alignment for the unrolled loop.
 	   */
+	mov	r5, r1
 	mov	r4, r0
-	tst	#3, r0		! Check alignment.
-	bt/s	2f		! Jump if alignment is ok.
-	 mov	r4, r7		! Keep a copy to check for alignment
+	tst	#2, r0		! Check alignment.
+	bt	2f		! Jump if alignment is ok.
 	!
-	tst	#1, r0		! Check alignment.
-	bt	21f		! Jump if alignment is boundary of 2bytes.
-
-	! buf is odd
-	tst	r5, r5
-	add	#-1, r5
-	bt	9f
-	mov.b	@r4+, r0
-	extu.b	r0, r0
-	addc	r0, r6		! t=0 from previous tst
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-	mov	r4, r0
-	tst	#2, r0
-	bt	2f
-21:
-	! buf is 2 byte aligned (len could be 0)
 	add	#-2, r5		! Alignment uses up two bytes.
 	cmp/pz	r5		!
 	bt/s	1f		! Jump if we had at least two bytes.
@@ -77,17 +58,16 @@ ENTRY(csum_partial)
 	bra	6f
 	 add	#2, r5		! r5 was < 2.  Deal with it.
 1:
+	mov	r5, r1		! Save new len for later use.
 	mov.w	@r4+, r0
 	extu.w	r0, r0
 	addc	r0, r6
 	bf	2f
 	add	#1, r6
 2:
-	! buf is 4 byte aligned (len could be 0)
-	mov	r5, r1
 	mov	#-5, r0
-	shld	r0, r1
-	tst	r1, r1
+	shld	r0, r5
+	tst	r5, r5
 	bt/s	4f		! if it's =0, go to 4f
 	 clrt
 	.align	2
@@ -109,31 +89,30 @@ ENTRY(csum_partial)
 	addc	r0, r6
 	addc	r2, r6
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	3b
 	 cmp/eq	#1, r0
-	! here, we know r1==0
-	addc	r1, r6			! add carry to r6
+	! here, we know r5==0
+	addc	r5, r6			! add carry to r6
 4:
-	mov	r5, r0
+	mov	r1, r0
 	and	#0x1c, r0
 	tst	r0, r0
-	bt	6f
-	! 4 bytes or more remaining
-	mov	r0, r1
-	shlr2	r1
+	bt/s	6f
+	 mov	r0, r5
+	shlr2	r5
 	mov	#0, r2
 5:
 	addc	r2, r6
 	mov.l	@r4+, r2
 	movt	r0
-	dt	r1
+	dt	r5
 	bf/s	5b
 	 cmp/eq	#1, r0
 	addc	r2, r6
-	addc	r1, r6		! r1==0 here, so it means add carry-bit
+	addc	r5, r6		! r5==0 here, so it means add carry-bit
 6:
-	! 3 bytes or less remaining
+	mov	r1, r5
 	mov	#3, r0
 	and	r0, r5
 	tst	r5, r5
@@ -159,16 +138,6 @@ ENTRY(csum_partial)
 	mov	#0, r0
 	addc	r0, r6
 9:
-	! Check if the buffer was misaligned, if so realign sum
-	mov	r7, r0
-	tst	#1, r0
-	bt	10f
-	mov	r6, r0
-	shll8	r6
-	shlr16	r0
-	shlr8	r0
-	or	r0, r6
-10:
 	rts
 	 mov	r6, r0
 
diff --git a/arch/sparc/include/asm/smp_64.h b/arch/sparc/include/asm/smp_64.h
index e75783b6abc4..16ab904616a0 100644
--- a/arch/sparc/include/asm/smp_64.h
+++ b/arch/sparc/include/asm/smp_64.h
@@ -47,7 +47,6 @@ void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 int hard_smp_processor_id(void);
 #define raw_smp_processor_id() (current_thread_info()->cpu)
 
-void smp_fill_in_cpu_possible_map(void);
 void smp_fill_in_sib_core_maps(void);
 void cpu_play_dead(void);
 
@@ -77,7 +76,6 @@ void __cpu_die(unsigned int cpu);
 #define smp_fill_in_sib_core_maps() do { } while (0)
 #define smp_fetch_global_regs() do { } while (0)
 #define smp_fetch_global_pmu() do { } while (0)
-#define smp_fill_in_cpu_possible_map() do { } while (0)
 #define smp_init_cpu_poke() do { } while (0)
 #define scheduler_poke() do { } while (0)
 
diff --git a/arch/sparc/include/uapi/asm/termbits.h b/arch/sparc/include/uapi/asm/termbits.h
index ce5ad5d0f105..0614e179bccc 100644
--- a/arch/sparc/include/uapi/asm/termbits.h
+++ b/arch/sparc/include/uapi/asm/termbits.h
@@ -13,16 +13,6 @@ typedef unsigned int    tcflag_t;
 typedef unsigned long   tcflag_t;
 #endif
 
-#define NCC 8
-struct termio {
-	unsigned short c_iflag;		/* input mode flags */
-	unsigned short c_oflag;		/* output mode flags */
-	unsigned short c_cflag;		/* control mode flags */
-	unsigned short c_lflag;		/* local mode flags */
-	unsigned char c_line;		/* line discipline */
-	unsigned char c_cc[NCC];	/* control characters */
-};
-
 #define NCCS 17
 struct termios {
 	tcflag_t c_iflag;		/* input mode flags */
diff --git a/arch/sparc/include/uapi/asm/termios.h b/arch/sparc/include/uapi/asm/termios.h
index ee86f4093d83..cceb32260881 100644
--- a/arch/sparc/include/uapi/asm/termios.h
+++ b/arch/sparc/include/uapi/asm/termios.h
@@ -40,5 +40,14 @@ struct winsize {
 	unsigned short ws_ypixel;
 };
 
+#define NCC 8
+struct termio {
+	unsigned short c_iflag;		/* input mode flags */
+	unsigned short c_oflag;		/* output mode flags */
+	unsigned short c_cflag;		/* control mode flags */
+	unsigned short c_lflag;		/* local mode flags */
+	unsigned char c_line;		/* line discipline */
+	unsigned char c_cc[NCC];	/* control characters */
+};
 
 #endif /* _UAPI_SPARC_TERMIOS_H */
diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index f883a50fa333..4eae633f7198 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -483,7 +483,9 @@ static void *record_one_cpu(struct device_node *dp, int cpuid, int arg)
 	ncpus_probed++;
 #ifdef CONFIG_SMP
 	set_cpu_present(cpuid, true);
-	set_cpu_possible(cpuid, true);
+
+	if (num_possible_cpus() < nr_cpu_ids)
+		set_cpu_possible(cpuid, true);
 #endif
 	return NULL;
 }
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 48abee4eee29..9e6e7f983d14 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -684,7 +684,6 @@ void __init setup_arch(char **cmdline_p)
 
 	paging_init();
 	init_sparc64_elf_hwcap();
-	smp_fill_in_cpu_possible_map();
 	/*
 	 * Once the OF device tree and MDESC have been setup and nr_cpus has
 	 * been parsed, we know the list of possible cpus.  Therefore we can
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index 0224d8f19ed6..1414efd49761 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1210,20 +1210,6 @@ void __init smp_setup_processor_id(void)
 		xcall_deliver_impl = hypervisor_xcall_deliver;
 }
 
-void __init smp_fill_in_cpu_possible_map(void)
-{
-	int possible_cpus = num_possible_cpus();
-	int i;
-
-	if (possible_cpus > nr_cpu_ids)
-		possible_cpus = nr_cpu_ids;
-
-	for (i = 0; i < possible_cpus; i++)
-		set_cpu_possible(i, true);
-	for (; i < NR_CPUS; i++)
-		set_cpu_possible(i, false);
-}
-
 void smp_fill_in_sib_core_maps(void)
 {
 	unsigned int i;
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 02b0befd6763..95ad6b190d1d 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -673,24 +673,26 @@ void register_winch_irq(int fd, int tty_fd, int pid, struct tty_port *port,
 		goto cleanup;
 	}
 
-	*winch = ((struct winch) { .list  	= LIST_HEAD_INIT(winch->list),
-				   .fd  	= fd,
+	*winch = ((struct winch) { .fd  	= fd,
 				   .tty_fd 	= tty_fd,
 				   .pid  	= pid,
 				   .port 	= port,
 				   .stack	= stack });
 
+	spin_lock(&winch_handler_lock);
+	list_add(&winch->list, &winch_handlers);
+	spin_unlock(&winch_handler_lock);
+
 	if (um_request_irq(WINCH_IRQ, fd, IRQ_READ, winch_interrupt,
 			   IRQF_SHARED, "winch", winch) < 0) {
 		printk(KERN_ERR "register_winch_irq - failed to register "
 		       "IRQ\n");
+		spin_lock(&winch_handler_lock);
+		list_del(&winch->list);
+		spin_unlock(&winch_handler_lock);
 		goto out_free;
 	}
 
-	spin_lock(&winch_handler_lock);
-	list_add(&winch->list, &winch_handlers);
-	spin_unlock(&winch_handler_lock);
-
 	return;
 
  out_free:
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index fefd343412c7..b3a4cc5a2091 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1097,7 +1097,7 @@ static int __init ubd_init(void)
 
 	if (irq_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	io_req_buffer = kmalloc_array(UBD_REQ_BUFFER_SIZE,
 				      sizeof(struct io_thread_req *),
@@ -1108,7 +1108,7 @@ static int __init ubd_init(void)
 
 	if (io_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	platform_driver_register(&ubd_driver);
 	mutex_lock(&ubd_lock);
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 45a4bcd27a39..310fb14a85f7 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -141,7 +141,7 @@ static bool get_bpf_flash(struct arglist *def)
 
 	if (allow != NULL) {
 		if (kstrtoul(allow, 10, &result) == 0)
-			return (allow > 0);
+			return result > 0;
 	}
 	return false;
 }
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 5b072aba5b65..a7cb380c0b5c 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -15,8 +15,6 @@ typedef struct mm_context {
 	struct page *stub_pages[2];
 } mm_context_t;
 
-extern void __switch_mm(struct mm_id * mm_idp);
-
 /* Avoid tangled inclusion with asm/ldt.h */
 extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
 extern void free_ldt(struct mm_context *mm);
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index e82e203f5f41..92dbf727e384 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -15,4 +15,6 @@ struct mm_id {
 	int kill;
 };
 
+void __switch_mm(struct mm_id *mm_idp);
+
 #endif
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index d4d6db4dde22..5d72d52fbc1b 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -249,6 +249,7 @@ config UNWINDER_ORC
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
+	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
 	  This option enables the frame pointer unwinder for unwinding kernel
@@ -272,7 +273,3 @@ config UNWINDER_GUESS
 	  overhead.
 
 endchoice
-
-config FRAME_POINTER
-	depends on !UNWINDER_ORC && !UNWINDER_GUESS
-	bool
diff --git a/arch/x86/crypto/nh-avx2-x86_64.S b/arch/x86/crypto/nh-avx2-x86_64.S
index 6a0b15e7196a..54c0ee41209d 100644
--- a/arch/x86/crypto/nh-avx2-x86_64.S
+++ b/arch/x86/crypto/nh-avx2-x86_64.S
@@ -153,5 +153,6 @@ SYM_FUNC_START(nh_avx2)
 	vpaddq		T1, T0, T0
 	vpaddq		T4, T0, T0
 	vmovdqu		T0, (HASH)
+	vzeroupper
 	RET
 SYM_FUNC_END(nh_avx2)
diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
index 9bcdbc47b8b4..f7d728776855 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -710,6 +710,7 @@ done_hash:
 	popq	%r13
 	popq	%r12
 	popq	%rbx
+	vzeroupper
 	RET
 SYM_FUNC_END(sha256_transform_rorx)
 
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index 5cdaab7d6901..1c4e5d88e167 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -679,6 +679,7 @@ done_hash:
 	pop	%r12
 	pop	%rbx
 
+	vzeroupper
 	RET
 SYM_FUNC_END(sha512_transform_rorx)
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index fd2ee9408e91..ba3172d5b328 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -98,11 +98,6 @@ static int addr_to_vsyscall_nr(unsigned long addr)
 
 static bool write_ok_or_segv(unsigned long ptr, size_t size)
 {
-	/*
-	 * XXX: if access_ok, get_user, and put_user handled
-	 * sig_on_uaccess_err, this could go away.
-	 */
-
 	if (!access_ok((void __user *)ptr, size)) {
 		struct thread_struct *thread = &current->thread;
 
@@ -120,10 +115,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 bool emulate_vsyscall(unsigned long error_code,
 		      struct pt_regs *regs, unsigned long address)
 {
-	struct task_struct *tsk;
 	unsigned long caller;
 	int vsyscall_nr, syscall_nr, tmp;
-	int prev_sig_on_uaccess_err;
 	long ret;
 	unsigned long orig_dx;
 
@@ -172,8 +165,6 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto sigsegv;
 	}
 
-	tsk = current;
-
 	/*
 	 * Check for access_ok violations and find the syscall nr.
 	 *
@@ -234,12 +225,8 @@ bool emulate_vsyscall(unsigned long error_code,
 		goto do_ret;  /* skip requested */
 
 	/*
-	 * With a real vsyscall, page faults cause SIGSEGV.  We want to
-	 * preserve that behavior to make writing exploits harder.
+	 * With a real vsyscall, page faults cause SIGSEGV.
 	 */
-	prev_sig_on_uaccess_err = current->thread.sig_on_uaccess_err;
-	current->thread.sig_on_uaccess_err = 1;
-
 	ret = -EFAULT;
 	switch (vsyscall_nr) {
 	case 0:
@@ -262,23 +249,12 @@ bool emulate_vsyscall(unsigned long error_code,
 		break;
 	}
 
-	current->thread.sig_on_uaccess_err = prev_sig_on_uaccess_err;
-
 check_fault:
 	if (ret == -EFAULT) {
 		/* Bad news -- userspace fed a bad pointer to a vsyscall. */
 		warn_bad_vsyscall(KERN_INFO, regs,
 				  "vsyscall fault (exploit attempt?)");
-
-		/*
-		 * If we failed to generate a signal for any reason,
-		 * generate one here.  (This should be impossible.)
-		 */
-		if (WARN_ON_ONCE(!sigismember(&tsk->pending.signal, SIGBUS) &&
-				 !sigismember(&tsk->pending.signal, SIGSEGV)))
-			goto sigsegv;
-
-		return true;  /* Don't emulate the ret. */
+		goto sigsegv;
 	}
 
 	regs->ax = ret;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index bbbf27cfe701..0702e0c5dbb8 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -519,7 +519,6 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
-	unsigned int		sig_on_uaccess_err:1;
 
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index c132daabe615..fb539244c546 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -982,7 +982,8 @@ static void __send_cleanup_vector(struct apic_chip_data *apicd)
 		hlist_add_head(&apicd->clist, per_cpu_ptr(&cleanup_list, cpu));
 		apic->send_IPI(cpu, IRQ_MOVE_CLEANUP_VECTOR);
 	} else {
-		apicd->prev_vector = 0;
+		pr_warn("IRQ %u schedule cleanup for offline CPU %u\n", apicd->irq, cpu);
+		free_moved_vector(apicd);
 	}
 	raw_spin_unlock(&vector_lock);
 }
@@ -1019,6 +1020,7 @@ void irq_complete_move(struct irq_cfg *cfg)
  */
 void irq_force_complete_move(struct irq_desc *desc)
 {
+	unsigned int cpu = smp_processor_id();
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
 	unsigned int vector;
@@ -1043,10 +1045,11 @@ void irq_force_complete_move(struct irq_desc *desc)
 		goto unlock;
 
 	/*
-	 * If prev_vector is empty, no action required.
+	 * If prev_vector is empty or the descriptor is neither currently
+	 * nor previously on the outgoing CPU no action required.
 	 */
 	vector = apicd->prev_vector;
-	if (!vector)
+	if (!vector || (apicd->cpu != cpu && apicd->prev_cpu != cpu))
 		goto unlock;
 
 	/*
diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 9452dc9664b5..7a1e3f53be24 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -192,11 +192,9 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	cur->warned = false;
 
 	/*
-	 * If a non-zero TSC value for socket 0 may be valid then the default
-	 * adjusted value cannot assumed to be zero either.
+	 * The default adjust value cannot be assumed to be zero on any socket.
 	 */
-	if (tsc_async_resets)
-		cur->adjusted = bootval;
+	cur->adjusted = bootval;
 
 	/*
 	 * Check whether this CPU is the first in a package to come up. In
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 6222aa3221f5..786584a9904c 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -934,9 +934,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = 0;
 		break;
 	case 0x80000008: {
-		unsigned g_phys_as = (entry->eax >> 16) & 0xff;
-		unsigned virt_as = max((entry->eax >> 8) & 0xff, 48U);
-		unsigned phys_as = entry->eax & 0xff;
+		unsigned int virt_as = max((entry->eax >> 8) & 0xff, 48U);
+		unsigned int phys_as;
 
 		/*
 		 * If TDP (NPT) is disabled use the adjusted host MAXPHYADDR as
@@ -944,16 +943,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		 * reductions in MAXPHYADDR for memory encryption affect shadow
 		 * paging, too.
 		 *
-		 * If TDP is enabled but an explicit guest MAXPHYADDR is not
-		 * provided, use the raw bare metal MAXPHYADDR as reductions to
-		 * the HPAs do not affect GPAs.
+		 * If TDP is enabled, use the raw bare metal MAXPHYADDR as
+		 * reductions to the HPAs do not affect GPAs.
 		 */
-		if (!tdp_enabled)
-			g_phys_as = boot_cpu_data.x86_phys_bits;
-		else if (!g_phys_as)
-			g_phys_as = phys_as;
+		if (!tdp_enabled) {
+			phys_as = boot_cpu_data.x86_phys_bits;
+		} else {
+			phys_as = entry->eax & 0xff;
+		}
 
-		entry->eax = g_phys_as | (virt_as << 8);
+		entry->eax = phys_as | (virt_as << 8);
 		entry->ecx &= ~(GENMASK(31, 16) | GENMASK(11, 8));
 		entry->edx = 0;
 		cpuid_entry_override(entry, CPUID_8000_0008_EBX);
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..1c25c1072a84 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index abc6fbc3d5f2..31afd82b9524 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -716,39 +716,8 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
 	WARN_ON_ONCE(user_mode(regs));
 
 	/* Are we prepared to handle this kernel fault? */
-	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
-		/*
-		 * Any interrupt that takes a fault gets the fixup. This makes
-		 * the below recursive fault logic only apply to a faults from
-		 * task context.
-		 */
-		if (in_interrupt())
-			return;
-
-		/*
-		 * Per the above we're !in_interrupt(), aka. task context.
-		 *
-		 * In this case we need to make sure we're not recursively
-		 * faulting through the emulate_vsyscall() logic.
-		 */
-		if (current->thread.sig_on_uaccess_err && signal) {
-			sanitize_error_code(address, &error_code);
-
-			set_signal_archinfo(address, error_code);
-
-			if (si_code == SEGV_PKUERR) {
-				force_sig_pkuerr((void __user *)address, pkey);
-			} else {
-				/* XXX: hwpoison faults will set the wrong code. */
-				force_sig_fault(signal, si_code, (void __user *)address);
-			}
-		}
-
-		/*
-		 * Barring that, we can do the fixup and be happy.
-		 */
+	if (fixup_exception(regs, X86_TRAP_PF, error_code, address))
 		return;
-	}
 
 	/*
 	 * AMD erratum #91 manifests as a spurious page fault on a PREFETCH
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 7a7701d1e18d..59373a4abfb4 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -41,7 +41,8 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 3167228ca174..d7549953bb79 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -692,6 +692,15 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
 		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC)) {
 			continue;
 		}
+
+		/*
+		 * Do not perform relocations in .notes sections; any
+		 * values there are meant for pre-boot consumption (e.g.
+		 * startup_xen).
+		 */
+		if (sec_applies->shdr.sh_type == SHT_NOTE)
+			continue;
+
 		sh_symtab = sec_symtab->symtab;
 		sym_strtab = sec_symtab->link->strtab;
 		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 1e7b15009bf6..da10517f2953 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -373,4 +373,7 @@ module_exit(ecdsa_exit);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Stefan Berger <stefanb@linux.ibm.com>");
 MODULE_DESCRIPTION("ECDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p192");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p256");
+MODULE_ALIAS_CRYPTO("ecdsa-nist-p384");
 MODULE_ALIAS_CRYPTO("ecdsa-generic");
diff --git a/crypto/ecrdsa.c b/crypto/ecrdsa.c
index f7ed43020672..0a970261b107 100644
--- a/crypto/ecrdsa.c
+++ b/crypto/ecrdsa.c
@@ -294,4 +294,5 @@ module_exit(ecrdsa_mod_fini);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Vitaly Chikunov <vt@altlinux.org>");
 MODULE_DESCRIPTION("EC-RDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecrdsa");
 MODULE_ALIAS_CRYPTO("ecrdsa-generic");
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index b70489d998d7..3c3e91114164 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -573,7 +573,7 @@ static u_long get_word(struct vc_data *vc)
 	}
 	attr_ch = get_char(vc, (u_short *)tmp_pos, &spk_attr);
 	buf[cnt++] = attr_ch;
-	while (tmpx < vc->vc_cols - 1 && cnt < sizeof(buf) - 1) {
+	while (tmpx < vc->vc_cols - 1 && cnt < ARRAY_SIZE(buf) - 1) {
 		tmp_pos += 2;
 		tmpx++;
 		ch = get_char(vc, (u_short *)tmp_pos, &temp);
diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index f919811156b1..b6cf9c9bd639 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -5,6 +5,7 @@
 
 ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
+CFLAGS_tbfind.o 		+= $(call cc-disable-warning, stringop-truncation)
 
 # use acpi.o to put all files here into acpi.o modparam namespace
 obj-y	+= acpi.o
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 0f533aff23a1..da4b94c0d65c 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -579,6 +579,18 @@ static const struct dmi_system_id lg_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "X577"),
 		},
 	},
+	{
+		/* TongFang GXxHRXx/TUXEDO InfinityBook Pro Gen9 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
+		},
+	},
+	{
+		/* TongFang GMxHGxx/TUXEDO Stellaris Slim Gen1 AMD */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GMxHGxx"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/ata/pata_legacy.c b/drivers/ata/pata_legacy.c
index 03c580625c2c..55b462ce99df 100644
--- a/drivers/ata/pata_legacy.c
+++ b/drivers/ata/pata_legacy.c
@@ -173,8 +173,6 @@ static int legacy_port[NR_HOST] = { 0x1f0, 0x170, 0x1e8, 0x168, 0x1e0, 0x160 };
 static struct legacy_probe probe_list[NR_HOST];
 static struct legacy_data legacy_data[NR_HOST];
 static struct ata_host *legacy_host[NR_HOST];
-static int nr_legacy_host;
-
 
 /**
  *	legacy_probe_add	-	Add interface to probe list
@@ -1276,9 +1274,11 @@ static __exit void legacy_exit(void)
 {
 	int i;
 
-	for (i = 0; i < nr_legacy_host; i++) {
+	for (i = 0; i < NR_HOST; i++) {
 		struct legacy_data *ld = &legacy_data[i];
-		ata_host_detach(legacy_host[i]);
+
+		if (legacy_host[i])
+			ata_host_detach(legacy_host[i]);
 		platform_device_unregister(ld->platform_dev);
 	}
 }
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 87791265e09b..ec78d9ad3e9b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2045,10 +2045,13 @@ static void __exit null_exit(void)
 
 	if (g_queue_mode == NULL_Q_MQ && shared_tags)
 		blk_mq_free_tag_set(&tag_set);
+
+	mutex_destroy(&lock);
 }
 
 module_init(null_init);
 module_exit(null_exit);
 
 MODULE_AUTHOR("Jens Axboe <axboe@kernel.dk>");
+MODULE_DESCRIPTION("multi queue aware block test driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index 38b46c7d1737..a97edbf7455a 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -296,28 +296,35 @@ static int register_device(int minor, struct pp_struct *pp)
 	if (!port) {
 		pr_warn("%s: no associated port!\n", name);
 		rc = -ENXIO;
-		goto err;
+		goto err_free_name;
+	}
+
+	index = ida_alloc(&ida_index, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		rc = index;
+		goto err_put_port;
 	}
 
-	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
 	ppdev_cb.private = pp;
 	pdev = parport_register_dev_model(port, name, &ppdev_cb, index);
-	parport_put_port(port);
 
 	if (!pdev) {
 		pr_warn("%s: failed to register device!\n", name);
 		rc = -ENXIO;
-		ida_simple_remove(&ida_index, index);
-		goto err;
+		ida_free(&ida_index, index);
+		goto err_put_port;
 	}
 
 	pp->pdev = pdev;
 	pp->index = index;
 	dev_dbg(&pdev->dev, "registered pardevice\n");
-err:
+err_put_port:
+	parport_put_port(port);
+err_free_name:
 	kfree(name);
 	return rc;
 }
@@ -750,7 +757,7 @@ static int pp_release(struct inode *inode, struct file *file)
 
 	if (pp->pdev) {
 		parport_unregister_device(pp->pdev);
-		ida_simple_remove(&ida_index, pp->index);
+		ida_free(&ida_index, pp->index);
 		pp->pdev = NULL;
 		pr_debug(CHRDEV "%x: unregistered pardevice\n", minor);
 	}
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index a68764cfb793..5e2e60c1c228 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2587,6 +2587,8 @@ static struct clk_hw *mmcc_msm8998_hws[] = {
 
 static struct gdsc video_top_gdsc = {
 	.gdscr = 0x1024,
+	.cxcs = (unsigned int []){ 0x1028, 0x1034, 0x1038 },
+	.cxc_count = 3,
 	.pd = {
 		.name = "video_top",
 	},
@@ -2595,20 +2597,26 @@ static struct gdsc video_top_gdsc = {
 
 static struct gdsc video_subcore0_gdsc = {
 	.gdscr = 0x1040,
+	.cxcs = (unsigned int []){ 0x1048 },
+	.cxc_count = 1,
 	.pd = {
 		.name = "video_subcore0",
 	},
 	.parent = &video_top_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
 };
 
 static struct gdsc video_subcore1_gdsc = {
 	.gdscr = 0x1044,
+	.cxcs = (unsigned int []){ 0x104c },
+	.cxc_count = 1,
 	.pd = {
 		.name = "video_subcore1",
 	},
 	.parent = &video_top_gdsc.pd,
 	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
 };
 
 static struct gdsc mdss_gdsc = {
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index e0ff09d66c96..17cfa2b92eee 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -615,10 +615,15 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cppc_perf_fb_ctrs fb_ctrs_t0 = {0}, fb_ctrs_t1 = {0};
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_cpudata *cpu_data;
 	u64 delivered_perf;
 	int ret;
 
+	if (!policy)
+		return -ENODEV;
+
+	cpu_data = policy->driver_data;
+
 	cpufreq_cpu_put(policy);
 
 	ret = cppc_get_perf_ctrs(cpu, &fb_ctrs_t0);
@@ -697,10 +702,15 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 static unsigned int hisi_cppc_cpufreq_get_rate(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_cpudata *cpu_data;
 	u64 desired_perf;
 	int ret;
 
+	if (!policy)
+		return -ENODEV;
+
+	cpu_data = policy->driver_data;
+
 	cpufreq_cpu_put(policy);
 
 	ret = cppc_get_desired_perf(cpu, &desired_perf);
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c2227be7bad8..a7bbe6f28b54 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1572,47 +1572,36 @@ static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
 	return 0;
 }
 
-static int cpufreq_offline(unsigned int cpu)
+static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 {
-	struct cpufreq_policy *policy;
 	int ret;
 
-	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
-
-	policy = cpufreq_cpu_get_raw(cpu);
-	if (!policy) {
-		pr_debug("%s: No cpu_data found\n", __func__);
-		return 0;
-	}
-
-	down_write(&policy->rwsem);
 	if (has_target())
 		cpufreq_stop_governor(policy);
 
 	cpumask_clear_cpu(cpu, policy->cpus);
 
-	if (policy_is_inactive(policy)) {
-		if (has_target())
-			strncpy(policy->last_governor, policy->governor->name,
-				CPUFREQ_NAME_LEN);
-		else
-			policy->last_policy = policy->policy;
-	} else if (cpu == policy->cpu) {
-		/* Nominate new CPU */
-		policy->cpu = cpumask_any(policy->cpus);
-	}
-
-	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
+		/* Nominate a new CPU if necessary. */
+		if (cpu == policy->cpu)
+			policy->cpu = cpumask_any(policy->cpus);
+
+		/* Start the governor again for the active policy. */
 		if (has_target()) {
 			ret = cpufreq_start_governor(policy);
 			if (ret)
 				pr_err("%s: Failed to start governor\n", __func__);
 		}
 
-		goto unlock;
+		return;
 	}
 
+	if (has_target())
+		strncpy(policy->last_governor, policy->governor->name,
+			CPUFREQ_NAME_LEN);
+	else
+		policy->last_policy = policy->policy;
+
 	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
 		cpufreq_cooling_unregister(policy->cdev);
 		policy->cdev = NULL;
@@ -1627,12 +1616,31 @@ static int cpufreq_offline(unsigned int cpu)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
+		return;
+	}
+
+	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+
+	policy->freq_table = NULL;
+}
+
+static int cpufreq_offline(unsigned int cpu)
+{
+	struct cpufreq_policy *policy;
+
+	pr_debug("%s: unregistering CPU %u\n", __func__, cpu);
+
+	policy = cpufreq_cpu_get_raw(cpu);
+	if (!policy) {
+		pr_debug("%s: No cpu_data found\n", __func__);
+		return 0;
 	}
 
-unlock:
+	down_write(&policy->rwsem);
+
+	__cpufreq_offline(cpu, policy);
+
 	up_write(&policy->rwsem);
 	return 0;
 }
@@ -1650,19 +1658,26 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	if (!policy)
 		return;
 
+	down_write(&policy->rwsem);
+
 	if (cpu_online(cpu))
-		cpufreq_offline(cpu);
+		__cpufreq_offline(cpu, policy);
 
 	cpumask_clear_cpu(cpu, policy->real_cpus);
 	remove_cpu_dev_symlink(policy, dev);
 
-	if (cpumask_empty(policy->real_cpus)) {
-		/* We did light-weight exit earlier, do full tear down now */
-		if (cpufreq_driver->offline)
-			cpufreq_driver->exit(policy);
-
-		cpufreq_policy_free(policy);
+	if (!cpumask_empty(policy->real_cpus)) {
+		up_write(&policy->rwsem);
+		return;
 	}
+
+	/* We did light-weight exit earlier, do full tear down now */
+	if (cpufreq_driver->offline && cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	up_write(&policy->rwsem);
+
+	cpufreq_policy_free(policy);
 }
 
 /**
diff --git a/drivers/crypto/bcm/spu2.c b/drivers/crypto/bcm/spu2.c
index 07989bb8c220..3fdc64b5a65e 100644
--- a/drivers/crypto/bcm/spu2.c
+++ b/drivers/crypto/bcm/spu2.c
@@ -495,7 +495,7 @@ static void spu2_dump_omd(u8 *omd, u16 hash_key_len, u16 ciph_key_len,
 	if (hash_iv_len) {
 		packet_log("  Hash IV Length %u bytes\n", hash_iv_len);
 		packet_dump("  hash IV: ", ptr, hash_iv_len);
-		ptr += ciph_key_len;
+		ptr += hash_iv_len;
 	}
 
 	if (ciph_iv_len) {
diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 9dba52fbee99..121f9d0cb608 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -39,44 +39,38 @@ static const struct sp_dev_vdata dev_vdata[] = {
 	},
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id sp_acpi_match[] = {
 	{ "AMDI0C00", (kernel_ulong_t)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, sp_acpi_match);
-#endif
 
-#ifdef CONFIG_OF
 static const struct of_device_id sp_of_match[] = {
 	{ .compatible = "amd,ccp-seattle-v1a",
 	  .data = (const void *)&dev_vdata[0] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, sp_of_match);
-#endif
 
 static struct sp_dev_vdata *sp_get_of_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_OF
 	const struct of_device_id *match;
 
 	match = of_match_node(sp_of_match, pdev->dev.of_node);
 	if (match && match->data)
 		return (struct sp_dev_vdata *)match->data;
-#endif
+
 	return NULL;
 }
 
 static struct sp_dev_vdata *sp_get_acpi_version(struct platform_device *pdev)
 {
-#ifdef CONFIG_ACPI
 	const struct acpi_device_id *match;
 
 	match = acpi_match_device(sp_acpi_match, &pdev->dev);
 	if (match && match->driver_data)
 		return (struct sp_dev_vdata *)match->driver_data;
-#endif
+
 	return NULL;
 }
 
@@ -222,12 +216,8 @@ static int sp_platform_resume(struct platform_device *pdev)
 static struct platform_driver sp_platform_driver = {
 	.driver = {
 		.name = "ccp",
-#ifdef CONFIG_ACPI
 		.acpi_match_table = sp_acpi_match,
-#endif
-#ifdef CONFIG_OF
 		.of_match_table = sp_of_match,
-#endif
 	},
 	.probe = sp_platform_probe,
 	.remove = sp_platform_remove,
diff --git a/drivers/crypto/qat/qat_common/adf_aer.c b/drivers/crypto/qat/qat_common/adf_aer.c
index 040595a6ab75..56c45c3408fc 100644
--- a/drivers/crypto/qat/qat_common/adf_aer.c
+++ b/drivers/crypto/qat/qat_common/adf_aer.c
@@ -95,8 +95,7 @@ static void adf_device_reset_worker(struct work_struct *work)
 	if (adf_dev_init(accel_dev) || adf_dev_start(accel_dev)) {
 		/* The device hanged and we can't restart it so stop here */
 		dev_err(&GET_DEV(accel_dev), "Restart device failed\n");
-		if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
-		    completion_done(&reset_data->compl))
+		if (reset_data->mode == ADF_DEV_RESET_ASYNC)
 			kfree(reset_data);
 		WARN(1, "QAT: device restart failed. Device is unusable\n");
 		return;
@@ -104,16 +103,8 @@ static void adf_device_reset_worker(struct work_struct *work)
 	adf_dev_restarted_notify(accel_dev);
 	clear_bit(ADF_STATUS_RESTARTING, &accel_dev->status);
 
-	/*
-	 * The dev is back alive. Notify the caller if in sync mode
-	 *
-	 * If device restart will take a more time than expected,
-	 * the schedule_reset() function can timeout and exit. This can be
-	 * detected by calling the completion_done() function. In this case
-	 * the reset_data structure needs to be freed here.
-	 */
-	if (reset_data->mode == ADF_DEV_RESET_ASYNC ||
-	    completion_done(&reset_data->compl))
+	/* The dev is back alive. Notify the caller if in sync mode */
+	if (reset_data->mode == ADF_DEV_RESET_ASYNC)
 		kfree(reset_data);
 	else
 		complete(&reset_data->compl);
@@ -148,10 +139,10 @@ static int adf_dev_aer_schedule_reset(struct adf_accel_dev *accel_dev,
 		if (!timeout) {
 			dev_err(&GET_DEV(accel_dev),
 				"Reset device timeout expired\n");
+			cancel_work_sync(&reset_data->reset_work);
 			ret = -EFAULT;
-		} else {
-			kfree(reset_data);
 		}
+		kfree(reset_data);
 		return ret;
 	}
 	return 0;
diff --git a/drivers/dma-buf/sync_debug.c b/drivers/dma-buf/sync_debug.c
index 101394f16930..237bce21d1e7 100644
--- a/drivers/dma-buf/sync_debug.c
+++ b/drivers/dma-buf/sync_debug.c
@@ -110,12 +110,12 @@ static void sync_print_obj(struct seq_file *s, struct sync_timeline *obj)
 
 	seq_printf(s, "%s: %d\n", obj->name, obj->value);
 
-	spin_lock_irq(&obj->lock);
+	spin_lock(&obj->lock); /* Caller already disabled IRQ. */
 	list_for_each(pos, &obj->pt_list) {
 		struct sync_pt *pt = container_of(pos, struct sync_pt, link);
 		sync_print_fence(s, &pt->base, false);
 	}
-	spin_unlock_irq(&obj->lock);
+	spin_unlock(&obj->lock);
 }
 
 static void sync_print_sync_file(struct seq_file *s,
diff --git a/drivers/dma/idma64.c b/drivers/dma/idma64.c
index af8777a1ec2e..89e4a3e1d519 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -594,7 +594,9 @@ static int idma64_probe(struct idma64_chip *chip)
 
 	idma64->dma.dev = chip->sysdev;
 
-	dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	ret = dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	if (ret)
+		return ret;
 
 	ret = dma_async_device_register(&idma64->dma);
 	if (ret)
diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
index 8ec70da8d84f..c46880a934da 100644
--- a/drivers/edac/igen6_edac.c
+++ b/drivers/edac/igen6_edac.c
@@ -627,7 +627,7 @@ static int errcmd_enable_error_reporting(bool enable)
 
 	rc = pci_read_config_word(imc->pdev, ERRCMD_OFFSET, &errcmd);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	if (enable)
 		errcmd |= ERRCMD_CE | ERRSTS_UE;
@@ -636,7 +636,7 @@ static int errcmd_enable_error_reporting(bool enable)
 
 	rc = pci_write_config_word(imc->pdev, ERRCMD_OFFSET, errcmd);
 	if (rc)
-		return rc;
+		return pcibios_err_to_errno(rc);
 
 	return 0;
 }
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 7684b3afa630..ba0542ef4d88 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -113,7 +113,8 @@ config EXTCON_MAX77843
 
 config EXTCON_MAX8997
 	tristate "Maxim MAX8997 EXTCON Support"
-	depends on MFD_MAX8997 && IRQ_DOMAIN
+	depends on MFD_MAX8997
+	select IRQ_DOMAIN
 	help
 	  If you say yes here you get support for the MUIC device of
 	  Maxim MAX8997 PMIC. The MAX8997 MUIC is a USB port accessory
diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index 940ddf916202..77a8d43e65d3 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -169,9 +169,14 @@ static int dmi_dev_uevent(struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
+static void dmi_dev_release(struct device *dev)
+{
+	kfree(dev);
+}
+
 static struct class dmi_class = {
 	.name = "dmi",
-	.dev_release = (void(*)(struct device *)) kfree,
+	.dev_release = dmi_dev_release,
 	.dev_uevent = dmi_dev_uevent,
 };
 
diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index dba315f675bc..ec223976c972 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -9,6 +9,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/kref.h>
 #include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -96,8 +97,8 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 	if (size & 3)
 		return -EINVAL;
 
-	buf = dma_alloc_coherent(fw->cl.dev, PAGE_ALIGN(size), &bus_addr,
-				 GFP_ATOMIC);
+	buf = dma_alloc_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size),
+				 &bus_addr, GFP_ATOMIC);
 	if (!buf)
 		return -ENOMEM;
 
@@ -125,7 +126,7 @@ int rpi_firmware_property_list(struct rpi_firmware *fw,
 		ret = -EINVAL;
 	}
 
-	dma_free_coherent(fw->cl.dev, PAGE_ALIGN(size), buf, bus_addr);
+	dma_free_coherent(fw->chan->mbox->dev, PAGE_ALIGN(size), buf, bus_addr);
 
 	return ret;
 }
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 1eeb42af1012..4aebde0a7f1c 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -30,6 +30,7 @@ static int fme_region_get_bridges(struct fpga_region *region)
 static int fme_region_probe(struct platform_device *pdev)
 {
 	struct dfl_fme_region_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct fpga_region_info info = { 0 };
 	struct device *dev = &pdev->dev;
 	struct fpga_region *region;
 	struct fpga_manager *mgr;
@@ -39,20 +40,18 @@ static int fme_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, fme_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	info.mgr = mgr;
+	info.compat_id = mgr->compat_id;
+	info.get_bridges = fme_region_get_bridges;
+	info.priv = pdata;
+	region = fpga_region_register_full(dev, &info);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
-	region->priv = pdata;
-	region->compat_id = mgr->compat_id;
 	platform_set_drvdata(pdev, region);
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	dev_dbg(dev, "DFL FME FPGA Region probed\n");
 
 	return 0;
diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index c38143ef23c6..071c25c164a8 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1407,19 +1407,15 @@ dfl_fpga_feature_devs_enumerate(struct dfl_fpga_enum_info *info)
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	cdev->region = devm_fpga_region_create(info->dev, NULL, NULL);
-	if (!cdev->region) {
-		ret = -ENOMEM;
-		goto free_cdev_exit;
-	}
-
 	cdev->parent = info->dev;
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->port_dev_list);
 
-	ret = fpga_region_register(cdev->region);
-	if (ret)
+	cdev->region = fpga_region_register(info->dev, NULL, NULL);
+	if (IS_ERR(cdev->region)) {
+		ret = PTR_ERR(cdev->region);
 		goto free_cdev_exit;
+	}
 
 	/* create and init build info for enumeration */
 	binfo = devm_kzalloc(info->dev, sizeof(*binfo), GFP_KERNEL);
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index a4838715221f..d73daea579ac 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -52,7 +52,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
 	}
 
 	get_device(dev);
-	if (!try_module_get(dev->parent->driver->owner)) {
+	if (!try_module_get(region->ops_owner)) {
 		put_device(dev);
 		mutex_unlock(&region->mutex);
 		return ERR_PTR(-ENODEV);
@@ -74,7 +74,7 @@ static void fpga_region_put(struct fpga_region *region)
 
 	dev_dbg(dev, "put\n");
 
-	module_put(dev->parent->driver->owner);
+	module_put(region->ops_owner);
 	put_device(dev);
 	mutex_unlock(&region->mutex);
 }
@@ -180,39 +180,45 @@ static struct attribute *fpga_region_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_region);
 
 /**
- * fpga_region_create - alloc and init a struct fpga_region
+ * __fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
- * @mgr: manager that programs this region
- * @get_bridges: optional function to get bridges to a list
- *
- * The caller of this function is responsible for freeing the resulting region
- * struct with fpga_region_free().  Using devm_fpga_region_create() instead is
- * recommended.
+ * @info: parameters for FPGA Region
+ * @owner: module containing the get_bridges function
  *
- * Return: struct fpga_region or NULL
+ * Return: struct fpga_region or ERR_PTR()
  */
-struct fpga_region
-*fpga_region_create(struct device *parent,
-		    struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner)
 {
 	struct fpga_region *region;
 	int id, ret = 0;
 
+	if (!info) {
+		dev_err(parent,
+			"Attempt to register without required info structure\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	region = kzalloc(sizeof(*region), GFP_KERNEL);
 	if (!region)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	id = ida_simple_get(&fpga_region_ida, 0, 0, GFP_KERNEL);
-	if (id < 0)
+	if (id < 0) {
+		ret = id;
 		goto err_free;
+	}
+
+	region->mgr = info->mgr;
+	region->compat_id = info->compat_id;
+	region->priv = info->priv;
+	region->get_bridges = info->get_bridges;
+	region->ops_owner = owner;
 
-	region->mgr = mgr;
-	region->get_bridges = get_bridges;
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
 
-	device_initialize(&region->dev);
 	region->dev.class = fpga_region_class;
 	region->dev.parent = parent;
 	region->dev.of_node = parent->of_node;
@@ -222,6 +228,12 @@ struct fpga_region
 	if (ret)
 		goto err_remove;
 
+	ret = device_register(&region->dev);
+	if (ret) {
+		put_device(&region->dev);
+		return ERR_PTR(ret);
+	}
+
 	return region;
 
 err_remove:
@@ -229,78 +241,35 @@ struct fpga_region
 err_free:
 	kfree(region);
 
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(fpga_region_create);
-
-/**
- * fpga_region_free - free an FPGA region created by fpga_region_create()
- * @region: FPGA region
- */
-void fpga_region_free(struct fpga_region *region)
-{
-	ida_simple_remove(&fpga_region_ida, region->dev.id);
-	kfree(region);
-}
-EXPORT_SYMBOL_GPL(fpga_region_free);
-
-static void devm_fpga_region_release(struct device *dev, void *res)
-{
-	struct fpga_region *region = *(struct fpga_region **)res;
-
-	fpga_region_free(region);
+	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(__fpga_region_register_full);
 
 /**
- * devm_fpga_region_create - create and initialize a managed FPGA region struct
+ * __fpga_region_register - create and register an FPGA Region device
  * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
+ * @owner: module containing the get_bridges function
  *
- * This function is intended for use in an FPGA region driver's probe function.
- * After the region driver creates the region struct with
- * devm_fpga_region_create(), it should register it with fpga_region_register().
- * The region driver's remove function should call fpga_region_unregister().
- * The region struct allocated with this function will be freed automatically on
- * driver detach.  This includes the case of a probe function returning error
- * before calling fpga_region_register(), the struct will still get cleaned up.
+ * This simple version of the register function should be sufficient for most users.
+ * The fpga_region_register_full() function is available for users that need to
+ * pass additional, optional parameters.
  *
- * Return: struct fpga_region or NULL
+ * Return: struct fpga_region or ERR_PTR()
  */
-struct fpga_region
-*devm_fpga_region_create(struct device *parent,
-			 struct fpga_manager *mgr,
-			 int (*get_bridges)(struct fpga_region *))
+struct fpga_region *
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner)
 {
-	struct fpga_region **ptr, *region;
-
-	ptr = devres_alloc(devm_fpga_region_release, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return NULL;
+	struct fpga_region_info info = { 0 };
 
-	region = fpga_region_create(parent, mgr, get_bridges);
-	if (!region) {
-		devres_free(ptr);
-	} else {
-		*ptr = region;
-		devres_add(parent, ptr);
-	}
+	info.mgr = mgr;
+	info.get_bridges = get_bridges;
 
-	return region;
+	return __fpga_region_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(devm_fpga_region_create);
-
-/**
- * fpga_region_register - register an FPGA region
- * @region: FPGA region
- *
- * Return: 0 or -errno
- */
-int fpga_region_register(struct fpga_region *region)
-{
-	return device_add(&region->dev);
-}
-EXPORT_SYMBOL_GPL(fpga_region_register);
+EXPORT_SYMBOL_GPL(__fpga_region_register);
 
 /**
  * fpga_region_unregister - unregister an FPGA region
@@ -316,6 +285,10 @@ EXPORT_SYMBOL_GPL(fpga_region_unregister);
 
 static void fpga_region_dev_release(struct device *dev)
 {
+	struct fpga_region *region = to_fpga_region(dev);
+
+	ida_simple_remove(&fpga_region_ida, region->dev.id);
+	kfree(region);
 }
 
 /**
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index e3c25576b6b9..9c662db1c508 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -405,16 +405,12 @@ static int of_fpga_region_probe(struct platform_device *pdev)
 	if (IS_ERR(mgr))
 		return -EPROBE_DEFER;
 
-	region = devm_fpga_region_create(dev, mgr, of_fpga_region_get_bridges);
-	if (!region) {
-		ret = -ENOMEM;
+	region = fpga_region_register(dev, mgr, of_fpga_region_get_bridges);
+	if (IS_ERR(region)) {
+		ret = PTR_ERR(region);
 		goto eprobe_mgr_put;
 	}
 
-	ret = fpga_region_register(region);
-	if (ret)
-		goto eprobe_mgr_put;
-
 	of_platform_populate(np, fpga_region_of_match, NULL, &region->dev);
 	platform_set_drvdata(pdev, region);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
index 97178b307ed6..2229c6e75cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
@@ -149,6 +149,7 @@ union igp_info {
 	struct atom_integrated_system_info_v1_11 v11;
 	struct atom_integrated_system_info_v1_12 v12;
 	struct atom_integrated_system_info_v2_1 v21;
+	struct atom_integrated_system_info_v2_3 v23;
 };
 
 union umc_info {
@@ -283,6 +284,20 @@ amdgpu_atomfirmware_get_vram_info(struct amdgpu_device *adev,
 					if (vram_type)
 						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
 					break;
+				case 3:
+					mem_channel_number = igp_info->v23.umachannelnumber;
+					if (!mem_channel_number)
+						mem_channel_number = 1;
+					mem_type = igp_info->v23.memorytype;
+					if (mem_type == LpDdr5MemType)
+						mem_channel_width = 32;
+					else
+						mem_channel_width = 64;
+					if (vram_width)
+						*vram_width = mem_channel_number * mem_channel_width;
+					if (vram_type)
+						*vram_type = convert_atom_mem_type_to_vram_type(adev, mem_type);
+					break;
 				default:
 					return -EINVAL;
 				}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 222a1d9ecf16..5f6c32ec674d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2487,6 +2487,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -2525,10 +2529,6 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 0fad9258e096..c189e7ae6838 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2152,6 +2152,9 @@ static int sdma_v4_0_process_trap_irq(struct amdgpu_device *adev,
 
 	DRM_DEBUG("IH: SDMA trap\n");
 	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
+	if (instance < 0)
+		return instance;
+
 	switch (entry->ring_id) {
 	case 0:
 		amdgpu_fence_process(&adev->sdma.instance[instance].ring);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 21ec8a18cad2..7f69031f2b61 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -818,6 +818,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	if (process) {
 		pr_debug("Process already found\n");
 	} else {
+		/* If the process just called exec(3), it is possible that the
+		 * cleanup of the kfd_process (following the release of the mm
+		 * of the old process image) is still in the cleanup work queue.
+		 * Make sure to drain any job before trying to recreate any
+		 * resource for this process.
+		 */
+		flush_workqueue(kfd_process_wq);
+
 		process = create_process(thread);
 		if (IS_ERR(process))
 			goto out;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b7b8a2d77da6..b821abb56ac3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2772,6 +2772,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 7a00fe525dfb..bd9bc51983fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -379,6 +379,11 @@ bool cm_helper_translate_curve_to_hw_format(
 				i += increment) {
 			if (j == hw_points - 1)
 				break;
+			if (i >= TRANSFER_FUNC_POINTS) {
+				DC_LOG_ERROR("Index out of bounds: i=%d, TRANSFER_FUNC_POINTS=%d\n",
+					     i, TRANSFER_FUNC_POINTS);
+				return false;
+			}
 			rgb_resulted[j].red = output_tf->tf_pts.red[i];
 			rgb_resulted[j].green = output_tf->tf_pts.green[i];
 			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 44955458fe38..d6f0f31de5ce 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -1467,6 +1467,49 @@ struct atom_integrated_system_info_v2_2
 	uint32_t  reserved4[189];
 };
 
+struct uma_carveout_option {
+  char       optionName[29];        //max length of string is 28chars + '\0'. Current design is for "minimum", "Medium", "High". This makes entire struct size 64bits
+  uint8_t    memoryCarvedGb;        //memory carved out with setting
+  uint8_t    memoryRemainingGb;     //memory remaining on system
+  union {
+    struct _flags {
+      uint8_t Auto     : 1;
+      uint8_t Custom   : 1;
+      uint8_t Reserved : 6;
+    } flags;
+    uint8_t all8;
+  } uma_carveout_option_flags;
+};
+
+struct atom_integrated_system_info_v2_3 {
+  struct  atom_common_table_header table_header;
+  uint32_t  vbios_misc; // enum of atom_system_vbiosmisc_def
+  uint32_t  gpucapinfo; // enum of atom_system_gpucapinf_def
+  uint32_t  system_config;
+  uint32_t  cpucapinfo;
+  uint16_t  gpuclk_ss_percentage; // unit of 0.001%,   1000 mean 1%
+  uint16_t  gpuclk_ss_type;
+  uint16_t  dpphy_override;  // bit vector, enum of atom_sysinfo_dpphy_override_def
+  uint8_t memorytype;       // enum of atom_dmi_t17_mem_type_def, APU memory type indication.
+  uint8_t umachannelnumber; // number of memory channels
+  uint8_t htc_hyst_limit;
+  uint8_t htc_tmp_limit;
+  uint8_t reserved1; // dp_ss_control
+  uint8_t gpu_package_id;
+  struct  edp_info_table  edp1_info;
+  struct  edp_info_table  edp2_info;
+  uint32_t  reserved2[8];
+  struct  atom_external_display_connection_info extdispconninfo;
+  uint8_t UMACarveoutVersion;
+  uint8_t UMACarveoutIndexMax;
+  uint8_t UMACarveoutTypeDefault;
+  uint8_t UMACarveoutIndexDefault;
+  uint8_t UMACarveoutType;           //Auto or Custom
+  uint8_t UMACarveoutIndex;
+  struct  uma_carveout_option UMASizeControlOption[20];
+  uint8_t reserved3[110];
+};
+
 // system_config
 enum atom_system_vbiosmisc_def{
   INTEGRATED_SYSTEM_INFO__GET_EDID_CALLBACK_FUNC_SUPPORT = 0x01,
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index f5847a79dd7e..0720b2197c4e 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -70,7 +70,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	connector->state = NULL;
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 5530fbf64f1e..c8386311cc70 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2040,6 +2040,9 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
+	if (!mhdp_state->current_mode)
+		return;
+
 	drm_mode_set_name(mhdp_state->current_mode);
 
 	dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index e16b0fc0cda0..6379d5c8edff 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -475,10 +475,8 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
 						 };
 
 	host = of_find_mipi_dsi_host_by_node(lt->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 660e05fa4a70..7f58ceda5b08 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -766,10 +766,8 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(lt9611->dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(lt9611->dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 2272adcc5b4a..2e299cfe4e48 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -453,10 +453,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
 		connector->display_info.bus_formats[0],
 		tc->bpc);
-	/*
-	 * Default hardware register settings of tc358775 configured
-	 * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
-	 */
 	if (connector->display_info.bus_formats[0] ==
 		MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
 		/* VESA-24 */
@@ -467,14 +463,15 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_B6, LVI_B7, LVI_B1, LVI_B2));
 		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B3, LVI_B4, LVI_B5, LVI_L0));
 		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R6));
-	} else { /*  MEDIA_BUS_FMT_RGB666_1X7X3_SPWG - JEIDA-18 */
-		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
-		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_L0, LVI_R5, LVI_G0));
-		d2l_write(tc->i2c, LV_MX0811, LV_MX(LVI_G1, LVI_G2, LVI_L0, LVI_L0));
-		d2l_write(tc->i2c, LV_MX1215, LV_MX(LVI_G3, LVI_G4, LVI_G5, LVI_B0));
-		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_L0, LVI_L0, LVI_B1, LVI_B2));
-		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B3, LVI_B4, LVI_B5, LVI_L0));
-		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_L0));
+	} else {
+		/* JEIDA-18 and JEIDA-24 */
+		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R2, LVI_R3, LVI_R4, LVI_R5));
+		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R6, LVI_R1, LVI_R7, LVI_G2));
+		d2l_write(tc->i2c, LV_MX0811, LV_MX(LVI_G3, LVI_G4, LVI_G0, LVI_G1));
+		d2l_write(tc->i2c, LV_MX1215, LV_MX(LVI_G5, LVI_G6, LVI_G7, LVI_B2));
+		d2l_write(tc->i2c, LV_MX1619, LV_MX(LVI_B0, LVI_B1, LVI_B3, LVI_B4));
+		d2l_write(tc->i2c, LV_MX2023, LV_MX(LVI_B5, LVI_B6, LVI_B7, LVI_L0));
+		d2l_write(tc->i2c, LV_MX2427, LV_MX(LVI_HS, LVI_VS, LVI_DE, LVI_R0));
 	}
 
 	d2l_write(tc->i2c, VFUEN, VFUEN_EN);
@@ -605,10 +602,8 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 						};
 
 	host = of_find_mipi_dsi_host_by_node(tc->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 5d30ba3af456..24606b632009 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -653,7 +653,7 @@ EXPORT_SYMBOL(mipi_dsi_set_maximum_return_packet_size);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable)
 {
 	/* Note: Needs updating for non-default PPS or algorithm */
 	u8 tx[2] = { enable << 0, 0 };
@@ -678,8 +678,8 @@ EXPORT_SYMBOL(mipi_dsi_compression_mode);
  *
  * Return: 0 on success or a negative error code on failure.
  */
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps)
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps)
 {
 	struct mipi_dsi_msg msg = {
 		.channel = dsi->channel,
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index da483125e063..97071ff5e540 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -198,13 +198,22 @@ int drm_mode_config_helper_suspend(struct drm_device *dev)
 
 	if (!dev)
 		return 0;
+	/*
+	 * Don't disable polling if it was never initialized
+	 */
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_disable(dev);
 
-	drm_kms_helper_poll_disable(dev);
 	drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 1);
 	state = drm_atomic_helper_suspend(dev);
 	if (IS_ERR(state)) {
 		drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 0);
-		drm_kms_helper_poll_enable(dev);
+		/*
+		 * Don't enable polling if it was never initialized
+		 */
+		if (dev->mode_config.poll_enabled)
+			drm_kms_helper_poll_enable(dev);
+
 		return PTR_ERR(state);
 	}
 
@@ -244,7 +253,11 @@ int drm_mode_config_helper_resume(struct drm_device *dev)
 	dev->mode_config.suspend_state = NULL;
 
 	drm_fb_helper_set_suspend_unlocked(dev->fb_helper, 0);
-	drm_kms_helper_poll_enable(dev);
+	/*
+	 * Don't enable polling if it is not initialized
+	 */
+	if (dev->mode_config.poll_enabled)
+		drm_kms_helper_poll_enable(dev);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index f6b72e03688d..e79bb93072dd 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -235,6 +235,9 @@ drm_connector_mode_valid(struct drm_connector *connector,
  * Drivers can call this helper from their device resume implementation. It is
  * not an error to call this even when output polling isn't enabled.
  *
+ * If device polling was never initialized before, this call will trigger a
+ * warning and return.
+ *
  * Note that calls to enable and disable polling must be strictly ordered, which
  * is automatically the case when they're only call from suspend/resume
  * callbacks.
@@ -246,7 +249,8 @@ void drm_kms_helper_poll_enable(struct drm_device *dev)
 	struct drm_connector_list_iter conn_iter;
 	unsigned long delay = DRM_OUTPUT_POLL_PERIOD;
 
-	if (!dev->mode_config.poll_enabled || !drm_kms_helper_poll)
+	if (drm_WARN_ON_ONCE(dev, !dev->mode_config.poll_enabled) ||
+	    !drm_kms_helper_poll || dev->mode_config.poll_running)
 		return;
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
@@ -494,7 +498,8 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 	}
 
 	/* Re-enable polling in case the global poll config changed. */
-	if (drm_kms_helper_poll != dev->mode_config.poll_running)
+	if (dev->mode_config.poll_enabled &&
+	    (drm_kms_helper_poll != dev->mode_config.poll_running))
 		drm_kms_helper_poll_enable(dev);
 
 	dev->mode_config.poll_running = drm_kms_helper_poll;
@@ -742,14 +747,18 @@ EXPORT_SYMBOL(drm_kms_helper_is_poll_worker);
  * not an error to call this even when output polling isn't enabled or already
  * disabled. Polling is re-enabled by calling drm_kms_helper_poll_enable().
  *
+ * If however, the polling was never initialized, this call will trigger a
+ * warning and return
+ *
  * Note that calls to enable and disable polling must be strictly ordered, which
  * is automatically the case when they're only call from suspend/resume
  * callbacks.
  */
 void drm_kms_helper_poll_disable(struct drm_device *dev)
 {
-	if (!dev->mode_config.poll_enabled)
+	if (drm_WARN_ON(dev, !dev->mode_config.poll_enabled))
 		return;
+
 	cancel_delayed_work_sync(&dev->mode_config.output_poll_work);
 }
 EXPORT_SYMBOL(drm_kms_helper_poll_disable);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index b983adffa392..88bdb8eeba81 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_gem.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
@@ -33,6 +33,9 @@ static struct mtk_drm_gem_obj *mtk_drm_gem_init(struct drm_device *dev,
 
 	size = round_up(size, PAGE_SIZE);
 
+	if (size == 0)
+		return ERR_PTR(-EINVAL);
+
 	mtk_gem_obj = kzalloc(sizeof(*mtk_gem_obj), GFP_KERNEL);
 	if (!mtk_gem_obj)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/gpu/drm/meson/meson_vclk.c b/drivers/gpu/drm/meson/meson_vclk.c
index 2a82119eb58e..2a942dc6a6dc 100644
--- a/drivers/gpu/drm/meson/meson_vclk.c
+++ b/drivers/gpu/drm/meson/meson_vclk.c
@@ -790,13 +790,13 @@ meson_vclk_vic_supported_freq(struct meson_drm *priv, unsigned int phy_freq,
 				 FREQ_1000_1001(params[i].pixel_freq));
 		DRM_DEBUG_DRIVER("i = %d phy_freq = %d alt = %d\n",
 				 i, params[i].phy_freq,
-				 FREQ_1000_1001(params[i].phy_freq/10)*10);
+				 FREQ_1000_1001(params[i].phy_freq/1000)*1000);
 		/* Match strict frequency */
 		if (phy_freq == params[i].phy_freq &&
 		    vclk_freq == params[i].vclk_freq)
 			return MODE_OK;
 		/* Match 1000/1001 variant */
-		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/10)*10) &&
+		if (phy_freq == (FREQ_1000_1001(params[i].phy_freq/1000)*1000) &&
 		    vclk_freq == FREQ_1000_1001(params[i].vclk_freq))
 			return MODE_OK;
 	}
@@ -1070,7 +1070,7 @@ void meson_vclk_setup(struct meson_drm *priv, unsigned int target,
 
 	for (freq = 0 ; params[freq].pixel_freq ; ++freq) {
 		if ((phy_freq == params[freq].phy_freq ||
-		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/10)*10) &&
+		     phy_freq == FREQ_1000_1001(params[freq].phy_freq/1000)*1000) &&
 		    (vclk_freq == params[freq].vclk_freq ||
 		     vclk_freq == FREQ_1000_1001(params[freq].vclk_freq))) {
 			if (vclk_freq != params[freq].vclk_freq)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index aa01698d6b25..a05276f0d698 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -441,9 +441,6 @@ static void dpu_encoder_phys_cmd_enable_helper(
 
 	_dpu_encoder_phys_cmd_pingpong_config(phys_enc);
 
-	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
-		return;
-
 	ctl = phys_enc->hw_ctl;
 	ctl->ops.update_pending_flush_intf(ctl, phys_enc->intf_idx);
 }
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 8d0612caf6c2..c563ecf6e7b9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -501,8 +501,8 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 	unsigned long byte_intf_rate;
 	int ret;
 
-	DBG("Set clk rates: pclk=%d, byteclk=%lu",
-		msm_host->mode->clock, msm_host->byte_clk_rate);
+	DBG("Set clk rates: pclk=%lu, byteclk=%lu",
+	    msm_host->pixel_clk_rate, msm_host->byte_clk_rate);
 
 	ret = dev_pm_opp_set_rate(&msm_host->pdev->dev,
 				  msm_host->byte_clk_rate);
@@ -583,9 +583,9 @@ int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host)
 {
 	int ret;
 
-	DBG("Set clk rates: pclk=%d, byteclk=%lu, esc_clk=%lu, dsi_src_clk=%lu",
-		msm_host->mode->clock, msm_host->byte_clk_rate,
-		msm_host->esc_clk_rate, msm_host->src_clk_rate);
+	DBG("Set clk rates: pclk=%lu, byteclk=%lu, esc_clk=%lu, dsi_src_clk=%lu",
+	    msm_host->pixel_clk_rate, msm_host->byte_clk_rate,
+	    msm_host->esc_clk_rate, msm_host->src_clk_rate);
 
 	ret = clk_set_rate(msm_host->byte_clk, msm_host->byte_clk_rate);
 	if (ret) {
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 671bd1d1ad19..0dc4d891fedc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2613,6 +2613,9 @@ static const struct panel_desc innolux_g121x1_l03 = {
 		.unprepare = 200,
 		.disable = 400,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
 static const struct drm_display_mode innolux_n116bca_ea1_mode = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 88aa00a1891b..86d77794d839 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1506,6 +1506,8 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 		index = 1;
 
 	addr = of_get_address(dev->of_node, index, NULL, NULL);
+	if (!addr)
+		return -EINVAL;
 
 	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 5916ef2933e2..bbc3ea34585d 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -212,6 +212,11 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* request and enable interrupt */
 	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
+	if (ret < 0) {
+		dev_err(dev, "ISH: Failed to allocate IRQ vectors\n");
+		return ret;
+	}
+
 	if (!pdev->msi_enabled && !pdev->msix_enabled)
 		irq_flag = IRQF_SHARED;
 
diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index 18546ebc8e9f..0365643029ae 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -238,7 +238,7 @@ static int shtc1_probe(struct i2c_client *client)
 
 	if (np) {
 		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking-io");
-		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low-precision");
+		data->setup.high_precision = !of_property_read_bool(np, "sensirion,low-precision");
 	} else {
 		if (client->dev.platform_data)
 			data->setup = *(struct shtc1_platform_data *)dev->platform_data;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 26d0d4485ae9..84734c7c1915 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1048,41 +1048,23 @@ static void etm4_init_arch_data(void *info)
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
 	/* INSTP0, bits[2:1] P0 tracing support field */
-	if (BMVAL(etmidr0, 1, 1) && BMVAL(etmidr0, 2, 2))
-		drvdata->instrp0 = true;
-	else
-		drvdata->instrp0 = false;
-
+	drvdata->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);
 	/* TRCBB, bit[5] Branch broadcast tracing support bit */
-	if (BMVAL(etmidr0, 5, 5))
-		drvdata->trcbb = true;
-	else
-		drvdata->trcbb = false;
-
+	drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
 	/* TRCCOND, bit[6] Conditional instruction tracing support bit */
-	if (BMVAL(etmidr0, 6, 6))
-		drvdata->trccond = true;
-	else
-		drvdata->trccond = false;
-
+	drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
 	/* TRCCCI, bit[7] Cycle counting instruction bit */
-	if (BMVAL(etmidr0, 7, 7))
-		drvdata->trccci = true;
-	else
-		drvdata->trccci = false;
-
+	drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
 	/* RETSTACK, bit[9] Return stack bit */
-	if (BMVAL(etmidr0, 9, 9))
-		drvdata->retstack = true;
-	else
-		drvdata->retstack = false;
-
+	drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
 	/* NUMEVENT, bits[11:10] Number of events field */
-	drvdata->nr_event = BMVAL(etmidr0, 10, 11);
+	drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
 	/* QSUPP, bits[16:15] Q element support field */
-	drvdata->q_support = BMVAL(etmidr0, 15, 16);
+	drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
+	if (drvdata->q_support)
+		drvdata->q_filt = !!(etmidr0 & TRCIDR0_QFILT);
 	/* TSSIZE, bits[28:24] Global timestamp size field */
-	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
+	drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
 
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
@@ -1602,16 +1584,14 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcccctlr = etm4x_read32(csa, TRCCCCTLR);
 	state->trcbbctlr = etm4x_read32(csa, TRCBBCTLR);
 	state->trctraceidr = etm4x_read32(csa, TRCTRACEIDR);
-	state->trcqctlr = etm4x_read32(csa, TRCQCTLR);
+	if (drvdata->q_filt)
+		state->trcqctlr = etm4x_read32(csa, TRCQCTLR);
 
 	state->trcvictlr = etm4x_read32(csa, TRCVICTLR);
 	state->trcviiectlr = etm4x_read32(csa, TRCVIIECTLR);
 	state->trcvissctlr = etm4x_read32(csa, TRCVISSCTLR);
 	if (drvdata->nr_pe_cmp)
 		state->trcvipcssctlr = etm4x_read32(csa, TRCVIPCSSCTLR);
-	state->trcvdctlr = etm4x_read32(csa, TRCVDCTLR);
-	state->trcvdsacctlr = etm4x_read32(csa, TRCVDSACCTLR);
-	state->trcvdarcctlr = etm4x_read32(csa, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
@@ -1628,7 +1608,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trccntvr[i] = etm4x_read32(csa, TRCCNTVRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/* Resource selector pair 0 is reserved */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		state->trcrsctlr[i] = etm4x_read32(csa, TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
@@ -1697,8 +1678,10 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 {
 	int i;
 	struct etmv4_save_state *state = drvdata->save_state;
-	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
-	struct csdev_access *csa = &tmp_csa;
+	struct csdev_access *csa = &drvdata->csdev->access;
+
+	if (WARN_ON(!drvdata->csdev))
+		return;
 
 	etm4_cs_unlock(drvdata, csa);
 	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
@@ -1717,16 +1700,14 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, state->trcccctlr, TRCCCCTLR);
 	etm4x_relaxed_write32(csa, state->trcbbctlr, TRCBBCTLR);
 	etm4x_relaxed_write32(csa, state->trctraceidr, TRCTRACEIDR);
-	etm4x_relaxed_write32(csa, state->trcqctlr, TRCQCTLR);
+	if (drvdata->q_filt)
+		etm4x_relaxed_write32(csa, state->trcqctlr, TRCQCTLR);
 
 	etm4x_relaxed_write32(csa, state->trcvictlr, TRCVICTLR);
 	etm4x_relaxed_write32(csa, state->trcviiectlr, TRCVIIECTLR);
 	etm4x_relaxed_write32(csa, state->trcvissctlr, TRCVISSCTLR);
 	if (drvdata->nr_pe_cmp)
 		etm4x_relaxed_write32(csa, state->trcvipcssctlr, TRCVIPCSSCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdctlr, TRCVDCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdsacctlr, TRCVDSACCTLR);
-	etm4x_relaxed_write32(csa, state->trcvdarcctlr, TRCVDARCCTLR);
 
 	for (i = 0; i < drvdata->nrseqstate - 1; i++)
 		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
@@ -1743,7 +1724,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, state->trccntvr[i], TRCCNTVRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/* Resource selector pair 0 is reserved */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		etm4x_relaxed_write32(csa, state->trcrsctlr[i], TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
@@ -2022,6 +2004,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	ret = etm4_probe(&pdev->dev, NULL, 0);
 
 	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index a0f3f0ba3380..3ab528c6b91f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -43,9 +43,6 @@
 #define TRCVIIECTLR			0x084
 #define TRCVISSCTLR			0x088
 #define TRCVIPCSSCTLR			0x08C
-#define TRCVDCTLR			0x0A0
-#define TRCVDSACCTLR			0x0A4
-#define TRCVDARCCTLR			0x0A8
 /* Derived resources registers */
 #define TRCSEQEVRn(n)			(0x100 + (n * 4)) /* n = 0-2 */
 #define TRCSEQRSTEVR			0x118
@@ -90,9 +87,6 @@
 /* Address Comparator registers n = 0-15 */
 #define TRCACVRn(n)			(0x400 + (n * 8))
 #define TRCACATRn(n)			(0x480 + (n * 8))
-/* Data Value Comparator Value registers, n = 0-7 */
-#define TRCDVCVRn(n)			(0x500 + (n * 16))
-#define TRCDVCMRn(n)			(0x580 + (n * 16))
 /* ContextID/Virtual ContextID comparators, n = 0-7 */
 #define TRCCIDCVRn(n)			(0x600 + (n * 8))
 #define TRCVMIDCVRn(n)			(0x640 + (n * 8))
@@ -131,6 +125,20 @@
 
 #define TRCRSR_TA			BIT(12)
 
+/*
+ * Bit positions of registers that are defined above, in the sysreg.h style
+ * of _MASK for multi bit fields and BIT() for single bits.
+ */
+#define TRCIDR0_INSTP0_MASK			GENMASK(2, 1)
+#define TRCIDR0_TRCBB				BIT(5)
+#define TRCIDR0_TRCCOND				BIT(6)
+#define TRCIDR0_TRCCCI				BIT(7)
+#define TRCIDR0_RETSTACK			BIT(9)
+#define TRCIDR0_NUMEVENT_MASK			GENMASK(11, 10)
+#define TRCIDR0_QFILT				BIT(14)
+#define TRCIDR0_QSUPP_MASK			GENMASK(16, 15)
+#define TRCIDR0_TSSIZE_MASK			GENMASK(28, 24)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -174,9 +182,6 @@
 /* List of registers accessible via System instructions */
 #define ETM4x_ONLY_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPROCSELR)		\
-	CASE_##op((val), TRCVDCTLR)		\
-	CASE_##op((val), TRCVDSACCTLR)		\
-	CASE_##op((val), TRCVDARCCTLR)		\
 	CASE_##op((val), TRCOSLAR)
 
 #define ETM_COMMON_SYSREG_LIST(op, val)		\
@@ -324,22 +329,6 @@
 	CASE_##op((val), TRCACATRn(13))		\
 	CASE_##op((val), TRCACATRn(14))		\
 	CASE_##op((val), TRCACATRn(15))		\
-	CASE_##op((val), TRCDVCVRn(0))		\
-	CASE_##op((val), TRCDVCVRn(1))		\
-	CASE_##op((val), TRCDVCVRn(2))		\
-	CASE_##op((val), TRCDVCVRn(3))		\
-	CASE_##op((val), TRCDVCVRn(4))		\
-	CASE_##op((val), TRCDVCVRn(5))		\
-	CASE_##op((val), TRCDVCVRn(6))		\
-	CASE_##op((val), TRCDVCVRn(7))		\
-	CASE_##op((val), TRCDVCMRn(0))		\
-	CASE_##op((val), TRCDVCMRn(1))		\
-	CASE_##op((val), TRCDVCMRn(2))		\
-	CASE_##op((val), TRCDVCMRn(3))		\
-	CASE_##op((val), TRCDVCMRn(4))		\
-	CASE_##op((val), TRCDVCMRn(5))		\
-	CASE_##op((val), TRCDVCMRn(6))		\
-	CASE_##op((val), TRCDVCMRn(7))		\
 	CASE_##op((val), TRCCIDCVRn(0))		\
 	CASE_##op((val), TRCCIDCVRn(1))		\
 	CASE_##op((val), TRCCIDCVRn(2))		\
@@ -821,9 +810,6 @@ struct etmv4_save_state {
 	u32	trcviiectlr;
 	u32	trcvissctlr;
 	u32	trcvipcssctlr;
-	u32	trcvdctlr;
-	u32	trcvdsacctlr;
-	u32	trcvdarcctlr;
 
 	u32	trcseqevr[ETM_MAX_SEQ_STATES];
 	u32	trcseqrstevr;
@@ -895,6 +881,7 @@ struct etmv4_save_state {
  * @os_unlock:  True if access to management registers is allowed.
  * @instrp0:	Tracing of load and store instructions
  *		as P0 elements is supported.
+ * @q_filt:	Q element filtering support, if Q elements are supported.
  * @trcbb:	Indicates if the trace unit supports branch broadcast tracing.
  * @trccond:	If the trace unit supports conditional
  *		instruction tracing.
@@ -953,6 +940,7 @@ struct etmv4_drvdata {
 	bool				boot_enable;
 	bool				os_unlock;
 	bool				instrp0;
+	bool				q_filt;
 	bool				trcbb;
 	bool				trccond;
 	bool				retstack;
diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 147d338c191e..648893f9e4b6 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -289,6 +289,11 @@ static const struct pci_device_id intel_th_pci_id_table[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7e24),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Meteor Lake-S CPU */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xae24),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{
 		/* Raptor Lake-S */
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x7a26),
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699ba08..ae9ea3a1fa2a 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -868,8 +868,11 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 		return -ENOMEM;
 
 	stm->major = register_chrdev(0, stm_data->name, &stm_fops);
-	if (stm->major < 0)
-		goto err_free;
+	if (stm->major < 0) {
+		err = stm->major;
+		vfree(stm);
+		return err;
+	}
 
 	device_initialize(&stm->dev);
 	stm->dev.devt = MKDEV(stm->major, 0);
@@ -913,10 +916,8 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 err_device:
 	unregister_chrdev(stm->major, stm_data->name);
 
-	/* matches device_initialize() above */
+	/* calls stm_device_release() */
 	put_device(&stm->dev);
-err_free:
-	vfree(stm);
 
 	return err;
 }
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 15a412e88dd5..7fc82b003b96 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -356,6 +356,19 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	int ret;
 
 	mutex_lock(&master->lock);
+	/*
+	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
+	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
+	 * ibitype will be 0 since it was last updated only after the 8th SCL
+	 * cycle, leading to missed client IBI handlers.
+	 *
+	 * A typical scenario is when IBIWON occurs and bus arbitration is lost
+	 * at svc_i3c_master_priv_xfers().
+	 *
+	 * Clear SVC_I3C_MINT_IBIWON before sending SVC_I3C_MCTRL_REQUEST_AUTO_IBI.
+	 */
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
 	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
 	       SVC_I3C_MCTRL_IBIRESP_AUTO,
@@ -370,9 +383,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		goto reenable_ibis;
 	}
 
-	/* Clear the interrupt status */
-	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
-
 	status = readl(master->regs + SVC_I3C_MSTATUS);
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(status);
 	ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1b6b9530f166..7fdc7a0147f0 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -730,7 +730,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_calculate_temp(struct dps310_data *data)
+static int dps310_calculate_temp(struct dps310_data *data, int *val)
 {
 	s64 c0;
 	s64 t;
@@ -746,7 +746,9 @@ static int dps310_calculate_temp(struct dps310_data *data)
 	t = c0 + ((s64)data->temp_raw * (s64)data->c1);
 
 	/* Convert to milliCelsius and scale the temperature */
-	return (int)div_s64(t * 1000LL, kt);
+	*val = (int)div_s64(t * 1000LL, kt);
+
+	return 0;
 }
 
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
@@ -768,11 +770,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_temp(data);
-		if (rc < 0)
+		rc = dps310_calculate_temp(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 2d84a6b3f05d..fa84ce33076a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.h
@@ -61,16 +61,16 @@ enum {
 	 (sizeof(struct scatterlist) + sizeof(void *)))
 
 #define check_whether_bt_num_3(type, hop_num) \
-	(type < HEM_TYPE_MTT && hop_num == 2)
+	((type) < HEM_TYPE_MTT && (hop_num) == 2)
 
 #define check_whether_bt_num_2(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == 2))
+	(((type) < HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 2))
 
 #define check_whether_bt_num_1(type, hop_num) \
-	((type < HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0) || \
-	(type >= HEM_TYPE_MTT && hop_num == 1) || \
-	(type >= HEM_TYPE_MTT && hop_num == HNS_ROCE_HOP_NUM_0))
+	(((type) < HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == 1) || \
+	((type) >= HEM_TYPE_MTT && (hop_num) == HNS_ROCE_HOP_NUM_0))
 
 struct hns_roce_hem_chunk {
 	struct list_head	 list;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 7376f012ece1..4accc9efa694 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2202,7 +2202,7 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 		caps->gid_table_len[0] = caps->gmv_bt_num *
 					(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
 
-		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
+		caps->gmv_entry_num = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 							  caps->gmv_entry_sz);
 	} else {
 		u32 func_num = max_t(u32, 1, hr_dev->func_num);
@@ -3514,8 +3514,9 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
 		   wc->status == IB_WC_WR_FLUSH_ERR))
 		return;
 
-	ibdev_err(&hr_dev->ib_dev, "error cqe status 0x%x:\n", cqe_status);
-	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_NONE, 16, 4, cqe,
+	ibdev_err_ratelimited(&hr_dev->ib_dev, "error cqe status 0x%x:\n",
+			      cqe_status);
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 4, cqe,
 		       cq->cqe_size, false);
 	wc->vendor_err = hr_reg_read(cqe, CQE_SUB_STATUS);
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index 80b9a9a45c68..e2d2f8f2bdbc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -38,6 +38,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
+#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 12c482f4a1c4..7106e51d5fad 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -444,18 +444,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	struct hns_roce_mr *mr = to_hr_mr(ibmr);
 	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
-	int ret = 0;
+	int ret, sg_num = 0;
 
 	mr->npages = 0;
 	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
 				 sizeof(dma_addr_t), GFP_KERNEL);
 	if (!mr->page_list)
-		return ret;
+		return sg_num;
 
-	ret = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
-	if (ret < 1) {
+	sg_num = ib_sg_to_pages(ibmr, sg, sg_nents, sg_offset, hns_roce_set_page);
+	if (sg_num < 1) {
 		ibdev_err(ibdev, "failed to store sg pages %u %u, cnt = %d.\n",
-			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, ret);
+			  mr->npages, mr->pbl_mtr.hem_cfg.buf_pg_count, sg_num);
 		goto err_page_list;
 	}
 
@@ -466,17 +466,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	ret = hns_roce_mtr_map(hr_dev, mtr, mr->page_list, mr->npages);
 	if (ret) {
 		ibdev_err(ibdev, "failed to map sg mtr, ret = %d.\n", ret);
-		ret = 0;
+		sg_num = 0;
 	} else {
 		mr->pbl_mtr.hem_cfg.buf_pg_shift = (u32)ilog2(ibmr->page_size);
-		ret = mr->npages;
 	}
 
 err_page_list:
 	kvfree(mr->page_list);
 	mr->page_list = NULL;
 
-	return ret;
+	return sg_num;
 }
 
 static void hns_roce_mw_free(struct hns_roce_dev *hr_dev,
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index e64ef6903fb4..35001fb99b94 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -100,7 +100,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		goto err_out;
 	}
 
-	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
 		goto err_put;
@@ -132,7 +132,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 err_mbox:
 	hns_roce_free_cmd_mailbox(hr_dev, mailbox);
 err_xa:
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
 err_out:
@@ -151,7 +151,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
 
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 
 	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index cf203f879d34..191078b6e912 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1687,7 +1687,8 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 	unsigned int diffs = current_access_flags ^ target_access_flags;
 
 	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
-		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
+		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING |
+		      IB_ACCESS_REMOTE_ATOMIC))
 		return false;
 	return mlx5_ib_can_reconfig_with_umr(dev, current_access_flags,
 					     target_access_flags);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 0322dc75396f..323d5d5db247 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -185,8 +185,12 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 
 	ppriv = ipoib_priv(pdev);
 
-	snprintf(intf_name, sizeof(intf_name), "%s.%04x",
-		 ppriv->dev->name, pkey);
+	/* If you increase IFNAMSIZ, update snprintf below
+	 * to allow longer names.
+	 */
+	BUILD_BUG_ON(IFNAMSIZ != 16);
+	snprintf(intf_name, sizeof(intf_name), "%.10s.%04x", ppriv->dev->name,
+		 pkey);
 
 	ndev = ipoib_intf_alloc(ppriv->ca, ppriv->port, intf_name);
 	if (IS_ERR(ndev)) {
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6f38aa23a1ff..b3215c97ee02 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -42,8 +42,8 @@ struct ims_pcu_backlight {
 #define IMS_PCU_PART_NUMBER_LEN		15
 #define IMS_PCU_SERIAL_NUMBER_LEN	8
 #define IMS_PCU_DOM_LEN			8
-#define IMS_PCU_FW_VERSION_LEN		(9 + 1)
-#define IMS_PCU_BL_VERSION_LEN		(9 + 1)
+#define IMS_PCU_FW_VERSION_LEN		16
+#define IMS_PCU_BL_VERSION_LEN		16
 #define IMS_PCU_BL_RESET_REASON_LEN	(2 + 1)
 
 #define IMS_PCU_PCU_B_DEVICE_ID		5
diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 53ad25eaf1a2..8bfe5c7b1244 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -14,7 +14,8 @@
 
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
+#define VIB_PER_STEP_mV		(100)
+#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
 
 #define MAX_FF_SPEED		0xff
 
@@ -118,10 +119,10 @@ static void pm8xxx_work_handler(struct work_struct *work)
 		vib->active = true;
 		vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
 						VIB_MIN_LEVEL_mV;
-		vib->level /= 100;
+		vib->level /= VIB_PER_STEP_mV;
 	} else {
 		vib->active = false;
-		vib->level = VIB_MIN_LEVEL_mV / 100;
+		vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
 	}
 
 	pm8xxx_vib_set(vib, vib->active);
diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 77cc653edca2..e401934df464 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1357,10 +1357,16 @@ static int __maybe_unused cyapa_suspend(struct device *dev)
 	u8 power_mode;
 	int error;
 
-	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	error = mutex_lock_interruptible(&cyapa->input->mutex);
 	if (error)
 		return error;
 
+	error = mutex_lock_interruptible(&cyapa->state_sync_lock);
+	if (error) {
+		mutex_unlock(&cyapa->input->mutex);
+		return error;
+	}
+
 	/*
 	 * Runtime PM is enable only when device is in operational mode and
 	 * users in use, so need check it before disable it to
@@ -1395,6 +1401,8 @@ static int __maybe_unused cyapa_suspend(struct device *dev)
 		cyapa->irq_wake = (enable_irq_wake(client->irq) == 0);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
+
 	return 0;
 }
 
@@ -1404,6 +1412,7 @@ static int __maybe_unused cyapa_resume(struct device *dev)
 	struct cyapa *cyapa = i2c_get_clientdata(client);
 	int error;
 
+	mutex_lock(&cyapa->input->mutex);
 	mutex_lock(&cyapa->state_sync_lock);
 
 	if (device_may_wakeup(dev) && cyapa->irq_wake) {
@@ -1422,6 +1431,7 @@ static int __maybe_unused cyapa_resume(struct device *dev)
 	enable_irq(client->irq);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
 	return 0;
 }
 
diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
index d51bfe912db5..676b0bda3d72 100644
--- a/drivers/input/serio/ioc3kbd.c
+++ b/drivers/input/serio/ioc3kbd.c
@@ -190,7 +190,7 @@ static int ioc3kbd_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ioc3kbd_remove(struct platform_device *pdev)
+static void ioc3kbd_remove(struct platform_device *pdev)
 {
 	struct ioc3kbd_data *d = platform_get_drvdata(pdev);
 
@@ -198,13 +198,18 @@ static int ioc3kbd_remove(struct platform_device *pdev)
 
 	serio_unregister_port(d->kbd);
 	serio_unregister_port(d->aux);
-
-	return 0;
 }
 
+static const struct platform_device_id ioc3kbd_id_table[] = {
+	{ "ioc3-kbd", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ioc3kbd_id_table);
+
 static struct platform_driver ioc3kbd_driver = {
 	.probe          = ioc3kbd_probe,
-	.remove         = ioc3kbd_remove,
+	.remove_new     = ioc3kbd_remove,
+	.id_table	= ioc3kbd_id_table,
 	.driver = {
 		.name = "ioc3-kbd",
 	},
diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index fc1ef7de3797..c9ffd69dfc75 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -165,7 +165,7 @@ static int alpine_msix_middle_domain_alloc(struct irq_domain *domain,
 	return 0;
 
 err_sgi:
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 	alpine_msix_free_sgi(priv, sgi, nr_irqs);
 	return err;
 }
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 32562b7e681b..254a58fbb844 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -132,7 +132,7 @@ static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
 
 err_hwirq:
 	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
-	irq_domain_free_irqs_parent(domain, virq, i - 1);
+	irq_domain_free_irqs_parent(domain, virq, i);
 
 	return err;
 }
diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index db9270da5b8e..b6ddf1d47cb4 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -140,24 +140,19 @@ static int macii_probe(void)
 /* Initialize the driver */
 static int macii_init(void)
 {
-	unsigned long flags;
 	int err;
 
-	local_irq_save(flags);
-
 	err = macii_init_via();
 	if (err)
-		goto out;
+		return err;
 
 	err = request_irq(IRQ_MAC_ADB, macii_interrupt, 0, "ADB",
 			  macii_interrupt);
 	if (err)
-		goto out;
+		return err;
 
 	macii_state = idle;
-out:
-	local_irq_restore(flags);
-	return err;
+	return 0;
 }
 
 /* initialize the hardware */
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 49c46f3aea57..b26e22dd9ba2 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1355,7 +1355,7 @@ __acquires(bitmap->lock)
 	sector_t chunk = offset >> bitmap->chunkshift;
 	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
 	unsigned long pageoff = (chunk & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
-	sector_t csize;
+	sector_t csize = ((sector_t)1) << bitmap->chunkshift;
 	int err;
 
 	if (page >= bitmap->pages) {
@@ -1364,6 +1364,7 @@ __acquires(bitmap->lock)
 		 * End-of-device while looking for a whole page or
 		 * user set a huge number to sysfs bitmap_set_bits.
 		 */
+		*blocks = csize - (offset & (csize - 1));
 		return NULL;
 	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
@@ -1372,8 +1373,7 @@ __acquires(bitmap->lock)
 	    bitmap->bp[page].map == NULL)
 		csize = ((sector_t)1) << (bitmap->chunkshift +
 					  PAGE_COUNTER_SHIFT);
-	else
-		csize = ((sector_t)1) << bitmap->chunkshift;
+
 	*blocks = csize - (offset & (csize - 1));
 
 	if (err < 0)
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index c2a42486f985..bcd43cca94f9 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -36,7 +36,6 @@
  */
 
 #include <linux/blkdev.h>
-#include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/raid/pq.h>
 #include <linux/async_tx.h>
@@ -6486,6 +6485,9 @@ static void raid5d(struct md_thread *thread)
 		int batch_size, released;
 		unsigned int offset;
 
+		if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
+			break;
+
 		released = release_stripe_list(conf, conf->temp_inactive_list);
 		if (released)
 			clear_bit(R5_DID_ALLOC, &conf->cache_state);
@@ -6522,18 +6524,7 @@ static void raid5d(struct md_thread *thread)
 			spin_unlock_irq(&conf->device_lock);
 			md_check_recovery(mddev);
 			spin_lock_irq(&conf->device_lock);
-
-			/*
-			 * Waiting on MD_SB_CHANGE_PENDING below may deadlock
-			 * seeing md_check_recovery() is needed to clear
-			 * the flag when using mdmon.
-			 */
-			continue;
 		}
-
-		wait_event_lock_irq(mddev->sb_wait,
-			!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags),
-			conf->device_lock);
 	}
 	pr_debug("%d stripes handled\n", handled);
 
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 01ff1329e01c..1f8ac656aede 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -39,15 +39,6 @@ static void cec_fill_msg_report_features(struct cec_adapter *adap,
  */
 #define CEC_XFER_TIMEOUT_MS (5 * 400 + 100)
 
-#define call_op(adap, op, arg...) \
-	(adap->ops->op ? adap->ops->op(adap, ## arg) : 0)
-
-#define call_void_op(adap, op, arg...)			\
-	do {						\
-		if (adap->ops->op)			\
-			adap->ops->op(adap, ## arg);	\
-	} while (0)
-
 static int cec_log_addr2idx(const struct cec_adapter *adap, u8 log_addr)
 {
 	int i;
@@ -366,38 +357,48 @@ static void cec_data_completed(struct cec_data *data)
 /*
  * A pending CEC transmit needs to be cancelled, either because the CEC
  * adapter is disabled or the transmit takes an impossibly long time to
- * finish.
+ * finish, or the reply timed out.
  *
  * This function is called with adap->lock held.
  */
-static void cec_data_cancel(struct cec_data *data, u8 tx_status)
+static void cec_data_cancel(struct cec_data *data, u8 tx_status, u8 rx_status)
 {
+	struct cec_adapter *adap = data->adap;
+
 	/*
 	 * It's either the current transmit, or it is a pending
 	 * transmit. Take the appropriate action to clear it.
 	 */
-	if (data->adap->transmitting == data) {
-		data->adap->transmitting = NULL;
+	if (adap->transmitting == data) {
+		adap->transmitting = NULL;
 	} else {
 		list_del_init(&data->list);
 		if (!(data->msg.tx_status & CEC_TX_STATUS_OK))
-			if (!WARN_ON(!data->adap->transmit_queue_sz))
-				data->adap->transmit_queue_sz--;
+			if (!WARN_ON(!adap->transmit_queue_sz))
+				adap->transmit_queue_sz--;
 	}
 
 	if (data->msg.tx_status & CEC_TX_STATUS_OK) {
 		data->msg.rx_ts = ktime_get_ns();
-		data->msg.rx_status = CEC_RX_STATUS_ABORTED;
+		data->msg.rx_status = rx_status;
+		if (!data->blocking)
+			data->msg.tx_status = 0;
 	} else {
 		data->msg.tx_ts = ktime_get_ns();
 		data->msg.tx_status |= tx_status |
 				       CEC_TX_STATUS_MAX_RETRIES;
 		data->msg.tx_error_cnt++;
 		data->attempts = 0;
+		if (!data->blocking)
+			data->msg.rx_status = 0;
 	}
 
 	/* Queue transmitted message for monitoring purposes */
-	cec_queue_msg_monitor(data->adap, &data->msg, 1);
+	cec_queue_msg_monitor(adap, &data->msg, 1);
+
+	if (!data->blocking && data->msg.sequence)
+		/* Allow drivers to react to a canceled transmit */
+		call_void_op(adap, adap_nb_transmit_canceled, &data->msg);
 
 	cec_data_completed(data);
 }
@@ -418,15 +419,15 @@ static void cec_flush(struct cec_adapter *adap)
 	while (!list_empty(&adap->transmit_queue)) {
 		data = list_first_entry(&adap->transmit_queue,
 					struct cec_data, list);
-		cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+		cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
 	}
 	if (adap->transmitting)
-		cec_data_cancel(adap->transmitting, CEC_TX_STATUS_ABORTED);
+		adap->transmit_in_progress_aborted = true;
 
 	/* Cancel the pending timeout work. */
 	list_for_each_entry_safe(data, n, &adap->wait_queue, list) {
 		if (cancel_delayed_work(&data->work))
-			cec_data_cancel(data, CEC_TX_STATUS_OK);
+			cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
 		/*
 		 * If cancel_delayed_work returned false, then
 		 * the cec_wait_timeout function is running,
@@ -501,6 +502,15 @@ int cec_thread_func(void *_adap)
 			goto unlock;
 		}
 
+		if (adap->transmit_in_progress &&
+		    adap->transmit_in_progress_aborted) {
+			if (adap->transmitting)
+				cec_data_cancel(adap->transmitting,
+						CEC_TX_STATUS_ABORTED, 0);
+			adap->transmit_in_progress = false;
+			adap->transmit_in_progress_aborted = false;
+			goto unlock;
+		}
 		if (adap->transmit_in_progress && timeout) {
 			/*
 			 * If we timeout, then log that. Normally this does
@@ -516,7 +526,7 @@ int cec_thread_func(void *_adap)
 					adap->transmitting->msg.msg);
 				/* Just give up on this. */
 				cec_data_cancel(adap->transmitting,
-						CEC_TX_STATUS_TIMEOUT);
+						CEC_TX_STATUS_TIMEOUT, 0);
 			} else {
 				pr_warn("cec-%s: transmit timed out\n", adap->name);
 			}
@@ -572,10 +582,11 @@ int cec_thread_func(void *_adap)
 		if (data->attempts == 0)
 			data->attempts = attempts;
 
+		adap->transmit_in_progress_aborted = false;
 		/* Tell the adapter to transmit, cancel on error */
-		if (adap->ops->adap_transmit(adap, data->attempts,
-					     signal_free_time, &data->msg))
-			cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+		if (call_op(adap, adap_transmit, data->attempts,
+			    signal_free_time, &data->msg))
+			cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
 		else
 			adap->transmit_in_progress = true;
 
@@ -599,6 +610,8 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 	struct cec_msg *msg;
 	unsigned int attempts_made = arb_lost_cnt + nack_cnt +
 				     low_drive_cnt + error_cnt;
+	bool done = status & (CEC_TX_STATUS_MAX_RETRIES | CEC_TX_STATUS_OK);
+	bool aborted = adap->transmit_in_progress_aborted;
 
 	dprintk(2, "%s: status 0x%02x\n", __func__, status);
 	if (attempts_made < 1)
@@ -619,6 +632,7 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 		goto wake_thread;
 	}
 	adap->transmit_in_progress = false;
+	adap->transmit_in_progress_aborted = false;
 
 	msg = &data->msg;
 
@@ -639,8 +653,7 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 	 * the hardware didn't signal that it retried itself (by setting
 	 * CEC_TX_STATUS_MAX_RETRIES), then we will retry ourselves.
 	 */
-	if (data->attempts > attempts_made &&
-	    !(status & (CEC_TX_STATUS_MAX_RETRIES | CEC_TX_STATUS_OK))) {
+	if (!aborted && data->attempts > attempts_made && !done) {
 		/* Retry this message */
 		data->attempts -= attempts_made;
 		if (msg->timeout)
@@ -655,6 +668,8 @@ void cec_transmit_done_ts(struct cec_adapter *adap, u8 status,
 		goto wake_thread;
 	}
 
+	if (aborted && !done)
+		status |= CEC_TX_STATUS_ABORTED;
 	data->attempts = 0;
 
 	/* Always set CEC_TX_STATUS_MAX_RETRIES on error */
@@ -733,9 +748,7 @@ static void cec_wait_timeout(struct work_struct *work)
 
 	/* Mark the message as timed out */
 	list_del_init(&data->list);
-	data->msg.rx_ts = ktime_get_ns();
-	data->msg.rx_status = CEC_RX_STATUS_TIMEOUT;
-	cec_data_completed(data);
+	cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_TIMEOUT);
 unlock:
 	mutex_unlock(&adap->lock);
 }
@@ -751,6 +764,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 {
 	struct cec_data *data;
 	bool is_raw = msg_is_raw(msg);
+	int err;
 
 	if (adap->devnode.unregistered)
 		return -ENODEV;
@@ -913,14 +927,20 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 	 * Release the lock and wait, retake the lock afterwards.
 	 */
 	mutex_unlock(&adap->lock);
-	wait_for_completion_killable(&data->c);
-	if (!data->completed)
-		cancel_delayed_work_sync(&data->work);
+	err = wait_for_completion_killable(&data->c);
+	cancel_delayed_work_sync(&data->work);
 	mutex_lock(&adap->lock);
 
+	if (err)
+		adap->transmit_in_progress_aborted = true;
+
 	/* Cancel the transmit if it was interrupted */
-	if (!data->completed)
-		cec_data_cancel(data, CEC_TX_STATUS_ABORTED);
+	if (!data->completed) {
+		if (data->msg.tx_status & CEC_TX_STATUS_OK)
+			cec_data_cancel(data, CEC_TX_STATUS_OK, CEC_RX_STATUS_ABORTED);
+		else
+			cec_data_cancel(data, CEC_TX_STATUS_ABORTED, 0);
+	}
 
 	/* The transmit completed (possibly with an error) */
 	*msg = data->msg;
@@ -1295,7 +1315,7 @@ static int cec_config_log_addr(struct cec_adapter *adap,
 	 * Message not acknowledged, so this logical
 	 * address is free to use.
 	 */
-	err = adap->ops->adap_log_addr(adap, log_addr);
+	err = call_op(adap, adap_log_addr, log_addr);
 	if (err)
 		return err;
 
@@ -1312,9 +1332,8 @@ static int cec_config_log_addr(struct cec_adapter *adap,
  */
 static void cec_adap_unconfigure(struct cec_adapter *adap)
 {
-	if (!adap->needs_hpd ||
-	    adap->phys_addr != CEC_PHYS_ADDR_INVALID)
-		WARN_ON(adap->ops->adap_log_addr(adap, CEC_LOG_ADDR_INVALID));
+	if (!adap->needs_hpd || adap->phys_addr != CEC_PHYS_ADDR_INVALID)
+		WARN_ON(call_op(adap, adap_log_addr, CEC_LOG_ADDR_INVALID));
 	adap->log_addrs.log_addr_mask = 0;
 	adap->is_configured = false;
 	cec_flush(adap);
@@ -1522,9 +1541,12 @@ static int cec_config_thread_func(void *arg)
  */
 static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 {
-	if (WARN_ON(adap->is_configuring || adap->is_configured))
+	if (WARN_ON(adap->is_claiming_log_addrs ||
+		    adap->is_configuring || adap->is_configured))
 		return;
 
+	adap->is_claiming_log_addrs = true;
+
 	init_completion(&adap->config_completion);
 
 	/* Ready to kick off the thread */
@@ -1533,11 +1555,67 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 					   "ceccfg-%s", adap->name);
 	if (IS_ERR(adap->kthread_config)) {
 		adap->kthread_config = NULL;
+		adap->is_configuring = false;
 	} else if (block) {
 		mutex_unlock(&adap->lock);
 		wait_for_completion(&adap->config_completion);
 		mutex_lock(&adap->lock);
 	}
+	adap->is_claiming_log_addrs = false;
+}
+
+/*
+ * Helper function to enable/disable the CEC adapter.
+ *
+ * This function is called with adap->lock held.
+ */
+static int cec_adap_enable(struct cec_adapter *adap)
+{
+	bool enable;
+	int ret = 0;
+
+	enable = adap->monitor_all_cnt || adap->monitor_pin_cnt ||
+		 adap->log_addrs.num_log_addrs;
+	if (adap->needs_hpd)
+		enable = enable && adap->phys_addr != CEC_PHYS_ADDR_INVALID;
+
+	if (enable == adap->is_enabled)
+		return 0;
+
+	/* serialize adap_enable */
+	mutex_lock(&adap->devnode.lock);
+	if (enable) {
+		adap->last_initiator = 0xff;
+		adap->transmit_in_progress = false;
+		ret = adap->ops->adap_enable(adap, true);
+		if (!ret) {
+			/*
+			 * Enable monitor-all/pin modes if needed. We warn, but
+			 * continue if this fails as this is not a critical error.
+			 */
+			if (adap->monitor_all_cnt)
+				WARN_ON(call_op(adap, adap_monitor_all_enable, true));
+			if (adap->monitor_pin_cnt)
+				WARN_ON(call_op(adap, adap_monitor_pin_enable, true));
+		}
+	} else {
+		/* Disable monitor-all/pin modes if needed (needs_hpd == 1) */
+		if (adap->monitor_all_cnt)
+			WARN_ON(call_op(adap, adap_monitor_all_enable, false));
+		if (adap->monitor_pin_cnt)
+			WARN_ON(call_op(adap, adap_monitor_pin_enable, false));
+		WARN_ON(adap->ops->adap_enable(adap, false));
+		adap->last_initiator = 0xff;
+		adap->transmit_in_progress = false;
+		adap->transmit_in_progress_aborted = false;
+		if (adap->transmitting)
+			cec_data_cancel(adap->transmitting, CEC_TX_STATUS_ABORTED, 0);
+	}
+	if (!ret)
+		adap->is_enabled = enable;
+	wake_up_interruptible(&adap->kthread_waitq);
+	mutex_unlock(&adap->devnode.lock);
+	return ret;
 }
 
 /* Set a new physical address and send an event notifying userspace of this.
@@ -1546,55 +1624,30 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
  */
 void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block)
 {
+	bool becomes_invalid = phys_addr == CEC_PHYS_ADDR_INVALID;
+	bool is_invalid = adap->phys_addr == CEC_PHYS_ADDR_INVALID;
+
 	if (phys_addr == adap->phys_addr)
 		return;
-	if (phys_addr != CEC_PHYS_ADDR_INVALID && adap->devnode.unregistered)
+	if (!becomes_invalid && adap->devnode.unregistered)
 		return;
 
 	dprintk(1, "new physical address %x.%x.%x.%x\n",
 		cec_phys_addr_exp(phys_addr));
-	if (phys_addr == CEC_PHYS_ADDR_INVALID ||
-	    adap->phys_addr != CEC_PHYS_ADDR_INVALID) {
+	if (becomes_invalid || !is_invalid) {
 		adap->phys_addr = CEC_PHYS_ADDR_INVALID;
 		cec_post_state_event(adap);
 		cec_adap_unconfigure(adap);
-		/* Disabling monitor all mode should always succeed */
-		if (adap->monitor_all_cnt)
-			WARN_ON(call_op(adap, adap_monitor_all_enable, false));
-		/* serialize adap_enable */
-		mutex_lock(&adap->devnode.lock);
-		if (adap->needs_hpd || list_empty(&adap->devnode.fhs)) {
-			WARN_ON(adap->ops->adap_enable(adap, false));
-			adap->transmit_in_progress = false;
-			wake_up_interruptible(&adap->kthread_waitq);
-		}
-		mutex_unlock(&adap->devnode.lock);
-		if (phys_addr == CEC_PHYS_ADDR_INVALID)
-			return;
-	}
-
-	/* serialize adap_enable */
-	mutex_lock(&adap->devnode.lock);
-	adap->last_initiator = 0xff;
-	adap->transmit_in_progress = false;
-
-	if (adap->needs_hpd || list_empty(&adap->devnode.fhs)) {
-		if (adap->ops->adap_enable(adap, true)) {
-			mutex_unlock(&adap->devnode.lock);
+		if (becomes_invalid) {
+			cec_adap_enable(adap);
 			return;
 		}
 	}
 
-	if (adap->monitor_all_cnt &&
-	    call_op(adap, adap_monitor_all_enable, true)) {
-		if (adap->needs_hpd || list_empty(&adap->devnode.fhs))
-			WARN_ON(adap->ops->adap_enable(adap, false));
-		mutex_unlock(&adap->devnode.lock);
-		return;
-	}
-	mutex_unlock(&adap->devnode.lock);
-
 	adap->phys_addr = phys_addr;
+	if (is_invalid)
+		cec_adap_enable(adap);
+
 	cec_post_state_event(adap);
 	if (adap->log_addrs.num_log_addrs)
 		cec_claim_log_addrs(adap, block);
@@ -1651,12 +1704,15 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		      struct cec_log_addrs *log_addrs, bool block)
 {
 	u16 type_mask = 0;
+	int err;
 	int i;
 
 	if (adap->devnode.unregistered)
 		return -ENODEV;
 
 	if (!log_addrs || log_addrs->num_log_addrs == 0) {
+		if (!adap->is_configuring && !adap->is_configured)
+			return 0;
 		cec_adap_unconfigure(adap);
 		adap->log_addrs.num_log_addrs = 0;
 		for (i = 0; i < CEC_MAX_LOG_ADDRS; i++)
@@ -1664,6 +1720,7 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 		adap->log_addrs.osd_name[0] = '\0';
 		adap->log_addrs.vendor_id = CEC_VENDOR_ID_NONE;
 		adap->log_addrs.cec_version = CEC_OP_CEC_VERSION_2_0;
+		cec_adap_enable(adap);
 		return 0;
 	}
 
@@ -1799,9 +1856,10 @@ int __cec_s_log_addrs(struct cec_adapter *adap,
 
 	log_addrs->log_addr_mask = adap->log_addrs.log_addr_mask;
 	adap->log_addrs = *log_addrs;
-	if (adap->phys_addr != CEC_PHYS_ADDR_INVALID)
+	err = cec_adap_enable(adap);
+	if (!err && adap->phys_addr != CEC_PHYS_ADDR_INVALID)
 		cec_claim_log_addrs(adap, block);
-	return 0;
+	return err;
 }
 
 int cec_s_log_addrs(struct cec_adapter *adap,
@@ -1903,11 +1961,10 @@ static int cec_receive_notify(struct cec_adapter *adap, struct cec_msg *msg,
 	    msg->msg[1] != CEC_MSG_CDC_MESSAGE)
 		return 0;
 
-	if (adap->ops->received) {
-		/* Allow drivers to process the message first */
-		if (adap->ops->received(adap, msg) != -ENOMSG)
-			return 0;
-	}
+	/* Allow drivers to process the message first */
+	if (adap->ops->received && !adap->devnode.unregistered &&
+	    adap->ops->received(adap, msg) != -ENOMSG)
+		return 0;
 
 	/*
 	 * REPORT_PHYSICAL_ADDR, CEC_MSG_USER_CONTROL_PRESSED and
@@ -2100,20 +2157,25 @@ static int cec_receive_notify(struct cec_adapter *adap, struct cec_msg *msg,
  */
 int cec_monitor_all_cnt_inc(struct cec_adapter *adap)
 {
-	int ret = 0;
+	int ret;
 
-	if (adap->monitor_all_cnt == 0)
-		ret = call_op(adap, adap_monitor_all_enable, 1);
-	if (ret == 0)
-		adap->monitor_all_cnt++;
+	if (adap->monitor_all_cnt++)
+		return 0;
+
+	ret = cec_adap_enable(adap);
+	if (ret)
+		adap->monitor_all_cnt--;
 	return ret;
 }
 
 void cec_monitor_all_cnt_dec(struct cec_adapter *adap)
 {
-	adap->monitor_all_cnt--;
-	if (adap->monitor_all_cnt == 0)
-		WARN_ON(call_op(adap, adap_monitor_all_enable, 0));
+	if (WARN_ON(!adap->monitor_all_cnt))
+		return;
+	if (--adap->monitor_all_cnt)
+		return;
+	WARN_ON(call_op(adap, adap_monitor_all_enable, false));
+	cec_adap_enable(adap);
 }
 
 /*
@@ -2123,20 +2185,25 @@ void cec_monitor_all_cnt_dec(struct cec_adapter *adap)
  */
 int cec_monitor_pin_cnt_inc(struct cec_adapter *adap)
 {
-	int ret = 0;
+	int ret;
+
+	if (adap->monitor_pin_cnt++)
+		return 0;
 
-	if (adap->monitor_pin_cnt == 0)
-		ret = call_op(adap, adap_monitor_pin_enable, 1);
-	if (ret == 0)
-		adap->monitor_pin_cnt++;
+	ret = cec_adap_enable(adap);
+	if (ret)
+		adap->monitor_pin_cnt--;
 	return ret;
 }
 
 void cec_monitor_pin_cnt_dec(struct cec_adapter *adap)
 {
-	adap->monitor_pin_cnt--;
-	if (adap->monitor_pin_cnt == 0)
-		WARN_ON(call_op(adap, adap_monitor_pin_enable, 0));
+	if (WARN_ON(!adap->monitor_pin_cnt))
+		return;
+	if (--adap->monitor_pin_cnt)
+		return;
+	WARN_ON(call_op(adap, adap_monitor_pin_enable, false));
+	cec_adap_enable(adap);
 }
 
 #ifdef CONFIG_DEBUG_FS
@@ -2150,6 +2217,7 @@ int cec_adap_status(struct seq_file *file, void *priv)
 	struct cec_data *data;
 
 	mutex_lock(&adap->lock);
+	seq_printf(file, "enabled: %d\n", adap->is_enabled);
 	seq_printf(file, "configured: %d\n", adap->is_configured);
 	seq_printf(file, "configuring: %d\n", adap->is_configuring);
 	seq_printf(file, "phys_addr: %x.%x.%x.%x\n",
@@ -2164,6 +2232,9 @@ int cec_adap_status(struct seq_file *file, void *priv)
 	if (adap->monitor_all_cnt)
 		seq_printf(file, "file handles in Monitor All mode: %u\n",
 			   adap->monitor_all_cnt);
+	if (adap->monitor_pin_cnt)
+		seq_printf(file, "file handles in Monitor Pin mode: %u\n",
+			   adap->monitor_pin_cnt);
 	if (adap->tx_timeouts) {
 		seq_printf(file, "transmit timeouts: %u\n",
 			   adap->tx_timeouts);
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 52c30e4e2005..7f260f2cbb15 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -178,7 +178,7 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
 			   CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
 			   CEC_LOG_ADDRS_FL_CDC_ONLY;
 	mutex_lock(&adap->lock);
-	if (!adap->is_configuring &&
+	if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
 	    (!log_addrs.num_log_addrs || !adap->is_configured) &&
 	    !cec_is_busy(adap, fh)) {
 		err = __cec_s_log_addrs(adap, &log_addrs, block);
@@ -586,18 +586,6 @@ static int cec_open(struct inode *inode, struct file *filp)
 		return err;
 	}
 
-	/* serialize adap_enable */
-	mutex_lock(&devnode->lock);
-	if (list_empty(&devnode->fhs) &&
-	    !adap->needs_hpd &&
-	    adap->phys_addr == CEC_PHYS_ADDR_INVALID) {
-		err = adap->ops->adap_enable(adap, true);
-		if (err) {
-			mutex_unlock(&devnode->lock);
-			kfree(fh);
-			return err;
-		}
-	}
 	filp->private_data = fh;
 
 	/* Queue up initial state events */
@@ -607,7 +595,8 @@ static int cec_open(struct inode *inode, struct file *filp)
 		adap->conn_info.type != CEC_CONNECTOR_TYPE_NO_CONNECTOR;
 	cec_queue_event_fh(fh, &ev, 0);
 #ifdef CONFIG_CEC_PIN
-	if (adap->pin && adap->pin->ops->read_hpd) {
+	if (adap->pin && adap->pin->ops->read_hpd &&
+	    !adap->devnode.unregistered) {
 		err = adap->pin->ops->read_hpd(adap);
 		if (err >= 0) {
 			ev.event = err ? CEC_EVENT_PIN_HPD_HIGH :
@@ -615,7 +604,8 @@ static int cec_open(struct inode *inode, struct file *filp)
 			cec_queue_event_fh(fh, &ev, 0);
 		}
 	}
-	if (adap->pin && adap->pin->ops->read_5v) {
+	if (adap->pin && adap->pin->ops->read_5v &&
+	    !adap->devnode.unregistered) {
 		err = adap->pin->ops->read_5v(adap);
 		if (err >= 0) {
 			ev.event = err ? CEC_EVENT_PIN_5V_HIGH :
@@ -625,6 +615,7 @@ static int cec_open(struct inode *inode, struct file *filp)
 	}
 #endif
 
+	mutex_lock(&devnode->lock);
 	mutex_lock(&devnode->lock_fhs);
 	list_add(&fh->list, &devnode->fhs);
 	mutex_unlock(&devnode->lock_fhs);
@@ -656,15 +647,10 @@ static int cec_release(struct inode *inode, struct file *filp)
 		cec_monitor_all_cnt_dec(adap);
 	mutex_unlock(&adap->lock);
 
-	/* serialize adap_enable */
 	mutex_lock(&devnode->lock);
 	mutex_lock(&devnode->lock_fhs);
 	list_del(&fh->list);
 	mutex_unlock(&devnode->lock_fhs);
-	if (cec_is_registered(adap) && list_empty(&devnode->fhs) &&
-	    !adap->needs_hpd && adap->phys_addr == CEC_PHYS_ADDR_INVALID) {
-		WARN_ON(adap->ops->adap_enable(adap, false));
-	}
 	mutex_unlock(&devnode->lock);
 
 	/* Unhook pending transmits from this filehandle. */
@@ -678,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
 		list_del(&data->xfer_list);
 	}
 	mutex_unlock(&adap->lock);
+
+	mutex_lock(&fh->lock);
 	while (!list_empty(&fh->msgs)) {
 		struct cec_msg_entry *entry =
 			list_first_entry(&fh->msgs, struct cec_msg_entry, list);
@@ -695,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
 			kfree(entry);
 		}
 	}
+	mutex_unlock(&fh->lock);
 	kfree(fh);
 
 	cec_put_device(devnode);
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index ec67065d5202..34f1631b7709 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -204,7 +204,7 @@ static ssize_t cec_error_inj_write(struct file *file,
 		line = strsep(&p, "\n");
 		if (!*line || *line == '#')
 			continue;
-		if (!adap->ops->error_inj_parse_line(adap, line)) {
+		if (!call_op(adap, error_inj_parse_line, line)) {
 			kfree(buf);
 			return -EINVAL;
 		}
@@ -217,7 +217,7 @@ static int cec_error_inj_show(struct seq_file *sf, void *unused)
 {
 	struct cec_adapter *adap = sf->private;
 
-	return adap->ops->error_inj_show(adap, sf);
+	return call_op(adap, error_inj_show, sf);
 }
 
 static int cec_error_inj_open(struct inode *inode, struct file *file)
diff --git a/drivers/media/cec/core/cec-pin-priv.h b/drivers/media/cec/core/cec-pin-priv.h
index fb101f15865c..e7d63f6acb30 100644
--- a/drivers/media/cec/core/cec-pin-priv.h
+++ b/drivers/media/cec/core/cec-pin-priv.h
@@ -12,6 +12,17 @@
 #include <linux/atomic.h>
 #include <media/cec-pin.h>
 
+#define call_pin_op(pin, op, arg...)					\
+	((pin && pin->ops->op && !pin->adap->devnode.unregistered) ?	\
+	 pin->ops->op(pin->adap, ## arg) : 0)
+
+#define call_void_pin_op(pin, op, arg...)				\
+	do {								\
+		if (pin && pin->ops->op &&				\
+		    !pin->adap->devnode.unregistered)			\
+			pin->ops->op(pin->adap, ## arg);		\
+	} while (0)
+
 enum cec_pin_state {
 	/* CEC is off */
 	CEC_ST_OFF,
diff --git a/drivers/media/cec/core/cec-pin.c b/drivers/media/cec/core/cec-pin.c
index 0eb90cc0ffb0..99e69c49e0c9 100644
--- a/drivers/media/cec/core/cec-pin.c
+++ b/drivers/media/cec/core/cec-pin.c
@@ -135,7 +135,7 @@ static void cec_pin_update(struct cec_pin *pin, bool v, bool force)
 
 static bool cec_pin_read(struct cec_pin *pin)
 {
-	bool v = pin->ops->read(pin->adap);
+	bool v = call_pin_op(pin, read);
 
 	cec_pin_update(pin, v, false);
 	return v;
@@ -143,13 +143,13 @@ static bool cec_pin_read(struct cec_pin *pin)
 
 static void cec_pin_low(struct cec_pin *pin)
 {
-	pin->ops->low(pin->adap);
+	call_void_pin_op(pin, low);
 	cec_pin_update(pin, false, false);
 }
 
 static bool cec_pin_high(struct cec_pin *pin)
 {
-	pin->ops->high(pin->adap);
+	call_void_pin_op(pin, high);
 	return cec_pin_read(pin);
 }
 
@@ -1086,7 +1086,7 @@ static int cec_pin_thread_func(void *_adap)
 				    CEC_PIN_IRQ_UNCHANGED)) {
 		case CEC_PIN_IRQ_DISABLE:
 			if (irq_enabled) {
-				pin->ops->disable_irq(adap);
+				call_void_pin_op(pin, disable_irq);
 				irq_enabled = false;
 			}
 			cec_pin_high(pin);
@@ -1097,7 +1097,7 @@ static int cec_pin_thread_func(void *_adap)
 		case CEC_PIN_IRQ_ENABLE:
 			if (irq_enabled)
 				break;
-			pin->enable_irq_failed = !pin->ops->enable_irq(adap);
+			pin->enable_irq_failed = !call_pin_op(pin, enable_irq);
 			if (pin->enable_irq_failed) {
 				cec_pin_to_idle(pin);
 				hrtimer_start(&pin->timer, ns_to_ktime(0),
@@ -1112,8 +1112,8 @@ static int cec_pin_thread_func(void *_adap)
 		if (kthread_should_stop())
 			break;
 	}
-	if (pin->ops->disable_irq && irq_enabled)
-		pin->ops->disable_irq(adap);
+	if (irq_enabled)
+		call_void_pin_op(pin, disable_irq);
 	hrtimer_cancel(&pin->timer);
 	cec_pin_read(pin);
 	cec_pin_to_idle(pin);
@@ -1208,7 +1208,7 @@ static void cec_pin_adap_status(struct cec_adapter *adap,
 	seq_printf(file, "state: %s\n", states[pin->state].name);
 	seq_printf(file, "tx_bit: %d\n", pin->tx_bit);
 	seq_printf(file, "rx_bit: %d\n", pin->rx_bit);
-	seq_printf(file, "cec pin: %d\n", pin->ops->read(adap));
+	seq_printf(file, "cec pin: %d\n", call_pin_op(pin, read));
 	seq_printf(file, "cec pin events dropped: %u\n",
 		   pin->work_pin_events_dropped_cnt);
 	seq_printf(file, "irq failed: %d\n", pin->enable_irq_failed);
@@ -1261,8 +1261,7 @@ static void cec_pin_adap_status(struct cec_adapter *adap,
 	pin->rx_data_bit_too_long_cnt = 0;
 	pin->rx_low_drive_cnt = 0;
 	pin->tx_low_drive_cnt = 0;
-	if (pin->ops->status)
-		pin->ops->status(adap, file);
+	call_void_pin_op(pin, status, file);
 }
 
 static int cec_pin_adap_monitor_all_enable(struct cec_adapter *adap,
@@ -1278,7 +1277,7 @@ static void cec_pin_adap_free(struct cec_adapter *adap)
 {
 	struct cec_pin *pin = adap->pin;
 
-	if (pin->ops->free)
+	if (pin && pin->ops->free)
 		pin->ops->free(adap);
 	adap->pin = NULL;
 	kfree(pin);
@@ -1288,7 +1287,7 @@ static int cec_pin_received(struct cec_adapter *adap, struct cec_msg *msg)
 {
 	struct cec_pin *pin = adap->pin;
 
-	if (pin->ops->received)
+	if (pin->ops->received && !adap->devnode.unregistered)
 		return pin->ops->received(adap, msg);
 	return -ENOMSG;
 }
diff --git a/drivers/media/cec/core/cec-priv.h b/drivers/media/cec/core/cec-priv.h
index 9bbd05053d42..b78df931aa74 100644
--- a/drivers/media/cec/core/cec-priv.h
+++ b/drivers/media/cec/core/cec-priv.h
@@ -17,6 +17,16 @@
 			pr_info("cec-%s: " fmt, adap->name, ## arg);	\
 	} while (0)
 
+#define call_op(adap, op, arg...)					\
+	((adap->ops->op && !adap->devnode.unregistered) ?		\
+	 adap->ops->op(adap, ## arg) : 0)
+
+#define call_void_op(adap, op, arg...)					\
+	do {								\
+		if (adap->ops->op && !adap->devnode.unregistered)	\
+			adap->ops->op(adap, ## arg);			\
+	} while (0)
+
 /* devnode to cec_adapter */
 #define to_cec_adapter(node) container_of(node, struct cec_adapter, devnode)
 
diff --git a/drivers/media/dvb-frontends/lgdt3306a.c b/drivers/media/dvb-frontends/lgdt3306a.c
index f6e83a38738d..79174336faec 100644
--- a/drivers/media/dvb-frontends/lgdt3306a.c
+++ b/drivers/media/dvb-frontends/lgdt3306a.c
@@ -2177,6 +2177,11 @@ static int lgdt3306a_probe(struct i2c_client *client,
 	struct dvb_frontend *fe;
 	int ret;
 
+	if (!client->dev.platform_data) {
+		dev_err(&client->dev, "platform data is mandatory\n");
+		return -EINVAL;
+	}
+
 	config = kmemdup(client->dev.platform_data,
 			 sizeof(struct lgdt3306a_config), GFP_KERNEL);
 	if (config == NULL) {
diff --git a/drivers/media/dvb-frontends/mxl5xx.c b/drivers/media/dvb-frontends/mxl5xx.c
index 0b00a23436ed..aaf9a173596a 100644
--- a/drivers/media/dvb-frontends/mxl5xx.c
+++ b/drivers/media/dvb-frontends/mxl5xx.c
@@ -1390,57 +1390,57 @@ static int config_ts(struct mxl *state, enum MXL_HYDRA_DEMOD_ID_E demod_id,
 	u32 nco_count_min = 0;
 	u32 clk_type = 0;
 
-	struct MXL_REG_FIELD_T xpt_sync_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_sync_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 8, 1}, {0x90700010, 9, 1},
 		{0x90700010, 10, 1}, {0x90700010, 11, 1},
 		{0x90700010, 12, 1}, {0x90700010, 13, 1},
 		{0x90700010, 14, 1}, {0x90700010, 15, 1} };
-	struct MXL_REG_FIELD_T xpt_clock_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_clock_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 16, 1}, {0x90700010, 17, 1},
 		{0x90700010, 18, 1}, {0x90700010, 19, 1},
 		{0x90700010, 20, 1}, {0x90700010, 21, 1},
 		{0x90700010, 22, 1}, {0x90700010, 23, 1} };
-	struct MXL_REG_FIELD_T xpt_valid_polarity[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_valid_polarity[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700014, 0, 1}, {0x90700014, 1, 1},
 		{0x90700014, 2, 1}, {0x90700014, 3, 1},
 		{0x90700014, 4, 1}, {0x90700014, 5, 1},
 		{0x90700014, 6, 1}, {0x90700014, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_ts_clock_phase[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_ts_clock_phase[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700018, 0, 3}, {0x90700018, 4, 3},
 		{0x90700018, 8, 3}, {0x90700018, 12, 3},
 		{0x90700018, 16, 3}, {0x90700018, 20, 3},
 		{0x90700018, 24, 3}, {0x90700018, 28, 3} };
-	struct MXL_REG_FIELD_T xpt_lsb_first[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_lsb_first[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 16, 1}, {0x9070000C, 17, 1},
 		{0x9070000C, 18, 1}, {0x9070000C, 19, 1},
 		{0x9070000C, 20, 1}, {0x9070000C, 21, 1},
 		{0x9070000C, 22, 1}, {0x9070000C, 23, 1} };
-	struct MXL_REG_FIELD_T xpt_sync_byte[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_sync_byte[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700010, 0, 1}, {0x90700010, 1, 1},
 		{0x90700010, 2, 1}, {0x90700010, 3, 1},
 		{0x90700010, 4, 1}, {0x90700010, 5, 1},
 		{0x90700010, 6, 1}, {0x90700010, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_enable_output[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_enable_output[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 0, 1}, {0x9070000C, 1, 1},
 		{0x9070000C, 2, 1}, {0x9070000C, 3, 1},
 		{0x9070000C, 4, 1}, {0x9070000C, 5, 1},
 		{0x9070000C, 6, 1}, {0x9070000C, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_err_replace_sync[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_err_replace_sync[MXL_HYDRA_DEMOD_MAX] = {
 		{0x9070000C, 24, 1}, {0x9070000C, 25, 1},
 		{0x9070000C, 26, 1}, {0x9070000C, 27, 1},
 		{0x9070000C, 28, 1}, {0x9070000C, 29, 1},
 		{0x9070000C, 30, 1}, {0x9070000C, 31, 1} };
-	struct MXL_REG_FIELD_T xpt_err_replace_valid[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_err_replace_valid[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700014, 8, 1}, {0x90700014, 9, 1},
 		{0x90700014, 10, 1}, {0x90700014, 11, 1},
 		{0x90700014, 12, 1}, {0x90700014, 13, 1},
 		{0x90700014, 14, 1}, {0x90700014, 15, 1} };
-	struct MXL_REG_FIELD_T xpt_continuous_clock[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_continuous_clock[MXL_HYDRA_DEMOD_MAX] = {
 		{0x907001D4, 0, 1}, {0x907001D4, 1, 1},
 		{0x907001D4, 2, 1}, {0x907001D4, 3, 1},
 		{0x907001D4, 4, 1}, {0x907001D4, 5, 1},
 		{0x907001D4, 6, 1}, {0x907001D4, 7, 1} };
-	struct MXL_REG_FIELD_T xpt_nco_clock_rate[MXL_HYDRA_DEMOD_MAX] = {
+	static const struct MXL_REG_FIELD_T xpt_nco_clock_rate[MXL_HYDRA_DEMOD_MAX] = {
 		{0x90700044, 16, 80}, {0x90700044, 16, 81},
 		{0x90700044, 16, 82}, {0x90700044, 16, 83},
 		{0x90700044, 16, 84}, {0x90700044, 16, 85},
diff --git a/drivers/media/mc/mc-devnode.c b/drivers/media/mc/mc-devnode.c
index f11382afe23b..f249199dc616 100644
--- a/drivers/media/mc/mc-devnode.c
+++ b/drivers/media/mc/mc-devnode.c
@@ -246,15 +246,14 @@ int __must_check media_devnode_register(struct media_device *mdev,
 	kobject_set_name(&devnode->cdev.kobj, "media%d", devnode->minor);
 
 	/* Part 3: Add the media and char device */
+	set_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
 	ret = cdev_device_add(&devnode->cdev, &devnode->dev);
 	if (ret < 0) {
+		clear_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
 		pr_err("%s: cdev_device_add failed\n", __func__);
 		goto cdev_add_error;
 	}
 
-	/* Part 4: Activate this minor. The char device can now be used. */
-	set_bit(MEDIA_FLAG_REGISTERED, &devnode->flags);
-
 	return 0;
 
 cdev_add_error:
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 162ab089124f..dfb2be0b9625 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -102,26 +102,29 @@ static inline u32 cio2_bytesperline(const unsigned int width)
 
 static void cio2_fbpt_exit_dummy(struct cio2_device *cio2)
 {
+	struct device *dev = &cio2->pci_dev->dev;
+
 	if (cio2->dummy_lop) {
-		dma_free_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
-				  cio2->dummy_lop, cio2->dummy_lop_bus_addr);
+		dma_free_coherent(dev, PAGE_SIZE, cio2->dummy_lop,
+				  cio2->dummy_lop_bus_addr);
 		cio2->dummy_lop = NULL;
 	}
 	if (cio2->dummy_page) {
-		dma_free_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
-				  cio2->dummy_page, cio2->dummy_page_bus_addr);
+		dma_free_coherent(dev, PAGE_SIZE, cio2->dummy_page,
+				  cio2->dummy_page_bus_addr);
 		cio2->dummy_page = NULL;
 	}
 }
 
 static int cio2_fbpt_init_dummy(struct cio2_device *cio2)
 {
+	struct device *dev = &cio2->pci_dev->dev;
 	unsigned int i;
 
-	cio2->dummy_page = dma_alloc_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
+	cio2->dummy_page = dma_alloc_coherent(dev, PAGE_SIZE,
 					      &cio2->dummy_page_bus_addr,
 					      GFP_KERNEL);
-	cio2->dummy_lop = dma_alloc_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
+	cio2->dummy_lop = dma_alloc_coherent(dev, PAGE_SIZE,
 					     &cio2->dummy_lop_bus_addr,
 					     GFP_KERNEL);
 	if (!cio2->dummy_page || !cio2->dummy_lop) {
@@ -497,6 +500,7 @@ static int cio2_hw_init(struct cio2_device *cio2, struct cio2_queue *q)
 
 static void cio2_hw_exit(struct cio2_device *cio2, struct cio2_queue *q)
 {
+	struct device *dev = &cio2->pci_dev->dev;
 	void __iomem *const base = cio2->base;
 	unsigned int i;
 	u32 value;
@@ -514,8 +518,7 @@ static void cio2_hw_exit(struct cio2_device *cio2, struct cio2_queue *q)
 				 value, value & CIO2_CDMAC0_DMA_HALTED,
 				 4000, 2000000);
 	if (ret)
-		dev_err(&cio2->pci_dev->dev,
-			"DMA %i can not be halted\n", CIO2_DMA_CHAN);
+		dev_err(dev, "DMA %i can not be halted\n", CIO2_DMA_CHAN);
 
 	for (i = 0; i < CIO2_NUM_PORTS; i++) {
 		writel(readl(base + CIO2_REG_PXM_FRF_CFG(i)) |
@@ -539,8 +542,7 @@ static void cio2_buffer_done(struct cio2_device *cio2, unsigned int dma_chan)
 
 	entry = &q->fbpt[q->bufs_first * CIO2_MAX_LOPS];
 	if (entry->first_entry.ctrl & CIO2_FBPT_CTRL_VALID) {
-		dev_warn(&cio2->pci_dev->dev,
-			 "no ready buffers found on DMA channel %u\n",
+		dev_warn(dev, "no ready buffers found on DMA channel %u\n",
 			 dma_chan);
 		return;
 	}
@@ -557,8 +559,7 @@ static void cio2_buffer_done(struct cio2_device *cio2, unsigned int dma_chan)
 
 			q->bufs[q->bufs_first] = NULL;
 			atomic_dec(&q->bufs_queued);
-			dev_dbg(&cio2->pci_dev->dev,
-				"buffer %i done\n", b->vbb.vb2_buf.index);
+			dev_dbg(dev, "buffer %i done\n", b->vbb.vb2_buf.index);
 
 			b->vbb.vb2_buf.timestamp = ns;
 			b->vbb.field = V4L2_FIELD_NONE;
@@ -624,8 +625,8 @@ static const char *const cio2_port_errs[] = {
 
 static void cio2_irq_handle_once(struct cio2_device *cio2, u32 int_status)
 {
-	void __iomem *const base = cio2->base;
 	struct device *dev = &cio2->pci_dev->dev;
+	void __iomem *const base = cio2->base;
 
 	if (int_status & CIO2_INT_IOOE) {
 		/*
@@ -795,6 +796,7 @@ static int cio2_vb2_queue_setup(struct vb2_queue *vq,
 				struct device *alloc_devs[])
 {
 	struct cio2_device *cio2 = vb2_get_drv_priv(vq);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
 	unsigned int i;
 
@@ -802,7 +804,7 @@ static int cio2_vb2_queue_setup(struct vb2_queue *vq,
 
 	for (i = 0; i < *num_planes; ++i) {
 		sizes[i] = q->format.plane_fmt[i].sizeimage;
-		alloc_devs[i] = &cio2->pci_dev->dev;
+		alloc_devs[i] = dev;
 	}
 
 	*num_buffers = clamp_val(*num_buffers, 1, CIO2_MAX_BUFFERS);
@@ -879,6 +881,7 @@ static int cio2_vb2_buf_init(struct vb2_buffer *vb)
 static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 {
 	struct cio2_device *cio2 = vb2_get_drv_priv(vb->vb2_queue);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct cio2_queue *q =
 		container_of(vb->vb2_queue, struct cio2_queue, vbq);
 	struct cio2_buffer *b =
@@ -889,7 +892,7 @@ static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 	int bufs_queued = atomic_inc_return(&q->bufs_queued);
 	u32 fbpt_rp;
 
-	dev_dbg(&cio2->pci_dev->dev, "queue buffer %d\n", vb->index);
+	dev_dbg(dev, "queue buffer %d\n", vb->index);
 
 	/*
 	 * This code queues the buffer to the CIO2 DMA engine, which starts
@@ -940,12 +943,12 @@ static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 			return;
 		}
 
-		dev_dbg(&cio2->pci_dev->dev, "entry %i was full!\n", next);
+		dev_dbg(dev, "entry %i was full!\n", next);
 		next = (next + 1) % CIO2_MAX_BUFFERS;
 	}
 
 	local_irq_restore(flags);
-	dev_err(&cio2->pci_dev->dev, "error: all cio2 entries were full!\n");
+	dev_err(dev, "error: all cio2 entries were full!\n");
 	atomic_dec(&q->bufs_queued);
 	vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
 }
@@ -954,6 +957,7 @@ static void cio2_vb2_buf_queue(struct vb2_buffer *vb)
 static void cio2_vb2_buf_cleanup(struct vb2_buffer *vb)
 {
 	struct cio2_device *cio2 = vb2_get_drv_priv(vb->vb2_queue);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct cio2_buffer *b =
 		container_of(vb, struct cio2_buffer, vbb.vb2_buf);
 	unsigned int i;
@@ -961,7 +965,7 @@ static void cio2_vb2_buf_cleanup(struct vb2_buffer *vb)
 	/* Free LOP table */
 	for (i = 0; i < CIO2_MAX_LOPS; i++) {
 		if (b->lop[i])
-			dma_free_coherent(&cio2->pci_dev->dev, PAGE_SIZE,
+			dma_free_coherent(dev, PAGE_SIZE,
 					  b->lop[i], b->lop_bus_addr[i]);
 	}
 }
@@ -970,14 +974,15 @@ static int cio2_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 {
 	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
 	struct cio2_device *cio2 = vb2_get_drv_priv(vq);
+	struct device *dev = &cio2->pci_dev->dev;
 	int r;
 
 	cio2->cur_queue = q;
 	atomic_set(&q->frame_sequence, 0);
 
-	r = pm_runtime_resume_and_get(&cio2->pci_dev->dev);
+	r = pm_runtime_resume_and_get(dev);
 	if (r < 0) {
-		dev_info(&cio2->pci_dev->dev, "failed to set power %d\n", r);
+		dev_info(dev, "failed to set power %d\n", r);
 		return r;
 	}
 
@@ -1003,9 +1008,9 @@ static int cio2_vb2_start_streaming(struct vb2_queue *vq, unsigned int count)
 fail_hw:
 	media_pipeline_stop(&q->vdev.entity);
 fail_pipeline:
-	dev_dbg(&cio2->pci_dev->dev, "failed to start streaming (%d)\n", r);
+	dev_dbg(dev, "failed to start streaming (%d)\n", r);
 	cio2_vb2_return_all_buffers(q, VB2_BUF_STATE_QUEUED);
-	pm_runtime_put(&cio2->pci_dev->dev);
+	pm_runtime_put(dev);
 
 	return r;
 }
@@ -1014,16 +1019,16 @@ static void cio2_vb2_stop_streaming(struct vb2_queue *vq)
 {
 	struct cio2_queue *q = vb2q_to_cio2_queue(vq);
 	struct cio2_device *cio2 = vb2_get_drv_priv(vq);
+	struct device *dev = &cio2->pci_dev->dev;
 
 	if (v4l2_subdev_call(q->sensor, video, s_stream, 0))
-		dev_err(&cio2->pci_dev->dev,
-			"failed to stop sensor streaming\n");
+		dev_err(dev, "failed to stop sensor streaming\n");
 
 	cio2_hw_exit(cio2, q);
 	synchronize_irq(cio2->pci_dev->irq);
 	cio2_vb2_return_all_buffers(q, VB2_BUF_STATE_ERROR);
 	media_pipeline_stop(&q->vdev.entity);
-	pm_runtime_put(&cio2->pci_dev->dev);
+	pm_runtime_put(dev);
 	cio2->streaming = false;
 }
 
@@ -1315,12 +1320,12 @@ static int cio2_video_link_validate(struct media_link *link)
 						struct video_device, entity);
 	struct cio2_queue *q = container_of(vd, struct cio2_queue, vdev);
 	struct cio2_device *cio2 = video_get_drvdata(vd);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct v4l2_subdev_format source_fmt;
 	int ret;
 
 	if (!media_entity_remote_pad(link->sink->entity->pads)) {
-		dev_info(&cio2->pci_dev->dev,
-			 "video node %s pad not connected\n", vd->name);
+		dev_info(dev, "video node %s pad not connected\n", vd->name);
 		return -ENOTCONN;
 	}
 
@@ -1330,8 +1335,7 @@ static int cio2_video_link_validate(struct media_link *link)
 
 	if (source_fmt.format.width != q->format.width ||
 	    source_fmt.format.height != q->format.height) {
-		dev_err(&cio2->pci_dev->dev,
-			"Wrong width or height %ux%u (%ux%u expected)\n",
+		dev_err(dev, "Wrong width or height %ux%u (%ux%u expected)\n",
 			q->format.width, q->format.height,
 			source_fmt.format.width, source_fmt.format.height);
 		return -EINVAL;
@@ -1412,6 +1416,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 {
 	struct cio2_device *cio2 = container_of(notifier, struct cio2_device,
 						notifier);
+	struct device *dev = &cio2->pci_dev->dev;
 	struct sensor_async_subdev *s_asd;
 	struct v4l2_async_subdev *asd;
 	struct cio2_queue *q;
@@ -1428,8 +1433,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 				break;
 
 		if (pad == q->sensor->entity.num_pads) {
-			dev_err(&cio2->pci_dev->dev,
-				"failed to find src pad for %s\n",
+			dev_err(dev, "failed to find src pad for %s\n",
 				q->sensor->name);
 			return -ENXIO;
 		}
@@ -1439,8 +1443,7 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 				&q->subdev.entity, CIO2_PAD_SINK,
 				0);
 		if (ret) {
-			dev_err(&cio2->pci_dev->dev,
-				"failed to create link for %s\n",
+			dev_err(dev, "failed to create link for %s\n",
 				q->sensor->name);
 			return ret;
 		}
@@ -1457,6 +1460,7 @@ static const struct v4l2_async_notifier_operations cio2_async_ops = {
 
 static int cio2_parse_firmware(struct cio2_device *cio2)
 {
+	struct device *dev = &cio2->pci_dev->dev;
 	unsigned int i;
 	int ret;
 
@@ -1467,10 +1471,8 @@ static int cio2_parse_firmware(struct cio2_device *cio2)
 		struct sensor_async_subdev *s_asd;
 		struct fwnode_handle *ep;
 
-		ep = fwnode_graph_get_endpoint_by_id(
-			dev_fwnode(&cio2->pci_dev->dev), i, 0,
-			FWNODE_GRAPH_ENDPOINT_NEXT);
-
+		ep = fwnode_graph_get_endpoint_by_id(dev_fwnode(dev), i, 0,
+						FWNODE_GRAPH_ENDPOINT_NEXT);
 		if (!ep)
 			continue;
 
@@ -1504,8 +1506,7 @@ static int cio2_parse_firmware(struct cio2_device *cio2)
 	cio2->notifier.ops = &cio2_async_ops;
 	ret = v4l2_async_notifier_register(&cio2->v4l2_dev, &cio2->notifier);
 	if (ret)
-		dev_err(&cio2->pci_dev->dev,
-			"failed to register async notifier : %d\n", ret);
+		dev_err(dev, "failed to register async notifier : %d\n", ret);
 
 	return ret;
 }
@@ -1524,7 +1525,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	static const u32 default_width = 1936;
 	static const u32 default_height = 1096;
 	const struct ipu3_cio2_fmt dflt_fmt = formats[0];
-
+	struct device *dev = &cio2->pci_dev->dev;
 	struct video_device *vdev = &q->vdev;
 	struct vb2_queue *vbq = &q->vbq;
 	struct v4l2_subdev *subdev = &q->subdev;
@@ -1566,8 +1567,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	subdev->internal_ops = &cio2_subdev_internal_ops;
 	r = media_entity_pads_init(&subdev->entity, CIO2_PADS, q->subdev_pads);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed initialize subdev media entity (%d)\n", r);
+		dev_err(dev, "failed initialize subdev media entity (%d)\n", r);
 		goto fail_subdev_media_entity;
 	}
 
@@ -1575,8 +1575,8 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	vdev->entity.ops = &cio2_video_entity_ops;
 	r = media_entity_pads_init(&vdev->entity, 1, &q->vdev_pad);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed initialize videodev media entity (%d)\n", r);
+		dev_err(dev, "failed initialize videodev media entity (%d)\n",
+			r);
 		goto fail_vdev_media_entity;
 	}
 
@@ -1590,8 +1590,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	v4l2_set_subdevdata(subdev, cio2);
 	r = v4l2_device_register_subdev(&cio2->v4l2_dev, subdev);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed initialize subdev (%d)\n", r);
+		dev_err(dev, "failed initialize subdev (%d)\n", r);
 		goto fail_subdev;
 	}
 
@@ -1607,8 +1606,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	vbq->lock = &q->lock;
 	r = vb2_queue_init(vbq);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed to initialize videobuf2 queue (%d)\n", r);
+		dev_err(dev, "failed to initialize videobuf2 queue (%d)\n", r);
 		goto fail_subdev;
 	}
 
@@ -1625,8 +1623,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 	video_set_drvdata(vdev, cio2);
 	r = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
 	if (r) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed to register video device (%d)\n", r);
+		dev_err(dev, "failed to register video device (%d)\n", r);
 		goto fail_vdev;
 	}
 
@@ -1648,7 +1645,7 @@ static int cio2_queue_init(struct cio2_device *cio2, struct cio2_queue *q)
 fail_vdev_media_entity:
 	media_entity_cleanup(&subdev->entity);
 fail_subdev_media_entity:
-	cio2_fbpt_exit(q, &cio2->pci_dev->dev);
+	cio2_fbpt_exit(q, dev);
 fail_fbpt:
 	mutex_destroy(&q->subdev_lock);
 	mutex_destroy(&q->lock);
@@ -1715,11 +1712,12 @@ static int cio2_check_fwnode_graph(struct fwnode_handle *fwnode)
 static int cio2_pci_probe(struct pci_dev *pci_dev,
 			  const struct pci_device_id *id)
 {
-	struct fwnode_handle *fwnode = dev_fwnode(&pci_dev->dev);
+	struct device *dev = &pci_dev->dev;
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	struct cio2_device *cio2;
 	int r;
 
-	cio2 = devm_kzalloc(&pci_dev->dev, sizeof(*cio2), GFP_KERNEL);
+	cio2 = devm_kzalloc(dev, sizeof(*cio2), GFP_KERNEL);
 	if (!cio2)
 		return -ENOMEM;
 	cio2->pci_dev = pci_dev;
@@ -1732,7 +1730,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 	r = cio2_check_fwnode_graph(fwnode);
 	if (r) {
 		if (fwnode && !IS_ERR_OR_NULL(fwnode->secondary)) {
-			dev_err(&pci_dev->dev, "fwnode graph has no endpoints connected\n");
+			dev_err(dev, "fwnode graph has no endpoints connected\n");
 			return -EINVAL;
 		}
 
@@ -1743,16 +1741,16 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	r = pcim_enable_device(pci_dev);
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to enable device (%d)\n", r);
+		dev_err(dev, "failed to enable device (%d)\n", r);
 		return r;
 	}
 
-	dev_info(&pci_dev->dev, "device 0x%x (rev: 0x%x)\n",
+	dev_info(dev, "device 0x%x (rev: 0x%x)\n",
 		 pci_dev->device, pci_dev->revision);
 
 	r = pcim_iomap_regions(pci_dev, 1 << CIO2_PCI_BAR, pci_name(pci_dev));
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to remap I/O memory (%d)\n", r);
+		dev_err(dev, "failed to remap I/O memory (%d)\n", r);
 		return -ENODEV;
 	}
 
@@ -1764,13 +1762,13 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	r = pci_set_dma_mask(pci_dev, CIO2_DMA_MASK);
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to set DMA mask (%d)\n", r);
+		dev_err(dev, "failed to set DMA mask (%d)\n", r);
 		return -ENODEV;
 	}
 
 	r = pci_enable_msi(pci_dev);
 	if (r) {
-		dev_err(&pci_dev->dev, "failed to enable MSI (%d)\n", r);
+		dev_err(dev, "failed to enable MSI (%d)\n", r);
 		return r;
 	}
 
@@ -1780,7 +1778,7 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	mutex_init(&cio2->lock);
 
-	cio2->media_dev.dev = &cio2->pci_dev->dev;
+	cio2->media_dev.dev = dev;
 	strscpy(cio2->media_dev.model, CIO2_DEVICE_NAME,
 		sizeof(cio2->media_dev.model));
 	snprintf(cio2->media_dev.bus_info, sizeof(cio2->media_dev.bus_info),
@@ -1793,10 +1791,9 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 		goto fail_mutex_destroy;
 
 	cio2->v4l2_dev.mdev = &cio2->media_dev;
-	r = v4l2_device_register(&pci_dev->dev, &cio2->v4l2_dev);
+	r = v4l2_device_register(dev, &cio2->v4l2_dev);
 	if (r) {
-		dev_err(&pci_dev->dev,
-			"failed to register V4L2 device (%d)\n", r);
+		dev_err(dev, "failed to register V4L2 device (%d)\n", r);
 		goto fail_media_device_unregister;
 	}
 
@@ -1806,20 +1803,20 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	v4l2_async_notifier_init(&cio2->notifier);
 
+	r = devm_request_irq(dev, pci_dev->irq, cio2_irq, IRQF_SHARED,
+			     CIO2_NAME, cio2);
+	if (r) {
+		dev_err(dev, "failed to request IRQ (%d)\n", r);
+		goto fail_clean_notifier;
+	}
+
 	/* Register notifier for subdevices we care */
 	r = cio2_parse_firmware(cio2);
 	if (r)
 		goto fail_clean_notifier;
 
-	r = devm_request_irq(&pci_dev->dev, pci_dev->irq, cio2_irq,
-			     IRQF_SHARED, CIO2_NAME, cio2);
-	if (r) {
-		dev_err(&pci_dev->dev, "failed to request IRQ (%d)\n", r);
-		goto fail_clean_notifier;
-	}
-
-	pm_runtime_put_noidle(&pci_dev->dev);
-	pm_runtime_allow(&pci_dev->dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_allow(dev);
 
 	return 0;
 
@@ -2008,10 +2005,9 @@ static int __maybe_unused cio2_resume(struct device *dev)
 	if (!cio2->streaming)
 		return 0;
 	/* Start stream */
-	r = pm_runtime_force_resume(&cio2->pci_dev->dev);
+	r = pm_runtime_force_resume(dev);
 	if (r < 0) {
-		dev_err(&cio2->pci_dev->dev,
-			"failed to set power %d\n", r);
+		dev_err(dev, "failed to set power %d\n", r);
 		return r;
 	}
 
diff --git a/drivers/media/pci/ngene/ngene-core.c b/drivers/media/pci/ngene/ngene-core.c
index 7481f553f959..24ec576dc3bf 100644
--- a/drivers/media/pci/ngene/ngene-core.c
+++ b/drivers/media/pci/ngene/ngene-core.c
@@ -1488,7 +1488,9 @@ static int init_channel(struct ngene_channel *chan)
 	}
 
 	if (dev->ci.en && (io & NGENE_IO_TSOUT)) {
-		dvb_ca_en50221_init(adapter, dev->ci.en, 0, 1);
+		ret = dvb_ca_en50221_init(adapter, dev->ci.en, 0, 1);
+		if (ret != 0)
+			goto err;
 		set_transfer(chan, 1);
 		chan->dev->channel[2].DataFormatFlags = DF_SWAP32;
 		set_transfer(&chan->dev->channel[2], 1);
diff --git a/drivers/media/radio/radio-shark2.c b/drivers/media/radio/radio-shark2.c
index f1c5c0a6a335..e3e6aa87fe08 100644
--- a/drivers/media/radio/radio-shark2.c
+++ b/drivers/media/radio/radio-shark2.c
@@ -62,7 +62,7 @@ struct shark_device {
 #ifdef SHARK_USE_LEDS
 	struct work_struct led_work;
 	struct led_classdev leds[NO_LEDS];
-	char led_names[NO_LEDS][32];
+	char led_names[NO_LEDS][64];
 	atomic_t brightness[NO_LEDS];
 	unsigned long brightness_new;
 #endif
diff --git a/drivers/media/usb/b2c2/flexcop-usb.c b/drivers/media/usb/b2c2/flexcop-usb.c
index 8ab1be03e731..0354614351cb 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -501,17 +501,21 @@ static int flexcop_usb_transfer_init(struct flexcop_usb *fc_usb)
 
 static int flexcop_usb_init(struct flexcop_usb *fc_usb)
 {
-	/* use the alternate setting with the larges buffer */
-	int ret = usb_set_interface(fc_usb->udev, 0, 1);
+	struct usb_host_interface *alt;
+	int ret;
 
+	/* use the alternate setting with the largest buffer */
+	ret = usb_set_interface(fc_usb->udev, 0, 1);
 	if (ret) {
 		err("set interface failed.");
 		return ret;
 	}
 
-	if (fc_usb->uintf->cur_altsetting->desc.bNumEndpoints < 1)
+	alt = fc_usb->uintf->cur_altsetting;
+
+	if (alt->desc.bNumEndpoints < 2)
 		return -ENODEV;
-	if (!usb_endpoint_is_isoc_in(&fc_usb->uintf->cur_altsetting->endpoint[0].desc))
+	if (!usb_endpoint_is_isoc_in(&alt->endpoint[0].desc))
 		return -ENODEV;
 
 	switch (fc_usb->udev->speed) {
diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 4cf540d1b250..2a5a90311e0c 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -99,7 +99,7 @@ void stk1160_buffer_done(struct stk1160 *dev)
 static inline
 void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 {
-	int linesdone, lineoff, lencopy;
+	int linesdone, lineoff, lencopy, offset;
 	int bytesperline = dev->width * 2;
 	struct stk1160_buffer *buf = dev->isoc_ctl.buf;
 	u8 *dst = buf->mem;
@@ -139,8 +139,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 	 * Check if we have enough space left in the buffer.
 	 * In that case, we force loop exit after copy.
 	 */
-	if (lencopy > buf->bytesused - buf->length) {
-		lencopy = buf->bytesused - buf->length;
+	offset = dst - (u8 *)buf->mem;
+	if (offset > buf->length) {
+		dev_warn_ratelimited(dev->dev, "out of bounds offset\n");
+		return;
+	}
+	if (lencopy > buf->length - offset) {
+		lencopy = buf->length - offset;
 		remain = lencopy;
 	}
 
@@ -182,8 +187,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 		 * Check if we have enough space left in the buffer.
 		 * In that case, we force loop exit after copy.
 		 */
-		if (lencopy > buf->bytesused - buf->length) {
-			lencopy = buf->bytesused - buf->length;
+		offset = dst - (u8 *)buf->mem;
+		if (offset > buf->length) {
+			dev_warn_ratelimited(dev->dev, "offset out of bounds\n");
+			return;
+		}
+		if (lencopy > buf->length - offset) {
+			lencopy = buf->length - offset;
 			remain = lencopy;
 		}
 
diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index d03ace324db0..e93b1d5c3a82 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -1033,8 +1033,10 @@ int __video_register_device(struct video_device *vdev,
 	vdev->dev.devt = MKDEV(VIDEO_MAJOR, vdev->minor);
 	vdev->dev.parent = vdev->dev_parent;
 	dev_set_name(&vdev->dev, "%s%d", name_base, vdev->num);
+	mutex_lock(&videodev_lock);
 	ret = device_register(&vdev->dev);
 	if (ret < 0) {
+		mutex_unlock(&videodev_lock);
 		pr_err("%s: device_register failed\n", __func__);
 		goto cleanup;
 	}
@@ -1054,6 +1056,7 @@ int __video_register_device(struct video_device *vdev,
 
 	/* Part 6: Activate this minor. The char device can now be used. */
 	set_bit(V4L2_FL_REGISTERED, &vdev->flags);
+	mutex_unlock(&videodev_lock);
 
 	return 0;
 
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 8303b484449e..820a780e41b0 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -119,13 +119,12 @@ void mmc_retune_enable(struct mmc_host *host)
 
 /*
  * Pause re-tuning for a small set of operations.  The pause begins after the
- * next command and after first doing re-tuning.
+ * next command.
  */
 void mmc_retune_pause(struct mmc_host *host)
 {
 	if (!host->retune_paused) {
 		host->retune_paused = 1;
-		mmc_retune_needed(host);
 		mmc_retune_hold(host);
 	}
 }
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 681653d097ef..04c510b751b2 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -202,6 +202,26 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd);
 
+/**
+ * mmc_gpiod_set_cd_config - set config for card-detection GPIO
+ * @host: mmc host
+ * @config: Generic pinconf config (from pinconf_to_config_packed())
+ *
+ * This can be used by mmc host drivers to fixup a card-detection GPIO's config
+ * (e.g. set PIN_CONFIG_BIAS_PULL_UP) after acquiring the GPIO descriptor
+ * through mmc_gpiod_request_cd().
+ *
+ * Returns:
+ * 0 on success, or a negative errno value on error.
+ */
+int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config)
+{
+	struct mmc_gpio *ctx = host->slot.handler_priv;
+
+	return gpiod_set_config(ctx->cd_gpio, config);
+}
+EXPORT_SYMBOL(mmc_gpiod_set_cd_config);
+
 bool mmc_can_gpio_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index f4e15eef7045..bb8ea7bc1917 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -82,6 +82,7 @@ struct sdhci_acpi_host {
 enum {
 	DMI_QUIRK_RESET_SD_SIGNAL_VOLT_ON_SUSP			= BIT(0),
 	DMI_QUIRK_SD_NO_WRITE_PROTECT				= BIT(1),
+	DMI_QUIRK_SD_CD_ACTIVE_HIGH				= BIT(2),
 };
 
 static inline void *sdhci_acpi_priv(struct sdhci_acpi_host *c)
@@ -795,7 +796,20 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
 
+/* Please keep this list sorted alphabetically */
 static const struct dmi_system_id sdhci_acpi_quirks[] = {
+	{
+		/*
+		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
+		 * reports the card being write-protected even though microSD
+		 * cards do not have a write-protect switch at all.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{
 		/*
 		 * The Lenovo Miix 320-10ICR has a bug in the _PS0 method of
@@ -812,15 +826,23 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 	},
 	{
 		/*
-		 * The Acer Aspire Switch 10 (SW5-012) microSD slot always
-		 * reports the card being write-protected even though microSD
-		 * cards do not have a write-protect switch at all.
+		 * Lenovo Yoga Tablet 2 Pro 1380F/L (13" Android version) this
+		 * has broken WP reporting and an inverted CD signal.
+		 * Note this has more or less the same BIOS as the Lenovo Yoga
+		 * Tablet 2 830F/L or 1050F/L (8" and 10" Android), but unlike
+		 * the 830 / 1050 models which share the same mainboard this
+		 * model has a different mainboard and the inverted CD and
+		 * broken WP are unique to this board.
 		 */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire SW5-012"),
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VALLEYVIEW C0 PLATFORM"),
+			DMI_MATCH(DMI_BOARD_NAME, "BYT-T FFD8"),
+			/* Full match so as to NOT match the 830/1050 BIOS */
+			DMI_MATCH(DMI_BIOS_VERSION, "BLADE_21.X64.0005.R00.1504101516"),
 		},
-		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+		.driver_data = (void *)(DMI_QUIRK_SD_NO_WRITE_PROTECT |
+					DMI_QUIRK_SD_CD_ACTIVE_HIGH),
 	},
 	{
 		/*
@@ -833,6 +855,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
 		},
 		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
 	},
+	{
+		/*
+		 * The Toshiba WT10-A's microSD slot always reports the card being
+		 * write-protected.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA WT10-A"),
+		},
+		.driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
+	},
 	{} /* Terminating entry */
 };
 
@@ -947,6 +980,9 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	if (sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD)) {
 		bool v = sdhci_acpi_flag(c, SDHCI_ACPI_SD_CD_OVERRIDE_LEVEL);
 
+		if (quirks & DMI_QUIRK_SD_CD_ACTIVE_HIGH)
+			host->mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+
 		err = mmc_gpiod_request_cd(host->mmc, NULL, 0, v, 0);
 		if (err) {
 			if (err == -EPROBE_DEFER)
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 210701e4fc13..230b61902e39 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -140,19 +140,26 @@ static const struct timing_data td[] = {
 
 struct sdhci_am654_data {
 	struct regmap *base;
-	bool legacy_otapdly;
 	int otap_del_sel[ARRAY_SIZE(td)];
 	int itap_del_sel[ARRAY_SIZE(td)];
+	u32 itap_del_ena[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
 	int strb_sel;
 	u32 flags;
 	u32 quirks;
+	bool dll_enable;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
 };
 
+struct window {
+	u8 start;
+	u8 end;
+	u8 length;
+};
+
 struct sdhci_am654_driver_data {
 	const struct sdhci_pltfm_data *pdata;
 	u32 flags;
@@ -232,11 +239,13 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 }
 
 static void sdhci_am654_write_itapdly(struct sdhci_am654_data *sdhci_am654,
-				      u32 itapdly)
+				      u32 itapdly, u32 enable)
 {
 	/* Set ITAPCHGWIN before writing to ITAPDLY */
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
 			   1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
+			   enable << ITAPDLYENA_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYSEL_MASK,
 			   itapdly << ITAPDLYSEL_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
@@ -253,8 +262,8 @@ static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
 	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
 
-	sdhci_am654_write_itapdly(sdhci_am654,
-				  sdhci_am654->itap_del_sel[timing]);
+	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+				  sdhci_am654->itap_del_ena[timing]);
 }
 
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -263,7 +272,6 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
-	u32 otap_del_ena;
 	u32 mask, val;
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
@@ -271,15 +279,10 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	sdhci_set_clock(host, clock);
 
 	/* Setup DLL Output TAP delay */
-	if (sdhci_am654->legacy_otapdly)
-		otap_del_sel = sdhci_am654->otap_del_sel[0];
-	else
-		otap_del_sel = sdhci_am654->otap_del_sel[timing];
-
-	otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
+	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (otap_del_ena << OTAPDLYENA_SHIFT) |
+	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
 	/* Write to STRBSEL for HS400 speed mode */
@@ -294,10 +297,21 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ)
+	if (timing > MMC_TIMING_UHS_SDR25 && clock >= CLOCK_TOO_SLOW_HZ) {
 		sdhci_am654_setup_dll(host, clock);
-	else
+		sdhci_am654->dll_enable = true;
+
+		if (timing == MMC_TIMING_MMC_HS400) {
+			sdhci_am654->itap_del_ena[timing] = 0x1;
+			sdhci_am654->itap_del_sel[timing] = sdhci_am654->itap_del_sel[timing - 1];
+		}
+
+		sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+					  sdhci_am654->itap_del_ena[timing]);
+	} else {
 		sdhci_am654_setup_delay_chain(sdhci_am654, timing);
+		sdhci_am654->dll_enable = false;
+	}
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
@@ -310,19 +324,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
+	u32 itap_del_ena;
+	u32 itap_del_sel;
 	u32 mask, val;
 
 	/* Setup DLL Output TAP delay */
-	if (sdhci_am654->legacy_otapdly)
-		otap_del_sel = sdhci_am654->otap_del_sel[0];
-	else
-		otap_del_sel = sdhci_am654->otap_del_sel[timing];
+	otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
+	/* Setup Input TAP delay */
+	itap_del_ena = sdhci_am654->itap_del_ena[timing];
+	itap_del_sel = sdhci_am654->itap_del_sel[timing];
+
+	mask |= ITAPDLYENA_MASK | ITAPDLYSEL_MASK;
+	val |= (itap_del_ena << ITAPDLYENA_SHIFT) |
+	       (itap_del_sel << ITAPDLYSEL_SHIFT);
+
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK,
+			   1 << ITAPCHGWIN_SHIFT);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPCHGWIN_MASK, 0);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, CLKBUFSEL_MASK,
 			   sdhci_am654->clkbuf_sel);
 
@@ -415,40 +439,105 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
 	return 0;
 }
 
-#define ITAP_MAX	32
+#define ITAPDLY_LENGTH 32
+#define ITAPDLY_LAST_INDEX (ITAPDLY_LENGTH - 1)
+
+static u32 sdhci_am654_calculate_itap(struct sdhci_host *host, struct window
+			  *fail_window, u8 num_fails, bool circular_buffer)
+{
+	u8 itap = 0, start_fail = 0, end_fail = 0, pass_length = 0;
+	u8 first_fail_start = 0, last_fail_end = 0;
+	struct device *dev = mmc_dev(host->mmc);
+	struct window pass_window = {0, 0, 0};
+	int prev_fail_end = -1;
+	u8 i;
+
+	if (!num_fails)
+		return ITAPDLY_LAST_INDEX >> 1;
+
+	if (fail_window->length == ITAPDLY_LENGTH) {
+		dev_err(dev, "No passing ITAPDLY, return 0\n");
+		return 0;
+	}
+
+	first_fail_start = fail_window->start;
+	last_fail_end = fail_window[num_fails - 1].end;
+
+	for (i = 0; i < num_fails; i++) {
+		start_fail = fail_window[i].start;
+		end_fail = fail_window[i].end;
+		pass_length = start_fail - (prev_fail_end + 1);
+
+		if (pass_length > pass_window.length) {
+			pass_window.start = prev_fail_end + 1;
+			pass_window.length = pass_length;
+		}
+		prev_fail_end = end_fail;
+	}
+
+	if (!circular_buffer)
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end;
+	else
+		pass_length = ITAPDLY_LAST_INDEX - last_fail_end + first_fail_start;
+
+	if (pass_length > pass_window.length) {
+		pass_window.start = last_fail_end + 1;
+		pass_window.length = pass_length;
+	}
+
+	if (!circular_buffer)
+		itap = pass_window.start + (pass_window.length >> 1);
+	else
+		itap = (pass_window.start + (pass_window.length >> 1)) % ITAPDLY_LENGTH;
+
+	return (itap > ITAPDLY_LAST_INDEX) ? ITAPDLY_LAST_INDEX >> 1 : itap;
+}
+
 static int sdhci_am654_platform_execute_tuning(struct sdhci_host *host,
 					       u32 opcode)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	int cur_val, prev_val = 1, fail_len = 0, pass_window = 0, pass_len;
-	u32 itap;
+	unsigned char timing = host->mmc->ios.timing;
+	struct window fail_window[ITAPDLY_LENGTH];
+	u8 curr_pass, itap;
+	u8 fail_index = 0;
+	u8 prev_pass = 1;
+
+	memset(fail_window, 0, sizeof(fail_window));
 
 	/* Enable ITAPDLY */
-	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, ITAPDLYENA_MASK,
-			   1 << ITAPDLYENA_SHIFT);
+	sdhci_am654->itap_del_ena[timing] = 0x1;
+
+	for (itap = 0; itap < ITAPDLY_LENGTH; itap++) {
+		sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
 
-	for (itap = 0; itap < ITAP_MAX; itap++) {
-		sdhci_am654_write_itapdly(sdhci_am654, itap);
+		curr_pass = !mmc_send_tuning(host->mmc, opcode, NULL);
 
-		cur_val = !mmc_send_tuning(host->mmc, opcode, NULL);
-		if (cur_val && !prev_val)
-			pass_window = itap;
+		if (!curr_pass && prev_pass)
+			fail_window[fail_index].start = itap;
+
+		if (!curr_pass) {
+			fail_window[fail_index].end = itap;
+			fail_window[fail_index].length++;
+		}
 
-		if (!cur_val)
-			fail_len++;
+		if (curr_pass && !prev_pass)
+			fail_index++;
 
-		prev_val = cur_val;
+		prev_pass = curr_pass;
 	}
-	/*
-	 * Having determined the length of the failing window and start of
-	 * the passing window calculate the length of the passing window and
-	 * set the final value halfway through it considering the range as a
-	 * circular buffer
-	 */
-	pass_len = ITAP_MAX - fail_len;
-	itap = (pass_window + (pass_len >> 1)) % ITAP_MAX;
-	sdhci_am654_write_itapdly(sdhci_am654, itap);
+
+	if (fail_window[fail_index].length != 0)
+		fail_index++;
+
+	itap = sdhci_am654_calculate_itap(host, fail_window, fail_index,
+					  sdhci_am654->dll_enable);
+
+	sdhci_am654_write_itapdly(sdhci_am654, itap, sdhci_am654->itap_del_ena[timing]);
+
+	/* Save ITAPDLY */
+	sdhci_am654->itap_del_sel[timing] = itap;
 
 	return 0;
 }
@@ -579,32 +668,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 	int i;
 	int ret;
 
-	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].otap_binding,
-				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
-	if (ret) {
-		/*
-		 * ti,otap-del-sel-legacy is mandatory, look for old binding
-		 * if not found.
-		 */
-		ret = device_property_read_u32(dev, "ti,otap-del-sel",
-					       &sdhci_am654->otap_del_sel[0]);
-		if (ret) {
-			dev_err(dev, "Couldn't find otap-del-sel\n");
-
-			return ret;
-		}
-
-		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
-		sdhci_am654->legacy_otapdly = true;
-
-		return 0;
-	}
-
 	for (i = MMC_TIMING_LEGACY; i <= MMC_TIMING_MMC_HS400; i++) {
 
 		ret = device_property_read_u32(dev, td[i].otap_binding,
 					       &sdhci_am654->otap_del_sel[i]);
 		if (ret) {
+			if (i == MMC_TIMING_LEGACY) {
+				dev_err(dev, "Couldn't find mandatory ti,otap-del-sel-legacy\n");
+				return ret;
+			}
 			dev_dbg(dev, "Couldn't find %s\n",
 				td[i].otap_binding);
 			/*
@@ -617,9 +689,12 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
 				host->mmc->caps2 &= ~td[i].capability;
 		}
 
-		if (td[i].itap_binding)
-			device_property_read_u32(dev, td[i].itap_binding,
-						 &sdhci_am654->itap_del_sel[i]);
+		if (td[i].itap_binding) {
+			ret = device_property_read_u32(dev, td[i].itap_binding,
+						       &sdhci_am654->itap_del_sel[i]);
+			if (!ret)
+				sdhci_am654->itap_del_ena[i] = 0x1;
+		}
 	}
 
 	return 0;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 2a228ee32641..16077e5a2df1 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -886,8 +886,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
 	if (mtd->_get_user_prot_info && mtd->_read_user_prot_reg) {
 		size = mtd_otp_size(mtd, true);
-		if (size < 0)
-			return size;
+		if (size < 0) {
+			err = size;
+			goto err;
+		}
 
 		if (size > 0) {
 			nvmem = mtd_otp_nvmem_register(mtd, "user-otp", size,
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index a9f50c9af109..856b3d6eceb7 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -402,7 +402,7 @@ static int hynix_nand_rr_init(struct nand_chip *chip)
 	if (ret)
 		pr_warn("failed to initialize read-retry infrastructure");
 
-	return 0;
+	return ret;
 }
 
 static void hynix_nand_extract_oobsize(struct nand_chip *chip,
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 50e60852f128..e5ed9dff10a2 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -46,7 +46,9 @@ obj-$(CONFIG_ARCNET) += arcnet/
 obj-$(CONFIG_DEV_APPLETALK) += appletalk/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
-obj-$(CONFIG_NET_DSA) += dsa/
+ifdef CONFIG_NET_DSA
+obj-y += dsa/
+endif
 obj-$(CONFIG_ETHERNET) += ethernet/
 obj-$(CONFIG_FDDI) += fddi/
 obj-$(CONFIG_HIPPI) += hippi/
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 3fc120802883..5ddd97f79e8e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2585,6 +2585,7 @@ static int mv88e6xxx_software_reset(struct mv88e6xxx_chip *chip)
 static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 {
 	struct gpio_desc *gpiod = chip->reset;
+	int err;
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
@@ -2593,17 +2594,26 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 		 * mid-byte, causing the first EEPROM read after the reset
 		 * from the wrong location resulting in the switch booting
 		 * to wrong mode and inoperable.
+		 * For this reason, switch families with EEPROM support
+		 * generally wait for EEPROM loads to complete as their pre-
+		 * and post-reset handlers.
 		 */
-		if (chip->info->ops->get_eeprom)
-			mv88e6xxx_g2_eeprom_wait(chip);
+		if (chip->info->ops->hardware_reset_pre) {
+			err = chip->info->ops->hardware_reset_pre(chip);
+			if (err)
+				dev_err(chip->dev, "pre-reset error: %d\n", err);
+		}
 
 		gpiod_set_value_cansleep(gpiod, 1);
 		usleep_range(10000, 20000);
 		gpiod_set_value_cansleep(gpiod, 0);
 		usleep_range(10000, 20000);
 
-		if (chip->info->ops->get_eeprom)
-			mv88e6xxx_g2_eeprom_wait(chip);
+		if (chip->info->ops->hardware_reset_post) {
+			err = chip->info->ops->hardware_reset_post(chip);
+			if (err)
+				dev_err(chip->dev, "post-reset error: %d\n", err);
+		}
 	}
 }
 
@@ -3824,6 +3834,8 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4006,6 +4018,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4103,6 +4117,8 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4201,6 +4217,8 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4262,6 +4280,8 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4321,6 +4341,8 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4383,6 +4405,8 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4438,6 +4462,8 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.watchdog_ops = &mv88e6250_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6250_g1_wait_eeprom_done_prereset,
+	.hardware_reset_post = mv88e6xxx_g1_wait_eeprom_done,
 	.reset = mv88e6250_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -4482,6 +4508,8 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4543,6 +4571,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -4586,6 +4616,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -4634,6 +4666,8 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4784,6 +4818,8 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4848,6 +4884,8 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4913,6 +4951,8 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4981,6 +5021,8 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.watchdog_ops = &mv88e6393x_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6393x_port_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 6b7307edaf17..6b86e7645be6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -434,6 +434,12 @@ struct mv88e6xxx_ops {
 	int (*ppu_enable)(struct mv88e6xxx_chip *chip);
 	int (*ppu_disable)(struct mv88e6xxx_chip *chip);
 
+	/* Additional handlers to run before and after hard reset, to make sure
+	 * that the switch and EEPROM are in a good state.
+	 */
+	int (*hardware_reset_pre)(struct mv88e6xxx_chip *chip);
+	int (*hardware_reset_post)(struct mv88e6xxx_chip *chip);
+
 	/* Switch Software Reset */
 	int (*reset)(struct mv88e6xxx_chip *chip);
 
diff --git a/drivers/net/dsa/mv88e6xxx/global1.c b/drivers/net/dsa/mv88e6xxx/global1.c
index 964928285782..83c6d1fab94a 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -75,6 +75,95 @@ static int mv88e6xxx_g1_wait_init_ready(struct mv88e6xxx_chip *chip)
 	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
 }
 
+static int mv88e6250_g1_eeprom_reload(struct mv88e6xxx_chip *chip)
+{
+	/* MV88E6185_G1_CTL1_RELOAD_EEPROM is also valid for 88E6250 */
+	int bit = __bf_shf(MV88E6185_G1_CTL1_RELOAD_EEPROM);
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_CTL1, &val);
+	if (err)
+		return err;
+
+	val |= MV88E6185_G1_CTL1_RELOAD_EEPROM;
+
+	err = mv88e6xxx_g1_write(chip, MV88E6XXX_G1_CTL1, val);
+	if (err)
+		return err;
+
+	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_CTL1, bit, 0);
+}
+
+/* Returns 0 when done, -EBUSY when waiting, other negative codes on error */
+static int mv88e6xxx_g1_is_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	u16 val;
+	int err;
+
+	err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_STS, &val);
+	if (err < 0) {
+		dev_err(chip->dev, "Error reading status");
+		return err;
+	}
+
+	/* If the switch is still resetting, it may not
+	 * respond on the bus, and so MDIO read returns
+	 * 0xffff. Differentiate between that, and waiting for
+	 * the EEPROM to be done by bit 0 being set.
+	 */
+	if (val == 0xffff || !(val & BIT(MV88E6XXX_G1_STS_IRQ_EEPROM_DONE)))
+		return -EBUSY;
+
+	return 0;
+}
+
+/* As the EEInt (EEPROM done) flag clears on read if the status register, this
+ * function must be called directly after a hard reset or EEPROM ReLoad request,
+ * or the done condition may have been missed
+ */
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip)
+{
+	const unsigned long timeout = jiffies + 1 * HZ;
+	int ret;
+
+	/* Wait up to 1 second for the switch to finish reading the
+	 * EEPROM.
+	 */
+	while (time_before(jiffies, timeout)) {
+		ret = mv88e6xxx_g1_is_eeprom_done(chip);
+		if (ret != -EBUSY)
+			return ret;
+	}
+
+	dev_err(chip->dev, "Timeout waiting for EEPROM done");
+	return -ETIMEDOUT;
+}
+
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip)
+{
+	int ret;
+
+	ret = mv88e6xxx_g1_is_eeprom_done(chip);
+	if (ret != -EBUSY)
+		return ret;
+
+	/* Pre-reset, we don't know the state of the switch - when
+	 * mv88e6xxx_g1_is_eeprom_done() returns -EBUSY, that may be because
+	 * the switch is actually busy reading the EEPROM, or because
+	 * MV88E6XXX_G1_STS_IRQ_EEPROM_DONE has been cleared by an unrelated
+	 * status register read already.
+	 *
+	 * To account for the latter case, trigger another EEPROM reload for
+	 * another chance at seeing the done flag.
+	 */
+	ret = mv88e6250_g1_eeprom_reload(chip);
+	if (ret)
+		return ret;
+
+	return mv88e6xxx_g1_wait_eeprom_done(chip);
+}
+
 /* Offset 0x01: Switch MAC Address Register Bytes 0 & 1
  * Offset 0x02: Switch MAC Address Register Bytes 2 & 3
  * Offset 0x03: Switch MAC Address Register Bytes 4 & 5
diff --git a/drivers/net/dsa/mv88e6xxx/global1.h b/drivers/net/dsa/mv88e6xxx/global1.h
index 6f41762eff3e..92fcebade809 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -280,6 +280,8 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 493192a8000c..888f10d93b9a 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -853,11 +853,11 @@ static int sja1105_init_general_params(struct sja1105_private *priv)
 		.hostprio = 7,
 		.mac_fltres1 = SJA1105_LINKLOCAL_FILTER_A,
 		.mac_flt1    = SJA1105_LINKLOCAL_FILTER_A_MASK,
-		.incl_srcpt1 = false,
+		.incl_srcpt1 = true,
 		.send_meta1  = false,
 		.mac_fltres0 = SJA1105_LINKLOCAL_FILTER_B,
 		.mac_flt0    = SJA1105_LINKLOCAL_FILTER_B_MASK,
-		.incl_srcpt0 = false,
+		.incl_srcpt0 = true,
 		.send_meta0  = false,
 		/* Default to an invalid value */
 		.mirr_port = priv->ds->num_ports,
@@ -2346,11 +2346,6 @@ int sja1105_vlan_filtering(struct dsa_switch *ds, int port, bool enabled,
 	general_params->tpid = tpid;
 	/* EtherType used to identify outer tagged (S-tag) VLAN traffic */
 	general_params->tpid2 = tpid2;
-	/* When VLAN filtering is on, we need to at least be able to
-	 * decode management traffic through the "backup plan".
-	 */
-	general_params->incl_srcpt1 = enabled;
-	general_params->incl_srcpt0 = enabled;
 
 	/* VLAN filtering => independent VLAN learning.
 	 * No VLAN filtering (or best effort) => shared VLAN learning.
diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index f5ec35fa4c63..6de0d590be34 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -48,6 +48,11 @@ enum ena_admin_aq_feature_id {
 	ENA_ADMIN_FEATURES_OPCODE_NUM               = 32,
 };
 
+/* device capabilities */
+enum ena_admin_aq_caps_id {
+	ENA_ADMIN_ENI_STATS                         = 0,
+};
+
 enum ena_admin_placement_policy_type {
 	/* descriptors and headers are in host memory */
 	ENA_ADMIN_PLACEMENT_POLICY_HOST             = 1,
@@ -455,7 +460,10 @@ struct ena_admin_device_attr_feature_desc {
 	 */
 	u32 supported_features;
 
-	u32 reserved3;
+	/* bitmap of ena_admin_aq_caps_id, which represents device
+	 * capabilities.
+	 */
+	u32 capabilities;
 
 	/* Indicates how many bits are used physical address access. */
 	u32 phys_addr_width;
@@ -861,7 +869,9 @@ struct ena_admin_host_info {
 	 * 2 : interrupt_moderation
 	 * 3 : rx_buf_mirroring
 	 * 4 : rss_configurable_function_key
-	 * 31:5 : reserved
+	 * 5 : reserved
+	 * 6 : rx_page_reuse
+	 * 31:7 : reserved
 	 */
 	u32 driver_supported_features;
 };
@@ -1176,6 +1186,8 @@ struct ena_admin_ena_mmio_req_read_less_resp {
 #define ENA_ADMIN_HOST_INFO_RX_BUF_MIRRORING_MASK           BIT(3)
 #define ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_SHIFT 4
 #define ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK BIT(4)
+#define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_SHIFT             6
+#define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK              BIT(6)
 
 /* aenq_common_desc */
 #define ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK               BIT(0)
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index e37c82eb6232..276f6a8631fb 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -90,8 +90,7 @@ static int ena_com_admin_init_sq(struct ena_com_admin_queue *admin_queue)
 	struct ena_com_admin_sq *sq = &admin_queue->sq;
 	u16 size = ADMIN_SQ_SIZE(admin_queue->q_depth);
 
-	sq->entries = dma_alloc_coherent(admin_queue->q_dmadev, size,
-					 &sq->dma_addr, GFP_KERNEL);
+	sq->entries = dma_alloc_coherent(admin_queue->q_dmadev, size, &sq->dma_addr, GFP_KERNEL);
 
 	if (!sq->entries) {
 		netdev_err(ena_dev->net_device, "Memory allocation failed\n");
@@ -113,8 +112,7 @@ static int ena_com_admin_init_cq(struct ena_com_admin_queue *admin_queue)
 	struct ena_com_admin_cq *cq = &admin_queue->cq;
 	u16 size = ADMIN_CQ_SIZE(admin_queue->q_depth);
 
-	cq->entries = dma_alloc_coherent(admin_queue->q_dmadev, size,
-					 &cq->dma_addr, GFP_KERNEL);
+	cq->entries = dma_alloc_coherent(admin_queue->q_dmadev, size, &cq->dma_addr, GFP_KERNEL);
 
 	if (!cq->entries) {
 		netdev_err(ena_dev->net_device, "Memory allocation failed\n");
@@ -136,8 +134,7 @@ static int ena_com_admin_init_aenq(struct ena_com_dev *ena_dev,
 
 	ena_dev->aenq.q_depth = ENA_ASYNC_QUEUE_DEPTH;
 	size = ADMIN_AENQ_SIZE(ENA_ASYNC_QUEUE_DEPTH);
-	aenq->entries = dma_alloc_coherent(ena_dev->dmadev, size,
-					   &aenq->dma_addr, GFP_KERNEL);
+	aenq->entries = dma_alloc_coherent(ena_dev->dmadev, size, &aenq->dma_addr, GFP_KERNEL);
 
 	if (!aenq->entries) {
 		netdev_err(ena_dev->net_device, "Memory allocation failed\n");
@@ -155,14 +152,13 @@ static int ena_com_admin_init_aenq(struct ena_com_dev *ena_dev,
 
 	aenq_caps = 0;
 	aenq_caps |= ena_dev->aenq.q_depth & ENA_REGS_AENQ_CAPS_AENQ_DEPTH_MASK;
-	aenq_caps |= (sizeof(struct ena_admin_aenq_entry)
-		      << ENA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_SHIFT) &
-		     ENA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_MASK;
+	aenq_caps |=
+		(sizeof(struct ena_admin_aenq_entry) << ENA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_SHIFT) &
+		ENA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_MASK;
 	writel(aenq_caps, ena_dev->reg_bar + ENA_REGS_AENQ_CAPS_OFF);
 
 	if (unlikely(!aenq_handlers)) {
-		netdev_err(ena_dev->net_device,
-			   "AENQ handlers pointer is NULL\n");
+		netdev_err(ena_dev->net_device, "AENQ handlers pointer is NULL\n");
 		return -EINVAL;
 	}
 
@@ -189,14 +185,12 @@ static struct ena_comp_ctx *get_comp_ctxt(struct ena_com_admin_queue *admin_queu
 	}
 
 	if (unlikely(!admin_queue->comp_ctx)) {
-		netdev_err(admin_queue->ena_dev->net_device,
-			   "Completion context is NULL\n");
+		netdev_err(admin_queue->ena_dev->net_device, "Completion context is NULL\n");
 		return NULL;
 	}
 
 	if (unlikely(admin_queue->comp_ctx[command_id].occupied && capture)) {
-		netdev_err(admin_queue->ena_dev->net_device,
-			   "Completion context is occupied\n");
+		netdev_err(admin_queue->ena_dev->net_device, "Completion context is occupied\n");
 		return NULL;
 	}
 
@@ -226,8 +220,7 @@ static struct ena_comp_ctx *__ena_com_submit_admin_cmd(struct ena_com_admin_queu
 	/* In case of queue FULL */
 	cnt = (u16)atomic_read(&admin_queue->outstanding_cmds);
 	if (cnt >= admin_queue->q_depth) {
-		netdev_dbg(admin_queue->ena_dev->net_device,
-			   "Admin queue is full.\n");
+		netdev_dbg(admin_queue->ena_dev->net_device, "Admin queue is full.\n");
 		admin_queue->stats.out_of_space++;
 		return ERR_PTR(-ENOSPC);
 	}
@@ -274,8 +267,7 @@ static int ena_com_init_comp_ctxt(struct ena_com_admin_queue *admin_queue)
 	struct ena_comp_ctx *comp_ctx;
 	u16 i;
 
-	admin_queue->comp_ctx =
-		devm_kzalloc(admin_queue->q_dmadev, size, GFP_KERNEL);
+	admin_queue->comp_ctx = devm_kzalloc(admin_queue->q_dmadev, size, GFP_KERNEL);
 	if (unlikely(!admin_queue->comp_ctx)) {
 		netdev_err(ena_dev->net_device, "Memory allocation failed\n");
 		return -ENOMEM;
@@ -320,7 +312,6 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_sq *io_sq)
 {
 	size_t size;
-	int dev_node = 0;
 
 	memset(&io_sq->desc_addr, 0x0, sizeof(io_sq->desc_addr));
 
@@ -333,23 +324,17 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 	size = io_sq->desc_entry_size * io_sq->q_depth;
 
 	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST) {
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
 		io_sq->desc_addr.virt_addr =
-			dma_alloc_coherent(ena_dev->dmadev, size,
-					   &io_sq->desc_addr.phys_addr,
+			dma_alloc_coherent(ena_dev->dmadev, size, &io_sq->desc_addr.phys_addr,
 					   GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
 		if (!io_sq->desc_addr.virt_addr) {
 			io_sq->desc_addr.virt_addr =
 				dma_alloc_coherent(ena_dev->dmadev, size,
-						   &io_sq->desc_addr.phys_addr,
-						   GFP_KERNEL);
+						   &io_sq->desc_addr.phys_addr, GFP_KERNEL);
 		}
 
 		if (!io_sq->desc_addr.virt_addr) {
-			netdev_err(ena_dev->net_device,
-				   "Memory allocation failed\n");
+			netdev_err(ena_dev->net_device, "Memory allocation failed\n");
 			return -ENOMEM;
 		}
 	}
@@ -365,18 +350,13 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
 			io_sq->bounce_buf_ctrl.buffers_num;
 
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
-		io_sq->bounce_buf_ctrl.base_buffer =
-			devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
+		io_sq->bounce_buf_ctrl.base_buffer = devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
 		if (!io_sq->bounce_buf_ctrl.base_buffer)
 			io_sq->bounce_buf_ctrl.base_buffer =
 				devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
 
 		if (!io_sq->bounce_buf_ctrl.base_buffer) {
-			netdev_err(ena_dev->net_device,
-				   "Bounce buffer memory allocation failed\n");
+			netdev_err(ena_dev->net_device, "Bounce buffer memory allocation failed\n");
 			return -ENOMEM;
 		}
 
@@ -410,7 +390,6 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_cq *io_cq)
 {
 	size_t size;
-	int prev_node = 0;
 
 	memset(&io_cq->cdesc_addr, 0x0, sizeof(io_cq->cdesc_addr));
 
@@ -422,16 +401,11 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 
 	size = io_cq->cdesc_entry_size_in_bytes * io_cq->q_depth;
 
-	prev_node = dev_to_node(ena_dev->dmadev);
-	set_dev_node(ena_dev->dmadev, ctx->numa_node);
 	io_cq->cdesc_addr.virt_addr =
-		dma_alloc_coherent(ena_dev->dmadev, size,
-				   &io_cq->cdesc_addr.phys_addr, GFP_KERNEL);
-	set_dev_node(ena_dev->dmadev, prev_node);
+		dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr, GFP_KERNEL);
 	if (!io_cq->cdesc_addr.virt_addr) {
 		io_cq->cdesc_addr.virt_addr =
-			dma_alloc_coherent(ena_dev->dmadev, size,
-					   &io_cq->cdesc_addr.phys_addr,
+			dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr,
 					   GFP_KERNEL);
 	}
 
@@ -514,8 +488,8 @@ static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
 					u8 comp_status)
 {
 	if (unlikely(comp_status != 0))
-		netdev_err(admin_queue->ena_dev->net_device,
-			   "Admin command failed[%u]\n", comp_status);
+		netdev_err(admin_queue->ena_dev->net_device, "Admin command failed[%u]\n",
+			   comp_status);
 
 	switch (comp_status) {
 	case ENA_ADMIN_SUCCESS:
@@ -580,8 +554,7 @@ static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_c
 	}
 
 	if (unlikely(comp_ctx->status == ENA_CMD_ABORTED)) {
-		netdev_err(admin_queue->ena_dev->net_device,
-			   "Command was aborted\n");
+		netdev_err(admin_queue->ena_dev->net_device, "Command was aborted\n");
 		spin_lock_irqsave(&admin_queue->q_lock, flags);
 		admin_queue->stats.aborted_cmd++;
 		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
@@ -589,8 +562,7 @@ static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_c
 		goto err;
 	}
 
-	WARN(comp_ctx->status != ENA_CMD_COMPLETED, "Invalid comp status %d\n",
-	     comp_ctx->status);
+	WARN(comp_ctx->status != ENA_CMD_COMPLETED, "Invalid comp status %d\n", comp_ctx->status);
 
 	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
 err:
@@ -634,8 +606,7 @@ static int ena_com_set_llq(struct ena_com_dev *ena_dev)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set LLQ configurations: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to set LLQ configurations: %d\n", ret);
 
 	return ret;
 }
@@ -658,8 +629,7 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 			llq_default_cfg->llq_header_location;
 	} else {
 		netdev_err(ena_dev->net_device,
-			   "Invalid header location control, supported: 0x%x\n",
-			   supported_feat);
+			   "Invalid header location control, supported: 0x%x\n", supported_feat);
 		return -EINVAL;
 	}
 
@@ -681,8 +651,8 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 
 			netdev_err(ena_dev->net_device,
 				   "Default llq stride ctrl is not supported, performing fallback, default: 0x%x, supported: 0x%x, used: 0x%x\n",
-				   llq_default_cfg->llq_stride_ctrl,
-				   supported_feat, llq_info->desc_stride_ctrl);
+				   llq_default_cfg->llq_stride_ctrl, supported_feat,
+				   llq_info->desc_stride_ctrl);
 		}
 	} else {
 		llq_info->desc_stride_ctrl = 0;
@@ -704,8 +674,7 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 			llq_info->desc_list_entry_size = 256;
 		} else {
 			netdev_err(ena_dev->net_device,
-				   "Invalid entry_size_ctrl, supported: 0x%x\n",
-				   supported_feat);
+				   "Invalid entry_size_ctrl, supported: 0x%x\n", supported_feat);
 			return -EINVAL;
 		}
 
@@ -750,8 +719,8 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 
 		netdev_err(ena_dev->net_device,
 			   "Default llq num descs before header is not supported, performing fallback, default: 0x%x, supported: 0x%x, used: 0x%x\n",
-			   llq_default_cfg->llq_num_decs_before_header,
-			   supported_feat, llq_info->descs_num_before_header);
+			   llq_default_cfg->llq_num_decs_before_header, supported_feat,
+			   llq_info->descs_num_before_header);
 	}
 	/* Check for accelerated queue supported */
 	llq_accel_mode_get = llq_features->accel_mode.u.get;
@@ -767,8 +736,7 @@ static int ena_com_config_llq_info(struct ena_com_dev *ena_dev,
 
 	rc = ena_com_set_llq(ena_dev);
 	if (rc)
-		netdev_err(ena_dev->net_device,
-			   "Cannot set LLQ configuration: %d\n", rc);
+		netdev_err(ena_dev->net_device, "Cannot set LLQ configuration: %d\n", rc);
 
 	return rc;
 }
@@ -780,8 +748,7 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 	int ret;
 
 	wait_for_completion_timeout(&comp_ctx->wait_event,
-				    usecs_to_jiffies(
-					    admin_queue->completion_timeout));
+				    usecs_to_jiffies(admin_queue->completion_timeout));
 
 	/* In case the command wasn't completed find out the root cause.
 	 * There might be 2 kinds of errors
@@ -797,8 +764,7 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 		if (comp_ctx->status == ENA_CMD_COMPLETED) {
 			netdev_err(admin_queue->ena_dev->net_device,
 				   "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
-				   comp_ctx->cmd_opcode,
-				   admin_queue->auto_polling ? "ON" : "OFF");
+				   comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
 			/* Check if fallback to polling is enabled */
 			if (admin_queue->auto_polling)
 				admin_queue->polling = true;
@@ -867,15 +833,13 @@ static u32 ena_com_reg_bar_read32(struct ena_com_dev *ena_dev, u16 offset)
 	if (unlikely(i == timeout)) {
 		netdev_err(ena_dev->net_device,
 			   "Reading reg failed for timeout. expected: req id[%u] offset[%u] actual: req id[%u] offset[%u]\n",
-			   mmio_read->seq_num, offset, read_resp->req_id,
-			   read_resp->reg_off);
+			   mmio_read->seq_num, offset, read_resp->req_id, read_resp->reg_off);
 		ret = ENA_MMIO_READ_TIMEOUT;
 		goto err;
 	}
 
 	if (read_resp->reg_off != offset) {
-		netdev_err(ena_dev->net_device,
-			   "Read failure: wrong offset provided\n");
+		netdev_err(ena_dev->net_device, "Read failure: wrong offset provided\n");
 		ret = ENA_MMIO_READ_TIMEOUT;
 	} else {
 		ret = read_resp->reg_val;
@@ -934,8 +898,7 @@ static int ena_com_destroy_io_sq(struct ena_com_dev *ena_dev,
 					    sizeof(destroy_resp));
 
 	if (unlikely(ret && (ret != -ENODEV)))
-		netdev_err(ena_dev->net_device,
-			   "Failed to destroy io sq error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to destroy io sq error: %d\n", ret);
 
 	return ret;
 }
@@ -949,8 +912,7 @@ static void ena_com_io_queue_free(struct ena_com_dev *ena_dev,
 	if (io_cq->cdesc_addr.virt_addr) {
 		size = io_cq->cdesc_entry_size_in_bytes * io_cq->q_depth;
 
-		dma_free_coherent(ena_dev->dmadev, size,
-				  io_cq->cdesc_addr.virt_addr,
+		dma_free_coherent(ena_dev->dmadev, size, io_cq->cdesc_addr.virt_addr,
 				  io_cq->cdesc_addr.phys_addr);
 
 		io_cq->cdesc_addr.virt_addr = NULL;
@@ -959,8 +921,7 @@ static void ena_com_io_queue_free(struct ena_com_dev *ena_dev,
 	if (io_sq->desc_addr.virt_addr) {
 		size = io_sq->desc_entry_size * io_sq->q_depth;
 
-		dma_free_coherent(ena_dev->dmadev, size,
-				  io_sq->desc_addr.virt_addr,
+		dma_free_coherent(ena_dev->dmadev, size, io_sq->desc_addr.virt_addr,
 				  io_sq->desc_addr.phys_addr);
 
 		io_sq->desc_addr.virt_addr = NULL;
@@ -985,8 +946,7 @@ static int wait_for_reset_state(struct ena_com_dev *ena_dev, u32 timeout,
 		val = ena_com_reg_bar_read32(ena_dev, ENA_REGS_DEV_STS_OFF);
 
 		if (unlikely(val == ENA_MMIO_READ_TIMEOUT)) {
-			netdev_err(ena_dev->net_device,
-				   "Reg read timeout occurred\n");
+			netdev_err(ena_dev->net_device, "Reg read timeout occurred\n");
 			return -ETIME;
 		}
 
@@ -1026,8 +986,7 @@ static int ena_com_get_feature_ex(struct ena_com_dev *ena_dev,
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev, feature_id)) {
-		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
-			   feature_id);
+		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n", feature_id);
 		return -EOPNOTSUPP;
 	}
 
@@ -1064,8 +1023,7 @@ static int ena_com_get_feature_ex(struct ena_com_dev *ena_dev,
 
 	if (unlikely(ret))
 		netdev_err(ena_dev->net_device,
-			   "Failed to submit get_feature command %d error: %d\n",
-			   feature_id, ret);
+			   "Failed to submit get_feature command %d error: %d\n", feature_id, ret);
 
 	return ret;
 }
@@ -1104,13 +1062,11 @@ static int ena_com_hash_key_allocate(struct ena_com_dev *ena_dev)
 {
 	struct ena_rss *rss = &ena_dev->rss;
 
-	if (!ena_com_check_supported_feature_id(ena_dev,
-						ENA_ADMIN_RSS_HASH_FUNCTION))
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_RSS_HASH_FUNCTION))
 		return -EOPNOTSUPP;
 
-	rss->hash_key =
-		dma_alloc_coherent(ena_dev->dmadev, sizeof(*rss->hash_key),
-				   &rss->hash_key_dma_addr, GFP_KERNEL);
+	rss->hash_key = dma_alloc_coherent(ena_dev->dmadev, sizeof(*rss->hash_key),
+					   &rss->hash_key_dma_addr, GFP_KERNEL);
 
 	if (unlikely(!rss->hash_key))
 		return -ENOMEM;
@@ -1123,8 +1079,8 @@ static void ena_com_hash_key_destroy(struct ena_com_dev *ena_dev)
 	struct ena_rss *rss = &ena_dev->rss;
 
 	if (rss->hash_key)
-		dma_free_coherent(ena_dev->dmadev, sizeof(*rss->hash_key),
-				  rss->hash_key, rss->hash_key_dma_addr);
+		dma_free_coherent(ena_dev->dmadev, sizeof(*rss->hash_key), rss->hash_key,
+				  rss->hash_key_dma_addr);
 	rss->hash_key = NULL;
 }
 
@@ -1132,9 +1088,8 @@ static int ena_com_hash_ctrl_init(struct ena_com_dev *ena_dev)
 {
 	struct ena_rss *rss = &ena_dev->rss;
 
-	rss->hash_ctrl =
-		dma_alloc_coherent(ena_dev->dmadev, sizeof(*rss->hash_ctrl),
-				   &rss->hash_ctrl_dma_addr, GFP_KERNEL);
+	rss->hash_ctrl = dma_alloc_coherent(ena_dev->dmadev, sizeof(*rss->hash_ctrl),
+					    &rss->hash_ctrl_dma_addr, GFP_KERNEL);
 
 	if (unlikely(!rss->hash_ctrl))
 		return -ENOMEM;
@@ -1147,8 +1102,8 @@ static void ena_com_hash_ctrl_destroy(struct ena_com_dev *ena_dev)
 	struct ena_rss *rss = &ena_dev->rss;
 
 	if (rss->hash_ctrl)
-		dma_free_coherent(ena_dev->dmadev, sizeof(*rss->hash_ctrl),
-				  rss->hash_ctrl, rss->hash_ctrl_dma_addr);
+		dma_free_coherent(ena_dev->dmadev, sizeof(*rss->hash_ctrl), rss->hash_ctrl,
+				  rss->hash_ctrl_dma_addr);
 	rss->hash_ctrl = NULL;
 }
 
@@ -1177,15 +1132,13 @@ static int ena_com_indirect_table_allocate(struct ena_com_dev *ena_dev,
 	tbl_size = (1ULL << log_size) *
 		sizeof(struct ena_admin_rss_ind_table_entry);
 
-	rss->rss_ind_tbl =
-		dma_alloc_coherent(ena_dev->dmadev, tbl_size,
-				   &rss->rss_ind_tbl_dma_addr, GFP_KERNEL);
+	rss->rss_ind_tbl = dma_alloc_coherent(ena_dev->dmadev, tbl_size, &rss->rss_ind_tbl_dma_addr,
+					      GFP_KERNEL);
 	if (unlikely(!rss->rss_ind_tbl))
 		goto mem_err1;
 
 	tbl_size = (1ULL << log_size) * sizeof(u16);
-	rss->host_rss_ind_tbl =
-		devm_kzalloc(ena_dev->dmadev, tbl_size, GFP_KERNEL);
+	rss->host_rss_ind_tbl = devm_kzalloc(ena_dev->dmadev, tbl_size, GFP_KERNEL);
 	if (unlikely(!rss->host_rss_ind_tbl))
 		goto mem_err2;
 
@@ -1197,8 +1150,7 @@ static int ena_com_indirect_table_allocate(struct ena_com_dev *ena_dev,
 	tbl_size = (1ULL << log_size) *
 		sizeof(struct ena_admin_rss_ind_table_entry);
 
-	dma_free_coherent(ena_dev->dmadev, tbl_size, rss->rss_ind_tbl,
-			  rss->rss_ind_tbl_dma_addr);
+	dma_free_coherent(ena_dev->dmadev, tbl_size, rss->rss_ind_tbl, rss->rss_ind_tbl_dma_addr);
 	rss->rss_ind_tbl = NULL;
 mem_err1:
 	rss->tbl_log_size = 0;
@@ -1261,8 +1213,7 @@ static int ena_com_create_io_sq(struct ena_com_dev *ena_dev,
 					   &create_cmd.sq_ba,
 					   io_sq->desc_addr.phys_addr);
 		if (unlikely(ret)) {
-			netdev_err(ena_dev->net_device,
-				   "Memory address set failed\n");
+			netdev_err(ena_dev->net_device, "Memory address set failed\n");
 			return ret;
 		}
 	}
@@ -1273,8 +1224,7 @@ static int ena_com_create_io_sq(struct ena_com_dev *ena_dev,
 					    (struct ena_admin_acq_entry *)&cmd_completion,
 					    sizeof(cmd_completion));
 	if (unlikely(ret)) {
-		netdev_err(ena_dev->net_device,
-			   "Failed to create IO SQ. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to create IO SQ. error: %d\n", ret);
 		return ret;
 	}
 
@@ -1292,8 +1242,7 @@ static int ena_com_create_io_sq(struct ena_com_dev *ena_dev,
 			cmd_completion.llq_descriptors_offset);
 	}
 
-	netdev_dbg(ena_dev->net_device, "Created sq[%u], depth[%u]\n",
-		   io_sq->idx, io_sq->q_depth);
+	netdev_dbg(ena_dev->net_device, "Created sq[%u], depth[%u]\n", io_sq->idx, io_sq->q_depth);
 
 	return ret;
 }
@@ -1420,8 +1369,7 @@ int ena_com_create_io_cq(struct ena_com_dev *ena_dev,
 					    (struct ena_admin_acq_entry *)&cmd_completion,
 					    sizeof(cmd_completion));
 	if (unlikely(ret)) {
-		netdev_err(ena_dev->net_device,
-			   "Failed to create IO CQ. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to create IO CQ. error: %d\n", ret);
 		return ret;
 	}
 
@@ -1440,8 +1388,7 @@ int ena_com_create_io_cq(struct ena_com_dev *ena_dev,
 			(u32 __iomem *)((uintptr_t)ena_dev->reg_bar +
 			cmd_completion.numa_node_register_offset);
 
-	netdev_dbg(ena_dev->net_device, "Created cq[%u], depth[%u]\n",
-		   io_cq->idx, io_cq->q_depth);
+	netdev_dbg(ena_dev->net_device, "Created cq[%u], depth[%u]\n", io_cq->idx, io_cq->q_depth);
 
 	return ret;
 }
@@ -1451,8 +1398,7 @@ int ena_com_get_io_handlers(struct ena_com_dev *ena_dev, u16 qid,
 			    struct ena_com_io_cq **io_cq)
 {
 	if (qid >= ENA_TOTAL_NUM_QUEUES) {
-		netdev_err(ena_dev->net_device,
-			   "Invalid queue number %d but the max is %d\n", qid,
+		netdev_err(ena_dev->net_device, "Invalid queue number %d but the max is %d\n", qid,
 			   ENA_TOTAL_NUM_QUEUES);
 		return -EINVAL;
 	}
@@ -1492,8 +1438,7 @@ void ena_com_wait_for_abort_completion(struct ena_com_dev *ena_dev)
 	spin_lock_irqsave(&admin_queue->q_lock, flags);
 	while (atomic_read(&admin_queue->outstanding_cmds) != 0) {
 		spin_unlock_irqrestore(&admin_queue->q_lock, flags);
-		ena_delay_exponential_backoff_us(exp++,
-						 ena_dev->ena_min_poll_delay_us);
+		ena_delay_exponential_backoff_us(exp++, ena_dev->ena_min_poll_delay_us);
 		spin_lock_irqsave(&admin_queue->q_lock, flags);
 	}
 	spin_unlock_irqrestore(&admin_queue->q_lock, flags);
@@ -1519,8 +1464,7 @@ int ena_com_destroy_io_cq(struct ena_com_dev *ena_dev,
 					    sizeof(destroy_resp));
 
 	if (unlikely(ret && (ret != -ENODEV)))
-		netdev_err(ena_dev->net_device,
-			   "Failed to destroy IO CQ. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to destroy IO CQ. error: %d\n", ret);
 
 	return ret;
 }
@@ -1588,8 +1532,7 @@ int ena_com_set_aenq_config(struct ena_com_dev *ena_dev, u32 groups_flag)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to config AENQ ret: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to config AENQ ret: %d\n", ret);
 
 	return ret;
 }
@@ -1610,8 +1553,7 @@ int ena_com_get_dma_width(struct ena_com_dev *ena_dev)
 	netdev_dbg(ena_dev->net_device, "ENA dma width: %d\n", width);
 
 	if ((width < 32) || width > ENA_MAX_PHYS_ADDR_SIZE_BITS) {
-		netdev_err(ena_dev->net_device, "DMA width illegal value: %d\n",
-			   width);
+		netdev_err(ena_dev->net_device, "DMA width illegal value: %d\n", width);
 		return -EINVAL;
 	}
 
@@ -1633,19 +1575,16 @@ int ena_com_validate_version(struct ena_com_dev *ena_dev)
 	ctrl_ver = ena_com_reg_bar_read32(ena_dev,
 					  ENA_REGS_CONTROLLER_VERSION_OFF);
 
-	if (unlikely((ver == ENA_MMIO_READ_TIMEOUT) ||
-		     (ctrl_ver == ENA_MMIO_READ_TIMEOUT))) {
+	if (unlikely((ver == ENA_MMIO_READ_TIMEOUT) || (ctrl_ver == ENA_MMIO_READ_TIMEOUT))) {
 		netdev_err(ena_dev->net_device, "Reg read timeout occurred\n");
 		return -ETIME;
 	}
 
 	dev_info(ena_dev->dmadev, "ENA device version: %d.%d\n",
-		 (ver & ENA_REGS_VERSION_MAJOR_VERSION_MASK) >>
-			 ENA_REGS_VERSION_MAJOR_VERSION_SHIFT,
+		 (ver & ENA_REGS_VERSION_MAJOR_VERSION_MASK) >> ENA_REGS_VERSION_MAJOR_VERSION_SHIFT,
 		 ver & ENA_REGS_VERSION_MINOR_VERSION_MASK);
 
-	dev_info(ena_dev->dmadev,
-		 "ENA controller version: %d.%d.%d implementation version %d\n",
+	dev_info(ena_dev->dmadev, "ENA controller version: %d.%d.%d implementation version %d\n",
 		 (ctrl_ver & ENA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_MASK) >>
 			 ENA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_SHIFT,
 		 (ctrl_ver & ENA_REGS_CONTROLLER_VERSION_MINOR_VERSION_MASK) >>
@@ -1694,20 +1633,17 @@ void ena_com_admin_destroy(struct ena_com_dev *ena_dev)
 
 	size = ADMIN_SQ_SIZE(admin_queue->q_depth);
 	if (sq->entries)
-		dma_free_coherent(ena_dev->dmadev, size, sq->entries,
-				  sq->dma_addr);
+		dma_free_coherent(ena_dev->dmadev, size, sq->entries, sq->dma_addr);
 	sq->entries = NULL;
 
 	size = ADMIN_CQ_SIZE(admin_queue->q_depth);
 	if (cq->entries)
-		dma_free_coherent(ena_dev->dmadev, size, cq->entries,
-				  cq->dma_addr);
+		dma_free_coherent(ena_dev->dmadev, size, cq->entries, cq->dma_addr);
 	cq->entries = NULL;
 
 	size = ADMIN_AENQ_SIZE(aenq->q_depth);
 	if (ena_dev->aenq.entries)
-		dma_free_coherent(ena_dev->dmadev, size, aenq->entries,
-				  aenq->dma_addr);
+		dma_free_coherent(ena_dev->dmadev, size, aenq->entries, aenq->dma_addr);
 	aenq->entries = NULL;
 }
 
@@ -1733,10 +1669,8 @@ int ena_com_mmio_reg_read_request_init(struct ena_com_dev *ena_dev)
 	struct ena_com_mmio_read *mmio_read = &ena_dev->mmio_read;
 
 	spin_lock_init(&mmio_read->lock);
-	mmio_read->read_resp =
-		dma_alloc_coherent(ena_dev->dmadev,
-				   sizeof(*mmio_read->read_resp),
-				   &mmio_read->read_resp_dma_addr, GFP_KERNEL);
+	mmio_read->read_resp = dma_alloc_coherent(ena_dev->dmadev, sizeof(*mmio_read->read_resp),
+						  &mmio_read->read_resp_dma_addr, GFP_KERNEL);
 	if (unlikely(!mmio_read->read_resp))
 		goto err;
 
@@ -1767,8 +1701,8 @@ void ena_com_mmio_reg_read_request_destroy(struct ena_com_dev *ena_dev)
 	writel(0x0, ena_dev->reg_bar + ENA_REGS_MMIO_RESP_LO_OFF);
 	writel(0x0, ena_dev->reg_bar + ENA_REGS_MMIO_RESP_HI_OFF);
 
-	dma_free_coherent(ena_dev->dmadev, sizeof(*mmio_read->read_resp),
-			  mmio_read->read_resp, mmio_read->read_resp_dma_addr);
+	dma_free_coherent(ena_dev->dmadev, sizeof(*mmio_read->read_resp), mmio_read->read_resp,
+			  mmio_read->read_resp_dma_addr);
 
 	mmio_read->read_resp = NULL;
 }
@@ -1800,8 +1734,7 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
 	}
 
 	if (!(dev_sts & ENA_REGS_DEV_STS_READY_MASK)) {
-		netdev_err(ena_dev->net_device,
-			   "Device isn't ready, abort com init\n");
+		netdev_err(ena_dev->net_device, "Device isn't ready, abort com init\n");
 		return -ENODEV;
 	}
 
@@ -1878,8 +1811,7 @@ int ena_com_create_io_queue(struct ena_com_dev *ena_dev,
 	int ret;
 
 	if (ctx->qid >= ENA_TOTAL_NUM_QUEUES) {
-		netdev_err(ena_dev->net_device,
-			   "Qid (%d) is bigger than max num of queues (%d)\n",
+		netdev_err(ena_dev->net_device, "Qid (%d) is bigger than max num of queues (%d)\n",
 			   ctx->qid, ENA_TOTAL_NUM_QUEUES);
 		return -EINVAL;
 	}
@@ -1905,8 +1837,7 @@ int ena_com_create_io_queue(struct ena_com_dev *ena_dev,
 
 	if (ctx->direction == ENA_COM_IO_QUEUE_DIRECTION_TX)
 		/* header length is limited to 8 bits */
-		io_sq->tx_max_header_size =
-			min_t(u32, ena_dev->tx_max_header_size, SZ_256);
+		io_sq->tx_max_header_size = min_t(u32, ena_dev->tx_max_header_size, SZ_256);
 
 	ret = ena_com_init_io_sq(ena_dev, ctx, io_sq);
 	if (ret)
@@ -1938,8 +1869,7 @@ void ena_com_destroy_io_queue(struct ena_com_dev *ena_dev, u16 qid)
 	struct ena_com_io_cq *io_cq;
 
 	if (qid >= ENA_TOTAL_NUM_QUEUES) {
-		netdev_err(ena_dev->net_device,
-			   "Qid (%d) is bigger than max num of queues (%d)\n",
+		netdev_err(ena_dev->net_device, "Qid (%d) is bigger than max num of queues (%d)\n",
 			   qid, ENA_TOTAL_NUM_QUEUES);
 		return;
 	}
@@ -1974,6 +1904,7 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 	       sizeof(get_resp.u.dev_attr));
 
 	ena_dev->supported_features = get_resp.u.dev_attr.supported_features;
+	ena_dev->capabilities = get_resp.u.dev_attr.capabilities;
 
 	if (ena_dev->supported_features & BIT(ENA_ADMIN_MAX_QUEUES_EXT)) {
 		rc = ena_com_get_feature(ena_dev, &get_resp,
@@ -1982,8 +1913,7 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 		if (rc)
 			return rc;
 
-		if (get_resp.u.max_queue_ext.version !=
-		    ENA_FEATURE_MAX_QUEUE_EXT_VER)
+		if (get_resp.u.max_queue_ext.version != ENA_FEATURE_MAX_QUEUE_EXT_VER)
 			return -EINVAL;
 
 		memcpy(&get_feat_ctx->max_queue_ext, &get_resp.u.max_queue_ext,
@@ -2024,18 +1954,15 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 	rc = ena_com_get_feature(ena_dev, &get_resp, ENA_ADMIN_HW_HINTS, 0);
 
 	if (!rc)
-		memcpy(&get_feat_ctx->hw_hints, &get_resp.u.hw_hints,
-		       sizeof(get_resp.u.hw_hints));
+		memcpy(&get_feat_ctx->hw_hints, &get_resp.u.hw_hints, sizeof(get_resp.u.hw_hints));
 	else if (rc == -EOPNOTSUPP)
-		memset(&get_feat_ctx->hw_hints, 0x0,
-		       sizeof(get_feat_ctx->hw_hints));
+		memset(&get_feat_ctx->hw_hints, 0x0, sizeof(get_feat_ctx->hw_hints));
 	else
 		return rc;
 
 	rc = ena_com_get_feature(ena_dev, &get_resp, ENA_ADMIN_LLQ, 0);
 	if (!rc)
-		memcpy(&get_feat_ctx->llq, &get_resp.u.llq,
-		       sizeof(get_resp.u.llq));
+		memcpy(&get_feat_ctx->llq, &get_resp.u.llq, sizeof(get_resp.u.llq));
 	else if (rc == -EOPNOTSUPP)
 		memset(&get_feat_ctx->llq, 0x0, sizeof(get_feat_ctx->llq));
 	else
@@ -2083,8 +2010,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 	aenq_common = &aenq_e->aenq_common_desc;
 
 	/* Go over all the events */
-	while ((READ_ONCE(aenq_common->flags) &
-		ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) == phase) {
+	while ((READ_ONCE(aenq_common->flags) & ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) == phase) {
 		/* Make sure the phase bit (ownership) is as expected before
 		 * reading the rest of the descriptor.
 		 */
@@ -2093,8 +2019,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 		timestamp = (u64)aenq_common->timestamp_low |
 			((u64)aenq_common->timestamp_high << 32);
 
-		netdev_dbg(ena_dev->net_device,
-			   "AENQ! Group[%x] Syndrome[%x] timestamp: [%llus]\n",
+		netdev_dbg(ena_dev->net_device, "AENQ! Group[%x] Syndrome[%x] timestamp: [%llus]\n",
 			   aenq_common->group, aenq_common->syndrome, timestamp);
 
 		/* Handle specific event*/
@@ -2123,8 +2048,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 
 	/* write the aenq doorbell after all AENQ descriptors were read */
 	mb();
-	writel_relaxed((u32)aenq->head,
-		       ena_dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
+	writel_relaxed((u32)aenq->head, ena_dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
 }
 
 int ena_com_dev_reset(struct ena_com_dev *ena_dev,
@@ -2136,15 +2060,13 @@ int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 	stat = ena_com_reg_bar_read32(ena_dev, ENA_REGS_DEV_STS_OFF);
 	cap = ena_com_reg_bar_read32(ena_dev, ENA_REGS_CAPS_OFF);
 
-	if (unlikely((stat == ENA_MMIO_READ_TIMEOUT) ||
-		     (cap == ENA_MMIO_READ_TIMEOUT))) {
+	if (unlikely((stat == ENA_MMIO_READ_TIMEOUT) || (cap == ENA_MMIO_READ_TIMEOUT))) {
 		netdev_err(ena_dev->net_device, "Reg read32 timeout occurred\n");
 		return -ETIME;
 	}
 
 	if ((stat & ENA_REGS_DEV_STS_READY_MASK) == 0) {
-		netdev_err(ena_dev->net_device,
-			   "Device isn't ready, can't reset device\n");
+		netdev_err(ena_dev->net_device, "Device isn't ready, can't reset device\n");
 		return -EINVAL;
 	}
 
@@ -2167,8 +2089,7 @@ int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 	rc = wait_for_reset_state(ena_dev, timeout,
 				  ENA_REGS_DEV_STS_RESET_IN_PROGRESS_MASK);
 	if (rc != 0) {
-		netdev_err(ena_dev->net_device,
-			   "Reset indication didn't turn on\n");
+		netdev_err(ena_dev->net_device, "Reset indication didn't turn on\n");
 		return rc;
 	}
 
@@ -2176,8 +2097,7 @@ int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 	writel(0, ena_dev->reg_bar + ENA_REGS_DEV_CTL_OFF);
 	rc = wait_for_reset_state(ena_dev, timeout, 0);
 	if (rc != 0) {
-		netdev_err(ena_dev->net_device,
-			   "Reset indication didn't turn off\n");
+		netdev_err(ena_dev->net_device, "Reset indication didn't turn off\n");
 		return rc;
 	}
 
@@ -2214,8 +2134,7 @@ static int ena_get_dev_stats(struct ena_com_dev *ena_dev,
 					     sizeof(*get_resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to get stats. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to get stats. error: %d\n", ret);
 
 	return ret;
 }
@@ -2226,6 +2145,12 @@ int ena_com_get_eni_stats(struct ena_com_dev *ena_dev,
 	struct ena_com_stats_ctx ctx;
 	int ret;
 
+	if (!ena_com_get_cap(ena_dev, ENA_ADMIN_ENI_STATS)) {
+		netdev_err(ena_dev->net_device, "Capability %d isn't supported\n",
+			   ENA_ADMIN_ENI_STATS);
+		return -EOPNOTSUPP;
+	}
+
 	memset(&ctx, 0x0, sizeof(ctx));
 	ret = ena_get_dev_stats(ena_dev, &ctx, ENA_ADMIN_GET_STATS_TYPE_ENI);
 	if (likely(ret == 0))
@@ -2258,8 +2183,7 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_MTU)) {
-		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
-			   ENA_ADMIN_MTU);
+		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n", ENA_ADMIN_MTU);
 		return -EOPNOTSUPP;
 	}
 
@@ -2278,8 +2202,7 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set mtu %d. error: %d\n", mtu, ret);
+		netdev_err(ena_dev->net_device, "Failed to set mtu %d. error: %d\n", mtu, ret);
 
 	return ret;
 }
@@ -2293,8 +2216,7 @@ int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
 	ret = ena_com_get_feature(ena_dev, &resp,
 				  ENA_ADMIN_STATELESS_OFFLOAD_CONFIG, 0);
 	if (unlikely(ret)) {
-		netdev_err(ena_dev->net_device,
-			   "Failed to get offload capabilities %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to get offload capabilities %d\n", ret);
 		return ret;
 	}
 
@@ -2312,8 +2234,7 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 	struct ena_admin_get_feat_resp get_resp;
 	int ret;
 
-	if (!ena_com_check_supported_feature_id(ena_dev,
-						ENA_ADMIN_RSS_HASH_FUNCTION)) {
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_RSS_HASH_FUNCTION)) {
 		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
 			   ENA_ADMIN_RSS_HASH_FUNCTION);
 		return -EOPNOTSUPP;
@@ -2326,8 +2247,7 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 		return ret;
 
 	if (!(get_resp.u.flow_hash_func.supported_func & BIT(rss->hash_func))) {
-		netdev_err(ena_dev->net_device,
-			   "Func hash %d isn't supported by device, abort\n",
+		netdev_err(ena_dev->net_device, "Func hash %d isn't supported by device, abort\n",
 			   rss->hash_func);
 		return -EOPNOTSUPP;
 	}
@@ -2357,8 +2277,7 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 					    (struct ena_admin_acq_entry *)&resp,
 					    sizeof(resp));
 	if (unlikely(ret)) {
-		netdev_err(ena_dev->net_device,
-			   "Failed to set hash function %d. error: %d\n",
+		netdev_err(ena_dev->net_device, "Failed to set hash function %d. error: %d\n",
 			   rss->hash_func, ret);
 		return -EINVAL;
 	}
@@ -2390,16 +2309,15 @@ int ena_com_fill_hash_function(struct ena_com_dev *ena_dev,
 		return rc;
 
 	if (!(BIT(func) & get_resp.u.flow_hash_func.supported_func)) {
-		netdev_err(ena_dev->net_device,
-			   "Flow hash function %d isn't supported\n", func);
+		netdev_err(ena_dev->net_device, "Flow hash function %d isn't supported\n", func);
 		return -EOPNOTSUPP;
 	}
 
 	if ((func == ENA_ADMIN_TOEPLITZ) && key) {
 		if (key_len != sizeof(hash_key->key)) {
 			netdev_err(ena_dev->net_device,
-				   "key len (%u) doesn't equal the supported size (%zu)\n",
-				   key_len, sizeof(hash_key->key));
+				   "key len (%u) doesn't equal the supported size (%zu)\n", key_len,
+				   sizeof(hash_key->key));
 			return -EINVAL;
 		}
 		memcpy(hash_key->key, key, key_len);
@@ -2487,8 +2405,7 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 	struct ena_admin_set_feat_resp resp;
 	int ret;
 
-	if (!ena_com_check_supported_feature_id(ena_dev,
-						ENA_ADMIN_RSS_HASH_INPUT)) {
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_RSS_HASH_INPUT)) {
 		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
 			   ENA_ADMIN_RSS_HASH_INPUT);
 		return -EOPNOTSUPP;
@@ -2519,8 +2436,7 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 					    (struct ena_admin_acq_entry *)&resp,
 					    sizeof(resp));
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set hash input. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to set hash input. error: %d\n", ret);
 
 	return ret;
 }
@@ -2597,8 +2513,7 @@ int ena_com_fill_hash_ctrl(struct ena_com_dev *ena_dev,
 	int rc;
 
 	if (proto >= ENA_ADMIN_RSS_PROTO_NUM) {
-		netdev_err(ena_dev->net_device, "Invalid proto num (%u)\n",
-			   proto);
+		netdev_err(ena_dev->net_device, "Invalid proto num (%u)\n", proto);
 		return -EINVAL;
 	}
 
@@ -2650,8 +2565,7 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 	struct ena_admin_set_feat_resp resp;
 	int ret;
 
-	if (!ena_com_check_supported_feature_id(
-		    ena_dev, ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG)) {
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG)) {
 		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
 			   ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG);
 		return -EOPNOTSUPP;
@@ -2691,8 +2605,7 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set indirect table. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to set indirect table. error: %d\n", ret);
 
 	return ret;
 }
@@ -2771,9 +2684,8 @@ int ena_com_allocate_host_info(struct ena_com_dev *ena_dev)
 {
 	struct ena_host_attribute *host_attr = &ena_dev->host_attr;
 
-	host_attr->host_info =
-		dma_alloc_coherent(ena_dev->dmadev, SZ_4K,
-				   &host_attr->host_info_dma_addr, GFP_KERNEL);
+	host_attr->host_info = dma_alloc_coherent(ena_dev->dmadev, SZ_4K,
+						  &host_attr->host_info_dma_addr, GFP_KERNEL);
 	if (unlikely(!host_attr->host_info))
 		return -ENOMEM;
 
@@ -2819,8 +2731,7 @@ void ena_com_delete_debug_area(struct ena_com_dev *ena_dev)
 
 	if (host_attr->debug_area_virt_addr) {
 		dma_free_coherent(ena_dev->dmadev, host_attr->debug_area_size,
-				  host_attr->debug_area_virt_addr,
-				  host_attr->debug_area_dma_addr);
+				  host_attr->debug_area_virt_addr, host_attr->debug_area_dma_addr);
 		host_attr->debug_area_virt_addr = NULL;
 	}
 }
@@ -2869,8 +2780,7 @@ int ena_com_set_host_attributes(struct ena_com_dev *ena_dev)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set host attributes: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to set host attributes: %d\n", ret);
 
 	return ret;
 }
@@ -2888,8 +2798,7 @@ static int ena_com_update_nonadaptive_moderation_interval(struct ena_com_dev *en
 							  u32 *intr_moder_interval)
 {
 	if (!intr_delay_resolution) {
-		netdev_err(ena_dev->net_device,
-			   "Illegal interrupt delay granularity value\n");
+		netdev_err(ena_dev->net_device, "Illegal interrupt delay granularity value\n");
 		return -EFAULT;
 	}
 
@@ -2927,14 +2836,12 @@ int ena_com_init_interrupt_moderation(struct ena_com_dev *ena_dev)
 
 	if (rc) {
 		if (rc == -EOPNOTSUPP) {
-			netdev_dbg(ena_dev->net_device,
-				   "Feature %d isn't supported\n",
+			netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
 				   ENA_ADMIN_INTERRUPT_MODERATION);
 			rc = 0;
 		} else {
 			netdev_err(ena_dev->net_device,
-				   "Failed to get interrupt moderation admin cmd. rc: %d\n",
-				   rc);
+				   "Failed to get interrupt moderation admin cmd. rc: %d\n", rc);
 		}
 
 		/* no moderation supported, disable adaptive support */
@@ -2982,8 +2889,7 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 		(llq_info->descs_num_before_header * sizeof(struct ena_eth_io_tx_desc));
 
 	if (unlikely(ena_dev->tx_max_header_size == 0)) {
-		netdev_err(ena_dev->net_device,
-			   "The size of the LLQ entry is smaller than needed\n");
+		netdev_err(ena_dev->net_device, "The size of the LLQ entry is smaller than needed\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.h b/drivers/net/ethernet/amazon/ena/ena_com.h
index 73b03ce59412..3c5081d9d25d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -314,6 +314,7 @@ struct ena_com_dev {
 
 	struct ena_rss rss;
 	u32 supported_features;
+	u32 capabilities;
 	u32 dma_addr_bits;
 
 	struct ena_host_attribute host_attr;
@@ -967,6 +968,18 @@ static inline void ena_com_disable_adaptive_moderation(struct ena_com_dev *ena_d
 	ena_dev->adaptive_coalescing = false;
 }
 
+/* ena_com_get_cap - query whether device supports a capability.
+ * @ena_dev: ENA communication layer struct
+ * @cap_id: enum value representing the capability
+ *
+ * @return - true if capability is supported or false otherwise
+ */
+static inline bool ena_com_get_cap(struct ena_com_dev *ena_dev,
+				   enum ena_admin_aq_caps_id cap_id)
+{
+	return !!(ena_dev->capabilities & BIT(cap_id));
+}
+
 /* ena_com_update_intr_reg - Prepare interrupt register
  * @intr_reg: interrupt register to update.
  * @rx_delay_interval: Rx interval in usecs
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.c b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
index f9f886289b97..933e619b3a31 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
@@ -18,8 +18,7 @@ static struct ena_eth_io_rx_cdesc_base *ena_com_get_next_rx_cdesc(
 	cdesc = (struct ena_eth_io_rx_cdesc_base *)(io_cq->cdesc_addr.virt_addr
 			+ (head_masked * io_cq->cdesc_entry_size_in_bytes));
 
-	desc_phase = (READ_ONCE(cdesc->status) &
-		      ENA_ETH_IO_RX_CDESC_BASE_PHASE_MASK) >>
+	desc_phase = (READ_ONCE(cdesc->status) & ENA_ETH_IO_RX_CDESC_BASE_PHASE_MASK) >>
 		     ENA_ETH_IO_RX_CDESC_BASE_PHASE_SHIFT;
 
 	if (desc_phase != expected_phase)
@@ -65,8 +64,8 @@ static int ena_com_write_bounce_buffer_to_dev(struct ena_com_io_sq *io_sq,
 
 		io_sq->entries_in_tx_burst_left--;
 		netdev_dbg(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-			   "Decreasing entries_in_tx_burst_left of queue %d to %d\n",
-			   io_sq->qid, io_sq->entries_in_tx_burst_left);
+			   "Decreasing entries_in_tx_burst_left of queue %d to %d\n", io_sq->qid,
+			   io_sq->entries_in_tx_burst_left);
 	}
 
 	/* Make sure everything was written into the bounce buffer before
@@ -75,8 +74,8 @@ static int ena_com_write_bounce_buffer_to_dev(struct ena_com_io_sq *io_sq,
 	wmb();
 
 	/* The line is completed. Copy it to dev */
-	__iowrite64_copy(io_sq->desc_addr.pbuf_dev_addr + dst_offset,
-			 bounce_buffer, (llq_info->desc_list_entry_size) / 8);
+	__iowrite64_copy(io_sq->desc_addr.pbuf_dev_addr + dst_offset, bounce_buffer,
+			 (llq_info->desc_list_entry_size) / 8);
 
 	io_sq->tail++;
 
@@ -102,16 +101,14 @@ static int ena_com_write_header_to_bounce(struct ena_com_io_sq *io_sq,
 	header_offset =
 		llq_info->descs_num_before_header * io_sq->desc_entry_size;
 
-	if (unlikely((header_offset + header_len) >
-		     llq_info->desc_list_entry_size)) {
+	if (unlikely((header_offset + header_len) > llq_info->desc_list_entry_size)) {
 		netdev_err(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
 			   "Trying to write header larger than llq entry can accommodate\n");
 		return -EFAULT;
 	}
 
 	if (unlikely(!bounce_buffer)) {
-		netdev_err(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-			   "Bounce buffer is NULL\n");
+		netdev_err(ena_com_io_sq_to_ena_dev(io_sq)->net_device, "Bounce buffer is NULL\n");
 		return -EFAULT;
 	}
 
@@ -129,8 +126,7 @@ static void *get_sq_desc_llq(struct ena_com_io_sq *io_sq)
 	bounce_buffer = pkt_ctrl->curr_bounce_buf;
 
 	if (unlikely(!bounce_buffer)) {
-		netdev_err(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-			   "Bounce buffer is NULL\n");
+		netdev_err(ena_com_io_sq_to_ena_dev(io_sq)->net_device, "Bounce buffer is NULL\n");
 		return NULL;
 	}
 
@@ -247,8 +243,7 @@ static u16 ena_com_cdesc_rx_pkt_get(struct ena_com_io_cq *io_cq,
 
 		ena_com_cq_inc_head(io_cq);
 		count++;
-		last = (READ_ONCE(cdesc->status) &
-			ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
+		last = (READ_ONCE(cdesc->status) & ENA_ETH_IO_RX_CDESC_BASE_LAST_MASK) >>
 		       ENA_ETH_IO_RX_CDESC_BASE_LAST_SHIFT;
 	} while (!last);
 
@@ -369,9 +364,8 @@ static void ena_com_rx_set_flags(struct ena_com_io_cq *io_cq,
 
 	netdev_dbg(ena_com_io_cq_to_ena_dev(io_cq)->net_device,
 		   "l3_proto %d l4_proto %d l3_csum_err %d l4_csum_err %d hash %d frag %d cdesc_status %x\n",
-		   ena_rx_ctx->l3_proto, ena_rx_ctx->l4_proto,
-		   ena_rx_ctx->l3_csum_err, ena_rx_ctx->l4_csum_err,
-		   ena_rx_ctx->hash, ena_rx_ctx->frag, cdesc->status);
+		   ena_rx_ctx->l3_proto, ena_rx_ctx->l4_proto, ena_rx_ctx->l3_csum_err,
+		   ena_rx_ctx->l4_csum_err, ena_rx_ctx->hash, ena_rx_ctx->frag, cdesc->status);
 }
 
 /*****************************************************************************/
@@ -403,13 +397,12 @@ int ena_com_prepare_tx(struct ena_com_io_sq *io_sq,
 
 	if (unlikely(header_len > io_sq->tx_max_header_size)) {
 		netdev_err(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-			   "Header size is too large %d max header: %d\n",
-			   header_len, io_sq->tx_max_header_size);
+			   "Header size is too large %d max header: %d\n", header_len,
+			   io_sq->tx_max_header_size);
 		return -EINVAL;
 	}
 
-	if (unlikely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV &&
-		     !buffer_to_push)) {
+	if (unlikely(io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_DEV && !buffer_to_push)) {
 		netdev_err(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
 			   "Push header wasn't provided in LLQ mode\n");
 		return -EINVAL;
@@ -556,13 +549,11 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	}
 
 	netdev_dbg(ena_com_io_cq_to_ena_dev(io_cq)->net_device,
-		   "Fetch rx packet: queue %d completed desc: %d\n", io_cq->qid,
-		   nb_hw_desc);
+		   "Fetch rx packet: queue %d completed desc: %d\n", io_cq->qid, nb_hw_desc);
 
 	if (unlikely(nb_hw_desc > ena_rx_ctx->max_bufs)) {
 		netdev_err(ena_com_io_cq_to_ena_dev(io_cq)->net_device,
-			   "Too many RX cdescs (%d) > MAX(%d)\n", nb_hw_desc,
-			   ena_rx_ctx->max_bufs);
+			   "Too many RX cdescs (%d) > MAX(%d)\n", nb_hw_desc, ena_rx_ctx->max_bufs);
 		return -ENOSPC;
 	}
 
@@ -586,8 +577,8 @@ int ena_com_rx_pkt(struct ena_com_io_cq *io_cq,
 	io_sq->next_to_comp += nb_hw_desc;
 
 	netdev_dbg(ena_com_io_cq_to_ena_dev(io_cq)->net_device,
-		   "[%s][QID#%d] Updating SQ head to: %d\n", __func__,
-		   io_sq->qid, io_sq->next_to_comp);
+		   "[%s][QID#%d] Updating SQ head to: %d\n", __func__, io_sq->qid,
+		   io_sq->next_to_comp);
 
 	/* Get rx flags from the last pkt */
 	ena_com_rx_set_flags(io_cq, ena_rx_ctx, cdesc);
@@ -624,8 +615,8 @@ int ena_com_add_single_rx_desc(struct ena_com_io_sq *io_sq,
 	desc->req_id = req_id;
 
 	netdev_dbg(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-		   "[%s] Adding single RX desc, Queue: %u, req_id: %u\n",
-		   __func__, io_sq->qid, req_id);
+		   "[%s] Adding single RX desc, Queue: %u, req_id: %u\n", __func__, io_sq->qid,
+		   req_id);
 
 	desc->buff_addr_lo = (u32)ena_buf->paddr;
 	desc->buff_addr_hi =
diff --git a/drivers/net/ethernet/amazon/ena/ena_eth_com.h b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
index 689313ee25a8..07029eee78ca 100644
--- a/drivers/net/ethernet/amazon/ena/ena_eth_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.h
@@ -141,8 +141,8 @@ static inline bool ena_com_is_doorbell_needed(struct ena_com_io_sq *io_sq,
 	}
 
 	netdev_dbg(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-		   "Queue: %d num_descs: %d num_entries_needed: %d\n",
-		   io_sq->qid, num_descs, num_entries_needed);
+		   "Queue: %d num_descs: %d num_entries_needed: %d\n", io_sq->qid, num_descs,
+		   num_entries_needed);
 
 	return num_entries_needed > io_sq->entries_in_tx_burst_left;
 }
@@ -153,15 +153,14 @@ static inline int ena_com_write_sq_doorbell(struct ena_com_io_sq *io_sq)
 	u16 tail = io_sq->tail;
 
 	netdev_dbg(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-		   "Write submission queue doorbell for queue: %d tail: %d\n",
-		   io_sq->qid, tail);
+		   "Write submission queue doorbell for queue: %d tail: %d\n", io_sq->qid, tail);
 
 	writel(tail, io_sq->db_addr);
 
 	if (is_llq_max_tx_burst_exists(io_sq)) {
 		netdev_dbg(ena_com_io_sq_to_ena_dev(io_sq)->net_device,
-			   "Reset available entries in tx burst for queue %d to %d\n",
-			   io_sq->qid, max_entries_in_tx_burst);
+			   "Reset available entries in tx burst for queue %d to %d\n", io_sq->qid,
+			   max_entries_in_tx_burst);
 		io_sq->entries_in_tx_burst_left = max_entries_in_tx_burst;
 	}
 
@@ -244,8 +243,8 @@ static inline int ena_com_tx_comp_req_id_get(struct ena_com_io_cq *io_cq,
 
 	*req_id = READ_ONCE(cdesc->req_id);
 	if (unlikely(*req_id >= io_cq->q_depth)) {
-		netdev_err(ena_com_io_cq_to_ena_dev(io_cq)->net_device,
-			   "Invalid req id %d\n", cdesc->req_id);
+		netdev_err(ena_com_io_cq_to_ena_dev(io_cq)->net_device, "Invalid req id %d\n",
+			   cdesc->req_id);
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 3ea449be7bdc..4d036b1ea684 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -103,7 +103,7 @@ static void ena_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	if (test_and_set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags))
 		return;
 
-	adapter->reset_reason = ENA_REGS_RESET_OS_NETDEV_WD;
+	ena_reset_device(adapter, ENA_REGS_RESET_OS_NETDEV_WD);
 	ena_increase_stat(&adapter->dev_stats.tx_timeout, 1, &adapter->syncp);
 
 	netif_err(adapter, tx_err, dev, "Transmit time out\n");
@@ -164,13 +164,9 @@ static int ena_xmit_common(struct net_device *dev,
 	if (unlikely(rc)) {
 		netif_err(adapter, tx_queued, dev,
 			  "Failed to prepare tx bufs\n");
-		ena_increase_stat(&ring->tx_stats.prepare_ctx_err, 1,
-				  &ring->syncp);
-		if (rc != -ENOMEM) {
-			adapter->reset_reason =
-				ENA_REGS_RESET_DRIVER_INVALID_STATE;
-			set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
-		}
+		ena_increase_stat(&ring->tx_stats.prepare_ctx_err, 1, &ring->syncp);
+		if (rc != -ENOMEM)
+			ena_reset_device(adapter, ENA_REGS_RESET_DRIVER_INVALID_STATE);
 		return rc;
 	}
 
@@ -994,8 +990,7 @@ static struct page *ena_alloc_map_page(struct ena_ring *rx_ring,
 	 */
 	page = dev_alloc_page();
 	if (!page) {
-		ena_increase_stat(&rx_ring->rx_stats.page_alloc_fail, 1,
-				  &rx_ring->syncp);
+		ena_increase_stat(&rx_ring->rx_stats.page_alloc_fail, 1, &rx_ring->syncp);
 		return ERR_PTR(-ENOSPC);
 	}
 
@@ -1024,7 +1019,7 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	int tailroom;
 
 	/* restore page offset value in case it has been changed by device */
-	rx_info->page_offset = headroom;
+	rx_info->buf_offset = headroom;
 
 	/* if previous allocated page is not used */
 	if (unlikely(rx_info->page))
@@ -1041,6 +1036,8 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	rx_info->page = page;
+	rx_info->dma_addr = dma;
+	rx_info->page_offset = 0;
 	ena_buf = &rx_info->ena_buf;
 	ena_buf->paddr = dma + headroom;
 	ena_buf->len = ENA_PAGE_SIZE - headroom - tailroom;
@@ -1048,14 +1045,12 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	return 0;
 }
 
-static void ena_unmap_rx_buff(struct ena_ring *rx_ring,
-			      struct ena_rx_buffer *rx_info)
+static void ena_unmap_rx_buff_attrs(struct ena_ring *rx_ring,
+				    struct ena_rx_buffer *rx_info,
+				    unsigned long attrs)
 {
-	struct ena_com_buf *ena_buf = &rx_info->ena_buf;
-
-	dma_unmap_page(rx_ring->dev, ena_buf->paddr - rx_ring->rx_headroom,
-		       ENA_PAGE_SIZE,
-		       DMA_BIDIRECTIONAL);
+	dma_unmap_page_attrs(rx_ring->dev, rx_info->dma_addr, ENA_PAGE_SIZE, DMA_BIDIRECTIONAL,
+			     attrs);
 }
 
 static void ena_free_rx_page(struct ena_ring *rx_ring,
@@ -1069,7 +1064,7 @@ static void ena_free_rx_page(struct ena_ring *rx_ring,
 		return;
 	}
 
-	ena_unmap_rx_buff(rx_ring, rx_info);
+	ena_unmap_rx_buff_attrs(rx_ring, rx_info, 0);
 
 	__free_page(page);
 	rx_info->page = NULL;
@@ -1297,10 +1292,8 @@ static int handle_invalid_req_id(struct ena_ring *ring, u16 req_id,
 			  req_id);
 
 	ena_increase_stat(&ring->tx_stats.bad_req_id, 1, &ring->syncp);
+	ena_reset_device(ring->adapter, ENA_REGS_RESET_INV_TX_REQ_ID);
 
-	/* Trigger device reset */
-	ring->adapter->reset_reason = ENA_REGS_RESET_INV_TX_REQ_ID;
-	set_bit(ENA_FLAG_TRIGGER_RESET, &ring->adapter->flags);
 	return -EFAULT;
 }
 
@@ -1348,8 +1341,7 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
 						&req_id);
 		if (rc) {
 			if (unlikely(rc == -EINVAL))
-				handle_invalid_req_id(tx_ring, req_id, NULL,
-						      false);
+				handle_invalid_req_id(tx_ring, req_id, NULL, false);
 			break;
 		}
 
@@ -1417,15 +1409,14 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
 	return tx_pkts;
 }
 
-static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag)
+static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag, u16 len)
 {
 	struct sk_buff *skb;
 
 	if (!first_frag)
-		skb = netdev_alloc_skb_ip_align(rx_ring->netdev,
-						rx_ring->rx_copybreak);
+		skb = napi_alloc_skb(rx_ring->napi, len);
 	else
-		skb = build_skb(first_frag, ENA_PAGE_SIZE);
+		skb = napi_build_skb(first_frag, len);
 
 	if (unlikely(!skb)) {
 		ena_increase_stat(&rx_ring->rx_stats.skb_alloc_fail, 1,
@@ -1434,24 +1425,47 @@ static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag)
 		netif_dbg(rx_ring->adapter, rx_err, rx_ring->netdev,
 			  "Failed to allocate skb. first_frag %s\n",
 			  first_frag ? "provided" : "not provided");
-		return NULL;
 	}
 
 	return skb;
 }
 
+static bool ena_try_rx_buf_page_reuse(struct ena_rx_buffer *rx_info, u16 buf_len,
+				      u16 len, int pkt_offset)
+{
+	struct ena_com_buf *ena_buf = &rx_info->ena_buf;
+
+	/* More than ENA_MIN_RX_BUF_SIZE left in the reused buffer
+	 * for data + headroom + tailroom.
+	 */
+	if (SKB_DATA_ALIGN(len + pkt_offset) + ENA_MIN_RX_BUF_SIZE <= ena_buf->len) {
+		page_ref_inc(rx_info->page);
+		rx_info->page_offset += buf_len;
+		ena_buf->paddr += buf_len;
+		ena_buf->len -= buf_len;
+		return true;
+	}
+
+	return false;
+}
+
 static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 				  struct ena_com_rx_buf_info *ena_bufs,
 				  u32 descs,
 				  u16 *next_to_clean)
 {
+	int tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bool is_xdp_loaded = ena_xdp_present_ring(rx_ring);
 	struct ena_rx_buffer *rx_info;
 	struct ena_adapter *adapter;
+	int page_offset, pkt_offset;
+	dma_addr_t pre_reuse_paddr;
 	u16 len, req_id, buf = 0;
+	bool reuse_rx_buf_page;
 	struct sk_buff *skb;
-	void *page_addr;
-	u32 page_offset;
-	void *data_addr;
+	void *buf_addr;
+	int buf_offset;
+	u16 buf_len;
 
 	len = ena_bufs[buf].len;
 	req_id = ena_bufs[buf].req_id;
@@ -1463,10 +1477,7 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		netif_err(adapter, rx_err, rx_ring->netdev,
 			  "Page is NULL. qid %u req_id %u\n", rx_ring->qid, req_id);
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1, &rx_ring->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_INV_RX_REQ_ID;
-		/* Make sure reset reason is set before triggering the reset */
-		smp_mb__before_atomic();
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_INV_RX_REQ_ID);
 		return NULL;
 	}
 
@@ -1474,34 +1485,25 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		  "rx_info %p page %p\n",
 		  rx_info, rx_info->page);
 
-	/* save virt address of first buffer */
-	page_addr = page_address(rx_info->page);
+	buf_offset = rx_info->buf_offset;
+	pkt_offset = buf_offset - rx_ring->rx_headroom;
 	page_offset = rx_info->page_offset;
-	data_addr = page_addr + page_offset;
-
-	prefetch(data_addr);
+	buf_addr = page_address(rx_info->page) + page_offset;
 
 	if (len <= rx_ring->rx_copybreak) {
-		skb = ena_alloc_skb(rx_ring, NULL);
+		skb = ena_alloc_skb(rx_ring, NULL, len);
 		if (unlikely(!skb))
 			return NULL;
 
-		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
-			  "RX allocated small packet. len %d. data_len %d\n",
-			  skb->len, skb->data_len);
-
-		/* sync this buffer for CPU use */
-		dma_sync_single_for_cpu(rx_ring->dev,
-					dma_unmap_addr(&rx_info->ena_buf, paddr),
-					len,
-					DMA_FROM_DEVICE);
-		skb_copy_to_linear_data(skb, data_addr, len);
+		skb_copy_to_linear_data(skb, buf_addr + buf_offset, len);
 		dma_sync_single_for_device(rx_ring->dev,
-					   dma_unmap_addr(&rx_info->ena_buf, paddr),
+					   dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
 					   len,
 					   DMA_FROM_DEVICE);
 
 		skb_put(skb, len);
+		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
+			  "RX allocated small packet. len %d.\n", skb->len);
 		skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 		rx_ring->free_ids[*next_to_clean] = req_id;
 		*next_to_clean = ENA_RX_RING_IDX_ADD(*next_to_clean, descs,
@@ -1509,14 +1511,21 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		return skb;
 	}
 
-	ena_unmap_rx_buff(rx_ring, rx_info);
+	buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
+
+	/* If XDP isn't loaded try to reuse part of the RX buffer */
+	reuse_rx_buf_page = !is_xdp_loaded &&
+			    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
 
-	skb = ena_alloc_skb(rx_ring, page_addr);
+	if (!reuse_rx_buf_page)
+		ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
+
+	skb = ena_alloc_skb(rx_ring, buf_addr, buf_len);
 	if (unlikely(!skb))
 		return NULL;
 
 	/* Populate skb's linear part */
-	skb_reserve(skb, page_offset);
+	skb_reserve(skb, buf_offset);
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 
@@ -1525,7 +1534,8 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 			  "RX skb updated. len %d. data_len %d\n",
 			  skb->len, skb->data_len);
 
-		rx_info->page = NULL;
+		if (!reuse_rx_buf_page)
+			rx_info->page = NULL;
 
 		rx_ring->free_ids[*next_to_clean] = req_id;
 		*next_to_clean =
@@ -1540,10 +1550,27 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 
 		rx_info = &rx_ring->rx_buffer_info[req_id];
 
-		ena_unmap_rx_buff(rx_ring, rx_info);
+		/* rx_info->buf_offset includes rx_ring->rx_headroom */
+		buf_offset = rx_info->buf_offset;
+		pkt_offset = buf_offset - rx_ring->rx_headroom;
+		buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
+		page_offset = rx_info->page_offset;
+
+		pre_reuse_paddr = dma_unmap_addr(&rx_info->ena_buf, paddr);
+
+		reuse_rx_buf_page = !is_xdp_loaded &&
+				    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
+
+		dma_sync_single_for_cpu(rx_ring->dev,
+					pre_reuse_paddr + pkt_offset,
+					len,
+					DMA_FROM_DEVICE);
+
+		if (!reuse_rx_buf_page)
+			ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_info->page,
-				rx_info->page_offset, len, ENA_PAGE_SIZE);
+				page_offset + buf_offset, len, buf_len);
 
 	} while (1);
 
@@ -1649,14 +1676,14 @@ static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp, u
 
 	rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
 	xdp_prepare_buff(xdp, page_address(rx_info->page),
-			 rx_info->page_offset,
+			 rx_info->buf_offset,
 			 rx_ring->ena_bufs[0].len, false);
 
 	ret = ena_xdp_execute(rx_ring, xdp);
 
 	/* The xdp program might expand the headers */
 	if (ret == ENA_XDP_PASS) {
-		rx_info->page_offset = xdp->data - xdp->data_hard_start;
+		rx_info->buf_offset = xdp->data - xdp->data_hard_start;
 		rx_ring->ena_bufs[0].len = xdp->data_end - xdp->data;
 	}
 
@@ -1685,6 +1712,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	int xdp_flags = 0;
 	int total_len = 0;
 	int xdp_verdict;
+	u8 pkt_offset;
 	int rc = 0;
 	int i;
 
@@ -1711,13 +1739,19 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 
 		/* First descriptor might have an offset set by the device */
 		rx_info = &rx_ring->rx_buffer_info[rx_ring->ena_bufs[0].req_id];
-		rx_info->page_offset += ena_rx_ctx.pkt_offset;
+		pkt_offset = ena_rx_ctx.pkt_offset;
+		rx_info->buf_offset += pkt_offset;
 
 		netif_dbg(rx_ring->adapter, rx_status, rx_ring->netdev,
 			  "rx_poll: q %d got packet from ena. descs #: %d l3 proto %d l4 proto %d hash: %x\n",
 			  rx_ring->qid, ena_rx_ctx.descs, ena_rx_ctx.l3_proto,
 			  ena_rx_ctx.l4_proto, ena_rx_ctx.hash);
 
+		dma_sync_single_for_cpu(rx_ring->dev,
+					dma_unmap_addr(&rx_info->ena_buf, paddr) + pkt_offset,
+					rx_ring->ena_bufs[0].len,
+					DMA_FROM_DEVICE);
+
 		if (ena_xdp_present_ring(rx_ring))
 			xdp_verdict = ena_xdp_handle_buff(rx_ring, &xdp, ena_rx_ctx.descs);
 
@@ -1741,8 +1775,9 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 				 * from RX side.
 				 */
 				if (xdp_verdict & ENA_XDP_FORWARDED) {
-					ena_unmap_rx_buff(rx_ring,
-							  &rx_ring->rx_buffer_info[req_id]);
+					ena_unmap_rx_buff_attrs(rx_ring,
+								&rx_ring->rx_buffer_info[req_id],
+								DMA_ATTR_SKIP_CPU_SYNC);
 					rx_ring->rx_buffer_info[req_id].page = NULL;
 				}
 			}
@@ -1804,17 +1839,13 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	adapter = netdev_priv(rx_ring->netdev);
 
 	if (rc == -ENOSPC) {
-		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1,
-				  &rx_ring->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_TOO_MANY_RX_DESCS;
+		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1, &rx_ring->syncp);
+		ena_reset_device(adapter, ENA_REGS_RESET_TOO_MANY_RX_DESCS);
 	} else {
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1,
 				  &rx_ring->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_INV_RX_REQ_ID;
+		ena_reset_device(adapter, ENA_REGS_RESET_INV_RX_REQ_ID);
 	}
-
-	set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
-
 	return 0;
 }
 
@@ -2355,8 +2386,7 @@ static int ena_rss_configure(struct ena_adapter *adapter)
 	if (!ena_dev->rss.tbl_log_size) {
 		rc = ena_rss_init_default(adapter);
 		if (rc && (rc != -EOPNOTSUPP)) {
-			netif_err(adapter, ifup, adapter->netdev,
-				  "Failed to init RSS rc: %d\n", rc);
+			netif_err(adapter, ifup, adapter->netdev, "Failed to init RSS rc: %d\n", rc);
 			return rc;
 		}
 	}
@@ -3229,7 +3259,8 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 		ENA_ADMIN_HOST_INFO_RX_OFFSET_MASK |
 		ENA_ADMIN_HOST_INFO_INTERRUPT_MODERATION_MASK |
 		ENA_ADMIN_HOST_INFO_RX_BUF_MIRRORING_MASK |
-		ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK;
+		ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK |
+		ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK;
 
 	rc = ena_com_set_host_attributes(ena_dev);
 	if (rc) {
@@ -3272,8 +3303,7 @@ static void ena_config_debug_area(struct ena_adapter *adapter)
 	rc = ena_com_set_host_attributes(adapter->ena_dev);
 	if (rc) {
 		if (rc == -EOPNOTSUPP)
-			netif_warn(adapter, drv, adapter->netdev,
-				   "Cannot set host attributes\n");
+			netif_warn(adapter, drv, adapter->netdev, "Cannot set host attributes\n");
 		else
 			netif_err(adapter, drv, adapter->netdev,
 				  "Cannot set host attributes\n");
@@ -3740,9 +3770,8 @@ static int check_for_rx_interrupt_queue(struct ena_adapter *adapter,
 		netif_err(adapter, rx_err, adapter->netdev,
 			  "Potential MSIX issue on Rx side Queue = %d. Reset the device\n",
 			  rx_ring->qid);
-		adapter->reset_reason = ENA_REGS_RESET_MISS_INTERRUPT;
-		smp_mb__before_atomic();
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+
+		ena_reset_device(adapter, ENA_REGS_RESET_MISS_INTERRUPT);
 		return -EIO;
 	}
 
@@ -3779,9 +3808,7 @@ static int check_missing_comp_in_tx_queue(struct ena_adapter *adapter,
 			netif_err(adapter, tx_err, adapter->netdev,
 				  "Potential MSIX issue on Tx side Queue = %d. Reset the device\n",
 				  tx_ring->qid);
-			adapter->reset_reason = ENA_REGS_RESET_MISS_INTERRUPT;
-			smp_mb__before_atomic();
-			set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+			ena_reset_device(adapter, ENA_REGS_RESET_MISS_INTERRUPT);
 			return -EIO;
 		}
 
@@ -3807,9 +3834,7 @@ static int check_missing_comp_in_tx_queue(struct ena_adapter *adapter,
 			  "The number of lost tx completions is above the threshold (%d > %d). Reset the device\n",
 			  missed_tx,
 			  adapter->missing_tx_completion_threshold);
-		adapter->reset_reason =
-			ENA_REGS_RESET_MISS_TX_CMPL;
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_MISS_TX_CMPL);
 		rc = -EIO;
 	}
 
@@ -3933,8 +3958,7 @@ static void check_for_missing_keep_alive(struct ena_adapter *adapter)
 			  "Keep alive watchdog timeout.\n");
 		ena_increase_stat(&adapter->dev_stats.wd_expired, 1,
 				  &adapter->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_KEEP_ALIVE_TO;
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_KEEP_ALIVE_TO);
 	}
 }
 
@@ -3945,8 +3969,7 @@ static void check_for_admin_com_state(struct ena_adapter *adapter)
 			  "ENA admin queue is not in running state!\n");
 		ena_increase_stat(&adapter->dev_stats.admin_q_pause, 1,
 				  &adapter->syncp);
-		adapter->reset_reason = ENA_REGS_RESET_ADMIN_TO;
-		set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+		ena_reset_device(adapter, ENA_REGS_RESET_ADMIN_TO);
 	}
 }
 
@@ -4152,8 +4175,8 @@ static int ena_rss_init_default(struct ena_adapter *adapter)
 		}
 	}
 
-	rc = ena_com_fill_hash_function(ena_dev, ENA_ADMIN_TOEPLITZ, NULL,
-					ENA_HASH_KEY_SIZE, 0xFFFFFFFF);
+	rc = ena_com_fill_hash_function(ena_dev, ENA_ADMIN_TOEPLITZ, NULL, ENA_HASH_KEY_SIZE,
+					0xFFFFFFFF);
 	if (unlikely(rc && (rc != -EOPNOTSUPP))) {
 		dev_err(dev, "Cannot fill hash function\n");
 		goto err_fill_indir;
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.h b/drivers/net/ethernet/amazon/ena/ena_netdev.h
index bf2a39c91c00..de54815845ab 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -50,6 +50,8 @@
 #define ENA_DEFAULT_RING_SIZE	(1024)
 #define ENA_MIN_RING_SIZE	(256)
 
+#define ENA_MIN_RX_BUF_SIZE (2048)
+
 #define ENA_MIN_NUM_IO_QUEUES	(1)
 
 #define ENA_TX_WAKEUP_THRESH		(MAX_SKB_FRAGS + 2)
@@ -186,7 +188,9 @@ struct ena_tx_buffer {
 struct ena_rx_buffer {
 	struct sk_buff *skb;
 	struct page *page;
+	dma_addr_t dma_addr;
 	u32 page_offset;
+	u32 buf_offset;
 	struct ena_com_buf ena_buf;
 } ____cacheline_aligned;
 
@@ -410,6 +414,15 @@ int ena_set_rx_copybreak(struct ena_adapter *adapter, u32 rx_copybreak);
 
 int ena_get_sset_count(struct net_device *netdev, int sset);
 
+static inline void ena_reset_device(struct ena_adapter *adapter,
+				    enum ena_regs_reset_reason_types reset_reason)
+{
+	adapter->reset_reason = reset_reason;
+	/* Make sure reset reason is set before triggering the reset */
+	smp_mb__before_atomic();
+	set_bit(ENA_FLAG_TRIGGER_RESET, &adapter->flags);
+}
+
 enum ena_xdp_errors_t {
 	ENA_XDP_ALLOWED = 0,
 	ENA_XDP_CURRENT_MTU_TOO_LARGE,
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index d0a8f7106958..52bc164a1cfb 100644
--- a/drivers/net/ethernet/cisco/enic/enic_main.c
+++ b/drivers/net/ethernet/cisco/enic/enic_main.c
@@ -1117,18 +1117,30 @@ static int enic_set_vf_port(struct net_device *netdev, int vf,
 	pp->request = nla_get_u8(port[IFLA_PORT_REQUEST]);
 
 	if (port[IFLA_PORT_PROFILE]) {
+		if (nla_len(port[IFLA_PORT_PROFILE]) != PORT_PROFILE_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_NAME;
 		memcpy(pp->name, nla_data(port[IFLA_PORT_PROFILE]),
 			PORT_PROFILE_MAX);
 	}
 
 	if (port[IFLA_PORT_INSTANCE_UUID]) {
+		if (nla_len(port[IFLA_PORT_INSTANCE_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_INSTANCE;
 		memcpy(pp->instance_uuid,
 			nla_data(port[IFLA_PORT_INSTANCE_UUID]), PORT_UUID_MAX);
 	}
 
 	if (port[IFLA_PORT_HOST_UUID]) {
+		if (nla_len(port[IFLA_PORT_HOST_UUID]) != PORT_UUID_MAX) {
+			memcpy(pp, &prev_pp, sizeof(*pp));
+			return -EINVAL;
+		}
 		pp->set |= ENIC_SET_HOST;
 		memcpy(pp->host_uuid,
 			nla_data(port[IFLA_PORT_HOST_UUID]), PORT_UUID_MAX);
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 675c6dda45e2..0c8c92ff7704 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1108,10 +1108,13 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
+	unsigned long flags;
 	u32 val, mask;
 
 	netdev_dbg(netdev, "%s device %d\n", __func__, netdev->dev_id);
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
+
 	mask = GMAC0_IRQ0_TXQ0_INTS << (6 * netdev->dev_id + txq);
 
 	if (en)
@@ -1120,6 +1123,8 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
 	val = en ? val | mask : val & ~mask;
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
+
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 static void gmac_tx_irq(struct net_device *netdev, unsigned int txq_num)
@@ -1426,15 +1431,19 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	union gmac_rxdesc_3 word3;
 	struct page *page = NULL;
 	unsigned int page_offs;
+	unsigned long flags;
 	unsigned short r, w;
 	union dma_rwptr rw;
 	dma_addr_t mapping;
 	int frag_nr = 0;
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
 	rw.bits32 = readl(ptr_reg);
 	/* Reset interrupt as all packages until here are taken into account */
 	writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
 	       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
+
 	r = rw.bits.rptr;
 	w = rw.bits.wptr;
 
@@ -1737,10 +1746,9 @@ static irqreturn_t gmac_irq(int irq, void *data)
 		gmac_update_hw_stats(netdev);
 
 	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
+		spin_lock(&geth->irq_lock);
 		writel(GMAC0_RXDERR_INT_BIT << (netdev->dev_id * 8),
 		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
-
-		spin_lock(&geth->irq_lock);
 		u64_stats_update_begin(&port->ir_stats_syncp);
 		++port->stats.rx_fifo_errors;
 		u64_stats_update_end(&port->ir_stats_syncp);
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 972808777f30..f02376555ed4 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3627,6 +3627,14 @@ static int fec_enet_init(struct net_device *ndev)
 	return ret;
 }
 
+static void fec_enet_deinit(struct net_device *ndev)
+{
+	struct fec_enet_private *fep = netdev_priv(ndev);
+
+	netif_napi_del(&fep->napi);
+	fec_enet_free_queue(ndev);
+}
+
 #ifdef CONFIG_OF
 static int fec_reset_phy(struct platform_device *pdev)
 {
@@ -4023,6 +4031,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_deinit(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
@@ -4085,6 +4094,7 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	fec_enet_deinit(ndev);
 	free_netdev(ndev);
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index c5ae67300590..780fbb3e1ed0 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -103,14 +103,13 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	u64 ns;
 	val = 0;
 
-	if (fep->pps_enable == enable)
-		return 0;
-
-	fep->pps_channel = DEFAULT_PPS_CHANNEL;
-	fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
-
 	spin_lock_irqsave(&fep->tmreg_lock, flags);
 
+	if (fep->pps_enable == enable) {
+		spin_unlock_irqrestore(&fep->tmreg_lock, flags);
+		return 0;
+	}
+
 	if (enable) {
 		/* clear capture or output compare interrupt status if have.
 		 */
@@ -441,6 +440,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	int ret = 0;
 
 	if (rq->type == PTP_CLK_REQ_PPS) {
+		fep->pps_channel = DEFAULT_PPS_CHANNEL;
+		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
+
 		ret = fec_ptp_enable_pps(fep, on);
 
 		return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 60f73e775bee..2440c82ea1fa 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3394,7 +3394,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
 	bool locked = false;
-	u32 curr_combined;
 	int ret = 0;
 
 	/* do not support changing channels in Safe Mode */
@@ -3411,22 +3410,8 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 		return -EOPNOTSUPP;
 	}
 
-	curr_combined = ice_get_combined_cnt(vsi);
-
-	/* these checks are for cases where user didn't specify a particular
-	 * value on cmd line but we get non-zero value anyway via
-	 * get_channels(); look at ethtool.c in ethtool repository (the user
-	 * space part), particularly, do_schannels() routine
-	 */
-	if (ch->rx_count == vsi->num_rxq - curr_combined)
-		ch->rx_count = 0;
-	if (ch->tx_count == vsi->num_txq - curr_combined)
-		ch->tx_count = 0;
-	if (ch->combined_count == curr_combined)
-		ch->combined_count = 0;
-
-	if (!(ch->combined_count || (ch->rx_count && ch->tx_count))) {
-		netdev_err(dev, "Please specify at least 1 Rx and 1 Tx channel\n");
+	if (ch->rx_count && ch->tx_count) {
+		netdev_err(dev, "Dedicated RX or TX channels cannot be used simultaneously\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 8d5dd8aba8cd..81e517dbe60e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -1535,6 +1535,9 @@ static int cmd_comp_notifier(struct notifier_block *nb,
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
 	eqe = data;
 
+	if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		return NOTIFY_DONE;
+
 	mlx5_cmd_comp_handler(dev, be32_to_cpu(eqe->data.cmd.vector), false);
 
 	return NOTIFY_OK;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 428881e0adcb..6621f6cd4315 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -105,18 +105,11 @@ mlx5e_ipsec_feature_check(struct sk_buff *skb, netdev_features_t features)
 		if (!x || !x->xso.offload_handle)
 			goto out_disable;
 
-		if (xo->inner_ipproto) {
-			/* Cannot support tunnel packet over IPsec tunnel mode
-			 * because we cannot offload three IP header csum
-			 */
-			if (x->props.mode == XFRM_MODE_TUNNEL)
-				goto out_disable;
-
-			/* Only support UDP or TCP L4 checksum */
-			if (xo->inner_ipproto != IPPROTO_UDP &&
-			    xo->inner_ipproto != IPPROTO_TCP)
-				goto out_disable;
-		}
+		/* Only support UDP or TCP L4 checksum */
+		if (xo->inner_ipproto &&
+		    xo->inner_ipproto != IPPROTO_UDP &&
+		    xo->inner_ipproto != IPPROTO_TCP)
+			goto out_disable;
 
 		return features;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 923be5fb7d21..79d687c663d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3185,7 +3185,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_dropped = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 6e902d57c793..99a6d11fec62 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1238,7 +1238,6 @@ static void qed_slowpath_task(struct work_struct *work)
 static int qed_slowpath_wq_start(struct qed_dev *cdev)
 {
 	struct qed_hwfn *hwfn;
-	char name[NAME_SIZE];
 	int i;
 
 	if (IS_VF(cdev))
@@ -1247,11 +1246,11 @@ static int qed_slowpath_wq_start(struct qed_dev *cdev)
 	for_each_hwfn(cdev, i) {
 		hwfn = &cdev->hwfns[i];
 
-		snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
-			 cdev->pdev->bus->number,
-			 PCI_SLOT(cdev->pdev->devfn), hwfn->abs_pf_id);
+		hwfn->slowpath_wq = alloc_workqueue("slowpath-%02x:%02x.%02x",
+					 0, 0, cdev->pdev->bus->number,
+					 PCI_SLOT(cdev->pdev->devfn),
+					 hwfn->abs_pf_id);
 
-		hwfn->slowpath_wq = alloc_workqueue(name, 0, 0);
 		if (!hwfn->slowpath_wq) {
 			DP_NOTICE(hwfn, "Cannot create slowpath workqueue\n");
 			return -ENOMEM;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 623286f22105..76d820c4e6ee 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4273,11 +4273,11 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
 static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 				      struct net_device *dev)
 {
-	unsigned int frags = skb_shinfo(skb)->nr_frags;
 	struct rtl8169_private *tp = netdev_priv(dev);
 	unsigned int entry = tp->cur_tx % NUM_TX_DESC;
 	struct TxDesc *txd_first, *txd_last;
 	bool stop_queue, door_bell;
+	unsigned int frags;
 	u32 opts[2];
 
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
@@ -4300,6 +4300,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 
 	txd_first = tp->TxDescArray + entry;
 
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;
@@ -4617,10 +4618,8 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 	}
 
-	if (napi_schedule_prep(&tp->napi)) {
-		rtl_irq_disable(tp);
-		__napi_schedule(&tp->napi);
-	}
+	rtl_irq_disable(tp);
+	napi_schedule(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
index 387539a8094b..95e9204ce827 100644
--- a/drivers/net/ethernet/smsc/smc91x.h
+++ b/drivers/net/ethernet/smsc/smc91x.h
@@ -175,8 +175,8 @@ static inline void mcf_outsw(void *a, unsigned char *p, int l)
 		writew(*wp++, a);
 }
 
-#define SMC_inw(a, r)		_swapw(readw((a) + (r)))
-#define SMC_outw(lp, v, a, r)	writew(_swapw(v), (a) + (r))
+#define SMC_inw(a, r)		ioread16be((a) + (r))
+#define SMC_outw(lp, v, a, r)	iowrite16be(v, (a) + (r))
 #define SMC_insw(a, r, p, l)	mcf_insw(a + r, p, l)
 #define SMC_outsw(a, r, p, l)	mcf_outsw(a + r, p, l)
 
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index d72018a60c0f..e14c1ac767ba 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -949,17 +949,6 @@ static irqreturn_t gem_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-static void gem_poll_controller(struct net_device *dev)
-{
-	struct gem *gp = netdev_priv(dev);
-
-	disable_irq(gp->pdev->irq);
-	gem_interrupt(gp->pdev->irq, dev);
-	enable_irq(gp->pdev->irq);
-}
-#endif
-
 static void gem_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct gem *gp = netdev_priv(dev);
@@ -2836,9 +2825,6 @@ static const struct net_device_ops gem_netdev_ops = {
 	.ndo_change_mtu		= gem_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = gem_set_mac_address,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller    = gem_poll_controller,
-#endif
 };
 
 static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 5aa9217240d5..a18b49db38ee 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -440,7 +440,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
-	err = ip_local_out(net, skb->sk, skb);
+	err = ip_local_out(net, NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
@@ -495,7 +495,7 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
-	err = ip6_local_out(dev_net(dev), skb->sk, skb);
+	err = ip6_local_out(dev_net(dev), NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index dc209ad8a0fe..59d05a1672ec 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -1669,6 +1669,7 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	/* PHY_BASIC_FEATURES */
 	.config_init	= ksz8061_config_init,
+	.soft_reset	= genphy_soft_reset,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= genphy_suspend,
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 6db37eb6c5cc..4b48a5c09bd4 100644
--- a/drivers/net/usb/aqc111.c
+++ b/drivers/net/usb/aqc111.c
@@ -1141,17 +1141,15 @@ static int aqc111_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			continue;
 		}
 
-		/* Clone SKB */
-		new_skb = skb_clone(skb, GFP_ATOMIC);
+		new_skb = netdev_alloc_skb_ip_align(dev->net, pkt_len);
 
 		if (!new_skb)
 			goto err;
 
-		new_skb->len = pkt_len;
+		skb_put(new_skb, pkt_len);
+		memcpy(new_skb->data, skb->data, pkt_len);
 		skb_pull(new_skb, AQ_RX_HW_PAD);
-		skb_set_tail_pointer(new_skb, new_skb->len);
 
-		new_skb->truesize = SKB_TRUESIZE(new_skb->len);
 		if (aqc111_data->rx_checksum)
 			aqc111_rx_checksum(new_skb, pkt_desc);
 
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 89e1fac07a25..9bd145732e58 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1362,6 +1362,9 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a9, 0)}, /* Telit FN920C04 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1100, 3)},	/* Telit ME910 */
 	{QMI_FIXED_INTF(0x1bc7, 0x1101, 3)},	/* Telit ME910 dual modem */
 	{QMI_FIXED_INTF(0x1bc7, 0x1200, 5)},	/* Telit LE920 */
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 5f962f58ff49..8a38939dd57e 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -842,7 +842,7 @@ static int smsc95xx_start_rx_path(struct usbnet *dev, int in_pm)
 static int smsc95xx_reset(struct usbnet *dev)
 {
 	struct smsc95xx_priv *pdata = dev->driver_priv;
-	u32 read_buf, write_buf, burst_cap;
+	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
 	netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
@@ -984,10 +984,13 @@ static int smsc95xx_reset(struct usbnet *dev)
 		return ret;
 	netif_dbg(dev, ifup, dev->net, "ID_REV = 0x%08x\n", read_buf);
 
+	ret = smsc95xx_read_reg(dev, LED_GPIO_CFG, &read_buf);
+	if (ret < 0)
+		return ret;
 	/* Configure GPIO pins as LED outputs */
-	write_buf = LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
-		LED_GPIO_CFG_FDX_LED;
-	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, write_buf);
+	read_buf |= LED_GPIO_CFG_SPD_LED | LED_GPIO_CFG_LNK_LED |
+		    LED_GPIO_CFG_FDX_LED;
+	ret = smsc95xx_write_reg(dev, LED_GPIO_CFG, read_buf);
 	if (ret < 0)
 		return ret;
 
@@ -1785,9 +1788,11 @@ static int smsc95xx_reset_resume(struct usb_interface *intf)
 
 static void smsc95xx_rx_csum_offload(struct sk_buff *skb)
 {
-	skb->csum = *(u16 *)(skb_tail_pointer(skb) - 2);
+	u16 *csum_ptr = (u16 *)(skb_tail_pointer(skb) - 2);
+
+	skb->csum = (__force __wsum)get_unaligned(csum_ptr);
 	skb->ip_summed = CHECKSUM_COMPLETE;
-	skb_trim(skb, skb->len - 2);
+	skb_trim(skb, skb->len - 2); /* remove csum */
 }
 
 static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
@@ -1845,25 +1850,22 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 				if (dev->net->features & NETIF_F_RXCSUM)
 					smsc95xx_rx_csum_offload(skb);
 				skb_trim(skb, skb->len - 4); /* remove fcs */
-				skb->truesize = size + sizeof(struct sk_buff);
 
 				return 1;
 			}
 
-			ax_skb = skb_clone(skb, GFP_ATOMIC);
+			ax_skb = netdev_alloc_skb_ip_align(dev->net, size);
 			if (unlikely(!ax_skb)) {
 				netdev_warn(dev->net, "Error allocating skb\n");
 				return 0;
 			}
 
-			ax_skb->len = size;
-			ax_skb->data = packet;
-			skb_set_tail_pointer(ax_skb, size);
+			skb_put(ax_skb, size);
+			memcpy(ax_skb->data, packet, size);
 
 			if (dev->net->features & NETIF_F_RXCSUM)
 				smsc95xx_rx_csum_offload(ax_skb);
 			skb_trim(ax_skb, ax_skb->len - 4); /* remove fcs */
-			ax_skb->truesize = size + sizeof(struct sk_buff);
 
 			usbnet_skb_return(dev, ax_skb);
 		}
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 279a540aef10..1c4a4bd46be6 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -419,19 +419,15 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			skb_pull(skb, 3);
 			skb->len = len;
 			skb_set_tail_pointer(skb, len);
-			skb->truesize = len + sizeof(struct sk_buff);
 			return 2;
 		}
 
-		/* skb_clone is used for address align */
-		sr_skb = skb_clone(skb, GFP_ATOMIC);
+		sr_skb = netdev_alloc_skb_ip_align(dev->net, len);
 		if (!sr_skb)
 			return 0;
 
-		sr_skb->len = len;
-		sr_skb->data = skb->data + 3;
-		skb_set_tail_pointer(sr_skb, len);
-		sr_skb->truesize = len + sizeof(struct sk_buff);
+		skb_put(sr_skb, len);
+		memcpy(sr_skb->data, skb->data + 3, len);
 		usbnet_skb_return(dev, sr_skb);
 
 		skb_pull(skb, len + SR_RX_OVERHEAD);
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 2e61041a1113..41b1b23fdd3e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1779,10 +1779,6 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
 	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
 		return false;
 
-	/* Ignore packets from invalid src-address */
-	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
-		return false;
-
 	/* Get address from the outer IP header */
 	if (vxlan_get_sk_family(vs) == AF_INET) {
 		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index efe38b2c1df7..71c2bf8817dc 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1590,6 +1590,20 @@ static int ar5523_probe(struct usb_interface *intf,
 	struct ar5523 *ar;
 	int error = -ENOMEM;
 
+	static const u8 bulk_ep_addr[] = {
+		AR5523_CMD_TX_PIPE | USB_DIR_OUT,
+		AR5523_DATA_TX_PIPE | USB_DIR_OUT,
+		AR5523_CMD_RX_PIPE | USB_DIR_IN,
+		AR5523_DATA_RX_PIPE | USB_DIR_IN,
+		0};
+
+	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr)) {
+		dev_err(&dev->dev,
+			"Could not find all expected endpoints\n");
+		error = -ENODEV;
+		goto out;
+	}
+
 	/*
 	 * Load firmware if the device requires it.  This will return
 	 * -ENXIO on success and we'll get called back afer the usb
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index eca24a61165e..4a93c415db07 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -640,6 +640,9 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.max_spatial_stream = 4,
 		.fw = {
 			.dir = WCN3990_HW_1_0_FW_DIR,
+			.board = WCN3990_HW_1_0_BOARD_DATA_FILE,
+			.board_size = WCN3990_BOARD_DATA_SZ,
+			.board_ext_size = WCN3990_BOARD_EXT_DATA_SZ,
 		},
 		.sw_decrypt_mcast_mgmt = true,
 		.hw_ops = &wcn3990_ops,
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 367539f2c370..f7912c72cba3 100644
--- a/drivers/net/wireless/ath/ath10k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
@@ -438,7 +438,7 @@ ath10k_dbg_sta_write_peer_debug_trigger(struct file *file,
 	}
 out:
 	mutex_unlock(&ar->conf_mutex);
-	return count;
+	return ret ?: count;
 }
 
 static const struct file_operations fops_peer_debug_trigger = {
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 591ef7416b61..0d8c8e948bb5 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -132,6 +132,7 @@ enum qca9377_chip_id_rev {
 /* WCN3990 1.0 definitions */
 #define WCN3990_HW_1_0_DEV_VERSION	ATH10K_HW_WCN3990
 #define WCN3990_HW_1_0_FW_DIR		ATH10K_FW_DIR "/WCN3990/hw1.0"
+#define WCN3990_HW_1_0_BOARD_DATA_FILE "board.bin"
 
 #define ATH10K_FW_FILE_BASE		"firmware"
 #define ATH10K_FW_API_MAX		6
diff --git a/drivers/net/wireless/ath/ath10k/targaddrs.h b/drivers/net/wireless/ath/ath10k/targaddrs.h
index ec556bb88d65..ba37e6c7ced0 100644
--- a/drivers/net/wireless/ath/ath10k/targaddrs.h
+++ b/drivers/net/wireless/ath/ath10k/targaddrs.h
@@ -491,4 +491,7 @@ struct host_interest {
 #define QCA4019_BOARD_DATA_SZ	  12064
 #define QCA4019_BOARD_EXT_DATA_SZ 0
 
+#define WCN3990_BOARD_DATA_SZ	  26328
+#define WCN3990_BOARD_EXT_DATA_SZ 0
+
 #endif /* __TARGADDRS_H__ */
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 7c1c2658cb5f..c8ccea542fec 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1762,12 +1762,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
-	unsigned long time_left;
+	unsigned long time_left, i;
 
 	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
 						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left)
-		return -ETIMEDOUT;
+	if (!time_left) {
+		/* Sometimes the PCI HIF doesn't receive interrupt
+		 * for the service ready message even if the buffer
+		 * was completed. PCIe sniffer shows that it's
+		 * because the corresponding CE ring doesn't fires
+		 * it. Workaround here by polling CE rings once.
+		 */
+		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
+
+		for (i = 0; i < CE_COUNT; i++)
+			ath10k_hif_send_complete_check(ar, i, 1);
+
+		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
+							WMI_SERVICE_READY_TIMEOUT_HZ);
+		if (!time_left) {
+			ath10k_warn(ar, "polling timed out\n");
+			return -ETIMEDOUT;
+		}
+
+		ath10k_warn(ar, "service ready completion received, continuing normally\n");
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/carl9170/usb.c b/drivers/net/wireless/ath/carl9170/usb.c
index e4eb666c6eea..a5265997b576 100644
--- a/drivers/net/wireless/ath/carl9170/usb.c
+++ b/drivers/net/wireless/ath/carl9170/usb.c
@@ -1069,6 +1069,38 @@ static int carl9170_usb_probe(struct usb_interface *intf,
 			ar->usb_ep_cmd_is_bulk = true;
 	}
 
+	/* Verify that all expected endpoints are present */
+	if (ar->usb_ep_cmd_is_bulk) {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	} else {
+		u8 bulk_ep_addr[] = {
+			AR9170_USB_EP_RX | USB_DIR_IN,
+			AR9170_USB_EP_TX | USB_DIR_OUT,
+			0};
+		u8 int_ep_addr[] = {
+			AR9170_USB_EP_IRQ | USB_DIR_IN,
+			AR9170_USB_EP_CMD | USB_DIR_OUT,
+			0};
+		if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
+		    !usb_check_int_endpoints(intf, int_ep_addr))
+			err = -ENODEV;
+	}
+
+	if (err) {
+		carl9170_free(ar);
+		return err;
+	}
+
 	usb_set_intfdata(intf, ar);
 	SET_IEEE80211_DEV(ar->hw, &intf->dev);
 
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 529e325498cd..ad9678186c58 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -2718,7 +2718,7 @@ __mwl8k_cmd_mac_multicast_adr(struct ieee80211_hw *hw, int allmulti,
 		cmd->action |= cpu_to_le16(MWL8K_ENABLE_RX_MULTICAST);
 		cmd->numaddr = cpu_to_le16(mc_count);
 		netdev_hw_addr_list_for_each(ha, mc_list) {
-			memcpy(cmd->addr[i], ha->addr, ETH_ALEN);
+			memcpy(cmd->addr[i++], ha->addr, ETH_ALEN);
 		}
 	}
 
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 3536b9f8470f..b042dff4ac93 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -28,6 +28,7 @@
 #include <linux/wireless.h>
 #include <linux/firmware.h>
 #include <linux/moduleparam.h>
+#include <linux/bitfield.h>
 #include <net/mac80211.h>
 #include "rtl8xxxu.h"
 #include "rtl8xxxu_regs.h"
@@ -1389,13 +1390,13 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 	u8 cck[RTL8723A_MAX_RF_PATHS], ofdm[RTL8723A_MAX_RF_PATHS];
 	u8 ofdmbase[RTL8723A_MAX_RF_PATHS], mcsbase[RTL8723A_MAX_RF_PATHS];
 	u32 val32, ofdm_a, ofdm_b, mcs_a, mcs_b;
-	u8 val8;
+	u8 val8, base;
 	int group, i;
 
 	group = rtl8xxxu_gen1_channel_to_group(channel);
 
-	cck[0] = priv->cck_tx_power_index_A[group] - 1;
-	cck[1] = priv->cck_tx_power_index_B[group] - 1;
+	cck[0] = priv->cck_tx_power_index_A[group];
+	cck[1] = priv->cck_tx_power_index_B[group];
 
 	if (priv->hi_pa) {
 		if (cck[0] > 0x20)
@@ -1406,10 +1407,6 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	ofdm[0] = priv->ht40_1s_tx_power_index_A[group];
 	ofdm[1] = priv->ht40_1s_tx_power_index_B[group];
-	if (ofdm[0])
-		ofdm[0] -= 1;
-	if (ofdm[1])
-		ofdm[1] -= 1;
 
 	ofdmbase[0] = ofdm[0] +	priv->ofdm_tx_power_index_diff[group].a;
 	ofdmbase[1] = ofdm[1] +	priv->ofdm_tx_power_index_diff[group].b;
@@ -1498,20 +1495,19 @@ rtl8xxxu_gen1_set_tx_power(struct rtl8xxxu_priv *priv, int channel, bool ht40)
 
 	rtl8xxxu_write32(priv, REG_TX_AGC_A_MCS15_MCS12,
 			 mcs_a + power_base->reg_0e1c);
+	val8 = u32_get_bits(mcs_a + power_base->reg_0e1c, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[0] > 8) ? (mcsbase[0] - 8) : 0;
-		else
-			val8 = (mcsbase[0] > 6) ? (mcsbase[0] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XC_TX_IQ_IMBALANCE + i, val8);
 	}
+
 	rtl8xxxu_write32(priv, REG_TX_AGC_B_MCS15_MCS12,
 			 mcs_b + power_base->reg_0868);
+	val8 = u32_get_bits(mcs_b + power_base->reg_0868, 0xff000000);
 	for (i = 0; i < 3; i++) {
-		if (i != 2)
-			val8 = (mcsbase[1] > 8) ? (mcsbase[1] - 8) : 0;
-		else
-			val8 = (mcsbase[1] > 6) ? (mcsbase[1] - 6) : 0;
+		base = i != 2 ? 8 : 6;
+		val8 = max_t(int, val8 - base, 0);
 		rtl8xxxu_write8(priv, REG_OFDM0_XD_TX_IQ_IMBALANCE + i, val8);
 	}
 }
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
index c02813fba934..0358e56d012f 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.c
@@ -35,7 +35,7 @@ static long _rtl92de_translate_todbm(struct ieee80211_hw *hw,
 
 static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 				       struct rtl_stats *pstats,
-				       struct rx_desc_92d *pdesc,
+				       __le32 *pdesc,
 				       struct rx_fwinfo_92d *p_drvinfo,
 				       bool packet_match_bssid,
 				       bool packet_toself,
@@ -49,8 +49,10 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 	u8 i, max_spatial_stream;
 	u32 rssi, total_rssi = 0;
 	bool is_cck_rate;
+	u8 rxmcs;
 
-	is_cck_rate = RX_HAL_IS_CCK_RATE(pdesc->rxmcs);
+	rxmcs = get_rx_desc_rxmcs(pdesc);
+	is_cck_rate = rxmcs <= DESC_RATE11M;
 	pstats->packet_matchbssid = packet_match_bssid;
 	pstats->packet_toself = packet_toself;
 	pstats->packet_beacon = packet_beacon;
@@ -158,8 +160,8 @@ static void _rtl92de_query_rxphystatus(struct ieee80211_hw *hw,
 		pstats->rx_pwdb_all = pwdb_all;
 		pstats->rxpower = rx_pwr_all;
 		pstats->recvsignalpower = rx_pwr_all;
-		if (pdesc->rxht && pdesc->rxmcs >= DESC_RATEMCS8 &&
-		    pdesc->rxmcs <= DESC_RATEMCS15)
+		if (get_rx_desc_rxht(pdesc) && rxmcs >= DESC_RATEMCS8 &&
+		    rxmcs <= DESC_RATEMCS15)
 			max_spatial_stream = 2;
 		else
 			max_spatial_stream = 1;
@@ -365,7 +367,7 @@ static void _rtl92de_process_phyinfo(struct ieee80211_hw *hw,
 static void _rtl92de_translate_rx_signal_stuff(struct ieee80211_hw *hw,
 					       struct sk_buff *skb,
 					       struct rtl_stats *pstats,
-					       struct rx_desc_92d *pdesc,
+					       __le32 *pdesc,
 					       struct rx_fwinfo_92d *p_drvinfo)
 {
 	struct rtl_mac *mac = rtl_mac(rtl_priv(hw));
@@ -414,7 +416,8 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	stats->icv = (u16)get_rx_desc_icv(pdesc);
 	stats->crc = (u16)get_rx_desc_crc32(pdesc);
 	stats->hwerror = (stats->crc | stats->icv);
-	stats->decrypted = !get_rx_desc_swdec(pdesc);
+	stats->decrypted = !get_rx_desc_swdec(pdesc) &&
+			   get_rx_desc_enc_type(pdesc) != RX_DESC_ENC_NONE;
 	stats->rate = (u8)get_rx_desc_rxmcs(pdesc);
 	stats->shortpreamble = (u16)get_rx_desc_splcp(pdesc);
 	stats->isampdu = (bool)(get_rx_desc_paggr(pdesc) == 1);
@@ -427,8 +430,6 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	rx_status->band = hw->conf.chandef.chan->band;
 	if (get_rx_desc_crc32(pdesc))
 		rx_status->flag |= RX_FLAG_FAILED_FCS_CRC;
-	if (!get_rx_desc_swdec(pdesc))
-		rx_status->flag |= RX_FLAG_DECRYPTED;
 	if (get_rx_desc_bw(pdesc))
 		rx_status->bw = RATE_INFO_BW_40;
 	if (get_rx_desc_rxht(pdesc))
@@ -442,9 +443,7 @@ bool rtl92de_rx_query_desc(struct ieee80211_hw *hw,	struct rtl_stats *stats,
 	if (phystatus) {
 		p_drvinfo = (struct rx_fwinfo_92d *)(skb->data +
 						     stats->rx_bufshift);
-		_rtl92de_translate_rx_signal_stuff(hw,
-						   skb, stats,
-						   (struct rx_desc_92d *)pdesc,
+		_rtl92de_translate_rx_signal_stuff(hw, skb, stats, pdesc,
 						   p_drvinfo);
 	}
 	/*rx_status->qual = stats->signal; */
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
index d01578875cd5..eb3f768140b5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192de/trx.h
@@ -14,6 +14,15 @@
 #define USB_HWDESC_HEADER_LEN			32
 #define CRCLENGTH				4
 
+enum rtl92d_rx_desc_enc {
+	RX_DESC_ENC_NONE	= 0,
+	RX_DESC_ENC_WEP40	= 1,
+	RX_DESC_ENC_TKIP_WO_MIC	= 2,
+	RX_DESC_ENC_TKIP_MIC	= 3,
+	RX_DESC_ENC_AES		= 4,
+	RX_DESC_ENC_WEP104	= 5,
+};
+
 /* macros to read/write various fields in RX or TX descriptors */
 
 static inline void set_tx_desc_pkt_size(__le32 *__pdesc, u32 __val)
@@ -246,6 +255,11 @@ static inline u32 get_rx_desc_drv_info_size(__le32 *__pdesc)
 	return le32_get_bits(*__pdesc, GENMASK(19, 16));
 }
 
+static inline u32 get_rx_desc_enc_type(__le32 *__pdesc)
+{
+	return le32_get_bits(*__pdesc, GENMASK(22, 20));
+}
+
 static inline u32 get_rx_desc_shift(__le32 *__pdesc)
 {
 	return le32_get_bits(*__pdesc, GENMASK(25, 24));
@@ -380,10 +394,17 @@ struct rx_fwinfo_92d {
 	u8 csi_target[2];
 	u8 sigevm;
 	u8 max_ex_pwr;
+#ifdef __LITTLE_ENDIAN
 	u8 ex_intf_flag:1;
 	u8 sgi_en:1;
 	u8 rxsc:2;
 	u8 reserve:4;
+#else
+	u8 reserve:4;
+	u8 rxsc:2;
+	u8 sgi_en:1;
+	u8 ex_intf_flag:1;
+#endif
 } __packed;
 
 struct tx_desc_92d {
@@ -488,64 +509,6 @@ struct tx_desc_92d {
 	u32 reserve_pass_pcie_mm_limit[4];
 } __packed;
 
-struct rx_desc_92d {
-	u32 length:14;
-	u32 crc32:1;
-	u32 icverror:1;
-	u32 drv_infosize:4;
-	u32 security:3;
-	u32 qos:1;
-	u32 shift:2;
-	u32 phystatus:1;
-	u32 swdec:1;
-	u32 lastseg:1;
-	u32 firstseg:1;
-	u32 eor:1;
-	u32 own:1;
-
-	u32 macid:5;
-	u32 tid:4;
-	u32 hwrsvd:5;
-	u32 paggr:1;
-	u32 faggr:1;
-	u32 a1_fit:4;
-	u32 a2_fit:4;
-	u32 pam:1;
-	u32 pwr:1;
-	u32 moredata:1;
-	u32 morefrag:1;
-	u32 type:2;
-	u32 mc:1;
-	u32 bc:1;
-
-	u32 seq:12;
-	u32 frag:4;
-	u32 nextpktlen:14;
-	u32 nextind:1;
-	u32 rsvd:1;
-
-	u32 rxmcs:6;
-	u32 rxht:1;
-	u32 amsdu:1;
-	u32 splcp:1;
-	u32 bandwidth:1;
-	u32 htc:1;
-	u32 tcpchk_rpt:1;
-	u32 ipcchk_rpt:1;
-	u32 tcpchk_valid:1;
-	u32 hwpcerr:1;
-	u32 hwpcind:1;
-	u32 iv0:16;
-
-	u32 iv1;
-
-	u32 tsfl;
-
-	u32 bufferaddress;
-	u32 bufferaddress64;
-
-} __packed;
-
 void rtl92de_tx_fill_desc(struct ieee80211_hw *hw,
 			  struct ieee80211_hdr *hdr, u8 *pdesc,
 			  u8 *pbd_desc_tx, struct ieee80211_tx_info *info,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 73eddb67f0d2..f8ad43b5f069 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -190,7 +190,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
+		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
 		else
 			distance = LOCAL_DISTANCE;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 5bdc3ba51f7e..a3d3a1bfd292 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -530,10 +530,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	if (strtobool(page, &enable))
 		return -EINVAL;
 
+	/*
+	 * take a global nvmet_config_sem because the disable routine has a
+	 * window where it releases the subsys-lock, giving a chance to
+	 * a parallel enable to concurrently execute causing the disable to
+	 * have a misaccounting of the ns percpu_ref.
+	 */
+	down_write(&nvmet_config_sem);
 	if (enable)
 		ret = nvmet_ns_enable(ns);
 	else
 		nvmet_ns_disable(ns);
+	up_write(&nvmet_config_sem);
 
 	return ret ? ret : count;
 }
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 2f82da76e371..3703ea0d90c2 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2142,10 +2142,13 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = tegra_pcie_config_ep(pcie, pdev);
 		if (ret < 0)
 			goto fail;
+		else
+			return 0;
 		break;
 
 	default:
 		dev_err(dev, "Invalid PCIe device type %d\n", pcie->mode);
+		ret = -EINVAL;
 	}
 
 fail:
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 87734e4c3c20..35210007602c 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -32,10 +32,10 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	int status = 0;
 
 	/*
-	 * Behavior when calling unsupported _DSM functions is undefined,
-	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
+	 * Per PCI Firmware r3.3, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
+	 * optional. Return success if it's not implemented.
 	 */
-	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
 			    1ULL << EDR_PORT_DPC_ENABLE_DSM))
 		return 0;
 
@@ -46,12 +46,7 @@ static int acpi_enable_dpc(struct pci_dev *pdev)
 	argv4.package.count = 1;
 	argv4.package.elements = &req;
 
-	/*
-	 * Per Downstream Port Containment Related Enhancements ECN to PCI
-	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
-	 * optional.  Return success if it's not implemented.
-	 */
-	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 6,
 				EDR_PORT_DPC_ENABLE_DSM, &argv4);
 	if (!obj)
 		return 0;
@@ -85,8 +80,9 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 	u16 port;
 
 	/*
-	 * Behavior when calling unsupported _DSM functions is undefined,
-	 * so check whether EDR_PORT_DPC_ENABLE_DSM is supported.
+	 * If EDR_PORT_LOCATE_DSM is not implemented under the target of
+	 * EDR, the target is the port that experienced the containment
+	 * event (PCI Firmware r3.3, sec 4.6.13).
 	 */
 	if (!acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
 			    1ULL << EDR_PORT_LOCATE_DSM))
@@ -103,6 +99,16 @@ static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
 		return NULL;
 	}
 
+	/*
+	 * Bit 31 represents the success/failure of the operation. If bit
+	 * 31 is set, the operation failed.
+	 */
+	if (obj->integer.value & BIT(31)) {
+		ACPI_FREE(obj);
+		pci_err(pdev, "Locate Port _DSM failed\n");
+		return NULL;
+	}
+
 	/*
 	 * Firmware returns DPC port BDF details in following format:
 	 *	15:8 = bus
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 0a7920cbd494..a0467f0b549c 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -571,6 +571,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sti_pwm_compat_data *cdata;
+	struct pwm_chip *chip;
 	struct sti_pwm_chip *pc;
 	unsigned int i;
 	int irq, ret;
@@ -578,6 +579,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
 		return -ENOMEM;
+	chip = &pc->chip;
 
 	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
 	if (!cdata)
@@ -623,40 +625,28 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	if (cdata->pwm_num_devs) {
-		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+		pc->pwm_clk = devm_clk_get_prepared(dev, "pwm");
 		if (IS_ERR(pc->pwm_clk)) {
 			dev_err(dev, "failed to get PWM clock\n");
 			return PTR_ERR(pc->pwm_clk);
 		}
-
-		ret = clk_prepare(pc->pwm_clk);
-		if (ret) {
-			dev_err(dev, "failed to prepare clock\n");
-			return ret;
-		}
 	}
 
 	if (cdata->cpt_num_devs) {
-		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+		pc->cpt_clk = devm_clk_get_prepared(dev, "capture");
 		if (IS_ERR(pc->cpt_clk)) {
 			dev_err(dev, "failed to get PWM capture clock\n");
 			return PTR_ERR(pc->cpt_clk);
 		}
 
-		ret = clk_prepare(pc->cpt_clk);
-		if (ret) {
-			dev_err(dev, "failed to prepare clock\n");
-			return ret;
-		}
-
 		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
 		if (!cdata->ddata)
 			return -ENOMEM;
 	}
 
-	pc->chip.dev = dev;
-	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
+	chip->dev = dev;
+	chip->ops = &sti_pwm_ops;
+	chip->npwm = max(cdata->pwm_num_devs, cdata->cpt_num_devs);
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
 		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
@@ -665,28 +655,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		mutex_init(&ddata->lock);
 	}
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, pc);
-
-	return 0;
-}
-
-static int sti_pwm_remove(struct platform_device *pdev)
-{
-	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&pc->chip);
-
-	clk_unprepare(pc->pwm_clk);
-	clk_unprepare(pc->cpt_clk);
-
-	return 0;
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct of_device_id sti_pwm_of_match[] = {
@@ -701,7 +670,6 @@ static struct platform_driver sti_pwm_driver = {
 		.of_match_table = sti_pwm_of_match,
 	},
 	.probe = sti_pwm_probe,
-	.remove = sti_pwm_remove,
 };
 module_platform_driver(sti_pwm_driver);
 
diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index a4f09a5a30ca..d07f0d120ca7 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -207,14 +207,11 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.suspend_reg = BD71828_REG_BUCK1_SUSP_VOLT,
 			.suspend_mask = BD71828_MASK_BUCK1267_VOLT,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
-			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
 			/*
 			 * LPSR voltage is same as SUSPEND voltage. Allow
-			 * setting it so that regulator can be set enabled at
-			 * LPSR state
+			 * only enabling/disabling regulator for LPSR state
 			 */
-			.lpsr_reg = BD71828_REG_BUCK1_SUSP_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK1267_VOLT,
+			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
 		},
 		.reg_inits = buck1_inits,
 		.reg_init_amnt = ARRAY_SIZE(buck1_inits),
@@ -289,13 +286,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_BUCK3_VOLT,
-			.idle_reg = BD71828_REG_BUCK3_VOLT,
-			.suspend_reg = BD71828_REG_BUCK3_VOLT,
-			.lpsr_reg = BD71828_REG_BUCK3_VOLT,
 			.run_mask = BD71828_MASK_BUCK3_VOLT,
-			.idle_mask = BD71828_MASK_BUCK3_VOLT,
-			.suspend_mask = BD71828_MASK_BUCK3_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK3_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -330,13 +321,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_BUCK4_VOLT,
-			.idle_reg = BD71828_REG_BUCK4_VOLT,
-			.suspend_reg = BD71828_REG_BUCK4_VOLT,
-			.lpsr_reg = BD71828_REG_BUCK4_VOLT,
 			.run_mask = BD71828_MASK_BUCK4_VOLT,
-			.idle_mask = BD71828_MASK_BUCK4_VOLT,
-			.suspend_mask = BD71828_MASK_BUCK4_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK4_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -371,13 +356,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_BUCK5_VOLT,
-			.idle_reg = BD71828_REG_BUCK5_VOLT,
-			.suspend_reg = BD71828_REG_BUCK5_VOLT,
-			.lpsr_reg = BD71828_REG_BUCK5_VOLT,
 			.run_mask = BD71828_MASK_BUCK5_VOLT,
-			.idle_mask = BD71828_MASK_BUCK5_VOLT,
-			.suspend_mask = BD71828_MASK_BUCK5_VOLT,
-			.lpsr_mask = BD71828_MASK_BUCK5_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -494,13 +473,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO1_VOLT,
-			.idle_reg = BD71828_REG_LDO1_VOLT,
-			.suspend_reg = BD71828_REG_LDO1_VOLT,
-			.lpsr_reg = BD71828_REG_LDO1_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -534,13 +507,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO2_VOLT,
-			.idle_reg = BD71828_REG_LDO2_VOLT,
-			.suspend_reg = BD71828_REG_LDO2_VOLT,
-			.lpsr_reg = BD71828_REG_LDO2_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -574,13 +541,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO3_VOLT,
-			.idle_reg = BD71828_REG_LDO3_VOLT,
-			.suspend_reg = BD71828_REG_LDO3_VOLT,
-			.lpsr_reg = BD71828_REG_LDO3_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -615,13 +576,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO4_VOLT,
-			.idle_reg = BD71828_REG_LDO4_VOLT,
-			.suspend_reg = BD71828_REG_LDO4_VOLT,
-			.lpsr_reg = BD71828_REG_LDO4_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -656,13 +611,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 				     ROHM_DVS_LEVEL_SUSPEND |
 				     ROHM_DVS_LEVEL_LPSR,
 			.run_reg = BD71828_REG_LDO5_VOLT,
-			.idle_reg = BD71828_REG_LDO5_VOLT,
-			.suspend_reg = BD71828_REG_LDO5_VOLT,
-			.lpsr_reg = BD71828_REG_LDO5_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
@@ -721,9 +670,6 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.suspend_reg = BD71828_REG_LDO7_VOLT,
 			.lpsr_reg = BD71828_REG_LDO7_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
index 522764435575..a44a0b30a651 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -350,6 +350,9 @@ void *regulator_irq_helper(struct device *dev,
 
 	h->irq = irq;
 	h->desc = *d;
+	h->desc.name = devm_kstrdup(dev, d->name, GFP_KERNEL);
+	if (!h->desc.name)
+		return ERR_PTR(-ENOMEM);
 
 	ret = init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
 			      rdev_amount);
diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index 6d5ae25d08d1..e2a28788d8a2 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -86,6 +86,7 @@ static const struct of_device_id regulator_ipq4019_of_match[] = {
 	{ .compatible = "qcom,vqmmc-ipq4019-regulator", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, regulator_ipq4019_of_match);
 
 static struct platform_driver ipq4019_regulator_driver = {
 	.probe = ipq4019_regulator_probe,
diff --git a/drivers/s390/cio/trace.h b/drivers/s390/cio/trace.h
index 86993de25345..a4c5c6736b31 100644
--- a/drivers/s390/cio/trace.h
+++ b/drivers/s390/cio/trace.h
@@ -50,7 +50,7 @@ DECLARE_EVENT_CLASS(s390_class_schib,
 		__entry->devno = schib->pmcw.dev;
 		__entry->schib = *schib;
 		__entry->pmcw_ena = schib->pmcw.ena;
-		__entry->pmcw_st = schib->pmcw.ena;
+		__entry->pmcw_st = schib->pmcw.st;
 		__entry->pmcw_dnv = schib->pmcw.dnv;
 		__entry->pmcw_dev = schib->pmcw.dev;
 		__entry->pmcw_lpm = schib->pmcw.lpm;
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 4968964ac5de..1dd6dd2ed7fb 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1031,7 +1031,7 @@ static int hex2bitmap(const char *str, unsigned long *bitmap, int bits)
  */
 static int modify_bitmap(const char *str, unsigned long *bitmap, int bits)
 {
-	int a, i, z;
+	unsigned long a, i, z;
 	char *np, sign;
 
 	/* bits needs to be a multiple of 8 */
diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index fd1b378a263a..d3c7d4423c51 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -250,7 +250,7 @@ bfad_debugfs_write_regrd(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
@@ -317,7 +317,7 @@ bfad_debugfs_write_regwr(struct file *file, const char __user *buf,
 	unsigned long flags;
 	void *kern_buf;
 
-	kern_buf = memdup_user(buf, nbytes);
+	kern_buf = memdup_user_nul(buf, nbytes);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c
index 8aa5c22ae3ff..b54c8aa8e803 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5848,7 +5848,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
 
-	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info));
+	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info *));
 	if (sh == NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 9ae35631135d..ee6607dfcdfa 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -256,8 +256,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id, void *rsp)
 	/* help some expanders that fail to zero sas_address in the 'no
 	 * device' case
 	 */
-	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
-	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
+	if (phy->attached_dev_type == SAS_PHY_UNUSED)
 		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
 	else
 		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 451fd236bfd0..96174353e389 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -170,7 +170,7 @@ qedf_dbg_debug_cmd_write(struct file *filp, const char __user *buffer,
 	if (!count || *ppos)
 		return 0;
 
-	kern_buf = memdup_user(buffer, count);
+	kern_buf = memdup_user_nul(buffer, count);
 	if (IS_ERR(kern_buf))
 		return PTR_ERR(kern_buf);
 
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index af921fd150d1..73695c6815fa 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -274,7 +274,7 @@ qla_dfs_fw_resource_cnt_show(struct seq_file *s, void *unused)
 		seq_printf(s, "Driver: estimate iocb used [%d] high water limit [%d]\n",
 			   iocbs_used, ha->base_qpair->fwres.iocbs_limit);
 
-		seq_printf(s, "estimate exchange used[%d] high water limit [%d] n",
+		seq_printf(s, "estimate exchange used[%d] high water limit [%d]\n",
 			   exch_used, ha->base_qpair->fwres.exch_limit);
 
 		if (ql2xenforce_iocb_limit == 2) {
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 585df40e95bb..531e0ea87202 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5145,7 +5145,7 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES)
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 	} else {
@@ -5153,14 +5153,14 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES) {
-			strlcpy(ha->model_number,
+			strscpy(ha->model_number,
 				qla2x00_model_name[index * 2],
 				sizeof(ha->model_number));
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 		} else {
-			strlcpy(ha->model_number, def,
+			strscpy(ha->model_number, def,
 				sizeof(ha->model_number));
 		}
 	}
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index f726eb8449c5..083f94e43fba 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -691,7 +691,7 @@ qlafx00_pci_info_str(struct scsi_qla_host *vha, char *str, size_t str_len)
 	struct qla_hw_data *ha = vha->hw;
 
 	if (pci_is_pcie(ha->pdev))
-		strlcpy(str, "PCIe iSA", str_len);
+		strscpy(str, "PCIe iSA", str_len);
 	return str;
 }
 
@@ -1850,21 +1850,21 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 			phost_info = &preg_hsi->hsi;
 			memset(preg_hsi, 0, sizeof(struct register_host_info));
 			phost_info->os_type = OS_TYPE_LINUX;
-			strlcpy(phost_info->sysname, p_sysid->sysname,
+			strscpy(phost_info->sysname, p_sysid->sysname,
 				sizeof(phost_info->sysname));
-			strlcpy(phost_info->nodename, p_sysid->nodename,
+			strscpy(phost_info->nodename, p_sysid->nodename,
 				sizeof(phost_info->nodename));
 			if (!strcmp(phost_info->nodename, "(none)"))
 				ha->mr.host_info_resend = true;
-			strlcpy(phost_info->release, p_sysid->release,
+			strscpy(phost_info->release, p_sysid->release,
 				sizeof(phost_info->release));
-			strlcpy(phost_info->version, p_sysid->version,
+			strscpy(phost_info->version, p_sysid->version,
 				sizeof(phost_info->version));
-			strlcpy(phost_info->machine, p_sysid->machine,
+			strscpy(phost_info->machine, p_sysid->machine,
 				sizeof(phost_info->machine));
-			strlcpy(phost_info->domainname, p_sysid->domainname,
+			strscpy(phost_info->domainname, p_sysid->domainname,
 				sizeof(phost_info->domainname));
-			strlcpy(phost_info->hostdriver, QLA2XXX_VERSION,
+			strscpy(phost_info->hostdriver, QLA2XXX_VERSION,
 				sizeof(phost_info->hostdriver));
 			preg_hsi->utc = (uint64_t)ktime_get_real_seconds();
 			ql_dbg(ql_dbg_init, vha, 0x0149,
@@ -1909,9 +1909,9 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 	if (fx_type == FXDISC_GET_CONFIG_INFO) {
 		struct config_info_data *pinfo =
 		    (struct config_info_data *) fdisc->u.fxiocb.rsp_addr;
-		strlcpy(vha->hw->model_number, pinfo->model_num,
+		strscpy(vha->hw->model_number, pinfo->model_num,
 			ARRAY_SIZE(vha->hw->model_number));
-		strlcpy(vha->hw->model_desc, pinfo->model_description,
+		strscpy(vha->hw->model_desc, pinfo->model_description,
 			ARRAY_SIZE(vha->hw->model_desc));
 		memcpy(&vha->hw->mr.symbolic_name, pinfo->symbolic_name,
 		    sizeof(vha->hw->mr.symbolic_name));
diff --git a/drivers/scsi/ufs/cdns-pltfrm.c b/drivers/scsi/ufs/cdns-pltfrm.c
index 7da8be2f35c4..07a2580e4e56 100644
--- a/drivers/scsi/ufs/cdns-pltfrm.c
+++ b/drivers/scsi/ufs/cdns-pltfrm.c
@@ -136,7 +136,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 	 * Make sure the register was updated,
 	 * UniPro layer will not work with an incorrect value.
 	 */
-	mb();
+	ufshcd_readl(hba, CDNS_UFS_REG_HCLKDIV);
 
 	return 0;
 }
diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index f810b99ef5c5..77a11cba69fc 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -242,8 +242,9 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
 	ufshcd_rmwl(host->hba, QUNIPRO_SEL,
 		   ufs_qcom_cap_qunipro(host) ? QUNIPRO_SEL : 0,
 		   REG_UFS_CFG1);
-	/* make sure above configuration is applied before we return */
-	mb();
+
+	if (host->hw_ver.major >= 0x05)
+		ufshcd_rmwl(host->hba, QUNIPRO_G4_SEL, 0, REG_UFS_CFG0);
 }
 
 /*
@@ -352,7 +353,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
 		REG_UFS_CFG2);
 
 	/* Ensure that HW clock gating is enabled before next operations */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG2);
 }
 
 static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
@@ -449,7 +450,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		 * make sure above write gets applied before we return from
 		 * this function.
 		 */
-		mb();
+		ufshcd_readl(hba, REG_UFS_SYS1CLK_1US);
 	}
 
 	if (ufs_qcom_cap_qunipro(host))
@@ -515,9 +516,9 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		mb();
 	}
 
-	if (update_link_startup_timer) {
+	if (update_link_startup_timer && host->hw_ver.major != 0x5) {
 		ufshcd_writel(hba, ((core_clk_rate / MSEC_PER_SEC) * 100),
-			      REG_UFS_PA_LINK_STARTUP_TIMER);
+			      REG_UFS_CFG0);
 		/*
 		 * make sure that this configuration is applied before
 		 * we return
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index 8208e3a3ef59..6b4584893c30 100644
--- a/drivers/scsi/ufs/ufs-qcom.h
+++ b/drivers/scsi/ufs/ufs-qcom.h
@@ -35,8 +35,10 @@ enum {
 	REG_UFS_TX_SYMBOL_CLK_NS_US         = 0xC4,
 	REG_UFS_LOCAL_PORT_ID_REG           = 0xC8,
 	REG_UFS_PA_ERR_CODE                 = 0xCC,
-	REG_UFS_RETRY_TIMER_REG             = 0xD0,
-	REG_UFS_PA_LINK_STARTUP_TIMER       = 0xD8,
+	/* On older UFS revisions, this register is called "RETRY_TIMER_REG" */
+	REG_UFS_PARAM0                      = 0xD0,
+	/* On older UFS revisions, this register is called "REG_UFS_PA_LINK_STARTUP_TIMER" */
+	REG_UFS_CFG0                        = 0xD8,
 	REG_UFS_CFG1                        = 0xDC,
 	REG_UFS_CFG2                        = 0xE0,
 	REG_UFS_HW_VERSION                  = 0xE4,
@@ -74,6 +76,9 @@ enum {
 #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
 
+/* bit definitions for REG_UFS_CFG0 register */
+#define QUNIPRO_G4_SEL		BIT(5)
+
 /* bit definitions for REG_UFS_CFG1 register */
 #define QUNIPRO_SEL		0x1
 #define UTP_DBG_RAMS_EN		0x20000
@@ -145,10 +150,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
 			1 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
 
 	/*
-	 * Make sure assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
@@ -157,10 +162,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
 			0 << OFFSET_UFS_PHY_SOFT_RESET, REG_UFS_CFG1);
 
 	/*
-	 * Make sure de-assertion of ufs phy reset is written to
-	 * register before returning
+	 * Dummy read to ensure the write takes effect before doing any sort
+	 * of delay
 	 */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG1);
 }
 
 /* Host controller hardware version: major.minor.step */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 03b33c34f702..b7abf1f6410c 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3960,7 +3960,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		 * Make sure UIC command completion interrupt is disabled before
 		 * issuing UIC command.
 		 */
-		wmb();
+		ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 		reenable_intr = true;
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
@@ -9500,7 +9500,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	 * Make sure that UFS interrupts are disabled and any pending interrupt
 	 * status is cleared before registering UFS interrupt handler.
 	 */
-	mb();
+	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
 	/* IRQ registration */
 	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);
diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index 3c8e4212d941..40fb935818f8 100644
--- a/drivers/soc/mediatek/mtk-cmdq-helper.c
+++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
@@ -13,7 +13,8 @@
 #define CMDQ_POLL_ENABLE_MASK	BIT(0)
 #define CMDQ_EOC_IRQ_EN		BIT(0)
 #define CMDQ_REG_TYPE		1
-#define CMDQ_JUMP_RELATIVE	1
+#define CMDQ_JUMP_RELATIVE	0
+#define CMDQ_JUMP_ABSOLUTE	1
 
 struct cmdq_instruction {
 	union {
@@ -396,7 +397,7 @@ int cmdq_pkt_jump(struct cmdq_pkt *pkt, dma_addr_t addr)
 	struct cmdq_instruction inst = {};
 
 	inst.op = CMDQ_CODE_JUMP;
-	inst.offset = CMDQ_JUMP_RELATIVE;
+	inst.offset = CMDQ_JUMP_ABSOLUTE;
 	inst.value = addr >>
 		cmdq_get_shift_pa(((struct cmdq_client *)pkt->cl)->chan);
 	return cmdq_pkt_append_command(pkt, inst);
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index dd872017f345..b4803f2fde5e 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -1,6 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2016-2018, 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -17,6 +21,8 @@
 #define MAX_SLV_ID		8
 #define SLAVE_ID_MASK		0x7
 #define SLAVE_ID_SHIFT		16
+#define SLAVE_ID(addr)		FIELD_GET(GENMASK(19, 16), addr)
+#define VRM_ADDR(addr)		FIELD_GET(GENMASK(19, 4), addr)
 
 /**
  * struct entry_header: header for each entry in cmddb
@@ -216,6 +222,30 @@ const void *cmd_db_read_aux_data(const char *id, size_t *len)
 }
 EXPORT_SYMBOL(cmd_db_read_aux_data);
 
+/**
+ * cmd_db_match_resource_addr() - Compare if both Resource addresses are same
+ *
+ * @addr1: Resource address to compare
+ * @addr2: Resource address to compare
+ *
+ * Return: true if two addresses refer to the same resource, false otherwise
+ */
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{
+	/*
+	 * Each RPMh VRM accelerator resource has 3 or 4 contiguous 4-byte
+	 * aligned addresses associated with it. Ignore the offset to check
+	 * for VRM requests.
+	 */
+	if (addr1 == addr2)
+		return true;
+	else if (SLAVE_ID(addr1) == CMD_DB_HW_VRM && VRM_ADDR(addr1) == VRM_ADDR(addr2))
+		return true;
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(cmd_db_match_resource_addr);
+
 /**
  * cmd_db_read_slave_id - Get the slave ID for a given resource address
  *
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index e749a2b285d8..b722e28d9ed6 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
@@ -519,7 +520,7 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
 		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
 			addr = read_tcs_cmd(drv, RSC_DRV_CMD_ADDR, i, j);
 			for (k = 0; k < msg->num_cmds; k++) {
-				if (addr == msg->cmds[k].addr)
+				if (cmd_db_match_resource_addr(msg->cmds[k].addr, addr))
 					return -EBUSY;
 			}
 		}
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 7b340f383213..fb37e14404ec 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1830,7 +1830,7 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd,
+		pdi = cdns_find_pdi(cdns, 0, stream->num_bd, stream->bd,
 				    dai_id);
 
 	if (pdi) {
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 191baa6e45c0..e8d21c93ed7e 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -884,7 +884,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		mask |= STM32H7_SPI_SR_TXP | STM32H7_SPI_SR_RXP;
 
 	if (!(sr & mask)) {
-		dev_warn(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
+		dev_vdbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
 			 sr, ier);
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return IRQ_NONE;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index d4b186a35bb2..128f1cda3992 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1047,6 +1047,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	else
 		rx_dev = ctlr->dev.parent;
 
+	ret = -ENOMSG;
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		if (!ctlr->can_dma(ctlr, msg->spi, xfer))
 			continue;
@@ -1070,6 +1071,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			}
 		}
 	}
+	/* No transfer has been mapped, bail out with success */
+	if (ret)
+		return 0;
 
 	ctlr->cur_msg_mapped = true;
 
diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index bbf3ba744fc4..c7383c6c6094 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -468,6 +468,7 @@ static const struct of_device_id arche_apb_ctrl_of_match[] = {
 	{ .compatible = "usbffff,2", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arche_apb_ctrl_of_match);
 
 static struct platform_driver arche_apb_ctrl_device_driver = {
 	.probe		= arche_apb_ctrl_probe,
diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index e374dfc0c92f..00beb8bb1b33 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -620,14 +620,7 @@ static const struct of_device_id arche_platform_of_match[] = {
 	{ .compatible = "google,arche-platform", },
 	{ },
 };
-
-static const struct of_device_id arche_combined_id[] = {
-	/* Use PID/VID of SVC device */
-	{ .compatible = "google,arche-platform", },
-	{ .compatible = "usbffff,2", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, arche_combined_id);
+MODULE_DEVICE_TABLE(of, arche_platform_of_match);
 
 static struct platform_driver arche_platform_device_driver = {
 	.probe		= arche_platform_probe,
diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index c6bd86a5335a..9999f8401699 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -147,6 +147,9 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
 		channel = get_channel_from_mode(channel->light,
 						GB_CHANNEL_MODE_TORCH);
 
+	if (!channel)
+		return -EINVAL;
+
 	/* For not flash we need to convert brightness to intensity */
 	intensity = channel->intensity_uA.min +
 			(channel->intensity_uA.step * channel->led->brightness);
@@ -549,7 +552,10 @@ static int gb_lights_light_v4l2_register(struct gb_light *light)
 	}
 
 	channel_flash = get_channel_from_mode(light, GB_CHANNEL_MODE_FLASH);
-	WARN_ON(!channel_flash);
+	if (!channel_flash) {
+		dev_err(dev, "failed to get flash channel from mode\n");
+		return -EINVAL;
+	}
 
 	fled = &channel_flash->fled;
 
diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
index ba25d0da8b81..feaec4cd9636 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -5322,6 +5322,7 @@ static int load_video_binaries(struct ia_css_pipe *pipe)
 						  sizeof(struct ia_css_binary),
 						  GFP_KERNEL);
 		if (!mycs->yuv_scaler_binary) {
+			mycs->num_yuv_scaler = 0;
 			err = -ENOMEM;
 			return err;
 		}
diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index cc94d8b005d4..36f0e92d92ce 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -92,6 +92,9 @@ static int lmh_probe(struct platform_device *pdev)
 	int temp_low, temp_high, temp_arm, cpu_id, ret;
 	u32 node_id;
 
+	if (!qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
 	lmh_data = devm_kzalloc(dev, sizeof(*lmh_data), GFP_KERNEL);
 	if (!lmh_data)
 		return -ENOMEM;
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 926cd8b41132..2f31129cd547 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -84,7 +84,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
-			__func__, i, p1[i], p2[i]);
+			__func__, i, p1[i], p2 ? p2[i] : 0);
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 4ff3010a82ea..aae9f73585bd 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -178,16 +178,18 @@ struct gsm_control {
 
 enum gsm_mux_state {
 	GSM_SEARCH,
-	GSM_START,
-	GSM_ADDRESS,
-	GSM_CONTROL,
-	GSM_LEN,
-	GSM_DATA,
-	GSM_FCS,
-	GSM_OVERRUN,
-	GSM_LEN0,
-	GSM_LEN1,
-	GSM_SSOF,
+	GSM0_ADDRESS,
+	GSM0_CONTROL,
+	GSM0_LEN0,
+	GSM0_LEN1,
+	GSM0_DATA,
+	GSM0_FCS,
+	GSM0_SSOF,
+	GSM1_START,
+	GSM1_ADDRESS,
+	GSM1_CONTROL,
+	GSM1_DATA,
+	GSM1_OVERRUN,
 };
 
 /*
@@ -2162,6 +2164,30 @@ static void gsm_queue(struct gsm_mux *gsm)
 	return;
 }
 
+/**
+ * gsm0_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for basic option mode.
+ */
+
+static void gsm0_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM0_ADDRESS:
+	case GSM0_CONTROL:
+	case GSM0_LEN0:
+	case GSM0_LEN1:
+	case GSM0_DATA:
+	case GSM0_FCS:
+	case GSM0_SSOF:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
 
 /**
  *	gsm0_receive	-	perform processing for non-transparency
@@ -2175,26 +2201,27 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 {
 	unsigned int len;
 
+	gsm0_receive_state_check_and_fix(gsm);
 	switch (gsm->state) {
 	case GSM_SEARCH:	/* SOF marker */
 		if (c == GSM0_SOF) {
-			gsm->state = GSM_ADDRESS;
+			gsm->state = GSM0_ADDRESS;
 			gsm->address = 0;
 			gsm->len = 0;
 			gsm->fcs = INIT_FCS;
 		}
 		break;
-	case GSM_ADDRESS:	/* Address EA */
+	case GSM0_ADDRESS:	/* Address EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM0_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM0_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
-		gsm->state = GSM_LEN0;
+		gsm->state = GSM0_LEN0;
 		break;
-	case GSM_LEN0:		/* Length EA */
+	case GSM0_LEN0:		/* Length EA */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->len, c)) {
 			if (gsm->len > gsm->mru) {
@@ -2204,14 +2231,14 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 			}
 			gsm->count = 0;
 			if (!gsm->len)
-				gsm->state = GSM_FCS;
+				gsm->state = GSM0_FCS;
 			else
-				gsm->state = GSM_DATA;
+				gsm->state = GSM0_DATA;
 			break;
 		}
-		gsm->state = GSM_LEN1;
+		gsm->state = GSM0_LEN1;
 		break;
-	case GSM_LEN1:
+	case GSM0_LEN1:
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		len = c;
 		gsm->len |= len << 7;
@@ -2222,26 +2249,29 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 		}
 		gsm->count = 0;
 		if (!gsm->len)
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		else
-			gsm->state = GSM_DATA;
+			gsm->state = GSM0_DATA;
 		break;
-	case GSM_DATA:		/* Data */
+	case GSM0_DATA:		/* Data */
 		gsm->buf[gsm->count++] = c;
-		if (gsm->count == gsm->len) {
+		if (gsm->count >= MAX_MRU) {
+			gsm->bad_size++;
+			gsm->state = GSM_SEARCH;
+		} else if (gsm->count >= gsm->len) {
 			/* Calculate final FCS for UI frames over all data */
 			if ((gsm->control & ~PF) != UIH) {
 				gsm->fcs = gsm_fcs_add_block(gsm->fcs, gsm->buf,
 							     gsm->count);
 			}
-			gsm->state = GSM_FCS;
+			gsm->state = GSM0_FCS;
 		}
 		break;
-	case GSM_FCS:		/* FCS follows the packet */
+	case GSM0_FCS:		/* FCS follows the packet */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
-		gsm->state = GSM_SSOF;
+		gsm->state = GSM0_SSOF;
 		break;
-	case GSM_SSOF:
+	case GSM0_SSOF:
 		gsm->state = GSM_SEARCH;
 		if (c == GSM0_SOF)
 			gsm_queue(gsm);
@@ -2254,6 +2284,29 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 	}
 }
 
+/**
+ * gsm1_receive_state_check_and_fix	-	check and correct receive state
+ * @gsm: gsm data for this ldisc instance
+ *
+ * Ensures that the current receive state is valid for advanced option mode.
+ */
+
+static void gsm1_receive_state_check_and_fix(struct gsm_mux *gsm)
+{
+	switch (gsm->state) {
+	case GSM_SEARCH:
+	case GSM1_START:
+	case GSM1_ADDRESS:
+	case GSM1_CONTROL:
+	case GSM1_DATA:
+	case GSM1_OVERRUN:
+		break;
+	default:
+		gsm->state = GSM_SEARCH;
+		break;
+	}
+}
+
 /**
  *	gsm1_receive	-	perform processing for non-transparency
  *	@gsm: gsm data for this ldisc instance
@@ -2264,6 +2317,7 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 
 static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 {
+	gsm1_receive_state_check_and_fix(gsm);
 	/* handle XON/XOFF */
 	if ((c & ISO_IEC_646_MASK) == XON) {
 		gsm->constipated = true;
@@ -2276,11 +2330,11 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 	}
 	if (c == GSM1_SOF) {
 		/* EOF is only valid in frame if we have got to the data state */
-		if (gsm->state == GSM_DATA) {
+		if (gsm->state == GSM1_DATA) {
 			if (gsm->count < 1) {
 				/* Missing FSC */
 				gsm->malformed++;
-				gsm->state = GSM_START;
+				gsm->state = GSM1_START;
 				return;
 			}
 			/* Remove the FCS from data */
@@ -2296,14 +2350,14 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 			gsm->fcs = gsm_fcs_add(gsm->fcs, gsm->buf[gsm->count]);
 			gsm->len = gsm->count;
 			gsm_queue(gsm);
-			gsm->state  = GSM_START;
+			gsm->state  = GSM1_START;
 			return;
 		}
 		/* Any partial frame was a runt so go back to start */
-		if (gsm->state != GSM_START) {
+		if (gsm->state != GSM1_START) {
 			if (gsm->state != GSM_SEARCH)
 				gsm->malformed++;
-			gsm->state = GSM_START;
+			gsm->state = GSM1_START;
 		}
 		/* A SOF in GSM_START means we are still reading idling or
 		   framing bytes */
@@ -2324,30 +2378,30 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 		gsm->escape = false;
 	}
 	switch (gsm->state) {
-	case GSM_START:		/* First byte after SOF */
+	case GSM1_START:		/* First byte after SOF */
 		gsm->address = 0;
-		gsm->state = GSM_ADDRESS;
+		gsm->state = GSM1_ADDRESS;
 		gsm->fcs = INIT_FCS;
 		fallthrough;
-	case GSM_ADDRESS:	/* Address continuation */
+	case GSM1_ADDRESS:	/* Address continuation */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		if (gsm_read_ea(&gsm->address, c))
-			gsm->state = GSM_CONTROL;
+			gsm->state = GSM1_CONTROL;
 		break;
-	case GSM_CONTROL:	/* Control Byte */
+	case GSM1_CONTROL:	/* Control Byte */
 		gsm->fcs = gsm_fcs_add(gsm->fcs, c);
 		gsm->control = c;
 		gsm->count = 0;
-		gsm->state = GSM_DATA;
+		gsm->state = GSM1_DATA;
 		break;
-	case GSM_DATA:		/* Data */
-		if (gsm->count > gsm->mru) {	/* Allow one for the FCS */
-			gsm->state = GSM_OVERRUN;
+	case GSM1_DATA:		/* Data */
+		if (gsm->count > gsm->mru || gsm->count > MAX_MRU) {	/* Allow one for the FCS */
+			gsm->state = GSM1_OVERRUN;
 			gsm->bad_size++;
 		} else
 			gsm->buf[gsm->count++] = c;
 		break;
-	case GSM_OVERRUN:	/* Over-long - eg a dropped SOF */
+	case GSM1_OVERRUN:	/* Over-long - eg a dropped SOF */
 		break;
 	default:
 		pr_debug("%s: unhandled state: %d\n", __func__, gsm->state);
diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index f95047160b4d..8a32418feb74 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -674,18 +674,46 @@ static void init_real_clk_rates(struct device *dev, struct brcmuart_priv *priv)
 	clk_set_rate(priv->baud_mux_clk, priv->default_mux_rate);
 }
 
+static u32 find_quot(struct device *dev, u32 freq, u32 baud, u32 *percent)
+{
+	u32 quot;
+	u32 rate;
+	u64 hires_rate;
+	u64 hires_baud;
+	u64 hires_err;
+
+	rate = freq / 16;
+	quot = DIV_ROUND_CLOSEST(rate, baud);
+	if (!quot)
+		return 0;
+
+	/* increase resolution to get xx.xx percent */
+	hires_rate = div_u64((u64)rate * 10000, (u64)quot);
+	hires_baud = (u64)baud * 10000;
+
+	/* get the delta */
+	if (hires_rate > hires_baud)
+		hires_err = (hires_rate - hires_baud);
+	else
+		hires_err = (hires_baud - hires_rate);
+
+	*percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
+
+	dev_dbg(dev, "Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
+		baud, freq, *percent / 100, *percent % 100);
+
+	return quot;
+}
+
 static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 			u32 baud)
 {
 	u32 percent;
 	u32 best_percent = UINT_MAX;
 	u32 quot;
+	u32 freq;
 	u32 best_quot = 1;
-	u32 rate;
-	int best_index = -1;
-	u64 hires_rate;
-	u64 hires_baud;
-	u64 hires_err;
+	u32 best_freq = 0;
 	int rc;
 	int i;
 	int real_baud;
@@ -694,44 +722,35 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 	if (priv->baud_mux_clk == NULL)
 		return;
 
-	/* Find the closest match for specified baud */
-	for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
-		if (priv->real_rates[i] == 0)
-			continue;
-		rate = priv->real_rates[i] / 16;
-		quot = DIV_ROUND_CLOSEST(rate, baud);
-		if (!quot)
-			continue;
-
-		/* increase resolution to get xx.xx percent */
-		hires_rate = (u64)rate * 10000;
-		hires_baud = (u64)baud * 10000;
-
-		hires_err = div_u64(hires_rate, (u64)quot);
-
-		/* get the delta */
-		if (hires_err > hires_baud)
-			hires_err = (hires_err - hires_baud);
-		else
-			hires_err = (hires_baud - hires_err);
-
-		percent = (unsigned long)DIV_ROUND_CLOSEST_ULL(hires_err, baud);
-		dev_dbg(up->dev,
-			"Baud rate: %u, MUX Clk: %u, Error: %u.%u%%\n",
-			baud, priv->real_rates[i], percent / 100,
-			percent % 100);
-		if (percent < best_percent) {
-			best_percent = percent;
-			best_index = i;
-			best_quot = quot;
+	/* Try default_mux_rate first */
+	quot = find_quot(up->dev, priv->default_mux_rate, baud, &percent);
+	if (quot) {
+		best_percent = percent;
+		best_freq = priv->default_mux_rate;
+		best_quot = quot;
+	}
+	/* If more than 1% error, find the closest match for specified baud */
+	if (best_percent > 100) {
+		for (i = 0; i < ARRAY_SIZE(priv->real_rates); i++) {
+			freq = priv->real_rates[i];
+			if (freq == 0 || freq == priv->default_mux_rate)
+				continue;
+			quot = find_quot(up->dev, freq, baud, &percent);
+			if (!quot)
+				continue;
+
+			if (percent < best_percent) {
+				best_percent = percent;
+				best_freq = freq;
+				best_quot = quot;
+			}
 		}
 	}
-	if (best_index == -1) {
+	if (!best_freq) {
 		dev_err(up->dev, "Error, %d BAUD rate is too fast.\n", baud);
 		return;
 	}
-	rate = priv->real_rates[best_index];
-	rc = clk_set_rate(priv->baud_mux_clk, rate);
+	rc = clk_set_rate(priv->baud_mux_clk, best_freq);
 	if (rc)
 		dev_err(up->dev, "Error selecting BAUD MUX clock\n");
 
@@ -740,8 +759,8 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 		dev_err(up->dev, "Error, baud: %d has %u.%u%% error\n",
 			baud, percent / 100, percent % 100);
 
-	real_baud = rate / 16 / best_quot;
-	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", rate);
+	real_baud = best_freq / 16 / best_quot;
+	dev_dbg(up->dev, "Selecting BAUD MUX rate: %u\n", best_freq);
 	dev_dbg(up->dev, "Requested baud: %u, Actual baud: %u\n",
 		baud, real_baud);
 
@@ -750,7 +769,7 @@ static void set_clock_mux(struct uart_port *up, struct brcmuart_priv *priv,
 	i += (i / 2);
 	priv->char_wait = ns_to_ktime(i);
 
-	up->uartclk = rate;
+	up->uartclk = best_freq;
 }
 
 static void brcmstb_set_termios(struct uart_port *up,
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 3c92d4e01488..8290ab72c05a 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -45,6 +45,9 @@
 #include <linux/freezer.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
 
 #include <linux/serial_max3100.h>
 
@@ -191,7 +194,7 @@ static void max3100_timeout(struct timer_list *t)
 static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 {
 	struct spi_message message;
-	u16 etx, erx;
+	__be16 etx, erx;
 	int status;
 	struct spi_transfer tran = {
 		.tx_buf = &etx,
@@ -213,7 +216,7 @@ static int max3100_sr(struct max3100_port *s, u16 tx, u16 *rx)
 	return 0;
 }
 
-static int max3100_handlerx(struct max3100_port *s, u16 rx)
+static int max3100_handlerx_unlocked(struct max3100_port *s, u16 rx)
 {
 	unsigned int ch, flg, status = 0;
 	int ret = 0, cts;
@@ -253,6 +256,17 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 	return ret;
 }
 
+static int max3100_handlerx(struct max3100_port *s, u16 rx)
+{
+	unsigned long flags;
+	int ret;
+
+	uart_port_lock_irqsave(&s->port, &flags);
+	ret = max3100_handlerx_unlocked(s, rx);
+	uart_port_unlock_irqrestore(&s->port, flags);
+	return ret;
+}
+
 static void max3100_work(struct work_struct *w)
 {
 	struct max3100_port *s = container_of(w, struct max3100_port, work);
@@ -740,13 +754,14 @@ static int max3100_probe(struct spi_device *spi)
 	mutex_lock(&max3100s_lock);
 
 	if (!uart_driver_registered) {
-		uart_driver_registered = 1;
 		retval = uart_register_driver(&max3100_uart_driver);
 		if (retval) {
 			printk(KERN_ERR "Couldn't register max3100 uart driver\n");
 			mutex_unlock(&max3100s_lock);
 			return retval;
 		}
+
+		uart_driver_registered = 1;
 	}
 
 	for (i = 0; i < MAX_MAX3100; i++)
@@ -832,6 +847,7 @@ static int max3100_remove(struct spi_device *spi)
 		}
 	pr_debug("removing max3100 driver\n");
 	uart_unregister_driver(&max3100_uart_driver);
+	uart_driver_registered = 0;
 
 	mutex_unlock(&max3100s_lock);
 	return 0;
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 0066a0e23516..35f8675db1d8 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/sched.h>
 #include <linux/serial_core.h>
 #include <linux/serial.h>
 #include <linux/tty.h>
@@ -25,7 +26,6 @@
 #include <linux/spi/spi.h>
 #include <linux/uaccess.h>
 #include <linux/units.h>
-#include <uapi/linux/sched/types.h>
 
 #define SC16IS7XX_NAME			"sc16is7xx"
 #define SC16IS7XX_MAX_DEVS		8
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 25318176091b..6cd7bd7b6782 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1255,9 +1255,14 @@ static void sci_dma_rx_chan_invalidate(struct sci_port *s)
 static void sci_dma_rx_release(struct sci_port *s)
 {
 	struct dma_chan *chan = s->chan_rx_saved;
+	struct uart_port *port = &s->port;
+	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	s->chan_rx_saved = NULL;
 	sci_dma_rx_chan_invalidate(s);
+	uart_port_unlock_irqrestore(port, flags);
+
 	dmaengine_terminate_sync(chan);
 	dma_free_coherent(chan->device->dev, s->buf_len_rx * 2, s->rx_buf[0],
 			  sg_dma_address(&s->sg_rx[0]));
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 200eb788a74b..5e34a7ff1b63 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -1172,6 +1172,8 @@ void g_audio_cleanup(struct g_audio *g_audio)
 		return;
 
 	uac = g_audio->uac;
+	g_audio->uac = NULL;
+
 	card = uac->card;
 	if (card)
 		snd_card_free_when_closed(card);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 662524574cc3..26dfc4e5b10c 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2016,8 +2016,8 @@ config FB_COBALT
 	depends on FB && MIPS_COBALT
 
 config FB_SH7760
-	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	tristate "SH7760/SH7763/SH7720/SH7721 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 94ebd8af50cf..224d7c8146a9 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2271,7 +2271,10 @@ static int savagefb_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (info->var.xres_virtual > 0x1000)
 		info->var.xres_virtual = 0x1000;
 #endif
-	savagefb_check_var(&info->var, info);
+	err = savagefb_check_var(&info->var, info);
+	if (err)
+		goto failed;
+
 	savagefb_set_fix(info);
 
 	/*
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index e33c016c5428..74a013c398b1 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1577,7 +1577,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
 	 */
 	info->fix = sh_mobile_lcdc_overlay_fix;
 	snprintf(info->fix.id, sizeof(info->fix.id),
-		 "SH Mobile LCDC Overlay %u", ovl->index);
+		 "SHMobile ovl %u", ovl->index);
 	info->fix.smem_start = ovl->dma_handle;
 	info->fix.smem_len = ovl->fb_size;
 	info->fix.line_length = ovl->pitch;
diff --git a/drivers/video/fbdev/sis/init301.c b/drivers/video/fbdev/sis/init301.c
index a8fb41f1a258..09329072004f 100644
--- a/drivers/video/fbdev/sis/init301.c
+++ b/drivers/video/fbdev/sis/init301.c
@@ -172,7 +172,7 @@ static const unsigned char SiS_HiTVGroup3_2[] = {
 };
 
 /* 301C / 302ELV extended Part2 TV registers (4 tap scaler) */
-
+#ifdef CONFIG_FB_SIS_315
 static const unsigned char SiS_Part2CLVX_1[] = {
     0x00,0x00,
     0x00,0x20,0x00,0x00,0x7F,0x20,0x02,0x7F,0x7D,0x20,0x04,0x7F,0x7D,0x1F,0x06,0x7E,
@@ -245,7 +245,6 @@ static const unsigned char SiS_Part2CLVX_6[] = {   /* 1080i */
     0xFF,0xFF,
 };
 
-#ifdef CONFIG_FB_SIS_315
 /* 661 et al LCD data structure (2.03.00) */
 static const unsigned char SiS_LCDStruct661[] = {
     /* 1024x768 */
diff --git a/drivers/virt/acrn/acrn_drv.h b/drivers/virt/acrn/acrn_drv.h
index 1be54efa666c..5663c17ad37c 100644
--- a/drivers/virt/acrn/acrn_drv.h
+++ b/drivers/virt/acrn/acrn_drv.h
@@ -48,6 +48,7 @@ struct vm_memory_region_op {
  * @reserved:		Reserved.
  * @regions_num:	The number of vm_memory_region_op.
  * @regions_gpa:	Physical address of a vm_memory_region_op array.
+ * @regions_op:		Flexible array of vm_memory_region_op.
  *
  * HC_VM_SET_MEMORY_REGIONS uses this structure to manage EPT mappings of
  * multiple memory regions of a User VM. A &struct vm_memory_region_batch
@@ -55,10 +56,11 @@ struct vm_memory_region_op {
  * ACRN Hypervisor.
  */
 struct vm_memory_region_batch {
-	u16	vmid;
-	u16	reserved[3];
-	u32	regions_num;
-	u64	regions_gpa;
+	u16			   vmid;
+	u16			   reserved[3];
+	u32			   regions_num;
+	u64			   regions_gpa;
+	struct vm_memory_region_op regions_op[];
 };
 
 /**
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index 3b1b1e7a844b..8ef49d7be453 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -155,44 +155,84 @@ int acrn_vm_memseg_unmap(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 {
 	struct vm_memory_region_batch *regions_info;
-	int nr_pages, i = 0, order, nr_regions = 0;
+	int nr_pages, i, order, nr_regions = 0;
 	struct vm_memory_mapping *region_mapping;
 	struct vm_memory_region_op *vm_region;
 	struct page **pages = NULL, *page;
 	void *remap_vaddr;
 	int ret, pinned;
 	u64 user_vm_pa;
-	unsigned long pfn;
 	struct vm_area_struct *vma;
 
 	if (!vm || !memmap)
 		return -EINVAL;
 
+	/* Get the page number of the map region */
+	nr_pages = memmap->len >> PAGE_SHIFT;
+	if (!nr_pages)
+		return -EINVAL;
+
 	mmap_read_lock(current->mm);
 	vma = vma_lookup(current->mm, memmap->vma_base);
 	if (vma && ((vma->vm_flags & VM_PFNMAP) != 0)) {
+		unsigned long start_pfn, cur_pfn;
+		spinlock_t *ptl;
+		bool writable;
+		pte_t *ptep;
+
 		if ((memmap->vma_base + memmap->len) > vma->vm_end) {
 			mmap_read_unlock(current->mm);
 			return -EINVAL;
 		}
 
-		ret = follow_pfn(vma, memmap->vma_base, &pfn);
+		for (i = 0; i < nr_pages; i++) {
+			ret = follow_pte(vma->vm_mm,
+					 memmap->vma_base + i * PAGE_SIZE,
+					 &ptep, &ptl);
+			if (ret)
+				break;
+
+			cur_pfn = pte_pfn(ptep_get(ptep));
+			if (i == 0)
+				start_pfn = cur_pfn;
+			writable = !!pte_write(ptep_get(ptep));
+			pte_unmap_unlock(ptep, ptl);
+
+			/* Disallow write access if the PTE is not writable. */
+			if (!writable &&
+			    (memmap->attr & ACRN_MEM_ACCESS_WRITE)) {
+				ret = -EFAULT;
+				break;
+			}
+
+			/* Disallow refcounted pages. */
+			if (pfn_valid(cur_pfn) &&
+			    !PageReserved(pfn_to_page(cur_pfn))) {
+				ret = -EFAULT;
+				break;
+			}
+
+			/* Disallow non-contiguous ranges. */
+			if (cur_pfn != start_pfn + i) {
+				ret = -EINVAL;
+				break;
+			}
+		}
 		mmap_read_unlock(current->mm);
-		if (ret < 0) {
+
+		if (ret) {
 			dev_dbg(acrn_dev.this_device,
 				"Failed to lookup PFN at VMA:%pK.\n", (void *)memmap->vma_base);
 			return ret;
 		}
 
 		return acrn_mm_region_add(vm, memmap->user_vm_pa,
-			 PFN_PHYS(pfn), memmap->len,
+			 PFN_PHYS(start_pfn), memmap->len,
 			 ACRN_MEM_TYPE_WB, memmap->attr);
 	}
 	mmap_read_unlock(current->mm);
 
-	/* Get the page number of the map region */
-	nr_pages = memmap->len >> PAGE_SHIFT;
-	pages = vzalloc(nr_pages * sizeof(struct page *));
+	pages = vzalloc(array_size(nr_pages, sizeof(*pages)));
 	if (!pages)
 		return -ENOMEM;
 
@@ -235,31 +275,28 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	mutex_unlock(&vm->regions_mapping_lock);
 
 	/* Calculate count of vm_memory_region_op */
-	while (i < nr_pages) {
+	for (i = 0; i < nr_pages; i += 1 << order) {
 		page = pages[i];
 		VM_BUG_ON_PAGE(PageTail(page), page);
 		order = compound_order(page);
 		nr_regions++;
-		i += 1 << order;
 	}
 
 	/* Prepare the vm_memory_region_batch */
-	regions_info = kzalloc(sizeof(*regions_info) +
-			       sizeof(*vm_region) * nr_regions,
-			       GFP_KERNEL);
+	regions_info = kzalloc(struct_size(regions_info, regions_op,
+					   nr_regions), GFP_KERNEL);
 	if (!regions_info) {
 		ret = -ENOMEM;
 		goto unmap_kernel_map;
 	}
 
 	/* Fill each vm_memory_region_op */
-	vm_region = (struct vm_memory_region_op *)(regions_info + 1);
+	vm_region = regions_info->regions_op;
 	regions_info->vmid = vm->vmid;
 	regions_info->regions_num = nr_regions;
 	regions_info->regions_gpa = virt_to_phys(vm_region);
 	user_vm_pa = memmap->user_vm_pa;
-	i = 0;
-	while (i < nr_pages) {
+	for (i = 0; i < nr_pages; i += 1 << order) {
 		u32 region_size;
 
 		page = pages[i];
@@ -275,7 +312,6 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 
 		vm_region++;
 		user_vm_pa += region_size;
-		i += 1 << order;
 	}
 
 	/* Inform the ACRN Hypervisor to set up EPT mappings */
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 1e890ef17687..a6f375417fd5 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -339,8 +339,10 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 				  vring_interrupt, 0,
 				  vp_dev->msix_names[msix_vec],
 				  vqs[i]);
-		if (err)
+		if (err) {
+			vp_del_vq(vqs[i]);
 			goto error_find;
+		}
 	}
 	return 0;
 
diff --git a/drivers/watchdog/bd9576_wdt.c b/drivers/watchdog/bd9576_wdt.c
index 0b6999f3b6e8..f00ea1b4e40b 100644
--- a/drivers/watchdog/bd9576_wdt.c
+++ b/drivers/watchdog/bd9576_wdt.c
@@ -9,8 +9,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/mfd/rohm-bd957x.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/watchdog.h>
 
@@ -29,7 +29,6 @@ struct bd9576_wdt_priv {
 	struct gpio_desc	*gpiod_en;
 	struct device		*dev;
 	struct regmap		*regmap;
-	bool			always_running;
 	struct watchdog_device	wdd;
 };
 
@@ -62,10 +61,7 @@ static int bd9576_wdt_stop(struct watchdog_device *wdd)
 {
 	struct bd9576_wdt_priv *priv = watchdog_get_drvdata(wdd);
 
-	if (!priv->always_running)
-		bd9576_wdt_disable(priv);
-	else
-		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	bd9576_wdt_disable(priv);
 
 	return 0;
 }
@@ -202,10 +198,10 @@ static int bd957x_set_wdt_mode(struct bd9576_wdt_priv *priv, int hw_margin,
 static int bd9576_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->parent->of_node;
 	struct bd9576_wdt_priv *priv;
 	u32 hw_margin[2];
 	u32 hw_margin_max = BD957X_WDT_DEFAULT_MARGIN, hw_margin_min = 0;
+	int count;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -221,41 +217,49 @@ static int bd9576_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	priv->gpiod_en = devm_gpiod_get_from_of_node(dev, dev->parent->of_node,
-						     "rohm,watchdog-enable-gpios",
-						     0, GPIOD_OUT_LOW,
-						     "watchdog-enable");
+	priv->gpiod_en = devm_fwnode_gpiod_get(dev, dev_fwnode(dev->parent),
+					       "rohm,watchdog-enable",
+					       GPIOD_OUT_LOW,
+					       "watchdog-enable");
 	if (IS_ERR(priv->gpiod_en))
 		return dev_err_probe(dev, PTR_ERR(priv->gpiod_en),
 			      "getting watchdog-enable GPIO failed\n");
 
-	priv->gpiod_ping = devm_gpiod_get_from_of_node(dev, dev->parent->of_node,
-						     "rohm,watchdog-ping-gpios",
-						     0, GPIOD_OUT_LOW,
-						     "watchdog-ping");
+	priv->gpiod_ping = devm_fwnode_gpiod_get(dev, dev_fwnode(dev->parent),
+						 "rohm,watchdog-ping",
+						 GPIOD_OUT_LOW,
+						 "watchdog-ping");
 	if (IS_ERR(priv->gpiod_ping))
 		return dev_err_probe(dev, PTR_ERR(priv->gpiod_ping),
 				     "getting watchdog-ping GPIO failed\n");
 
-	ret = of_property_read_variable_u32_array(np, "rohm,hw-timeout-ms",
-						  &hw_margin[0], 1, 2);
-	if (ret < 0 && ret != -EINVAL)
-		return ret;
+	count = device_property_count_u32(dev->parent, "rohm,hw-timeout-ms");
+	if (count < 0 && count != -EINVAL)
+		return count;
+
+	if (count > 0) {
+		if (count > ARRAY_SIZE(hw_margin))
+			return -EINVAL;
+
+		ret = device_property_read_u32_array(dev->parent,
+						     "rohm,hw-timeout-ms",
+						     hw_margin, count);
+		if (ret < 0)
+			return ret;
 
-	if (ret == 1)
-		hw_margin_max = hw_margin[0];
+		if (count == 1)
+			hw_margin_max = hw_margin[0];
 
-	if (ret == 2) {
-		hw_margin_max = hw_margin[1];
-		hw_margin_min = hw_margin[0];
+		if (count == 2) {
+			hw_margin_max = hw_margin[1];
+			hw_margin_min = hw_margin[0];
+		}
 	}
 
 	ret = bd957x_set_wdt_mode(priv, hw_margin_max, hw_margin_min);
 	if (ret)
 		return ret;
 
-	priv->always_running = of_property_read_bool(np, "always-running");
-
 	watchdog_set_drvdata(&priv->wdd, priv);
 
 	priv->wdd.info			= &bd957x_wdt_ident;
@@ -270,9 +274,6 @@ static int bd9576_wdt_probe(struct platform_device *pdev)
 
 	watchdog_stop_on_reboot(&priv->wdd);
 
-	if (priv->always_running)
-		bd9576_wdt_start(&priv->wdd);
-
 	return devm_watchdog_register_device(dev, &priv->wdd);
 }
 
diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index daa00f3c5a6a..7f2ca611a3f8 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -52,6 +52,8 @@
 
 #define DWDST			BIT(1)
 
+#define MAX_HW_ERROR		250
+
 static int heartbeat = DEFAULT_HEARTBEAT;
 
 /*
@@ -90,7 +92,7 @@ static int rti_wdt_start(struct watchdog_device *wdd)
 	 * to be 50% or less than that; we obviouly want to configure the open
 	 * window as large as possible so we select the 50% option.
 	 */
-	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
+	wdd->min_hw_heartbeat_ms = 520 * wdd->timeout + MAX_HW_ERROR;
 
 	/* Generate NMI when wdt expires */
 	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
@@ -124,31 +126,33 @@ static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
 	 * be petted during the open window; not too early or not too late.
 	 * The HW configuration options only allow for the open window size
 	 * to be 50% or less than that.
+	 * To avoid any glitches, we accommodate 2% + max hardware error
+	 * safety margin.
 	 */
 	switch (wsize) {
 	case RTIWWDSIZE_50P:
-		/* 50% open window => 50% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
+		/* 50% open window => 52% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 520 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_25P:
-		/* 25% open window => 75% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
+		/* 25% open window => 77% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 770 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_12P5:
-		/* 12.5% open window => 87.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
+		/* 12.5% open window => 89.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 895 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_6P25:
-		/* 6.5% open window => 93.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
+		/* 6.5% open window => 95.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 955 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_3P125:
-		/* 3.125% open window => 96.9% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
+		/* 3.125% open window => 98.9% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 989 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	default:
@@ -222,14 +226,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/*
-	 * If watchdog is running at 32k clock, it is not accurate.
-	 * Adjust frequency down in this case so that we don't pet
-	 * the watchdog too often.
-	 */
-	if (wdt->freq < 32768)
-		wdt->freq = wdt->freq * 9 / 10;
-
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
 	if (ret < 0) {
diff --git a/fs/afs/mntpt.c b/fs/afs/mntpt.c
index bbb2c210d139..fa8a6543142d 100644
--- a/fs/afs/mntpt.c
+++ b/fs/afs/mntpt.c
@@ -146,6 +146,11 @@ static int afs_mntpt_set_params(struct fs_context *fc, struct dentry *mntpt)
 		put_page(page);
 		if (ret < 0)
 			return ret;
+
+		/* Don't cross a backup volume mountpoint from a backup volume */
+		if (src_as->volume && src_as->volume->type == AFSVL_BACKVOL &&
+		    ctx->type == AFSVL_BACKVOL)
+			return -ENODEV;
 	}
 
 	return 0;
diff --git a/fs/ecryptfs/keystore.c b/fs/ecryptfs/keystore.c
index 3fe41964c0d8..7f9f68c00ef6 100644
--- a/fs/ecryptfs/keystore.c
+++ b/fs/ecryptfs/keystore.c
@@ -300,9 +300,11 @@ write_tag_66_packet(char *signature, u8 cipher_code,
 	 *         | Key Identifier Size      | 1 or 2 bytes |
 	 *         | Key Identifier           | arbitrary    |
 	 *         | File Encryption Key Size | 1 or 2 bytes |
+	 *         | Cipher Code              | 1 byte       |
 	 *         | File Encryption Key      | arbitrary    |
+	 *         | Checksum                 | 2 bytes      |
 	 */
-	data_len = (5 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
+	data_len = (8 + ECRYPTFS_SIG_SIZE_HEX + crypt_stat->key_size);
 	*packet = kmalloc(data_len, GFP_KERNEL);
 	message = *packet;
 	if (!message) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1c254094c4c3..b60edddf1787 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -832,6 +832,34 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	return res;
 }
 
+/*
+ * The ffd.file pointer may be in the process of being torn down due to
+ * being closed, but we may not have finished eventpoll_release() yet.
+ *
+ * Normally, even with the atomic_long_inc_not_zero, the file may have
+ * been free'd and then gotten re-allocated to something else (since
+ * files are not RCU-delayed, they are SLAB_TYPESAFE_BY_RCU).
+ *
+ * But for epoll, users hold the ep->mtx mutex, and as such any file in
+ * the process of being free'd will block in eventpoll_release_file()
+ * and thus the underlying file allocation will not be free'd, and the
+ * file re-use cannot happen.
+ *
+ * For the same reason we can avoid a rcu_read_lock() around the
+ * operation - 'ffd.file' cannot go away even if the refcount has
+ * reached zero (but we must still not call out to ->poll() functions
+ * etc).
+ */
+static struct file *epi_fget(const struct epitem *epi)
+{
+	struct file *file;
+
+	file = epi->ffd.file;
+	if (!atomic_long_inc_not_zero(&file->f_count))
+		file = NULL;
+	return file;
+}
+
 /*
  * Differs from ep_eventpoll_poll() in that internal callers already have
  * the ep->mtx so we need to start from depth=1, such that mutex_lock_nested()
@@ -840,14 +868,22 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt,
 				 int depth)
 {
-	struct file *file = epi->ffd.file;
+	struct file *file = epi_fget(epi);
 	__poll_t res;
 
+	/*
+	 * We could return EPOLLERR | EPOLLHUP or something, but let's
+	 * treat this more as "file doesn't exist, poll didn't happen".
+	 */
+	if (!file)
+		return 0;
+
 	pt->_key = epi->event.events;
 	if (!is_file_epoll(file))
 		res = vfs_poll(file, pt);
 	else
 		res = __ep_eventpoll_poll(file, pt, depth);
+	fput(file);
 	return res & epi->event.events;
 }
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 8dba416aa6c1..1145664a0bb7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5620,8 +5620,73 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 	return ret;
 }
 
-static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
-				struct ext4_allocation_request *ar, int *errp);
+/*
+ * Simple allocator for Ext4 fast commit replay path. It searches for blocks
+ * linearly starting at the goal block and also excludes the blocks which
+ * are going to be in use after fast commit replay.
+ */
+static ext4_fsblk_t
+ext4_mb_new_blocks_simple(struct ext4_allocation_request *ar, int *errp)
+{
+	struct buffer_head *bitmap_bh;
+	struct super_block *sb = ar->inode->i_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_group_t group, nr;
+	ext4_grpblk_t blkoff;
+	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
+	ext4_grpblk_t i = 0;
+	ext4_fsblk_t goal, block;
+	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+
+	goal = ar->goal;
+	if (goal < le32_to_cpu(es->s_first_data_block) ||
+			goal >= ext4_blocks_count(es))
+		goal = le32_to_cpu(es->s_first_data_block);
+
+	ar->len = 0;
+	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
+	for (nr = ext4_get_groups_count(sb); nr > 0; nr--) {
+		bitmap_bh = ext4_read_block_bitmap(sb, group);
+		if (IS_ERR(bitmap_bh)) {
+			*errp = PTR_ERR(bitmap_bh);
+			pr_warn("Failed to read block bitmap\n");
+			return 0;
+		}
+
+		while (1) {
+			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
+						blkoff);
+			if (i >= max)
+				break;
+			if (ext4_fc_replay_check_excluded(sb,
+				ext4_group_first_block_no(sb, group) +
+				EXT4_C2B(sbi, i))) {
+				blkoff = i + 1;
+			} else
+				break;
+		}
+		brelse(bitmap_bh);
+		if (i < max)
+			break;
+
+		if (++group >= ext4_get_groups_count(sb))
+			group = 0;
+
+		blkoff = 0;
+	}
+
+	if (i >= max) {
+		*errp = -ENOSPC;
+		return 0;
+	}
+
+	block = ext4_group_first_block_no(sb, group) + EXT4_C2B(sbi, i);
+	ext4_mb_mark_bb(sb, block, 1, 1);
+	ar->len = 1;
+
+	*errp = 0;
+	return block;
+}
 
 /*
  * Main entry point into mballoc to allocate blocks
@@ -5646,7 +5711,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 
 	trace_ext4_request_blocks(ar);
 	if (sbi->s_mount_state & EXT4_FC_REPLAY)
-		return ext4_mb_new_blocks_simple(handle, ar, errp);
+		return ext4_mb_new_blocks_simple(ar, errp);
 
 	/* Allow to use superuser reservation for quota file */
 	if (ext4_is_quota_file(ar->inode))
@@ -5876,69 +5941,6 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 	return 0;
 }
 
-/*
- * Simple allocator for Ext4 fast commit replay path. It searches for blocks
- * linearly starting at the goal block and also excludes the blocks which
- * are going to be in use after fast commit replay.
- */
-static ext4_fsblk_t ext4_mb_new_blocks_simple(handle_t *handle,
-				struct ext4_allocation_request *ar, int *errp)
-{
-	struct buffer_head *bitmap_bh;
-	struct super_block *sb = ar->inode->i_sb;
-	ext4_group_t group;
-	ext4_grpblk_t blkoff;
-	ext4_grpblk_t max = EXT4_CLUSTERS_PER_GROUP(sb);
-	ext4_grpblk_t i = 0;
-	ext4_fsblk_t goal, block;
-	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
-
-	goal = ar->goal;
-	if (goal < le32_to_cpu(es->s_first_data_block) ||
-			goal >= ext4_blocks_count(es))
-		goal = le32_to_cpu(es->s_first_data_block);
-
-	ar->len = 0;
-	ext4_get_group_no_and_offset(sb, goal, &group, &blkoff);
-	for (; group < ext4_get_groups_count(sb); group++) {
-		bitmap_bh = ext4_read_block_bitmap(sb, group);
-		if (IS_ERR(bitmap_bh)) {
-			*errp = PTR_ERR(bitmap_bh);
-			pr_warn("Failed to read block bitmap\n");
-			return 0;
-		}
-
-		ext4_get_group_no_and_offset(sb,
-			max(ext4_group_first_block_no(sb, group), goal),
-			NULL, &blkoff);
-		while (1) {
-			i = mb_find_next_zero_bit(bitmap_bh->b_data, max,
-						blkoff);
-			if (i >= max)
-				break;
-			if (ext4_fc_replay_check_excluded(sb,
-				ext4_group_first_block_no(sb, group) + i)) {
-				blkoff = i + 1;
-			} else
-				break;
-		}
-		brelse(bitmap_bh);
-		if (i < max)
-			break;
-	}
-
-	if (group >= ext4_get_groups_count(sb) || i >= max) {
-		*errp = -ENOSPC;
-		return 0;
-	}
-
-	block = ext4_group_first_block_no(sb, group) + i;
-	ext4_mb_mark_bb(sb, block, 1, 1);
-	ar->len = 1;
-
-	return block;
-}
-
 static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
 					unsigned long count)
 {
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index bf048cbf3986..3f40746c90da 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -181,8 +181,8 @@ struct ext4_allocation_context {
 	ext4_group_t ac_last_optimal_group;
 	__u32 ac_groups_considered;
 	__u32 ac_flags;		/* allocation hints */
+	__u32 ac_groups_linear_remaining;
 	__u16 ac_groups_scanned;
-	__u16 ac_groups_linear_remaining;
 	__u16 ac_found;
 	__u16 ac_tail;
 	__u16 ac_buddy;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 14c977e1e4bb..e9501fb28477 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2901,7 +2901,7 @@ static int ext4_tmpfile(struct user_namespace *mnt_userns, struct inode *dir,
 	inode = ext4_new_inode_start_handle(mnt_userns, dir, mode,
 					    NULL, 0, NULL,
 					    EXT4_HT_DIR,
-			EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
+			EXT4_MAXQUOTAS_TRANS_BLOCKS(dir->i_sb) +
 			  4 + EXT4_XATTR_TRANS_BLOCKS);
 	handle = ext4_journal_current_handle();
 	err = PTR_ERR(inode);
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index f79705af3aca..37f3c2ebe6f8 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -3075,8 +3075,10 @@ ext4_xattr_block_cache_find(struct inode *inode,
 
 		bh = ext4_sb_bread(inode->i_sb, ce->e_value, REQ_PRIO);
 		if (IS_ERR(bh)) {
-			if (PTR_ERR(bh) == -ENOMEM)
+			if (PTR_ERR(bh) == -ENOMEM) {
+				mb_cache_entry_put(ea_block_cache, ce);
 				return NULL;
+			}
 			bh = NULL;
 			EXT4_ERROR_INODE(inode, "block %lu read error",
 					 (unsigned long)ce->e_value);
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7d3e7418d8fd..71a3714419f8 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -792,7 +792,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	 */
 	head = &im->ino_list;
 
-	/* loop for each orphan inode entry and write them in Jornal block */
+	/* loop for each orphan inode entry and write them in journal block */
 	list_for_each_entry(orphan, head, list) {
 		if (!page) {
 			page = f2fs_grab_meta_page(sbi, start_blk++);
@@ -1124,7 +1124,7 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 	} else {
 		/*
 		 * We should submit bio, since it exists several
-		 * wribacking dentry pages in the freeing inode.
+		 * writebacking dentry pages in the freeing inode.
 		 */
 		f2fs_submit_merged_write(sbi, DATA);
 		cond_resched();
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 88799c6ebd7d..be46dc41523b 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1247,7 +1247,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	loff_t psize;
 	int i, err;
 
-	/* we should bypass data pages to proceed the kworkder jobs */
+	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(cc->rpages[0]->mapping, -EIO);
 		goto out_free;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a8e99da8edc1..fa86eaf1d639 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2412,7 +2412,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
-			/* there are remained comressed pages, submit them */
+			/* there are remained compressed pages, submit them */
 			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
@@ -2811,7 +2811,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	trace_f2fs_writepage(page, DATA);
 
-	/* we should bypass data pages to proceed the kworkder jobs */
+	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
 		/*
@@ -2938,7 +2938,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 redirty_out:
 	redirty_page_for_writepage(wbc, page);
 	/*
-	 * pageout() in MM traslates EAGAIN, so calls handle_write_error()
+	 * pageout() in MM translates EAGAIN, so calls handle_write_error()
 	 * -> mapping_set_error() -> set_bit(AS_EIO, ...).
 	 * file_write_and_wait_range() will see EIO error, which is critical
 	 * to return value of fsync() followed by atomic_write failure to user.
@@ -2972,7 +2972,7 @@ static int f2fs_write_data_page(struct page *page,
 }
 
 /*
- * This function was copied from write_cche_pages from mm/page-writeback.c.
+ * This function was copied from write_cache_pages from mm/page-writeback.c.
  * The major change is making write step of cold data page separately from
  * warm/hot data page.
  */
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 6a9ab5c11939..30b8924d1493 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -112,7 +112,7 @@ struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
  * @prev_ex: extent before ofs
  * @next_ex: extent after ofs
  * @insert_p: insert point for new extent at ofs
- * in order to simpfy the insertion after.
+ * in order to simplify the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
 struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
@@ -573,7 +573,7 @@ static void f2fs_update_extent_tree_range(struct inode *inode,
 	if (!en)
 		en = next_en;
 
-	/* 2. invlidate all extent nodes in range [fofs, fofs + len - 1] */
+	/* 2. invalidate all extent nodes in range [fofs, fofs + len - 1] */
 	while (en && en->ei.fofs < end) {
 		unsigned int org_end;
 		int parts = 0;	/* # of parts current extent split into */
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 647d53df6a3d..e49fca9daf2d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2587,16 +2587,6 @@ static inline struct page *f2fs_pagecache_get_page(
 	return pagecache_get_page(mapping, index, fgp_flags, gfp_mask);
 }
 
-static inline void f2fs_copy_page(struct page *src, struct page *dst)
-{
-	char *src_kaddr = kmap(src);
-	char *dst_kaddr = kmap(dst);
-
-	memcpy(dst_kaddr, src_kaddr, PAGE_SIZE);
-	kunmap(dst);
-	kunmap(src);
-}
-
 static inline void f2fs_put_page(struct page *page, int unlock)
 {
 	if (!page)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 378ab6bd1b8d..be9536815e50 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -304,7 +304,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		 * for OPU case, during fsync(), node can be persisted before
 		 * data when lower device doesn't support write barrier, result
 		 * in data corruption after SPO.
-		 * So for strict fsync mode, force to use atomic write sematics
+		 * So for strict fsync mode, force to use atomic write semantics
 		 * to keep write order in between data/node and last node to
 		 * avoid potential data corruption.
 		 */
@@ -899,9 +899,14 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				  ATTR_GID | ATTR_TIMES_SET))))
 		return -EPERM;
 
-	if ((attr->ia_valid & ATTR_SIZE) &&
-		!f2fs_is_compress_backend_ready(inode))
-		return -EOPNOTSUPP;
+	if ((attr->ia_valid & ATTR_SIZE)) {
+		if (!f2fs_is_compress_backend_ready(inode))
+			return -EOPNOTSUPP;
+		if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED) &&
+			!IS_ALIGNED(attr->ia_size,
+			F2FS_BLK_TO_BYTES(F2FS_I(inode)->i_cluster_size)))
+			return -EINVAL;
+	}
 
 	err = setattr_prepare(&init_user_ns, dentry, attr);
 	if (err)
@@ -1276,7 +1281,10 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
-			f2fs_copy_page(psrc, pdst);
+
+			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
+
+			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
 			set_page_private_gcing(pdst);
 			f2fs_put_page(pdst, 1);
@@ -1757,11 +1765,6 @@ static long f2fs_fallocate(struct file *file, int mode,
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
-	if (f2fs_compressed_file(inode) &&
-		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
-		return -EOPNOTSUPP;
-
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
 			FALLOC_FL_INSERT_RANGE))
@@ -1769,6 +1772,17 @@ static long f2fs_fallocate(struct file *file, int mode,
 
 	inode_lock(inode);
 
+	/*
+	 * Pinned file should not support partial truncation since the block
+	 * can be used by applications.
+	 */
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
+		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
+			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))) {
+		ret = -EOPNOTSUPP;
+		goto out;
+	}
+
 	ret = file_modified(file);
 	if (ret)
 		goto out;
@@ -1804,7 +1818,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
 	/*
-	 * f2fs_relase_file is called at every close calls. So we should
+	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
 	 */
 	if (!(filp->f_mode & FMODE_WRITE) ||
@@ -2781,7 +2795,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
-	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst) ||
+		f2fs_is_pinned_file(src) || f2fs_is_pinned_file(dst)) {
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
@@ -3433,12 +3448,9 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	int ret;
 	int writecount;
 
-	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3446,7 +3458,7 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (ret)
 		return ret;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
 
@@ -3457,7 +3469,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3482,9 +3495,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3502,6 +3518,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -3612,12 +3630,9 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	unsigned int reserved_blocks = 0;
 	int ret;
 
-	if (!f2fs_sb_has_compression(F2FS_I_SB(inode)))
+	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3628,11 +3643,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (atomic_read(&F2FS_I(inode)->i_compr_blocks))
 		goto out;
 
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
 
-	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto unlock_inode;
 	}
@@ -3646,9 +3662,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 		struct dnode_of_data dn;
 		pgoff_t end_offset, count;
 
+		f2fs_lock_op(sbi);
+
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		ret = f2fs_get_dnode_of_data(&dn, page_idx, LOOKUP_NODE);
 		if (ret) {
+			f2fs_unlock_op(sbi);
 			if (ret == -ENOENT) {
 				page_idx = f2fs_get_next_page_offset(&dn,
 								page_idx);
@@ -3666,6 +3685,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -4017,10 +4038,7 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
@@ -4030,7 +4048,8 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4089,10 +4108,7 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
-	f2fs_balance_fs(F2FS_I_SB(inode), true);
+	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
 	inode_lock(inode);
@@ -4102,7 +4118,8 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 94e21136d579..ddb297409f41 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -330,6 +330,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		}
 	}
 
+	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	return true;
 }
 
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 0d6906644feb..80bc386ec698 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -959,7 +959,7 @@ static int f2fs_rename(struct inode *old_dir, struct dentry *old_dentry,
 
 	/*
 	 * If new_inode is null, the below renaming flow will
-	 * add a link in old_dir which can conver inline_dir.
+	 * add a link in old_dir which can convert inline_dir.
 	 * After then, if we failed to get the entry due to other
 	 * reasons like ENOMEM, we had to remove the new entry.
 	 * Instead of adding such the error handling routine, let's
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index dc85dd55314c..b6758887540f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1300,6 +1300,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	}
 	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
 		err = -EFSCORRUPTED;
+		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		goto fail;
 	}
@@ -1325,7 +1326,6 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 	return page;
-
 fail:
 	clear_node_page_dirty(page);
 	f2fs_put_page(page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index b454496ca67a..1c69dc91c329 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3772,7 +3772,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
 
 		/* submit cached LFS IO */
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
-		/* sbumit cached IPU IO */
+		/* submit cached IPU IO */
 		f2fs_submit_merged_ipu_write(sbi, NULL, page);
 		if (ordered) {
 			wait_on_page_writeback(page);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index e85ef6b14777..7fed3beb5e80 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -807,11 +807,13 @@ __acquires(&gl->gl_lockref.lock)
 	}
 
 	if (sdp->sd_lockstruct.ls_ops->lm_lock)	{
+		struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+
 		/* lock_dlm */
 		ret = sdp->sd_lockstruct.ls_ops->lm_lock(gl, target, lck_flags);
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
-		    test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags)) {
+		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
 			finish_xmote(gl, target);
 			gfs2_glock_queue_work(gl, 0);
 		} else if (ret) {
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 558932ad89d5..5a4b3550d833 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -82,6 +82,9 @@ static void __gfs2_ail_flush(struct gfs2_glock *gl, bool fsync,
 	GLOCK_BUG_ON(gl, !fsync && atomic_read(&gl->gl_ail_count));
 	spin_unlock(&sdp->sd_ail_lock);
 	gfs2_log_unlock(sdp);
+
+	if (gfs2_withdrawing(sdp))
+		gfs2_withdraw(sdp);
 }
 
 
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index cf345a86ef67..9cdece492845 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -351,7 +351,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 			fs_err(sdp, "telling LM to unmount\n");
 			lm->lm_unmount(sdp);
 		}
-		set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
 		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
diff --git a/fs/jffs2/xattr.c b/fs/jffs2/xattr.c
index acb4492f5970..5a31220f96f5 100644
--- a/fs/jffs2/xattr.c
+++ b/fs/jffs2/xattr.c
@@ -1111,6 +1111,9 @@ int do_jffs2_setxattr(struct inode *inode, int xprefix, const char *xname,
 		return rc;
 
 	request = PAD(sizeof(struct jffs2_raw_xattr) + strlen(xname) + 1 + size);
+	if (request > c->sector_size - c->cleanmarker_size)
+		return -ERANGE;
+
 	rc = jffs2_reserve_space(c, request, &length,
 				 ALLOC_NORMAL, JFFS2_SUMMARY_XATTR_SIZE);
 	if (rc) {
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 46a0a2d6962e..8fe143cad4a2 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -124,7 +124,7 @@ nfs41_callback_svc(void *vrqstp)
 		} else {
 			spin_unlock_bh(&serv->sv_cb_lock);
 			if (!kthread_should_stop())
-				schedule();
+				freezable_schedule();
 			finish_wait(&serv->sv_cb_waitq, &wq);
 		}
 	}
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index d0965b4676a5..f82264fcbb07 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -653,9 +653,9 @@ unsigned long nfs_block_bits(unsigned long bsize, unsigned char *nrbitsp)
 	if ((bsize & (bsize - 1)) || nrbitsp) {
 		unsigned char	nrbits;
 
-		for (nrbits = 31; nrbits && !(bsize & (1 << nrbits)); nrbits--)
+		for (nrbits = 31; nrbits && !(bsize & (1UL << nrbits)); nrbits--)
 			;
-		bsize = 1 << nrbits;
+		bsize = 1UL << nrbits;
 		if (nrbitsp)
 			*nrbitsp = nrbits;
 	}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 925ad7dbe6a0..167f2cc3c379 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5421,7 +5421,7 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 	struct rpc_message *msg = &task->tk_msg;
 
 	if (msg->rpc_proc == &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS] &&
-	    server->caps & NFS_CAP_READ_PLUS && task->tk_status == -ENOTSUPP) {
+	    task->tk_status == -ENOTSUPP) {
 		server->caps &= ~NFS_CAP_READ_PLUS;
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
 		rpc_restart_call_prepare(task);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index d7868cc52780..d452fa85a567 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2102,6 +2102,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_fs_locations *locations = NULL;
+	struct nfs_fattr *fattr;
 	struct inode *inode;
 	struct page *page;
 	int status, result;
@@ -2111,19 +2112,16 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 			(unsigned long long)server->fsid.minor,
 			clp->cl_hostname);
 
-	result = 0;
 	page = alloc_page(GFP_KERNEL);
 	locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
-	if (page == NULL || locations == NULL) {
-		dprintk("<-- %s: no memory\n", __func__);
-		goto out;
-	}
-	locations->fattr = nfs_alloc_fattr();
-	if (locations->fattr == NULL) {
+	fattr = nfs_alloc_fattr();
+	if (page == NULL || locations == NULL || fattr == NULL) {
 		dprintk("<-- %s: no memory\n", __func__);
+		result = 0;
 		goto out;
 	}
 
+	locations->fattr = fattr;
 	inode = d_inode(server->super->s_root);
 	result = nfs4_proc_get_locations(server, NFS_FH(inode), locations,
 					 page, cred);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 6779291efca9..e0ff2212866a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -38,6 +38,7 @@
 #include <linux/slab.h>
 #include <linux/kthread.h>
 #include <linux/namei.h>
+#include <linux/freezer.h>
 
 #include <linux/sunrpc/addr.h>
 #include <linux/nfs_ssc.h>
@@ -1322,7 +1323,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 
 			/* allow 20secs for mount/unmount for now - revisit */
 			if (kthread_should_stop() ||
-					(schedule_timeout(20*HZ) == 0)) {
+					(freezable_schedule_timeout(20*HZ) == 0)) {
 				finish_wait(&nn->nfsd_ssc_waitq, &wait);
 				kfree(work);
 				return nfserr_eagain;
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index a39206705dd1..6a2f779e0bad 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -60,7 +60,7 @@ static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 	if (argv->v_nmembs == 0)
 		return 0;
 
-	if (argv->v_size > PAGE_SIZE)
+	if ((size_t)argv->v_size > PAGE_SIZE)
 		return -EINVAL;
 
 	/*
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 17ff9589c474..1a5f2daa4a95 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2159,8 +2159,10 @@ static void nilfs_segctor_start_timer(struct nilfs_sc_info *sci)
 {
 	spin_lock(&sci->sc_state_lock);
 	if (!(sci->sc_state & NILFS_SEGCTOR_COMMIT)) {
-		sci->sc_timer.expires = jiffies + sci->sc_interval;
-		add_timer(&sci->sc_timer);
+		if (sci->sc_task) {
+			sci->sc_timer.expires = jiffies + sci->sc_interval;
+			add_timer(&sci->sc_timer);
+		}
 		sci->sc_state |= NILFS_SEGCTOR_COMMIT;
 	}
 	spin_unlock(&sci->sc_state_lock);
@@ -2207,19 +2209,36 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	struct nilfs_segctor_wait_request wait_req;
 	int err = 0;
 
-	spin_lock(&sci->sc_state_lock);
 	init_wait(&wait_req.wq);
 	wait_req.err = 0;
 	atomic_set(&wait_req.done, 0);
+	init_waitqueue_entry(&wait_req.wq, current);
+
+	/*
+	 * To prevent a race issue where completion notifications from the
+	 * log writer thread are missed, increment the request sequence count
+	 * "sc_seq_request" and insert a wait queue entry using the current
+	 * sequence number into the "sc_wait_request" queue at the same time
+	 * within the lock section of "sc_state_lock".
+	 */
+	spin_lock(&sci->sc_state_lock);
 	wait_req.seq = ++sci->sc_seq_request;
+	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
 	spin_unlock(&sci->sc_state_lock);
 
-	init_waitqueue_entry(&wait_req.wq, current);
-	add_wait_queue(&sci->sc_wait_request, &wait_req.wq);
-	set_current_state(TASK_INTERRUPTIBLE);
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		/*
+		 * Synchronize only while the log writer thread is alive.
+		 * Leave flushing out after the log writer thread exits to
+		 * the cleanup work in nilfs_segctor_destroy().
+		 */
+		if (!sci->sc_task)
+			break;
+
 		if (atomic_read(&wait_req.done)) {
 			err = wait_req.err;
 			break;
@@ -2235,7 +2254,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	return err;
 }
 
-static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
+static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
 {
 	struct nilfs_segctor_wait_request *wrq, *n;
 	unsigned long flags;
@@ -2243,7 +2262,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
 	spin_lock_irqsave(&sci->sc_wait_request.lock, flags);
 	list_for_each_entry_safe(wrq, n, &sci->sc_wait_request.head, wq.entry) {
 		if (!atomic_read(&wrq->done) &&
-		    nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq)) {
+		    (force || nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq))) {
 			wrq->err = err;
 			atomic_set(&wrq->done, 1);
 		}
@@ -2363,10 +2382,21 @@ int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
  */
 static void nilfs_segctor_accept(struct nilfs_sc_info *sci)
 {
+	bool thread_is_alive;
+
 	spin_lock(&sci->sc_state_lock);
 	sci->sc_seq_accepted = sci->sc_seq_request;
+	thread_is_alive = (bool)sci->sc_task;
 	spin_unlock(&sci->sc_state_lock);
-	del_timer_sync(&sci->sc_timer);
+
+	/*
+	 * This function does not race with the log writer thread's
+	 * termination.  Therefore, deleting sc_timer, which should not be
+	 * done after the log writer thread exits, can be done safely outside
+	 * the area protected by sc_state_lock.
+	 */
+	if (thread_is_alive)
+		del_timer_sync(&sci->sc_timer);
 }
 
 /**
@@ -2383,7 +2413,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 	if (mode == SC_LSEG_SR) {
 		sci->sc_state &= ~NILFS_SEGCTOR_COMMIT;
 		sci->sc_seq_done = sci->sc_seq_accepted;
-		nilfs_segctor_wakeup(sci, err);
+		nilfs_segctor_wakeup(sci, err, false);
 		sci->sc_flush_request = 0;
 	} else {
 		if (mode == SC_FLUSH_FILE)
@@ -2392,7 +2422,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 			sci->sc_flush_request &= ~FLUSH_DAT_BIT;
 
 		/* re-enable timer if checkpoint creation was not done */
-		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) &&
+		if ((sci->sc_state & NILFS_SEGCTOR_COMMIT) && sci->sc_task &&
 		    time_before(jiffies, sci->sc_timer.expires))
 			add_timer(&sci->sc_timer);
 	}
@@ -2582,6 +2612,7 @@ static int nilfs_segctor_thread(void *arg)
 	int timeout = 0;
 
 	sci->sc_timer_task = current;
+	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	/* start sync. */
 	sci->sc_task = current;
@@ -2648,6 +2679,7 @@ static int nilfs_segctor_thread(void *arg)
  end_thread:
 	/* end sync. */
 	sci->sc_task = NULL;
+	del_timer_sync(&sci->sc_timer);
 	wake_up(&sci->sc_wait_task); /* for nilfs_segctor_kill_thread() */
 	spin_unlock(&sci->sc_state_lock);
 	return 0;
@@ -2711,7 +2743,6 @@ static struct nilfs_sc_info *nilfs_segctor_new(struct super_block *sb,
 	INIT_LIST_HEAD(&sci->sc_gc_inodes);
 	INIT_LIST_HEAD(&sci->sc_iput_queue);
 	INIT_WORK(&sci->sc_iput_work, nilfs_iput_work_func);
-	timer_setup(&sci->sc_timer, nilfs_construction_timeout, 0);
 
 	sci->sc_interval = HZ * NILFS_SC_DEFAULT_TIMEOUT;
 	sci->sc_mjcp_freq = HZ * NILFS_SC_DEFAULT_SR_FREQ;
@@ -2765,6 +2796,13 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 		|| sci->sc_seq_request != sci->sc_seq_done);
 	spin_unlock(&sci->sc_state_lock);
 
+	/*
+	 * Forcibly wake up tasks waiting in nilfs_segctor_sync(), which can
+	 * be called from delayed iput() via nilfs_evict_inode() and can race
+	 * with the above log writer thread termination.
+	 */
+	nilfs_segctor_wakeup(sci, 0, true);
+
 	if (flush_work(&sci->sc_iput_work))
 		flag = true;
 
@@ -2790,7 +2828,6 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
 
 	down_write(&nilfs->ns_segctor_sem);
 
-	del_timer_sync(&sci->sc_timer);
 	kfree(sci);
 }
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 72cdfa8727d3..98f57d0c702e 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -475,6 +475,7 @@ static int ntfs_readdir(struct file *file, struct dir_context *ctx)
 		vbo = (u64)bit << index_bits;
 		if (vbo >= i_size) {
 			ntfs_inode_err(dir, "Looks like your dir is corrupt");
+			ctx->pos = eod;
 			err = -EINVAL;
 			goto out;
 		}
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 6ba1357f3ed4..369ab64a0b84 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -1181,7 +1181,8 @@ static int read_log_page(struct ntfs_log *log, u32 vbo,
 static int log_read_rst(struct ntfs_log *log, u32 l_size, bool first,
 			struct restart_info *info)
 {
-	u32 skip, vbo;
+	u32 skip;
+	u64 vbo;
 	struct RESTART_HDR *r_page = NULL;
 
 	/* Determine which restart area we are looking for. */
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 76935562d5ce..a069ae7a748e 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1538,6 +1538,11 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out1;
 	}
 
+	if (data_size <= le64_to_cpu(alloc->nres.data_size)) {
+		/* Reuse index. */
+		goto out;
+	}
+
 	/* Increase allocation. */
 	err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
 			    &indx->alloc_run, data_size, &data_size, true,
@@ -1548,6 +1553,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out1;
 	}
 
+out:
 	*vbn = bit << indx->idx2vbn_bits;
 
 	return 0;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0ff673bb4b2b..ff45ad967fb8 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -37,7 +37,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	bool is_dir;
 	unsigned long ino = inode->i_ino;
 	u32 rp_fa = 0, asize, t32;
-	u16 roff, rsize, names = 0;
+	u16 roff, rsize, names = 0, links = 0;
 	const struct ATTR_FILE_NAME *fname = NULL;
 	const struct INDEX_ROOT *root;
 	struct REPARSE_DATA_BUFFER rp; // 0x18 bytes
@@ -190,11 +190,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		    rsize < SIZEOF_ATTRIBUTE_FILENAME)
 			goto out;
 
+		names += 1;
 		fname = Add2Ptr(attr, roff);
 		if (fname->type == FILE_NAME_DOS)
 			goto next_attr;
 
-		names += 1;
+		links += 1;
 		if (name && name->len == fname->name_len &&
 		    !ntfs_cmp_names_cpu(name, (struct le_str *)&fname->name_len,
 					NULL, false))
@@ -421,7 +422,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		ni->mi.dirty = true;
 	}
 
-	set_nlink(inode, names);
+	set_nlink(inode, links);
 
 	if (S_ISDIR(mode)) {
 		ni->std_fa |= FILE_ATTRIBUTE_DIRECTORY;
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index ba26a465b309..324c0b036fdc 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -59,7 +59,7 @@ struct GUID {
 struct cpu_str {
 	u8 len;
 	u8 unused;
-	u16 name[10];
+	u16 name[];
 };
 
 struct le_str {
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index ac43e4a6d57d..383fc3437f02 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -508,16 +508,9 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
 	if (aoff + asize > used)
 		return false;
 
-	if (ni && is_attr_indexed(attr)) {
+	if (ni && is_attr_indexed(attr) && attr->type == ATTR_NAME) {
 		u16 links = le16_to_cpu(ni->mi.mrec->hard_links);
-		struct ATTR_FILE_NAME *fname =
-			attr->type != ATTR_NAME ?
-				NULL :
-				resident_data_ex(attr,
-						 SIZEOF_ATTRIBUTE_FILENAME);
-		if (fname && fname->type == FILE_NAME_DOS) {
-			/* Do not decrease links count deleting DOS name. */
-		} else if (!links) {
+		if (!links) {
 			/* minor error. Not critical. */
 		} else {
 			ni->mi.mrec->hard_links = cpu_to_le16(links - 1);
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index fbaf1c84311b..0a71075042bb 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1448,8 +1448,6 @@ static int __init init_ntfs_fs(void)
 {
 	int err;
 
-	pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
-
 	if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
 		pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
 	if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index f825176ff4ed..07a312bf9be7 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -355,10 +355,10 @@ static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 	return inode;
 }
 
-static int openprom_remount(struct super_block *sb, int *flags, char *data)
+static int openpromfs_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_NOATIME;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -366,7 +366,6 @@ static const struct super_operations openprom_sops = {
 	.alloc_inode	= openprom_alloc_inode,
 	.free_inode	= openprom_free_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= openprom_remount,
 };
 
 static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
@@ -416,6 +415,7 @@ static int openpromfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations openpromfs_context_ops = {
 	.get_tree	= openpromfs_get_tree,
+	.reconfigure	= openpromfs_reconfigure,
 };
 
 static int openpromfs_init_fs_context(struct fs_context *fc)
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 5190fd48d318..05cd782db905 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -240,9 +240,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_turn_on_peripheral(struct mipi_dsi_device *dsi);
 int mipi_dsi_set_maximum_return_packet_size(struct mipi_dsi_device *dsi,
 					    u16 value);
-ssize_t mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
-ssize_t mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
-				       const struct drm_dsc_picture_parameter_set *pps);
+int mipi_dsi_compression_mode(struct mipi_dsi_device *dsi, bool enable);
+int mipi_dsi_picture_parameter_set(struct mipi_dsi_device *dsi,
+				   const struct drm_dsc_picture_parameter_set *pps);
 
 ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
diff --git a/include/linux/dev_printk.h b/include/linux/dev_printk.h
index 8904063d4c9f..65eec5be8ccb 100644
--- a/include/linux/dev_printk.h
+++ b/include/linux/dev_printk.h
@@ -129,6 +129,16 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 		_dev_printk(level, dev, fmt, ##__VA_ARGS__);		\
 	})
 
+/*
+ * Dummy dev_printk for disabled debugging statements to use whilst maintaining
+ * gcc's format checking.
+ */
+#define dev_no_printk(level, dev, fmt, ...)				\
+	({								\
+		if (0)							\
+			_dev_printk(level, dev, fmt, ##__VA_ARGS__);	\
+	})
+
 /*
  * #defines for all the dev_<level> macros to prefix with whatever
  * possible use of #define dev_fmt(fmt) ...
@@ -158,10 +168,7 @@ void _dev_info(const struct device *dev, const char *fmt, ...)
 	dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #else
 #define dev_dbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #ifdef CONFIG_PRINTK
@@ -247,20 +254,14 @@ do {									\
 } while (0)
 #else
 #define dev_dbg_ratelimited(dev, fmt, ...)				\
-do {									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-} while (0)
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 #ifdef VERBOSE_DEBUG
 #define dev_vdbg	dev_dbg
 #else
 #define dev_vdbg(dev, fmt, ...)						\
-({									\
-	if (0)								\
-		dev_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__); \
-})
+	dev_no_printk(KERN_DEBUG, dev, dev_fmt(fmt), ##__VA_ARGS__)
 #endif
 
 /*
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index 27cb706275db..1c446c2ce2f9 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -7,6 +7,27 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-bridge.h>
 
+struct fpga_region;
+
+/**
+ * struct fpga_region_info - collection of parameters an FPGA Region
+ * @mgr: fpga region manager
+ * @compat_id: FPGA region id for compatibility check.
+ * @priv: fpga region private data
+ * @get_bridges: optional function to get bridges to a list
+ *
+ * fpga_region_info contains parameters for the register_full function.
+ * These are separated into an info structure because they some are optional
+ * others could be added to in the future. The info structure facilitates
+ * maintaining a stable API.
+ */
+struct fpga_region_info {
+	struct fpga_manager *mgr;
+	struct fpga_compat_id *compat_id;
+	void *priv;
+	int (*get_bridges)(struct fpga_region *region);
+};
+
 /**
  * struct fpga_region - FPGA Region structure
  * @dev: FPGA Region device
@@ -15,6 +36,7 @@
  * @mgr: FPGA manager
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
+ * @ops_owner: module containing the get_bridges function
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -25,6 +47,7 @@ struct fpga_region {
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
+	struct module *ops_owner;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
@@ -37,15 +60,17 @@ struct fpga_region *fpga_region_class_find(
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
-struct fpga_region
-*fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-		    int (*get_bridges)(struct fpga_region *));
-void fpga_region_free(struct fpga_region *region);
-int fpga_region_register(struct fpga_region *region);
-void fpga_region_unregister(struct fpga_region *region);
+#define fpga_region_register_full(parent, info) \
+	__fpga_region_register_full(parent, info, THIS_MODULE)
+struct fpga_region *
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner);
 
-struct fpga_region
-*devm_fpga_region_create(struct device *dev, struct fpga_manager *mgr,
-			int (*get_bridges)(struct fpga_region *));
+#define fpga_region_register(parent, mgr, get_bridges) \
+	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
+struct fpga_region *
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner);
+void fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 4ae2f2908f99..d4a1567c94d0 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -20,6 +20,7 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
 			 unsigned int debounce);
 int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 			 unsigned int idx, unsigned int debounce);
+int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
 void mmc_gpio_set_cd_isr(struct mmc_host *host,
 			 irqreturn_t (*isr)(int irq, void *dev_id));
 int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 9497f6b98339..c4fb84822111 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -129,7 +129,7 @@ struct va_format {
 #define no_printk(fmt, ...)				\
 ({							\
 	if (0)						\
-		printk(fmt, ##__VA_ARGS__);		\
+		_printk(fmt, ##__VA_ARGS__);		\
 	0;						\
 })
 
diff --git a/include/media/cec.h b/include/media/cec.h
index 77346f757036..38eb9334d854 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -120,14 +120,16 @@ struct cec_adap_ops {
 	int (*adap_log_addr)(struct cec_adapter *adap, u8 logical_addr);
 	int (*adap_transmit)(struct cec_adapter *adap, u8 attempts,
 			     u32 signal_free_time, struct cec_msg *msg);
+	void (*adap_nb_transmit_canceled)(struct cec_adapter *adap,
+					  const struct cec_msg *msg);
 	void (*adap_status)(struct cec_adapter *adap, struct seq_file *file);
 	void (*adap_free)(struct cec_adapter *adap);
 
-	/* Error injection callbacks */
+	/* Error injection callbacks, called without adap->lock held */
 	int (*error_inj_show)(struct cec_adapter *adap, struct seq_file *sf);
 	bool (*error_inj_parse_line)(struct cec_adapter *adap, char *line);
 
-	/* High-level CEC message callback */
+	/* High-level CEC message callback, called without adap->lock held */
 	int (*received)(struct cec_adapter *adap, struct cec_msg *msg);
 };
 
@@ -163,6 +165,11 @@ struct cec_adap_ops {
  * @wait_queue:		queue of transmits waiting for a reply
  * @transmitting:	CEC messages currently being transmitted
  * @transmit_in_progress: true if a transmit is in progress
+ * @transmit_in_progress_aborted: true if a transmit is in progress is to be
+ *			aborted. This happens if the logical address is
+ *			invalidated while the transmit is ongoing. In that
+ *			case the transmit will finish, but will not retransmit
+ *			and be marked as ABORTED.
  * @kthread_config:	kthread used to configure a CEC adapter
  * @config_completion:	used to signal completion of the config kthread
  * @kthread:		main CEC processing thread
@@ -175,6 +182,7 @@ struct cec_adap_ops {
  * @needs_hpd:		if true, then the HDMI HotPlug Detect pin must be high
  *	in order to transmit or receive CEC messages. This is usually a HW
  *	limitation.
+ * @is_enabled:		the CEC adapter is enabled
  * @is_configuring:	the CEC adapter is configuring (i.e. claiming LAs)
  * @is_configured:	the CEC adapter is configured (i.e. has claimed LAs)
  * @cec_pin_is_high:	if true then the CEC pin is high. Only used with the
@@ -217,6 +225,7 @@ struct cec_adapter {
 	struct list_head wait_queue;
 	struct cec_data *transmitting;
 	bool transmit_in_progress;
+	bool transmit_in_progress_aborted;
 
 	struct task_struct *kthread_config;
 	struct completion config_completion;
@@ -231,6 +240,8 @@ struct cec_adapter {
 
 	u16 phys_addr;
 	bool needs_hpd;
+	bool is_enabled;
+	bool is_claiming_log_addrs;
 	bool is_configuring;
 	bool is_configured;
 	bool cec_pin_is_high;
diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 632086b2f644..3ae2fda29507 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -24,7 +24,7 @@ struct dst_ops {
 	void			(*destroy)(struct dst_entry *);
 	void			(*ifdown)(struct dst_entry *,
 					  struct net_device *dev, int how);
-	struct dst_entry *	(*negative_advice)(struct dst_entry *);
+	void			(*negative_advice)(struct sock *sk, struct dst_entry *);
 	void			(*link_failure)(struct sk_buff *);
 	void			(*update_pmtu)(struct dst_entry *dst, struct sock *sk,
 					       struct sk_buff *skb, u32 mtu,
diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtables.h
index 56f1286583d3..f89320b6fee3 100644
--- a/include/net/inet6_hashtables.h
+++ b/include/net/inet6_hashtables.h
@@ -48,6 +48,22 @@ struct sock *__inet6_lookup_established(struct net *net,
 					const u16 hnum, const int dif,
 					const int sdif);
 
+typedef u32 (inet6_ehashfn_t)(const struct net *net,
+			       const struct in6_addr *laddr, const u16 lport,
+			       const struct in6_addr *faddr, const __be16 fport);
+
+inet6_ehashfn_t inet6_ehashfn;
+
+INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
+
+struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+				    struct sk_buff *skb, int doff,
+				    const struct in6_addr *saddr,
+				    __be16 sport,
+				    const struct in6_addr *daddr,
+				    unsigned short hnum,
+				    inet6_ehashfn_t *ehashfn);
+
 struct sock *inet6_lookup_listener(struct net *net,
 				   struct inet_hashinfo *hashinfo,
 				   struct sk_buff *skb, int doff,
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index a7a8e66a1bad..5849f816402d 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -279,6 +279,20 @@ struct sock *__inet_lookup_established(struct net *net,
 				       const __be32 daddr, const u16 hnum,
 				       const int dif, const int sdif);
 
+typedef u32 (inet_ehashfn_t)(const struct net *net,
+			      const __be32 laddr, const __u16 lport,
+			      const __be32 faddr, const __be16 fport);
+
+inet_ehashfn_t inet_ehashfn;
+
+INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
+
+struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+				   struct sk_buff *skb, int doff,
+				   __be32 saddr, __be16 sport,
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t *ehashfn);
+
 static inline struct sock *
 	inet_lookup_established(struct net *net, struct inet_hashinfo *hashinfo,
 				const __be32 saddr, const __be16 sport,
@@ -348,10 +362,6 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 			     refcounted);
 }
 
-u32 inet6_ehashfn(const struct net *net,
-		  const struct in6_addr *laddr, const u16 lport,
-		  const struct in6_addr *faddr, const __be16 fport);
-
 static inline void sk_daddr_set(struct sock *sk, __be32 addr)
 {
 	sk->sk_daddr = addr; /* alias of inet_daddr */
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 9dfa11d4224d..315869fc3fcb 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -74,16 +74,6 @@ struct nft_payload {
 	u8			dreg;
 };
 
-struct nft_payload_set {
-	enum nft_payload_bases	base:8;
-	u8			offset;
-	u8			len;
-	u8			sreg;
-	u8			csum_type;
-	u8			csum_offset;
-	u8			csum_flags;
-};
-
 extern const struct nft_expr_ops nft_payload_fast_ops;
 
 extern const struct nft_expr_ops nft_bitwise_fast_ops;
diff --git a/include/net/sock.h b/include/net/sock.h
index 44ebec3fdda6..b8de579b916e 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2082,17 +2082,10 @@ sk_dst_get(struct sock *sk)
 
 static inline void __dst_negative_advice(struct sock *sk)
 {
-	struct dst_entry *ndst, *dst = __sk_dst_get(sk);
+	struct dst_entry *dst = __sk_dst_get(sk);
 
-	if (dst && dst->ops->negative_advice) {
-		ndst = dst->ops->negative_advice(dst);
-
-		if (ndst != dst) {
-			rcu_assign_pointer(sk->sk_dst_cache, ndst);
-			sk_tx_queue_clear(sk);
-			WRITE_ONCE(sk->sk_dst_pending_confirm, 0);
-		}
-	}
+	if (dst && dst->ops->negative_advice)
+		dst->ops->negative_advice(sk, dst);
 }
 
 static inline void dst_negative_advice(struct sock *sk)
diff --git a/include/soc/qcom/cmd-db.h b/include/soc/qcom/cmd-db.h
index c8bb56e6852a..47a6cab75e63 100644
--- a/include/soc/qcom/cmd-db.h
+++ b/include/soc/qcom/cmd-db.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved. */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
 
 #ifndef __QCOM_COMMAND_DB_H__
 #define __QCOM_COMMAND_DB_H__
@@ -21,6 +24,8 @@ u32 cmd_db_read_addr(const char *resource_id);
 
 const void *cmd_db_read_aux_data(const char *resource_id, size_t *len);
 
+bool cmd_db_match_resource_addr(u32 addr1, u32 addr2);
+
 enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id);
 
 int cmd_db_ready(void);
@@ -31,6 +36,9 @@ static inline u32 cmd_db_read_addr(const char *resource_id)
 static inline const void *cmd_db_read_aux_data(const char *resource_id, size_t *len)
 { return ERR_PTR(-ENODEV); }
 
+static inline bool cmd_db_match_resource_addr(u32 addr1, u32 addr2)
+{ return false; }
+
 static inline enum cmd_db_hw_type cmd_db_read_slave_id(const char *resource_id)
 { return -ENODEV; }
 
diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index 4d8ef71090af..97a434d02135 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -12,6 +12,8 @@
 #define DAPM_DIRECT "(direct)"
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
+TRACE_DEFINE_ENUM(SND_SOC_DAPM_DIR_OUT);
+
 struct snd_soc_jack;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bdb5f2ba769d..6bfb510656ab 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6089,7 +6089,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ff6c36aec27c..ea005700c8ce 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -6621,6 +6621,8 @@ static int io_req_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	switch (req->opcode) {
 	case IORING_OP_NOP:
+		if (READ_ONCE(sqe->rw_flags))
+			return -EINVAL;
 		return 0;
 	case IORING_OP_READV:
 	case IORING_OP_READ_FIXED:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 94d952967fbf..07ca1157f97c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5568,7 +5568,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -5579,6 +5580,11 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 		if (eatype == BPF_TRACE_ITER)
 			return true;
 		break;
+	case BPF_PROG_TYPE_SOCK_OPS:
+		/* map_update allowed only via dedicated helpers with event type checks */
+		if (func_id == BPF_FUNC_map_delete_elem)
+			return true;
+		break;
 	case BPF_PROG_TYPE_SOCKET_FILTER:
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
@@ -5666,7 +5672,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -5676,7 +5681,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6905079c15c2..82df5a07a869 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1938,7 +1938,7 @@ bool current_cpuset_is_being_rebound(void)
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
 {
 #ifdef CONFIG_SMP
-	if (val < -1 || val >= sched_domain_level_max)
+	if (val < -1 || val > sched_domain_level_max + 1)
 		return -EINVAL;
 #endif
 
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6735ac36b718..a3b4b55d2e2e 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -172,6 +172,33 @@ char kdb_getchar(void)
 	unreachable();
 }
 
+/**
+ * kdb_position_cursor() - Place cursor in the correct horizontal position
+ * @prompt: Nil-terminated string containing the prompt string
+ * @buffer: Nil-terminated string containing the entire command line
+ * @cp: Cursor position, pointer the character in buffer where the cursor
+ *      should be positioned.
+ *
+ * The cursor is positioned by sending a carriage-return and then printing
+ * the content of the line until we reach the correct cursor position.
+ *
+ * There is some additional fine detail here.
+ *
+ * Firstly, even though kdb_printf() will correctly format zero-width fields
+ * we want the second call to kdb_printf() to be conditional. That keeps things
+ * a little cleaner when LOGGING=1.
+ *
+ * Secondly, we can't combine everything into one call to kdb_printf() since
+ * that renders into a fixed length buffer and the combined print could result
+ * in unwanted truncation.
+ */
+static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
+{
+	kdb_printf("\r%s", kdb_prompt_str);
+	if (cp > buffer)
+		kdb_printf("%.*s", (int)(cp - buffer), buffer);
+}
+
 /*
  * kdb_read
  *
@@ -200,7 +227,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 						 * and null byte */
 	char *lastchar;
 	char *p_tmp;
-	char tmp;
 	static char tmpbuffer[CMD_BUFLEN];
 	int len = strlen(buffer);
 	int len_tmp;
@@ -237,12 +263,8 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			*(--lastchar) = '\0';
 			--cp;
-			kdb_printf("\b%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("\b%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 13: /* enter */
@@ -259,19 +281,14 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			memcpy(tmpbuffer, cp+1, lastchar - cp - 1);
 			memcpy(cp, tmpbuffer, lastchar - cp - 1);
 			*(--lastchar) = '\0';
-			kdb_printf("%s \r", cp);
-			tmp = *cp;
-			*cp = '\0';
-			kdb_printf(kdb_prompt_str);
-			kdb_printf("%s", buffer);
-			*cp = tmp;
+			kdb_printf("%s ", cp);
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 1: /* Home */
 		if (cp > buffer) {
-			kdb_printf("\r");
-			kdb_printf(kdb_prompt_str);
 			cp = buffer;
+			kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		}
 		break;
 	case 5: /* End */
@@ -287,11 +304,10 @@ static char *kdb_read(char *buffer, size_t bufsize)
 		}
 		break;
 	case 14: /* Down */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
+	case 16: /* Up */
+		kdb_printf("\r%*c\r",
+			   (int)(strlen(kdb_prompt_str) + (lastchar - buffer)),
+			   ' ');
 		*lastchar = (char)key;
 		*(lastchar+1) = '\0';
 		return lastchar;
@@ -301,15 +317,6 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			++cp;
 		}
 		break;
-	case 16: /* Up */
-		memset(tmpbuffer, ' ',
-		       strlen(kdb_prompt_str) + (lastchar-buffer));
-		*(tmpbuffer+strlen(kdb_prompt_str) +
-		  (lastchar-buffer)) = '\0';
-		kdb_printf("\r%s\r", tmpbuffer);
-		*lastchar = (char)key;
-		*(lastchar+1) = '\0';
-		return lastchar;
 	case 9: /* Tab */
 		if (tab < 2)
 			++tab;
@@ -353,15 +360,25 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			kdb_printf("\n");
 			kdb_printf(kdb_prompt_str);
 			kdb_printf("%s", buffer);
+			if (cp != lastchar)
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 		} else if (tab != 2 && count > 0) {
-			len_tmp = strlen(p_tmp);
-			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
-			len_tmp = strlen(p_tmp);
-			strncpy(cp, p_tmp+len, len_tmp-len + 1);
-			len = len_tmp - len;
-			kdb_printf("%s", cp);
-			cp += len;
-			lastchar += len;
+			/* How many new characters do we want from tmpbuffer? */
+			len_tmp = strlen(p_tmp) - len;
+			if (lastchar + len_tmp >= bufend)
+				len_tmp = bufend - lastchar;
+
+			if (len_tmp) {
+				/* + 1 ensures the '\0' is memmove'd */
+				memmove(cp+len_tmp, cp, (lastchar-cp) + 1);
+				memcpy(cp, p_tmp+len, len_tmp);
+				kdb_printf("%s", cp);
+				cp += len_tmp;
+				lastchar += len_tmp;
+				if (cp != lastchar)
+					kdb_position_cursor(kdb_prompt_str,
+							    buffer, cp);
+			}
 		}
 		kdb_nextline = 1; /* reset output line number */
 		break;
@@ -372,13 +389,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
 				memcpy(cp+1, tmpbuffer, lastchar - cp);
 				*++lastchar = '\0';
 				*cp = key;
-				kdb_printf("%s\r", cp);
+				kdb_printf("%s", cp);
 				++cp;
-				tmp = *cp;
-				*cp = '\0';
-				kdb_printf(kdb_prompt_str);
-				kdb_printf("%s", buffer);
-				*cp = tmp;
+				kdb_position_cursor(kdb_prompt_str, buffer, cp);
 			} else {
 				*++lastchar = '\0';
 				*cp++ = key;
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 9b9af1bd6be3..b7f8bb7a1e5c 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -124,7 +124,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	struct task_struct **tsk;
 	int threads = map->bparam.threads;
 	int node = map->bparam.node;
-	const cpumask_t *cpu_mask = cpumask_of_node(node);
 	u64 loops;
 	int ret = 0;
 	int i;
@@ -145,7 +144,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		}
 
 		if (node != NUMA_NO_NODE)
-			kthread_bind_mask(tsk[i], cpu_mask);
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
 	}
 
 	/* clear the old value in the previous benchmark */
@@ -231,7 +230,8 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		}
 
 		if (map->bparam.node != NUMA_NO_NODE &&
-		    !node_possible(map->bparam.node)) {
+		    (map->bparam.node < 0 || map->bparam.node >= MAX_NUMNODES ||
+		     !node_possible(map->bparam.node))) {
 			pr_err("invalid numa node\n");
 			return -EINVAL;
 		}
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 39a41c56ad4f..24fd9db84cfb 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -69,6 +69,14 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 	}
 
+	/*
+	 * Complete an eventually pending irq move cleanup. If this
+	 * interrupt was moved in hard irq context, then the vectors need
+	 * to be cleaned up. It can't wait until this interrupt actually
+	 * happens and this CPU was involved.
+	 */
+	irq_force_complete_move(desc);
+
 	/*
 	 * No move required, if:
 	 * - Interrupt is per cpu
@@ -87,14 +95,6 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 	}
 
-	/*
-	 * Complete an eventually pending irq move cleanup. If this
-	 * interrupt was moved in hard irq context, then the vectors need
-	 * to be cleaned up. It can't wait until this interrupt actually
-	 * happens and this CPU was involved.
-	 */
-	irq_force_complete_move(desc);
-
 	/*
 	 * If there is a setaffinity pending, then try to reuse the pending
 	 * mask, so the last change of the affinity does not get lost. If
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 25b8ea91168e..b43da6201b9a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10828,7 +10828,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg_get_cfs_burst(tg);
+	u64 burst = tg->cfs_bandwidth.burst;
 	u64 quota;
 	int ret;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4a1393405a6f..94fcd585eb7f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5746,21 +5746,41 @@ static inline unsigned long cpu_util(int cpu);
 
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
-	unsigned long rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
+	unsigned long  rq_util_min, rq_util_max;
+
+	if (!sched_energy_enabled())
+		return false;
+
+	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
+	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
 	return !util_fits_cpu(cpu_util(cpu), rq_util_min, rq_util_max, cpu);
 }
 
-static inline void update_overutilized_status(struct rq *rq)
+static inline void set_rd_overutilized_status(struct root_domain *rd,
+					      unsigned int status)
 {
-	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu)) {
-		WRITE_ONCE(rq->rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rq->rd, SG_OVERUTILIZED);
-	}
+	if (!sched_energy_enabled())
+		return;
+
+	WRITE_ONCE(rd->overutilized, status);
+	trace_sched_overutilized_tp(rd, !!status);
+}
+
+static inline void check_update_overutilized_status(struct rq *rq)
+{
+	/*
+	 * overutilized field is used for load balancing decisions only
+	 * if energy aware scheduler is being used
+	 */
+	if (!sched_energy_enabled())
+		return;
+
+	if (!READ_ONCE(rq->rd->overutilized) && cpu_overutilized(rq->cpu))
+		set_rd_overutilized_status(rq->rd, SG_OVERUTILIZED);
 }
 #else
-static inline void update_overutilized_status(struct rq *rq) { }
+static inline void check_update_overutilized_status(struct rq *rq) { }
 #endif
 
 /* Runqueue only has SCHED_IDLE tasks enqueued */
@@ -5868,7 +5888,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * and the following generally works well enough in practice.
 	 */
 	if (!task_new)
-		update_overutilized_status(rq);
+		check_update_overutilized_status(rq);
 
 enqueue_throttle:
 	if (cfs_bandwidth_used()) {
@@ -9577,19 +9597,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->fbq_type = fbq_classify_group(&sds->busiest_stat);
 
 	if (!env->sd->parent) {
-		struct root_domain *rd = env->dst_rq->rd;
-
 		/* update overload indicator if we are at root domain */
-		WRITE_ONCE(rd->overload, sg_status & SG_OVERLOAD);
+		WRITE_ONCE(env->dst_rq->rd->overload, sg_status & SG_OVERLOAD);
 
 		/* Update over-utilization (tipping point, U >= 0) indicator */
-		WRITE_ONCE(rd->overutilized, sg_status & SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, sg_status & SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd,
+					   sg_status & SG_OVERUTILIZED);
 	} else if (sg_status & SG_OVERUTILIZED) {
-		struct root_domain *rd = env->dst_rq->rd;
-
-		WRITE_ONCE(rd->overutilized, SG_OVERUTILIZED);
-		trace_sched_overutilized_tp(rd, SG_OVERUTILIZED);
+		set_rd_overutilized_status(env->dst_rq->rd, SG_OVERUTILIZED);
 	}
 
 	update_idle_cpu_scan(env, sum_util);
@@ -11460,7 +11475,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
-	update_overutilized_status(task_rq(curr));
+	check_update_overutilized_status(task_rq(curr));
 
 	task_tick_core(rq, curr);
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4e8698e62f07..8c82ca3aa652 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1405,7 +1405,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..dc60f0c66a25 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -512,7 +512,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -567,8 +567,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -588,6 +587,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
+asmlinkage __visible void __softirq_entry __do_softirq(void)
+{
+	handle_softirqs(false);
+}
+
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -918,7 +922,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2ec1473146ca..f9f0c198cb43 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1568,6 +1568,11 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
+ *
+ * Callers of this function need to guarantee that the list of pages doesn't get
+ * modified during the check. In particular, if it's possible that the function
+ * is invoked with concurrent readers which can swap in a new reader page then
+ * the caller should take cpu_buffer->reader_lock.
  */
 static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
@@ -2289,8 +2294,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
+			unsigned long flags;
+
 			cpu_buffer = buffer->buffers[cpu];
+			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 8662dc6cb509..e8b13b62029d 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -39,7 +39,7 @@ static void test_next_pointer(struct kunit *test)
 
 	ptr_addr = (unsigned long *)(p + s->offset);
 	tmp = *ptr_addr;
-	p[s->offset] = 0x12;
+	p[s->offset] = ~p[s->offset];
 
 	/*
 	 * Expecting three errors.
diff --git a/net/9p/client.c b/net/9p/client.c
index ead458486fdc..bf29462c919b 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -233,6 +233,8 @@ static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
 	if (!fc->sdata)
 		return -ENOMEM;
 	fc->capacity = alloc_msize;
+	fc->id = 0;
+	fc->tag = P9_NOTAG;
 	return 0;
 }
 
diff --git a/net/core/dev.c b/net/core/dev.c
index f80bc2ca888a..e86ef1a1647e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10549,8 +10549,9 @@ static void netdev_wait_allrefs(struct net_device *dev)
 			rebroadcast_time = jiffies;
 		}
 
+		rcu_barrier();
+
 		if (!wait) {
-			rcu_barrier();
 			wait = WAIT_REFS_MIN_MSECS;
 		} else {
 			msleep(wait);
diff --git a/net/dsa/tag_sja1105.c b/net/dsa/tag_sja1105.c
index a163f535697e..aa5d234b634d 100644
--- a/net/dsa/tag_sja1105.c
+++ b/net/dsa/tag_sja1105.c
@@ -489,10 +489,7 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 	is_link_local = sja1105_is_link_local(skb);
 	is_meta = sja1105_is_meta_frame(skb);
 
-	if (sja1105_skb_has_tag_8021q(skb)) {
-		/* Normal traffic path. */
-		sja1105_vlan_rcv(skb, &source_port, &switch_id, &vid);
-	} else if (is_link_local) {
+	if (is_link_local) {
 		/* Management traffic path. Switch embeds the switch ID and
 		 * port ID into bytes of the destination MAC, courtesy of
 		 * the incl_srcpt options.
@@ -506,14 +503,35 @@ static struct sk_buff *sja1105_rcv(struct sk_buff *skb,
 		sja1105_meta_unpack(skb, &meta);
 		source_port = meta.source_port;
 		switch_id = meta.switch_id;
-	} else {
+	}
+
+	/* Normal data plane traffic and link-local frames are tagged with
+	 * a tag_8021q VLAN which we have to strip
+	 */
+	if (sja1105_skb_has_tag_8021q(skb)) {
+		int tmp_source_port = -1, tmp_switch_id = -1;
+
+		sja1105_vlan_rcv(skb, &tmp_source_port, &tmp_switch_id, &vid);
+		/* Preserve the source information from the INCL_SRCPT option,
+		 * if available. This allows us to not overwrite a valid source
+		 * port and switch ID with zeroes when receiving link-local
+		 * frames from a VLAN-aware bridged port (non-zero vid).
+		 */
+		if (source_port == -1)
+			source_port = tmp_source_port;
+		if (switch_id == -1)
+			switch_id = tmp_switch_id;
+	} else if (source_port == -1 && switch_id == -1) {
+		/* Packets with no source information have no chance of
+		 * getting accepted, drop them straight away.
+		 */
 		return NULL;
 	}
 
-	if (source_port == -1 || switch_id == -1)
-		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
-	else
+	if (source_port != -1 && switch_id != -1)
 		skb->dev = dsa_master_find_slave(netdev, switch_id, source_port);
+	else
+		skb->dev = dsa_find_designated_bridge_port_by_vid(netdev, vid);
 	if (!skb->dev) {
 		netdev_warn(netdev, "Couldn't decode source port\n");
 		return NULL;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index b4e0120af9c2..a2ab164e815a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -28,9 +28,9 @@
 #include <net/tcp.h>
 #include <net/sock_reuseport.h>
 
-static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
-			const __u16 lport, const __be32 faddr,
-			const __be16 fport)
+u32 inet_ehashfn(const struct net *net, const __be32 laddr,
+		 const __u16 lport, const __be32 faddr,
+		 const __be16 fport)
 {
 	static u32 inet_ehash_secret __read_mostly;
 
@@ -39,6 +39,7 @@ static u32 inet_ehashfn(const struct net *net, const __be32 laddr,
 	return __inet_ehashfn(laddr, lport, faddr, fport,
 			      inet_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet_ehashfn);
 
 /* This function handles inet_sock, but also timewait and request sockets
  * for IPv4/IPv6.
@@ -216,20 +217,25 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-					    struct sk_buff *skb, int doff,
-					    __be32 saddr, __be16 sport,
-					    __be32 daddr, unsigned short hnum)
+INDIRECT_CALLABLE_DECLARE(inet_ehashfn_t udp_ehashfn);
+
+struct sock *inet_lookup_reuseport(struct net *net, struct sock *sk,
+				   struct sk_buff *skb, int doff,
+				   __be32 saddr, __be16 sport,
+				   __be32 daddr, unsigned short hnum,
+				   inet_ehashfn_t *ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_2(ehashfn, udp_ehashfn, inet_ehashfn,
+					net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
 }
+EXPORT_SYMBOL_GPL(inet_lookup_reuseport);
 
 /*
  * Here are some nice properties to exploit here. The BSD API
@@ -253,8 +259,8 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet_lookup_reuseport(net, sk, skb, doff,
+						       saddr, sport, daddr, hnum, inet_ehashfn);
 			if (result)
 				return result;
 
@@ -283,7 +289,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
+					 inet_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv4/netfilter/nf_tproxy_ipv4.c b/net/ipv4/netfilter/nf_tproxy_ipv4.c
index 61cb2341f50f..7c1a0cd9f435 100644
--- a/net/ipv4/netfilter/nf_tproxy_ipv4.c
+++ b/net/ipv4/netfilter/nf_tproxy_ipv4.c
@@ -58,6 +58,8 @@ __be32 nf_tproxy_laddr4(struct sk_buff *skb, __be32 user_laddr, __be32 daddr)
 
 	laddr = 0;
 	indev = __in_dev_get_rcu(skb->dev);
+	if (!indev)
+		return daddr;
 
 	in_dev_for_each_ifa_rcu(ifa, indev) {
 		if (ifa->ifa_flags & IFA_F_SECONDARY)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 895754439393..e7130a9f0e1a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -139,7 +139,8 @@ struct dst_entry	*ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ipv4_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ipv4_mtu(const struct dst_entry *dst);
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst);
+static void		ipv4_negative_advice(struct sock *sk,
+					     struct dst_entry *dst);
 static void		 ipv4_link_failure(struct sk_buff *skb);
 static void		 ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 					   struct sk_buff *skb, u32 mtu,
@@ -844,22 +845,15 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 	__ip_do_redirect(rt, skb, &fl4, true);
 }
 
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
+static void ipv4_negative_advice(struct sock *sk,
+				 struct dst_entry *dst)
 {
 	struct rtable *rt = (struct rtable *)dst;
-	struct dst_entry *ret = dst;
 
-	if (rt) {
-		if (dst->obsolete > 0) {
-			ip_rt_put(rt);
-			ret = NULL;
-		} else if ((rt->rt_flags & RTCF_REDIRECTED) ||
-			   rt->dst.expires) {
-			ip_rt_put(rt);
-			ret = NULL;
-		}
-	}
-	return ret;
+	if ((dst->obsolete > 0) ||
+	    (rt->rt_flags & RTCF_REDIRECTED) ||
+	    rt->dst.expires)
+		sk_dst_reset(sk);
 }
 
 /*
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 43bcefbaefbb..d6db7c25649f 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -55,7 +55,18 @@ struct dctcp {
 };
 
 static unsigned int dctcp_shift_g __read_mostly = 4; /* g = 1/2^4 */
-module_param(dctcp_shift_g, uint, 0644);
+
+static int dctcp_shift_g_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp, 0, 10);
+}
+
+static const struct kernel_param_ops dctcp_shift_g_ops = {
+	.set = dctcp_shift_g_set,
+	.get = param_get_uint,
+};
+
+module_param_cb(dctcp_shift_g, &dctcp_shift_g_ops, &dctcp_shift_g, 0644);
 MODULE_PARM_DESC(dctcp_shift_g, "parameter g for updating dctcp_alpha");
 
 static unsigned int dctcp_alpha_on_init __read_mostly = DCTCP_MAX_ALPHA;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e162bed1916a..e9b1dcf2d463 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1817,7 +1817,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 {
-	u32 limit, tail_gso_size, tail_gso_segs;
+	u32 tail_gso_size, tail_gso_segs;
 	struct skb_shared_info *shinfo;
 	const struct tcphdr *th;
 	struct tcphdr *thtail;
@@ -1826,6 +1826,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	bool fragstolen;
 	u32 gso_segs;
 	u32 gso_size;
+	u64 limit;
 	int delta;
 
 	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
@@ -1922,7 +1923,13 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	__skb_push(skb, hdrlen);
 
 no_coalesce:
-	limit = (u32)READ_ONCE(sk->sk_rcvbuf) + (u32)(READ_ONCE(sk->sk_sndbuf) >> 1);
+	/* sk->sk_backlog.len is reset only at the end of __release_sock().
+	 * Both sk->sk_backlog.len and sk->sk_rmem_alloc could reach
+	 * sk_rcvbuf in normal conditions.
+	 */
+	limit = ((u64)READ_ONCE(sk->sk_rcvbuf)) << 1;
+
+	limit += ((u32)READ_ONCE(sk->sk_sndbuf)) >> 1;
 
 	/* Only socket owner can try to collapse/prune rx queues
 	 * to reduce memory overhead, so add a little headroom here.
@@ -1930,6 +1937,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	 */
 	limit += 64 * 1024;
 
+	limit = min_t(u64, limit, UINT_MAX);
+
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
 		__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPBACKLOGDROP);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index d0387e5eee5b..53d7a81d6258 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -398,9 +398,9 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
-		       const __u16 lport, const __be32 faddr,
-		       const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp_ehashfn(const struct net *net, const __be32 laddr, const __u16 lport,
+		const __be32 faddr, const __be16 fport)
 {
 	static u32 udp_ehash_secret __read_mostly;
 
@@ -410,22 +410,6 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
 			      udp_ehash_secret + net_hash_mix(net));
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     __be32 saddr, __be16 sport,
-				     __be32 daddr, unsigned short hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp4_lib_lookup2(struct net *net,
 				     __be32 saddr, __be16 sport,
@@ -436,15 +420,28 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool need_rescore;
 
 	result = NULL;
 	badness = 0;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+		need_rescore = false;
+rescore:
+		score = compute_score(need_rescore ? result : sk, net, saddr,
+				      sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (need_rescore)
+				continue;
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+						       saddr, sport, daddr, hnum, udp_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -458,9 +455,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(result, net, saddr, sport,
-						daddr, hnum, dif, sdif);
-
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			need_rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
@@ -483,7 +485,8 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					 saddr, sport, daddr, hnum, udp_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index c40cbdfc6247..869173f176cc 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -41,6 +41,7 @@ u32 inet6_ehashfn(const struct net *net,
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
 			       inet6_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
 /*
  * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
@@ -113,22 +114,27 @@ static inline int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static inline struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-					    struct sk_buff *skb, int doff,
-					    const struct in6_addr *saddr,
-					    __be16 sport,
-					    const struct in6_addr *daddr,
-					    unsigned short hnum)
+INDIRECT_CALLABLE_DECLARE(inet6_ehashfn_t udp6_ehashfn);
+
+struct sock *inet6_lookup_reuseport(struct net *net, struct sock *sk,
+				    struct sk_buff *skb, int doff,
+				    const struct in6_addr *saddr,
+				    __be16 sport,
+				    const struct in6_addr *daddr,
+				    unsigned short hnum,
+				    inet6_ehashfn_t *ehashfn)
 {
 	struct sock *reuse_sk = NULL;
 	u32 phash;
 
 	if (sk->sk_reuseport) {
-		phash = inet6_ehashfn(net, daddr, hnum, saddr, sport);
+		phash = INDIRECT_CALL_INET(ehashfn, udp6_ehashfn, inet6_ehashfn,
+					   net, daddr, hnum, saddr, sport);
 		reuse_sk = reuseport_select_sock(sk, phash, skb, doff);
 	}
 	return reuse_sk;
 }
+EXPORT_SYMBOL_GPL(inet6_lookup_reuseport);
 
 /* called with rcu_read_lock() */
 static struct sock *inet6_lhash2_lookup(struct net *net,
@@ -145,8 +151,8 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet6_lookup_reuseport(net, sk, skb, doff,
+							saddr, sport, daddr, hnum, inet6_ehashfn);
 			if (result)
 				return result;
 
@@ -177,7 +183,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, hnum, inet6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 28e44782c94d..699367517155 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -363,7 +363,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	 * the source of the fragment, with the Pointer field set to zero.
 	 */
 	nexthdr = hdr->nexthdr;
-	if (ipv6frag_thdr_truncated(skb, skb_transport_offset(skb), &nexthdr)) {
+	if (ipv6frag_thdr_truncated(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr), &nexthdr)) {
 		__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 				IPSTATS_MIB_INHDRERRORS);
 		icmpv6_param_prob(skb, ICMPV6_HDR_INCOMP, 0);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 3a95466e10a9..3bc3a30363e1 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -87,7 +87,8 @@ struct dst_entry	*ip6_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ip6_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ip6_mtu(const struct dst_entry *dst);
-static struct dst_entry *ip6_negative_advice(struct dst_entry *);
+static void		ip6_negative_advice(struct sock *sk,
+					    struct dst_entry *dst);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
 				       struct net_device *dev, int how);
@@ -2763,24 +2764,24 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 }
 EXPORT_INDIRECT_CALLABLE(ip6_dst_check);
 
-static struct dst_entry *ip6_negative_advice(struct dst_entry *dst)
+static void ip6_negative_advice(struct sock *sk,
+				struct dst_entry *dst)
 {
 	struct rt6_info *rt = (struct rt6_info *) dst;
 
-	if (rt) {
-		if (rt->rt6i_flags & RTF_CACHE) {
-			rcu_read_lock();
-			if (rt6_check_expired(rt)) {
-				rt6_remove_exception_rt(rt);
-				dst = NULL;
-			}
-			rcu_read_unlock();
-		} else {
-			dst_release(dst);
-			dst = NULL;
+	if (rt->rt6i_flags & RTF_CACHE) {
+		rcu_read_lock();
+		if (rt6_check_expired(rt)) {
+			/* counteract the dst_release() in sk_dst_reset() */
+			dst_hold(dst);
+			sk_dst_reset(sk);
+
+			rt6_remove_exception_rt(rt);
 		}
+		rcu_read_unlock();
+		return;
 	}
-	return dst;
+	sk_dst_reset(sk);
 }
 
 static void ip6_link_failure(struct sk_buff *skb)
@@ -4456,7 +4457,7 @@ static void rtmsg_to_fib6_config(struct net *net,
 		.fc_table = l3mdev_fib_table_by_index(net, rtmsg->rtmsg_ifindex) ?
 			 : RT6_TABLE_MAIN,
 		.fc_ifindex = rtmsg->rtmsg_ifindex,
-		.fc_metric = rtmsg->rtmsg_metric ? : IP6_RT_PRIO_USER,
+		.fc_metric = rtmsg->rtmsg_metric,
 		.fc_expires = rtmsg->rtmsg_info,
 		.fc_dst_len = rtmsg->rtmsg_dst_len,
 		.fc_src_len = rtmsg->rtmsg_src_len,
@@ -4486,6 +4487,9 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 	rtnl_lock();
 	switch (cmd) {
 	case SIOCADDRT:
+		/* Only do the default setting of fc_metric in route adding */
+		if (cfg.fc_metric == 0)
+			cfg.fc_metric = IP6_RT_PRIO_USER;
 		err = ip6_route_add(&cfg, GFP_KERNEL, NULL);
 		break;
 	case SIOCDELRT:
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index dc434e4ee6d6..03090d1419d0 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -546,6 +546,8 @@ int __init seg6_init(void)
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
+#endif
+#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
 	genl_unregister_family(&seg6_genl_family);
 #endif
 out_unregister_pernet:
@@ -559,8 +561,9 @@ void seg6_exit(void)
 	seg6_hmac_exit();
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
+	seg6_local_exit();
 	seg6_iptunnel_exit();
 #endif
-	unregister_pernet_subsys(&ip6_segments_ops);
 	genl_unregister_family(&seg6_genl_family);
+	unregister_pernet_subsys(&ip6_segments_ops);
 }
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index b7d6b64cc532..fdbc06f356d6 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -354,6 +354,7 @@ static int seg6_hmac_init_algo(void)
 	struct crypto_shash *tfm;
 	struct shash_desc *shash;
 	int i, alg_count, cpu;
+	int ret = -ENOMEM;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 
@@ -364,12 +365,14 @@ static int seg6_hmac_init_algo(void)
 		algo = &hmac_algos[i];
 		algo->tfms = alloc_percpu(struct crypto_shash *);
 		if (!algo->tfms)
-			return -ENOMEM;
+			goto error_out;
 
 		for_each_possible_cpu(cpu) {
 			tfm = crypto_alloc_shash(algo->name, 0, 0);
-			if (IS_ERR(tfm))
-				return PTR_ERR(tfm);
+			if (IS_ERR(tfm)) {
+				ret = PTR_ERR(tfm);
+				goto error_out;
+			}
 			p_tfm = per_cpu_ptr(algo->tfms, cpu);
 			*p_tfm = tfm;
 		}
@@ -381,18 +384,22 @@ static int seg6_hmac_init_algo(void)
 
 		algo->shashs = alloc_percpu(struct shash_desc *);
 		if (!algo->shashs)
-			return -ENOMEM;
+			goto error_out;
 
 		for_each_possible_cpu(cpu) {
 			shash = kzalloc_node(shsize, GFP_KERNEL,
 					     cpu_to_node(cpu));
 			if (!shash)
-				return -ENOMEM;
+				goto error_out;
 			*per_cpu_ptr(algo->shashs, cpu) = shash;
 		}
 	}
 
 	return 0;
+
+error_out:
+	seg6_hmac_exit();
+	return ret;
 }
 
 int __init seg6_hmac_init(void)
@@ -412,22 +419,29 @@ int __net_init seg6_hmac_net_init(struct net *net)
 void seg6_hmac_exit(void)
 {
 	struct seg6_hmac_algo *algo = NULL;
+	struct crypto_shash *tfm;
+	struct shash_desc *shash;
 	int i, alg_count, cpu;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 	for (i = 0; i < alg_count; i++) {
 		algo = &hmac_algos[i];
-		for_each_possible_cpu(cpu) {
-			struct crypto_shash *tfm;
-			struct shash_desc *shash;
 
-			shash = *per_cpu_ptr(algo->shashs, cpu);
-			kfree(shash);
-			tfm = *per_cpu_ptr(algo->tfms, cpu);
-			crypto_free_shash(tfm);
+		if (algo->shashs) {
+			for_each_possible_cpu(cpu) {
+				shash = *per_cpu_ptr(algo->shashs, cpu);
+				kfree(shash);
+			}
+			free_percpu(algo->shashs);
+		}
+
+		if (algo->tfms) {
+			for_each_possible_cpu(cpu) {
+				tfm = *per_cpu_ptr(algo->tfms, cpu);
+				crypto_free_shash(tfm);
+			}
+			free_percpu(algo->tfms);
 		}
-		free_percpu(algo->tfms);
-		free_percpu(algo->shashs);
 	}
 }
 EXPORT_SYMBOL(seg6_hmac_exit);
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index e756ba705fd9..f98bb719190b 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -327,10 +327,8 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	int err;
 
 	err = seg6_do_srh(skb);
-	if (unlikely(err)) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (unlikely(err))
+		goto drop;
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
@@ -355,7 +353,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-		return err;
+		goto drop;
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -363,6 +361,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 			       skb_dst(skb)->dev, seg6_input_finish);
 
 	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 static int seg6_input_nf(struct sk_buff *skb)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 256de135191f..c60162ea0aa8 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -68,11 +68,12 @@ int udpv6_init_sock(struct sock *sk)
 	return 0;
 }
 
-static u32 udp6_ehashfn(const struct net *net,
-			const struct in6_addr *laddr,
-			const u16 lport,
-			const struct in6_addr *faddr,
-			const __be16 fport)
+INDIRECT_CALLABLE_SCOPE
+u32 udp6_ehashfn(const struct net *net,
+		 const struct in6_addr *laddr,
+		 const u16 lport,
+		 const struct in6_addr *faddr,
+		 const __be16 fport)
 {
 	static u32 udp6_ehash_secret __read_mostly;
 	static u32 udp_ipv6_hash_secret __read_mostly;
@@ -156,24 +157,6 @@ static int compute_score(struct sock *sk, struct net *net,
 	return score;
 }
 
-static struct sock *lookup_reuseport(struct net *net, struct sock *sk,
-				     struct sk_buff *skb,
-				     const struct in6_addr *saddr,
-				     __be16 sport,
-				     const struct in6_addr *daddr,
-				     unsigned int hnum)
-{
-	struct sock *reuse_sk = NULL;
-	u32 hash;
-
-	if (sk->sk_reuseport && sk->sk_state != TCP_ESTABLISHED) {
-		hash = udp6_ehashfn(net, daddr, hnum, saddr, sport);
-		reuse_sk = reuseport_select_sock(sk, hash, skb,
-						 sizeof(struct udphdr));
-	}
-	return reuse_sk;
-}
-
 /* called with rcu_read_lock() */
 static struct sock *udp6_lib_lookup2(struct net *net,
 		const struct in6_addr *saddr, __be16 sport,
@@ -183,15 +166,28 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 {
 	struct sock *sk, *result;
 	int score, badness;
+	bool need_rescore;
 
 	result = NULL;
 	badness = -1;
 	udp_portaddr_for_each_entry_rcu(sk, &hslot2->head) {
-		score = compute_score(sk, net, saddr, sport,
-				      daddr, hnum, dif, sdif);
+		need_rescore = false;
+rescore:
+		score = compute_score(need_rescore ? result : sk, net, saddr,
+				      sport, daddr, hnum, dif, sdif);
 		if (score > badness) {
 			badness = score;
-			result = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+
+			if (need_rescore)
+				continue;
+
+			if (sk->sk_state == TCP_ESTABLISHED) {
+				result = sk;
+				continue;
+			}
+
+			result = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+							saddr, sport, daddr, hnum, udp6_ehashfn);
 			if (!result) {
 				result = sk;
 				continue;
@@ -205,8 +201,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
 			if (IS_ERR(result))
 				continue;
 
-			badness = compute_score(sk, net, saddr, sport,
-						daddr, hnum, dif, sdif);
+			/* compute_score is too long of a function to be
+			 * inlined, and calling it again here yields
+			 * measureable overhead for some
+			 * workloads. Work around it by jumping
+			 * backwards to rescore 'result'.
+			 */
+			need_rescore = true;
+			goto rescore;
 		}
 	}
 	return result;
@@ -231,7 +233,8 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					  saddr, sport, daddr, hnum, udp6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 78aa6125eafb..b4ccae4f6849 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -250,6 +250,9 @@ struct mptcp_sock {
 	bool		use_64bit_ack; /* Set when we received a 64-bit DSN */
 	bool		csum_enabled;
 	spinlock_t	join_list_lock;
+	int		keepalive_cnt;
+	int		keepalive_idle;
+	int		keepalive_intvl;
 	struct work_struct work;
 	struct sk_buff  *ooo_last_skb;
 	struct rb_root  out_of_order_queue;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 4bb305342fcc..36d85af12e76 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -177,8 +177,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case SO_KEEPALIVE:
-		mptcp_sol_socket_sync_intval(msk, optname, val);
-		return 0;
 	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
@@ -595,6 +593,60 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	return ret;
 }
 
+static int __tcp_sock_set_keepintvl(struct sock *sk, int val)
+{
+	if (val < 1 || val > MAX_TCP_KEEPINTVL)
+		return -EINVAL;
+
+	WRITE_ONCE(tcp_sk(sk)->keepalive_intvl, val * HZ);
+
+	return 0;
+}
+
+static int __tcp_sock_set_keepcnt(struct sock *sk, int val)
+{
+	if (val < 1 || val > MAX_TCP_KEEPCNT)
+		return -EINVAL;
+
+	/* Paired with READ_ONCE() in keepalive_probes() */
+	WRITE_ONCE(tcp_sk(sk)->keepalive_probes, val);
+
+	return 0;
+}
+
+static int mptcp_setsockopt_set_val(struct mptcp_sock *msk, int max,
+				    int (*set_val)(struct sock *, int),
+				    int *msk_val, sockptr_t optval,
+				    unsigned int optlen)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = (struct sock *)msk;
+	int val, err;
+
+	err = mptcp_get_int_option(msk, optval, optlen, &val);
+	if (err)
+		return err;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int ret;
+
+		lock_sock(ssk);
+		ret = set_val(ssk, val);
+		err = err ? : ret;
+		release_sock(ssk);
+	}
+
+	if (!err) {
+		*msk_val = val;
+		sockopt_seq_inc(msk);
+	}
+	release_sock(sk);
+
+	return err;
+}
+
 static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    sockptr_t optval, unsigned int optlen)
 {
@@ -603,6 +655,21 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return -EOPNOTSUPP;
 	case TCP_CONGESTION:
 		return mptcp_setsockopt_sol_tcp_congestion(msk, optval, optlen);
+	case TCP_KEEPIDLE:
+		return mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPIDLE,
+						&tcp_sock_set_keepidle_locked,
+						&msk->keepalive_idle,
+						optval, optlen);
+	case TCP_KEEPINTVL:
+		return mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPINTVL,
+						&__tcp_sock_set_keepintvl,
+						&msk->keepalive_intvl,
+						optval, optlen);
+	case TCP_KEEPCNT:
+		return mptcp_setsockopt_set_val(msk, MAX_TCP_KEEPCNT,
+						&__tcp_sock_set_keepcnt,
+						&msk->keepalive_cnt,
+						optval, optlen);
 	}
 
 	return -EOPNOTSUPP;
@@ -669,9 +736,40 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 	return ret;
 }
 
+static int mptcp_put_int_option(struct mptcp_sock *msk, char __user *optval,
+				int __user *optlen, int val)
+{
+	int len;
+
+	if (get_user(len, optlen))
+		return -EFAULT;
+	if (len < 0)
+		return -EINVAL;
+
+	if (len < sizeof(int) && len > 0 && val >= 0 && val <= 255) {
+		unsigned char ucval = (unsigned char)val;
+
+		len = 1;
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &ucval, 1))
+			return -EFAULT;
+	} else {
+		len = min_t(unsigned int, len, sizeof(int));
+		if (put_user(len, optlen))
+			return -EFAULT;
+		if (copy_to_user(optval, &val, len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 				    char __user *optval, int __user *optlen)
 {
+	struct sock *sk = (void *)msk;
+
 	switch (optname) {
 	case TCP_ULP:
 	case TCP_CONGESTION:
@@ -679,6 +777,18 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 	case TCP_CC_INFO:
 		return mptcp_getsockopt_first_sf_only(msk, SOL_TCP, optname,
 						      optval, optlen);
+	case TCP_KEEPIDLE:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_idle ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_time) / HZ);
+	case TCP_KEEPINTVL:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_intvl ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_intvl) / HZ);
+	case TCP_KEEPCNT:
+		return mptcp_put_int_option(msk, optval, optlen,
+					    msk->keepalive_cnt ? :
+					    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_keepalive_probes));
 	}
 	return -EOPNOTSUPP;
 }
@@ -748,6 +858,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 
 	if (inet_csk(sk)->icsk_ca_ops != inet_csk(ssk)->icsk_ca_ops)
 		tcp_set_congestion_control(ssk, msk->ca_name, false, true);
+	tcp_sock_set_keepidle_locked(ssk, msk->keepalive_idle);
+	__tcp_sock_set_keepintvl(ssk, msk->keepalive_intvl);
+	__tcp_sock_set_keepcnt(ssk, msk->keepalive_cnt);
 }
 
 static void __mptcp_sockopt_sync(struct mptcp_sock *msk, struct sock *ssk)
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 8c96e01f6a02..89b16d36da9c 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -167,7 +167,9 @@ instance_destroy_rcu(struct rcu_head *head)
 	struct nfqnl_instance *inst = container_of(head, struct nfqnl_instance,
 						   rcu);
 
+	rcu_read_lock();
 	nfqnl_flush(inst, NULL, 0);
+	rcu_read_unlock();
 	kfree(inst);
 	module_put(THIS_MODULE);
 }
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index 02327ffebc49..55237d8a3d88 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -45,36 +45,27 @@ nft_payload_copy_vlan(u32 *d, const struct sk_buff *skb, u8 offset, u8 len)
 	int mac_off = skb_mac_header(skb) - skb->data;
 	u8 *vlanh, *dst_u8 = (u8 *) d;
 	struct vlan_ethhdr veth;
-	u8 vlan_hlen = 0;
-
-	if ((skb->protocol == htons(ETH_P_8021AD) ||
-	     skb->protocol == htons(ETH_P_8021Q)) &&
-	    offset >= VLAN_ETH_HLEN && offset < VLAN_ETH_HLEN + VLAN_HLEN)
-		vlan_hlen += VLAN_HLEN;
 
 	vlanh = (u8 *) &veth;
-	if (offset < VLAN_ETH_HLEN + vlan_hlen) {
+	if (offset < VLAN_ETH_HLEN) {
 		u8 ethlen = len;
 
-		if (vlan_hlen &&
-		    skb_copy_bits(skb, mac_off, &veth, VLAN_ETH_HLEN) < 0)
-			return false;
-		else if (!nft_payload_rebuild_vlan_hdr(skb, mac_off, &veth))
+		if (!nft_payload_rebuild_vlan_hdr(skb, mac_off, &veth))
 			return false;
 
-		if (offset + len > VLAN_ETH_HLEN + vlan_hlen)
-			ethlen -= offset + len - VLAN_ETH_HLEN - vlan_hlen;
+		if (offset + len > VLAN_ETH_HLEN)
+			ethlen -= offset + len - VLAN_ETH_HLEN;
 
-		memcpy(dst_u8, vlanh + offset - vlan_hlen, ethlen);
+		memcpy(dst_u8, vlanh + offset, ethlen);
 
 		len -= ethlen;
 		if (len == 0)
 			return true;
 
 		dst_u8 += ethlen;
-		offset = ETH_HLEN + vlan_hlen;
+		offset = ETH_HLEN;
 	} else {
-		offset -= VLAN_HLEN + vlan_hlen;
+		offset -= VLAN_HLEN;
 	}
 
 	return skb_copy_bits(skb, offset + mac_off, dst_u8, len) == 0;
@@ -119,6 +110,17 @@ static int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
 	return pkt->inneroff;
 }
 
+static bool nft_payload_need_vlan_adjust(u32 offset, u32 len)
+{
+	unsigned int boundary = offset + len;
+
+	/* data past ether src/dst requested, copy needed */
+	if (boundary > offsetof(struct ethhdr, h_proto))
+		return true;
+
+	return false;
+}
+
 void nft_payload_eval(const struct nft_expr *expr,
 		      struct nft_regs *regs,
 		      const struct nft_pktinfo *pkt)
@@ -136,7 +138,8 @@ void nft_payload_eval(const struct nft_expr *expr,
 		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) == 0)
 			goto err;
 
-		if (skb_vlan_tag_present(skb)) {
+		if (skb_vlan_tag_present(skb) &&
+		    nft_payload_need_vlan_adjust(priv->offset, priv->len)) {
 			if (!nft_payload_copy_vlan(dest, skb,
 						   priv->offset, priv->len))
 				goto err;
@@ -638,21 +641,89 @@ static int nft_payload_csum_inet(struct sk_buff *skb, const u32 *src,
 	return 0;
 }
 
+struct nft_payload_set {
+	enum nft_payload_bases	base:8;
+	u8			offset;
+	u8			len;
+	u8			sreg;
+	u8			csum_type;
+	u8			csum_offset;
+	u8			csum_flags;
+};
+
+/* This is not struct vlan_hdr. */
+struct nft_payload_vlan_hdr {
+	__be16			h_vlan_proto;
+	__be16			h_vlan_TCI;
+};
+
+static bool
+nft_payload_set_vlan(const u32 *src, struct sk_buff *skb, u8 offset, u8 len,
+		     int *vlan_hlen)
+{
+	struct nft_payload_vlan_hdr *vlanh;
+	__be16 vlan_proto;
+	u16 vlan_tci;
+
+	if (offset >= offsetof(struct vlan_ethhdr, h_vlan_encapsulated_proto)) {
+		*vlan_hlen = VLAN_HLEN;
+		return true;
+	}
+
+	switch (offset) {
+	case offsetof(struct vlan_ethhdr, h_vlan_proto):
+		if (len == 2) {
+			vlan_proto = nft_reg_load_be16(src);
+			skb->vlan_proto = vlan_proto;
+		} else if (len == 4) {
+			vlanh = (struct nft_payload_vlan_hdr *)src;
+			__vlan_hwaccel_put_tag(skb, vlanh->h_vlan_proto,
+					       ntohs(vlanh->h_vlan_TCI));
+		} else {
+			return false;
+		}
+		break;
+	case offsetof(struct vlan_ethhdr, h_vlan_TCI):
+		if (len != 2)
+			return false;
+
+		vlan_tci = ntohs(nft_reg_load_be16(src));
+		skb->vlan_tci = vlan_tci;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
 static void nft_payload_set_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
 {
 	const struct nft_payload_set *priv = nft_expr_priv(expr);
-	struct sk_buff *skb = pkt->skb;
 	const u32 *src = &regs->data[priv->sreg];
-	int offset, csum_offset;
+	int offset, csum_offset, vlan_hlen = 0;
+	struct sk_buff *skb = pkt->skb;
 	__wsum fsum, tsum;
 
 	switch (priv->base) {
 	case NFT_PAYLOAD_LL_HEADER:
 		if (!skb_mac_header_was_set(skb))
 			goto err;
-		offset = skb_mac_header(skb) - skb->data;
+
+		if (skb_vlan_tag_present(skb) &&
+		    nft_payload_need_vlan_adjust(priv->offset, priv->len)) {
+			if (!nft_payload_set_vlan(src, skb,
+						  priv->offset, priv->len,
+						  &vlan_hlen))
+				goto err;
+
+			if (!vlan_hlen)
+				return;
+		}
+
+		offset = skb_mac_header(skb) - skb->data - vlan_hlen;
 		break;
 	case NFT_PAYLOAD_NETWORK_HEADER:
 		offset = skb_network_offset(skb);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 983c5ad9724f..dc39ae20c6aa 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -285,22 +285,14 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	return 0;
 }
 
-static inline void __nr_remove_node(struct nr_node *nr_node)
+static void nr_remove_node_locked(struct nr_node *nr_node)
 {
+	lockdep_assert_held(&nr_node_list_lock);
+
 	hlist_del_init(&nr_node->node_node);
 	nr_node_put(nr_node);
 }
 
-#define nr_remove_node_locked(__node) \
-	__nr_remove_node(__node)
-
-static void nr_remove_node(struct nr_node *nr_node)
-{
-	spin_lock_bh(&nr_node_list_lock);
-	__nr_remove_node(nr_node);
-	spin_unlock_bh(&nr_node_list_lock);
-}
-
 static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
 {
 	hlist_del_init(&nr_neigh->neigh_node);
@@ -339,6 +331,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 		return -EINVAL;
 	}
 
+	spin_lock_bh(&nr_node_list_lock);
 	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
 		if (nr_node->routes[i].neighbour == nr_neigh) {
@@ -352,7 +345,7 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 			nr_node->count--;
 
 			if (nr_node->count == 0) {
-				nr_remove_node(nr_node);
+				nr_remove_node_locked(nr_node);
 			} else {
 				switch (i) {
 				case 0:
@@ -367,12 +360,14 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 				nr_node_put(nr_node);
 			}
 			nr_node_unlock(nr_node);
+			spin_unlock_bh(&nr_node_list_lock);
 
 			return 0;
 		}
 	}
 	nr_neigh_put(nr_neigh);
 	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_node_list_lock);
 	nr_node_put(nr_node);
 
 	return -EINVAL;
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 2a821f2b2ffe..905452006d2d 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1466,6 +1466,19 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb)
+{
+	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
+	BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
+
+	if (skb->len < hdr_size ||
+	    !nci_plen(skb->data) ||
+	    skb->len < hdr_size + nci_plen(skb->data)) {
+		return false;
+	}
+	return true;
+}
+
 /* ---- NCI TX Data worker thread ---- */
 
 static void nci_tx_work(struct work_struct *work)
@@ -1516,9 +1529,9 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
-			break;
+			continue;
 		}
 
 		/* Process frame */
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index aca6e2b599c8..85af0e9e0ac6 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -924,6 +924,12 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
+		/* Need to set the pkt_type to involve the routing layer.  The
+		 * packet movement through the OVS datapath doesn't generally
+		 * use routing, but this is needed for tunnel cases.
+		 */
+		skb->pkt_type = PACKET_OUTGOING;
+
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 1b81d71bac3c..209b42cf5aea 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -417,7 +417,6 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 	 */
 	key->tp.src = htons(icmp->icmp6_type);
 	key->tp.dst = htons(icmp->icmp6_code);
-	memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
 
 	if (icmp->icmp6_code == 0 &&
 	    (icmp->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
@@ -426,6 +425,8 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 		struct nd_msg *nd;
 		int offset;
 
+		memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
+
 		/* In order to process neighbor discovery options, we need the
 		 * entire packet.
 		 */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cffa217fb306..0ab3b09f863b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2490,8 +2490,7 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
-		if (!packet_read_pending(&po->tx_ring))
-			complete(&po->skb_completion);
+		complete(&po->skb_completion);
 	}
 
 	sock_wfree(skb);
diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index 4a13b9f7abb4..3c513e7ca2d5 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -807,6 +807,24 @@ int qrtr_ns_init(void)
 	if (ret < 0)
 		goto err_wq;
 
+	/* As the qrtr ns socket owner and creator is the same module, we have
+	 * to decrease the qrtr module reference count to guarantee that it
+	 * remains zero after the ns socket is created, otherwise, executing
+	 * "rmmod" command is unable to make the qrtr module deleted after the
+	 *  qrtr module is inserted successfully.
+	 *
+	 * However, the reference count is increased twice in
+	 * sock_create_kern(): one is to increase the reference count of owner
+	 * of qrtr socket's proto_ops struct; another is to increment the
+	 * reference count of owner of qrtr proto struct. Therefore, we must
+	 * decrement the module reference count twice to ensure that it keeps
+	 * zero after server's listening socket is created. Of course, we
+	 * must bump the module reference count twice as well before the socket
+	 * is closed.
+	 */
+	module_put(qrtr_ns.sock->ops->owner);
+	module_put(qrtr_ns.sock->sk->sk_prot_creator->owner);
+
 	return 0;
 
 err_wq:
@@ -821,6 +839,15 @@ void qrtr_ns_remove(void)
 {
 	cancel_work_sync(&qrtr_ns.work);
 	destroy_workqueue(qrtr_ns.workqueue);
+
+	/* sock_release() expects the two references that were put during
+	 * qrtr_ns_init(). This function is only called during module remove,
+	 * so try_stop_module() has already set the refcnt to 0. Use
+	 * __module_get() instead of try_module_get() to successfully take two
+	 * references.
+	 */
+	__module_get(qrtr_ns.sock->ops->owner);
+	__module_get(qrtr_ns.sock->sk->sk_prot_creator->owner);
 	sock_release(qrtr_ns.sock);
 }
 EXPORT_SYMBOL_GPL(qrtr_ns_remove);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 48b608cb5f5e..93a7b7061d9a 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1132,17 +1132,11 @@ gss_read_verf(struct rpc_gss_wire_cred *gc,
 
 static void gss_free_in_token_pages(struct gssp_in_token *in_token)
 {
-	u32 inlen;
 	int i;
 
 	i = 0;
-	inlen = in_token->page_len;
-	while (inlen) {
-		if (in_token->pages[i])
-			put_page(in_token->pages[i]);
-		inlen -= inlen > PAGE_SIZE ? PAGE_SIZE : inlen;
-	}
-
+	while (in_token->pages[i])
+		put_page(in_token->pages[i++]);
 	kfree(in_token->pages);
 	in_token->pages = NULL;
 }
@@ -1168,7 +1162,7 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 	}
 
 	pages = DIV_ROUND_UP(inlen, PAGE_SIZE);
-	in_token->pages = kcalloc(pages, sizeof(struct page *), GFP_KERNEL);
+	in_token->pages = kcalloc(pages + 1, sizeof(struct page *), GFP_KERNEL);
 	if (!in_token->pages) {
 		kfree(in_handle->data);
 		return SVC_DENIED;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 59fd6dedbbed..f73d4593625c 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -982,6 +982,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
 		.stats		= old->cl_stats,
+		.timeout	= old->cl_timeout,
 	};
 	struct rpc_clnt *clnt;
 	int err;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9177b243a949..8d5897ed2816 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1238,8 +1238,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	if (rqstp->rq_proc >= versp->vs_nproc)
 		goto err_bad_proc;
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
-	if (!procp)
-		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
 	memset(rqstp->rq_argp, 0, procp->pc_argzero);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index b19592673eef..3cf53e3140a5 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -705,7 +705,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 			set_current_state(TASK_RUNNING);
 			return -EINTR;
 		}
-		schedule_timeout(msecs_to_jiffies(500));
+		freezable_schedule_timeout(msecs_to_jiffies(500));
 	}
 	rqstp->rq_page_end = &rqstp->rq_pages[pages];
 	rqstp->rq_pages[pages] = NULL; /* this might be seen in nfsd_splice_actor() */
@@ -765,7 +765,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
 	smp_mb__after_atomic();
 
 	if (likely(rqst_should_sleep(rqstp)))
-		time_left = schedule_timeout(timeout);
+		time_left = freezable_schedule_timeout(timeout);
 	else
 		__set_current_state(TASK_RUNNING);
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 41095a278f79..34413d4ab0e5 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -258,7 +258,11 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		pr_info("rpcrdma: removing device %s for %pISpc\n",
 			ep->re_id->device->name, sap);
-		fallthrough;
+		switch (xchg(&ep->re_connect_status, -ENODEV)) {
+		case 0: goto wake_connect_worker;
+		case 1: goto disconnected;
+		}
+		return 0;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		ep->re_connect_status = -ENODEV;
 		goto disconnected;
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 79ea1ab34570..4a3bf8528da7 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -636,9 +636,17 @@ struct tls_context *tls_ctx_create(struct sock *sk)
 		return NULL;
 
 	mutex_init(&ctx->tx_lock);
-	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	ctx->sk_proto = READ_ONCE(sk->sk_prot);
 	ctx->sk = sk;
+	/* Release semantic of rcu_assign_pointer() ensures that
+	 * ctx->sk_proto is visible before changing sk->sk_prot in
+	 * update_sk_prot(), and prevents reading uninitialized value in
+	 * tls_{getsockopt, setsockopt}. Note that we do not need a
+	 * read barrier in tls_{getsockopt,setsockopt} as there is an
+	 * address dependency between sk->sk_proto->{getsockopt,setsockopt}
+	 * and ctx->sk_proto.
+	 */
+	rcu_assign_pointer(icsk->icsk_ulp_data, ctx);
 	return ctx;
 }
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f66f86704901..80f91b5ab401 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2005,13 +2005,15 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
 	maybe_add_creds(skb, sock, other);
 	skb_get(skb);
 
+	scm_stat_add(other, skb);
+
+	spin_lock(&other->sk_receive_queue.lock);
 	if (ousk->oob_skb)
 		consume_skb(ousk->oob_skb);
-
 	WRITE_ONCE(ousk->oob_skb, skb);
+	__skb_queue_tail(&other->sk_receive_queue, skb);
+	spin_unlock(&other->sk_receive_queue.lock);
 
-	scm_stat_add(other, skb);
-	skb_queue_tail(&other->sk_receive_queue, skb);
 	sk_send_sigurg(other);
 	unix_state_unlock(other);
 	other->sk_data_ready(other);
@@ -2057,7 +2059,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_err;
 	}
 
-	if (sk->sk_shutdown & SEND_SHUTDOWN)
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto pipe_err;
 
 	while (sent < len) {
@@ -2516,8 +2518,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
+	spin_lock(&sk->sk_receive_queue.lock);
 
 	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
+		spin_unlock(&sk->sk_receive_queue.lock);
 		unix_state_unlock(sk);
 		mutex_unlock(&u->iolock);
 		return -EINVAL;
@@ -2529,6 +2533,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 		WRITE_ONCE(u->oob_skb, NULL);
 	else
 		skb_get(oob_skb);
+
+	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
@@ -2557,6 +2563,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 		consume_skb(skb);
 		skb = NULL;
 	} else {
+		struct sk_buff *unlinked_skb = NULL;
+
+		spin_lock(&sk->sk_receive_queue.lock);
+
 		if (skb == u->oob_skb) {
 			if (copied) {
 				skb = NULL;
@@ -2568,13 +2578,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
 			} else if (flags & MSG_PEEK) {
 				skb = NULL;
 			} else {
-				skb_unlink(skb, &sk->sk_receive_queue);
+				__skb_unlink(skb, &sk->sk_receive_queue);
 				WRITE_ONCE(u->oob_skb, NULL);
-				if (!WARN_ON_ONCE(skb_unref(skb)))
-					kfree_skb(skb);
+				unlinked_skb = skb;
 				skb = skb_peek(&sk->sk_receive_queue);
 			}
 		}
+
+		spin_unlock(&sk->sk_receive_queue.lock);
+
+		if (unlinked_skb) {
+			WARN_ON_ONCE(skb_unref(unlinked_skb));
+			kfree_skb(unlinked_skb);
+		}
 	}
 	return skb;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index dafea8bfcf3c..946719342415 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1687,7 +1687,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1704,7 +1704,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index eebca0cbc61a..cee851fbe2c3 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3766,15 +3766,10 @@ static void xfrm_link_failure(struct sk_buff *skb)
 	/* Impossible. Such dst must be popped before reaches point of failure. */
 }
 
-static struct dst_entry *xfrm_negative_advice(struct dst_entry *dst)
+static void xfrm_negative_advice(struct sock *sk, struct dst_entry *dst)
 {
-	if (dst) {
-		if (dst->obsolete) {
-			dst_release(dst);
-			dst = NULL;
-		}
-	}
-	return dst;
+	if (dst->obsolete)
+		sk_dst_reset(sk);
 }
 
 static void xfrm_init_pmtu(struct xfrm_dst **bundle, int nr)
diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/constants.py.in
index 08f0587d15ea..0ff707bc1896 100644
--- a/scripts/gdb/linux/constants.py.in
+++ b/scripts/gdb/linux/constants.py.in
@@ -46,12 +46,12 @@ if IS_BUILTIN(CONFIG_COMMON_CLK):
     LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
 
 /* linux/fs.h */
-LX_VALUE(SB_RDONLY)
-LX_VALUE(SB_SYNCHRONOUS)
-LX_VALUE(SB_MANDLOCK)
-LX_VALUE(SB_DIRSYNC)
-LX_VALUE(SB_NOATIME)
-LX_VALUE(SB_NODIRATIME)
+LX_GDBPARSED(SB_RDONLY)
+LX_GDBPARSED(SB_SYNCHRONOUS)
+LX_GDBPARSED(SB_MANDLOCK)
+LX_GDBPARSED(SB_DIRSYNC)
+LX_GDBPARSED(SB_NOATIME)
+LX_GDBPARSED(SB_NODIRATIME)
 
 /* linux/htimer.h */
 LX_GDBPARSED(hrtimer_resolution)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 7f8013dcef00..f9786621a178 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -13,18 +13,21 @@
 
 struct symbol symbol_yes = {
 	.name = "y",
+	.type = S_TRISTATE,
 	.curr = { "y", yes },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
 struct symbol symbol_mod = {
 	.name = "m",
+	.type = S_TRISTATE,
 	.curr = { "m", mod },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
 
 struct symbol symbol_no = {
 	.name = "n",
+	.type = S_TRISTATE,
 	.curr = { "n", no },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
 };
@@ -775,8 +778,7 @@ const char *sym_get_string_value(struct symbol *sym)
 		case no:
 			return "n";
 		case mod:
-			sym_calc_value(modules_sym);
-			return (modules_sym->curr.tri == no) ? "n" : "m";
+			return "m";
 		case yes:
 			return "y";
 		}
diff --git a/sound/core/init.c b/sound/core/init.c
index 7b3618997d34..088f4f1874b3 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -303,8 +303,8 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 	card->number = idx;
 #ifdef MODULE
 	WARN_ON(!module);
-	card->module = module;
 #endif
+	card->module = module;
 	INIT_LIST_HEAD(&card->devices);
 	init_rwsem(&card->controls_rwsem);
 	rwlock_init(&card->ctl_files_rwlock);
@@ -508,6 +508,14 @@ int snd_card_disconnect(struct snd_card *card)
 	}
 	spin_unlock(&card->files_lock);	
 
+#ifdef CONFIG_PM
+	/* wake up sleepers here before other callbacks for avoiding potential
+	 * deadlocks with other locks (e.g. in kctls);
+	 * then this notifies the shutdown and sleepers would abort immediately
+	 */
+	wake_up_all(&card->power_sleep);
+#endif
+
 	/* notify all connected devices about disconnection */
 	/* at this point, they cannot respond to any calls except release() */
 
@@ -535,7 +543,6 @@ int snd_card_disconnect(struct snd_card *card)
 	mutex_unlock(&snd_card_mutex);
 
 #ifdef CONFIG_PM
-	wake_up(&card->power_sleep);
 	snd_power_sync_ref(card);
 #endif
 	return 0;	
diff --git a/sound/core/timer.c b/sound/core/timer.c
index e08a37c23add..38f3b30efae7 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -553,6 +553,16 @@ static int snd_timer_start1(struct snd_timer_instance *timeri,
 		goto unlock;
 	}
 
+	/* check the actual time for the start tick;
+	 * bail out as error if it's way too low (< 100us)
+	 */
+	if (start) {
+		if ((u64)snd_timer_hw_resolution(timer) * ticks < 100000) {
+			result = -EINVAL;
+			goto unlock;
+		}
+	}
+
 	if (start)
 		timeri->ticks = timeri->cticks = ticks;
 	else if (!timeri->cticks)
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 4dc6eed6c18a..99676c426f78 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -629,8 +629,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -705,6 +707,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 2cc3d814bab4..5a44f5201515 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -441,6 +441,7 @@ struct rt5645_priv {
 	struct regmap *regmap;
 	struct i2c_client *i2c;
 	struct gpio_desc *gpiod_hp_det;
+	struct gpio_desc *gpiod_cbj_sleeve;
 	struct snd_soc_jack *hp_jack;
 	struct snd_soc_jack *mic_jack;
 	struct snd_soc_jack *btn_jack;
@@ -3179,6 +3180,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		regmap_update_bits(rt5645->regmap, RT5645_IN1_CTRL2,
 			RT5645_CBJ_MN_JD, 0);
 
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 1);
+
 		msleep(600);
 		regmap_read(rt5645->regmap, RT5645_IN1_CTRL3, &val);
 		val &= 0x7;
@@ -3195,6 +3199,8 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 			snd_soc_dapm_disable_pin(dapm, "Mic Det Power");
 			snd_soc_dapm_sync(dapm);
 			rt5645->jack_type = SND_JACK_HEADPHONE;
+			if (rt5645->gpiod_cbj_sleeve)
+				gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 		}
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
@@ -3220,6 +3226,9 @@ static int rt5645_jack_detect(struct snd_soc_component *component, int jack_inse
 		if (rt5645->pdata.level_trigger_irq)
 			regmap_update_bits(rt5645->regmap, RT5645_IRQ_CTRL2,
 				RT5645_JD_1_1_MASK, RT5645_JD_1_1_INV);
+
+		if (rt5645->gpiod_cbj_sleeve)
+			gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 	}
 
 	return rt5645->jack_type;
@@ -3933,6 +3942,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 			return ret;
 	}
 
+	rt5645->gpiod_cbj_sleeve = devm_gpiod_get_optional(&i2c->dev, "cbj-sleeve",
+							   GPIOD_OUT_LOW);
+
+	if (IS_ERR(rt5645->gpiod_cbj_sleeve)) {
+		ret = PTR_ERR(rt5645->gpiod_cbj_sleeve);
+		dev_info(&i2c->dev, "failed to initialize gpiod, ret=%d\n", ret);
+		if (ret != -ENOENT)
+			return ret;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
 		rt5645->supplies[i].supply = rt5645_supply_names[i];
 
@@ -4176,6 +4195,9 @@ static int rt5645_i2c_remove(struct i2c_client *i2c)
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
+
 	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 
 	return 0;
@@ -4193,6 +4215,9 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 		0);
 	msleep(20);
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
+
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 }
 
 static struct i2c_driver rt5645_i2c_driver = {
diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index bfa536bd7196..7c8d6a012f61 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -315,7 +315,7 @@ static int rt715_sdca_set_amp_gain_8ch_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -17625, 375, 0);
+static const DECLARE_TLV_DB_SCALE(in_vol_tlv, -1725, 75, 0);
 static const DECLARE_TLV_DB_SCALE(mic_vol_tlv, 0, 1000, 0);
 
 static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
@@ -476,7 +476,7 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC7_27_VOL,
 			RT715_SDCA_FU_VOL_CTRL, CH_02),
-			0x2f, 0x7f, 0,
+			0x2f, 0x3f, 0,
 		rt715_sdca_set_amp_gain_get, rt715_sdca_set_amp_gain_put,
 		in_vol_tlv),
 	RT715_SDCA_EXT_TLV("FU02 Capture Volume",
@@ -484,13 +484,13 @@ static const struct snd_kcontrol_new rt715_sdca_snd_controls[] = {
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		rt715_sdca_set_amp_gain_4ch_get,
 		rt715_sdca_set_amp_gain_4ch_put,
-		in_vol_tlv, 4, 0x7f),
+		in_vol_tlv, 4, 0x3f),
 	RT715_SDCA_EXT_TLV("FU06 Capture Volume",
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_ADC10_11_VOL,
 			RT715_SDCA_FU_VOL_CTRL, CH_01),
 		rt715_sdca_set_amp_gain_4ch_get,
 		rt715_sdca_set_amp_gain_4ch_put,
-		in_vol_tlv, 4, 0x7f),
+		in_vol_tlv, 4, 0x3f),
 	/* MIC Boost Control */
 	RT715_SDCA_BOOST_EXT_TLV("FU0E Boost",
 		SDW_SDCA_CTL(FUN_MIC_ARRAY, RT715_SDCA_FU_DMIC_GAIN_EN,
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index b047bf87a100..e269026942e1 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -111,6 +111,7 @@ static bool rt715_readable_register(struct device *dev, unsigned int reg)
 	case 0x839d:
 	case 0x83a7:
 	case 0x83a9:
+	case 0x752001:
 	case 0x752039:
 		return true;
 	default:
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 700baa6314aa..ba36525a5789 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -2,7 +2,8 @@
 /*
  * tas2552.c - ALSA SoC Texas Instruments TAS2552 Mono Audio Amplifier
  *
- * Copyright (C) 2014 Texas Instruments Incorporated -  https://www.ti.com
+ * Copyright (C) 2014 - 2024 Texas Instruments Incorporated -
+ *	https://www.ti.com
  *
  * Author: Dan Murphy <dmurphy@ti.com>
  */
@@ -119,12 +120,14 @@ static const struct snd_soc_dapm_widget tas2552_dapm_widgets[] =
 			 &tas2552_input_mux_control),
 
 	SND_SOC_DAPM_AIF_IN("DAC IN", "DAC Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("ASI OUT", "DAC Capture", 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_OUT_DRV("ClassD", TAS2552_CFG_2, 7, 0, NULL, 0),
 	SND_SOC_DAPM_SUPPLY("PLL", TAS2552_CFG_2, 3, 0, NULL, 0),
 	SND_SOC_DAPM_POST("Post Event", tas2552_post_event),
 
-	SND_SOC_DAPM_OUTPUT("OUT")
+	SND_SOC_DAPM_OUTPUT("OUT"),
+	SND_SOC_DAPM_INPUT("DMIC")
 };
 
 static const struct snd_soc_dapm_route tas2552_audio_map[] = {
@@ -134,6 +137,7 @@ static const struct snd_soc_dapm_route tas2552_audio_map[] = {
 	{"ClassD", NULL, "Input selection"},
 	{"OUT", NULL, "ClassD"},
 	{"ClassD", NULL, "PLL"},
+	{"ASI OUT", NULL, "DMIC"}
 };
 
 #ifdef CONFIG_PM
@@ -538,6 +542,13 @@ static struct snd_soc_dai_driver tas2552_dai[] = {
 			.rates = SNDRV_PCM_RATE_8000_192000,
 			.formats = TAS2552_FORMATS,
 		},
+		.capture = {
+			.stream_name = "Capture",
+			.channels_min = 2,
+			.channels_max = 2,
+			.rates = SNDRV_PCM_RATE_8000_192000,
+			.formats = TAS2552_FORMATS,
+		},
 		.ops = &tas2552_speaker_dai_ops,
 	},
 };
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index e49c64f54a12..5bc2f8c82ffc 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -750,6 +750,7 @@ static struct snd_soc_card broxton_audio_card = {
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 0d1df37ecea0..cd11a4025232 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -575,6 +575,7 @@ static struct snd_soc_card broxton_rt298 = {
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 
 };
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index 99b3d7642cb7..5f1eb7504832 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -603,6 +603,8 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	card = &glk_audio_card_rt5682_m98357a;
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, ctx);
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		card->disable_route_checks = true;
 
 	/* override platform name, if required */
 	mach = pdev->dev.platform_data;
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 14b625e947f5..77f6898b397d 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -621,6 +621,7 @@ static struct snd_soc_card kabylake_audio_card_da7219_m98357a = {
 	.dapm_routes = kabylake_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 2b43459adc33..2c57c9204d32 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -1018,6 +1018,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1036,6 +1037,7 @@ static struct snd_soc_card kbl_audio_card_max98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1053,6 +1055,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1070,6 +1073,7 @@ static struct snd_soc_card kbl_audio_card_max98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 289ca39b8206..776a1beaaf17 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -519,6 +519,7 @@ static struct snd_soc_card kabylake_audio_card_rt5660 = {
 	.dapm_routes = kabylake_rt5660_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_rt5660_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index a3e040a249f6..fa7d9cff9855 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -954,6 +954,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -970,6 +971,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663 = {
 	.dapm_routes = kabylake_5663_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_5663_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index dd38fdaf2ff5..673eaa891706 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -779,6 +779,7 @@ static struct snd_soc_card kabylake_audio_card = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index f4b4eeca3e03..6aad5232acbe 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -229,6 +229,8 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
 
 	hda_soc_card.dev = &pdev->dev;
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		hda_soc_card.disable_route_checks = true;
 
 	if (mach->mach_params.dmic_num > 0) {
 		snprintf(hda_soc_components, sizeof(hda_soc_components),
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index e3a1f04a8b53..3b62e15da95f 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -643,6 +643,7 @@ static struct snd_soc_card skylake_audio_card = {
 	.dapm_routes = skylake_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 75dab5405380..9c2ba695c1a1 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -524,6 +524,7 @@ static struct snd_soc_card skylake_rt286 = {
 	.dapm_routes = skylake_rt286_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_rt286_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index 640cebd2983e..16d2c9acc33a 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -182,6 +182,9 @@ static int kirkwood_dma_hw_params(struct snd_soc_component *component,
 	const struct mbus_dram_target_info *dram = mv_mbus_dram_info();
 	unsigned long addr = substream->runtime->dma_addr;
 
+	if (!dram)
+		return 0;
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		kirkwood_dma_conf_mbus_windows(priv->io,
 			KIRKWOOD_PLAYBACK_WIN, addr, dram);
diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
index f3bebed2428a..360259e60de8 100644
--- a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
+++ b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
@@ -566,10 +566,10 @@ static int mtk_dai_tdm_hw_params(struct snd_pcm_substream *substream,
 		tdm_con |= 1 << DELAY_DATA_SFT;
 		tdm_con |= get_tdm_lrck_width(format) << LRCK_TDM_WIDTH_SFT;
 	} else if (tdm_priv->tdm_out_mode == TDM_OUT_DSP_A) {
-		tdm_con |= 0 << DELAY_DATA_SFT;
+		tdm_con |= 1 << DELAY_DATA_SFT;
 		tdm_con |= 0 << LRCK_TDM_WIDTH_SFT;
 	} else if (tdm_priv->tdm_out_mode == TDM_OUT_DSP_B) {
-		tdm_con |= 1 << DELAY_DATA_SFT;
+		tdm_con |= 0 << DELAY_DATA_SFT;
 		tdm_con |= 0 << LRCK_TDM_WIDTH_SFT;
 	}
 
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index ec31f5b60323..1c25c1072a84 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -148,7 +148,7 @@ AVXcode:
 65: SEG=GS (Prefix)
 66: Operand-Size (Prefix)
 67: Address-Size (Prefix)
-68: PUSH Iz (d64)
+68: PUSH Iz
 69: IMUL Gv,Ev,Iz
 6a: PUSH Ib (d64)
 6b: IMUL Gv,Ev,Ib
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index 45e0d640618a..55ca620b5691 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -643,7 +643,7 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	int err;
+	off_t err;
 
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 69d7f0d65b38..54b8c899d21c 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6089,7 +6089,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 39ebf6192016..e799d35cba43 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -633,11 +633,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
+	char *buf = NULL;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
-		char *buf = NULL;
-
 		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
 
 		for (int i = 0; subcommands[i]; i++) {
@@ -679,7 +678,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
 		usage_with_options(usagestr, options);
 	}
-
+	if (buf) {
+		usagestr[0] = NULL;
+		free(buf);
+	}
 	return parse_options_end(&ctx);
 }
 
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index eefd445b96fc..7465cbe19bb0 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2014,9 +2014,9 @@ int main(int argc, char **argv)
 		free(options.whitelist);
 	if (options.blacklist)
 		free(options.blacklist);
+	close(cg_fd);
 	if (cg_created)
 		cleanup_cgroup_environment();
-	close(cg_fd);
 	return err;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/Makefile b/tools/testing/selftests/filesystems/binderfs/Makefile
index 8af25ae96049..24d8910c7ab5 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,6 +3,4 @@
 CFLAGS += -I../../../../../usr/include/ -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
-
 include ../../lib.mk
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 6ea7b9f37a41..d7a8e321bb16 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -88,7 +88,10 @@ int main(int argc, char **argv)
 		int pid2 = getpid();
 		int ret;
 
-		fd2 = open(kpath, O_RDWR, 0644);
+		ksft_print_header();
+		ksft_set_plan(3);
+
+		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
 			perror("Can't open file");
 			ksft_exit_fail();
@@ -152,7 +155,6 @@ int main(int argc, char **argv)
 			ksft_inc_pass_cnt();
 		}
 
-		ksft_print_cnts();
 
 		if (ret)
 			ksft_exit_fail();
@@ -162,5 +164,5 @@ int main(int argc, char **argv)
 
 	waitpid(pid2, &status, P_ALL);
 
-	return ksft_exit_pass();
+	return 0;
 }
diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 1162836f8f32..6dc3cb4ac608 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -481,10 +481,10 @@ v3exc_timeout_test()
 	RET=0
 	local X=("192.0.2.20" "192.0.2.30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -492,7 +492,7 @@ v3exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index e2b9ff773c6b..f84ab2e65754 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -478,10 +478,10 @@ mldv2exc_timeout_test()
 	RET=0
 	local X=("2001:db8:1::20" "2001:db8:1::30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	mldv2exclude_prepare $h1
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -489,7 +489,7 @@ mldv2exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 2deac2031de9..021863f86053 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -5,6 +5,8 @@ CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
 
+LOCAL_HDRS += $(wildcard *.h)
+
 include ../lib.mk
 
-$(OUTPUT)/resctrl_tests: $(wildcard *.[ch])
+$(OUTPUT)/resctrl_tests: $(wildcard *.c)
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index b5d592d4099e..d975a6767329 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -158,6 +158,20 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 
 	/* In preparation for sigreturn. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
+
+	/*
+	 * The tests for argument handling assume that `syscall(x) == x`. This
+	 * is a NOP on x86 because the syscall number is passed in %rax, which
+	 * happens to also be the function ABI return register.  Other
+	 * architectures may need to swizzle the arguments around.
+	 */
+#if defined(__riscv)
+/* REG_A7 is not defined in libc headers */
+# define REG_A7 (REG_A0 + 7)
+
+	((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A0] =
+			((ucontext_t *)ucontext)->uc_mcontext.__gregs[REG_A7];
+#endif
 }
 
 TEST(dispatch_and_return)
diff --git a/tools/tracing/latency/latency-collector.c b/tools/tracing/latency/latency-collector.c
index 59a7f2346eab..f7ed8084e16a 100644
--- a/tools/tracing/latency/latency-collector.c
+++ b/tools/tracing/latency/latency-collector.c
@@ -935,12 +935,12 @@ static void show_available(void)
 	}
 
 	if (!tracers) {
-		warnx(no_tracer_msg);
+		warnx("%s", no_tracer_msg);
 		return;
 	}
 
 	if (!found) {
-		warnx(no_latency_tr_msg);
+		warnx("%s", no_latency_tr_msg);
 		tracefs_list_free(tracers);
 		return;
 	}
@@ -983,7 +983,7 @@ static const char *find_default_tracer(void)
 	for (i = 0; relevant_tracers[i]; i++) {
 		valid = tracer_valid(relevant_tracers[i], &notracer);
 		if (notracer)
-			errx(EXIT_FAILURE, no_tracer_msg);
+			errx(EXIT_FAILURE, "%s", no_tracer_msg);
 		if (valid)
 			return relevant_tracers[i];
 	}
@@ -1878,7 +1878,7 @@ static void scan_arguments(int argc, char *argv[])
 			}
 			valid = tracer_valid(current_tracer, &notracer);
 			if (notracer)
-				errx(EXIT_FAILURE, no_tracer_msg);
+				errx(EXIT_FAILURE, "%s", no_tracer_msg);
 			if (!valid)
 				errx(EXIT_FAILURE,
 "The tracer %s is not supported by your kernel!\n", current_tracer);

