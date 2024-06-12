Return-Path: <stable+bounces-50216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60015904F78
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 11:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F502B2318E
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08416DED8;
	Wed, 12 Jun 2024 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="niGClVrP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964016DED6;
	Wed, 12 Jun 2024 09:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185424; cv=none; b=AN8VF8hu+88agAM8o79v0eKP4ID1ByqaBVSulMLn38EKZ93OPNLys81DlgC6bzrAt98CZRjvmJzqqXyJ64zT7goCXXT61SYjbJu+3iZriHuz0dbX5oD9MLP1vVGJvnYhVwrXGZu2Ax4RoFlccAoLq5T21AJHgwSlXD7LnJwCrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185424; c=relaxed/simple;
	bh=WsS9ChgtbaGBUu+5DTxbfM2eqIL9QQgZCZunatvbfGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTk4AtN5rR7mEcm5/3a2uW0uGKMCGegKL53J1ay2Sjg5ebty3UCnL512SC1VVqwANxm7HHBAc+wriOBiqqy3vCruvdsWffeOEeke7WqKi05TJ4Qa+RfhGOxYNDkrZ7pXjZgaZ8M1Xk525L7PDZ9RCkY5d7D1LLGmAEmgaUmu0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=niGClVrP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2441C3277B;
	Wed, 12 Jun 2024 09:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718185424;
	bh=WsS9ChgtbaGBUu+5DTxbfM2eqIL9QQgZCZunatvbfGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niGClVrP8k93t/rrjLDFpzEfNhj6Hjx1G6vwTGWLJrLUk7vmBHeJD9q8SY5+lgc/D
	 hNSTH9q8EAPVz5QGw91tuZmEOCIaTlELO4xX3UWtoBzD/hJuR3H3aAar1hPp6+DsBP
	 Hg91TtL+ROowKfSAd6I0hMJGh4n/CY7k/slGU0a4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.93
Date: Wed, 12 Jun 2024 11:43:30 +0200
Message-ID: <2024061230-clench-could-293b@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061229-neuter-whooping-632b@gregkh>
References: <2024061229-neuter-whooping-632b@gregkh>
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
index c9ea0cad489b..376798140900 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
@@ -97,7 +97,8 @@ patternProperties:
             then:
               properties:
                 groups:
-                  enum: [emmc, emmc_rst]
+                  items:
+                    enum: [emmc, emmc_rst]
           - if:
               properties:
                 function:
@@ -105,8 +106,9 @@ patternProperties:
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
@@ -123,10 +125,11 @@ patternProperties:
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
@@ -159,10 +162,11 @@ patternProperties:
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
@@ -178,11 +182,12 @@ patternProperties:
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
@@ -260,33 +265,34 @@ patternProperties:
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
index 2ed8cca79b59..e4eade2661f6 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -151,6 +151,7 @@ allOf:
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
index dc55d60a0b4a..2d03b5fb7657 100644
--- a/Documentation/driver-api/fpga/fpga-region.rst
+++ b/Documentation/driver-api/fpga/fpga-region.rst
@@ -46,13 +46,16 @@ API to add a new FPGA region
 ----------------------------
 
 * struct fpga_region - The FPGA region struct
-* struct fpga_region_info - Parameter structure for fpga_region_register_full()
-* fpga_region_register_full() -  Create and register an FPGA region using the
+* struct fpga_region_info - Parameter structure for __fpga_region_register_full()
+* __fpga_region_register_full() -  Create and register an FPGA region using the
   fpga_region_info structure to provide the full flexibility of options
-* fpga_region_register() -  Create and register an FPGA region using standard
+* __fpga_region_register() -  Create and register an FPGA region using standard
   arguments
 * fpga_region_unregister() -  Unregister an FPGA region
 
+Helper macros ``fpga_region_register()`` and ``fpga_region_register_full()``
+automatically set the module that registers the FPGA region as the owner.
+
 The FPGA region's probe function will need to get a reference to the FPGA
 Manager it will be using to do the programming.  This usually would happen
 during the region's probe function.
@@ -82,10 +85,10 @@ following APIs to handle building or tearing down that list.
    :functions: fpga_region_info
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register_full
+   :functions: __fpga_region_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
-   :functions: fpga_region_register
+   :functions: __fpga_region_register
 
 .. kernel-doc:: drivers/fpga/fpga-region.c
    :functions: fpga_region_unregister
diff --git a/Documentation/networking/device_drivers/ethernet/amazon/ena.rst b/Documentation/networking/device_drivers/ethernet/amazon/ena.rst
index 8bcb173e0353..491492677632 100644
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
index 0be668057cb2..c5147f1c46f8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 92
+SUBLEVEL = 93
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index bddc82f78942..a83d29fed175 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -110,6 +110,7 @@ CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
 CONFIG_DRM_PANEL_EDP=y
 CONFIG_DRM_SIMPLE_BRIDGE=y
+CONFIG_DRM_DW_HDMI=y
 CONFIG_DRM_LIMA=y
 CONFIG_FB_SIMPLE=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index 372a03762d69..a1c55b047708 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -61,10 +61,15 @@ xtal: xtal-clk {
 		#clock-cells = <0>;
 	};
 
-	pwrc: power-controller {
-		compatible = "amlogic,meson-s4-pwrc";
-		#power-domain-cells = <1>;
-		status = "okay";
+	firmware {
+		sm: secure-monitor {
+			compatible = "amlogic,meson-gxbb-sm";
+
+			pwrc: power-controller {
+				compatible = "amlogic,meson-s4-pwrc";
+				#power-domain-cells = <1>;
+			};
+		};
 	};
 
 	soc {
diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index c762038ba400..6e73809f6492 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -28,6 +28,7 @@
 	14470:	.long 14471f - .;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
+		.align 2;				\
 		.popsection;				\
 	14471:
 #else
diff --git a/arch/loongarch/include/asm/perf_event.h b/arch/loongarch/include/asm/perf_event.h
index 52b638059e40..f948a0676daf 100644
--- a/arch/loongarch/include/asm/perf_event.h
+++ b/arch/loongarch/include/asm/perf_event.h
@@ -13,8 +13,7 @@
 
 #define perf_arch_fetch_caller_regs(regs, __ip) { \
 	(regs)->csr_era = (__ip); \
-	(regs)->regs[3] = current_stack_pointer; \
-	(regs)->regs[22] = (unsigned long) __builtin_frame_address(0); \
+	(regs)->regs[3] = (unsigned long) __builtin_frame_address(0); \
 }
 
 #endif /* __LOONGARCH_PERF_EVENT_H__ */
diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 3a2edb157b65..1563bf47f3e2 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -884,4 +884,4 @@ static int __init init_hw_perf_events(void)
 
 	return 0;
 }
-early_initcall(init_hw_perf_events);
+pure_initcall(init_hw_perf_events);
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 42879e6eb651..1219318304b2 100644
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
index 4393bee64eaf..85c4d29ef43e 100644
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
index 95fd7f9485d5..47bc10cdb70b 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -539,7 +539,7 @@ struct hvcall_mpp_data {
 	unsigned long backing_mem;
 };
 
-int h_get_mpp(struct hvcall_mpp_data *);
+long h_get_mpp(struct hvcall_mpp_data *mpp_data);
 
 struct hvcall_mpp_x_data {
 	unsigned long coalesced_bytes;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 5186d65d772e..29d235b02f06 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -1904,10 +1904,10 @@ notrace void __trace_hcall_exit(long opcode, long retval, unsigned long *retbuf)
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
index ca10a3682c46..a6f2d71831cc 100644
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
@@ -393,8 +393,8 @@ static int read_dt_lpar_name(struct seq_file *m)
 
 static void read_lpar_name(struct seq_file *m)
 {
-	if (read_rtas_lpar_name(m) && read_dt_lpar_name(m))
-		pr_err_once("Error can't get the LPAR name");
+	if (read_rtas_lpar_name(m))
+		read_dt_lpar_name(m);
 }
 
 #define SPLPAR_CHARACTERISTICS_TOKEN 20
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 73c2d70706c0..e50445c2656a 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -567,10 +567,12 @@ static const struct fsl_msi_feature ipic_msi_feature = {
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
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index efa0f0816634..93cbc38d1805 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -72,7 +72,7 @@ static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 	/* Make sure tidle is updated */
 	smp_mb();
 	bdata->task_ptr = tidle;
-	bdata->stack_ptr = task_stack_page(tidle) + THREAD_SIZE;
+	bdata->stack_ptr = task_pt_regs(tidle);
 	/* Make sure boot data is updated */
 	smp_mb();
 	hsm_data = __pa(bdata);
diff --git a/arch/riscv/kernel/cpu_ops_spinwait.c b/arch/riscv/kernel/cpu_ops_spinwait.c
index d98d19226b5f..691e0c5366d2 100644
--- a/arch/riscv/kernel/cpu_ops_spinwait.c
+++ b/arch/riscv/kernel/cpu_ops_spinwait.c
@@ -34,8 +34,7 @@ static void cpu_update_secondary_bootdata(unsigned int cpuid,
 
 	/* Make sure tidle is updated */
 	smp_mb();
-	WRITE_ONCE(__cpu_spinwait_stack_pointer[hartid],
-		   task_stack_page(tidle) + THREAD_SIZE);
+	WRITE_ONCE(__cpu_spinwait_stack_pointer[hartid], task_pt_regs(tidle));
 	WRITE_ONCE(__cpu_spinwait_task_pointer[hartid], tidle);
 }
 
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 3221a9e5f372..99d38fdf8b18 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -248,7 +248,7 @@ ret_from_syscall_rejected:
 	andi t0, t0, _TIF_SYSCALL_WORK
 	bnez t0, handle_syscall_trace_exit
 
-ret_from_exception:
+SYM_CODE_START_NOALIGN(ret_from_exception)
 	REG_L s0, PT_STATUS(sp)
 	csrc CSR_STATUS, SR_IE
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -262,6 +262,7 @@ ret_from_exception:
 	andi s0, s0, SR_SPP
 #endif
 	bnez s0, resume_kernel
+SYM_CODE_END(ret_from_exception)
 
 	/* Interrupts must be disabled here so flags are checked atomically */
 	REG_L s0, TASK_TI_FLAGS(tp) /* current_thread_info->flags */
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 17d7383f201a..528ec7cc9a62 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,6 +16,18 @@
 
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
@@ -39,27 +51,32 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
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
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 8f5d3c57d58a..4c4ac563326b 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -503,33 +503,33 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 		break;
 	/* src_reg = atomic_fetch_<op>(dst_reg + off16, src_reg) */
 	case BPF_ADD | BPF_FETCH:
-		emit(is64 ? rv_amoadd_d(rs, rs, rd, 0, 0) :
-		     rv_amoadd_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoadd_d(rs, rs, rd, 1, 1) :
+		     rv_amoadd_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_AND | BPF_FETCH:
-		emit(is64 ? rv_amoand_d(rs, rs, rd, 0, 0) :
-		     rv_amoand_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoand_d(rs, rs, rd, 1, 1) :
+		     rv_amoand_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_OR | BPF_FETCH:
-		emit(is64 ? rv_amoor_d(rs, rs, rd, 0, 0) :
-		     rv_amoor_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoor_d(rs, rs, rd, 1, 1) :
+		     rv_amoor_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	case BPF_XOR | BPF_FETCH:
-		emit(is64 ? rv_amoxor_d(rs, rs, rd, 0, 0) :
-		     rv_amoxor_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoxor_d(rs, rs, rd, 1, 1) :
+		     rv_amoxor_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
 	/* src_reg = atomic_xchg(dst_reg + off16, src_reg); */
 	case BPF_XCHG:
-		emit(is64 ? rv_amoswap_d(rs, rs, rd, 0, 0) :
-		     rv_amoswap_w(rs, rs, rd, 0, 0), ctx);
+		emit(is64 ? rv_amoswap_d(rs, rs, rd, 1, 1) :
+		     rv_amoswap_w(rs, rs, rd, 1, 1), ctx);
 		if (!is64)
 			emit_zext_32(rs, ctx);
 		break;
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index e0863d28759a..bfb4dec36414 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -30,7 +30,6 @@ int __bootdata(is_full_image) = 1;
 struct initrd_data __bootdata(initrd_data);
 
 u64 __bootdata_preserved(stfle_fac_list[16]);
-u64 __bootdata_preserved(alt_stfle_fac_list[16]);
 struct oldmem_data __bootdata_preserved(oldmem_data);
 
 void error(char *x)
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index df5d2ec737d8..3aa3fff9bde0 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -834,8 +834,8 @@ static ssize_t reipl_nvme_scpdata_write(struct file *filp, struct kobject *kobj,
 		scpdata_len += padding;
 	}
 
-	reipl_block_nvme->hdr.len = IPL_BP_FCP_LEN + scpdata_len;
-	reipl_block_nvme->nvme.len = IPL_BP0_FCP_LEN + scpdata_len;
+	reipl_block_nvme->hdr.len = IPL_BP_NVME_LEN + scpdata_len;
+	reipl_block_nvme->nvme.len = IPL_BP0_NVME_LEN + scpdata_len;
 	reipl_block_nvme->nvme.scp_data_len = scpdata_len;
 
 	return count;
@@ -1604,9 +1604,9 @@ static int __init dump_nvme_init(void)
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
index 2ec5f1e0312f..1f514557fee9 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -155,7 +155,7 @@ unsigned int __bootdata_preserved(zlib_dfltcc_support);
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
index fbdba4c306be..862386393557 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1207,8 +1207,12 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
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
index aed1ea8e2c2f..74051b8ddf3e 100644
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
index f4c1e6e97ad5..13a22a461305 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1099,7 +1099,7 @@ static int __init ubd_init(void)
 
 	if (irq_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	io_req_buffer = kmalloc_array(UBD_REQ_BUFFER_SIZE,
 				      sizeof(struct io_thread_req *),
@@ -1110,7 +1110,7 @@ static int __init ubd_init(void)
 
 	if (io_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	platform_driver_register(&ubd_driver);
 	mutex_lock(&ubd_lock);
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index 131b7cb29576..94a4dfac6c23 100644
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
diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
index 0d6547f4ec85..f97bb1f7b851 100644
--- a/arch/um/include/asm/kasan.h
+++ b/arch/um/include/asm/kasan.h
@@ -24,7 +24,6 @@
 
 #ifdef CONFIG_KASAN
 void kasan_init(void);
-void kasan_map_memory(void *start, unsigned long len);
 extern int kasan_um_is_ready;
 
 #ifdef CONFIG_STATIC_LINK
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
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index bb5f06480da9..9adfcef579c1 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -95,7 +95,6 @@ extern struct cpuinfo_um boot_cpu_data;
 #define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
-extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
 extern unsigned long __get_wchan(struct task_struct *p);
 
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 444bae755b16..7372746c1687 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -67,4 +67,6 @@ extern void fatal_sigsegv(void) __attribute__ ((noreturn));
 
 void um_idle_sleep(void);
 
+void kasan_map_memory(void *start, size_t len);
+
 #endif
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
diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
index 8530b2e08604..c6c9495b1432 100644
--- a/arch/um/os-Linux/mem.c
+++ b/arch/um/os-Linux/mem.c
@@ -15,6 +15,7 @@
 #include <sys/vfs.h>
 #include <linux/magic.h>
 #include <init.h>
+#include <kern_util.h>
 #include <os.h>
 
 /*
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index bdfe08f1a930..584fb1eea2cb 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -248,6 +248,7 @@ config UNWINDER_ORC
 
 config UNWINDER_FRAME_POINTER
 	bool "Frame pointer unwinder"
+	select ARCH_WANT_FRAME_POINTERS
 	select FRAME_POINTER
 	help
 	  This option enables the frame pointer unwinder for unwinding kernel
@@ -271,7 +272,3 @@ config UNWINDER_GUESS
 	  overhead.
 
 endchoice
-
-config FRAME_POINTER
-	depends on !UNWINDER_ORC && !UNWINDER_GUESS
-	bool
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 0d7aef10b19a..6bc70385314c 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -390,6 +390,11 @@ SYM_CODE_START(startup_64)
 	call	sev_enable
 #endif
 
+	/* Preserve only the CR4 bits that must be preserved, and clear the rest */
+	movq	%cr4, %rax
+	andl	$(X86_CR4_PAE | X86_CR4_MCE | X86_CR4_LA57), %eax
+	movq	%rax, %cr4
+
 	/*
 	 * configure_5level_paging() updates the number of paging levels using
 	 * a trampoline in 32-bit addressable memory if the current number does
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
index 2d2be531a11e..eaa093f973cc 100644
--- a/arch/x86/crypto/sha256-avx2-asm.S
+++ b/arch/x86/crypto/sha256-avx2-asm.S
@@ -711,6 +711,7 @@ done_hash:
 	popq	%r13
 	popq	%r12
 	popq	%rbx
+	vzeroupper
 	RET
 SYM_FUNC_END(sha256_transform_rorx)
 
diff --git a/arch/x86/crypto/sha512-avx2-asm.S b/arch/x86/crypto/sha512-avx2-asm.S
index b1ca99055ef9..17d6c756b541 100644
--- a/arch/x86/crypto/sha512-avx2-asm.S
+++ b/arch/x86/crypto/sha512-avx2-asm.S
@@ -680,6 +680,7 @@ done_hash:
 	pop	%r12
 	pop	%rbx
 
+	vzeroupper
 	RET
 SYM_FUNC_END(sha512_transform_rorx)
 
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 4af81df133ee..5d4ca8b94293 100644
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
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index f0b9b37c4609..e3028373f0b4 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -544,6 +544,8 @@ static inline void update_page_count(int level, unsigned long pages) { }
 extern pte_t *lookup_address(unsigned long address, unsigned int *level);
 extern pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 				    unsigned int *level);
+pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
+				  unsigned int *level, bool *nx, bool *rw);
 extern pmd_t *lookup_pmd_address(unsigned long address);
 extern phys_addr_t slow_virt_to_phys(void *__address);
 extern int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn,
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 94ea13adb724..3ed6cc778503 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -519,7 +519,6 @@ struct thread_struct {
 	unsigned long		iopl_emul;
 
 	unsigned int		iopl_warn:1;
-	unsigned int		sig_on_uaccess_err:1;
 
 	/*
 	 * Protection Keys Register for Userspace.  Loaded immediately on
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..64df897c0ee3 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,8 +37,6 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
-extern int numa_fill_memblks(u64 start, u64 end);
-#define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3e6f6b448f6a..d261b4c207d0 100644
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
index f02961cbbb75..3818c85cf964 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1157,9 +1157,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
@@ -1167,16 +1166,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
index d12d1358f96d..8eaf140172c5 100644
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
@@ -698,10 +698,10 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66),(ev)
-51: vpdpbusds Vx,Hx,Wx (66),(ev)
-52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
-53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+50: vpdpbusd Vx,Hx,Wx (66)
+51: vpdpbusds Vx,Hx,Wx (66)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
 55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f20636510eb1..2fc007752ceb 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -737,39 +737,8 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
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
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index dae5c952735c..c7fa5396c0f0 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -956,6 +956,8 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+#endif
+
 static int __init cmp_memblk(const void *a, const void *b)
 {
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
@@ -1028,5 +1030,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	}
 	return 0;
 }
-
-#endif
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 68d4f328f169..fd412dec0125 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -583,7 +583,8 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long start,
  * Validate strict W^X semantics.
  */
 static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
-				  unsigned long pfn, unsigned long npg)
+				  unsigned long pfn, unsigned long npg,
+				  bool nx, bool rw)
 {
 	unsigned long end;
 
@@ -609,6 +610,10 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
 		return new;
 
+	/* Non-leaf translation entries can disable writing or execution. */
+	if (!rw || nx)
+		return new;
+
 	end = start + npg * PAGE_SIZE - 1;
 	WARN_ONCE(1, "CPA detected W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
 		  (unsigned long long)pgprot_val(old),
@@ -625,20 +630,26 @@ static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long star
 
 /*
  * Lookup the page table entry for a virtual address in a specific pgd.
- * Return a pointer to the entry and the level of the mapping.
+ * Return a pointer to the entry, the level of the mapping, and the effective
+ * NX and RW bits of all page table levels.
  */
-pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
-			     unsigned int *level)
+pte_t *lookup_address_in_pgd_attr(pgd_t *pgd, unsigned long address,
+				  unsigned int *level, bool *nx, bool *rw)
 {
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 
 	*level = PG_LEVEL_NONE;
+	*nx = false;
+	*rw = true;
 
 	if (pgd_none(*pgd))
 		return NULL;
 
+	*nx |= pgd_flags(*pgd) & _PAGE_NX;
+	*rw &= pgd_flags(*pgd) & _PAGE_RW;
+
 	p4d = p4d_offset(pgd, address);
 	if (p4d_none(*p4d))
 		return NULL;
@@ -647,6 +658,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (p4d_large(*p4d) || !p4d_present(*p4d))
 		return (pte_t *)p4d;
 
+	*nx |= p4d_flags(*p4d) & _PAGE_NX;
+	*rw &= p4d_flags(*p4d) & _PAGE_RW;
+
 	pud = pud_offset(p4d, address);
 	if (pud_none(*pud))
 		return NULL;
@@ -655,6 +669,9 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (pud_large(*pud) || !pud_present(*pud))
 		return (pte_t *)pud;
 
+	*nx |= pud_flags(*pud) & _PAGE_NX;
+	*rw &= pud_flags(*pud) & _PAGE_RW;
+
 	pmd = pmd_offset(pud, address);
 	if (pmd_none(*pmd))
 		return NULL;
@@ -663,11 +680,26 @@ pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
 	if (pmd_large(*pmd) || !pmd_present(*pmd))
 		return (pte_t *)pmd;
 
+	*nx |= pmd_flags(*pmd) & _PAGE_NX;
+	*rw &= pmd_flags(*pmd) & _PAGE_RW;
+
 	*level = PG_LEVEL_4K;
 
 	return pte_offset_kernel(pmd, address);
 }
 
+/*
+ * Lookup the page table entry for a virtual address in a specific pgd.
+ * Return a pointer to the entry and the level of the mapping.
+ */
+pte_t *lookup_address_in_pgd(pgd_t *pgd, unsigned long address,
+			     unsigned int *level)
+{
+	bool nx, rw;
+
+	return lookup_address_in_pgd_attr(pgd, address, level, &nx, &rw);
+}
+
 /*
  * Lookup the page table entry for a virtual address. Return a pointer
  * to the entry and the level of the mapping.
@@ -683,13 +715,16 @@ pte_t *lookup_address(unsigned long address, unsigned int *level)
 EXPORT_SYMBOL_GPL(lookup_address);
 
 static pte_t *_lookup_address_cpa(struct cpa_data *cpa, unsigned long address,
-				  unsigned int *level)
+				  unsigned int *level, bool *nx, bool *rw)
 {
-	if (cpa->pgd)
-		return lookup_address_in_pgd(cpa->pgd + pgd_index(address),
-					       address, level);
+	pgd_t *pgd;
+
+	if (!cpa->pgd)
+		pgd = pgd_offset_k(address);
+	else
+		pgd = cpa->pgd + pgd_index(address);
 
-	return lookup_address(address, level);
+	return lookup_address_in_pgd_attr(pgd, address, level, nx, rw);
 }
 
 /*
@@ -813,12 +848,13 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	pgprot_t old_prot, new_prot, req_prot, chk_prot;
 	pte_t new_pte, *tmp;
 	enum pg_level level;
+	bool nx, rw;
 
 	/*
 	 * Check for races, another CPU might have split this page
 	 * up already:
 	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
+	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
 	if (tmp != kpte)
 		return 1;
 
@@ -929,7 +965,8 @@ static int __should_split_large_page(pte_t *kpte, unsigned long address,
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
 				      psize, CPA_DETECT);
 
-	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages);
+	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages,
+			      nx, rw);
 
 	/*
 	 * If there is a conflict, split the large page.
@@ -1010,6 +1047,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	pte_t *pbase = (pte_t *)page_address(base);
 	unsigned int i, level;
 	pgprot_t ref_prot;
+	bool nx, rw;
 	pte_t *tmp;
 
 	spin_lock(&pgd_lock);
@@ -1017,7 +1055,7 @@ __split_large_page(struct cpa_data *cpa, pte_t *kpte, unsigned long address,
 	 * Check for races, another CPU might have split this page
 	 * up for us already:
 	 */
-	tmp = _lookup_address_cpa(cpa, address, &level);
+	tmp = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
 	if (tmp != kpte) {
 		spin_unlock(&pgd_lock);
 		return 1;
@@ -1558,10 +1596,11 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 	int do_split, err;
 	unsigned int level;
 	pte_t *kpte, old_pte;
+	bool nx, rw;
 
 	address = __cpa_addr(cpa, cpa->curpage);
 repeat:
-	kpte = _lookup_address_cpa(cpa, address, &level);
+	kpte = _lookup_address_cpa(cpa, address, &level, &nx, &rw);
 	if (!kpte)
 		return __cpa_process_fault(cpa, address, primary);
 
@@ -1583,7 +1622,8 @@ static int __change_page_attr(struct cpa_data *cpa, int primary)
 		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
-		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1);
+		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1,
+				      nx, rw);
 
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index d28e0987aa85..ebb1b786591d 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -42,7 +42,8 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -g0
+PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
 
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 9a5b101c4502..4fd824a44824 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -746,6 +746,15 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
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
diff --git a/arch/x86/um/shared/sysdep/archsetjmp.h b/arch/x86/um/shared/sysdep/archsetjmp.h
index 166cedbab926..8c81d1a604a9 100644
--- a/arch/x86/um/shared/sysdep/archsetjmp.h
+++ b/arch/x86/um/shared/sysdep/archsetjmp.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __X86_UM_SYSDEP_ARCHSETJMP_H
+#define __X86_UM_SYSDEP_ARCHSETJMP_H
+
 #ifdef __i386__
 #include "archsetjmp_32.h"
 #else
 #include "archsetjmp_64.h"
 #endif
+
+unsigned long get_thread_reg(int reg, jmp_buf *buf);
+
+#endif /* __X86_UM_SYSDEP_ARCHSETJMP_H */
diff --git a/block/blk-core.c b/block/blk-core.c
index aefdf07bdc2c..a4155f123ab3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -933,10 +933,11 @@ void update_io_ticks(struct block_device *part, unsigned long now, bool end)
 	unsigned long stamp;
 again:
 	stamp = READ_ONCE(part->bd_stamp);
-	if (unlikely(time_after(now, stamp))) {
-		if (likely(try_cmpxchg(&part->bd_stamp, &stamp, now)))
-			__part_stat_add(part, io_ticks, end ? now - stamp : 1);
-	}
+	if (unlikely(time_after(now, stamp)) &&
+	    likely(try_cmpxchg(&part->bd_stamp, &stamp, now)) &&
+	    (end || part_in_flight(part)))
+		__part_stat_add(part, io_ticks, now - stamp);
+
 	if (part->bd_partno) {
 		part = bdev_whole(part);
 		goto again;
diff --git a/block/blk-merge.c b/block/blk-merge.c
index cc7f6a4a255c..13a47b37acb7 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -779,6 +779,8 @@ static void blk_account_io_merge_request(struct request *req)
 	if (blk_do_io_stat(req)) {
 		part_stat_lock();
 		part_stat_inc(req->part, merges[op_stat_group(req_op(req))]);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
 		part_stat_unlock();
 	}
 }
diff --git a/block/blk-mq.c b/block/blk-mq.c
index e1b12f3d54bd..3afa5c8d165b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -971,17 +971,6 @@ bool blk_update_request(struct request *req, blk_status_t error,
 }
 EXPORT_SYMBOL_GPL(blk_update_request);
 
-static void __blk_account_io_done(struct request *req, u64 now)
-{
-	const int sgrp = op_stat_group(req_op(req));
-
-	part_stat_lock();
-	update_io_ticks(req->part, jiffies, true);
-	part_stat_inc(req->part, ios[sgrp]);
-	part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
-	part_stat_unlock();
-}
-
 static inline void blk_account_io_done(struct request *req, u64 now)
 {
 	/*
@@ -990,32 +979,39 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 	 * containing request is enough.
 	 */
 	if (blk_do_io_stat(req) && req->part &&
-	    !(req->rq_flags & RQF_FLUSH_SEQ))
-		__blk_account_io_done(req, now);
-}
-
-static void __blk_account_io_start(struct request *rq)
-{
-	/*
-	 * All non-passthrough requests are created from a bio with one
-	 * exception: when a flush command that is part of a flush sequence
-	 * generated by the state machine in blk-flush.c is cloned onto the
-	 * lower device by dm-multipath we can get here without a bio.
-	 */
-	if (rq->bio)
-		rq->part = rq->bio->bi_bdev;
-	else
-		rq->part = rq->q->disk->part0;
+	    !(req->rq_flags & RQF_FLUSH_SEQ)) {
+		const int sgrp = op_stat_group(req_op(req));
 
-	part_stat_lock();
-	update_io_ticks(rq->part, jiffies, false);
-	part_stat_unlock();
+		part_stat_lock();
+		update_io_ticks(req->part, jiffies, true);
+		part_stat_inc(req->part, ios[sgrp]);
+		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_local_dec(req->part,
+				    in_flight[op_is_write(req_op(req))]);
+		part_stat_unlock();
+	}
 }
 
 static inline void blk_account_io_start(struct request *req)
 {
-	if (blk_do_io_stat(req))
-		__blk_account_io_start(req);
+	if (blk_do_io_stat(req)) {
+		/*
+		 * All non-passthrough requests are created from a bio with one
+		 * exception: when a flush command that is part of a flush sequence
+		 * generated by the state machine in blk-flush.c is cloned onto the
+		 * lower device by dm-multipath we can get here without a bio.
+		 */
+		if (req->bio)
+			req->part = req->bio->bi_bdev;
+		else
+			req->part = req->q->disk->part0;
+
+		part_stat_lock();
+		update_io_ticks(req->part, jiffies, false);
+		part_stat_local_inc(req->part,
+				    in_flight[op_is_write(req_op(req))]);
+		part_stat_unlock();
+	}
 }
 
 static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
diff --git a/block/blk.h b/block/blk.h
index a186ea20f39d..9b2f53ff4c37 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -346,6 +346,7 @@ static inline bool blk_do_io_stat(struct request *rq)
 }
 
 void update_io_ticks(struct block_device *part, unsigned long now, bool end);
+unsigned int part_in_flight(struct block_device *part);
 
 static inline void req_set_nomerge(struct request_queue *q, struct request *req)
 {
diff --git a/block/genhd.c b/block/genhd.c
index ddb17c4adc8a..f9e3ecd5ba2f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -123,7 +123,7 @@ static void part_stat_read_all(struct block_device *part,
 	}
 }
 
-static unsigned int part_in_flight(struct block_device *part)
+unsigned int part_in_flight(struct block_device *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 3df3fe4ed95f..a7c09785f572 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -84,5 +84,7 @@ config FIPS_SIGNATURE_SELFTEST
 	depends on KEYS
 	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER
+	depends on CRYPTO_RSA
+	depends on CRYPTO_SHA256
 
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 45d906f17ea3..10aa9c2ec400 100644
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
diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 8b44743945c8..52af775ac1f1 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -319,6 +319,7 @@ static const struct lpss_device_desc bsw_i2c_dev_desc = {
 
 static const struct property_entry bsw_spi_properties[] = {
 	PROPERTY_ENTRY_U32("intel,spi-pxa2xx-type", LPSS_BSW_SSP),
+	PROPERTY_ENTRY_U32("num-cs", 2),
 	{ }
 };
 
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
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index b57de78fbf14..a44c0761fd1c 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -206,6 +206,11 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
+__weak int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+
 #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 959952e8ede3..220cedda2ca7 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2298,10 +2298,13 @@ static void __exit null_exit(void)
 
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
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index a0fadde993d7..2dda94a0875a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -148,8 +148,10 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
 	}
 
 	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
-	if (!build_label)
+	if (!build_label) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 	hci_set_fw_info(hdev, "%s", build_label);
 
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
diff --git a/drivers/clk/clk-renesas-pcie.c b/drivers/clk/clk-renesas-pcie.c
index 35b2519f1696..bba0e7c667dc 100644
--- a/drivers/clk/clk-renesas-pcie.c
+++ b/drivers/clk/clk-renesas-pcie.c
@@ -24,10 +24,12 @@
 #define RS9_REG_SS_AMP_0V7			0x1
 #define RS9_REG_SS_AMP_0V8			0x2
 #define RS9_REG_SS_AMP_0V9			0x3
+#define RS9_REG_SS_AMP_DEFAULT			RS9_REG_SS_AMP_0V8
 #define RS9_REG_SS_AMP_MASK			0x3
 #define RS9_REG_SS_SSC_100			0
 #define RS9_REG_SS_SSC_M025			(1 << 3)
 #define RS9_REG_SS_SSC_M050			(3 << 3)
+#define RS9_REG_SS_SSC_DEFAULT			RS9_REG_SS_SSC_100
 #define RS9_REG_SS_SSC_MASK			(3 << 3)
 #define RS9_REG_SS_SSC_LOCK			BIT(5)
 #define RS9_REG_SR				0x2
@@ -196,8 +198,8 @@ static int rs9_get_common_config(struct rs9_driver_data *rs9)
 	int ret;
 
 	/* Set defaults */
-	rs9->pll_amplitude = RS9_REG_SS_AMP_0V7;
-	rs9->pll_ssc = RS9_REG_SS_SSC_100;
+	rs9->pll_amplitude = RS9_REG_SS_AMP_DEFAULT;
+	rs9->pll_ssc = RS9_REG_SS_SSC_DEFAULT;
 
 	/* Output clock amplitude */
 	ret = of_property_read_u32(np, "renesas,out-amplitude-microvolt",
@@ -238,13 +240,13 @@ static void rs9_update_config(struct rs9_driver_data *rs9)
 	int i;
 
 	/* If amplitude is non-default, update it. */
-	if (rs9->pll_amplitude != RS9_REG_SS_AMP_0V7) {
+	if (rs9->pll_amplitude != RS9_REG_SS_AMP_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_AMP_MASK,
 				   rs9->pll_amplitude);
 	}
 
 	/* If SSC is non-default, update it. */
-	if (rs9->pll_ssc != RS9_REG_SS_SSC_100) {
+	if (rs9->pll_ssc != RS9_REG_SS_SSC_DEFAULT) {
 		regmap_update_bits(rs9->regmap, RS9_REG_SS, RS9_REG_SS_SSC_MASK,
 				   rs9->pll_ssc);
 	}
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 22c75a03a645..bc0b1162ed43 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -53,7 +53,7 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM0(CLK_MM_MM_DSI0, "mm_dsi0", "mm_sel", 17),
 	GATE_MM0(CLK_MM_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 18),
 	GATE_MM0(CLK_MM_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 19),
-	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "vpll_dpix", 20),
+	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "dpi0_sel", 20),
 	GATE_MM0(CLK_MM_MM_FAKE, "mm_fake", "mm_sel", 21),
 	GATE_MM0(CLK_MM_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 22),
 	GATE_MM0(CLK_MM_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 23),
diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
index ea6f54ed846e..441f042f5ea4 100644
--- a/drivers/clk/qcom/dispcc-sm6350.c
+++ b/drivers/clk/qcom/dispcc-sm6350.c
@@ -221,26 +221,17 @@ static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] = {
-	F(162000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dp_link_clk_src = {
 	.cmd_rcgr = 0x10f8,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_0,
-	.freq_tbl = ftbl_disp_cc_mdss_dp_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "disp_cc_mdss_dp_link_clk_src",
 		.parent_data = disp_cc_parent_data_0,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
 		.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
index 64626f620a01..e7dd45a2058c 100644
--- a/drivers/clk/qcom/dispcc-sm8450.c
+++ b/drivers/clk/qcom/dispcc-sm8450.c
@@ -309,26 +309,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
 	},
 };
 
-static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
-	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
-	{ }
-};
-
 static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
 	.cmd_rcgr = 0x819c,
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx0_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -382,13 +373,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx1_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -442,13 +432,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx2_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
@@ -502,13 +491,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
 	.mnd_width = 0,
 	.hid_width = 5,
 	.parent_map = disp_cc_parent_map_3,
-	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
 	.clkr.hw.init = &(struct clk_init_data) {
 		.name = "disp_cc_mdss_dptx3_link_clk_src",
 		.parent_data = disp_cc_parent_data_3,
 		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
 		.flags = CLK_SET_RATE_PARENT,
-		.ops = &clk_rcg2_ops,
+		.ops = &clk_byte2_ops,
 	},
 };
 
diff --git a/drivers/clk/qcom/mmcc-msm8998.c b/drivers/clk/qcom/mmcc-msm8998.c
index e5a72c2f080f..c282424bac53 100644
--- a/drivers/clk/qcom/mmcc-msm8998.c
+++ b/drivers/clk/qcom/mmcc-msm8998.c
@@ -2578,6 +2578,8 @@ static struct clk_hw *mmcc_msm8998_hws[] = {
 
 static struct gdsc video_top_gdsc = {
 	.gdscr = 0x1024,
+	.cxcs = (unsigned int []){ 0x1028, 0x1034, 0x1038 },
+	.cxc_count = 3,
 	.pd = {
 		.name = "video_top",
 	},
@@ -2586,20 +2588,26 @@ static struct gdsc video_top_gdsc = {
 
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
diff --git a/drivers/clk/renesas/r8a779a0-cpg-mssr.c b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
index e02542ca24a0..5c908c8c5180 100644
--- a/drivers/clk/renesas/r8a779a0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779a0-cpg-mssr.c
@@ -139,7 +139,7 @@ static const struct mssr_mod_clk r8a779a0_mod_clks[] __initconst = {
 	DEF_MOD("avb3",		214,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb4",		215,	R8A779A0_CLK_S3D2),
 	DEF_MOD("avb5",		216,	R8A779A0_CLK_S3D2),
-	DEF_MOD("canfd0",	328,	R8A779A0_CLK_CANFD),
+	DEF_MOD("canfd0",	328,	R8A779A0_CLK_S3D2),
 	DEF_MOD("csi40",	331,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi41",	400,	R8A779A0_CLK_CSI0),
 	DEF_MOD("csi42",	401,	R8A779A0_CLK_CSI0),
diff --git a/drivers/clk/renesas/r9a07g043-cpg.c b/drivers/clk/renesas/r9a07g043-cpg.c
index 37475465100d..0b56688ecbfc 100644
--- a/drivers/clk/renesas/r9a07g043-cpg.c
+++ b/drivers/clk/renesas/r9a07g043-cpg.c
@@ -252,6 +252,10 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
 				0x5a8, 1),
 	DEF_MOD("tsu_pclk",	R9A07G043_TSU_PCLK, R9A07G043_CLK_TSU,
 				0x5ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_MOD("nceplic_aclk",	R9A07G043_NCEPLIC_ACLK, R9A07G043_CLK_P1,
+				0x608, 0),
+#endif
 };
 
 static struct rzg2l_reset r9a07g043_resets[] = {
@@ -305,6 +309,10 @@ static struct rzg2l_reset r9a07g043_resets[] = {
 	DEF_RST(R9A07G043_ADC_PRESETN, 0x8a8, 0),
 	DEF_RST(R9A07G043_ADC_ADRST_N, 0x8a8, 1),
 	DEF_RST(R9A07G043_TSU_PRESETN, 0x8ac, 0),
+#ifdef CONFIG_RISCV
+	DEF_RST(R9A07G043_NCEPLIC_ARESETN, 0x908, 0),
+#endif
+
 };
 
 static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
@@ -314,6 +322,7 @@ static const unsigned int r9a07g043_crit_mod_clks[] __initconst = {
 #endif
 #ifdef CONFIG_RISCV
 	MOD_CLK_BASE + R9A07G043_IAX45_CLK,
+	MOD_CLK_BASE + R9A07G043_NCEPLIC_ACLK,
 #endif
 	MOD_CLK_BASE + R9A07G043_DMAC_ACLK,
 };
diff --git a/drivers/clk/samsung/clk-exynosautov9.c b/drivers/clk/samsung/clk-exynosautov9.c
index 7b16320bba66..c36063956275 100644
--- a/drivers/clk/samsung/clk-exynosautov9.c
+++ b/drivers/clk/samsung/clk-exynosautov9.c
@@ -343,13 +343,13 @@ static const struct samsung_pll_clock top_pll_clks[] __initconst = {
 	/* CMU_TOP_PURECLKCOMP */
 	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED0, PLL_CON3_PLL_SHARED0, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared1_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED1_PLL, "fout_shared1_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED1, PLL_CON3_PLL_SHARED1, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared2_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED2_PLL, "fout_shared2_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED2, PLL_CON3_PLL_SHARED2, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared3_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED3_PLL, "fout_shared3_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED3, PLL_CON3_PLL_SHARED3, NULL),
-	PLL(pll_0822x, FOUT_SHARED0_PLL, "fout_shared4_pll", "oscclk",
+	PLL(pll_0822x, FOUT_SHARED4_PLL, "fout_shared4_pll", "oscclk",
 	    PLL_LOCKTIME_PLL_SHARED4, PLL_CON3_PLL_SHARED4, NULL),
 };
 
diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 022e3555407c..8791a88c7741 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -841,10 +841,15 @@ static unsigned int cppc_cpufreq_get_rate(unsigned int cpu)
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
@@ -924,10 +929,15 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
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
index 91efa23e0e8f..04d89cf0d71d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1619,10 +1619,13 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	 */
 	if (cpufreq_driver->offline) {
 		cpufreq_driver->offline(policy);
-	} else if (cpufreq_driver->exit) {
-		cpufreq_driver->exit(policy);
-		policy->freq_table = NULL;
+		return;
 	}
+
+	if (cpufreq_driver->exit)
+		cpufreq_driver->exit(policy);
+
+	policy->freq_table = NULL;
 }
 
 static int cpufreq_offline(unsigned int cpu)
@@ -1680,7 +1683,7 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 	}
 
 	/* We did light-weight exit earlier, do full tear down now */
-	if (cpufreq_driver->offline)
+	if (cpufreq_driver->offline && cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
 	up_write(&policy->rwsem);
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
index 7d79a8744f9a..c43ad7e1acf7 100644
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
 
@@ -214,12 +208,8 @@ static int sp_platform_resume(struct platform_device *pdev)
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
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 4dd52a6a5b48..e54e5e64d9ab 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -116,7 +116,8 @@ config EXTCON_MAX77843
 
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
 
diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
index 70e9789ff9de..6a337f1f8787 100644
--- a/drivers/firmware/efi/libstub/fdt.c
+++ b/drivers/firmware/efi/libstub/fdt.c
@@ -335,8 +335,8 @@ efi_status_t allocate_new_fdt_and_exit_boot(void *handle,
 
 fail:
 	efi_free(fdt_size, fdt_addr);
-
-	efi_bs_call(free_pool, priv.runtime_map);
+	if (!efi_novamap)
+		efi_bs_call(free_pool, priv.runtime_map);
 
 	return EFI_LOAD_ERROR;
 }
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 55468debd55d..f7eb389aeec0 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -736,6 +736,26 @@ static void error(char *str)
 	efi_warn("Decompression failed: %s\n", str);
 }
 
+static const char *cmdline_memmap_override;
+
+static efi_status_t parse_options(const char *cmdline)
+{
+	static const char opts[][14] = {
+		"mem=", "memmap=", "efi_fake_mem=", "hugepages="
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(opts); i++) {
+		const char *p = strstr(cmdline, opts[i]);
+
+		if (p == cmdline || (p > cmdline && isspace(p[-1]))) {
+			cmdline_memmap_override = opts[i];
+			break;
+		}
+	}
+
+	return efi_parse_options(cmdline);
+}
+
 static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 {
 	unsigned long virt_addr = LOAD_PHYSICAL_ADDR;
@@ -767,6 +787,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 		    !memcmp(efistub_fw_vendor(), ami, sizeof(ami))) {
 			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
 			seed[0] = 0;
+		} else if (cmdline_memmap_override) {
+			efi_info("%s detected on the kernel command line - disabling physical KASLR\n",
+				 cmdline_memmap_override);
+			seed[0] = 0;
 		}
 
 		boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
@@ -843,7 +867,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	status = efi_parse_options(CONFIG_CMDLINE);
+	status = parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to parse options\n");
 		goto fail;
@@ -852,7 +876,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
-		status = efi_parse_options((char *)cmdline_paddr);
+		status = parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
 			goto fail;
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
diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 0914e7328b1a..4220ef00a555 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -79,6 +79,7 @@ static void cci_pci_free_irq(struct pci_dev *pcidev)
 #define PCIE_DEVICE_ID_SILICOM_PAC_N5011	0x1001
 #define PCIE_DEVICE_ID_INTEL_DFL		0xbcce
 /* PCI Subdevice ID for PCIE_DEVICE_ID_INTEL_DFL */
+#define PCIE_SUBDEVICE_ID_INTEL_D5005		0x138d
 #define PCIE_SUBDEVICE_ID_INTEL_N6000		0x1770
 #define PCIE_SUBDEVICE_ID_INTEL_N6001		0x1771
 #define PCIE_SUBDEVICE_ID_INTEL_C6100		0x17d4
@@ -102,6 +103,8 @@ static struct pci_device_id cci_pcie_id_tbl[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_PAC_D5005_VF),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5010),},
 	{PCI_DEVICE(PCI_VENDOR_ID_SILICOM_DENMARK, PCIE_DEVICE_ID_SILICOM_PAC_N5011),},
+	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
+			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_D5005),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL,
 			PCI_VENDOR_ID_INTEL, PCIE_SUBDEVICE_ID_INTEL_N6000),},
 	{PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, PCIE_DEVICE_ID_INTEL_DFL_VF,
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 27ff9dea04ae..3aefd9d89356 100644
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
@@ -180,14 +180,16 @@ static struct attribute *fpga_region_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_region);
 
 /**
- * fpga_region_register_full - create and register an FPGA Region device
+ * __fpga_region_register_full - create and register an FPGA Region device
  * @parent: device parent
  * @info: parameters for FPGA Region
+ * @owner: module containing the get_bridges function
  *
  * Return: struct fpga_region or ERR_PTR()
  */
 struct fpga_region *
-fpga_region_register_full(struct device *parent, const struct fpga_region_info *info)
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner)
 {
 	struct fpga_region *region;
 	int id, ret = 0;
@@ -212,6 +214,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 	region->compat_id = info->compat_id;
 	region->priv = info->priv;
 	region->get_bridges = info->get_bridges;
+	region->ops_owner = owner;
 
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
@@ -240,13 +243,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_region_register_full);
+EXPORT_SYMBOL_GPL(__fpga_region_register_full);
 
 /**
- * fpga_region_register - create and register an FPGA Region device
+ * __fpga_region_register - create and register an FPGA Region device
  * @parent: device parent
  * @mgr: manager that programs this region
  * @get_bridges: optional function to get bridges to a list
+ * @owner: module containing the get_bridges function
  *
  * This simple version of the register function should be sufficient for most users.
  * The fpga_region_register_full() function is available for users that need to
@@ -255,17 +259,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
  * Return: struct fpga_region or ERR_PTR()
  */
 struct fpga_region *
-fpga_region_register(struct device *parent, struct fpga_manager *mgr,
-		     int (*get_bridges)(struct fpga_region *))
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner)
 {
 	struct fpga_region_info info = { 0 };
 
 	info.mgr = mgr;
 	info.get_bridges = get_bridges;
 
-	return fpga_region_register_full(parent, &info);
+	return __fpga_region_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(fpga_region_register);
+EXPORT_SYMBOL_GPL(__fpga_region_register);
 
 /**
  * fpga_region_unregister - unregister an FPGA region
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index bebd136ed544..9a4cbfbd5d9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1083,6 +1083,7 @@ void amdgpu_mes_remove_ring(struct amdgpu_device *adev,
 		return;
 
 	amdgpu_mes_remove_hw_queue(adev, ring->hw_queue_id);
+	del_timer_sync(&ring->fence_drv.fallback_timer);
 	amdgpu_ring_fini(ring);
 	kfree(ring);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9a111988b7f1..7acf1586882e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -585,6 +585,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	else
 		amdgpu_bo_placement_from_domain(bo, bp->domain);
 	if (bp->type == ttm_bo_type_kernel)
+		bo->tbo.priority = 2;
+	else if (!(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE))
 		bo->tbo.priority = 1;
 
 	if (!bp->destroy)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 84a36b50ddd8..f8382b227ad4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9352,7 +9352,7 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		4 + /* double SWITCH_BUFFER,
@@ -9445,7 +9445,6 @@ static const struct amdgpu_ring_funcs gfx_v10_0_ring_funcs_kiq = {
 		7 + /* gfx_v10_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v10_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v10_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v10_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v10_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5a5787bfbce7..1f9f7fdd4b8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6157,7 +6157,7 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_gfx = {
 		7 + /* PIPELINE_SYNC */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* VM_FLUSH */
+		4 + /* VM_FLUSH */
 		8 + /* FENCE for VM_FLUSH */
 		20 + /* GDS switch */
 		5 + /* COND_EXEC */
@@ -6243,7 +6243,6 @@ static const struct amdgpu_ring_funcs gfx_v11_0_ring_funcs_kiq = {
 		7 + /* gfx_v11_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v11_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v11_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v11_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v11_0_ring_emit_ib_compute,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 195b29892354..6a1fe2168514 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -6742,7 +6742,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v9_0_emit_mem_sync */
 		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
@@ -6781,7 +6780,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
 		7 + /* gfx_v9_0_ring_emit_pipeline_sync */
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
-		2 + /* gfx_v9_0_ring_emit_vm_flush */
 		8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fence, vm fence */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_fence = gfx_v9_0_ring_emit_fence_kiq,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 7f68d51541e8..5bca6abd55ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -823,6 +823,14 @@ struct kfd_process *kfd_create_process(struct file *filep)
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
index ff460c9802eb..31bae620aeff 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2964,6 +2964,7 @@ static int dm_resume(void *handle)
 			dc_stream_release(dm_new_crtc_state->stream);
 			dm_new_crtc_state->stream = NULL;
 		}
+		dm_new_crtc_state->base.color_mgmt_changed = true;
 	}
 
 	for_each_new_plane_in_state(dm->cached_state, plane, new_plane_state, i) {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 28b83133db91..09eb1bc9aa03 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -131,6 +131,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 	 */
 	clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 	if (safe_to_lower) {
+		if (clk_mgr_base->clks.dtbclk_en && !new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, false);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in lower */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_LOW_POWER) {
 			display_count = dcn315_get_active_display_cnt_wa(dc, context);
@@ -146,6 +150,10 @@ static void dcn315_update_clocks(struct clk_mgr *clk_mgr_base,
 			}
 		}
 	} else {
+		if (!clk_mgr_base->clks.dtbclk_en && new_clocks->dtbclk_en) {
+			dcn315_smu_set_dtbclk(clk_mgr, true);
+			clk_mgr_base->clks.dtbclk_en = new_clocks->dtbclk_en;
+		}
 		/* check that we're not already in D0 */
 		if (clk_mgr_base->clks.pwr_state != DCN_PWR_STATE_MISSION_MODE) {
 			union display_idle_optimization_u idle_info = { 0 };
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
index 3538973bd0c6..c0372aa4ec83 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
@@ -382,6 +382,11 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
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
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 19d034341e64..cb2f6cd73af5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -291,6 +291,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.dispclk_dppclk_vco_speed_mhz = 2400.0,
 	.num_chans = 4,
 	.dummy_pstate_latency_us = 10.0
 };
@@ -438,6 +439,7 @@ static struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
 	.do_urgent_latency_adjustment = false,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.dispclk_dppclk_vco_speed_mhz = 2500.0,
 };
 
 void dcn31_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index ef76d0e6ee2f..389d32994135 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -72,7 +72,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	connector->state = NULL;
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 77a304ac4d75..193015c75b45 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2077,10 +2077,8 @@ static int anx7625_setup_dsi_device(struct anx7625_data *ctx)
 	};
 
 	host = of_find_mipi_dsi_host_by_node(ctx->pdata.mipi_host_node);
-	if (!host) {
-		DRM_DEV_ERROR(dev, "fail to find dsi host.\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "fail to find dsi host.\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 31442a922502..1b7c14d7c5ee 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2042,6 +2042,9 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
+	if (!mhdp_state->current_mode)
+		return;
+
 	drm_mode_set_name(mhdp_state->current_mode);
 
 	dev_dbg(mhdp->dev, "%s: Enabling mode %s\n", __func__, mode->name);
diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index bf920c3503aa..3459a696b34f 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -563,10 +563,8 @@ static int chipone_dsi_host_attach(struct chipone *icn)
 
 	host = of_find_mipi_dsi_host_by_node(host_node);
 	of_node_put(host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index ac76c2363589..55a7fa4670a7 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -485,10 +485,8 @@ static int lt8912_attach_dsi(struct lt8912 *lt)
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
index ae8c6d9d4095..e40ceb56ff55 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -777,10 +777,8 @@ static struct mipi_dsi_device *lt9611_attach_dsi(struct lt9611 *lt9611,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(lt9611->dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(lt9611->dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 818848b2c04d..cb75da940b89 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -263,10 +263,8 @@ static struct mipi_dsi_device *lt9611uxc_attach_dsi(struct lt9611uxc *lt9611uxc,
 	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dsi_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
+	if (!host)
+		return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n"));
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 02dc12b8151e..40d6da774332 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -455,10 +455,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
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
@@ -469,14 +465,15 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
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
@@ -611,10 +608,8 @@ static int tc_attach_host(struct tc_data *tc)
 						};
 
 	host = of_find_mipi_dsi_host_by_node(tc->host_node);
-	if (!host) {
-		dev_err(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi)) {
diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index 186a9e2ff24d..d1684e66d9e3 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -319,12 +319,11 @@ static int dlpc_host_attach(struct dlpc *dlpc)
 		.channel = 0,
 		.node = NULL,
 	};
+	int ret;
 
 	host = of_find_mipi_dsi_host_by_node(dlpc->host_node);
-	if (!host) {
-		DRM_DEV_ERROR(dev, "failed to find dsi host\n");
-		return -EPROBE_DEFER;
-	}
+	if (!host)
+		return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
 
 	dlpc->dsi = mipi_dsi_device_register_full(host, &info);
 	if (IS_ERR(dlpc->dsi)) {
@@ -336,7 +335,11 @@ static int dlpc_host_attach(struct dlpc *dlpc)
 	dlpc->dsi->format = MIPI_DSI_FMT_RGB565;
 	dlpc->dsi->lanes = dlpc->dsi_lanes;
 
-	return devm_mipi_dsi_attach(dev, dlpc->dsi);
+	ret = devm_mipi_dsi_attach(dev, dlpc->dsi);
+	if (ret)
+		DRM_DEV_ERROR(dev, "failed to attach dsi host\n");
+
+	return ret;
 }
 
 static int dlpc3433_probe(struct i2c_client *client)
@@ -367,10 +370,8 @@ static int dlpc3433_probe(struct i2c_client *client)
 	drm_bridge_add(&dlpc->bridge);
 
 	ret = dlpc_host_attach(dlpc);
-	if (ret) {
-		DRM_DEV_ERROR(dev, "failed to attach dsi host\n");
+	if (ret)
 		goto err_remove_bridge;
-	}
 
 	return 0;
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 3f43b44145a8..52008a72bd49 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -478,7 +478,6 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
 		/* On failure, disable PLL again and exit. */
 		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
-		regulator_disable(ctx->vcc);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 16565a0a5da6..e839981c7b2f 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -532,6 +532,15 @@ static int drm_dp_dpcd_access(struct drm_dp_aux *aux, u8 request,
 
 	mutex_lock(&aux->hw_mutex);
 
+	/*
+	 * If the device attached to the aux bus is powered down then there's
+	 * no reason to attempt a transfer. Error out immediately.
+	 */
+	if (aux->powered_down) {
+		ret = -EBUSY;
+		goto unlock;
+	}
+
 	/*
 	 * The specification doesn't give any recommendation on how often to
 	 * retry native transactions. We used to retry 7 times like for
@@ -599,6 +608,29 @@ int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset)
 }
 EXPORT_SYMBOL(drm_dp_dpcd_probe);
 
+/**
+ * drm_dp_dpcd_set_powered() - Set whether the DP device is powered
+ * @aux: DisplayPort AUX channel; for convenience it's OK to pass NULL here
+ *       and the function will be a no-op.
+ * @powered: true if powered; false if not
+ *
+ * If the endpoint device on the DP AUX bus is known to be powered down
+ * then this function can be called to make future transfers fail immediately
+ * instead of needing to time out.
+ *
+ * If this function is never called then a device defaults to being powered.
+ */
+void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered)
+{
+	if (!aux)
+		return;
+
+	mutex_lock(&aux->hw_mutex);
+	aux->powered_down = !powered;
+	mutex_unlock(&aux->hw_mutex);
+}
+EXPORT_SYMBOL(drm_dp_dpcd_set_powered);
+
 /**
  * drm_dp_dpcd_read() - read a series of bytes from the DPCD
  * @aux: DisplayPort AUX channel (SST or MST)
@@ -1855,6 +1887,9 @@ static int drm_dp_i2c_xfer(struct i2c_adapter *adapter, struct i2c_msg *msgs,
 	struct drm_dp_aux_msg msg;
 	int err = 0;
 
+	if (aux->powered_down)
+		return -EBUSY;
+
 	dp_aux_i2c_transfer_size = clamp(dp_aux_i2c_transfer_size, 1, DP_AUX_MAX_PAYLOAD_BYTES);
 
 	memset(&msg, 0, sizeof(msg));
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 7044e339a82c..f80254879804 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -755,11 +755,17 @@ void drm_atomic_bridge_chain_post_disable(struct drm_bridge *bridge,
 				 */
 				list_for_each_entry_from(next, &encoder->bridge_chain,
 							 chain_node) {
-					if (next->pre_enable_prev_first) {
+					if (!next->pre_enable_prev_first) {
 						next = list_prev_entry(next, chain_node);
 						limit = next;
 						break;
 					}
+
+					if (list_is_last(&next->chain_node,
+							 &encoder->bridge_chain)) {
+						limit = next;
+						break;
+					}
 				}
 
 				/* Call these bridges in reverse order */
@@ -842,7 +848,7 @@ void drm_atomic_bridge_chain_pre_enable(struct drm_bridge *bridge,
 					/* Found first bridge that does NOT
 					 * request prev to be enabled first
 					 */
-					limit = list_prev_entry(next, chain_node);
+					limit = next;
 					break;
 				}
 			}
diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index ef7ec68867df..112f213cc8d9 100644
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
diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
index 4a59478c3b5c..bbeceb640d31 100644
--- a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
+++ b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
@@ -29,9 +29,9 @@
  */
 
 #define GUC_KLV_LEN_MIN				1u
-#define GUC_KLV_0_KEY				(0xffff << 16)
-#define GUC_KLV_0_LEN				(0xffff << 0)
-#define GUC_KLV_n_VALUE				(0xffffffff << 0)
+#define GUC_KLV_0_KEY				(0xffffu << 16)
+#define GUC_KLV_0_LEN				(0xffffu << 0)
+#define GUC_KLV_n_VALUE				(0xffffffffu << 0)
 
 /**
  * DOC: GuC Self Config KLVs
diff --git a/drivers/gpu/drm/mediatek/Kconfig b/drivers/gpu/drm/mediatek/Kconfig
index 369e495d0c3e..d1eededee943 100644
--- a/drivers/gpu/drm/mediatek/Kconfig
+++ b/drivers/gpu/drm/mediatek/Kconfig
@@ -27,6 +27,7 @@ config DRM_MEDIATEK_DP
 	select PHY_MTK_DP
 	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_DP_AUX_BUS
 	help
 	  DRM/KMS Display Port driver for MediaTek SoCs.
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 519e23a2a017..c24eeb7ffde7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2022 BayLibre
  */
 
+#include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_dp.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic_helper.h>
@@ -1284,9 +1285,11 @@ static void mtk_dp_power_disable(struct mtk_dp *mtk_dp)
 
 static void mtk_dp_initialize_priv_data(struct mtk_dp *mtk_dp)
 {
+	bool plugged_in = (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP);
+
 	mtk_dp->train_info.link_rate = DP_LINK_BW_5_4;
 	mtk_dp->train_info.lane_count = mtk_dp->max_lanes;
-	mtk_dp->train_info.cable_plugged_in = false;
+	mtk_dp->train_info.cable_plugged_in = plugged_in;
 
 	mtk_dp->info.format = DP_PIXELFORMAT_RGB;
 	memset(&mtk_dp->info.vm, 0, sizeof(struct videomode));
@@ -1588,6 +1591,16 @@ static int mtk_dp_parse_capabilities(struct mtk_dp *mtk_dp)
 	u8 val;
 	ssize_t ret;
 
+	/*
+	 * If we're eDP and capabilities were already parsed we can skip
+	 * reading again because eDP panels aren't hotpluggable hence the
+	 * caps and training information won't ever change in a boot life
+	 */
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP &&
+	    mtk_dp->rx_cap[DP_MAX_LINK_RATE] &&
+	    mtk_dp->train_info.sink_ssc)
+		return 0;
+
 	ret = drm_dp_read_dpcd_caps(&mtk_dp->aux, mtk_dp->rx_cap);
 	if (ret < 0)
 		return ret;
@@ -2037,16 +2050,15 @@ static struct edid *mtk_dp_get_edid(struct drm_bridge *bridge,
 static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 				   struct drm_dp_aux_msg *msg)
 {
-	struct mtk_dp *mtk_dp;
+	struct mtk_dp *mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
 	bool is_read;
 	u8 request;
 	size_t accessed_bytes = 0;
 	int ret;
 
-	mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
-
-	if (!mtk_dp->train_info.cable_plugged_in) {
-		ret = -EAGAIN;
+	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP &&
+	    !mtk_dp->train_info.cable_plugged_in) {
+		ret = -EIO;
 		goto err;
 	}
 
@@ -2490,6 +2502,51 @@ static int mtk_dp_register_audio_driver(struct device *dev)
 	return PTR_ERR_OR_ZERO(mtk_dp->audio_pdev);
 }
 
+static int mtk_dp_register_phy(struct mtk_dp *mtk_dp)
+{
+	struct device *dev = mtk_dp->dev;
+
+	mtk_dp->phy_dev = platform_device_register_data(dev, "mediatek-dp-phy",
+							PLATFORM_DEVID_AUTO,
+							&mtk_dp->regs,
+							sizeof(struct regmap *));
+	if (IS_ERR(mtk_dp->phy_dev))
+		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
+				     "Failed to create device mediatek-dp-phy\n");
+
+	mtk_dp_get_calibration_data(mtk_dp);
+
+	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
+	if (IS_ERR(mtk_dp->phy)) {
+		platform_device_unregister(mtk_dp->phy_dev);
+		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy), "Failed to get phy\n");
+	}
+
+	return 0;
+}
+
+static int mtk_dp_edp_link_panel(struct drm_dp_aux *mtk_aux)
+{
+	struct mtk_dp *mtk_dp = container_of(mtk_aux, struct mtk_dp, aux);
+	struct device *dev = mtk_aux->dev;
+	int ret;
+
+	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+
+	/* Power off the DP and AUX: either detection is done, or no panel present */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+			   DP_PWR_STATE_BANDGAP_TPLL,
+			   DP_PWR_STATE_MASK);
+	mtk_dp_power_disable(mtk_dp);
+
+	if (IS_ERR(mtk_dp->next_bridge)) {
+		ret = PTR_ERR(mtk_dp->next_bridge);
+		mtk_dp->next_bridge = NULL;
+		return ret;
+	}
+	return 0;
+}
+
 static int mtk_dp_probe(struct platform_device *pdev)
 {
 	struct mtk_dp *mtk_dp;
@@ -2508,21 +2565,14 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, irq_num,
 				     "failed to request dp irq resource\n");
 
-	mtk_dp->next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
-	if (IS_ERR(mtk_dp->next_bridge) &&
-	    PTR_ERR(mtk_dp->next_bridge) == -ENODEV)
-		mtk_dp->next_bridge = NULL;
-	else if (IS_ERR(mtk_dp->next_bridge))
-		return dev_err_probe(dev, PTR_ERR(mtk_dp->next_bridge),
-				     "Failed to get bridge\n");
-
 	ret = mtk_dp_dt_parse(mtk_dp, pdev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to parse dt\n");
 
-	drm_dp_aux_init(&mtk_dp->aux);
 	mtk_dp->aux.name = "aux_mtk_dp";
+	mtk_dp->aux.dev = dev;
 	mtk_dp->aux.transfer = mtk_dp_aux_transfer;
+	drm_dp_aux_init(&mtk_dp->aux);
 
 	spin_lock_init(&mtk_dp->irq_thread_lock);
 
@@ -2547,23 +2597,9 @@ static int mtk_dp_probe(struct platform_device *pdev)
 		}
 	}
 
-	mtk_dp->phy_dev = platform_device_register_data(dev, "mediatek-dp-phy",
-							PLATFORM_DEVID_AUTO,
-							&mtk_dp->regs,
-							sizeof(struct regmap *));
-	if (IS_ERR(mtk_dp->phy_dev))
-		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
-				     "Failed to create device mediatek-dp-phy\n");
-
-	mtk_dp_get_calibration_data(mtk_dp);
-
-	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
-
-	if (IS_ERR(mtk_dp->phy)) {
-		platform_device_unregister(mtk_dp->phy_dev);
-		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy),
-				     "Failed to get phy\n");
-	}
+	ret = mtk_dp_register_phy(mtk_dp);
+	if (ret)
+		return ret;
 
 	mtk_dp->bridge.funcs = &mtk_dp_bridge_funcs;
 	mtk_dp->bridge.of_node = dev->of_node;
@@ -2577,6 +2613,43 @@ static int mtk_dp_probe(struct platform_device *pdev)
 	mtk_dp->need_debounce = true;
 	timer_setup(&mtk_dp->debounce_timer, mtk_dp_debounce_timer, 0);
 
+	if (mtk_dp->bridge.type == DRM_MODE_CONNECTOR_eDP) {
+		/*
+		 * Set the data lanes to idle in case the bootloader didn't
+		 * properly close the eDP port to avoid stalls and then
+		 * reinitialize, reset and power on the AUX block.
+		 */
+		mtk_dp_set_idle_pattern(mtk_dp, true);
+		mtk_dp_initialize_aux_settings(mtk_dp);
+		mtk_dp_power_enable(mtk_dp);
+
+		/*
+		 * Power on the AUX to allow reading the EDID from aux-bus:
+		 * please note that it is necessary to call power off in the
+		 * .done_probing() callback (mtk_dp_edp_link_panel), as only
+		 * there we can safely assume that we finished reading EDID.
+		 */
+		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+				   DP_PWR_STATE_BANDGAP_TPLL_LANE,
+				   DP_PWR_STATE_MASK);
+
+		ret = devm_of_dp_aux_populate_bus(&mtk_dp->aux, mtk_dp_edp_link_panel);
+		if (ret) {
+			/* -ENODEV this means that the panel is not on the aux-bus */
+			if (ret == -ENODEV) {
+				ret = mtk_dp_edp_link_panel(&mtk_dp->aux);
+				if (ret)
+					return ret;
+			} else {
+				mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
+						   DP_PWR_STATE_BANDGAP_TPLL,
+						   DP_PWR_STATE_MASK);
+				mtk_dp_power_disable(mtk_dp);
+				return ret;
+			}
+		}
+	}
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_gem.c b/drivers/gpu/drm/mediatek/mtk_drm_gem.c
index fb4f0e336b60..21e584038581 100644
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
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 95e73eddc5e9..d6a810b7cfa2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2036,18 +2036,12 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 			adreno_cmp_rev(ADRENO_REV(6, 3, 5, ANY_ID), info->rev)))
 		adreno_gpu->base.hw_apriv = true;
 
-	/*
-	 * For now only clamp to idle freq for devices where this is known not
-	 * to cause power supply issues:
-	 */
-	if (info && (info->revn == 618))
-		gpu->clamp_to_idle = true;
-
 	a6xx_llc_slices_init(pdev, a6xx_gpu);
 
 	ret = a6xx_set_supported_hw(&pdev->dev, config->rev);
 	if (ret) {
-		a6xx_destroy(&(a6xx_gpu->base.base));
+		a6xx_llc_slices_destroy(a6xx_gpu);
+		kfree(a6xx_gpu);
 		return ERR_PTR(ret);
 	}
 
@@ -2057,6 +2051,13 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
+	/*
+	 * For now only clamp to idle freq for devices where this is known not
+	 * to cause power supply issues:
+	 */
+	if (adreno_is_a618(adreno_gpu) || adreno_is_7c3(adreno_gpu))
+		gpu->clamp_to_idle = true;
+
 	/* Check if there is a GMU phandle and set it up */
 	node = of_parse_phandle(pdev->dev.of_node, "qcom,gmu", 0);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index ae28b2b93e69..ce58d97818bc 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -439,9 +439,6 @@ static void dpu_encoder_phys_cmd_enable_helper(
 
 	_dpu_encoder_phys_cmd_pingpong_config(phys_enc);
 
-	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
-		return;
-
 	ctl = phys_enc->hw_ctl;
 	ctl->ops.update_pending_flush_intf(ctl, phys_enc->intf_idx);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
index 84f9e3e5f964..559809a5cbcf 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.c
+++ b/drivers/gpu/drm/msm/dp/dp_aux.c
@@ -35,6 +35,7 @@ struct dp_aux_private {
 	bool no_send_stop;
 	bool initted;
 	bool is_edp;
+	bool enable_xfers;
 	u32 offset;
 	u32 segment;
 
@@ -297,6 +298,17 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 		goto exit;
 	}
 
+	/*
+	 * If we're using DP and an external display isn't connected then the
+	 * transfer won't succeed. Return right away. If we don't do this we
+	 * can end up with long timeouts if someone tries to access the DP AUX
+	 * character device when no DP device is connected.
+	 */
+	if (!aux->is_edp && !aux->enable_xfers) {
+		ret = -ENXIO;
+		goto exit;
+	}
+
 	/*
 	 * For eDP it's important to give a reasonably long wait here for HPD
 	 * to be asserted. This is because the panel driver may have _just_
@@ -368,14 +380,14 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
 	return ret;
 }
 
-void dp_aux_isr(struct drm_dp_aux *dp_aux)
+irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux)
 {
 	u32 isr;
 	struct dp_aux_private *aux;
 
 	if (!dp_aux) {
 		DRM_ERROR("invalid input\n");
-		return;
+		return IRQ_NONE;
 	}
 
 	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
@@ -384,11 +396,11 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
 
 	/* no interrupts pending, return immediately */
 	if (!isr)
-		return;
+		return IRQ_NONE;
 
 	if (!aux->cmd_busy) {
 		DRM_ERROR("Unexpected DP AUX IRQ %#010x when not busy\n", isr);
-		return;
+		return IRQ_NONE;
 	}
 
 	/*
@@ -420,10 +432,20 @@ void dp_aux_isr(struct drm_dp_aux *dp_aux)
 		aux->aux_error_num = DP_AUX_ERR_NONE;
 	} else {
 		DRM_WARN("Unexpected interrupt: %#010x\n", isr);
-		return;
+		return IRQ_NONE;
 	}
 
 	complete(&aux->comp);
+
+	return IRQ_HANDLED;
+}
+
+void dp_aux_enable_xfers(struct drm_dp_aux *dp_aux, bool enabled)
+{
+	struct dp_aux_private *aux;
+
+	aux = container_of(dp_aux, struct dp_aux_private, dp_aux);
+	aux->enable_xfers = enabled;
 }
 
 void dp_aux_reconfig(struct drm_dp_aux *dp_aux)
diff --git a/drivers/gpu/drm/msm/dp/dp_aux.h b/drivers/gpu/drm/msm/dp/dp_aux.h
index e930974bcb5b..f3052cb43306 100644
--- a/drivers/gpu/drm/msm/dp/dp_aux.h
+++ b/drivers/gpu/drm/msm/dp/dp_aux.h
@@ -11,7 +11,8 @@
 
 int dp_aux_register(struct drm_dp_aux *dp_aux);
 void dp_aux_unregister(struct drm_dp_aux *dp_aux);
-void dp_aux_isr(struct drm_dp_aux *dp_aux);
+irqreturn_t dp_aux_isr(struct drm_dp_aux *dp_aux);
+void dp_aux_enable_xfers(struct drm_dp_aux *dp_aux, bool enabled);
 void dp_aux_init(struct drm_dp_aux *dp_aux);
 void dp_aux_deinit(struct drm_dp_aux *dp_aux);
 void dp_aux_reconfig(struct drm_dp_aux *dp_aux);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b20701893e5b..bd1343602f55 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -1014,14 +1014,14 @@ static int dp_ctrl_update_vx_px(struct dp_ctrl_private *ctrl)
 	if (ret)
 		return ret;
 
-	if (voltage_swing_level >= DP_TRAIN_VOLTAGE_SWING_MAX) {
+	if (voltage_swing_level >= DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(ctrl->drm_dev,
 				"max. voltage swing level reached %d\n",
 				voltage_swing_level);
 		max_level_reached |= DP_TRAIN_MAX_SWING_REACHED;
 	}
 
-	if (pre_emphasis_level >= DP_TRAIN_PRE_EMPHASIS_MAX) {
+	if (pre_emphasis_level >= DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(ctrl->drm_dev,
 				"max. pre-emphasis level reached %d\n",
 				pre_emphasis_level);
@@ -1112,7 +1112,7 @@ static int dp_ctrl_link_train_1(struct dp_ctrl_private *ctrl,
 		}
 
 		if (ctrl->link->phy_params.v_level >=
-			DP_TRAIN_VOLTAGE_SWING_MAX) {
+			DP_TRAIN_LEVEL_MAX) {
 			DRM_ERROR_RATELIMITED("max v_level reached\n");
 			return -EAGAIN;
 		}
@@ -1973,27 +1973,33 @@ int dp_ctrl_off(struct dp_ctrl *dp_ctrl)
 	return ret;
 }
 
-void dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
+irqreturn_t dp_ctrl_isr(struct dp_ctrl *dp_ctrl)
 {
 	struct dp_ctrl_private *ctrl;
 	u32 isr;
+	irqreturn_t ret = IRQ_NONE;
 
 	if (!dp_ctrl)
-		return;
+		return IRQ_NONE;
 
 	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
 
 	isr = dp_catalog_ctrl_get_interrupt(ctrl->catalog);
 
+
 	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
 		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
 		complete(&ctrl->video_comp);
+		ret = IRQ_HANDLED;
 	}
 
 	if (isr & DP_CTRL_INTR_IDLE_PATTERN_SENT) {
 		drm_dbg_dp(ctrl->drm_dev, "idle_patterns_sent\n");
 		complete(&ctrl->idle_comp);
+		ret = IRQ_HANDLED;
 	}
+
+	return ret;
 }
 
 struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 9f29734af81c..c3af06dc87b1 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -25,7 +25,7 @@ int dp_ctrl_off_link_stream(struct dp_ctrl *dp_ctrl);
 int dp_ctrl_off_link(struct dp_ctrl *dp_ctrl);
 int dp_ctrl_off(struct dp_ctrl *dp_ctrl);
 void dp_ctrl_push_idle(struct dp_ctrl *dp_ctrl);
-void dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
+irqreturn_t dp_ctrl_isr(struct dp_ctrl *dp_ctrl);
 void dp_ctrl_handle_sink_request(struct dp_ctrl *dp_ctrl);
 struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
 			struct dp_panel *panel,	struct drm_dp_aux *aux,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d16c12351adb..fd82752e502f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -577,6 +577,8 @@ static int dp_hpd_plug_handle(struct dp_display_private *dp, u32 data)
 	if (!hpd)
 		return 0;
 
+	dp_aux_enable_xfers(dp->aux, true);
+
 	mutex_lock(&dp->event_mutex);
 
 	state =  dp->hpd_state;
@@ -641,6 +643,8 @@ static int dp_hpd_unplug_handle(struct dp_display_private *dp, u32 data)
 	if (!hpd)
 		return 0;
 
+	dp_aux_enable_xfers(dp->aux, false);
+
 	mutex_lock(&dp->event_mutex);
 
 	state = dp->hpd_state;
@@ -1193,7 +1197,7 @@ static int dp_hpd_event_thread_start(struct dp_display_private *dp_priv)
 static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
 {
 	struct dp_display_private *dp = dev_id;
-	irqreturn_t ret = IRQ_HANDLED;
+	irqreturn_t ret = IRQ_NONE;
 	u32 hpd_isr_status;
 
 	if (!dp) {
@@ -1221,13 +1225,15 @@ static irqreturn_t dp_display_irq_handler(int irq, void *dev_id)
 
 		if (hpd_isr_status & DP_DP_HPD_UNPLUG_INT_MASK)
 			dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
+
+		ret = IRQ_HANDLED;
 	}
 
 	/* DP controller isr */
-	dp_ctrl_isr(dp->ctrl);
+	ret |= dp_ctrl_isr(dp->ctrl);
 
 	/* DP aux isr */
-	dp_aux_isr(dp->aux);
+	ret |= dp_aux_isr(dp->aux);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_link.c b/drivers/gpu/drm/msm/dp/dp_link.c
index ceb382fa56d5..e4f9decec970 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.c
+++ b/drivers/gpu/drm/msm/dp/dp_link.c
@@ -1102,6 +1102,7 @@ int dp_link_get_colorimetry_config(struct dp_link *dp_link)
 int dp_link_adjust_levels(struct dp_link *dp_link, u8 *link_status)
 {
 	int i;
+	u8 max_p_level;
 	int v_max = 0, p_max = 0;
 	struct dp_link_private *link;
 
@@ -1133,30 +1134,29 @@ int dp_link_adjust_levels(struct dp_link *dp_link, u8 *link_status)
 	 * Adjust the voltage swing and pre-emphasis level combination to within
 	 * the allowable range.
 	 */
-	if (dp_link->phy_params.v_level > DP_TRAIN_VOLTAGE_SWING_MAX) {
+	if (dp_link->phy_params.v_level > DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested vSwingLevel=%d, change to %d\n",
 			dp_link->phy_params.v_level,
-			DP_TRAIN_VOLTAGE_SWING_MAX);
-		dp_link->phy_params.v_level = DP_TRAIN_VOLTAGE_SWING_MAX;
+			DP_TRAIN_LEVEL_MAX);
+		dp_link->phy_params.v_level = DP_TRAIN_LEVEL_MAX;
 	}
 
-	if (dp_link->phy_params.p_level > DP_TRAIN_PRE_EMPHASIS_MAX) {
+	if (dp_link->phy_params.p_level > DP_TRAIN_LEVEL_MAX) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested preEmphasisLevel=%d, change to %d\n",
 			dp_link->phy_params.p_level,
-			DP_TRAIN_PRE_EMPHASIS_MAX);
-		dp_link->phy_params.p_level = DP_TRAIN_PRE_EMPHASIS_MAX;
+			DP_TRAIN_LEVEL_MAX);
+		dp_link->phy_params.p_level = DP_TRAIN_LEVEL_MAX;
 	}
 
-	if ((dp_link->phy_params.p_level > DP_TRAIN_PRE_EMPHASIS_LVL_1)
-		&& (dp_link->phy_params.v_level ==
-			DP_TRAIN_VOLTAGE_SWING_LVL_2)) {
+	max_p_level = DP_TRAIN_LEVEL_MAX - dp_link->phy_params.v_level;
+	if (dp_link->phy_params.p_level > max_p_level) {
 		drm_dbg_dp(link->drm_dev,
 			"Requested preEmphasisLevel=%d, change to %d\n",
 			dp_link->phy_params.p_level,
-			DP_TRAIN_PRE_EMPHASIS_LVL_1);
-		dp_link->phy_params.p_level = DP_TRAIN_PRE_EMPHASIS_LVL_1;
+			max_p_level);
+		dp_link->phy_params.p_level = max_p_level;
 	}
 
 	drm_dbg_dp(link->drm_dev, "adjusted: v_level=%d, p_level=%d\n",
diff --git a/drivers/gpu/drm/msm/dp/dp_link.h b/drivers/gpu/drm/msm/dp/dp_link.h
index 9dd4dd926530..79c3a02b8dac 100644
--- a/drivers/gpu/drm/msm/dp/dp_link.h
+++ b/drivers/gpu/drm/msm/dp/dp_link.h
@@ -19,19 +19,7 @@ struct dp_link_info {
 	unsigned long capabilities;
 };
 
-enum dp_link_voltage_level {
-	DP_TRAIN_VOLTAGE_SWING_LVL_0	= 0,
-	DP_TRAIN_VOLTAGE_SWING_LVL_1	= 1,
-	DP_TRAIN_VOLTAGE_SWING_LVL_2	= 2,
-	DP_TRAIN_VOLTAGE_SWING_MAX	= DP_TRAIN_VOLTAGE_SWING_LVL_2,
-};
-
-enum dp_link_preemaphasis_level {
-	DP_TRAIN_PRE_EMPHASIS_LVL_0	= 0,
-	DP_TRAIN_PRE_EMPHASIS_LVL_1	= 1,
-	DP_TRAIN_PRE_EMPHASIS_LVL_2	= 2,
-	DP_TRAIN_PRE_EMPHASIS_MAX	= DP_TRAIN_PRE_EMPHASIS_LVL_2,
-};
+#define DP_TRAIN_LEVEL_MAX	3
 
 struct dp_link_test_video {
 	u32 test_video_pattern;
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index a7c6e8a1754d..cd9ca3690161 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -402,8 +402,8 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 	unsigned long byte_intf_rate;
 	int ret;
 
-	DBG("Set clk rates: pclk=%d, byteclk=%lu",
-		msm_host->mode->clock, msm_host->byte_clk_rate);
+	DBG("Set clk rates: pclk=%lu, byteclk=%lu",
+	    msm_host->pixel_clk_rate, msm_host->byte_clk_rate);
 
 	ret = dev_pm_opp_set_rate(&msm_host->pdev->dev,
 				  msm_host->byte_clk_rate);
@@ -482,9 +482,9 @@ int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host)
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
diff --git a/drivers/gpu/drm/mxsfb/lcdif_drv.c b/drivers/gpu/drm/mxsfb/lcdif_drv.c
index 075002ed6fb0..43d316447f38 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_drv.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_drv.c
@@ -290,6 +290,9 @@ static int __maybe_unused lcdif_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (pm_runtime_suspended(dev))
+		return 0;
+
 	return lcdif_rpm_suspend(dev);
 }
 
@@ -297,7 +300,8 @@ static int __maybe_unused lcdif_resume(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 
-	lcdif_rpm_resume(dev);
+	if (!pm_runtime_suspended(dev))
+		lcdif_rpm_resume(dev);
 
 	return drm_mode_config_helper_resume(drm);
 }
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index bfcddd4aa932..2c14779a39e8 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -397,6 +397,7 @@ static int panel_edp_suspend(struct device *dev)
 {
 	struct panel_edp *p = dev_get_drvdata(dev);
 
+	drm_dp_dpcd_set_powered(p->aux, false);
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get();
@@ -453,6 +454,7 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 	}
 
 	gpiod_set_value_cansleep(p->enable_gpio, 1);
+	drm_dp_dpcd_set_powered(p->aux, true);
 
 	delay = p->desc->delay.hpd_reliable;
 	if (p->no_hpd)
@@ -489,6 +491,7 @@ static int panel_edp_prepare_once(struct panel_edp *p)
 	return 0;
 
 error:
+	drm_dp_dpcd_set_powered(p->aux, false);
 	gpiod_set_value_cansleep(p->enable_gpio, 0);
 	regulator_disable(p->supply);
 	p->unprepared_time = ktime_get();
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 5d04957b1144..ec2780be74d1 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -573,10 +573,8 @@ static int nt35950_probe(struct mipi_dsi_device *dsi)
 		}
 		dsi_r_host = of_find_mipi_dsi_host_by_node(dsi_r);
 		of_node_put(dsi_r);
-		if (!dsi_r_host) {
-			dev_err(dev, "Cannot get secondary DSI host\n");
-			return -EPROBE_DEFER;
-		}
+		if (!dsi_r_host)
+			return dev_err_probe(dev, -EPROBE_DEFER, "Cannot get secondary DSI host\n");
 
 		nt->dsi[1] = mipi_dsi_device_register_full(dsi_r_host, info);
 		if (!nt->dsi[1]) {
diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 5a8b978c6415..5b698514957c 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -53,7 +53,7 @@ static void atana33xc20_wait(ktime_t start_ktime, unsigned int min_ms)
 	ktime_t now_ktime, min_ktime;
 
 	min_ktime = ktime_add(start_ktime, ms_to_ktime(min_ms));
-	now_ktime = ktime_get();
+	now_ktime = ktime_get_boottime();
 
 	if (ktime_before(now_ktime, min_ktime))
 		msleep(ktime_to_ms(ktime_sub(min_ktime, now_ktime)) + 1);
@@ -72,10 +72,11 @@ static int atana33xc20_suspend(struct device *dev)
 	if (p->el3_was_on)
 		atana33xc20_wait(p->el_on3_off_time, 150);
 
+	drm_dp_dpcd_set_powered(p->aux, false);
 	ret = regulator_disable(p->supply);
 	if (ret)
 		return ret;
-	p->powered_off_time = ktime_get();
+	p->powered_off_time = ktime_get_boottime();
 	p->el3_was_on = false;
 
 	return 0;
@@ -93,7 +94,8 @@ static int atana33xc20_resume(struct device *dev)
 	ret = regulator_enable(p->supply);
 	if (ret)
 		return ret;
-	p->powered_on_time = ktime_get();
+	drm_dp_dpcd_set_powered(p->aux, true);
+	p->powered_on_time = ktime_get_boottime();
 
 	if (p->no_hpd) {
 		msleep(HPD_MAX_MS);
@@ -107,19 +109,17 @@ static int atana33xc20_resume(struct device *dev)
 		if (hpd_asserted < 0)
 			ret = hpd_asserted;
 
-		if (ret)
+		if (ret) {
 			dev_warn(dev, "Error waiting for HPD GPIO: %d\n", ret);
-
-		return ret;
-	}
-
-	if (p->aux->wait_hpd_asserted) {
+			goto error;
+		}
+	} else if (p->aux->wait_hpd_asserted) {
 		ret = p->aux->wait_hpd_asserted(p->aux, HPD_MAX_US);
 
-		if (ret)
+		if (ret) {
 			dev_warn(dev, "Controller error waiting for HPD: %d\n", ret);
-
-		return ret;
+			goto error;
+		}
 	}
 
 	/*
@@ -131,6 +131,12 @@ static int atana33xc20_resume(struct device *dev)
 	 * right times.
 	 */
 	return 0;
+
+error:
+	drm_dp_dpcd_set_powered(p->aux, false);
+	regulator_disable(p->supply);
+
+	return ret;
 }
 
 static int atana33xc20_disable(struct drm_panel *panel)
@@ -142,7 +148,7 @@ static int atana33xc20_disable(struct drm_panel *panel)
 		return 0;
 
 	gpiod_set_value_cansleep(p->el_on3_gpio, 0);
-	p->el_on3_off_time = ktime_get();
+	p->el_on3_off_time = ktime_get_boottime();
 	p->enabled = false;
 
 	/*
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index b714ee1bcbaa..acb7f5c206d1 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2286,6 +2286,9 @@ static const struct panel_desc innolux_g121x1_l03 = {
 		.unprepare = 200,
 		.disable = 400,
 	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
 static const struct drm_display_mode innolux_n156bge_l21_mode = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index b233f52675dc..a72642bb9cc6 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -607,6 +607,8 @@ static void vop2_setup_scale(struct vop2 *vop2, const struct vop2_win *win,
 	const struct drm_format_info *info;
 	u16 hor_scl_mode, ver_scl_mode;
 	u16 hscl_filter_mode, vscl_filter_mode;
+	uint16_t cbcr_src_w = src_w;
+	uint16_t cbcr_src_h = src_h;
 	u8 gt2 = 0;
 	u8 gt4 = 0;
 	u32 val;
@@ -664,27 +666,27 @@ static void vop2_setup_scale(struct vop2 *vop2, const struct vop2_win *win,
 	vop2_win_write(win, VOP2_WIN_YRGB_VSCL_FILTER_MODE, vscl_filter_mode);
 
 	if (info->is_yuv) {
-		src_w /= info->hsub;
-		src_h /= info->vsub;
+		cbcr_src_w /= info->hsub;
+		cbcr_src_h /= info->vsub;
 
 		gt4 = 0;
 		gt2 = 0;
 
-		if (src_h >= (4 * dst_h)) {
+		if (cbcr_src_h >= (4 * dst_h)) {
 			gt4 = 1;
-			src_h >>= 2;
-		} else if (src_h >= (2 * dst_h)) {
+			cbcr_src_h >>= 2;
+		} else if (cbcr_src_h >= (2 * dst_h)) {
 			gt2 = 1;
-			src_h >>= 1;
+			cbcr_src_h >>= 1;
 		}
 
-		hor_scl_mode = scl_get_scl_mode(src_w, dst_w);
-		ver_scl_mode = scl_get_scl_mode(src_h, dst_h);
+		hor_scl_mode = scl_get_scl_mode(cbcr_src_w, dst_w);
+		ver_scl_mode = scl_get_scl_mode(cbcr_src_h, dst_h);
 
-		val = vop2_scale_factor(src_w, dst_w);
+		val = vop2_scale_factor(cbcr_src_w, dst_w);
 		vop2_win_write(win, VOP2_WIN_SCALE_CBCR_X, val);
 
-		val = vop2_scale_factor(src_h, dst_h);
+		val = vop2_scale_factor(cbcr_src_h, dst_h);
 		vop2_win_write(win, VOP2_WIN_SCALE_CBCR_Y, val);
 
 		vop2_win_write(win, VOP2_WIN_VSD_CBCR_GT4, gt4);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f69681891349..072e2487b465 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2489,6 +2489,8 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 		index = 1;
 
 	addr = of_get_address(dev->of_node, index, NULL, NULL);
+	if (!addr)
+		return -EINVAL;
 
 	vc4_hdmi->audio.dma_data.addr = be32_to_cpup(addr) + mai_data->offset;
 	vc4_hdmi->audio.dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index bb8bd7892b67..eda888f75f16 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -222,6 +222,11 @@ static void amd_sfh_resume(struct amd_mp2_dev *mp2)
 	struct amd_mp2_sensor_info info;
 	int i, status;
 
+	if (!cl_data->is_any_sensor_enabled) {
+		amd_sfh_clear_intr(mp2);
+		return;
+	}
+
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		if (cl_data->sensor_sts[i] == SENSOR_DISABLED) {
 			info.sensor_idx = cl_data->sensor_idx[i];
@@ -247,6 +252,11 @@ static void amd_sfh_suspend(struct amd_mp2_dev *mp2)
 	struct amdtp_cl_data *cl_data = mp2->cl_data;
 	int i, status;
 
+	if (!cl_data->is_any_sensor_enabled) {
+		amd_sfh_clear_intr(mp2);
+		return;
+	}
+
 	for (i = 0; i < cl_data->num_hid_devices; i++) {
 		if (cl_data->sensor_idx[i] != HPD_IDX &&
 		    cl_data->sensor_sts[i] == SENSOR_ENABLED) {
diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 710fda5f19e1..916d427163ca 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -216,6 +216,11 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
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
index fda48a0afc1a..354267edcb45 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1120,6 +1120,8 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
 	/* QSUPP, bits[16:15] Q element support field */
 	drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
+	if (drvdata->q_support)
+		drvdata->q_filt = !!(etmidr0 & TRCIDR0_QFILT);
 	/* TSSIZE, bits[28:24] Global timestamp size field */
 	drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
 
@@ -1615,16 +1617,14 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
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
@@ -1641,7 +1641,8 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trccntvr[i] = etm4x_read32(csa, TRCCNTVRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/* Resource selector pair 0 is reserved */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		state->trcrsctlr[i] = etm4x_read32(csa, TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
@@ -1726,8 +1727,10 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
@@ -1746,16 +1749,14 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
@@ -1772,7 +1773,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, state->trccntvr[i], TRCCNTVRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/* Resource selector pair 0 is reserved */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		etm4x_relaxed_write32(csa, state->trcrsctlr[i], TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
@@ -2053,6 +2055,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	ret = etm4_probe(&pdev->dev, NULL, 0);
 
 	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index d8e4d902b01a..31754173091b 100644
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
@@ -141,6 +135,7 @@
 #define TRCIDR0_TRCCCI				BIT(7)
 #define TRCIDR0_RETSTACK			BIT(9)
 #define TRCIDR0_NUMEVENT_MASK			GENMASK(11, 10)
+#define TRCIDR0_QFILT				BIT(14)
 #define TRCIDR0_QSUPP_MASK			GENMASK(16, 15)
 #define TRCIDR0_TSSIZE_MASK			GENMASK(28, 24)
 
@@ -272,9 +267,6 @@
 /* List of registers accessible via System instructions */
 #define ETM4x_ONLY_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPROCSELR)		\
-	CASE_##op((val), TRCVDCTLR)		\
-	CASE_##op((val), TRCVDSACCTLR)		\
-	CASE_##op((val), TRCVDARCCTLR)		\
 	CASE_##op((val), TRCOSLAR)
 
 #define ETM_COMMON_SYSREG_LIST(op, val)		\
@@ -422,22 +414,6 @@
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
@@ -905,9 +881,6 @@ struct etmv4_save_state {
 	u32	trcviiectlr;
 	u32	trcvissctlr;
 	u32	trcvipcssctlr;
-	u32	trcvdctlr;
-	u32	trcvdsacctlr;
-	u32	trcvdarcctlr;
 
 	u32	trcseqevr[ETM_MAX_SEQ_STATES];
 	u32	trcseqrstevr;
@@ -979,6 +952,7 @@ struct etmv4_save_state {
  * @os_unlock:  True if access to management registers is allowed.
  * @instrp0:	Tracing of load and store instructions
  *		as P0 elements is supported.
+ * @q_filt:	Q element filtering support, if Q elements are supported.
  * @trcbb:	Indicates if the trace unit supports branch broadcast tracing.
  * @trccond:	If the trace unit supports conditional
  *		instruction tracing.
@@ -1041,6 +1015,7 @@ struct etmv4_drvdata {
 	bool				boot_enable;
 	bool				os_unlock;
 	bool				instrp0;
+	bool				q_filt;
 	bool				trcbb;
 	bool				trccond;
 	bool				retstack;
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
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index a5d5b7b3823b..6fede34091cc 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2079,6 +2079,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
 				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
 					vin[0], vin[1]);
+				ret = -EINVAL;
 				goto err;
 			}
 		} else if (ret != -EINVAL) {
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index a2f8278f0085..135a86fc9453 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1670,8 +1670,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
 		return NULL;
 
 	indio_dev = &iio_dev_opaque->indio_dev;
-	indio_dev->priv = (char *)iio_dev_opaque +
-		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
+
+	if (sizeof_priv)
+		indio_dev->priv = (char *)iio_dev_opaque +
+			ALIGN(sizeof(*iio_dev_opaque), IIO_DMA_MINALIGN);
 
 	indio_dev->dev.parent = parent;
 	indio_dev->dev.type = &iio_device_type;
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index db1b1e48225a..519fcd425b6a 100644
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
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 736dc2f993b4..ff177466de9b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -151,7 +151,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		return ret;
 	}
 
-	ret = xa_err(xa_store(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&cq_table->array, hr_cq->cqn, hr_cq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to xa_store CQ, ret = %d.\n", ret);
 		goto err_put;
@@ -164,7 +164,7 @@ static int alloc_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 	return 0;
 
 err_xa:
-	xa_erase(&cq_table->array, hr_cq->cqn);
+	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 err_put:
 	hns_roce_table_put(hr_dev, &cq_table->table, hr_cq->cqn);
 
@@ -183,7 +183,7 @@ static void free_cqc(struct hns_roce_dev *hr_dev, struct hns_roce_cq *hr_cq)
 		dev_err(dev, "DESTROY_CQ failed (%d) for CQN %06lx\n", ret,
 			hr_cq->cqn);
 
-	xa_erase(&cq_table->array, hr_cq->cqn);
+	xa_erase_irq(&cq_table->array, hr_cq->cqn);
 
 	/* Waiting interrupt process procedure carried out */
 	synchronize_irq(hr_dev->eq_table.eq[hr_cq->vector].irq);
@@ -472,13 +472,6 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 	struct ib_event event;
 	struct ib_cq *ibcq;
 
-	hr_cq = xa_load(&hr_dev->cq_table.array,
-			cqn & (hr_dev->caps.num_cqs - 1));
-	if (!hr_cq) {
-		dev_warn(dev, "async event for bogus CQ 0x%06x\n", cqn);
-		return;
-	}
-
 	if (event_type != HNS_ROCE_EVENT_TYPE_CQ_ID_INVALID &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_ACCESS_ERROR &&
 	    event_type != HNS_ROCE_EVENT_TYPE_CQ_OVERFLOW) {
@@ -487,7 +480,16 @@ void hns_roce_cq_event(struct hns_roce_dev *hr_dev, u32 cqn, int event_type)
 		return;
 	}
 
-	refcount_inc(&hr_cq->refcount);
+	xa_lock(&hr_dev->cq_table.array);
+	hr_cq = xa_load(&hr_dev->cq_table.array,
+			cqn & (hr_dev->caps.num_cqs - 1));
+	if (hr_cq)
+		refcount_inc(&hr_cq->refcount);
+	xa_unlock(&hr_dev->cq_table.array);
+	if (!hr_cq) {
+		dev_warn(dev, "async event for bogus CQ 0x%06x\n", cqn);
+		return;
+	}
 
 	ibcq = &hr_cq->ib_cq;
 	if (ibcq->event_handler) {
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.h b/drivers/infiniband/hw/hns/hns_roce_hem.h
index 7d23d3c51da4..fea6d7d508b6 100644
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
index d06b19e69a15..c931cce50d50 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2229,7 +2229,7 @@ static void apply_func_caps(struct hns_roce_dev *hr_dev)
 		caps->gid_table_len[0] = caps->gmv_bt_num *
 					(HNS_HW_PAGE_SIZE / caps->gmv_entry_sz);
 
-		caps->gmv_entry_num = caps->gmv_bt_num * (PAGE_SIZE /
+		caps->gmv_entry_num = caps->gmv_bt_num * (HNS_HW_PAGE_SIZE /
 							  caps->gmv_entry_sz);
 	} else {
 		u32 func_num = max_t(u32, 1, hr_dev->func_num);
@@ -3857,8 +3857,9 @@ static void get_cqe_status(struct hns_roce_dev *hr_dev, struct hns_roce_qp *qp,
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
index da1b33d818d8..afe7523eca90 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -37,6 +37,7 @@
 #include <rdma/ib_smi.h>
 #include <rdma/ib_user_verbs.h>
 #include <rdma/ib_cache.h>
+#include "hnae3.h"
 #include "hns_roce_common.h"
 #include "hns_roce_device.h"
 #include "hns_roce_hem.h"
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 14376490ac22..190e62da98e4 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -421,18 +421,18 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
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
 
@@ -443,17 +443,16 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
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
index 8dae98f827eb..6a4923c21cbc 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -122,7 +122,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		return ret;
 	}
 
-	ret = xa_err(xa_store(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
+	ret = xa_err(xa_store_irq(&srq_table->xa, srq->srqn, srq, GFP_KERNEL));
 	if (ret) {
 		ibdev_err(ibdev, "failed to store SRQC, ret = %d.\n", ret);
 		goto err_put;
@@ -135,7 +135,7 @@ static int alloc_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 	return 0;
 
 err_xa:
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 err_put:
 	hns_roce_table_put(hr_dev, &srq_table->table, srq->srqn);
 
@@ -153,7 +153,7 @@ static void free_srqc(struct hns_roce_dev *hr_dev, struct hns_roce_srq *srq)
 		dev_err(hr_dev->dev, "DESTROY_SRQ failed (%d) for SRQN %06lx\n",
 			ret, srq->srqn);
 
-	xa_erase(&srq_table->xa, srq->srqn);
+	xa_erase_irq(&srq_table->xa, srq->srqn);
 
 	if (refcount_dec_and_test(&srq->refcount))
 		complete(&srq->free);
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 96ffbbaf0a73..5a22be14d958 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/io.h>
 #include <rdma/ib_umem_odp.h>
 #include "mlx5_ib.h"
 #include <linux/jiffies.h>
@@ -108,7 +109,6 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	__be32 mmio_wqe[16] = {};
 	unsigned long flags;
 	unsigned int idx;
-	int i;
 
 	if (unlikely(dev->mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR))
 		return -EIO;
@@ -148,10 +148,8 @@ static int post_send_nop(struct mlx5_ib_dev *dev, struct ib_qp *ibqp, u64 wr_id,
 	 * we hit doorbell
 	 */
 	wmb();
-	for (i = 0; i < 8; i++)
-		mlx5_write64(&mmio_wqe[i * 2],
-			     bf->bfreg->map + bf->offset + i * 8);
-	io_stop_wc();
+	__iowrite64_copy(bf->bfreg->map + bf->offset, mmio_wqe,
+			 sizeof(mmio_wqe) / 8);
 
 	bf->offset ^= bf->buf_size;
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 410cc5fd2523..b81b03aa2a62 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1349,7 +1349,8 @@ static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
 	unsigned int diffs = current_access_flags ^ target_access_flags;
 
 	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
-		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
+		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING |
+		      IB_ACCESS_REMOTE_ATOMIC))
 		return false;
 	return mlx5r_umr_can_reconfig(dev, current_access_flags,
 				      target_access_flags);
diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
index d2a250123617..c238fa61815a 100644
--- a/drivers/infiniband/sw/rxe/rxe_comp.c
+++ b/drivers/infiniband/sw/rxe/rxe_comp.c
@@ -126,12 +126,12 @@ void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
 {
 	int must_sched;
 
-	skb_queue_tail(&qp->resp_pkts, skb);
-
-	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
+	must_sched = skb_queue_len(&qp->resp_pkts) > 0;
 	if (must_sched != 0)
 		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
 
+	skb_queue_tail(&qp->resp_pkts, skb);
+
 	if (must_sched)
 		rxe_sched_task(&qp->comp.task);
 	else
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 719432808a06..779cd547ce83 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -20,9 +20,10 @@
 
 static struct rxe_recv_sockets recv_sockets;
 
-static struct dst_entry *rxe_find_route4(struct net_device *ndev,
-				  struct in_addr *saddr,
-				  struct in_addr *daddr)
+static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
+					 struct net_device *ndev,
+					 struct in_addr *saddr,
+					 struct in_addr *daddr)
 {
 	struct rtable *rt;
 	struct flowi4 fl = { { 0 } };
@@ -35,7 +36,7 @@ static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 
 	rt = ip_route_output_key(&init_net, &fl);
 	if (IS_ERR(rt)) {
-		pr_err_ratelimited("no route to %pI4\n", &daddr->s_addr);
+		rxe_dbg_qp(qp, "no route to %pI4\n", &daddr->s_addr);
 		return NULL;
 	}
 
@@ -43,7 +44,8 @@ static struct dst_entry *rxe_find_route4(struct net_device *ndev,
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-static struct dst_entry *rxe_find_route6(struct net_device *ndev,
+static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
+					 struct net_device *ndev,
 					 struct in6_addr *saddr,
 					 struct in6_addr *daddr)
 {
@@ -60,12 +62,12 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 					       recv_sockets.sk6->sk, &fl6,
 					       NULL);
 	if (IS_ERR(ndst)) {
-		pr_err_ratelimited("no route to %pI6\n", daddr);
+		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
 		return NULL;
 	}
 
 	if (unlikely(ndst->error)) {
-		pr_err("no route to %pI6\n", daddr);
+		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
 		goto put;
 	}
 
@@ -77,7 +79,8 @@ static struct dst_entry *rxe_find_route6(struct net_device *ndev,
 
 #else
 
-static struct dst_entry *rxe_find_route6(struct net_device *ndev,
+static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
+					 struct net_device *ndev,
 					 struct in6_addr *saddr,
 					 struct in6_addr *daddr)
 {
@@ -105,14 +108,14 @@ static struct dst_entry *rxe_find_route(struct net_device *ndev,
 
 			saddr = &av->sgid_addr._sockaddr_in.sin_addr;
 			daddr = &av->dgid_addr._sockaddr_in.sin_addr;
-			dst = rxe_find_route4(ndev, saddr, daddr);
+			dst = rxe_find_route4(qp, ndev, saddr, daddr);
 		} else if (av->network_type == RXE_NETWORK_TYPE_IPV6) {
 			struct in6_addr *saddr6;
 			struct in6_addr *daddr6;
 
 			saddr6 = &av->sgid_addr._sockaddr_in6.sin6_addr;
 			daddr6 = &av->dgid_addr._sockaddr_in6.sin6_addr;
-			dst = rxe_find_route6(ndev, saddr6, daddr6);
+			dst = rxe_find_route6(qp, ndev, saddr6, daddr6);
 #if IS_ENABLED(CONFIG_IPV6)
 			if (dst)
 				qp->dst_cookie =
@@ -285,7 +288,7 @@ static int prepare4(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 	dst = rxe_find_route(skb->dev, qp, av);
 	if (!dst) {
-		pr_err("Host not reachable\n");
+		rxe_dbg_qp(qp, "Host not reachable\n");
 		return -EHOSTUNREACH;
 	}
 
@@ -309,7 +312,7 @@ static int prepare6(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 	dst = rxe_find_route(skb->dev, qp, av);
 	if (!dst) {
-		pr_err("Host not reachable\n");
+		rxe_dbg_qp(qp, "Host not reachable\n");
 		return -EHOSTUNREACH;
 	}
 
@@ -363,20 +366,13 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
-	if (skb->protocol == htons(ETH_P_IP)) {
+	if (skb->protocol == htons(ETH_P_IP))
 		err = ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else if (skb->protocol == htons(ETH_P_IPV6)) {
+	else
 		err = ip6_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
-	} else {
-		pr_err("Unknown layer 3 protocol: %d\n", skb->protocol);
-		atomic_dec(&pkt->qp->skb_out);
-		rxe_put(pkt->qp);
-		kfree_skb(skb);
-		return -EINVAL;
-	}
 
 	if (unlikely(net_xmit_eval(err))) {
-		pr_debug("error sending packet: %d\n", err);
+		rxe_dbg_qp(pkt->qp, "error sending packet: %d\n", err);
 		return -EAGAIN;
 	}
 
@@ -417,7 +413,7 @@ int rxe_xmit_packet(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
 
 	if ((is_request && (qp->req.state != QP_STATE_READY)) ||
 	    (!is_request && (qp->resp.state != QP_STATE_READY))) {
-		pr_info("Packet dropped. QP is not in ready state\n");
+		rxe_dbg_qp(qp, "Packet dropped. QP is not in ready state\n");
 		goto drop;
 	}
 
@@ -598,7 +594,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 		rxe_port_down(rxe);
 		break;
 	case NETDEV_CHANGEMTU:
-		pr_info("%s changed mtu to %d\n", ndev->name, ndev->mtu);
+		rxe_dbg(rxe, "%s changed mtu to %d\n", ndev->name, ndev->mtu);
 		rxe_set_mtu(rxe, ndev->mtu);
 		break;
 	case NETDEV_CHANGE:
@@ -610,7 +606,7 @@ static int rxe_notify(struct notifier_block *not_blk,
 	case NETDEV_CHANGENAME:
 	case NETDEV_FEAT_CHANGE:
 	default:
-		pr_info("ignoring netdev event = %ld for %s\n",
+		rxe_dbg(rxe, "ignoring netdev event = %ld for %s\n",
 			event, ndev->name);
 		break;
 	}
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
index 4bd161e86f8d..562df2b3ef18 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_vlan.c
@@ -184,8 +184,12 @@ int ipoib_vlan_add(struct net_device *pdev, unsigned short pkey)
 
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
index b2f1292e27ef..180d90e46061 100644
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
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 82a2698ad66b..ca7ad37ea677 100644
--- a/drivers/interconnect/qcom/qcm2290.c
+++ b/drivers/interconnect/qcom/qcm2290.c
@@ -164,7 +164,7 @@ static struct qcom_icc_node mas_snoc_bimc = {
 	.name = "mas_snoc_bimc",
 	.buswidth = 16,
 	.qos.ap_owned = true,
-	.qos.qos_port = 2,
+	.qos.qos_port = 6,
 	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
 	.mas_rpm_id = 164,
 	.slv_rpm_id = -1,
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
index a72ede90ffc6..8b642927b522 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -136,7 +136,7 @@ static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
 
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
index 5200bba63708..9d8ac04c2346 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1352,7 +1352,7 @@ __acquires(bitmap->lock)
 	sector_t chunk = offset >> bitmap->chunkshift;
 	unsigned long page = chunk >> PAGE_COUNTER_SHIFT;
 	unsigned long pageoff = (chunk & PAGE_COUNTER_MASK) << COUNTER_BYTE_SHIFT;
-	sector_t csize;
+	sector_t csize = ((sector_t)1) << bitmap->chunkshift;
 	int err;
 
 	if (page >= bitmap->pages) {
@@ -1361,6 +1361,7 @@ __acquires(bitmap->lock)
 		 * End-of-device while looking for a whole page or
 		 * user set a huge number to sysfs bitmap_set_bits.
 		 */
+		*blocks = csize - (offset & (csize - 1));
 		return NULL;
 	}
 	err = md_bitmap_checkpage(bitmap, page, create, 0);
@@ -1369,8 +1370,7 @@ __acquires(bitmap->lock)
 	    bitmap->bp[page].map == NULL)
 		csize = ((sector_t)1) << (bitmap->chunkshift +
 					  PAGE_COUNTER_SHIFT);
-	else
-		csize = ((sector_t)1) << bitmap->chunkshift;
+
 	*blocks = csize - (offset & (csize - 1));
 
 	if (err < 0)
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index c761ac35e120..a5e5f6a4af91 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -490,6 +490,15 @@ int cec_thread_func(void *_adap)
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
@@ -744,6 +753,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 {
 	struct cec_data *data;
 	bool is_raw = msg_is_raw(msg);
+	int err;
 
 	if (adap->devnode.unregistered)
 		return -ENODEV;
@@ -908,11 +918,13 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
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
 	if (!data->completed) {
 		if (data->msg.tx_status & CEC_TX_STATUS_OK)
@@ -1545,9 +1557,12 @@ static int cec_config_thread_func(void *arg)
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
@@ -1562,6 +1577,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 		wait_for_completion(&adap->config_completion);
 		mutex_lock(&adap->lock);
 	}
+	adap->is_claiming_log_addrs = false;
 }
 
 /*
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index 67dc79ef1705..3ef915344304 100644
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
@@ -664,6 +664,8 @@ static int cec_release(struct inode *inode, struct file *filp)
 		list_del_init(&data->xfer_list);
 	}
 	mutex_unlock(&adap->lock);
+
+	mutex_lock(&fh->lock);
 	while (!list_empty(&fh->msgs)) {
 		struct cec_msg_entry *entry =
 			list_first_entry(&fh->msgs, struct cec_msg_entry, list);
@@ -681,6 +683,7 @@ static int cec_release(struct inode *inode, struct file *filp)
 			kfree(entry);
 		}
 	}
+	mutex_unlock(&fh->lock);
 	kfree(fh);
 
 	cec_put_device(devnode);
diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
index 1bbe58b24d99..2ae713088053 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2-main.c
@@ -1798,11 +1798,6 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 
 	v4l2_async_nf_init(&cio2->notifier);
 
-	/* Register notifier for subdevices we care */
-	r = cio2_parse_firmware(cio2);
-	if (r)
-		goto fail_clean_notifier;
-
 	r = devm_request_irq(dev, pci_dev->irq, cio2_irq, IRQF_SHARED,
 			     CIO2_NAME, cio2);
 	if (r) {
@@ -1810,6 +1805,11 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 		goto fail_clean_notifier;
 	}
 
+	/* Register notifier for subdevices we care */
+	r = cio2_parse_firmware(cio2);
+	if (r)
+		goto fail_clean_notifier;
+
 	pm_runtime_put_noidle(dev);
 	pm_runtime_allow(dev);
 
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
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
index 1f94589d9ef1..0b144ed64379 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-vin.h
@@ -58,7 +58,7 @@ enum rvin_isp_id {
 
 #define RVIN_REMOTES_MAX \
 	(((unsigned int)RVIN_CSI_MAX) > ((unsigned int)RVIN_ISP_MAX) ? \
-	 RVIN_CSI_MAX : RVIN_ISP_MAX)
+	 (unsigned int)RVIN_CSI_MAX : (unsigned int)RVIN_ISP_MAX)
 
 /**
  * enum rvin_dma_state - DMA states
diff --git a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
index 47a8c0fb7eb9..99c401e653bc 100644
--- a/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
+++ b/drivers/media/platform/sunxi/sun8i-a83t-mipi-csi2/Kconfig
@@ -8,6 +8,7 @@ config VIDEO_SUN8I_A83T_MIPI_CSI2
 	select VIDEO_V4L2_SUBDEV_API
 	select V4L2_FWNODE
 	select REGMAP_MMIO
+	select GENERIC_PHY
 	select GENERIC_PHY_MIPI_DPHY
 	help
 	   Support for the Allwinner A83T MIPI CSI-2 controller and D-PHY.
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
index 790787f0eba8..bcb24d896498 100644
--- a/drivers/media/usb/b2c2/flexcop-usb.c
+++ b/drivers/media/usb/b2c2/flexcop-usb.c
@@ -515,7 +515,7 @@ static int flexcop_usb_init(struct flexcop_usb *fc_usb)
 
 	alt = fc_usb->uintf->cur_altsetting;
 
-	if (alt->desc.bNumEndpoints < 1)
+	if (alt->desc.bNumEndpoints < 2)
 		return -ENODEV;
 	if (!usb_endpoint_is_isoc_in(&alt->endpoint[0].desc))
 		return -ENODEV;
diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index 366f0e4a5dc0..e79c45db60ab 100644
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
 
diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 4f8d962bb5b2..1300ccab3d21 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -625,7 +625,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	if (!vmci_dev) {
 		dev_err(&pdev->dev,
 			"Can't allocate memory for VMCI device\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_unmap_mmio_base;
 	}
 
 	vmci_dev->dev = &pdev->dev;
@@ -642,7 +643,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		if (!vmci_dev->tx_buffer) {
 			dev_err(&pdev->dev,
 				"Can't allocate memory for datagram tx buffer\n");
-			return -ENOMEM;
+			error = -ENOMEM;
+			goto err_unmap_mmio_base;
 		}
 
 		vmci_dev->data_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
@@ -893,6 +895,10 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 err_free_data_buffers:
 	vmci_free_dg_buffers(vmci_dev);
 
+err_unmap_mmio_base:
+	if (mmio_base != NULL)
+		pci_iounmap(pdev, mmio_base);
+
 	/* The rest are managed resources and will be freed by PCI core */
 	return error;
 }
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index c16dbe64859e..52d6cc07e38c 100644
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
@@ -576,32 +665,15 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
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
@@ -614,9 +686,12 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
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
index 24518e5e1b5e..ad527bdbd463 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -942,8 +942,10 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 
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
index 0d4d4bbfdece..49e36767d8f7 100644
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
index 6ce076462dbf..c2f4d4bbf65a 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -48,7 +48,9 @@ obj-$(CONFIG_ARCNET) += arcnet/
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
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index dc9eea3c8ab1..f9f43897f86c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2540,7 +2540,7 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 		else
 			interface = PHY_INTERFACE_MODE_MII;
 	} else if (val == bitval[P_RMII_SEL]) {
-		interface = PHY_INTERFACE_MODE_RGMII;
+		interface = PHY_INTERFACE_MODE_RMII;
 	} else {
 		interface = PHY_INTERFACE_MODE_RGMII;
 		if (data8 & P_RGMII_ID_EG_ENABLE)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 517c50d11fbc..dc4ff8a6d0bf 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3003,6 +3003,7 @@ static int mv88e6xxx_software_reset(struct mv88e6xxx_chip *chip)
 static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
 {
 	struct gpio_desc *gpiod = chip->reset;
+	int err;
 
 	/* If there is a GPIO connected to the reset pin, toggle it */
 	if (gpiod) {
@@ -3011,17 +3012,26 @@ static void mv88e6xxx_hardware_reset(struct mv88e6xxx_chip *chip)
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
 
@@ -4339,6 +4349,8 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4529,6 +4541,8 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4630,6 +4644,8 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4731,6 +4747,8 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4794,6 +4812,8 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4855,6 +4875,8 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4919,6 +4941,8 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -4977,6 +5001,8 @@ static const struct mv88e6xxx_ops mv88e6250_ops = {
 	.watchdog_ops = &mv88e6250_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6250_g1_wait_eeprom_done_prereset,
+	.hardware_reset_post = mv88e6xxx_g1_wait_eeprom_done,
 	.reset = mv88e6250_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5021,6 +5047,8 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5085,6 +5113,8 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5129,6 +5159,8 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.set_egress_port = mv88e6095_g1_set_egress_port,
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
@@ -5177,6 +5209,8 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu =  mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5333,6 +5367,8 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.watchdog_ops = &mv88e6097_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5400,6 +5436,8 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5467,6 +5505,8 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6390_g1_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
@@ -5537,6 +5577,8 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.watchdog_ops = &mv88e6393x_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6393x_port_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
+	.hardware_reset_pre = mv88e6xxx_g2_eeprom_wait,
+	.hardware_reset_post = mv88e6xxx_g2_eeprom_wait,
 	.reset = mv88e6352_g1_reset,
 	.rmu_disable = mv88e6390_g1_rmu_disable,
 	.atu_get_hash = mv88e6165_g1_atu_get_hash,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 97a47d8743fd..b34e96e689d5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -458,6 +458,12 @@ struct mv88e6xxx_ops {
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
index 04b57a21f786..f3c0b8ab6461 100644
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -281,6 +281,8 @@ int mv88e6xxx_g1_set_switch_mac(struct mv88e6xxx_chip *chip, u8 *addr);
 int mv88e6185_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6352_g1_reset(struct mv88e6xxx_chip *chip);
 int mv88e6250_g1_reset(struct mv88e6xxx_chip *chip);
+int mv88e6xxx_g1_wait_eeprom_done(struct mv88e6xxx_chip *chip);
+int mv88e6250_g1_wait_eeprom_done_prereset(struct mv88e6xxx_chip *chip);
 
 int mv88e6185_g1_ppu_enable(struct mv88e6xxx_chip *chip);
 int mv88e6185_g1_ppu_disable(struct mv88e6xxx_chip *chip);
diff --git a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
index 466ad9470d1f..6de0d590be34 100644
--- a/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
+++ b/drivers/net/ethernet/amazon/ena/ena_admin_defs.h
@@ -869,7 +869,9 @@ struct ena_admin_host_info {
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
@@ -1184,6 +1186,8 @@ struct ena_admin_ena_mmio_req_read_less_resp {
 #define ENA_ADMIN_HOST_INFO_RX_BUF_MIRRORING_MASK           BIT(3)
 #define ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_SHIFT 4
 #define ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK BIT(4)
+#define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_SHIFT             6
+#define ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK              BIT(6)
 
 /* aenq_common_desc */
 #define ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK               BIT(0)
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 4db689372980..276f6a8631fb 100644
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
@@ -1983,8 +1913,7 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 		if (rc)
 			return rc;
 
-		if (get_resp.u.max_queue_ext.version !=
-		    ENA_FEATURE_MAX_QUEUE_EXT_VER)
+		if (get_resp.u.max_queue_ext.version != ENA_FEATURE_MAX_QUEUE_EXT_VER)
 			return -EINVAL;
 
 		memcpy(&get_feat_ctx->max_queue_ext, &get_resp.u.max_queue_ext,
@@ -2025,18 +1954,15 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
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
@@ -2084,8 +2010,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 	aenq_common = &aenq_e->aenq_common_desc;
 
 	/* Go over all the events */
-	while ((READ_ONCE(aenq_common->flags) &
-		ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) == phase) {
+	while ((READ_ONCE(aenq_common->flags) & ENA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK) == phase) {
 		/* Make sure the phase bit (ownership) is as expected before
 		 * reading the rest of the descriptor.
 		 */
@@ -2094,8 +2019,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 		timestamp = (u64)aenq_common->timestamp_low |
 			((u64)aenq_common->timestamp_high << 32);
 
-		netdev_dbg(ena_dev->net_device,
-			   "AENQ! Group[%x] Syndrome[%x] timestamp: [%llus]\n",
+		netdev_dbg(ena_dev->net_device, "AENQ! Group[%x] Syndrome[%x] timestamp: [%llus]\n",
 			   aenq_common->group, aenq_common->syndrome, timestamp);
 
 		/* Handle specific event*/
@@ -2124,8 +2048,7 @@ void ena_com_aenq_intr_handler(struct ena_com_dev *ena_dev, void *data)
 
 	/* write the aenq doorbell after all AENQ descriptors were read */
 	mb();
-	writel_relaxed((u32)aenq->head,
-		       ena_dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
+	writel_relaxed((u32)aenq->head, ena_dev->reg_bar + ENA_REGS_AENQ_HEAD_DB_OFF);
 }
 
 int ena_com_dev_reset(struct ena_com_dev *ena_dev,
@@ -2137,15 +2060,13 @@ int ena_com_dev_reset(struct ena_com_dev *ena_dev,
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
 
@@ -2168,8 +2089,7 @@ int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 	rc = wait_for_reset_state(ena_dev, timeout,
 				  ENA_REGS_DEV_STS_RESET_IN_PROGRESS_MASK);
 	if (rc != 0) {
-		netdev_err(ena_dev->net_device,
-			   "Reset indication didn't turn on\n");
+		netdev_err(ena_dev->net_device, "Reset indication didn't turn on\n");
 		return rc;
 	}
 
@@ -2177,8 +2097,7 @@ int ena_com_dev_reset(struct ena_com_dev *ena_dev,
 	writel(0, ena_dev->reg_bar + ENA_REGS_DEV_CTL_OFF);
 	rc = wait_for_reset_state(ena_dev, timeout, 0);
 	if (rc != 0) {
-		netdev_err(ena_dev->net_device,
-			   "Reset indication didn't turn off\n");
+		netdev_err(ena_dev->net_device, "Reset indication didn't turn off\n");
 		return rc;
 	}
 
@@ -2215,8 +2134,7 @@ static int ena_get_dev_stats(struct ena_com_dev *ena_dev,
 					     sizeof(*get_resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to get stats. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to get stats. error: %d\n", ret);
 
 	return ret;
 }
@@ -2228,8 +2146,7 @@ int ena_com_get_eni_stats(struct ena_com_dev *ena_dev,
 	int ret;
 
 	if (!ena_com_get_cap(ena_dev, ENA_ADMIN_ENI_STATS)) {
-		netdev_err(ena_dev->net_device,
-			   "Capability %d isn't supported\n",
+		netdev_err(ena_dev->net_device, "Capability %d isn't supported\n",
 			   ENA_ADMIN_ENI_STATS);
 		return -EOPNOTSUPP;
 	}
@@ -2266,8 +2183,7 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 	int ret;
 
 	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_MTU)) {
-		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
-			   ENA_ADMIN_MTU);
+		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n", ENA_ADMIN_MTU);
 		return -EOPNOTSUPP;
 	}
 
@@ -2286,8 +2202,7 @@ int ena_com_set_dev_mtu(struct ena_com_dev *ena_dev, u32 mtu)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set mtu %d. error: %d\n", mtu, ret);
+		netdev_err(ena_dev->net_device, "Failed to set mtu %d. error: %d\n", mtu, ret);
 
 	return ret;
 }
@@ -2301,8 +2216,7 @@ int ena_com_get_offload_settings(struct ena_com_dev *ena_dev,
 	ret = ena_com_get_feature(ena_dev, &resp,
 				  ENA_ADMIN_STATELESS_OFFLOAD_CONFIG, 0);
 	if (unlikely(ret)) {
-		netdev_err(ena_dev->net_device,
-			   "Failed to get offload capabilities %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to get offload capabilities %d\n", ret);
 		return ret;
 	}
 
@@ -2320,8 +2234,7 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 	struct ena_admin_get_feat_resp get_resp;
 	int ret;
 
-	if (!ena_com_check_supported_feature_id(ena_dev,
-						ENA_ADMIN_RSS_HASH_FUNCTION)) {
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_RSS_HASH_FUNCTION)) {
 		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
 			   ENA_ADMIN_RSS_HASH_FUNCTION);
 		return -EOPNOTSUPP;
@@ -2334,8 +2247,7 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 		return ret;
 
 	if (!(get_resp.u.flow_hash_func.supported_func & BIT(rss->hash_func))) {
-		netdev_err(ena_dev->net_device,
-			   "Func hash %d isn't supported by device, abort\n",
+		netdev_err(ena_dev->net_device, "Func hash %d isn't supported by device, abort\n",
 			   rss->hash_func);
 		return -EOPNOTSUPP;
 	}
@@ -2365,8 +2277,7 @@ int ena_com_set_hash_function(struct ena_com_dev *ena_dev)
 					    (struct ena_admin_acq_entry *)&resp,
 					    sizeof(resp));
 	if (unlikely(ret)) {
-		netdev_err(ena_dev->net_device,
-			   "Failed to set hash function %d. error: %d\n",
+		netdev_err(ena_dev->net_device, "Failed to set hash function %d. error: %d\n",
 			   rss->hash_func, ret);
 		return -EINVAL;
 	}
@@ -2398,16 +2309,15 @@ int ena_com_fill_hash_function(struct ena_com_dev *ena_dev,
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
@@ -2495,8 +2405,7 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 	struct ena_admin_set_feat_resp resp;
 	int ret;
 
-	if (!ena_com_check_supported_feature_id(ena_dev,
-						ENA_ADMIN_RSS_HASH_INPUT)) {
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_RSS_HASH_INPUT)) {
 		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
 			   ENA_ADMIN_RSS_HASH_INPUT);
 		return -EOPNOTSUPP;
@@ -2527,8 +2436,7 @@ int ena_com_set_hash_ctrl(struct ena_com_dev *ena_dev)
 					    (struct ena_admin_acq_entry *)&resp,
 					    sizeof(resp));
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set hash input. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to set hash input. error: %d\n", ret);
 
 	return ret;
 }
@@ -2605,8 +2513,7 @@ int ena_com_fill_hash_ctrl(struct ena_com_dev *ena_dev,
 	int rc;
 
 	if (proto >= ENA_ADMIN_RSS_PROTO_NUM) {
-		netdev_err(ena_dev->net_device, "Invalid proto num (%u)\n",
-			   proto);
+		netdev_err(ena_dev->net_device, "Invalid proto num (%u)\n", proto);
 		return -EINVAL;
 	}
 
@@ -2658,8 +2565,7 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 	struct ena_admin_set_feat_resp resp;
 	int ret;
 
-	if (!ena_com_check_supported_feature_id(
-		    ena_dev, ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG)) {
+	if (!ena_com_check_supported_feature_id(ena_dev, ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG)) {
 		netdev_dbg(ena_dev->net_device, "Feature %d isn't supported\n",
 			   ENA_ADMIN_RSS_INDIRECTION_TABLE_CONFIG);
 		return -EOPNOTSUPP;
@@ -2699,8 +2605,7 @@ int ena_com_indirect_table_set(struct ena_com_dev *ena_dev)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set indirect table. error: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to set indirect table. error: %d\n", ret);
 
 	return ret;
 }
@@ -2779,9 +2684,8 @@ int ena_com_allocate_host_info(struct ena_com_dev *ena_dev)
 {
 	struct ena_host_attribute *host_attr = &ena_dev->host_attr;
 
-	host_attr->host_info =
-		dma_alloc_coherent(ena_dev->dmadev, SZ_4K,
-				   &host_attr->host_info_dma_addr, GFP_KERNEL);
+	host_attr->host_info = dma_alloc_coherent(ena_dev->dmadev, SZ_4K,
+						  &host_attr->host_info_dma_addr, GFP_KERNEL);
 	if (unlikely(!host_attr->host_info))
 		return -ENOMEM;
 
@@ -2827,8 +2731,7 @@ void ena_com_delete_debug_area(struct ena_com_dev *ena_dev)
 
 	if (host_attr->debug_area_virt_addr) {
 		dma_free_coherent(ena_dev->dmadev, host_attr->debug_area_size,
-				  host_attr->debug_area_virt_addr,
-				  host_attr->debug_area_dma_addr);
+				  host_attr->debug_area_virt_addr, host_attr->debug_area_dma_addr);
 		host_attr->debug_area_virt_addr = NULL;
 	}
 }
@@ -2877,8 +2780,7 @@ int ena_com_set_host_attributes(struct ena_com_dev *ena_dev)
 					    sizeof(resp));
 
 	if (unlikely(ret))
-		netdev_err(ena_dev->net_device,
-			   "Failed to set host attributes: %d\n", ret);
+		netdev_err(ena_dev->net_device, "Failed to set host attributes: %d\n", ret);
 
 	return ret;
 }
@@ -2896,8 +2798,7 @@ static int ena_com_update_nonadaptive_moderation_interval(struct ena_com_dev *en
 							  u32 *intr_moder_interval)
 {
 	if (!intr_delay_resolution) {
-		netdev_err(ena_dev->net_device,
-			   "Illegal interrupt delay granularity value\n");
+		netdev_err(ena_dev->net_device, "Illegal interrupt delay granularity value\n");
 		return -EFAULT;
 	}
 
@@ -2935,14 +2836,12 @@ int ena_com_init_interrupt_moderation(struct ena_com_dev *ena_dev)
 
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
@@ -2990,8 +2889,7 @@ int ena_com_config_dev_mode(struct ena_com_dev *ena_dev,
 		(llq_info->descs_num_before_header * sizeof(struct ena_eth_io_tx_desc));
 
 	if (unlikely(ena_dev->tx_max_header_size == 0)) {
-		netdev_err(ena_dev->net_device,
-			   "The size of the LLQ entry is smaller than needed\n");
+		netdev_err(ena_dev->net_device, "The size of the LLQ entry is smaller than needed\n");
 		return -EINVAL;
 	}
 
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
index 5e37b18ac3ad..77fa4c35f233 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -164,11 +164,9 @@ static int ena_xmit_common(struct net_device *dev,
 	if (unlikely(rc)) {
 		netif_err(adapter, tx_queued, dev,
 			  "Failed to prepare tx bufs\n");
-		ena_increase_stat(&ring->tx_stats.prepare_ctx_err, 1,
-				  &ring->syncp);
+		ena_increase_stat(&ring->tx_stats.prepare_ctx_err, 1, &ring->syncp);
 		if (rc != -ENOMEM)
-			ena_reset_device(adapter,
-					 ENA_REGS_RESET_DRIVER_INVALID_STATE);
+			ena_reset_device(adapter, ENA_REGS_RESET_DRIVER_INVALID_STATE);
 		return rc;
 	}
 
@@ -992,8 +990,7 @@ static struct page *ena_alloc_map_page(struct ena_ring *rx_ring,
 	 */
 	page = dev_alloc_page();
 	if (!page) {
-		ena_increase_stat(&rx_ring->rx_stats.page_alloc_fail, 1,
-				  &rx_ring->syncp);
+		ena_increase_stat(&rx_ring->rx_stats.page_alloc_fail, 1, &rx_ring->syncp);
 		return ERR_PTR(-ENOSPC);
 	}
 
@@ -1022,7 +1019,7 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	int tailroom;
 
 	/* restore page offset value in case it has been changed by device */
-	rx_info->page_offset = headroom;
+	rx_info->buf_offset = headroom;
 
 	/* if previous allocated page is not used */
 	if (unlikely(rx_info->page))
@@ -1039,6 +1036,8 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
 	tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
 	rx_info->page = page;
+	rx_info->dma_addr = dma;
+	rx_info->page_offset = 0;
 	ena_buf = &rx_info->ena_buf;
 	ena_buf->paddr = dma + headroom;
 	ena_buf->len = ENA_PAGE_SIZE - headroom - tailroom;
@@ -1046,14 +1045,12 @@ static int ena_alloc_rx_buffer(struct ena_ring *rx_ring,
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
@@ -1067,7 +1064,7 @@ static void ena_free_rx_page(struct ena_ring *rx_ring,
 		return;
 	}
 
-	ena_unmap_rx_buff(rx_ring, rx_info);
+	ena_unmap_rx_buff_attrs(rx_ring, rx_info, 0);
 
 	__free_page(page);
 	rx_info->page = NULL;
@@ -1344,8 +1341,7 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
 						&req_id);
 		if (rc) {
 			if (unlikely(rc == -EINVAL))
-				handle_invalid_req_id(tx_ring, req_id, NULL,
-						      false);
+				handle_invalid_req_id(tx_ring, req_id, NULL, false);
 			break;
 		}
 
@@ -1413,14 +1409,14 @@ static int ena_clean_tx_irq(struct ena_ring *tx_ring, u32 budget)
 	return tx_pkts;
 }
 
-static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag)
+static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag, u16 len)
 {
 	struct sk_buff *skb;
 
 	if (!first_frag)
-		skb = napi_alloc_skb(rx_ring->napi, rx_ring->rx_copybreak);
+		skb = napi_alloc_skb(rx_ring->napi, len);
 	else
-		skb = napi_build_skb(first_frag, ENA_PAGE_SIZE);
+		skb = napi_build_skb(first_frag, len);
 
 	if (unlikely(!skb)) {
 		ena_increase_stat(&rx_ring->rx_stats.skb_alloc_fail, 1,
@@ -1429,24 +1425,47 @@ static struct sk_buff *ena_alloc_skb(struct ena_ring *rx_ring, void *first_frag)
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
@@ -1466,34 +1485,25 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
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
@@ -1501,14 +1511,21 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 		return skb;
 	}
 
-	ena_unmap_rx_buff(rx_ring, rx_info);
+	buf_len = SKB_DATA_ALIGN(len + buf_offset + tailroom);
+
+	/* If XDP isn't loaded try to reuse part of the RX buffer */
+	reuse_rx_buf_page = !is_xdp_loaded &&
+			    ena_try_rx_buf_page_reuse(rx_info, buf_len, len, pkt_offset);
+
+	if (!reuse_rx_buf_page)
+		ena_unmap_rx_buff_attrs(rx_ring, rx_info, DMA_ATTR_SKIP_CPU_SYNC);
 
-	skb = ena_alloc_skb(rx_ring, page_addr);
+	skb = ena_alloc_skb(rx_ring, buf_addr, buf_len);
 	if (unlikely(!skb))
 		return NULL;
 
 	/* Populate skb's linear part */
-	skb_reserve(skb, page_offset);
+	skb_reserve(skb, buf_offset);
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 
@@ -1517,7 +1534,8 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 			  "RX skb updated. len %d. data_len %d\n",
 			  skb->len, skb->data_len);
 
-		rx_info->page = NULL;
+		if (!reuse_rx_buf_page)
+			rx_info->page = NULL;
 
 		rx_ring->free_ids[*next_to_clean] = req_id;
 		*next_to_clean =
@@ -1532,10 +1550,27 @@ static struct sk_buff *ena_rx_skb(struct ena_ring *rx_ring,
 
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
 
@@ -1641,14 +1676,14 @@ static int ena_xdp_handle_buff(struct ena_ring *rx_ring, struct xdp_buff *xdp, u
 
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
 
@@ -1677,6 +1712,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	int xdp_flags = 0;
 	int total_len = 0;
 	int xdp_verdict;
+	u8 pkt_offset;
 	int rc = 0;
 	int i;
 
@@ -1703,13 +1739,19 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 
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
 
@@ -1733,8 +1775,9 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
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
@@ -1796,8 +1839,7 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	adapter = netdev_priv(rx_ring->netdev);
 
 	if (rc == -ENOSPC) {
-		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1,
-				  &rx_ring->syncp);
+		ena_increase_stat(&rx_ring->rx_stats.bad_desc_num, 1, &rx_ring->syncp);
 		ena_reset_device(adapter, ENA_REGS_RESET_TOO_MANY_RX_DESCS);
 	} else {
 		ena_increase_stat(&rx_ring->rx_stats.bad_req_id, 1,
@@ -2342,8 +2384,7 @@ static int ena_rss_configure(struct ena_adapter *adapter)
 	if (!ena_dev->rss.tbl_log_size) {
 		rc = ena_rss_init_default(adapter);
 		if (rc && (rc != -EOPNOTSUPP)) {
-			netif_err(adapter, ifup, adapter->netdev,
-				  "Failed to init RSS rc: %d\n", rc);
+			netif_err(adapter, ifup, adapter->netdev, "Failed to init RSS rc: %d\n", rc);
 			return rc;
 		}
 	}
@@ -3216,7 +3257,8 @@ static void ena_config_host_info(struct ena_com_dev *ena_dev, struct pci_dev *pd
 		ENA_ADMIN_HOST_INFO_RX_OFFSET_MASK |
 		ENA_ADMIN_HOST_INFO_INTERRUPT_MODERATION_MASK |
 		ENA_ADMIN_HOST_INFO_RX_BUF_MIRRORING_MASK |
-		ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK;
+		ENA_ADMIN_HOST_INFO_RSS_CONFIGURABLE_FUNCTION_KEY_MASK |
+		ENA_ADMIN_HOST_INFO_RX_PAGE_REUSE_MASK;
 
 	rc = ena_com_set_host_attributes(ena_dev);
 	if (rc) {
@@ -3259,8 +3301,7 @@ static void ena_config_debug_area(struct ena_adapter *adapter)
 	rc = ena_com_set_host_attributes(adapter->ena_dev);
 	if (rc) {
 		if (rc == -EOPNOTSUPP)
-			netif_warn(adapter, drv, adapter->netdev,
-				   "Cannot set host attributes\n");
+			netif_warn(adapter, drv, adapter->netdev, "Cannot set host attributes\n");
 		else
 			netif_err(adapter, drv, adapter->netdev,
 				  "Cannot set host attributes\n");
@@ -4132,8 +4173,8 @@ static int ena_rss_init_default(struct ena_adapter *adapter)
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
index 2cb141079474..73bfd7229c6a 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.h
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.h
@@ -51,6 +51,8 @@
 #define ENA_DEFAULT_RING_SIZE	(1024)
 #define ENA_MIN_RING_SIZE	(256)
 
+#define ENA_MIN_RX_BUF_SIZE (2048)
+
 #define ENA_MIN_NUM_IO_QUEUES	(1)
 
 #define ENA_TX_WAKEUP_THRESH		(MAX_SKB_FRAGS + 2)
@@ -175,7 +177,9 @@ struct ena_tx_buffer {
 struct ena_rx_buffer {
 	struct sk_buff *skb;
 	struct page *page;
+	dma_addr_t dma_addr;
 	u32 page_offset;
+	u32 buf_offset;
 	struct ena_com_buf ena_buf;
 } ____cacheline_aligned;
 
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index 29500d32e362..2065c26f394d 100644
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
index 7c0b0bc033c9..19fb8c4caab8 100644
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
index ebff14b0837d..0a3df468316e 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3732,6 +3732,14 @@ static int fec_enet_init(struct net_device *ndev)
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
@@ -4136,6 +4144,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_deinit(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
@@ -4199,6 +4208,7 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	fec_enet_deinit(ndev);
 	free_netdev(ndev);
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index cffd9ad499dd..e0393dc159fc 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -102,14 +102,13 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
 	struct timespec64 ts;
 	u64 ns;
 
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
@@ -440,6 +439,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	int ret = 0;
 
 	if (rq->type == PTP_CLK_REQ_PPS) {
+		fep->pps_channel = DEFAULT_PPS_CHANNEL;
+		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
+
 		ret = fec_ptp_enable_pps(fep, on);
 
 		return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 02eb78df2378..a163e7717a53 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3473,7 +3473,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
 	bool locked = false;
-	u32 curr_combined;
 	int ret = 0;
 
 	/* do not support changing channels in Safe Mode */
@@ -3495,22 +3494,8 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
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
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
index 239266e9d5f1..80c16e04f670 100644
--- a/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c
@@ -45,14 +45,15 @@ int ice_vsi_add_vlan(struct ice_vsi *vsi, struct ice_vlan *vlan)
 		return -EINVAL;
 
 	err = ice_fltr_add_vlan(vsi, vlan);
-	if (err && err != -EEXIST) {
+	if (!err)
+		vsi->num_vlan++;
+	else if (err == -EEXIST)
+		err = 0;
+	else
 		dev_err(ice_pf_to_dev(vsi->back), "Failure Adding VLAN %d on VSI %i, status %d\n",
 			vlan->vid, vsi->vsi_num, err);
-		return err;
-	}
 
-	vsi->num_vlan++;
-	return 0;
+	return err;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 61b9774b3d31..c24a72d1e273 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3673,9 +3673,7 @@ struct ixgbe_info {
 #define IXGBE_KRM_LINK_S1(P)		((P) ? 0x8200 : 0x4200)
 #define IXGBE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
 #define IXGBE_KRM_AN_CNTL_1(P)		((P) ? 0x822C : 0x422C)
-#define IXGBE_KRM_AN_CNTL_4(P)		((P) ? 0x8238 : 0x4238)
 #define IXGBE_KRM_AN_CNTL_8(P)		((P) ? 0x8248 : 0x4248)
-#define IXGBE_KRM_PCS_KX_AN(P)		((P) ? 0x9918 : 0x5918)
 #define IXGBE_KRM_SGMII_CTRL(P)		((P) ? 0x82A0 : 0x42A0)
 #define IXGBE_KRM_LP_BASE_PAGE_HIGH(P)	((P) ? 0x836C : 0x436C)
 #define IXGBE_KRM_DSP_TXFFE_STATE_4(P)	((P) ? 0x8634 : 0x4634)
@@ -3685,7 +3683,6 @@ struct ixgbe_info {
 #define IXGBE_KRM_PMD_FLX_MASK_ST20(P)	((P) ? 0x9054 : 0x5054)
 #define IXGBE_KRM_TX_COEFF_CTRL_1(P)	((P) ? 0x9520 : 0x5520)
 #define IXGBE_KRM_RX_ANA_CTL(P)		((P) ? 0x9A00 : 0x5A00)
-#define IXGBE_KRM_FLX_TMRS_CTRL_ST31(P)	((P) ? 0x9180 : 0x5180)
 
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA		~(0x3 << 20)
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR		BIT(20)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index cdc912bba808..f1b63937c552 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1724,59 +1724,9 @@ static s32 ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		return -EINVAL;
 	}
 
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* change mode enforcement rules to hybrid */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x0400;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* manually control the config */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x20002240;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* move the AN base page values */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x1;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* set the AN37 over CB mode */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x20000000;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* restart AN manually */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+	status = mac->ops.write_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
 
 	/* Toggle port SW reset by AN reset. */
 	status = ixgbe_restart_an_internal_phy_x550em(hw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index ac6a0785b10d..465d2adbf3c0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -964,19 +964,32 @@ static void cmd_work_handler(struct work_struct *work)
 	bool poll_cmd = ent->polling;
 	struct mlx5_cmd_layout *lay;
 	struct mlx5_core_dev *dev;
-	unsigned long cb_timeout;
-	struct semaphore *sem;
+	unsigned long timeout;
 	unsigned long flags;
 	int alloc_ret;
 	int cmd_mode;
 
+	complete(&ent->handling);
+
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
-	cb_timeout = msecs_to_jiffies(mlx5_tout_ms(dev, CMD));
+	timeout = msecs_to_jiffies(mlx5_tout_ms(dev, CMD));
 
-	complete(&ent->handling);
-	sem = ent->page_queue ? &cmd->vars.pages_sem : &cmd->vars.sem;
-	down(sem);
 	if (!ent->page_queue) {
+		if (down_timeout(&cmd->vars.sem, timeout)) {
+			mlx5_core_warn(dev, "%s(0x%x) timed out while waiting for a slot.\n",
+				       mlx5_command_str(ent->op), ent->op);
+			if (ent->callback) {
+				ent->callback(-EBUSY, ent->context);
+				mlx5_free_cmd_msg(dev, ent->out);
+				free_msg(dev, ent->in);
+				cmd_ent_put(ent);
+			} else {
+				ent->ret = -EBUSY;
+				complete(&ent->done);
+			}
+			complete(&ent->slotted);
+			return;
+		}
 		alloc_ret = cmd_alloc_index(cmd, ent);
 		if (alloc_ret < 0) {
 			mlx5_core_err_rl(dev, "failed to allocate command entry\n");
@@ -989,10 +1002,11 @@ static void cmd_work_handler(struct work_struct *work)
 				ent->ret = -EAGAIN;
 				complete(&ent->done);
 			}
-			up(sem);
+			up(&cmd->vars.sem);
 			return;
 		}
 	} else {
+		down(&cmd->vars.pages_sem);
 		ent->idx = cmd->vars.max_reg_cmds;
 		spin_lock_irqsave(&cmd->alloc_lock, flags);
 		clear_bit(ent->idx, &cmd->vars.bitmask);
@@ -1000,6 +1014,8 @@ static void cmd_work_handler(struct work_struct *work)
 		spin_unlock_irqrestore(&cmd->alloc_lock, flags);
 	}
 
+	complete(&ent->slotted);
+
 	lay = get_inst(cmd, ent->idx);
 	ent->lay = lay;
 	memset(lay, 0, sizeof(*lay));
@@ -1018,7 +1034,7 @@ static void cmd_work_handler(struct work_struct *work)
 	ent->ts1 = ktime_get_ns();
 	cmd_mode = cmd->mode;
 
-	if (ent->callback && schedule_delayed_work(&ent->cb_timeout_work, cb_timeout))
+	if (ent->callback && schedule_delayed_work(&ent->cb_timeout_work, timeout))
 		cmd_ent_get(ent);
 	set_bit(MLX5_CMD_ENT_STATE_PENDING_COMP, &ent->state);
 
@@ -1138,6 +1154,9 @@ static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
 		ent->ret = -ECANCELED;
 		goto out_err;
 	}
+
+	wait_for_completion(&ent->slotted);
+
 	if (cmd->mode == CMD_MODE_POLLING || ent->polling)
 		wait_for_completion(&ent->done);
 	else if (!wait_for_completion_timeout(&ent->done, timeout))
@@ -1152,6 +1171,9 @@ static int wait_func(struct mlx5_core_dev *dev, struct mlx5_cmd_work_ent *ent)
 	} else if (err == -ECANCELED) {
 		mlx5_core_warn(dev, "%s(0x%x) canceled on out of queue timeout.\n",
 			       mlx5_command_str(ent->op), ent->op);
+	} else if (err == -EBUSY) {
+		mlx5_core_warn(dev, "%s(0x%x) timeout while waiting for command semaphore.\n",
+			       mlx5_command_str(ent->op), ent->op);
 	}
 	mlx5_core_dbg(dev, "err %d, delivery status %s(%d)\n",
 		      err, deliv_status_to_str(ent->status), ent->status);
@@ -1203,6 +1225,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 	ent->polling = force_polling;
 
 	init_completion(&ent->handling);
+	init_completion(&ent->slotted);
 	if (!callback)
 		init_completion(&ent->done);
 
@@ -1220,7 +1243,7 @@ static int mlx5_cmd_invoke(struct mlx5_core_dev *dev, struct mlx5_cmd_msg *in,
 		return 0; /* mlx5_cmd_comp_handler() will put(ent) */
 
 	err = wait_func(dev, ent);
-	if (err == -ETIMEDOUT || err == -ECANCELED)
+	if (err == -ETIMEDOUT || err == -ECANCELED || err == -EBUSY)
 		goto out_free;
 
 	ds = ent->ts2 - ent->ts1;
@@ -1609,6 +1632,9 @@ static int cmd_comp_notifier(struct notifier_block *nb,
 	dev = container_of(cmd, struct mlx5_core_dev, cmd);
 	eqe = data;
 
+	if (dev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR)
+		return NOTIFY_DONE;
+
 	mlx5_cmd_comp_handler(dev, be32_to_cpu(eqe->data.cmd.vector), false);
 
 	return NOTIFY_OK;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index d3de1b7a80bf..be7302aa6f86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -581,11 +581,16 @@ int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 	bool unaligned = xsk ? xsk->unaligned : false;
 	u16 max_mtu_pkts;
 
-	if (!mlx5e_check_fragmented_striding_rq_cap(mdev, page_shift, umr_mode))
+	if (!mlx5e_check_fragmented_striding_rq_cap(mdev, page_shift, umr_mode)) {
+		mlx5_core_err(mdev, "Striding RQ for XSK can't be activated with page_shift %u and umr_mode %d\n",
+			      page_shift, umr_mode);
 		return -EOPNOTSUPP;
+	}
 
-	if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, xsk))
+	if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, xsk)) {
+		mlx5_core_err(mdev, "Striding RQ linear mode for XSK can't be activated with current params\n");
 		return -EINVAL;
+	}
 
 	/* Current RQ length is too big for the given frame size, the
 	 * needed number of WQEs exceeds the maximum.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index ff03c43833bb..608d4253799d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -7,6 +7,18 @@
 #include "en/health.h"
 #include <net/xdp_sock_drv.h>
 
+static int mlx5e_legacy_rq_validate_xsk(struct mlx5_core_dev *mdev,
+					struct mlx5e_params *params,
+					struct mlx5e_xsk_param *xsk)
+{
+	if (!mlx5e_rx_is_linear_skb(mdev, params, xsk)) {
+		mlx5_core_err(mdev, "Legacy RQ linear mode for XSK can't be activated with current params\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* The limitation of 2048 can be altered, but shouldn't go beyond the minimal
  * stride size of striding RQ.
  */
@@ -16,9 +28,14 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 			      struct mlx5e_xsk_param *xsk,
 			      struct mlx5_core_dev *mdev)
 {
-	/* AF_XDP doesn't support frames larger than PAGE_SIZE. */
-	if (xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE)
+	/* AF_XDP doesn't support frames larger than PAGE_SIZE,
+	 * and xsk->chunk_size is limited to 65535 bytes.
+	 */
+	if ((size_t)xsk->chunk_size > PAGE_SIZE || xsk->chunk_size < MLX5E_MIN_XSK_CHUNK_SIZE) {
+		mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u, %lu]\n", xsk->chunk_size,
+			      MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);
 		return false;
+	}
 
 	/* frag_sz is different for regular and XSK RQs, so ensure that linear
 	 * SKB mode is possible.
@@ -27,7 +44,7 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		return !mlx5e_mpwrq_validate_xsk(mdev, params, xsk);
 	default: /* MLX5_WQ_TYPE_CYCLIC */
-		return mlx5e_rx_is_linear_skb(mdev, params, xsk);
+		return !mlx5e_legacy_rq_validate_xsk(mdev, params, xsk);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index 07187028f0d3..1445a9a46bae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
@@ -102,8 +102,14 @@ static inline void
 mlx5e_udp_gso_handle_tx_skb(struct sk_buff *skb)
 {
 	int payload_len = skb_shinfo(skb)->gso_size + sizeof(struct udphdr);
+	struct udphdr *udphdr;
 
-	udp_hdr(skb)->len = htons(payload_len);
+	if (skb->encapsulation)
+		udphdr = (struct udphdr *)skb_inner_transport_header(skb);
+	else
+		udphdr = udp_hdr(skb);
+
+	udphdr->len = htons(payload_len);
 }
 
 struct mlx5e_accel_tx_state {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 1878a70b9031..43ccdf0e6cff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
@@ -97,18 +97,11 @@ mlx5e_ipsec_feature_check(struct sk_buff *skb, netdev_features_t features)
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
index e7d396434da3..e2f134e1d9fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3666,7 +3666,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_dropped = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index a6d7e2cfcd0e..e6e792a38a64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -153,7 +153,11 @@ mlx5e_tx_get_gso_ihs(struct mlx5e_txqsq *sq, struct sk_buff *skb, int *hopbyhop)
 
 	*hopbyhop = 0;
 	if (skb->encapsulation) {
-		ihs = skb_inner_tcp_all_headers(skb);
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
+			ihs = skb_inner_transport_offset(skb) +
+			      sizeof(struct udphdr);
+		else
+			ihs = skb_inner_tcp_all_headers(skb);
 		stats->tso_inner_packets++;
 		stats->tso_inner_bytes += skb->len - ihs;
 	} else {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 01c0e1ee918d..a283d8ae466b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -696,6 +696,7 @@ static bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	struct mlx5_core_dev *dev;
 	u8 mode;
 #endif
+	bool roce_support;
 	int i;
 
 	for (i = 0; i < ldev->ports; i++)
@@ -722,6 +723,11 @@ static bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 		if (mlx5_sriov_is_enabled(ldev->pf[i].dev))
 			return false;
 #endif
+	roce_support = mlx5_get_roce_state(ldev->pf[MLX5_LAG_P1].dev);
+	for (i = 1; i < ldev->ports; i++)
+		if (mlx5_get_roce_state(ldev->pf[i].dev) != roce_support)
+			return false;
+
 	return true;
 }
 
@@ -884,8 +890,10 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 		} else if (roce_lag) {
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
-			for (i = 1; i < ldev->ports; i++)
-				mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
+			for (i = 1; i < ldev->ports; i++) {
+				if (mlx5_get_roce_state(ldev->pf[i].dev))
+					mlx5_nic_vport_enable_roce(ldev->pf[i].dev);
+			}
 		} else if (shared_fdb) {
 			dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 			mlx5_rescan_drivers_locked(dev0);
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 25d9c254288b..956ae0206a1f 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -1215,7 +1215,6 @@ static void qed_slowpath_task(struct work_struct *work)
 static int qed_slowpath_wq_start(struct qed_dev *cdev)
 {
 	struct qed_hwfn *hwfn;
-	char name[NAME_SIZE];
 	int i;
 
 	if (IS_VF(cdev))
@@ -1224,11 +1223,11 @@ static int qed_slowpath_wq_start(struct qed_dev *cdev)
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
index 6e3417712e40..f83bd15f9e99 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4263,11 +4263,11 @@ static void rtl8169_doorbell(struct rtl8169_private *tp)
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
@@ -4290,6 +4290,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 
 	txd_first = tp->TxDescArray + entry;
 
+	frags = skb_shinfo(skb)->nr_frags;
 	if (frags) {
 		if (rtl8169_xmit_frags(tp, skb, opts, entry))
 			goto err_dma_1;
@@ -4607,10 +4608,8 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
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
index c521ea8f94f2..9c74d2542141 100644
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
index 4154e68639ac..940e45bf7a2e 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -948,17 +948,6 @@ static irqreturn_t gem_interrupt(int irq, void *dev_id)
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
@@ -2838,9 +2827,6 @@ static const struct net_device_ops gem_netdev_ops = {
 	.ndo_change_mtu		= gem_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_set_mac_address    = gem_set_mac_address,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller    = gem_poll_controller,
-#endif
 };
 
 static int gem_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index d447f3076e24..1d49771d07f4 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -439,7 +439,7 @@ static noinline_for_stack int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
-	err = ip_local_out(net, skb->sk, skb);
+	err = ip_local_out(net, NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
@@ -494,7 +494,7 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
-	err = ip6_local_out(dev_net(dev), skb->sk, skb);
+	err = ip6_local_out(dev_net(dev), NULL, skb);
 	if (unlikely(net_xmit_eval(err)))
 		DEV_STATS_INC(dev, tx_errors);
 	else
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 2cbb1d1830bb..98c6d0caf8fa 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3245,6 +3245,7 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.probe		= kszphy_probe,
 	.config_init	= ksz8061_config_init,
+	.soft_reset	= genphy_soft_reset,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= kszphy_suspend,
diff --git a/drivers/net/usb/aqc111.c b/drivers/net/usb/aqc111.c
index 7b8afa589a53..284375f662f1 100644
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
index 45a542659a81..d22ba63160b8 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1367,6 +1367,9 @@ static const struct usb_device_id products[] = {
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
index 2fa46baa589e..8e82184be5e7 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -879,7 +879,7 @@ static int smsc95xx_start_rx_path(struct usbnet *dev)
 static int smsc95xx_reset(struct usbnet *dev)
 {
 	struct smsc95xx_priv *pdata = dev->driver_priv;
-	u32 read_buf, write_buf, burst_cap;
+	u32 read_buf, burst_cap;
 	int ret = 0, timeout;
 
 	netif_dbg(dev, ifup, dev->net, "entering smsc95xx_reset\n");
@@ -1003,10 +1003,13 @@ static int smsc95xx_reset(struct usbnet *dev)
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
 
@@ -1810,9 +1813,11 @@ static int smsc95xx_reset_resume(struct usb_interface *intf)
 
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
@@ -1870,25 +1875,22 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
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
index 3164451e1010..0a662e42ed96 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -421,19 +421,15 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
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
diff --git a/drivers/net/wireless/ath/ar5523/ar5523.c b/drivers/net/wireless/ath/ar5523/ar5523.c
index ce3d613fa36c..2833e2206cc8 100644
--- a/drivers/net/wireless/ath/ar5523/ar5523.c
+++ b/drivers/net/wireless/ath/ar5523/ar5523.c
@@ -1589,6 +1589,20 @@ static int ar5523_probe(struct usb_interface *intf,
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
index 6cdb225b7eac..81058be3598f 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -704,6 +704,9 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.max_spatial_stream = 4,
 		.fw = {
 			.dir = WCN3990_HW_1_0_FW_DIR,
+			.board = WCN3990_HW_1_0_BOARD_DATA_FILE,
+			.board_size = WCN3990_BOARD_DATA_SZ,
+			.board_ext_size = WCN3990_BOARD_EXT_DATA_SZ,
 		},
 		.sw_decrypt_mcast_mgmt = true,
 		.rx_desc_ops = &wcn3990_rx_desc_ops,
diff --git a/drivers/net/wireless/ath/ath10k/debugfs_sta.c b/drivers/net/wireless/ath/ath10k/debugfs_sta.c
index 87a3365330ff..5598cf706daa 100644
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
index 9643031a4427..7ecdd0011cfa 100644
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
index 980d4124fa28..8a5a44d75b14 100644
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
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 51fc77e93de5..b863ead198bd 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1226,14 +1226,7 @@ static int ath11k_mac_vif_setup_ps(struct ath11k_vif *arvif)
 
 	enable_ps = arvif->ps;
 
-	if (!arvif->is_started) {
-		/* mac80211 can update vif powersave state while disconnected.
-		 * Firmware doesn't behave nicely and consumes more power than
-		 * necessary if PS is disabled on a non-started vdev. Hence
-		 * force-enable PS for non-running vdevs.
-		 */
-		psmode = WMI_STA_PS_MODE_ENABLED;
-	} else if (enable_ps) {
+	if (enable_ps) {
 		psmode = WMI_STA_PS_MODE_ENABLED;
 		param = WMI_STA_PS_PARAM_INACTIVITY_TIME;
 
diff --git a/drivers/net/wireless/ath/carl9170/tx.c b/drivers/net/wireless/ath/carl9170/tx.c
index 6bb9aa2bfe65..88ef6e023f82 100644
--- a/drivers/net/wireless/ath/carl9170/tx.c
+++ b/drivers/net/wireless/ath/carl9170/tx.c
@@ -280,7 +280,8 @@ static void carl9170_tx_release(struct kref *ref)
 	 * carl9170_tx_fill_rateinfo() has filled the rate information
 	 * before we get to this point.
 	 */
-	memset_after(&txinfo->status, 0, rates);
+	memset(&txinfo->pad, 0, sizeof(txinfo->pad));
+	memset(&txinfo->rate_driver_data, 0, sizeof(txinfo->rate_driver_data));
 
 	if (atomic_read(&ar->tx_total_queued))
 		ar->tx_schedule = true;
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
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
index 3b1277a8bd61..99cc41135473 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c
@@ -1640,6 +1640,15 @@ struct brcmf_random_seed_footer {
 #define BRCMF_RANDOM_SEED_MAGIC		0xfeedc0de
 #define BRCMF_RANDOM_SEED_LENGTH	0x100
 
+static noinline_for_stack void
+brcmf_pcie_provide_random_bytes(struct brcmf_pciedev_info *devinfo, u32 address)
+{
+	u8 randbuf[BRCMF_RANDOM_SEED_LENGTH];
+
+	get_random_bytes(randbuf, BRCMF_RANDOM_SEED_LENGTH);
+	memcpy_toio(devinfo->tcm + address, randbuf, BRCMF_RANDOM_SEED_LENGTH);
+}
+
 static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 					const struct firmware *fw, void *nvram,
 					u32 nvram_len)
@@ -1682,7 +1691,6 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 				.length = cpu_to_le32(rand_len),
 				.magic = cpu_to_le32(BRCMF_RANDOM_SEED_MAGIC),
 			};
-			void *randbuf;
 
 			/* Some Apple chips/firmwares expect a buffer of random
 			 * data to be present before NVRAM
@@ -1694,10 +1702,7 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
 				    sizeof(footer));
 
 			address -= rand_len;
-			randbuf = kzalloc(rand_len, GFP_KERNEL);
-			get_random_bytes(randbuf, rand_len);
-			memcpy_toio(devinfo->tcm + address, randbuf, rand_len);
-			kfree(randbuf);
+			brcmf_pcie_provide_random_bytes(devinfo, address);
 		}
 	} else {
 		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 4dc7e2e53b81..61697dad4ea6 100644
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
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 2980e1234d13..082ac1afc515 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1382,6 +1382,7 @@ void mt7603_pse_client_reset(struct mt7603_dev *dev)
 		   MT_CLIENT_RESET_TX_R_E_2_S);
 
 	/* Start PSE client TX abort */
+	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_FORCE_TX_EOF);
 	mt76_set(dev, addr, MT_CLIENT_RESET_TX_R_E_1);
 	mt76_poll_msec(dev, addr, MT_CLIENT_RESET_TX_R_E_1_S,
 		       MT_CLIENT_RESET_TX_R_E_1_S, 500);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f96d330d3964..6cf0ce7aff67 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -213,7 +213,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
+		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
 		else
 			distance = LOCAL_DISTANCE;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4dcddcf95279..e900525b7866 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -284,9 +284,9 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	}
 
 	if (shash_len != crypto_shash_digestsize(shash_tfm)) {
-		pr_debug("%s: hash len mismatch (len %d digest %d)\n",
-			 __func__, shash_len,
-			 crypto_shash_digestsize(shash_tfm));
+		pr_err("%s: hash len mismatch (len %d digest %d)\n",
+			__func__, shash_len,
+			crypto_shash_digestsize(shash_tfm));
 		ret = -EINVAL;
 		goto out_free_tfm;
 	}
@@ -368,7 +368,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	kfree_sensitive(host_response);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
-	return 0;
+	return ret;
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 73ae16059a1c..2e87718aa194 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -537,10 +537,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
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
@@ -615,6 +623,18 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	NULL,
 };
 
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid)
+{
+	struct config_item *ns_item;
+	char name[12];
+
+	snprintf(name, sizeof(name), "%u", nsid);
+	mutex_lock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	ns_item = config_group_find_item(&subsys->namespaces_group, name);
+	mutex_unlock(&subsys->namespaces_group.cg_subsys->su_mutex);
+	return ns_item != NULL;
+}
+
 static void nvmet_ns_release(struct config_item *item)
 {
 	struct nvmet_ns *ns = to_nvmet_ns(item);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3235baf7cc6b..7b74926c50f9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -423,10 +423,13 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 
-	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
+	req->ns = xa_load(&subsys->namespaces, nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		if (nvmet_subsys_nsid_exists(subsys, nsid))
+			return NVME_SC_INTERNAL_PATH_ERROR;
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
 	}
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 273cca49a040..6aee0ce60a4b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -527,6 +527,7 @@ void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
 void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
+bool nvmet_subsys_nsid_exists(struct nvmet_subsys *subsys, u32 nsid);
 
 #define NVMET_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 348076827469..5556f5588041 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -297,6 +297,7 @@ static int nvmet_tcp_check_ddgst(struct nvmet_tcp_queue *queue, void *pdu)
 	return 0;
 }
 
+/* If cmd buffers are NULL, no operation is performed */
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 {
 	kfree(cmd->iov);
@@ -1437,13 +1438,9 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
 
-	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_free_cmd_buffers(cmd);
-	}
-
-	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-		nvmet_tcp_free_cmd_buffers(&queue->connect);
+	for (i = 0; i < queue->nr_cmds; i++, cmd++)
+		nvmet_tcp_free_cmd_buffers(cmd);
+	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5d1ae2706f6e..0839454fe499 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2250,11 +2250,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		ret = tegra_pcie_config_ep(pcie, pdev);
 		if (ret < 0)
 			goto fail;
+		else
+			return 0;
 		break;
 
 	default:
 		dev_err(dev, "Invalid PCIe device type %d\n",
 			pcie->of_data->mode);
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
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
index 54aa4658fb36..535734dad2eb 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -513,12 +513,16 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 	if (event->cpu < 0)
 		return -EINVAL;
 
+	hwc->idx = -1;
+
+	if (event->group_leader == event)
+		return 0;
+
 	/*
 	 * We can't atomically disable all HW counters so only one event allowed,
 	 * although software events are acceptable.
 	 */
-	if (event->group_leader != event &&
-			!is_software_event(event->group_leader))
+	if (!is_software_event(event->group_leader))
 		return -EINVAL;
 
 	for_each_sibling_event(sibling, event->group_leader) {
@@ -527,7 +531,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	hwc->idx = -1;
 	return 0;
 }
 
diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
index c4c1cd269c57..49f2d69c119d 100644
--- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
+++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
@@ -326,15 +326,27 @@ static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
 			return false;
 
 		for (num = 0; num < counters; num++) {
+			/*
+			 * If we find a related event, then it's a valid group
+			 * since we don't need to allocate a new counter for it.
+			 */
 			if (hisi_pcie_pmu_cmp_event(event_group[num], sibling))
 				break;
 		}
 
+		/*
+		 * Otherwise it's a new event but if there's no available counter,
+		 * fail the check since we cannot schedule all the events in
+		 * the group simultaneously.
+		 */
+		if (num == HISI_PCIE_MAX_COUNTERS)
+			return false;
+
 		if (num == counters)
 			event_group[counters++] = sibling;
 	}
 
-	return counters <= HISI_PCIE_MAX_COUNTERS;
+	return true;
 }
 
 static int hisi_pcie_pmu_event_init(struct perf_event *event)
diff --git a/drivers/perf/hisilicon/hns3_pmu.c b/drivers/perf/hisilicon/hns3_pmu.c
index 16869bf5bf4c..60062eaa342a 100644
--- a/drivers/perf/hisilicon/hns3_pmu.c
+++ b/drivers/perf/hisilicon/hns3_pmu.c
@@ -1085,15 +1085,27 @@ static bool hns3_pmu_validate_event_group(struct perf_event *event)
 			return false;
 
 		for (num = 0; num < counters; num++) {
+			/*
+			 * If we find a related event, then it's a valid group
+			 * since we don't need to allocate a new counter for it.
+			 */
 			if (hns3_pmu_cmp_event(event_group[num], sibling))
 				break;
 		}
 
+		/*
+		 * Otherwise it's a new event but if there's no available counter,
+		 * fail the check since we cannot schedule all the events in
+		 * the group simultaneously.
+		 */
+		if (num == HNS3_PMU_MAX_HW_EVENTS)
+			return false;
+
 		if (num == counters)
 			event_group[counters++] = sibling;
 	}
 
-	return counters <= HNS3_PMU_MAX_HW_EVENTS;
+	return true;
 }
 
 static u32 hns3_pmu_get_filter_condition(struct perf_event *event)
@@ -1515,7 +1527,7 @@ static int hns3_pmu_irq_register(struct pci_dev *pdev,
 		return ret;
 	}
 
-	ret = devm_add_action(&pdev->dev, hns3_pmu_free_irq, pdev);
+	ret = devm_add_action_or_reset(&pdev->dev, hns3_pmu_free_irq, pdev);
 	if (ret) {
 		pci_err(pdev, "failed to add free irq action, ret = %d.\n", ret);
 		return ret;
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
index fe7ae0f3f46a..5ab1a0befe12 100644
--- a/drivers/regulator/irq_helpers.c
+++ b/drivers/regulator/irq_helpers.c
@@ -352,6 +352,9 @@ void *regulator_irq_helper(struct device *dev,
 
 	h->irq = irq;
 	h->desc = *d;
+	h->desc.name = devm_kstrdup(dev, d->name, GFP_KERNEL);
+	if (!h->desc.name)
+		return ERR_PTR(-ENOMEM);
 
 	ret = init_rdev_state(dev, h, rdev, common_errs, per_rdev_errs,
 			      rdev_amount);
diff --git a/drivers/regulator/vqmmc-ipq4019-regulator.c b/drivers/regulator/vqmmc-ipq4019-regulator.c
index c4213f096fe5..4f470b2d66c9 100644
--- a/drivers/regulator/vqmmc-ipq4019-regulator.c
+++ b/drivers/regulator/vqmmc-ipq4019-regulator.c
@@ -84,6 +84,7 @@ static const struct of_device_id regulator_ipq4019_of_match[] = {
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
diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugfs.c
index 52db147d9979..f6dd077d47c9 100644
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
index f6da34850af9..e529b3d3eaf3 100644
--- a/drivers/scsi/hpsa.c
+++ b/drivers/scsi/hpsa.c
@@ -5850,7 +5850,7 @@ static int hpsa_scsi_host_alloc(struct ctlr_info *h)
 {
 	struct Scsi_Host *sh;
 
-	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info));
+	sh = scsi_host_alloc(&hpsa_driver_template, sizeof(struct ctlr_info *));
 	if (sh == NULL) {
 		dev_err(&h->pdev->dev, "scsi_host_alloc failed\n");
 		return -ENOMEM;
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index 4b5ceba68e46..ffec7f0e51fc 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -239,8 +239,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
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
index a7a364760b80..081af4d420a0 100644
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
index c64e44964d84..6dce3f166564 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5144,7 +5144,7 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES)
-			strlcpy(ha->model_desc,
+			strscpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
 			    sizeof(ha->model_desc));
 	} else {
@@ -5152,14 +5152,14 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
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
diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
index c1837a468267..3ed8bd63f7e1 100644
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
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 7286c9b3be69..5bd874e58dd6 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1847,7 +1847,7 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd,
+		pdi = cdns_find_pdi(cdns, 0, stream->num_bd, stream->bd,
 				    dai_id);
 
 	if (pdi) {
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 12241815510d..c37d557f7d03 100644
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
index 1018feff468c..50fe5aa450f8 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1147,6 +1147,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	else
 		rx_dev = ctlr->dev.parent;
 
+	ret = -ENOMSG;
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* The sync is done before each transfer. */
 		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
@@ -1176,6 +1177,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			}
 		}
 	}
+	/* No transfer has been mapped, bail out with success */
+	if (ret)
+		return 0;
 
 	ctlr->cur_rx_dma_dev = rx_dev;
 	ctlr->cur_tx_dma_dev = tx_dev;
diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index 45afa208d004..4f9403f3d0cd 100644
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
index fcbd5f71eff2..4850bc64d3fd 100644
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
index da96aaffebc1..738c0d634ea9 100644
--- a/drivers/staging/media/atomisp/pci/sh_css.c
+++ b/drivers/staging/media/atomisp/pci/sh_css.c
@@ -4972,6 +4972,7 @@ static int load_video_binaries(struct ia_css_pipe *pipe)
 						  sizeof(struct ia_css_binary),
 						  GFP_KERNEL);
 		if (!mycs->yuv_scaler_binary) {
+			mycs->num_yuv_scaler = 0;
 			err = -ENOMEM;
 			return err;
 		}
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 252c5ffdd1b6..fc58db60852a 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -85,7 +85,7 @@ void compute_intercept_slope(struct tsens_priv *priv, u32 *p1,
 	for (i = 0; i < priv->num_sensors; i++) {
 		dev_dbg(priv->dev,
 			"%s: sensor%d - data_point1:%#x data_point2:%#x\n",
-			__func__, i, p1[i], p2[i]);
+			__func__, i, p1[i], p2 ? p2[i] : 0);
 
 		if (!priv->sensor[i].slope)
 			priv->sensor[i].slope = SLOPE_DEFAULT;
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index d2daf0a72e34..9997d73d5f56 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -202,16 +202,18 @@ enum gsm_encoding {
 
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
@@ -2259,6 +2261,30 @@ static void gsm_queue(struct gsm_mux *gsm)
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
@@ -2272,26 +2298,27 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
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
@@ -2301,14 +2328,14 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
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
@@ -2319,26 +2346,29 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
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
@@ -2351,6 +2381,29 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
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
@@ -2361,6 +2414,7 @@ static void gsm0_receive(struct gsm_mux *gsm, unsigned char c)
 
 static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
 {
+	gsm1_receive_state_check_and_fix(gsm);
 	/* handle XON/XOFF */
 	if ((c & ISO_IEC_646_MASK) == XON) {
 		gsm->constipated = true;
@@ -2373,11 +2427,11 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
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
@@ -2393,14 +2447,14 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
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
@@ -2421,30 +2475,30 @@ static void gsm1_receive(struct gsm_mux *gsm, unsigned char c)
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
index ffc7f67e27e3..a28f115f6194 100644
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
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index fb1d5ec0940e..295b9ba1b4f3 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -209,15 +209,19 @@ static int mtk8250_startup(struct uart_port *port)
 
 static void mtk8250_shutdown(struct uart_port *port)
 {
-#ifdef CONFIG_SERIAL_8250_DMA
 	struct uart_8250_port *up = up_to_u8250p(port);
 	struct mtk8250_data *data = port->private_data;
+	int irq = data->rx_wakeup_irq;
 
+#ifdef CONFIG_SERIAL_8250_DMA
 	if (up->dma)
 		data->rx_status = DMA_RX_SHUTDOWN;
 #endif
 
-	return serial8250_do_shutdown(port);
+	serial8250_do_shutdown(port);
+
+	if (irq >= 0)
+		serial8250_do_set_mctrl(&up->port, TIOCM_RTS);
 }
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index c69602f356fd..5d8660fed081 100644
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
@@ -739,13 +753,14 @@ static int max3100_probe(struct spi_device *spi)
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
@@ -831,6 +846,7 @@ static void max3100_remove(struct spi_device *spi)
 		}
 	pr_debug("removing max3100 driver\n");
 	uart_unregister_driver(&max3100_uart_driver);
+	uart_driver_registered = 0;
 
 	mutex_unlock(&max3100s_lock);
 }
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index e331b57d6d7d..e6eedebf6776 100644
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
index e67d3a886bf4..08ad5ae41121 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1244,9 +1244,14 @@ static void sci_dma_rx_chan_invalidate(struct sci_port *s)
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
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 948449a13247..5922cb5a1de0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -4074,7 +4074,7 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		 * Make sure UIC command completion interrupt is disabled before
 		 * issuing UIC command.
 		 */
-		wmb();
+		ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 		reenable_intr = true;
 	}
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
@@ -9817,7 +9817,7 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	 * Make sure that UFS interrupts are disabled and any pending interrupt
 	 * status is cleared before registering UFS interrupt handler.
 	 */
-	mb();
+	ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 
 	/* IRQ registration */
 	err = devm_request_irq(dev, irq, ufshcd_intr, IRQF_SHARED, UFSHCD, hba);
diff --git a/drivers/ufs/host/cdns-pltfrm.c b/drivers/ufs/host/cdns-pltfrm.c
index e05c0ae64eea..38a238eaa213 100644
--- a/drivers/ufs/host/cdns-pltfrm.c
+++ b/drivers/ufs/host/cdns-pltfrm.c
@@ -137,7 +137,7 @@ static int cdns_ufs_set_hclkdiv(struct ufs_hba *hba)
 	 * Make sure the register was updated,
 	 * UniPro layer will not work with an incorrect value.
 	 */
-	mb();
+	ufshcd_readl(hba, CDNS_UFS_REG_HCLKDIV);
 
 	return 0;
 }
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 8ad1415e10b6..ecd5939f4c9a 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -226,8 +226,9 @@ static void ufs_qcom_select_unipro_mode(struct ufs_qcom_host *host)
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
@@ -335,7 +336,7 @@ static void ufs_qcom_enable_hw_clk_gating(struct ufs_hba *hba)
 		REG_UFS_CFG2);
 
 	/* Ensure that HW clock gating is enabled before next operations */
-	mb();
+	ufshcd_readl(hba, REG_UFS_CFG2);
 }
 
 static int ufs_qcom_hce_enable_notify(struct ufs_hba *hba,
@@ -432,7 +433,7 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
 		 * make sure above write gets applied before we return from
 		 * this function.
 		 */
-		mb();
+		ufshcd_readl(hba, REG_UFS_SYS1CLK_1US);
 	}
 
 	if (ufs_qcom_cap_qunipro(host))
@@ -498,9 +499,9 @@ static int ufs_qcom_cfg_timers(struct ufs_hba *hba, u32 gear,
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
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 44466a395bb5..24367cee0b3f 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -36,8 +36,10 @@ enum {
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
@@ -75,6 +77,9 @@ enum {
 #define UFS_CNTLR_2_x_x_VEN_REGS_OFFSET(x)	(0x000 + x)
 #define UFS_CNTLR_3_x_x_VEN_REGS_OFFSET(x)	(0x400 + x)
 
+/* bit definitions for REG_UFS_CFG0 register */
+#define QUNIPRO_G4_SEL		BIT(5)
+
 /* bit definitions for REG_UFS_CFG1 register */
 #define QUNIPRO_SEL		0x1
 #define UTP_DBG_RAMS_EN		0x20000
@@ -146,10 +151,10 @@ static inline void ufs_qcom_assert_reset(struct ufs_hba *hba)
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
@@ -158,10 +163,10 @@ static inline void ufs_qcom_deassert_reset(struct ufs_hba *hba)
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
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 4a42574b4a7f..ec1dceb08729 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -57,13 +57,13 @@ struct uac_rtd_params {
 
   /* Volume/Mute controls and their state */
   int fu_id; /* Feature Unit ID */
-  struct snd_kcontrol *snd_kctl_volume;
-  struct snd_kcontrol *snd_kctl_mute;
+  struct snd_ctl_elem_id snd_kctl_volume_id;
+  struct snd_ctl_elem_id snd_kctl_mute_id;
   s16 volume_min, volume_max, volume_res;
   s16 volume;
   int mute;
 
-	struct snd_kcontrol *snd_kctl_rate; /* read-only current rate */
+	struct snd_ctl_elem_id snd_kctl_rate_id; /* read-only current rate */
 	int srate; /* selected samplerate */
 	int active; /* playback/capture running */
 
@@ -494,14 +494,13 @@ static inline void free_ep_fback(struct uac_rtd_params *prm, struct usb_ep *ep)
 static void set_active(struct uac_rtd_params *prm, bool active)
 {
 	// notifying through the Rate ctrl
-	struct snd_kcontrol *kctl = prm->snd_kctl_rate;
 	unsigned long flags;
 
 	spin_lock_irqsave(&prm->lock, flags);
 	if (prm->active != active) {
 		prm->active = active;
 		snd_ctl_notify(prm->uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				&kctl->id);
+				&prm->snd_kctl_rate_id);
 	}
 	spin_unlock_irqrestore(&prm->lock, flags);
 }
@@ -807,7 +806,7 @@ int u_audio_set_volume(struct g_audio *audio_dev, int playback, s16 val)
 
 	if (change)
 		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
-				&prm->snd_kctl_volume->id);
+				&prm->snd_kctl_volume_id);
 
 	return 0;
 }
@@ -856,7 +855,7 @@ int u_audio_set_mute(struct g_audio *audio_dev, int playback, int val)
 
 	if (change)
 		snd_ctl_notify(uac->card, SNDRV_CTL_EVENT_MASK_VALUE,
-			       &prm->snd_kctl_mute->id);
+			       &prm->snd_kctl_mute_id);
 
 	return 0;
 }
@@ -1331,7 +1330,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				goto snd_fail;
-			prm->snd_kctl_mute = kctl;
+			prm->snd_kctl_mute_id = kctl->id;
 			prm->mute = 0;
 		}
 
@@ -1359,7 +1358,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 			err = snd_ctl_add(card, kctl);
 			if (err < 0)
 				goto snd_fail;
-			prm->snd_kctl_volume = kctl;
+			prm->snd_kctl_volume_id = kctl->id;
 			prm->volume = fu->volume_max;
 			prm->volume_max = fu->volume_max;
 			prm->volume_min = fu->volume_min;
@@ -1383,7 +1382,7 @@ int g_audio_setup(struct g_audio *g_audio, const char *pcm_name,
 		err = snd_ctl_add(card, kctl);
 		if (err < 0)
 			goto snd_fail;
-		prm->snd_kctl_rate = kctl;
+		prm->snd_kctl_rate_id = kctl->id;
 	}
 
 	strscpy(card->driver, card_name, sizeof(card->driver));
@@ -1420,6 +1419,8 @@ void g_audio_cleanup(struct g_audio *g_audio)
 		return;
 
 	uac = g_audio->uac;
+	g_audio->uac = NULL;
+
 	card = uac->card;
 	if (card)
 		snd_card_free_when_closed(card);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ff95f1922490..37089d5a7ccc 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2014,8 +2014,8 @@ config FB_COBALT
 	depends on FB && MIPS_COBALT
 
 config FB_SH7760
-	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	tristate "SH7760/SH7763/SH7720/SH7721 LCDC support"
+	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 6d00893d41f4..444c3ca9d4d4 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1576,7 +1576,7 @@ sh_mobile_lcdc_overlay_fb_init(struct sh_mobile_lcdc_overlay *ovl)
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
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index b4ad8d452e9a..8ef49d7be453 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -155,43 +155,83 @@ int acrn_vm_memseg_unmap(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
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
 	pages = vzalloc(array_size(nr_pages, sizeof(*pages)));
 	if (!pages)
 		return -ENOMEM;
@@ -235,12 +275,11 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
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
@@ -257,8 +296,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 	regions_info->regions_num = nr_regions;
 	regions_info->regions_gpa = virt_to_phys(vm_region);
 	user_vm_pa = memmap->user_vm_pa;
-	i = 0;
-	while (i < nr_pages) {
+	for (i = 0; i < nr_pages; i += 1 << order) {
 		u32 region_size;
 
 		page = pages[i];
@@ -274,7 +312,6 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 
 		vm_region++;
 		user_vm_pa += region_size;
-		i += 1 << order;
 	}
 
 	/* Inform the ACRN Hypervisor to set up EPT mappings */
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index a6c86f916dbd..6bfb67d4866c 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -345,8 +345,10 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
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
index 4a20e07fbb69..f00ea1b4e40b 100644
--- a/drivers/watchdog/bd9576_wdt.c
+++ b/drivers/watchdog/bd9576_wdt.c
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
@@ -264,9 +260,6 @@ static int bd9576_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->always_running = device_property_read_bool(dev->parent,
-							 "always-running");
-
 	watchdog_set_drvdata(&priv->wdd, priv);
 
 	priv->wdd.info			= &bd957x_wdt_ident;
@@ -281,9 +274,6 @@ static int bd9576_wdt_probe(struct platform_device *pdev)
 
 	watchdog_stop_on_reboot(&priv->wdd);
 
-	if (priv->always_running)
-		bd9576_wdt_start(&priv->wdd);
-
 	return devm_watchdog_register_device(dev, &priv->wdd);
 }
 
diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 82ac5d19f519..1745d7cafb76 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -191,9 +191,8 @@ static int sa1100dog_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENXIO;
 	reg_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	ret = PTR_ERR_OR_ZERO(reg_base);
-	if (ret)
-		return ret;
+	if (!reg_base)
+		return -ENOMEM;
 
 	clk = clk_get(NULL, "OSTIMER0");
 	if (IS_ERR(clk)) {
diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
index 3205e5d724c8..1a9ded0cddcb 100644
--- a/drivers/xen/xenbus/xenbus_probe.c
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -65,13 +65,17 @@
 #include "xenbus.h"
 
 
-static int xs_init_irq;
+static int xs_init_irq = -1;
 int xen_store_evtchn;
 EXPORT_SYMBOL_GPL(xen_store_evtchn);
 
 struct xenstore_domain_interface *xen_store_interface;
 EXPORT_SYMBOL_GPL(xen_store_interface);
 
+#define XS_INTERFACE_READY \
+	((xen_store_interface != NULL) && \
+	 (xen_store_interface->connection == XENSTORE_CONNECTED))
+
 enum xenstore_init xen_store_domain_type;
 EXPORT_SYMBOL_GPL(xen_store_domain_type);
 
@@ -751,19 +755,19 @@ static void xenbus_probe(void)
 {
 	xenstored_ready = 1;
 
-	if (!xen_store_interface) {
+	if (!xen_store_interface)
 		xen_store_interface = memremap(xen_store_gfn << XEN_PAGE_SHIFT,
 					       XEN_PAGE_SIZE, MEMREMAP_WB);
-		/*
-		 * Now it is safe to free the IRQ used for xenstore late
-		 * initialization. No need to unbind: it is about to be
-		 * bound again from xb_init_comms. Note that calling
-		 * unbind_from_irqhandler now would result in xen_evtchn_close()
-		 * being called and the event channel not being enabled again
-		 * afterwards, resulting in missed event notifications.
-		 */
+	/*
+	 * Now it is safe to free the IRQ used for xenstore late
+	 * initialization. No need to unbind: it is about to be
+	 * bound again from xb_init_comms. Note that calling
+	 * unbind_from_irqhandler now would result in xen_evtchn_close()
+	 * being called and the event channel not being enabled again
+	 * afterwards, resulting in missed event notifications.
+	 */
+	if (xs_init_irq >= 0)
 		free_irq(xs_init_irq, &xb_waitq);
-	}
 
 	/*
 	 * In the HVM case, xenbus_init() deferred its call to
@@ -822,7 +826,7 @@ static int __init xenbus_probe_initcall(void)
 	if (xen_store_domain_type == XS_PV ||
 	    (xen_store_domain_type == XS_HVM &&
 	     !xs_hvm_defer_init_for_callback() &&
-	     xen_store_interface != NULL))
+	     XS_INTERFACE_READY))
 		xenbus_probe();
 
 	/*
@@ -831,7 +835,7 @@ static int __init xenbus_probe_initcall(void)
 	 * started, then probe.  It will be triggered when communication
 	 * starts happening, by waiting on xb_waitq.
 	 */
-	if (xen_store_domain_type == XS_LOCAL || xen_store_interface == NULL) {
+	if (xen_store_domain_type == XS_LOCAL || !XS_INTERFACE_READY) {
 		struct task_struct *probe_task;
 
 		probe_task = kthread_run(xenbus_probe_thread, NULL,
@@ -1014,6 +1018,12 @@ static int __init xenbus_init(void)
 			xen_store_interface =
 				memremap(xen_store_gfn << XEN_PAGE_SHIFT,
 					 XEN_PAGE_SIZE, MEMREMAP_WB);
+			if (!xen_store_interface) {
+				pr_err("%s: cannot map HVM_PARAM_STORE_PFN=%llx\n",
+				       __func__, v);
+				err = -EINVAL;
+				goto out_error;
+			}
 			if (xen_store_interface->connection != XENSTORE_CONNECTED)
 				wait = true;
 		}
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
index eccecd3fac90..7221072f39fa 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -839,6 +839,34 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
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
@@ -847,14 +875,22 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
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
index a843f964332c..71ce3ed5ab6b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5608,8 +5608,73 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
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
@@ -5634,7 +5699,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 
 	trace_ext4_request_blocks(ar);
 	if (sbi->s_mount_state & EXT4_FC_REPLAY)
-		return ext4_mb_new_blocks_simple(handle, ar, errp);
+		return ext4_mb_new_blocks_simple(ar, errp);
 
 	/* Allow to use superuser reservation for quota file */
 	if (ext4_is_quota_file(ar->inode))
@@ -5864,69 +5929,6 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
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
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index bbfb37390723..8b1383223848 100644
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
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 3ec203bbd559..13d877470675 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -797,7 +797,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	 */
 	head = &im->ino_list;
 
-	/* loop for each orphan inode entry and write them in Jornal block */
+	/* loop for each orphan inode entry and write them in journal block */
 	list_for_each_entry(orphan, head, list) {
 		if (!page) {
 			page = f2fs_grab_meta_page(sbi, start_blk++);
@@ -1127,7 +1127,7 @@ int f2fs_sync_dirty_inodes(struct f2fs_sb_info *sbi, enum inode_type type,
 	} else {
 		/*
 		 * We should submit bio, since it exists several
-		 * wribacking dentry pages in the freeing inode.
+		 * writebacking dentry pages in the freeing inode.
 		 */
 		f2fs_submit_merged_write(sbi, DATA);
 		cond_resched();
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index df6dfd7de6d0..84585dba86a5 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1264,7 +1264,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	int i, err;
 	bool quota_inode = IS_NOQUOTA(inode);
 
-	/* we should bypass data pages to proceed the kworkder jobs */
+	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(cc->rpages[0]->mapping, -EIO);
 		goto out_free;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b83b8ac29f43..0b0e3d44e158 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2363,7 +2363,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
-			/* there are remained comressed pages, submit them */
+			/* there are remained compressed pages, submit them */
 			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
 				ret = f2fs_read_multi_pages(&cc, &bio,
 							max_nr_pages,
@@ -2779,7 +2779,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 
 	trace_f2fs_writepage(page, DATA);
 
-	/* we should bypass data pages to proceed the kworkder jobs */
+	/* we should bypass data pages to proceed the kworker jobs */
 	if (unlikely(f2fs_cp_error(sbi))) {
 		mapping_set_error(page->mapping, -EIO);
 		/*
@@ -2898,7 +2898,7 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 redirty_out:
 	redirty_page_for_writepage(wbc, page);
 	/*
-	 * pageout() in MM traslates EAGAIN, so calls handle_write_error()
+	 * pageout() in MM translates EAGAIN, so calls handle_write_error()
 	 * -> mapping_set_error() -> set_bit(AS_EIO, ...).
 	 * file_write_and_wait_range() will see EIO error, which is critical
 	 * to return value of fsync() followed by atomic_write failure to user.
@@ -2932,7 +2932,7 @@ static int f2fs_write_data_page(struct page *page,
 }
 
 /*
- * This function was copied from write_cche_pages from mm/page-writeback.c.
+ * This function was copied from write_cache_pages from mm/page-writeback.c.
  * The major change is making write step of cold data page separately from
  * warm/hot data page.
  */
@@ -4195,7 +4195,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
 		return -EINVAL;
 
-	if (map.m_pblk != NULL_ADDR) {
+	if (map.m_flags & F2FS_MAP_MAPPED) {
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index 16692c96e765..c55359267d43 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -205,7 +205,7 @@ struct rb_node **f2fs_lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
  * @prev_ex: extent before ofs
  * @next_ex: extent after ofs
  * @insert_p: insert point for new extent at ofs
- * in order to simpfy the insertion after.
+ * in order to simplify the insertion after.
  * tree must stay unchanged between lookup and insertion.
  */
 struct rb_entry *f2fs_lookup_rb_tree_ret(struct rb_root_cached *root,
@@ -662,7 +662,7 @@ static void __update_extent_tree_range(struct inode *inode,
 	if (!en)
 		en = next_en;
 
-	/* 2. invlidate all extent nodes in range [fofs, fofs + len - 1] */
+	/* 2. invalidate all extent nodes in range [fofs, fofs + len - 1] */
 	while (en && en->ei.fofs < end) {
 		unsigned int org_end;
 		int parts = 0;	/* # of parts current extent split into */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2fbc8d89c600..1d73582d1f63 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -305,7 +305,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 		 * for OPU case, during fsync(), node can be persisted before
 		 * data when lower device doesn't support write barrier, result
 		 * in data corruption after SPO.
-		 * So for strict fsync mode, force to use atomic write sematics
+		 * So for strict fsync mode, force to use atomic write semantics
 		 * to keep write order in between data/node and last node to
 		 * avoid potential data corruption.
 		 */
@@ -940,9 +940,14 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
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
 
 	err = setattr_prepare(mnt_userns, dentry, attr);
 	if (err)
@@ -1314,6 +1319,9 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
+
+			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
+
 			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
 			set_page_private_gcing(pdst);
@@ -1801,15 +1809,6 @@ static long f2fs_fallocate(struct file *file, int mode,
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
-	/*
-	 * Pinned file should not support partial trucation since the block
-	 * can be used by applications.
-	 */
-	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
-		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
-		return -EOPNOTSUPP;
-
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 			FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
 			FALLOC_FL_INSERT_RANGE))
@@ -1817,6 +1816,17 @@ static long f2fs_fallocate(struct file *file, int mode,
 
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
@@ -1852,7 +1862,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 static int f2fs_release_file(struct inode *inode, struct file *filp)
 {
 	/*
-	 * f2fs_relase_file is called at every close calls. So we should
+	 * f2fs_release_file is called at every close calls. So we should
 	 * not drop any inmemory pages by close called by other process.
 	 */
 	if (!(filp->f_mode & FMODE_WRITE) ||
@@ -2811,7 +2821,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
-	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst) ||
+		f2fs_is_pinned_file(src) || f2fs_is_pinned_file(dst)) {
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
@@ -3465,9 +3476,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3486,7 +3494,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3511,9 +3520,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
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
@@ -3531,6 +3543,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -3584,7 +3598,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 	while (count) {
 		int compr_blocks = 0;
-		blkcnt_t reserved;
+		blkcnt_t reserved = 0;
+		blkcnt_t to_reserved;
 		int ret;
 
 		for (i = 0; i < cluster_size; i++) {
@@ -3604,20 +3619,26 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 			 * fails in release_compress_blocks(), so NEW_ADDR
 			 * is a possible case.
 			 */
-			if (blkaddr == NEW_ADDR ||
-				__is_valid_data_blkaddr(blkaddr)) {
+			if (blkaddr == NEW_ADDR) {
+				reserved++;
+				continue;
+			}
+			if (__is_valid_data_blkaddr(blkaddr)) {
 				compr_blocks++;
 				continue;
 			}
 		}
 
-		reserved = cluster_size - compr_blocks;
+		to_reserved = cluster_size - compr_blocks - reserved;
 
 		/* for the case all blocks in cluster were reserved */
-		if (reserved == 1)
+		if (to_reserved == 1) {
+			dn->ofs_in_node += cluster_size;
 			goto next;
+		}
 
-		ret = inc_valid_block_count(sbi, dn->inode, &reserved, false);
+		ret = inc_valid_block_count(sbi, dn->inode,
+						&to_reserved, false);
 		if (unlikely(ret))
 			return ret;
 
@@ -3628,7 +3649,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
 
-		*reserved_blocks += reserved;
+		*reserved_blocks += to_reserved;
 next:
 		count -= cluster_size;
 	}
@@ -3647,9 +3668,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3661,7 +3679,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto unlock_inode;
 	}
@@ -3678,9 +3697,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
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
@@ -3698,6 +3720,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -4065,9 +4089,6 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4078,7 +4099,8 @@ static int f2fs_ioc_decompress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4137,9 +4159,6 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4150,7 +4169,8 @@ static int f2fs_ioc_compress_file(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d4662ccb94c8..5a661a0e7663 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1566,10 +1566,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			int err;
 
 			inode = f2fs_iget(sb, dni.ino);
-			if (IS_ERR(inode) || is_bad_inode(inode) ||
-					special_file(inode->i_mode))
+			if (IS_ERR(inode))
 				continue;
 
+			if (is_bad_inode(inode) ||
+					special_file(inode->i_mode)) {
+				iput(inode);
+				continue;
+			}
+
 			err = f2fs_gc_pinned_control(inode, gc_type, segno);
 			if (err == -EAGAIN) {
 				iput(inode);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 328cd20b16a5..6dcc73ca3217 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -970,7 +970,7 @@ static int f2fs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 	/*
 	 * If new_inode is null, the below renaming flow will
-	 * add a link in old_dir which can conver inline_dir.
+	 * add a link in old_dir which can convert inline_dir.
 	 * After then, if we failed to get the entry due to other
 	 * reasons like ENOMEM, we had to remove the new entry.
 	 * Instead of adding such the error handling routine, let's
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fcf22a50ff5d..745ecf5523c9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1307,6 +1307,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	}
 	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
 		err = -EFSCORRUPTED;
+		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 		goto fail;
@@ -1333,7 +1334,6 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 	return page;
-
 fail:
 	clear_node_page_dirty(page);
 	f2fs_put_page(page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 205216c1db91..e19b569d938d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3615,7 +3615,7 @@ void f2fs_wait_on_page_writeback(struct page *page,
 
 		/* submit cached LFS IO */
 		f2fs_submit_merged_write_cond(sbi, NULL, page, 0, type);
-		/* sbumit cached IPU IO */
+		/* submit cached IPU IO */
 		f2fs_submit_merged_ipu_write(sbi, NULL, page);
 		if (ordered) {
 			wait_on_page_writeback(page);
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 235a0948f6cc..95353982e643 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -855,11 +855,13 @@ __acquires(&gl->gl_lockref.lock)
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
index 7762483f5f20..91a542b9d81e 100644
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
index 7a6aeffcdf5c..48c69aa60cd1 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -359,7 +359,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
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
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 4974cd18ca46..b363e1bdacda 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -881,7 +881,7 @@ filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 						      NFS4_MAX_UINT64,
 						      IOMODE_READ,
 						      false,
-						      GFP_KERNEL);
+						      nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
@@ -905,7 +905,7 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 						      NFS4_MAX_UINT64,
 						      IOMODE_RW,
 						      false,
-						      GFP_NOFS);
+						      nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 9bcd53d5c7d4..9a5b735e74f9 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1047,9 +1047,12 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
 		ctx->acdirmax	= data->acdirmax;
 		ctx->need_mount	= false;
 
-		memcpy(sap, &data->addr, sizeof(data->addr));
-		ctx->nfs_server.addrlen = sizeof(data->addr);
-		ctx->nfs_server.port = ntohs(data->addr.sin_port);
+		if (!is_remount_fc(fc)) {
+			memcpy(sap, &data->addr, sizeof(data->addr));
+			ctx->nfs_server.addrlen = sizeof(data->addr);
+			ctx->nfs_server.port = ntohs(data->addr.sin_port);
+		}
+
 		if (sap->ss_family != AF_INET ||
 		    !nfs_verify_server_address(sap))
 			goto out_no_address;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 457b2b2f804a..2b19ddc2c39a 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2113,6 +2113,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_fs_locations *locations = NULL;
+	struct nfs_fattr *fattr;
 	struct inode *inode;
 	struct page *page;
 	int status, result;
@@ -2122,19 +2123,16 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
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
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index ef9f9a2511b7..1d4d610bd82b 100644
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
index 0a84613960db..006df4eac9fa 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2207,19 +2207,36 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
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
@@ -2235,7 +2252,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	return err;
 }
 
-static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
+static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
 {
 	struct nilfs_segctor_wait_request *wrq, *n;
 	unsigned long flags;
@@ -2243,7 +2260,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err)
 	spin_lock_irqsave(&sci->sc_wait_request.lock, flags);
 	list_for_each_entry_safe(wrq, n, &sci->sc_wait_request.head, wq.entry) {
 		if (!atomic_read(&wrq->done) &&
-		    nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq)) {
+		    (force || nilfs_cnt32_ge(sci->sc_seq_done, wrq->seq))) {
 			wrq->err = err;
 			atomic_set(&wrq->done, 1);
 		}
@@ -2381,7 +2398,7 @@ static void nilfs_segctor_notify(struct nilfs_sc_info *sci, int mode, int err)
 	if (mode == SC_LSEG_SR) {
 		sci->sc_state &= ~NILFS_SEGCTOR_COMMIT;
 		sci->sc_seq_done = sci->sc_seq_accepted;
-		nilfs_segctor_wakeup(sci, err);
+		nilfs_segctor_wakeup(sci, err, false);
 		sci->sc_flush_request = 0;
 	} else {
 		if (mode == SC_FLUSH_FILE)
@@ -2763,6 +2780,13 @@ static void nilfs_segctor_destroy(struct nilfs_sc_info *sci)
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
index d53ef128fa73..a2d5b2a94d85 100644
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
index eee01db6e0cc..730629235ffa 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1531,6 +1531,11 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
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
@@ -1541,6 +1546,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out1;
 	}
 
+out:
 	*vbn = bit << indx->idx2vbn_bits;
 
 	return 0;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 42dd9fdaf415..2c8c32d9fcaa 100644
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
index a8d4ed7bca02..1351fb02e140 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -485,16 +485,9 @@ bool mi_remove_attr(struct ntfs_inode *ni, struct mft_inode *mi,
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
index 6066eea3f61c..ab0711185b3d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1453,8 +1453,6 @@ static int __init init_ntfs_fs(void)
 {
 	int err;
 
-	pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
-
 	if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
 		pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
 	if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index f0b7f4d51a17..0a2b0b4a8361 100644
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
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 5339ff08bd0f..582d4bd50a1f 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -327,9 +327,6 @@ static int ovl_create_upper(struct dentry *dentry, struct inode *inode,
 	struct dentry *newdentry;
 	int err;
 
-	if (!attr->hardlink && !IS_POSIXACL(udir))
-		attr->mode &= ~current_umask();
-
 	inode_lock_nested(udir, I_MUTEX_PARENT);
 	newdentry = ovl_create_real(ofs, udir,
 				    ovl_lookup_upper(ofs, dentry->d_name.name,
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index a2f0a2edceb8..e0a6b758094f 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -165,8 +165,12 @@ static struct ksmbd_share_config *share_config_request(struct unicode_map *um,
 
 		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
 				      GFP_KERNEL);
-		if (share->path)
+		if (share->path) {
 			share->path_sz = strlen(share->path);
+			while (share->path_sz > 1 &&
+			       share->path[share->path_sz - 1] == '/')
+				share->path[--share->path_sz] = '\0';
+		}
 		share->create_mask = resp->create_mask;
 		share->directory_mask = resp->directory_mask;
 		share->force_create_mode = resp->force_create_mode;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 1b98796499d7..b29e78b517bf 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -613,19 +613,24 @@ static int oplock_break_pending(struct oplock_info *opinfo, int req_op_level)
 		if (opinfo->op_state == OPLOCK_CLOSING)
 			return -ENOENT;
 		else if (opinfo->level <= req_op_level) {
-			if (opinfo->is_lease &&
-			    opinfo->o_lease->state !=
-			     (SMB2_LEASE_HANDLE_CACHING_LE |
-			      SMB2_LEASE_READ_CACHING_LE))
+			if (opinfo->is_lease == false)
+				return 1;
+
+			if (opinfo->o_lease->state !=
+			    (SMB2_LEASE_HANDLE_CACHING_LE |
+			     SMB2_LEASE_READ_CACHING_LE))
 				return 1;
 		}
 	}
 
 	if (opinfo->level <= req_op_level) {
-		if (opinfo->is_lease &&
-		    opinfo->o_lease->state !=
-		     (SMB2_LEASE_HANDLE_CACHING_LE |
-		      SMB2_LEASE_READ_CACHING_LE)) {
+		if (opinfo->is_lease == false) {
+			wake_up_oplock_break(opinfo);
+			return 1;
+		}
+		if (opinfo->o_lease->state !=
+		    (SMB2_LEASE_HANDLE_CACHING_LE |
+		     SMB2_LEASE_READ_CACHING_LE)) {
 			wake_up_oplock_break(opinfo);
 			return 1;
 		}
diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ade9df59e156..59b191de14d6 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -436,9 +436,15 @@ struct drm_dp_aux {
 	 * @is_remote: Is this AUX CH actually using sideband messaging.
 	 */
 	bool is_remote;
+
+	/**
+	 * @powered_down: If true then the remote endpoint is powered down.
+	 */
+	bool powered_down;
 };
 
 int drm_dp_dpcd_probe(struct drm_dp_aux *aux, unsigned int offset);
+void drm_dp_dpcd_set_powered(struct drm_dp_aux *aux, bool powered);
 ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 			 void *buffer, size_t size);
 ssize_t drm_dp_dpcd_write(struct drm_dp_aux *aux, unsigned int offset,
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 31171914990a..66a7e01c6260 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -244,9 +244,9 @@ int mipi_dsi_shutdown_peripheral(struct mipi_dsi_device *dsi);
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3015235d65e3..e4e7b2cfe72a 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -582,8 +582,8 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
 #define OSC_SB_PCLPI_SUPPORT			0x00000080
 #define OSC_SB_OSLPI_SUPPORT			0x00000100
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
-#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00002000
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
+#define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
 #define OSC_SB_PRM_SUPPORT			0x00200000
 
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e067fe..f7f5a783da2a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -80,6 +80,7 @@ __check_bitop_pr(__test_and_set_bit);
 __check_bitop_pr(__test_and_clear_bit);
 __check_bitop_pr(__test_and_change_bit);
 __check_bitop_pr(test_bit);
+__check_bitop_pr(test_bit_acquire);
 
 #undef __check_bitop_pr
 
diff --git a/include/linux/counter.h b/include/linux/counter.h
index b63746637de2..246711b76e54 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -359,7 +359,6 @@ struct counter_ops {
  * @num_counts:		number of Counts specified in @counts
  * @ext:		optional array of Counter device extensions
  * @num_ext:		number of Counter device extensions specified in @ext
- * @priv:		optional private data supplied by driver
  * @dev:		internal device structure
  * @chrdev:		internal character device structure
  * @events_list:	list of current watching Counter events
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
index 9d4d32909340..5fbc05fe70a6 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -36,6 +36,7 @@ struct fpga_region_info {
  * @mgr: FPGA manager
  * @info: FPGA image info
  * @compat_id: FPGA region id for compatibility check.
+ * @ops_owner: module containing the get_bridges function
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -46,6 +47,7 @@ struct fpga_region {
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
 	struct fpga_compat_id *compat_id;
+	struct module *ops_owner;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
@@ -58,12 +60,17 @@ fpga_region_class_find(struct device *start, const void *data,
 
 int fpga_region_program_fpga(struct fpga_region *region);
 
+#define fpga_region_register_full(parent, info) \
+	__fpga_region_register_full(parent, info, THIS_MODULE)
 struct fpga_region *
-fpga_region_register_full(struct device *parent, const struct fpga_region_info *info);
+__fpga_region_register_full(struct device *parent, const struct fpga_region_info *info,
+			    struct module *owner);
 
+#define fpga_region_register(parent, mgr, get_bridges) \
+	__fpga_region_register(parent, mgr, get_bridges, THIS_MODULE)
 struct fpga_region *
-fpga_region_register(struct device *parent, struct fpga_manager *mgr,
-		     int (*get_bridges)(struct fpga_region *));
+__fpga_region_register(struct device *parent, struct fpga_manager *mgr,
+		       int (*get_bridges)(struct fpga_region *), struct module *owner);
 void fpga_region_unregister(struct fpga_region *region);
 
 #endif /* _FPGA_REGION_H */
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 93ec34a94b72..1cae12185cf0 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -850,6 +850,7 @@ struct mlx5_cmd_work_ent {
 	void		       *context;
 	int			idx;
 	struct completion	handling;
+	struct completion	slotted;
 	struct completion	done;
 	struct mlx5_cmd        *cmd;
 	struct work_struct	work;
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 0f512c0aba54..871e7babc288 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _LINUX_NUMA_H
 #define _LINUX_NUMA_H
+#include <linux/init.h>
 #include <linux/types.h>
 
 #ifdef CONFIG_NODES_SHIFT
@@ -22,34 +23,21 @@
 #endif
 
 #ifdef CONFIG_NUMA
-#include <linux/printk.h>
 #include <asm/sparsemem.h>
 
 /* Generic implementation available */
 int numa_map_to_online_node(int node);
 
 #ifndef memory_add_physaddr_to_nid
-static inline int memory_add_physaddr_to_nid(u64 start)
-{
-	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
-			start);
-	return 0;
-}
+int memory_add_physaddr_to_nid(u64 start);
 #endif
+
 #ifndef phys_to_target_node
-static inline int phys_to_target_node(u64 start)
-{
-	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
-			start);
-	return 0;
-}
-#endif
-#ifndef numa_fill_memblks
-static inline int __init numa_fill_memblks(u64 start, u64 end)
-{
-	return NUMA_NO_MEMBLK;
-}
+int phys_to_target_node(u64 start);
 #endif
+
+int numa_fill_memblks(u64 start, u64 end);
+
 #else /* !CONFIG_NUMA */
 static inline int numa_map_to_online_node(int node)
 {
diff --git a/include/linux/printk.h b/include/linux/printk.h
index 8c81806c2e99..b1a12916f036 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -128,7 +128,7 @@ struct va_format {
 #define no_printk(fmt, ...)				\
 ({							\
 	if (0)						\
-		printk(fmt, ##__VA_ARGS__);		\
+		_printk(fmt, ##__VA_ARGS__);		\
 	0;						\
 })
 
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index cecd3b6bebb8..2b5466204888 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2636,15 +2636,26 @@ void *skb_pull_data(struct sk_buff *skb, size_t len);
 
 void *__pskb_pull_tail(struct sk_buff *skb, int delta);
 
-static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
+static inline enum skb_drop_reason
+pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
 {
 	DEBUG_NET_WARN_ON_ONCE(len > INT_MAX);
 
 	if (likely(len <= skb_headlen(skb)))
-		return true;
+		return SKB_NOT_DROPPED_YET;
+
 	if (unlikely(len > skb->len))
-		return false;
-	return __pskb_pull_tail(skb, len - skb_headlen(skb)) != NULL;
+		return SKB_DROP_REASON_PKT_TOO_SMALL;
+
+	if (unlikely(!__pskb_pull_tail(skb, len - skb_headlen(skb))))
+		return SKB_DROP_REASON_NOMEM;
+
+	return SKB_NOT_DROPPED_YET;
+}
+
+static inline bool pskb_may_pull(struct sk_buff *skb, unsigned int len)
+{
+	return pskb_may_pull_reason(skb, len) == SKB_NOT_DROPPED_YET;
 }
 
 static inline void *pskb_pull(struct sk_buff *skb, unsigned int len)
diff --git a/include/media/cec.h b/include/media/cec.h
index 9c007f83569a..ffd17371302c 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -247,6 +247,7 @@ struct cec_adapter {
 	u16 phys_addr;
 	bool needs_hpd;
 	bool is_enabled;
+	bool is_claiming_log_addrs;
 	bool is_configuring;
 	bool must_reconfigure;
 	bool is_configured;
diff --git a/include/net/ax25.h b/include/net/ax25.h
index f8cf3629a419..1d55e8ee08b4 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -216,7 +216,7 @@ typedef struct {
 struct ctl_table;
 
 typedef struct ax25_dev {
-	struct ax25_dev		*next;
+	struct list_head	list;
 
 	struct net_device	*dev;
 	netdevice_tracker	dev_tracker;
@@ -333,7 +333,6 @@ int ax25_addr_size(const ax25_digi *);
 void ax25_digi_invert(const ax25_digi *, ax25_digi *);
 
 /* ax25_dev.c */
-extern ax25_dev *ax25_dev_list;
 extern spinlock_t ax25_dev_lock;
 
 #if IS_ENABLED(CONFIG_AX25)
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 5aaf7d7f3c6f..c7f1dd34ea47 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -383,6 +383,8 @@ int  bt_sock_register(int proto, const struct net_proto_family *ops);
 void bt_sock_unregister(int proto);
 void bt_sock_link(struct bt_sock_list *l, struct sock *s);
 void bt_sock_unlink(struct bt_sock_list *l, struct sock *s);
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern);
 int  bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		     int flags);
 int  bt_sock_stream_recvmsg(struct socket *sock, struct msghdr *msg,
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2f766e3437ce..d46f1335cf9a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -584,6 +584,9 @@ struct l2cap_chan {
 	__u16		tx_credits;
 	__u16		rx_credits;
 
+	/* estimated available receive buffer space or -1 if unknown */
+	ssize_t		rx_avail;
+
 	__u8		tx_state;
 	__u8		rx_state;
 
@@ -724,10 +727,15 @@ struct l2cap_user {
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 
+struct l2cap_rx_busy {
+	struct list_head	list;
+	struct sk_buff		*skb;
+};
+
 struct l2cap_pinfo {
 	struct bt_sock		bt;
 	struct l2cap_chan	*chan;
-	struct sk_buff		*rx_busy_skb;
+	struct list_head	rx_busy;
 };
 
 enum {
@@ -985,6 +993,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 int l2cap_chan_reconfigure(struct l2cap_chan *chan, __u16 mtu);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
 int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
 void l2cap_chan_set_defaults(struct l2cap_chan *chan);
 int l2cap_ertm_init(struct l2cap_chan *chan);
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
diff --git a/include/net/inet_common.h b/include/net/inet_common.h
index 4673bbfd2811..a75333342c4e 100644
--- a/include/net/inet_common.h
+++ b/include/net/inet_common.h
@@ -31,6 +31,8 @@ int inet_dgram_connect(struct socket *sock, struct sockaddr *uaddr,
 		       int addr_len, int flags);
 int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 		bool kern);
+void __inet_accept(struct socket *sock, struct socket *newsock,
+		   struct sock *newsk);
 int inet_send_prepare(struct sock *sk);
 int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size);
 void inet_splice_eof(struct socket *sock);
diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 99bd823e97f6..ddfa2e67fdb5 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -379,6 +379,20 @@ struct sock *__inet_lookup_established(struct net *net,
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
@@ -448,10 +462,6 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 			     refcounted);
 }
 
-u32 inet6_ehashfn(const struct net *net,
-		  const struct in6_addr *laddr, const u16 lport,
-		  const struct in6_addr *faddr, const __be16 fport);
-
 static inline void sk_daddr_set(struct sock *sk, __be32 addr)
 {
 	sk->sk_daddr = addr; /* alias of inet_daddr */
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 43173204d6d5..87a4f334c22a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -885,6 +885,8 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly internally
  *	for sequence number assignment
+ * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
+ *	due to scanning, not in normal operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -905,6 +907,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	= BIT(9),
+	IEEE80211_TX_CTRL_SCAN_TX		= BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		= 0xf0000000,
 };
 
diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
index 1223af68cd9a..990c3767a350 100644
--- a/include/net/netfilter/nf_tables_core.h
+++ b/include/net/netfilter/nf_tables_core.h
@@ -66,16 +66,6 @@ struct nft_payload {
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
index d5d2183730b9..a17688011440 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6730,7 +6730,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 59e6f755f12c..0cafdefce02d 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -275,8 +275,7 @@ static inline int io_run_task_work(void)
 
 static inline bool io_task_work_pending(struct io_ring_ctx *ctx)
 {
-	return test_thread_flag(TIF_NOTIFY_SIGNAL) ||
-		!wq_list_empty(&ctx->work_llist);
+	return task_work_pending(current) || !llist_empty(&ctx->work_llist);
 }
 
 static inline int io_run_task_work_ctx(struct io_ring_ctx *ctx)
diff --git a/io_uring/nop.c b/io_uring/nop.c
index d956599a3c1b..1a4e312dfe51 100644
--- a/io_uring/nop.c
+++ b/io_uring/nop.c
@@ -12,6 +12,8 @@
 
 int io_nop_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
+	if (READ_ONCE(sqe->rw_flags))
+		return -EINVAL;
 	return 0;
 }
 
diff --git a/kernel/Makefile b/kernel/Makefile
index ebc692242b68..c90ee75eb804 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
+obj-$(CONFIG_NUMA) += numa.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 18b3f429abe1..1d851e2f4859 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6492,7 +6492,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -6503,6 +6504,11 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
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
@@ -6598,7 +6604,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -6608,7 +6613,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 79e6a5d4c29a..01f5a019e0f5 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2185,7 +2185,7 @@ bool current_cpuset_is_being_rebound(void)
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
 {
 #ifdef CONFIG_SMP
-	if (val < -1 || val >= sched_domain_level_max)
+	if (val < -1 || val > sched_domain_level_max + 1)
 		return -EINVAL;
 #endif
 
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 0520a8f4fb1d..af661734e8f9 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -101,7 +101,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	struct task_struct **tsk;
 	int threads = map->bparam.threads;
 	int node = map->bparam.node;
-	const cpumask_t *cpu_mask = cpumask_of_node(node);
 	u64 loops;
 	int ret = 0;
 	int i;
@@ -122,7 +121,7 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		}
 
 		if (node != NUMA_NO_NODE)
-			kthread_bind_mask(tsk[i], cpu_mask);
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
 	}
 
 	/* clear the old value in the previous benchmark */
@@ -208,7 +207,8 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		}
 
 		if (map->bparam.node != NUMA_NO_NODE &&
-		    !node_possible(map->bparam.node)) {
+		    (map->bparam.node < 0 || map->bparam.node >= MAX_NUMNODES ||
+		     !node_possible(map->bparam.node))) {
 			pr_err("invalid numa node\n");
 			return -EINVAL;
 		}
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 1ed2b1739363..5ecd072a34fe 100644
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
diff --git a/kernel/numa.c b/kernel/numa.c
new file mode 100644
index 000000000000..67ca6b8585c0
--- /dev/null
+++ b/kernel/numa.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/printk.h>
+#include <linux/numa.h>
+
+/* Stub functions: */
+
+#ifndef memory_add_physaddr_to_nid
+int memory_add_physaddr_to_nid(u64 start)
+{
+	pr_info_once("Unknown online node for memory at 0x%llx, assuming node 0\n",
+			start);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+#endif
+
+#ifndef phys_to_target_node
+int phys_to_target_node(u64 start)
+{
+	pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",
+			start);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(phys_to_target_node);
+#endif
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index b5d5b6cf093a..6f48f565e3ac 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1789,7 +1789,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%lu h:%lu/%lu/%lu",
+	snprintf(buf, sizeof(buf), "N%lu h:%lu/%lu/%lu",
 		data_race(n_trc_holdouts),
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 7d15b5b5a235..11a82404a6ce 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -474,7 +474,8 @@ static void print_cpu_stall_info(int cpu)
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
 	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
 	if (rcuc_starved)
-		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
+		// Print signed value, as negative values indicate a probable bug.
+		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 18a4f8f28a25..d71234729edb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11117,7 +11117,7 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
-	u64 burst = tg_get_cfs_burst(tg);
+	u64 burst = tg->cfs_bandwidth.burst;
 	u64 quota;
 	int ret;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 91c101ecfef9..0de8354d5ad0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6020,22 +6020,42 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
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
 
 	/* Return true only if the utilization doesn't fit CPU's capacity */
 	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
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
@@ -6147,7 +6167,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * and the following generally works well enough in practice.
 	 */
 	if (!task_new)
-		update_overutilized_status(rq);
+		check_update_overutilized_status(rq);
 
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
@@ -9923,19 +9943,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
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
@@ -11849,7 +11864,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 		task_tick_numa(rq, curr);
 
 	update_misfit_status(curr, rq);
-	update_overutilized_status(task_rq(curr));
+	check_update_overutilized_status(task_rq(curr));
 
 	task_tick_core(rq, curr);
 }
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 373d42c707bc..82e2f7fc7c26 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -109,6 +109,7 @@ static void __init housekeeping_setup_type(enum hk_type type,
 static int __init housekeeping_setup(char *str, unsigned long flags)
 {
 	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
+	unsigned int first_cpu;
 	int err = 0;
 
 	if ((flags & HK_FLAG_TICK) && !(housekeeping.flags & HK_FLAG_TICK)) {
@@ -129,7 +130,8 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 	cpumask_andnot(housekeeping_staging,
 		       cpu_possible_mask, non_housekeeping_mask);
 
-	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
+	first_cpu = cpumask_first_and(cpu_present_mask, housekeeping_staging);
+	if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
 		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
 		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
 		if (!housekeeping.flags) {
@@ -138,6 +140,9 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
 		}
 	}
 
+	if (cpumask_empty(non_housekeeping_mask))
+		goto free_housekeeping_staging;
+
 	if (!housekeeping.flags) {
 		/* First setup call ("nohz_full=" or "isolcpus=") */
 		enum hk_type type;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8739c2a5a54e..d404b5d2d842 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1436,7 +1436,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c8a6913c067d..a47396161843 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -525,7 +525,7 @@ static inline bool lockdep_softirq_start(void) { return false; }
 static inline void lockdep_softirq_end(bool in_hardirq) { }
 #endif
 
-asmlinkage __visible void __softirq_entry __do_softirq(void)
+static void handle_softirqs(bool ksirqd)
 {
 	unsigned long end = jiffies + MAX_SOFTIRQ_TIME;
 	unsigned long old_flags = current->flags;
@@ -580,8 +580,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 		pending >>= softirq_bit;
 	}
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
-	    __this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && ksirqd)
 		rcu_softirq_qs();
 
 	local_irq_disable();
@@ -601,6 +600,11 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
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
@@ -931,7 +935,7 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		handle_softirqs(true);
 		ksoftirqd_run_end();
 		cond_resched();
 		return;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 552956ccb91c..e9ce45dce31b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1565,12 +1565,15 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
 unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct dyn_ftrace *rec;
+	unsigned long ip = 0;
 
+	rcu_read_lock();
 	rec = lookup_rec(start, end);
 	if (rec)
-		return rec->ip;
+		ip = rec->ip;
+	rcu_read_unlock();
 
-	return 0;
+	return ip;
 }
 
 /**
@@ -1583,25 +1586,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	struct dyn_ftrace *rec;
+	unsigned long loc;
 	unsigned long offset;
 	unsigned long size;
 
-	rec = lookup_rec(ip, ip);
-	if (!rec) {
+	loc = ftrace_location_range(ip, ip);
+	if (!loc) {
 		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
 			goto out;
 
 		/* map sym+0 to __fentry__ */
 		if (!offset)
-			rec = lookup_rec(ip, ip + size - 1);
+			loc = ftrace_location_range(ip, ip + size - 1);
 	}
 
-	if (rec)
-		return rec->ip;
-
 out:
-	return 0;
+	return loc;
 }
 
 /**
@@ -6784,6 +6784,8 @@ static int ftrace_process_locs(struct module *mod,
 	/* We should have used all pages unless we skipped some */
 	if (pg_unuse) {
 		WARN_ON(!skipped);
+		/* Need to synchronize with ftrace_location_range() */
+		synchronize_rcu();
 		ftrace_free_pages(pg_unuse);
 	}
 	return ret;
@@ -6998,6 +7000,9 @@ void ftrace_release_mod(struct module *mod)
  out_unlock:
 	mutex_unlock(&ftrace_lock);
 
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page)
+		synchronize_rcu();
 	for (pg = tmp_page; pg; pg = tmp_page) {
 
 		/* Needs to be called outside of ftrace_lock */
@@ -7332,6 +7337,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	unsigned long start = (unsigned long)(start_ptr);
 	unsigned long end = (unsigned long)(end_ptr);
 	struct ftrace_page **last_pg = &ftrace_pages_start;
+	struct ftrace_page *tmp_page = NULL;
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
 	struct dyn_ftrace key;
@@ -7375,12 +7381,8 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		ftrace_update_tot_cnt--;
 		if (!pg->index) {
 			*last_pg = pg->next;
-			if (pg->records) {
-				free_pages((unsigned long)pg->records, pg->order);
-				ftrace_number_of_pages -= 1 << pg->order;
-			}
-			ftrace_number_of_groups--;
-			kfree(pg);
+			pg->next = tmp_page;
+			tmp_page = pg;
 			pg = container_of(last_pg, struct ftrace_page, next);
 			if (!(*last_pg))
 				ftrace_pages = pg;
@@ -7397,6 +7399,11 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 		clear_func_from_hashes(func);
 		kfree(func);
 	}
+	/* Need to synchronize with ftrace_location_range() */
+	if (tmp_page) {
+		synchronize_rcu();
+		ftrace_free_pages(tmp_page);
+	}
 }
 
 void __init ftrace_free_init_mem(void)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 337162e0c3d5..0093fc56ab3a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1602,6 +1602,11 @@ static int rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
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
@@ -2323,8 +2328,12 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
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
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 6c97cc2d754a..d0d49b910474 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -245,6 +245,7 @@ static int __rv_disable_monitor(struct rv_monitor_def *mdef, bool sync)
 
 /**
  * rv_disable_monitor - disable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success.
  */
@@ -256,6 +257,7 @@ int rv_disable_monitor(struct rv_monitor_def *mdef)
 
 /**
  * rv_enable_monitor - enable a given runtime monitor
+ * @mdef: Pointer to the monitor definition structure.
  *
  * Returns 0 on success, error otherwise.
  */
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index f7825991d576..d9d1df28cc52 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -11,6 +11,7 @@
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
+#include <linux/sched/task.h>
 
 #include "try-catch-impl.h"
 
@@ -65,13 +66,14 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	try_catch->context = context;
 	try_catch->try_completion = &try_completion;
 	try_catch->try_result = 0;
-	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
-				  try_catch,
-				  "kunit_try_catch_thread");
+	task_struct = kthread_create(kunit_generic_run_threadfn_adapter,
+				     try_catch, "kunit_try_catch_thread");
 	if (IS_ERR(task_struct)) {
 		try_catch->catch(try_catch->context);
 		return;
 	}
+	get_task_struct(task_struct);
+	wake_up_process(task_struct);
 
 	time_remaining = wait_for_completion_timeout(&try_completion,
 						     kunit_test_timeout());
@@ -81,6 +83,7 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 		kthread_stop(task_struct);
 	}
 
+	put_task_struct(task_struct);
 	exit_code = try_catch->try_result;
 
 	if (!exit_code)
diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
index 7a0564d7cb7a..9384747d90e5 100644
--- a/lib/slub_kunit.c
+++ b/lib/slub_kunit.c
@@ -39,7 +39,7 @@ static void test_next_pointer(struct kunit *test)
 
 	ptr_addr = (unsigned long *)(p + s->offset);
 	tmp = *ptr_addr;
-	p[s->offset] = 0x12;
+	p[s->offset] = ~p[s->offset];
 
 	/*
 	 * Expecting three errors.
diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 67e6f83fe0f8..be50a1fdba70 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1232,8 +1232,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	unsigned long *src_pfns;
 	unsigned long *dst_pfns;
 
-	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
-	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
+	src_pfns = kvcalloc(npages, sizeof(*src_pfns), GFP_KERNEL | __GFP_NOFAIL);
+	dst_pfns = kvcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL | __GFP_NOFAIL);
 
 	migrate_device_range(src_pfns, start_pfn, npages);
 	for (i = 0; i < npages; i++) {
@@ -1256,8 +1256,8 @@ static void dmirror_device_evict_chunk(struct dmirror_chunk *chunk)
 	}
 	migrate_device_pages(src_pfns, dst_pfns, npages);
 	migrate_device_finalize(src_pfns, dst_pfns, npages);
-	kfree(src_pfns);
-	kfree(dst_pfns);
+	kvfree(src_pfns);
+	kvfree(dst_pfns);
 }
 
 /* Removes free pages from the free list so they can't be re-allocated */
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index c5462486dbca..fcc64645bbf5 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -22,11 +22,12 @@
 #include <net/sock.h>
 #include <linux/uaccess.h>
 #include <linux/fcntl.h>
+#include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 
-ax25_dev *ax25_dev_list;
+static LIST_HEAD(ax25_dev_list);
 DEFINE_SPINLOCK(ax25_dev_lock);
 
 ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
@@ -34,10 +35,11 @@ ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
 	ax25_dev *ax25_dev, *res = NULL;
 
 	spin_lock_bh(&ax25_dev_lock);
-	for (ax25_dev = ax25_dev_list; ax25_dev != NULL; ax25_dev = ax25_dev->next)
+	list_for_each_entry(ax25_dev, &ax25_dev_list, list)
 		if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
 			res = ax25_dev;
 			ax25_dev_hold(ax25_dev);
+			break;
 		}
 	spin_unlock_bh(&ax25_dev_lock);
 
@@ -59,7 +61,6 @@ void ax25_dev_device_up(struct net_device *dev)
 	}
 
 	refcount_set(&ax25_dev->refcount, 1);
-	dev->ax25_ptr     = ax25_dev;
 	ax25_dev->dev     = dev;
 	netdev_hold(dev, &ax25_dev->dev_tracker, GFP_KERNEL);
 	ax25_dev->forward = NULL;
@@ -85,10 +86,9 @@ void ax25_dev_device_up(struct net_device *dev)
 #endif
 
 	spin_lock_bh(&ax25_dev_lock);
-	ax25_dev->next = ax25_dev_list;
-	ax25_dev_list  = ax25_dev;
+	list_add(&ax25_dev->list, &ax25_dev_list);
+	dev->ax25_ptr     = ax25_dev;
 	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_hold(ax25_dev);
 
 	ax25_register_dev_sysctl(ax25_dev);
 }
@@ -111,32 +111,19 @@ void ax25_dev_device_down(struct net_device *dev)
 	/*
 	 *	Remove any packet forwarding that points to this device.
 	 */
-	for (s = ax25_dev_list; s != NULL; s = s->next)
+	list_for_each_entry(s, &ax25_dev_list, list)
 		if (s->forward == dev)
 			s->forward = NULL;
 
-	if ((s = ax25_dev_list) == ax25_dev) {
-		ax25_dev_list = s->next;
-		goto unlock_put;
-	}
-
-	while (s != NULL && s->next != NULL) {
-		if (s->next == ax25_dev) {
-			s->next = ax25_dev->next;
-			goto unlock_put;
+	list_for_each_entry(s, &ax25_dev_list, list) {
+		if (s == ax25_dev) {
+			list_del(&s->list);
+			break;
 		}
-
-		s = s->next;
 	}
-	spin_unlock_bh(&ax25_dev_lock);
-	dev->ax25_ptr = NULL;
-	ax25_dev_put(ax25_dev);
-	return;
 
-unlock_put:
-	spin_unlock_bh(&ax25_dev_lock);
-	ax25_dev_put(ax25_dev);
 	dev->ax25_ptr = NULL;
+	spin_unlock_bh(&ax25_dev_lock);
 	netdev_put(dev, &ax25_dev->dev_tracker);
 	ax25_dev_put(ax25_dev);
 }
@@ -200,16 +187,13 @@ struct net_device *ax25_fwd_dev(struct net_device *dev)
  */
 void __exit ax25_dev_free(void)
 {
-	ax25_dev *s, *ax25_dev;
+	ax25_dev *s, *n;
 
 	spin_lock_bh(&ax25_dev_lock);
-	ax25_dev = ax25_dev_list;
-	while (ax25_dev != NULL) {
-		s        = ax25_dev;
-		netdev_put(ax25_dev->dev, &ax25_dev->dev_tracker);
-		ax25_dev = ax25_dev->next;
+	list_for_each_entry_safe(s, n, &ax25_dev_list, list) {
+		netdev_put(s->dev, &s->dev_tracker);
+		list_del(&s->list);
 		kfree(s);
 	}
-	ax25_dev_list = NULL;
 	spin_unlock_bh(&ax25_dev_lock);
 }
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 3f9ff02baafe..b8b31b79904a 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -140,6 +140,27 @@ static int bt_sock_create(struct net *net, struct socket *sock, int proto,
 	return err;
 }
 
+struct sock *bt_sock_alloc(struct net *net, struct socket *sock,
+			   struct proto *prot, int proto, gfp_t prio, int kern)
+{
+	struct sock *sk;
+
+	sk = sk_alloc(net, PF_BLUETOOTH, prio, prot, kern);
+	if (!sk)
+		return NULL;
+
+	sock_init_data(sock, sk);
+	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
+
+	sock_reset_flag(sk, SOCK_ZAPPED);
+
+	sk->sk_protocol = proto;
+	sk->sk_state    = BT_OPEN;
+
+	return sk;
+}
+EXPORT_SYMBOL(bt_sock_alloc);
+
 void bt_sock_link(struct bt_sock_list *l, struct sock *sk)
 {
 	write_lock(&l->lock);
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
index 57d509d77cb4..00d47bcf4d7d 100644
--- a/net/bluetooth/bnep/sock.c
+++ b/net/bluetooth/bnep/sock.c
@@ -205,21 +205,13 @@ static int bnep_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (sock->type != SOCK_RAW)
 		return -ESOCKTNOSUPPORT;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &bnep_proto, kern);
+	sk = bt_sock_alloc(net, sock, &bnep_proto, protocol, GFP_ATOMIC, kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
 	sock->ops = &bnep_sock_ops;
-
 	sock->state = SS_UNCONNECTED;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-	sk->sk_state	= BT_OPEN;
-
 	bt_sock_link(&bnep_sk_list, sk);
 	return 0;
 }
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 484fc2a8e4ba..730e569cae36 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -2144,18 +2144,12 @@ static int hci_sock_create(struct net *net, struct socket *sock, int protocol,
 
 	sock->ops = &hci_sock_ops;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, GFP_ATOMIC, &hci_sk_proto, kern);
+	sk = bt_sock_alloc(net, sock, &hci_sk_proto, protocol, GFP_ATOMIC,
+			   kern);
 	if (!sk)
 		return -ENOMEM;
 
-	sock_init_data(sock, sk);
-
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = protocol;
-
 	sock->state = SS_UNCONNECTED;
-	sk->sk_state = BT_OPEN;
 	sk->sk_destruct = hci_sock_destruct;
 
 	bt_sock_link(&hci_sk_list, sk);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 91e990accbf2..5fe1008799ab 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -695,21 +695,13 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &iso_proto, kern);
+	sk = bt_sock_alloc(net, sock, &iso_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = iso_sock_destruct;
 	sk->sk_sndtimeo = ISO_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	/* Set address type as public as default src address is BDADDR_ANY */
 	iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c34011113d4c..5f9a599baa34 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -477,6 +477,9 @@ struct l2cap_chan *l2cap_chan_create(void)
 	/* Set default lock nesting level */
 	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
 
+	/* Available receive buffer space is initially unknown */
+	chan->rx_avail = -1;
+
 	write_lock(&chan_list_lock);
 	list_add(&chan->global_l, &chan_list);
 	write_unlock(&chan_list_lock);
@@ -558,6 +561,28 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan)
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_set_defaults);
 
+static __u16 l2cap_le_rx_credits(struct l2cap_chan *chan)
+{
+	size_t sdu_len = chan->sdu ? chan->sdu->len : 0;
+
+	if (chan->mps == 0)
+		return 0;
+
+	/* If we don't know the available space in the receiver buffer, give
+	 * enough credits for a full packet.
+	 */
+	if (chan->rx_avail == -1)
+		return (chan->imtu / chan->mps) + 1;
+
+	/* If we know how much space is available in the receive buffer, give
+	 * out as many credits as would fill the buffer.
+	 */
+	if (chan->rx_avail <= sdu_len)
+		return 0;
+
+	return DIV_ROUND_UP(chan->rx_avail - sdu_len, chan->mps);
+}
+
 static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 {
 	chan->sdu = NULL;
@@ -566,8 +591,7 @@ static void l2cap_le_flowctl_init(struct l2cap_chan *chan, u16 tx_credits)
 	chan->tx_credits = tx_credits;
 	/* Derive MPS from connection MTU to stop HCI fragmentation */
 	chan->mps = min_t(u16, chan->imtu, chan->conn->mtu - L2CAP_HDR_SIZE);
-	/* Give enough credits for a full packet */
-	chan->rx_credits = (chan->imtu / chan->mps) + 1;
+	chan->rx_credits = l2cap_le_rx_credits(chan);
 
 	skb_queue_head_init(&chan->tx_q);
 }
@@ -579,7 +603,7 @@ static void l2cap_ecred_init(struct l2cap_chan *chan, u16 tx_credits)
 	/* L2CAP implementations shall support a minimum MPS of 64 octets */
 	if (chan->mps < L2CAP_ECRED_MIN_MPS) {
 		chan->mps = L2CAP_ECRED_MIN_MPS;
-		chan->rx_credits = (chan->imtu / chan->mps) + 1;
+		chan->rx_credits = l2cap_le_rx_credits(chan);
 	}
 }
 
@@ -7529,9 +7553,7 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 {
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_le_credits pkt;
-	u16 return_credits;
-
-	return_credits = (chan->imtu / chan->mps) + 1;
+	u16 return_credits = l2cap_le_rx_credits(chan);
 
 	if (chan->rx_credits >= return_credits)
 		return;
@@ -7550,6 +7572,19 @@ static void l2cap_chan_le_send_credits(struct l2cap_chan *chan)
 	l2cap_send_cmd(conn, chan->ident, L2CAP_LE_CREDITS, sizeof(pkt), &pkt);
 }
 
+void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail)
+{
+	if (chan->rx_avail == rx_avail)
+		return;
+
+	BT_DBG("chan %p has %zd bytes avail for rx", chan, rx_avail);
+
+	chan->rx_avail = rx_avail;
+
+	if (chan->state == BT_CONNECTED)
+		l2cap_chan_le_send_credits(chan);
+}
+
 static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	int err;
@@ -7559,6 +7594,12 @@ static int l2cap_ecred_recv(struct l2cap_chan *chan, struct sk_buff *skb)
 	/* Wait recv to confirm reception before updating the credits */
 	err = chan->ops->recv(chan, skb);
 
+	if (err < 0 && chan->rx_avail != -1) {
+		BT_ERR("Queueing received LE L2CAP data failed");
+		l2cap_send_disconn_req(chan, ECONNRESET);
+		return err;
+	}
+
 	/* Update credits whenever an SDU is received */
 	l2cap_chan_le_send_credits(chan);
 
@@ -7581,7 +7622,8 @@ static int l2cap_ecred_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 	}
 
 	chan->rx_credits--;
-	BT_DBG("rx_credits %u -> %u", chan->rx_credits + 1, chan->rx_credits);
+	BT_DBG("chan %p: rx_credits %u -> %u",
+	       chan, chan->rx_credits + 1, chan->rx_credits);
 
 	/* Update if remote had run out of credits, this should only happens
 	 * if the remote is not using the entire MPS.
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index e3c7029ec8a6..af6d4e3b8c06 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1165,6 +1165,34 @@ static int l2cap_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	return err;
 }
 
+static void l2cap_publish_rx_avail(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+	ssize_t avail = sk->sk_rcvbuf - atomic_read(&sk->sk_rmem_alloc);
+	int expected_skbs, skb_overhead;
+
+	if (avail <= 0) {
+		l2cap_chan_rx_avail(chan, 0);
+		return;
+	}
+
+	if (!chan->mps) {
+		l2cap_chan_rx_avail(chan, -1);
+		return;
+	}
+
+	/* Correct available memory by estimated sk_buff overhead.
+	 * This is significant due to small transfer sizes. However, accept
+	 * at least one full packet if receive space is non-zero.
+	 */
+	expected_skbs = DIV_ROUND_UP(avail, chan->mps);
+	skb_overhead = expected_skbs * sizeof(struct sk_buff);
+	if (skb_overhead < avail)
+		l2cap_chan_rx_avail(chan, avail - skb_overhead);
+	else
+		l2cap_chan_rx_avail(chan, -1);
+}
+
 static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			      size_t len, int flags)
 {
@@ -1201,28 +1229,33 @@ static int l2cap_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	else
 		err = bt_sock_recvmsg(sock, msg, len, flags);
 
-	if (pi->chan->mode != L2CAP_MODE_ERTM)
+	if (pi->chan->mode != L2CAP_MODE_ERTM &&
+	    pi->chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    pi->chan->mode != L2CAP_MODE_EXT_FLOWCTL)
 		return err;
 
-	/* Attempt to put pending rx data in the socket buffer */
-
 	lock_sock(sk);
 
-	if (!test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state))
-		goto done;
+	l2cap_publish_rx_avail(pi->chan);
 
-	if (pi->rx_busy_skb) {
-		if (!__sock_queue_rcv_skb(sk, pi->rx_busy_skb))
-			pi->rx_busy_skb = NULL;
-		else
+	/* Attempt to put pending rx data in the socket buffer */
+	while (!list_empty(&pi->rx_busy)) {
+		struct l2cap_rx_busy *rx_busy =
+			list_first_entry(&pi->rx_busy,
+					 struct l2cap_rx_busy,
+					 list);
+		if (__sock_queue_rcv_skb(sk, rx_busy->skb) < 0)
 			goto done;
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	/* Restore data flow when half of the receive buffer is
 	 * available.  This avoids resending large numbers of
 	 * frames.
 	 */
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
+	if (test_bit(CONN_LOCAL_BUSY, &pi->chan->conn_state) &&
+	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf >> 1)
 		l2cap_chan_busy(pi->chan, 0);
 
 done:
@@ -1483,17 +1516,20 @@ static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct sock *sk = chan->data;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	int err;
 
 	lock_sock(sk);
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
+	if (chan->mode == L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
 		err = -ENOMEM;
 		goto done;
 	}
 
 	if (chan->mode != L2CAP_MODE_ERTM &&
-	    chan->mode != L2CAP_MODE_STREAMING) {
+	    chan->mode != L2CAP_MODE_STREAMING &&
+	    chan->mode != L2CAP_MODE_LE_FLOWCTL &&
+	    chan->mode != L2CAP_MODE_EXT_FLOWCTL) {
 		/* Even if no filter is attached, we could potentially
 		 * get errors from security modules, etc.
 		 */
@@ -1504,7 +1540,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 	err = __sock_queue_rcv_skb(sk, skb);
 
-	/* For ERTM, handle one skb that doesn't fit into the recv
+	l2cap_publish_rx_avail(chan);
+
+	/* For ERTM and LE, handle a skb that doesn't fit into the recv
 	 * buffer.  This is important to do because the data frames
 	 * have already been acked, so the skb cannot be discarded.
 	 *
@@ -1513,8 +1551,18 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	 * acked and reassembled until there is buffer space
 	 * available.
 	 */
-	if (err < 0 && chan->mode == L2CAP_MODE_ERTM) {
-		l2cap_pi(sk)->rx_busy_skb = skb;
+	if (err < 0 &&
+	    (chan->mode == L2CAP_MODE_ERTM ||
+	     chan->mode == L2CAP_MODE_LE_FLOWCTL ||
+	     chan->mode == L2CAP_MODE_EXT_FLOWCTL)) {
+		struct l2cap_rx_busy *rx_busy =
+			kmalloc(sizeof(*rx_busy), GFP_KERNEL);
+		if (!rx_busy) {
+			err = -ENOMEM;
+			goto done;
+		}
+		rx_busy->skb = skb;
+		list_add_tail(&rx_busy->list, &pi->rx_busy);
 		l2cap_chan_busy(chan, 1);
 		err = 0;
 	}
@@ -1740,6 +1788,8 @@ static const struct l2cap_ops l2cap_chan_ops = {
 
 static void l2cap_sock_destruct(struct sock *sk)
 {
+	struct l2cap_rx_busy *rx_busy, *next;
+
 	BT_DBG("sk %p", sk);
 
 	if (l2cap_pi(sk)->chan) {
@@ -1747,9 +1797,10 @@ static void l2cap_sock_destruct(struct sock *sk)
 		l2cap_chan_put(l2cap_pi(sk)->chan);
 	}
 
-	if (l2cap_pi(sk)->rx_busy_skb) {
-		kfree_skb(l2cap_pi(sk)->rx_busy_skb);
-		l2cap_pi(sk)->rx_busy_skb = NULL;
+	list_for_each_entry_safe(rx_busy, next, &l2cap_pi(sk)->rx_busy, list) {
+		kfree_skb(rx_busy->skb);
+		list_del(&rx_busy->list);
+		kfree(rx_busy);
 	}
 
 	skb_queue_purge(&sk->sk_receive_queue);
@@ -1833,6 +1884,8 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 
 	chan->data = sk;
 	chan->ops = &l2cap_chan_ops;
+
+	l2cap_publish_rx_avail(chan);
 }
 
 static struct proto l2cap_proto = {
@@ -1847,20 +1900,14 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 	struct sock *sk;
 	struct l2cap_chan *chan;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &l2cap_proto, kern);
+	sk = bt_sock_alloc(net, sock, &l2cap_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = l2cap_sock_destruct;
 	sk->sk_sndtimeo = L2CAP_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state = BT_OPEN;
+	INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
 
 	chan = l2cap_chan_create();
 	if (!chan) {
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 4397e14ff560..b54e8a530f55 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -268,18 +268,16 @@ static struct proto rfcomm_proto = {
 	.obj_size	= sizeof(struct rfcomm_pinfo)
 };
 
-static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int proto, gfp_t prio, int kern)
+static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock,
+				      int proto, gfp_t prio, int kern)
 {
 	struct rfcomm_dlc *d;
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &rfcomm_proto, kern);
+	sk = bt_sock_alloc(net, sock, &rfcomm_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	d = rfcomm_dlc_alloc(prio);
 	if (!d) {
 		sk_free(sk);
@@ -298,11 +296,6 @@ static struct sock *rfcomm_sock_alloc(struct net *net, struct socket *sock, int
 	sk->sk_sndbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 	sk->sk_rcvbuf = RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	bt_sock_link(&rfcomm_sk_list, sk);
 
 	BT_DBG("sk %p", sk);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 301cf802d32c..a3bbe04b1138 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -484,21 +484,13 @@ static struct sock *sco_sock_alloc(struct net *net, struct socket *sock,
 {
 	struct sock *sk;
 
-	sk = sk_alloc(net, PF_BLUETOOTH, prio, &sco_proto, kern);
+	sk = bt_sock_alloc(net, sock, &sco_proto, proto, prio, kern);
 	if (!sk)
 		return NULL;
 
-	sock_init_data(sock, sk);
-	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
-
 	sk->sk_destruct = sco_sock_destruct;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
-	sock_reset_flag(sk, SOCK_ZAPPED);
-
-	sk->sk_protocol = proto;
-	sk->sk_state    = BT_OPEN;
-
 	sco_pi(sk)->setting = BT_VOICE_CVSD_16BIT;
 	sco_pi(sk)->codec.id = BT_CODEC_CVSD;
 	sco_pi(sk)->codec.cid = 0xffff;
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index b82906fc999a..036ae99d0984 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -27,6 +27,7 @@ EXPORT_SYMBOL_GPL(nf_br_ops);
 /* net device transmit always called with BH disabled */
 netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	enum skb_drop_reason reason = pskb_may_pull_reason(skb, ETH_HLEN);
 	struct net_bridge_mcast_port *pmctx_null = NULL;
 	struct net_bridge *br = netdev_priv(dev);
 	struct net_bridge_mcast *brmctx = &br->multicast_ctx;
@@ -38,6 +39,11 @@ netdev_tx_t br_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	const unsigned char *dest;
 	u16 vid = 0;
 
+	if (unlikely(reason != SKB_NOT_DROPPED_YET)) {
+		kfree_skb_reason(skb, reason);
+		return NETDEV_TX_OK;
+	}
+
 	memset(skb->cb, 0, sizeof(struct br_input_skb_cb));
 
 	rcu_read_lock();
diff --git a/net/bridge/br_mst.c b/net/bridge/br_mst.c
index ee680adcee17..3c66141d34d6 100644
--- a/net/bridge/br_mst.c
+++ b/net/bridge/br_mst.c
@@ -78,7 +78,7 @@ static void br_mst_vlan_set_state(struct net_bridge_port *p, struct net_bridge_v
 {
 	struct net_bridge_vlan_group *vg = nbp_vlan_group(p);
 
-	if (v->state == state)
+	if (br_vlan_get_state(v) == state)
 		return;
 
 	br_vlan_set_state(v, state);
@@ -100,11 +100,12 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	};
 	struct net_bridge_vlan_group *vg;
 	struct net_bridge_vlan *v;
-	int err;
+	int err = 0;
 
+	rcu_read_lock();
 	vg = nbp_vlan_group(p);
 	if (!vg)
-		return 0;
+		goto out;
 
 	/* MSTI 0 (CST) state changes are notified via the regular
 	 * SWITCHDEV_ATTR_ID_PORT_STP_STATE.
@@ -112,17 +113,20 @@ int br_mst_set_state(struct net_bridge_port *p, u16 msti, u8 state,
 	if (msti) {
 		err = switchdev_port_attr_set(p->dev, &attr, extack);
 		if (err && err != -EOPNOTSUPP)
-			return err;
+			goto out;
 	}
 
-	list_for_each_entry(v, &vg->vlan_list, vlist) {
+	err = 0;
+	list_for_each_entry_rcu(v, &vg->vlan_list, vlist) {
 		if (v->brvlan->msti != msti)
 			continue;
 
 		br_mst_vlan_set_state(p, v, state);
 	}
 
-	return 0;
+out:
+	rcu_read_unlock();
+	return err;
 }
 
 static void br_mst_vlan_sync_state(struct net_bridge_vlan *pv, u16 msti)
diff --git a/net/core/dev.c b/net/core/dev.c
index 65284eeec7de..20d8b9195ef6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10300,8 +10300,9 @@ static struct net_device *netdev_wait_allrefs_any(struct list_head *list)
 			rebroadcast_time = jiffies;
 		}
 
+		rcu_barrier();
+
 		if (!wait) {
-			rcu_barrier();
 			wait = WAIT_REFS_MIN_MSECS;
 		} else {
 			msleep(wait);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 9408dc3bb42d..cc013be9b02c 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -744,6 +744,22 @@ int inet_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 }
 EXPORT_SYMBOL(inet_stream_connect);
 
+void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *newsk)
+{
+	sock_rps_record_flow(newsk);
+	WARN_ON(!((1 << newsk->sk_state) &
+		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
+		   TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
+		   TCPF_CLOSING | TCPF_CLOSE_WAIT |
+		   TCPF_CLOSE)));
+
+	if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
+		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
+	sock_graft(newsk, newsock);
+
+	newsock->state = SS_CONNECTED;
+}
+
 /*
  *	Accept a pending connection. The TCP layer now gives BSD semantics.
  */
@@ -757,24 +773,12 @@ int inet_accept(struct socket *sock, struct socket *newsock, int flags,
 	/* IPV6_ADDRFORM can change sk->sk_prot under us. */
 	sk2 = READ_ONCE(sk1->sk_prot)->accept(sk1, flags, &err, kern);
 	if (!sk2)
-		goto do_err;
+		return err;
 
 	lock_sock(sk2);
-
-	sock_rps_record_flow(sk2);
-	WARN_ON(!((1 << sk2->sk_state) &
-		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
-		  TCPF_CLOSE_WAIT | TCPF_CLOSE)));
-
-	if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
-		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
-	sock_graft(sk2, newsock);
-
-	newsock->state = SS_CONNECTED;
-	err = 0;
+	__inet_accept(sock, newsock, sk2);
 	release_sock(sk2);
-do_err:
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(inet_accept);
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 0ad25e6783ac..321f509f2347 100644
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
@@ -338,20 +339,25 @@ static inline int compute_score(struct sock *sk, struct net *net,
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
@@ -375,8 +381,8 @@ static struct sock *inet_lhash2_lookup(struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet_lookup_reuseport(net, sk, skb, doff,
+						       saddr, sport, daddr, hnum, inet_ehashfn);
 			if (result)
 				return result;
 
@@ -405,7 +411,8 @@ static inline struct sock *inet_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum,
+					 inet_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv4/netfilter/nf_tproxy_ipv4.c b/net/ipv4/netfilter/nf_tproxy_ipv4.c
index 69e331799604..73e66a088e25 100644
--- a/net/ipv4/netfilter/nf_tproxy_ipv4.c
+++ b/net/ipv4/netfilter/nf_tproxy_ipv4.c
@@ -58,6 +58,8 @@ __be32 nf_tproxy_laddr4(struct sk_buff *skb, __be32 user_laddr, __be32 daddr)
 
 	laddr = 0;
 	indev = __in_dev_get_rcu(skb->dev);
+	if (!indev)
+		return daddr;
 
 	in_dev_for_each_ifa_rcu(ifa, indev) {
 		if (ifa->ifa_flags & IFA_F_SECONDARY)
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 2a6c0dd665a4..863aab186055 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -57,7 +57,18 @@ struct dctcp {
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
index 5dcb969cb5e9..befa848fb820 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1771,7 +1771,7 @@ int tcp_v4_early_demux(struct sk_buff *skb)
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		     enum skb_drop_reason *reason)
 {
-	u32 limit, tail_gso_size, tail_gso_segs;
+	u32 tail_gso_size, tail_gso_segs;
 	struct skb_shared_info *shinfo;
 	const struct tcphdr *th;
 	struct tcphdr *thtail;
@@ -1780,6 +1780,7 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	bool fragstolen;
 	u32 gso_segs;
 	u32 gso_size;
+	u64 limit;
 	int delta;
 
 	/* In case all data was pulled from skb frags (in __pskb_pull_tail()),
@@ -1877,7 +1878,13 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
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
@@ -1885,6 +1892,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	 */
 	limit += 64 * 1024;
 
+	limit = min_t(u64, limit, UINT_MAX);
+
 	if (unlikely(sk_add_backlog(sk, skb, limit))) {
 		bh_unlock_sock(sk);
 		*reason = SKB_DROP_REASON_SOCKET_BACKLOG;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 39fae7581d35..b8f93c1479ae 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -400,9 +400,9 @@ static int compute_score(struct sock *sk, struct net *net,
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
 
@@ -412,22 +412,6 @@ static u32 udp_ehashfn(const struct net *net, const __be32 laddr,
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
@@ -438,15 +422,28 @@ static struct sock *udp4_lib_lookup2(struct net *net,
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
@@ -460,9 +457,14 @@ static struct sock *udp4_lib_lookup2(struct net *net,
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
@@ -485,7 +487,8 @@ static struct sock *udp4_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					 saddr, sport, daddr, hnum, udp_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index b64b49012655..3616225c89ef 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -39,6 +39,7 @@ u32 inet6_ehashfn(const struct net *net,
 	return __inet6_ehashfn(lhash, lport, fhash, fport,
 			       inet6_ehash_secret + net_hash_mix(net));
 }
+EXPORT_SYMBOL_GPL(inet6_ehashfn);
 
 /*
  * Sockets in TCP_CLOSE state are _always_ taken out of the hash, so
@@ -111,22 +112,27 @@ static inline int compute_score(struct sock *sk, struct net *net,
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
@@ -143,8 +149,8 @@ static struct sock *inet6_lhash2_lookup(struct net *net,
 	sk_nulls_for_each_rcu(sk, node, &ilb2->nulls_head) {
 		score = compute_score(sk, net, hnum, daddr, dif, sdif);
 		if (score > hiscore) {
-			result = lookup_reuseport(net, sk, skb, doff,
-						  saddr, sport, daddr, hnum);
+			result = inet6_lookup_reuseport(net, sk, skb, doff,
+							saddr, sport, daddr, hnum, inet6_ehashfn);
 			if (result)
 				return result;
 
@@ -175,7 +181,8 @@ static inline struct sock *inet6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, doff, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, doff,
+					  saddr, sport, daddr, hnum, inet6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index ff866f2a879e..32ba4417eb1d 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -364,7 +364,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	 * the source of the fragment, with the Pointer field set to zero.
 	 */
 	nexthdr = hdr->nexthdr;
-	if (ipv6frag_thdr_truncated(skb, skb_transport_offset(skb), &nexthdr)) {
+	if (ipv6frag_thdr_truncated(skb, skb_network_offset(skb) + sizeof(struct ipv6hdr), &nexthdr)) {
 		__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 				IPSTATS_MIB_INHDRERRORS);
 		icmpv6_param_prob(skb, ICMPV6_HDR_INCOMP, 0);
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 35508abd76f4..a31521e270f7 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -551,6 +551,8 @@ int __init seg6_init(void)
 #endif
 #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
 out_unregister_genl:
+#endif
+#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
 	genl_unregister_family(&seg6_genl_family);
 #endif
 out_unregister_pernet:
@@ -564,8 +566,9 @@ void seg6_exit(void)
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
index d43c50a7310d..3c3800223e0e 100644
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
@@ -410,22 +417,29 @@ int __net_init seg6_hmac_net_init(struct net *net)
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
index 34db881204d2..5924407b87b0 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -459,10 +459,8 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	int err;
 
 	err = seg6_do_srh(skb);
-	if (unlikely(err)) {
-		kfree_skb(skb);
-		return err;
-	}
+	if (unlikely(err))
+		goto drop;
 
 	slwt = seg6_lwt_lwtunnel(orig_dst->lwtstate);
 
@@ -487,7 +485,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-		return err;
+		goto drop;
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -495,6 +493,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 			       skb_dst(skb)->dev, seg6_input_finish);
 
 	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 static int seg6_input_nf(struct sk_buff *skb)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 504ea27d08fb..f55d08d2096a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -70,11 +70,12 @@ int udpv6_init_sock(struct sock *sk)
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
@@ -159,24 +160,6 @@ static int compute_score(struct sock *sk, struct net *net,
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
@@ -186,15 +169,28 @@ static struct sock *udp6_lib_lookup2(struct net *net,
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
@@ -208,8 +204,14 @@ static struct sock *udp6_lib_lookup2(struct net *net,
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
@@ -234,7 +236,8 @@ static inline struct sock *udp6_lookup_run_bpf(struct net *net,
 	if (no_reuseport || IS_ERR_OR_NULL(sk))
 		return sk;
 
-	reuse_sk = lookup_reuseport(net, sk, skb, saddr, sport, daddr, hnum);
+	reuse_sk = inet6_lookup_reuseport(net, sk, skb, sizeof(struct udphdr),
+					  saddr, sport, daddr, hnum, udp6_ehashfn);
 	if (reuse_sk)
 		sk = reuse_sk;
 	return sk;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f25dc6931a5b..9a5530ca2f6b 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5528,7 +5528,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 			link->u.mgd.dtim_period = elems->dtim_period;
 		link->u.mgd.have_beacon = true;
 		ifmgd->assoc_data->need_beacon = false;
-		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
+		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
+		    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
 			link->conf->sync_tsf =
 				le64_to_cpu(mgmt->u.beacon.timestamp);
 			link->conf->sync_device_ts =
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index 9d33fd2377c8..a2bc9c5d92b8 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -877,6 +877,7 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	struct ieee80211_sub_if_data *sdata;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_supported_band *sband;
+	u32 mask = ~0;
 
 	rate_control_fill_sta_table(sta, info, dest, max_rates);
 
@@ -889,9 +890,12 @@ void ieee80211_get_tx_rates(struct ieee80211_vif *vif,
 	if (ieee80211_is_tx_data(skb))
 		rate_control_apply_mask(sdata, sta, sband, dest, max_rates);
 
+	if (!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX))
+		mask = sdata->rc_rateidx_mask[info->band];
+
 	if (dest[0].idx < 0)
 		__rate_control_send_low(&sdata->local->hw, sband, sta, info,
-					sdata->rc_rateidx_mask[info->band]);
+					mask);
 
 	if (sta)
 		rate_fixup_ratelist(vif, sband, info, dest, max_rates);
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index c37e2576f1c1..933d02d7c128 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -647,6 +647,7 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
+		IEEE80211_SKB_CB(skb)->control.flags |= IEEE80211_TX_CTRL_SCAN_TX;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3d62e8b71874..419baf8efdde 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -720,11 +720,16 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	txrc.bss_conf = &tx->sdata->vif.bss_conf;
 	txrc.skb = tx->skb;
 	txrc.reported_rate.idx = -1;
-	txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
 
-	if (tx->sdata->rc_has_mcs_mask[info->band])
-		txrc.rate_idx_mcs_mask =
-			tx->sdata->rc_rateidx_mcs_mask[info->band];
+	if (unlikely(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX)) {
+		txrc.rate_idx_mask = ~0;
+	} else {
+		txrc.rate_idx_mask = tx->sdata->rc_rateidx_mask[info->band];
+
+		if (tx->sdata->rc_has_mcs_mask[info->band])
+			txrc.rate_idx_mcs_mask =
+				tx->sdata->rc_rateidx_mcs_mask[info->band];
+	}
 
 	txrc.bss = (tx->sdata->vif.type == NL80211_IFTYPE_AP ||
 		    tx->sdata->vif.type == NL80211_IFTYPE_MESH_POINT ||
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 30374fd44228..e59e46e07b5c 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -179,8 +179,6 @@ static int mptcp_setsockopt_sol_socket_int(struct mptcp_sock *msk, int optname,
 
 	switch (optname) {
 	case SO_KEEPALIVE:
-		mptcp_sol_socket_sync_intval(msk, optname, val);
-		return 0;
 	case SO_DEBUG:
 	case SO_MARK:
 	case SO_PRIORITY:
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 87a9009d5234..5bc342cb1376 100644
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
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 5748415f74d0..0f17ace97227 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -34,11 +34,9 @@ int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:
 	case NFT_FIB_RESULT_OIFNAME:
-		hooks = (1 << NF_INET_PRE_ROUTING);
-		if (priv->flags & NFTA_FIB_F_IIF) {
-			hooks |= (1 << NF_INET_LOCAL_IN) |
-				 (1 << NF_INET_FORWARD);
-		}
+		hooks = (1 << NF_INET_PRE_ROUTING) |
+			(1 << NF_INET_LOCAL_IN) |
+			(1 << NF_INET_FORWARD);
 		break;
 	case NFT_FIB_RESULT_ADDRTYPE:
 		if (priv->flags & NFTA_FIB_F_IIF)
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index f44f2eaf3217..1b001dd2bc9a 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -44,36 +44,27 @@ nft_payload_copy_vlan(u32 *d, const struct sk_buff *skb, u8 offset, u8 len)
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
@@ -118,6 +109,17 @@ static int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
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
@@ -135,7 +137,8 @@ void nft_payload_eval(const struct nft_expr *expr,
 		if (!skb_mac_header_was_set(skb) || skb_mac_header_len(skb) == 0)
 			goto err;
 
-		if (skb_vlan_tag_present(skb)) {
+		if (skb_vlan_tag_present(skb) &&
+		    nft_payload_need_vlan_adjust(priv->offset, priv->len)) {
 			if (!nft_payload_copy_vlan(dest, skb,
 						   priv->offset, priv->len))
 				goto err;
@@ -665,21 +668,89 @@ static int nft_payload_csum_inet(struct sk_buff *skb, const u32 *src,
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
index 70480869ad1c..bd2b17b219ae 100644
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
index f76a2d806034..6196bb512dfc 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1462,6 +1462,19 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
 				 ndev->ops->n_core_ops);
 }
 
+static bool nci_valid_size(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(NCI_CTRL_HDR_SIZE != NCI_DATA_HDR_SIZE);
+	unsigned int hdr_size = NCI_CTRL_HDR_SIZE;
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
@@ -1512,9 +1525,9 @@ static void nci_rx_work(struct work_struct *work)
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
index a8cf9a88758e..21102ffe4470 100644
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
index e20d1a973417..78960a8a3892 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -558,7 +558,6 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 	 */
 	key->tp.src = htons(icmp->icmp6_type);
 	key->tp.dst = htons(icmp->icmp6_code);
-	memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
 
 	if (icmp->icmp6_code == 0 &&
 	    (icmp->icmp6_type == NDISC_NEIGHBOUR_SOLICITATION ||
@@ -567,6 +566,8 @@ static int parse_icmpv6(struct sk_buff *skb, struct sw_flow_key *key,
 		struct nd_msg *nd;
 		int offset;
 
+		memset(&key->ipv6.nd, 0, sizeof(key->ipv6.nd));
+
 		/* In order to process neighbor discovery options, we need the
 		 * entire packet.
 		 */
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7188ca8d8469..8888c09931ce 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2528,8 +2528,7 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
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
index bdc34ea0d939..d0575747ff0e 100644
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
index b774028e4aa8..1dbad41c4614 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1047,6 +1047,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
 		.stats		= old->cl_stats,
+		.timeout	= old->cl_timeout,
 	};
 	struct rpc_clnt *clnt;
 	int err;
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 9b0b21cccca9..666d738bcf07 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1205,8 +1205,6 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	if (rqstp->rq_proc >= versp->vs_nproc)
 		goto err_bad_proc;
 	rqstp->rq_procinfo = procp = &versp->vs_proc[rqstp->rq_proc];
-	if (!procp)
-		goto err_bad_proc;
 
 	/* Initialize storage for argp and resp */
 	memset(rqstp->rq_argp, 0, procp->pc_argzero);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 28c0771c4e8c..4f71627ba39c 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -244,7 +244,11 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
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
index 6b7189a520af..75cd20c0e3fd 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -910,9 +910,17 @@ struct tls_context *tls_ctx_create(struct sock *sk)
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
index f28e2956fea5..7d2a3b42b456 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1121,8 +1121,8 @@ static struct sock *unix_find_other(struct net *net,
 
 static int unix_autobind(struct sock *sk)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
 	u32 lastnum, ordernum;
@@ -1145,6 +1145,7 @@ static int unix_autobind(struct sock *sk)
 	addr->name->sun_family = AF_UNIX;
 	refcount_set(&addr->refcnt, 1);
 
+	old_hash = sk->sk_hash;
 	ordernum = get_random_u32();
 	lastnum = ordernum & 0xFFFFF;
 retry:
@@ -1185,8 +1186,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 {
 	umode_t mode = S_IFSOCK |
 	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct user_namespace *ns; // barf...
 	struct unix_address *addr;
@@ -1227,6 +1228,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	if (u->addr)
 		goto out_unlock;
 
+	old_hash = sk->sk_hash;
 	new_hash = unix_bsd_hash(d_backing_inode(dentry));
 	unix_table_double_lock(net, old_hash, new_hash);
 	u->path.mnt = mntget(parent.mnt);
@@ -1254,8 +1256,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 			      int addr_len)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
 	int err;
@@ -1273,6 +1275,7 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 		goto out_mutex;
 	}
 
+	old_hash = sk->sk_hash;
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
@@ -2137,13 +2140,15 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
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
@@ -2189,7 +2194,7 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto out_err;
 	}
 
-	if (sk->sk_shutdown & SEND_SHUTDOWN)
+	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
 		goto pipe_err;
 
 	while (sent < len) {
@@ -2626,8 +2631,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
+	spin_lock(&sk->sk_receive_queue.lock);
 
 	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
+		spin_unlock(&sk->sk_receive_queue.lock);
 		unix_state_unlock(sk);
 		mutex_unlock(&u->iolock);
 		return -EINVAL;
@@ -2639,6 +2646,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 		WRITE_ONCE(u->oob_skb, NULL);
 	else
 		skb_get(oob_skb);
+
+	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
@@ -2667,6 +2676,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
@@ -2678,13 +2691,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
index cb5c3224e038..137937b1f4b3 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1734,7 +1734,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1751,7 +1751,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index a76925b46ce6..7b1df55b0176 100644
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
index 5377f94eb211..3f08104e9366 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -307,8 +307,8 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
 	card->number = idx;
 #ifdef MODULE
 	WARN_ON(!module);
-	card->module = module;
 #endif
+	card->module = module;
 	INIT_LIST_HEAD(&card->devices);
 	init_rwsem(&card->controls_rwsem);
 	rwlock_init(&card->ctl_files_rwlock);
@@ -518,6 +518,14 @@ int snd_card_disconnect(struct snd_card *card)
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
 
@@ -533,6 +541,11 @@ int snd_card_disconnect(struct snd_card *card)
 		synchronize_irq(card->sync_irq);
 
 	snd_info_card_disconnect(card);
+#ifdef CONFIG_SND_DEBUG
+	debugfs_remove(card->debugfs_root);
+	card->debugfs_root = NULL;
+#endif
+
 	if (card->registered) {
 		device_del(&card->card_dev);
 		card->registered = false;
@@ -545,7 +558,6 @@ int snd_card_disconnect(struct snd_card *card)
 	mutex_unlock(&snd_card_mutex);
 
 #ifdef CONFIG_PM
-	wake_up(&card->power_sleep);
 	snd_power_sync_ref(card);
 #endif
 	return 0;	
@@ -595,10 +607,6 @@ static int snd_card_do_free(struct snd_card *card)
 		dev_warn(card->dev, "unable to free card info\n");
 		/* Not fatal error */
 	}
-#ifdef CONFIG_SND_DEBUG
-	debugfs_remove(card->debugfs_root);
-	card->debugfs_root = NULL;
-#endif
 	if (card->release_completion)
 		complete(card->release_completion);
 	if (!card->managed)
diff --git a/sound/core/jack.c b/sound/core/jack.c
index 03d155ed362b..bd795452e57b 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -37,16 +37,18 @@ static const int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
 };
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 
+static void snd_jack_remove_debugfs(struct snd_jack *jack);
+
 static int snd_jack_dev_disconnect(struct snd_device *device)
 {
-#ifdef CONFIG_SND_JACK_INPUT_DEV
 	struct snd_jack *jack = device->device_data;
 
-	mutex_lock(&jack->input_dev_lock);
-	if (!jack->input_dev) {
-		mutex_unlock(&jack->input_dev_lock);
+	snd_jack_remove_debugfs(jack);
+
+#ifdef CONFIG_SND_JACK_INPUT_DEV
+	guard(mutex)(&jack->input_dev_lock);
+	if (!jack->input_dev)
 		return 0;
-	}
 
 	/* If the input device is registered with the input subsystem
 	 * then we need to use a different deallocator. */
@@ -55,7 +57,6 @@ static int snd_jack_dev_disconnect(struct snd_device *device)
 	else
 		input_free_device(jack->input_dev);
 	jack->input_dev = NULL;
-	mutex_unlock(&jack->input_dev_lock);
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 	return 0;
 }
@@ -94,11 +95,9 @@ static int snd_jack_dev_register(struct snd_device *device)
 	snprintf(jack->name, sizeof(jack->name), "%s %s",
 		 card->shortname, jack->id);
 
-	mutex_lock(&jack->input_dev_lock);
-	if (!jack->input_dev) {
-		mutex_unlock(&jack->input_dev_lock);
+	guard(mutex)(&jack->input_dev_lock);
+	if (!jack->input_dev)
 		return 0;
-	}
 
 	jack->input_dev->name = jack->name;
 
@@ -123,7 +122,6 @@ static int snd_jack_dev_register(struct snd_device *device)
 	if (err == 0)
 		jack->registered = 1;
 
-	mutex_unlock(&jack->input_dev_lock);
 	return err;
 }
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
@@ -389,10 +387,14 @@ static int snd_jack_debugfs_add_inject_node(struct snd_jack *jack,
 	return 0;
 }
 
-static void snd_jack_debugfs_clear_inject_node(struct snd_jack_kctl *jack_kctl)
+static void snd_jack_remove_debugfs(struct snd_jack *jack)
 {
-	debugfs_remove(jack_kctl->jack_debugfs_root);
-	jack_kctl->jack_debugfs_root = NULL;
+	struct snd_jack_kctl *jack_kctl;
+
+	list_for_each_entry(jack_kctl, &jack->kctl_list, list) {
+		debugfs_remove(jack_kctl->jack_debugfs_root);
+		jack_kctl->jack_debugfs_root = NULL;
+	}
 }
 #else /* CONFIG_SND_JACK_INJECTION_DEBUG */
 static int snd_jack_debugfs_add_inject_node(struct snd_jack *jack,
@@ -401,7 +403,7 @@ static int snd_jack_debugfs_add_inject_node(struct snd_jack *jack,
 	return 0;
 }
 
-static void snd_jack_debugfs_clear_inject_node(struct snd_jack_kctl *jack_kctl)
+static void snd_jack_remove_debugfs(struct snd_jack *jack)
 {
 }
 #endif /* CONFIG_SND_JACK_INJECTION_DEBUG */
@@ -412,7 +414,6 @@ static void snd_jack_kctl_private_free(struct snd_kcontrol *kctl)
 
 	jack_kctl = kctl->private_data;
 	if (jack_kctl) {
-		snd_jack_debugfs_clear_inject_node(jack_kctl);
 		list_del(&jack_kctl->list);
 		kfree(jack_kctl);
 	}
@@ -505,8 +506,8 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		.dev_free = snd_jack_dev_free,
 #ifdef CONFIG_SND_JACK_INPUT_DEV
 		.dev_register = snd_jack_dev_register,
-		.dev_disconnect = snd_jack_dev_disconnect,
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
+		.dev_disconnect = snd_jack_dev_disconnect,
 	};
 
 	if (initial_kctl) {
@@ -588,14 +589,9 @@ EXPORT_SYMBOL(snd_jack_new);
 void snd_jack_set_parent(struct snd_jack *jack, struct device *parent)
 {
 	WARN_ON(jack->registered);
-	mutex_lock(&jack->input_dev_lock);
-	if (!jack->input_dev) {
-		mutex_unlock(&jack->input_dev_lock);
-		return;
-	}
-
-	jack->input_dev->dev.parent = parent;
-	mutex_unlock(&jack->input_dev_lock);
+	guard(mutex)(&jack->input_dev_lock);
+	if (jack->input_dev)
+		jack->input_dev->dev.parent = parent;
 }
 EXPORT_SYMBOL(snd_jack_set_parent);
 
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
diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index bc03b5692983..f1de386604a1 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -511,9 +511,32 @@ static const struct config_entry *snd_intel_dsp_find_config
 		if (table->codec_hid) {
 			int i;
 
-			for (i = 0; i < table->codec_hid->num_codecs; i++)
-				if (acpi_dev_present(table->codec_hid->codecs[i], NULL, -1))
+			for (i = 0; i < table->codec_hid->num_codecs; i++) {
+				struct nhlt_acpi_table *nhlt;
+				bool ssp_found = false;
+
+				if (!acpi_dev_present(table->codec_hid->codecs[i], NULL, -1))
+					continue;
+
+				nhlt = intel_nhlt_init(&pci->dev);
+				if (!nhlt) {
+					dev_warn(&pci->dev, "%s: NHLT table not found, skipped HID %s\n",
+						 __func__, table->codec_hid->codecs[i]);
+					continue;
+				}
+
+				if (intel_nhlt_has_endpoint_type(nhlt, NHLT_LINK_SSP) &&
+				    intel_nhlt_ssp_endpoint_mask(nhlt, NHLT_DEVICE_I2S))
+					ssp_found = true;
+
+				intel_nhlt_free(nhlt);
+
+				if (ssp_found)
 					break;
+
+				dev_warn(&pci->dev, "%s: no valid SSP found for HID %s, skipped\n",
+					 __func__, table->codec_hid->codecs[i]);
+			}
 			if (i == table->codec_hid->num_codecs)
 				continue;
 		}
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 1622a22f96f6..4a84ebe83157 100644
--- a/sound/pci/hda/hda_cs_dsp_ctl.c
+++ b/sound/pci/hda/hda_cs_dsp_ctl.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <sound/soc.h>
+#include <linux/cleanup.h>
 #include <linux/firmware/cirrus/cs_dsp.h>
 #include <linux/firmware/cirrus/wmfw.h>
 #include "hda_cs_dsp_ctl.h"
@@ -97,11 +98,23 @@ static unsigned int wmfw_convert_flags(unsigned int in)
 	return out;
 }
 
-static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char *name)
+static void hda_cs_dsp_free_kcontrol(struct snd_kcontrol *kctl)
 {
+	struct hda_cs_dsp_coeff_ctl *ctl = (struct hda_cs_dsp_coeff_ctl *)snd_kcontrol_chip(kctl);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+
+	/* NULL priv to prevent a double-free in hda_cs_dsp_control_remove() */
+	cs_ctl->priv = NULL;
+	kfree(ctl);
+}
+
+static void hda_cs_dsp_add_kcontrol(struct cs_dsp_coeff_ctl *cs_ctl,
+				    const struct hda_cs_dsp_ctl_info *info,
+				    const char *name)
+{
 	struct snd_kcontrol_new kcontrol = {0};
 	struct snd_kcontrol *kctl;
+	struct hda_cs_dsp_coeff_ctl *ctl __free(kfree) = NULL;
 	int ret = 0;
 
 	if (cs_ctl->len > ADSP_MAX_STD_CTRL_SIZE) {
@@ -110,6 +123,13 @@ static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char
 		return;
 	}
 
+	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
+	if (!ctl)
+		return;
+
+	ctl->cs_ctl = cs_ctl;
+	ctl->card = info->card;
+
 	kcontrol.name = name;
 	kcontrol.info = hda_cs_dsp_coeff_info;
 	kcontrol.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
@@ -117,20 +137,22 @@ static void hda_cs_dsp_add_kcontrol(struct hda_cs_dsp_coeff_ctl *ctl, const char
 	kcontrol.get = hda_cs_dsp_coeff_get;
 	kcontrol.put = hda_cs_dsp_coeff_put;
 
-	/* Save ctl inside private_data, ctl is owned by cs_dsp,
-	 * and will be freed when cs_dsp removes the control */
 	kctl = snd_ctl_new1(&kcontrol, (void *)ctl);
 	if (!kctl)
 		return;
 
-	ret = snd_ctl_add(ctl->card, kctl);
+	kctl->private_free = hda_cs_dsp_free_kcontrol;
+	ctl->kctl = kctl;
+
+	/* snd_ctl_add() calls our private_free on error, which will kfree(ctl) */
+	cs_ctl->priv = no_free_ptr(ctl);
+	ret = snd_ctl_add(info->card, kctl);
 	if (ret) {
 		dev_err(cs_ctl->dsp->dev, "Failed to add KControl %s = %d\n", kcontrol.name, ret);
 		return;
 	}
 
 	dev_dbg(cs_ctl->dsp->dev, "Added KControl: %s\n", kcontrol.name);
-	ctl->kctl = kctl;
 }
 
 static void hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl,
@@ -138,7 +160,6 @@ static void hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl,
 {
 	struct cs_dsp *cs_dsp = cs_ctl->dsp;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
-	struct hda_cs_dsp_coeff_ctl *ctl;
 	const char *region_name;
 	int ret;
 
@@ -163,15 +184,7 @@ static void hda_cs_dsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl,
 			 " %.*s", cs_ctl->subname_len - skip, cs_ctl->subname + skip);
 	}
 
-	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
-	if (!ctl)
-		return;
-
-	ctl->cs_ctl = cs_ctl;
-	ctl->card = info->card;
-	cs_ctl->priv = ctl;
-
-	hda_cs_dsp_add_kcontrol(ctl, name);
+	hda_cs_dsp_add_kcontrol(cs_ctl, info, name);
 }
 
 void hda_cs_dsp_add_controls(struct cs_dsp *dsp, const struct hda_cs_dsp_ctl_info *info)
@@ -203,7 +216,9 @@ void hda_cs_dsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 {
 	struct hda_cs_dsp_coeff_ctl *ctl = cs_ctl->priv;
 
-	kfree(ctl);
+	/* ctl and kctl may already have been removed by ALSA private_free */
+	if (ctl && ctl->kctl)
+		snd_ctl_remove(ctl->card, ctl->kctl);
 }
 EXPORT_SYMBOL_NS_GPL(hda_cs_dsp_control_remove, SND_HDA_CS_DSP_CONTROLS);
 
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f0b939862a2a..3a7104f72cab 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7207,6 +7207,7 @@ enum {
 	ALC285_FIXUP_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_HEADSET_MIC,
+	ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS,
 	ALC285_FIXUP_ASUS_I2C_SPEAKER2_TO_DAC1,
 	ALC285_FIXUP_ASUS_I2C_HEADSET_MIC,
 	ALC280_FIXUP_HP_HEADSET_MIC,
@@ -8214,6 +8215,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC285_FIXUP_ASUS_SPEAKER2_TO_DAC1
 	},
+	[ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x14, 0x90170120 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC285_FIXUP_ASUS_HEADSET_MIC
+	},
 	[ALC285_FIXUP_ASUS_I2C_SPEAKER2_TO_DAC1] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_speaker2_to_dac1,
@@ -9793,8 +9803,11 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c89, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8a, "HP EliteBook 630", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c8c, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8d, "HP ProBook 440 G11", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c8e, "HP ProBook 460 G11", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c90, "HP EliteBook 640", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c91, "HP EliteBook 660", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
@@ -9857,6 +9870,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1c62, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x1c92, "ASUS ROG Strix G15", ALC285_FIXUP_ASUS_G533Z_PINS),
+	SND_PCI_QUIRK(0x1043, 0x1caf, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1d1f, "ASUS ROG Strix G17 2023 (G713PV)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x1043, 0x1d42, "ASUS Zephyrus G14 2022", ALC289_FIXUP_ASUS_GA401),
@@ -9879,7 +9893,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index c8410769188a..d613f1074524 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -638,8 +638,10 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 		return NULL;
 
 	aad_pdata = devm_kzalloc(dev, sizeof(*aad_pdata), GFP_KERNEL);
-	if (!aad_pdata)
+	if (!aad_pdata) {
+		fwnode_handle_put(aad_np);
 		return NULL;
+	}
 
 	aad_pdata->irq = i2c->irq;
 
@@ -714,6 +716,8 @@ static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct device *dev)
 	else
 		aad_pdata->adc_1bit_rpt = DA7219_AAD_ADC_1BIT_RPT_1;
 
+	fwnode_handle_put(aad_np);
+
 	return aad_pdata;
 }
 
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index aac914074996..0bb70066111b 100644
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
@@ -3931,6 +3940,16 @@ static int rt5645_i2c_probe(struct i2c_client *i2c)
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
 
@@ -4174,6 +4193,9 @@ static void rt5645_i2c_remove(struct i2c_client *i2c)
 	cancel_delayed_work_sync(&rt5645->jack_detect_work);
 	cancel_delayed_work_sync(&rt5645->rcclock_work);
 
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
+
 	regulator_bulk_disable(ARRAY_SIZE(rt5645->supplies), rt5645->supplies);
 }
 
@@ -4189,6 +4211,9 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 		0);
 	msleep(20);
 	regmap_write(rt5645->regmap, RT5645_RESET, 0);
+
+	if (rt5645->gpiod_cbj_sleeve)
+		gpiod_set_value(rt5645->gpiod_cbj_sleeve, 0);
 }
 
 static struct i2c_driver rt5645_i2c_driver = {
diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index ce8bbc76199a..3377846a8753 100644
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
index 4e61e16470ed..4e35b67b01ce 100644
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
index 59a4ea5f6e30..7923f9a031ed 100644
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
diff --git a/sound/soc/intel/avs/boards/ssm4567.c b/sound/soc/intel/avs/boards/ssm4567.c
index 51a8867326b4..c1c936b73475 100644
--- a/sound/soc/intel/avs/boards/ssm4567.c
+++ b/sound/soc/intel/avs/boards/ssm4567.c
@@ -217,7 +217,6 @@ static int avs_ssm4567_probe(struct platform_device *pdev)
 	card->dapm_routes = routes;
 	card->num_dapm_routes = num_routes;
 	card->fully_routed = true;
-	card->disable_route_checks = true;
 
 	ret = snd_soc_fixup_dai_links_platform_name(card, pname);
 	if (ret)
diff --git a/sound/soc/intel/avs/cldma.c b/sound/soc/intel/avs/cldma.c
index d7a9390b5e48..585579840b64 100644
--- a/sound/soc/intel/avs/cldma.c
+++ b/sound/soc/intel/avs/cldma.c
@@ -35,7 +35,7 @@ struct hda_cldma {
 
 	unsigned int buffer_size;
 	unsigned int num_periods;
-	unsigned int stream_tag;
+	unsigned char stream_tag;
 	void __iomem *sd_addr;
 
 	struct snd_dma_buffer dmab_data;
diff --git a/sound/soc/intel/avs/path.c b/sound/soc/intel/avs/path.c
index ce157a8d6552..989a7a4127cd 100644
--- a/sound/soc/intel/avs/path.c
+++ b/sound/soc/intel/avs/path.c
@@ -308,6 +308,7 @@ static int avs_asrc_create(struct avs_dev *adev, struct avs_path_module *mod)
 	struct avs_tplg_module *t = mod->template;
 	struct avs_asrc_cfg cfg;
 
+	memset(&cfg, 0, sizeof(cfg));
 	cfg.base.cpc = t->cfg_base->cpc;
 	cfg.base.ibs = t->cfg_base->ibs;
 	cfg.base.obs = t->cfg_base->obs;
diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 7c6c95e99ade..420c8b2588c1 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -762,6 +762,7 @@ static struct snd_soc_card broxton_audio_card = {
 	.dapm_routes = audio_map,
 	.num_dapm_routes = ARRAY_SIZE(audio_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 4bd93c3ba377..ea45baaaaaed 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -574,6 +574,7 @@ static struct snd_soc_card broxton_rt298 = {
 	.dapm_routes = broxton_rt298_map,
 	.num_dapm_routes = ARRAY_SIZE(broxton_rt298_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = bxt_card_late_probe,
 
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 094445036c20..d6ef8e850412 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -636,28 +636,30 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_USE_AMCR0F28),
 	},
 	{
+		/* Asus T100TAF, unlike other T100TA* models this one has a mono speaker */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_JD_SRC_JD2_IN4N |
 					BYT_RT5640_OVCD_TH_2000UA |
 					BYT_RT5640_OVCD_SF_0P75 |
+					BYT_RT5640_MONO_SPEAKER |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
+		/* Asus T100TA and T100TAM, must come after T100TAF (mono spk) match */
 		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TAF"),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T100TA"),
 		},
 		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
 					BYT_RT5640_JD_SRC_JD2_IN4N |
 					BYT_RT5640_OVCD_TH_2000UA |
 					BYT_RT5640_OVCD_SF_0P75 |
-					BYT_RT5640_MONO_SPEAKER |
-					BYT_RT5640_DIFF_MIC |
-					BYT_RT5640_SSP0_AIF2 |
 					BYT_RT5640_MCLK_EN),
 	},
 	{
diff --git a/sound/soc/intel/boards/glk_rt5682_max98357a.c b/sound/soc/intel/boards/glk_rt5682_max98357a.c
index cf0f89db3e20..0f9bbb970b23 100644
--- a/sound/soc/intel/boards/glk_rt5682_max98357a.c
+++ b/sound/soc/intel/boards/glk_rt5682_max98357a.c
@@ -649,6 +649,8 @@ static int geminilake_audio_probe(struct platform_device *pdev)
 	card = &glk_audio_card_rt5682_m98357a;
 	card->dev = &pdev->dev;
 	snd_soc_card_set_drvdata(card, ctx);
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		card->disable_route_checks = true;
 
 	/* override platform name, if required */
 	mach = pdev->dev.platform_data;
diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 329457e3e3a2..c990baed8013 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -633,6 +633,7 @@ static struct snd_soc_card kabylake_audio_card_da7219_m98357a = {
 	.dapm_routes = kabylake_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_da7219_max98927.c b/sound/soc/intel/boards/kbl_da7219_max98927.c
index 362579f25835..7ab80ba264cb 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98927.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98927.c
@@ -1030,6 +1030,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1048,6 +1049,7 @@ static struct snd_soc_card kbl_audio_card_max98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1065,6 +1067,7 @@ static struct snd_soc_card kbl_audio_card_da7219_m98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -1082,6 +1085,7 @@ static struct snd_soc_card kbl_audio_card_max98373 = {
 	.codec_conf = max98373_codec_conf,
 	.num_configs = ARRAY_SIZE(max98373_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5660.c b/sound/soc/intel/boards/kbl_rt5660.c
index 2c7a547f63c9..358d60622812 100644
--- a/sound/soc/intel/boards/kbl_rt5660.c
+++ b/sound/soc/intel/boards/kbl_rt5660.c
@@ -518,6 +518,7 @@ static struct snd_soc_card kabylake_audio_card_rt5660 = {
 	.dapm_routes = kabylake_rt5660_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_rt5660_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_max98927.c b/sound/soc/intel/boards/kbl_rt5663_max98927.c
index 2d4224c5b152..d110ebd10bca 100644
--- a/sound/soc/intel/boards/kbl_rt5663_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_max98927.c
@@ -966,6 +966,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663_m98927 = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
@@ -982,6 +983,7 @@ static struct snd_soc_card kabylake_audio_card_rt5663 = {
 	.dapm_routes = kabylake_5663_map,
 	.num_dapm_routes = ARRAY_SIZE(kabylake_5663_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 2c79fca57b19..a15d2c30b6c4 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -791,6 +791,7 @@ static struct snd_soc_card kabylake_audio_card = {
 	.codec_conf = max98927_codec_conf,
 	.num_configs = ARRAY_SIZE(max98927_codec_conf),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = kabylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_hda_dsp_generic.c b/sound/soc/intel/boards/skl_hda_dsp_generic.c
index 463ffb85121d..2e1c1e4013c3 100644
--- a/sound/soc/intel/boards/skl_hda_dsp_generic.c
+++ b/sound/soc/intel/boards/skl_hda_dsp_generic.c
@@ -231,6 +231,8 @@ static int skl_hda_audio_probe(struct platform_device *pdev)
 	ctx->common_hdmi_codec_drv = mach->mach_params.common_hdmi_codec_drv;
 
 	hda_soc_card.dev = &pdev->dev;
+	if (!snd_soc_acpi_sof_parent(&pdev->dev))
+		hda_soc_card.disable_route_checks = true;
 
 	if (mach->mach_params.dmic_num > 0) {
 		snprintf(hda_soc_components, sizeof(hda_soc_components),
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 8dceb0b02581..8180afb4505b 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -654,6 +654,7 @@ static struct snd_soc_card skylake_audio_card = {
 	.dapm_routes = skylake_map,
 	.num_dapm_routes = ARRAY_SIZE(skylake_map),
 	.fully_routed = true,
+	.disable_route_checks = true,
 	.late_probe = skylake_card_late_probe,
 };
 
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 4f3d655e2bfa..0a4795a94a76 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -523,6 +523,7 @@ static struct snd_soc_card skylake_rt286 = {
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
index d12d1358f96d..8eaf140172c5 100644
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
@@ -698,10 +698,10 @@ AVXcode: 2
 4d: vrcp14ss/d Vsd,Hpd,Wsd (66),(ev)
 4e: vrsqrt14ps/d Vpd,Wpd (66),(ev)
 4f: vrsqrt14ss/d Vsd,Hsd,Wsd (66),(ev)
-50: vpdpbusd Vx,Hx,Wx (66),(ev)
-51: vpdpbusds Vx,Hx,Wx (66),(ev)
-52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66),(ev) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
-53: vpdpwssds Vx,Hx,Wx (66),(ev) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
+50: vpdpbusd Vx,Hx,Wx (66)
+51: vpdpbusds Vx,Hx,Wx (66)
+52: vdpbf16ps Vx,Hx,Wx (F3),(ev) | vpdpwssd Vx,Hx,Wx (66) | vp4dpwssd Vdqq,Hdqq,Wdq (F2),(ev)
+53: vpdpwssds Vx,Hx,Wx (66) | vp4dpwssds Vdqq,Hdqq,Wdq (F2),(ev)
 54: vpopcntb/w Vx,Wx (66),(ev)
 55: vpopcntd/q Vx,Wx (66),(ev)
 58: vpbroadcastd Vx,Wx (66),(v)
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index 26004f0c5a6a..7bdbcac3cf62 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -102,8 +102,8 @@ int iter(struct bpf_iter__task_file *ctx)
 				       BPF_LINK_TYPE_PERF_EVENT___local)) {
 		struct bpf_link *link = (struct bpf_link *) file->private_data;
 
-		if (link->type == bpf_core_enum_value(enum bpf_link_type___local,
-						      BPF_LINK_TYPE_PERF_EVENT___local)) {
+		if (BPF_CORE_READ(link, type) == bpf_core_enum_value(enum bpf_link_type___local,
+								     BPF_LINK_TYPE_PERF_EVENT___local)) {
 			e.has_bpf_cookie = true;
 			e.bpf_cookie = get_bpf_cookie(link);
 		}
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index ef0764d6891e..82bffa7cf865 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -728,7 +728,7 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	int err;
+	off_t err;
 
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index a24000d1e822..c0c3854b3f35 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -166,7 +166,7 @@ void *realloc(void *old_ptr, size_t new_size)
 	if (__builtin_expect(!ret, 0))
 		return NULL;
 
-	memcpy(ret, heap->user_p, heap->len);
+	memcpy(ret, heap->user_p, user_p_len);
 	munmap(heap, heap->len);
 	return ret;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index d5d2183730b9..a17688011440 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6730,7 +6730,7 @@ struct bpf_fib_lookup {
 
 		/* output: MTU value */
 		__u16	mtu_result;
-	};
+	} __attribute__((packed, aligned(2)));
 	/* input: L3 device index for lookup
 	 * output: device index from FIB lookup
 	 */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index c71d4d0f5c6f..bb27dfd6b97a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10417,7 +10417,7 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
 
 	n = sscanf(spec, "%m[a-zA-Z0-9_.*?]", &pattern);
 	if (n < 1) {
-		pr_warn("kprobe multi pattern is invalid: %s\n", pattern);
+		pr_warn("kprobe multi pattern is invalid: %s\n", spec);
 		return -EINVAL;
 	}
 
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 9fa75943f2ed..d943d78b787e 100644
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
 
diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index 57384a97c04f..3dae696b748a 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -63,6 +63,7 @@ counted. The following modifiers exist:
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
  e - group or event are exclusive and do not share the PMU
+ b - use BPF aggregration (see perf stat --bpf-counters)
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 17672790f123..d1672be702f3 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -361,7 +361,7 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 		return -1;
 
 	for (i = 0; i < nr_mmaps; i++) {
-		int idx = rand() % (nr_dsos - 1);
+		int idx = rand() % nr_dsos;
 		struct bench_dso *dso = &dsos[idx];
 		u64 timestamp = rand() % 1000000;
 
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 517d928c00e3..21d758260873 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -571,8 +571,6 @@ int cmd_annotate(int argc, const char **argv)
 		    "Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
-	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
-		    "Show event group information together"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
 	OPT_BOOLEAN('n', "show-nr-samples", &symbol_conf.show_nr_samples,
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 6cb3f6cc36d0..35942256582a 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -523,7 +523,7 @@ static int daemon_session__control(struct daemon_session *session,
 		  session->base, SESSION_CONTROL);
 
 	control = open(control_path, O_WRONLY|O_NONBLOCK);
-	if (!control)
+	if (control < 0)
 		return -1;
 
 	if (do_ack) {
@@ -532,7 +532,7 @@ static int daemon_session__control(struct daemon_session *session,
 			  session->base, SESSION_ACK);
 
 		ack = open(ack_path, O_RDONLY, O_NONBLOCK);
-		if (!ack) {
+		if (ack < 0) {
 			close(control);
 			return -1;
 		}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b9b0fda8374e..ee3a5c4b8251 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2843,10 +2843,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 #endif
 	zstd_fini(&session->zstd_data);
-	perf_session__delete(session);
-
 	if (!opts->no_bpf_event)
 		evlist__stop_sb_thread(rec->sb_evlist);
+
+	perf_session__delete(session);
 	return status;
 }
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index b6d77d3da64f..155f119b3db5 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -416,7 +416,7 @@ static int report__setup_sample_type(struct report *rep)
 		 * compatibility, set the bit if it's an old perf data file.
 		 */
 		evlist__for_each_entry(session->evlist, evsel) {
-			if (strstr(evsel->name, "arm_spe") &&
+			if (strstr(evsel__name(evsel), "arm_spe") &&
 				!(sample_type & PERF_SAMPLE_DATA_SRC)) {
 				evsel->core.attr.sample_type |= PERF_SAMPLE_DATA_SRC;
 				sample_type |= PERF_SAMPLE_DATA_SRC;
diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 2064a640facb..11b69023011b 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -103,3 +103,5 @@ endif
 CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
 CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
+
+perf-y += workloads/
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 7122eae1d98d..4c6ae59a4dfd 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -118,6 +118,15 @@ static struct test_suite **tests[] = {
 	arch_tests,
 };
 
+static struct test_workload *workloads[] = {
+	&workload__noploop,
+	&workload__thloop,
+	&workload__leafloop,
+	&workload__sqrtloop,
+	&workload__brstack,
+	&workload__datasym,
+};
+
 static int num_subtests(const struct test_suite *t)
 {
 	int num;
@@ -475,6 +484,21 @@ static int perf_test__list(int argc, const char **argv)
 	return 0;
 }
 
+static int run_workload(const char *work, int argc, const char **argv)
+{
+	unsigned int i = 0;
+	struct test_workload *twl;
+
+	for (i = 0; i < ARRAY_SIZE(workloads); i++) {
+		twl = workloads[i];
+		if (!strcmp(twl->name, work))
+			return twl->func(argc, argv);
+	}
+
+	pr_info("No workload found: %s\n", work);
+	return -1;
+}
+
 int cmd_test(int argc, const char **argv)
 {
 	const char *test_usage[] = {
@@ -482,12 +506,14 @@ int cmd_test(int argc, const char **argv)
 	NULL,
 	};
 	const char *skip = NULL;
+	const char *workload = NULL;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show symbol address, etc)"),
 	OPT_BOOLEAN('F', "dont-fork", &dont_fork,
 		    "Do not fork for testcase"),
+	OPT_STRING('w', "workload", &workload, "work", "workload to run for testing"),
 	OPT_END()
 	};
 	const char * const test_subcommands[] = { "list", NULL };
@@ -504,6 +530,9 @@ int cmd_test(int argc, const char **argv)
 	if (argc >= 1 && !strcmp(argv[0], "list"))
 		return perf_test__list(argc - 1, argv + 1);
 
+	if (workload)
+		return run_workload(workload, argc, argv);
+
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.sort_by_name = true;
 	symbol_conf.try_vmlinux_path = true;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 5bbb8f6a48fc..e15f24cfc909 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -180,4 +180,31 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 DECLARE_SUITE(vectors_page);
 #endif
 
+/*
+ * Define test workloads to be used in test suites.
+ */
+typedef int (*workload_fnptr)(int argc, const char **argv);
+
+struct test_workload {
+	const char	*name;
+	workload_fnptr	func;
+};
+
+#define DECLARE_WORKLOAD(work) \
+	extern struct test_workload workload__##work
+
+#define DEFINE_WORKLOAD(work) \
+struct test_workload workload__##work = {	\
+	.name = #work,				\
+	.func = work,				\
+}
+
+/* The list of test workloads */
+DECLARE_WORKLOAD(noploop);
+DECLARE_WORKLOAD(thloop);
+DECLARE_WORKLOAD(leafloop);
+DECLARE_WORKLOAD(sqrtloop);
+DECLARE_WORKLOAD(brstack);
+DECLARE_WORKLOAD(datasym);
+
 #endif /* TESTS_H */
diff --git a/tools/perf/tests/workloads/Build b/tools/perf/tests/workloads/Build
new file mode 100644
index 000000000000..a1f34d5861e3
--- /dev/null
+++ b/tools/perf/tests/workloads/Build
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+
+perf-y += noploop.o
+perf-y += thloop.o
+perf-y += leafloop.o
+perf-y += sqrtloop.o
+perf-y += brstack.o
+perf-y += datasym.o
+
+CFLAGS_sqrtloop.o         = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_leafloop.o         = -g -O0 -fno-inline -fno-omit-frame-pointer -U_FORTIFY_SOURCE
+CFLAGS_brstack.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
+CFLAGS_datasym.o          = -g -O0 -fno-inline -U_FORTIFY_SOURCE
diff --git a/tools/perf/tests/workloads/brstack.c b/tools/perf/tests/workloads/brstack.c
new file mode 100644
index 000000000000..0b60bd37b9d1
--- /dev/null
+++ b/tools/perf/tests/workloads/brstack.c
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+#include "../tests.h"
+
+#define BENCH_RUNS 999999
+
+static volatile int cnt;
+
+static void brstack_bar(void) {
+}				/* return */
+
+static void brstack_foo(void) {
+	brstack_bar();		/* call */
+}				/* return */
+
+static void brstack_bench(void) {
+	void (*brstack_foo_ind)(void) = brstack_foo;
+
+	if ((cnt++) % 3)	/* branch (cond) */
+		brstack_foo();	/* call */
+	brstack_bar();		/* call */
+	brstack_foo_ind();	/* call (ind) */
+}
+
+static int brstack(int argc, const char **argv)
+{
+	int num_loops = BENCH_RUNS;
+
+	if (argc > 0)
+		num_loops = atoi(argv[0]);
+
+	while (1) {
+		if ((cnt++) > num_loops)
+			break;
+		brstack_bench();/* call */
+	}			/* branch (uncond) */
+	return 0;
+}
+
+DEFINE_WORKLOAD(brstack);
diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
new file mode 100644
index 000000000000..8e08fc75a973
--- /dev/null
+++ b/tools/perf/tests/workloads/datasym.c
@@ -0,0 +1,40 @@
+#include <linux/compiler.h>
+#include "../tests.h"
+
+typedef struct _buf {
+	char data1;
+	char reserved[55];
+	char data2;
+} buf __attribute__((aligned(64)));
+
+static buf buf1 = {
+	/* to have this in the data section */
+	.reserved[0] = 1,
+};
+
+static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	for (;;) {
+		buf1.data1++;
+		if (buf1.data1 == 123) {
+			/*
+			 * Add some 'noise' in the loop to work around errata
+			 * 1694299 on Arm N1.
+			 *
+			 * Bias exists in SPE sampling which can cause the load
+			 * and store instructions to be skipped entirely. This
+			 * comes and goes randomly depending on the offset the
+			 * linker places the datasym loop at in the Perf binary.
+			 * With an extra branch in the middle of the loop that
+			 * isn't always taken, the instruction stream is no
+			 * longer a continuous repeating pattern that interacts
+			 * badly with the bias.
+			 */
+			buf1.data1++;
+		}
+		buf1.data2 += buf1.data1;
+	}
+	return 0;
+}
+
+DEFINE_WORKLOAD(datasym);
diff --git a/tools/perf/tests/workloads/leafloop.c b/tools/perf/tests/workloads/leafloop.c
new file mode 100644
index 000000000000..1bf5cc97649b
--- /dev/null
+++ b/tools/perf/tests/workloads/leafloop.c
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+/* We want to check these symbols in perf script */
+noinline void leaf(volatile int b);
+noinline void parent(volatile int b);
+
+static volatile int a;
+
+noinline void leaf(volatile int b)
+{
+	for (;;)
+		a += b;
+}
+
+noinline void parent(volatile int b)
+{
+	leaf(b);
+}
+
+static int leafloop(int argc, const char **argv)
+{
+	int c = 1;
+
+	if (argc > 0)
+		c = atoi(argv[0]);
+
+	parent(c);
+	return 0;
+}
+
+DEFINE_WORKLOAD(leafloop);
diff --git a/tools/perf/tests/workloads/noploop.c b/tools/perf/tests/workloads/noploop.c
new file mode 100644
index 000000000000..940ea5910a84
--- /dev/null
+++ b/tools/perf/tests/workloads/noploop.c
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int noploop(int argc, const char **argv)
+{
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done)
+		continue;
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(noploop);
diff --git a/tools/perf/tests/workloads/sqrtloop.c b/tools/perf/tests/workloads/sqrtloop.c
new file mode 100644
index 000000000000..ccc94c6a6676
--- /dev/null
+++ b/tools/perf/tests/workloads/sqrtloop.c
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <math.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include <sys/wait.h>
+#include "../tests.h"
+
+static volatile sig_atomic_t done;
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+static int __sqrtloop(int sec)
+{
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	while (!done)
+		(void)sqrt(rand());
+	return 0;
+}
+
+static int sqrtloop(int argc, const char **argv)
+{
+	int sec = 1;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	switch (fork()) {
+	case 0:
+		return __sqrtloop(sec);
+	case -1:
+		return -1;
+	default:
+		wait(NULL);
+	}
+	return 0;
+}
+
+DEFINE_WORKLOAD(sqrtloop);
diff --git a/tools/perf/tests/workloads/thloop.c b/tools/perf/tests/workloads/thloop.c
new file mode 100644
index 000000000000..29193b75717e
--- /dev/null
+++ b/tools/perf/tests/workloads/thloop.c
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <pthread.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <unistd.h>
+#include <linux/compiler.h>
+#include "../tests.h"
+
+static volatile sig_atomic_t done;
+static volatile unsigned count;
+
+/* We want to check this symbol in perf report */
+noinline void test_loop(void);
+
+static void sighandler(int sig __maybe_unused)
+{
+	done = 1;
+}
+
+noinline void test_loop(void)
+{
+	while (!done)
+		count++;
+}
+
+static void *thfunc(void *arg)
+{
+	void (*loop_fn)(void) = arg;
+
+	loop_fn();
+	return NULL;
+}
+
+static int thloop(int argc, const char **argv)
+{
+	int sec = 1;
+	pthread_t th;
+
+	if (argc > 0)
+		sec = atoi(argv[0]);
+
+	signal(SIGINT, sighandler);
+	signal(SIGALRM, sighandler);
+	alarm(sec);
+
+	pthread_create(&th, NULL, thfunc, test_loop);
+	test_loop();
+	pthread_join(th, NULL);
+
+	return 0;
+}
+
+DEFINE_WORKLOAD(thloop);
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 78fb01d6ad63..5d6f4f25c33d 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -203,7 +203,7 @@ void ui_browser__refresh_dimensions(struct ui_browser *browser)
 void ui_browser__handle_resize(struct ui_browser *browser)
 {
 	ui__refresh_dimensions(false);
-	ui_browser__show(browser, browser->title, ui_helpline__current);
+	ui_browser__show(browser, browser->title ?: "", ui_helpline__current);
 	ui_browser__refresh(browser);
 }
 
@@ -287,7 +287,8 @@ int ui_browser__show(struct ui_browser *browser, const char *title,
 	mutex_lock(&ui__lock);
 	__ui_browser__show_title(browser, title);
 
-	browser->title = title;
+	free(browser->title);
+	browser->title = strdup(title);
 	zfree(&browser->helpline);
 
 	va_start(ap, helpline);
@@ -304,6 +305,7 @@ void ui_browser__hide(struct ui_browser *browser)
 	mutex_lock(&ui__lock);
 	ui_helpline__pop();
 	zfree(&browser->helpline);
+	zfree(&browser->title);
 	mutex_unlock(&ui__lock);
 }
 
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 510ce4554050..6e98d5f8f71c 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -21,7 +21,7 @@ struct ui_browser {
 	u8	      extra_title_lines;
 	int	      current_color;
 	void	      *priv;
-	const char    *title;
+	char	      *title;
 	char	      *helpline;
 	const char    *no_samples_msg;
 	void 	      (*refresh_dimensions)(struct ui_browser *browser);
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index 7145c5890de0..178baa1e6949 100644
--- a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
+++ b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
@@ -1319,6 +1319,8 @@ static bool intel_pt_fup_event(struct intel_pt_decoder *decoder, bool no_tip)
 	bool ret = false;
 
 	decoder->state.type &= ~INTEL_PT_BRANCH;
+	decoder->state.insn_op = INTEL_PT_OP_OTHER;
+	decoder->state.insn_len = 0;
 
 	if (decoder->set_fup_cfe_ip || decoder->set_fup_cfe) {
 		bool ip = decoder->set_fup_cfe_ip;
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 6fb64c58b408..bd09af447eb0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -755,6 +755,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 	bool nr;
 
 	intel_pt_insn->length = 0;
+	intel_pt_insn->op = INTEL_PT_OP_OTHER;
 
 	if (to_ip && *ip == to_ip)
 		goto out_no_cache;
@@ -876,6 +877,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 			if (to_ip && *ip == to_ip) {
 				intel_pt_insn->length = 0;
+				intel_pt_insn->op = INTEL_PT_OP_OTHER;
 				goto out_no_cache;
 			}
 
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 0c24bc7afbca..66ff8420ce2b 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -11,6 +11,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index ef9a3df45965..9053db0dc00a 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1162,6 +1162,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
+		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
+			continue;
+
 		os.evsel = counter;
 
 		if (!first && config->json_output)
diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 1fa4672380a9..9448d075bce2 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -459,6 +459,8 @@ struct nstoken *open_netns(const char *name)
 
 	return token;
 fail:
+	if (token->orig_netns_fd != -1)
+		close(token->orig_netns_fd);
 	free(token);
 	return NULL;
 }
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index e768181a1bd7..d56f521b8aaa 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -2086,9 +2086,9 @@ int main(int argc, char **argv)
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
index c2f7cef919c0..eb4c3b411934 100644
--- a/tools/testing/selftests/filesystems/binderfs/Makefile
+++ b/tools/testing/selftests/filesystems/binderfs/Makefile
@@ -3,6 +3,4 @@
 CFLAGS += $(KHDR_INCLUDES) -pthread
 TEST_GEN_PROGS := binderfs_test
 
-binderfs_test: binderfs_test.c ../../kselftest.h ../../kselftest_harness.h
-
 include ../../lib.mk
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 25110c7c0b3e..d7a8e321bb16 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -91,7 +91,7 @@ int main(int argc, char **argv)
 		ksft_print_header();
 		ksft_set_plan(3);
 
-		fd2 = open(kpath, O_RDWR, 0644);
+		fd2 = open(kpath, O_RDWR);
 		if (fd2 < 0) {
 			perror("Can't open file");
 			ksft_exit_fail();
diff --git a/tools/testing/selftests/kvm/aarch64/vgic_init.c b/tools/testing/selftests/kvm/aarch64/vgic_init.c
index 9c131d977a1b..e43536a76b78 100644
--- a/tools/testing/selftests/kvm/aarch64/vgic_init.c
+++ b/tools/testing/selftests/kvm/aarch64/vgic_init.c
@@ -6,6 +6,7 @@
  */
 #define _GNU_SOURCE
 #include <linux/kernel.h>
+#include <linux/bitfield.h>
 #include <sys/syscall.h>
 #include <asm/kvm.h>
 #include <asm/kvm_para.h>
@@ -86,6 +87,18 @@ static struct vm_gic vm_gic_create_with_vcpus(uint32_t gic_dev_type,
 	return v;
 }
 
+static struct vm_gic vm_gic_create_barebones(uint32_t gic_dev_type)
+{
+	struct vm_gic v;
+
+	v.gic_dev_type = gic_dev_type;
+	v.vm = vm_create_barebones();
+	v.gic_fd = kvm_create_device(v.vm, gic_dev_type);
+
+	return v;
+}
+
+
 static void vm_gic_destroy(struct vm_gic *v)
 {
 	close(v->gic_fd);
@@ -359,6 +372,40 @@ static void test_vcpus_then_vgic(uint32_t gic_dev_type)
 	vm_gic_destroy(&v);
 }
 
+#define KVM_VGIC_V2_ATTR(offset, cpu) \
+	(FIELD_PREP(KVM_DEV_ARM_VGIC_OFFSET_MASK, offset) | \
+	 FIELD_PREP(KVM_DEV_ARM_VGIC_CPUID_MASK, cpu))
+
+#define GIC_CPU_CTRL	0x00
+
+static void test_v2_uaccess_cpuif_no_vcpus(void)
+{
+	struct vm_gic v;
+	u64 val = 0;
+	int ret;
+
+	v = vm_gic_create_barebones(KVM_DEV_TYPE_ARM_VGIC_V2);
+	subtest_dist_rdist(&v);
+
+	ret = __kvm_has_device_attr(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0));
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+	ret = __kvm_device_attr_get(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0), &val);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+	ret = __kvm_device_attr_set(v.gic_fd, KVM_DEV_ARM_VGIC_GRP_CPU_REGS,
+				    KVM_VGIC_V2_ATTR(GIC_CPU_CTRL, 0), &val);
+	TEST_ASSERT(ret && errno == EINVAL,
+		    "accessed non-existent CPU interface, want errno: %i",
+		    EINVAL);
+
+	vm_gic_destroy(&v);
+}
+
 static void test_v3_new_redist_regions(void)
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
@@ -677,6 +724,9 @@ void run_tests(uint32_t gic_dev_type)
 	test_vcpus_then_vgic(gic_dev_type);
 	test_vgic_then_vcpus(gic_dev_type);
 
+	if (VGIC_DEV_IS_V2(gic_dev_type))
+		test_v2_uaccess_cpuif_no_vcpus();
+
 	if (VGIC_DEV_IS_V3(gic_dev_type)) {
 		test_v3_new_redist_regions();
 		test_v3_typer_accesses();
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index aa646e0661f3..a8f0442a36bc 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -7,6 +7,8 @@ else ifneq ($(filter -%,$(LLVM)),)
 LLVM_SUFFIX := $(LLVM)
 endif
 
+CLANG := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+
 CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
 CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
 CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
@@ -18,7 +20,13 @@ CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
 CLANG_TARGET_FLAGS_x86_64       := x86_64-linux-gnu
-CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+
+# Default to host architecture if ARCH is not explicitly given.
+ifeq ($(ARCH),)
+CLANG_TARGET_FLAGS := $(shell $(CLANG) -print-target-triple)
+else
+CLANG_TARGET_FLAGS := $(CLANG_TARGET_FLAGS_$(ARCH))
+endif
 
 ifeq ($(CROSS_COMPILE),)
 ifeq ($(CLANG_TARGET_FLAGS),)
@@ -30,7 +38,7 @@ else
 CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
 endif # CROSS_COMPILE
 
-CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
+CC := $(CLANG) $(CLANG_FLAGS) -fintegrated-as
 else
 CC := $(CROSS_COMPILE)gcc
 endif # LLVM
diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 75528788cb95..7e7ed6c558da 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -77,6 +77,7 @@ readonly LISTENER=$(mktemp -u listener-XXXXXXXX)
 readonly GATEWAY=$(mktemp -u gateway-XXXXXXXX)
 readonly RELAY=$(mktemp -u relay-XXXXXXXX)
 readonly SOURCE=$(mktemp -u source-XXXXXXXX)
+readonly SMCROUTEDIR="$(mktemp -d)"
 ERR=4
 err=0
 
@@ -85,6 +86,11 @@ exit_cleanup()
 	for ns in "$@"; do
 		ip netns delete "${ns}" 2>/dev/null || true
 	done
+	if [ -f "$SMCROUTEDIR/amt.pid" ]; then
+		smcpid=$(< $SMCROUTEDIR/amt.pid)
+		kill $smcpid
+	fi
+	rm -rf $SMCROUTEDIR
 
 	exit $ERR
 }
@@ -167,7 +173,7 @@ setup_iptables()
 
 setup_mcast_routing()
 {
-	ip netns exec "${RELAY}" smcrouted
+	ip netns exec "${RELAY}" smcrouted -P $SMCROUTEDIR/amt.pid
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
 		172.17.0.2 239.0.0.1 amtr
 	ip netns exec "${RELAY}" smcroutectl a relay_src \
@@ -210,8 +216,8 @@ check_features()
 
 test_ipv4_forward()
 {
-	RESULT4=$(ip netns exec "${LISTENER}" nc -w 1 -l -u 239.0.0.1 4000)
-	if [ "$RESULT4" == "172.17.0.2" ]; then
+	RESULT4=$(ip netns exec "${LISTENER}" timeout 15 socat - UDP4-LISTEN:4000,readbytes=128 || true)
+	if echo "$RESULT4" | grep -q "172.17.0.2"; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv4 amt multicast forwarding"
 		exit 0
 	else
@@ -222,8 +228,8 @@ test_ipv4_forward()
 
 test_ipv6_forward()
 {
-	RESULT6=$(ip netns exec "${LISTENER}" nc -w 1 -l -u ff0e::5:6 6000)
-	if [ "$RESULT6" == "2001:db8:3::2" ]; then
+	RESULT6=$(ip netns exec "${LISTENER}" timeout 15 socat - UDP6-LISTEN:6000,readbytes=128 || true)
+	if echo "$RESULT6" | grep -q "2001:db8:3::2"; then
 		printf "TEST: %-60s  [ OK ]\n" "IPv6 amt multicast forwarding"
 		exit 0
 	else
@@ -236,14 +242,14 @@ send_mcast4()
 {
 	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
-		'echo 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
+		'printf "%s %128s" 172.17.0.2 | nc -w 1 -u 239.0.0.1 4000' &
 }
 
 send_mcast6()
 {
 	sleep 2
 	ip netns exec "${SOURCE}" bash -c \
-		'echo 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
+		'printf "%s %128s" 2001:db8:3::2 | nc -w 1 -u ff0e::5:6 6000' &
 }
 
 check_features
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

