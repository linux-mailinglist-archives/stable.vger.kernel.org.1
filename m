Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002057B8864
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbjJDSPj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244044AbjJDSPi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:15:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F360A6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:15:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97502C433C7;
        Wed,  4 Oct 2023 18:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443334;
        bh=j5+jAqh6G3p5vCvDLwP8VZxLBLW08gwXz0gSHZHo090=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhocQLt0vjWYzEAVD2YkYHIBuhK2WNrDvJ7YkqZDtSfgqaBGFTN0YZsIOux1pq2AV
         7mRaR+0Xv/1gF1HDUv5m/5FLBJG1PZTEDx4u52OyB8Fgrs55UwD3CxZ8BBcd2CcTjT
         uVlhbUFhQaPGo006WKg1ZKcsoNPb2I9Iod18S3kw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 119/259] ARM: dts: omap: correct indentation
Date:   Wed,  4 Oct 2023 19:54:52 +0200
Message-ID: <20231004175222.825025441@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 8ae9c7a69fa14e95d032e64d8d758e3f85bee132 ]

Do not use spaces for indentation.

Link: https://lore.kernel.org/r/20221002092002.68880-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Stable-dep-of: 6469b2feade8 ("ARM: dts: ti: omap: Fix bandgap thermal cells addressing for omap3/4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi |  6 +--
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi |  6 +--
 arch/arm/boot/dts/omap3-cm-t3517.dts      | 12 ++---
 arch/arm/boot/dts/omap3-gta04.dtsi        |  6 +--
 arch/arm/boot/dts/omap3-ldp.dts           |  2 +-
 arch/arm/boot/dts/omap3-n900.dts          | 38 +++++++-------
 arch/arm/boot/dts/omap3-zoom3.dts         | 44 ++++++++--------
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi  | 24 ++++-----
 arch/arm/boot/dts/omap5-cm-t54.dts        | 64 +++++++++++------------
 9 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
index ce6c235f68ec6..3046ec572632d 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -8,9 +8,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
index e7534fe9c53cf..bc8961f3690f0 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
@@ -12,9 +12,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
index 3b8349094baa6..f25c0a84a190c 100644
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -11,12 +11,12 @@
 	model = "CompuLab CM-T3517";
 	compatible = "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
 
-	vmmc:  regulator-vmmc {
-                compatible = "regulator-fixed";
-                regulator-name = "vmmc";
-                regulator-min-microvolt = <3300000>;
-                regulator-max-microvolt = <3300000>;
-        };
+	vmmc: regulator-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
 	wl12xx_vmmc2: wl12xx_vmmc2 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 2dbee248a126f..da578719ac5a2 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -332,7 +332,7 @@
 			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
 			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
 		>;
-       };
+	};
 
 	gps_pins: pinmux_gps_pins {
 		pinctrl-single,pins = <
@@ -869,8 +869,8 @@
 };
 
 &hdqw1w {
-        pinctrl-names = "default";
-        pinctrl-0 = <&hdq_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdq_pins>;
 };
 
 /* image signal processor within OMAP3 SoC */
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 36fc8805e0c15..85f33bbb566f9 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -301,5 +301,5 @@
 
 &vaux1 {
 	/* Needed for ads7846 */
-        regulator-name = "vcc";
+	regulator-name = "vcc";
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index dd79715564498..98a67581bdd23 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -236,27 +236,27 @@
 		pinctrl-single,pins = <
 
 			/* address lines */
-                        OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
-                        OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
-                        OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
+			OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
+			OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
+			OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
 
 			/* data lines, gpmc_d0..d7 not muxable according to TRM */
-                        OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
-                        OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
-                        OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
-                        OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
-                        OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
-                        OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
-                        OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
-                        OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
+			OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
+			OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
+			OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
+			OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
+			OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
+			OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
+			OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
+			OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
 
 			/*
 			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
 			 * according to TRM. OneNAND seems to require PIN_INPUT on clock.
 			 */
-                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
-                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
-		>;
+			OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
+			OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
+			>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
@@ -738,12 +738,12 @@
 
 	si4713: si4713@63 {
 		compatible = "silabs,si4713";
-                reg = <0x63>;
+		reg = <0x63>;
 
-                interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
-                reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
-                vio-supply = <&vio>;
-                vdd-supply = <&vaux1>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
+		reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
+		vio-supply = <&vio>;
+		vdd-supply = <&vaux1>;
 	};
 
 	bq24150a: bq24150a@6b {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 0482676d18306..ce58b1f208e81 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -23,9 +23,9 @@
 	};
 
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
@@ -84,28 +84,28 @@
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
-                        OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
-                        OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
-                        OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
+			OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
-                        OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
-                        OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
-                        OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
-                        OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
-                        OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
-                        OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
@@ -205,22 +205,22 @@
 };
 
 &uart1 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 };
 
 &uart2 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart3_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
 };
 
 &uart4 {
-       status = "disabled";
+	status = "disabled";
 };
 
 &usb_otg_hs {
diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
index 4d7eeb133dadd..801b4f10350c1 100644
--- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -13,20 +13,20 @@ cpu_thermal: cpu_thermal {
 	polling-delay = <1000>; /* milliseconds */
 
 			/* sensor       ID */
-        thermal-sensors = <&bandgap     0>;
+	thermal-sensors = <&bandgap     0>;
 
 	cpu_trips: trips {
-                cpu_alert0: cpu_alert {
-                        temperature = <100000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "passive";
-                };
-                cpu_crit: cpu_crit {
-                        temperature = <125000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "critical";
-                };
-        };
+		cpu_alert0: cpu_alert {
+			temperature = <100000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu_crit: cpu_crit {
+			temperature = <125000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
 
 	cpu_cooling_maps: cooling-maps {
 		map0 {
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index e62ea8b6d53fd..af288d63a26a4 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -84,36 +84,36 @@
 	};
 
 	lcd0: display {
-                compatible = "startek,startek-kd050c", "panel-dpi";
-                label = "lcd";
-
-                pinctrl-names = "default";
-                pinctrl-0 = <&lcd_pins>;
-
-                enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
-
-                panel-timing {
-                        clock-frequency = <33000000>;
-                        hactive = <800>;
-                        vactive = <480>;
-                        hfront-porch = <40>;
-                        hback-porch = <40>;
-                        hsync-len = <43>;
-                        vback-porch = <29>;
-                        vfront-porch = <13>;
-                        vsync-len = <3>;
-                        hsync-active = <0>;
-                        vsync-active = <0>;
-                        de-active = <1>;
-                        pixelclk-active = <1>;
-                };
-
-                port {
-                        lcd_in: endpoint {
-                                remote-endpoint = <&dpi_lcd_out>;
-                        };
-                };
-        };
+		compatible = "startek,startek-kd050c", "panel-dpi";
+		label = "lcd";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+
+		enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			hsync-len = <43>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_lcd_out>;
+			};
+		};
+	};
 
 	hdmi0: connector0 {
 		compatible = "hdmi-connector";
@@ -644,8 +644,8 @@
 };
 
 &usb3 {
-       extcon = <&extcon_usb3>;
-       vbus-supply = <&smps10_out1_reg>;
+	extcon = <&extcon_usb3>;
+	vbus-supply = <&smps10_out1_reg>;
 };
 
 &cpu0 {
-- 
2.40.1



