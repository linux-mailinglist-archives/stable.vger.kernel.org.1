Return-Path: <stable+bounces-50220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F352C904F82
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 11:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2F41C21A8C
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 09:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6D16E86B;
	Wed, 12 Jun 2024 09:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZRiCKZ+R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B516E897;
	Wed, 12 Jun 2024 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185454; cv=none; b=lTLLaJH8DfriyaltAalzsU1b33GKXwDfidS0jcO86tm5IEjLt81Ch3+F1o9dreat74zHeF2WAUuCN9Br6uPyIFqFYj8gVJ1/8Sh6MhrMdx/FEbZ8zS+boxGe4FcO7EHKpTTSn52CdJPxhgR63s6OqlnttmLpIZ0RxRv46vn0F3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185454; c=relaxed/simple;
	bh=ki9N4hdiNstQ7/f/2N+OqLCfjD3Gul9xiX1UhiSamrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GaefD/oKRkx2UHI/3dUj/0OpfABSYIMGpwWZahRhhjUO3Indml4ur5NaZt70DECRtU6KuP2AMPVH9v5HaDxrQr6noC2LDoDj9X0g5120Oy9qY0mJbwz6iTqQZ6IqAmvmRsuApY2TWOfKNhyhdUqw2ENByKirwgLYhW8ieLX4VeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZRiCKZ+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD89AC3277B;
	Wed, 12 Jun 2024 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718185454;
	bh=ki9N4hdiNstQ7/f/2N+OqLCfjD3Gul9xiX1UhiSamrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRiCKZ+RPVaPnLZ/jb/mCOmlvg4ENR1xsA9k6ub5JeA4xs/9GBB7jQNPWSLATtSPS
	 DznK5zAyvf55YdI+K5PcSPqH7/qDex8TMrQqtmUUs4hXzwRUjkHUHTWHcvHRMfJFcm
	 9GAN+SdmBzTg/vrB+D1XDP4ZVj2t0w2AgRqRn3VI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.9.4
Date: Wed, 12 Jun 2024 11:44:00 +0200
Message-ID: <2024061259-stunned-swan-9fcc@gregkh>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024061258-squishier-canteen-6ba0@gregkh>
References: <2024061258-squishier-canteen-6ba0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
index b6a7cb32f61e..835b6db00c27 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-host.yaml
@@ -77,6 +77,9 @@ properties:
   vpcie12v-supply:
     description: The 12v regulator to use for PCIe.
 
+  iommu-map: true
+  iommu-map-mask: true
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
index 531008f0b6ac..002b728cbc71 100644
--- a/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
@@ -37,6 +37,7 @@ properties:
     description: This property is needed if using 24MHz OSC for RC's PHY.
 
   ep-gpios:
+    maxItems: 1
     description: pre-reset GPIO
 
   vpcie12v-supply:
diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index ba966a78a128..7543456862b8 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -198,7 +198,6 @@ allOf:
             enum:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
-              - qcom,x1e80100-qmp-gen3x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy
     then:
       properties:
diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 91a6cc38ff7f..c4c4fb38c51a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -71,7 +71,6 @@ required:
   - reg
   - clocks
   - clock-names
-  - power-domains
   - resets
   - reset-names
   - vdda-phy-supply
@@ -127,6 +126,21 @@ allOf:
             - const: ref
             - const: qref
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8996-qmp-ufs-phy
+              - qcom,msm8998-qmp-ufs-phy
+    then:
+      properties:
+        power-domains:
+          false
+    else:
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 0f200e3f97a9..fce7f8a19e9c 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -15,9 +15,6 @@ description: |
 properties:
   compatible:
     oneOf:
-      - enum:
-          - qcom,sc8180x-usb-hs-phy
-          - qcom,usb-snps-femto-v2-phy
       - items:
           - enum:
               - qcom,sa8775p-usb-hs-phy
@@ -26,6 +23,7 @@ properties:
       - items:
           - enum:
               - qcom,sc7280-usb-hs-phy
+              - qcom,sc8180x-usb-hs-phy
               - qcom,sdx55-usb-hs-phy
               - qcom,sdx65-usb-hs-phy
               - qcom,sm6375-usb-hs-phy
diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt7622-pinctrl.yaml
index bd72a326e6e0..60f30a59f385 100644
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
             description:
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
 
diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
index bb675c8ec220..1b941b276b3f 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
@@ -72,40 +72,24 @@ $defs:
         description:
           Specify the alternative function to be configured for the specified
           pins.
-        enum: [ gpio, atest_char, atest_char0, atest_char1, atest_char2,
-                atest_char3, atest_usb0, atest_usb00, atest_usb01, atest_usb02,
-                atest_usb03, audio_ref, cam_mclk, cci_async, cci_i2c,
-                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
-                cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, cri_trng,
-                cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1,
-                dp0_hot, gcc_gp1, gcc_gp2, gcc_gp3, host2wlan_sol, ibi_i3c,
-                jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
-                mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws,
-                mi2s2_data0, mi2s2_data1, mi2s2_sck, mi2s2_ws, mi2s_mclk0,
-                mi2s_mclk1, nav_gpio0, nav_gpio1, nav_gpio2, pcie0_clk,
-                phase_flag0, phase_flag1, phase_flag10, phase_flag11,
-                phase_flag12, phase_flag13, phase_flag14, phase_flag15,
-                phase_flag16, phase_flag17, phase_flag18, phase_flag19,
-                phase_flag2, phase_flag20, phase_flag21, phase_flag22,
-                phase_flag23, phase_flag24, phase_flag25, phase_flag26,
-                phase_flag27, phase_flag28, phase_flag29, phase_flag3,
-                phase_flag30, phase_flag31, phase_flag4, phase_flag5,
-                phase_flag6, phase_flag7, phase_flag8, phase_flag9,
-                pll_bist, pll_clk, prng_rosc0, prng_rosc1, prng_rosc2,
-                prng_rosc3, qdss_cti, qdss_gpio, qdss_gpio0, qdss_gpio1,
-                qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
-                qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5,
-                qdss_gpio6, qdss_gpio7, qdss_gpio8, qdss_gpio9, qlink0_enable,
-                qlink0_request, qlink0_wmss, qlink1_enable, qlink1_request,
-                qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss,
-                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4, qup0_se5,
-                qup0_se6, qup0_se7, qup1_se0, qup1_se1, qup1_se2, qup1_se3,
-                qup1_se4, qup1_se5, qup1_se6, sd_write, tb_trig, tgu_ch0,
-                tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
-                tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk,
-                uim0_data, uim0_present, uim0_reset, uim1_clk, uim1_data,
-                uim1_present, uim1_reset, usb0_hs, usb0_phy, vfr_0, vfr_1,
-                vsense_trigger ]
+        enum: [ gpio, atest_char, atest_usb0, audio_ref_clk, cam_mclk,
+                cci_async_in0, cci_i2c, cci, cmu_rng, coex_uart1_rx,
+                coex_uart1_tx, cri_trng, dbg_out_clk, ddr_bist,
+                ddr_pxi0_test, ddr_pxi1_test, gcc_gp1_clk, gcc_gp2_clk,
+                gcc_gp3_clk, host2wlan_sol, ibi_i3c_qup0, ibi_i3c_qup1,
+                jitter_bist_ref, mdp_vsync0_out, mdp_vsync1_out,
+                mdp_vsync2_out, mdp_vsync3_out, mdp_vsync, nav,
+                pcie0_clk_req, phase_flag, pll_bist_sync, pll_clk_aux,
+                prng_rosc, qdss_cti_trig0, qdss_cti_trig1, qdss_gpio,
+                qlink0_enable, qlink0_request, qlink0_wmss_reset,
+                qup0_se0, qup0_se1, qup0_se2, qup0_se3, qup0_se4,
+                qup1_se0, qup1_se1, qup1_se2, qup1_se2_l2, qup1_se3,
+                qup1_se4, sd_write_protect, tb_trig_sdc1, tb_trig_sdc2,
+                tgu_ch0_trigout, tgu_ch1_trigout, tgu_ch2_trigout,
+                tgu_ch3_trigout, tmess_prng, tsense_pwm1_out,
+                tsense_pwm2_out, uim0, uim1, usb0_hs_ac, usb0_phy_ps,
+                vfr_0_mira, vfr_0_mirb, vfr_1, vsense_trigger_mirnat,
+                wlan1_adc_dtest0, wlan1_adc_dtest1 ]
 
         required:
           - pins
diff --git a/Documentation/driver-api/fpga/fpga-bridge.rst b/Documentation/driver-api/fpga/fpga-bridge.rst
index 604208534095..833f68fb0700 100644
--- a/Documentation/driver-api/fpga/fpga-bridge.rst
+++ b/Documentation/driver-api/fpga/fpga-bridge.rst
@@ -6,9 +6,12 @@ API to implement a new FPGA bridge
 
 * struct fpga_bridge - The FPGA Bridge structure
 * struct fpga_bridge_ops - Low level Bridge driver ops
-* fpga_bridge_register() - Create and register a bridge
+* __fpga_bridge_register() - Create and register a bridge
 * fpga_bridge_unregister() - Unregister a bridge
 
+The helper macro ``fpga_bridge_register()`` automatically sets
+the module that registers the FPGA bridge as the owner.
+
 .. kernel-doc:: include/linux/fpga/fpga-bridge.h
    :functions: fpga_bridge
 
@@ -16,7 +19,7 @@ API to implement a new FPGA bridge
    :functions: fpga_bridge_ops
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
-   :functions: fpga_bridge_register
+   :functions: __fpga_bridge_register
 
 .. kernel-doc:: drivers/fpga/fpga-bridge.c
    :functions: fpga_bridge_unregister
diff --git a/Documentation/driver-api/fpga/fpga-mgr.rst b/Documentation/driver-api/fpga/fpga-mgr.rst
index 49c0a9512653..8d2b79f696c1 100644
--- a/Documentation/driver-api/fpga/fpga-mgr.rst
+++ b/Documentation/driver-api/fpga/fpga-mgr.rst
@@ -24,7 +24,8 @@ How to support a new FPGA device
 --------------------------------
 
 To add another FPGA manager, write a driver that implements a set of ops.  The
-probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
+probe function calls ``fpga_mgr_register()`` or ``fpga_mgr_register_full()``,
+such as::
 
 	static const struct fpga_manager_ops socfpga_fpga_ops = {
 		.write_init = socfpga_fpga_ops_configure_init,
@@ -69,10 +70,11 @@ probe function calls fpga_mgr_register() or fpga_mgr_register_full(), such as::
 	}
 
 Alternatively, the probe function could call one of the resource managed
-register functions, devm_fpga_mgr_register() or devm_fpga_mgr_register_full().
-When these functions are used, the parameter syntax is the same, but the call
-to fpga_mgr_unregister() should be removed. In the above example, the
-socfpga_fpga_remove() function would not be required.
+register functions, ``devm_fpga_mgr_register()`` or
+``devm_fpga_mgr_register_full()``.  When these functions are used, the
+parameter syntax is the same, but the call to ``fpga_mgr_unregister()`` should be
+removed. In the above example, the ``socfpga_fpga_remove()`` function would not be
+required.
 
 The ops will implement whatever device specific register writes are needed to
 do the programming sequence for this particular FPGA.  These ops return 0 for
@@ -125,15 +127,19 @@ API for implementing a new FPGA Manager driver
 * struct fpga_manager -  the FPGA manager struct
 * struct fpga_manager_ops -  Low level FPGA manager driver ops
 * struct fpga_manager_info -  Parameter structure for fpga_mgr_register_full()
-* fpga_mgr_register_full() -  Create and register an FPGA manager using the
+* __fpga_mgr_register_full() -  Create and register an FPGA manager using the
   fpga_mgr_info structure to provide the full flexibility of options
-* fpga_mgr_register() -  Create and register an FPGA manager using standard
+* __fpga_mgr_register() -  Create and register an FPGA manager using standard
   arguments
-* devm_fpga_mgr_register_full() -  Resource managed version of
-  fpga_mgr_register_full()
-* devm_fpga_mgr_register() -  Resource managed version of fpga_mgr_register()
+* __devm_fpga_mgr_register_full() -  Resource managed version of
+  __fpga_mgr_register_full()
+* __devm_fpga_mgr_register() -  Resource managed version of __fpga_mgr_register()
 * fpga_mgr_unregister() -  Unregister an FPGA manager
 
+Helper macros ``fpga_mgr_register_full()``, ``fpga_mgr_register()``,
+``devm_fpga_mgr_register_full()``, and ``devm_fpga_mgr_register()`` are available
+to ease the registration.
+
 .. kernel-doc:: include/linux/fpga/fpga-mgr.h
    :functions: fpga_mgr_states
 
@@ -147,16 +153,16 @@ API for implementing a new FPGA Manager driver
    :functions: fpga_manager_info
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register_full
+   :functions: __fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: fpga_mgr_register
+   :functions: __fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register_full
+   :functions: __devm_fpga_mgr_register_full
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
-   :functions: devm_fpga_mgr_register
+   :functions: __devm_fpga_mgr_register
 
 .. kernel-doc:: drivers/fpga/fpga-mgr.c
    :functions: fpga_mgr_unregister
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
diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
index 91cabb7d8d05..130f9e97cc17 100644
--- a/Documentation/iio/adis16475.rst
+++ b/Documentation/iio/adis16475.rst
@@ -66,11 +66,9 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_x_calibbias                      | Calibration offset for the X-axis accelerometer channel. |
 +-------------------------------------------+----------------------------------------------------------+
-| in_accel_calibbias_x                      | x-axis acceleration offset correction                    |
-+-------------------------------------------+----------------------------------------------------------+
 | in_accel_x_raw                            | Raw X-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
-| in_accel_calibbias_y                      | y-axis acceleration offset correction                    |
+| in_accel_y_calibbias                      | Calibration offset for the Y-axis accelerometer channel. |
 +-------------------------------------------+----------------------------------------------------------+
 | in_accel_y_raw                            | Raw Y-axis accelerometer channel value.                  |
 +-------------------------------------------+----------------------------------------------------------+
@@ -94,11 +92,9 @@ specific device folder path ``/sys/bus/iio/devices/iio:deviceX``.
 +---------------------------------------+------------------------------------------------------+
 | in_anglvel_x_calibbias                | Calibration offset for the X-axis gyroscope channel. |
 +---------------------------------------+------------------------------------------------------+
-| in_anglvel_calibbias_x                | x-axis gyroscope offset correction                   |
-+---------------------------------------+------------------------------------------------------+
 | in_anglvel_x_raw                      | Raw X-axis gyroscope channel value.                  |
 +---------------------------------------+------------------------------------------------------+
-| in_anglvel_calibbias_y                | y-axis gyroscope offset correction                   |
+| in_anglvel_y_calibbias                | Calibration offset for the Y-axis gyroscope channel. |
 +---------------------------------------+------------------------------------------------------+
 | in_anglvel_y_raw                      | Raw Y-axis gyroscope channel value.                  |
 +---------------------------------------+------------------------------------------------------+
diff --git a/Makefile b/Makefile
index 8def0819eb55..91f1d4d34e80 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 9
-SUBLEVEL = 3
+SUBLEVEL = 4
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
index ce90b35686a2..10896f9df682 100644
--- a/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-s4.dtsi
@@ -65,10 +65,15 @@ xtal: xtal-clk {
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
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index c4a0a35e02c7..6cda738a4157 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -195,6 +195,23 @@ void kvm_arch_create_vm_debugfs(struct kvm *kvm)
 	kvm_sys_regs_create_debugfs(kvm);
 }
 
+static void kvm_destroy_mpidr_data(struct kvm *kvm)
+{
+	struct kvm_mpidr_data *data;
+
+	mutex_lock(&kvm->arch.config_lock);
+
+	data = rcu_dereference_protected(kvm->arch.mpidr_data,
+					 lockdep_is_held(&kvm->arch.config_lock));
+	if (data) {
+		rcu_assign_pointer(kvm->arch.mpidr_data, NULL);
+		synchronize_rcu();
+		kfree(data);
+	}
+
+	mutex_unlock(&kvm->arch.config_lock);
+}
+
 /**
  * kvm_arch_destroy_vm - destroy the VM data structure
  * @kvm:	pointer to the KVM struct
@@ -209,7 +226,8 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	if (is_protected_kvm_enabled())
 		pkvm_destroy_hyp_vm(kvm);
 
-	kfree(kvm->arch.mpidr_data);
+	kvm_destroy_mpidr_data(kvm);
+
 	kfree(kvm->arch.sysreg_masks);
 	kvm_destroy_vcpus(kvm);
 
@@ -395,6 +413,13 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.hw_mmu = &vcpu->kvm->arch.mmu;
 
+	/*
+	 * This vCPU may have been created after mpidr_data was initialized.
+	 * Throw out the pre-computed mappings if that is the case which forces
+	 * KVM to fall back to iteratively searching the vCPUs.
+	 */
+	kvm_destroy_mpidr_data(vcpu->kvm);
+
 	err = kvm_vgic_vcpu_init(vcpu);
 	if (err)
 		return err;
@@ -594,7 +619,8 @@ static void kvm_init_mpidr_data(struct kvm *kvm)
 
 	mutex_lock(&kvm->arch.config_lock);
 
-	if (kvm->arch.mpidr_data || atomic_read(&kvm->online_vcpus) == 1)
+	if (rcu_access_pointer(kvm->arch.mpidr_data) ||
+	    atomic_read(&kvm->online_vcpus) == 1)
 		goto out;
 
 	kvm_for_each_vcpu(c, vcpu, kvm) {
@@ -631,7 +657,7 @@ static void kvm_init_mpidr_data(struct kvm *kvm)
 		data->cmpidr_to_idx[index] = c;
 	}
 
-	kvm->arch.mpidr_data = data;
+	rcu_assign_pointer(kvm->arch.mpidr_data, data);
 out:
 	mutex_unlock(&kvm->arch.config_lock);
 }
@@ -2470,21 +2496,27 @@ static int __init init_hyp_mode(void)
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
 {
-	struct kvm_vcpu *vcpu;
+	struct kvm_vcpu *vcpu = NULL;
+	struct kvm_mpidr_data *data;
 	unsigned long i;
 
 	mpidr &= MPIDR_HWID_BITMASK;
 
-	if (kvm->arch.mpidr_data) {
-		u16 idx = kvm_mpidr_index(kvm->arch.mpidr_data, mpidr);
+	rcu_read_lock();
+	data = rcu_dereference(kvm->arch.mpidr_data);
 
-		vcpu = kvm_get_vcpu(kvm,
-				    kvm->arch.mpidr_data->cmpidr_to_idx[idx]);
+	if (data) {
+		u16 idx = kvm_mpidr_index(data, mpidr);
+
+		vcpu = kvm_get_vcpu(kvm, data->cmpidr_to_idx[idx]);
 		if (mpidr != kvm_vcpu_get_mpidr_aff(vcpu))
 			vcpu = NULL;
+	}
 
+	rcu_read_unlock();
+
+	if (vcpu)
 		return vcpu;
-	}
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		if (mpidr == kvm_vcpu_get_mpidr_aff(vcpu))
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
diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a41e542ba94d..51172625fa3a 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -570,7 +570,7 @@ struct hvcall_mpp_data {
 	unsigned long backing_mem;
 };
 
-int h_get_mpp(struct hvcall_mpp_data *);
+long h_get_mpp(struct hvcall_mpp_data *mpp_data);
 
 struct hvcall_mpp_x_data {
 	unsigned long coalesced_bytes;
diff --git a/arch/powerpc/include/asm/ppc-opcode.h b/arch/powerpc/include/asm/ppc-opcode.h
index 005601243dda..076ae60b4a55 100644
--- a/arch/powerpc/include/asm/ppc-opcode.h
+++ b/arch/powerpc/include/asm/ppc-opcode.h
@@ -510,6 +510,7 @@
 #define PPC_RAW_STB(r, base, i)		(0x98000000 | ___PPC_RS(r) | ___PPC_RA(base) | IMM_L(i))
 #define PPC_RAW_LBZ(r, base, i)		(0x88000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_L(i))
 #define PPC_RAW_LDX(r, base, b)		(0x7c00002a | ___PPC_RT(r) | ___PPC_RA(base) | ___PPC_RB(b))
+#define PPC_RAW_LHA(r, base, i)		(0xa8000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_L(i))
 #define PPC_RAW_LHZ(r, base, i)		(0xa0000000 | ___PPC_RT(r) | ___PPC_RA(base) | IMM_L(i))
 #define PPC_RAW_LHBRX(r, base, b)	(0x7c00062c | ___PPC_RT(r) | ___PPC_RA(base) | ___PPC_RB(b))
 #define PPC_RAW_LWBRX(r, base, b)	(0x7c00042c | ___PPC_RT(r) | ___PPC_RA(base) | ___PPC_RB(b))
@@ -532,6 +533,7 @@
 #define PPC_RAW_MULW(d, a, b)		(0x7c0001d6 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_MULHWU(d, a, b)		(0x7c000016 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_MULI(d, a, i)		(0x1c000000 | ___PPC_RT(d) | ___PPC_RA(a) | IMM_L(i))
+#define PPC_RAW_DIVW(d, a, b)		(0x7c0003d6 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_DIVWU(d, a, b)		(0x7c000396 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_DIVDU(d, a, b)		(0x7c000392 | ___PPC_RT(d) | ___PPC_RA(a) | ___PPC_RB(b))
 #define PPC_RAW_DIVDE(t, a, b)		(0x7c000352 | ___PPC_RT(t) | ___PPC_RA(a) | ___PPC_RB(b))
@@ -550,6 +552,8 @@
 #define PPC_RAW_XOR(d, a, b)		(0x7c000278 | ___PPC_RA(d) | ___PPC_RS(a) | ___PPC_RB(b))
 #define PPC_RAW_XORI(d, a, i)		(0x68000000 | ___PPC_RA(d) | ___PPC_RS(a) | IMM_L(i))
 #define PPC_RAW_XORIS(d, a, i)		(0x6c000000 | ___PPC_RA(d) | ___PPC_RS(a) | IMM_L(i))
+#define PPC_RAW_EXTSB(d, a)		(0x7c000774 | ___PPC_RA(d) | ___PPC_RS(a))
+#define PPC_RAW_EXTSH(d, a)		(0x7c000734 | ___PPC_RA(d) | ___PPC_RS(a))
 #define PPC_RAW_EXTSW(d, a)		(0x7c0007b4 | ___PPC_RA(d) | ___PPC_RS(a))
 #define PPC_RAW_SLW(d, a, s)		(0x7c000030 | ___PPC_RA(d) | ___PPC_RS(a) | ___PPC_RB(s))
 #define PPC_RAW_SLD(d, a, s)		(0x7c000036 | ___PPC_RA(d) | ___PPC_RS(a) | ___PPC_RB(s))
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 8e86eb577eb8..692a7c6f5fd9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4857,7 +4857,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 	 * entering a nested guest in which case the decrementer is now owned
 	 * by L2 and the L1 decrementer is provided in hdec_expires
 	 */
-	if (!kvmhv_is_nestedv2() && kvmppc_core_pending_dec(vcpu) &&
+	if (kvmppc_core_pending_dec(vcpu) &&
 			((tb < kvmppc_dec_expires_host_tb(vcpu)) ||
 			 (trap == BOOK3S_INTERRUPT_SYSCALL &&
 			  kvmppc_get_gpr(vcpu, 3) == H_ENTER_NESTED)))
diff --git a/arch/powerpc/kvm/book3s_hv_nestedv2.c b/arch/powerpc/kvm/book3s_hv_nestedv2.c
index 8e6f5355f08b..1091f7a83b25 100644
--- a/arch/powerpc/kvm/book3s_hv_nestedv2.c
+++ b/arch/powerpc/kvm/book3s_hv_nestedv2.c
@@ -71,8 +71,8 @@ gs_msg_ops_kvmhv_nestedv2_config_fill_info(struct kvmppc_gs_buff *gsb,
 	}
 
 	if (kvmppc_gsm_includes(gsm, KVMPPC_GSID_RUN_OUTPUT)) {
-		kvmppc_gse_put_buff_info(gsb, KVMPPC_GSID_RUN_OUTPUT,
-					 cfg->vcpu_run_output_cfg);
+		rc = kvmppc_gse_put_buff_info(gsb, KVMPPC_GSID_RUN_OUTPUT,
+					      cfg->vcpu_run_output_cfg);
 		if (rc < 0)
 			return rc;
 	}
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 2f39c50ca729..43b97032a91c 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -450,10 +450,16 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			}
 			break;
 		case BPF_ALU | BPF_DIV | BPF_X: /* (u32) dst /= (u32) src */
-			EMIT(PPC_RAW_DIVWU(dst_reg, src2_reg, src_reg));
+			if (off)
+				EMIT(PPC_RAW_DIVW(dst_reg, src2_reg, src_reg));
+			else
+				EMIT(PPC_RAW_DIVWU(dst_reg, src2_reg, src_reg));
 			break;
 		case BPF_ALU | BPF_MOD | BPF_X: /* (u32) dst %= (u32) src */
-			EMIT(PPC_RAW_DIVWU(_R0, src2_reg, src_reg));
+			if (off)
+				EMIT(PPC_RAW_DIVW(_R0, src2_reg, src_reg));
+			else
+				EMIT(PPC_RAW_DIVWU(_R0, src2_reg, src_reg));
 			EMIT(PPC_RAW_MULW(_R0, src_reg, _R0));
 			EMIT(PPC_RAW_SUB(dst_reg, src2_reg, _R0));
 			break;
@@ -467,10 +473,16 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (imm == 1) {
 				EMIT(PPC_RAW_MR(dst_reg, src2_reg));
 			} else if (is_power_of_2((u32)imm)) {
-				EMIT(PPC_RAW_SRWI(dst_reg, src2_reg, ilog2(imm)));
+				if (off)
+					EMIT(PPC_RAW_SRAWI(dst_reg, src2_reg, ilog2(imm)));
+				else
+					EMIT(PPC_RAW_SRWI(dst_reg, src2_reg, ilog2(imm)));
 			} else {
 				PPC_LI32(_R0, imm);
-				EMIT(PPC_RAW_DIVWU(dst_reg, src2_reg, _R0));
+				if (off)
+					EMIT(PPC_RAW_DIVW(dst_reg, src2_reg, _R0));
+				else
+					EMIT(PPC_RAW_DIVWU(dst_reg, src2_reg, _R0));
 			}
 			break;
 		case BPF_ALU | BPF_MOD | BPF_K: /* (u32) dst %= (u32) imm */
@@ -480,11 +492,19 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			if (!is_power_of_2((u32)imm)) {
 				bpf_set_seen_register(ctx, tmp_reg);
 				PPC_LI32(tmp_reg, imm);
-				EMIT(PPC_RAW_DIVWU(_R0, src2_reg, tmp_reg));
+				if (off)
+					EMIT(PPC_RAW_DIVW(_R0, src2_reg, tmp_reg));
+				else
+					EMIT(PPC_RAW_DIVWU(_R0, src2_reg, tmp_reg));
 				EMIT(PPC_RAW_MULW(_R0, tmp_reg, _R0));
 				EMIT(PPC_RAW_SUB(dst_reg, src2_reg, _R0));
 			} else if (imm == 1) {
 				EMIT(PPC_RAW_LI(dst_reg, 0));
+			} else if (off) {
+				EMIT(PPC_RAW_SRAWI(_R0, src2_reg, ilog2(imm)));
+				EMIT(PPC_RAW_ADDZE(_R0, _R0));
+				EMIT(PPC_RAW_SLWI(_R0, _R0, ilog2(imm)));
+				EMIT(PPC_RAW_SUB(dst_reg, src2_reg, _R0));
 			} else {
 				imm = ilog2((u32)imm);
 				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 0, 32 - imm, 31));
@@ -497,11 +517,21 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				imm = -imm;
 			if (!is_power_of_2(imm))
 				return -EOPNOTSUPP;
-			if (imm == 1)
+			if (imm == 1) {
 				EMIT(PPC_RAW_LI(dst_reg, 0));
-			else
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			} else if (off) {
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, src2_reg_h, 31));
+				EMIT(PPC_RAW_XOR(dst_reg, src2_reg, dst_reg_h));
+				EMIT(PPC_RAW_SUBFC(dst_reg, dst_reg_h, dst_reg));
+				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 32 - ilog2(imm), 31));
+				EMIT(PPC_RAW_XOR(dst_reg, dst_reg, dst_reg_h));
+				EMIT(PPC_RAW_SUBFC(dst_reg, dst_reg_h, dst_reg));
+				EMIT(PPC_RAW_SUBFE(dst_reg_h, dst_reg_h, dst_reg_h));
+			} else {
 				EMIT(PPC_RAW_RLWINM(dst_reg, src2_reg, 0, 32 - ilog2(imm), 31));
-			EMIT(PPC_RAW_LI(dst_reg_h, 0));
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			}
 			break;
 		case BPF_ALU64 | BPF_DIV | BPF_K: /* dst /= imm */
 			if (!imm)
@@ -727,15 +757,30 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * MOV
 		 */
 		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
-			if (dst_reg == src_reg)
-				break;
-			EMIT(PPC_RAW_MR(dst_reg, src_reg));
-			EMIT(PPC_RAW_MR(dst_reg_h, src_reg_h));
+			if (off == 8) {
+				EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg, 31));
+			} else if (off == 16) {
+				EMIT(PPC_RAW_EXTSH(dst_reg, src_reg));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg, 31));
+			} else if (off == 32 && dst_reg == src_reg) {
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, src_reg, 31));
+			} else if (off == 32) {
+				EMIT(PPC_RAW_MR(dst_reg, src_reg));
+				EMIT(PPC_RAW_SRAWI(dst_reg_h, src_reg, 31));
+			} else if (dst_reg != src_reg) {
+				EMIT(PPC_RAW_MR(dst_reg, src_reg));
+				EMIT(PPC_RAW_MR(dst_reg_h, src_reg_h));
+			}
 			break;
 		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
 			/* special mov32 for zext */
 			if (imm == 1)
 				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			else if (off == 8)
+				EMIT(PPC_RAW_EXTSB(dst_reg, src_reg));
+			else if (off == 16)
+				EMIT(PPC_RAW_EXTSH(dst_reg, src_reg));
 			else if (dst_reg != src_reg)
 				EMIT(PPC_RAW_MR(dst_reg, src_reg));
 			break;
@@ -751,6 +796,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * BPF_FROM_BE/LE
 		 */
 		case BPF_ALU | BPF_END | BPF_FROM_LE:
+		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
 			switch (imm) {
 			case 16:
 				/* Copy 16 bits to upper part */
@@ -785,6 +831,8 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				EMIT(PPC_RAW_MR(dst_reg_h, tmp_reg));
 				break;
 			}
+			if (BPF_CLASS(code) == BPF_ALU64 && imm != 64)
+				EMIT(PPC_RAW_LI(dst_reg_h, 0));
 			break;
 		case BPF_ALU | BPF_END | BPF_FROM_BE:
 			switch (imm) {
@@ -918,11 +966,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		 * BPF_LDX
 		 */
 		case BPF_LDX | BPF_MEM | BPF_B: /* dst = *(u8 *)(ul) (src + off) */
+		case BPF_LDX | BPF_MEMSX | BPF_B:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_B:
 		case BPF_LDX | BPF_MEM | BPF_H: /* dst = *(u16 *)(ul) (src + off) */
+		case BPF_LDX | BPF_MEMSX | BPF_H:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_H:
 		case BPF_LDX | BPF_MEM | BPF_W: /* dst = *(u32 *)(ul) (src + off) */
+		case BPF_LDX | BPF_MEMSX | BPF_W:
 		case BPF_LDX | BPF_PROBE_MEM | BPF_W:
+		case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
 		case BPF_LDX | BPF_MEM | BPF_DW: /* dst = *(u64 *)(ul) (src + off) */
 		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
 			/*
@@ -931,7 +985,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			 * load only if addr is kernel address (see is_kernel_addr()), otherwise
 			 * set dst_reg=0 and move on.
 			 */
-			if (BPF_MODE(code) == BPF_PROBE_MEM) {
+			if (BPF_MODE(code) == BPF_PROBE_MEM || BPF_MODE(code) == BPF_PROBE_MEMSX) {
 				PPC_LI32(_R0, TASK_SIZE - off);
 				EMIT(PPC_RAW_CMPLW(src_reg, _R0));
 				PPC_BCC_SHORT(COND_GT, (ctx->idx + 4) * 4);
@@ -953,30 +1007,48 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				 * as there are two load instructions for dst_reg_h & dst_reg
 				 * respectively.
 				 */
-				if (size == BPF_DW)
+				if (size == BPF_DW ||
+				    (size == BPF_B && BPF_MODE(code) == BPF_PROBE_MEMSX))
 					PPC_JMP((ctx->idx + 3) * 4);
 				else
 					PPC_JMP((ctx->idx + 2) * 4);
 			}
 
-			switch (size) {
-			case BPF_B:
-				EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
-				break;
-			case BPF_H:
-				EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
-				break;
-			case BPF_W:
-				EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
-				break;
-			case BPF_DW:
-				EMIT(PPC_RAW_LWZ(dst_reg_h, src_reg, off));
-				EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off + 4));
-				break;
-			}
+			if (BPF_MODE(code) == BPF_MEMSX || BPF_MODE(code) == BPF_PROBE_MEMSX) {
+				switch (size) {
+				case BPF_B:
+					EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
+					EMIT(PPC_RAW_EXTSB(dst_reg, dst_reg));
+					break;
+				case BPF_H:
+					EMIT(PPC_RAW_LHA(dst_reg, src_reg, off));
+					break;
+				case BPF_W:
+					EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
+					break;
+				}
+				if (!fp->aux->verifier_zext)
+					EMIT(PPC_RAW_SRAWI(dst_reg_h, dst_reg, 31));
 
-			if (size != BPF_DW && !fp->aux->verifier_zext)
-				EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			} else {
+				switch (size) {
+				case BPF_B:
+					EMIT(PPC_RAW_LBZ(dst_reg, src_reg, off));
+					break;
+				case BPF_H:
+					EMIT(PPC_RAW_LHZ(dst_reg, src_reg, off));
+					break;
+				case BPF_W:
+					EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off));
+					break;
+				case BPF_DW:
+					EMIT(PPC_RAW_LWZ(dst_reg_h, src_reg, off));
+					EMIT(PPC_RAW_LWZ(dst_reg, src_reg, off + 4));
+					break;
+				}
+				if (size != BPF_DW && !fp->aux->verifier_zext)
+					EMIT(PPC_RAW_LI(dst_reg_h, 0));
+			}
 
 			if (BPF_MODE(code) == BPF_PROBE_MEM) {
 				int insn_idx = ctx->idx - 1;
@@ -1068,6 +1140,9 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 		case BPF_JMP | BPF_JA:
 			PPC_JMP(addrs[i + 1 + off]);
 			break;
+		case BPF_JMP32 | BPF_JA:
+			PPC_JMP(addrs[i + 1 + imm]);
+			break;
 
 		case BPF_JMP | BPF_JGT | BPF_K:
 		case BPF_JMP | BPF_JGT | BPF_X:
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 4e9916bb03d7..c1d8bee8f701 100644
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
index f73c4d1c26af..0ed56e56271f 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -113,8 +113,8 @@ struct hvcall_ppp_data {
  */
 static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
-	unsigned long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	long rc;
 
 	rc = plpar_hcall9(H_GET_PPP, retbuf);
 
@@ -193,7 +193,7 @@ static void parse_ppp_data(struct seq_file *m)
 	struct hvcall_ppp_data ppp_data;
 	struct device_node *root;
 	const __be32 *perf_level;
-	int rc;
+	long rc;
 
 	rc = h_get_ppp(&ppp_data);
 	if (rc)
@@ -361,8 +361,8 @@ static int read_dt_lpar_name(struct seq_file *m)
 
 static void read_lpar_name(struct seq_file *m)
 {
-	if (read_rtas_lpar_name(m) && read_dt_lpar_name(m))
-		pr_err_once("Error can't get the LPAR name");
+	if (read_rtas_lpar_name(m))
+		read_dt_lpar_name(m);
 }
 
 #define SPLPAR_MAXLENGTH 1026*(sizeof(char))
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 45b58b6f3df8..2b3e952513e4 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -279,24 +279,6 @@ &i2c6 {
 	status = "okay";
 };
 
-&i2srx {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2srx_pins>;
-	status = "okay";
-};
-
-&i2stx0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mclk_ext_pins>;
-	status = "okay";
-};
-
-&i2stx1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2stx1_pins>;
-	status = "okay";
-};
-
 &mmc0 {
 	max-frequency = <100000000>;
 	assigned-clocks = <&syscrg JH7110_SYSCLK_SDIO0_SDCARD>;
@@ -447,46 +429,6 @@ GPOEN_SYS_I2C6_DATA,
 		};
 	};
 
-	i2srx_pins: i2srx-0 {
-		clk-sd-pins {
-			pinmux = <GPIOMUX(38, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_BCLK)>,
-				 <GPIOMUX(63, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_LRCK)>,
-				 <GPIOMUX(38, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2STX1_BCLK)>,
-				 <GPIOMUX(63, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2STX1_LRCK)>,
-				 <GPIOMUX(61, GPOUT_LOW,
-					      GPOEN_DISABLE,
-					      GPI_SYS_I2SRX_SDIN0)>;
-			input-enable;
-		};
-	};
-
-	i2stx1_pins: i2stx1-0 {
-		sd-pins {
-			pinmux = <GPIOMUX(44, GPOUT_SYS_I2STX1_SDO0,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-disable;
-			input-disable;
-		};
-	};
-
-	mclk_ext_pins: mclk-ext-0 {
-		mclk-ext-pins {
-			pinmux = <GPIOMUX(4, GPOUT_LOW,
-					     GPOEN_DISABLE,
-					     GPI_SYS_MCLK_EXT)>;
-			input-enable;
-		};
-	};
-
 	mmc0_pins: mmc0-0 {
 		 rst-pins {
 			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
@@ -622,40 +564,6 @@ GPOEN_ENABLE,
 		};
 	};
 
-	tdm_pins: tdm-0 {
-		tx-pins {
-			pinmux = <GPIOMUX(44, GPOUT_SYS_TDM_TXD,
-					      GPOEN_ENABLE,
-					      GPI_NONE)>;
-			bias-pull-up;
-			drive-strength = <2>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-
-		rx-pins {
-			pinmux = <GPIOMUX(61, GPOUT_HIGH,
-					      GPOEN_DISABLE,
-					      GPI_SYS_TDM_RXD)>;
-			input-enable;
-		};
-
-		sync-pins {
-			pinmux = <GPIOMUX(63, GPOUT_HIGH,
-					      GPOEN_DISABLE,
-					      GPI_SYS_TDM_SYNC)>;
-			input-enable;
-		};
-
-		pcmclk-pins {
-			pinmux = <GPIOMUX(38, GPOUT_HIGH,
-					      GPOEN_DISABLE,
-					      GPI_SYS_TDM_CLK)>;
-			input-enable;
-		};
-	};
-
 	uart0_pins: uart0-0 {
 		tx-pins {
 			pinmux = <GPIOMUX(5, GPOUT_SYS_UART0_TX,
@@ -681,12 +589,6 @@ GPOEN_DISABLE,
 	};
 };
 
-&tdm {
-	pinctrl-names = "default";
-	pinctrl-0 = <&tdm_pins>;
-	status = "okay";
-};
-
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 6e68f8dff76b..0fab508a65b3 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -370,6 +370,8 @@ static inline int sbi_remote_fence_i(const struct cpumask *cpu_mask) { return -1
 static inline void sbi_init(void) {}
 #endif /* CONFIG_RISCV_SBI */
 
+unsigned long riscv_get_mvendorid(void);
+unsigned long riscv_get_marchid(void);
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id);
 unsigned long riscv_cached_marchid(unsigned int cpu_id);
 unsigned long riscv_cached_mimpid(unsigned int cpu_id);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index d11d6320fb0d..c1f3655238fd 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -139,6 +139,34 @@ int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 	return -1;
 }
 
+unsigned long __init riscv_get_marchid(void)
+{
+	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
+
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
+	ci->marchid = csr_read(CSR_MARCHID);
+#else
+	ci->marchid = 0;
+#endif
+	return ci->marchid;
+}
+
+unsigned long __init riscv_get_mvendorid(void)
+{
+	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
+
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+#elif IS_ENABLED(CONFIG_RISCV_M_MODE)
+	ci->mvendorid = csr_read(CSR_MVENDORID);
+#else
+	ci->mvendorid = 0;
+#endif
+	return ci->mvendorid;
+}
+
 DEFINE_PER_CPU(struct riscv_cpuinfo, riscv_cpuinfo);
 
 unsigned long riscv_cached_mvendorid(unsigned int cpu_id)
@@ -170,12 +198,16 @@ static int riscv_cpuinfo_starting(unsigned int cpu)
 	struct riscv_cpuinfo *ci = this_cpu_ptr(&riscv_cpuinfo);
 
 #if IS_ENABLED(CONFIG_RISCV_SBI)
-	ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
-	ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
+	if (!ci->mvendorid)
+		ci->mvendorid = sbi_spec_is_0_1() ? 0 : sbi_get_mvendorid();
+	if (!ci->marchid)
+		ci->marchid = sbi_spec_is_0_1() ? 0 : sbi_get_marchid();
 	ci->mimpid = sbi_spec_is_0_1() ? 0 : sbi_get_mimpid();
 #elif IS_ENABLED(CONFIG_RISCV_M_MODE)
-	ci->mvendorid = csr_read(CSR_MVENDORID);
-	ci->marchid = csr_read(CSR_MARCHID);
+	if (!ci->mvendorid)
+		ci->mvendorid = csr_read(CSR_MVENDORID);
+	if (!ci->marchid)
+		ci->marchid = csr_read(CSR_MARCHID);
 	ci->mimpid = csr_read(CSR_MIMPID);
 #else
 	ci->mvendorid = 0;
diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 1cc7df740edd..e6fbaaf54956 100644
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
index 613872b0a21a..24869eb88908 100644
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
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3ed2359eae35..5ef48cb20ee1 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -490,6 +490,8 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 	struct acpi_table_header *rhct;
 	acpi_status status;
 	unsigned int cpu;
+	u64 boot_vendorid;
+	u64 boot_archid;
 
 	if (!acpi_disabled) {
 		status = acpi_get_table(ACPI_SIG_RHCT, 0, &rhct);
@@ -497,6 +499,9 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 			return;
 	}
 
+	boot_vendorid = riscv_get_mvendorid();
+	boot_archid = riscv_get_marchid();
+
 	for_each_possible_cpu(cpu) {
 		struct riscv_isainfo *isainfo = &hart_isa[cpu];
 		unsigned long this_hwcap = 0;
@@ -544,8 +549,7 @@ static void __init riscv_fill_hwcap_from_isa_string(unsigned long *isa2hwcap)
 		 * CPU cores with the ratified spec will contain non-zero
 		 * marchid.
 		 */
-		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
-		    riscv_cached_marchid(cpu) == 0x0) {
+		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
 			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
 			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
 		}
@@ -599,7 +603,7 @@ static int __init riscv_fill_hwcap_from_ext_list(unsigned long *isa2hwcap)
 
 			if (ext->subset_ext_size) {
 				for (int j = 0; j < ext->subset_ext_size; j++) {
-					if (riscv_isa_extension_check(ext->subset_ext_ids[i]))
+					if (riscv_isa_extension_check(ext->subset_ext_ids[j]))
 						set_bit(ext->subset_ext_ids[j], isainfo->isa);
 				}
 			}
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index d41090fc3203..4b3c50da48ba 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -26,7 +26,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 
-#include <asm/cpufeature.h>
+#include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
@@ -234,9 +234,10 @@ asmlinkage __visible void smp_callin(void)
 	riscv_user_isa_enable();
 
 	/*
-	 * Remote TLB flushes are ignored while the CPU is offline, so emit
-	 * a local TLB flush right now just in case.
+	 * Remote cache and TLB flushes are ignored while the CPU is offline,
+	 * so flush them both right now just in case.
 	 */
+	local_flush_icache_all();
 	local_flush_tlb_all();
 	complete(&cpu_running);
 	/*
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 64a9c093aef9..528ec7cc9a62 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -18,6 +18,16 @@
 
 extern asmlinkage void ret_from_exception(void);
 
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
@@ -41,21 +51,19 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
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
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 6cf89314209a..9e2c9027e986 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -32,7 +32,6 @@ unsigned long __bootdata_preserved(max_mappable);
 unsigned long __bootdata(ident_map_size);
 
 u64 __bootdata_preserved(stfle_fac_list[16]);
-u64 __bootdata_preserved(alt_stfle_fac_list[16]);
 struct oldmem_data __bootdata_preserved(oldmem_data);
 
 struct machine_info machine;
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index 621f23d5ae30..77e479d44f1e 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -8,12 +8,8 @@
 
 #ifndef __ASSEMBLY__
 
-#ifdef CONFIG_CC_IS_CLANG
-/* https://llvm.org/pr41424 */
-#define ftrace_return_address(n) 0UL
-#else
-#define ftrace_return_address(n) __builtin_return_address(n)
-#endif
+unsigned long return_address(unsigned int n);
+#define ftrace_return_address(n) return_address(n)
 
 void ftrace_caller(void);
 
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index db9982f0e8cd..bbbdc5abe2b2 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -98,6 +98,7 @@ void cpu_detect_mhz_feature(void);
 
 extern const struct seq_operations cpuinfo_op;
 extern void execve_tail(void);
+unsigned long vdso_text_size(void);
 unsigned long vdso_size(void);
 
 /*
diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 433fde85b14e..85b6738b826a 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_S390_STACKTRACE_H
 #define _ASM_S390_STACKTRACE_H
 
+#include <linux/stacktrace.h>
 #include <linux/uaccess.h>
 #include <linux/ptrace.h>
 
@@ -12,6 +13,17 @@ struct stack_frame_user {
 	unsigned long empty2[4];
 };
 
+struct stack_frame_vdso_wrapper {
+	struct stack_frame_user sf;
+	unsigned long return_address;
+};
+
+struct perf_callchain_entry_ctx;
+
+void arch_stack_walk_user_common(stack_trace_consume_fn consume_entry, void *cookie,
+				 struct perf_callchain_entry_ctx *entry,
+				 const struct pt_regs *regs, bool perf);
+
 enum stack_type {
 	STACK_TYPE_UNKNOWN,
 	STACK_TYPE_TASK,
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index fa029d0dc28f..db2d9ba5a86d 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -11,6 +11,8 @@ CFLAGS_REMOVE_ftrace.o		= $(CC_FLAGS_FTRACE)
 # Do not trace early setup code
 CFLAGS_REMOVE_early.o		= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_rethook.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_stacktrace.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_unwind_bc.o	= $(CC_FLAGS_FTRACE)
 
 endif
 
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index fa5f6885c74a..2f65bca2f3f1 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -66,6 +66,11 @@ int main(void)
 	OFFSET(__SF_SIE_CONTROL_PHYS, stack_frame, sie_control_block_phys);
 	DEFINE(STACK_FRAME_OVERHEAD, sizeof(struct stack_frame));
 	BLANK();
+	OFFSET(__SFUSER_BACKCHAIN, stack_frame_user, back_chain);
+	DEFINE(STACK_FRAME_USER_OVERHEAD, sizeof(struct stack_frame_user));
+	OFFSET(__SFVDSO_RETURN_ADDRESS, stack_frame_vdso_wrapper, return_address);
+	DEFINE(STACK_FRAME_VDSO_OVERHEAD, sizeof(struct stack_frame_vdso_wrapper));
+	BLANK();
 	/* idle data offsets */
 	OFFSET(__CLOCK_IDLE_ENTER, s390_idle_data, clock_idle_enter);
 	OFFSET(__TIMER_IDLE_ENTER, s390_idle_data, timer_idle_enter);
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index 1486350a4177..469e8d3fbfbf 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -962,8 +962,8 @@ static ssize_t reipl_nvme_scpdata_write(struct file *filp, struct kobject *kobj,
 		scpdata_len += padding;
 	}
 
-	reipl_block_nvme->hdr.len = IPL_BP_FCP_LEN + scpdata_len;
-	reipl_block_nvme->nvme.len = IPL_BP0_FCP_LEN + scpdata_len;
+	reipl_block_nvme->hdr.len = IPL_BP_NVME_LEN + scpdata_len;
+	reipl_block_nvme->nvme.len = IPL_BP0_NVME_LEN + scpdata_len;
 	reipl_block_nvme->nvme.scp_data_len = scpdata_len;
 
 	return count;
@@ -1858,9 +1858,9 @@ static int __init dump_nvme_init(void)
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
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index dfa77da2fd2e..5fff629b1a89 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -218,39 +218,7 @@ void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
 void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 			 struct pt_regs *regs)
 {
-	struct stack_frame_user __user *sf;
-	unsigned long ip, sp;
-	bool first = true;
-
-	if (is_compat_task())
-		return;
-	perf_callchain_store(entry, instruction_pointer(regs));
-	sf = (void __user *)user_stack_pointer(regs);
-	pagefault_disable();
-	while (entry->nr < entry->max_stack) {
-		if (__get_user(sp, &sf->back_chain))
-			break;
-		if (__get_user(ip, &sf->gprs[8]))
-			break;
-		if (ip & 0x1) {
-			/*
-			 * If the instruction address is invalid, and this
-			 * is the first stack frame, assume r14 has not
-			 * been written to the stack yet. Otherwise exit.
-			 */
-			if (first && !(regs->gprs[14] & 0x1))
-				ip = regs->gprs[14];
-			else
-				break;
-		}
-		perf_callchain_store(entry, ip);
-		/* Sanity check: ABI requires SP to be aligned 8 bytes. */
-		if (!sp || sp & 0x7)
-			break;
-		sf = (void __user *)sp;
-		first = false;
-	}
-	pagefault_enable();
+	arch_stack_walk_user_common(NULL, NULL, entry, regs, true);
 }
 
 /* Perf definitions for PMU event attributes in sysfs */
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 24ed33f044ec..7ecd27c62d56 100644
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
diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 94f440e38303..640363b2a105 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -5,6 +5,7 @@
  *  Copyright IBM Corp. 2006
  */
 
+#include <linux/perf_event.h>
 #include <linux/stacktrace.h>
 #include <linux/uaccess.h>
 #include <linux/compat.h>
@@ -62,42 +63,121 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 	return 0;
 }
 
-void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
-			  const struct pt_regs *regs)
+static inline bool store_ip(stack_trace_consume_fn consume_entry, void *cookie,
+			    struct perf_callchain_entry_ctx *entry, bool perf,
+			    unsigned long ip)
+{
+#ifdef CONFIG_PERF_EVENTS
+	if (perf) {
+		if (perf_callchain_store(entry, ip))
+			return false;
+		return true;
+	}
+#endif
+	return consume_entry(cookie, ip);
+}
+
+static inline bool ip_invalid(unsigned long ip)
+{
+	/*
+	 * Perform some basic checks if an instruction address taken
+	 * from unreliable source is invalid.
+	 */
+	if (ip & 1)
+		return true;
+	if (ip < mmap_min_addr)
+		return true;
+	if (ip >= current->mm->context.asce_limit)
+		return true;
+	return false;
+}
+
+static inline bool ip_within_vdso(unsigned long ip)
 {
+	return in_range(ip, current->mm->context.vdso_base, vdso_text_size());
+}
+
+void arch_stack_walk_user_common(stack_trace_consume_fn consume_entry, void *cookie,
+				 struct perf_callchain_entry_ctx *entry,
+				 const struct pt_regs *regs, bool perf)
+{
+	struct stack_frame_vdso_wrapper __user *sf_vdso;
 	struct stack_frame_user __user *sf;
 	unsigned long ip, sp;
 	bool first = true;
 
 	if (is_compat_task())
 		return;
-	if (!consume_entry(cookie, instruction_pointer(regs)))
+	if (!current->mm)
+		return;
+	ip = instruction_pointer(regs);
+	if (!store_ip(consume_entry, cookie, entry, perf, ip))
 		return;
 	sf = (void __user *)user_stack_pointer(regs);
 	pagefault_disable();
 	while (1) {
 		if (__get_user(sp, &sf->back_chain))
 			break;
-		if (__get_user(ip, &sf->gprs[8]))
+		/*
+		 * VDSO entry code has a non-standard stack frame layout.
+		 * See VDSO user wrapper code for details.
+		 */
+		if (!sp && ip_within_vdso(ip)) {
+			sf_vdso = (void __user *)sf;
+			if (__get_user(ip, &sf_vdso->return_address))
+				break;
+			sp = (unsigned long)sf + STACK_FRAME_VDSO_OVERHEAD;
+			sf = (void __user *)sp;
+			if (__get_user(sp, &sf->back_chain))
+				break;
+		} else {
+			sf = (void __user *)sp;
+			if (__get_user(ip, &sf->gprs[8]))
+				break;
+		}
+		/* Sanity check: ABI requires SP to be 8 byte aligned. */
+		if (sp & 0x7)
 			break;
-		if (ip & 0x1) {
+		if (ip_invalid(ip)) {
 			/*
 			 * If the instruction address is invalid, and this
 			 * is the first stack frame, assume r14 has not
 			 * been written to the stack yet. Otherwise exit.
 			 */
-			if (first && !(regs->gprs[14] & 0x1))
-				ip = regs->gprs[14];
-			else
+			if (!first)
+				break;
+			ip = regs->gprs[14];
+			if (ip_invalid(ip))
 				break;
 		}
-		if (!consume_entry(cookie, ip))
-			break;
-		/* Sanity check: ABI requires SP to be aligned 8 bytes. */
-		if (!sp || sp & 0x7)
-			break;
-		sf = (void __user *)sp;
+		if (!store_ip(consume_entry, cookie, entry, perf, ip))
+			return;
 		first = false;
 	}
 	pagefault_enable();
 }
+
+void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
+			  const struct pt_regs *regs)
+{
+	arch_stack_walk_user_common(consume_entry, cookie, NULL, regs, false);
+}
+
+unsigned long return_address(unsigned int n)
+{
+	struct unwind_state state;
+	unsigned long addr;
+
+	/* Increment to skip current stack entry */
+	n++;
+
+	unwind_for_each_frame(&state, NULL, NULL, 0) {
+		addr = unwind_get_return_address(&state);
+		if (!addr)
+			break;
+		if (!n--)
+			return addr;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(return_address);
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index a45b3a4c91db..2f967ac2b8e3 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -210,17 +210,22 @@ static unsigned long vdso_addr(unsigned long start, unsigned long len)
 	return addr;
 }
 
-unsigned long vdso_size(void)
+unsigned long vdso_text_size(void)
 {
-	unsigned long size = VVAR_NR_PAGES * PAGE_SIZE;
+	unsigned long size;
 
 	if (is_compat_task())
-		size += vdso32_end - vdso32_start;
+		size = vdso32_end - vdso32_start;
 	else
-		size += vdso64_end - vdso64_start;
+		size = vdso64_end - vdso64_start;
 	return PAGE_ALIGN(size);
 }
 
+unsigned long vdso_size(void)
+{
+	return vdso_text_size() + VVAR_NR_PAGES * PAGE_SIZE;
+}
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	unsigned long addr = VDSO_BASE;
diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
index b12a274cbb47..4800d80decee 100644
--- a/arch/s390/kernel/vdso32/Makefile
+++ b/arch/s390/kernel/vdso32/Makefile
@@ -19,8 +19,10 @@ KBUILD_AFLAGS_32 := $(filter-out -m64,$(KBUILD_AFLAGS))
 KBUILD_AFLAGS_32 += -m31 -s
 
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
+KBUILD_CFLAGS_32 := $(filter-out -mpacked-stack,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin
+KBUILD_CFLAGS_32 := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 += -m31 -fPIC -shared -fno-common -fno-builtin -fasynchronous-unwind-tables
 
 LDFLAGS_vdso32.so.dbg += -shared -soname=linux-vdso32.so.1 \
 	--hash-style=both --build-id=sha1 -melf_s390 -T
diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
index ef9832726097..2f2e4e997030 100644
--- a/arch/s390/kernel/vdso64/Makefile
+++ b/arch/s390/kernel/vdso64/Makefile
@@ -24,9 +24,11 @@ KBUILD_AFLAGS_64 := $(filter-out -m64,$(KBUILD_AFLAGS))
 KBUILD_AFLAGS_64 += -m64
 
 KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
+KBUILD_CFLAGS_64 := $(filter-out -mpacked-stack,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 := $(filter-out -mno-pic-data-is-text-relative,$(KBUILD_CFLAGS_64))
 KBUILD_CFLAGS_64 := $(filter-out -munaligned-symbols,$(KBUILD_CFLAGS_64))
-KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin
+KBUILD_CFLAGS_64 := $(filter-out -fno-asynchronous-unwind-tables,$(KBUILD_CFLAGS_64))
+KBUILD_CFLAGS_64 += -m64 -fPIC -fno-common -fno-builtin -fasynchronous-unwind-tables
 ldflags-y := -shared -soname=linux-vdso64.so.1 \
 	     --hash-style=both --build-id=sha1 -T
 
diff --git a/arch/s390/kernel/vdso64/vdso_user_wrapper.S b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
index 85247ef5a41b..e26e68675c08 100644
--- a/arch/s390/kernel/vdso64/vdso_user_wrapper.S
+++ b/arch/s390/kernel/vdso64/vdso_user_wrapper.S
@@ -6,8 +6,6 @@
 #include <asm/dwarf.h>
 #include <asm/ptrace.h>
 
-#define WRAPPER_FRAME_SIZE (STACK_FRAME_OVERHEAD+8)
-
 /*
  * Older glibc version called vdso without allocating a stackframe. This wrapper
  * is just used to allocate a stackframe. See
@@ -20,16 +18,17 @@
 	__ALIGN
 __kernel_\func:
 	CFI_STARTPROC
-	aghi	%r15,-WRAPPER_FRAME_SIZE
-	CFI_DEF_CFA_OFFSET (STACK_FRAME_OVERHEAD + WRAPPER_FRAME_SIZE)
-	CFI_VAL_OFFSET 15, -STACK_FRAME_OVERHEAD
-	stg	%r14,STACK_FRAME_OVERHEAD(%r15)
-	CFI_REL_OFFSET 14, STACK_FRAME_OVERHEAD
+	aghi	%r15,-STACK_FRAME_VDSO_OVERHEAD
+	CFI_DEF_CFA_OFFSET (STACK_FRAME_USER_OVERHEAD + STACK_FRAME_VDSO_OVERHEAD)
+	CFI_VAL_OFFSET 15,-STACK_FRAME_USER_OVERHEAD
+	stg	%r14,__SFVDSO_RETURN_ADDRESS(%r15)
+	CFI_REL_OFFSET 14,__SFVDSO_RETURN_ADDRESS
+	xc	__SFUSER_BACKCHAIN(8,%r15),__SFUSER_BACKCHAIN(%r15)
 	brasl	%r14,__s390_vdso_\func
-	lg	%r14,STACK_FRAME_OVERHEAD(%r15)
+	lg	%r14,__SFVDSO_RETURN_ADDRESS(%r15)
 	CFI_RESTORE 14
-	aghi	%r15,WRAPPER_FRAME_SIZE
-	CFI_DEF_CFA_OFFSET STACK_FRAME_OVERHEAD
+	aghi	%r15,STACK_FRAME_VDSO_OVERHEAD
+	CFI_DEF_CFA_OFFSET STACK_FRAME_USER_OVERHEAD
 	CFI_RESTORE 15
 	br	%r14
 	CFI_ENDPROC
diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index ffc5cb92fa36..d82bc3fdb86e 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -676,24 +676,26 @@ void register_winch_irq(int fd, int tty_fd, int pid, struct tty_port *port,
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
index 63fc062add70..ef805eaa9e01 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1092,7 +1092,7 @@ static int __init ubd_init(void)
 
 	if (irq_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	io_req_buffer = kmalloc_array(UBD_REQ_BUFFER_SIZE,
 				      sizeof(struct io_thread_req *),
@@ -1103,7 +1103,7 @@ static int __init ubd_init(void)
 
 	if (io_req_buffer == NULL) {
 		printk(KERN_ERR "Failed to initialize ubd buffering\n");
-		return -1;
+		return -ENOMEM;
 	}
 	platform_driver_register(&ubd_driver);
 	mutex_lock(&ubd_lock);
diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index dc2feae789cb..63e5f108a6b9 100644
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
index a7555e43ed14..f2923c767bb9 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -14,8 +14,6 @@ typedef struct mm_context {
 	struct uml_arch_mm_context arch;
 } mm_context_t;
 
-extern void __switch_mm(struct mm_id * mm_idp);
-
 /* Avoid tangled inclusion with asm/ldt.h */
 extern long init_new_ldt(struct mm_context *to_mm, struct mm_context *from_mm);
 extern void free_ldt(struct mm_context *mm);
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 6c3779541845..5a7c05275aa7 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -94,7 +94,6 @@ extern struct cpuinfo_um boot_cpu_data;
 #define current_cpu_data boot_cpu_data
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
-extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
 extern unsigned long __get_wchan(struct task_struct *p);
 
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 789b83013f35..af8cdfc75897 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -66,4 +66,6 @@ extern void fatal_sigsegv(void) __attribute__ ((noreturn));
 
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
index c5d614d28a75..74777a97e394 100644
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
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index b77bbb67e77b..ce5111cec36e 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -59,36 +59,30 @@
 #define __force_percpu_prefix	"%%"__stringify(__percpu_seg)":"
 #define __my_cpu_offset		this_cpu_read(this_cpu_off)
 
-#ifdef CONFIG_USE_X86_SEG_SUPPORT
-/*
- * Efficient implementation for cases in which the compiler supports
- * named address spaces.  Allows the compiler to perform additional
- * optimizations that can save more instructions.
- */
-#define arch_raw_cpu_ptr(ptr)					\
-({								\
-	unsigned long tcp_ptr__;				\
-	tcp_ptr__ = __raw_cpu_read(, this_cpu_off);		\
-								\
-	tcp_ptr__ += (__force unsigned long)(ptr);		\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
-})
-#else /* CONFIG_USE_X86_SEG_SUPPORT */
+#ifdef CONFIG_X86_64
+#define __raw_my_cpu_offset	raw_cpu_read_8(this_cpu_off);
+#else
+#define __raw_my_cpu_offset	raw_cpu_read_4(this_cpu_off);
+#endif
+
 /*
  * Compared to the generic __my_cpu_offset version, the following
  * saves one instruction and avoids clobbering a temp register.
+ *
+ * arch_raw_cpu_ptr should not be used in 32-bit VDSO for a 64-bit
+ * kernel, because games are played with CONFIG_X86_64 there and
+ * sizeof(this_cpu_off) becames 4.
  */
-#define arch_raw_cpu_ptr(ptr)					\
+#ifndef BUILD_VDSO32_64
+#define arch_raw_cpu_ptr(_ptr)					\
 ({								\
-	unsigned long tcp_ptr__;				\
-	asm ("mov " __percpu_arg(1) ", %0"			\
-	     : "=r" (tcp_ptr__)					\
-	     : "m" (__my_cpu_var(this_cpu_off)));		\
-								\
-	tcp_ptr__ += (unsigned long)(ptr);			\
-	(typeof(*(ptr)) __kernel __force *)tcp_ptr__;		\
+	unsigned long tcp_ptr__ = __raw_my_cpu_offset;		\
+	tcp_ptr__ += (__force unsigned long)(_ptr);		\
+	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;		\
 })
-#endif /* CONFIG_USE_X86_SEG_SUPPORT */
+#else
+#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
 
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 185738c72766..29cd0543fc2f 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1036,7 +1036,8 @@ static void __vector_schedule_cleanup(struct apic_chip_data *apicd)
 			add_timer_on(&cl->timer, cpu);
 		}
 	} else {
-		apicd->prev_vector = 0;
+		pr_warn("IRQ %u schedule cleanup for offline CPU %u\n", apicd->irq, cpu);
+		free_moved_vector(apicd);
 	}
 	raw_spin_unlock(&vector_lock);
 }
@@ -1073,6 +1074,7 @@ void irq_complete_move(struct irq_cfg *cfg)
  */
 void irq_force_complete_move(struct irq_desc *desc)
 {
+	unsigned int cpu = smp_processor_id();
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
 	unsigned int vector;
@@ -1097,10 +1099,11 @@ void irq_force_complete_move(struct irq_desc *desc)
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 605c26c009c8..ae987a26f26e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1589,6 +1589,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (have_cpuid_p()) {
 		cpu_detect(c);
 		get_cpu_vendor(c);
+		intel_unlock_cpuid_leafs(c);
 		get_cpu_cap(c);
 		setup_force_cpu_cap(X86_FEATURE_CPUID);
 		get_cpu_address_sizes(c);
@@ -1748,7 +1749,7 @@ static void generic_identify(struct cpuinfo_x86 *c)
 	cpu_detect(c);
 
 	get_cpu_vendor(c);
-
+	intel_unlock_cpuid_leafs(c);
 	get_cpu_cap(c);
 
 	get_cpu_address_sizes(c);
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index ea9e07d57c8d..1beccefbaff9 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -61,9 +61,11 @@ extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
 
 extern void __init tsx_init(void);
 void tsx_ap_init(void);
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
 #else
 static inline void tsx_init(void) { }
 static inline void tsx_ap_init(void) { }
+static inline void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c) { }
 #endif /* CONFIG_CPU_SUP_INTEL */
 
 extern void init_spectral_chicken(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be30d7fa2e66..93efd9edc724 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -268,19 +268,26 @@ static void detect_tme_early(struct cpuinfo_x86 *c)
 	c->x86_phys_bits -= keyid_bits;
 }
 
+void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
+
+	if (c->x86 < 6 || (c->x86 == 6 && c->x86_model < 0xd))
+		return;
+
+	/*
+	 * The BIOS can have limited CPUID to leaf 2, which breaks feature
+	 * enumeration. Unlock it and update the maximum leaf info.
+	 */
+	if (msr_clear_bit(MSR_IA32_MISC_ENABLE, MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0)
+		c->cpuid_level = cpuid_eax(0);
+}
+
 static void early_init_intel(struct cpuinfo_x86 *c)
 {
 	u64 misc_enable;
 
-	/* Unmask CPUID levels if masked: */
-	if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
-		if (msr_clear_bit(MSR_IA32_MISC_ENABLE,
-				  MSR_IA32_MISC_ENABLE_LIMIT_CPUID_BIT) > 0) {
-			c->cpuid_level = cpuid_eax(0);
-			get_cpu_cap(c);
-		}
-	}
-
 	if ((c->x86 == 0xf && c->x86_model >= 0x03) ||
 		(c->x86 == 0x6 && c->x86_model >= 0x0e))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index d17c9b71eb4a..621a151ccf7d 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -128,6 +128,9 @@ static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
 
 static __init bool check_for_real_bsp(u32 apic_id)
 {
+	bool is_bsp = false, has_apic_base = boot_cpu_data.x86 >= 6;
+	u64 msr;
+
 	/*
 	 * There is no real good way to detect whether this a kdump()
 	 * kernel, but except on the Voyager SMP monstrosity which is not
@@ -144,17 +147,61 @@ static __init bool check_for_real_bsp(u32 apic_id)
 	if (topo_info.real_bsp_apic_id != BAD_APICID)
 		return false;
 
+	/*
+	 * Check whether the enumeration order is broken by evaluating the
+	 * BSP bit in the APICBASE MSR. If the CPU does not have the
+	 * APICBASE MSR then the BSP detection is not possible and the
+	 * kernel must rely on the firmware enumeration order.
+	 */
+	if (has_apic_base) {
+		rdmsrl(MSR_IA32_APICBASE, msr);
+		is_bsp = !!(msr & MSR_IA32_APICBASE_BSP);
+	}
+
 	if (apic_id == topo_info.boot_cpu_apic_id) {
-		topo_info.real_bsp_apic_id = apic_id;
-		return false;
+		/*
+		 * If the boot CPU has the APIC BSP bit set then the
+		 * firmware enumeration is agreeing. If the CPU does not
+		 * have the APICBASE MSR then the only choice is to trust
+		 * the enumeration order.
+		 */
+		if (is_bsp || !has_apic_base) {
+			topo_info.real_bsp_apic_id = apic_id;
+			return false;
+		}
+		/*
+		 * If the boot APIC is enumerated first, but the APICBASE
+		 * MSR does not have the BSP bit set, then there is no way
+		 * to discover the real BSP here. Assume a crash kernel and
+		 * limit the number of CPUs to 1 as an INIT to the real BSP
+		 * would reset the machine.
+		 */
+		pr_warn("Enumerated BSP APIC %x is not marked in APICBASE MSR\n", apic_id);
+		pr_warn("Assuming crash kernel. Limiting to one CPU to prevent machine INIT\n");
+		set_nr_cpu_ids(1);
+		goto fwbug;
 	}
 
-	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x > %x\n",
+	pr_warn("Boot CPU APIC ID not the first enumerated APIC ID: %x != %x\n",
 		topo_info.boot_cpu_apic_id, apic_id);
+
+	if (is_bsp) {
+		/*
+		 * The boot CPU has the APIC BSP bit set. Use it and complain
+		 * about the broken firmware enumeration.
+		 */
+		topo_info.real_bsp_apic_id = topo_info.boot_cpu_apic_id;
+		goto fwbug;
+	}
+
 	pr_warn("Crash kernel detected. Disabling real BSP to prevent machine INIT\n");
 
 	topo_info.real_bsp_apic_id = apic_id;
 	return true;
+
+fwbug:
+	pr_warn(FW_BUG "APIC enumeration order not specification compliant\n");
+	return false;
 }
 
 static unsigned int topo_unit_count(u32 lvlid, enum x86_topology_domains at_level,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 77352a4abd87..b1002b79886a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1232,9 +1232,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
@@ -1242,16 +1241,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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
diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
index 0cc9520666ef..39255f0eb14d 100644
--- a/arch/x86/pci/mmconfig-shared.c
+++ b/arch/x86/pci/mmconfig-shared.c
@@ -518,7 +518,34 @@ static bool __ref pci_mmcfg_reserved(struct device *dev,
 {
 	struct resource *conflict;
 
-	if (!early && !acpi_disabled) {
+	if (early) {
+
+		/*
+		 * Don't try to do this check unless configuration type 1
+		 * is available.  How about type 2?
+		 */
+
+		/*
+		 * 946f2ee5c731 ("Check that MCFG points to an e820
+		 * reserved area") added this E820 check in 2006 to work
+		 * around BIOS defects.
+		 *
+		 * Per PCI Firmware r3.3, sec 4.1.2, ECAM space must be
+		 * reserved by a PNP0C02 resource, but it need not be
+		 * mentioned in E820.  Before the ACPI interpreter is
+		 * available, we can't check for PNP0C02 resources, so
+		 * there's no reliable way to verify the region in this
+		 * early check.  Keep it only for the old machines that
+		 * motivated 946f2ee5c731.
+		 */
+		if (dmi_get_bios_year() < 2016 && raw_pci_ops)
+			return is_mmconf_reserved(e820__mapped_all, cfg, dev,
+						  "E820 entry");
+
+		return true;
+	}
+
+	if (!acpi_disabled) {
 		if (is_mmconf_reserved(is_acpi_reserved, cfg, dev,
 				       "ACPI motherboard resource"))
 			return true;
@@ -551,16 +578,7 @@ static bool __ref pci_mmcfg_reserved(struct device *dev,
 	 * For MCFG information constructed from hotpluggable host bridge's
 	 * _CBA method, just assume it's reserved.
 	 */
-	if (pci_mmcfg_running_state)
-		return true;
-
-	/* Don't try to do this check unless configuration
-	   type 1 is available. how about type 2 ?*/
-	if (raw_pci_ops)
-		return is_mmconf_reserved(e820__mapped_all, cfg, dev,
-					  "E820 entry");
-
-	return false;
+	return pci_mmcfg_running_state;
 }
 
 static void __init pci_mmcfg_reject_broken(int early)
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
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index a01ca255b0c6..b88722dfc4f8 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -382,3 +382,36 @@ void __init xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns)
 
 	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
 }
+
+#ifdef CONFIG_XEN_UNPOPULATED_ALLOC
+int __init arch_xen_unpopulated_init(struct resource **res)
+{
+	unsigned int i;
+
+	if (!xen_domain())
+		return -ENODEV;
+
+	/* Must be set strictly before calling xen_free_unpopulated_pages(). */
+	*res = &iomem_resource;
+
+	/*
+	 * Initialize with pages from the extra memory regions (see
+	 * arch/x86/xen/setup.c).
+	 */
+	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
+		unsigned int j;
+
+		for (j = 0; j < xen_extra_mem[i].n_pfns; j++) {
+			struct page *pg =
+				pfn_to_page(xen_extra_mem[i].start_pfn + j);
+
+			xen_free_unpopulated_pages(1, &pg);
+		}
+
+		/* Zero so region is not also added to the balloon driver. */
+		xen_extra_mem[i].n_pfns = 0;
+	}
+
+	return 0;
+}
+#endif
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 059467086b13..96af8224992e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -323,6 +323,7 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct gendisk *disk,
 	blkg->q = disk->queue;
 	INIT_LIST_HEAD(&blkg->q_node);
 	blkg->blkcg = blkcg;
+	blkg->iostat.blkg = blkg;
 #ifdef CONFIG_BLK_CGROUP_PUNT_BIO
 	spin_lock_init(&blkg->async_bio_lock);
 	bio_list_init(&blkg->async_bios);
@@ -619,12 +620,45 @@ static void blkg_destroy_all(struct gendisk *disk)
 	spin_unlock_irq(&q->queue_lock);
 }
 
+static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] = src->bytes[i];
+		dst->ios[i] = src->ios[i];
+	}
+}
+
+static void __blkg_clear_stat(struct blkg_iostat_set *bis)
+{
+	struct blkg_iostat cur = {0};
+	unsigned long flags;
+
+	flags = u64_stats_update_begin_irqsave(&bis->sync);
+	blkg_iostat_set(&bis->cur, &cur);
+	blkg_iostat_set(&bis->last, &cur);
+	u64_stats_update_end_irqrestore(&bis->sync, flags);
+}
+
+static void blkg_clear_stat(struct blkcg_gq *blkg)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
+
+		__blkg_clear_stat(s);
+	}
+	__blkg_clear_stat(&blkg->iostat);
+}
+
 static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			     struct cftype *cftype, u64 val)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct blkcg_gq *blkg;
-	int i, cpu;
+	int i;
 
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
@@ -635,18 +669,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	 * anyway.  If you get hit by a race, retry.
 	 */
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		for_each_possible_cpu(cpu) {
-			struct blkg_iostat_set *bis =
-				per_cpu_ptr(blkg->iostat_cpu, cpu);
-			memset(bis, 0, sizeof(*bis));
-
-			/* Re-initialize the cleared blkg_iostat_set */
-			u64_stats_init(&bis->sync);
-			bis->blkg = blkg;
-		}
-		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
-		u64_stats_init(&blkg->iostat.sync);
-
+		blkg_clear_stat(blkg);
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
@@ -949,16 +972,6 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
-static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] = src->bytes[i];
-		dst->ios[i] = src->ios[i];
-	}
-}
-
 static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
 {
 	int i;
@@ -1024,7 +1037,19 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 		struct blkg_iostat cur;
 		unsigned int seq;
 
+		/*
+		 * Order assignment of `next_bisc` from `bisc->lnode.next` in
+		 * llist_for_each_entry_safe and clearing `bisc->lqueued` for
+		 * avoiding to assign `next_bisc` with new next pointer added
+		 * in blk_cgroup_bio_start() in case of re-ordering.
+		 *
+		 * The pair barrier is implied in llist_add() in blk_cgroup_bio_start().
+		 */
+		smp_mb();
+
 		WRITE_ONCE(bisc->lqueued, false);
+		if (bisc == &blkg->iostat)
+			goto propagate_up; /* propagate up to parent only */
 
 		/* fetch the current per-cpu values */
 		do {
@@ -1034,10 +1059,24 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 
 		blkcg_iostat_update(blkg, &cur, &bisc->last);
 
+propagate_up:
 		/* propagate global delta to parent (unless that's root) */
-		if (parent && parent->parent)
+		if (parent && parent->parent) {
 			blkcg_iostat_update(parent, &blkg->iostat.cur,
 					    &blkg->iostat.last);
+			/*
+			 * Queue parent->iostat to its blkcg's lockless
+			 * list to propagate up to the grandparent if the
+			 * iostat hasn't been queued yet.
+			 */
+			if (!parent->iostat.lqueued) {
+				struct llist_head *plhead;
+
+				plhead = per_cpu_ptr(parent->blkcg->lhead, cpu);
+				llist_add(&parent->iostat.lnode, plhead);
+				parent->iostat.lqueued = true;
+			}
+		}
 	}
 	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
 out:
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9d6033e01f2e..15319b217bf3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -751,6 +751,8 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 	unsigned int top, bottom, alignment, ret = 0;
 
 	t->max_sectors = min_not_zero(t->max_sectors, b->max_sectors);
+	t->max_user_sectors = min_not_zero(t->max_user_sectors,
+			b->max_user_sectors);
 	t->max_hw_sectors = min_not_zero(t->max_hw_sectors, b->max_hw_sectors);
 	t->max_dev_sectors = min_not_zero(t->max_dev_sectors, b->max_dev_sectors);
 	t->max_write_zeroes_sectors = min(t->max_write_zeroes_sectors,
diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0738ccad08b2..db4f910e8e36 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -192,11 +192,14 @@ extern struct kset *devices_kset;
 void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
-void module_add_driver(struct module *mod, struct device_driver *drv);
+int module_add_driver(struct module *mod, struct device_driver *drv);
 void module_remove_driver(struct device_driver *drv);
 #else
-static inline void module_add_driver(struct module *mod,
-				     struct device_driver *drv) { }
+static inline int module_add_driver(struct module *mod,
+				    struct device_driver *drv)
+{
+	return 0;
+}
 static inline void module_remove_driver(struct device_driver *drv) { }
 #endif
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index daee55c9b2d9..ffea0728b8b2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -674,7 +674,12 @@ int bus_add_driver(struct device_driver *drv)
 		if (error)
 			goto out_del_list;
 	}
-	module_add_driver(drv->owner, drv);
+	error = module_add_driver(drv->owner, drv);
+	if (error) {
+		printk(KERN_ERR "%s: failed to create module links for %s\n",
+			__func__, drv->name);
+		goto out_detach;
+	}
 
 	error = driver_create_file(drv, &driver_attr_uevent);
 	if (error) {
@@ -699,6 +704,8 @@ int bus_add_driver(struct device_driver *drv)
 
 	return 0;
 
+out_detach:
+	driver_detach(drv);
 out_del_list:
 	klist_del(&priv->knode_bus);
 out_unregister:
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..a1b55da07127 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -30,14 +30,14 @@ static void module_create_drivers_dir(struct module_kobject *mk)
 	mutex_unlock(&drivers_dir_mutex);
 }
 
-void module_add_driver(struct module *mod, struct device_driver *drv)
+int module_add_driver(struct module *mod, struct device_driver *drv)
 {
 	char *driver_name;
-	int no_warn;
 	struct module_kobject *mk = NULL;
+	int ret;
 
 	if (!drv)
-		return;
+		return 0;
 
 	if (mod)
 		mk = &mod->mkobj;
@@ -56,17 +56,37 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 	}
 
 	if (!mk)
-		return;
+		return 0;
+
+	ret = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
+	if (ret)
+		return ret;
 
-	/* Don't check return codes; these calls are idempotent */
-	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
 	driver_name = make_driver_name(drv);
-	if (driver_name) {
-		module_create_drivers_dir(mk);
-		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
-					    driver_name);
-		kfree(driver_name);
+	if (!driver_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	module_create_drivers_dir(mk);
+	if (!mk->drivers_dir) {
+		ret = -EINVAL;
+		goto out;
 	}
+
+	ret = sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);
+	if (ret)
+		goto out;
+
+	kfree(driver_name);
+
+	return 0;
+out:
+	sysfs_remove_link(&drv->p->kobj, "module");
+	sysfs_remove_link(mk->drivers_dir, driver_name);
+	kfree(driver_name);
+
+	return ret;
 }
 
 void module_remove_driver(struct device_driver *drv)
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index eed63f95e89d..620679a0ac38 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -404,13 +404,25 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 static int nullb_apply_submit_queues(struct nullb_device *dev,
 				     unsigned int submit_queues)
 {
-	return nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, submit_queues, dev->poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 static int nullb_apply_poll_queues(struct nullb_device *dev,
 				   unsigned int poll_queues)
 {
-	return nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	int ret;
+
+	mutex_lock(&lock);
+	ret = nullb_update_nr_hw_queues(dev, dev->submit_queues, poll_queues);
+	mutex_unlock(&lock);
+
+	return ret;
 }
 
 NULLB_DEVICE_ATTR(size, ulong, NULL);
@@ -457,28 +469,32 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 	if (ret < 0)
 		return ret;
 
+	ret = count;
+	mutex_lock(&lock);
 	if (!dev->power && newp) {
 		if (test_and_set_bit(NULLB_DEV_FL_UP, &dev->flags))
-			return count;
+			goto out;
+
 		ret = null_add_dev(dev);
 		if (ret) {
 			clear_bit(NULLB_DEV_FL_UP, &dev->flags);
-			return ret;
+			goto out;
 		}
 
 		set_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 		dev->power = newp;
+		ret = count;
 	} else if (dev->power && !newp) {
 		if (test_and_clear_bit(NULLB_DEV_FL_UP, &dev->flags)) {
-			mutex_lock(&lock);
 			dev->power = newp;
 			null_del_dev(dev->nullb);
-			mutex_unlock(&lock);
 		}
 		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
-	return count;
+out:
+	mutex_unlock(&lock);
+	return ret;
 }
 
 CONFIGFS_ATTR(nullb_device_, power);
@@ -1918,15 +1934,12 @@ static int null_add_dev(struct nullb_device *dev)
 	nullb->q->queuedata = nullb;
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 
-	mutex_lock(&lock);
 	rv = ida_alloc(&nullb_indexes, GFP_KERNEL);
-	if (rv < 0) {
-		mutex_unlock(&lock);
+	if (rv < 0)
 		goto out_cleanup_disk;
-	}
+
 	nullb->index = rv;
 	dev->index = rv;
-	mutex_unlock(&lock);
 
 	if (config_item_name(&dev->group.cg_item)) {
 		/* Use configfs dir name as the device name */
@@ -1955,9 +1968,7 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_ida_free;
 
-	mutex_lock(&lock);
 	list_add_tail(&nullb->list, &nullb_list);
-	mutex_unlock(&lock);
 
 	pr_info("disk %s created\n", nullb->disk_name);
 
@@ -2006,7 +2017,9 @@ static int null_create_dev(void)
 	if (!dev)
 		return -ENOMEM;
 
+	mutex_lock(&lock);
 	ret = null_add_dev(dev);
+	mutex_unlock(&lock);
 	if (ret) {
 		null_free_dev(dev);
 		return ret;
@@ -2121,4 +2134,5 @@ module_init(null_init);
 module_exit(null_exit);
 
 MODULE_AUTHOR("Jens Axboe <axboe@kernel.dk>");
+MODULE_DESCRIPTION("multi queue aware block test driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index ee951b265213..58e9dcc2a308 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -296,28 +296,35 @@ static int register_device(int minor, struct pp_struct *pp)
 	if (!port) {
 		pr_warn("%s: no associated port!\n", name);
 		rc = -ENXIO;
-		goto err;
+		goto err_free_name;
 	}
 
 	index = ida_alloc(&ida_index, GFP_KERNEL);
+	if (index < 0) {
+		pr_warn("%s: failed to get index!\n", name);
+		rc = index;
+		goto err_put_port;
+	}
+
 	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
 	ppdev_cb.irq_func = pp_irq;
 	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;
 	ppdev_cb.private = pp;
 	pdev = parport_register_dev_model(port, name, &ppdev_cb, index);
-	parport_put_port(port);
 
 	if (!pdev) {
 		pr_warn("%s: failed to register device!\n", name);
 		rc = -ENXIO;
 		ida_free(&ida_index, index);
-		goto err;
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
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index 3f9eaf27b41b..c9eca24bbad4 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -37,6 +37,7 @@
 #include "tpm_tis_spi.h"
 
 #define MAX_SPI_FRAMESIZE 64
+#define SPI_HDRSIZE 4
 
 /*
  * TCG SPI flow control is documented in section 6.4 of the spec[1]. In short,
@@ -247,7 +248,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
 {
-	phy->iobuf = devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
+	phy->iobuf = devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAMESIZE, GFP_KERNEL);
 	if (!phy->iobuf)
 		return -ENOMEM;
 
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5c186e0a39b9..812b2948b6c6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2719,6 +2719,7 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 		if (i == 0) {
 			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
 			if (!cxl_nvb) {
+				kfree(cxlr_pmem);
 				cxlr_pmem = ERR_PTR(-ENODEV);
 				goto out;
 			}
diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
index e5f13260fc52..7c5cd069f10c 100644
--- a/drivers/cxl/core/trace.h
+++ b/drivers/cxl/core/trace.h
@@ -253,8 +253,8 @@ TRACE_EVENT(cxl_generic_event,
  * DRAM Event Record
  * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
  */
-#define CXL_DPA_FLAGS_MASK			0x3F
-#define CXL_DPA_MASK				(~CXL_DPA_FLAGS_MASK)
+#define CXL_DPA_FLAGS_MASK			GENMASK(1, 0)
+#define CXL_DPA_MASK				GENMASK_ULL(63, 6)
 
 #define CXL_DPA_VOLATILE			BIT(0)
 #define CXL_DPA_NOT_REPAIRABLE			BIT(1)
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
index 1398814d8fbb..e3505e56784b 100644
--- a/drivers/dma/idma64.c
+++ b/drivers/dma/idma64.c
@@ -598,7 +598,9 @@ static int idma64_probe(struct idma64_chip *chip)
 
 	idma64->dma.dev = chip->sysdev;
 
-	dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	ret = dma_set_max_seg_size(idma64->dma.dev, IDMA64C_CTLH_BLOCK_TS_MASK);
+	if (ret)
+		return ret;
 
 	ret = dma_async_device_register(&idma64->dma);
 	if (ret)
diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 39935071174a..fd9bbee4cc42 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -577,7 +577,6 @@ void idxd_wq_del_cdev(struct idxd_wq *wq)
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
-	ida_destroy(&file_ida);
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
 	put_device(cdev_dev(idxd_cdev));
diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 5f869eacd19a..3da94b382292 100644
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
index 5f3a3e913d28..d19c78a78ae3 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -169,9 +169,14 @@ static int dmi_dev_uevent(const struct device *dev, struct kobj_uevent_env *env)
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
index d5a8182cf2e1..1983fd3bf392 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -776,6 +776,26 @@ static void error(char *str)
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
@@ -807,6 +827,10 @@ static efi_status_t efi_decompress_kernel(unsigned long *kernel_entry)
 		    !memcmp(efistub_fw_vendor(), ami, sizeof(ami))) {
 			efi_debug("AMI firmware v2.0 or older detected - disabling physical KASLR\n");
 			seed[0] = 0;
+		} else if (cmdline_memmap_override) {
+			efi_info("%s detected on the kernel command line - disabling physical KASLR\n",
+				 cmdline_memmap_override);
+			seed[0] = 0;
 		}
 
 		boot_params_ptr->hdr.loadflags |= KASLR_FLAG;
@@ -883,7 +907,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	}
 
 #ifdef CONFIG_CMDLINE_BOOL
-	status = efi_parse_options(CONFIG_CMDLINE);
+	status = parse_options(CONFIG_CMDLINE);
 	if (status != EFI_SUCCESS) {
 		efi_err("Failed to parse options\n");
 		goto fail;
@@ -892,7 +916,7 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (!IS_ENABLED(CONFIG_CMDLINE_OVERRIDE)) {
 		unsigned long cmdline_paddr = ((u64)hdr->cmd_line_ptr |
 					       ((u64)boot_params->ext_cmd_line_ptr << 32));
-		status = efi_parse_options((char *)cmdline_paddr);
+		status = parse_options((char *)cmdline_paddr);
 		if (status != EFI_SUCCESS) {
 			efi_err("Failed to parse options\n");
 			goto fail;
diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 79c473b3c7c3..8ef395b49bf8 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -55,33 +55,26 @@ int fpga_bridge_disable(struct fpga_bridge *bridge)
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_disable);
 
-static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
+static struct fpga_bridge *__fpga_bridge_get(struct device *bridge_dev,
 					     struct fpga_image_info *info)
 {
 	struct fpga_bridge *bridge;
-	int ret = -ENODEV;
 
-	bridge = to_fpga_bridge(dev);
+	bridge = to_fpga_bridge(bridge_dev);
 
 	bridge->info = info;
 
-	if (!mutex_trylock(&bridge->mutex)) {
-		ret = -EBUSY;
-		goto err_dev;
-	}
+	if (!mutex_trylock(&bridge->mutex))
+		return ERR_PTR(-EBUSY);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_ll_mod;
+	if (!try_module_get(bridge->br_ops_owner)) {
+		mutex_unlock(&bridge->mutex);
+		return ERR_PTR(-ENODEV);
+	}
 
 	dev_dbg(&bridge->dev, "get\n");
 
 	return bridge;
-
-err_ll_mod:
-	mutex_unlock(&bridge->mutex);
-err_dev:
-	put_device(dev);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -98,13 +91,18 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
 struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
 				       struct fpga_image_info *info)
 {
-	struct device *dev;
+	struct fpga_bridge *bridge;
+	struct device *bridge_dev;
 
-	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
-	if (!dev)
+	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
+	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
 
@@ -125,6 +123,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
 struct fpga_bridge *fpga_bridge_get(struct device *dev,
 				    struct fpga_image_info *info)
 {
+	struct fpga_bridge *bridge;
 	struct device *bridge_dev;
 
 	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
@@ -132,7 +131,11 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
 	if (!bridge_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_bridge_get(bridge_dev, info);
+	bridge = __fpga_bridge_get(bridge_dev, info);
+	if (IS_ERR(bridge))
+		put_device(bridge_dev);
+
+	return bridge;
 }
 EXPORT_SYMBOL_GPL(fpga_bridge_get);
 
@@ -146,7 +149,7 @@ void fpga_bridge_put(struct fpga_bridge *bridge)
 	dev_dbg(&bridge->dev, "put\n");
 
 	bridge->info = NULL;
-	module_put(bridge->dev.parent->driver->owner);
+	module_put(bridge->br_ops_owner);
 	mutex_unlock(&bridge->mutex);
 	put_device(&bridge->dev);
 }
@@ -316,18 +319,19 @@ static struct attribute *fpga_bridge_attrs[] = {
 ATTRIBUTE_GROUPS(fpga_bridge);
 
 /**
- * fpga_bridge_register - create and register an FPGA Bridge device
+ * __fpga_bridge_register - create and register an FPGA Bridge device
  * @parent:	FPGA bridge device from pdev
  * @name:	FPGA bridge name
  * @br_ops:	pointer to structure of fpga bridge ops
  * @priv:	FPGA bridge private data
+ * @owner:	owner module containing the br_ops
  *
  * Return: struct fpga_bridge pointer or ERR_PTR()
  */
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv)
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops,
+		       void *priv, struct module *owner)
 {
 	struct fpga_bridge *bridge;
 	int id, ret;
@@ -357,6 +361,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	bridge->name = name;
 	bridge->br_ops = br_ops;
+	bridge->br_ops_owner = owner;
 	bridge->priv = priv;
 
 	bridge->dev.groups = br_ops->groups;
@@ -386,7 +391,7 @@ fpga_bridge_register(struct device *parent, const char *name,
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_bridge_register);
+EXPORT_SYMBOL_GPL(__fpga_bridge_register);
 
 /**
  * fpga_bridge_unregister - unregister an FPGA bridge
diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 06651389c592..0f4035b089a2 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -664,20 +664,16 @@ static struct attribute *fpga_mgr_attrs[] = {
 };
 ATTRIBUTE_GROUPS(fpga_mgr);
 
-static struct fpga_manager *__fpga_mgr_get(struct device *dev)
+static struct fpga_manager *__fpga_mgr_get(struct device *mgr_dev)
 {
 	struct fpga_manager *mgr;
 
-	mgr = to_fpga_manager(dev);
+	mgr = to_fpga_manager(mgr_dev);
 
-	if (!try_module_get(dev->parent->driver->owner))
-		goto err_dev;
+	if (!try_module_get(mgr->mops_owner))
+		mgr = ERR_PTR(-ENODEV);
 
 	return mgr;
-
-err_dev:
-	put_device(dev);
-	return ERR_PTR(-ENODEV);
 }
 
 static int fpga_mgr_dev_match(struct device *dev, const void *data)
@@ -693,12 +689,18 @@ static int fpga_mgr_dev_match(struct device *dev, const void *data)
  */
 struct fpga_manager *fpga_mgr_get(struct device *dev)
 {
-	struct device *mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev,
-						   fpga_mgr_dev_match);
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
+
+	mgr_dev = class_find_device(&fpga_mgr_class, NULL, dev, fpga_mgr_dev_match);
 	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(mgr_dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_get);
 
@@ -711,13 +713,18 @@ EXPORT_SYMBOL_GPL(fpga_mgr_get);
  */
 struct fpga_manager *of_fpga_mgr_get(struct device_node *node)
 {
-	struct device *dev;
+	struct fpga_manager *mgr;
+	struct device *mgr_dev;
 
-	dev = class_find_device_by_of_node(&fpga_mgr_class, node);
-	if (!dev)
+	mgr_dev = class_find_device_by_of_node(&fpga_mgr_class, node);
+	if (!mgr_dev)
 		return ERR_PTR(-ENODEV);
 
-	return __fpga_mgr_get(dev);
+	mgr = __fpga_mgr_get(mgr_dev);
+	if (IS_ERR(mgr))
+		put_device(mgr_dev);
+
+	return mgr;
 }
 EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
 
@@ -727,7 +734,7 @@ EXPORT_SYMBOL_GPL(of_fpga_mgr_get);
  */
 void fpga_mgr_put(struct fpga_manager *mgr)
 {
-	module_put(mgr->dev.parent->driver->owner);
+	module_put(mgr->mops_owner);
 	put_device(&mgr->dev);
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_put);
@@ -766,9 +773,10 @@ void fpga_mgr_unlock(struct fpga_manager *mgr)
 EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
 
 /**
- * fpga_mgr_register_full - create and register an FPGA Manager device
+ * __fpga_mgr_register_full - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register_full() instead is recommended.
@@ -776,7 +784,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_unlock);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner)
 {
 	const struct fpga_manager_ops *mops = info->mops;
 	struct fpga_manager *mgr;
@@ -804,6 +813,8 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	mutex_init(&mgr->ref_mutex);
 
+	mgr->mops_owner = owner;
+
 	mgr->name = info->name;
 	mgr->mops = info->mops;
 	mgr->priv = info->priv;
@@ -841,14 +852,15 @@ fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *in
 
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register_full);
 
 /**
- * fpga_mgr_register - create and register an FPGA Manager device
+ * __fpga_mgr_register - create and register an FPGA Manager device
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * The caller of this function is responsible for calling fpga_mgr_unregister().
  * Using devm_fpga_mgr_register() instead is recommended. This simple
@@ -859,8 +871,8 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register_full);
  * Return: pointer to struct fpga_manager pointer or ERR_PTR()
  */
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv)
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -868,9 +880,9 @@ fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return fpga_mgr_register_full(parent, &info);
+	return __fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__fpga_mgr_register);
 
 /**
  * fpga_mgr_unregister - unregister an FPGA manager
@@ -900,9 +912,10 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
 }
 
 /**
- * devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register_full - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @info:	parameters for fpga manager
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -910,7 +923,8 @@ static void devm_fpga_mgr_unregister(struct device *dev, void *res)
  * function will be called automatically when the managing device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info)
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner)
 {
 	struct fpga_mgr_devres *dr;
 	struct fpga_manager *mgr;
@@ -919,7 +933,7 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 	if (!dr)
 		return ERR_PTR(-ENOMEM);
 
-	mgr = fpga_mgr_register_full(parent, info);
+	mgr = __fpga_mgr_register_full(parent, info, owner);
 	if (IS_ERR(mgr)) {
 		devres_free(dr);
 		return mgr;
@@ -930,14 +944,15 @@ devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_inf
 
 	return mgr;
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register_full);
 
 /**
- * devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
+ * __devm_fpga_mgr_register - resource managed variant of fpga_mgr_register()
  * @parent:	fpga manager device from pdev
  * @name:	fpga manager name
  * @mops:	pointer to structure of fpga manager ops
  * @priv:	fpga manager private data
+ * @owner:	owner module containing the ops
  *
  * Return:  fpga manager pointer on success, negative error code otherwise.
  *
@@ -946,8 +961,9 @@ EXPORT_SYMBOL_GPL(devm_fpga_mgr_register_full);
  * device is detached.
  */
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv)
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner)
 {
 	struct fpga_manager_info info = { 0 };
 
@@ -955,9 +971,9 @@ devm_fpga_mgr_register(struct device *parent, const char *name,
 	info.mops = mops;
 	info.priv = priv;
 
-	return devm_fpga_mgr_register_full(parent, &info);
+	return __devm_fpga_mgr_register_full(parent, &info, owner);
 }
-EXPORT_SYMBOL_GPL(devm_fpga_mgr_register);
+EXPORT_SYMBOL_GPL(__devm_fpga_mgr_register);
 
 static void fpga_mgr_dev_release(struct device *dev)
 {
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index b364a929425c..753cd142503e 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -53,7 +53,7 @@ static struct fpga_region *fpga_region_get(struct fpga_region *region)
 	}
 
 	get_device(dev);
-	if (!try_module_get(dev->parent->driver->owner)) {
+	if (!try_module_get(region->ops_owner)) {
 		put_device(dev);
 		mutex_unlock(&region->mutex);
 		return ERR_PTR(-ENODEV);
@@ -75,7 +75,7 @@ static void fpga_region_put(struct fpga_region *region)
 
 	dev_dbg(dev, "put\n");
 
-	module_put(dev->parent->driver->owner);
+	module_put(region->ops_owner);
 	put_device(dev);
 	mutex_unlock(&region->mutex);
 }
@@ -181,14 +181,16 @@ static struct attribute *fpga_region_attrs[] = {
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
@@ -213,6 +215,7 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 	region->compat_id = info->compat_id;
 	region->priv = info->priv;
 	region->get_bridges = info->get_bridges;
+	region->ops_owner = owner;
 
 	mutex_init(&region->mutex);
 	INIT_LIST_HEAD(&region->bridge_list);
@@ -241,13 +244,14 @@ fpga_region_register_full(struct device *parent, const struct fpga_region_info *
 
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
@@ -256,17 +260,17 @@ EXPORT_SYMBOL_GPL(fpga_region_register_full);
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
diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 7f140df40f35..c1e190d3ea24 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -128,7 +128,24 @@ static bool acpi_gpio_deferred_req_irqs_done;
 
 static int acpi_gpiochip_find(struct gpio_chip *gc, const void *data)
 {
-	return device_match_acpi_handle(&gc->gpiodev->dev, data);
+	/* First check the actual GPIO device */
+	if (device_match_acpi_handle(&gc->gpiodev->dev, data))
+		return true;
+
+	/*
+	 * When the ACPI device is artificially split to the banks of GPIOs,
+	 * where each of them is represented by a separate GPIO device,
+	 * the firmware node of the physical device may not be shared among
+	 * the banks as they may require different values for the same property,
+	 * e.g., number of GPIOs in a certain bank. In such case the ACPI handle
+	 * of a GPIO device is NULL and can not be used. Hence we have to check
+	 * the parent device to be sure that there is no match before bailing
+	 * out.
+	 */
+	if (gc->parent)
+		return device_match_acpi_handle(gc->parent, data);
+
+	return false;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7753a2e64d41..941d6e379b8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5809,13 +5809,18 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
 	*speed = PCI_SPEED_UNKNOWN;
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
 
-	while ((parent = pci_upstream_bridge(parent))) {
-		/* skip upstream/downstream switches internal to dGPU*/
-		if (parent->vendor == PCI_VENDOR_ID_ATI)
-			continue;
-		*speed = pcie_get_speed_cap(parent);
-		*width = pcie_get_width_cap(parent);
-		break;
+	if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
+		while ((parent = pci_upstream_bridge(parent))) {
+			/* skip upstream/downstream switches internal to dGPU*/
+			if (parent->vendor == PCI_VENDOR_ID_ATI)
+				continue;
+			*speed = pcie_get_speed_cap(parent);
+			*width = pcie_get_width_cap(parent);
+			break;
+		}
+	} else {
+		/* use the current speeds rather than max if switching is not supported */
+		pcie_bandwidth_available(adev->pdev, NULL, speed, width);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index b53c8fd4e8cf..d89d6829f1df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -431,16 +431,16 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
 {
-	const char *chip_name;
+	char ucode_prefix[15];
 	int r;
 
-	chip_name = "gc_9_4_3";
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	r = gfx_v9_4_3_init_rlc_microcode(adev, chip_name);
+	r = gfx_v9_4_3_init_rlc_microcode(adev, ucode_prefix);
 	if (r)
 		return r;
 
-	r = gfx_v9_4_3_init_cp_compute_microcode(adev, chip_name);
+	r = gfx_v9_4_3_init_cp_compute_microcode(adev, ucode_prefix);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index cb31a699c662..1a269099f19f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -613,6 +613,9 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 		&connector->base,
 		dev->mode_config.tile_property,
 		0);
+	connector->colorspace_property = master->base.colorspace_property;
+	if (connector->colorspace_property)
+		drm_connector_attach_colorspace_property(connector);
 
 	drm_connector_set_path_property(connector, pathprop);
 
diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index 5965e8027529..8dd89efa8ea7 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -8,8 +8,8 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
 	depends on OF
 	depends on COMMON_CLK
 	select DRM_DW_HDMI
-	select DRM_IMX8MP_HDMI_PVI
-	select PHY_FSL_SAMSUNG_HDMI_PHY
+	imply DRM_IMX8MP_HDMI_PVI
+	imply PHY_FSL_SAMSUNG_HDMI_PHY
 	help
 	  Choose this to enable support for the internal HDMI encoder found
 	  on the i.MX8MP SoC.
diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index fea4f00a20f8..c73767063192 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -454,10 +454,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
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
@@ -468,14 +464,15 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
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
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 4814b7b6d1fd..57a7ed13f996 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -478,7 +478,6 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		dev_err(ctx->dev, "failed to lock PLL, ret=%i\n", ret);
 		/* On failure, disable PLL again and exit. */
 		regmap_write(ctx->regmap, REG_RC_PLL_EN, 0x00);
-		regulator_disable(ctx->vcc);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/intel_engine_cs.c b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
index 7a6dc371c384..bc6209df0f68 100644
--- a/drivers/gpu/drm/i915/gt/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/intel_engine_cs.c
@@ -919,6 +919,12 @@ static intel_engine_mask_t init_engine_mask(struct intel_gt *gt)
 	if (IS_DG2(gt->i915)) {
 		u8 first_ccs = __ffs(CCS_MASK(gt));
 
+		/*
+		 * Store the number of active cslices before
+		 * changing the CCS engine configuration
+		 */
+		gt->ccs.cslices = CCS_MASK(gt);
+
 		/* Mask off all the CCS engine */
 		info->engine_mask &= ~GENMASK(CCS3, CCS0);
 		/* Put back in the first CCS engine */
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
index 99b71bb7da0a..3c62a44e9106 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
+++ b/drivers/gpu/drm/i915/gt/intel_gt_ccs_mode.c
@@ -19,7 +19,7 @@ unsigned int intel_gt_apply_ccs_mode(struct intel_gt *gt)
 
 	/* Build the value for the fixed CCS load balancing */
 	for (cslice = 0; cslice < I915_MAX_CCS; cslice++) {
-		if (CCS_MASK(gt) & BIT(cslice))
+		if (gt->ccs.cslices & BIT(cslice))
 			/*
 			 * If available, assign the cslice
 			 * to the first available engine...
diff --git a/drivers/gpu/drm/i915/gt/intel_gt_types.h b/drivers/gpu/drm/i915/gt/intel_gt_types.h
index def7dd0eb6f1..cfdd2ad5e954 100644
--- a/drivers/gpu/drm/i915/gt/intel_gt_types.h
+++ b/drivers/gpu/drm/i915/gt/intel_gt_types.h
@@ -207,6 +207,14 @@ struct intel_gt {
 					    [MAX_ENGINE_INSTANCE + 1];
 	enum intel_submission_method submission_method;
 
+	struct {
+		/*
+		 * Mask of the non fused CCS slices
+		 * to be used for the load balancing
+		 */
+		intel_engine_mask_t cslices;
+	} ccs;
+
 	/*
 	 * Default address space (either GGTT or ppGTT depending on arch).
 	 *
diff --git a/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h b/drivers/gpu/drm/i915/gt/uc/abi/guc_klvs_abi.h
index 58012edd4eb0..4f4f53c42a9c 100644
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
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 0ba72102636a..536366956447 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2104,7 +2104,7 @@ static ssize_t mtk_dp_aux_transfer(struct drm_dp_aux *mtk_aux,
 
 	if (mtk_dp->bridge.type != DRM_MODE_CONNECTOR_eDP &&
 	    !mtk_dp->train_info.cable_plugged_in) {
-		ret = -EAGAIN;
+		ret = -EIO;
 		goto err;
 	}
 
diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
index a6bc1bdb3d0d..a10cff3ca1fe 100644
--- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
+++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
@@ -95,6 +95,7 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	clk_disable_unprepare(mipi_dsi->px_clk);
 	ret = clk_set_rate(mipi_dsi->px_clk, mipi_dsi->mode->clock * 1000);
 
 	if (ret) {
@@ -103,6 +104,12 @@ static int dw_mipi_dsi_phy_init(void *priv_data)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(mipi_dsi->px_clk);
+	if (ret) {
+		dev_err(mipi_dsi->dev, "Failed to enable DSI Pixel clock (ret %d)\n", ret);
+		return ret;
+	}
+
 	switch (mipi_dsi->dsi_device->format) {
 	case MIPI_DSI_FMT_RGB888:
 		dpi_data_format = DPI_COLOR_24BIT;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index cf0b1de1c071..7b72327df7f3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -284,7 +284,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	a6xx_set_pagetable(a6xx_gpu, ring, submit->queue->ctx);
 
-	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
+	get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
 		rbmemptr_stats(ring, index, cpcycles_start));
 	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
 		rbmemptr_stats(ring, index, alwayson_start));
@@ -330,7 +330,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_PKT7(ring, CP_SET_MARKER, 1);
 	OUT_RING(ring, 0x00e); /* IB1LIST end */
 
-	get_stats_counter(ring, REG_A6XX_RBBM_PERFCTR_CP(0),
+	get_stats_counter(ring, REG_A7XX_RBBM_PERFCTR_CP(0),
 		rbmemptr_stats(ring, index, cpcycles_end));
 	get_stats_counter(ring, REG_A6XX_CP_ALWAYS_ON_COUNTER,
 		rbmemptr_stats(ring, index, alwayson_end));
@@ -3062,7 +3062,8 @@ struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 
 	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
 	if (ret) {
-		a6xx_destroy(&(a6xx_gpu->base.base));
+		a6xx_llc_slices_destroy(a6xx_gpu);
+		kfree(a6xx_gpu);
 		return ERR_PTR(ret);
 	}
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
index fc1d5736d7fc..489be1c0c704 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
@@ -448,9 +448,6 @@ static void dpu_encoder_phys_cmd_enable_helper(
 
 	_dpu_encoder_phys_cmd_pingpong_config(phys_enc);
 
-	if (!dpu_encoder_phys_cmd_is_master(phys_enc))
-		return;
-
 	ctl = phys_enc->hw_ctl;
 	ctl->ops.update_pending_flush_intf(ctl, phys_enc->hw_intf->idx);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
index a06f69d0b257..2e50049f2f85 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
@@ -545,6 +545,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 {
 	struct dpu_hw_blk_reg_map *c = &ctx->hw;
 	u32 intf_active = 0;
+	u32 dsc_active = 0;
 	u32 wb_active = 0;
 	u32 mode_sel = 0;
 
@@ -560,6 +561,7 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 
 	intf_active = DPU_REG_READ(c, CTL_INTF_ACTIVE);
 	wb_active = DPU_REG_READ(c, CTL_WB_ACTIVE);
+	dsc_active = DPU_REG_READ(c, CTL_DSC_ACTIVE);
 
 	if (cfg->intf)
 		intf_active |= BIT(cfg->intf - INTF_0);
@@ -567,17 +569,18 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
 	if (cfg->wb)
 		wb_active |= BIT(cfg->wb - WB_0);
 
+	if (cfg->dsc)
+		dsc_active |= cfg->dsc;
+
 	DPU_REG_WRITE(c, CTL_TOP, mode_sel);
 	DPU_REG_WRITE(c, CTL_INTF_ACTIVE, intf_active);
 	DPU_REG_WRITE(c, CTL_WB_ACTIVE, wb_active);
+	DPU_REG_WRITE(c, CTL_DSC_ACTIVE, dsc_active);
 
 	if (cfg->merge_3d)
 		DPU_REG_WRITE(c, CTL_MERGE_3D_ACTIVE,
 			      BIT(cfg->merge_3d - MERGE_3D_0));
 
-	if (cfg->dsc)
-		DPU_REG_WRITE(c, CTL_DSC_ACTIVE, cfg->dsc);
-
 	if (cfg->cdm)
 		DPU_REG_WRITE(c, CTL_CDM_ACTIVE, cfg->cdm);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 6a0a74832fb6..b85881aab047 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -223,9 +223,11 @@ static void dpu_core_irq_callback_handler(struct dpu_kms *dpu_kms, unsigned int
 
 	VERB("IRQ=[%d, %d]\n", DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
 
-	if (!irq_entry->cb)
+	if (!irq_entry->cb) {
 		DRM_ERROR("no registered cb, IRQ=[%d, %d]\n",
 			  DPU_IRQ_REG(irq_idx), DPU_IRQ_BIT(irq_idx));
+		return;
+	}
 
 	atomic_inc(&irq_entry->count);
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 9d86a6aca6f2..c80be74cf10b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -356,8 +356,8 @@ int dsi_link_clk_set_rate_6g(struct msm_dsi_host *msm_host)
 {
 	int ret;
 
-	DBG("Set clk rates: pclk=%d, byteclk=%lu",
-		msm_host->mode->clock, msm_host->byte_clk_rate);
+	DBG("Set clk rates: pclk=%lu, byteclk=%lu",
+	    msm_host->pixel_clk_rate, msm_host->byte_clk_rate);
 
 	ret = dev_pm_opp_set_rate(&msm_host->pdev->dev,
 				  msm_host->byte_clk_rate);
@@ -430,9 +430,9 @@ int dsi_link_clk_set_rate_v2(struct msm_dsi_host *msm_host)
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
diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 80f74ee0fc78..47e53e17b4e5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -272,6 +272,9 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
 		getparam->value = (u64)ttm_resource_manager_usage(vram_mgr);
 		break;
 	}
+	case NOUVEAU_GETPARAM_HAS_VMA_TILEMODE:
+		getparam->value = 1;
+		break;
 	default:
 		NV_PRINTK(dbg, cli, "unknown parameter %lld\n", getparam->param);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index db8cbf615112..186add400ea5 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -241,28 +241,28 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 	}
 
 	nvbo->contig = !(tile_flags & NOUVEAU_GEM_TILE_NONCONTIG);
-	if (!nouveau_cli_uvmm(cli) || internal) {
-		/* for BO noVM allocs, don't assign kinds */
-		if (cli->device.info.family >= NV_DEVICE_INFO_V0_FERMI) {
-			nvbo->kind = (tile_flags & 0x0000ff00) >> 8;
-			if (!nvif_mmu_kind_valid(mmu, nvbo->kind)) {
-				kfree(nvbo);
-				return ERR_PTR(-EINVAL);
-			}
 
-			nvbo->comp = mmu->kind[nvbo->kind] != nvbo->kind;
-		} else if (cli->device.info.family >= NV_DEVICE_INFO_V0_TESLA) {
-			nvbo->kind = (tile_flags & 0x00007f00) >> 8;
-			nvbo->comp = (tile_flags & 0x00030000) >> 16;
-			if (!nvif_mmu_kind_valid(mmu, nvbo->kind)) {
-				kfree(nvbo);
-				return ERR_PTR(-EINVAL);
-			}
-		} else {
-			nvbo->zeta = (tile_flags & 0x00000007);
+	if (cli->device.info.family >= NV_DEVICE_INFO_V0_FERMI) {
+		nvbo->kind = (tile_flags & 0x0000ff00) >> 8;
+		if (!nvif_mmu_kind_valid(mmu, nvbo->kind)) {
+			kfree(nvbo);
+			return ERR_PTR(-EINVAL);
+		}
+
+		nvbo->comp = mmu->kind[nvbo->kind] != nvbo->kind;
+	} else if (cli->device.info.family >= NV_DEVICE_INFO_V0_TESLA) {
+		nvbo->kind = (tile_flags & 0x00007f00) >> 8;
+		nvbo->comp = (tile_flags & 0x00030000) >> 16;
+		if (!nvif_mmu_kind_valid(mmu, nvbo->kind)) {
+			kfree(nvbo);
+			return ERR_PTR(-EINVAL);
 		}
-		nvbo->mode = tile_mode;
+	} else {
+		nvbo->zeta = (tile_flags & 0x00000007);
+	}
+	nvbo->mode = tile_mode;
 
+	if (!nouveau_cli_uvmm(cli) || internal) {
 		/* Determine the desirable target GPU page size for the buffer. */
 		for (i = 0; i < vmm->page_nr; i++) {
 			/* Because we cannot currently allow VMM maps to fail
@@ -304,12 +304,6 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 domain,
 		}
 		nvbo->page = vmm->page[pi].shift;
 	} else {
-		/* reject other tile flags when in VM mode. */
-		if (tile_mode)
-			return ERR_PTR(-EINVAL);
-		if (tile_flags & ~NOUVEAU_GEM_TILE_NONCONTIG)
-			return ERR_PTR(-EINVAL);
-
 		/* Determine the desirable target GPU page size for the buffer. */
 		for (i = 0; i < vmm->page_nr; i++) {
 			/* Because we cannot currently allow VMM maps to fail
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index 88e80fe98112..e8f385b9c618 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -282,15 +282,15 @@ static const struct drm_display_mode et028013dma_mode = {
 static const struct drm_display_mode jt240mhqs_hwt_ek_e3_mode = {
 	.clock = 6000,
 	.hdisplay = 240,
-	.hsync_start = 240 + 28,
-	.hsync_end = 240 + 28 + 10,
-	.htotal = 240 + 28 + 10 + 10,
+	.hsync_start = 240 + 38,
+	.hsync_end = 240 + 38 + 10,
+	.htotal = 240 + 38 + 10 + 10,
 	.vdisplay = 280,
-	.vsync_start = 280 + 8,
-	.vsync_end = 280 + 8 + 4,
-	.vtotal = 280 + 8 + 4 + 4,
-	.width_mm = 43,
-	.height_mm = 37,
+	.vsync_start = 280 + 48,
+	.vsync_end = 280 + 48 + 4,
+	.vtotal = 280 + 48 + 4 + 4,
+	.width_mm = 37,
+	.height_mm = 43,
 	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
 };
 
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index d32ff3857e65..b3b37ed832ca 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -389,8 +389,14 @@ static int xe_set_dma_info(struct xe_device *xe)
 	return err;
 }
 
-/*
- * Initialize MMIO resources that don't require any knowledge about tile count.
+/**
+ * xe_device_probe_early: Device early probe
+ * @xe: xe device instance
+ *
+ * Initialize MMIO resources that don't require any
+ * knowledge about tile count. Also initialize pcode
+ *
+ * Return: 0 on success, error code on failure
  */
 int xe_device_probe_early(struct xe_device *xe)
 {
@@ -404,6 +410,10 @@ int xe_device_probe_early(struct xe_device *xe)
 	if (err)
 		return err;
 
+	err = xe_pcode_probe_early(xe);
+	if (err)
+		return err;
+
 	return 0;
 }
 
@@ -482,11 +492,8 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
 
-	for_each_gt(gt, xe, id) {
-		err = xe_pcode_probe(gt);
-		if (err)
-			return err;
-	}
+	for_each_gt(gt, xe, id)
+		xe_pcode_init(gt);
 
 	err = xe_display_init_noirq(xe);
 	if (err)
diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 2ba4fb9511f6..aca519f5b85d 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -33,7 +33,6 @@
 #include "xe_sync.h"
 #include "xe_trace.h"
 #include "xe_vm.h"
-#include "xe_wa.h"
 
 /**
  * struct xe_migrate - migrate context.
@@ -299,10 +298,6 @@ static int xe_migrate_prepare_vm(struct xe_tile *tile, struct xe_migrate *m,
 }
 
 /*
- * Due to workaround 16017236439, odd instance hardware copy engines are
- * faster than even instance ones.
- * This function returns the mask involving all fast copy engines and the
- * reserved copy engine to be used as logical mask for migrate engine.
  * Including the reserved copy engine is required to avoid deadlocks due to
  * migrate jobs servicing the faults gets stuck behind the job that faulted.
  */
@@ -316,8 +311,7 @@ static u32 xe_migrate_usm_logical_mask(struct xe_gt *gt)
 		if (hwe->class != XE_ENGINE_CLASS_COPY)
 			continue;
 
-		if (!XE_WA(gt, 16017236439) ||
-		    xe_gt_is_usm_hwe(gt, hwe) || hwe->instance & 1)
+		if (xe_gt_is_usm_hwe(gt, hwe))
 			logical_mask |= BIT(hwe->logical_instance);
 	}
 
@@ -368,6 +362,10 @@ struct xe_migrate *xe_migrate_init(struct xe_tile *tile)
 		if (!hwe || !logical_mask)
 			return ERR_PTR(-EINVAL);
 
+		/*
+		 * XXX: Currently only reserving 1 (likely slow) BCS instance on
+		 * PVC, may want to revisit if performance is needed.
+		 */
 		m->q = xe_exec_queue_create(xe, vm, logical_mask, 1, hwe,
 					    EXEC_QUEUE_FLAG_KERNEL |
 					    EXEC_QUEUE_FLAG_PERMANENT |
diff --git a/drivers/gpu/drm/xe/xe_pcode.c b/drivers/gpu/drm/xe/xe_pcode.c
index b324dc2a5deb..81f4ae2ea08f 100644
--- a/drivers/gpu/drm/xe/xe_pcode.c
+++ b/drivers/gpu/drm/xe/xe_pcode.c
@@ -10,6 +10,7 @@
 
 #include <drm/drm_managed.h>
 
+#include "xe_device.h"
 #include "xe_gt.h"
 #include "xe_mmio.h"
 #include "xe_pcode_api.h"
@@ -43,8 +44,6 @@ static int pcode_mailbox_status(struct xe_gt *gt)
 		[PCODE_ERROR_MASK] = {-EPROTO, "Unknown"},
 	};
 
-	lockdep_assert_held(&gt->pcode.lock);
-
 	err = xe_mmio_read32(gt, PCODE_MAILBOX) & PCODE_ERROR_MASK;
 	if (err) {
 		drm_err(&gt_to_xe(gt)->drm, "PCODE Mailbox failed: %d %s", err,
@@ -55,17 +54,15 @@ static int pcode_mailbox_status(struct xe_gt *gt)
 	return 0;
 }
 
-static int pcode_mailbox_rw(struct xe_gt *gt, u32 mbox, u32 *data0, u32 *data1,
-			    unsigned int timeout_ms, bool return_data,
-			    bool atomic)
+static int __pcode_mailbox_rw(struct xe_gt *gt, u32 mbox, u32 *data0, u32 *data1,
+			      unsigned int timeout_ms, bool return_data,
+			      bool atomic)
 {
 	int err;
 
 	if (gt_to_xe(gt)->info.skip_pcode)
 		return 0;
 
-	lockdep_assert_held(&gt->pcode.lock);
-
 	if ((xe_mmio_read32(gt, PCODE_MAILBOX) & PCODE_READY) != 0)
 		return -EAGAIN;
 
@@ -87,6 +84,18 @@ static int pcode_mailbox_rw(struct xe_gt *gt, u32 mbox, u32 *data0, u32 *data1,
 	return pcode_mailbox_status(gt);
 }
 
+static int pcode_mailbox_rw(struct xe_gt *gt, u32 mbox, u32 *data0, u32 *data1,
+			    unsigned int timeout_ms, bool return_data,
+			    bool atomic)
+{
+	if (gt_to_xe(gt)->info.skip_pcode)
+		return 0;
+
+	lockdep_assert_held(&gt->pcode.lock);
+
+	return __pcode_mailbox_rw(gt, mbox, data0, data1, timeout_ms, return_data, atomic);
+}
+
 int xe_pcode_write_timeout(struct xe_gt *gt, u32 mbox, u32 data, int timeout)
 {
 	int err;
@@ -109,15 +118,19 @@ int xe_pcode_read(struct xe_gt *gt, u32 mbox, u32 *val, u32 *val1)
 	return err;
 }
 
-static int xe_pcode_try_request(struct xe_gt *gt, u32 mbox,
-				u32 request, u32 reply_mask, u32 reply,
-				u32 *status, bool atomic, int timeout_us)
+static int pcode_try_request(struct xe_gt *gt, u32 mbox,
+			     u32 request, u32 reply_mask, u32 reply,
+			     u32 *status, bool atomic, int timeout_us, bool locked)
 {
 	int slept, wait = 10;
 
 	for (slept = 0; slept < timeout_us; slept += wait) {
-		*status = pcode_mailbox_rw(gt, mbox, &request, NULL, 1, true,
-					   atomic);
+		if (locked)
+			*status = pcode_mailbox_rw(gt, mbox, &request, NULL, 1, true,
+						   atomic);
+		else
+			*status = __pcode_mailbox_rw(gt, mbox, &request, NULL, 1, true,
+						     atomic);
 		if ((*status == 0) && ((request & reply_mask) == reply))
 			return 0;
 
@@ -158,8 +171,8 @@ int xe_pcode_request(struct xe_gt *gt, u32 mbox, u32 request,
 
 	mutex_lock(&gt->pcode.lock);
 
-	ret = xe_pcode_try_request(gt, mbox, request, reply_mask, reply, &status,
-				   false, timeout_base_ms * 1000);
+	ret = pcode_try_request(gt, mbox, request, reply_mask, reply, &status,
+				false, timeout_base_ms * 1000, true);
 	if (!ret)
 		goto out;
 
@@ -177,8 +190,8 @@ int xe_pcode_request(struct xe_gt *gt, u32 mbox, u32 request,
 		"PCODE timeout, retrying with preemption disabled\n");
 	drm_WARN_ON_ONCE(&gt_to_xe(gt)->drm, timeout_base_ms > 1);
 	preempt_disable();
-	ret = xe_pcode_try_request(gt, mbox, request, reply_mask, reply, &status,
-				   true, timeout_base_ms * 1000);
+	ret = pcode_try_request(gt, mbox, request, reply_mask, reply, &status,
+				true, 50 * 1000, true);
 	preempt_enable();
 
 out:
@@ -238,59 +251,71 @@ int xe_pcode_init_min_freq_table(struct xe_gt *gt, u32 min_gt_freq,
 }
 
 /**
- * xe_pcode_init - Ensure PCODE is initialized
- * @gt: gt instance
+ * xe_pcode_ready - Ensure PCODE is initialized
+ * @xe: xe instance
+ * @locked: true if lock held, false otherwise
  *
- * This function ensures that PCODE is properly initialized. To be called during
- * probe and resume paths.
+ * PCODE init mailbox is polled only on root gt of root tile
+ * as the root tile provides the initialization is complete only
+ * after all the tiles have completed the initialization.
+ * Called only on early probe without locks and with locks in
+ * resume path.
  *
- * It returns 0 on success, and -error number on failure.
+ * Returns 0 on success, and -error number on failure.
  */
-int xe_pcode_init(struct xe_gt *gt)
+int xe_pcode_ready(struct xe_device *xe, bool locked)
 {
 	u32 status, request = DGFX_GET_INIT_STATUS;
+	struct xe_gt *gt = xe_root_mmio_gt(xe);
 	int timeout_us = 180000000; /* 3 min */
 	int ret;
 
-	if (gt_to_xe(gt)->info.skip_pcode)
+	if (xe->info.skip_pcode)
 		return 0;
 
-	if (!IS_DGFX(gt_to_xe(gt)))
+	if (!IS_DGFX(xe))
 		return 0;
 
-	mutex_lock(&gt->pcode.lock);
-	ret = xe_pcode_try_request(gt, DGFX_PCODE_STATUS, request,
-				   DGFX_INIT_STATUS_COMPLETE,
-				   DGFX_INIT_STATUS_COMPLETE,
-				   &status, false, timeout_us);
-	mutex_unlock(&gt->pcode.lock);
+	if (locked)
+		mutex_lock(&gt->pcode.lock);
+
+	ret = pcode_try_request(gt, DGFX_PCODE_STATUS, request,
+				DGFX_INIT_STATUS_COMPLETE,
+				DGFX_INIT_STATUS_COMPLETE,
+				&status, false, timeout_us, locked);
+
+	if (locked)
+		mutex_unlock(&gt->pcode.lock);
 
 	if (ret)
-		drm_err(&gt_to_xe(gt)->drm,
+		drm_err(&xe->drm,
 			"PCODE initialization timedout after: 3 min\n");
 
 	return ret;
 }
 
 /**
- * xe_pcode_probe - Prepare xe_pcode and also ensure PCODE is initialized.
+ * xe_pcode_init: initialize components of PCODE
  * @gt: gt instance
  *
- * This function initializes the xe_pcode component, and when needed, it ensures
- * that PCODE has properly performed its initialization and it is really ready
- * to go. To be called once only during probe.
- *
- * It returns 0 on success, and -error number on failure.
+ * This function initializes the xe_pcode component.
+ * To be called once only during probe.
  */
-int xe_pcode_probe(struct xe_gt *gt)
+void xe_pcode_init(struct xe_gt *gt)
 {
 	drmm_mutex_init(&gt_to_xe(gt)->drm, &gt->pcode.lock);
+}
 
-	if (gt_to_xe(gt)->info.skip_pcode)
-		return 0;
-
-	if (!IS_DGFX(gt_to_xe(gt)))
-		return 0;
-
-	return xe_pcode_init(gt);
+/**
+ * xe_pcode_probe_early: initializes PCODE
+ * @xe: xe instance
+ *
+ * This function checks the initialization status of PCODE
+ * To be called once only during early probe without locks.
+ *
+ * Returns 0 on success, error code otherwise
+ */
+int xe_pcode_probe_early(struct xe_device *xe)
+{
+	return xe_pcode_ready(xe, false);
 }
diff --git a/drivers/gpu/drm/xe/xe_pcode.h b/drivers/gpu/drm/xe/xe_pcode.h
index 08cb1d047cba..3f54c6d2a57d 100644
--- a/drivers/gpu/drm/xe/xe_pcode.h
+++ b/drivers/gpu/drm/xe/xe_pcode.h
@@ -8,9 +8,11 @@
 
 #include <linux/types.h>
 struct xe_gt;
+struct xe_device;
 
-int xe_pcode_probe(struct xe_gt *gt);
-int xe_pcode_init(struct xe_gt *gt);
+void xe_pcode_init(struct xe_gt *gt);
+int xe_pcode_probe_early(struct xe_device *xe);
+int xe_pcode_ready(struct xe_device *xe, bool locked);
 int xe_pcode_init_min_freq_table(struct xe_gt *gt, u32 min_gt_freq,
 				 u32 max_gt_freq);
 int xe_pcode_read(struct xe_gt *gt, u32 mbox, u32 *val, u32 *val1);
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index 53b3b0b019ac..944cf4d76099 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -54,13 +54,15 @@ int xe_pm_suspend(struct xe_device *xe)
 	u8 id;
 	int err;
 
+	drm_dbg(&xe->drm, "Suspending device\n");
+
 	for_each_gt(gt, xe, id)
 		xe_gt_suspend_prepare(gt);
 
 	/* FIXME: Super racey... */
 	err = xe_bo_evict_all(xe);
 	if (err)
-		return err;
+		goto err;
 
 	xe_display_pm_suspend(xe);
 
@@ -68,7 +70,7 @@ int xe_pm_suspend(struct xe_device *xe)
 		err = xe_gt_suspend(gt);
 		if (err) {
 			xe_display_pm_resume(xe);
-			return err;
+			goto err;
 		}
 	}
 
@@ -76,7 +78,11 @@ int xe_pm_suspend(struct xe_device *xe)
 
 	xe_display_pm_suspend_late(xe);
 
+	drm_dbg(&xe->drm, "Device suspended\n");
 	return 0;
+err:
+	drm_dbg(&xe->drm, "Device suspend failed %d\n", err);
+	return err;
 }
 
 /**
@@ -92,14 +98,14 @@ int xe_pm_resume(struct xe_device *xe)
 	u8 id;
 	int err;
 
+	drm_dbg(&xe->drm, "Resuming device\n");
+
 	for_each_tile(tile, xe, id)
 		xe_wa_apply_tile_workarounds(tile);
 
-	for_each_gt(gt, xe, id) {
-		err = xe_pcode_init(gt);
-		if (err)
-			return err;
-	}
+	err = xe_pcode_ready(xe, true);
+	if (err)
+		return err;
 
 	xe_display_pm_resume_early(xe);
 
@@ -109,7 +115,7 @@ int xe_pm_resume(struct xe_device *xe)
 	 */
 	err = xe_bo_restore_kernel(xe);
 	if (err)
-		return err;
+		goto err;
 
 	xe_irq_resume(xe);
 
@@ -120,9 +126,13 @@ int xe_pm_resume(struct xe_device *xe)
 
 	err = xe_bo_restore_user(xe);
 	if (err)
-		return err;
+		goto err;
 
+	drm_dbg(&xe->drm, "Device resumed\n");
 	return 0;
+err:
+	drm_dbg(&xe->drm, "Device resume failed %d\n", err);
+	return err;
 }
 
 static bool xe_pm_pci_d3cold_capable(struct xe_device *xe)
@@ -310,11 +320,9 @@ int xe_pm_runtime_resume(struct xe_device *xe)
 	xe->d3cold.power_lost = xe_guc_in_reset(&gt->uc.guc);
 
 	if (xe->d3cold.allowed && xe->d3cold.power_lost) {
-		for_each_gt(gt, xe, id) {
-			err = xe_pcode_init(gt);
-			if (err)
-				goto out;
-		}
+		err = xe_pcode_ready(xe, true);
+		if (err)
+			goto out;
 
 		/*
 		 * This only restores pinned memory which is the memory
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 88eb33acd5f0..face8d6b2a6f 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -256,12 +256,12 @@ static int zynqmp_dpsub_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_dp;
 
+	drm_bridge_add(dpsub->bridge);
+
 	if (dpsub->dma_enabled) {
 		ret = zynqmp_dpsub_drm_init(dpsub);
 		if (ret)
 			goto err_disp;
-	} else {
-		drm_bridge_add(dpsub->bridge);
 	}
 
 	dev_info(&pdev->dev, "ZynqMP DisplayPort Subsystem driver probed");
@@ -288,9 +288,8 @@ static void zynqmp_dpsub_remove(struct platform_device *pdev)
 
 	if (dpsub->drm)
 		zynqmp_dpsub_drm_cleanup(dpsub);
-	else
-		drm_bridge_remove(dpsub->bridge);
 
+	drm_bridge_remove(dpsub->bridge);
 	zynqmp_disp_remove(dpsub);
 	zynqmp_dp_remove(dpsub);
 
diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
index 6500ca548f9c..ca2dff158925 100644
--- a/drivers/hwmon/intel-m10-bmc-hwmon.c
+++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
@@ -429,7 +429,7 @@ static const struct m10bmc_sdata n6000bmc_curr_tbl[] = {
 };
 
 static const struct m10bmc_sdata n6000bmc_power_tbl[] = {
-	{ 0x724, 0x0, 0x0, 0x0, 0x0, 1, "Board Power" },
+	{ 0x724, 0x0, 0x0, 0x0, 0x0, 1000, "Board Power" },
 };
 
 static const struct hwmon_channel_info * const n6000bmc_hinfo[] = {
diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index 1f96e94967ee..439dd3dba5fc 100644
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
index c2ca4a02dfce..a0bdfabddbc6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1240,6 +1240,8 @@ static void etm4_init_arch_data(void *info)
 	drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
 	/* QSUPP, bits[16:15] Q element support field */
 	drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
+	if (drvdata->q_support)
+		drvdata->q_filt = !!(etmidr0 & TRCIDR0_QFILT);
 	/* TSSIZE, bits[28:24] Global timestamp size field */
 	drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
 
@@ -1732,16 +1734,14 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
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
@@ -1758,7 +1758,8 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trccntvr[i] = etm4x_read32(csa, TRCCNTVRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/* Resource selector pair 0 is reserved */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		state->trcrsctlr[i] = etm4x_read32(csa, TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
@@ -1843,8 +1844,10 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
@@ -1863,16 +1866,14 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
@@ -1889,7 +1890,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, state->trccntvr[i], TRCCNTVRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_resource * 2; i++)
+	/* Resource selector pair 0 is reserved */
+	for (i = 2; i < drvdata->nr_resource * 2; i++)
 		etm4x_relaxed_write32(csa, state->trcrsctlr[i], TRCRSCTLRn(i));
 
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
@@ -2213,6 +2215,9 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	ret = etm4_probe(&pdev->dev);
 
 	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
 	return ret;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9ea678bc2e8e..9e9165f62e81 100644
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
@@ -907,9 +883,6 @@ struct etmv4_save_state {
 	u32	trcviiectlr;
 	u32	trcvissctlr;
 	u32	trcvipcssctlr;
-	u32	trcvdctlr;
-	u32	trcvdsacctlr;
-	u32	trcvdarcctlr;
 
 	u32	trcseqevr[ETM_MAX_SEQ_STATES];
 	u32	trcseqrstevr;
@@ -982,6 +955,7 @@ struct etmv4_save_state {
  * @os_unlock:  True if access to management registers is allowed.
  * @instrp0:	Tracing of load and store instructions
  *		as P0 elements is supported.
+ * @q_filt:	Q element filtering support, if Q elements are supported.
  * @trcbb:	Indicates if the trace unit supports branch broadcast tracing.
  * @trccond:	If the trace unit supports conditional
  *		instruction tracing.
@@ -1044,6 +1018,7 @@ struct etmv4_drvdata {
 	bool				boot_enable;
 	bool				os_unlock;
 	bool				instrp0;
+	bool				q_filt;
 	bool				trcbb;
 	bool				trccond;
 	bool				retstack;
diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 534fbefc7f6a..20895d391562 100644
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
diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index 4bb7d6756947..2fce3e84ba64 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -633,6 +633,7 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
 
 	if (hold_clear) {
 		ctrl_reg &= ~CDNS_I2C_CR_HOLD;
+		ctrl_reg &= ~CDNS_I2C_CR_CLR_FIFO;
 		/*
 		 * In case of Xilinx Zynq SOC, clear the HOLD bit before transfer size
 		 * register reaches '0'. This is an IP bug which causes transfer size
diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index bbea521b05dd..a73f5bb9a164 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -550,17 +550,13 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "socionext,pclk-rate",
 				 &i2c->pclkrate);
 
-	i2c->pclk = devm_clk_get(&pdev->dev, "pclk");
-	if (PTR_ERR(i2c->pclk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-	if (!IS_ERR_OR_NULL(i2c->pclk)) {
-		dev_dbg(&pdev->dev, "clock source %p\n", i2c->pclk);
-
-		ret = clk_prepare_enable(i2c->pclk);
-		if (ret)
-			return dev_err_probe(&pdev->dev, ret, "failed to enable clock\n");
-		i2c->pclkrate = clk_get_rate(i2c->pclk);
-	}
+	i2c->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	if (IS_ERR(i2c->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->pclk),
+				     "failed to get and enable clock\n");
+
+	dev_dbg(&pdev->dev, "clock source %p\n", i2c->pclk);
+	i2c->pclkrate = clk_get_rate(i2c->pclk);
 
 	if (i2c->pclkrate < SYNQUACER_I2C_MIN_CLK_RATE ||
 	    i2c->pclkrate > SYNQUACER_I2C_MAX_CLK_RATE)
@@ -615,8 +611,6 @@ static void synquacer_i2c_remove(struct platform_device *pdev)
 	struct synquacer_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&i2c->adapter);
-	if (!IS_ERR(i2c->pclk))
-		clk_disable_unprepare(i2c->pclk);
 };
 
 static const struct of_device_id synquacer_i2c_dt_ids[] __maybe_unused = {
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 5ee4db68988e..a2298ab460a3 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1080,7 +1080,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 * and yield the above events handler.
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-		ret = -ENXIO;
+		ret = -EAGAIN;
 		*actual_len = 0;
 		goto emit_stop;
 	}
diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 4156639b3c8b..a543b91124b0 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -207,9 +207,9 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (*expected_ver > ver) {
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
 		dev_err(&pdev->dev,
-			"IP core version is too old. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
+			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
 			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
 			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
 			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index e0c2742da523..8a0c35742212 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -787,6 +787,15 @@ static int pac1934_read_raw(struct iio_dev *indio_dev,
 	s64 curr_energy;
 	int ret, channel = chan->channel - 1;
 
+	/*
+	 * For AVG the index should be between 5 to 8.
+	 * To calculate PAC1934_CH_VOLTAGE_AVERAGE,
+	 * respectively PAC1934_CH_CURRENT real index, we need
+	 * to remove the added offset (PAC1934_MAX_NUM_CHANNELS).
+	 */
+	if (channel >= PAC1934_MAX_NUM_CHANNELS)
+		channel = channel - PAC1934_MAX_NUM_CHANNELS;
+
 	ret = pac1934_retrieve_data(info, PAC1934_MIN_UPDATE_WAIT_TIME_US);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b5d3c9cea5c4..283c20757106 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2234,6 +2234,7 @@ static int stm32_adc_generic_chan_init(struct iio_dev *indio_dev,
 			if (vin[0] != val || vin[1] >= adc_info->max_channels) {
 				dev_err(&indio_dev->dev, "Invalid channel in%d-in%d\n",
 					vin[0], vin[1]);
+				ret = -EINVAL;
 				goto err;
 			}
 		} else if (ret != -EINVAL) {
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4302093b92c7..8684ba246969 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1654,8 +1654,10 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
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
index 1ff091b2f764..d0a516d56da4 100644
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
diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f253295795f0..be0743dac3ff 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -348,16 +348,10 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 
 static bool has_gateway(const struct dst_entry *dst, sa_family_t family)
 {
-	struct rtable *rt;
-	struct rt6_info *rt6;
-
-	if (family == AF_INET) {
-		rt = container_of(dst, struct rtable, dst);
-		return rt->rt_uses_gateway;
-	}
+	if (family == AF_INET)
+		return dst_rtable(dst)->rt_uses_gateway;
 
-	rt6 = container_of(dst, struct rt6_info, dst);
-	return rt6->rt6i_flags & RTF_GATEWAY;
+	return dst_rt6_info(dst)->rt6i_flags & RTF_GATEWAY;
 }
 
 static int fetch_ha(const struct dst_entry *dst, struct rdma_dev_addr *dev_addr,
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index 6e8cc28debd9..80d16c92a08b 100644
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
index 5c288fe7accf..79f478d3a9b3 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -13,7 +13,8 @@
 
 #define VIB_MAX_LEVEL_mV	(3100)
 #define VIB_MIN_LEVEL_mV	(1200)
-#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV)
+#define VIB_PER_STEP_mV		(100)
+#define VIB_MAX_LEVELS		(VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
 
 #define MAX_FF_SPEED		0xff
 
@@ -117,10 +118,10 @@ static void pm8xxx_work_handler(struct work_struct *work)
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
index 5979deabe23d..256f757a1326 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1347,10 +1347,16 @@ static int cyapa_suspend(struct device *dev)
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
@@ -1385,6 +1391,8 @@ static int cyapa_suspend(struct device *dev)
 		cyapa->irq_wake = (enable_irq_wake(client->irq) == 0);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
+
 	return 0;
 }
 
@@ -1394,6 +1402,7 @@ static int cyapa_resume(struct device *dev)
 	struct cyapa *cyapa = i2c_get_clientdata(client);
 	int error;
 
+	mutex_lock(&cyapa->input->mutex);
 	mutex_lock(&cyapa->state_sync_lock);
 
 	if (device_may_wakeup(dev) && cyapa->irq_wake) {
@@ -1412,6 +1421,7 @@ static int cyapa_resume(struct device *dev)
 	enable_irq(client->irq);
 
 	mutex_unlock(&cyapa->state_sync_lock);
+	mutex_unlock(&cyapa->input->mutex);
 	return 0;
 }
 
diff --git a/drivers/input/serio/ioc3kbd.c b/drivers/input/serio/ioc3kbd.c
index 50552dc7b4f5..676b0bda3d72 100644
--- a/drivers/input/serio/ioc3kbd.c
+++ b/drivers/input/serio/ioc3kbd.c
@@ -200,9 +200,16 @@ static void ioc3kbd_remove(struct platform_device *pdev)
 	serio_unregister_port(d->aux);
 }
 
+static const struct platform_device_id ioc3kbd_id_table[] = {
+	{ "ioc3-kbd", },
+	{ }
+};
+MODULE_DEVICE_TABLE(platform, ioc3kbd_id_table);
+
 static struct platform_driver ioc3kbd_driver = {
 	.probe          = ioc3kbd_probe,
 	.remove_new     = ioc3kbd_remove,
+	.id_table	= ioc3kbd_id_table,
 	.driver = {
 		.name = "ioc3-kbd",
 	},
diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
index 96735800b13c..ba4cc08684d6 100644
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
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 4e3936a39d0e..e1b414b40353 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -53,7 +53,13 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 		duty = led_dat->pwmstate.period - duty;
 
 	led_dat->pwmstate.duty_cycle = duty;
-	led_dat->pwmstate.enabled = true;
+	/*
+	 * Disabling a PWM doesn't guarantee that it emits the inactive level.
+	 * So keep it on. Only for suspending the PWM should be disabled because
+	 * otherwise it refuses to suspend. The possible downside is that the
+	 * LED might stay (or even go) on.
+	 */
+	led_dat->pwmstate.enabled = !(led_cdev->flags & LED_SUSPENDED);
 	return pwm_apply_might_sleep(led_dat->pwm, &led_dat->pwmstate);
 }
 
diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index ead2200f39ba..033aff11f87c 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -465,7 +465,7 @@ static void cmdq_mbox_shutdown(struct mbox_chan *chan)
 	struct cmdq_task *task, *tmp;
 	unsigned long flags;
 
-	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev));
+	WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev) < 0);
 
 	spin_lock_irqsave(&thread->chan->lock, flags);
 	if (list_empty(&thread->task_busy_list))
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 559a172ebc6c..da09834990b8 100644
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
@@ -771,6 +780,7 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
 {
 	struct cec_data *data;
 	bool is_raw = msg_is_raw(msg);
+	int err;
 
 	if (adap->devnode.unregistered)
 		return -ENODEV;
@@ -935,11 +945,13 @@ int cec_transmit_msg_fh(struct cec_adapter *adap, struct cec_msg *msg,
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
@@ -1575,9 +1587,12 @@ static int cec_config_thread_func(void *arg)
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
@@ -1592,6 +1607,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
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
diff --git a/drivers/media/i2c/ov2680.c b/drivers/media/i2c/ov2680.c
index 39d321e2b7f9..4577a8977c85 100644
--- a/drivers/media/i2c/ov2680.c
+++ b/drivers/media/i2c/ov2680.c
@@ -1116,25 +1116,24 @@ static int ov2680_parse_dt(struct ov2680_dev *sensor)
 	sensor->pixel_rate = sensor->link_freq[0] * 2;
 	do_div(sensor->pixel_rate, 10);
 
-	/* Verify bus cfg */
-	if (bus_cfg.bus.mipi_csi2.num_data_lanes != 1) {
-		ret = dev_err_probe(dev, -EINVAL,
-				    "only a 1-lane CSI2 config is supported");
-		goto out_free_bus_cfg;
+	if (!bus_cfg.nr_of_link_frequencies) {
+		dev_warn(dev, "Consider passing 'link-frequencies' in DT\n");
+		goto skip_link_freq_validation;
 	}
 
 	for (i = 0; i < bus_cfg.nr_of_link_frequencies; i++)
 		if (bus_cfg.link_frequencies[i] == sensor->link_freq[0])
 			break;
 
-	if (bus_cfg.nr_of_link_frequencies == 0 ||
-	    bus_cfg.nr_of_link_frequencies == i) {
+	if (bus_cfg.nr_of_link_frequencies == i) {
 		ret = dev_err_probe(dev, -EINVAL,
 				    "supported link freq %lld not found\n",
 				    sensor->link_freq[0]);
 		goto out_free_bus_cfg;
 	}
 
+skip_link_freq_validation:
+	ret = 0;
 out_free_bus_cfg:
 	v4l2_fwnode_endpoint_free(&bus_cfg);
 	return ret;
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
index a22b7dfc656e..1a2b14a3e219 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.c
@@ -58,13 +58,15 @@ int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *mtkdev)
 	return 0;
 }
 
-void mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm)
+int mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm)
 {
 	int ret;
 
 	ret = pm_runtime_resume_and_get(pm->dev);
 	if (ret)
 		dev_err(pm->dev, "pm_runtime_resume_and_get fail: %d", ret);
+
+	return ret;
 }
 
 void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm)
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
index 157ea08ba9e3..2e28f25e36cc 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
+++ b/drivers/media/platform/mediatek/vcodec/encoder/mtk_vcodec_enc_pm.h
@@ -10,7 +10,7 @@
 #include "mtk_vcodec_enc_drv.h"
 
 int mtk_vcodec_init_enc_clk(struct mtk_vcodec_enc_dev *dev);
-void mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm);
+int mtk_vcodec_enc_pw_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_pw_off(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_on(struct mtk_vcodec_pm *pm);
 void mtk_vcodec_enc_clock_off(struct mtk_vcodec_pm *pm);
diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
index c402a686f3cb..e83747b8d69a 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_drv_if.c
@@ -64,7 +64,9 @@ int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 	ctx->dev->curr_ctx = ctx;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
-	mtk_vcodec_enc_pw_on(&ctx->dev->pm);
+	ret = mtk_vcodec_enc_pw_on(&ctx->dev->pm);
+	if (ret)
+		goto venc_if_encode_pw_on_err;
 	mtk_vcodec_enc_clock_on(&ctx->dev->pm);
 	ret = ctx->enc_if->encode(ctx->drv_handle, opt, frm_buf,
 				  bs_buf, result);
@@ -75,6 +77,7 @@ int venc_if_encode(struct mtk_vcodec_enc_ctx *ctx,
 	ctx->dev->curr_ctx = NULL;
 	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
 
+venc_if_encode_pw_on_err:
 	mtk_venc_unlock(ctx);
 	return ret;
 }
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
diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
index 6da83d0cffaa..22442fce7607 100644
--- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
+++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
@@ -786,15 +786,14 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
 			dev_warn(csi->dev,
 				 "Failed to drain DMA. Next frame might be bogus\n");
 
+		spin_lock_irqsave(&dma->lock, flags);
 		ret = ti_csi2rx_start_dma(csi, buf);
 		if (ret) {
-			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
-			spin_lock_irqsave(&dma->lock, flags);
 			vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
 			dma->state = TI_CSI2RX_DMA_IDLE;
 			spin_unlock_irqrestore(&dma->lock, flags);
+			dev_err(csi->dev, "Failed to start DMA: %d\n", ret);
 		} else {
-			spin_lock_irqsave(&dma->lock, flags);
 			list_add_tail(&buf->list, &dma->submitted);
 			spin_unlock_irqrestore(&dma->lock, flags);
 		}
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
 
diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
index 45836f0a2b0a..19d20871afef 100644
--- a/drivers/media/v4l2-core/v4l2-subdev.c
+++ b/drivers/media/v4l2-core/v4l2-subdev.c
@@ -412,15 +412,6 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 	if (WARN_ON(!!sd->enabled_streams == !!enable))
 		return 0;
 
-#if IS_REACHABLE(CONFIG_LEDS_CLASS)
-	if (!IS_ERR_OR_NULL(sd->privacy_led)) {
-		if (enable)
-			led_set_brightness(sd->privacy_led,
-					   sd->privacy_led->max_brightness);
-		else
-			led_set_brightness(sd->privacy_led, 0);
-	}
-#endif
 	ret = sd->ops->video->s_stream(sd, enable);
 
 	if (!enable && ret < 0) {
@@ -428,9 +419,20 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
 		ret = 0;
 	}
 
-	if (!ret)
+	if (!ret) {
 		sd->enabled_streams = enable ? BIT(0) : 0;
 
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
+		if (!IS_ERR_OR_NULL(sd->privacy_led)) {
+			if (enable)
+				led_set_brightness(sd->privacy_led,
+						   sd->privacy_led->max_brightness);
+			else
+				led_set_brightness(sd->privacy_led, 0);
+		}
+#endif
+	}
+
 	return ret;
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
index d659c59422e1..562034af653e 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -143,16 +143,24 @@ struct sdhci_am654_data {
 	struct regmap *base;
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
@@ -232,11 +240,13 @@ static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
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
@@ -253,8 +263,8 @@ static void sdhci_am654_setup_delay_chain(struct sdhci_am654_data *sdhci_am654,
 	mask = SELDLYTXCLK_MASK | SELDLYRXCLK_MASK;
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
 
-	sdhci_am654_write_itapdly(sdhci_am654,
-				  sdhci_am654->itap_del_sel[timing]);
+	sdhci_am654_write_itapdly(sdhci_am654, sdhci_am654->itap_del_sel[timing],
+				  sdhci_am654->itap_del_ena[timing]);
 }
 
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -263,7 +273,6 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
-	u32 otap_del_ena;
 	u32 mask, val;
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
@@ -272,10 +281,9 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	/* Setup DLL Output TAP delay */
 	otap_del_sel = sdhci_am654->otap_del_sel[timing];
-	otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (otap_del_ena << OTAPDLYENA_SHIFT) |
+	val = (0x1 << OTAPDLYENA_SHIFT) |
 	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
 	/* Write to STRBSEL for HS400 speed mode */
@@ -290,10 +298,21 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
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
@@ -306,6 +325,8 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
 	u32 otap_del_sel;
+	u32 itap_del_ena;
+	u32 itap_del_sel;
 	u32 mask, val;
 
 	/* Setup DLL Output TAP delay */
@@ -314,8 +335,19 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
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
 
@@ -408,40 +440,105 @@ static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
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
 
-		if (!cur_val)
-			fail_len++;
+		if (!curr_pass) {
+			fail_window[fail_index].end = itap;
+			fail_window[fail_index].length++;
+		}
+
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
@@ -590,9 +687,12 @@ static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
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
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 7cab36f94782..db55ffdb5792 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -48,7 +48,9 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
 obj-$(CONFIG_ARCNET) += arcnet/
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
index 2b510f150dd8..2a5861a88d0e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3050,7 +3050,7 @@ phy_interface_t ksz_get_xmii(struct ksz_device *dev, int port, bool gbit)
 		else
 			interface = PHY_INTERFACE_MODE_MII;
 	} else if (val == bitval[P_RMII_SEL]) {
-		interface = PHY_INTERFACE_MODE_RGMII;
+		interface = PHY_INTERFACE_MODE_RMII;
 	} else {
 		interface = PHY_INTERFACE_MODE_RGMII;
 		if (data8 & P_RGMII_ID_EG_ENABLE)
diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 2d8a66ea82fa..713a595370bf 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -312,7 +312,6 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_sq *io_sq)
 {
 	size_t size;
-	int dev_node = 0;
 
 	memset(&io_sq->desc_addr, 0x0, sizeof(io_sq->desc_addr));
 
@@ -325,12 +324,9 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 	size = io_sq->desc_entry_size * io_sq->q_depth;
 
 	if (io_sq->mem_queue_type == ENA_ADMIN_PLACEMENT_POLICY_HOST) {
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
 		io_sq->desc_addr.virt_addr =
 			dma_alloc_coherent(ena_dev->dmadev, size, &io_sq->desc_addr.phys_addr,
 					   GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
 		if (!io_sq->desc_addr.virt_addr) {
 			io_sq->desc_addr.virt_addr =
 				dma_alloc_coherent(ena_dev->dmadev, size,
@@ -354,10 +350,7 @@ static int ena_com_init_io_sq(struct ena_com_dev *ena_dev,
 		size = (size_t)io_sq->bounce_buf_ctrl.buffer_size *
 			io_sq->bounce_buf_ctrl.buffers_num;
 
-		dev_node = dev_to_node(ena_dev->dmadev);
-		set_dev_node(ena_dev->dmadev, ctx->numa_node);
 		io_sq->bounce_buf_ctrl.base_buffer = devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
-		set_dev_node(ena_dev->dmadev, dev_node);
 		if (!io_sq->bounce_buf_ctrl.base_buffer)
 			io_sq->bounce_buf_ctrl.base_buffer =
 				devm_kzalloc(ena_dev->dmadev, size, GFP_KERNEL);
@@ -397,7 +390,6 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 			      struct ena_com_io_cq *io_cq)
 {
 	size_t size;
-	int prev_node = 0;
 
 	memset(&io_cq->cdesc_addr, 0x0, sizeof(io_cq->cdesc_addr));
 
@@ -409,11 +401,8 @@ static int ena_com_init_io_cq(struct ena_com_dev *ena_dev,
 
 	size = io_cq->cdesc_entry_size_in_bytes * io_cq->q_depth;
 
-	prev_node = dev_to_node(ena_dev->dmadev);
-	set_dev_node(ena_dev->dmadev, ctx->numa_node);
 	io_cq->cdesc_addr.virt_addr =
 		dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr, GFP_KERNEL);
-	set_dev_node(ena_dev->dmadev, prev_node);
 	if (!io_cq->cdesc_addr.virt_addr) {
 		io_cq->cdesc_addr.virt_addr =
 			dma_alloc_coherent(ena_dev->dmadev, size, &io_cq->cdesc_addr.phys_addr,
diff --git a/drivers/net/ethernet/cisco/enic/enic_main.c b/drivers/net/ethernet/cisco/enic/enic_main.c
index d266a87297a5..54798df8e254 100644
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
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index a72d8a2eb0b3..881ece735dcf 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -4130,6 +4130,14 @@ static int fec_enet_init(struct net_device *ndev)
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
@@ -4524,6 +4532,7 @@ fec_probe(struct platform_device *pdev)
 	fec_enet_mii_remove(fep);
 failed_mii_init:
 failed_irq:
+	fec_enet_deinit(ndev);
 failed_init:
 	fec_ptp_stop(pdev);
 failed_reset:
@@ -4587,6 +4596,7 @@ fec_drv_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
+	fec_enet_deinit(ndev);
 	free_netdev(ndev);
 }
 
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 181d9bfbee22..e32f6724f568 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -104,14 +104,13 @@ static int fec_ptp_enable_pps(struct fec_enet_private *fep, uint enable)
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
@@ -532,6 +531,9 @@ static int fec_ptp_enable(struct ptp_clock_info *ptp,
 	int ret = 0;
 
 	if (rq->type == PTP_CLK_REQ_PPS) {
+		fep->pps_channel = DEFAULT_PPS_CHANNEL;
+		fep->reload_period = PPS_OUPUT_RELOAD_PERIOD;
+
 		ret = fec_ptp_enable_pps(fep, on);
 
 		return ret;
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index d9f6cc71d900..e7d28432ba03 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3135,6 +3135,16 @@ ice_get_link_speed_based_on_phy_type(u64 phy_type_low, u64 phy_type_high)
 	case ICE_PHY_TYPE_HIGH_100G_AUI2:
 		speed_phy_type_high = ICE_AQ_LINK_SPEED_100GB;
 		break;
+	case ICE_PHY_TYPE_HIGH_200G_CR4_PAM4:
+	case ICE_PHY_TYPE_HIGH_200G_SR4:
+	case ICE_PHY_TYPE_HIGH_200G_FR4:
+	case ICE_PHY_TYPE_HIGH_200G_LR4:
+	case ICE_PHY_TYPE_HIGH_200G_DR4:
+	case ICE_PHY_TYPE_HIGH_200G_KR4_PAM4:
+	case ICE_PHY_TYPE_HIGH_200G_AUI4_AOC_ACC:
+	case ICE_PHY_TYPE_HIGH_200G_AUI4:
+		speed_phy_type_high = ICE_AQ_LINK_SPEED_200GB;
+		break;
 	default:
 		speed_phy_type_high = ICE_AQ_LINK_SPEED_UNKNOWN;
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 78b833b3e1d7..62c8205fceba 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3593,7 +3593,6 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
 	struct ice_pf *pf = vsi->back;
 	int new_rx = 0, new_tx = 0;
 	bool locked = false;
-	u32 curr_combined;
 	int ret = 0;
 
 	/* do not support changing channels in Safe Mode */
@@ -3615,22 +3614,8 @@ static int ice_set_channels(struct net_device *dev, struct ethtool_channels *ch)
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
index 2e9ad27cb9d1..6e8f2aab6080 100644
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
diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 6972d728431c..1885ba618981 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -222,14 +222,19 @@ static int idpf_set_channels(struct net_device *netdev,
 			     struct ethtool_channels *ch)
 {
 	struct idpf_vport_config *vport_config;
-	u16 combined, num_txq, num_rxq;
 	unsigned int num_req_tx_q;
 	unsigned int num_req_rx_q;
 	struct idpf_vport *vport;
+	u16 num_txq, num_rxq;
 	struct device *dev;
 	int err = 0;
 	u16 idx;
 
+	if (ch->rx_count && ch->tx_count) {
+		netdev_err(netdev, "Dedicated RX or TX channels cannot be used simultaneously\n");
+		return -EINVAL;
+	}
+
 	idpf_vport_ctrl_lock(netdev);
 	vport = idpf_netdev_to_vport(netdev);
 
@@ -239,20 +244,6 @@ static int idpf_set_channels(struct net_device *netdev,
 	num_txq = vport_config->user_config.num_req_tx_qs;
 	num_rxq = vport_config->user_config.num_req_rx_qs;
 
-	combined = min(num_txq, num_rxq);
-
-	/* these checks are for cases where user didn't specify a particular
-	 * value on cmd line but we get non-zero value anyway via
-	 * get_channels(); look at ethtool.c in ethtool repository (the user
-	 * space part), particularly, do_schannels() routine
-	 */
-	if (ch->combined_count == combined)
-		ch->combined_count = 0;
-	if (ch->combined_count && ch->rx_count == num_rxq - combined)
-		ch->rx_count = 0;
-	if (ch->combined_count && ch->tx_count == num_txq - combined)
-		ch->tx_count = 0;
-
 	num_req_tx_q = ch->combined_count + ch->tx_count;
 	num_req_rx_q = ch->combined_count + ch->rx_count;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 5d3532c27d57..ae8a48c48070 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1394,6 +1394,7 @@ static int idpf_vport_open(struct idpf_vport *vport, bool alloc_res)
 	}
 
 	idpf_rx_init_buf_tail(vport);
+	idpf_vport_intr_ena(vport);
 
 	err = idpf_send_config_queues_msg(vport);
 	if (err) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index f5bc4a278074..7fc77ed9d123 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3747,9 +3747,9 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport)
  */
 void idpf_vport_intr_deinit(struct idpf_vport *vport)
 {
+	idpf_vport_intr_dis_irq_all(vport);
 	idpf_vport_intr_napi_dis_all(vport);
 	idpf_vport_intr_napi_del_all(vport);
-	idpf_vport_intr_dis_irq_all(vport);
 	idpf_vport_intr_rel_irq(vport);
 }
 
@@ -4180,7 +4180,6 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 
 	idpf_vport_intr_map_vector_to_qs(vport);
 	idpf_vport_intr_napi_add_all(vport);
-	idpf_vport_intr_napi_ena_all(vport);
 
 	err = vport->adapter->dev_ops.reg_ops.intr_reg_init(vport);
 	if (err)
@@ -4194,17 +4193,20 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
 	if (err)
 		goto unroll_vectors_alloc;
 
-	idpf_vport_intr_ena_irq_all(vport);
-
 	return 0;
 
 unroll_vectors_alloc:
-	idpf_vport_intr_napi_dis_all(vport);
 	idpf_vport_intr_napi_del_all(vport);
 
 	return err;
 }
 
+void idpf_vport_intr_ena(struct idpf_vport *vport)
+{
+	idpf_vport_intr_napi_ena_all(vport);
+	idpf_vport_intr_ena_irq_all(vport);
+}
+
 /**
  * idpf_config_rss - Send virtchnl messages to configure RSS
  * @vport: virtual port
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index df76493faa75..85a1466890d4 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -988,6 +988,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport);
 void idpf_vport_intr_update_itr_ena_irq(struct idpf_q_vector *q_vector);
 void idpf_vport_intr_deinit(struct idpf_vport *vport);
 int idpf_vport_intr_init(struct idpf_vport *vport);
+void idpf_vport_intr_ena(struct idpf_vport *vport);
 enum pkt_hash_types idpf_ptype_to_htype(const struct idpf_rx_ptype_decoded *decoded);
 int idpf_config_rss(struct idpf_vport *vport);
 int idpf_init_rss(struct idpf_vport *vport);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index ed440dd0c4f9..84fb6b8de2a1 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3676,9 +3676,7 @@ struct ixgbe_info {
 #define IXGBE_KRM_LINK_S1(P)		((P) ? 0x8200 : 0x4200)
 #define IXGBE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
 #define IXGBE_KRM_AN_CNTL_1(P)		((P) ? 0x822C : 0x422C)
-#define IXGBE_KRM_AN_CNTL_4(P)		((P) ? 0x8238 : 0x4238)
 #define IXGBE_KRM_AN_CNTL_8(P)		((P) ? 0x8248 : 0x4248)
-#define IXGBE_KRM_PCS_KX_AN(P)		((P) ? 0x9918 : 0x5918)
 #define IXGBE_KRM_SGMII_CTRL(P)		((P) ? 0x82A0 : 0x42A0)
 #define IXGBE_KRM_LP_BASE_PAGE_HIGH(P)	((P) ? 0x836C : 0x436C)
 #define IXGBE_KRM_DSP_TXFFE_STATE_4(P)	((P) ? 0x8634 : 0x4634)
@@ -3688,7 +3686,6 @@ struct ixgbe_info {
 #define IXGBE_KRM_PMD_FLX_MASK_ST20(P)	((P) ? 0x9054 : 0x5054)
 #define IXGBE_KRM_TX_COEFF_CTRL_1(P)	((P) ? 0x9520 : 0x5520)
 #define IXGBE_KRM_RX_ANA_CTL(P)		((P) ? 0x9A00 : 0x5A00)
-#define IXGBE_KRM_FLX_TMRS_CTRL_ST31(P)	((P) ? 0x9180 : 0x5180)
 
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA		~(0x3 << 20)
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR		BIT(20)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 2decb0710b6e..a5f644934445 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1722,59 +1722,9 @@ static int ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
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
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
index 1723e9912ae0..6cddb4da85b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/qos.c
@@ -1407,7 +1407,10 @@ static int otx2_qos_leaf_to_inner(struct otx2_nic *pfvf, u16 classid,
 	otx2_qos_read_txschq_cfg(pfvf, node, old_cfg);
 
 	/* delete the txschq nodes allocated for this node */
+	otx2_qos_disable_sq(pfvf, qid);
+	otx2_qos_free_hw_node_schq(pfvf, node);
 	otx2_qos_free_sw_node_schq(pfvf, node);
+	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
 	/* mark this node as htb inner node */
 	WRITE_ONCE(node->qid, OTX2_QOS_QID_INNER);
@@ -1554,6 +1557,7 @@ static int otx2_qos_leaf_del_last(struct otx2_nic *pfvf, u16 classid, bool force
 		dwrr_del_node = true;
 
 	/* destroy the leaf node */
+	otx2_qos_disable_sq(pfvf, qid);
 	otx2_qos_destroy_node(pfvf, node);
 	pfvf->qos.qid_to_sqmap[qid] = OTX2_QOS_INVALID_SQ;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/en_accel.h
index caa34b9c161e..33e32584b07f 100644
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 41a2543a52cd..e51b03d4c717 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -750,8 +750,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 err_fs_ft:
 	if (rx->allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(mdev);
-	mlx5_del_flow_rules(rx->status.rule);
-	mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
+	mlx5_ipsec_rx_status_destroy(ipsec, rx);
 err_add:
 	mlx5_destroy_flow_table(rx->ft.status);
 err_fs_ft_status:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.h
index 82064614846f..359050f0b54d 100644
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
index 64497b6eebd3..47be07af214f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3790,7 +3790,7 @@ mlx5e_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 		mlx5e_fold_sw_stats64(priv, stats);
 	}
 
-	stats->rx_dropped = priv->stats.qcnt.rx_out_of_buffer;
+	stats->rx_missed_errors = priv->stats.qcnt.rx_out_of_buffer;
 
 	stats->rx_length_errors =
 		PPORT_802_3_GET(pstats, a_in_range_length_errors) +
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index e21a3b4128ce..0964b16ca561 100644
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
index 37598d116f3b..58a452d20daf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -720,6 +720,7 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
 	struct mlx5_core_dev *dev;
 	u8 mode;
 #endif
+	bool roce_support;
 	int i;
 
 	for (i = 0; i < ldev->ports; i++)
@@ -746,6 +747,11 @@ bool mlx5_lag_check_prereq(struct mlx5_lag *ldev)
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
 
@@ -913,8 +919,10 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
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
 			int i;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index dd5d186dc614..f6deb5a3f820 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -100,10 +100,6 @@ static bool ft_create_alias_supported(struct mlx5_core_dev *dev)
 
 static bool mlx5_sd_is_supported(struct mlx5_core_dev *dev, u8 host_buses)
 {
-	/* Feature is currently implemented for PFs only */
-	if (!mlx5_core_is_pf(dev))
-		return false;
-
 	/* Honor the SW implementation limit */
 	if (host_buses > MLX5_SD_MAX_GROUP_SZ)
 		return false;
@@ -162,6 +158,14 @@ static int sd_init(struct mlx5_core_dev *dev)
 	bool sdm;
 	int err;
 
+	/* Feature is currently implemented for PFs only */
+	if (!mlx5_core_is_pf(dev))
+		return 0;
+
+	/* Block on embedded CPU PFs */
+	if (mlx5_core_is_ecpf(dev))
+		return 0;
+
 	if (!MLX5_CAP_MCAM_REG(dev, mpir))
 		return 0;
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
index af50ff9e5f26..ce49c9514f91 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_span.c
@@ -539,7 +539,7 @@ mlxsw_sp_span_gretap6_route(const struct net_device *to_dev,
 	if (!dst || dst->error)
 		goto out;
 
-	rt6 = container_of(dst, struct rt6_info, dst);
+	rt6 = dst_rt6_info(dst);
 
 	dev = dst->dev;
 	*saddrp = fl6.saddr;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
index 61d88207eed4..6695ed661ef8 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.c
@@ -474,14 +474,14 @@ static int lan966x_port_hwtstamp_set(struct net_device *dev,
 	    cfg->source != HWTSTAMP_SOURCE_PHYLIB)
 		return -EOPNOTSUPP;
 
+	if (cfg->source == HWTSTAMP_SOURCE_NETDEV && !port->lan966x->ptp)
+		return -EOPNOTSUPP;
+
 	err = lan966x_ptp_setup_traps(port, cfg);
 	if (err)
 		return err;
 
 	if (cfg->source == HWTSTAMP_SOURCE_NETDEV) {
-		if (!port->lan966x->ptp)
-			return -EOPNOTSUPP;
-
 		err = lan966x_ptp_hwtstamp_set(port, cfg, extack);
 		if (err) {
 			lan966x_ptp_del_traps(port);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_classifier.c b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
index 6df53ab17fbc..902a2717785c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_classifier.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_classifier.c
@@ -360,7 +360,7 @@ void icssg_ft1_set_mac_addr(struct regmap *miig_rt, int slice, u8 *mac_addr)
 {
 	const u8 mask_addr[] = { 0, 0, 0, 0, 0, 0, };
 
-	rx_class_ft1_set_start_len(miig_rt, slice, 0, 6);
+	rx_class_ft1_set_start_len(miig_rt, slice, ETH_ALEN, ETH_ALEN);
 	rx_class_ft1_set_da(miig_rt, slice, 0, mac_addr);
 	rx_class_ft1_set_da_mask(miig_rt, slice, 0, mask_addr);
 	rx_class_ft1_cfg_set_type(miig_rt, slice, 0, FT1_CFG_TYPE_EQ);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 2d5b021b4ea6..fef4eff7753a 100644
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
diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
index a4d2e76a8d58..16789cd446e9 100644
--- a/drivers/net/netkit.c
+++ b/drivers/net/netkit.c
@@ -55,6 +55,7 @@ static void netkit_prep_forward(struct sk_buff *skb, bool xnet)
 	skb_scrub_packet(skb, xnet);
 	skb->priority = 0;
 	nf_skip_egress(skb, true);
+	skb_reset_mac_header(skb);
 }
 
 static struct netkit *netkit_priv(const struct net_device *dev)
@@ -78,6 +79,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 		     skb_orphan_frags(skb, GFP_ATOMIC)))
 		goto drop;
 	netkit_prep_forward(skb, !net_eq(dev_net(dev), dev_net(peer)));
+	eth_skb_pkt_type(skb, peer);
 	skb->dev = peer;
 	entry = rcu_dereference(nk->active);
 	if (entry)
@@ -85,7 +87,7 @@ static netdev_tx_t netkit_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (ret) {
 	case NETKIT_NEXT:
 	case NETKIT_PASS:
-		skb->protocol = eth_type_trans(skb, skb->dev);
+		eth_skb_pull_mac(skb);
 		skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
 		if (likely(__netif_rx(skb) == NET_RX_SUCCESS)) {
 			dev_sw_netstats_tx_add(dev, 1, len);
@@ -155,6 +157,16 @@ static void netkit_set_multicast(struct net_device *dev)
 	/* Nothing to do, we receive whatever gets pushed to us! */
 }
 
+static int netkit_set_macaddr(struct net_device *dev, void *sa)
+{
+	struct netkit *nk = netkit_priv(dev);
+
+	if (nk->mode != NETKIT_L2)
+		return -EOPNOTSUPP;
+
+	return eth_mac_addr(dev, sa);
+}
+
 static void netkit_set_headroom(struct net_device *dev, int headroom)
 {
 	struct netkit *nk = netkit_priv(dev), *nk2;
@@ -198,6 +210,7 @@ static const struct net_device_ops netkit_netdev_ops = {
 	.ndo_start_xmit		= netkit_xmit,
 	.ndo_set_rx_mode	= netkit_set_multicast,
 	.ndo_set_rx_headroom	= netkit_set_headroom,
+	.ndo_set_mac_address	= netkit_set_macaddr,
 	.ndo_get_iflink		= netkit_get_iflink,
 	.ndo_get_peer_dev	= netkit_peer_dev,
 	.ndo_get_stats64	= netkit_get_stats,
@@ -300,9 +313,11 @@ static int netkit_validate(struct nlattr *tb[], struct nlattr *data[],
 
 	if (!attr)
 		return 0;
-	NL_SET_ERR_MSG_ATTR(extack, attr,
-			    "Setting Ethernet address is not supported");
-	return -EOPNOTSUPP;
+	if (nla_len(attr) != ETH_ALEN)
+		return -EINVAL;
+	if (!is_valid_ether_addr(nla_data(attr)))
+		return -EADDRNOTAVAIL;
+	return 0;
 }
 
 static struct rtnl_link_ops netkit_link_ops;
@@ -365,6 +380,9 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 		strscpy(ifname, "nk%d", IFNAMSIZ);
 		ifname_assign_type = NET_NAME_ENUM;
 	}
+	if (mode != NETKIT_L2 &&
+	    (tb[IFLA_ADDRESS] || tbp[IFLA_ADDRESS]))
+		return -EOPNOTSUPP;
 
 	net = rtnl_link_get_net(src_net, tbp);
 	if (IS_ERR(net))
@@ -379,7 +397,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 
 	netif_inherit_tso_max(peer, dev);
 
-	if (mode == NETKIT_L2)
+	if (mode == NETKIT_L2 && !(ifmp && tbp[IFLA_ADDRESS]))
 		eth_hw_addr_random(peer);
 	if (ifmp && dev->ifindex)
 		peer->ifindex = ifmp->ifi_index;
@@ -402,7 +420,7 @@ static int netkit_new_link(struct net *src_net, struct net_device *dev,
 	if (err < 0)
 		goto err_configure_peer;
 
-	if (mode == NETKIT_L2)
+	if (mode == NETKIT_L2 && !tb[IFLA_ADDRESS])
 		eth_hw_addr_random(dev);
 	if (tb[IFLA_IFNAME])
 		nla_strscpy(dev->name, tb[IFLA_IFNAME], IFNAMSIZ);
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 87780465cd0d..13370439a7ca 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -3516,7 +3516,7 @@ static int lan8841_config_intr(struct phy_device *phydev)
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		err = phy_read(phydev, LAN8814_INTS);
-		if (err)
+		if (err < 0)
 			return err;
 
 		/* Enable / disable interrupts. It is OK to enable PTP interrupt
@@ -3532,6 +3532,14 @@ static int lan8841_config_intr(struct phy_device *phydev)
 			return err;
 
 		err = phy_read(phydev, LAN8814_INTS);
+		if (err < 0)
+			return err;
+
+		/* Getting a positive value doesn't mean that is an error, it
+		 * just indicates what was the status. Therefore make sure to
+		 * clear the value and say that there is no error.
+		 */
+		err = 0;
 	}
 
 	return err;
@@ -4814,6 +4822,7 @@ static struct phy_driver ksphy_driver[] = {
 	/* PHY_BASIC_FEATURES */
 	.probe		= kszphy_probe,
 	.config_init	= ksz8061_config_init,
+	.soft_reset	= genphy_soft_reset,
 	.config_intr	= kszphy_config_intr,
 	.handle_interrupt = kszphy_handle_interrupt,
 	.suspend	= kszphy_suspend,
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index cbea24666479..8e82184be5e7 100644
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
 
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bb95ce43cd97..c3af9ad5e154 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -653,7 +653,7 @@ static int vrf_finish_output6(struct net *net, struct sock *sk,
 	skb->dev = dev;
 
 	rcu_read_lock();
-	nexthop = rt6_nexthop((struct rt6_info *)dst, &ipv6_hdr(skb)->daddr);
+	nexthop = rt6_nexthop(dst_rt6_info(dst), &ipv6_hdr(skb)->daddr);
 	neigh = __ipv6_neigh_lookup_noref(dst->dev, nexthop);
 	if (unlikely(!neigh))
 		neigh = __neigh_create(&nd_tbl, nexthop, dst->dev, false);
@@ -860,7 +860,7 @@ static int vrf_rt6_create(struct net_device *dev)
 static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct net_device *dev = dst->dev;
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3a9148fb1422..6b64f28a9174 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2528,7 +2528,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		if (!info) {
-			u32 rt6i_flags = ((struct rt6_info *)ndst)->rt6i_flags;
+			u32 rt6i_flags = dst_rt6_info(ndst)->rt6i_flags;
 
 			err = encap_bypass_if_local(skb, dev, vxlan, AF_INET6,
 						    dst_port, ifindex, vni,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 095f59e7aa93..d513fd27589d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -414,7 +414,15 @@ static inline void nvme_end_req_zoned(struct request *req)
 	}
 }
 
-static inline void nvme_end_req(struct request *req)
+static inline void __nvme_end_req(struct request *req)
+{
+	nvme_end_req_zoned(req);
+	nvme_trace_bio_complete(req);
+	if (req->cmd_flags & REQ_NVME_MPATH)
+		nvme_mpath_end_request(req);
+}
+
+void nvme_end_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
@@ -424,10 +432,7 @@ static inline void nvme_end_req(struct request *req)
 		else
 			nvme_log_error(req);
 	}
-	nvme_end_req_zoned(req);
-	nvme_trace_bio_complete(req);
-	if (req->cmd_flags & REQ_NVME_MPATH)
-		nvme_mpath_end_request(req);
+	__nvme_end_req(req);
 	blk_mq_end_request(req, status);
 }
 
@@ -476,7 +481,7 @@ void nvme_complete_batch_req(struct request *req)
 {
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
-	nvme_end_req_zoned(req);
+	__nvme_end_req(req);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d16e976ae1a4..a4e46eb20be6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -118,7 +118,8 @@ void nvme_failover_req(struct request *req)
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
-	blk_mq_end_request(req, 0);
+	nvme_req(req)->status = 0;
+	nvme_end_req(req);
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05532c281177..d7bcc6d51e84 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -767,6 +767,7 @@ static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
 	}
 }
 
+void nvme_end_req(struct request *req);
 void nvme_complete_rq(struct request *req);
 void nvme_complete_batch_req(struct request *req);
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 7fda69395c1e..dfdff6aba695 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -676,10 +676,18 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	if (kstrtobool(page, &enable))
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
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 746a11dcb67f..c43a1479de2c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -604,11 +604,16 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct dw_pcie_ep_func *ep_func;
+	struct device *dev = pci->dev;
+	struct pci_epc *epc = ep->epc;
 	unsigned int offset, ptm_cap_base;
 	unsigned int nbars;
 	u8 hdr_type;
+	u8 func_no;
+	int i, ret;
+	void *addr;
 	u32 reg;
-	int i;
 
 	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
 		   PCI_HEADER_TYPE_MASK;
@@ -619,6 +624,58 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 		return -EIO;
 	}
 
+	dw_pcie_version_detect(pci);
+
+	dw_pcie_iatu_detect(pci);
+
+	ret = dw_pcie_edma_detect(pci);
+	if (ret)
+		return ret;
+
+	if (!ep->ib_window_map) {
+		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
+						       GFP_KERNEL);
+		if (!ep->ib_window_map)
+			goto err_remove_edma;
+	}
+
+	if (!ep->ob_window_map) {
+		ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
+						       GFP_KERNEL);
+		if (!ep->ob_window_map)
+			goto err_remove_edma;
+	}
+
+	if (!ep->outbound_addr) {
+		addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
+				    GFP_KERNEL);
+		if (!addr)
+			goto err_remove_edma;
+		ep->outbound_addr = addr;
+	}
+
+	for (func_no = 0; func_no < epc->max_functions; func_no++) {
+
+		ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
+		if (ep_func)
+			continue;
+
+		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
+		if (!ep_func)
+			goto err_remove_edma;
+
+		ep_func->func_no = func_no;
+		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
+							      PCI_CAP_ID_MSI);
+		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
+							       PCI_CAP_ID_MSIX);
+
+		list_add_tail(&ep_func->list, &ep->func_list);
+	}
+
+	if (ep->ops->init)
+		ep->ops->init(ep);
+
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
@@ -658,14 +715,17 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 	dw_pcie_dbi_ro_wr_dis(pci);
 
 	return 0;
+
+err_remove_edma:
+	dw_pcie_edma_remove(pci);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	int ret;
-	void *addr;
-	u8 func_no;
 	struct resource *res;
 	struct pci_epc *epc;
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -673,7 +733,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	const struct pci_epc_features *epc_features;
-	struct dw_pcie_ep_func *ep_func;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -691,26 +750,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ep->ops->pre_init)
 		ep->ops->pre_init(ep);
 
-	dw_pcie_version_detect(pci);
-
-	dw_pcie_iatu_detect(pci);
-
-	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
-					       GFP_KERNEL);
-	if (!ep->ib_window_map)
-		return -ENOMEM;
-
-	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
-					       GFP_KERNEL);
-	if (!ep->ob_window_map)
-		return -ENOMEM;
-
-	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
-			    GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
-	ep->outbound_addr = addr;
-
 	epc = devm_pci_epc_create(dev, &epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "Failed to create epc device\n");
@@ -724,23 +763,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	if (ret < 0)
 		epc->max_functions = 1;
 
-	for (func_no = 0; func_no < epc->max_functions; func_no++) {
-		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
-		if (!ep_func)
-			return -ENOMEM;
-
-		ep_func->func_no = func_no;
-		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
-							      PCI_CAP_ID_MSI);
-		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
-							       PCI_CAP_ID_MSIX);
-
-		list_add_tail(&ep_func->list, &ep->func_list);
-	}
-
-	if (ep->ops->init)
-		ep->ops->init(ep);
-
 	ret = pci_epc_mem_init(epc, ep->phys_base, ep->addr_size,
 			       ep->page_size);
 	if (ret < 0) {
@@ -756,25 +778,25 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		goto err_exit_epc_mem;
 	}
 
-	ret = dw_pcie_edma_detect(pci);
-	if (ret)
-		goto err_free_epc_mem;
-
 	if (ep->ops->get_features) {
 		epc_features = ep->ops->get_features(ep);
 		if (epc_features->core_init_notifier)
 			return 0;
 	}
 
+	/*
+	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
+	 * step as platforms that implement 'core_init_notifier' feature may
+	 * not have the hardware ready (i.e. core initialized) for access
+	 * (Ex: tegra194). Any hardware access on such platforms result
+	 * in system hang.
+	 */
 	ret = dw_pcie_ep_init_complete(ep);
 	if (ret)
-		goto err_remove_edma;
+		goto err_free_epc_mem;
 
 	return 0;
 
-err_remove_edma:
-	dw_pcie_edma_remove(pci);
-
 err_free_epc_mem:
 	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
 			      epc->mem->window.page_size);
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 1f7b662cb8e1..e440c09d1dc1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2273,11 +2273,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
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
diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
index c2c7334152bc..03539e505372 100644
--- a/drivers/pci/of_property.c
+++ b/drivers/pci/of_property.c
@@ -238,6 +238,8 @@ static int of_pci_prop_intr_map(struct pci_dev *pdev, struct of_changeset *ocs,
 		return 0;
 
 	int_map = kcalloc(map_sz, sizeof(u32), GFP_KERNEL);
+	if (!int_map)
+		return -ENOMEM;
 	mapp = int_map;
 
 	list_for_each_entry(child, &pdev->subordinate->devices, bus_list) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..70b8c87055cb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4629,7 +4629,7 @@ int pcie_retrain_link(struct pci_dev *pdev, bool use_lt)
 	 * avoid LTSSM race as recommended in Implementation Note at the
 	 * end of PCIe r6.0.1 sec 7.5.3.7.
 	 */
-	rc = pcie_wait_for_link_status(pdev, use_lt, !use_lt);
+	rc = pcie_wait_for_link_status(pdev, true, false);
 	if (rc)
 		return rc;
 
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 5f4914d313a1..e86298dbbcff 100644
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
index 8a81be2dd5ec..88c17c1d6d49 100644
--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -542,12 +542,16 @@ static int dmc620_pmu_event_init(struct perf_event *event)
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
@@ -556,7 +560,6 @@ static int dmc620_pmu_event_init(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	hwc->idx = -1;
 	return 0;
 }
 
diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index c21cdb8dbfe7..acc2b5b9ea25 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -1382,6 +1382,13 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
 	{ 0x3f, 0xff, 0xff, 0xff }
 };
 
+static const u8 qmp_dp_v6_voltage_swing_hbr_rbr[4][4] = {
+	{ 0x27, 0x2f, 0x36, 0x3f },
+	{ 0x31, 0x3e, 0x3f, 0xff },
+	{ 0x36, 0x3f, 0xff, 0xff },
+	{ 0x3f, 0xff, 0xff, 0xff }
+};
+
 static const u8 qmp_dp_v6_pre_emphasis_hbr_rbr[4][4] = {
 	{ 0x20, 0x2d, 0x34, 0x3a },
 	{ 0x20, 0x2e, 0x35, 0xff },
@@ -2001,6 +2008,51 @@ static const struct qmp_phy_cfg sm8550_usb3dpphy_cfg = {
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 };
 
+static const struct qmp_phy_cfg sm8650_usb3dpphy_cfg = {
+	.offsets		= &qmp_combo_offsets_v3,
+
+	.serdes_tbl		= sm8550_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8550_usb3_serdes_tbl),
+	.tx_tbl			= sm8550_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8550_usb3_tx_tbl),
+	.rx_tbl			= sm8550_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8550_usb3_rx_tbl),
+	.pcs_tbl		= sm8550_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8550_usb3_pcs_tbl),
+	.pcs_usb_tbl		= sm8550_usb3_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8550_usb3_pcs_usb_tbl),
+
+	.dp_serdes_tbl		= qmp_v6_dp_serdes_tbl,
+	.dp_serdes_tbl_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl),
+	.dp_tx_tbl		= qmp_v6_dp_tx_tbl,
+	.dp_tx_tbl_num		= ARRAY_SIZE(qmp_v6_dp_tx_tbl),
+
+	.serdes_tbl_rbr		= qmp_v6_dp_serdes_tbl_rbr,
+	.serdes_tbl_rbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_rbr),
+	.serdes_tbl_hbr		= qmp_v6_dp_serdes_tbl_hbr,
+	.serdes_tbl_hbr_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr),
+	.serdes_tbl_hbr2	= qmp_v6_dp_serdes_tbl_hbr2,
+	.serdes_tbl_hbr2_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr2),
+	.serdes_tbl_hbr3	= qmp_v6_dp_serdes_tbl_hbr3,
+	.serdes_tbl_hbr3_num	= ARRAY_SIZE(qmp_v6_dp_serdes_tbl_hbr3),
+
+	.swing_hbr_rbr		= &qmp_dp_v6_voltage_swing_hbr_rbr,
+	.pre_emphasis_hbr_rbr	= &qmp_dp_v6_pre_emphasis_hbr_rbr,
+	.swing_hbr3_hbr2	= &qmp_dp_v5_voltage_swing_hbr3_hbr2,
+	.pre_emphasis_hbr3_hbr2 = &qmp_dp_v5_pre_emphasis_hbr3_hbr2,
+
+	.dp_aux_init		= qmp_v4_dp_aux_init,
+	.configure_dp_tx	= qmp_v4_configure_dp_tx,
+	.configure_dp_phy	= qmp_v4_configure_dp_phy,
+	.calibrate_dp_phy	= qmp_v4_calibrate_dp_phy,
+
+	.regs			= qmp_v6_usb3phy_regs_layout,
+	.reset_list		= msm8996_usb3phy_reset_l,
+	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+};
+
 static int qmp_combo_dp_serdes_init(struct qmp_combo *qmp)
 {
 	const struct qmp_phy_cfg *cfg = qmp->cfg;
@@ -3631,7 +3683,7 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
 	},
 	{
 		.compatible = "qcom,sm8650-qmp-usb3-dp-phy",
-		.data = &sm8550_usb3dpphy_cfg,
+		.data = &sm8650_usb3dpphy_cfg,
 	},
 	{
 		.compatible = "qcom,x1e80100-qmp-usb3-dp-phy",
diff --git a/drivers/pinctrl/qcom/pinctrl-sm7150.c b/drivers/pinctrl/qcom/pinctrl-sm7150.c
index c25357ca1963..b9f067de8ef0 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm7150.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm7150.c
@@ -65,7 +65,7 @@ enum {
 		.intr_detection_width = 2,		\
 	}
 
-#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
+#define SDC_QDSD_PINGROUP(pg_name, _tile, ctl, pull, drv) \
 	{						\
 		.grp = PINCTRL_PINGROUP(#pg_name, 	\
 			pg_name##_pins, 		\
@@ -75,7 +75,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
-		.tile = SOUTH,				\
+		.tile = _tile,				\
 		.mux_bit = -1,				\
 		.pull_bit = pull,			\
 		.drv_bit = drv,				\
@@ -101,7 +101,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
-		.tile = SOUTH,				\
+		.tile = WEST,				\
 		.mux_bit = -1,				\
 		.pull_bit = 3,				\
 		.drv_bit = 0,				\
@@ -1199,13 +1199,13 @@ static const struct msm_pingroup sm7150_groups[] = {
 	[117] = PINGROUP(117, NORTH, _, _, _, _, _, _, _, _, _),
 	[118] = PINGROUP(118, NORTH, _, _, _, _, _, _, _, _, _),
 	[119] = UFS_RESET(ufs_reset, 0x9f000),
-	[120] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x9a000, 15, 0),
-	[121] = SDC_QDSD_PINGROUP(sdc1_clk, 0x9a000, 13, 6),
-	[122] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x9a000, 11, 3),
-	[123] = SDC_QDSD_PINGROUP(sdc1_data, 0x9a000, 9, 0),
-	[124] = SDC_QDSD_PINGROUP(sdc2_clk, 0x98000, 14, 6),
-	[125] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x98000, 11, 3),
-	[126] = SDC_QDSD_PINGROUP(sdc2_data, 0x98000, 9, 0),
+	[120] = SDC_QDSD_PINGROUP(sdc1_rclk, WEST, 0x9a000, 15, 0),
+	[121] = SDC_QDSD_PINGROUP(sdc1_clk, WEST, 0x9a000, 13, 6),
+	[122] = SDC_QDSD_PINGROUP(sdc1_cmd, WEST, 0x9a000, 11, 3),
+	[123] = SDC_QDSD_PINGROUP(sdc1_data, WEST, 0x9a000, 9, 0),
+	[124] = SDC_QDSD_PINGROUP(sdc2_clk, SOUTH, 0x98000, 14, 6),
+	[125] = SDC_QDSD_PINGROUP(sdc2_cmd, SOUTH, 0x98000, 11, 3),
+	[126] = SDC_QDSD_PINGROUP(sdc2_data, SOUTH, 0x98000, 9, 0),
 };
 
 static const struct msm_gpio_wakeirq_map sm7150_pdc_map[] = {
diff --git a/drivers/pinctrl/renesas/pfc-r8a779h0.c b/drivers/pinctrl/renesas/pfc-r8a779h0.c
index afa8f06c85cf..0cbfe7637fc9 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779h0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779h0.c
@@ -75,10 +75,10 @@
 #define GPSR0_9		F_(MSIOF5_SYNC,		IP1SR0_7_4)
 #define GPSR0_8		F_(MSIOF5_SS1,		IP1SR0_3_0)
 #define GPSR0_7		F_(MSIOF5_SS2,		IP0SR0_31_28)
-#define GPSR0_6		F_(IRQ0,		IP0SR0_27_24)
-#define GPSR0_5		F_(IRQ1,		IP0SR0_23_20)
-#define GPSR0_4		F_(IRQ2,		IP0SR0_19_16)
-#define GPSR0_3		F_(IRQ3,		IP0SR0_15_12)
+#define GPSR0_6		F_(IRQ0_A,		IP0SR0_27_24)
+#define GPSR0_5		F_(IRQ1_A,		IP0SR0_23_20)
+#define GPSR0_4		F_(IRQ2_A,		IP0SR0_19_16)
+#define GPSR0_3		F_(IRQ3_A,		IP0SR0_15_12)
 #define GPSR0_2		F_(GP0_02,		IP0SR0_11_8)
 #define GPSR0_1		F_(GP0_01,		IP0SR0_7_4)
 #define GPSR0_0		F_(GP0_00,		IP0SR0_3_0)
@@ -265,10 +265,10 @@
 #define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_7_4	F_(0, 0)		FM(MSIOF3_SS1)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_11_8	F_(0, 0)		FM(MSIOF3_SS2)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_15_12	FM(IRQ3)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_19_16	FM(IRQ2)		FM(MSIOF3_TXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_23_20	FM(IRQ1)		FM(MSIOF3_RXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_27_24	FM(IRQ0)		FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_15_12	FM(IRQ3_A)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_19_16	FM(IRQ2_A)		FM(MSIOF3_TXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_23_20	FM(IRQ1_A)		FM(MSIOF3_RXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_27_24	FM(IRQ0_A)		FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_31_28	FM(MSIOF5_SS2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -672,16 +672,16 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP0SR0_11_8,	MSIOF3_SS2),
 
-	PINMUX_IPSR_GPSR(IP0SR0_15_12,	IRQ3),
+	PINMUX_IPSR_GPSR(IP0SR0_15_12,	IRQ3_A),
 	PINMUX_IPSR_GPSR(IP0SR0_15_12,	MSIOF3_SCK),
 
-	PINMUX_IPSR_GPSR(IP0SR0_19_16,	IRQ2),
+	PINMUX_IPSR_GPSR(IP0SR0_19_16,	IRQ2_A),
 	PINMUX_IPSR_GPSR(IP0SR0_19_16,	MSIOF3_TXD),
 
-	PINMUX_IPSR_GPSR(IP0SR0_23_20,	IRQ1),
+	PINMUX_IPSR_GPSR(IP0SR0_23_20,	IRQ1_A),
 	PINMUX_IPSR_GPSR(IP0SR0_23_20,	MSIOF3_RXD),
 
-	PINMUX_IPSR_GPSR(IP0SR0_27_24,	IRQ0),
+	PINMUX_IPSR_GPSR(IP0SR0_27_24,	IRQ0_A),
 	PINMUX_IPSR_GPSR(IP0SR0_27_24,	MSIOF3_SYNC),
 
 	PINMUX_IPSR_GPSR(IP0SR0_31_28,	MSIOF5_SS2),
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 20425afc6b33..248ab71b9f9d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -892,6 +892,8 @@ static int rzg2l_set_power_source(struct rzg2l_pinctrl *pctrl, u32 pin, u32 caps
 		val = PVDD_1800;
 		break;
 	case 2500:
+		if (!(caps & (PIN_CFG_IO_VMC_ETH0 | PIN_CFG_IO_VMC_ETH1)))
+			return -EINVAL;
 		val = PVDD_2500;
 		break;
 	case 3300:
diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 910df7c654f4..003e765dedea 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -763,8 +763,11 @@ static int intel_vsec_tpmi_init(struct auxiliary_device *auxdev)
 		 * when actual device nodes created outside this
 		 * loop via tpmi_create_devices().
 		 */
-		if (pfs->pfs_header.tpmi_id == TPMI_INFO_ID)
-			tpmi_process_info(tpmi_info, pfs);
+		if (pfs->pfs_header.tpmi_id == TPMI_INFO_ID) {
+			ret = tpmi_process_info(tpmi_info, pfs);
+			if (ret)
+				return ret;
+		}
 
 		if (pfs->pfs_header.tpmi_id == TPMI_CONTROL_ID)
 			tpmi_set_control_base(auxdev, tpmi_info, pfs);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index ef730200a04b..bb8e72deb354 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -240,6 +240,7 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
 	struct tpmi_uncore_struct *tpmi_uncore;
+	bool uncore_sysfs_added = false;
 	int ret, i, pkg = 0;
 	int num_resources;
 
@@ -384,9 +385,15 @@ static int uncore_probe(struct auxiliary_device *auxdev, const struct auxiliary_
 			}
 			/* Point to next cluster offset */
 			cluster_offset >>= UNCORE_MAX_CLUSTER_PER_DOMAIN;
+			uncore_sysfs_added = true;
 		}
 	}
 
+	if (!uncore_sysfs_added) {
+		ret = -ENODEV;
+		goto remove_clusters;
+	}
+
 	auxiliary_set_drvdata(auxdev, tpmi_uncore);
 
 	tpmi_uncore->root_cluster.root_domain = true;
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 82429e59999d..87a4a381bd98 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -3044,10 +3044,9 @@ static void tpacpi_send_radiosw_update(void)
 
 static void hotkey_exit(void)
 {
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	mutex_lock(&hotkey_mutex);
+#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_poll_stop_sync();
-	mutex_unlock(&hotkey_mutex);
 #endif
 	dbg_printk(TPACPI_DBG_EXIT | TPACPI_DBG_HKEY,
 		   "restoring original HKEY status and mask\n");
@@ -3057,6 +3056,8 @@ static void hotkey_exit(void)
 	      hotkey_mask_set(hotkey_orig_mask)) |
 	     hotkey_status_set(false)) != 0)
 		pr_err("failed to restore hot key mask to BIOS defaults\n");
+
+	mutex_unlock(&hotkey_mutex);
 }
 
 static void __init hotkey_unmap(const unsigned int scancode)
diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index 08d4ee369287..dd871ffe979c 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -206,14 +206,11 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -288,13 +285,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -329,13 +320,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -370,13 +355,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -493,13 +472,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -533,13 +506,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -573,13 +540,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -614,13 +575,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -655,13 +610,7 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
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
@@ -720,9 +669,6 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 			.suspend_reg = BD71828_REG_LDO7_VOLT,
 			.lpsr_reg = BD71828_REG_LDO7_VOLT,
 			.run_mask = BD71828_MASK_LDO_VOLT,
-			.idle_mask = BD71828_MASK_LDO_VOLT,
-			.suspend_mask = BD71828_MASK_LDO_VOLT,
-			.lpsr_mask = BD71828_MASK_LDO_VOLT,
 			.idle_on_mask = BD71828_MASK_IDLE_EN,
 			.suspend_on_mask = BD71828_MASK_SUSP_EN,
 			.lpsr_on_mask = BD71828_MASK_LPSR_EN,
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index d49268336553..6e1ace660b8c 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -161,6 +161,32 @@ int regulator_get_voltage_sel_pickable_regmap(struct regulator_dev *rdev)
 }
 EXPORT_SYMBOL_GPL(regulator_get_voltage_sel_pickable_regmap);
 
+static int write_separate_vsel_and_range(struct regulator_dev *rdev,
+					 unsigned int sel, unsigned int range)
+{
+	bool range_updated;
+	int ret;
+
+	ret = regmap_update_bits_base(rdev->regmap, rdev->desc->vsel_range_reg,
+				      rdev->desc->vsel_range_mask,
+				      range, &range_updated, false, false);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some PMICs treat the vsel_reg same as apply-bit. Force it to be
+	 * written if the range changed, even if the old selector was same as
+	 * the new one
+	 */
+	if (rdev->desc->range_applied_by_vsel && range_updated)
+		return regmap_write_bits(rdev->regmap,
+					rdev->desc->vsel_reg,
+					rdev->desc->vsel_mask, sel);
+
+	return regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
+				  rdev->desc->vsel_mask, sel);
+}
+
 /**
  * regulator_set_voltage_sel_pickable_regmap - pickable range set_voltage_sel
  *
@@ -199,21 +225,12 @@ int regulator_set_voltage_sel_pickable_regmap(struct regulator_dev *rdev,
 	range = rdev->desc->linear_range_selectors_bitfield[i];
 	range <<= ffs(rdev->desc->vsel_range_mask) - 1;
 
-	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg) {
-		ret = regmap_update_bits(rdev->regmap,
-					 rdev->desc->vsel_reg,
+	if (rdev->desc->vsel_reg == rdev->desc->vsel_range_reg)
+		ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
 					 rdev->desc->vsel_range_mask |
 					 rdev->desc->vsel_mask, sel | range);
-	} else {
-		ret = regmap_update_bits(rdev->regmap,
-					 rdev->desc->vsel_range_reg,
-					 rdev->desc->vsel_range_mask, range);
-		if (ret)
-			return ret;
-
-		ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg,
-				  rdev->desc->vsel_mask, sel);
-	}
+	else
+		ret = write_separate_vsel_and_range(rdev, sel, range);
 
 	if (ret)
 		return ret;
diff --git a/drivers/regulator/tps6287x-regulator.c b/drivers/regulator/tps6287x-regulator.c
index 9b7c3d77789e..3c9d79e003e4 100644
--- a/drivers/regulator/tps6287x-regulator.c
+++ b/drivers/regulator/tps6287x-regulator.c
@@ -115,6 +115,7 @@ static struct regulator_desc tps6287x_reg = {
 	.vsel_mask = 0xFF,
 	.vsel_range_reg = TPS6287X_CTRL2,
 	.vsel_range_mask = TPS6287X_CTRL2_VRANGE,
+	.range_applied_by_vsel = true,
 	.ramp_reg = TPS6287X_CTRL1,
 	.ramp_mask = TPS6287X_CTRL1_VRAMP,
 	.ramp_delay_table = tps6287x_ramp_table,
diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index b7f0c8779757..5fad61785e72 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -287,30 +287,30 @@ static struct tps6594_regulator_irq_type *tps6594_ldos_irq_types[] = {
 static const struct regulator_desc multi_regs[] = {
 	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK34", "buck34", TPS6594_BUCK_3,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(3),
+			  TPS6594_REG_BUCKX_VOUT_1(2),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(3),
+			  TPS6594_REG_BUCKX_CTRL(2),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 0, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK123", "buck123", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 	TPS6594_REGULATOR("BUCK1234", "buck1234", TPS6594_BUCK_1,
 			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_REG_BUCKX_VOUT_1(0),
 			  TPS6594_MASK_BUCKS_VSET,
-			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_REG_BUCKX_CTRL(0),
 			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
 			  4, 4000, 0, NULL, 0, 0),
 };
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index cce0bafd4c92..f13837907bd5 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -767,9 +767,9 @@ static void ap_check_bindings_complete(void)
 		if (bound == apqns) {
 			if (!completion_done(&ap_apqn_bindings_complete)) {
 				complete_all(&ap_apqn_bindings_complete);
+				ap_send_bindings_complete_uevent();
 				pr_debug("%s all apqn bindings complete\n", __func__);
 			}
-			ap_send_bindings_complete_uevent();
 		}
 	}
 }
@@ -929,6 +929,12 @@ static int ap_device_probe(struct device *dev)
 			goto out;
 	}
 
+	/*
+	 * Rearm the bindings complete completion to trigger
+	 * bindings complete when all devices are bound again
+	 */
+	reinit_completion(&ap_apqn_bindings_complete);
+
 	/* Add queue/card to list of active queues/cards */
 	spin_lock_bh(&ap_queues_lock);
 	if (is_queue_dev(dev))
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 613eab729704..41fe8a043d61 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -956,7 +956,7 @@ static inline struct dst_entry *qeth_dst_check_rcu(struct sk_buff *skb,
 	struct dst_entry *dst = skb_dst(skb);
 	struct rt6_info *rt;
 
-	rt = (struct rt6_info *) dst;
+	rt = dst_rt6_info(dst);
 	if (dst) {
 		if (proto == htons(ETH_P_IPV6))
 			dst = dst_check(dst, rt6_get_cookie(rt));
@@ -970,15 +970,14 @@ static inline struct dst_entry *qeth_dst_check_rcu(struct sk_buff *skb,
 static inline __be32 qeth_next_hop_v4_rcu(struct sk_buff *skb,
 					  struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *) dst;
-
-	return (rt) ? rt_nexthop(rt, ip_hdr(skb)->daddr) : ip_hdr(skb)->daddr;
+	return (dst) ? rt_nexthop(dst_rtable(dst), ip_hdr(skb)->daddr) :
+		       ip_hdr(skb)->daddr;
 }
 
 static inline struct in6_addr *qeth_next_hop_v6_rcu(struct sk_buff *skb,
 						    struct dst_entry *dst)
 {
-	struct rt6_info *rt = (struct rt6_info *) dst;
+	struct rt6_info *rt = dst_rt6_info(dst);
 
 	if (rt && !ipv6_addr_any(&rt->rt6i_gateway))
 		return &rt->rt6i_gateway;
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 65cdc8b77e35..caac482fff2f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3707,8 +3707,10 @@ static int sd_revalidate_disk(struct gendisk *disk)
 	 */
 	if (sdkp->first_scan ||
 	    q->limits.max_sectors > q->limits.max_dev_sectors ||
-	    q->limits.max_sectors > q->limits.max_hw_sectors)
+	    q->limits.max_sectors > q->limits.max_hw_sectors) {
 		q->limits.max_sectors = rw_max;
+		q->limits.max_user_sectors = rw_max;
+	}
 
 	sdkp->first_scan = 0;
 
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index 0efc1c3bee5f..3e7cf04aaf2a 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1880,7 +1880,7 @@ struct sdw_cdns_pdi *sdw_cdns_alloc_pdi(struct sdw_cdns *cdns,
 
 	/* check if we found a PDI, else find in bi-directional */
 	if (!pdi)
-		pdi = cdns_find_pdi(cdns, 2, stream->num_bd, stream->bd,
+		pdi = cdns_find_pdi(cdns, 0, stream->num_bd, stream->bd,
 				    dai_id);
 
 	if (pdi) {
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4a68abcdcc35..4c4ff074e3f6 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1016,8 +1016,10 @@ static irqreturn_t stm32fx_spi_irq_event(int irq, void *dev_id)
 static irqreturn_t stm32fx_spi_irq_thread(int irq, void *dev_id)
 {
 	struct spi_controller *ctrl = dev_id;
+	struct stm32_spi *spi = spi_controller_get_devdata(ctrl);
 
 	spi_finalize_current_transfer(ctrl);
+	stm32fx_spi_disable(spi);
 
 	return IRQ_HANDLED;
 }
@@ -1055,7 +1057,7 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 		mask |= STM32H7_SPI_SR_TXP | STM32H7_SPI_SR_RXP;
 
 	if (!(sr & mask)) {
-		dev_warn(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
+		dev_vdbg(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
 			 sr, ier);
 		spin_unlock_irqrestore(&spi->lock, flags);
 		return IRQ_NONE;
@@ -1185,8 +1187,6 @@ static int stm32_spi_prepare_msg(struct spi_controller *ctrl,
 			 ~clrb) | setb,
 			spi->base + spi->cfg->regs->cpol.reg);
 
-	stm32_spi_enable(spi);
-
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	return 0;
@@ -1204,6 +1204,7 @@ static void stm32fx_spi_dma_tx_cb(void *data)
 
 	if (spi->cur_comm == SPI_SIMPLEX_TX || spi->cur_comm == SPI_3WIRE_TX) {
 		spi_finalize_current_transfer(spi->ctrl);
+		stm32fx_spi_disable(spi);
 	}
 }
 
@@ -1218,6 +1219,7 @@ static void stm32_spi_dma_rx_cb(void *data)
 	struct stm32_spi *spi = data;
 
 	spi_finalize_current_transfer(spi->ctrl);
+	spi->cfg->disable(spi);
 }
 
 /**
@@ -1305,6 +1307,8 @@ static int stm32fx_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32FX_SPI_CR2, cr2);
 
+	stm32_spi_enable(spi);
+
 	/* starting data transfer when buffer is loaded */
 	if (spi->tx_buf)
 		spi->cfg->write_tx(spi);
@@ -1341,6 +1345,8 @@ static int stm32h7_spi_transfer_one_irq(struct stm32_spi *spi)
 
 	spin_lock_irqsave(&spi->lock, flags);
 
+	stm32_spi_enable(spi);
+
 	/* Be sure to have data in fifo before starting data transfer */
 	if (spi->tx_buf)
 		stm32h7_spi_write_txfifo(spi);
@@ -1372,6 +1378,8 @@ static void stm32fx_spi_transfer_one_dma_start(struct stm32_spi *spi)
 		 */
 		stm32_spi_set_bits(spi, STM32FX_SPI_CR2, STM32FX_SPI_CR2_ERRIE);
 	}
+
+	stm32_spi_enable(spi);
 }
 
 /**
@@ -1405,6 +1413,8 @@ static void stm32h7_spi_transfer_one_dma_start(struct stm32_spi *spi)
 
 	stm32_spi_set_bits(spi, STM32H7_SPI_IER, ier);
 
+	stm32_spi_enable(spi);
+
 	if (STM32_SPI_HOST_MODE(spi))
 		stm32_spi_set_bits(spi, STM32H7_SPI_CR1, STM32H7_SPI_CR1_CSTART);
 }
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index a2c467d9e92f..2cea7aeb10f9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1242,6 +1242,7 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 	else
 		rx_dev = ctlr->dev.parent;
 
+	ret = -ENOMSG;
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
 		/* The sync is done before each transfer. */
 		unsigned long attrs = DMA_ATTR_SKIP_CPU_SYNC;
@@ -1271,6 +1272,9 @@ static int __spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
 			}
 		}
 	}
+	/* No transfer has been mapped, bail out with success */
+	if (ret)
+		return 0;
 
 	ctlr->cur_rx_dma_dev = rx_dev;
 	ctlr->cur_tx_dma_dev = tx_dev;
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ed1180fe31f..937c15324513 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1462,8 +1462,8 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
-	if (IS_ERR(core))
-		return PTR_ERR(core);
+	if (!core)
+		return -ENOMEM;
 
 	pmic_arb->core_size = resource_size(res);
 
@@ -1495,15 +1495,15 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 						   "obsrvr");
 		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->rd_base))
-			return PTR_ERR(pmic_arb->rd_base);
+		if (!pmic_arb->rd_base)
+			return -ENOMEM;
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "chnls");
 		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->wr_base))
-			return PTR_ERR(pmic_arb->wr_base);
+		if (!pmic_arb->wr_base)
+			return -ENOMEM;
 	}
 
 	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
diff --git a/drivers/staging/greybus/arche-apb-ctrl.c b/drivers/staging/greybus/arche-apb-ctrl.c
index 8541995008da..aa6f266b62a1 100644
--- a/drivers/staging/greybus/arche-apb-ctrl.c
+++ b/drivers/staging/greybus/arche-apb-ctrl.c
@@ -466,6 +466,7 @@ static const struct of_device_id arche_apb_ctrl_of_match[] = {
 	{ .compatible = "usbffff,2", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, arche_apb_ctrl_of_match);
 
 static struct platform_driver arche_apb_ctrl_device_driver = {
 	.probe		= arche_apb_ctrl_probe,
diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 891b75327d7f..b33977ccd527 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -619,14 +619,7 @@ static const struct of_device_id arche_platform_of_match[] = {
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
index a5c2fe963866..00360f4a0485 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -142,6 +142,9 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
 		channel = get_channel_from_mode(channel->light,
 						GB_CHANNEL_MODE_TORCH);
 
+	if (!channel)
+		return -EINVAL;
+
 	/* For not flash we need to convert brightness to intensity */
 	intensity = channel->intensity_uA.min +
 			(channel->intensity_uA.step * channel->led->brightness);
@@ -528,7 +531,10 @@ static int gb_lights_light_v4l2_register(struct gb_light *light)
 	}
 
 	channel_flash = get_channel_from_mode(light, GB_CHANNEL_MODE_FLASH);
-	WARN_ON(!channel_flash);
+	if (!channel_flash) {
+		dev_err(dev, "failed to get flash channel from mode\n");
+		return -EINVAL;
+	}
 
 	fled = &channel_flash->fled;
 
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 5efb2b593be3..3d2b83d6ab51 100644
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
 	unsigned int status = 0;
 	int ret = 0, cts;
@@ -254,6 +257,17 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
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
@@ -738,13 +752,14 @@ static int max3100_probe(struct spi_device *spi)
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
@@ -830,6 +845,7 @@ static void max3100_remove(struct spi_device *spi)
 		}
 	pr_debug("removing max3100 driver\n");
 	uart_unregister_driver(&max3100_uart_driver);
+	uart_driver_registered = 0;
 
 	mutex_unlock(&max3100s_lock);
 }
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 12915fffac27..ace2c4b333ac 100644
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
index e512eaa57ed5..a6f3517dce74 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1271,9 +1271,14 @@ static void sci_dma_rx_chan_invalidate(struct sci_port *s)
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
diff --git a/drivers/usb/fotg210/fotg210-core.c b/drivers/usb/fotg210/fotg210-core.c
index 958fc40eae86..0655afe7f977 100644
--- a/drivers/usb/fotg210/fotg210-core.c
+++ b/drivers/usb/fotg210/fotg210-core.c
@@ -95,6 +95,7 @@ static int fotg210_gemini_init(struct fotg210 *fotg, struct resource *res,
 
 /**
  * fotg210_vbus() - Called by gadget driver to enable/disable VBUS
+ * @fotg: pointer to a private fotg210 object
  * @enable: true to enable VBUS, false to disable VBUS
  */
 void fotg210_vbus(struct fotg210 *fotg, bool enable)
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
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 69dd86669883..990008aebe8f 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -2269,24 +2269,24 @@ static int xhci_setup_port_arrays(struct xhci_hcd *xhci, gfp_t flags)
 }
 
 static struct xhci_interrupter *
-xhci_alloc_interrupter(struct xhci_hcd *xhci, int segs, gfp_t flags)
+xhci_alloc_interrupter(struct xhci_hcd *xhci, unsigned int segs, gfp_t flags)
 {
 	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
 	struct xhci_interrupter *ir;
-	unsigned int num_segs = segs;
+	unsigned int max_segs;
 	int ret;
 
+	if (!segs)
+		segs = ERST_DEFAULT_SEGS;
+
+	max_segs = BIT(HCS_ERST_MAX(xhci->hcs_params2));
+	segs = min(segs, max_segs);
+
 	ir = kzalloc_node(sizeof(*ir), flags, dev_to_node(dev));
 	if (!ir)
 		return NULL;
 
-	/* number of ring segments should be greater than 0 */
-	if (segs <= 0)
-		num_segs = min_t(unsigned int, 1 << HCS_ERST_MAX(xhci->hcs_params2),
-			 ERST_MAX_SEGS);
-
-	ir->event_ring = xhci_ring_alloc(xhci, num_segs, 1, TYPE_EVENT, 0,
-					 flags);
+	ir->event_ring = xhci_ring_alloc(xhci, segs, 1, TYPE_EVENT, 0, flags);
 	if (!ir->event_ring) {
 		xhci_warn(xhci, "Failed to allocate interrupter event ring\n");
 		kfree(ir);
@@ -2344,7 +2344,7 @@ xhci_add_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir,
 }
 
 struct xhci_interrupter *
-xhci_create_secondary_interrupter(struct usb_hcd *hcd, int num_seg)
+xhci_create_secondary_interrupter(struct usb_hcd *hcd, unsigned int segs)
 {
 	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
 	struct xhci_interrupter *ir;
@@ -2354,7 +2354,7 @@ xhci_create_secondary_interrupter(struct usb_hcd *hcd, int num_seg)
 	if (!xhci->interrupters || xhci->max_interrupters <= 1)
 		return NULL;
 
-	ir = xhci_alloc_interrupter(xhci, num_seg, GFP_KERNEL);
+	ir = xhci_alloc_interrupter(xhci, segs, GFP_KERNEL);
 	if (!ir)
 		return NULL;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 6f4bf98a6282..31566e82bbd3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1392,8 +1392,8 @@ struct urb_priv {
 	struct	xhci_td	td[] __counted_by(num_tds);
 };
 
-/* Reasonable limit for number of Event Ring segments (spec allows 32k) */
-#define	ERST_MAX_SEGS	2
+/* Number of Event Ring segments to allocate, when amount is not specified. (spec allows 32k) */
+#define	ERST_DEFAULT_SEGS	2
 /* Poll every 60 seconds */
 #define	POLL_TIMEOUT	60
 /* Stop endpoint command timeout (secs) for URB cancellation watchdog timer */
@@ -1833,7 +1833,7 @@ struct xhci_container_ctx *xhci_alloc_container_ctx(struct xhci_hcd *xhci,
 void xhci_free_container_ctx(struct xhci_hcd *xhci,
 		struct xhci_container_ctx *ctx);
 struct xhci_interrupter *
-xhci_create_secondary_interrupter(struct usb_hcd *hcd, int num_seg);
+xhci_create_secondary_interrupter(struct usb_hcd *hcd, unsigned int segs);
 void xhci_remove_secondary_interrupter(struct usb_hcd
 				       *hcd, struct xhci_interrupter *ir);
 
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index bd6ae92aa39e..7801501837b6 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -619,7 +619,8 @@ static int ucsi_read_pdos(struct ucsi_connector *con,
 	u64 command;
 	int ret;
 
-	if (ucsi->quirks & UCSI_NO_PARTNER_PDOS)
+	if (is_partner &&
+	    ucsi->quirks & UCSI_NO_PARTNER_PDOS)
 		return 0;
 
 	command = UCSI_COMMAND(UCSI_GET_PDOS) | UCSI_CONNECTOR_NUMBER(con->num);
@@ -823,12 +824,6 @@ static int ucsi_register_partner_pdos(struct ucsi_connector *con)
 			return PTR_ERR(cap);
 
 		con->partner_source_caps = cap;
-
-		ret = typec_partner_set_usb_power_delivery(con->partner, con->partner_pd);
-		if (ret) {
-			usb_power_delivery_unregister_capabilities(con->partner_source_caps);
-			return ret;
-		}
 	}
 
 	ret = ucsi_get_pdos(con, TYPEC_SINK, 1, caps.pdo);
@@ -843,15 +838,9 @@ static int ucsi_register_partner_pdos(struct ucsi_connector *con)
 			return PTR_ERR(cap);
 
 		con->partner_sink_caps = cap;
-
-		ret = typec_partner_set_usb_power_delivery(con->partner, con->partner_pd);
-		if (ret) {
-			usb_power_delivery_unregister_capabilities(con->partner_sink_caps);
-			return ret;
-		}
 	}
 
-	return 0;
+	return typec_partner_set_usb_power_delivery(con->partner, con->partner_pd);
 }
 
 static void ucsi_unregister_partner_pdos(struct ucsi_connector *con)
@@ -1572,7 +1561,6 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		}
 
 		con->port_source_caps = pd_cap;
-		typec_port_set_usb_power_delivery(con->port, con->pd);
 	}
 
 	memset(&pd_caps, 0, sizeof(pd_caps));
@@ -1589,9 +1577,10 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
 		}
 
 		con->port_sink_caps = pd_cap;
-		typec_port_set_usb_power_delivery(con->port, con->pd);
 	}
 
+	typec_port_set_usb_power_delivery(con->port, con->pd);
+
 	/* Alternate modes */
 	ret = ucsi_register_altmodes(con, UCSI_RECIPIENT_CON);
 	if (ret) {
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index fb5392b749ff..e80c5d75b541 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -277,8 +277,10 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 		return -ENOMEM;
 
 	ctx = vfio_irq_ctx_alloc(vdev, 0);
-	if (!ctx)
+	if (!ctx) {
+		kfree(name);
 		return -ENOMEM;
+	}
 
 	ctx->name = name;
 	ctx->trigger = trigger;
diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index c80a1481e742..4e98e60417d2 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -205,8 +205,9 @@ static int mp3309c_parse_fwnode(struct mp3309c_chip *chip,
 				struct mp3309c_platform_data *pdata)
 {
 	int ret, i;
-	unsigned int num_levels, tmp_value;
+	unsigned int tmp_value;
 	struct device *dev = chip->dev;
+	int num_levels;
 
 	if (!dev_fwnode(dev))
 		return dev_err_probe(dev, -ENODEV, "failed to get firmware node\n");
diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 1f5b3dd31fcf..89bc8da80519 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -450,7 +450,7 @@ static void start_update_balloon_size(struct virtio_balloon *vb)
 	vb->adjustment_signal_pending = true;
 	if (!vb->adjustment_in_progress) {
 		vb->adjustment_in_progress = true;
-		pm_stay_awake(vb->vdev->dev.parent);
+		pm_stay_awake(&vb->vdev->dev);
 	}
 	spin_unlock_irqrestore(&vb->adjustment_lock, flags);
 
@@ -462,7 +462,7 @@ static void end_update_balloon_size(struct virtio_balloon *vb)
 	spin_lock_irq(&vb->adjustment_lock);
 	if (!vb->adjustment_signal_pending && vb->adjustment_in_progress) {
 		vb->adjustment_in_progress = false;
-		pm_relax(vb->vdev->dev.parent);
+		pm_relax(&vb->vdev->dev);
 	}
 	spin_unlock_irq(&vb->adjustment_lock);
 }
@@ -1029,6 +1029,15 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&vb->adjustment_lock);
 
+	/*
+	 * The virtio balloon itself can't wake up the device, but it is
+	 * responsible for processing wakeup events passed up from the transport
+	 * layer. Wakeup sources don't support nesting/chaining calls, so we use
+	 * our own wakeup source to ensure wakeup events are properly handled
+	 * without trampling on the transport layer's wakeup source.
+	 */
+	device_set_wakeup_capable(&vb->vdev->dev, true);
+
 	virtio_device_ready(vdev);
 
 	if (towards_target(vb))
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index b655fccaf773..584af7816532 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -348,8 +348,10 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
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
 
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 688b112e712b..9f279c0e13a6 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -252,7 +252,7 @@ static void cpu5wdt_exit(void)
 	if (cpu5wdt_device.queue) {
 		cpu5wdt_device.queue = 0;
 		wait_for_completion(&cpu5wdt_device.stop);
-		del_timer(&cpu5wdt_device.timer);
+		timer_shutdown_sync(&cpu5wdt_device.timer);
 	}
 
 	misc_deregister(&cpu5wdt_misc);
diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 5d2df008b92a..34a917221e31 100644
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
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5fc7c1..5f77f9df2476 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3896,15 +3896,14 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	sector_t cur_lblock;
-	sector_t last_lblock;
-	sector_t pblock;
-	sector_t lowest_pblock = -1;
-	sector_t highest_pblock = 0;
+	block_t cur_lblock;
+	block_t last_lblock;
+	block_t pblock;
+	block_t lowest_pblock = -1;
+	block_t highest_pblock = 0;
 	int nr_extents = 0;
-	unsigned long nr_pblocks;
+	unsigned int nr_pblocks;
 	unsigned int blks_per_sec = BLKS_PER_SEC(sbi);
-	unsigned int sec_blks_mask = BLKS_PER_SEC(sbi) - 1;
 	unsigned int not_aligned = 0;
 	int ret = 0;
 
@@ -3942,8 +3941,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
-		if ((pblock - SM_I(sbi)->main_blkaddr) & sec_blks_mask ||
-				nr_pblocks & sec_blks_mask ||
+		if ((pblock - SM_I(sbi)->main_blkaddr) % blks_per_sec ||
+				nr_pblocks % blks_per_sec ||
 				!f2fs_valid_pinned_area(sbi, pblock)) {
 			bool last_extent = false;
 
@@ -4185,7 +4184,7 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
 		return -EINVAL;
 
-	if (map.m_pblk != NULL_ADDR) {
+	if (map.m_flags & F2FS_MAP_MAPPED) {
 		iomap->length = blks_to_bytes(inode, map.m_len);
 		iomap->type = IOMAP_MAPPED;
 		iomap->flags |= IOMAP_F_MERGED;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index fced2b7652f4..07b3675ea169 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2309,7 +2309,7 @@ static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);
 static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 				 struct inode *inode, blkcnt_t *count, bool partial)
 {
-	blkcnt_t diff = 0, release = 0;
+	long long diff = 0, release = 0;
 	block_t avail_user_block_count;
 	int ret;
 
@@ -2329,26 +2329,27 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	percpu_counter_add(&sbi->alloc_valid_block_count, (*count));
 
 	spin_lock(&sbi->stat_lock);
-	sbi->total_valid_block_count += (block_t)(*count);
-	avail_user_block_count = get_available_block_count(sbi, inode, true);
 
-	if (unlikely(sbi->total_valid_block_count > avail_user_block_count)) {
+	avail_user_block_count = get_available_block_count(sbi, inode, true);
+	diff = (long long)sbi->total_valid_block_count + *count -
+						avail_user_block_count;
+	if (unlikely(diff > 0)) {
 		if (!partial) {
 			spin_unlock(&sbi->stat_lock);
+			release = *count;
 			goto enospc;
 		}
-
-		diff = sbi->total_valid_block_count - avail_user_block_count;
 		if (diff > *count)
 			diff = *count;
 		*count -= diff;
 		release = diff;
-		sbi->total_valid_block_count -= diff;
 		if (!*count) {
 			spin_unlock(&sbi->stat_lock);
 			goto enospc;
 		}
 	}
+	sbi->total_valid_block_count += (block_t)(*count);
+
 	spin_unlock(&sbi->stat_lock);
 
 	if (unlikely(release)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1761ad125f97..208dedc161d5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -952,9 +952,14 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
 
 	err = setattr_prepare(idmap, dentry, attr);
 	if (err)
@@ -1325,6 +1330,9 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 				f2fs_put_page(psrc, 1);
 				return PTR_ERR(pdst);
 			}
+
+			f2fs_wait_on_page_writeback(pdst, DATA, true, true);
+
 			memcpy_page(pdst, 0, psrc, 0, PAGE_SIZE);
 			set_page_dirty(pdst);
 			set_page_private_gcing(pdst);
@@ -1817,15 +1825,6 @@ static long f2fs_fallocate(struct file *file, int mode,
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
-	/*
-	 * Pinned file should not support partial truncation since the block
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
@@ -1833,6 +1832,17 @@ static long f2fs_fallocate(struct file *file, int mode,
 
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
@@ -2837,7 +2847,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 			goto out;
 	}
 
-	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst)) {
+	if (f2fs_compressed_file(src) || f2fs_compressed_file(dst) ||
+		f2fs_is_pinned_file(src) || f2fs_is_pinned_file(dst)) {
 		ret = -EOPNOTSUPP;
 		goto out_unlock;
 	}
@@ -3522,9 +3533,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3543,7 +3551,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -3570,9 +3579,12 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
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
@@ -3590,6 +3602,8 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -3641,7 +3655,8 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 	while (count) {
 		int compr_blocks = 0;
-		blkcnt_t reserved;
+		blkcnt_t reserved = 0;
+		blkcnt_t to_reserved;
 		int ret;
 
 		for (i = 0; i < cluster_size; i++) {
@@ -3661,20 +3676,26 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
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
 
@@ -3685,7 +3706,7 @@ static int reserve_compress_blocks(struct dnode_of_data *dn, pgoff_t count,
 
 		f2fs_i_compr_blocks_update(dn->inode, compr_blocks, true);
 
-		*reserved_blocks += reserved;
+		*reserved_blocks += to_reserved;
 next:
 		count -= cluster_size;
 	}
@@ -3704,9 +3725,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
@@ -3718,7 +3736,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 	inode_lock(inode);
 
-	if (!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		!is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto unlock_inode;
 	}
@@ -3735,9 +3754,12 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
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
@@ -3755,6 +3777,8 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 
 		f2fs_put_dnode(&dn);
 
+		f2fs_unlock_op(sbi);
+
 		if (ret < 0)
 			break;
 
@@ -4119,9 +4143,6 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4132,7 +4153,8 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -4197,9 +4219,6 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	if (!(filp->f_mode & FMODE_WRITE))
 		return -EBADF;
 
-	if (!f2fs_compressed_file(inode))
-		return -EINVAL;
-
 	f2fs_balance_fs(sbi, true);
 
 	file_start_write(filp);
@@ -4210,7 +4229,8 @@ static int f2fs_ioc_compress_file(struct file *filp)
 		goto out;
 	}
 
-	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
+	if (!f2fs_compressed_file(inode) ||
+		is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 8852814dab7f..e86c7f01539a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1554,10 +1554,15 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
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
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3de6d6cdb02..7df5ad84cb5e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1319,6 +1319,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	}
 	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
 		err = -EFSCORRUPTED;
+		dec_valid_node_count(sbi, dn->inode, !ofs);
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
 		goto fail;
@@ -1345,7 +1346,6 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
 	return page;
-
 fail:
 	clear_node_page_dirty(page);
 	f2fs_put_page(page, 1);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4fd76e867e0a..6474b7338e81 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3559,6 +3559,8 @@ int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	if (segment_full) {
 		if (type == CURSEG_COLD_DATA_PINNED &&
 		    !((curseg->segno + 1) % sbi->segs_per_sec)) {
+			write_sum_page(sbi, curseg->sum_blk,
+					GET_SUM_BLOCK(sbi, curseg->segno));
 			reset_curseg_fields(curseg);
 			goto skip_new_segment;
 		}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3ec8bb5e68ff..9eb191b5c4de 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1813,7 +1813,8 @@ static void fuse_resend(struct fuse_conn *fc)
 	spin_unlock(&fc->lock);
 
 	list_for_each_entry_safe(req, next, &to_queue, list) {
-		__set_bit(FR_PENDING, &req->flags);
+		set_bit(FR_PENDING, &req->flags);
+		clear_bit(FR_SENT, &req->flags);
 		/* mark the request as resend request */
 		req->in.h.unique |= FUSE_UNIQUE_RESEND;
 	}
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 267b622d923b..912ad0a1df02 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -163,7 +163,7 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct folio *folio;
 	enum netfs_how_to_modify howto;
 	enum netfs_folio_trace trace;
-	unsigned int bdp_flags = (iocb->ki_flags & IOCB_SYNC) ? 0: BDP_ASYNC;
+	unsigned int bdp_flags = (iocb->ki_flags & IOCB_NOWAIT) ? BDP_ASYNC : 0;
 	ssize_t written = 0, ret, ret2;
 	loff_t i_size, pos = iocb->ki_pos, from, to;
 	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index ce8f8934bca5..569ae4ec6084 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -883,7 +883,7 @@ filelayout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 						      NFS4_MAX_UINT64,
 						      IOMODE_READ,
 						      false,
-						      GFP_KERNEL);
+						      nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
@@ -907,7 +907,7 @@ filelayout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 						      NFS4_MAX_UINT64,
 						      IOMODE_RW,
 						      false,
-						      GFP_NOFS);
+						      nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index d0a0956f8a13..cac1157be2c2 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1112,9 +1112,12 @@ static int nfs23_parse_monolithic(struct fs_context *fc,
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
index 662e86ea3a2d..5b452411e8fd 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2116,6 +2116,7 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
 {
 	struct nfs_client *clp = server->nfs_client;
 	struct nfs4_fs_locations *locations = NULL;
+	struct nfs_fattr *fattr;
 	struct inode *inode;
 	struct page *page;
 	int status, result;
@@ -2125,19 +2126,16 @@ static int nfs4_try_migration(struct nfs_server *server, const struct cred *cred
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
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 855519713bf7..4085fe30bf48 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -1184,7 +1184,8 @@ static int read_log_page(struct ntfs_log *log, u32 vbo,
 static int log_read_rst(struct ntfs_log *log, bool first,
 			struct restart_info *info)
 {
-	u32 skip, vbo;
+	u32 skip;
+	u64 vbo;
 	struct RESTART_HDR *r_page = NULL;
 
 	/* Determine which restart area we are looking for. */
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index ba5a39a2f957..90d4e9a9859e 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -577,13 +577,18 @@ static noinline int ntfs_get_block_vbo(struct inode *inode, u64 vbo,
 	clear_buffer_uptodate(bh);
 
 	if (is_resident(ni)) {
-		ni_lock(ni);
-		err = attr_data_read_resident(ni, &folio->page);
-		ni_unlock(ni);
-
-		if (!err)
-			set_buffer_uptodate(bh);
+		bh->b_blocknr = RESIDENT_LCN;
 		bh->b_size = block_size;
+		if (!folio) {
+			err = 0;
+		} else {
+			ni_lock(ni);
+			err = attr_data_read_resident(ni, &folio->page);
+			ni_unlock(ni);
+
+			if (!err)
+				set_buffer_uptodate(bh);
+		}
 		return err;
 	}
 
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 9c7478150a03..3d6143c7abc0 100644
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
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index c803c10dd97e..33aeaaa056d7 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -863,14 +863,8 @@ static int ocfs2_local_alloc_find_clear_bits(struct ocfs2_super *osb,
 
 	numfound = bitoff = startoff = 0;
 	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
-	while ((bitoff = ocfs2_find_next_zero_bit(bitmap, left, startoff)) != -1) {
-		if (bitoff == left) {
-			/* mlog(0, "bitoff (%d) == left", bitoff); */
-			break;
-		}
-		/* mlog(0, "Found a zero: bitoff = %d, startoff = %d, "
-		   "numfound = %d\n", bitoff, startoff, numfound);*/
-
+	while ((bitoff = ocfs2_find_next_zero_bit(bitmap, left, startoff)) <
+	       left) {
 		/* Ok, we found a zero bit... is it contig. or do we
 		 * start over?*/
 		if (bitoff == startoff) {
@@ -976,9 +970,9 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 	start = count = 0;
 	left = le32_to_cpu(alloc->id1.bitmap1.i_total);
 
-	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start))
-	       != -1) {
-		if ((bit_off < left) && (bit_off == start)) {
+	while ((bit_off = ocfs2_find_next_zero_bit(bitmap, left, start)) <
+	       left) {
+		if (bit_off == start) {
 			count++;
 			start++;
 			continue;
@@ -1002,8 +996,7 @@ static int ocfs2_sync_local_to_main(struct ocfs2_super *osb,
 				goto bail;
 			}
 		}
-		if (bit_off >= left)
-			break;
+
 		count = 1;
 		start = bit_off + 1;
 	}
diff --git a/fs/ocfs2/reservations.c b/fs/ocfs2/reservations.c
index a9d1296d736d..1fe61974d9f0 100644
--- a/fs/ocfs2/reservations.c
+++ b/fs/ocfs2/reservations.c
@@ -414,7 +414,7 @@ static int ocfs2_resmap_find_free_bits(struct ocfs2_reservation_map *resmap,
 
 	start = search_start;
 	while ((offset = ocfs2_find_next_zero_bit(bitmap, resmap->m_bitmap_len,
-						 start)) != -1) {
+					start)) < resmap->m_bitmap_len) {
 		/* Search reached end of the region */
 		if (offset >= (search_start + search_len))
 			break;
diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index 166c8918c825..961998415308 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -1290,10 +1290,8 @@ static int ocfs2_block_group_find_clear_bits(struct ocfs2_super *osb,
 	found = start = best_offset = best_size = 0;
 	bitmap = bg->bg_bitmap;
 
-	while((offset = ocfs2_find_next_zero_bit(bitmap, total_bits, start)) != -1) {
-		if (offset == total_bits)
-			break;
-
+	while ((offset = ocfs2_find_next_zero_bit(bitmap, total_bits, start)) <
+	       total_bits) {
 		if (!ocfs2_test_bg_bit_allocatable(bg_bh, offset)) {
 			/* We found a zero, but we can't use it as it
 			 * hasn't been put to disk yet! */
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0f8b4a719237..02d89a285d0d 100644
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
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 39277c37185c..4fb21affe4e1 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1277,7 +1277,7 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	struct cifsFileInfo *smb_file_src = src_file->private_data;
 	struct cifsFileInfo *smb_file_target = dst_file->private_data;
 	struct cifs_tcon *target_tcon, *src_tcon;
-	unsigned long long destend, fstart, fend, new_size;
+	unsigned long long destend, fstart, fend, old_size, new_size;
 	unsigned int xid;
 	int rc;
 
@@ -1342,6 +1342,9 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
 	if (rc)
 		goto unlock;
+	if (fend > target_cifsi->netfs.zero_point)
+		target_cifsi->netfs.zero_point = fend + 1;
+	old_size = target_cifsi->netfs.remote_i_size;
 
 	/* Discard all the folios that overlap the destination region. */
 	cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend);
@@ -1354,12 +1357,13 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	if (target_tcon->ses->server->ops->duplicate_extents) {
 		rc = target_tcon->ses->server->ops->duplicate_extents(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
-		if (rc == 0 && new_size > i_size_read(target_inode)) {
+		if (rc == 0 && new_size > old_size) {
 			truncate_setsize(target_inode, new_size);
-			netfs_resize_file(&target_cifsi->netfs, new_size, true);
 			fscache_resize_cookie(cifs_inode_cookie(target_inode),
 					      new_size);
 		}
+		if (rc == 0 && new_size > target_cifsi->netfs.zero_point)
+			target_cifsi->netfs.zero_point = new_size;
 	}
 
 	/* force revalidate of size and timestamps of target file now
@@ -1451,6 +1455,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
 	if (rc)
 		goto unlock;
+	if (fend > target_cifsi->netfs.zero_point)
+		target_cifsi->netfs.zero_point = fend + 1;
 
 	/* Discard all the folios that overlap the destination region. */
 	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 28f0b7d19d53..6fea0aed4346 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2028,6 +2028,7 @@ smb2_duplicate_extents(const unsigned int xid,
 		 * size will be queried on next revalidate, but it is important
 		 * to make sure that file's cached size is updated immediately
 		 */
+		netfs_resize_file(netfs_inode(inode), dest_off + len, true);
 		cifs_setsize(inode, dest_off + len);
 	}
 	rc = SMB2_ioctl(xid, tcon, trgtfile->fid.persistent_fid,
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 2f831a3a91af..bbf8918417fd 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -341,7 +341,7 @@ const struct address_space_operations udf_aops = {
  */
 int udf_expand_file_adinicb(struct inode *inode)
 {
-	struct page *page;
+	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
 	int err;
 
@@ -357,12 +357,13 @@ int udf_expand_file_adinicb(struct inode *inode)
 		return 0;
 	}
 
-	page = find_or_create_page(inode->i_mapping, 0, GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
+	folio = __filemap_get_folio(inode->i_mapping, 0,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	if (!PageUptodate(page))
-		udf_adinicb_readpage(page);
+	if (!folio_test_uptodate(folio))
+		udf_adinicb_readpage(&folio->page);
 	down_write(&iinfo->i_data_sem);
 	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
 	       iinfo->i_lenAlloc);
@@ -371,22 +372,22 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-	set_page_dirty(page);
-	unlock_page(page);
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
 	up_write(&iinfo->i_data_sem);
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
-		lock_page(page);
+		folio_lock(folio);
 		down_write(&iinfo->i_data_sem);
-		memcpy_to_page(page, 0, iinfo->i_data + iinfo->i_lenEAttr,
-			       inode->i_size);
-		unlock_page(page);
+		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
+				folio, 0, inode->i_size);
+		folio_unlock(folio);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
 	}
-	put_page(page);
+	folio_put(folio);
 	mark_inode_dirty(inode);
 
 	return err;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 702e9108bbb4..b767b5c821f5 100644
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
diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 297231854ada..e44913a8200f 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -632,6 +632,14 @@ static inline void eth_skb_pkt_type(struct sk_buff *skb,
 	}
 }
 
+static inline struct ethhdr *eth_skb_pull_mac(struct sk_buff *skb)
+{
+	struct ethhdr *eth = (struct ethhdr *)skb->data;
+
+	skb_pull_inline(skb, ETH_HLEN);
+	return eth;
+}
+
 /**
  * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
  * @skb: Buffer to pad
diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 6eaa190d0083..9754f97e71e5 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -71,17 +71,30 @@ void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("
 	__ret;							\
 })
 
-#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
+#if defined(__SANITIZE_ADDRESS__)
+
+#if !defined(CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX) && !defined(CONFIG_GENERIC_ENTRY)
+extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
+extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
+extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
+#elif defined(CONFIG_KASAN_GENERIC)
+extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(__asan_memset);
+extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(__asan_memmove);
+extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(__asan_memcpy);
+#else /* CONFIG_KASAN_SW_TAGS */
+extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(__hwasan_memset);
+extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(__hwasan_memmove);
+extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(__hwasan_memcpy);
+#endif
+
 extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
 extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
-extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
-extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
-extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
 extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
 extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
 extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
 extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
 extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
+
 #else
 
 #if defined(__SANITIZE_MEMORY__)
@@ -106,6 +119,7 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
 #define __underlying_strlen	__builtin_strlen
 #define __underlying_strncat	__builtin_strncat
 #define __underlying_strncpy	__builtin_strncpy
+
 #endif
 
 /**
diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
index 223da48a6d18..94c4edd047e5 100644
--- a/include/linux/fpga/fpga-bridge.h
+++ b/include/linux/fpga/fpga-bridge.h
@@ -45,6 +45,7 @@ struct fpga_bridge_info {
  * @dev: FPGA bridge device
  * @mutex: enforces exclusive reference to bridge
  * @br_ops: pointer to struct of FPGA bridge ops
+ * @br_ops_owner: module containing the br_ops
  * @info: fpga image specific information
  * @node: FPGA bridge list node
  * @priv: low level driver private date
@@ -54,6 +55,7 @@ struct fpga_bridge {
 	struct device dev;
 	struct mutex mutex; /* for exclusive reference to bridge */
 	const struct fpga_bridge_ops *br_ops;
+	struct module *br_ops_owner;
 	struct fpga_image_info *info;
 	struct list_head node;
 	void *priv;
@@ -79,10 +81,12 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
 			       struct fpga_image_info *info,
 			       struct list_head *bridge_list);
 
+#define fpga_bridge_register(parent, name, br_ops, priv) \
+	__fpga_bridge_register(parent, name, br_ops, priv, THIS_MODULE)
 struct fpga_bridge *
-fpga_bridge_register(struct device *parent, const char *name,
-		     const struct fpga_bridge_ops *br_ops,
-		     void *priv);
+__fpga_bridge_register(struct device *parent, const char *name,
+		       const struct fpga_bridge_ops *br_ops, void *priv,
+		       struct module *owner);
 void fpga_bridge_unregister(struct fpga_bridge *br);
 
 #endif /* _LINUX_FPGA_BRIDGE_H */
diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index 54f63459efd6..0d4fe068f3d8 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -201,6 +201,7 @@ struct fpga_manager_ops {
  * @state: state of fpga manager
  * @compat_id: FPGA manager id for compatibility check.
  * @mops: pointer to struct of fpga manager ops
+ * @mops_owner: module containing the mops
  * @priv: low level driver private date
  */
 struct fpga_manager {
@@ -210,6 +211,7 @@ struct fpga_manager {
 	enum fpga_mgr_states state;
 	struct fpga_compat_id *compat_id;
 	const struct fpga_manager_ops *mops;
+	struct module *mops_owner;
 	void *priv;
 };
 
@@ -230,18 +232,30 @@ struct fpga_manager *fpga_mgr_get(struct device *dev);
 
 void fpga_mgr_put(struct fpga_manager *mgr);
 
+#define fpga_mgr_register_full(parent, info) \
+	__fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			 struct module *owner);
 
+#define fpga_mgr_register(parent, name, mops, priv) \
+	__fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-fpga_mgr_register(struct device *parent, const char *name,
-		  const struct fpga_manager_ops *mops, void *priv);
+__fpga_mgr_register(struct device *parent, const char *name,
+		    const struct fpga_manager_ops *mops, void *priv, struct module *owner);
+
 void fpga_mgr_unregister(struct fpga_manager *mgr);
 
+#define devm_fpga_mgr_register_full(parent, info) \
+	__devm_fpga_mgr_register_full(parent, info, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info);
+__devm_fpga_mgr_register_full(struct device *parent, const struct fpga_manager_info *info,
+			      struct module *owner);
+#define devm_fpga_mgr_register(parent, name, mops, priv) \
+	__devm_fpga_mgr_register(parent, name, mops, priv, THIS_MODULE)
 struct fpga_manager *
-devm_fpga_mgr_register(struct device *parent, const char *name,
-		       const struct fpga_manager_ops *mops, void *priv);
+__devm_fpga_mgr_register(struct device *parent, const char *name,
+			 const struct fpga_manager_ops *mops, void *priv,
+			 struct module *owner);
 
 #endif /*_LINUX_FPGA_MGR_H */
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
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index c940b329a475..5e5a9c6774bd 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10267,9 +10267,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 	u8         mfrl[0x1];
 	u8         regs_39_to_32[0x8];
 
-	u8         regs_31_to_10[0x16];
+	u8         regs_31_to_11[0x15];
 	u8         mtmp[0x1];
-	u8         regs_8_to_0[0x9];
+	u8         regs_9_to_0[0xa];
 };
 
 struct mlx5_ifc_mcam_access_reg_bits1 {
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 22a07c0900a4..f230a472ccd3 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -299,6 +299,8 @@ enum regulator_type {
  * @vsel_range_reg: Register for range selector when using pickable ranges
  *		    and ``regulator_map_*_voltage_*_pickable`` functions.
  * @vsel_range_mask: Mask for register bitfield used for range selector
+ * @range_applied_by_vsel: A flag to indicate that changes to vsel_range_reg
+ *			   are only effective after vsel_reg is written
  * @vsel_reg: Register for selector when using ``regulator_map_*_voltage_*``
  * @vsel_mask: Mask for register bitfield used for selector
  * @vsel_step: Specify the resolution of selector stepping when setting
@@ -389,6 +391,7 @@ struct regulator_desc {
 
 	unsigned int vsel_range_reg;
 	unsigned int vsel_range_mask;
+	bool range_applied_by_vsel;
 	unsigned int vsel_reg;
 	unsigned int vsel_mask;
 	unsigned int vsel_step;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 4ff48eda3f64..5b1078c160f2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1174,15 +1174,6 @@ static inline bool skb_dst_is_noref(const struct sk_buff *skb)
 	return (skb->_skb_refdst & SKB_DST_NOREF) && skb_dst(skb);
 }
 
-/**
- * skb_rtable - Returns the skb &rtable
- * @skb: buffer
- */
-static inline struct rtable *skb_rtable(const struct sk_buff *skb)
-{
-	return (struct rtable *)skb_dst(skb);
-}
-
 /* For mangling skb->pkt_type from user space side from applications
  * such as nft, tc, etc, we only allow a conservative subset of
  * possible pkt_types to be set.
diff --git a/include/media/cec.h b/include/media/cec.h
index 10c9cf6058b7..cc3fcd0496c3 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -258,6 +258,7 @@ struct cec_adapter {
 	u16 phys_addr;
 	bool needs_hpd;
 	bool is_enabled;
+	bool is_claiming_log_addrs;
 	bool is_configuring;
 	bool must_reconfigure;
 	bool is_configured;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5277c6d5134c..970101184cf1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1335,8 +1335,7 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_dev *hdev, __u16 sync_handle)
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != ISO_LINK ||
-			!test_bit(HCI_CONN_PA_SYNC, &c->flags))
+		if (c->type != ISO_LINK)
 			continue;
 
 		if (c->sync_handle == sync_handle) {
diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 6d1c8541183d..3a9001a042a5 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -24,7 +24,7 @@ struct dst_ops {
 	void			(*destroy)(struct dst_entry *);
 	void			(*ifdown)(struct dst_entry *,
 					  struct net_device *dev);
-	struct dst_entry *	(*negative_advice)(struct dst_entry *);
+	void			(*negative_advice)(struct sock *sk, struct dst_entry *);
 	void			(*link_failure)(struct sk_buff *);
 	void			(*update_pmtu)(struct dst_entry *dst, struct sock *sk,
 					       struct sk_buff *skb, u32 mtu,
diff --git a/include/net/ip.h b/include/net/ip.h
index 25cb688bdc62..6d735e00d3f3 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -423,7 +423,7 @@ int ip_decrease_ttl(struct iphdr *iph)
 
 static inline int ip_mtu_locked(const struct dst_entry *dst)
 {
-	const struct rtable *rt = (const struct rtable *)dst;
+	const struct rtable *rt = dst_rtable(dst);
 
 	return rt->rt_mtu_locked || dst_metric_locked(dst, RTAX_MTU);
 }
@@ -461,7 +461,7 @@ static inline bool ip_sk_ignore_df(const struct sock *sk)
 static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
-	const struct rtable *rt = container_of(dst, struct rtable, dst);
+	const struct rtable *rt = dst_rtable(dst);
 	struct net *net = dev_net(dst->dev);
 	unsigned int mtu;
 
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 323c94f1845b..73524fa0c064 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -234,9 +234,11 @@ struct fib6_result {
 	for (rt = (w)->leaf; rt;					\
 	     rt = rcu_dereference_protected(rt->fib6_next, 1))
 
-static inline struct inet6_dev *ip6_dst_idev(struct dst_entry *dst)
+#define dst_rt6_info(_ptr) container_of_const(_ptr, struct rt6_info, dst)
+
+static inline struct inet6_dev *ip6_dst_idev(const struct dst_entry *dst)
 {
-	return ((struct rt6_info *)dst)->rt6i_idev;
+	return dst_rt6_info(dst)->rt6i_idev;
 }
 
 static inline bool fib6_requires_src(const struct fib6_info *rt)
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index a30c6aa9e5cf..a18ed24fed94 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -210,12 +210,11 @@ void rt6_uncached_list_del(struct rt6_info *rt);
 static inline const struct rt6_info *skb_rt6_info(const struct sk_buff *skb)
 {
 	const struct dst_entry *dst = skb_dst(skb);
-	const struct rt6_info *rt6 = NULL;
 
 	if (dst)
-		rt6 = container_of(dst, struct rt6_info, dst);
+		return dst_rt6_info(dst);
 
-	return rt6;
+	return NULL;
 }
 
 /*
@@ -227,7 +226,7 @@ static inline void ip6_dst_store(struct sock *sk, struct dst_entry *dst,
 {
 	struct ipv6_pinfo *np = inet6_sk(sk);
 
-	np->dst_cookie = rt6_get_cookie((struct rt6_info *)dst);
+	np->dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
 	sk_setup_caps(sk, dst);
 	np->daddr_cache = daddr;
 #ifdef CONFIG_IPV6_SUBTREES
@@ -240,7 +239,7 @@ void ip6_sk_dst_store_flow(struct sock *sk, struct dst_entry *dst,
 
 static inline bool ipv6_unicast_destination(const struct sk_buff *skb)
 {
-	struct rt6_info *rt = (struct rt6_info *) skb_dst(skb);
+	const struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 
 	return rt->rt6i_flags & RTF_LOCAL;
 }
@@ -248,7 +247,7 @@ static inline bool ipv6_unicast_destination(const struct sk_buff *skb)
 static inline bool ipv6_anycast_destination(const struct dst_entry *dst,
 					    const struct in6_addr *daddr)
 {
-	struct rt6_info *rt = (struct rt6_info *)dst;
+	const struct rt6_info *rt = dst_rt6_info(dst);
 
 	return rt->rt6i_flags & RTF_ANYCAST ||
 		(rt->rt6i_dst.plen < 127 &&
diff --git a/include/net/route.h b/include/net/route.h
index d4a0147942f1..af55401aa8f4 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -77,6 +77,17 @@ struct rtable {
 				rt_pmtu:31;
 };
 
+#define dst_rtable(_ptr) container_of_const(_ptr, struct rtable, dst)
+
+/**
+ * skb_rtable - Returns the skb &rtable
+ * @skb: buffer
+ */
+static inline struct rtable *skb_rtable(const struct sk_buff *skb)
+{
+	return dst_rtable(skb_dst(skb));
+}
+
 static inline bool rt_is_input_route(const struct rtable *rt)
 {
 	return rt->rt_is_input != 0;
diff --git a/include/net/sock.h b/include/net/sock.h
index b4b553df7870..944f71a8ab22 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2134,17 +2134,10 @@ sk_dst_get(const struct sock *sk)
 
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
diff --git a/include/sound/tas2781-dsp.h b/include/sound/tas2781-dsp.h
index ea9af2726a53..7fba7ea26a4b 100644
--- a/include/sound/tas2781-dsp.h
+++ b/include/sound/tas2781-dsp.h
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2781 driver implements a flexible and configurable
@@ -13,8 +13,8 @@
 // Author: Kevin Lu <kevin-lu@ti.com>
 //
 
-#ifndef __TASDEVICE_DSP_H__
-#define __TASDEVICE_DSP_H__
+#ifndef __TAS2781_DSP_H__
+#define __TAS2781_DSP_H__
 
 #define MAIN_ALL_DEVICES			0x0d
 #define MAIN_DEVICE_A				0x01
@@ -180,7 +180,6 @@ void tasdevice_calbin_remove(void *context);
 int tasdevice_select_tuningprm_cfg(void *context, int prm,
 	int cfg_no, int rca_conf_no);
 int tasdevice_prmg_load(void *context, int prm_no);
-int tasdevice_prmg_calibdata_load(void *context, int prm_no);
 void tasdevice_tuning_switch(void *context, int state);
 int tas2781_load_calibration(void *context, char *file_name,
 	unsigned short i);
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index cd84227f1b42..5402f77ee859 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -68,6 +68,13 @@ extern "C" {
  */
 #define NOUVEAU_GETPARAM_VRAM_USED 19
 
+/*
+ * NOUVEAU_GETPARAM_HAS_VMA_TILEMODE
+ *
+ * Query whether tile mode and PTE kind are accepted with VM allocs or not.
+ */
+#define NOUVEAU_GETPARAM_HAS_VMA_TILEMODE 20
+
 struct drm_nouveau_getparam {
 	__u64 param;
 	__u64 value;
diff --git a/init/Kconfig b/init/Kconfig
index 664bedb9a71f..459f44ef7cc9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -743,8 +743,8 @@ config LOG_CPU_MAX_BUF_SHIFT
 	int "CPU kernel log buffer size contribution (13 => 8 KB, 17 => 128KB)"
 	depends on SMP
 	range 0 21
-	default 12 if !BASE_SMALL
-	default 0 if BASE_SMALL
+	default 0 if BASE_SMALL != 0
+	default 12
 	depends on PRINTK
 	help
 	  This option allows to increase the default ring buffer size
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2c90b1eb12e2..8a29309db424 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8845,7 +8845,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -8856,6 +8857,11 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
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
@@ -8951,7 +8957,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -8961,7 +8966,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 02205ab53b7e..f7f3d14fa69a 100644
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
@@ -118,11 +117,13 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 		if (IS_ERR(tsk[i])) {
 			pr_err("create dma_map thread failed\n");
 			ret = PTR_ERR(tsk[i]);
+			while (--i >= 0)
+				kthread_stop(tsk[i]);
 			goto out;
 		}
 
 		if (node != NUMA_NO_NODE)
-			kthread_bind_mask(tsk[i], cpu_mask);
+			kthread_bind_mask(tsk[i], cpumask_of_node(node));
 	}
 
 	/* clear the old value in the previous benchmark */
@@ -139,13 +140,17 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 
 	msleep_interruptible(map->bparam.seconds * 1000);
 
-	/* wait for the completion of benchmark threads */
+	/* wait for the completion of all started benchmark threads */
 	for (i = 0; i < threads; i++) {
-		ret = kthread_stop(tsk[i]);
-		if (ret)
-			goto out;
+		int kthread_ret = kthread_stop_put(tsk[i]);
+
+		if (kthread_ret)
+			ret = kthread_ret;
 	}
 
+	if (ret)
+		goto out;
+
 	loops = atomic64_read(&map->loops);
 	if (likely(loops > 0)) {
 		u64 map_variance, unmap_variance;
@@ -170,8 +175,6 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	}
 
 out:
-	for (i = 0; i < threads; i++)
-		put_task_struct(tsk[i]);
 	put_device(map->dev);
 	kfree(tsk);
 	return ret;
@@ -208,7 +211,8 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
 		}
 
 		if (map->bparam.node != NUMA_NO_NODE &&
-		    !node_possible(map->bparam.node)) {
+		    (map->bparam.node < 0 || map->bparam.node >= MAX_NUMNODES ||
+		     !node_possible(map->bparam.node))) {
 			pr_err("invalid numa node\n");
 			return -EINVAL;
 		}
diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 6d443ea22bb7..4ba5fd3d73ae 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -14,7 +14,12 @@ include/
 arch/$SRCARCH/include/
 "
 
-type cpio > /dev/null
+if ! command -v cpio >/dev/null; then
+	echo >&2 "***"
+	echo >&2 "*** 'cpio' could not be found."
+	echo >&2 "***"
+	exit 1
+fi
 
 # Support incremental builds by skipping archive generation
 # if timestamps of files being archived are not changed.
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
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 2f68e93fff0b..df0745a42a3f 100644
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
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 42bc0f362226..1a7e7cf94493 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -553,6 +553,10 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
 			anon_offs = 0;
 			field = btf_find_struct_member(ctx->btf, type, fieldname,
 						       &anon_offs);
+			if (IS_ERR(field)) {
+				trace_probe_log_err(ctx->offset, BAD_BTF_TID);
+				return PTR_ERR(field);
+			}
 			if (!field) {
 				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
 				return -ENOENT;
diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index e81e1ac4a919..bdda600f8dfb 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -4,6 +4,7 @@ config ARCH_HAS_UBSAN
 
 menuconfig UBSAN
 	bool "Undefined behaviour sanity checker"
+	depends on ARCH_HAS_UBSAN
 	help
 	  This option enables the Undefined Behaviour sanity checker.
 	  Compile-time instrumentation is used to detect various undefined
diff --git a/lib/strcat_kunit.c b/lib/strcat_kunit.c
index e21be95514af..ca09f7f0e6a2 100644
--- a/lib/strcat_kunit.c
+++ b/lib/strcat_kunit.c
@@ -10,7 +10,7 @@
 
 static volatile int unconst;
 
-static void strcat_test(struct kunit *test)
+static void test_strcat(struct kunit *test)
 {
 	char dest[8];
 
@@ -29,7 +29,7 @@ static void strcat_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void strncat_test(struct kunit *test)
+static void test_strncat(struct kunit *test)
 {
 	char dest[8];
 
@@ -56,7 +56,7 @@ static void strncat_test(struct kunit *test)
 	KUNIT_EXPECT_STREQ(test, dest, "fourAB");
 }
 
-static void strlcat_test(struct kunit *test)
+static void test_strlcat(struct kunit *test)
 {
 	char dest[8] = "";
 	int len = sizeof(dest) + unconst;
@@ -88,9 +88,9 @@ static void strlcat_test(struct kunit *test)
 }
 
 static struct kunit_case strcat_test_cases[] = {
-	KUNIT_CASE(strcat_test),
-	KUNIT_CASE(strncat_test),
-	KUNIT_CASE(strlcat_test),
+	KUNIT_CASE(test_strcat),
+	KUNIT_CASE(test_strncat),
+	KUNIT_CASE(test_strlcat),
 	{}
 };
 
diff --git a/lib/string_kunit.c b/lib/string_kunit.c
index eabf025cf77c..dd19bd7748aa 100644
--- a/lib/string_kunit.c
+++ b/lib/string_kunit.c
@@ -11,6 +11,12 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 
+#define STRCMP_LARGE_BUF_LEN 2048
+#define STRCMP_CHANGE_POINT 1337
+#define STRCMP_TEST_EXPECT_EQUAL(test, fn, ...) KUNIT_EXPECT_EQ(test, fn(__VA_ARGS__), 0)
+#define STRCMP_TEST_EXPECT_LOWER(test, fn, ...) KUNIT_EXPECT_LT(test, fn(__VA_ARGS__), 0)
+#define STRCMP_TEST_EXPECT_GREATER(test, fn, ...) KUNIT_EXPECT_GT(test, fn(__VA_ARGS__), 0)
+
 static void test_memset16(struct kunit *test)
 {
 	unsigned i, j, k;
@@ -179,6 +185,147 @@ static void test_strspn(struct kunit *test)
 	}
 }
 
+static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
+static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
+
+static void strcmp_fill_buffers(char fill1, char fill2)
+{
+	memset(strcmp_buffer1, fill1, STRCMP_LARGE_BUF_LEN);
+	memset(strcmp_buffer2, fill2, STRCMP_LARGE_BUF_LEN);
+	strcmp_buffer1[STRCMP_LARGE_BUF_LEN - 1] = 0;
+	strcmp_buffer2[STRCMP_LARGE_BUF_LEN - 1] = 0;
+}
+
+static void test_strcmp(struct kunit *test)
+{
+	/* Equal strings */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, "Hello, Kernel!", "Hello, Kernel!");
+	/* First string is lexicographically less than the second */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Hello, KUnit!", "Hello, Kernel!");
+	/* First string is lexicographically larger than the second */
+	STRCMP_TEST_EXPECT_GREATER(test, strcmp, "Hello, Kernel!", "Hello, KUnit!");
+	/* Empty string is always lexicographically less than any non-empty string */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "", "Non-empty string");
+	/* Two empty strings should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, "", "");
+	/* Compare two strings which have only one char difference */
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Abacaba", "Abadaba");
+	/* Compare two strings which have the same prefix*/
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, "Just a string", "Just a string and something else");
+}
+
+static void test_strcmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcmp, strcmp_buffer1, strcmp_buffer2);
+}
+
+static void test_strncmp(struct kunit *test)
+{
+	/* Equal strings */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Hello, KUnit!", "Hello, KUnit!", 13);
+	/* First string is lexicographically less than the second */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Hello, KUnit!", "Hello, Kernel!", 13);
+	/* Result is always 'equal' when count = 0 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Hello, Kernel!", "Hello, KUnit!", 0);
+	/* Strings with common prefix are equal if count = length of prefix */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Abacaba", "Abadaba", 3);
+	/* Strings with common prefix are not equal when count = length of prefix + 1 */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Abacaba", "Abadaba", 4);
+	/* If one string is a prefix of another, the shorter string is lexicographically smaller */
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, "Just a string", "Just a string and something else",
+				 strlen("Just a string and something else"));
+	/*
+	 * If one string is a prefix of another, and we check first length
+	 * of prefix chars, the result is 'equal'
+	 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, "Just a string", "Just a string and something else",
+				 strlen("Just a string"));
+}
+
+static void test_strncmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('B', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'A';
+	STRCMP_TEST_EXPECT_LOWER(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+	/* the strings are equal up to STRCMP_CHANGE_POINT */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
+}
+
+static void test_strcasecmp(struct kunit *test)
+{
+	/* Same strings in different case should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "Hello, Kernel!", "HeLLO, KErNeL!");
+	/* Empty strings should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "", "");
+	/* Despite ascii code for 'a' is larger than ascii code for 'B', 'a' < 'B' */
+	STRCMP_TEST_EXPECT_LOWER(test, strcasecmp, "a", "B");
+	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, "B", "a");
+	/* Special symbols and numbers should be processed correctly */
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, "-+**.1230ghTTT~^", "-+**.1230Ghttt~^");
+}
+
+static void test_strcasecmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strcasecmp, strcmp_buffer1, strcmp_buffer2);
+}
+
+static void test_strncasecmp(struct kunit *test)
+{
+	/* Same strings in different case should be equal */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "AbAcAbA", "Abacaba", strlen("Abacaba"));
+	/* strncasecmp should check 'count' chars only */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "AbaCaBa", "abaCaDa", 5);
+	STRCMP_TEST_EXPECT_LOWER(test, strncasecmp, "a", "B", 1);
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, "B", "a", 1);
+	/* Result is always 'equal' when count = 0 */
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, "Abacaba", "Not abacaba", 0);
+}
+
+static void test_strncasecmp_long_strings(struct kunit *test)
+{
+	strcmp_fill_buffers('b', 'B');
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'a';
+	STRCMP_TEST_EXPECT_LOWER(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	strcmp_buffer1[STRCMP_CHANGE_POINT] = 'C';
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_LARGE_BUF_LEN);
+
+	STRCMP_TEST_EXPECT_EQUAL(test, strncasecmp, strcmp_buffer1,
+				 strcmp_buffer2, STRCMP_CHANGE_POINT);
+	STRCMP_TEST_EXPECT_GREATER(test, strncasecmp, strcmp_buffer1,
+				   strcmp_buffer2, STRCMP_CHANGE_POINT + 1);
+}
+
 static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_memset16),
 	KUNIT_CASE(test_memset32),
@@ -186,6 +333,14 @@ static struct kunit_case string_test_cases[] = {
 	KUNIT_CASE(test_strchr),
 	KUNIT_CASE(test_strnchr),
 	KUNIT_CASE(test_strspn),
+	KUNIT_CASE(test_strcmp),
+	KUNIT_CASE(test_strcmp_long_strings),
+	KUNIT_CASE(test_strncmp),
+	KUNIT_CASE(test_strncmp_long_strings),
+	KUNIT_CASE(test_strcasecmp),
+	KUNIT_CASE(test_strcasecmp_long_strings),
+	KUNIT_CASE(test_strncasecmp),
+	KUNIT_CASE(test_strncasecmp_long_strings),
 	{}
 };
 
diff --git a/lib/strscpy_kunit.c b/lib/strscpy_kunit.c
index a6b6344354ed..b6d1d93a8883 100644
--- a/lib/strscpy_kunit.c
+++ b/lib/strscpy_kunit.c
@@ -8,22 +8,23 @@
 #include <kunit/test.h>
 #include <linux/string.h>
 
-/*
- * tc() - Run a specific test case.
+/**
+ * strscpy_check() - Run a specific test case.
+ * @test: KUnit test context pointer
  * @src: Source string, argument to strscpy_pad()
  * @count: Size of destination buffer, argument to strscpy_pad()
  * @expected: Expected return value from call to strscpy_pad()
- * @terminator: 1 if there should be a terminating null byte 0 otherwise.
  * @chars: Number of characters from the src string expected to be
  *         written to the dst buffer.
+ * @terminator: 1 if there should be a terminating null byte 0 otherwise.
  * @pad: Number of pad characters expected (in the tail of dst buffer).
  *       (@pad does not include the null terminator byte.)
  *
  * Calls strscpy_pad() and verifies the return value and state of the
  * destination buffer after the call returns.
  */
-static void tc(struct kunit *test, char *src, int count, int expected,
-	       int chars, int terminator, int pad)
+static void strscpy_check(struct kunit *test, char *src, int count,
+			  int expected, int chars, int terminator, int pad)
 {
 	int nr_bytes_poison;
 	int max_expected;
@@ -79,12 +80,12 @@ static void tc(struct kunit *test, char *src, int count, int expected,
 	}
 }
 
-static void strscpy_test(struct kunit *test)
+static void test_strscpy(struct kunit *test)
 {
 	char dest[8];
 
 	/*
-	 * tc() uses a destination buffer of size 6 and needs at
+	 * strscpy_check() uses a destination buffer of size 6 and needs at
 	 * least 2 characters spare (one for null and one to check for
 	 * overflow).  This means we should only call tc() with
 	 * strings up to a maximum of 4 characters long and 'count'
@@ -92,27 +93,27 @@ static void strscpy_test(struct kunit *test)
 	 * the buffer size in tc().
 	 */
 
-	/* tc(test, src, count, expected, chars, terminator, pad) */
-	tc(test, "a", 0, -E2BIG, 0, 0, 0);
-	tc(test, "",  0, -E2BIG, 0, 0, 0);
+	/* strscpy_check(test, src, count, expected, chars, terminator, pad) */
+	strscpy_check(test, "a", 0, -E2BIG, 0, 0, 0);
+	strscpy_check(test, "",  0, -E2BIG, 0, 0, 0);
 
-	tc(test, "a", 1, -E2BIG, 0, 1, 0);
-	tc(test, "",  1, 0,	 0, 1, 0);
+	strscpy_check(test, "a", 1, -E2BIG, 0, 1, 0);
+	strscpy_check(test, "",  1, 0,	 0, 1, 0);
 
-	tc(test, "ab", 2, -E2BIG, 1, 1, 0);
-	tc(test, "a",  2, 1,	  1, 1, 0);
-	tc(test, "",   2, 0,	  0, 1, 1);
+	strscpy_check(test, "ab", 2, -E2BIG, 1, 1, 0);
+	strscpy_check(test, "a",  2, 1,	  1, 1, 0);
+	strscpy_check(test, "",   2, 0,	  0, 1, 1);
 
-	tc(test, "abc", 3, -E2BIG, 2, 1, 0);
-	tc(test, "ab",  3, 2,	   2, 1, 0);
-	tc(test, "a",   3, 1,	   1, 1, 1);
-	tc(test, "",    3, 0,	   0, 1, 2);
+	strscpy_check(test, "abc", 3, -E2BIG, 2, 1, 0);
+	strscpy_check(test, "ab",  3, 2,	   2, 1, 0);
+	strscpy_check(test, "a",   3, 1,	   1, 1, 1);
+	strscpy_check(test, "",    3, 0,	   0, 1, 2);
 
-	tc(test, "abcd", 4, -E2BIG, 3, 1, 0);
-	tc(test, "abc",  4, 3,	    3, 1, 0);
-	tc(test, "ab",   4, 2,	    2, 1, 1);
-	tc(test, "a",    4, 1,	    1, 1, 2);
-	tc(test, "",     4, 0,	    0, 1, 3);
+	strscpy_check(test, "abcd", 4, -E2BIG, 3, 1, 0);
+	strscpy_check(test, "abc",  4, 3,	    3, 1, 0);
+	strscpy_check(test, "ab",   4, 2,	    2, 1, 1);
+	strscpy_check(test, "a",    4, 1,	    1, 1, 2);
+	strscpy_check(test, "",     4, 0,	    0, 1, 3);
 
 	/* Compile-time-known source strings. */
 	KUNIT_EXPECT_EQ(test, strscpy(dest, "", ARRAY_SIZE(dest)), 0);
@@ -127,7 +128,7 @@ static void strscpy_test(struct kunit *test)
 }
 
 static struct kunit_case strscpy_test_cases[] = {
-	KUNIT_CASE(strscpy_test),
+	KUNIT_CASE(test_strscpy),
 	{}
 };
 
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 294cb9efe3d3..015fb679be42 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -345,7 +345,7 @@ static netdev_tx_t clip_start_xmit(struct sk_buff *skb,
 		dev->stats.tx_dropped++;
 		return NETDEV_TX_OK;
 	}
-	rt = (struct rtable *) dst;
+	rt = dst_rtable(dst);
 	if (rt->rt_gw_family == AF_INET)
 		daddr = &rt->rt_gw4;
 	else
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 27520a8a486f..50cfec8ccac4 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -133,7 +133,7 @@ static inline struct lowpan_peer *peer_lookup_dst(struct lowpan_btle_dev *dev,
 						  struct in6_addr *daddr,
 						  struct sk_buff *skb)
 {
-	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
+	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 	int count = atomic_read(&dev->peer_count);
 	const struct in6_addr *nexthop;
 	struct lowpan_peer *peer;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cce73749f2dc..1ed734a7fb31 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1,7 +1,7 @@
 /*
    BlueZ - Bluetooth protocol stack for Linux
    Copyright (c) 2000-2001, 2010, Code Aurora Forum. All rights reserved.
-   Copyright 2023 NXP
+   Copyright 2023-2024 NXP
 
    Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
 
@@ -6359,14 +6359,16 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	if (!(flags & HCI_PROTO_DEFER))
 		goto unlock;
 
-	if (ev->status) {
-		/* Add connection to indicate the failed PA sync event */
-		pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
-					     HCI_ROLE_SLAVE);
+	/* Add connection to indicate PA sync event */
+	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
+				     HCI_ROLE_SLAVE);
 
-		if (!pa_sync)
-			goto unlock;
+	if (IS_ERR(pa_sync))
+		goto unlock;
+
+	pa_sync->sync_handle = le16_to_cpu(ev->handle);
 
+	if (ev->status) {
 		set_bit(HCI_CONN_PA_SYNC_FAILED, &pa_sync->flags);
 
 		/* Notify iso layer */
@@ -6383,6 +6385,7 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
 	struct hci_ev_le_per_adv_report *ev = data;
 	int mask = hdev->link_mode;
 	__u8 flags = 0;
+	struct hci_conn *pa_sync;
 
 	bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->sync_handle));
 
@@ -6390,8 +6393,28 @@ static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void *data,
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
 	if (!(mask & HCI_LM_ACCEPT))
-		hci_le_pa_term_sync(hdev, ev->sync_handle);
+		goto unlock;
+
+	if (!(flags & HCI_PROTO_DEFER))
+		goto unlock;
+
+	pa_sync = hci_conn_hash_lookup_pa_sync_handle
+			(hdev,
+			le16_to_cpu(ev->sync_handle));
 
+	if (!pa_sync)
+		goto unlock;
+
+	if (ev->data_status == LE_PA_DATA_COMPLETE &&
+	    !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags)) {
+		/* Notify iso layer */
+		hci_connect_cfm(pa_sync, 0);
+
+		/* Notify MGMT layer */
+		mgmt_device_connected(hdev, pa_sync, NULL, 0);
+	}
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -6926,10 +6949,8 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	hci_dev_lock(hdev);
 
 	mask |= hci_proto_connect_ind(hdev, BDADDR_ANY, ISO_LINK, &flags);
-	if (!(mask & HCI_LM_ACCEPT)) {
-		hci_le_pa_term_sync(hdev, ev->sync_handle);
+	if (!(mask & HCI_LM_ACCEPT))
 		goto unlock;
-	}
 
 	if (!(flags & HCI_PROTO_DEFER))
 		goto unlock;
@@ -6938,24 +6959,11 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 			(hdev,
 			le16_to_cpu(ev->sync_handle));
 
-	if (pa_sync)
-		goto unlock;
-
-	/* Add connection to indicate the PA sync event */
-	pa_sync = hci_conn_add_unset(hdev, ISO_LINK, BDADDR_ANY,
-				     HCI_ROLE_SLAVE);
-
 	if (IS_ERR(pa_sync))
 		goto unlock;
 
-	pa_sync->sync_handle = le16_to_cpu(ev->sync_handle);
-	set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags);
-
 	/* Notify iso layer */
-	hci_connect_cfm(pa_sync, 0x00);
-
-	/* Notify MGMT layer */
-	mgmt_device_connected(hdev, pa_sync, NULL, 0);
+	hci_connect_cfm(pa_sync, 0);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6cb41f9d174e..00c0d8413c63 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -54,7 +54,6 @@ static void iso_sock_kill(struct sock *sk);
 enum {
 	BT_SK_BIG_SYNC,
 	BT_SK_PA_SYNC,
-	BT_SK_PA_SYNC_TERM,
 };
 
 struct iso_pinfo {
@@ -81,6 +80,7 @@ static bool check_ucast_qos(struct bt_iso_qos *qos);
 static bool check_bcast_qos(struct bt_iso_qos *qos);
 static bool iso_match_sid(struct sock *sk, void *data);
 static bool iso_match_sync_handle(struct sock *sk, void *data);
+static bool iso_match_sync_handle_pa_report(struct sock *sk, void *data);
 static void iso_sock_disconn(struct sock *sk);
 
 typedef bool (*iso_sock_match_t)(struct sock *sk, void *data);
@@ -197,21 +197,10 @@ static void iso_chan_del(struct sock *sk, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 }
 
-static bool iso_match_conn_sync_handle(struct sock *sk, void *data)
-{
-	struct hci_conn *hcon = data;
-
-	if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
-		return false;
-
-	return hcon->sync_handle == iso_pi(sk)->sync_handle;
-}
-
 static void iso_conn_del(struct hci_conn *hcon, int err)
 {
 	struct iso_conn *conn = hcon->iso_data;
 	struct sock *sk;
-	struct sock *parent;
 
 	if (!conn)
 		return;
@@ -227,26 +216,6 @@ static void iso_conn_del(struct hci_conn *hcon, int err)
 
 	if (sk) {
 		lock_sock(sk);
-
-		/* While a PA sync hcon is in the process of closing,
-		 * mark parent socket with a flag, so that any residual
-		 * BIGInfo adv reports that arrive before PA sync is
-		 * terminated are not processed anymore.
-		 */
-		if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
-			parent = iso_get_sock(&hcon->src,
-					      &hcon->dst,
-					      BT_LISTEN,
-					      iso_match_conn_sync_handle,
-					      hcon);
-
-			if (parent) {
-				set_bit(BT_SK_PA_SYNC_TERM,
-					&iso_pi(parent)->flags);
-				sock_put(parent);
-			}
-		}
-
 		iso_sock_clear_timer(sk);
 		iso_chan_del(sk, err);
 		release_sock(sk);
@@ -860,6 +829,7 @@ static struct sock *iso_sock_alloc(struct net *net, struct socket *sock,
 	iso_pi(sk)->src_type = BDADDR_LE_PUBLIC;
 
 	iso_pi(sk)->qos = default_qos;
+	iso_pi(sk)->sync_handle = -1;
 
 	bt_sock_link(&iso_sk_list, sk);
 	return sk;
@@ -907,7 +877,6 @@ static int iso_sock_bind_bc(struct socket *sock, struct sockaddr *addr,
 		return -EINVAL;
 
 	iso_pi(sk)->dst_type = sa->iso_bc->bc_bdaddr_type;
-	iso_pi(sk)->sync_handle = -1;
 
 	if (sa->iso_bc->bc_sid > 0x0f)
 		return -EINVAL;
@@ -984,7 +953,8 @@ static int iso_sock_bind(struct socket *sock, struct sockaddr *addr,
 	/* Allow the user to bind a PA sync socket to a number
 	 * of BISes to sync to.
 	 */
-	if (sk->sk_state == BT_CONNECT2 &&
+	if ((sk->sk_state == BT_CONNECT2 ||
+	     sk->sk_state == BT_CONNECTED) &&
 	    test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
 		err = iso_sock_bind_pa_sk(sk, sa, addr_len);
 		goto done;
@@ -1396,6 +1366,16 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 			}
 			release_sock(sk);
 			return 0;
+		case BT_CONNECTED:
+			if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
+				iso_conn_big_sync(sk);
+				sk->sk_state = BT_LISTEN;
+				release_sock(sk);
+				return 0;
+			}
+
+			release_sock(sk);
+			break;
 		case BT_CONNECT:
 			release_sock(sk);
 			return iso_connect_cis(sk);
@@ -1541,7 +1521,9 @@ static int iso_sock_setsockopt(struct socket *sock, int level, int optname,
 
 	case BT_ISO_QOS:
 		if (sk->sk_state != BT_OPEN && sk->sk_state != BT_BOUND &&
-		    sk->sk_state != BT_CONNECT2) {
+		    sk->sk_state != BT_CONNECT2 &&
+		    (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags) ||
+		    sk->sk_state != BT_CONNECTED)) {
 			err = -EINVAL;
 			break;
 		}
@@ -1762,7 +1744,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 	struct sock *sk = conn->sk;
 	struct hci_ev_le_big_sync_estabilished *ev = NULL;
 	struct hci_ev_le_pa_sync_established *ev2 = NULL;
-	struct hci_evt_le_big_info_adv_report *ev3 = NULL;
+	struct hci_ev_le_per_adv_report *ev3 = NULL;
 	struct hci_conn *hcon;
 
 	BT_DBG("conn %p", conn);
@@ -1799,12 +1781,12 @@ static void iso_conn_ready(struct iso_conn *conn)
 						      iso_match_sid, ev2);
 		} else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
 			ev3 = hci_recv_event_data(hcon->hdev,
-						  HCI_EVT_LE_BIG_INFO_ADV_REPORT);
+						  HCI_EV_LE_PER_ADV_REPORT);
 			if (ev3)
 				parent = iso_get_sock(&hcon->src,
 						      &hcon->dst,
 						      BT_LISTEN,
-						      iso_match_sync_handle,
+						      iso_match_sync_handle_pa_report,
 						      ev3);
 		}
 
@@ -1847,7 +1829,6 @@ static void iso_conn_ready(struct iso_conn *conn)
 
 		if (ev3) {
 			iso_pi(sk)->qos = iso_pi(parent)->qos;
-			iso_pi(sk)->qos.bcast.encryption = ev3->encryption;
 			hcon->iso_qos = iso_pi(sk)->qos;
 			iso_pi(sk)->bc_num_bis = iso_pi(parent)->bc_num_bis;
 			memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis, ISO_MAX_NUM_BIS);
@@ -1941,26 +1922,29 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 	ev2 = hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT);
 	if (ev2) {
-		/* Try to get PA sync listening socket, if it exists */
-		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
-				  iso_match_pa_sync_flag, NULL);
-
-		if (!sk) {
-			sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_LISTEN,
-					  iso_match_sync_handle, ev2);
-
-			/* If PA Sync is in process of terminating,
-			 * do not handle any more BIGInfo adv reports.
-			 */
-
-			if (sk && test_bit(BT_SK_PA_SYNC_TERM,
-					   &iso_pi(sk)->flags))
-				return 0;
+		/* Check if BIGInfo report has already been handled */
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECTED,
+				  iso_match_sync_handle, ev2);
+		if (sk) {
+			sock_put(sk);
+			sk = NULL;
+			goto done;
 		}
 
+		/* Try to get PA sync socket, if it exists */
+		sk = iso_get_sock(&hdev->bdaddr, bdaddr, BT_CONNECT2,
+				  iso_match_sync_handle, ev2);
+		if (!sk)
+			sk = iso_get_sock(&hdev->bdaddr, bdaddr,
+					  BT_LISTEN,
+					  iso_match_sync_handle,
+					  ev2);
+
 		if (sk) {
 			int err;
 
+			iso_pi(sk)->qos.bcast.encryption = ev2->encryption;
+
 			if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
 				iso_pi(sk)->bc_num_bis = ev2->num_bis;
 
@@ -1979,6 +1963,8 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 				}
 			}
 		}
+
+		goto done;
 	}
 
 	ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index 0ccfd5fa5cb9..0c0bdb058c5b 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -83,7 +83,7 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
 		return NULL;
 
 	*saddr = idst->in_saddr.s_addr;
-	return container_of(dst, struct rtable, dst);
+	return dst_rtable(dst);
 }
 EXPORT_SYMBOL_GPL(dst_cache_get_ip4);
 
@@ -112,7 +112,7 @@ void dst_cache_set_ip6(struct dst_cache *dst_cache, struct dst_entry *dst,
 
 	idst = this_cpu_ptr(dst_cache->cache);
 	dst_cache_per_cpu_dst_set(this_cpu_ptr(dst_cache->cache), dst,
-				  rt6_get_cookie((struct rt6_info *)dst));
+				  rt6_get_cookie(dst_rt6_info(dst)));
 	idst->in6_saddr = *saddr;
 }
 EXPORT_SYMBOL_GPL(dst_cache_set_ip6);
diff --git a/net/core/filter.c b/net/core/filter.c
index ae5254f712c9..a5856a8b4498 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2215,7 +2215,7 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 	rcu_read_lock();
 	if (!nh) {
 		dst = skb_dst(skb);
-		nexthop = rt6_nexthop(container_of(dst, struct rt6_info, dst),
+		nexthop = rt6_nexthop(dst_rt6_info(dst),
 				      &ipv6_hdr(skb)->daddr);
 	} else {
 		nexthop = &nh->ipv6_nh;
@@ -2314,8 +2314,7 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 	rcu_read_lock();
 	if (!nh) {
-		struct dst_entry *dst = skb_dst(skb);
-		struct rtable *rt = container_of(dst, struct rtable, dst);
+		struct rtable *rt = skb_rtable(skb);
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 049c3adeb850..4e3651101b86 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -161,9 +161,7 @@ __be16 eth_type_trans(struct sk_buff *skb, struct net_device *dev)
 	skb->dev = dev;
 	skb_reset_mac_header(skb);
 
-	eth = (struct ethhdr *)skb->data;
-	skb_pull_inline(skb, ETH_HLEN);
-
+	eth = eth_skb_pull_mac(skb);
 	eth_skb_pkt_type(skb, dev);
 
 	/*
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fafb123f798b..5622ddd3bf55 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -758,7 +758,9 @@ void __inet_accept(struct socket *sock, struct socket *newsock, struct sock *new
 	sock_rps_record_flow(newsk);
 	WARN_ON(!((1 << newsk->sk_state) &
 		  (TCPF_ESTABLISHED | TCPF_SYN_RECV |
-		  TCPF_CLOSE_WAIT | TCPF_CLOSE)));
+		   TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 |
+		   TCPF_CLOSING | TCPF_CLOSE_WAIT |
+		   TCPF_CLOSE)));
 
 	if (test_bit(SOCK_SUPPORT_ZC, &sock->flags))
 		set_bit(SOCK_SUPPORT_ZC, &newsock->flags);
@@ -1306,8 +1308,8 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 
 int inet_sk_rebuild_header(struct sock *sk)
 {
+	struct rtable *rt = dst_rtable(__sk_dst_check(sk, 0));
 	struct inet_sock *inet = inet_sk(sk);
-	struct rtable *rt = (struct rtable *)__sk_dst_check(sk, 0);
 	__be32 daddr;
 	struct ip_options_rcu *inet_opt;
 	struct flowi4 *fl4;
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7e45c34c8340..8382cc998bff 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1882,10 +1882,11 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 			goto done;
 
 		if (fillargs.ifindex) {
-			err = -ENODEV;
 			dev = dev_get_by_index_rcu(tgt_net, fillargs.ifindex);
-			if (!dev)
+			if (!dev) {
+				err = -ENODEV;
 				goto done;
+			}
 			in_dev = __in_dev_get_rcu(dev);
 			if (!in_dev)
 				goto done;
@@ -1897,7 +1898,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 
 	cb->seq = inet_base_seq(tgt_net);
 
-	for_each_netdev_dump(net, dev, ctx->ifindex) {
+	for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
 		in_dev = __in_dev_get_rcu(dev);
 		if (!in_dev)
 			continue;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 437e782b9663..207482d30dc7 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -483,6 +483,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 					struct icmp_bxm *param)
 {
 	struct net_device *route_lookup_dev;
+	struct dst_entry *dst, *dst2;
 	struct rtable *rt, *rt2;
 	struct flowi4 fl4_dec;
 	int err;
@@ -508,16 +509,17 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	/* No need to clone since we're just using its address. */
 	rt2 = rt;
 
-	rt = (struct rtable *) xfrm_lookup(net, &rt->dst,
-					   flowi4_to_flowi(fl4), NULL, 0);
-	if (!IS_ERR(rt)) {
+	dst = xfrm_lookup(net, &rt->dst,
+			  flowi4_to_flowi(fl4), NULL, 0);
+	rt = dst_rtable(dst);
+	if (!IS_ERR(dst)) {
 		if (rt != rt2)
 			return rt;
-	} else if (PTR_ERR(rt) == -EPERM) {
+	} else if (PTR_ERR(dst) == -EPERM) {
 		rt = NULL;
-	} else
+	} else {
 		return rt;
-
+	}
 	err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
 	if (err)
 		goto relookup_failed;
@@ -551,19 +553,19 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	if (err)
 		goto relookup_failed;
 
-	rt2 = (struct rtable *) xfrm_lookup(net, &rt2->dst,
-					    flowi4_to_flowi(&fl4_dec), NULL,
-					    XFRM_LOOKUP_ICMP);
-	if (!IS_ERR(rt2)) {
+	dst2 = xfrm_lookup(net, &rt2->dst, flowi4_to_flowi(&fl4_dec), NULL,
+			   XFRM_LOOKUP_ICMP);
+	rt2 = dst_rtable(dst2);
+	if (!IS_ERR(dst2)) {
 		dst_release(&rt->dst);
 		memcpy(fl4, &fl4_dec, sizeof(*fl4));
 		rt = rt2;
-	} else if (PTR_ERR(rt2) == -EPERM) {
+	} else if (PTR_ERR(dst2) == -EPERM) {
 		if (rt)
 			dst_release(&rt->dst);
 		return rt2;
 	} else {
-		err = PTR_ERR(rt2);
+		err = PTR_ERR(dst2);
 		goto relookup_failed;
 	}
 	return rt;
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 5e9c8156656a..d6fbcbd2358a 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -616,7 +616,7 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
 			hint = ip_extract_route_hint(net, skb,
-					       ((struct rtable *)dst)->rt_type);
+						     dst_rtable(dst)->rt_type);
 
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 39229fd0601a..9500031a1f55 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -198,7 +198,7 @@ EXPORT_SYMBOL_GPL(ip_build_and_send_pkt);
 static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct net_device *dev = dst->dev;
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
@@ -475,7 +475,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 		goto packet_routed;
 
 	/* Make sure we can route this packet. */
-	rt = (struct rtable *)__sk_dst_check(sk, 0);
+	rt = dst_rtable(__sk_dst_check(sk, 0));
 	if (!rt) {
 		__be32 daddr;
 
@@ -971,7 +971,7 @@ static int __ip_append_data(struct sock *sk,
 	bool zc = false;
 	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
 	int csummode = CHECKSUM_NONE;
-	struct rtable *rt = (struct rtable *)cork->dst;
+	struct rtable *rt = dst_rtable(cork->dst);
 	bool paged, hold_tskey, extra_uref = false;
 	unsigned int wmem_alloc_delta = 0;
 	u32 tskey = 0;
@@ -1390,7 +1390,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ip_options *opt = NULL;
-	struct rtable *rt = (struct rtable *)cork->dst;
+	struct rtable *rt = dst_rtable(cork->dst);
 	struct iphdr *iph;
 	u8 pmtudisc, ttl;
 	__be16 df = 0;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 1b8d8ff9a237..0e4bd528428e 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -543,7 +543,7 @@ static int tnl_update_pmtu(struct net_device *dev, struct sk_buff *skb,
 		struct rt6_info *rt6;
 		__be32 daddr;
 
-		rt6 = skb_valid_dst(skb) ? (struct rt6_info *)skb_dst(skb) :
+		rt6 = skb_valid_dst(skb) ? dst_rt6_info(skb_dst(skb)) :
 					   NULL;
 		daddr = md ? dst : tunnel->parms.iph.daddr;
 
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
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b814fdab19f7..3fcf084fbda5 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -132,7 +132,8 @@ struct dst_entry	*ipv4_dst_check(struct dst_entry *dst, u32 cookie);
 static unsigned int	 ipv4_default_advmss(const struct dst_entry *dst);
 INDIRECT_CALLABLE_SCOPE
 unsigned int		ipv4_mtu(const struct dst_entry *dst);
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst);
+static void		ipv4_negative_advice(struct sock *sk,
+					     struct dst_entry *dst);
 static void		 ipv4_link_failure(struct sk_buff *skb);
 static void		 ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 					   struct sk_buff *skb, u32 mtu,
@@ -831,28 +832,21 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 	u32 mark = skb->mark;
 	__u8 tos = iph->tos;
 
-	rt = (struct rtable *) dst;
+	rt = dst_rtable(dst);
 
 	__build_flow_key(net, &fl4, sk, iph, oif, tos, prot, mark, 0);
 	__ip_do_redirect(rt, skb, &fl4, true);
 }
 
-static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
+static void ipv4_negative_advice(struct sock *sk,
+				 struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *)dst;
-	struct dst_entry *ret = dst;
+	struct rtable *rt = dst_rtable(dst);
 
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
@@ -1056,7 +1050,7 @@ static void ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			      struct sk_buff *skb, u32 mtu,
 			      bool confirm_neigh)
 {
-	struct rtable *rt = (struct rtable *) dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct flowi4 fl4;
 
 	ip_rt_build_flow_key(&fl4, sk, skb);
@@ -1127,7 +1121,7 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 
 	__build_flow_key(net, &fl4, sk, iph, 0, 0, 0, 0, 0);
 
-	rt = (struct rtable *)odst;
+	rt = dst_rtable(odst);
 	if (odst->obsolete && !odst->ops->check(odst, 0)) {
 		rt = ip_route_output_flow(sock_net(sk), &fl4, sk);
 		if (IS_ERR(rt))
@@ -1136,7 +1130,7 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 		new = true;
 	}
 
-	__ip_rt_update_pmtu((struct rtable *)xfrm_dst_path(&rt->dst), &fl4, mtu);
+	__ip_rt_update_pmtu(dst_rtable(xfrm_dst_path(&rt->dst)), &fl4, mtu);
 
 	if (!dst_check(&rt->dst, 0)) {
 		if (new)
@@ -1193,7 +1187,7 @@ EXPORT_SYMBOL_GPL(ipv4_sk_redirect);
 INDIRECT_CALLABLE_SCOPE struct dst_entry *ipv4_dst_check(struct dst_entry *dst,
 							 u32 cookie)
 {
-	struct rtable *rt = (struct rtable *) dst;
+	struct rtable *rt = dst_rtable(dst);
 
 	/* All IPV4 dsts are created with ->obsolete set to the value
 	 * DST_OBSOLETE_FORCE_CHK which forces validation calls down
@@ -1528,10 +1522,8 @@ void rt_del_uncached_list(struct rtable *rt)
 
 static void ipv4_dst_destroy(struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *)dst;
-
 	ip_dst_metrics_put(dst);
-	rt_del_uncached_list(rt);
+	rt_del_uncached_list(dst_rtable(dst));
 }
 
 void rt_flush_dev(struct net_device *dev)
@@ -2832,7 +2824,7 @@ static struct dst_ops ipv4_dst_blackhole_ops = {
 
 struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
-	struct rtable *ort = (struct rtable *) dst_orig;
+	struct rtable *ort = dst_rtable(dst_orig);
 	struct rtable *rt;
 
 	rt = dst_alloc(&ipv4_dst_blackhole_ops, NULL, DST_OBSOLETE_DEAD, 0);
@@ -2877,9 +2869,9 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 
 	if (flp4->flowi4_proto) {
 		flp4->flowi4_oif = rt->dst.dev->ifindex;
-		rt = (struct rtable *)xfrm_lookup_route(net, &rt->dst,
-							flowi4_to_flowi(flp4),
-							sk, 0);
+		rt = dst_rtable(xfrm_lookup_route(net, &rt->dst,
+						  flowi4_to_flowi(flp4),
+						  sk, 0));
 	}
 
 	return rt;
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index e33fbe4933e4..b004280855f8 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -58,7 +58,18 @@ struct dctcp {
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
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index b5ad0c527c52..72d3bf136810 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1218,7 +1218,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	if (connected)
-		rt = (struct rtable *)sk_dst_check(sk, 0);
+		rt = dst_rtable(sk_dst_check(sk, 0));
 
 	if (!rt) {
 		struct net *net = sock_net(sk);
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index c33bca2c3841..1853a8415d9f 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -69,7 +69,7 @@ static int xfrm4_get_saddr(struct net *net, int oif,
 static int xfrm4_fill_dst(struct xfrm_dst *xdst, struct net_device *dev,
 			  const struct flowi *fl)
 {
-	struct rtable *rt = (struct rtable *)xdst->route;
+	struct rtable *rt = dst_rtable(xdst->route);
 	const struct flowi4 *fl4 = &fl->u.ip4;
 
 	xdst->u.rt.rt_iif = fl4->flowi4_iif;
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 1635da07285f..d285c1f6f1a6 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -212,7 +212,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	} else if (dst->dev && (dst->dev->flags&IFF_LOOPBACK)) {
 		res = true;
 	} else {
-		struct rt6_info *rt = (struct rt6_info *)dst;
+		struct rt6_info *rt = dst_rt6_info(dst);
 		int tmo = net->ipv6.sysctl.icmpv6_time;
 		struct inet_peer *peer;
 
@@ -241,7 +241,7 @@ static bool icmpv6_rt_has_prefsrc(struct sock *sk, u8 type,
 
 	dst = ip6_route_output(net, sk, fl6);
 	if (!dst->error) {
-		struct rt6_info *rt = (struct rt6_info *)dst;
+		struct rt6_info *rt = dst_rt6_info(dst);
 		struct in6_addr prefsrc;
 
 		rt6_get_prefsrc(rt, &prefsrc);
@@ -616,7 +616,7 @@ void icmp6_send(struct sk_buff *skb, u8 type, u8 code, __u32 info,
 	if (ip6_append_data(sk, icmpv6_getfrag, &msg,
 			    len + sizeof(struct icmp6hdr),
 			    sizeof(struct icmp6hdr),
-			    &ipc6, &fl6, (struct rt6_info *)dst,
+			    &ipc6, &fl6, dst_rt6_info(dst),
 			    MSG_DONTWAIT)) {
 		ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTERRORS);
 		ip6_flush_pending_frames(sk);
@@ -803,7 +803,7 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
 	if (ip6_append_data(sk, icmpv6_getfrag, &msg,
 			    skb->len + sizeof(struct icmp6hdr),
 			    sizeof(struct icmp6hdr), &ipc6, &fl6,
-			    (struct rt6_info *)dst, MSG_DONTWAIT)) {
+			    dst_rt6_info(dst), MSG_DONTWAIT)) {
 		__ICMP6_INC_STATS(net, idev, ICMP6_MIB_OUTERRORS);
 		ip6_flush_pending_frames(sk);
 	} else {
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 8c1ce78956ba..0601bad79822 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -38,7 +38,7 @@ static inline struct ila_params *ila_params_lwtunnel(
 static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *orig_dst = skb_dst(skb);
-	struct rt6_info *rt = (struct rt6_info *)orig_dst;
+	struct rt6_info *rt = dst_rt6_info(orig_dst);
 	struct ila_lwt *ilwt = ila_lwt_lwtunnel(orig_dst->lwtstate);
 	struct dst_entry *dst;
 	int err = -EINVAL;
@@ -70,7 +70,7 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		memset(&fl6, 0, sizeof(fl6));
 		fl6.flowi6_oif = orig_dst->dev->ifindex;
 		fl6.flowi6_iif = LOOPBACK_IFINDEX;
-		fl6.daddr = *rt6_nexthop((struct rt6_info *)orig_dst,
+		fl6.daddr = *rt6_nexthop(dst_rt6_info(orig_dst),
 					 &ip6h->daddr);
 
 		dst = ip6_route_output(net, NULL, &fl6);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 97b0788b31ba..27d8725445e3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -120,7 +120,7 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
 
 	rcu_read_lock();
-	nexthop = rt6_nexthop((struct rt6_info *)dst, daddr);
+	nexthop = rt6_nexthop(dst_rt6_info(dst), daddr);
 	neigh = __ipv6_neigh_lookup_noref(dev, nexthop);
 
 	if (unlikely(IS_ERR_OR_NULL(neigh))) {
@@ -599,7 +599,7 @@ int ip6_forward(struct sk_buff *skb)
 		 *	send a redirect.
 		 */
 
-		rt = (struct rt6_info *) dst;
+		rt = dst_rt6_info(dst);
 		if (rt->rt6i_flags & RTF_GATEWAY)
 			target = &rt->rt6i_gateway;
 		else
@@ -856,7 +856,7 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 		 int (*output)(struct net *, struct sock *, struct sk_buff *))
 {
 	struct sk_buff *frag;
-	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
+	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 	struct ipv6_pinfo *np = skb->sk && !dev_recursion_level() ?
 				inet6_sk(skb->sk) : NULL;
 	bool mono_delivery_time = skb->mono_delivery_time;
@@ -1063,7 +1063,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 		return NULL;
 	}
 
-	rt = (struct rt6_info *)dst;
+	rt = dst_rt6_info(dst);
 	/* Yes, checking route validity in not connected
 	 * case is not very simple. Take into account,
 	 * that we do not support routing by source, TOS,
@@ -1118,7 +1118,7 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 		struct rt6_info *rt;
 
 		*dst = ip6_route_output(net, sk, fl6);
-		rt = (*dst)->error ? NULL : (struct rt6_info *)*dst;
+		rt = (*dst)->error ? NULL : dst_rt6_info(*dst);
 
 		rcu_read_lock();
 		from = rt ? rcu_dereference(rt->from) : NULL;
@@ -1159,7 +1159,7 @@ static int ip6_dst_lookup_tail(struct net *net, const struct sock *sk,
 	 * dst entry and replace it instead with the
 	 * dst entry of the nexthop router
 	 */
-	rt = (struct rt6_info *) *dst;
+	rt = dst_rt6_info(*dst);
 	rcu_read_lock();
 	n = __ipv6_neigh_lookup_noref(rt->dst.dev,
 				      rt6_nexthop(rt, &fl6->daddr));
@@ -1423,7 +1423,7 @@ static int __ip6_append_data(struct sock *sk,
 	int offset = 0;
 	bool zc = false;
 	u32 tskey = 0;
-	struct rt6_info *rt = (struct rt6_info *)cork->dst;
+	struct rt6_info *rt = dst_rt6_info(cork->dst);
 	bool paged, hold_tskey, extra_uref = false;
 	struct ipv6_txoptions *opt = v6_cork->opt;
 	int csummode = CHECKSUM_NONE;
@@ -1877,7 +1877,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 	struct net *net = sock_net(sk);
 	struct ipv6hdr *hdr;
 	struct ipv6_txoptions *opt = v6_cork->opt;
-	struct rt6_info *rt = (struct rt6_info *)cork->base.dst;
+	struct rt6_info *rt = dst_rt6_info(cork->base.dst);
 	struct flowi6 *fl6 = &cork->fl.u.ip6;
 	unsigned char proto = fl6->flowi6_proto;
 
@@ -1949,7 +1949,7 @@ struct sk_buff *__ip6_make_skb(struct sock *sk,
 int ip6_send_skb(struct sk_buff *skb)
 {
 	struct net *net = sock_net(skb->sk);
-	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
+	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 	int err;
 
 	err = ip6_local_out(net, skb->sk, skb);
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index cb0ee81a068a..dd342e6ecf3f 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2273,7 +2273,7 @@ int ip6mr_get_route(struct net *net, struct sk_buff *skb, struct rtmsg *rtm,
 	int err;
 	struct mr_table *mrt;
 	struct mfc6_cache *cache;
-	struct rt6_info *rt = (struct rt6_info *)skb_dst(skb);
+	struct rt6_info *rt = dst_rt6_info(skb_dst(skb));
 
 	mrt = ip6mr_get_table(net, RT6_TABLE_DFLT);
 	if (!mrt)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ae134634c323..d914b23256ce 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1722,7 +1722,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 	if (IS_ERR(dst))
 		return;
 
-	rt = (struct rt6_info *) dst;
+	rt = dst_rt6_info(dst);
 
 	if (rt->rt6i_flags & RTF_GATEWAY) {
 		ND_PRINTK(2, warn,
diff --git a/net/ipv6/ping.c b/net/ipv6/ping.c
index ef2059c88955..88b3fcacd4f9 100644
--- a/net/ipv6/ping.c
+++ b/net/ipv6/ping.c
@@ -154,7 +154,7 @@ static int ping_v6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	dst = ip6_sk_dst_lookup_flow(sk, &fl6, daddr, false);
 	if (IS_ERR(dst))
 		return PTR_ERR(dst);
-	rt = (struct rt6_info *) dst;
+	rt = dst_rt6_info(dst);
 
 	if (!fl6.flowi6_oif && ipv6_addr_is_multicast(&fl6.daddr))
 		fl6.flowi6_oif = READ_ONCE(np->mcast_oif);
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 0d896ca7b589..2eedf255600b 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -598,7 +598,7 @@ static int rawv6_send_hdrinc(struct sock *sk, struct msghdr *msg, int length,
 	struct ipv6hdr *iph;
 	struct sk_buff *skb;
 	int err;
-	struct rt6_info *rt = (struct rt6_info *)*dstp;
+	struct rt6_info *rt = dst_rt6_info(*dstp);
 	int hlen = LL_RESERVED_SPACE(rt->dst.dev);
 	int tlen = rt->dst.dev->needed_tailroom;
 
@@ -917,7 +917,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.opt = opt;
 		lock_sock(sk);
 		err = ip6_append_data(sk, raw6_getfrag, &rfv,
-			len, 0, &ipc6, &fl6, (struct rt6_info *)dst,
+			len, 0, &ipc6, &fl6, dst_rt6_info(dst),
 			msg->msg_flags);
 
 		if (err)
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 1f4b935a0e57..8d5257c3f084 100644
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
 				       struct net_device *dev);
@@ -226,7 +227,7 @@ static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,
 					      struct sk_buff *skb,
 					      const void *daddr)
 {
-	const struct rt6_info *rt = container_of(dst, struct rt6_info, dst);
+	const struct rt6_info *rt = dst_rt6_info(dst);
 
 	return ip6_neigh_lookup(rt6_nexthop(rt, &in6addr_any),
 				dst->dev, skb, daddr);
@@ -234,8 +235,8 @@ static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,
 
 static void ip6_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 {
+	const struct rt6_info *rt = dst_rt6_info(dst);
 	struct net_device *dev = dst->dev;
-	struct rt6_info *rt = (struct rt6_info *)dst;
 
 	daddr = choose_neigh_daddr(rt6_nexthop(rt, &in6addr_any), NULL, daddr);
 	if (!daddr)
@@ -354,7 +355,7 @@ EXPORT_SYMBOL(ip6_dst_alloc);
 
 static void ip6_dst_destroy(struct dst_entry *dst)
 {
-	struct rt6_info *rt = (struct rt6_info *)dst;
+	struct rt6_info *rt = dst_rt6_info(dst);
 	struct fib6_info *from;
 	struct inet6_dev *idev;
 
@@ -373,7 +374,7 @@ static void ip6_dst_destroy(struct dst_entry *dst)
 
 static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev)
 {
-	struct rt6_info *rt = (struct rt6_info *)dst;
+	struct rt6_info *rt = dst_rt6_info(dst);
 	struct inet6_dev *idev = rt->rt6i_idev;
 
 	if (idev && idev->dev != blackhole_netdev) {
@@ -1288,7 +1289,7 @@ struct rt6_info *rt6_lookup(struct net *net, const struct in6_addr *daddr,
 
 	dst = fib6_rule_lookup(net, &fl6, skb, flags, ip6_pol_route_lookup);
 	if (dst->error == 0)
-		return (struct rt6_info *) dst;
+		return dst_rt6_info(dst);
 
 	dst_release(dst);
 
@@ -2647,7 +2648,7 @@ struct dst_entry *ip6_route_output_flags(struct net *net,
 
 	rcu_read_lock();
 	dst = ip6_route_output_flags_noref(net, sk, fl6, flags);
-	rt6 = (struct rt6_info *)dst;
+	rt6 = dst_rt6_info(dst);
 	/* For dst cached in uncached_list, refcnt is already taken. */
 	if (list_empty(&rt6->dst.rt_uncached) && !dst_hold_safe(dst)) {
 		dst = &net->ipv6.ip6_null_entry->dst;
@@ -2661,7 +2662,7 @@ EXPORT_SYMBOL_GPL(ip6_route_output_flags);
 
 struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
-	struct rt6_info *rt, *ort = (struct rt6_info *) dst_orig;
+	struct rt6_info *rt, *ort = dst_rt6_info(dst_orig);
 	struct net_device *loopback_dev = net->loopback_dev;
 	struct dst_entry *new = NULL;
 
@@ -2744,7 +2745,7 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 	struct fib6_info *from;
 	struct rt6_info *rt;
 
-	rt = container_of(dst, struct rt6_info, dst);
+	rt = dst_rt6_info(dst);
 
 	if (rt->sernum)
 		return rt6_is_valid(rt) ? dst : NULL;
@@ -2770,24 +2771,24 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 }
 EXPORT_INDIRECT_CALLABLE(ip6_dst_check);
 
-static struct dst_entry *ip6_negative_advice(struct dst_entry *dst)
+static void ip6_negative_advice(struct sock *sk,
+				struct dst_entry *dst)
 {
-	struct rt6_info *rt = (struct rt6_info *) dst;
+	struct rt6_info *rt = dst_rt6_info(dst);
 
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
@@ -2796,7 +2797,7 @@ static void ip6_link_failure(struct sk_buff *skb)
 
 	icmpv6_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0);
 
-	rt = (struct rt6_info *) skb_dst(skb);
+	rt = dst_rt6_info(skb_dst(skb));
 	if (rt) {
 		rcu_read_lock();
 		if (rt->rt6i_flags & RTF_CACHE) {
@@ -2852,7 +2853,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 				 bool confirm_neigh)
 {
 	const struct in6_addr *daddr, *saddr;
-	struct rt6_info *rt6 = (struct rt6_info *)dst;
+	struct rt6_info *rt6 = dst_rt6_info(dst);
 
 	/* Note: do *NOT* check dst_metric_locked(dst, RTAX_MTU)
 	 * IPv6 pmtu discovery isn't optional, so 'mtu lock' cannot disable it.
@@ -4174,7 +4175,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 		}
 	}
 
-	rt = (struct rt6_info *) dst;
+	rt = dst_rt6_info(dst);
 	if (rt->rt6i_flags & RTF_REJECT) {
 		net_dbg_ratelimited("rt6_redirect: source isn't a valid nexthop for redirect target\n");
 		return;
@@ -5608,7 +5609,7 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 			 int iif, int type, u32 portid, u32 seq,
 			 unsigned int flags)
 {
-	struct rt6_info *rt6 = (struct rt6_info *)dst;
+	struct rt6_info *rt6 = dst_rt6_info(dst);
 	struct rt6key *rt6_dst, *rt6_src;
 	u32 *pmetrics, table, rt6_flags;
 	unsigned char nh_flags = 0;
@@ -6111,7 +6112,7 @@ static int inet6_rtm_getroute(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	}
 
 
-	rt = container_of(dst, struct rt6_info, dst);
+	rt = dst_rt6_info(dst);
 	if (rt->dst.error) {
 		err = rt->dst.error;
 		ip6_rt_put(rt);
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index 861e0366f549..bbf5b84a70fc 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -356,6 +356,7 @@ static int seg6_hmac_init_algo(void)
 	struct crypto_shash *tfm;
 	struct shash_desc *shash;
 	int i, alg_count, cpu;
+	int ret = -ENOMEM;
 
 	alg_count = ARRAY_SIZE(hmac_algos);
 
@@ -366,12 +367,14 @@ static int seg6_hmac_init_algo(void)
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
@@ -383,18 +386,22 @@ static int seg6_hmac_init_algo(void)
 
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
index 03b877ff4558..a75df2ec8db0 100644
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
 
@@ -486,7 +484,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 
 	err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
 	if (unlikely(err))
-		return err;
+		goto drop;
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
@@ -494,6 +492,9 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 			       skb_dst(skb)->dev, seg6_input_finish);
 
 	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
+drop:
+	kfree_skb(skb);
+	return err;
 }
 
 static int seg6_input_nf(struct sk_buff *skb)
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 3f4cba49e9ee..5873b3c3562e 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -95,11 +95,9 @@ static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 	struct dst_entry *dst = skb_dst(skb);
 
 	if (dst && dst_hold_safe(dst)) {
-		const struct rt6_info *rt = (const struct rt6_info *)dst;
-
 		rcu_assign_pointer(sk->sk_rx_dst, dst);
 		sk->sk_rx_dst_ifindex = skb->skb_iif;
-		sk->sk_rx_dst_cookie = rt6_get_cookie(rt);
+		sk->sk_rx_dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
 	}
 }
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e0dd5bc2b30e..acafa0cdf74a 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -910,11 +910,8 @@ static int __udp6_lib_mcast_deliver(struct net *net, struct sk_buff *skb,
 
 static void udp6_sk_rx_dst_set(struct sock *sk, struct dst_entry *dst)
 {
-	if (udp_sk_rx_dst_set(sk, dst)) {
-		const struct rt6_info *rt = (const struct rt6_info *)dst;
-
-		sk->sk_rx_dst_cookie = rt6_get_cookie(rt);
-	}
+	if (udp_sk_rx_dst_set(sk, dst))
+		sk->sk_rx_dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
 }
 
 /* wrapper for udp_queue_rcv_skb tacking care of csum conversion and
@@ -1585,7 +1582,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		skb = ip6_make_skb(sk, getfrag, msg, ulen,
 				   sizeof(struct udphdr), &ipc6,
-				   (struct rt6_info *)dst,
+				   dst_rt6_info(dst),
 				   msg->msg_flags, &cork);
 		err = PTR_ERR(skb);
 		if (!IS_ERR_OR_NULL(skb))
@@ -1612,7 +1609,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
 	up->len += ulen;
 	err = ip6_append_data(sk, getfrag, msg, ulen, sizeof(struct udphdr),
-			      &ipc6, fl6, (struct rt6_info *)dst,
+			      &ipc6, fl6, dst_rt6_info(dst),
 			      corkreq ? msg->msg_flags|MSG_MORE : msg->msg_flags);
 	if (err)
 		udp_v6_flush_pending_frames(sk);
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 42fb6996b077..ce48173c60e5 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -70,7 +70,7 @@ static int xfrm6_get_saddr(struct net *net, int oif,
 static int xfrm6_fill_dst(struct xfrm_dst *xdst, struct net_device *dev,
 			  const struct flowi *fl)
 {
-	struct rt6_info *rt = (struct rt6_info *)xdst->route;
+	struct rt6_info *rt = dst_rt6_info(xdst->route);
 
 	xdst->u.dst.dev = dev;
 	netdev_hold(dev, &xdst->u.dst.dev_tracker, GFP_ATOMIC);
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 970af3983d11..19c8cc5289d5 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -459,7 +459,7 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	fl4 = &inet->cork.fl.u.ip4;
 	if (connected)
-		rt = (struct rtable *)__sk_dst_check(sk, 0);
+		rt = dst_rtable(__sk_dst_check(sk, 0));
 
 	rcu_read_lock();
 	if (!rt) {
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 7bf14cf9ffaa..8780ec64f376 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -630,7 +630,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	ulen = len + (skb_queue_empty(&sk->sk_write_queue) ? transhdrlen : 0);
 	err = ip6_append_data(sk, ip_generic_getfrag, msg,
 			      ulen, transhdrlen, &ipc6,
-			      &fl6, (struct rt6_info *)dst,
+			      &fl6, dst_rt6_info(dst),
 			      msg->msg_flags);
 	if (err)
 		ip6_flush_pending_frames(sk);
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 8fc790f2a01b..4385fd3b13be 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -81,7 +81,7 @@ static int mpls_xmit(struct sk_buff *skb)
 			ttl = net->mpls.default_ttl;
 		else
 			ttl = ip_hdr(skb)->ttl;
-		rt = (struct rtable *)dst;
+		rt = dst_rtable(dst);
 	} else if (dst->ops->family == AF_INET6) {
 		if (tun_encap_info->ttl_propagate == MPLS_TTL_PROP_DISABLED)
 			ttl = tun_encap_info->default_ttl;
@@ -90,7 +90,7 @@ static int mpls_xmit(struct sk_buff *skb)
 			ttl = net->mpls.default_ttl;
 		else
 			ttl = ipv6_hdr(skb)->hop_limit;
-		rt6 = (struct rt6_info *)dst;
+		rt6 = dst_rt6_info(dst);
 	} else {
 		goto drop;
 	}
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index 6c3f28bc59b3..54e2a1dd7f5f 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -549,6 +549,9 @@ list_set_cancel_gc(struct ip_set *set)
 
 	if (SET_WITH_TIMEOUT(set))
 		timer_shutdown_sync(&map->gc);
+
+	/* Flush list to drop references to other ipsets */
+	list_set_flush(set);
 }
 
 static const struct ip_set_type_variant set_variant = {
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 65e0259178da..e1f17392f58c 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -180,7 +180,7 @@ static inline bool crosses_local_route_boundary(int skb_af, struct sk_buff *skb,
 			(!skb->dev || skb->dev->flags & IFF_LOOPBACK) &&
 			(addr_type & IPV6_ADDR_LOOPBACK);
 		old_rt_is_local = __ip_vs_is_local_route6(
-			(struct rt6_info *)skb_dst(skb));
+			dst_rt6_info(skb_dst(skb)));
 	} else
 #endif
 	{
@@ -318,7 +318,7 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 	if (dest) {
 		dest_dst = __ip_vs_dst_check(dest);
 		if (likely(dest_dst))
-			rt = (struct rtable *) dest_dst->dst_cache;
+			rt = dst_rtable(dest_dst->dst_cache);
 		else {
 			dest_dst = ip_vs_dest_dst_alloc();
 			spin_lock_bh(&dest->dst_lock);
@@ -481,7 +481,7 @@ __ip_vs_get_out_rt_v6(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 	if (dest) {
 		dest_dst = __ip_vs_dst_check(dest);
 		if (likely(dest_dst))
-			rt = (struct rt6_info *) dest_dst->dst_cache;
+			rt = dst_rt6_info(dest_dst->dst_cache);
 		else {
 			u32 cookie;
 
@@ -501,7 +501,7 @@ __ip_vs_get_out_rt_v6(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 				ip_vs_dest_dst_free(dest_dst);
 				goto err_unreach;
 			}
-			rt = (struct rt6_info *) dst;
+			rt = dst_rt6_info(dst);
 			cookie = rt6_get_cookie(rt);
 			__ip_vs_dst_set(dest, dest_dst, &rt->dst, cookie);
 			spin_unlock_bh(&dest->dst_lock);
@@ -517,7 +517,7 @@ __ip_vs_get_out_rt_v6(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 					      rt_mode);
 		if (!dst)
 			goto err_unreach;
-		rt = (struct rt6_info *) dst;
+		rt = dst_rt6_info(dst);
 	}
 
 	local = __ip_vs_is_local_route6(rt);
@@ -862,7 +862,7 @@ ip_vs_nat_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 				      IP_VS_RT_MODE_RDR);
 	if (local < 0)
 		goto tx_error;
-	rt = (struct rt6_info *) skb_dst(skb);
+	rt = dst_rt6_info(skb_dst(skb));
 	/*
 	 * Avoid duplicate tuple in reply direction for NAT traffic
 	 * to local address when connection is sync-ed
@@ -1288,7 +1288,7 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 	if (local)
 		return ip_vs_send_or_cont(NFPROTO_IPV6, skb, cp, 1);
 
-	rt = (struct rt6_info *) skb_dst(skb);
+	rt = dst_rt6_info(skb_dst(skb));
 	tdev = rt->dst.dev;
 
 	/*
@@ -1590,7 +1590,7 @@ ip_vs_icmp_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 				      &cp->daddr.in6, NULL, ipvsh, 0, rt_mode);
 	if (local < 0)
 		goto tx_error;
-	rt = (struct rt6_info *) skb_dst(skb);
+	rt = dst_rt6_info(skb_dst(skb));
 	/*
 	 * Avoid duplicate tuple in reply direction for NAT traffic
 	 * to local address when connection is sync-ed
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index a0571339239c..5c1ff07eaee0 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -77,12 +77,8 @@ EXPORT_SYMBOL_GPL(flow_offload_alloc);
 
 static u32 flow_offload_dst_cookie(struct flow_offload_tuple *flow_tuple)
 {
-	const struct rt6_info *rt;
-
-	if (flow_tuple->l3proto == NFPROTO_IPV6) {
-		rt = (const struct rt6_info *)flow_tuple->dst_cache;
-		return rt6_get_cookie(rt);
-	}
+	if (flow_tuple->l3proto == NFPROTO_IPV6)
+		return rt6_get_cookie(dst_rt6_info(flow_tuple->dst_cache));
 
 	return 0;
 }
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 5383bed3d3e0..c2c005234dcd 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -434,7 +434,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 
 	if (unlikely(tuplehash->tuple.xmit_type == FLOW_OFFLOAD_XMIT_XFRM)) {
-		rt = (struct rtable *)tuplehash->tuple.dst_cache;
+		rt = dst_rtable(tuplehash->tuple.dst_cache);
 		memset(skb->cb, 0, sizeof(struct inet_skb_parm));
 		IPCB(skb)->iif = skb->dev->ifindex;
 		IPCB(skb)->flags = IPSKB_FORWARDED;
@@ -446,7 +446,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
 	switch (tuplehash->tuple.xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
-		rt = (struct rtable *)tuplehash->tuple.dst_cache;
+		rt = dst_rtable(tuplehash->tuple.dst_cache);
 		outdev = rt->dst.dev;
 		skb->dev = outdev;
 		nexthop = rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr);
@@ -729,7 +729,7 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 
 	if (unlikely(tuplehash->tuple.xmit_type == FLOW_OFFLOAD_XMIT_XFRM)) {
-		rt = (struct rt6_info *)tuplehash->tuple.dst_cache;
+		rt = dst_rt6_info(tuplehash->tuple.dst_cache);
 		memset(skb->cb, 0, sizeof(struct inet6_skb_parm));
 		IP6CB(skb)->iif = skb->dev->ifindex;
 		IP6CB(skb)->flags = IP6SKB_FORWARDED;
@@ -741,7 +741,7 @@ nf_flow_offload_ipv6_hook(void *priv, struct sk_buff *skb,
 
 	switch (tuplehash->tuple.xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
-		rt = (struct rt6_info *)tuplehash->tuple.dst_cache;
+		rt = dst_rt6_info(tuplehash->tuple.dst_cache);
 		outdev = rt->dst.dev;
 		skb->dev = outdev;
 		nexthop = rt6_nexthop(rt, &flow->tuplehash[!dir].tuple.src_v6);
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index 00f4bd21c59b..f1c31757e496 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -169,7 +169,9 @@ instance_destroy_rcu(struct rcu_head *head)
 	struct nfqnl_instance *inst = container_of(head, struct nfqnl_instance,
 						   rcu);
 
+	rcu_read_lock();
 	nfqnl_flush(inst, NULL, 0);
+	rcu_read_unlock();
 	kfree(inst);
 	module_put(THIS_MODULE);
 }
diff --git a/net/netfilter/nft_fib.c b/net/netfilter/nft_fib.c
index 37cfe6dd712d..b58f62195ff3 100644
--- a/net/netfilter/nft_fib.c
+++ b/net/netfilter/nft_fib.c
@@ -35,11 +35,9 @@ int nft_fib_validate(const struct nft_ctx *ctx, const struct nft_expr *expr,
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
index 0a689c8e0295..0c43d748e23a 100644
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
@@ -154,12 +145,12 @@ int nft_payload_inner_offset(const struct nft_pktinfo *pkt)
 	return pkt->inneroff;
 }
 
-static bool nft_payload_need_vlan_copy(const struct nft_payload *priv)
+static bool nft_payload_need_vlan_adjust(u32 offset, u32 len)
 {
-	unsigned int len = priv->offset + priv->len;
+	unsigned int boundary = offset + len;
 
 	/* data past ether src/dst requested, copy needed */
-	if (len > offsetof(struct ethhdr, h_proto))
+	if (boundary > offsetof(struct ethhdr, h_proto))
 		return true;
 
 	return false;
@@ -183,7 +174,7 @@ void nft_payload_eval(const struct nft_expr *expr,
 			goto err;
 
 		if (skb_vlan_tag_present(skb) &&
-		    nft_payload_need_vlan_copy(priv)) {
+		    nft_payload_need_vlan_adjust(priv->offset, priv->len)) {
 			if (!nft_payload_copy_vlan(dest, skb,
 						   priv->offset, priv->len))
 				goto err;
@@ -810,21 +801,79 @@ struct nft_payload_set {
 	u8			csum_flags;
 };
 
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
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 24d977138572..14d88394bcb7 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -73,14 +73,14 @@ void nft_rt_get_eval(const struct nft_expr *expr,
 		if (nft_pf(pkt) != NFPROTO_IPV4)
 			goto err;
 
-		*dest = (__force u32)rt_nexthop((const struct rtable *)dst,
+		*dest = (__force u32)rt_nexthop(dst_rtable(dst),
 						ip_hdr(skb)->daddr);
 		break;
 	case NFT_RT_NEXTHOP6:
 		if (nft_pf(pkt) != NFPROTO_IPV6)
 			goto err;
 
-		memcpy(dest, rt6_nexthop((struct rt6_info *)dst,
+		memcpy(dest, rt6_nexthop(dst_rt6_info(dst),
 					 &ipv6_hdr(skb)->daddr),
 		       sizeof(struct in6_addr));
 		break;
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b133dc55304c..f456a5911e7d 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1463,6 +1463,19 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
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
@@ -1516,10 +1529,9 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!nci_valid_size(skb)) {
 			kfree_skb(skb);
-			kcov_remote_stop();
-			break;
+			continue;
 		}
 
 		/* Process frame */
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 6fcd7e2ca81f..964225580824 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -936,6 +936,12 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
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
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a0d54b422186..5c3f8a278fc2 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1151,11 +1151,6 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 		list_for_each_entry(entry, &new->entries, list)
 			cycle = ktime_add_ns(cycle, entry->interval);
 
-		if (!cycle) {
-			NL_SET_ERR_MSG(extack, "'cycle_time' can never be 0");
-			return -EINVAL;
-		}
-
 		if (cycle < 0 || cycle > INT_MAX) {
 			NL_SET_ERR_MSG(extack, "'cycle_time' is too big");
 			return -EINVAL;
@@ -1164,6 +1159,11 @@ static int parse_taprio_schedule(struct taprio_sched *q, struct nlattr **tb,
 		new->cycle_time = cycle;
 	}
 
+	if (new->cycle_time < new->num_entries * length_to_duration(q, ETH_ZLEN)) {
+		NL_SET_ERR_MSG(extack, "'cycle_time' is too small");
+		return -EINVAL;
+	}
+
 	taprio_calculate_gate_durations(q, new);
 
 	return 0;
@@ -1851,6 +1851,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 	q->flags = taprio_flags;
 
+	/* Needed for length_to_duration() during netlink attribute parsing */
+	taprio_set_picos_per_byte(dev, q);
+
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
 		return err;
@@ -1910,7 +1913,6 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	if (err < 0)
 		goto free_sched;
 
-	taprio_set_picos_per_byte(dev, q);
 	taprio_update_queue_max_sdu(q, new_admin, stab);
 
 	if (FULL_OFFLOAD_IS_ENABLED(q->flags))
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 24368f755ab1..f7b809c0d142 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -415,7 +415,7 @@ static void sctp_v6_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	if (!IS_ERR_OR_NULL(dst)) {
 		struct rt6_info *rt;
 
-		rt = (struct rt6_info *)dst;
+		rt = dst_rt6_info(dst);
 		t->dst_cookie = rt6_get_cookie(rt);
 		pr_debug("rt6_dst:%pI6/%d rt6_src:%pI6\n",
 			 &rt->rt6i_dst.addr, rt->rt6i_dst.plen,
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index e849f368ed91..5a7436a13b74 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -552,7 +552,7 @@ static void sctp_v4_get_saddr(struct sctp_sock *sk,
 			      struct flowi *fl)
 {
 	union sctp_addr *saddr = &t->saddr;
-	struct rtable *rt = (struct rtable *)t->dst;
+	struct rtable *rt = dst_rtable(t->dst);
 
 	if (rt) {
 		saddr->v4.sin_family = AF_INET;
@@ -1085,7 +1085,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
-	udp_tunnel_xmit_skb((struct rtable *)dst, sk, skb, fl4->saddr,
+	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false);
 	return 0;
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 96ab50eda9c2..73a90ad873fb 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -1069,7 +1069,7 @@ static int gss_read_proxy_verf(struct svc_rqst *rqstp,
 		goto out_denied_free;
 
 	pages = DIV_ROUND_UP(inlen, PAGE_SIZE);
-	in_token->pages = kcalloc(pages, sizeof(struct page *), GFP_KERNEL);
+	in_token->pages = kcalloc(pages + 1, sizeof(struct page *), GFP_KERNEL);
 	if (!in_token->pages)
 		goto out_denied_free;
 	in_token->page_base = 0;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 28f3749f6dc6..59b2fbd88e5e 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1071,6 +1071,7 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 		.authflavor	= old->cl_auth->au_flavor,
 		.cred		= old->cl_cred,
 		.stats		= old->cl_stats,
+		.timeout	= old->cl_timeout,
 	};
 	struct rpc_clnt *clnt;
 	int err;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 4f8d7efa469f..432557a553e7 100644
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
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index f892b0903dba..b849a3d133a0 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -174,7 +174,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
-		struct rtable *rt = (struct rtable *)ndst;
+		struct rtable *rt = dst_rtable(ndst);
 
 		if (!rt) {
 			struct flowi4 fl = {
diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index b4674f03d71a..90b7f253d363 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -816,9 +816,17 @@ struct tls_context *tls_ctx_create(struct sock *sk)
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
index e94839d89b09..439c531744a2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -731,7 +731,7 @@ static int unix_listen(struct socket *sock, int backlog)
 	if (sock->type != SOCK_STREAM && sock->type != SOCK_SEQPACKET)
 		goto out;	/* Only stream/seqpacket sockets accept */
 	err = -EINVAL;
-	if (!u->addr)
+	if (!READ_ONCE(u->addr))
 		goto out;	/* No listens on an unbound socket */
 	unix_state_lock(sk);
 	if (sk->sk_state != TCP_CLOSE && sk->sk_state != TCP_LISTEN)
@@ -1131,8 +1131,8 @@ static struct sock *unix_find_other(struct net *net,
 
 static int unix_autobind(struct sock *sk)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
 	u32 lastnum, ordernum;
@@ -1155,6 +1155,7 @@ static int unix_autobind(struct sock *sk)
 	addr->name->sun_family = AF_UNIX;
 	refcount_set(&addr->refcnt, 1);
 
+	old_hash = sk->sk_hash;
 	ordernum = get_random_u32();
 	lastnum = ordernum & 0xFFFFF;
 retry:
@@ -1195,8 +1196,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 {
 	umode_t mode = S_IFSOCK |
 	       (SOCK_INODE(sk->sk_socket)->i_mode & ~current_umask());
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct mnt_idmap *idmap;
 	struct unix_address *addr;
@@ -1234,6 +1235,7 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 	if (u->addr)
 		goto out_unlock;
 
+	old_hash = sk->sk_hash;
 	new_hash = unix_bsd_hash(d_backing_inode(dentry));
 	unix_table_double_lock(net, old_hash, new_hash);
 	u->path.mnt = mntget(parent.mnt);
@@ -1261,8 +1263,8 @@ static int unix_bind_bsd(struct sock *sk, struct sockaddr_un *sunaddr,
 static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 			      int addr_len)
 {
-	unsigned int new_hash, old_hash = sk->sk_hash;
 	struct unix_sock *u = unix_sk(sk);
+	unsigned int new_hash, old_hash;
 	struct net *net = sock_net(sk);
 	struct unix_address *addr;
 	int err;
@@ -1280,6 +1282,7 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 		goto out_mutex;
 	}
 
+	old_hash = sk->sk_hash;
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
@@ -1369,7 +1372,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 
 		if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
 		     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
-		    !unix_sk(sk)->addr) {
+		    !READ_ONCE(unix_sk(sk)->addr)) {
 			err = unix_autobind(sk);
 			if (err)
 				goto out;
@@ -1481,7 +1484,8 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
+	    !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -1997,7 +2001,8 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if ((test_bit(SOCK_PASSCRED, &sock->flags) ||
-	     test_bit(SOCK_PASSPIDFD, &sock->flags)) && !u->addr) {
+	     test_bit(SOCK_PASSPIDFD, &sock->flags)) &&
+	    !READ_ONCE(u->addr)) {
 		err = unix_autobind(sk);
 		if (err)
 			goto out;
@@ -2217,13 +2222,15 @@ static int queue_oob(struct socket *sock, struct msghdr *msg, struct sock *other
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
@@ -2614,8 +2621,10 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 
 	mutex_lock(&u->iolock);
 	unix_state_lock(sk);
+	spin_lock(&sk->sk_receive_queue.lock);
 
 	if (sock_flag(sk, SOCK_URGINLINE) || !u->oob_skb) {
+		spin_unlock(&sk->sk_receive_queue.lock);
 		unix_state_unlock(sk);
 		mutex_unlock(&u->iolock);
 		return -EINVAL;
@@ -2627,6 +2636,8 @@ static int unix_stream_recv_urg(struct unix_stream_read_state *state)
 		WRITE_ONCE(u->oob_skb, NULL);
 	else
 		skb_get(oob_skb);
+
+	spin_unlock(&sk->sk_receive_queue.lock);
 	unix_state_unlock(sk);
 
 	chunk = state->recv_actor(oob_skb, 0, chunk, state);
@@ -2655,6 +2666,10 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
@@ -2666,13 +2681,19 @@ static struct sk_buff *manage_oob(struct sk_buff *skb, struct sock *sk,
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
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 53d8fabfa685..d154597728d5 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2598,8 +2598,7 @@ static void xfrm_init_path(struct xfrm_dst *path, struct dst_entry *dst,
 			   int nfheader_len)
 {
 	if (dst->ops->family == AF_INET6) {
-		struct rt6_info *rt = (struct rt6_info *)dst;
-		path->path_cookie = rt6_get_cookie(rt);
+		path->path_cookie = rt6_get_cookie(dst_rt6_info(dst));
 		path->u.rt6.rt6i_nfheader_len = nfheader_len;
 	}
 }
@@ -3905,15 +3904,10 @@ static void xfrm_link_failure(struct sk_buff *skb)
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
diff --git a/scripts/Makefile.vdsoinst b/scripts/Makefile.vdsoinst
index c477d17b0aa5..a81ca735003e 100644
--- a/scripts/Makefile.vdsoinst
+++ b/scripts/Makefile.vdsoinst
@@ -21,7 +21,7 @@ $$(dest): $$(src) FORCE
 	$$(call cmd,install)
 
 # Some architectures create .build-id symlinks
-ifneq ($(filter arm sparc x86, $(SRCARCH)),)
+ifneq ($(filter arm s390 sparc x86, $(SRCARCH)),)
 link := $(install-dir)/.build-id/$$(shell $(READELF) -n $$(src) | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p').debug
 
 __default: $$(link)
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 81fe1884ef8a..67a509778135 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -14,6 +14,7 @@
 
 struct symbol symbol_yes = {
 	.name = "y",
+	.type = S_TRISTATE,
 	.curr = { "y", yes },
 	.menus = LIST_HEAD_INIT(symbol_yes.menus),
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
@@ -21,6 +22,7 @@ struct symbol symbol_yes = {
 
 struct symbol symbol_mod = {
 	.name = "m",
+	.type = S_TRISTATE,
 	.curr = { "m", mod },
 	.menus = LIST_HEAD_INIT(symbol_mod.menus),
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
@@ -28,6 +30,7 @@ struct symbol symbol_mod = {
 
 struct symbol symbol_no = {
 	.name = "n",
+	.type = S_TRISTATE,
 	.curr = { "n", no },
 	.menus = LIST_HEAD_INIT(symbol_no.menus),
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
@@ -788,8 +791,7 @@ const char *sym_get_string_value(struct symbol *sym)
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
index 66d7265fea92..b8912de04866 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -539,6 +539,11 @@ void snd_card_disconnect(struct snd_card *card)
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
@@ -590,10 +595,6 @@ static int snd_card_do_free(struct snd_card *card)
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
index e08b2c4fbd1a..e4bcecdf89b7 100644
--- a/sound/core/jack.c
+++ b/sound/core/jack.c
@@ -37,11 +37,15 @@ static const int jack_switch_types[SND_JACK_SWITCH_TYPES] = {
 };
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
 
+static void snd_jack_remove_debugfs(struct snd_jack *jack);
+
 static int snd_jack_dev_disconnect(struct snd_device *device)
 {
-#ifdef CONFIG_SND_JACK_INPUT_DEV
 	struct snd_jack *jack = device->device_data;
 
+	snd_jack_remove_debugfs(jack);
+
+#ifdef CONFIG_SND_JACK_INPUT_DEV
 	guard(mutex)(&jack->input_dev_lock);
 	if (!jack->input_dev)
 		return 0;
@@ -381,10 +385,14 @@ static int snd_jack_debugfs_add_inject_node(struct snd_jack *jack,
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
@@ -393,7 +401,7 @@ static int snd_jack_debugfs_add_inject_node(struct snd_jack *jack,
 	return 0;
 }
 
-static void snd_jack_debugfs_clear_inject_node(struct snd_jack_kctl *jack_kctl)
+static void snd_jack_remove_debugfs(struct snd_jack *jack)
 {
 }
 #endif /* CONFIG_SND_JACK_INJECTION_DEBUG */
@@ -404,7 +412,6 @@ static void snd_jack_kctl_private_free(struct snd_kcontrol *kctl)
 
 	jack_kctl = kctl->private_data;
 	if (jack_kctl) {
-		snd_jack_debugfs_clear_inject_node(jack_kctl);
 		list_del(&jack_kctl->list);
 		kfree(jack_kctl);
 	}
@@ -497,8 +504,8 @@ int snd_jack_new(struct snd_card *card, const char *id, int type,
 		.dev_free = snd_jack_dev_free,
 #ifdef CONFIG_SND_JACK_INPUT_DEV
 		.dev_register = snd_jack_dev_register,
-		.dev_disconnect = snd_jack_dev_disconnect,
 #endif /* CONFIG_SND_JACK_INPUT_DEV */
+		.dev_disconnect = snd_jack_dev_disconnect,
 	};
 
 	if (initial_kctl) {
diff --git a/sound/core/seq/seq_ump_convert.c b/sound/core/seq/seq_ump_convert.c
index ee6ac649df83..9bfba69b2a70 100644
--- a/sound/core/seq/seq_ump_convert.c
+++ b/sound/core/seq/seq_ump_convert.c
@@ -157,7 +157,7 @@ static void ump_system_to_one_param_ev(const union snd_ump_midi1_msg *val,
 static void ump_system_to_songpos_ev(const union snd_ump_midi1_msg *val,
 				     struct snd_seq_event *ev)
 {
-	ev->data.control.value = (val->system.parm1 << 7) | val->system.parm2;
+	ev->data.control.value = (val->system.parm2 << 7) | val->system.parm1;
 }
 
 /* Encoders for 0xf0 - 0xff */
@@ -368,6 +368,7 @@ static int cvt_ump_midi1_to_midi2(struct snd_seq_client *dest,
 	struct snd_seq_ump_event ev_cvt;
 	const union snd_ump_midi1_msg *midi1 = (const union snd_ump_midi1_msg *)event->ump;
 	union snd_ump_midi2_msg *midi2 = (union snd_ump_midi2_msg *)ev_cvt.ump;
+	struct snd_seq_ump_midi2_bank *cc;
 
 	ev_cvt = *event;
 	memset(&ev_cvt.ump, 0, sizeof(ev_cvt.ump));
@@ -387,11 +388,29 @@ static int cvt_ump_midi1_to_midi2(struct snd_seq_client *dest,
 		midi2->paf.data = upscale_7_to_32bit(midi1->paf.data);
 		break;
 	case UMP_MSG_STATUS_CC:
+		cc = &dest_port->midi2_bank[midi1->note.channel];
+		switch (midi1->cc.index) {
+		case UMP_CC_BANK_SELECT:
+			cc->bank_set = 1;
+			cc->cc_bank_msb = midi1->cc.data;
+			return 0; // skip
+		case UMP_CC_BANK_SELECT_LSB:
+			cc->bank_set = 1;
+			cc->cc_bank_lsb = midi1->cc.data;
+			return 0; // skip
+		}
 		midi2->cc.index = midi1->cc.index;
 		midi2->cc.data = upscale_7_to_32bit(midi1->cc.data);
 		break;
 	case UMP_MSG_STATUS_PROGRAM:
 		midi2->pg.program = midi1->pg.program;
+		cc = &dest_port->midi2_bank[midi1->note.channel];
+		if (cc->bank_set) {
+			midi2->pg.bank_valid = 1;
+			midi2->pg.bank_msb = cc->cc_bank_msb;
+			midi2->pg.bank_lsb = cc->cc_bank_lsb;
+			cc->bank_set = 0;
+		}
 		break;
 	case UMP_MSG_STATUS_CHANNEL_PRESSURE:
 		midi2->caf.data = upscale_7_to_32bit(midi1->caf.data);
@@ -419,6 +438,7 @@ static int cvt_ump_midi2_to_midi1(struct snd_seq_client *dest,
 	struct snd_seq_ump_event ev_cvt;
 	union snd_ump_midi1_msg *midi1 = (union snd_ump_midi1_msg *)ev_cvt.ump;
 	const union snd_ump_midi2_msg *midi2 = (const union snd_ump_midi2_msg *)event->ump;
+	int err;
 	u16 v;
 
 	ev_cvt = *event;
@@ -443,6 +463,24 @@ static int cvt_ump_midi2_to_midi1(struct snd_seq_client *dest,
 		midi1->cc.data = downscale_32_to_7bit(midi2->cc.data);
 		break;
 	case UMP_MSG_STATUS_PROGRAM:
+		if (midi2->pg.bank_valid) {
+			midi1->cc.status = UMP_MSG_STATUS_CC;
+			midi1->cc.index = UMP_CC_BANK_SELECT;
+			midi1->cc.data = midi2->pg.bank_msb;
+			err = __snd_seq_deliver_single_event(dest, dest_port,
+							     (struct snd_seq_event *)&ev_cvt,
+							     atomic, hop);
+			if (err < 0)
+				return err;
+			midi1->cc.index = UMP_CC_BANK_SELECT_LSB;
+			midi1->cc.data = midi2->pg.bank_lsb;
+			err = __snd_seq_deliver_single_event(dest, dest_port,
+							     (struct snd_seq_event *)&ev_cvt,
+							     atomic, hop);
+			if (err < 0)
+				return err;
+			midi1->note.status = midi2->note.status;
+		}
 		midi1->pg.program = midi2->pg.program;
 		break;
 	case UMP_MSG_STATUS_CHANNEL_PRESSURE:
@@ -691,6 +729,7 @@ static int system_ev_to_ump_midi1(const struct snd_seq_event *event,
 				  union snd_ump_midi1_msg *data,
 				  unsigned char status)
 {
+	data->system.type = UMP_MSG_TYPE_SYSTEM; // override
 	data->system.status = status;
 	return 1;
 }
@@ -713,8 +752,8 @@ static int system_2p_ev_to_ump_midi1(const struct snd_seq_event *event,
 				     unsigned char status)
 {
 	data->system.status = status;
-	data->system.parm1 = (event->data.control.value >> 7) & 0x7f;
-	data->system.parm2 = event->data.control.value & 0x7f;
+	data->system.parm1 = event->data.control.value & 0x7f;
+	data->system.parm2 = (event->data.control.value >> 7) & 0x7f;
 	return 1;
 }
 
@@ -854,7 +893,6 @@ static int pgm_ev_to_ump_midi2(const struct snd_seq_event *event,
 		data->pg.bank_msb = cc->cc_bank_msb;
 		data->pg.bank_lsb = cc->cc_bank_lsb;
 		cc->bank_set = 0;
-		cc->cc_bank_msb = cc->cc_bank_lsb = 0;
 	}
 	return 1;
 }
diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index 558c1f38fe97..11b0570ff56d 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -732,8 +732,6 @@ static void cs35l56_hda_unbind(struct device *dev, struct device *master, void *
 	if (cs35l56->base.fw_patched)
 		cs_dsp_power_down(&cs35l56->cs_dsp);
 
-	cs_dsp_remove(&cs35l56->cs_dsp);
-
 	if (comps[cs35l56->index].dev == dev)
 		memset(&comps[cs35l56->index], 0, sizeof(*comps));
 
@@ -1035,7 +1033,7 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 			       ARRAY_SIZE(cs35l56_hda_dai_config));
 	ret = cs35l56_force_sync_asp1_registers_from_cache(&cs35l56->base);
 	if (ret)
-		goto err;
+		goto dsp_err;
 
 	/*
 	 * By default only enable one ASP1TXn, where n=amplifier index,
@@ -1061,6 +1059,8 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
 
 pm_err:
 	pm_runtime_disable(cs35l56->base.dev);
+dsp_err:
+	cs_dsp_remove(&cs35l56->cs_dsp);
 err:
 	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
 
@@ -1078,6 +1078,8 @@ void cs35l56_hda_remove(struct device *dev)
 
 	component_del(cs35l56->base.dev, &cs35l56_hda_comp_ops);
 
+	cs_dsp_remove(&cs35l56->cs_dsp);
+
 	kfree(cs35l56->system_name);
 	pm_runtime_put_noidle(cs35l56->base.dev);
 
diff --git a/sound/pci/hda/hda_component.c b/sound/pci/hda/hda_component.c
index cd299d7d84ba..d02589014a3f 100644
--- a/sound/pci/hda/hda_component.c
+++ b/sound/pci/hda/hda_component.c
@@ -123,6 +123,21 @@ static int hda_comp_match_dev_name(struct device *dev, void *data)
 	return !strcmp(d + n, tmp);
 }
 
+int hda_component_manager_bind(struct hda_codec *cdc,
+			       struct hda_component *comps, int count)
+{
+	int i;
+
+	/* Init shared data */
+	for (i = 0; i < count; ++i) {
+		memset(&comps[i], 0, sizeof(comps[i]));
+		comps[i].codec = cdc;
+	}
+
+	return component_bind_all(hda_codec_dev(cdc), comps);
+}
+EXPORT_SYMBOL_NS_GPL(hda_component_manager_bind, SND_HDA_SCODEC_COMPONENT);
+
 int hda_component_manager_init(struct hda_codec *cdc,
 			       struct hda_component *comps, int count,
 			       const char *bus, const char *hid,
@@ -143,7 +158,6 @@ int hda_component_manager_init(struct hda_codec *cdc,
 		sm->hid = hid;
 		sm->match_str = match_str;
 		sm->index = i;
-		comps[i].codec = cdc;
 		component_match_add(dev, &match, hda_comp_match_dev_name, sm);
 	}
 
diff --git a/sound/pci/hda/hda_component.h b/sound/pci/hda/hda_component.h
index c80a66691b5d..c70b3de68ab2 100644
--- a/sound/pci/hda/hda_component.h
+++ b/sound/pci/hda/hda_component.h
@@ -75,11 +75,8 @@ int hda_component_manager_init(struct hda_codec *cdc,
 void hda_component_manager_free(struct hda_codec *cdc,
 				const struct component_master_ops *ops);
 
-static inline int hda_component_manager_bind(struct hda_codec *cdc,
-					     struct hda_component *comps)
-{
-	return component_bind_all(hda_codec_dev(cdc), comps);
-}
+int hda_component_manager_bind(struct hda_codec *cdc,
+			       struct hda_component *comps, int count);
 
 static inline void hda_component_manager_unbind(struct hda_codec *cdc,
 					       struct hda_component *comps)
diff --git a/sound/pci/hda/hda_cs_dsp_ctl.c b/sound/pci/hda/hda_cs_dsp_ctl.c
index 463ca06036bf..9db45d7c17e5 100644
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
index 3b8b4ab488a6..1a1ca7caaff0 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6793,7 +6793,7 @@ static int comp_bind(struct device *dev)
 	struct alc_spec *spec = cdc->spec;
 	int ret;
 
-	ret = hda_component_manager_bind(cdc, spec->comps);
+	ret = hda_component_manager_bind(cdc, spec->comps, ARRAY_SIZE(spec->comps));
 	if (ret)
 		return ret;
 
@@ -10103,7 +10103,6 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2c, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2d, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a6e, "HP EDNA 360", ALC287_FIXUP_CS35L41_I2C_4),
@@ -10295,7 +10294,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x3a20, "ASUS G614JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a30, "ASUS G814JVR/JIR", ALC245_FIXUP_CS35L41_SPI_2),
-	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x3a40, "ASUS G814JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x3a50, "ASUS G834JYR/JZR", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x3a60, "ASUS G634JYR/JZR", ALC285_FIXUP_ASUS_SPI_REAR_SPEAKERS),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
diff --git a/sound/soc/amd/acp/acp-legacy-common.c b/sound/soc/amd/acp/acp-legacy-common.c
index b5aff3f230be..3be7c6d55a6f 100644
--- a/sound/soc/amd/acp/acp-legacy-common.c
+++ b/sound/soc/amd/acp/acp-legacy-common.c
@@ -358,11 +358,25 @@ int smn_read(struct pci_dev *dev, u32 smn_addr)
 }
 EXPORT_SYMBOL_NS_GPL(smn_read, SND_SOC_ACP_COMMON);
 
-int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
+static void check_acp3x_config(struct acp_chip_info *chip)
 {
-	struct acpi_device *pdm_dev;
-	const union acpi_object *obj;
-	u32 pdm_addr, val;
+	u32 val;
+
+	val = readl(chip->base + ACP3X_PIN_CONFIG);
+	switch (val) {
+	case ACP_CONFIG_4:
+		chip->is_i2s_config = true;
+		chip->is_pdm_config = true;
+		break;
+	default:
+		chip->is_pdm_config = true;
+		break;
+	}
+}
+
+static void check_acp6x_config(struct acp_chip_info *chip)
+{
+	u32 val;
 
 	val = readl(chip->base + ACP_PIN_CONFIG);
 	switch (val) {
@@ -371,42 +385,94 @@ int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip)
 	case ACP_CONFIG_6:
 	case ACP_CONFIG_7:
 	case ACP_CONFIG_8:
-	case ACP_CONFIG_10:
 	case ACP_CONFIG_11:
+	case ACP_CONFIG_14:
+		chip->is_pdm_config = true;
+		break;
+	case ACP_CONFIG_9:
+		chip->is_i2s_config = true;
+		break;
+	case ACP_CONFIG_10:
 	case ACP_CONFIG_12:
 	case ACP_CONFIG_13:
+		chip->is_i2s_config = true;
+		chip->is_pdm_config = true;
+		break;
+	default:
+		break;
+	}
+}
+
+static void check_acp70_config(struct acp_chip_info *chip)
+{
+	u32 val;
+
+	val = readl(chip->base + ACP_PIN_CONFIG);
+	switch (val) {
+	case ACP_CONFIG_4:
+	case ACP_CONFIG_5:
+	case ACP_CONFIG_6:
+	case ACP_CONFIG_7:
+	case ACP_CONFIG_8:
+	case ACP_CONFIG_11:
 	case ACP_CONFIG_14:
+	case ACP_CONFIG_17:
+	case ACP_CONFIG_18:
+		chip->is_pdm_config = true;
+		break;
+	case ACP_CONFIG_9:
+		chip->is_i2s_config = true;
+		break;
+	case ACP_CONFIG_10:
+	case ACP_CONFIG_12:
+	case ACP_CONFIG_13:
+	case ACP_CONFIG_19:
+	case ACP_CONFIG_20:
+		chip->is_i2s_config = true;
+		chip->is_pdm_config = true;
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
+}
+
+void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip)
+{
+	struct acpi_device *pdm_dev;
+	const union acpi_object *obj;
+	u32 pdm_addr;
 
 	switch (chip->acp_rev) {
 	case ACP3X_DEV:
 		pdm_addr = ACP_RENOIR_PDM_ADDR;
+		check_acp3x_config(chip);
 		break;
 	case ACP6X_DEV:
 		pdm_addr = ACP_REMBRANDT_PDM_ADDR;
+		check_acp6x_config(chip);
 		break;
 	case ACP63_DEV:
 		pdm_addr = ACP63_PDM_ADDR;
+		check_acp6x_config(chip);
 		break;
 	case ACP70_DEV:
 		pdm_addr = ACP70_PDM_ADDR;
+		check_acp70_config(chip);
 		break;
 	default:
-		return -EINVAL;
+		break;
 	}
 
-	pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
-	if (pdm_dev) {
-		if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
-					   ACPI_TYPE_INTEGER, &obj) &&
-					   obj->integer.value == pdm_addr)
-			return 0;
+	if (chip->is_pdm_config) {
+		pdm_dev = acpi_find_child_device(ACPI_COMPANION(&pci->dev), pdm_addr, 0);
+		if (pdm_dev) {
+			if (!acpi_dev_get_property(pdm_dev, "acp-audio-device-type",
+						   ACPI_TYPE_INTEGER, &obj) &&
+						   obj->integer.value == pdm_addr)
+				chip->is_pdm_dev = true;
+		}
 	}
-	return -ENODEV;
 }
-EXPORT_SYMBOL_NS_GPL(check_acp_pdm, SND_SOC_ACP_COMMON);
+EXPORT_SYMBOL_NS_GPL(check_acp_config, SND_SOC_ACP_COMMON);
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 5f35b90eab8d..ad320b29e87d 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -100,7 +100,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		ret = -EINVAL;
 		goto release_regions;
 	}
-
 	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(dmic_dev)) {
 		dev_err(dev, "failed to create DMIC device\n");
@@ -119,6 +118,10 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	if (ret)
 		goto unregister_dmic_dev;
 
+	check_acp_config(pci, chip);
+	if (!chip->is_pdm_dev && !chip->is_i2s_config)
+		goto skip_pdev_creation;
+
 	res = devm_kcalloc(&pci->dev, num_res, sizeof(struct resource), GFP_KERNEL);
 	if (!res) {
 		ret = -ENOMEM;
@@ -136,10 +139,6 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		}
 	}
 
-	ret = check_acp_pdm(pci, chip);
-	if (ret < 0)
-		goto skip_pdev_creation;
-
 	chip->flag = flag;
 	memset(&pdevinfo, 0, sizeof(pdevinfo));
 
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 5017e868f39b..d75b4eb34de8 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -138,6 +138,9 @@ struct acp_chip_info {
 	void __iomem *base;	/* ACP memory PCI base */
 	struct platform_device *chip_pdev;
 	unsigned int flag;	/* Distinguish b/w Legacy or Only PDM */
+	bool is_pdm_dev;	/* flag set to true when ACP PDM controller exists */
+	bool is_pdm_config;	/* flag set to true when PDM configuration is selected from BIOS */
+	bool is_i2s_config;	/* flag set to true when I2S configuration is selected from BIOS */
 };
 
 struct acp_stream {
@@ -212,6 +215,11 @@ enum acp_config {
 	ACP_CONFIG_13,
 	ACP_CONFIG_14,
 	ACP_CONFIG_15,
+	ACP_CONFIG_16,
+	ACP_CONFIG_17,
+	ACP_CONFIG_18,
+	ACP_CONFIG_19,
+	ACP_CONFIG_20,
 };
 
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
@@ -240,7 +248,7 @@ void restore_acp_pdm_params(struct snd_pcm_substream *substream,
 int restore_acp_i2s_params(struct snd_pcm_substream *substream,
 			   struct acp_dev_data *adata, struct acp_stream *stream);
 
-int check_acp_pdm(struct pci_dev *pci, struct acp_chip_info *chip);
+void check_acp_config(struct pci_dev *pci, struct acp_chip_info *chip);
 
 static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int direction)
 {
diff --git a/sound/soc/amd/acp/chip_offset_byte.h b/sound/soc/amd/acp/chip_offset_byte.h
index cfd6c4d07594..18da734c0e9e 100644
--- a/sound/soc/amd/acp/chip_offset_byte.h
+++ b/sound/soc/amd/acp/chip_offset_byte.h
@@ -20,6 +20,7 @@
 #define ACP_SOFT_RESET                          0x1000
 #define ACP_CONTROL                             0x1004
 #define ACP_PIN_CONFIG				0x1440
+#define ACP3X_PIN_CONFIG			0x1400
 
 #define ACP_EXTERNAL_INTR_REG_ADDR(adata, offset, ctrl) \
 	(adata->acp_base + adata->rsrc->irq_reg_offset + offset + (ctrl * 0x04))
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 94685449f0f4..92674314227c 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -310,8 +310,9 @@ static int cs42l43_startup(struct snd_pcm_substream *substream, struct snd_soc_d
 	struct snd_soc_component *component = dai->component;
 	struct cs42l43_codec *priv = snd_soc_component_get_drvdata(component);
 	struct cs42l43 *cs42l43 = priv->core;
-	int provider = !!regmap_test_bits(cs42l43->regmap, CS42L43_ASP_CLK_CONFIG2,
-					  CS42L43_ASP_MASTER_MODE_MASK);
+	int provider = !dai->id || !!regmap_test_bits(cs42l43->regmap,
+						      CS42L43_ASP_CLK_CONFIG2,
+						      CS42L43_ASP_MASTER_MODE_MASK);
 
 	if (provider)
 		priv->constraint.mask = CS42L43_PROVIDER_RATE_MASK;
diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index ee450126106f..9a55e77af02f 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -234,10 +234,10 @@ static int __maybe_unused rt715_dev_resume(struct device *dev)
 	if (!slave->unattach_request)
 		goto regmap_sync;
 
-	time = wait_for_completion_timeout(&slave->enumeration_complete,
+	time = wait_for_completion_timeout(&slave->initialization_complete,
 					   msecs_to_jiffies(RT715_PROBE_TIMEOUT));
 	if (!time) {
-		dev_err(&slave->dev, "%s: Enumeration not complete, timed out\n", __func__);
+		dev_err(&slave->dev, "%s: Initialization not complete, timed out\n", __func__);
 		sdw_show_ping_status(slave->bus, true);
 
 		return -ETIMEDOUT;
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index 8c9dc318b0e8..c65a4219ecd6 100644
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
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 45760fe19523..265a8ca25cbb 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 //
-// tasdevice-fmw.c -- TASDEVICE firmware support
+// tas2781-fmwlib.c -- TASDEVICE firmware support
 //
-// Copyright 2023 Texas Instruments, Inc.
+// Copyright 2023 - 2024 Texas Instruments, Inc.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 
@@ -1878,7 +1878,7 @@ int tas2781_load_calibration(void *context, char *file_name,
 {
 	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *)context;
 	struct tasdevice *tasdev = &(tas_priv->tasdevice[i]);
-	const struct firmware *fw_entry;
+	const struct firmware *fw_entry = NULL;
 	struct tasdevice_fw *tas_fmw;
 	struct firmware fmw;
 	int offset = 0;
@@ -2151,6 +2151,24 @@ static int tasdevice_load_data(struct tasdevice_priv *tas_priv,
 	return ret;
 }
 
+static void tasdev_load_calibrated_data(struct tasdevice_priv *priv, int i)
+{
+	struct tasdevice_calibration *cal;
+	struct tasdevice_fw *cal_fmw;
+
+	cal_fmw = priv->tasdevice[i].cali_data_fmw;
+
+	/* No calibrated data for current devices, playback will go ahead. */
+	if (!cal_fmw)
+		return;
+
+	cal = cal_fmw->calibrations;
+	if (cal)
+		return;
+
+	load_calib_data(priv, &cal->dev_data);
+}
+
 int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 	int cfg_no, int rca_conf_no)
 {
@@ -2210,21 +2228,9 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 		for (i = 0; i < tas_priv->ndev; i++) {
 			if (tas_priv->tasdevice[i].is_loaderr == true)
 				continue;
-			else if (tas_priv->tasdevice[i].is_loaderr == false
-				&& tas_priv->tasdevice[i].is_loading == true) {
-				struct tasdevice_fw *cal_fmw =
-					tas_priv->tasdevice[i].cali_data_fmw;
-
-				if (cal_fmw) {
-					struct tasdevice_calibration
-						*cal = cal_fmw->calibrations;
-
-					if (cal)
-						load_calib_data(tas_priv,
-							&(cal->dev_data));
-				}
+			if (tas_priv->tasdevice[i].is_loaderr == false &&
+				tas_priv->tasdevice[i].is_loading == true)
 				tas_priv->tasdevice[i].cur_prog = prm_no;
-			}
 		}
 	}
 
@@ -2245,11 +2251,15 @@ int tasdevice_select_tuningprm_cfg(void *context, int prm_no,
 		tasdevice_load_data(tas_priv, &(conf->dev_data));
 		for (i = 0; i < tas_priv->ndev; i++) {
 			if (tas_priv->tasdevice[i].is_loaderr == true) {
-				status |= 1 << (i + 4);
+				status |= BIT(i + 4);
 				continue;
-			} else if (tas_priv->tasdevice[i].is_loaderr == false
-				&& tas_priv->tasdevice[i].is_loading == true)
+			}
+
+			if (tas_priv->tasdevice[i].is_loaderr == false &&
+				tas_priv->tasdevice[i].is_loading == true) {
+				tasdev_load_calibrated_data(tas_priv, i);
 				tas_priv->tasdevice[i].cur_conf = cfg_no;
+			}
 		}
 	} else
 		dev_dbg(tas_priv->dev, "%s: Unneeded loading dsp conf %d\n",
@@ -2308,65 +2318,6 @@ int tasdevice_prmg_load(void *context, int prm_no)
 }
 EXPORT_SYMBOL_NS_GPL(tasdevice_prmg_load, SND_SOC_TAS2781_FMWLIB);
 
-int tasdevice_prmg_calibdata_load(void *context, int prm_no)
-{
-	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *) context;
-	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
-	struct tasdevice_prog *program;
-	int prog_status = 0;
-	int i;
-
-	if (!tas_fmw) {
-		dev_err(tas_priv->dev, "%s: Firmware is NULL\n", __func__);
-		goto out;
-	}
-
-	if (prm_no >= tas_fmw->nr_programs) {
-		dev_err(tas_priv->dev,
-			"%s: prm(%d) is not in range of Programs %u\n",
-			__func__, prm_no, tas_fmw->nr_programs);
-		goto out;
-	}
-
-	for (i = 0, prog_status = 0; i < tas_priv->ndev; i++) {
-		if (prm_no >= 0 && tas_priv->tasdevice[i].cur_prog != prm_no) {
-			tas_priv->tasdevice[i].cur_conf = -1;
-			tas_priv->tasdevice[i].is_loading = true;
-			prog_status++;
-		}
-		tas_priv->tasdevice[i].is_loaderr = false;
-	}
-
-	if (prog_status) {
-		program = &(tas_fmw->programs[prm_no]);
-		tasdevice_load_data(tas_priv, &(program->dev_data));
-		for (i = 0; i < tas_priv->ndev; i++) {
-			if (tas_priv->tasdevice[i].is_loaderr == true)
-				continue;
-			else if (tas_priv->tasdevice[i].is_loaderr == false
-				&& tas_priv->tasdevice[i].is_loading == true) {
-				struct tasdevice_fw *cal_fmw =
-					tas_priv->tasdevice[i].cali_data_fmw;
-
-				if (cal_fmw) {
-					struct tasdevice_calibration *cal =
-						cal_fmw->calibrations;
-
-					if (cal)
-						load_calib_data(tas_priv,
-							&(cal->dev_data));
-				}
-				tas_priv->tasdevice[i].cur_prog = prm_no;
-			}
-		}
-	}
-
-out:
-	return prog_status;
-}
-EXPORT_SYMBOL_NS_GPL(tasdevice_prmg_calibdata_load,
-	SND_SOC_TAS2781_FMWLIB);
-
 void tasdevice_tuning_switch(void *context, int state)
 {
 	struct tasdevice_priv *tas_priv = (struct tasdevice_priv *) context;
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index b5abff230e43..9350972dfefe 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -2,7 +2,7 @@
 //
 // ALSA SoC Texas Instruments TAS2563/TAS2781 Audio Smart Amplifier
 //
-// Copyright (C) 2022 - 2023 Texas Instruments Incorporated
+// Copyright (C) 2022 - 2024 Texas Instruments Incorporated
 // https://www.ti.com
 //
 // The TAS2563/TAS2781 driver implements a flexible and configurable
@@ -414,7 +414,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 				__func__, tas_priv->cal_binaryname[i]);
 	}
 
-	tasdevice_prmg_calibdata_load(tas_priv, 0);
+	tasdevice_prmg_load(tas_priv, 0);
 	tas_priv->cur_prog = 0;
 out:
 	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
diff --git a/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c b/sound/soc/mediatek/mt8192/mt8192-dai-tdm.c
index 9ce06821c7d0..49440db370af 100644
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
 
diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
index 7275437ea8d8..6481da31826d 100644
--- a/sound/soc/sof/debug.c
+++ b/sound/soc/sof/debug.c
@@ -345,8 +345,27 @@ int snd_sof_dbg_init(struct snd_sof_dev *sdev)
 
 	debugfs_create_str("fw_path", 0444, fw_profile,
 			   (char **)&plat_data->fw_filename_prefix);
-	debugfs_create_str("fw_lib_path", 0444, fw_profile,
-			   (char **)&plat_data->fw_lib_prefix);
+	/* library path is not valid for IPC3 */
+	if (plat_data->ipc_type != SOF_IPC_TYPE_3) {
+		/*
+		 * fw_lib_prefix can be NULL if the vendor/platform does not
+		 * support loadable libraries
+		 */
+		if (plat_data->fw_lib_prefix) {
+			debugfs_create_str("fw_lib_path", 0444, fw_profile,
+					   (char **)&plat_data->fw_lib_prefix);
+		} else {
+			static char *fw_lib_path;
+
+			fw_lib_path = devm_kasprintf(sdev->dev, GFP_KERNEL,
+						     "Not supported");
+			if (!fw_lib_path)
+				return -ENOMEM;
+
+			debugfs_create_str("fw_lib_path", 0444, fw_profile,
+					   (char **)&fw_lib_path);
+		}
+	}
 	debugfs_create_str("tplg_path", 0444, fw_profile,
 			   (char **)&plat_data->tplg_filename_prefix);
 	debugfs_create_str("fw_name", 0444, fw_profile,
diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
index 2cd92761f171..ba2a6b6645ae 100644
--- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
+++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
@@ -43,7 +43,6 @@
 #define METER_CERT_MAX_SIZE	4096
 #define STATE_MAX_NUM_LICENSES	16
 #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
-#define METER_MAX_NUM_BUNDLES	8
 
 #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
 #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
@@ -154,11 +153,12 @@ struct bundle_encoding {
 };
 
 struct meter_certificate {
-	uint32_t block_signature;
-	uint32_t counter_unit;
+	uint32_t signature;
+	uint32_t version;
 	uint64_t ppin;
+	uint32_t counter_unit;
 	uint32_t bundle_length;
-	uint32_t reserved;
+	uint64_t reserved;
 	uint32_t mmrc_encoding;
 	uint32_t mmrc_counter;
 };
@@ -167,6 +167,11 @@ struct bundle_encoding_counter {
 	uint32_t encoding;
 	uint32_t counter;
 };
+#define METER_BUNDLE_SIZE sizeof(struct bundle_encoding_counter)
+#define BUNDLE_COUNT(length) ((length) / METER_BUNDLE_SIZE)
+#define METER_MAX_NUM_BUNDLES							\
+		((METER_CERT_MAX_SIZE - sizeof(struct meter_certificate)) /	\
+		 sizeof(struct bundle_encoding_counter))
 
 struct sdsi_dev {
 	struct sdsi_regs regs;
@@ -334,6 +339,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	uint32_t count = 0;
 	FILE *cert_ptr;
 	int ret, size;
+	char name[4];
 
 	ret = sdsi_update_registers(s);
 	if (ret)
@@ -375,32 +381,40 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
 	printf("\n");
 	printf("Meter certificate for device %s\n", s->dev_name);
 	printf("\n");
-	printf("Block Signature:       0x%x\n", mc->block_signature);
-	printf("Count Unit:            %dms\n", mc->counter_unit);
-	printf("PPIN:                  0x%lx\n", mc->ppin);
-	printf("Feature Bundle Length: %d\n", mc->bundle_length);
-	printf("MMRC encoding:         %d\n", mc->mmrc_encoding);
-	printf("MMRC counter:          %d\n", mc->mmrc_counter);
-	if (mc->bundle_length % 8) {
+
+	get_feature(mc->signature, name);
+	printf("Signature:                    %.4s\n", name);
+
+	printf("Version:                      %d\n", mc->version);
+	printf("Count Unit:                   %dms\n", mc->counter_unit);
+	printf("PPIN:                         0x%lx\n", mc->ppin);
+	printf("Feature Bundle Length:        %d\n", mc->bundle_length);
+
+	get_feature(mc->mmrc_encoding, name);
+	printf("MMRC encoding:                %.4s\n", name);
+
+	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
+	if (mc->bundle_length % METER_BUNDLE_SIZE) {
 		fprintf(stderr, "Invalid bundle length\n");
 		return -1;
 	}
 
-	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
-		fprintf(stderr, "More than %d bundles: %d\n",
-			METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);
+	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * METER_BUNDLE_SIZE)  {
+		fprintf(stderr, "More than %ld bundles: actual %ld\n",
+			METER_MAX_NUM_BUNDLES, BUNDLE_COUNT(mc->bundle_length));
 		return -1;
 	}
 
-	bec = (void *)(mc) + sizeof(mc);
+	bec = (struct bundle_encoding_counter *)(mc + 1);
 
-	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
-	while (count++ < mc->bundle_length / 8) {
+	printf("Number of Feature Counters:   %ld\n", BUNDLE_COUNT(mc->bundle_length));
+	while (count < BUNDLE_COUNT(mc->bundle_length)) {
 		char feature[5];
 
 		feature[4] = '\0';
 		get_feature(bec[count].encoding, feature);
 		printf("    %s:          %d\n", feature, bec[count].counter);
+		++count;
 	}
 
 	return 0;
diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d9520cb826b3..af393c7dee1f 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -728,7 +728,7 @@ static int sets_patch(struct object *obj)
 
 static int symbols_patch(struct object *obj)
 {
-	int err;
+	off_t err;
 
 	if (__symbols_patch(obj, &obj->structs)  ||
 	    __symbols_patch(obj, &obj->unions)   ||
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
index 3b12595193c9..6bf2468f59d3 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -71,6 +71,7 @@ counted. The following modifiers exist:
  D - pin the event to the PMU
  W - group is weak and will fallback to non-group if not schedulable,
  e - group or event are exclusive and do not share the PMU
+ b - use BPF aggregration (see perf stat --bpf-counters)
 
 The 'p' modifier can be used for specifying how precise the instruction
 address should be. The 'p' modifier can be specified multiple times:
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 04d89d2ed209..d769aa447fb7 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -458,18 +458,19 @@ SHELL = $(SHELL_PATH)
 
 arm64_gen_sysreg_dir := $(srctree)/tools/arch/arm64/tools
 ifneq ($(OUTPUT),)
-  arm64_gen_sysreg_outdir := $(OUTPUT)
+  arm64_gen_sysreg_outdir := $(abspath $(OUTPUT))
 else
   arm64_gen_sysreg_outdir := $(CURDIR)
 endif
 
 arm64-sysreg-defs: FORCE
-	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir)
+	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir) \
+		prefix= subdir=
 
 arm64-sysreg-defs-clean:
 	$(call QUIET_CLEAN,arm64-sysreg-defs)
 	$(Q)$(MAKE) -C $(arm64_gen_sysreg_dir) O=$(arm64_gen_sysreg_outdir) \
-		clean > /dev/null
+		prefix= subdir= clean > /dev/null
 
 beauty_linux_dir := $(srctree)/tools/perf/trace/beauty/include/linux/
 linux_uapi_dir := $(srctree)/tools/include/uapi/linux
diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 49331743c743..a759eb2328be 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -362,7 +362,7 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 		return -1;
 
 	for (i = 0; i < nr_mmaps; i++) {
-		int idx = rand() % (nr_dsos - 1);
+		int idx = rand() % nr_dsos;
 		struct bench_dso *dso = &dsos[idx];
 		u64 timestamp = rand() % 1000000;
 
diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 5c71fdc419dd..b722ff88fe7d 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -47,7 +47,7 @@ static const char * const bench_uprobe_usage[] = {
 #define bench_uprobe__attach_uprobe(prog) \
 	skel->links.prog = bpf_program__attach_uprobe_opts(/*prog=*/skel->progs.prog, \
 							   /*pid=*/-1, \
-							   /*binary_path=*/"/lib64/libc.so.6", \
+							   /*binary_path=*/"libc.so.6", \
 							   /*func_offset=*/0, \
 							   /*opts=*/&uprobe_opts); \
 	if (!skel->links.prog) { \
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6c1cc797692d..9cd97fd76bb5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -809,8 +809,6 @@ int cmd_annotate(int argc, const char **argv)
 		    "Enable symbol demangling"),
 	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
 		    "Enable kernel symbol demangling"),
-	OPT_BOOLEAN(0, "group", &symbol_conf.event_group,
-		    "Show event group information together"),
 	OPT_BOOLEAN(0, "show-total-period", &symbol_conf.show_total_period,
 		    "Show a column with the sum of periods"),
 	OPT_BOOLEAN('n', "show-nr-samples", &symbol_conf.show_nr_samples,
diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 83954af36753..de76bbc50bfb 100644
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
index ff7e1d6cfcd2..6aeae398ec28 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1355,8 +1355,6 @@ static int record__open(struct record *rec)
 	struct record_opts *opts = &rec->opts;
 	int rc = 0;
 
-	evlist__config(evlist, opts, &callchain_param);
-
 	evlist__for_each_entry(evlist, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
@@ -2483,6 +2481,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 
 	evlist__uniquify_name(rec->evlist);
 
+	evlist__config(rec->evlist, opts, &callchain_param);
+
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
 	if (record__open(rec) != 0) {
@@ -2881,10 +2881,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
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
index dcd93ee5fc24..5b684d2ab4be 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -428,7 +428,7 @@ static int report__setup_sample_type(struct report *rep)
 		 * compatibility, set the bit if it's an old perf data file.
 		 */
 		evlist__for_each_entry(session->evlist, evsel) {
-			if (strstr(evsel->name, "arm_spe") &&
+			if (strstr(evsel__name(evsel), "arm_spe") &&
 				!(sample_type & PERF_SAMPLE_DATA_SRC)) {
 				evsel->core.attr.sample_type |= PERF_SAMPLE_DATA_SRC;
 				sample_type |= PERF_SAMPLE_DATA_SRC;
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b248c433529a..1bfb22347371 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2963,8 +2963,11 @@ static int timehist_check_attr(struct perf_sched *sched,
 			return -1;
 		}
 
-		if (sched->show_callchain && !evsel__has_callchain(evsel)) {
-			pr_info("Samples do not have callchains.\n");
+		/* only need to save callchain related to sched_switch event */
+		if (sched->show_callchain &&
+		    evsel__name_is(evsel, "sched:sched_switch") &&
+		    !evsel__has_callchain(evsel)) {
+			pr_info("Samples of sched_switch event do not have callchains.\n");
 			sched->show_callchain = 0;
 			symbol_conf.use_callchain = 0;
 		}
diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
index ec2ff78e2b5f..3ab1d3a6638c 100644
--- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
+++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
@@ -2,71 +2,71 @@
   {
     "BriefDescription": "Transaction count",
     "MetricName": "transaction",
-    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL"
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL if has_event(TX_C_TEND) else 0"
   },
   {
     "BriefDescription": "Cycles per Instruction",
     "MetricName": "cpi",
-    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Problem State Instruction Ratio",
     "MetricName": "prbstate",
-    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Level One Miss per 100 Instructions",
     "MetricName": "l1mp",
-    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100"
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 2 cache",
     "MetricName": "l2p",
-    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 3 on same chip cache",
     "MetricName": "l3p",
-    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + DCW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + DCW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ_CHIP_HIT) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 4 Local cache on same book",
     "MetricName": "l4lp",
-    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_ON_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + IDCW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDCW_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_ON_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + IDCW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDCW_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ_DRAWER_HIT) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from Level 4 Remote cache on different book",
     "MetricName": "l4rp",
-    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAWER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAWER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_OFF_DRAWER) else 0"
   },
   {
     "BriefDescription": "Percentage sourced from memory",
     "MetricName": "memp",
-    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100"
+    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY + ICW_ON_CHIP_MEMORY + ICW_ON_MODULE_MEMORY + ICW_ON_DRAWER_MEMORY + ICW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_ON_CHIP_MEMORY) else 0"
   },
   {
     "BriefDescription": "Cycles per Instructions from Finite cache/memory",
     "MetricName": "finite_cpi",
-    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS"
+    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_MISSES) else 0"
   },
   {
     "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
     "MetricName": "est_cpi",
-    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS)"
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
   },
   {
     "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
     "MetricName": "scpl1m",
-    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES)"
+    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) if has_event(L1C_TLB2_MISSES) else 0"
   },
   {
     "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
     "MetricName": "tlb_percent",
-    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100"
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100 if has_event(CPU_CYCLES) else 0"
   },
   {
     "BriefDescription": "Estimated Cycles per TLB Miss",
     "MetricName": "tlb_miss",
-    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES))"
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) if has_event(DTLB2_MISSES) else 0"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index a918e1af77a5..b22648d12751 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -5,4 +5,4 @@ Family-model,Version,Filename,EventType
 ^IBM.296[45].*[13]\.[1-5].[[:xdigit:]]+$,1,cf_z13,core
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
 ^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
-^IBM.393[12].*3\.7.[[:xdigit:]]+$,3,cf_z16,core
+^IBM.393[12].*$,3,cf_z16,core
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index d13ee7683d9d..e05b370b1e2b 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -274,11 +274,8 @@ static int finish_test(struct child_test *child_test, int width)
 	struct test_suite *t = child_test->test;
 	int i = child_test->test_num;
 	int subi = child_test->subtest;
-	int out = child_test->process.out;
 	int err = child_test->process.err;
-	bool out_done = out <= 0;
 	bool err_done = err <= 0;
-	struct strbuf out_output = STRBUF_INIT;
 	struct strbuf err_output = STRBUF_INIT;
 	int ret;
 
@@ -290,11 +287,9 @@ static int finish_test(struct child_test *child_test, int width)
 		pr_info("%3d: %-*s:\n", i + 1, width, test_description(t, -1));
 
 	/*
-	 * Busy loop reading from the child's stdout and stderr that are set to
-	 * be non-blocking until EOF.
+	 * Busy loop reading from the child's stdout/stderr that are set to be
+	 * non-blocking until EOF.
 	 */
-	if (!out_done)
-		fcntl(out, F_SETFL, O_NONBLOCK);
 	if (!err_done)
 		fcntl(err, F_SETFL, O_NONBLOCK);
 	if (verbose > 1) {
@@ -303,11 +298,8 @@ static int finish_test(struct child_test *child_test, int width)
 		else
 			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
 	}
-	while (!out_done || !err_done) {
-		struct pollfd pfds[2] = {
-			{ .fd = out,
-			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
-			},
+	while (!err_done) {
+		struct pollfd pfds[1] = {
 			{ .fd = err,
 			  .events = POLLIN | POLLERR | POLLHUP | POLLNVAL,
 			},
@@ -317,21 +309,7 @@ static int finish_test(struct child_test *child_test, int width)
 
 		/* Poll to avoid excessive spinning, timeout set for 1000ms. */
 		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/1000);
-		if (!out_done && pfds[0].revents) {
-			errno = 0;
-			len = read(out, buf, sizeof(buf) - 1);
-
-			if (len <= 0) {
-				out_done = errno != EAGAIN;
-			} else {
-				buf[len] = '\0';
-				if (verbose > 1)
-					fprintf(stdout, "%s", buf);
-				else
-					strbuf_addstr(&out_output, buf);
-			}
-		}
-		if (!err_done && pfds[1].revents) {
+		if (!err_done && pfds[0].revents) {
 			errno = 0;
 			len = read(err, buf, sizeof(buf) - 1);
 
@@ -354,14 +332,10 @@ static int finish_test(struct child_test *child_test, int width)
 			pr_info("%3d.%1d: %s:\n", i + 1, subi + 1, test_description(t, subi));
 		else
 			pr_info("%3d: %s:\n", i + 1, test_description(t, -1));
-		fprintf(stdout, "%s", out_output.buf);
 		fprintf(stderr, "%s", err_output.buf);
 	}
-	strbuf_release(&out_output);
 	strbuf_release(&err_output);
 	print_test_result(t, i, subi, ret, width);
-	if (out > 0)
-		close(out);
 	if (err > 0)
 		close(err);
 	return 0;
@@ -394,6 +368,7 @@ static int start_test(struct test_suite *test, int i, int subi, struct child_tes
 		(*child)->process.no_stdout = 1;
 		(*child)->process.no_stderr = 1;
 	} else {
+		(*child)->process.stdout_to_stderr = 1;
 		(*child)->process.out = -1;
 		(*child)->process.err = -1;
 	}
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 7a3a7bbbec71..29d2f3ee4e10 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -637,11 +637,11 @@ static int do_test_code_reading(bool try_kcore)
 
 		evlist__config(evlist, &opts, NULL);
 
-		evsel = evlist__first(evlist);
-
-		evsel->core.attr.comm = 1;
-		evsel->core.attr.disabled = 1;
-		evsel->core.attr.enable_on_exec = 0;
+		evlist__for_each_entry(evlist, evsel) {
+			evsel->core.attr.comm = 1;
+			evsel->core.attr.disabled = 1;
+			evsel->core.attr.enable_on_exec = 0;
+		}
 
 		ret = evlist__open(evlist);
 		if (ret < 0) {
diff --git a/tools/perf/tests/shell/test_arm_coresight.sh b/tools/perf/tests/shell/test_arm_coresight.sh
index 65dd85207125..3302ea0b9672 100755
--- a/tools/perf/tests/shell/test_arm_coresight.sh
+++ b/tools/perf/tests/shell/test_arm_coresight.sh
@@ -188,7 +188,7 @@ arm_cs_etm_snapshot_test() {
 
 arm_cs_etm_basic_test() {
 	echo "Recording trace with '$*'"
-	perf record -o ${perfdata} "$@" -- ls > /dev/null 2>&1
+	perf record -o ${perfdata} "$@" -m,8M -- ls > /dev/null 2>&1
 
 	perf_script_branch_samples ls &&
 	perf_report_branch_samples ls &&
diff --git a/tools/perf/tests/workloads/datasym.c b/tools/perf/tests/workloads/datasym.c
index ddd40bc63448..8e08fc75a973 100644
--- a/tools/perf/tests/workloads/datasym.c
+++ b/tools/perf/tests/workloads/datasym.c
@@ -16,6 +16,22 @@ static int datasym(int argc __maybe_unused, const char **argv __maybe_unused)
 {
 	for (;;) {
 		buf1.data1++;
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
 		buf1.data2 += buf1.data1;
 	}
 	return 0;
diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 603d11283cbd..19503e838738 100644
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
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 50ca92255ff6..79d082155c2f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -887,10 +887,17 @@ static struct annotated_source *annotated_source__new(void)
 
 static __maybe_unused void annotated_source__delete(struct annotated_source *src)
 {
+	struct hashmap_entry *cur;
+	size_t bkt;
+
 	if (src == NULL)
 		return;
 
-	hashmap__free(src->samples);
+	if (src->samples) {
+		hashmap__for_each_entry(src->samples, cur, bkt)
+			zfree(&cur->pvalue);
+		hashmap__free(src->samples);
+	}
 	zfree(&src->histograms);
 	free(src);
 }
@@ -3025,7 +3032,7 @@ void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *m
 	annotation__update_column_widths(notes);
 }
 
-static void annotation__calc_lines(struct annotation *notes, struct map *map,
+static void annotation__calc_lines(struct annotation *notes, struct map_symbol *ms,
 				   struct rb_root *root)
 {
 	struct annotation_line *al;
@@ -3033,6 +3040,7 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		double percent_max = 0.0;
+		u64 addr;
 		int i;
 
 		for (i = 0; i < al->data_nr; i++) {
@@ -3048,8 +3056,9 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		if (percent_max <= 0.5)
 			continue;
 
-		al->path = get_srcline(map__dso(map), notes->start + al->offset, NULL,
-				       false, true, notes->start + al->offset);
+		addr = map__rip_2objdump(ms->map, ms->sym->start);
+		al->path = get_srcline(map__dso(ms->map), addr + al->offset, NULL,
+				       false, true, ms->sym->start + al->offset);
 		insert_source_line(&tmp_root, al);
 	}
 
@@ -3060,7 +3069,7 @@ static void symbol__calc_lines(struct map_symbol *ms, struct rb_root *root)
 {
 	struct annotation *notes = symbol__annotation(ms->sym);
 
-	annotation__calc_lines(notes, ms->map, root);
+	annotation__calc_lines(notes, ms, root);
 }
 
 int symbol__tty_annotate2(struct map_symbol *ms, struct evsel *evsel)
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 2791126069b4..f93e57e2fc42 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1136,6 +1136,68 @@ int die_get_varname(Dwarf_Die *vr_die, struct strbuf *buf)
 	return ret < 0 ? ret : strbuf_addf(buf, "\t%s", dwarf_diename(vr_die));
 }
 
+#if defined(HAVE_DWARF_GETLOCATIONS_SUPPORT) || defined(HAVE_DWARF_CFI_SUPPORT)
+static int reg_from_dwarf_op(Dwarf_Op *op)
+{
+	switch (op->atom) {
+	case DW_OP_reg0 ... DW_OP_reg31:
+		return op->atom - DW_OP_reg0;
+	case DW_OP_breg0 ... DW_OP_breg31:
+		return op->atom - DW_OP_breg0;
+	case DW_OP_regx:
+	case DW_OP_bregx:
+		return op->number;
+	default:
+		break;
+	}
+	return -1;
+}
+
+static int offset_from_dwarf_op(Dwarf_Op *op)
+{
+	switch (op->atom) {
+	case DW_OP_reg0 ... DW_OP_reg31:
+	case DW_OP_regx:
+		return 0;
+	case DW_OP_breg0 ... DW_OP_breg31:
+		return op->number;
+	case DW_OP_bregx:
+		return op->number2;
+	default:
+		break;
+	}
+	return -1;
+}
+
+static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
+{
+	/* The first op is checked separately */
+	ops++;
+	nops--;
+
+	/*
+	 * It needs to make sure if the location expression matches to the given
+	 * register and offset exactly.  Thus it rejects any complex expressions
+	 * and only allows a few of selected operators that doesn't change the
+	 * location.
+	 */
+	while (nops) {
+		switch (ops->atom) {
+		case DW_OP_stack_value:
+		case DW_OP_deref_size:
+		case DW_OP_deref:
+		case DW_OP_piece:
+			break;
+		default:
+			return false;
+		}
+		ops++;
+		nops--;
+	}
+	return true;
+}
+#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT || HAVE_DWARF_CFI_SUPPORT */
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 /**
  * die_get_var_innermost_scope - Get innermost scope range of given variable DIE
@@ -1280,7 +1342,7 @@ struct find_var_data {
 #define DWARF_OP_DIRECT_REGS  32
 
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
-			     u64 addr_offset, u64 addr_type)
+			     u64 addr_offset, u64 addr_type, bool is_pointer)
 {
 	Dwarf_Die type_die;
 	Dwarf_Word size;
@@ -1294,6 +1356,12 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	if (die_get_real_type(die_mem, &type_die) == NULL)
 		return false;
 
+	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
+		/* Get the target type of the pointer */
+		if (die_get_real_type(&type_die, &type_die) == NULL)
+			return false;
+	}
+
 	if (dwarf_aggregate_size(&type_die, &size) < 0)
 		return false;
 
@@ -1305,34 +1373,6 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	return true;
 }
 
-static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
-{
-	/* The first op is checked separately */
-	ops++;
-	nops--;
-
-	/*
-	 * It needs to make sure if the location expression matches to the given
-	 * register and offset exactly.  Thus it rejects any complex expressions
-	 * and only allows a few of selected operators that doesn't change the
-	 * location.
-	 */
-	while (nops) {
-		switch (ops->atom) {
-		case DW_OP_stack_value:
-		case DW_OP_deref_size:
-		case DW_OP_deref:
-		case DW_OP_piece:
-			break;
-		default:
-			return false;
-		}
-		ops++;
-		nops--;
-	}
-	return true;
-}
-
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1361,31 +1401,38 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
 		    data->offset >= (int)ops->number &&
 		    check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->offset, ops->number))
+		    match_var_offset(die_mem, data, data->offset, ops->number,
+				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 
 		/* Only match with a simple case */
 		if (data->reg < DWARF_OP_DIRECT_REGS) {
 			/* pointer variables saved in a register 0 to 31 */
 			if (ops->atom == (DW_OP_reg0 + data->reg) &&
-			    check_allowed_ops(ops, nops))
+			    check_allowed_ops(ops, nops) &&
+			    match_var_offset(die_mem, data, data->offset, 0,
+					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == (DW_OP_breg0 + data->reg) &&
 			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, ops->number))
+			    match_var_offset(die_mem, data, data->offset, ops->number,
+					     /*is_pointer=*/false))
 				return DIE_FIND_CB_END;
 		} else {
 			/* pointer variables saved in a register 32 or above */
 			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
-			    check_allowed_ops(ops, nops))
+			    check_allowed_ops(ops, nops) &&
+			    match_var_offset(die_mem, data, data->offset, 0,
+					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
 			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, ops->number2))
+			    match_var_offset(die_mem, data, data->offset, ops->number2,
+					     /*is_poitner=*/false))
 				return DIE_FIND_CB_END;
 		}
 	}
@@ -1447,7 +1494,8 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 			continue;
 
 		if (check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->addr, ops->number))
+		    match_var_offset(die_mem, data, data->addr, ops->number,
+				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 	}
 	return DIE_FIND_CB_SIBLING;
@@ -1479,41 +1527,69 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 		*offset = data.offset;
 	return result;
 }
-#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
-#ifdef HAVE_DWARF_CFI_SUPPORT
-static int reg_from_dwarf_op(Dwarf_Op *op)
+static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
 {
-	switch (op->atom) {
-	case DW_OP_reg0 ... DW_OP_reg31:
-		return op->atom - DW_OP_reg0;
-	case DW_OP_breg0 ... DW_OP_breg31:
-		return op->atom - DW_OP_breg0;
-	case DW_OP_regx:
-	case DW_OP_bregx:
-		return op->number;
-	default:
-		break;
-	}
-	return -1;
+	struct die_var_type **var_types = arg;
+	Dwarf_Die type_die;
+	int tag = dwarf_tag(die_mem);
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t nops;
+	struct die_var_type *vt;
+
+	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	/*
+	 * Only collect the first location as it can reconstruct the
+	 * remaining state by following the instructions.
+	 * start = 0 means it covers the whole range.
+	 */
+	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
+		return DIE_FIND_CB_SIBLING;
+
+	if (die_get_real_type(die_mem, &type_die) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	vt = malloc(sizeof(*vt));
+	if (vt == NULL)
+		return DIE_FIND_CB_END;
+
+	vt->die_off = dwarf_dieoffset(&type_die);
+	vt->addr = start;
+	vt->reg = reg_from_dwarf_op(ops);
+	vt->offset = offset_from_dwarf_op(ops);
+	vt->next = *var_types;
+	*var_types = vt;
+
+	return DIE_FIND_CB_SIBLING;
 }
 
-static int offset_from_dwarf_op(Dwarf_Op *op)
+/**
+ * die_collect_vars - Save all variables and parameters
+ * @sc_die: a scope DIE
+ * @var_types: a pointer to save the resulting list
+ *
+ * Save all variables and parameters in the @sc_die and save them to @var_types.
+ * The @var_types is a singly-linked list containing type and location info.
+ * Actual type can be retrieved using dwarf_offdie() with 'die_off' later.
+ *
+ * Callers should free @var_types.
+ */
+void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types)
 {
-	switch (op->atom) {
-	case DW_OP_reg0 ... DW_OP_reg31:
-	case DW_OP_regx:
-		return 0;
-	case DW_OP_breg0 ... DW_OP_breg31:
-		return op->number;
-	case DW_OP_bregx:
-		return op->number2;
-	default:
-		break;
-	}
-	return -1;
+	Dwarf_Die die_mem;
+
+	die_find_child(sc_die, __die_collect_vars_cb, (void *)var_types, &die_mem);
 }
+#endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
+#ifdef HAVE_DWARF_CFI_SUPPORT
 /**
  * die_get_cfa - Get frame base information
  * @dwarf: a Dwarf info
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 85dd527ae1f7..efafd3a1f5b6 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -135,6 +135,15 @@ void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 /* Get the list of including scopes */
 int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
 
+/* Variable type information */
+struct die_var_type {
+	struct die_var_type *next;
+	u64 die_off;
+	u64 addr;
+	int reg;
+	int offset;
+};
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 
 /* Get byte offset range of given variable DIE */
@@ -150,6 +159,9 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 				     Dwarf_Addr addr, Dwarf_Die *die_mem,
 				     int *offset);
 
+/* Save all variables and parameters in this scope */
+void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -178,6 +190,11 @@ static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unu
 	return NULL;
 }
 
+static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
+				    struct die_var_type **var_types __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #ifdef HAVE_DWARF_CFI_SUPPORT
diff --git a/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c b/tools/perf/util/intel-pt-decoder/intel-pt-decoder.c
index b450178e3420..e733f6b1f7ac 100644
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
index f38893e0b036..4db9a098f592 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -764,6 +764,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 	addr_location__init(&al);
 	intel_pt_insn->length = 0;
+	intel_pt_insn->op = INTEL_PT_OP_OTHER;
 
 	if (to_ip && *ip == to_ip)
 		goto out_no_cache;
@@ -898,6 +899,7 @@ static int intel_pt_walk_next_insn(struct intel_pt_insn *intel_pt_insn,
 
 			if (to_ip && *ip == to_ip) {
 				intel_pt_insn->length = 0;
+				intel_pt_insn->op = INTEL_PT_OP_OTHER;
 				goto out_no_cache;
 			}
 
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 527517db3182..07c22f765fab 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1549,8 +1549,8 @@ static int machine__update_kernel_mmap(struct machine *machine,
 	updated = map__get(orig);
 
 	machine->vmlinux_map = updated;
-	machine__set_kernel_mmap(machine, start, end);
 	maps__remove(machine__kernel_maps(machine), orig);
+	machine__set_kernel_mmap(machine, start, end);
 	err = maps__insert(machine__kernel_maps(machine), updated);
 	map__put(orig);
 
diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
index 8f04d3b7f3ec..59fbbba79697 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -7,6 +7,8 @@
 #include <linux/types.h>
 #include <linux/perf_event.h>
 #include "util/evsel_fprintf.h"
+#include "util/pmu.h"
+#include "util/pmus.h"
 #include "trace-event.h"
 
 struct bit_names {
@@ -75,9 +77,12 @@ static void __p_read_format(char *buf, size_t size, u64 value)
 }
 
 #define ENUM_ID_TO_STR_CASE(x) case x: return (#x);
-static const char *stringify_perf_type_id(u64 value)
+static const char *stringify_perf_type_id(struct perf_pmu *pmu, u32 type)
 {
-	switch (value) {
+	if (pmu)
+		return pmu->name;
+
+	switch (type) {
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_HARDWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_SOFTWARE)
 	ENUM_ID_TO_STR_CASE(PERF_TYPE_TRACEPOINT)
@@ -175,9 +180,9 @@ do {								\
 #define print_id_unsigned(_s)	PRINT_ID(_s, "%"PRIu64)
 #define print_id_hex(_s)	PRINT_ID(_s, "%#"PRIx64)
 
-static void __p_type_id(char *buf, size_t size, u64 value)
+static void __p_type_id(struct perf_pmu *pmu, char *buf, size_t size, u64 value)
 {
-	print_id_unsigned(stringify_perf_type_id(value));
+	print_id_unsigned(stringify_perf_type_id(pmu, value));
 }
 
 static void __p_config_hw_id(char *buf, size_t size, u64 value)
@@ -217,8 +222,14 @@ static void __p_config_tracepoint_id(char *buf, size_t size, u64 value)
 }
 #endif
 
-static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
+static void __p_config_id(struct perf_pmu *pmu, char *buf, size_t size, u32 type, u64 value)
 {
+	const char *name = perf_pmu__name_from_config(pmu, value);
+
+	if (name) {
+		print_id_hex(name);
+		return;
+	}
 	switch (type) {
 	case PERF_TYPE_HARDWARE:
 		return __p_config_hw_id(buf, size, value);
@@ -246,8 +257,8 @@ static void __p_config_id(char *buf, size_t size, u32 type, u64 value)
 #define p_sample_type(val)	__p_sample_type(buf, BUF_SIZE, val)
 #define p_branch_sample_type(val) __p_branch_sample_type(buf, BUF_SIZE, val)
 #define p_read_format(val)	__p_read_format(buf, BUF_SIZE, val)
-#define p_type_id(val)		__p_type_id(buf, BUF_SIZE, val)
-#define p_config_id(val)	__p_config_id(buf, BUF_SIZE, attr->type, val)
+#define p_type_id(val)		__p_type_id(pmu, buf, BUF_SIZE, val)
+#define p_config_id(val)	__p_config_id(pmu, buf, BUF_SIZE, attr->type, val)
 
 #define PRINT_ATTRn(_n, _f, _p, _a)			\
 do {							\
@@ -262,6 +273,7 @@ do {							\
 int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
 			     attr__fprintf_f attr__fprintf, void *priv)
 {
+	struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 	char buf[BUF_SIZE];
 	int ret = 0;
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index f39cbbc1a7ec..cc349d9cb0f9 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -36,6 +36,18 @@ struct perf_pmu perf_pmu__fake = {
 
 #define UNIT_MAX_LEN	31 /* max length for event unit name */
 
+enum event_source {
+	/* An event loaded from /sys/devices/<pmu>/events. */
+	EVENT_SRC_SYSFS,
+	/* An event loaded from a CPUID matched json file. */
+	EVENT_SRC_CPU_JSON,
+	/*
+	 * An event loaded from a /sys/devices/<pmu>/identifier matched json
+	 * file.
+	 */
+	EVENT_SRC_SYS_JSON,
+};
+
 /**
  * struct perf_pmu_alias - An event either read from sysfs or builtin in
  * pmu-events.c, created by parsing the pmu-events json files.
@@ -425,9 +437,30 @@ static struct perf_pmu_alias *perf_pmu__find_alias(struct perf_pmu *pmu,
 {
 	struct perf_pmu_alias *alias;
 
-	if (load && !pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
+	if (load && !pmu->sysfs_aliases_loaded) {
+		bool has_sysfs_event;
+		char event_file_name[FILENAME_MAX + 8];
+
+		/*
+		 * Test if alias/event 'name' exists in the PMU's sysfs/events
+		 * directory. If not skip parsing the sysfs aliases. Sysfs event
+		 * name must be all lower or all upper case.
+		 */
+		scnprintf(event_file_name, sizeof(event_file_name), "events/%s", name);
+		for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+			event_file_name[i] = tolower(event_file_name[i]);
+
+		has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+		if (!has_sysfs_event) {
+			for (size_t i = 7, n = 7 + strlen(name); i < n; i++)
+				event_file_name[i] = toupper(event_file_name[i]);
+
+			has_sysfs_event = perf_pmu__file_exists(pmu, event_file_name);
+		}
+		if (has_sysfs_event)
+			pmu_aliases_parse(pmu);
 
+	}
 	list_for_each_entry(alias, &pmu->aliases, list) {
 		if (!strcasecmp(alias->name, name))
 			return alias;
@@ -500,7 +533,7 @@ static int update_alias(const struct pmu_event *pe,
 
 static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 				const char *desc, const char *val, FILE *val_fd,
-				const struct pmu_event *pe)
+			        const struct pmu_event *pe, enum event_source src)
 {
 	struct perf_pmu_alias *alias;
 	int ret;
@@ -552,25 +585,30 @@ static int perf_pmu__new_alias(struct perf_pmu *pmu, const char *name,
 		}
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
-	if (!pe) {
-		/* Update an event from sysfs with json data. */
-		struct update_alias_data data = {
-			.pmu = pmu,
-			.alias = alias,
-		};
-
+	switch (src) {
+	default:
+	case EVENT_SRC_SYSFS:
 		alias->from_sysfs = true;
 		if (pmu->events_table) {
+			/* Update an event from sysfs with json data. */
+			struct update_alias_data data = {
+				.pmu = pmu,
+				.alias = alias,
+			};
 			if (pmu_events_table__find_event(pmu->events_table, pmu, name,
 							 update_alias, &data) == 0)
-				pmu->loaded_json_aliases++;
+				pmu->cpu_json_aliases++;
 		}
-	}
-
-	if (!pe)
 		pmu->sysfs_aliases++;
-	else
-		pmu->loaded_json_aliases++;
+		break;
+	case  EVENT_SRC_CPU_JSON:
+		pmu->cpu_json_aliases++;
+		break;
+	case  EVENT_SRC_SYS_JSON:
+		pmu->sys_json_aliases++;
+		break;
+
+	}
 	list_add_tail(&alias->list, &pmu->aliases);
 	return 0;
 }
@@ -646,7 +684,8 @@ static int pmu_aliases_parse(struct perf_pmu *pmu)
 		}
 
 		if (perf_pmu__new_alias(pmu, name, /*desc=*/ NULL,
-					/*val=*/ NULL, file, /*pe=*/ NULL) < 0)
+					/*val=*/ NULL, file, /*pe=*/ NULL,
+					EVENT_SRC_SYSFS) < 0)
 			pr_debug("Cannot set up %s\n", name);
 		fclose(file);
 	}
@@ -900,7 +939,8 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 {
 	struct perf_pmu *pmu = vdata;
 
-	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL, pe);
+	perf_pmu__new_alias(pmu, pe->name, pe->desc, pe->event, /*val_fd=*/ NULL,
+			    pe, EVENT_SRC_CPU_JSON);
 	return 0;
 }
 
@@ -935,13 +975,14 @@ static int pmu_add_sys_aliases_iter_fn(const struct pmu_event *pe,
 		return 0;
 
 	if (pmu_uncore_alias_match(pe->pmu, pmu->name) &&
-			pmu_uncore_identifier_match(pe->compat, pmu->id)) {
+	    pmu_uncore_identifier_match(pe->compat, pmu->id)) {
 		perf_pmu__new_alias(pmu,
 				pe->name,
 				pe->desc,
 				pe->event,
 				/*val_fd=*/ NULL,
-				pe);
+				pe,
+				EVENT_SRC_SYS_JSON);
 	}
 
 	return 0;
@@ -1035,6 +1076,12 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 	pmu->max_precise = pmu_max_precise(dirfd, pmu);
 	pmu->alias_name = pmu_find_alias_name(pmu, dirfd);
 	pmu->events_table = perf_pmu__find_events_table(pmu);
+	/*
+	 * Load the sys json events/aliases when loading the PMU as each event
+	 * may have a different compat regular expression. We therefore can't
+	 * know the number of sys json events/aliases without computing the
+	 * regular expressions for them all.
+	 */
 	pmu_add_sys_aliases(pmu);
 	list_add_tail(&pmu->list, pmus);
 
@@ -1632,15 +1679,15 @@ size_t perf_pmu__num_events(struct perf_pmu *pmu)
 {
 	size_t nr;
 
-	if (!pmu->sysfs_aliases_loaded)
-		pmu_aliases_parse(pmu);
-
-	nr = pmu->sysfs_aliases;
+	pmu_aliases_parse(pmu);
+	nr = pmu->sysfs_aliases + pmu->sys_json_aliases;;
 
 	if (pmu->cpu_aliases_added)
-		 nr += pmu->loaded_json_aliases;
+		 nr += pmu->cpu_json_aliases;
 	else if (pmu->events_table)
-		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->loaded_json_aliases;
+		nr += pmu_events_table__num_events(pmu->events_table, pmu) - pmu->cpu_json_aliases;
+	else
+		assert(pmu->cpu_json_aliases == 0);
 
 	return pmu->selectable ? nr + 1 : nr;
 }
@@ -1693,6 +1740,7 @@ int perf_pmu__for_each_event(struct perf_pmu *pmu, bool skip_duplicate_pmus,
 	struct strbuf sb;
 
 	strbuf_init(&sb, /*hint=*/ 0);
+	pmu_aliases_parse(pmu);
 	pmu_add_cpu_aliases(pmu);
 	list_for_each_entry(event, &pmu->aliases, list) {
 		size_t buf_used;
@@ -2085,3 +2133,22 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->id);
 	free(pmu);
 }
+
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config)
+{
+	struct perf_pmu_alias *event;
+
+	if (!pmu)
+		return NULL;
+
+	pmu_aliases_parse(pmu);
+	pmu_add_cpu_aliases(pmu);
+	list_for_each_entry(event, &pmu->aliases, list) {
+		struct perf_event_attr attr = {.config = 0,};
+		int ret = perf_pmu__config(pmu, &attr, &event->terms, NULL);
+
+		if (ret == 0 && config == attr.config)
+			return event->name;
+	}
+	return NULL;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index e35d985206db..77c59ebc0526 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -123,8 +123,10 @@ struct perf_pmu {
 	const struct pmu_events_table *events_table;
 	/** @sysfs_aliases: Number of sysfs aliases loaded. */
 	uint32_t sysfs_aliases;
-	/** @sysfs_aliases: Number of json event aliases loaded. */
-	uint32_t loaded_json_aliases;
+	/** @cpu_json_aliases: Number of json event aliases loaded specific to the CPUID. */
+	uint32_t cpu_json_aliases;
+	/** @sys_json_aliases: Number of json event aliases loaded matching the PMU's identifier. */
+	uint32_t sys_json_aliases;
 	/** @sysfs_aliases_loaded: Are sysfs aliases loaded from disk? */
 	bool sysfs_aliases_loaded;
 	/**
@@ -273,5 +275,6 @@ struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
 struct perf_pmu *perf_pmus__find_core_pmu(void);
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu, u64 config);
 
 #endif /* __PMU_H */
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 2a0ad9ecf0a2..5c12459e9765 100644
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
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 075c0f79b1b9..0aeb97c11c03 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -103,6 +103,16 @@ int perf_pmu__scan_file(const struct perf_pmu *pmu, const char *name, const char
 	return EOF;
 }
 
+const char *perf_pmu__name_from_config(struct perf_pmu *pmu __maybe_unused, u64 config __maybe_unused)
+{
+	return NULL;
+}
+
+struct perf_pmu *perf_pmus__find_by_type(unsigned int type __maybe_unused)
+{
+	return NULL;
+}
+
 int perf_pmus__num_core_pmus(void)
 {
 	return 1;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bfc1d705f437..91d2f7f65df7 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1223,6 +1223,9 @@ static void print_metric_headers(struct perf_stat_config *config,
 
 	/* Print metrics headers only */
 	evlist__for_each_entry(evlist, counter) {
+		if (config->aggr_mode != AGGR_NONE && counter->metric_leader != counter)
+			continue;
+
 		os.evsel = counter;
 
 		perf_stat__print_shadow_stats(config, counter, 0,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9ebdb8e13c0b..68dbeae8d2bf 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1287,7 +1287,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 {
 	struct maps *kmaps = map__kmaps(map);
 	struct kcore_mapfn_data md;
-	struct map *replacement_map = NULL;
+	struct map *map_ref, *replacement_map = NULL;
 	struct machine *machine;
 	bool is_64_bit;
 	int err, fd;
@@ -1365,6 +1365,24 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 	if (!replacement_map)
 		replacement_map = list_entry(md.maps.next, struct map_list_node, node)->map;
 
+	/*
+	 * Update addresses of vmlinux map. Re-insert it to ensure maps are
+	 * correctly ordered. Do this before using maps__merge_in() for the
+	 * remaining maps so vmlinux gets split if necessary.
+	 */
+	map_ref = map__get(map);
+	maps__remove(kmaps, map_ref);
+
+	map__set_start(map_ref, map__start(replacement_map));
+	map__set_end(map_ref, map__end(replacement_map));
+	map__set_pgoff(map_ref, map__pgoff(replacement_map));
+	map__set_mapping_type(map_ref, map__mapping_type(replacement_map));
+
+	err = maps__insert(kmaps, map_ref);
+	map__put(map_ref);
+	if (err)
+		goto out_err;
+
 	/* Add new maps */
 	while (!list_empty(&md.maps)) {
 		struct map_list_node *new_node = list_entry(md.maps.next, struct map_list_node, node);
@@ -1372,22 +1390,8 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 		list_del_init(&new_node->node);
 
-		if (RC_CHK_EQUAL(new_map, replacement_map)) {
-			struct map *map_ref;
-
-			map__set_start(map, map__start(new_map));
-			map__set_end(map, map__end(new_map));
-			map__set_pgoff(map, map__pgoff(new_map));
-			map__set_mapping_type(map, map__mapping_type(new_map));
-			/* Ensure maps are correctly ordered */
-			map_ref = map__get(map);
-			maps__remove(kmaps, map_ref);
-			err = maps__insert(kmaps, map_ref);
-			map__put(map_ref);
-			map__put(new_map);
-			if (err)
-				goto out_err;
-		} else {
+		/* skip if replacement_map, already inserted above */
+		if (!RC_CHK_EQUAL(new_map, replacement_map)) {
 			/*
 			 * Merge kcore map into existing maps,
 			 * and ensure that current maps (eBPF)
@@ -1969,6 +1973,10 @@ int dso__load(struct dso *dso, struct map *map)
 	return ret;
 }
 
+/*
+ * Always takes ownership of vmlinux when vmlinux_allocated == true, even if
+ * it returns an error.
+ */
 int dso__load_vmlinux(struct dso *dso, struct map *map,
 		      const char *vmlinux, bool vmlinux_allocated)
 {
@@ -1987,8 +1995,11 @@ int dso__load_vmlinux(struct dso *dso, struct map *map,
 	else
 		symtab_type = DSO_BINARY_TYPE__VMLINUX;
 
-	if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type))
+	if (symsrc__init(&ss, dso, symfs_vmlinux, symtab_type)) {
+		if (vmlinux_allocated)
+			free((char *) vmlinux);
 		return -1;
+	}
 
 	/*
 	 * dso__load_sym() may copy 'dso' which will result in the copies having
@@ -2031,7 +2042,6 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map)
 		err = dso__load_vmlinux(dso, map, filename, true);
 		if (err > 0)
 			goto out;
-		free(filename);
 	}
 out:
 	return err;
@@ -2183,7 +2193,6 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 		err = dso__load_vmlinux(dso, map, filename, true);
 		if (err > 0)
 			return err;
-		free(filename);
 	}
 
 	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 1aa8962dcf52..515726489e36 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -39,12 +39,13 @@ int thread__init_maps(struct thread *thread, struct machine *machine)
 
 struct thread *thread__new(pid_t pid, pid_t tid)
 {
-	char *comm_str;
-	struct comm *comm;
 	RC_STRUCT(thread) *_thread = zalloc(sizeof(*_thread));
 	struct thread *thread;
 
 	if (ADD_RC_CHK(thread, _thread) != NULL) {
+		struct comm *comm;
+		char comm_str[32];
+
 		thread__set_pid(thread, pid);
 		thread__set_tid(thread, tid);
 		thread__set_ppid(thread, -1);
@@ -56,13 +57,8 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		init_rwsem(thread__namespaces_lock(thread));
 		init_rwsem(thread__comm_lock(thread));
 
-		comm_str = malloc(32);
-		if (!comm_str)
-			goto err_thread;
-
-		snprintf(comm_str, 32, ":%d", tid);
+		snprintf(comm_str, sizeof(comm_str), ":%d", tid);
 		comm = comm__new(comm_str, 0, false);
-		free(comm_str);
 		if (!comm)
 			goto err_thread;
 
@@ -76,7 +72,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 	return thread;
 
 err_thread:
-	free(thread);
+	thread__delete(thread);
 	return NULL;
 }
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh b/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh
index 6369927e9c37..48395cfd4f95 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/mlxsw_lib.sh
@@ -42,7 +42,7 @@ __mlxsw_only_on_spectrum()
 	local src=$1; shift
 
 	if ! mlxsw_on_spectrum "$rev"; then
-		log_test_skip $src:$caller "(Spectrum-$rev only)"
+		log_test_xfail $src:$caller "(Spectrum-$rev only)"
 		return 1
 	fi
 }
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
index a88d8a8c85f2..899b6892603f 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
@@ -47,7 +47,6 @@ for current_test in ${TESTS:-$ALL_TESTS}; do
 		RET=0
 		target=$(${current_test}_get_target "$should_fail")
 		if ((target == 0)); then
-			log_test_skip "'$current_test' should_fail=$should_fail test"
 			continue
 		fi
 
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
index f981c957f097..482ebb744eba 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
@@ -52,7 +52,6 @@ for current_test in ${TESTS:-$ALL_TESTS}; do
 			RET=0
 			target=$(${current_test}_get_target "$should_fail")
 			if ((target == 0)); then
-				log_test_skip "'$current_test' [$profile] should_fail=$should_fail test"
 				continue
 			fi
 			${current_test}_setup_prepare
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 3c8f2965c285..b634969cbb6f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1216,7 +1216,7 @@ void __run_test(struct __fixture_metadata *f,
 		struct __test_metadata *t)
 {
 	struct __test_xfail *xfail;
-	char *test_name;
+	char test_name[1024];
 	const char *diagnostic;
 
 	/* reset test struct */
@@ -1227,12 +1227,8 @@ void __run_test(struct __fixture_metadata *f,
 	memset(t->env, 0, sizeof(t->env));
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
-	if (asprintf(&test_name, "%s%s%s.%s", f->name,
-		variant->name[0] ? "." : "", variant->name, t->name) == -1) {
-		ksft_print_msg("ERROR ALLOCATING MEMORY\n");
-		t->exit_code = KSFT_FAIL;
-		_exit(t->exit_code);
-	}
+	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",
+		 f->name, variant->name[0] ? "." : "", variant->name, t->name);
 
 	ksft_print_msg(" RUN           %s ...\n", test_name);
 
@@ -1270,7 +1266,6 @@ void __run_test(struct __fixture_metadata *f,
 
 	ksft_test_result_code(t->exit_code, test_name,
 			      diagnostic ? "%s" : NULL, diagnostic);
-	free(test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
index 1e01d3ddc11c..200bedcdc32e 100644
--- a/tools/testing/selftests/mm/mdwe_test.c
+++ b/tools/testing/selftests/mm/mdwe_test.c
@@ -7,7 +7,6 @@
 #include <linux/mman.h>
 #include <linux/prctl.h>
 
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/auxv.h>
diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 5175a42cbe8a..7e7ed6c558da 100755
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
diff --git a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
index a40c0e9bd023..eef5cbf6eecc 100755
--- a/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
+++ b/tools/testing/selftests/net/arp_ndisc_untracked_subnets.sh
@@ -73,25 +73,19 @@ setup_v6() {
 	# namespaces. veth0 is veth-router, veth1 is veth-host.
 	# first, set up the inteface's link to the namespace
 	# then, set the interface "up"
-	ip -6 -netns ${ROUTER_NS_V6} link add name ${ROUTER_INTF} \
-		type veth peer name ${HOST_INTF}
-
-	ip -6 -netns ${ROUTER_NS_V6} link set dev ${ROUTER_INTF} up
-	ip -6 -netns ${ROUTER_NS_V6} link set dev ${HOST_INTF} netns \
-		${HOST_NS_V6}
+	ip -n ${ROUTER_NS_V6} link add name ${ROUTER_INTF} \
+		type veth peer name ${HOST_INTF} netns ${HOST_NS_V6}
 
-	ip -6 -netns ${HOST_NS_V6} link set dev ${HOST_INTF} up
-	ip -6 -netns ${ROUTER_NS_V6} addr add \
-		${ROUTER_ADDR_V6}/${PREFIX_WIDTH_V6} dev ${ROUTER_INTF} nodad
+	# Add tc rule to filter out host na message
+	tc -n ${ROUTER_NS_V6} qdisc add dev ${ROUTER_INTF} clsact
+	tc -n ${ROUTER_NS_V6} filter add dev ${ROUTER_INTF} \
+		ingress protocol ipv6 pref 1 handle 101 \
+		flower src_ip ${HOST_ADDR_V6} ip_proto icmpv6 type 136 skip_hw action pass
 
 	HOST_CONF=net.ipv6.conf.${HOST_INTF}
 	ip netns exec ${HOST_NS_V6} sysctl -qw ${HOST_CONF}.ndisc_notify=1
 	ip netns exec ${HOST_NS_V6} sysctl -qw ${HOST_CONF}.disable_ipv6=0
-	ip -6 -netns ${HOST_NS_V6} addr add ${HOST_ADDR_V6}/${PREFIX_WIDTH_V6} \
-		dev ${HOST_INTF}
-
 	ROUTER_CONF=net.ipv6.conf.${ROUTER_INTF}
-
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
 		${ROUTER_CONF}.forwarding=1 >/dev/null 2>&1
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
@@ -99,6 +93,13 @@ setup_v6() {
 	ip netns exec ${ROUTER_NS_V6} sysctl -w \
 		${ROUTER_CONF}.accept_untracked_na=${accept_untracked_na} \
 		>/dev/null 2>&1
+
+	ip -n ${ROUTER_NS_V6} link set dev ${ROUTER_INTF} up
+	ip -n ${HOST_NS_V6} link set dev ${HOST_INTF} up
+	ip -n ${ROUTER_NS_V6} addr add ${ROUTER_ADDR_V6}/${PREFIX_WIDTH_V6} \
+		dev ${ROUTER_INTF} nodad
+	ip -n ${HOST_NS_V6} addr add ${HOST_ADDR_V6}/${PREFIX_WIDTH_V6} \
+		dev ${HOST_INTF}
 	set +e
 }
 
@@ -162,26 +163,6 @@ arp_test_gratuitous_combinations() {
 	arp_test_gratuitous 2 1
 }
 
-cleanup_tcpdump() {
-	set -e
-	[[ ! -z  ${tcpdump_stdout} ]] && rm -f ${tcpdump_stdout}
-	[[ ! -z  ${tcpdump_stderr} ]] && rm -f ${tcpdump_stderr}
-	tcpdump_stdout=
-	tcpdump_stderr=
-	set +e
-}
-
-start_tcpdump() {
-	set -e
-	tcpdump_stdout=`mktemp`
-	tcpdump_stderr=`mktemp`
-	ip netns exec ${ROUTER_NS_V6} timeout 15s \
-		tcpdump --immediate-mode -tpni ${ROUTER_INTF} -c 1 \
-		"icmp6 && icmp6[0] == 136 && src ${HOST_ADDR_V6}" \
-		> ${tcpdump_stdout} 2> /dev/null
-	set +e
-}
-
 verify_ndisc() {
 	local accept_untracked_na=$1
 	local same_subnet=$2
@@ -222,8 +203,9 @@ ndisc_test_untracked_advertisements() {
 			HOST_ADDR_V6=2001:db8:abcd:0012::3
 		fi
 	fi
-	setup_v6 $1 $2
-	start_tcpdump
+	setup_v6 $1
+	slowwait_for_counter 15 1 \
+		tc_rule_handle_stats_get "dev ${ROUTER_INTF} ingress" 101 ".packets" "-n ${ROUTER_NS_V6}"
 
 	if verify_ndisc $1 $2; then
 		printf "    TEST: %-60s  [ OK ]\n" "${test_msg[*]}"
@@ -231,7 +213,6 @@ ndisc_test_untracked_advertisements() {
 		printf "    TEST: %-60s  [FAIL]\n" "${test_msg[*]}"
 	fi
 
-	cleanup_tcpdump
 	cleanup_v6
 	set +e
 }
diff --git a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
index 41a34a61f763..e78776db850f 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_rmon.sh
@@ -78,7 +78,7 @@ rmon_histogram()
 
 		for if in $iface $neigh; do
 			if ! ensure_mtu $if ${bucket[0]}; then
-				log_test_skip "$if does not support the required MTU for $step"
+				log_test_xfail "$if does not support the required MTU for $step"
 				return
 			fi
 		done
@@ -93,7 +93,7 @@ rmon_histogram()
 		jq -r ".[0].rmon[\"${set}-pktsNtoM\"][]|[.low, .high]|@tsv" 2>/dev/null)
 
 	if [ $nbuckets -eq 0 ]; then
-		log_test_skip "$iface does not support $set histogram counters"
+		log_test_xfail "$iface does not support $set histogram counters"
 		return
 	fi
 }
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index e579c2e0c462..e78f11140edd 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -38,32 +38,6 @@ fi
 
 source "$net_forwarding_dir/../lib.sh"
 
-# timeout in seconds
-slowwait()
-{
-	local timeout=$1; shift
-
-	local start_time="$(date -u +%s)"
-	while true
-	do
-		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
-			echo -n "$out"
-			return 0
-		fi
-
-		local current_time="$(date -u +%s)"
-		if ((current_time - start_time > timeout)); then
-			echo -n "$out"
-			return 1
-		fi
-
-		sleep 0.1
-	done
-}
-
 ##############################################################################
 # Sanity checks
 
@@ -358,14 +332,24 @@ EXIT_STATUS=0
 # Per-test return value. Clear at the beginning of each test.
 RET=0
 
+ret_set_ksft_status()
+{
+	local ksft_status=$1; shift
+	local msg=$1; shift
+
+	RET=$(ksft_status_merge $RET $ksft_status)
+	if (( $? )); then
+		retmsg=$msg
+	fi
+}
+
 check_err()
 {
 	local err=$1
 	local msg=$2
 
-	if [[ $RET -eq 0 && $err -ne 0 ]]; then
-		RET=$err
-		retmsg=$msg
+	if ((err)); then
+		ret_set_ksft_status $ksft_fail "$msg"
 	fi
 }
 
@@ -374,10 +358,7 @@ check_fail()
 	local err=$1
 	local msg=$2
 
-	if [[ $RET -eq 0 && $err -eq 0 ]]; then
-		RET=1
-		retmsg=$msg
-	fi
+	check_err $((!err)) "$msg"
 }
 
 check_err_fail()
@@ -393,6 +374,62 @@ check_err_fail()
 	fi
 }
 
+log_test_result()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+	local result=$1; shift
+	local retmsg=$1; shift
+
+	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
+	if [[ $retmsg ]]; then
+		printf "\t%s\n" "$retmsg"
+	fi
+}
+
+pause_on_fail()
+{
+	if [[ $PAUSE_ON_FAIL == yes ]]; then
+		echo "Hit enter to continue, 'q' to quit"
+		read a
+		[[ $a == q ]] && exit 1
+	fi
+}
+
+handle_test_result_pass()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" " OK "
+}
+
+handle_test_result_fail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_xfail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_skip()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
+}
+
 log_test()
 {
 	local test_name=$1
@@ -402,31 +439,28 @@ log_test()
 		opt_str="($opt_str)"
 	fi
 
-	if [[ $RET -ne 0 ]]; then
-		EXIT_STATUS=1
-		printf "TEST: %-60s  [FAIL]\n" "$test_name $opt_str"
-		if [[ ! -z "$retmsg" ]]; then
-			printf "\t%s\n" "$retmsg"
-		fi
-		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
-			echo "Hit enter to continue, 'q' to quit"
-			read a
-			[ "$a" = "q" ] && exit 1
-		fi
-		return 1
+	if ((RET == ksft_pass)); then
+		handle_test_result_pass "$test_name" "$opt_str"
+	elif ((RET == ksft_xfail)); then
+		handle_test_result_xfail "$test_name" "$opt_str"
+	elif ((RET == ksft_skip)); then
+		handle_test_result_skip "$test_name" "$opt_str"
+	else
+		handle_test_result_fail "$test_name" "$opt_str"
 	fi
 
-	printf "TEST: %-60s  [ OK ]\n" "$test_name $opt_str"
-	return 0
+	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
+	return $RET
 }
 
 log_test_skip()
 {
-	local test_name=$1
-	local opt_str=$2
+	RET=$ksft_skip retmsg= log_test "$@"
+}
 
-	printf "TEST: %-60s  [SKIP]\n" "$test_name $opt_str"
-	return 0
+log_test_xfail()
+{
+	RET=$ksft_xfail retmsg= log_test "$@"
 }
 
 log_info()
@@ -487,33 +521,6 @@ wait_for_trap()
 	"$@" | grep -q trap
 }
 
-until_counter_is()
-{
-	local expr=$1; shift
-	local current=$("$@")
-
-	echo $((current))
-	((current $expr))
-}
-
-busywait_for_counter()
-{
-	local timeout=$1; shift
-	local delta=$1; shift
-
-	local base=$("$@")
-	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
-}
-
-slowwait_for_counter()
-{
-	local timeout=$1; shift
-	local delta=$1; shift
-
-	local base=$("$@")
-	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
-}
-
 setup_wait_dev()
 {
 	local dev=$1; shift
@@ -819,29 +826,6 @@ link_stats_rx_errors_get()
 	link_stats_get $1 rx errors
 }
 
-tc_rule_stats_get()
-{
-	local dev=$1; shift
-	local pref=$1; shift
-	local dir=$1; shift
-	local selector=${1:-.packets}; shift
-
-	tc -j -s filter show dev $dev ${dir:-ingress} pref $pref \
-	    | jq ".[1].options.actions[].stats$selector"
-}
-
-tc_rule_handle_stats_get()
-{
-	local id=$1; shift
-	local handle=$1; shift
-	local selector=${1:-.packets}; shift
-	local netns=${1:-""}; shift
-
-	tc $netns -j -s filter show $id \
-	    | jq ".[] | select(.options.handle == $handle) | \
-		  .options.actions[0].stats$selector"
-}
-
 ethtool_stats_get()
 {
 	local dev=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
index 7e7d62161c34..b2d2c6cecc01 100644
--- a/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
+++ b/tools/testing/selftests/net/forwarding/router_mpath_nh_lib.sh
@@ -69,7 +69,7 @@ nh_stats_test_dispatch_swhw()
 		nh_stats_do_test "HW $what" "$nh1_id" "$nh2_id" "$group_id" \
 				 nh_stats_get_hw "${mz[@]}"
 	elif [[ $kind == veth ]]; then
-		log_test_skip "HW stats not offloaded on veth topology"
+		log_test_xfail "HW stats not offloaded on veth topology"
 	fi
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 56a9454b7ba3..cf7fe4d550dd 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -14,9 +14,50 @@ NS_LIST=""
 
 ##############################################################################
 # Helpers
-busywait()
+
+__ksft_status_merge()
 {
-	local timeout=$1; shift
+	local a=$1; shift
+	local b=$1; shift
+	local -A weights
+	local weight=0
+
+	local i
+	for i in "$@"; do
+		weights[$i]=$((weight++))
+	done
+
+	if [[ ${weights[$a]} > ${weights[$b]} ]]; then
+		echo "$a"
+		return 0
+	else
+		echo "$b"
+		return 1
+	fi
+}
+
+ksft_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+
+	__ksft_status_merge "$a" "$b" \
+		$ksft_pass $ksft_xfail $ksft_skip $ksft_fail
+}
+
+ksft_exit_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+
+	__ksft_status_merge "$a" "$b" \
+		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
+}
+
+loopy_wait()
+{
+	local sleep_cmd=$1; shift
+	local timeout_ms=$1; shift
 
 	local start_time="$(date -u +%s%3N)"
 	while true
@@ -30,13 +71,57 @@ busywait()
 		fi
 
 		local current_time="$(date -u +%s%3N)"
-		if ((current_time - start_time > timeout)); then
+		if ((current_time - start_time > timeout_ms)); then
 			echo -n "$out"
 			return 1
 		fi
+
+		$sleep_cmd
 	done
 }
 
+busywait()
+{
+	local timeout_ms=$1; shift
+
+	loopy_wait : "$timeout_ms" "$@"
+}
+
+# timeout in seconds
+slowwait()
+{
+	local timeout_sec=$1; shift
+
+	loopy_wait "sleep 0.1" "$((timeout_sec * 1000))" "$@"
+}
+
+until_counter_is()
+{
+	local expr=$1; shift
+	local current=$("$@")
+
+	echo $((current))
+	((current $expr))
+}
+
+busywait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
+slowwait_for_counter()
+{
+	local timeout=$1; shift
+	local delta=$1; shift
+
+	local base=$("$@")
+	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
+}
+
 cleanup_ns()
 {
 	local ns=""
@@ -96,3 +181,26 @@ setup_ns()
 	done
 	NS_LIST="$NS_LIST $ns_list"
 }
+
+tc_rule_stats_get()
+{
+	local dev=$1; shift
+	local pref=$1; shift
+	local dir=$1; shift
+	local selector=${1:-.packets}; shift
+
+	tc -j -s filter show dev $dev ${dir:-ingress} pref $pref \
+	    | jq ".[1].options.actions[].stats$selector"
+}
+
+tc_rule_handle_stats_get()
+{
+	local id=$1; shift
+	local handle=$1; shift
+	local selector=${1:-.packets}; shift
+	local netns=${1:-""}; shift
+
+	tc $netns -j -s filter show $id \
+	    | jq ".[] | select(.options.handle == $handle) | \
+		  .options.actions[0].stats$selector"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e4403236f655..1b5722e6166e 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -125,8 +125,8 @@ init_shapers()
 {
 	local i
 	for i in $(seq 1 4); do
-		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1
-		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1
+		tc -n $ns1 qdisc add dev ns1eth$i root netem rate 20mbit delay 1ms
+		tc -n $ns2 qdisc add dev ns2eth$i root netem rate 20mbit delay 1ms
 	done
 }
 
@@ -262,6 +262,8 @@ reset()
 
 	TEST_NAME="${1}"
 
+	MPTCP_LIB_SUBTEST_FLAKY=0 # reset if modified
+
 	if skip_test; then
 		MPTCP_LIB_TEST_COUNTER=$((MPTCP_LIB_TEST_COUNTER+1))
 		last_test_ignored=1
@@ -449,7 +451,9 @@ reset_with_tcp_filter()
 # $1: err msg
 fail_test()
 {
-	ret=${KSFT_FAIL}
+	if ! mptcp_lib_subtest_is_flaky; then
+		ret=${KSFT_FAIL}
+	fi
 
 	if [ ${#} -gt 0 ]; then
 		print_fail "${@}"
@@ -3178,6 +3182,7 @@ fullmesh_tests()
 fastclose_tests()
 {
 	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=client \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0
@@ -3186,6 +3191,7 @@ fastclose_tests()
 	fi
 
 	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=1024 fastclose=server \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 0 0 0 1
@@ -3204,6 +3210,7 @@ fail_tests()
 {
 	# single subflow
 	if reset_with_fail "Infinite map" 1; then
+		MPTCP_LIB_SUBTEST_FLAKY=1
 		test_linkfail=128 \
 			run_tests $ns1 $ns2 10.0.1.1
 		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
@@ -3212,7 +3219,8 @@ fail_tests()
 
 	# multiple subflows
 	if reset_with_fail "MP_FAIL MP_RST" 2; then
-		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5
+		MPTCP_LIB_SUBTEST_FLAKY=1
+		tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 5ms
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 dev ns2eth2 flags subflow
diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
index 1b2366220388..7322e1e4e5db 100755
--- a/tools/testing/selftests/net/mptcp/simult_flows.sh
+++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
@@ -216,8 +216,8 @@ run_test()
 	shift 4
 	local msg=$*
 
-	[ $delay1 -gt 0 ] && delay1="delay $delay1" || delay1=""
-	[ $delay2 -gt 0 ] && delay2="delay $delay2" || delay2=""
+	[ $delay1 -gt 0 ] && delay1="delay ${delay1}ms" || delay1=""
+	[ $delay2 -gt 0 ] && delay2="delay ${delay2}ms" || delay2=""
 
 	for dev in ns1eth1 ns1eth2; do
 		tc -n $ns1 qdisc del dev $dev root >/dev/null 2>&1
@@ -243,7 +243,7 @@ run_test()
 	do_transfer $small $large $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -253,7 +253,7 @@ run_test()
 	do_transfer $large $small $time
 	lret=$?
 	mptcp_lib_result_code "${lret}" "${msg}"
-	if [ $lret -ne 0 ]; then
+	if [ $lret -ne 0 ] && ! mptcp_lib_subtest_is_flaky; then
 		ret=$lret
 		[ $bail -eq 0 ] || exit $ret
 	fi
@@ -286,7 +286,7 @@ run_test 10 10 0 0 "balanced bwidth"
 run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
 
 # we still need some additional infrastructure to pass the following test-cases
-run_test 10 3 0 0 "unbalanced bwidth"
+MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"
 run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
 run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
 
diff --git a/tools/testing/selftests/powerpc/dexcr/Makefile b/tools/testing/selftests/powerpc/dexcr/Makefile
index 76210f2bcec3..829ad075b4a4 100644
--- a/tools/testing/selftests/powerpc/dexcr/Makefile
+++ b/tools/testing/selftests/powerpc/dexcr/Makefile
@@ -3,7 +3,7 @@ TEST_GEN_FILES := lsdexcr
 
 include ../../lib.mk
 
-$(OUTPUT)/hashchk_test: CFLAGS += -fno-pie $(call cc-option,-mno-rop-protect)
+$(OUTPUT)/hashchk_test: CFLAGS += -fno-pie -no-pie $(call cc-option,-mno-rop-protect)
 
 $(TEST_GEN_PROGS): ../harness.c ../utils.c ./dexcr.c
 $(TEST_GEN_FILES): ../utils.c ./dexcr.c
diff --git a/tools/testing/selftests/riscv/hwprobe/.gitignore b/tools/testing/selftests/riscv/hwprobe/.gitignore
index 8113dc3bdd03..6e384e80ea1a 100644
--- a/tools/testing/selftests/riscv/hwprobe/.gitignore
+++ b/tools/testing/selftests/riscv/hwprobe/.gitignore
@@ -1 +1,3 @@
 hwprobe
+cbo
+which-cpus
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 12da0a939e3e..557fb074acf0 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -132,6 +132,50 @@
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
     },
+    {
+        "id": "6f62",
+        "name": "Add taprio Qdisc with too short interval",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 queues 1@0 1@1 sched-entry S 01 300 sched-entry S 02 1700 clockid CLOCK_TAI",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc taprio 1: root refcnt",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "831f",
+        "name": "Add taprio Qdisc with too short cycle-time",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $ETH root handle 1: taprio num_tc 2 queues 1@0 1@1 sched-entry S 01 200000 sched-entry S 02 200000 cycle-time 100 clockid CLOCK_TAI",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $ETH",
+        "matchPattern": "qdisc taprio 1: root refcnt",
+        "matchCount": "0",
+        "teardown": [
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
     {
         "id": "3e1e",
         "name": "Add taprio Qdisc with an invalid cycle-time",

