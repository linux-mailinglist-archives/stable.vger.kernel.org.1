Return-Path: <stable+bounces-185777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6090BBDDF7F
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 12:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744B3425B36
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 10:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42331D36D;
	Wed, 15 Oct 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MKy8GrBw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD731D361;
	Wed, 15 Oct 2025 10:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523956; cv=none; b=t/1COfGUTvJYgFcL9pqEw0fxkENagFbpH7m4NJDv5UtCQMX8Ma86v60QGc0XnkHXR2vJ6I+WPfMpC1NimcSbceKqcobtJlBr2mcbwF8LCFe+0p6riXFqPwia+cT/MtXpc5Z8sp790WK7ZJEJYJ/Exfm/G1xnhxpP3O4Ykh/DZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523956; c=relaxed/simple;
	bh=1FZSZpsqVff6t8bKZ9sse33GKO4IYmi4bl47XGi7Trs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVqJbeQ0rzbYFjzI/u1byIISS530hh0KB+nXq1VRFR31VZ0GTFHNrPPF046rUuvNryGMqnes3TOPxpE+eSmbS+3wf6AkX9gyJFHyEflCGY3xMzuiqg/DdKF9MADxuZMRB9H2s/B8OwSIwty3D8vGeBoKdRXYZ9pPhAuJTwUFhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MKy8GrBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9B3C4CEF8;
	Wed, 15 Oct 2025 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760523955;
	bh=1FZSZpsqVff6t8bKZ9sse33GKO4IYmi4bl47XGi7Trs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MKy8GrBw0r9R2kO6eXN9n+55m1Akz8F5+pKX+DbHPFDE9UK5hQ2QvCp1WXgw2sA18
	 GDDw80XNyJHR68tpY03JuI6rn8Zc+rjVwrL/1E6sVuuN8DGpocyv6nVnuuupLJX/Mc
	 +tFQFm+a6+U5G44Kt38a4wPjB+kVsTxVG/c3nuFE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.53
Date: Wed, 15 Oct 2025 12:25:43 +0200
Message-ID: <2025101542-deduce-shorty-dde3@gregkh>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101542-rogue-wired-4c6c@gregkh>
References: <2025101542-rogue-wired-4c6c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/trace/histogram-design.rst b/Documentation/trace/histogram-design.rst
index 5765eb3e9efa..a30f4bed11b4 100644
--- a/Documentation/trace/histogram-design.rst
+++ b/Documentation/trace/histogram-design.rst
@@ -380,7 +380,9 @@ entry, ts0, corresponding to the ts0 variable in the sched_waking
 trigger above.
 
 sched_waking histogram
-----------------------::
+----------------------
+
+.. code-block::
 
   +------------------+
   | hist_data        |<-------------------------------------------------------+
diff --git a/Makefile b/Makefile
index 3345d6257350..a4a2228276e6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 52
+SUBLEVEL = 53
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/renesas/r8a7791-porter.dts b/arch/arm/boot/dts/renesas/r8a7791-porter.dts
index 93c86e921645..b255eb228dd7 100644
--- a/arch/arm/boot/dts/renesas/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/renesas/r8a7791-porter.dts
@@ -290,7 +290,7 @@ vin0_pins: vin0 {
 	};
 
 	can0_pins: can0 {
-		groups = "can0_data";
+		groups = "can0_data_b";
 		function = "can0";
 	};
 
diff --git a/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi b/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi
index a4beb718559c..9ee9e7a1343c 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am335x-baltos.dtsi
@@ -270,7 +270,7 @@ &tps {
 	vcc7-supply = <&vbat>;
 	vccio-supply = <&vbat>;
 
-	ti,en-ck32k-xtal = <1>;
+	ti,en-ck32k-xtal;
 
 	regulators {
 		vrtc_reg: regulator@0 {
diff --git a/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts b/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts
index 06767ea164b5..ece7f7854f6a 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-cm-t335.dts
@@ -483,8 +483,6 @@ &mcasp1 {
 
 		op-mode = <0>;          /* MCASP_IIS_MODE */
 		tdm-slots = <2>;
-		/* 16 serializers */
-		num-serializer = <16>;
 		serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
 			0 0 2 1 0 0 0 0 0 0 0 0 0 0 0 0
 		>;
diff --git a/arch/arm/boot/dts/ti/omap/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-devkit8000-lcd-common.dtsi
index a7f99ae0c1fe..78c657429f64 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-devkit8000-lcd-common.dtsi
@@ -65,7 +65,7 @@ ads7846@0 {
 		ti,debounce-max = /bits/ 16 <10>;
 		ti,debounce-tol = /bits/ 16 <5>;
 		ti,debounce-rep = /bits/ 16 <1>;
-		ti,keep-vref-on = <1>;
+		ti,keep-vref-on;
 		ti,settle-delay-usec = /bits/ 16 <150>;
 
 		wakeup-source;
diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index e5869cca5e79..94dece1839af 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -872,7 +872,7 @@ e_done:
 /**
  * at91_mckx_ps_restore: restore MCK1..4 settings
  *
- * Side effects: overwrites tmp1, tmp2
+ * Side effects: overwrites tmp1, tmp2 and tmp3
  */
 .macro at91_mckx_ps_restore
 #ifdef CONFIG_SOC_SAMA7
@@ -916,7 +916,7 @@ r_ps:
 	bic	tmp3, tmp3, #AT91_PMC_MCR_V2_ID_MSK
 	orr	tmp3, tmp3, tmp1
 	orr	tmp3, tmp3, #AT91_PMC_MCR_V2_CMD
-	str	tmp2, [pmc, #AT91_PMC_MCR_V2]
+	str	tmp3, [pmc, #AT91_PMC_MCR_V2]
 
 	wait_mckrdy tmp1
 
diff --git a/arch/arm64/boot/dts/apple/t8103-j457.dts b/arch/arm64/boot/dts/apple/t8103-j457.dts
index 152f95fd49a2..7089ccf3ce55 100644
--- a/arch/arm64/boot/dts/apple/t8103-j457.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j457.dts
@@ -21,6 +21,14 @@ aliases {
 	};
 };
 
+/*
+ * Adjust pcie0's iommu-map to account for the disabled port01.
+ */
+&pcie0 {
+	iommu-map = <0x100 &pcie0_dart_0 1 1>,
+			<0x200 &pcie0_dart_2 1 1>;
+};
+
 &bluetooth0 {
 	brcm,board-type = "apple,santorini";
 };
@@ -36,10 +44,10 @@ &wifi0 {
  */
 
 &port02 {
-	bus-range = <3 3>;
+	bus-range = <2 2>;
 	status = "okay";
 	ethernet0: ethernet@0,0 {
-		reg = <0x30000 0x0 0x0 0x0 0x0>;
+		reg = <0x20000 0x0 0x0 0x0 0x0>;
 		/* To be filled by the loader */
 		local-mac-address = [00 10 18 00 00 00];
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
index 89e97c604bd3..c3d2ddd887fd 100644
--- a/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-kontron-bl-osm-s.dts
@@ -33,7 +33,9 @@ pwm-beeper {
 
 	reg_vcc_panel: regulator-vcc-panel {
 		compatible = "regulator-fixed";
-		gpio = <&gpio4 3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_reg_vcc_panel>;
+		gpio = <&gpio2 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
@@ -135,6 +137,16 @@ &tpm6 {
 };
 
 &usbotg1 {
+	adp-disable;
+	hnp-disable;
+	srp-disable;
+	disable-over-current;
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+};
+
+&usbotg2 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 	disable-over-current;
@@ -147,17 +159,15 @@ usb1@1 {
 	};
 };
 
-&usbotg2 {
-	adp-disable;
-	hnp-disable;
-	srp-disable;
-	disable-over-current;
-	dr_mode = "otg";
-	usb-role-switch;
-	status = "okay";
-};
-
 &usdhc2 {
 	vmmc-supply = <&reg_vdd_3v3>;
 	status = "okay";
 };
+
+&iomuxc {
+	pinctrl_reg_vcc_panel: regvccpanelgrp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO21__GPIO2_IO21		0x31e /* PWM_2 */
+		>;
+	};
+};
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 7365d6538a73..ddbc94c375e0 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -822,7 +822,7 @@ lpuart7: serial@42690000 {
 				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART7>;
 				clock-names = "ipg";
-				dmas = <&edma2 26 0 FSL_EDMA_RX>, <&edma2 25 0 0>;
+				dmas = <&edma2 88 0 FSL_EDMA_RX>, <&edma2 87 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
@@ -834,7 +834,7 @@ lpuart8: serial@426a0000 {
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&scmi_clk IMX95_CLK_LPUART8>;
 				clock-names = "ipg";
-				dmas = <&edma2 28 0 FSL_EDMA_RX>, <&edma2 27 0 0>;
+				dmas = <&edma2 90 0 FSL_EDMA_RX>, <&edma2 89 0 0>;
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/mediatek/mt6331.dtsi b/arch/arm64/boot/dts/mediatek/mt6331.dtsi
index d89858c73ab1..243afbffa21f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6331.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6331.dtsi
@@ -6,12 +6,12 @@
 #include <dt-bindings/input/input.h>
 
 &pwrap {
-	pmic: mt6331 {
+	pmic: pmic {
 		compatible = "mediatek,mt6331";
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
-		mt6331regulator: mt6331regulator {
+		mt6331regulator: regulators {
 			compatible = "mediatek,mt6331-regulator";
 
 			mt6331_vdvfs11_reg: buck-vdvfs11 {
@@ -258,7 +258,7 @@ mt6331_vrtc_reg: ldo-vrtc {
 			};
 
 			mt6331_vdig18_reg: ldo-vdig18 {
-				regulator-name = "dvdd18_dig";
+				regulator-name = "vdig18";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-ramp-delay = <0>;
@@ -266,11 +266,11 @@ mt6331_vdig18_reg: ldo-vdig18 {
 			};
 		};
 
-		mt6331rtc: mt6331rtc {
+		mt6331rtc: rtc {
 			compatible = "mediatek,mt6331-rtc";
 		};
 
-		mt6331keys: mt6331keys {
+		mt6331keys: keys {
 			compatible = "mediatek,mt6331-keys";
 			power {
 				linux,keycodes = <KEY_POWER>;
diff --git a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
index 91de920c2245..03cc48321a3f 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
+++ b/arch/arm64/boot/dts/mediatek/mt6795-sony-xperia-m5.dts
@@ -212,7 +212,7 @@ proximity@48 {
 
 &mmc0 {
 	/* eMMC controller */
-	mediatek,latch-ck = <0x14>; /* hs400 */
+	mediatek,latch-ck = <4>; /* hs400 */
 	mediatek,hs200-cmd-int-delay = <1>;
 	mediatek,hs400-cmd-int-delay = <1>;
 	mediatek,hs400-ds-dly3 = <0x1a>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
index 7c971198fa95..72a2a2bff0a9 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-krabby.dtsi
@@ -71,14 +71,14 @@ &i2c1 {
 	i2c-scl-internal-delay-ns = <10000>;
 
 	touchscreen: touchscreen@10 {
-		compatible = "hid-over-i2c";
+		compatible = "elan,ekth6915";
 		reg = <0x10>;
 		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&touchscreen_pins>;
-		post-power-on-delay-ms = <10>;
-		hid-descr-addr = <0x0001>;
-		vdd-supply = <&pp3300_s3>;
+		reset-gpios = <&pio 60 GPIO_ACTIVE_LOW>;
+		vcc33-supply = <&pp3300_s3>;
+		no-reset-on-power-off;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
index 26d3451a5e47..24d9ede63eaa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola-tentacruel-sku262144.dts
@@ -42,3 +42,7 @@ MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
 		CROS_STD_MAIN_KEYMAP
 	>;
 };
+
+&touchscreen {
+	compatible = "elan,ekth6a12nay";
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 2e138b54f556..451aa278bef5 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -1563,9 +1563,6 @@ pcie0: pcie@112f0000 {
 
 			power-domains = <&spm MT8195_POWER_DOMAIN_PCIE_MAC_P0>;
 
-			resets = <&infracfg_ao MT8195_INFRA_RST2_PCIE_P0_SWRST>;
-			reset-names = "mac";
-
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 7>;
 			interrupt-map = <0 0 0 1 &pcie_intc0 0>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
index e2e75b8ff918..9ab4fee769e4 100644
--- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
@@ -351,7 +351,7 @@ regulator {
 			LDO_VIN2-supply = <&vsys>;
 			LDO_VIN3-supply = <&vsys>;
 
-			mt6360_buck1: BUCK1 {
+			mt6360_buck1: buck1 {
 				regulator-name = "emi_vdd2";
 				regulator-min-microvolt = <600000>;
 				regulator-max-microvolt = <1800000>;
@@ -361,7 +361,7 @@ MT6360_OPMODE_LP
 				regulator-always-on;
 			};
 
-			mt6360_buck2: BUCK2 {
+			mt6360_buck2: buck2 {
 				regulator-name = "emi_vddq";
 				regulator-min-microvolt = <300000>;
 				regulator-max-microvolt = <1300000>;
@@ -371,7 +371,7 @@ MT6360_OPMODE_LP
 				regulator-always-on;
 			};
 
-			mt6360_ldo1: LDO1 {
+			mt6360_ldo1: ldo1 {
 				regulator-name = "mt6360_ldo1"; /* Test point */
 				regulator-min-microvolt = <1200000>;
 				regulator-max-microvolt = <3600000>;
@@ -379,7 +379,7 @@ mt6360_ldo1: LDO1 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo2: LDO2 {
+			mt6360_ldo2: ldo2 {
 				regulator-name = "panel1_p1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
@@ -387,7 +387,7 @@ mt6360_ldo2: LDO2 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo3: LDO3 {
+			mt6360_ldo3: ldo3 {
 				regulator-name = "vmc_pmu";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
@@ -395,7 +395,7 @@ mt6360_ldo3: LDO3 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo5: LDO5 {
+			mt6360_ldo5: ldo5 {
 				regulator-name = "vmch_pmu";
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
@@ -403,7 +403,7 @@ mt6360_ldo5: LDO5 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo6: LDO6 {
+			mt6360_ldo6: ldo6 {
 				regulator-name = "mt6360_ldo6"; /* Test point */
 				regulator-min-microvolt = <500000>;
 				regulator-max-microvolt = <2100000>;
@@ -411,7 +411,7 @@ mt6360_ldo6: LDO6 {
 							   MT6360_OPMODE_LP>;
 			};
 
-			mt6360_ldo7: LDO7 {
+			mt6360_ldo7: ldo7 {
 				regulator-name = "emi_vmddr_en";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
index cce642c53812..3d3db33a64dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8516-pumpkin.dts
@@ -11,7 +11,7 @@
 
 / {
 	model = "Pumpkin MT8516";
-	compatible = "mediatek,mt8516";
+	compatible = "mediatek,mt8516-pumpkin", "mediatek,mt8516";
 
 	memory@40000000 {
 		device_type = "memory";
diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 2cfdf5bd5fd9..e75e6354b2d5 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1405,6 +1405,7 @@ usb_dwc3: usb@4e00000 {
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
 				snps,usb3_lpm_capable;
+				snps,parkmode-disable-ss-quirk;
 				maximum-speed = "super-speed";
 				dr_mode = "otg";
 				usb-role-switch;
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 377849cbb462..5785a934c28b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -48,7 +48,10 @@ sound_card {
 #if (SW_SCIF_CAN || SW_RSPI_CAN)
 &canfd {
 	pinctrl-0 = <&can1_pins>;
-	/delete-node/ channel@0;
+
+	channel0 {
+		status = "disabled";
+	};
 };
 #else
 &canfd {
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 5553508c3644..ca6d002a6f13 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2754,8 +2754,7 @@ void bpf_jit_free(struct bpf_prog *prog)
 		 * before freeing it.
 		 */
 		if (jit_data) {
-			bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
-					   sizeof(jit_data->header->size));
+			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
 			kfree(jit_data);
 		}
 		hdr = bpf_jit_binary_pack_hdr(prog);
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 50c469067f3a..b5e2312a2fca 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -166,6 +166,10 @@ static inline __init bool kaslr_disabled(void)
 		return true;
 #endif
 
+	str = strstr(boot_command_line, "kexec_file");
+	if (str == boot_command_line || (str > boot_command_line && *(str - 1) == ' '))
+		return true;
+
 	return false;
 }
 
diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index dd4eb3063175..f4390704d5ba 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -7,8 +7,14 @@
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
-			pgtable_gfp_flags(mm, GFP_KERNEL));
+	pgd_t *pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+				      pgtable_gfp_flags(mm, GFP_KERNEL));
+
+#ifdef CONFIG_PPC_BOOK3S_603
+	memcpy(pgd + USER_PTRS_PER_PGD, swapper_pg_dir + USER_PTRS_PER_PGD,
+	       (MAX_PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+#endif
+	return pgd;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index bb5f3e8ea912..4ef780b291bc 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -22,7 +22,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	pgd_t *pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 
-#if defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC_BOOK3S_603)
+#ifdef CONFIG_PPC_8xx
 	memcpy(pgd + USER_PTRS_PER_PGD, swapper_pg_dir + USER_PTRS_PER_PGD,
 	       (MAX_PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 #endif
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 56c5ebe21b99..613606400ee9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -162,7 +162,7 @@ instruction_counter:
  * For the MPC8xx, this is a software tablewalk to load the instruction
  * TLB.  The task switch loads the M_TWB register with the pointer to the first
  * level table.
- * If we discover there is no second level table (value is zero) or if there
+ * If there is no second level table (value is zero) or if there
  * is an invalid pte, we load that into the TLB, which causes another fault
  * into the TLB Error interrupt where we can handle such problems.
  * We have to use the MD_xxx registers for the tablewalk because the
@@ -183,9 +183,6 @@ instruction_counter:
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mtspr	SPRN_M_TW, r11
 
-	/* If we are faulting a kernel address, we have to use the
-	 * kernel page tables.
-	 */
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
 	mtspr	SPRN_MD_EPN, r10
@@ -228,10 +225,6 @@ instruction_counter:
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mtspr	SPRN_M_TW, r11
 
-	/* If we are faulting a kernel address, we have to use the
-	 * kernel page tables.
-	 */
-	mfspr	r10, SPRN_MD_EPN
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
 
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 563425b4963c..497945aa3e2c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -559,6 +559,39 @@ static void emit_atomic(u8 rd, u8 rs, s16 off, s32 imm, bool is64,
 	}
 }
 
+/*
+ * Sign-extend the register if necessary
+ */
+static int sign_extend(u8 rd, u8 rs, u8 sz, bool sign, struct rv_jit_context *ctx)
+{
+	if (!sign && (sz == 1 || sz == 2)) {
+		if (rd != rs)
+			emit_mv(rd, rs, ctx);
+		return 0;
+	}
+
+	switch (sz) {
+	case 1:
+		emit_sextb(rd, rs, ctx);
+		break;
+	case 2:
+		emit_sexth(rd, rs, ctx);
+		break;
+	case 4:
+		emit_sextw(rd, rs, ctx);
+		break;
+	case 8:
+		if (rd != rs)
+			emit_mv(rd, rs, ctx);
+		break;
+	default:
+		pr_err("bpf-jit: invalid size %d for sign_extend\n", sz);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 #define BPF_FIXUP_OFFSET_MASK   GENMASK(26, 0)
 #define BPF_FIXUP_REG_MASK      GENMASK(31, 27)
 #define REG_DONT_CLEAR_MARKER	0	/* RV_REG_ZERO unused in pt_regmap */
@@ -1020,8 +1053,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
 		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
 
 	if (save_ret) {
-		emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
 		emit_ld(regmap[BPF_REG_0], -(retval_off - 8), RV_REG_FP, ctx);
+		if (is_struct_ops) {
+			ret = sign_extend(RV_REG_A0, regmap[BPF_REG_0], m->ret_size,
+					  m->ret_flags & BTF_FMODEL_SIGNED_ARG, ctx);
+			if (ret)
+				goto out;
+		} else {
+			emit_ld(RV_REG_A0, -retval_off, RV_REG_FP, ctx);
+		}
 	}
 
 	emit_ld(RV_REG_S1, -sreg_off, RV_REG_FP, ctx);
diff --git a/arch/sparc/lib/M7memcpy.S b/arch/sparc/lib/M7memcpy.S
index cbd42ea7c3f7..99357bfa8e82 100644
--- a/arch/sparc/lib/M7memcpy.S
+++ b/arch/sparc/lib/M7memcpy.S
@@ -696,16 +696,16 @@ FUNC_NAME:
 	EX_LD_FP(LOAD(ldd, %o4+40, %f26), memcpy_retl_o2_plus_o5_plus_40)
 	faligndata %f24, %f26, %f10
 	EX_ST_FP(STORE(std, %f6, %o0+24), memcpy_retl_o2_plus_o5_plus_40)
-	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_40)
+	EX_LD_FP(LOAD(ldd, %o4+48, %f28), memcpy_retl_o2_plus_o5_plus_32)
 	faligndata %f26, %f28, %f12
-	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f8, %o0+32), memcpy_retl_o2_plus_o5_plus_32)
 	add	%o4, 64, %o4
-	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_40)
+	EX_LD_FP(LOAD(ldd, %o4-8, %f30), memcpy_retl_o2_plus_o5_plus_24)
 	faligndata %f28, %f30, %f14
-	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_40)
-	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f10, %o0+40), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST_FP(STORE(std, %f12, %o0+48), memcpy_retl_o2_plus_o5_plus_16)
 	add	%o0, 64, %o0
-	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_40)
+	EX_ST_FP(STORE(std, %f14, %o0-8), memcpy_retl_o2_plus_o5_plus_8)
 	fsrc2	%f30, %f14
 	bgu,pt	%xcc, .Lunalign_sloop
 	 prefetch [%o4 + (8 * BLOCK_SIZE)], 20
@@ -728,7 +728,7 @@ FUNC_NAME:
 	add	%o4, 8, %o4
 	faligndata %f0, %f2, %f16
 	subcc	%o5, 8, %o5
-	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5)
+	EX_ST_FP(STORE(std, %f16, %o0), memcpy_retl_o2_plus_o5_plus_8)
 	fsrc2	%f2, %f0
 	bgu,pt	%xcc, .Lunalign_by8
 	 add	%o0, 8, %o0
@@ -772,7 +772,7 @@ FUNC_NAME:
 	subcc	%o5, 0x20, %o5
 	EX_ST(STORE(stx, %o3, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
 	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, %g7, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
 	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt	%xcc, 1b
 	 add	%o0, 0x20, %o0
@@ -804,12 +804,12 @@ FUNC_NAME:
 	brz,pt	%o3, 2f
 	 sub	%o2, %o3, %o2
 
-1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_g1)
+1:	EX_LD(LOAD(ldub, %o1 + 0x00, %g2), memcpy_retl_o2_plus_o3)
 	add	%o1, 1, %o1
 	subcc	%o3, 1, %o3
 	add	%o0, 1, %o0
 	bne,pt	%xcc, 1b
-	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_g1_plus_1)
+	 EX_ST(STORE(stb, %g2, %o0 - 0x01), memcpy_retl_o2_plus_o3_plus_1)
 2:
 	and	%o1, 0x7, %o3
 	brz,pn	%o3, .Lmedium_noprefetch_cp
diff --git a/arch/sparc/lib/Memcpy_utils.S b/arch/sparc/lib/Memcpy_utils.S
index 64fbac28b3db..207343367bb2 100644
--- a/arch/sparc/lib/Memcpy_utils.S
+++ b/arch/sparc/lib/Memcpy_utils.S
@@ -137,6 +137,15 @@ ENTRY(memcpy_retl_o2_plus_63_8)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, 8, %o0
 ENDPROC(memcpy_retl_o2_plus_63_8)
+ENTRY(memcpy_retl_o2_plus_o3)
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3)
+ENTRY(memcpy_retl_o2_plus_o3_plus_1)
+	add	%o3, 1, %o3
+	ba,pt	%xcc, __restore_asi
+	 add	%o2, %o3, %o0
+ENDPROC(memcpy_retl_o2_plus_o3_plus_1)
 ENTRY(memcpy_retl_o2_plus_o5)
 	ba,pt	%xcc, __restore_asi
 	 add	%o2, %o5, %o0
diff --git a/arch/sparc/lib/NG4memcpy.S b/arch/sparc/lib/NG4memcpy.S
index 7ad58ebe0d00..df0ec1bd1948 100644
--- a/arch/sparc/lib/NG4memcpy.S
+++ b/arch/sparc/lib/NG4memcpy.S
@@ -281,7 +281,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	subcc		%o5, 0x20, %o5
 	EX_ST(STORE(stx, %g1, %o0 + 0x00), memcpy_retl_o2_plus_o5_plus_32)
 	EX_ST(STORE(stx, %g2, %o0 + 0x08), memcpy_retl_o2_plus_o5_plus_24)
-	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_24)
+	EX_ST(STORE(stx, GLOBAL_SPARE, %o0 + 0x10), memcpy_retl_o2_plus_o5_plus_16)
 	EX_ST(STORE(stx, %o4, %o0 + 0x18), memcpy_retl_o2_plus_o5_plus_8)
 	bne,pt		%icc, 1b
 	 add		%o0, 0x20, %o0
diff --git a/arch/sparc/lib/NGmemcpy.S b/arch/sparc/lib/NGmemcpy.S
index ee51c1230689..bbd3ea0a6482 100644
--- a/arch/sparc/lib/NGmemcpy.S
+++ b/arch/sparc/lib/NGmemcpy.S
@@ -79,8 +79,8 @@
 #ifndef EX_RETVAL
 #define EX_RETVAL(x)	x
 __restore_asi:
-	ret
 	wr	%g0, ASI_AIUS, %asi
+	ret
 	 restore
 ENTRY(NG_ret_i2_plus_i4_plus_1)
 	ba,pt	%xcc, __restore_asi
@@ -125,15 +125,16 @@ ENTRY(NG_ret_i2_plus_g1_minus_56)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %g1, %i0
 ENDPROC(NG_ret_i2_plus_g1_minus_56)
-ENTRY(NG_ret_i2_plus_i4)
+ENTRY(NG_ret_i2_plus_i4_plus_16)
+        add     %i4, 16, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4)
-ENTRY(NG_ret_i2_plus_i4_minus_8)
-	sub	%i4, 8, %i4
+ENDPROC(NG_ret_i2_plus_i4_plus_16)
+ENTRY(NG_ret_i2_plus_i4_plus_8)
+	add	%i4, 8, %i4
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
-ENDPROC(NG_ret_i2_plus_i4_minus_8)
+ENDPROC(NG_ret_i2_plus_i4_plus_8)
 ENTRY(NG_ret_i2_plus_8)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, 8, %i0
@@ -160,6 +161,12 @@ ENTRY(NG_ret_i2_and_7_plus_i4)
 	ba,pt	%xcc, __restore_asi
 	 add	%i2, %i4, %i0
 ENDPROC(NG_ret_i2_and_7_plus_i4)
+ENTRY(NG_ret_i2_and_7_plus_i4_plus_8)
+	and	%i2, 7, %i2
+	add	%i4, 8, %i4
+	ba,pt	%xcc, __restore_asi
+	 add	%i2, %i4, %i0
+ENDPROC(NG_ret_i2_and_7_plus_i4)
 #endif
 
 	.align		64
@@ -405,13 +412,13 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	andn		%i2, 0xf, %i4
 	and		%i2, 0xf, %i2
 1:	subcc		%i4, 0x10, %i4
-	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %o4), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x08, %i1
-	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4)
+	EX_LD(LOAD(ldx, %i1, %g1), NG_ret_i2_plus_i4_plus_16)
 	sub		%i1, 0x08, %i1
-	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4)
+	EX_ST(STORE(stx, %o4, %i1 + %i3), NG_ret_i2_plus_i4_plus_16)
 	add		%i1, 0x8, %i1
-	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_minus_8)
+	EX_ST(STORE(stx, %g1, %i1 + %i3), NG_ret_i2_plus_i4_plus_8)
 	bgu,pt		%XCC, 1b
 	 add		%i1, 0x8, %i1
 73:	andcc		%i2, 0x8, %g0
@@ -468,7 +475,7 @@ FUNC_NAME:	/* %i0=dst, %i1=src, %i2=len */
 	subcc		%i4, 0x8, %i4
 	srlx		%g3, %i3, %i5
 	or		%i5, %g2, %i5
-	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4)
+	EX_ST(STORE(stx, %i5, %o0), NG_ret_i2_and_7_plus_i4_plus_8)
 	add		%o0, 0x8, %o0
 	bgu,pt		%icc, 1b
 	 sllx		%g3, %g1, %g2
diff --git a/arch/sparc/lib/U1memcpy.S b/arch/sparc/lib/U1memcpy.S
index 635398ec7540..154fbd35400c 100644
--- a/arch/sparc/lib/U1memcpy.S
+++ b/arch/sparc/lib/U1memcpy.S
@@ -164,17 +164,18 @@ ENTRY(U1_gs_40_fp)
 	retl
 	 add		%o0, %o2, %o0
 ENDPROC(U1_gs_40_fp)
-ENTRY(U1_g3_0_fp)
-	VISExitHalf
-	retl
-	 add		%g3, %o2, %o0
-ENDPROC(U1_g3_0_fp)
 ENTRY(U1_g3_8_fp)
 	VISExitHalf
 	add		%g3, 8, %g3
 	retl
 	 add		%g3, %o2, %o0
 ENDPROC(U1_g3_8_fp)
+ENTRY(U1_g3_16_fp)
+	VISExitHalf
+	add		%g3, 16, %g3
+	retl
+	 add		%g3, %o2, %o0
+ENDPROC(U1_g3_16_fp)
 ENTRY(U1_o2_0_fp)
 	VISExitHalf
 	retl
@@ -547,18 +548,18 @@ FUNC_NAME:		/* %o0=dst, %o1=src, %o2=len */
 62:	FINISH_VISCHUNK(o0, f44, f46)
 63:	UNEVEN_VISCHUNK_LAST(o0, f46, f0)
 
-93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_0_fp)
+93:	EX_LD_FP(LOAD(ldd, %o1, %f2), U1_g3_8_fp)
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f0, %f2, %f8
-	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
+	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
 	bl,pn		%xcc, 95f
 	 add		%o0, 8, %o0
-	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_0_fp)
+	EX_LD_FP(LOAD(ldd, %o1, %f0), U1_g3_8_fp)
 	add		%o1, 8, %o1
 	subcc		%g3, 8, %g3
 	faligndata	%f2, %f0, %f8
-	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_8_fp)
+	EX_ST_FP(STORE(std, %f8, %o0), U1_g3_16_fp)
 	bge,pt		%xcc, 93b
 	 add		%o0, 8, %o0
 
diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 9248d59c734c..bace3a18f836 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	faligndata	%f10, %f12, %f26
 	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
 
+	and		%o2, 0x3f, %o2
 	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
 	add		%o1, 0x40, %o1
 	bgu,pt		%XCC, 1f
@@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
 	 * Also notice how this code is careful not to perform a
 	 * load past the end of the src buffer.
 	 */
-	and		%o2, 0x3f, %o2
 	andcc		%o2, 0x38, %g2
 	be,pn		%XCC, 2f
 	 subcc		%g2, 0x8, %g2
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 9d6411c65920..00cefbb59fa9 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -244,7 +244,7 @@ static inline unsigned long vdso_encode_cpunode(int cpu, unsigned long node)
 
 static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 {
-	unsigned int p;
+	unsigned long p;
 
 	/*
 	 * Load CPU and node number from the GDT.  LSL is faster than RDTSCP
@@ -254,10 +254,10 @@ static inline void vdso_read_cpunode(unsigned *cpu, unsigned *node)
 	 *
 	 * If RDPID is available, use it.
 	 */
-	alternative_io ("lsl %[seg],%[p]",
-			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
+	alternative_io ("lsl %[seg],%k[p]",
+			"rdpid %[p]",
 			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__CPUNODE_SEG));
+			[p] "=r" (p), [seg] "r" (__CPUNODE_SEG));
 
 	if (cpu)
 		*cpu = (p & VDSO_CPUNODE_MASK);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9170a9e127b7..c48a466db0c3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4237,13 +4237,21 @@ static int svm_vcpu_pre_run(struct kvm_vcpu *vcpu)
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
+	struct vmcb_control_area *control = &svm->vmcb->control;
+
+	/*
+	 * Next RIP must be provided as IRQs are disabled, and accessing guest
+	 * memory to decode the instruction might fault, i.e. might sleep.
+	 */
+	if (!nrips || !control->next_rip)
+		return EXIT_FASTPATH_NONE;
 
 	if (is_guest_mode(vcpu))
 		return EXIT_FASTPATH_NONE;
 
-	switch (svm->vmcb->control.exit_code) {
+	switch (control->exit_code) {
 	case SVM_EXIT_MSR:
-		if (!svm->vmcb->control.exit_info_1)
+		if (!control->exit_info_1)
 			break;
 		return handle_fastpath_set_msr_irqoff(vcpu);
 	case SVM_EXIT_HLT:
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 156e9bb07abf..2fb234ab467b 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -150,9 +150,11 @@ static void blk_mq_unregister_hctx(struct blk_mq_hw_ctx *hctx)
 		return;
 
 	hctx_for_each_ctx(hctx, ctx, i)
-		kobject_del(&ctx->kobj);
+		if (ctx->kobj.state_in_sysfs)
+			kobject_del(&ctx->kobj);
 
-	kobject_del(&hctx->kobj);
+	if (hctx->kobj.state_in_sysfs)
+		kobject_del(&hctx->kobj);
 }
 
 static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-settings.c b/block/blk-settings.c
index f24fffdb6c29..d72a283401c3 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -552,7 +552,8 @@ static unsigned int blk_round_down_sectors(unsigned int sectors, unsigned int lb
 int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 		     sector_t start)
 {
-	unsigned int top, bottom, alignment, ret = 0;
+	unsigned int top, bottom, alignment;
+	int ret = 0;
 
 	t->features |= (b->features & BLK_FEAT_INHERIT_MASK);
 
diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index ee2fdab42334..7e0ce7bf68c9 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -611,11 +611,14 @@ int x509_process_extension(void *context, size_t hdrlen,
 		/*
 		 * Get hold of the basicConstraints
 		 * v[1] is the encoding size
-		 *	(Expect 0x2 or greater, making it 1 or more bytes)
+		 *	(Expect 0x00 for empty SEQUENCE with CA:FALSE, or
+		 *	0x03 or greater for non-empty SEQUENCE)
 		 * v[2] is the encoding type
 		 *	(Expect an ASN1_BOOL for the CA)
-		 * v[3] is the contents of the ASN1_BOOL
-		 *      (Expect 1 if the CA is TRUE)
+		 * v[3] is the length of the ASN1_BOOL
+		 *	(Expect 1 for a single byte boolean)
+		 * v[4] is the contents of the ASN1_BOOL
+		 *	(Expect 0xFF if the CA is TRUE)
 		 * vlen should match the entire extension size
 		 */
 		if (v[0] != (ASN1_CONS_BIT | ASN1_SEQ))
@@ -624,8 +627,13 @@ int x509_process_extension(void *context, size_t hdrlen,
 			return -EBADMSG;
 		if (v[1] != vlen - 2)
 			return -EBADMSG;
-		if (vlen >= 4 && v[1] != 0 && v[2] == ASN1_BOOL && v[3] == 1)
+		/* Empty SEQUENCE means CA:FALSE (default value omitted per DER) */
+		if (v[1] == 0)
+			return 0;
+		if (vlen >= 5 && v[2] == ASN1_BOOL && v[3] == 1 && v[4] == 0xFF)
 			ctx->cert->pub->key_eflags |= 1 << KEY_EFLAG_CA;
+		else
+			return -EBADMSG;
 		return 0;
 	}
 
diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 6f4fe47c955b..35460c2072a4 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1141,7 +1141,7 @@ struct acpi_port_info {
 #define ACPI_RESOURCE_NAME_PIN_GROUP_FUNCTION   0x91
 #define ACPI_RESOURCE_NAME_PIN_GROUP_CONFIG     0x92
 #define ACPI_RESOURCE_NAME_CLOCK_INPUT          0x93
-#define ACPI_RESOURCE_NAME_LARGE_MAX            0x94
+#define ACPI_RESOURCE_NAME_LARGE_MAX            0x93
 
 /*****************************************************************************
  *
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ae035b93da08..3eb56b77cb6d 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2637,7 +2637,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
 	if (ndr_desc->target_node == NUMA_NO_NODE) {
 		ndr_desc->target_node = phys_to_target_node(spa->address);
 		dev_info(acpi_desc->dev, "changing target node from %d to %d for nfit region [%pa-%pa]",
-			NUMA_NO_NODE, ndr_desc->numa_node, &res.start, &res.end);
+			NUMA_NO_NODE, ndr_desc->target_node, &res.start, &res.end);
 	}
 
 	/*
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 0888e4d618d5..b524cf27213d 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1410,6 +1410,9 @@ int acpi_processor_power_init(struct acpi_processor *pr)
 		if (retval) {
 			if (acpi_processor_registered == 0)
 				cpuidle_unregister_driver(&acpi_idle_driver);
+
+			per_cpu(acpi_cpuidle_device, pr->id) = NULL;
+			kfree(dev);
 			return retval;
 		}
 		acpi_processor_registered++;
diff --git a/drivers/base/node.c b/drivers/base/node.c
index eb72580288e6..deccfe68214e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -879,6 +879,10 @@ int __register_one_node(int nid)
 	node_devices[nid] = node;
 
 	error = register_node(node_devices[nid], nid);
+	if (error) {
+		node_devices[nid] = NULL;
+		return error;
+	}
 
 	/* link cpu under this node */
 	for_each_present_cpu(cpu) {
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index faf4cdec23f0..abb16a5bb796 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -628,8 +628,20 @@ static void device_resume_noirq(struct device *dev, pm_message_t state, bool asy
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Out;
 
-	if (!dev->power.is_noirq_suspended)
+	if (!dev->power.is_noirq_suspended) {
+		/*
+		 * This means that system suspend has been aborted in the noirq
+		 * phase before invoking the noirq suspend callback for the
+		 * device, so if device_suspend_late() has left it in suspend,
+		 * device_resume_early() should leave it in suspend either in
+		 * case the early resume of it depends on the noirq resume that
+		 * has not run.
+		 */
+		if (dev_pm_skip_suspend(dev))
+			dev->power.must_resume = false;
+
 		goto Out;
+	}
 
 	if (!dpm_wait_for_superior(dev, async))
 		goto Out;
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index de4e2f3db942..66b3840bd96e 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -828,7 +828,7 @@ struct regmap *__regmap_init(struct device *dev,
 		map->read_flag_mask = bus->read_flag_mask;
 	}
 
-	if (config && config->read && config->write) {
+	if (config->read && config->write) {
 		map->reg_read  = _regmap_bus_read;
 		if (config->reg_update_bits)
 			map->reg_update_bits = config->reg_update_bits;
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index c705acc4d6f4..de692eed9874 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1156,6 +1156,14 @@ static struct socket *nbd_get_socket(struct nbd_device *nbd, unsigned long fd,
 	if (!sock)
 		return NULL;
 
+	if (!sk_is_tcp(sock->sk) &&
+	    !sk_is_stream_unix(sock->sk)) {
+		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: should be TCP or UNIX.\n");
+		*err = -EINVAL;
+		sockfd_put(sock);
+		return NULL;
+	}
+
 	if (sock->ops->shutdown == sock_no_shutdown) {
 		dev_err(disk_to_dev(nbd->disk), "Unsupported socket: shutdown callout must be supported.\n");
 		*err = -EINVAL;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f10369ad90f7..ceb7aeca5d9b 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -223,7 +223,7 @@ MODULE_PARM_DESC(discard, "Support discard operations (requires memory-backed nu
 
 static unsigned long g_cache_size;
 module_param_named(cache_size, g_cache_size, ulong, 0444);
-MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (none)");
+MODULE_PARM_DESC(cache_size, "Cache size in MiB for memory-backed device. Default: 0 (none)");
 
 static bool g_fua = true;
 module_param_named(fua, g_fua, bool, 0444);
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 4575d9a4e5ed..dbc8d8f14ce7 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -1103,6 +1103,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	 * Get physical address of MC portal for the root DPRC:
 	 */
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!plat_res)
+		return -EINVAL;
+
 	mc_portal_phys_addr = plat_res->start;
 	mc_portal_size = resource_size(plat_res);
 	mc_portal_base_phys_addr = mc_portal_phys_addr & ~0x3ffffff;
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index b51d9e243f35..f0dde77f50b4 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -286,6 +286,7 @@ config HW_RANDOM_INGENIC_TRNG
 config HW_RANDOM_NOMADIK
 	tristate "ST-Ericsson Nomadik Random Number Generator support"
 	depends on ARCH_NOMADIK || COMPILE_TEST
+	depends on ARM_AMBA
 	default HW_RANDOM
 	help
 	  This driver provides kernel-side support for the Random Number
diff --git a/drivers/char/hw_random/ks-sa-rng.c b/drivers/char/hw_random/ks-sa-rng.c
index 36c34252b4f6..3c514b4fbc8a 100644
--- a/drivers/char/hw_random/ks-sa-rng.c
+++ b/drivers/char/hw_random/ks-sa-rng.c
@@ -231,6 +231,10 @@ static int ks_sa_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(ks_sa_rng->regmap_cfg))
 		return dev_err_probe(dev, -EINVAL, "syscon_node_to_regmap failed\n");
 
+	ks_sa_rng->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(ks_sa_rng->clk))
+		return dev_err_probe(dev, PTR_ERR(ks_sa_rng->clk), "Failed to get clock\n");
+
 	pm_runtime_enable(dev);
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index cf0be8a7939d..db41301e63f2 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -29,7 +29,7 @@ if TCG_TPM
 
 config TCG_TPM2_HMAC
 	bool "Use HMAC and encrypted transactions on the TPM bus"
-	default X86_64
+	default n
 	select CRYPTO_ECDH
 	select CRYPTO_LIB_AESCFB
 	select CRYPTO_LIB_SHA256
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index beb660ca240c..a2ec1addafc9 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -15,6 +15,7 @@
 #include <linux/energy_model.h>
 #include <linux/export.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/scmi_protocol.h>
@@ -398,6 +399,15 @@ static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
 			return true;
 	}
 
+	/*
+	 * Older Broadcom STB chips had a "clocks" property for CPU node(s)
+	 * that did not match the SCMI performance protocol node, if we got
+	 * there, it means we had such an older Device Tree, therefore return
+	 * true to preserve backwards compatibility.
+	 */
+	if (of_machine_is_compatible("brcm,brcmstb"))
+		return true;
+
 	return false;
 }
 
diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 1fc9968eae19..b6b06a510fd8 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -96,20 +96,23 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+	of_node_put(cpu_node);
 	if (!saw_node)
 		return -ENODEV;
 
 	pdev = of_find_device_by_node(saw_node);
 	of_node_put(saw_node);
-	of_node_put(cpu_node);
 	if (!pdev)
 		return -ENODEV;
 
 	data = devm_kzalloc(cpuidle_dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		put_device(&pdev->dev);
 		return -ENOMEM;
+	}
 
 	data->spm = dev_get_drvdata(&pdev->dev);
+	put_device(&pdev->dev);
 	if (!data->spm)
 		return -EINVAL;
 
diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 45e130b901eb..17eb236e9ee4 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -888,6 +888,7 @@ static int qm_diff_regs_init(struct hisi_qm *qm,
 		dfx_regs_uninit(qm, qm->debug.qm_diff_regs, ARRAY_SIZE(qm_diff_regs));
 		ret = PTR_ERR(qm->debug.acc_diff_regs);
 		qm->debug.acc_diff_regs = NULL;
+		qm->debug.qm_diff_regs = NULL;
 		return ret;
 	}
 
diff --git a/drivers/crypto/hisilicon/hpre/hpre_main.c b/drivers/crypto/hisilicon/hpre/hpre_main.c
index 34d30b783813..a11fe5e27677 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_main.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_main.c
@@ -690,6 +690,7 @@ static int hpre_set_user_domain_and_cache(struct hisi_qm *qm)
 
 	/* Config data buffer pasid needed by Kunpeng 920 */
 	hpre_config_pasid(qm);
+	hpre_open_sva_prefetch(qm);
 
 	hpre_enable_clock_gate(qm);
 
@@ -1366,8 +1367,6 @@ static int hpre_pf_probe_init(struct hpre *hpre)
 	if (ret)
 		return ret;
 
-	hpre_open_sva_prefetch(qm);
-
 	hisi_qm_dev_err_init(qm);
 	ret = hpre_show_last_regs_init(qm);
 	if (ret)
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index b18692ee7fd5..a9550a05dfbd 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -3657,6 +3657,10 @@ static ssize_t qm_get_qos_value(struct hisi_qm *qm, const char *buf,
 	}
 
 	pdev = container_of(dev, struct pci_dev, dev);
+	if (pci_physfn(pdev) != qm->pdev) {
+		pci_err(qm->pdev, "the pdev input does not match the pf!\n");
+		return -EINVAL;
+	}
 
 	*fun_index = pdev->devfn;
 
@@ -4272,9 +4276,6 @@ static void qm_restart_prepare(struct hisi_qm *qm)
 {
 	u32 value;
 
-	if (qm->err_ini->open_sva_prefetch)
-		qm->err_ini->open_sva_prefetch(qm);
-
 	if (qm->ver >= QM_HW_V3)
 		return;
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 75c25f0d5f2b..9014cc36705f 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -441,6 +441,45 @@ static void sec_set_endian(struct hisi_qm *qm)
 	writel_relaxed(reg, qm->io_base + SEC_CONTROL_REG);
 }
 
+static void sec_close_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
+		return;
+
+	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
+	val |= SEC_PREFETCH_DISABLE;
+	writel(val, qm->io_base + SEC_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_SVA_TRANS,
+					 val, !(val & SEC_SVA_DISABLE_READY),
+					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to close sva prefetch\n");
+}
+
+static void sec_open_sva_prefetch(struct hisi_qm *qm)
+{
+	u32 val;
+	int ret;
+
+	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
+		return;
+
+	/* Enable prefetch */
+	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
+	val &= SEC_PREFETCH_ENABLE;
+	writel(val, qm->io_base + SEC_PREFETCH_CFG);
+
+	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_PREFETCH_CFG,
+					 val, !(val & SEC_PREFETCH_DISABLE),
+					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
+	if (ret)
+		pci_err(qm->pdev, "failed to open sva prefetch\n");
+}
+
 static void sec_engine_sva_config(struct hisi_qm *qm)
 {
 	u32 reg;
@@ -474,45 +513,7 @@ static void sec_engine_sva_config(struct hisi_qm *qm)
 		writel_relaxed(reg, qm->io_base +
 				SEC_INTERFACE_USER_CTRL1_REG);
 	}
-}
-
-static void sec_open_sva_prefetch(struct hisi_qm *qm)
-{
-	u32 val;
-	int ret;
-
-	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
-		return;
-
-	/* Enable prefetch */
-	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
-	val &= SEC_PREFETCH_ENABLE;
-	writel(val, qm->io_base + SEC_PREFETCH_CFG);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_PREFETCH_CFG,
-					 val, !(val & SEC_PREFETCH_DISABLE),
-					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
-	if (ret)
-		pci_err(qm->pdev, "failed to open sva prefetch\n");
-}
-
-static void sec_close_sva_prefetch(struct hisi_qm *qm)
-{
-	u32 val;
-	int ret;
-
-	if (!test_bit(QM_SUPPORT_SVA_PREFETCH, &qm->caps))
-		return;
-
-	val = readl_relaxed(qm->io_base + SEC_PREFETCH_CFG);
-	val |= SEC_PREFETCH_DISABLE;
-	writel(val, qm->io_base + SEC_PREFETCH_CFG);
-
-	ret = readl_relaxed_poll_timeout(qm->io_base + SEC_SVA_TRANS,
-					 val, !(val & SEC_SVA_DISABLE_READY),
-					 SEC_DELAY_10_US, SEC_POLL_TIMEOUT_US);
-	if (ret)
-		pci_err(qm->pdev, "failed to close sva prefetch\n");
+	sec_open_sva_prefetch(qm);
 }
 
 static void sec_enable_clock_gate(struct hisi_qm *qm)
@@ -1094,7 +1095,6 @@ static int sec_pf_probe_init(struct sec_dev *sec)
 	if (ret)
 		return ret;
 
-	sec_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	sec_debug_regs_clear(qm);
 	ret = sec_show_last_regs_init(qm);
diff --git a/drivers/crypto/hisilicon/zip/zip_main.c b/drivers/crypto/hisilicon/zip/zip_main.c
index 80c2fcb1d26d..323f53217f0c 100644
--- a/drivers/crypto/hisilicon/zip/zip_main.c
+++ b/drivers/crypto/hisilicon/zip/zip_main.c
@@ -449,10 +449,9 @@ bool hisi_zip_alg_support(struct hisi_qm *qm, u32 alg)
 	return false;
 }
 
-static int hisi_zip_set_high_perf(struct hisi_qm *qm)
+static void hisi_zip_set_high_perf(struct hisi_qm *qm)
 {
 	u32 val;
-	int ret;
 
 	val = readl_relaxed(qm->io_base + HZIP_HIGH_PERF_OFFSET);
 	if (perf_mode == HZIP_HIGH_COMP_PERF)
@@ -462,13 +461,6 @@ static int hisi_zip_set_high_perf(struct hisi_qm *qm)
 
 	/* Set perf mode */
 	writel(val, qm->io_base + HZIP_HIGH_PERF_OFFSET);
-	ret = readl_relaxed_poll_timeout(qm->io_base + HZIP_HIGH_PERF_OFFSET,
-					 val, val == perf_mode, HZIP_DELAY_1_US,
-					 HZIP_POLL_TIMEOUT_US);
-	if (ret)
-		pci_err(qm->pdev, "failed to set perf mode\n");
-
-	return ret;
 }
 
 static void hisi_zip_open_sva_prefetch(struct hisi_qm *qm)
@@ -565,6 +557,7 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 		writel(AXUSER_BASE, base + HZIP_DATA_WUSER_32_63);
 		writel(AXUSER_BASE, base + HZIP_SGL_RUSER_32_63);
 	}
+	hisi_zip_open_sva_prefetch(qm);
 
 	/* let's open all compression/decompression cores */
 	dcomp_bm = qm->cap_tables.dev_cap_table[ZIP_DECOMP_ENABLE_BITMAP_IDX].cap_val;
@@ -576,6 +569,7 @@ static int hisi_zip_set_user_domain_and_cache(struct hisi_qm *qm)
 	       CQC_CACHE_WB_ENABLE | FIELD_PREP(SQC_CACHE_WB_THRD, 1) |
 	       FIELD_PREP(CQC_CACHE_WB_THRD, 1), base + QM_CACHE_CTL);
 
+	hisi_zip_set_high_perf(qm);
 	hisi_zip_enable_clock_gate(qm);
 
 	return 0;
@@ -1171,11 +1165,6 @@ static int hisi_zip_pf_probe_init(struct hisi_zip *hisi_zip)
 	if (ret)
 		return ret;
 
-	ret = hisi_zip_set_high_perf(qm);
-	if (ret)
-		return ret;
-
-	hisi_zip_open_sva_prefetch(qm);
 	hisi_qm_dev_err_init(qm);
 	hisi_zip_debug_regs_clear(qm);
 
diff --git a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
index fdeca861933c..903f31dc663e 100644
--- a/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
+++ b/drivers/crypto/intel/keembay/keembay-ocs-hcu-core.c
@@ -232,7 +232,7 @@ static int kmb_ocs_dma_prepare(struct ahash_request *req)
 	struct device *dev = rctx->hcu_dev->dev;
 	unsigned int remainder = 0;
 	unsigned int total;
-	size_t nents;
+	int nents;
 	size_t count;
 	int rc;
 	int i;
@@ -253,6 +253,9 @@ static int kmb_ocs_dma_prepare(struct ahash_request *req)
 	/* Determine the number of scatter gather list entries to process. */
 	nents = sg_nents_for_len(req->src, rctx->sg_data_total - remainder);
 
+	if (nents < 0)
+		return nents;
+
 	/* If there are entries to process, map them. */
 	if (nents) {
 		rctx->sg_dma_nents = dma_map_sg(dev, req->src, nents,
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 1493a373baf7..cf68b213c3e6 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1614,7 +1614,7 @@ int otx2_cpt_dl_custom_egrp_create(struct otx2_cptpf_dev *cptpf,
 		return -EINVAL;
 	}
 	err_msg = "Invalid engine group format";
-	strscpy(tmp_buf, ctx->val.vstr, strlen(ctx->val.vstr) + 1);
+	strscpy(tmp_buf, ctx->val.vstr);
 	start = tmp_buf;
 
 	has_se = has_ie = has_ae = false;
diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index e2a1e4463b6f..712df781436c 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -116,6 +116,7 @@ struct rockchip_dfi {
 	int buswidth[DMC_MAX_CHANNELS];
 	int ddrmon_stride;
 	bool ddrmon_ctrl_single;
+	unsigned int count_multiplier;	/* number of data clocks per count */
 };
 
 static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
@@ -435,7 +436,7 @@ static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
 
 	switch (event->attr.config) {
 	case PERF_EVENT_CYCLES:
-		count = total.c[0].clock_cycles;
+		count = total.c[0].clock_cycles * dfi->count_multiplier;
 		break;
 	case PERF_EVENT_READ_BYTES:
 		for (i = 0; i < dfi->max_channels; i++)
@@ -656,6 +657,9 @@ static int rockchip_ddr_perf_init(struct rockchip_dfi *dfi)
 		break;
 	}
 
+	if (!dfi->count_multiplier)
+		dfi->count_multiplier = 1;
+
 	ret = perf_pmu_register(pmu, "rockchip_ddr", -1);
 	if (ret)
 		return ret;
@@ -752,6 +756,7 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 	dfi->max_channels = 4;
 
 	dfi->ddrmon_stride = 0x4000;
+	dfi->count_multiplier = 2;
 
 	return 0;
 };
diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
index 7ad5225b0381..6e608d92f7e6 100644
--- a/drivers/devfreq/mtk-cci-devfreq.c
+++ b/drivers/devfreq/mtk-cci-devfreq.c
@@ -386,7 +386,8 @@ static int mtk_ccifreq_probe(struct platform_device *pdev)
 out_free_resources:
 	if (regulator_is_enabled(drv->proc_reg))
 		regulator_disable(drv->proc_reg);
-	if (drv->sram_reg && regulator_is_enabled(drv->sram_reg))
+	if (!IS_ERR_OR_NULL(drv->sram_reg) &&
+	    regulator_is_enabled(drv->sram_reg))
 		regulator_disable(drv->sram_reg);
 
 	return ret;
diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
index ac4b3d95531c..d8cd12d906a7 100644
--- a/drivers/edac/i10nm_base.c
+++ b/drivers/edac/i10nm_base.c
@@ -967,6 +967,15 @@ static bool i10nm_check_ecc(struct skx_imc *imc, int chan)
 	return !!GET_BITFIELD(mcmtr, 2, 2);
 }
 
+static bool i10nm_channel_disabled(struct skx_imc *imc, int chan)
+{
+	u32 mcmtr = I10NM_GET_MCMTR(imc, chan);
+
+	edac_dbg(1, "mc%d ch%d mcmtr reg %x\n", imc->mc, chan, mcmtr);
+
+	return (mcmtr == ~0 || GET_BITFIELD(mcmtr, 18, 18));
+}
+
 static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 				 struct res_config *cfg)
 {
@@ -980,6 +989,11 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci,
 		if (!imc->mbase)
 			continue;
 
+		if (i10nm_channel_disabled(imc, i)) {
+			edac_dbg(1, "mc%d ch%d is disabled.\n", imc->mc, i);
+			continue;
+		}
+
 		ndimms = 0;
 
 		if (res_cfg->type != GNR)
diff --git a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
index d349766bc0b2..f78b87f33403 100644
--- a/drivers/firmware/arm_scmi/transports/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -870,6 +870,9 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	/* Ensure initialized scmi_vdev is visible */
 	smp_store_mb(scmi_vdev, vdev);
 
+	/* Set device ready */
+	virtio_device_ready(vdev);
+
 	ret = platform_driver_register(&scmi_virtio_driver);
 	if (ret) {
 		vdev->priv = NULL;
diff --git a/drivers/firmware/meson/Kconfig b/drivers/firmware/meson/Kconfig
index f2fdd3756648..179f5d46d8dd 100644
--- a/drivers/firmware/meson/Kconfig
+++ b/drivers/firmware/meson/Kconfig
@@ -5,7 +5,7 @@
 config MESON_SM
 	tristate "Amlogic Secure Monitor driver"
 	depends on ARCH_MESON || COMPILE_TEST
-	default y
+	default ARCH_MESON
 	depends on ARM64_4K_PAGES
 	help
 	  Say y here to enable the Amlogic secure monitor driver
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 805d6662c88b..21376d98ee49 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -623,7 +623,22 @@ static void uvd_v3_1_enable_mgcg(struct amdgpu_device *adev,
  *
  * @handle: handle used to pass amdgpu_device pointer
  *
- * Initialize the hardware, boot up the VCPU and do some testing
+ * Initialize the hardware, boot up the VCPU and do some testing.
+ *
+ * On SI, the UVD is meant to be used in a specific power state,
+ * or alternatively the driver can manually enable its clock.
+ * In amdgpu we use the dedicated UVD power state when DPM is enabled.
+ * Calling amdgpu_dpm_enable_uvd makes DPM select the UVD power state
+ * for the SMU and afterwards enables the UVD clock.
+ * This is automatically done by amdgpu_uvd_ring_begin_use when work
+ * is submitted to the UVD ring. Here, we have to call it manually
+ * in order to power up UVD before firmware validation.
+ *
+ * Note that we must not disable the UVD clock here, as that would
+ * cause the ring test to fail. However, UVD is powered off
+ * automatically after the ring test: amdgpu_uvd_ring_end_use calls
+ * the UVD idle work handler which will disable the UVD clock when
+ * all fences are signalled.
  */
 static int uvd_v3_1_hw_init(void *handle)
 {
@@ -633,6 +648,15 @@ static int uvd_v3_1_hw_init(void *handle)
 	int r;
 
 	uvd_v3_1_mc_resume(adev);
+	uvd_v3_1_enable_mgcg(adev, true);
+
+	/* Make sure UVD is powered during FW validation.
+	 * It's going to be automatically powered off after the ring test.
+	 */
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_uvd(adev, true);
+	else
+		amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
 
 	r = uvd_v3_1_fw_validate(adev);
 	if (r) {
@@ -640,9 +664,6 @@ static int uvd_v3_1_hw_init(void *handle)
 		return r;
 	}
 
-	uvd_v3_1_enable_mgcg(adev, true);
-	amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
-
 	uvd_v3_1_start(adev);
 
 	r = amdgpu_ring_test_helper(ring);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3e9e0f36cd3f..a8d4b3a3e77a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -4231,7 +4231,7 @@ svm_ioctl(struct kfd_process *p, enum kfd_ioctl_svm_op op, uint64_t start,
 		r = svm_range_get_attr(p, mm, start, size, nattrs, attrs);
 		break;
 	default:
-		r = EINVAL;
+		r = -EINVAL;
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
index 9ba6cb67655f..6c75aa82327a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_rq_dlg_calc_32.c
@@ -139,7 +139,6 @@ void dml32_rq_dlg_get_rq_reg(display_rq_regs_st *rq_regs,
 	if (dual_plane) {
 		unsigned int p1_pte_row_height_linear = get_dpte_row_height_linear_c(mode_lib, e2e_pipe_param,
 				num_pipes, pipe_idx);
-		;
 		if (src->sw_mode == dm_sw_linear)
 			ASSERT(p1_pte_row_height_linear >= 8);
 
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index 42efe838fa85..2d2d2d5e6763 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -66,6 +66,13 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
 					(amdgpu_crtc->v_border * 2));
 
 				vblank_time_us = vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+
+				/* we have issues with mclk switching with
+				 * refresh rates over 120 hz on the non-DC code.
+				 */
+				if (drm_mode_vrefresh(&amdgpu_crtc->hw_mode) > 120)
+					vblank_time_us = 0;
+
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a5ad1b60597e..82167eca2668 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3066,7 +3066,13 @@ static bool si_dpm_vblank_too_short(void *handle)
 	/* we never hit the non-gddr5 limit so disable it */
 	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
 
-	if (vblank_time < switch_limit)
+	/* Consider zero vblank time too short and disable MCLK switching.
+	 * Note that the vblank time is set to maximum when no displays are attached,
+	 * so we'll still enable MCLK switching in that case.
+	 */
+	if (vblank_time == 0)
+		return true;
+	else if (vblank_time < switch_limit)
 		return true;
 	else
 		return false;
@@ -3424,12 +3430,14 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 {
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
+	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
 	u16 vddc, vddci, min_vce_voltage = 0;
 	u32 max_sclk_vddc, max_mclk_vddci, max_mclk_vddc;
 	u32 max_sclk = 0, max_mclk = 0;
+	u32 high_pixelclock_count = 0;
 	int i;
 
 	if (adev->asic_type == CHIP_HAINAN) {
@@ -3457,6 +3465,35 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		}
 	}
 
+	/* We define "high pixelclock" for SI as higher than necessary for 4K 30Hz.
+	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
+	 * Find number of such displays connected.
+	 */
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
+			!adev->mode_info.crtcs[i]->enabled)
+			continue;
+
+		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
+
+		if (conn->pixelclock_for_modeset > 297000)
+			high_pixelclock_count++;
+	}
+
+	/* These are some ad-hoc fixes to some issues observed with SI GPUs.
+	 * They are necessary because we don't have something like dce_calcs
+	 * for these GPUs to calculate bandwidth requirements.
+	 */
+	if (high_pixelclock_count) {
+		/* On Oland, we observe some flickering when two 4K 60Hz
+		 * displays are connected, possibly because voltage is too low.
+		 * Raise the voltage by requiring a higher SCLK.
+		 * (Voltage cannot be adjusted independently without also SCLK.)
+		 */
+		if (high_pixelclock_count > 1 && adev->asic_type == CHIP_OLAND)
+			disable_sclk_switching = true;
+	}
+
 	if (rps->vce_active) {
 		rps->evclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].evclk;
 		rps->ecclk = adev->pm.dpm.vce_states[adev->pm.dpm.vce_level].ecclk;
@@ -5613,14 +5650,10 @@ static int si_populate_smc_t(struct amdgpu_device *adev,
 
 static int si_disable_ulv(struct amdgpu_device *adev)
 {
-	struct si_power_info *si_pi = si_get_pi(adev);
-	struct si_ulv_param *ulv = &si_pi->ulv;
-
-	if (ulv->supported)
-		return (amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV) == PPSMC_Result_OK) ?
-			0 : -EINVAL;
+	PPSMC_Result r;
 
-	return 0;
+	r = amdgpu_si_send_msg_to_smc(adev, PPSMC_MSG_DisableULV);
+	return (r == PPSMC_Result_OK) ? 0 : -EINVAL;
 }
 
 static bool si_is_state_ulv_compatible(struct amdgpu_device *adev,
@@ -5793,9 +5826,9 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_crtc *amdgpu_crtc = NULL;
 	int i;
-
-	if (adev->pm.dpm.new_active_crtc_count == 0)
-		return 0;
+	u32 crtc_index = 0;
+	u32 mclk_change_block_cp_min = 0;
+	u32 mclk_change_block_cp_max = 0;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		if (adev->pm.dpm.new_active_crtcs & (1 << i)) {
@@ -5804,26 +5837,31 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 		}
 	}
 
-	if (amdgpu_crtc == NULL)
-		return 0;
+	/* When a display is plugged in, program these so that the SMC
+	 * performs MCLK switching when it doesn't cause flickering.
+	 * When no display is plugged in, there is no need to restrict
+	 * MCLK switching, so program them to zero.
+	 */
+	if (adev->pm.dpm.new_active_crtc_count && amdgpu_crtc) {
+		crtc_index = amdgpu_crtc->crtc_id;
 
-	if (amdgpu_crtc->line_time <= 0)
-		return 0;
+		if (amdgpu_crtc->line_time) {
+			mclk_change_block_cp_min = 200 / amdgpu_crtc->line_time;
+			mclk_change_block_cp_max = 100 / amdgpu_crtc->line_time;
+		}
+	}
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_crtc_index,
-				       amdgpu_crtc->crtc_id) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_crtc_index,
+		crtc_index);
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
-				       amdgpu_crtc->wm_high / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
+		mclk_change_block_cp_min);
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
-				       amdgpu_crtc->wm_low / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
+		mclk_change_block_cp_max);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 3eb955333c80..66369b6a023f 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -101,6 +101,7 @@ config DRM_ITE_IT6505
 	select EXTCON
 	select CRYPTO
 	select CRYPTO_HASH
+	select REGMAP_I2C
 	help
 	  ITE IT6505 DisplayPort bridge chip driver.
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 07035ab77b79..4597fdb65358 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -445,7 +445,7 @@ static void _dpu_encoder_phys_wb_handle_wbdone_timeout(
 static int dpu_encoder_phys_wb_wait_for_commit_done(
 		struct dpu_encoder_phys *phys_enc)
 {
-	unsigned long ret;
+	int ret;
 	struct dpu_encoder_wait_info wait_info;
 	struct dpu_encoder_phys_wb *wb_enc = to_dpu_encoder_phys_wb(phys_enc);
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35560.c b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
index 5bbea734123b..ee04c55175bb 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35560.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35560.c
@@ -161,7 +161,7 @@ static int nt35560_set_brightness(struct backlight_device *bl)
 		par = 0x00;
 		ret = mipi_dsi_dcs_write(dsi, MIPI_DCS_WRITE_CONTROL_DISPLAY,
 					 &par, 1);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(nt->dev, "failed to disable display backlight (%d)\n", ret);
 			return ret;
 		}
diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index ac77d1246b94..811265648a58 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -1408,7 +1408,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 			      unsigned block_align, unsigned height_align, unsigned base_align,
 			      unsigned *l0_size, unsigned *mipmap_size)
 {
-	unsigned offset, i, level;
+	unsigned offset, i;
 	unsigned width, height, depth, size;
 	unsigned blocksize;
 	unsigned nbx, nby;
@@ -1420,7 +1420,7 @@ static void r600_texture_size(unsigned nfaces, unsigned blevel, unsigned llevel,
 	w0 = r600_mip_minify(w0, 0);
 	h0 = r600_mip_minify(h0, 0);
 	d0 = r600_mip_minify(d0, 0);
-	for(i = 0, offset = 0, level = blevel; i < nlevels; i++, level++) {
+	for (i = 0, offset = 0; i < nlevels; i++) {
 		width = r600_mip_minify(w0, i);
 		nbx = r600_fmt_get_nblocksx(format, width);
 
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index c887f48756f4..bbd6f23bce78 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -394,27 +394,15 @@ static int hidraw_revoke(struct hidraw_list *list)
 	return 0;
 }
 
-static long hidraw_ioctl(struct file *file, unsigned int cmd,
-							unsigned long arg)
+static long hidraw_fixed_size_ioctl(struct file *file, struct hidraw *dev, unsigned int cmd,
+				    void __user *arg)
 {
-	struct inode *inode = file_inode(file);
-	unsigned int minor = iminor(inode);
-	long ret = 0;
-	struct hidraw *dev;
-	struct hidraw_list *list = file->private_data;
-	void __user *user_arg = (void __user*) arg;
-
-	down_read(&minors_rwsem);
-	dev = hidraw_table[minor];
-	if (!dev || !dev->exist || hidraw_is_revoked(list)) {
-		ret = -ENODEV;
-		goto out;
-	}
+	struct hid_device *hid = dev->hid;
 
 	switch (cmd) {
 		case HIDIOCGRDESCSIZE:
-			if (put_user(dev->hid->rsize, (int __user *)arg))
-				ret = -EFAULT;
+			if (put_user(hid->rsize, (int __user *)arg))
+				return -EFAULT;
 			break;
 
 		case HIDIOCGRDESC:
@@ -422,113 +410,145 @@ static long hidraw_ioctl(struct file *file, unsigned int cmd,
 				__u32 len;
 
 				if (get_user(len, (int __user *)arg))
-					ret = -EFAULT;
-				else if (len > HID_MAX_DESCRIPTOR_SIZE - 1)
-					ret = -EINVAL;
-				else if (copy_to_user(user_arg + offsetof(
-					struct hidraw_report_descriptor,
-					value[0]),
-					dev->hid->rdesc,
-					min(dev->hid->rsize, len)))
-					ret = -EFAULT;
+					return -EFAULT;
+
+				if (len > HID_MAX_DESCRIPTOR_SIZE - 1)
+					return -EINVAL;
+
+				if (copy_to_user(arg + offsetof(
+				    struct hidraw_report_descriptor,
+				    value[0]),
+				    hid->rdesc,
+				    min(hid->rsize, len)))
+					return -EFAULT;
+
 				break;
 			}
 		case HIDIOCGRAWINFO:
 			{
 				struct hidraw_devinfo dinfo;
 
-				dinfo.bustype = dev->hid->bus;
-				dinfo.vendor = dev->hid->vendor;
-				dinfo.product = dev->hid->product;
-				if (copy_to_user(user_arg, &dinfo, sizeof(dinfo)))
-					ret = -EFAULT;
+				dinfo.bustype = hid->bus;
+				dinfo.vendor = hid->vendor;
+				dinfo.product = hid->product;
+				if (copy_to_user(arg, &dinfo, sizeof(dinfo)))
+					return -EFAULT;
 				break;
 			}
 		case HIDIOCREVOKE:
 			{
-				if (user_arg)
-					ret = -EINVAL;
-				else
-					ret = hidraw_revoke(list);
-				break;
+				struct hidraw_list *list = file->private_data;
+
+				if (arg)
+					return -EINVAL;
+
+				return hidraw_revoke(list);
 			}
 		default:
-			{
-				struct hid_device *hid = dev->hid;
-				if (_IOC_TYPE(cmd) != 'H') {
-					ret = -EINVAL;
-					break;
-				}
+			/*
+			 * None of the above ioctls can return -EAGAIN, so
+			 * use it as a marker that we need to check variable
+			 * length ioctls.
+			 */
+			return -EAGAIN;
+	}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCSFEATURE(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_send_report(file, user_arg, len, HID_FEATURE_REPORT);
-					break;
-				}
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGFEATURE(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_get_report(file, user_arg, len, HID_FEATURE_REPORT);
-					break;
-				}
+	return 0;
+}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCSINPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_send_report(file, user_arg, len, HID_INPUT_REPORT);
-					break;
-				}
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGINPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_get_report(file, user_arg, len, HID_INPUT_REPORT);
-					break;
-				}
+static long hidraw_rw_variable_size_ioctl(struct file *file, struct hidraw *dev, unsigned int cmd,
+					  void __user *user_arg)
+{
+	int len = _IOC_SIZE(cmd);
+
+	switch (cmd & ~IOCSIZE_MASK) {
+	case HIDIOCSFEATURE(0):
+		return hidraw_send_report(file, user_arg, len, HID_FEATURE_REPORT);
+	case HIDIOCGFEATURE(0):
+		return hidraw_get_report(file, user_arg, len, HID_FEATURE_REPORT);
+	case HIDIOCSINPUT(0):
+		return hidraw_send_report(file, user_arg, len, HID_INPUT_REPORT);
+	case HIDIOCGINPUT(0):
+		return hidraw_get_report(file, user_arg, len, HID_INPUT_REPORT);
+	case HIDIOCSOUTPUT(0):
+		return hidraw_send_report(file, user_arg, len, HID_OUTPUT_REPORT);
+	case HIDIOCGOUTPUT(0):
+		return hidraw_get_report(file, user_arg, len, HID_OUTPUT_REPORT);
+	}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCSOUTPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_send_report(file, user_arg, len, HID_OUTPUT_REPORT);
-					break;
-				}
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGOUTPUT(0))) {
-					int len = _IOC_SIZE(cmd);
-					ret = hidraw_get_report(file, user_arg, len, HID_OUTPUT_REPORT);
-					break;
-				}
+	return -EINVAL;
+}
 
-				/* Begin Read-only ioctls. */
-				if (_IOC_DIR(cmd) != _IOC_READ) {
-					ret = -EINVAL;
-					break;
-				}
+static long hidraw_ro_variable_size_ioctl(struct file *file, struct hidraw *dev, unsigned int cmd,
+					  void __user *user_arg)
+{
+	struct hid_device *hid = dev->hid;
+	int len = _IOC_SIZE(cmd);
+	int field_len;
+
+	switch (cmd & ~IOCSIZE_MASK) {
+	case HIDIOCGRAWNAME(0):
+		field_len = strlen(hid->name) + 1;
+		if (len > field_len)
+			len = field_len;
+		return copy_to_user(user_arg, hid->name, len) ?  -EFAULT : len;
+	case HIDIOCGRAWPHYS(0):
+		field_len = strlen(hid->phys) + 1;
+		if (len > field_len)
+			len = field_len;
+		return copy_to_user(user_arg, hid->phys, len) ?  -EFAULT : len;
+	case HIDIOCGRAWUNIQ(0):
+		field_len = strlen(hid->uniq) + 1;
+		if (len > field_len)
+			len = field_len;
+		return copy_to_user(user_arg, hid->uniq, len) ?  -EFAULT : len;
+	}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWNAME(0))) {
-					int len = strlen(hid->name) + 1;
-					if (len > _IOC_SIZE(cmd))
-						len = _IOC_SIZE(cmd);
-					ret = copy_to_user(user_arg, hid->name, len) ?
-						-EFAULT : len;
-					break;
-				}
+	return -EINVAL;
+}
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWPHYS(0))) {
-					int len = strlen(hid->phys) + 1;
-					if (len > _IOC_SIZE(cmd))
-						len = _IOC_SIZE(cmd);
-					ret = copy_to_user(user_arg, hid->phys, len) ?
-						-EFAULT : len;
-					break;
-				}
+static long hidraw_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+	unsigned int minor = iminor(inode);
+	struct hidraw *dev;
+	struct hidraw_list *list = file->private_data;
+	void __user *user_arg = (void __user *)arg;
+	int ret;
 
-				if (_IOC_NR(cmd) == _IOC_NR(HIDIOCGRAWUNIQ(0))) {
-					int len = strlen(hid->uniq) + 1;
-					if (len > _IOC_SIZE(cmd))
-						len = _IOC_SIZE(cmd);
-					ret = copy_to_user(user_arg, hid->uniq, len) ?
-						-EFAULT : len;
-					break;
-				}
-			}
+	down_read(&minors_rwsem);
+	dev = hidraw_table[minor];
+	if (!dev || !dev->exist || hidraw_is_revoked(list)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (_IOC_TYPE(cmd) != 'H') {
+		ret = -EINVAL;
+		goto out;
+	}
 
+	if (_IOC_NR(cmd) > HIDIOCTL_LAST || _IOC_NR(cmd) == 0) {
 		ret = -ENOTTY;
+		goto out;
 	}
+
+	ret = hidraw_fixed_size_ioctl(file, dev, cmd, user_arg);
+	if (ret != -EAGAIN)
+		goto out;
+
+	switch (_IOC_DIR(cmd)) {
+	case (_IOC_READ | _IOC_WRITE):
+		ret = hidraw_rw_variable_size_ioctl(file, dev, cmd, user_arg);
+		break;
+	case _IOC_READ:
+		ret = hidraw_ro_variable_size_ioctl(file, dev, cmd, user_arg);
+		break;
+	default:
+		/* Any other IOC_DIR is wrong */
+		ret = -EINVAL;
+	}
+
 out:
 	up_read(&minors_rwsem);
 	return ret;
diff --git a/drivers/hwmon/mlxreg-fan.c b/drivers/hwmon/mlxreg-fan.c
index c25a54d5b39a..0ba9195c9d71 100644
--- a/drivers/hwmon/mlxreg-fan.c
+++ b/drivers/hwmon/mlxreg-fan.c
@@ -113,8 +113,8 @@ struct mlxreg_fan {
 	int divider;
 };
 
-static int mlxreg_fan_set_cur_state(struct thermal_cooling_device *cdev,
-				    unsigned long state);
+static int _mlxreg_fan_set_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long state, bool thermal);
 
 static int
 mlxreg_fan_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
@@ -224,8 +224,9 @@ mlxreg_fan_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 				 * last thermal state.
 				 */
 				if (pwm->last_hwmon_state >= pwm->last_thermal_state)
-					return mlxreg_fan_set_cur_state(pwm->cdev,
-									pwm->last_hwmon_state);
+					return _mlxreg_fan_set_cur_state(pwm->cdev,
+									 pwm->last_hwmon_state,
+									 false);
 				return 0;
 			}
 			return regmap_write(fan->regmap, pwm->reg, val);
@@ -357,9 +358,8 @@ static int mlxreg_fan_get_cur_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static int mlxreg_fan_set_cur_state(struct thermal_cooling_device *cdev,
-				    unsigned long state)
-
+static int _mlxreg_fan_set_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long state, bool thermal)
 {
 	struct mlxreg_fan_pwm *pwm = cdev->devdata;
 	struct mlxreg_fan *fan = pwm->fan;
@@ -369,7 +369,8 @@ static int mlxreg_fan_set_cur_state(struct thermal_cooling_device *cdev,
 		return -EINVAL;
 
 	/* Save thermal state. */
-	pwm->last_thermal_state = state;
+	if (thermal)
+		pwm->last_thermal_state = state;
 
 	state = max_t(unsigned long, state, pwm->last_hwmon_state);
 	err = regmap_write(fan->regmap, pwm->reg,
@@ -381,6 +382,13 @@ static int mlxreg_fan_set_cur_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+static int mlxreg_fan_set_cur_state(struct thermal_cooling_device *cdev,
+				    unsigned long state)
+
+{
+	return _mlxreg_fan_set_cur_state(cdev, state, true);
+}
+
 static const struct thermal_cooling_device_ops mlxreg_fan_cooling_ops = {
 	.get_max_state	= mlxreg_fan_get_max_state,
 	.get_cur_state	= mlxreg_fan_get_cur_state,
diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 25fd02955c38..abfff42b20c9 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -521,6 +521,10 @@ static int __catu_probe(struct device *dev, struct resource *res)
 	struct coresight_platform_data *pdata = NULL;
 	void __iomem *base;
 
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
+
 	catu_desc.name = coresight_alloc_device_name(&catu_devs, dev);
 	if (!catu_desc.name)
 		return -ENOMEM;
@@ -668,18 +672,26 @@ static int catu_runtime_suspend(struct device *dev)
 {
 	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
+	clk_disable_unprepare(drvdata->atclk);
+	clk_disable_unprepare(drvdata->pclk);
+
 	return 0;
 }
 
 static int catu_runtime_resume(struct device *dev)
 {
 	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
+	int ret;
 
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_prepare_enable(drvdata->pclk);
-	return 0;
+	ret = clk_prepare_enable(drvdata->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(drvdata->atclk);
+	if (ret)
+		clk_disable_unprepare(drvdata->pclk);
+
+	return ret;
 }
 #endif
 
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 755776cd19c5..6e6b7aac206d 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -62,6 +62,7 @@
 
 struct catu_drvdata {
 	struct clk *pclk;
+	struct clk *atclk;
 	void __iomem *base;
 	struct coresight_device *csdev;
 	int irq;
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index b7941d8abbfe..f20d4cab8f1d 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1200,8 +1200,9 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		goto out_unlock;
 	}
 
-	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
-	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
+	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
+	    sink_ops(csdev)->alloc_buffer) {
 		ret = etm_perf_add_symlink_sink(csdev);
 
 		if (ret) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index be8b46f26ddc..7b9eaeb115d2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -481,7 +481,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
 	}
-	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
+	if (drvdata->numextinsel)
+		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
 		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
@@ -1362,6 +1363,7 @@ static void etm4_init_arch_data(void *info)
 	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
 	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
 	drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
+	drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
 	/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
 	drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
 	/* ATBTRIG, bit[22] implementation can support ATB triggers? */
@@ -1789,7 +1791,9 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
 		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
 		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
 	}
-	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
+
+	if (drvdata->numextinsel)
+		state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
@@ -1921,7 +1925,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
 	}
-	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
+	if (drvdata->numextinsel)
+		etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
@@ -2152,6 +2157,10 @@ static int etm4_probe(struct device *dev)
 	if (WARN_ON(!drvdata))
 		return -ENOMEM;
 
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
+
 	if (pm_save_enable == PARAM_PM_SAVE_FIRMWARE)
 		pm_save_enable = coresight_loses_context_with_cpu(dev) ?
 			       PARAM_PM_SAVE_SELF_HOSTED : PARAM_PM_SAVE_NEVER;
@@ -2400,8 +2409,8 @@ static int etm4_runtime_suspend(struct device *dev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata->pclk && !IS_ERR(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
+	clk_disable_unprepare(drvdata->atclk);
+	clk_disable_unprepare(drvdata->pclk);
 
 	return 0;
 }
@@ -2409,11 +2418,17 @@ static int etm4_runtime_suspend(struct device *dev)
 static int etm4_runtime_resume(struct device *dev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
+	int ret;
 
-	if (drvdata->pclk && !IS_ERR(drvdata->pclk))
-		clk_prepare_enable(drvdata->pclk);
+	ret = clk_prepare_enable(drvdata->pclk);
+	if (ret)
+		return ret;
 
-	return 0;
+	ret = clk_prepare_enable(drvdata->atclk);
+	if (ret)
+		clk_disable_unprepare(drvdata->pclk);
+
+	return ret;
 }
 #endif
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9e9165f62e81..3683966bd060 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -162,6 +162,7 @@
 #define TRCIDR4_NUMVMIDC_MASK			GENMASK(31, 28)
 
 #define TRCIDR5_NUMEXTIN_MASK			GENMASK(8, 0)
+#define TRCIDR5_NUMEXTINSEL_MASK               GENMASK(11, 9)
 #define TRCIDR5_TRACEIDSIZE_MASK		GENMASK(21, 16)
 #define TRCIDR5_ATBTRIG				BIT(22)
 #define TRCIDR5_LPOVERRIDE			BIT(23)
@@ -919,7 +920,8 @@ struct etmv4_save_state {
 
 /**
  * struct etm4_drvdata - specifics associated to an ETM component
- * @pclk        APB clock if present, otherwise NULL
+ * @pclk:       APB clock if present, otherwise NULL
+ * @atclk:      Optional clock for the core parts of the ETMv4.
  * @base:       Memory mapped base address for this component.
  * @csdev:      Component vitals needed by the framework.
  * @spinlock:   Only one at a time pls.
@@ -987,6 +989,7 @@ struct etmv4_save_state {
  */
 struct etmv4_drvdata {
 	struct clk			*pclk;
+	struct clk			*atclk;
 	void __iomem			*base;
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
@@ -998,6 +1001,7 @@ struct etmv4_drvdata {
 	u8				nr_cntr;
 	u8				nr_ext_inp;
 	u8				numcidc;
+	u8				numextinsel;
 	u8				numvmidc;
 	u8				nrseqstate;
 	u8				nr_event;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 475fa4bb6813..96ef2517dd43 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -480,6 +480,10 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	struct coresight_desc desc = { 0 };
 	struct coresight_dev_list *dev_list = NULL;
 
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
+
 	ret = -ENOMEM;
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -700,18 +704,26 @@ static int tmc_runtime_suspend(struct device *dev)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
+	clk_disable_unprepare(drvdata->atclk);
+	clk_disable_unprepare(drvdata->pclk);
+
 	return 0;
 }
 
 static int tmc_runtime_resume(struct device *dev)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
+	int ret;
 
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_prepare_enable(drvdata->pclk);
-	return 0;
+	ret = clk_prepare_enable(drvdata->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(drvdata->atclk);
+	if (ret)
+		clk_disable_unprepare(drvdata->pclk);
+
+	return ret;
 }
 #endif
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 2671926be62a..2a53acbb5990 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -166,6 +166,7 @@ struct etr_buf {
 
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
+ * @atclk:	optional clock for the core parts of the TMC.
  * @pclk:	APB clock if present, otherwise NULL
  * @base:	memory mapped base address for this component.
  * @csdev:	component vitals needed by the framework.
@@ -191,6 +192,7 @@ struct etr_buf {
  * @perf_buf:	PERF buffer for ETR.
  */
 struct tmc_drvdata {
+	struct clk		*atclk;
 	struct clk		*pclk;
 	void __iomem		*base;
 	struct coresight_device	*csdev;
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index bfca103f9f84..865fd6273e5e 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -71,12 +71,15 @@ static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
 	if (tpdm_has_dsb_dataset(tpdm_data)) {
 		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
 				"qcom,dsb-element-bits", &drvdata->dsb_esize);
+		if (rc)
+			goto out;
 	}
 	if (tpdm_has_cmb_dataset(tpdm_data)) {
 		rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
 				"qcom,cmb-element-bits", &drvdata->cmb_esize);
 	}
 
+out:
 	if (rc)
 		dev_warn_once(&csdev->dev,
 			"Failed to read TPDM Element size: %d\n", rc);
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 96a32b213669..d771980a278d 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -22,7 +22,8 @@
 #include "coresight-self-hosted-trace.h"
 #include "coresight-trbe.h"
 
-#define PERF_IDX2OFF(idx, buf) ((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf) \
+	((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /*
  * A padding packet that will help the user space tools
@@ -744,12 +745,12 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
 
 	buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, trbe_alloc_node(event));
 	if (!buf)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	pglist = kcalloc(nr_pages, sizeof(*pglist), GFP_KERNEL);
 	if (!pglist) {
 		kfree(buf);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 
 	for (i = 0; i < nr_pages; i++)
@@ -759,7 +760,7 @@ static void *arm_trbe_alloc_buffer(struct coresight_device *csdev,
 	if (!buf->trbe_base) {
 		kfree(pglist);
 		kfree(buf);
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 	}
 	buf->trbe_limit = buf->trbe_base + nr_pages * PAGE_SIZE;
 	buf->trbe_write = buf->trbe_base;
@@ -1266,7 +1267,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	 * into the device for that purpose.
 	 */
 	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
-	if (IS_ERR(desc.pdata))
+	if (!desc.pdata)
 		goto cpu_clear;
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index ef9bed2f2dcc..24c0ada72f6a 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -311,6 +311,7 @@ static int dw_i2c_plat_probe(struct platform_device *pdev)
 
 exit_probe:
 	dw_i2c_plat_pm_cleanup(dev);
+	i2c_dw_prepare_clk(dev, false);
 exit_reset:
 	reset_control_assert(dev->rst);
 	return ret;
@@ -328,9 +329,11 @@ static void dw_i2c_plat_remove(struct platform_device *pdev)
 	i2c_dw_disable(dev);
 
 	pm_runtime_dont_use_autosuspend(device);
-	pm_runtime_put_sync(device);
+	pm_runtime_put_noidle(device);
 	dw_i2c_plat_pm_cleanup(dev);
 
+	i2c_dw_prepare_clk(dev, false);
+
 	i2c_dw_remove_lock_support(dev);
 
 	reset_control_assert(dev->rst);
diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index e0ba653dec2d..8beef73960c7 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -1243,6 +1243,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 {
 	int ret;
 	int left_num = num;
+	bool write_then_read_en = false;
 	struct mtk_i2c *i2c = i2c_get_adapdata(adap);
 
 	ret = clk_bulk_enable(I2C_MT65XX_CLK_MAX, i2c->clocks);
@@ -1256,6 +1257,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M_RD) &&
 		    msgs[0].addr == msgs[1].addr) {
 			i2c->auto_restart = 0;
+			write_then_read_en = true;
 		}
 	}
 
@@ -1280,12 +1282,10 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		else
 			i2c->op = I2C_MASTER_WR;
 
-		if (!i2c->auto_restart) {
-			if (num > 1) {
-				/* combined two messages into one transaction */
-				i2c->op = I2C_MASTER_WRRD;
-				left_num--;
-			}
+		if (write_then_read_en) {
+			/* combined two messages into one transaction */
+			i2c->op = I2C_MASTER_WRRD;
+			left_num--;
 		}
 
 		/* always use DMA mode. */
@@ -1293,7 +1293,10 @@ static int mtk_i2c_transfer(struct i2c_adapter *adap,
 		if (ret < 0)
 			goto err_exit;
 
-		msgs++;
+		if (i2c->op == I2C_MASTER_WRRD)
+			msgs += 2;
+		else
+			msgs++;
 	}
 	/* the return value is number of executed messages */
 	ret = num;
diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 474a96ebda22..a1945bf9ef19 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -377,6 +377,7 @@ static int svc_i3c_master_handle_ibi(struct svc_i3c_master *master,
 						SVC_I3C_MSTATUS_COMPLETE(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for COMPLETE\n");
+		i3c_generic_ibi_recycle_slot(data->ibi_pool, slot);
 		return ret;
 	}
 
@@ -438,9 +439,24 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	 */
 	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
 
-	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
-	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
-	       SVC_I3C_MCTRL_IBIRESP_AUTO,
+	/*
+	 * Write REQUEST_START_ADDR request to emit broadcast address for arbitration,
+	 * instend of using AUTO_IBI.
+	 *
+	 * Using AutoIBI request may cause controller to remain in AutoIBI state when
+	 * there is a glitch on SDA line (high->low->high).
+	 * 1. SDA high->low, raising an interrupt to execute IBI isr.
+	 * 2. SDA low->high.
+	 * 3. IBI isr writes an AutoIBI request.
+	 * 4. The controller will not start AutoIBI process because SDA is not low.
+	 * 5. IBIWON polling times out.
+	 * 6. Controller reamins in AutoIBI state and doesn't accept EmitStop request.
+	 */
+	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
+	       SVC_I3C_MCTRL_TYPE_I3C |
+	       SVC_I3C_MCTRL_IBIRESP_MANUAL |
+	       SVC_I3C_MCTRL_DIR(SVC_I3C_MCTRL_DIR_WRITE) |
+	       SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
@@ -460,10 +476,15 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	switch (ibitype) {
 	case SVC_I3C_MSTATUS_IBITYPE_IBI:
 		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
-		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
+		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)) {
 			svc_i3c_master_nack_ibi(master);
-		else
+		} else {
+			if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
+				svc_i3c_master_ack_ibi(master, true);
+			else
+				svc_i3c_master_ack_ibi(master, false);
 			svc_i3c_master_handle_ibi(master, dev);
+		}
 		break;
 	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
 		if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 1155487f7aea..85ba80c57d08 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/iio-opaque.h>
@@ -602,7 +603,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 {
 	int scale_type, scale_val, scale_val2;
 	int offset_type, offset_val, offset_val2;
-	s64 raw64 = raw;
+	s64 denominator, raw64 = raw;
 
 	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
 				       IIO_CHAN_INFO_OFFSET);
@@ -637,7 +638,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		 * If no channel scaling is available apply consumer scale to
 		 * raw value and return.
 		 */
-		*processed = raw * scale;
+		*processed = raw64 * scale;
 		return 0;
 	}
 
@@ -646,20 +647,19 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 		*processed = raw64 * scale_val * scale;
 		break;
 	case IIO_VAL_INT_PLUS_MICRO:
-		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val * scale;
-		else
-			*processed = raw64 * scale_val * scale;
-		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
-				      1000000LL);
-		break;
 	case IIO_VAL_INT_PLUS_NANO:
-		if (scale_val2 < 0)
-			*processed = -raw64 * scale_val * scale;
-		else
-			*processed = raw64 * scale_val * scale;
-		*processed += div_s64(raw64 * (s64)scale_val2 * scale,
-				      1000000000LL);
+		switch (scale_type) {
+		case IIO_VAL_INT_PLUS_MICRO:
+			denominator = MICRO;
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			denominator = NANO;
+			break;
+		}
+		*processed = raw64 * scale * abs(scale_val);
+		*processed += div_s64(raw64 * scale * abs(scale_val2), denominator);
+		if (scale_val < 0 || scale_val2 < 0)
+			*processed *= -1;
 		break;
 	case IIO_VAL_FRACTIONAL:
 		*processed = div_s64(raw64 * (s64)scale_val * scale,
diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index be0743dac3ff..929e89841c12 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -454,14 +454,10 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
 {
 	int ret = 0;
 
-	if (ndev_flags & IFF_LOOPBACK) {
+	if (ndev_flags & IFF_LOOPBACK)
 		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
-	} else {
-		if (!(ndev_flags & IFF_NOARP)) {
-			/* If the device doesn't do ARP internally */
-			ret = fetch_ha(dst, addr, dst_in, seq);
-		}
-	}
+	else
+		ret = fetch_ha(dst, addr, dst_in, seq);
 	return ret;
 }
 
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d45e3909dafe..50bb3c43f40b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1032,8 +1032,8 @@ static noinline void cm_destroy_id_wait_timeout(struct ib_cm_id *cm_id,
 	struct cm_id_private *cm_id_priv;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	pr_err("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
-	       cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
+	pr_err_ratelimited("%s: cm_id=%p timed out. state %d -> %d, refcnt=%d\n", __func__,
+			   cm_id, old_state, cm_id->state, refcount_read(&cm_id_priv->refcount));
 }
 
 static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 53571e6b3162..66df5bed6a56 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1013,6 +1013,8 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 	if (timeout > IB_SA_LOCAL_SVC_TIMEOUT_MAX)
 		timeout = IB_SA_LOCAL_SVC_TIMEOUT_MAX;
 
+	spin_lock_irqsave(&ib_nl_request_lock, flags);
+
 	delta = timeout - sa_local_svc_timeout_ms;
 	if (delta < 0)
 		abs_delta = -delta;
@@ -1020,7 +1022,6 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 		abs_delta = delta;
 
 	if (delta != 0) {
-		spin_lock_irqsave(&ib_nl_request_lock, flags);
 		sa_local_svc_timeout_ms = timeout;
 		list_for_each_entry(query, &ib_nl_request_list, list) {
 			if (delta < 0 && abs_delta > query->timeout)
@@ -1038,9 +1039,10 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 		if (delay)
 			mod_delayed_work(ib_nl_wq, &ib_nl_timed_work,
 					 (unsigned long)delay);
-		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
 	}
 
+	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+
 settimeout_out:
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 435c456a4fd5..f3e58797705d 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/bitmap.h>
+#include <linux/log2.h>
 #include <linux/sched.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
@@ -865,6 +866,51 @@ static void fill_esw_mgr_reg_c0(struct mlx5_core_dev *mdev,
 	resp->reg_c0.mask = mlx5_eswitch_get_vport_metadata_mask();
 }
 
+/*
+ * Calculate maximum SQ overhead across all QP types.
+ * Other QP types (REG_UMR, UC, RC, UD/SMI/GSI, XRC_TGT)
+ * have smaller overhead than the types calculated below,
+ * so they are implicitly included.
+ */
+static u32 mlx5_ib_calc_max_sq_overhead(void)
+{
+	u32 max_overhead_xrc, overhead_ud_lso, a, b;
+
+	/* XRC_INI */
+	max_overhead_xrc = sizeof(struct mlx5_wqe_xrc_seg);
+	max_overhead_xrc += sizeof(struct mlx5_wqe_ctrl_seg);
+	a = sizeof(struct mlx5_wqe_atomic_seg) +
+	    sizeof(struct mlx5_wqe_raddr_seg);
+	b = sizeof(struct mlx5_wqe_umr_ctrl_seg) +
+	    sizeof(struct mlx5_mkey_seg) +
+	    MLX5_IB_SQ_UMR_INLINE_THRESHOLD / MLX5_IB_UMR_OCTOWORD;
+	max_overhead_xrc += max(a, b);
+
+	/* UD with LSO */
+	overhead_ud_lso = sizeof(struct mlx5_wqe_ctrl_seg);
+	overhead_ud_lso += sizeof(struct mlx5_wqe_eth_pad);
+	overhead_ud_lso += sizeof(struct mlx5_wqe_eth_seg);
+	overhead_ud_lso += sizeof(struct mlx5_wqe_datagram_seg);
+
+	return max(max_overhead_xrc, overhead_ud_lso);
+}
+
+static u32 mlx5_ib_calc_max_qp_wr(struct mlx5_ib_dev *dev)
+{
+	struct mlx5_core_dev *mdev = dev->mdev;
+	u32 max_wqe_bb_units = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
+	u32 max_wqe_size;
+	/* max QP overhead + 1 SGE, no inline, no special features */
+	max_wqe_size = mlx5_ib_calc_max_sq_overhead() +
+		       sizeof(struct mlx5_wqe_data_seg);
+
+	max_wqe_size = roundup_pow_of_two(max_wqe_size);
+
+	max_wqe_size = ALIGN(max_wqe_size, MLX5_SEND_WQE_BB);
+
+	return (max_wqe_bb_units * MLX5_SEND_WQE_BB) / max_wqe_size;
+}
+
 static int mlx5_ib_query_device(struct ib_device *ibdev,
 				struct ib_device_attr *props,
 				struct ib_udata *uhw)
@@ -1023,7 +1069,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	props->max_mr_size	   = ~0ull;
 	props->page_size_cap	   = ~(min_page_size - 1);
 	props->max_qp		   = 1 << MLX5_CAP_GEN(mdev, log_max_qp);
-	props->max_qp_wr	   = 1 << MLX5_CAP_GEN(mdev, log_max_qp_sz);
+	props->max_qp_wr = mlx5_ib_calc_max_qp_wr(dev);
 	max_rq_sg =  MLX5_CAP_GEN(mdev, max_wqe_sz_rq) /
 		     sizeof(struct mlx5_wqe_data_seg);
 	max_sq_desc = min_t(int, MLX5_CAP_GEN(mdev, max_wqe_sz_sq), 512);
@@ -1767,7 +1813,8 @@ static void deallocate_uars(struct mlx5_ib_dev *dev,
 }
 
 static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
-				struct mlx5_core_dev *slave)
+				struct mlx5_core_dev *slave,
+				struct mlx5_ib_lb_state *lb_state)
 {
 	int err;
 
@@ -1779,6 +1826,7 @@ static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
 	if (err)
 		goto out;
 
+	lb_state->force_enable = true;
 	return 0;
 
 out:
@@ -1787,16 +1835,22 @@ static int mlx5_ib_enable_lb_mp(struct mlx5_core_dev *master,
 }
 
 static void mlx5_ib_disable_lb_mp(struct mlx5_core_dev *master,
-				  struct mlx5_core_dev *slave)
+				  struct mlx5_core_dev *slave,
+				  struct mlx5_ib_lb_state *lb_state)
 {
 	mlx5_nic_vport_update_local_lb(slave, false);
 	mlx5_nic_vport_update_local_lb(master, false);
+
+	lb_state->force_enable = false;
 }
 
 int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
 	int err = 0;
 
+	if (dev->lb.force_enable)
+		return 0;
+
 	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td++;
@@ -1818,6 +1872,9 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 {
+	if (dev->lb.force_enable)
+		return;
+
 	mutex_lock(&dev->lb.mutex);
 	if (td)
 		dev->lb.user_td--;
@@ -3475,7 +3532,7 @@ static void mlx5_ib_unbind_slave_port(struct mlx5_ib_dev *ibdev,
 
 	lockdep_assert_held(&mlx5_ib_multiport_mutex);
 
-	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev);
+	mlx5_ib_disable_lb_mp(ibdev->mdev, mpi->mdev, &ibdev->lb);
 
 	mlx5_core_mp_event_replay(ibdev->mdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
@@ -3572,7 +3629,7 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 				  MLX5_DRIVER_EVENT_AFFILIATION_DONE,
 				  &key);
 
-	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev);
+	err = mlx5_ib_enable_lb_mp(ibdev->mdev, mpi->mdev, &ibdev->lb);
 	if (err)
 		goto unbind;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 29bde64ea1ea..f49cb588a856 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1083,6 +1083,7 @@ struct mlx5_ib_lb_state {
 	u32			user_td;
 	int			qps;
 	bool			enabled;
+	bool			force_enable;
 };
 
 struct mlx5_ib_pf_eq {
diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
index 80332638d9e3..be6cd8ce4d97 100644
--- a/drivers/infiniband/sw/rxe/rxe_task.c
+++ b/drivers/infiniband/sw/rxe/rxe_task.c
@@ -132,8 +132,12 @@ static void do_task(struct rxe_task *task)
 		 * yield the cpu and reschedule the task
 		 */
 		if (!ret) {
-			task->state = TASK_STATE_IDLE;
-			resched = 1;
+			if (task->state != TASK_STATE_DRAINING) {
+				task->state = TASK_STATE_IDLE;
+				resched = 1;
+			} else {
+				cont = 1;
+			}
 			goto exit;
 		}
 
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 7ca0297d68a4..d0c0cde09f11 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -773,7 +773,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	struct siw_wqe *wqe = tx_wqe(qp);
 
 	unsigned long flags;
-	int rv = 0;
+	int rv = 0, imm_err = 0;
 
 	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
 		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
@@ -959,9 +959,17 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	 * Send directly if SQ processing is not in progress.
 	 * Eventual immediate errors (rv < 0) do not affect the involved
 	 * RI resources (Verbs, 8.3.1) and thus do not prevent from SQ
-	 * processing, if new work is already pending. But rv must be passed
-	 * to caller.
+	 * processing, if new work is already pending. But rv and pointer
+	 * to failed work request must be passed to caller.
 	 */
+	if (unlikely(rv < 0)) {
+		/*
+		 * Immediate error
+		 */
+		siw_dbg_qp(qp, "Immediate error %d\n", rv);
+		imm_err = rv;
+		*bad_wr = wr;
+	}
 	if (wqe->wr_status != SIW_WR_IDLE) {
 		spin_unlock_irqrestore(&qp->sq_lock, flags);
 		goto skip_direct_sending;
@@ -986,15 +994,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 
 	up_read(&qp->state_lock);
 
-	if (rv >= 0)
-		return 0;
-	/*
-	 * Immediate error
-	 */
-	siw_dbg_qp(qp, "error %d\n", rv);
+	if (unlikely(imm_err))
+		return imm_err;
 
-	*bad_wr = wr;
-	return rv;
+	return (rv >= 0) ? 0 : rv;
 }
 
 /*
diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 2c51ea9d01d7..13336a2fd49c 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -775,6 +775,7 @@ static int uinput_ff_upload_to_user(char __user *buffer,
 	if (in_compat_syscall()) {
 		struct uinput_ff_upload_compat ff_up_compat;
 
+		memset(&ff_up_compat, 0, sizeof(ff_up_compat));
 		ff_up_compat.request_id = ff_up->request_id;
 		ff_up_compat.retval = ff_up->retval;
 		/*
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 3ddabc5a2c99..d7496d47eabe 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -3319,7 +3319,7 @@ static int mxt_probe(struct i2c_client *client)
 	if (data->reset_gpio) {
 		/* Wait a while and then de-assert the RESET GPIO line */
 		msleep(MXT_RESET_GPIO_TIME);
-		gpiod_set_value(data->reset_gpio, 0);
+		gpiod_set_value_cansleep(data->reset_gpio, 0);
 		msleep(MXT_RESET_INVALID_CHG);
 	}
 
diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index affbf4a1558d..5aa7f46a420b 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -435,8 +435,21 @@ static int domain_translation_struct_show(struct seq_file *m,
 			}
 			pgd &= VTD_PAGE_MASK;
 		} else { /* legacy mode */
-			pgd = context->lo & VTD_PAGE_MASK;
-			agaw = context->hi & 7;
+			u8 tt = (u8)(context->lo & GENMASK_ULL(3, 2)) >> 2;
+
+			/*
+			 * According to Translation Type(TT),
+			 * get the page table pointer(SSPTPTR).
+			 */
+			switch (tt) {
+			case CONTEXT_TT_MULTI_LEVEL:
+			case CONTEXT_TT_DEV_IOTLB:
+				pgd = context->lo & VTD_PAGE_MASK;
+				agaw = context->hi & 7;
+				break;
+			default:
+				goto iommu_unlock;
+			}
 		}
 
 		seq_printf(m, "Device %04x:%02x:%02x.%x ",
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index f521155fb793..df24a62e8ca4 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -541,7 +541,8 @@ enum {
 #define pasid_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_pasid((iommu)->ecap))
 #define ssads_supported(iommu) (sm_supported(iommu) &&                 \
-				ecap_slads((iommu)->ecap))
+				ecap_slads((iommu)->ecap) &&           \
+				ecap_smpwc(iommu->ecap))
 #define nested_supported(iommu)	(sm_supported(iommu) &&			\
 				 ecap_nest((iommu)->ecap))
 
diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
index 07a83bb2dfdf..bb00097b1ae5 100644
--- a/drivers/leds/flash/leds-qcom-flash.c
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2022, 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #include <linux/bitfield.h>
@@ -114,36 +114,39 @@ enum {
 	REG_THERM_THRSH1,
 	REG_THERM_THRSH2,
 	REG_THERM_THRSH3,
+	REG_TORCH_CLAMP,
 	REG_MAX_COUNT,
 };
 
 static const struct reg_field mvflash_3ch_regs[REG_MAX_COUNT] = {
-	REG_FIELD(0x08, 0, 7),			/* status1	*/
-	REG_FIELD(0x09, 0, 7),                  /* status2	*/
-	REG_FIELD(0x0a, 0, 7),                  /* status3	*/
-	REG_FIELD_ID(0x40, 0, 7, 3, 1),         /* chan_timer	*/
-	REG_FIELD_ID(0x43, 0, 6, 3, 1),         /* itarget	*/
-	REG_FIELD(0x46, 7, 7),                  /* module_en	*/
-	REG_FIELD(0x47, 0, 5),                  /* iresolution	*/
-	REG_FIELD_ID(0x49, 0, 2, 3, 1),         /* chan_strobe	*/
-	REG_FIELD(0x4c, 0, 2),                  /* chan_en	*/
-	REG_FIELD(0x56, 0, 2),			/* therm_thrsh1 */
-	REG_FIELD(0x57, 0, 2),			/* therm_thrsh2 */
-	REG_FIELD(0x58, 0, 2),			/* therm_thrsh3 */
+	[REG_STATUS1]		= REG_FIELD(0x08, 0, 7),
+	[REG_STATUS2]		= REG_FIELD(0x09, 0, 7),
+	[REG_STATUS3]		= REG_FIELD(0x0a, 0, 7),
+	[REG_CHAN_TIMER]	= REG_FIELD_ID(0x40, 0, 7, 3, 1),
+	[REG_ITARGET]		= REG_FIELD_ID(0x43, 0, 6, 3, 1),
+	[REG_MODULE_EN]		= REG_FIELD(0x46, 7, 7),
+	[REG_IRESOLUTION]	= REG_FIELD(0x47, 0, 5),
+	[REG_CHAN_STROBE]	= REG_FIELD_ID(0x49, 0, 2, 3, 1),
+	[REG_CHAN_EN]		= REG_FIELD(0x4c, 0, 2),
+	[REG_THERM_THRSH1]	= REG_FIELD(0x56, 0, 2),
+	[REG_THERM_THRSH2]	= REG_FIELD(0x57, 0, 2),
+	[REG_THERM_THRSH3]	= REG_FIELD(0x58, 0, 2),
+	[REG_TORCH_CLAMP]	= REG_FIELD(0xec, 0, 6),
 };
 
 static const struct reg_field mvflash_4ch_regs[REG_MAX_COUNT] = {
-	REG_FIELD(0x06, 0, 7),			/* status1	*/
-	REG_FIELD(0x07, 0, 6),			/* status2	*/
-	REG_FIELD(0x09, 0, 7),			/* status3	*/
-	REG_FIELD_ID(0x3e, 0, 7, 4, 1),		/* chan_timer	*/
-	REG_FIELD_ID(0x42, 0, 6, 4, 1),		/* itarget	*/
-	REG_FIELD(0x46, 7, 7),			/* module_en	*/
-	REG_FIELD(0x49, 0, 3),			/* iresolution	*/
-	REG_FIELD_ID(0x4a, 0, 6, 4, 1),		/* chan_strobe	*/
-	REG_FIELD(0x4e, 0, 3),			/* chan_en	*/
-	REG_FIELD(0x7a, 0, 2),			/* therm_thrsh1 */
-	REG_FIELD(0x78, 0, 2),			/* therm_thrsh2 */
+	[REG_STATUS1]		= REG_FIELD(0x06, 0, 7),
+	[REG_STATUS2]		= REG_FIELD(0x07, 0, 6),
+	[REG_STATUS3]		= REG_FIELD(0x09, 0, 7),
+	[REG_CHAN_TIMER]	= REG_FIELD_ID(0x3e, 0, 7, 4, 1),
+	[REG_ITARGET]		= REG_FIELD_ID(0x42, 0, 6, 4, 1),
+	[REG_MODULE_EN]		= REG_FIELD(0x46, 7, 7),
+	[REG_IRESOLUTION]	= REG_FIELD(0x49, 0, 3),
+	[REG_CHAN_STROBE]	= REG_FIELD_ID(0x4a, 0, 6, 4, 1),
+	[REG_CHAN_EN]		= REG_FIELD(0x4e, 0, 3),
+	[REG_THERM_THRSH1]	= REG_FIELD(0x7a, 0, 2),
+	[REG_THERM_THRSH2]	= REG_FIELD(0x78, 0, 2),
+	[REG_TORCH_CLAMP]	= REG_FIELD(0xed, 0, 6),
 };
 
 struct qcom_flash_data {
@@ -156,6 +159,7 @@ struct qcom_flash_data {
 	u8			max_channels;
 	u8			chan_en_bits;
 	u8			revision;
+	u8			torch_clamp;
 };
 
 struct qcom_flash_led {
@@ -702,6 +706,7 @@ static int qcom_flash_register_led_device(struct device *dev,
 	u32 current_ua, timeout_us;
 	u32 channels[4];
 	int i, rc, count;
+	u8 torch_clamp;
 
 	count = fwnode_property_count_u32(node, "led-sources");
 	if (count <= 0) {
@@ -751,6 +756,12 @@ static int qcom_flash_register_led_device(struct device *dev,
 	current_ua = min_t(u32, current_ua, TORCH_CURRENT_MAX_UA * led->chan_count);
 	led->max_torch_current_ma = current_ua / UA_PER_MA;
 
+	torch_clamp = (current_ua / led->chan_count) / TORCH_IRES_UA;
+	if (torch_clamp != 0)
+		torch_clamp--;
+
+	flash_data->torch_clamp = max_t(u8, flash_data->torch_clamp, torch_clamp);
+
 	if (fwnode_property_present(node, "flash-max-microamp")) {
 		flash->led_cdev.flags |= LED_DEV_CAP_FLASH;
 
@@ -918,8 +929,7 @@ static int qcom_flash_led_probe(struct platform_device *pdev)
 		flash_data->leds_count++;
 	}
 
-	return 0;
-
+	return regmap_field_write(flash_data->r_fields[REG_TORCH_CLAMP], flash_data->torch_clamp);
 release:
 	fwnode_handle_put(child);
 	while (flash_data->v4l2_flash[flash_data->leds_count] && flash_data->leds_count)
diff --git a/drivers/leds/leds-lp55xx-common.c b/drivers/leds/leds-lp55xx-common.c
index e71456a56ab8..fd447eb7eb15 100644
--- a/drivers/leds/leds-lp55xx-common.c
+++ b/drivers/leds/leds-lp55xx-common.c
@@ -212,7 +212,7 @@ int lp55xx_update_program_memory(struct lp55xx_chip *chip,
 	 * For LED chip that support page, PAGE is already set in load_engine.
 	 */
 	if (!cfg->pages_per_engine)
-		start_addr += LP55xx_BYTES_PER_PAGE * idx;
+		start_addr += LP55xx_BYTES_PER_PAGE * (idx - 1);
 
 	for (page = 0; page < program_length / LP55xx_BYTES_PER_PAGE; page++) {
 		/* Write to the next page each 32 bytes (if supported) */
diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
index f3a3f2ef6322..391c1df19a76 100644
--- a/drivers/md/dm-core.h
+++ b/drivers/md/dm-core.h
@@ -162,6 +162,7 @@ struct mapped_device {
 #define DMF_SUSPENDED_INTERNALLY 7
 #define DMF_POST_SUSPENDING 8
 #define DMF_EMULATE_ZONE_APPEND 9
+#define DMF_QUEUE_STOPPED 10
 
 void disable_discard(struct mapped_device *md);
 void disable_write_zeroes(struct mapped_device *md);
diff --git a/drivers/md/dm-vdo/indexer/volume-index.c b/drivers/md/dm-vdo/indexer/volume-index.c
index 12f954a0c532..afb062e1f1fb 100644
--- a/drivers/md/dm-vdo/indexer/volume-index.c
+++ b/drivers/md/dm-vdo/indexer/volume-index.c
@@ -836,7 +836,7 @@ static int start_restoring_volume_sub_index(struct volume_sub_index *sub_index,
 				    "%zu bytes decoded of %zu expected", offset,
 				    sizeof(buffer));
 		if (result != VDO_SUCCESS)
-			result = UDS_CORRUPT_DATA;
+			return UDS_CORRUPT_DATA;
 
 		if (memcmp(header.magic, MAGIC_START_5, MAGIC_SIZE) != 0) {
 			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
@@ -928,7 +928,7 @@ static int start_restoring_volume_index(struct volume_index *volume_index,
 				    "%zu bytes decoded of %zu expected", offset,
 				    sizeof(buffer));
 		if (result != VDO_SUCCESS)
-			result = UDS_CORRUPT_DATA;
+			return UDS_CORRUPT_DATA;
 
 		if (memcmp(header.magic, MAGIC_START_6, MAGIC_SIZE) != 0)
 			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index a7deeda59a55..fd84a126f63f 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2918,7 +2918,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 {
 	bool do_lockfs = suspend_flags & DM_SUSPEND_LOCKFS_FLAG;
 	bool noflush = suspend_flags & DM_SUSPEND_NOFLUSH_FLAG;
-	int r;
+	int r = 0;
 
 	lockdep_assert_held(&md->suspend_lock);
 
@@ -2970,8 +2970,10 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * Stop md->queue before flushing md->wq in case request-based
 	 * dm defers requests to md->wq from md->queue.
 	 */
-	if (dm_request_based(md))
+	if (map && dm_request_based(md)) {
 		dm_stop_queue(md->queue);
+		set_bit(DMF_QUEUE_STOPPED, &md->flags);
+	}
 
 	flush_workqueue(md->wq);
 
@@ -2980,7 +2982,8 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	 * We call dm_wait_for_completion to wait for all existing requests
 	 * to finish.
 	 */
-	r = dm_wait_for_completion(md, task_state);
+	if (map)
+		r = dm_wait_for_completion(md, task_state);
 	if (!r)
 		set_bit(dmf_suspended_flag, &md->flags);
 
@@ -2993,7 +2996,7 @@ static int __dm_suspend(struct mapped_device *md, struct dm_table *map,
 	if (r < 0) {
 		dm_queue_flush(md);
 
-		if (dm_request_based(md))
+		if (test_and_clear_bit(DMF_QUEUE_STOPPED, &md->flags))
 			dm_start_queue(md->queue);
 
 		unlock_fs(md);
@@ -3077,7 +3080,7 @@ static int __dm_resume(struct mapped_device *md, struct dm_table *map)
 	 * so that mapping of targets can work correctly.
 	 * Request-based dm is queueing the deferred I/Os in its request_queue.
 	 */
-	if (dm_request_based(md))
+	if (test_and_clear_bit(DMF_QUEUE_STOPPED, &md->flags))
 		dm_start_queue(md->queue);
 
 	unlock_fs(md);
diff --git a/drivers/media/i2c/rj54n1cb0c.c b/drivers/media/i2c/rj54n1cb0c.c
index b7ca39f63dba..6dfc91216851 100644
--- a/drivers/media/i2c/rj54n1cb0c.c
+++ b/drivers/media/i2c/rj54n1cb0c.c
@@ -1329,10 +1329,13 @@ static int rj54n1_probe(struct i2c_client *client)
 			V4L2_CID_GAIN, 0, 127, 1, 66);
 	v4l2_ctrl_new_std(&rj54n1->hdl, &rj54n1_ctrl_ops,
 			V4L2_CID_AUTO_WHITE_BALANCE, 0, 1, 1, 1);
-	rj54n1->subdev.ctrl_handler = &rj54n1->hdl;
-	if (rj54n1->hdl.error)
-		return rj54n1->hdl.error;
 
+	if (rj54n1->hdl.error) {
+		ret = rj54n1->hdl.error;
+		goto err_free_ctrl;
+	}
+
+	rj54n1->subdev.ctrl_handler = &rj54n1->hdl;
 	rj54n1->clk_div		= clk_div;
 	rj54n1->rect.left	= RJ54N1_COLUMN_SKIP;
 	rj54n1->rect.top	= RJ54N1_ROW_SKIP;
diff --git a/drivers/media/pci/zoran/zoran.h b/drivers/media/pci/zoran/zoran.h
index 1cd990468d3d..d05e222b3921 100644
--- a/drivers/media/pci/zoran/zoran.h
+++ b/drivers/media/pci/zoran/zoran.h
@@ -154,12 +154,6 @@ struct zoran_jpg_settings {
 
 struct zoran;
 
-/* zoran_fh contains per-open() settings */
-struct zoran_fh {
-	struct v4l2_fh fh;
-	struct zoran *zr;
-};
-
 struct card_info {
 	enum card_type type;
 	char name[32];
diff --git a/drivers/media/pci/zoran/zoran_driver.c b/drivers/media/pci/zoran/zoran_driver.c
index 5c05e64c71a9..80377992a607 100644
--- a/drivers/media/pci/zoran/zoran_driver.c
+++ b/drivers/media/pci/zoran/zoran_driver.c
@@ -511,12 +511,11 @@ static int zoran_s_fmt_vid_cap(struct file *file, void *__fh,
 			       struct v4l2_format *fmt)
 {
 	struct zoran *zr = video_drvdata(file);
-	struct zoran_fh *fh = __fh;
 	int i;
 	int res = 0;
 
 	if (fmt->fmt.pix.pixelformat == V4L2_PIX_FMT_MJPEG)
-		return zoran_s_fmt_vid_out(file, fh, fmt);
+		return zoran_s_fmt_vid_out(file, __fh, fmt);
 
 	for (i = 0; i < NUM_FORMATS; i++)
 		if (fmt->fmt.pix.pixelformat == zoran_formats[i].fourcc)
diff --git a/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c b/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c
index 0533d4a083d2..a078f1107300 100644
--- a/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c
+++ b/drivers/media/platform/st/sti/delta/delta-mjpeg-dec.c
@@ -239,7 +239,7 @@ static int delta_mjpeg_ipc_open(struct delta_ctx *pctx)
 	return 0;
 }
 
-static int delta_mjpeg_ipc_decode(struct delta_ctx *pctx, struct delta_au *au)
+static int delta_mjpeg_ipc_decode(struct delta_ctx *pctx, dma_addr_t pstart, dma_addr_t pend)
 {
 	struct delta_dev *delta = pctx->dev;
 	struct delta_mjpeg_ctx *ctx = to_ctx(pctx);
@@ -256,8 +256,8 @@ static int delta_mjpeg_ipc_decode(struct delta_ctx *pctx, struct delta_au *au)
 
 	memset(params, 0, sizeof(*params));
 
-	params->picture_start_addr_p = (u32)(au->paddr);
-	params->picture_end_addr_p = (u32)(au->paddr + au->size - 1);
+	params->picture_start_addr_p = pstart;
+	params->picture_end_addr_p = pend;
 
 	/*
 	 * !WARNING!
@@ -374,12 +374,14 @@ static int delta_mjpeg_decode(struct delta_ctx *pctx, struct delta_au *pau)
 	struct delta_dev *delta = pctx->dev;
 	struct delta_mjpeg_ctx *ctx = to_ctx(pctx);
 	int ret;
-	struct delta_au au = *pau;
+	void *au_vaddr = pau->vaddr;
+	dma_addr_t au_dma = pau->paddr;
+	size_t au_size = pau->size;
 	unsigned int data_offset = 0;
 	struct mjpeg_header *header = &ctx->header_struct;
 
 	if (!ctx->header) {
-		ret = delta_mjpeg_read_header(pctx, au.vaddr, au.size,
+		ret = delta_mjpeg_read_header(pctx, au_vaddr, au_size,
 					      header, &data_offset);
 		if (ret) {
 			pctx->stream_errors++;
@@ -405,17 +407,17 @@ static int delta_mjpeg_decode(struct delta_ctx *pctx, struct delta_au *pau)
 			goto err;
 	}
 
-	ret = delta_mjpeg_read_header(pctx, au.vaddr, au.size,
+	ret = delta_mjpeg_read_header(pctx, au_vaddr, au_size,
 				      ctx->header, &data_offset);
 	if (ret) {
 		pctx->stream_errors++;
 		goto err;
 	}
 
-	au.paddr += data_offset;
-	au.vaddr += data_offset;
+	au_dma += data_offset;
+	au_vaddr += data_offset;
 
-	ret = delta_mjpeg_ipc_decode(pctx, &au);
+	ret = delta_mjpeg_ipc_decode(pctx, au_dma, au_dma + au_size - 1);
 	if (ret)
 		goto err;
 
diff --git a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c
index f3dac4a29a83..9cdfef610398 100644
--- a/drivers/mfd/rz-mtu3.c
+++ b/drivers/mfd/rz-mtu3.c
@@ -32,7 +32,7 @@ static const unsigned long rz_mtu3_8bit_ch_reg_offs[][13] = {
 	[RZ_MTU3_CHAN_2] = MTU_8BIT_CH_1_2(0x204, 0x092, 0x205, 0x200, 0x20c, 0x201, 0x202),
 	[RZ_MTU3_CHAN_3] = MTU_8BIT_CH_3_4_6_7(0x008, 0x093, 0x02c, 0x000, 0x04c, 0x002, 0x004, 0x005, 0x038),
 	[RZ_MTU3_CHAN_4] = MTU_8BIT_CH_3_4_6_7(0x009, 0x094, 0x02d, 0x001, 0x04d, 0x003, 0x006, 0x007, 0x039),
-	[RZ_MTU3_CHAN_5] = MTU_8BIT_CH_5(0xab2, 0x1eb, 0xab4, 0xab6, 0xa84, 0xa85, 0xa86, 0xa94, 0xa95, 0xa96, 0xaa4, 0xaa5, 0xaa6),
+	[RZ_MTU3_CHAN_5] = MTU_8BIT_CH_5(0xab2, 0x895, 0xab4, 0xab6, 0xa84, 0xa85, 0xa86, 0xa94, 0xa95, 0xa96, 0xaa4, 0xaa5, 0xaa6),
 	[RZ_MTU3_CHAN_6] = MTU_8BIT_CH_3_4_6_7(0x808, 0x893, 0x82c, 0x800, 0x84c, 0x802, 0x804, 0x805, 0x838),
 	[RZ_MTU3_CHAN_7] = MTU_8BIT_CH_3_4_6_7(0x809, 0x894, 0x82d, 0x801, 0x84d, 0x803, 0x806, 0x807, 0x839),
 	[RZ_MTU3_CHAN_8] = MTU_8BIT_CH_8(0x404, 0x098, 0x400, 0x406, 0x401, 0x402, 0x403)
diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index d34d58ce46db..5f26ef733fd0 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -90,6 +90,7 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	struct resource *mem;
 	void __iomem *base;
 	struct gpio_chip *mmc_gpio_chip;
+	int ret;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem)
@@ -110,7 +111,10 @@ static int vexpress_sysreg_probe(struct platform_device *pdev)
 	bgpio_init(mmc_gpio_chip, &pdev->dev, 0x4, base + SYS_MCI,
 			NULL, NULL, NULL, NULL, 0);
 	mmc_gpio_chip->ngpio = 2;
-	devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+
+	ret = devm_gpiochip_add_data(&pdev->dev, mmc_gpio_chip, NULL);
+	if (ret)
+		return ret;
 
 	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
 			vexpress_sysreg_cells,
diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e567a36275af..9d8e51351ff8 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -323,11 +323,11 @@ static void fastrpc_free_map(struct kref *ref)
 
 			perm.vmid = QCOM_SCM_VMID_HLOS;
 			perm.perm = QCOM_SCM_PERM_RWX;
-			err = qcom_scm_assign_mem(map->phys, map->size,
+			err = qcom_scm_assign_mem(map->phys, map->len,
 				&src_perms, &perm, 1);
 			if (err) {
 				dev_err(map->fl->sctx->dev, "Failed to assign memory phys 0x%llx size 0x%llx err %d\n",
-						map->phys, map->size, err);
+						map->phys, map->len, err);
 				return;
 			}
 		}
@@ -363,26 +363,21 @@ static int fastrpc_map_get(struct fastrpc_map *map)
 
 
 static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
-			    struct fastrpc_map **ppmap, bool take_ref)
+			    struct fastrpc_map **ppmap)
 {
-	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
+	struct dma_buf *buf;
 	int ret = -ENOENT;
 
+	buf = dma_buf_get(fd);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+
 	spin_lock(&fl->lock);
 	list_for_each_entry(map, &fl->maps, node) {
-		if (map->fd != fd)
+		if (map->fd != fd || map->buf != buf)
 			continue;
 
-		if (take_ref) {
-			ret = fastrpc_map_get(map);
-			if (ret) {
-				dev_dbg(sess->dev, "%s: Failed to get map fd=%d ret=%d\n",
-					__func__, fd, ret);
-				break;
-			}
-		}
-
 		*ppmap = map;
 		ret = 0;
 		break;
@@ -752,16 +747,14 @@ static const struct dma_buf_ops fastrpc_dma_buf_ops = {
 	.release = fastrpc_release,
 };
 
-static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
+static int fastrpc_map_attach(struct fastrpc_user *fl, int fd,
 			      u64 len, u32 attr, struct fastrpc_map **ppmap)
 {
 	struct fastrpc_session_ctx *sess = fl->sctx;
 	struct fastrpc_map *map = NULL;
 	struct sg_table *table;
-	int err = 0;
-
-	if (!fastrpc_map_lookup(fl, fd, ppmap, true))
-		return 0;
+	struct scatterlist *sgl = NULL;
+	int err = 0, sgl_index = 0;
 
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (!map)
@@ -798,7 +791,15 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		map->phys = sg_dma_address(map->table->sgl);
 		map->phys += ((u64)fl->sctx->sid << 32);
 	}
-	map->size = len;
+	for_each_sg(map->table->sgl, sgl, map->table->nents,
+		sgl_index)
+		map->size += sg_dma_len(sgl);
+	if (len > map->size) {
+		dev_dbg(sess->dev, "Bad size passed len 0x%llx map size 0x%llx\n",
+				len, map->size);
+		err = -EINVAL;
+		goto map_err;
+	}
 	map->va = sg_virt(map->table->sgl);
 	map->len = len;
 
@@ -815,10 +816,10 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 		dst_perms[1].vmid = fl->cctx->vmperms[0].vmid;
 		dst_perms[1].perm = QCOM_SCM_PERM_RWX;
 		map->attr = attr;
-		err = qcom_scm_assign_mem(map->phys, (u64)map->size, &src_perms, dst_perms, 2);
+		err = qcom_scm_assign_mem(map->phys, (u64)map->len, &src_perms, dst_perms, 2);
 		if (err) {
 			dev_err(sess->dev, "Failed to assign memory with phys 0x%llx size 0x%llx err %d\n",
-					map->phys, map->size, err);
+					map->phys, map->len, err);
 			goto map_err;
 		}
 	}
@@ -839,6 +840,24 @@ static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
 	return err;
 }
 
+static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
+			      u64 len, u32 attr, struct fastrpc_map **ppmap)
+{
+	struct fastrpc_session_ctx *sess = fl->sctx;
+	int err = 0;
+
+	if (!fastrpc_map_lookup(fl, fd, ppmap)) {
+		if (!fastrpc_map_get(*ppmap))
+			return 0;
+		dev_dbg(sess->dev, "%s: Failed to get map fd=%d\n",
+			__func__, fd);
+	}
+
+	err = fastrpc_map_attach(fl, fd, len, attr, ppmap);
+
+	return err;
+}
+
 /*
  * Fastrpc payload buffer with metadata looks like:
  *
@@ -911,8 +930,12 @@ static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
 		    ctx->args[i].length == 0)
 			continue;
 
-		err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
-			 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+		if (i < ctx->nbufs)
+			err = fastrpc_map_create(ctx->fl, ctx->args[i].fd,
+				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
+		else
+			err = fastrpc_map_attach(ctx->fl, ctx->args[i].fd,
+				 ctx->args[i].length, ctx->args[i].attr, &ctx->maps[i]);
 		if (err) {
 			dev_err(dev, "Error Creating map %d\n", err);
 			return -EINVAL;
@@ -1071,6 +1094,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	struct fastrpc_phy_page *pages;
 	u64 *fdlist;
 	int i, inbufs, outbufs, handles;
+	int ret = 0;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
 	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
@@ -1086,23 +1110,26 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			u64 len = rpra[i].buf.len;
 
 			if (!kernel) {
-				if (copy_to_user((void __user *)dst, src, len))
-					return -EFAULT;
+				if (copy_to_user((void __user *)dst, src, len)) {
+					ret = -EFAULT;
+					goto cleanup_fdlist;
+				}
 			} else {
 				memcpy(dst, src, len);
 			}
 		}
 	}
 
+cleanup_fdlist:
 	/* Clean up fdlist which is updated by DSP */
 	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
 		if (!fdlist[i])
 			break;
-		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
+		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap))
 			fastrpc_map_put(mmap);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
@@ -2044,7 +2071,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	args[0].length = sizeof(req_msg);
 
 	pages.addr = map->phys;
-	pages.size = map->size;
+	pages.size = map->len;
 
 	args[1].ptr = (u64) (uintptr_t) &pages;
 	args[1].length = sizeof(pages);
@@ -2059,7 +2086,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	err = fastrpc_internal_invoke(fl, true, FASTRPC_INIT_HANDLE, sc, &args[0]);
 	if (err) {
 		dev_err(dev, "mem mmap error, fd %d, vaddr %llx, size %lld\n",
-			req.fd, req.vaddrin, map->size);
+			req.fd, req.vaddrin, map->len);
 		goto err_invoke;
 	}
 
@@ -2072,7 +2099,7 @@ static int fastrpc_req_mem_map(struct fastrpc_user *fl, char __user *argp)
 	if (copy_to_user((void __user *)argp, &req, sizeof(req))) {
 		/* unmap the memory and release the buffer */
 		req_unmap.vaddr = (uintptr_t) rsp_msg.vaddr;
-		req_unmap.length = map->size;
+		req_unmap.length = map->len;
 		fastrpc_req_mem_unmap_impl(fl, &req_unmap);
 		return -EFAULT;
 	}
diff --git a/drivers/misc/genwqe/card_ddcb.c b/drivers/misc/genwqe/card_ddcb.c
index 500b1feaf1f6..fd7d5cd50d39 100644
--- a/drivers/misc/genwqe/card_ddcb.c
+++ b/drivers/misc/genwqe/card_ddcb.c
@@ -923,7 +923,7 @@ int __genwqe_execute_raw_ddcb(struct genwqe_dev *cd,
 	}
 	if (cmd->asv_length > DDCB_ASV_LENGTH) {
 		dev_err(&pci_dev->dev, "[%s] err: wrong asv_length of %d\n",
-			__func__, cmd->asiv_length);
+			__func__, cmd->asv_length);
 		return -EINVAL;
 	}
 	rc = __genwqe_enqueue_ddcb(cd, req, f_flags);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 1d08009f2bd8..08b8276e1da9 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2876,15 +2876,15 @@ static int mmc_route_rpmb_frames(struct device *dev, u8 *req,
 		return -ENOMEM;
 
 	if (write) {
-		struct rpmb_frame *frm = (struct rpmb_frame *)resp;
+		struct rpmb_frame *resp_frm = (struct rpmb_frame *)resp;
 
 		/* Send write request frame(s) */
 		set_idata(idata[0], MMC_WRITE_MULTIPLE_BLOCK,
 			  1 | MMC_CMD23_ARG_REL_WR, req, req_len);
 
 		/* Send result request frame */
-		memset(frm, 0, sizeof(*frm));
-		frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
+		memset(resp_frm, 0, sizeof(*resp_frm));
+		resp_frm->req_resp = cpu_to_be16(RPMB_RESULT_READ);
 		set_idata(idata[1], MMC_WRITE_MULTIPLE_BLOCK, 1, resp,
 			  resp_len);
 
diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
index 5b02119d8ba2..543a0be9dc64 100644
--- a/drivers/mtd/nand/raw/atmel/nand-controller.c
+++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
@@ -1858,7 +1858,7 @@ atmel_nand_controller_legacy_add_nands(struct atmel_nand_controller *nc)
 
 static int atmel_nand_controller_add_nands(struct atmel_nand_controller *nc)
 {
-	struct device_node *np, *nand_np;
+	struct device_node *np;
 	struct device *dev = nc->dev;
 	int ret, reg_cells;
 	u32 val;
@@ -1885,7 +1885,7 @@ static int atmel_nand_controller_add_nands(struct atmel_nand_controller *nc)
 
 	reg_cells += val;
 
-	for_each_child_of_node(np, nand_np) {
+	for_each_child_of_node_scoped(np, nand_np) {
 		struct atmel_nand *nand;
 
 		nand = atmel_nand_create(nc, nand_np, reg_cells);
diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 60fb35ec4b15..0b2e257b591f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -869,7 +869,10 @@ static u32 ena_get_rxfh_indir_size(struct net_device *netdev)
 
 static u32 ena_get_rxfh_key_size(struct net_device *netdev)
 {
-	return ENA_HASH_KEY_SIZE;
+	struct ena_adapter *adapter = netdev_priv(netdev);
+	struct ena_rss *rss = &adapter->ena_dev->rss;
+
+	return rss->hash_key ? ENA_HASH_KEY_SIZE : 0;
 }
 
 static int ena_indirection_table_set(struct ena_adapter *adapter,
diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 2c1b551e1442..92856cf387c7 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -953,15 +953,18 @@ receive_packet (struct net_device *dev)
 		} else {
 			struct sk_buff *skb;
 
+			skb = NULL;
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
+			if (pkt_len <= copy_thresh)
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+			if (!skb) {
 				dma_unmap_single(&np->pdev->dev,
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
 				skb_put (skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			} else {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4086a6ef352e..087a3077d548 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3216,18 +3216,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx_queue *rxq, int budget)
 		/* get the Rx desc from Rx queue based on 'next_to_clean' */
 		rx_desc = &rxq->rx[ntc].flex_adv_nic_3_wb;
 
-		/* This memory barrier is needed to keep us from reading
-		 * any other fields out of the rx_desc
-		 */
-		dma_rmb();
-
 		/* if the descriptor isn't done, no work yet to do */
 		gen_id = le16_get_bits(rx_desc->pktlen_gen_bufq_id,
 				       VIRTCHNL2_RX_FLEX_DESC_ADV_GEN_M);
-
 		if (idpf_queue_has(GEN_CHK, rxq) != gen_id)
 			break;
 
+		dma_rmb();
+
 		rxdid = FIELD_GET(VIRTCHNL2_RX_FLEX_DESC_ADV_RXDID_M,
 				  rx_desc->rxdid_ucast);
 		if (rxdid != VIRTCHNL2_RXDID_2_FLEX_SPLITQ) {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index f27a8cf3816d..d1f374da0098 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -727,9 +727,9 @@ int idpf_recv_mb_msg(struct idpf_adapter *adapter)
 		/* If post failed clear the only buffer we supplied */
 		if (post_err) {
 			if (dma_mem)
-				dmam_free_coherent(&adapter->pdev->dev,
-						   dma_mem->size, dma_mem->va,
-						   dma_mem->pa);
+				dma_free_coherent(&adapter->pdev->dev,
+						  dma_mem->size, dma_mem->va,
+						  dma_mem->pa);
 			break;
 		}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index 5bb4940da59d..b51c00627759 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -289,6 +289,10 @@ static void poll_timeout(struct mlx5_cmd_work_ent *ent)
 			return;
 		}
 		cond_resched();
+		if (mlx5_cmd_is_down(dev)) {
+			ent->ret = -ENXIO;
+			return;
+		}
 	} while (time_before(jiffies, poll_end));
 
 	ent->ret = -ETIMEDOUT;
@@ -1066,7 +1070,7 @@ static void cmd_work_handler(struct work_struct *work)
 		poll_timeout(ent);
 		/* make sure we read the descriptor after ownership is SW */
 		rmb();
-		mlx5_cmd_comp_handler(dev, 1ULL << ent->idx, (ent->ret == -ETIMEDOUT));
+		mlx5_cmd_comp_handler(dev, 1ULL << ent->idx, !!ent->ret);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
index 66d276a1be83..f4a19ffbb641 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.h
@@ -66,23 +66,11 @@ struct mlx5e_port_buffer {
 	struct mlx5e_bufferx_reg  buffer[MLX5E_MAX_NETWORK_BUFFER];
 };
 
-#ifdef CONFIG_MLX5_CORE_EN_DCB
 int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 				    u32 change, unsigned int mtu,
 				    struct ieee_pfc *pfc,
 				    u32 *buffer_size,
 				    u8 *prio2buffer);
-#else
-static inline int
-mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
-				u32 change, unsigned int mtu,
-				void *pfc,
-				u32 *buffer_size,
-				u8 *prio2buffer)
-{
-	return 0;
-}
-#endif
 
 int mlx5e_port_query_buffer(struct mlx5e_priv *priv,
 			    struct mlx5e_port_buffer *port_buffer);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index de2327ffb0f7..4a2f58a9d706 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -47,7 +47,6 @@
 #include "en.h"
 #include "en/dim.h"
 #include "en/txrx.h"
-#include "en/port_buffer.h"
 #include "en_tc.h"
 #include "en_rep.h"
 #include "en_accel/ipsec.h"
@@ -2918,11 +2917,9 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 	struct mlx5e_params *params = &priv->channels.params;
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	u16 mtu, prev_mtu;
+	u16 mtu;
 	int err;
 
-	mlx5e_query_mtu(mdev, params, &prev_mtu);
-
 	err = mlx5e_set_mtu(mdev, params, params->sw_mtu);
 	if (err)
 		return err;
@@ -2932,18 +2929,6 @@ int mlx5e_set_dev_port_mtu(struct mlx5e_priv *priv)
 		netdev_warn(netdev, "%s: VPort MTU %d is different than netdev mtu %d\n",
 			    __func__, mtu, params->sw_mtu);
 
-	if (mtu != prev_mtu && MLX5_BUFFER_SUPPORTED(mdev)) {
-		err = mlx5e_port_manual_buffer_config(priv, 0, mtu,
-						      NULL, NULL, NULL);
-		if (err) {
-			netdev_warn(netdev, "%s: Failed to set Xon/Xoff values with MTU %d (err %d), setting back to previous MTU %d\n",
-				    __func__, mtu, err, prev_mtu);
-
-			mlx5e_set_mtu(mdev, params, prev_mtu);
-			return err;
-		}
-	}
-
 	params->sw_mtu = mtu;
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 516df7f1997e..35d2fe08c0fb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -27,6 +27,7 @@ struct mlx5_fw_reset {
 	struct work_struct reset_reload_work;
 	struct work_struct reset_now_work;
 	struct work_struct reset_abort_work;
+	struct delayed_work reset_timeout_work;
 	unsigned long reset_flags;
 	u8 reset_method;
 	struct timer_list timer;
@@ -258,6 +259,8 @@ static int mlx5_sync_reset_clear_reset_requested(struct mlx5_core_dev *dev, bool
 		return -EALREADY;
 	}
 
+	if (current_work() != &fw_reset->reset_timeout_work.work)
+		cancel_delayed_work(&fw_reset->reset_timeout_work);
 	mlx5_stop_sync_reset_poll(dev);
 	if (poll_health)
 		mlx5_start_health_poll(dev);
@@ -328,6 +331,11 @@ static int mlx5_sync_reset_set_reset_requested(struct mlx5_core_dev *dev)
 	}
 	mlx5_stop_health_poll(dev, true);
 	mlx5_start_sync_reset_poll(dev);
+
+	if (!test_bit(MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS,
+		      &fw_reset->reset_flags))
+		schedule_delayed_work(&fw_reset->reset_timeout_work,
+			msecs_to_jiffies(mlx5_tout_ms(dev, PCI_SYNC_UPDATE)));
 	return 0;
 }
 
@@ -728,6 +736,19 @@ static void mlx5_sync_reset_events_handle(struct mlx5_fw_reset *fw_reset, struct
 	}
 }
 
+static void mlx5_sync_reset_timeout_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work,
+						  work);
+	struct mlx5_fw_reset *fw_reset =
+		container_of(dwork, struct mlx5_fw_reset, reset_timeout_work);
+	struct mlx5_core_dev *dev = fw_reset->dev;
+
+	if (mlx5_sync_reset_clear_reset_requested(dev, true))
+		return;
+	mlx5_core_warn(dev, "PCI Sync FW Update Reset Timeout.\n");
+}
+
 static int fw_reset_event_notifier(struct notifier_block *nb, unsigned long action, void *data)
 {
 	struct mlx5_fw_reset *fw_reset = mlx5_nb_cof(nb, struct mlx5_fw_reset, nb);
@@ -811,6 +832,7 @@ void mlx5_drain_fw_reset(struct mlx5_core_dev *dev)
 	cancel_work_sync(&fw_reset->reset_reload_work);
 	cancel_work_sync(&fw_reset->reset_now_work);
 	cancel_work_sync(&fw_reset->reset_abort_work);
+	cancel_delayed_work(&fw_reset->reset_timeout_work);
 }
 
 static const struct devlink_param mlx5_fw_reset_devlink_params[] = {
@@ -854,6 +876,8 @@ int mlx5_fw_reset_init(struct mlx5_core_dev *dev)
 	INIT_WORK(&fw_reset->reset_reload_work, mlx5_sync_reset_reload_work);
 	INIT_WORK(&fw_reset->reset_now_work, mlx5_sync_reset_now_event);
 	INIT_WORK(&fw_reset->reset_abort_work, mlx5_sync_reset_abort_event);
+	INIT_DELAYED_WORK(&fw_reset->reset_timeout_work,
+			  mlx5_sync_reset_timeout_work);
 
 	init_completion(&fw_reset->done);
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
index 9bc9bd83c232..cd68c4b2c0bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
@@ -489,9 +489,12 @@ static int reclaim_pages_cmd(struct mlx5_core_dev *dev,
 	u32 func_id;
 	u32 npages;
 	u32 i = 0;
+	int err;
 
-	if (!mlx5_cmd_is_down(dev))
-		return mlx5_cmd_do(dev, in, in_size, out, out_size);
+	err = mlx5_cmd_do(dev, in, in_size, out, out_size);
+	/* If FW is gone (-ENXIO), proceed to forceful reclaim */
+	if (err != -ENXIO)
+		return err;
 
 	/* No hard feelings, we want our pages back! */
 	npages = MLX5_GET(manage_pages_in, in, input_num_entries);
diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
index fbca8d0efd85..37a46596268a 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_ethtool.c
@@ -1789,7 +1789,7 @@ static u32 nfp_net_get_rxfh_key_size(struct net_device *netdev)
 	struct nfp_net *nn = netdev_priv(netdev);
 
 	if (!(nn->cap & NFP_NET_CFG_CTRL_RSS_ANY))
-		return -EOPNOTSUPP;
+		return 0;
 
 	return nfp_net_rss_key_sz(nn);
 }
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index 792ddda1ad49..85bd5d845409 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -625,6 +625,21 @@ static void ax88772_suspend(struct usbnet *dev)
 		   asix_read_medium_status(dev, 1));
 }
 
+/* Notes on PM callbacks and locking context:
+ *
+ * - asix_suspend()/asix_resume() are invoked for both runtime PM and
+ *   system-wide suspend/resume. For struct usb_driver the ->resume()
+ *   callback does not receive pm_message_t, so the resume type cannot
+ *   be distinguished here.
+ *
+ * - The MAC driver must hold RTNL when calling phylink interfaces such as
+ *   phylink_suspend()/resume(). Those calls will also perform MDIO I/O.
+ *
+ * - Taking RTNL and doing MDIO from a runtime-PM resume callback (while
+ *   the USB PM lock is held) is fragile. Since autosuspend brings no
+ *   measurable power saving here, we block it by holding a PM usage
+ *   reference in ax88772_bind().
+ */
 static int asix_suspend(struct usb_interface *intf, pm_message_t message)
 {
 	struct usbnet *dev = usb_get_intfdata(intf);
@@ -919,6 +934,13 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	if (ret)
 		goto initphy_err;
 
+	/* Keep this interface runtime-PM active by taking a usage ref.
+	 * Prevents runtime suspend while bound and avoids resume paths
+	 * that could deadlock (autoresume under RTNL while USB PM lock
+	 * is held, phylink/MDIO wants RTNL).
+	 */
+	pm_runtime_get_noresume(&intf->dev);
+
 	return 0;
 
 initphy_err:
@@ -948,6 +970,8 @@ static void ax88772_unbind(struct usbnet *dev, struct usb_interface *intf)
 	phylink_destroy(priv->phylink);
 	ax88772_mdio_unregister(priv);
 	asix_rx_fixup_common_free(dev->driver_priv);
+	/* Drop the PM usage ref taken in bind() */
+	pm_runtime_put(&intf->dev);
 }
 
 static void ax88178_unbind(struct usbnet *dev, struct usb_interface *intf)
@@ -1600,6 +1624,11 @@ static struct usb_driver asix_driver = {
 	.resume =	asix_resume,
 	.reset_resume =	asix_resume,
 	.disconnect =	usbnet_disconnect,
+	/* usbnet enables autosuspend by default (supports_autosuspend=1).
+	 * We keep runtime-PM active for AX88772* by taking a PM usage
+	 * reference in ax88772_bind() (pm_runtime_get_noresume()) and
+	 * dropping it in unbind(), which effectively blocks autosuspend.
+	 */
 	.supports_autosuspend = 1,
 	.disable_hub_initiated_lpm = 1,
 };
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index ddff6f19ff98..92add3daadbb 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -664,7 +664,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	u16 rx_creg = 0x9e;
 
-	netif_stop_queue(netdev);
 	if (netdev->flags & IFF_PROMISC) {
 		rx_creg |= 0x0001;
 		dev_info(&netdev->dev, "%s: promiscuous mode\n", netdev->name);
@@ -678,7 +677,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 		rx_creg &= 0x00fc;
 	}
 	async_set_registers(dev, RCR, sizeof(rx_creg), rx_creg);
-	netif_wake_queue(netdev);
 }
 
 static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 09066e6aca40..fdab67a56e43 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1764,33 +1764,32 @@ void ath10k_wmi_put_wmi_channel(struct ath10k *ar, struct wmi_channel *ch,
 
 int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
 {
+	unsigned long timeout = jiffies + WMI_SERVICE_READY_TIMEOUT_HZ;
 	unsigned long time_left, i;
 
-	time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-						WMI_SERVICE_READY_TIMEOUT_HZ);
-	if (!time_left) {
-		/* Sometimes the PCI HIF doesn't receive interrupt
-		 * for the service ready message even if the buffer
-		 * was completed. PCIe sniffer shows that it's
-		 * because the corresponding CE ring doesn't fires
-		 * it. Workaround here by polling CE rings once.
-		 */
-		ath10k_warn(ar, "failed to receive service ready completion, polling..\n");
-
+	/* Sometimes the PCI HIF doesn't receive interrupt
+	 * for the service ready message even if the buffer
+	 * was completed. PCIe sniffer shows that it's
+	 * because the corresponding CE ring doesn't fires
+	 * it. Workaround here by polling CE rings. Since
+	 * the message could arrive at any time, continue
+	 * polling until timeout.
+	 */
+	do {
 		for (i = 0; i < CE_COUNT; i++)
 			ath10k_hif_send_complete_check(ar, i, 1);
 
+		/* The 100 ms granularity is a tradeoff considering scheduler
+		 * overhead and response latency
+		 */
 		time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
-							WMI_SERVICE_READY_TIMEOUT_HZ);
-		if (!time_left) {
-			ath10k_warn(ar, "polling timed out\n");
-			return -ETIMEDOUT;
-		}
-
-		ath10k_warn(ar, "service ready completion received, continuing normally\n");
-	}
+							msecs_to_jiffies(100));
+		if (time_left)
+			return 0;
+	} while (time_before(jiffies, timeout));
 
-	return 0;
+	ath10k_warn(ar, "failed to receive service ready completion\n");
+	return -ETIMEDOUT;
 }
 
 int ath10k_wmi_wait_for_unified_ready(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index b66d23d6b2bd..bd21e8fe9c90 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -388,7 +388,7 @@ static void ath12k_ce_recv_process_cb(struct ath12k_ce_pipe *pipe)
 	}
 
 	while ((skb = __skb_dequeue(&list))) {
-		ath12k_dbg(ab, ATH12K_DBG_AHB, "rx ce pipe %d len %d\n",
+		ath12k_dbg(ab, ATH12K_DBG_CE, "rx ce pipe %d len %d\n",
 			   pipe->pipe_num, skb->len);
 		pipe->recv_cb(ab, skb);
 	}
diff --git a/drivers/net/wireless/ath/ath12k/debug.h b/drivers/net/wireless/ath/ath12k/debug.h
index f7005917362c..ea711e02ca03 100644
--- a/drivers/net/wireless/ath/ath12k/debug.h
+++ b/drivers/net/wireless/ath/ath12k/debug.h
@@ -26,6 +26,7 @@ enum ath12k_debug_mask {
 	ATH12K_DBG_DP_TX	= 0x00002000,
 	ATH12K_DBG_DP_RX	= 0x00004000,
 	ATH12K_DBG_WOW		= 0x00008000,
+	ATH12K_DBG_CE		= 0x00010000,
 	ATH12K_DBG_ANY		= 0xffffffff,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 81787501d4a4..11704163876b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -12,7 +12,6 @@
 #include "fw/api/phy.h"
 #include "fw/api/config.h"
 #include "fw/api/nvm-reg.h"
-#include "fw/img.h"
 #include "iwl-trans.h"
 
 #define BIOS_SAR_MAX_PROFILE_NUM	4
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 59bea82eab29..8801b93eacd4 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -684,10 +684,9 @@ static void mwifiex_reg_notifier(struct wiphy *wiphy,
 		return;
 	}
 
-	/* Don't send world or same regdom info to firmware */
-	if (strncmp(request->alpha2, "00", 2) &&
-	    strncmp(request->alpha2, adapter->country_code,
-		    sizeof(request->alpha2))) {
+	/* Don't send same regdom info to firmware */
+	if (strncmp(request->alpha2, adapter->country_code,
+		    sizeof(request->alpha2)) != 0) {
 		memcpy(adapter->country_code, request->alpha2,
 		       sizeof(request->alpha2));
 		mwifiex_send_domain_info_cmd_fw(wiphy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index ec02148a7f1f..2ee8a6e1e310 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -48,7 +48,7 @@ mt76_wmac_probe(struct platform_device *pdev)
 
 	return 0;
 error:
-	ieee80211_free_hw(mt76_hw(dev));
+	mt76_free_device(mdev);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 509fb43d8a68..2908e8113e48 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -50,9 +50,9 @@ enum mt7915_eeprom_field {
 #define MT_EE_CAL_GROUP_SIZE_7975		(54 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_GROUP_SIZE_7976		(94 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_GROUP_SIZE_7916_6G		(94 * MT_EE_CAL_UNIT + 16)
+#define MT_EE_CAL_GROUP_SIZE_7981		(144 * MT_EE_CAL_UNIT + 16)
 #define MT_EE_CAL_DPD_SIZE_V1			(54 * MT_EE_CAL_UNIT)
 #define MT_EE_CAL_DPD_SIZE_V2			(300 * MT_EE_CAL_UNIT)
-#define MT_EE_CAL_DPD_SIZE_V2_7981		(102 * MT_EE_CAL_UNIT)	/* no 6g dpd data */
 
 #define MT_EE_WIFI_CONF0_TX_PATH		GENMASK(2, 0)
 #define MT_EE_WIFI_CONF0_BAND_SEL		GENMASK(7, 6)
@@ -179,6 +179,8 @@ mt7915_get_cal_group_size(struct mt7915_dev *dev)
 		val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
 		return (val == MT_EE_V2_BAND_SEL_6GHZ) ? MT_EE_CAL_GROUP_SIZE_7916_6G :
 							 MT_EE_CAL_GROUP_SIZE_7916;
+	} else if (is_mt7981(&dev->mt76)) {
+		return MT_EE_CAL_GROUP_SIZE_7981;
 	} else if (mt7915_check_adie(dev, false)) {
 		return MT_EE_CAL_GROUP_SIZE_7976;
 	} else {
@@ -191,8 +193,6 @@ mt7915_get_cal_dpd_size(struct mt7915_dev *dev)
 {
 	if (is_mt7915(&dev->mt76))
 		return MT_EE_CAL_DPD_SIZE_V1;
-	else if (is_mt7981(&dev->mt76))
-		return MT_EE_CAL_DPD_SIZE_V2_7981;
 	else
 		return MT_EE_CAL_DPD_SIZE_V2;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 3398c25cb03c..7b481aea76b6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3004,30 +3004,15 @@ static int mt7915_dpd_freq_idx(struct mt7915_dev *dev, u16 freq, u8 bw)
 		/* 5G BW160 */
 		5250, 5570, 5815
 	};
-	static const u16 freq_list_v2_7981[] = {
-		/* 5G BW20 */
-		5180, 5200, 5220, 5240,
-		5260, 5280, 5300, 5320,
-		5500, 5520, 5540, 5560,
-		5580, 5600, 5620, 5640,
-		5660, 5680, 5700, 5720,
-		5745, 5765, 5785, 5805,
-		5825, 5845, 5865, 5885,
-		/* 5G BW160 */
-		5250, 5570, 5815
-	};
-	const u16 *freq_list = freq_list_v1;
-	int n_freqs = ARRAY_SIZE(freq_list_v1);
-	int idx;
+	const u16 *freq_list;
+	int idx, n_freqs;
 
 	if (!is_mt7915(&dev->mt76)) {
-		if (is_mt7981(&dev->mt76)) {
-			freq_list = freq_list_v2_7981;
-			n_freqs = ARRAY_SIZE(freq_list_v2_7981);
-		} else {
-			freq_list = freq_list_v2;
-			n_freqs = ARRAY_SIZE(freq_list_v2);
-		}
+		freq_list = freq_list_v2;
+		n_freqs = ARRAY_SIZE(freq_list_v2);
+	} else {
+		freq_list = freq_list_v1;
+		n_freqs = ARRAY_SIZE(freq_list_v1);
 	}
 
 	if (freq < 4000) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index c55038554114..91b7d35bdb43 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -679,6 +679,7 @@ void mt7996_wfsys_reset(struct mt7996_dev *dev)
 static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	u32 val = FIELD_PREP(WED_RRO_ADDR_SIGNATURE_MASK, 0xff);
 	struct mtk_wed_device *wed = &dev->mt76.mmio.wed;
 	u32 reg = MT_RRO_ADDR_ELEM_SEG_ADDR0;
 	struct mt7996_wed_rro_addr *addr;
@@ -718,7 +719,7 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 
 		addr = dev->wed_rro.addr_elem[i].ptr;
 		for (j = 0; j < MT7996_RRO_WINDOW_MAX_SIZE; j++) {
-			addr->signature = 0xff;
+			addr->data = cpu_to_le32(val);
 			addr++;
 		}
 
@@ -736,7 +737,7 @@ static int mt7996_wed_rro_init(struct mt7996_dev *dev)
 	dev->wed_rro.session.ptr = ptr;
 	addr = dev->wed_rro.session.ptr;
 	for (i = 0; i < MT7996_RRO_WINDOW_MAX_LEN; i++) {
-		addr->signature = 0xff;
+		addr->data = cpu_to_le32(val);
 		addr++;
 	}
 
@@ -836,6 +837,7 @@ static void mt7996_wed_rro_free(struct mt7996_dev *dev)
 static void mt7996_wed_rro_work(struct work_struct *work)
 {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
+	u32 val = FIELD_PREP(WED_RRO_ADDR_SIGNATURE_MASK, 0xff);
 	struct mt7996_dev *dev;
 	LIST_HEAD(list);
 
@@ -872,7 +874,7 @@ static void mt7996_wed_rro_work(struct work_struct *work)
 				MT7996_RRO_WINDOW_MAX_LEN;
 reset:
 			elem = ptr + elem_id * sizeof(*elem);
-			elem->signature = 0xff;
+			elem->data |= cpu_to_le32(val);
 		}
 		mt7996_mcu_wed_rro_reset_sessions(dev, e->id);
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 425fd030bee0..29e7289c3a16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -194,13 +194,12 @@ struct mt7996_hif {
 	int irq;
 };
 
+#define WED_RRO_ADDR_SIGNATURE_MASK	GENMASK(31, 24)
+#define WED_RRO_ADDR_COUNT_MASK		GENMASK(14, 4)
+#define WED_RRO_ADDR_HEAD_HIGH_MASK	GENMASK(3, 0)
 struct mt7996_wed_rro_addr {
-	u32 head_low;
-	u32 head_high : 4;
-	u32 count: 11;
-	u32 oor: 1;
-	u32 rsv : 8;
-	u32 signature : 8;
+	__le32 head_low;
+	__le32 data;
 };
 
 struct mt7996_wed_rro_session_id {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 04056181368a..dbd05612f2e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -132,6 +132,7 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 	mdev = &dev->mt76;
 	mt7996_wfsys_reset(dev);
 	hif2 = mt7996_pci_init_hif2(pdev);
+	dev->hif2 = hif2;
 
 	ret = mt7996_mmio_wed_init(dev, pdev, false, &irq);
 	if (ret < 0)
@@ -156,7 +157,6 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 
 	if (hif2) {
 		hif2_dev = container_of(hif2->dev, struct pci_dev, dev);
-		dev->hif2 = hif2;
 
 		ret = mt7996_mmio_wed_init(dev, hif2_dev, true, &hif2_irq);
 		if (ret < 0)
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index c0f0e3d71f5f..2a303a758e27 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -207,7 +207,6 @@ static void rtw89_ser_hdl_work(struct work_struct *work)
 
 static int ser_send_msg(struct rtw89_ser *ser, u8 event)
 {
-	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
 	struct ser_msg *msg = NULL;
 
 	if (test_bit(RTW89_SER_DRV_STOP_RUN, ser->flags))
@@ -223,7 +222,7 @@ static int ser_send_msg(struct rtw89_ser *ser, u8 event)
 	list_add(&msg->list, &ser->msg_q);
 	spin_unlock_irq(&ser->msg_q_lock);
 
-	ieee80211_queue_work(rtwdev->hw, &ser->ser_hdl_work);
+	schedule_work(&ser->ser_hdl_work);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ef8c5961e10c..0ade23610ae6 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -54,6 +54,8 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 	int				ls_error;
 	struct list_head		lsreq_list; /* tgtport->ls_req_list */
 	bool				req_queued;
+
+	struct work_struct		put_work;
 };
 
 
@@ -111,8 +113,6 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
-
-	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -235,12 +235,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
-static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+static void nvmet_fc_put_lsop_work(struct work_struct *work)
 {
-	struct nvmet_fc_tgtport *tgtport =
-		container_of(work, struct nvmet_fc_tgtport, put_work);
+	struct nvmet_fc_ls_req_op *lsop =
+		container_of(work, struct nvmet_fc_ls_req_op, put_work);
 
-	nvmet_fc_tgtport_put(tgtport);
+	nvmet_fc_tgtport_put(lsop->tgtport);
+	kfree(lsop);
 }
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
@@ -367,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  DMA_BIDIRECTIONAL);
 
 out_putwork:
-	queue_work(nvmet_wq, &tgtport->put_work);
+	queue_work(nvmet_wq, &lsop->put_work);
 }
 
 static int
@@ -388,6 +389,7 @@ __nvmet_fc_send_ls_req(struct nvmet_fc_tgtport *tgtport,
 	lsreq->done = done;
 	lsop->req_queued = false;
 	INIT_LIST_HEAD(&lsop->lsreq_list);
+	INIT_WORK(&lsop->put_work, nvmet_fc_put_lsop_work);
 
 	lsreq->rqstdma = fc_dma_map_single(tgtport->dev, lsreq->rqstaddr,
 				  lsreq->rqstlen + lsreq->rsplen,
@@ -447,8 +449,6 @@ nvmet_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
 	__nvmet_fc_finish_ls_req(lsop);
 
 	/* fc-nvme target doesn't care about success or failure of cmd */
-
-	kfree(lsop);
 }
 
 /*
@@ -1412,7 +1412,6 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
-	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index bae829ac759e..eb772c18d44e 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -531,7 +531,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 
 	ret = j721e_pcie_ctrl_init(pcie);
 	if (ret < 0) {
-		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
+		dev_err_probe(dev, ret, "j721e_pcie_ctrl_init failed\n");
 		goto err_get_sync;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 5d77a0164860..14f69efa243c 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -182,8 +182,17 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 		return ret;
 	}
 
-	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
+	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
 		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+		/*
+		 * R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr.
+		 * 21, 2025 page 585 Figure 9.3.2 Software Reset flow (B)
+		 * indicates that for peripherals in HSC domain, after
+		 * reset has been asserted by writing a matching reset bit
+		 * into register SRCR, it is mandatory to wait 1ms.
+		 */
+		fsleep(1000);
+	}
 
 	val = readl(rcar->base + PCIEMSR0);
 	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
@@ -204,6 +213,19 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
 	if (ret)
 		goto err_unprepare;
 
+	/*
+	 * Assure the reset is latched and the core is ready for DBI access.
+	 * On R-Car V4H, the PCIe reset is asynchronous and does not take
+	 * effect immediately, but needs a short time to complete. In case
+	 * DBI access happens in that short time, that access generates an
+	 * SError. To make sure that condition can never happen, read back the
+	 * state of the reset, which should turn the asynchronous reset into
+	 * synchronous one, and wait a little over 1ms to add additional
+	 * safety margin.
+	 */
+	reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
+	fsleep(1000);
+
 	if (rcar->drvdata->additional_common_init)
 		rcar->drvdata->additional_common_init(rcar);
 
@@ -711,7 +733,7 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, bool enable
 	val &= ~APP_HOLD_PHY_RST;
 	writel(val, rcar->base + PCIERSTCTRL1);
 
-	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, !(val & BIT(18)), 100, 10000);
+	ret = readl_poll_timeout(rcar->phy_base + 0x0f8, val, val & BIT(18), 100, 10000);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index ced3b7e7bdad..815599ef72db 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1721,9 +1721,9 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 				ret);
 	}
 
-	ret = tegra_pcie_bpmp_set_pll_state(pcie, false);
+	ret = tegra_pcie_bpmp_set_ctrl_state(pcie, false);
 	if (ret)
-		dev_err(pcie->dev, "Failed to turn off UPHY: %d\n", ret);
+		dev_err(pcie->dev, "Failed to disable controller: %d\n", ret);
 
 	pcie->ep_state = EP_STATE_DISABLED;
 	dev_dbg(pcie->dev, "Uninitialization of endpoint is completed\n");
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index d7517c3976e7..4f70b7f2ded9 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1343,7 +1343,7 @@ static int tegra_pcie_port_get_phys(struct tegra_pcie_port *port)
 	unsigned int i;
 	int err;
 
-	port->phys = devm_kcalloc(dev, sizeof(phy), port->lanes, GFP_KERNEL);
+	port->phys = devm_kcalloc(dev, port->lanes, sizeof(phy), GFP_KERNEL);
 	if (!port->phys)
 		return -ENOMEM;
 
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 99c58ee09fbb..0cd8a75e2258 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -122,6 +122,8 @@ phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
 
 bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 {
+	bool ret = false;
+
 	if (ACPI_HANDLE(&host_bridge->dev)) {
 		union acpi_object *obj;
 
@@ -135,11 +137,11 @@ bool pci_acpi_preserve_config(struct pci_host_bridge *host_bridge)
 					      1, DSM_PCI_PRESERVE_BOOT_CONFIG,
 					      NULL, ACPI_TYPE_INTEGER);
 		if (obj && obj->integer.value == 0)
-			return true;
+			ret = true;
 		ACPI_FREE(obj);
 	}
 
-	return false;
+	return ret;
 }
 
 /* _HPX PCI Setting Record (Type 0); same as _HPP */
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index 3569050f9cf3..abd23430dc03 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -96,7 +96,8 @@ struct arm_spe_pmu {
 #define to_spe_pmu(p) (container_of(p, struct arm_spe_pmu, pmu))
 
 /* Convert a free-running index from perf into an SPE buffer offset */
-#define PERF_IDX2OFF(idx, buf)	((idx) % ((buf)->nr_pages << PAGE_SHIFT))
+#define PERF_IDX2OFF(idx, buf) \
+	((idx) % ((unsigned long)(buf)->nr_pages << PAGE_SHIFT))
 
 /* Keep track of our dynamic hotplug state */
 static enum cpuhp_state arm_spe_pmu_online;
diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 1ef6d9630f7e..fbaeb7ca600d 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -122,6 +122,8 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg pipe_xpcs_phy_ready;
 	struct combphy_reg pipe_pcie1l0_sel;
 	struct combphy_reg pipe_pcie1l1_sel;
+	struct combphy_reg u3otg0_port_en;
+	struct combphy_reg u3otg1_port_en;
 };
 
 struct rockchip_combphy_cfg {
@@ -431,6 +433,14 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
 		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		switch (priv->id) {
+		case 0:
+			rockchip_combphy_param_write(priv->pipe_grf, &cfg->u3otg0_port_en, true);
+			break;
+		case 1:
+			rockchip_combphy_param_write(priv->pipe_grf, &cfg->u3otg1_port_en, true);
+			break;
+		}
 		break;
 
 	case PHY_TYPE_SATA:
@@ -574,6 +584,8 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
 	/* pipe-grf */
 	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
 	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
+	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
+	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },
 };
 
 static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 9171de657f97..a75762e4d264 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -187,6 +187,9 @@ static const unsigned int i2c_sda_c_pins[]	= { GPIODV_28 };
 static const unsigned int i2c_sck_c_dv19_pins[] = { GPIODV_19 };
 static const unsigned int i2c_sda_c_dv18_pins[] = { GPIODV_18 };
 
+static const unsigned int i2c_sck_d_pins[]	= { GPIOX_11 };
+static const unsigned int i2c_sda_d_pins[]	= { GPIOX_10 };
+
 static const unsigned int eth_mdio_pins[]	= { GPIOZ_0 };
 static const unsigned int eth_mdc_pins[]	= { GPIOZ_1 };
 static const unsigned int eth_clk_rx_clk_pins[] = { GPIOZ_2 };
@@ -411,6 +414,8 @@ static const struct meson_pmx_group meson_gxl_periphs_groups[] = {
 	GPIO_GROUP(GPIO_TEST_N),
 
 	/* Bank X */
+	GROUP(i2c_sda_d,	5,	5),
+	GROUP(i2c_sck_d,	5,	4),
 	GROUP(sdio_d0,		5,	31),
 	GROUP(sdio_d1,		5,	30),
 	GROUP(sdio_d2,		5,	29),
@@ -651,6 +656,10 @@ static const char * const i2c_c_groups[] = {
 	"i2c_sck_c", "i2c_sda_c", "i2c_sda_c_dv18", "i2c_sck_c_dv19",
 };
 
+static const char * const i2c_d_groups[] = {
+	"i2c_sck_d", "i2c_sda_d",
+};
+
 static const char * const eth_groups[] = {
 	"eth_mdio", "eth_mdc", "eth_clk_rx_clk", "eth_rx_dv",
 	"eth_rxd0", "eth_rxd1", "eth_rxd2", "eth_rxd3",
@@ -777,6 +786,7 @@ static const struct meson_pmx_func meson_gxl_periphs_functions[] = {
 	FUNCTION(i2c_a),
 	FUNCTION(i2c_b),
 	FUNCTION(i2c_c),
+	FUNCTION(i2c_d),
 	FUNCTION(eth),
 	FUNCTION(pwm_a),
 	FUNCTION(pwm_b),
diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 2c31e7f2a27a..56e14193d678 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -337,7 +337,7 @@ static int pinmux_func_name_to_selector(struct pinctrl_dev *pctldev,
 	while (selector < nfuncs) {
 		const char *fname = ops->get_function_name(pctldev, selector);
 
-		if (!strcmp(function, fname))
+		if (fname && !strcmp(function, fname))
 			return selector;
 
 		selector++;
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index bde58f5a743c..698ab8cc970a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1074,7 +1074,7 @@ static u32 rzg3s_oen_read(struct rzg2l_pinctrl *pctrl, unsigned int _pin)
 
 	bit = rzg3s_pin_to_oen_bit(pctrl, _pin);
 	if (bit < 0)
-		return bit;
+		return 0;
 
 	return !(readb(pctrl->base + ETH_MODE) & BIT(bit));
 }
diff --git a/drivers/pinctrl/renesas/pinctrl.c b/drivers/pinctrl/renesas/pinctrl.c
index 29d16c9c1bd1..3a742f74ecd1 100644
--- a/drivers/pinctrl/renesas/pinctrl.c
+++ b/drivers/pinctrl/renesas/pinctrl.c
@@ -726,7 +726,8 @@ static int sh_pfc_pinconf_group_set(struct pinctrl_dev *pctldev, unsigned group,
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
 	const unsigned int *pins;
 	unsigned int num_pins;
-	unsigned int i, ret;
+	unsigned int i;
+	int ret;
 
 	pins = pmx->pfc->info->groups[group].pins;
 	num_pins = pmx->pfc->info->groups[group].nr_pins;
diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index f63c3c410451..382dff8805c6 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -702,8 +702,7 @@ static int cw_bat_probe(struct i2c_client *client)
 	if (!cw_bat->battery_workqueue)
 		return -ENOMEM;
 
-	devm_delayed_work_autocancel(&client->dev,
-							  &cw_bat->battery_delay_work, cw_bat_work);
+	devm_delayed_work_autocancel(&client->dev, &cw_bat->battery_delay_work, cw_bat_work);
 	queue_delayed_work(cw_bat->battery_workqueue,
 			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
 	return 0;
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index 92d1b62ea239..e9389876229e 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -109,16 +109,13 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
 	if (err < 0) {
 		pr_err("%s: unable to create char device\n",
 					info->name);
-		goto kfree_pps;
+		goto pps_register_source_exit;
 	}
 
 	dev_dbg(&pps->dev, "new PPS source %s\n", info->name);
 
 	return pps;
 
-kfree_pps:
-	kfree(pps);
-
 pps_register_source_exit:
 	pr_err("%s: unable to register source\n", info->name);
 
diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
index 9463232af8d2..c6b8b6478276 100644
--- a/drivers/pps/pps.c
+++ b/drivers/pps/pps.c
@@ -374,6 +374,7 @@ int pps_register_cdev(struct pps_device *pps)
 			       pps->info.name);
 			err = -EBUSY;
 		}
+		kfree(pps);
 		goto out_unlock;
 	}
 	pps->id = err;
@@ -383,13 +384,11 @@ int pps_register_cdev(struct pps_device *pps)
 	pps->dev.devt = MKDEV(pps_major, pps->id);
 	dev_set_drvdata(&pps->dev, pps);
 	dev_set_name(&pps->dev, "pps%d", pps->id);
+	pps->dev.release = pps_device_destruct;
 	err = device_register(&pps->dev);
 	if (err)
 		goto free_idr;
 
-	/* Override the release function with our own */
-	pps->dev.release = pps_device_destruct;
-
 	pr_debug("source %s got cdev (%d:%d)\n", pps->info.name, pps_major,
 		 pps->id);
 
diff --git a/drivers/ptp/ptp_private.h b/drivers/ptp/ptp_private.h
index b352df4cd3f9..f329263f33aa 100644
--- a/drivers/ptp/ptp_private.h
+++ b/drivers/ptp/ptp_private.h
@@ -22,6 +22,7 @@
 #define PTP_MAX_TIMESTAMPS 128
 #define PTP_BUF_TIMESTAMPS 30
 #define PTP_DEFAULT_MAX_VCLOCKS 20
+#define PTP_MAX_VCLOCKS_LIMIT (KMALLOC_MAX_SIZE/(sizeof(int)))
 #define PTP_MAX_CHANNELS 2048
 
 enum {
diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
index 6b1b8f57cd95..200eaf500696 100644
--- a/drivers/ptp/ptp_sysfs.c
+++ b/drivers/ptp/ptp_sysfs.c
@@ -284,7 +284,7 @@ static ssize_t max_vclocks_store(struct device *dev,
 	size_t size;
 	u32 max;
 
-	if (kstrtou32(buf, 0, &max) || max == 0)
+	if (kstrtou32(buf, 0, &max) || max == 0 || max > PTP_MAX_VCLOCKS_LIMIT)
 		return -EINVAL;
 
 	if (max == ptp->max_vclocks)
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0125e73b98df..7a86cb090f76 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -36,7 +36,7 @@
 
 #define CLKDIV_MAX		7
 #define HSPCLKDIV_MAX		7
-#define PERIOD_MAX		0xFFFF
+#define PERIOD_MAX		0x10000
 
 /* compare module registers */
 #define CMPA			0x12
@@ -65,14 +65,10 @@
 #define AQCTL_ZRO_FRCHIGH	BIT(1)
 #define AQCTL_ZRO_FRCTOGGLE	(BIT(1) | BIT(0))
 
-#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
-#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_ZRO_FRCLOW)
 
 #define AQSFRC_RLDCSF_MASK	(BIT(7) | BIT(6))
 #define AQSFRC_RLDCSF_ZRO	0
@@ -108,7 +104,6 @@ struct ehrpwm_pwm_chip {
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
-	enum pwm_polarity polarity[NUM_PWM_CHANNEL];
 	struct clk *tbclk;
 	struct ehrpwm_context ctx;
 };
@@ -166,7 +161,7 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 
 			*prescale_div = (1 << clkdiv) *
 					(hspclkdiv ? (hspclkdiv * 2) : 1);
-			if (*prescale_div > rqst_prescaler) {
+			if (*prescale_div >= rqst_prescaler) {
 				*tb_clk_div = (clkdiv << TBCTL_CLKDIV_SHIFT) |
 					(hspclkdiv << TBCTL_HSPCLKDIV_SHIFT);
 				return 0;
@@ -177,51 +172,20 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 	return 1;
 }
 
-static void configure_polarity(struct ehrpwm_pwm_chip *pc, int chan)
-{
-	u16 aqctl_val, aqctl_mask;
-	unsigned int aqctl_reg;
-
-	/*
-	 * Configure PWM output to HIGH/LOW level on counter
-	 * reaches compare register value and LOW/HIGH level
-	 * on counter value reaches period register value and
-	 * zero value on counter
-	 */
-	if (chan == 1) {
-		aqctl_reg = AQCTLB;
-		aqctl_mask = AQCTL_CBU_MASK;
-
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANB_POLINVERSED;
-		else
-			aqctl_val = AQCTL_CHANB_POLNORMAL;
-	} else {
-		aqctl_reg = AQCTLA;
-		aqctl_mask = AQCTL_CAU_MASK;
-
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANA_POLINVERSED;
-		else
-			aqctl_val = AQCTL_CHANA_POLNORMAL;
-	}
-
-	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
-	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
-}
-
 /*
  * period_ns = 10^9 * (ps_divval * period_cycles) / PWM_CLK_RATE
  * duty_ns   = 10^9 * (ps_divval * duty_cycles) / PWM_CLK_RATE
  */
 static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     u64 duty_ns, u64 period_ns)
+			     u64 duty_ns, u64 period_ns, enum pwm_polarity polarity)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 	u32 period_cycles, duty_cycles;
 	u16 ps_divval, tb_divval;
 	unsigned int i, cmp_reg;
 	unsigned long long c;
+	u16 aqctl_val, aqctl_mask;
+	unsigned int aqctl_reg;
 
 	if (period_ns > NSEC_PER_SEC)
 		return -ERANGE;
@@ -231,15 +195,10 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(c, NSEC_PER_SEC);
 	period_cycles = (unsigned long)c;
 
-	if (period_cycles < 1) {
-		period_cycles = 1;
-		duty_cycles = 1;
-	} else {
-		c = pc->clk_rate;
-		c = c * duty_ns;
-		do_div(c, NSEC_PER_SEC);
-		duty_cycles = (unsigned long)c;
-	}
+	c = pc->clk_rate;
+	c = c * duty_ns;
+	do_div(c, NSEC_PER_SEC);
+	duty_cycles = (unsigned long)c;
 
 	/*
 	 * Period values should be same for multiple PWM channels as IP uses
@@ -265,52 +224,73 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	pc->period_cycles[pwm->hwpwm] = period_cycles;
 
 	/* Configure clock prescaler to support Low frequency PWM wave */
-	if (set_prescale_div(period_cycles/PERIOD_MAX, &ps_divval,
+	if (set_prescale_div(DIV_ROUND_UP(period_cycles, PERIOD_MAX), &ps_divval,
 			     &tb_divval)) {
 		dev_err(pwmchip_parent(chip), "Unsupported values\n");
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(pwmchip_parent(chip));
-
-	/* Update clock prescaler values */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
-
 	/* Update period & duty cycle with presacler division */
 	period_cycles = period_cycles / ps_divval;
 	duty_cycles = duty_cycles / ps_divval;
 
-	/* Configure shadow loading on Period register */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRDLD_MASK, TBCTL_PRDLD_SHDW);
+	if (period_cycles < 1)
+		period_cycles = 1;
 
-	ehrpwm_write(pc->mmio_base, TBPRD, period_cycles);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
-	/* Configure ehrpwm counter for up-count mode */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CTRMODE_MASK,
-		      TBCTL_CTRMODE_UP);
+	/* Update clock prescaler values */
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
 
-	if (pwm->hwpwm == 1)
+	if (pwm->hwpwm == 1) {
 		/* Channel 1 configured with compare B register */
 		cmp_reg = CMPB;
-	else
+
+		aqctl_reg = AQCTLB;
+		aqctl_mask = AQCTL_CBU_MASK;
+
+		if (polarity == PWM_POLARITY_INVERSED)
+			aqctl_val = AQCTL_CHANB_POLINVERSED;
+		else
+			aqctl_val = AQCTL_CHANB_POLNORMAL;
+
+		/* if duty_cycle is big, don't toggle on CBU */
+		if (duty_cycles > period_cycles)
+			aqctl_val &= ~AQCTL_CBU_MASK;
+
+	} else {
 		/* Channel 0 configured with compare A register */
 		cmp_reg = CMPA;
 
-	ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
+		aqctl_reg = AQCTLA;
+		aqctl_mask = AQCTL_CAU_MASK;
 
-	pm_runtime_put_sync(pwmchip_parent(chip));
+		if (polarity == PWM_POLARITY_INVERSED)
+			aqctl_val = AQCTL_CHANA_POLINVERSED;
+		else
+			aqctl_val = AQCTL_CHANA_POLNORMAL;
 
-	return 0;
-}
+		/* if duty_cycle is big, don't toggle on CAU */
+		if (duty_cycles > period_cycles)
+			aqctl_val &= ~AQCTL_CAU_MASK;
+	}
 
-static int ehrpwm_pwm_set_polarity(struct pwm_chip *chip,
-				   struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
-{
-	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
+	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
+
+	/* Configure shadow loading on Period register */
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRDLD_MASK, TBCTL_PRDLD_SHDW);
+
+	ehrpwm_write(pc->mmio_base, TBPRD, period_cycles - 1);
 
-	/* Configuration of polarity in hardware delayed, do at enable */
-	pc->polarity[pwm->hwpwm] = polarity;
+	/* Configure ehrpwm counter for up-count mode */
+	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CTRMODE_MASK,
+		      TBCTL_CTRMODE_UP);
+
+	if (!(duty_cycles > period_cycles))
+		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
+
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -339,9 +319,6 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 
-	/* Channels polarity can be configured from action qualifier module */
-	configure_polarity(pc, pwm->hwpwm);
-
 	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
@@ -391,12 +368,7 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	if (pwm_is_enabled(pwm)) {
-		dev_warn(pwmchip_parent(chip), "Removing PWM device without disabling\n");
-		pm_runtime_put_sync(pwmchip_parent(chip));
-	}
-
-	/* set period value to zero on free */
+	/* Don't let a pwm without consumer block requests to the other channel */
 	pc->period_cycles[pwm->hwpwm] = 0;
 }
 
@@ -411,10 +383,6 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			ehrpwm_pwm_disable(chip, pwm);
 			enabled = false;
 		}
-
-		err = ehrpwm_pwm_set_polarity(chip, pwm, state->polarity);
-		if (err)
-			return err;
 	}
 
 	if (!state->enabled) {
@@ -423,7 +391,7 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
 	if (err)
 		return err;
 
diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 9df726f10ad1..6d609c42e479 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -257,7 +257,8 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 					  struct device_node *np,
 					  struct scmi_regulator_info *rinfo)
 {
-	u32 dom, ret;
+	u32 dom;
+	int ret;
 
 	ret = of_property_read_u32(np, "reg", &dom);
 	if (ret)
diff --git a/drivers/remoteproc/pru_rproc.c b/drivers/remoteproc/pru_rproc.c
index 327f0c7ee3d6..7ffbae209a31 100644
--- a/drivers/remoteproc/pru_rproc.c
+++ b/drivers/remoteproc/pru_rproc.c
@@ -340,7 +340,7 @@ EXPORT_SYMBOL_GPL(pru_rproc_put);
  */
 int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
 {
-	struct pru_rproc *pru = rproc->priv;
+	struct pru_rproc *pru;
 	unsigned int reg;
 	u32 mask, set;
 	u16 idx;
@@ -352,6 +352,7 @@ int pru_rproc_set_ctable(struct rproc *rproc, enum pru_ctable_idx c, u32 addr)
 	if (!rproc->dev.parent || !is_pru_rproc(rproc->dev.parent))
 		return -ENODEV;
 
+	pru = rproc->priv;
 	/* pointer is 16 bit and index is 8-bit so mask out the rest */
 	idx_mask = (c >= PRU_C28) ? 0xFFFF : 0xFF;
 
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 4ee5e67a9f03..769c6d6d6a73 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -156,9 +156,6 @@ int qcom_q6v5_wait_for_start(struct qcom_q6v5 *q6v5, int timeout)
 	int ret;
 
 	ret = wait_for_completion_timeout(&q6v5->start_done, timeout);
-	if (!ret)
-		disable_irq(q6v5->handover_irq);
-
 	return !ret ? -ETIMEDOUT : 0;
 }
 EXPORT_SYMBOL_GPL(qcom_q6v5_wait_for_start);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
index d84413b77d84..421db8996927 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
@@ -987,11 +987,9 @@ mpt3sas_transport_port_remove(struct MPT3SAS_ADAPTER *ioc, u64 sas_address,
 	list_for_each_entry_safe(mpt3sas_phy, next_phy,
 	    &mpt3sas_port->phy_list, port_siblings) {
 		if ((ioc->logging_level & MPT_DEBUG_TRANSPORT))
-			dev_printk(KERN_INFO, &mpt3sas_port->port->dev,
-			    "remove: sas_addr(0x%016llx), phy(%d)\n",
-			    (unsigned long long)
-			    mpt3sas_port->remote_identify.sas_address,
-			    mpt3sas_phy->phy_id);
+			ioc_info(ioc, "remove: sas_addr(0x%016llx), phy(%d)\n",
+				(unsigned long long) mpt3sas_port->remote_identify.sas_address,
+					mpt3sas_phy->phy_id);
 		mpt3sas_phy->phy_belongs_to_port = 0;
 		if (!ioc->remove_host)
 			sas_port_delete_phy(mpt3sas_port->port,
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
index 1469d0c54e45..5a02fd3bc6c9 100644
--- a/drivers/scsi/myrs.c
+++ b/drivers/scsi/myrs.c
@@ -498,14 +498,14 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 	/* Temporary dma mapping, used only in the scope of this function */
 	mbox = dma_alloc_coherent(&pdev->dev, sizeof(union myrs_cmd_mbox),
 				  &mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, mbox_addr))
+	if (!mbox)
 		return false;
 
 	/* These are the base addresses for the command memory mailbox array */
 	cs->cmd_mbox_size = MYRS_MAX_CMD_MBOX * sizeof(union myrs_cmd_mbox);
 	cmd_mbox = dma_alloc_coherent(&pdev->dev, cs->cmd_mbox_size,
 				      &cs->cmd_mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, cs->cmd_mbox_addr)) {
+	if (!cmd_mbox) {
 		dev_err(&pdev->dev, "Failed to map command mailbox\n");
 		goto out_free;
 	}
@@ -520,7 +520,7 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 	cs->stat_mbox_size = MYRS_MAX_STAT_MBOX * sizeof(struct myrs_stat_mbox);
 	stat_mbox = dma_alloc_coherent(&pdev->dev, cs->stat_mbox_size,
 				       &cs->stat_mbox_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, cs->stat_mbox_addr)) {
+	if (!stat_mbox) {
 		dev_err(&pdev->dev, "Failed to map status mailbox\n");
 		goto out_free;
 	}
@@ -533,7 +533,7 @@ static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
 	cs->fwstat_buf = dma_alloc_coherent(&pdev->dev,
 					    sizeof(struct myrs_fwstat),
 					    &cs->fwstat_addr, GFP_KERNEL);
-	if (dma_mapping_error(&pdev->dev, cs->fwstat_addr)) {
+	if (!cs->fwstat_buf) {
 		dev_err(&pdev->dev, "Failed to map firmware health buffer\n");
 		cs->fwstat_buf = NULL;
 		goto out_free;
diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index a9d6dac41334..4daab8b6d675 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -703,6 +703,7 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 	unsigned long flags = 0;
 	struct pm8001_hba_info *pm8001_ha;
 	struct pm8001_device *pm8001_dev = dev->lldd_dev;
+	struct domain_device *parent_dev = dev->parent;
 
 	pm8001_ha = pm8001_find_ha_by_dev(dev);
 	spin_lock_irqsave(&pm8001_ha->lock, flags);
@@ -719,7 +720,13 @@ static void pm8001_dev_gone_notify(struct domain_device *dev)
 			spin_lock_irqsave(&pm8001_ha->lock, flags);
 		}
 		PM8001_CHIP_DISP->dereg_dev_req(pm8001_ha, device_id);
-		pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
+
+		/*
+		 * The phy array only contains local phys. Thus, we cannot clear
+		 * phy_attached for a device behind an expander.
+		 */
+		if (!(parent_dev && dev_is_expander(parent_dev->dev_type)))
+			pm8001_ha->phy[pm8001_dev->attached_phy].phy_attached = 0;
 		pm8001_free_dev(pm8001_dev);
 	} else {
 		pm8001_dbg(pm8001_ha, DISC, "Found dev has gone.\n");
diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index dcde55c8ee5d..be20e2c457b8 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -1797,7 +1797,7 @@ qla24xx_sadb_update(struct bsg_job *bsg_job)
 	switch (rval) {
 	case QLA_SUCCESS:
 		break;
-	case EAGAIN:
+	case -EAGAIN:
 		msleep(EDIF_MSLEEP_INTERVAL);
 		cnt++;
 		if (cnt < EDIF_RETRY_COUNT)
@@ -3648,7 +3648,7 @@ int qla_edif_process_els(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 		       p->e.extra_rx_xchg_address, p->e.extra_control_flags,
 		       sp->handle, sp->remap.req.len, bsg_job);
 		break;
-	case EAGAIN:
+	case -EAGAIN:
 		msleep(EDIF_MSLEEP_INTERVAL);
 		cnt++;
 		if (cnt < EDIF_RETRY_COUNT)
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 79cdfec2bca3..8bd4aa935e22 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -2059,11 +2059,11 @@ static void qla_marker_sp_done(srb_t *sp, int res)
 	int cnt = 5; \
 	do { \
 		if (_chip_gen != sp->vha->hw->chip_reset || _login_gen != sp->fcport->login_gen) {\
-			_rval = EINVAL; \
+			_rval = -EINVAL; \
 			break; \
 		} \
 		_rval = qla2x00_start_sp(_sp); \
-		if (_rval == EAGAIN) \
+		if (_rval == -EAGAIN) \
 			msleep(1); \
 		else \
 			break; \
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 8ee2e337c9e1..316594aa40cc 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -419,7 +419,7 @@ static int qla_nvme_xmt_ls_rsp(struct nvme_fc_local_port *lport,
 	switch (rval) {
 	case QLA_SUCCESS:
 		break;
-	case EAGAIN:
+	case -EAGAIN:
 		msleep(PURLS_MSLEEP_INTERVAL);
 		cnt++;
 		if (cnt < PURLS_RETRY_COUNT)
diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 9a91298c1253..4cb8169aec6b 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2167,10 +2167,18 @@ static struct device *svs_add_device_link(struct svs_platform *svsp,
 	return dev;
 }
 
+static void svs_put_device(void *_dev)
+{
+	struct device *dev = _dev;
+
+	put_device(dev);
+}
+
 static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
 	u32 idx;
+	int ret;
 
 	svsp->rst = devm_reset_control_get_optional(svsp->dev, "svs_rst");
 	if (IS_ERR(svsp->rst))
@@ -2181,6 +2189,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get lvts device\n");
+	put_device(dev);
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		struct svs_bank *svsb = &svsp->banks[idx];
@@ -2190,6 +2199,7 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 		case SVSB_SWID_CPU_LITTLE:
 		case SVSB_SWID_CPU_BIG:
 			svsb->opp_dev = get_cpu_device(bdata->cpu_id);
+			get_device(svsb->opp_dev);
 			break;
 		case SVSB_SWID_CCI:
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
@@ -2209,6 +2219,11 @@ static int svs_mt8192_platform_probe(struct svs_platform *svsp)
 			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
 					     "failed to get OPP device for bank %d\n",
 					     idx);
+
+		ret = devm_add_action_or_reset(svsp->dev, svs_put_device,
+					       svsb->opp_dev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -2218,11 +2233,13 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 {
 	struct device *dev;
 	u32 idx;
+	int ret;
 
 	dev = svs_add_device_link(svsp, "thermal-sensor");
 	if (IS_ERR(dev))
 		return dev_err_probe(svsp->dev, PTR_ERR(dev),
 				     "failed to get thermal device\n");
+	put_device(dev);
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		struct svs_bank *svsb = &svsp->banks[idx];
@@ -2232,6 +2249,7 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 		case SVSB_SWID_CPU_LITTLE:
 		case SVSB_SWID_CPU_BIG:
 			svsb->opp_dev = get_cpu_device(bdata->cpu_id);
+			get_device(svsb->opp_dev);
 			break;
 		case SVSB_SWID_CCI:
 			svsb->opp_dev = svs_add_device_link(svsp, "cci");
@@ -2248,6 +2266,11 @@ static int svs_mt8183_platform_probe(struct svs_platform *svsp)
 			return dev_err_probe(svsp->dev, PTR_ERR(svsb->opp_dev),
 					     "failed to get OPP device for bank %d\n",
 					     idx);
+
+		ret = devm_add_action_or_reset(svsp->dev, svs_put_device,
+					       svsb->opp_dev);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 641f29a98cbd..cc72a31a450e 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -453,13 +453,10 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 		trace_rpmh_tx_done(drv, i, req);
 
-		/*
-		 * If wake tcs was re-purposed for sending active
-		 * votes, clear AMC trigger & enable modes and
+		/* Clear AMC trigger & enable modes and
 		 * disable interrupt for this TCS
 		 */
-		if (!drv->tcs[ACTIVE_TCS].num_tcs)
-			__tcs_set_trigger(drv, i, false);
+		__tcs_set_trigger(drv, i, false);
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8d6341b0d866..5ad9f4a2148f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2462,7 +2462,7 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	if (rc > ctlr->num_chipselect) {
 		dev_err(&ctlr->dev, "%pOF has number of CS > ctlr->num_chipselect (%d)\n",
 			nc, rc);
-		return rc;
+		return -EINVAL;
 	}
 	if ((of_property_read_bool(nc, "parallel-memories")) &&
 	    (!(ctlr->flags & SPI_CONTROLLER_MULTI_CS))) {
diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 2a7d253d9c55..8e50476eb71f 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -321,6 +321,14 @@ register_shm_helper(struct tee_context *ctx, struct iov_iter *iter, u32 flags,
 	if (unlikely(len <= 0)) {
 		ret = len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
 		goto err_free_shm_pages;
+	} else if (DIV_ROUND_UP(len + off, PAGE_SIZE) != num_pages) {
+		/*
+		 * If we only got a few pages, update to release the
+		 * correct amount below.
+		 */
+		shm->num_pages = len / PAGE_SIZE;
+		ret = ERR_PTR(-ENOMEM);
+		goto err_put_shm_pages;
 	}
 
 	/*
diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26eb..a6bb01082ec6 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -34,7 +34,8 @@ config QCOM_SPMI_TEMP_ALARM
 
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
-	depends on ARCH_QCOM && QCOM_SCM
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index d2d49264cf83..7c299184c59b 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -5,6 +5,8 @@
  */
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/irqdomain.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 252849910588..c917fc20b469 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -461,6 +461,7 @@ static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg);
 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr);
 static void gsmld_write_trigger(struct gsm_mux *gsm);
 static void gsmld_write_task(struct work_struct *work);
+static int gsm_modem_send_initial_msc(struct gsm_dlci *dlci);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -2174,7 +2175,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
 	if (dlci->addr) {
-		gsm_modem_update(dlci, 0);
+		gsm_modem_send_initial_msc(dlci);
 	} else {
 		/* Start keep-alive control */
 		gsm->ka_num = 0;
@@ -4156,6 +4157,28 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 	return gsm_control_wait(dlci->gsm, ctrl);
 }
 
+/**
+ * gsm_modem_send_initial_msc - Send initial modem status message
+ *
+ * @dlci channel
+ *
+ * Send an initial MSC message after DLCI open to set the initial
+ * modem status lines. This is only done for basic mode.
+ * Does not wait for a response as we cannot block the input queue
+ * processing.
+ */
+static int gsm_modem_send_initial_msc(struct gsm_dlci *dlci)
+{
+	u8 modembits[2];
+
+	if (dlci->adaption != 1 || dlci->gsm->encoding != GSM_BASIC_OPT)
+		return 0;
+
+	modembits[0] = (dlci->addr << 2) | 2 | EA; /* DLCI, Valid, EA */
+	modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
+	return gsm_control_command(dlci->gsm, CMD_MSC, (const u8 *)&modembits, 2);
+}
+
 /**
  *	gsm_modem_update	-	send modem status line state
  *	@dlci: channel
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 35369a2f77b2..2f8e3ea4fe12 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1641,6 +1641,8 @@ static int max310x_i2c_probe(struct i2c_client *client)
 		port_client = devm_i2c_new_dummy_device(&client->dev,
 							client->adapter,
 							port_addr);
+		if (IS_ERR(port_client))
+			return PTR_ERR(port_client);
 
 		regcfg_i2c.name = max310x_regmap_name(i);
 		regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index a6551a795f74..0b414d1168dd 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -98,7 +98,6 @@ static void hv_uio_channel_cb(void *context)
 	struct hv_device *hv_dev = chan->device_obj;
 	struct hv_uio_private_data *pdata = hv_get_drvdata(hv_dev);
 
-	chan->inbound.ring_buffer->interrupt_mask = 1;
 	virt_mb();
 
 	uio_event_notify(&pdata->info);
@@ -163,8 +162,6 @@ hv_uio_new_channel(struct vmbus_channel *new_sc)
 		return;
 	}
 
-	/* Disable interrupts on sub channel */
-	new_sc->inbound.ring_buffer->interrupt_mask = 1;
 	set_channel_read_mode(new_sc, HV_CALL_ISR);
 	ret = hv_create_ring_sysfs(new_sc, hv_uio_ring_mmap);
 	if (ret) {
@@ -207,9 +204,7 @@ hv_uio_open(struct uio_info *info, struct inode *inode)
 
 	ret = vmbus_connect_ring(dev->channel,
 				 hv_uio_channel_cb, dev->channel);
-	if (ret == 0)
-		dev->channel->inbound.ring_buffer->interrupt_mask = 1;
-	else
+	if (ret)
 		atomic_dec(&pdata->refcnt);
 
 	return ret;
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 36781ea60f6a..4a9eff7fdb12 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -91,7 +91,7 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 		cdnsp = kzalloc(sizeof(*cdnsp), GFP_KERNEL);
 		if (!cdnsp) {
 			ret = -ENOMEM;
-			goto disable_pci;
+			goto put_pci;
 		}
 	}
 
@@ -174,9 +174,6 @@ static int cdnsp_pci_probe(struct pci_dev *pdev,
 	if (!pci_is_enabled(func))
 		kfree(cdnsp);
 
-disable_pci:
-	pci_disable_device(pdev);
-
 put_pci:
 	pci_dev_put(func);
 
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 1b4d0056f1d0..82282373c786 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1750,6 +1750,8 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		cdev->use_os_string = true;
 		cdev->b_vendor_code = gi->b_vendor_code;
 		memcpy(cdev->qw_sign, gi->qw_sign, OS_STRING_QW_SIGN_LEN);
+	} else {
+		cdev->use_os_string = false;
 	}
 
 	if (gadget_is_otg(gadget) && !otg_desc[0]) {
diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hcd.c
index dcf31a592f5d..4b5f03f683f7 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -1916,7 +1916,7 @@ max3421_probe(struct spi_device *spi)
 	if (hcd) {
 		kfree(max3421_hcd->tx);
 		kfree(max3421_hcd->rx);
-		if (max3421_hcd->spi_thread)
+		if (!IS_ERR_OR_NULL(max3421_hcd->spi_thread))
 			kthread_stop(max3421_hcd->spi_thread);
 		usb_put_hcd(hcd);
 	}
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 1002fa51a25a..f377725a1212 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1199,19 +1199,16 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again.
+			 * Keep retrying until the EP starts and stops again, on
+			 * chips where this is known to help. Wait for 100ms.
 			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
-			/*
-			 * Don't retry forever if we guessed wrong or a defective HC never starts
-			 * the EP or says 'Running' but fails the command. We must give back TDs.
-			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 6497c4e81e95..9bf8fc6247ba 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	select USB_ROLE_SWITCH
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index 19906301a4eb..012e3b9d9bcc 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/usb/role.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 
 #define EUD_REG_INT1_EN_MASK	0x0024
 #define EUD_REG_INT_STATUS_1	0x0044
@@ -34,7 +35,7 @@ struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
 	void __iomem			*base;
-	void __iomem			*mode_mgr;
+	phys_addr_t			mode_mgr;
 	unsigned int			int_status;
 	int				irq;
 	bool				enabled;
@@ -43,18 +44,29 @@ struct eud_chip {
 
 static int enable_eud(struct eud_chip *priv)
 {
+	int ret;
+
+	ret = qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 1);
+	if (ret)
+		return ret;
+
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
 	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
 			priv->base + EUD_REG_INT1_EN_MASK);
-	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
 
 	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
 }
 
-static void disable_eud(struct eud_chip *priv)
+static int disable_eud(struct eud_chip *priv)
 {
+	int ret;
+
+	ret = qcom_scm_io_writel(priv->mode_mgr + EUD_REG_EUD_EN2, 0);
+	if (ret)
+		return ret;
+
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
+	return 0;
 }
 
 static ssize_t enable_show(struct device *dev,
@@ -82,11 +94,12 @@ static ssize_t enable_store(struct device *dev,
 			chip->enabled = enable;
 		else
 			disable_eud(chip);
+
 	} else {
-		disable_eud(chip);
+		ret = disable_eud(chip);
 	}
 
-	return count;
+	return ret < 0 ? ret : count;
 }
 
 static DEVICE_ATTR_RW(enable);
@@ -178,6 +191,7 @@ static void eud_role_switch_release(void *data)
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
@@ -200,9 +214,10 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(chip->mode_mgr))
-		return PTR_ERR(chip->mode_mgr);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return -ENODEV;
+	chip->mode_mgr = res->start;
 
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0)
diff --git a/drivers/usb/phy/phy-twl6030-usb.c b/drivers/usb/phy/phy-twl6030-usb.c
index da09cff55abc..0e732cd53b62 100644
--- a/drivers/usb/phy/phy-twl6030-usb.c
+++ b/drivers/usb/phy/phy-twl6030-usb.c
@@ -328,9 +328,8 @@ static int twl6030_set_vbus(struct phy_companion *comparator, bool enabled)
 
 static int twl6030_usb_probe(struct platform_device *pdev)
 {
-	u32 ret;
 	struct twl6030_usb	*twl;
-	int			status, err;
+	int			status, err, ret;
 	struct device_node	*np = pdev->dev.of_node;
 	struct device		*dev = &pdev->dev;
 
diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7ee721a877c1..1bdf6f5538f4 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -545,24 +545,23 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
 	if (!event)
 		goto err_unlock;
 
+	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event);
+
 	if (!tps6598x_read_status(tps, &status))
-		goto err_clear_ints;
+		goto err_unlock;
 
 	if (event & APPLE_CD_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
-			goto err_clear_ints;
+			goto err_unlock;
 
 	if (event & APPLE_CD_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
-			goto err_clear_ints;
+			goto err_unlock;
 
 	/* Handle plug insert or removal */
 	if (event & APPLE_CD_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
-err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event);
-
 err_unlock:
 	mutex_unlock(&tps->lock);
 
@@ -668,25 +667,24 @@ static irqreturn_t tps6598x_interrupt(int irq, void *data)
 	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
 		goto err_unlock;
 
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, intev_len);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, intev_len);
+
 	if (!tps6598x_read_status(tps, &status))
-		goto err_clear_ints;
+		goto err_unlock;
 
 	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
-			goto err_clear_ints;
+			goto err_unlock;
 
 	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
-			goto err_clear_ints;
+			goto err_unlock;
 
 	/* Handle plug insert or removal */
 	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
-err_clear_ints:
-	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, intev_len);
-	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, intev_len);
-
 err_unlock:
 	mutex_unlock(&tps->lock);
 
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 8dac1edc74d4..a793e30d46b7 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -764,6 +764,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 				 ctrlreq->wValue, vdev->rhport);
 
 			vdev->udev = usb_get_dev(urb->dev);
+			/*
+			 * NOTE: A similar operation has been done via
+			 * USB_REQ_GET_DESCRIPTOR handler below, which is
+			 * supposed to always precede USB_REQ_SET_ADDRESS.
+			 *
+			 * It's not entirely clear if operating on a different
+			 * usb_device instance here is a real possibility,
+			 * otherwise this call and vdev->udev assignment above
+			 * should be dropped.
+			 */
+			dev_pm_syscore_device(&vdev->udev->dev, true);
 			usb_put_dev(old);
 
 			spin_lock(&vdev->ud.lock);
@@ -784,6 +795,17 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
 			vdev->udev = usb_get_dev(urb->dev);
+			/*
+			 * Set syscore PM flag for the virtually attached
+			 * devices to ensure they will not enter suspend on
+			 * the client side.
+			 *
+			 * Note this doesn't have any impact on the physical
+			 * devices attached to the host system on the server
+			 * side, hence there is no need to undo the operation
+			 * on disconnect.
+			 */
+			dev_pm_syscore_device(&vdev->udev->dev, true);
 			usb_put_dev(old);
 			goto out;
 
diff --git a/drivers/vfio/pci/pds/dirty.c b/drivers/vfio/pci/pds/dirty.c
index c51f5e4c3dd6..481992142f79 100644
--- a/drivers/vfio/pci/pds/dirty.c
+++ b/drivers/vfio/pci/pds/dirty.c
@@ -82,7 +82,7 @@ static int pds_vfio_dirty_alloc_bitmaps(struct pds_vfio_region *region,
 
 	host_ack_bmp = vzalloc(bytes);
 	if (!host_ack_bmp) {
-		bitmap_free(host_seq_bmp);
+		vfree(host_seq_bmp);
 		return -ENOMEM;
 	}
 
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 73e153f9b449..781731eb95cf 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1191,6 +1191,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
+		size_t size;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)src,
 				      len - total_translated, &translated,
@@ -1208,9 +1209,9 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 				      translated);
 		}
 
-		ret = copy_from_iter(dst, translated, &iter);
-		if (ret < 0)
-			return ret;
+		size = copy_from_iter(dst, translated, &iter);
+		if (size != translated)
+			return -EFAULT;
 
 		src += translated;
 		dst += translated;
@@ -1237,6 +1238,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 		struct iov_iter iter;
 		u64 translated;
 		int ret;
+		size_t size;
 
 		ret = iotlb_translate(vrh, (u64)(uintptr_t)dst,
 				      len - total_translated, &translated,
@@ -1254,9 +1256,9 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 				      translated);
 		}
 
-		ret = copy_to_iter(src, translated, &iter);
-		if (ret < 0)
-			return ret;
+		size = copy_to_iter(src, translated, &iter);
+		if (size != translated)
+			return -EFAULT;
 
 		src += translated;
 		dst += translated;
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index be95fcddce4c..85bc40aa8b2c 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -93,6 +93,7 @@ struct simplefb_par {
 
 static void simplefb_clocks_destroy(struct simplefb_par *par);
 static void simplefb_regulators_destroy(struct simplefb_par *par);
+static void simplefb_detach_genpds(void *res);
 
 /*
  * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
@@ -105,6 +106,7 @@ static void simplefb_destroy(struct fb_info *info)
 
 	simplefb_regulators_destroy(info->par);
 	simplefb_clocks_destroy(info->par);
+	simplefb_detach_genpds(info->par);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 
@@ -454,13 +456,14 @@ static void simplefb_detach_genpds(void *res)
 		if (!IS_ERR_OR_NULL(par->genpds[i]))
 			dev_pm_domain_detach(par->genpds[i], true);
 	}
+	par->num_genpds = 0;
 }
 
 static int simplefb_attach_genpds(struct simplefb_par *par,
 				  struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	unsigned int i;
+	unsigned int i, num_genpds;
 	int err;
 
 	err = of_count_phandle_with_args(dev->of_node, "power-domains",
@@ -474,26 +477,35 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
 		return err;
 	}
 
-	par->num_genpds = err;
+	num_genpds = err;
 
 	/*
 	 * Single power-domain devices are handled by the driver core, so
 	 * nothing to do here.
 	 */
-	if (par->num_genpds <= 1)
+	if (num_genpds <= 1) {
+		par->num_genpds = num_genpds;
 		return 0;
+	}
 
-	par->genpds = devm_kcalloc(dev, par->num_genpds, sizeof(*par->genpds),
+	par->genpds = devm_kcalloc(dev, num_genpds, sizeof(*par->genpds),
 				   GFP_KERNEL);
 	if (!par->genpds)
 		return -ENOMEM;
 
-	par->genpd_links = devm_kcalloc(dev, par->num_genpds,
+	par->genpd_links = devm_kcalloc(dev, num_genpds,
 					sizeof(*par->genpd_links),
 					GFP_KERNEL);
 	if (!par->genpd_links)
 		return -ENOMEM;
 
+	/*
+	 * Set par->num_genpds only after genpds and genpd_links are allocated
+	 * to exit early from simplefb_detach_genpds() without full
+	 * initialisation.
+	 */
+	par->num_genpds = num_genpds;
+
 	for (i = 0; i < par->num_genpds; i++) {
 		par->genpds[i] = dev_pm_domain_attach_by_id(dev, i);
 		if (IS_ERR(par->genpds[i])) {
@@ -515,9 +527,10 @@ static int simplefb_attach_genpds(struct simplefb_par *par,
 			dev_warn(dev, "failed to link power-domain %u\n", i);
 	}
 
-	return devm_add_action_or_reset(dev, simplefb_detach_genpds, par);
+	return 0;
 }
 #else
+static void simplefb_detach_genpds(void *res) { }
 static int simplefb_attach_genpds(struct simplefb_par *par,
 				  struct platform_device *pdev)
 {
@@ -631,18 +644,20 @@ static int simplefb_probe(struct platform_device *pdev)
 	ret = devm_aperture_acquire_for_platform_device(pdev, par->base, par->size);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to acquire aperture: %d\n", ret);
-		goto error_regulators;
+		goto error_genpds;
 	}
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register simplefb: %d\n", ret);
-		goto error_regulators;
+		goto error_genpds;
 	}
 
 	dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node);
 
 	return 0;
 
+error_genpds:
+	simplefb_detach_genpds(par);
 error_regulators:
 	simplefb_regulators_destroy(par);
 error_clocks:
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 867f9f311379..a4b497ecfa20 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -100,6 +100,8 @@ static int mpc8xxx_wdt_start(struct watchdog_device *w)
 	ddata->swtc = tmp >> 16;
 	set_bit(WDOG_HW_RUNNING, &ddata->wdd.status);
 
+	mpc8xxx_wdt_keepalive(ddata);
+
 	return 0;
 }
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index afebc91882be..60fe155b1ce0 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1479,7 +1479,7 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long range_bitmap = 0;
 	bool submitted_io = false;
-	bool error = false;
+	int found_error = 0;
 	const u64 folio_start = folio_pos(folio);
 	u64 cur;
 	int bit;
@@ -1536,7 +1536,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 			 */
 			btrfs_mark_ordered_io_finished(inode, folio, cur,
 						       fs_info->sectorsize, false);
-			error = true;
+			if (!found_error)
+				found_error = ret;
 			continue;
 		}
 		submitted_io = true;
@@ -1553,11 +1554,11 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 * If we hit any error, the corresponding sector will still be dirty
 	 * thus no need to clear PAGECACHE_TAG_DIRTY.
 	 */
-	if (!submitted_io && !error) {
+	if (!submitted_io && !found_error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
 		btrfs_folio_clear_writeback(fs_info, folio, start, len);
 	}
-	return ret;
+	return found_error;
 }
 
 /*
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d8120b88fa00..37e18e654f71 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1969,6 +1969,16 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
 
 #define NEXT_ORPHAN(inode) EXT4_I(inode)->i_dtime
 
+/*
+ * Check whether the inode is tracked as orphan (either in orphan file or
+ * orphan list).
+ */
+static inline bool ext4_inode_orphan_tracked(struct inode *inode)
+{
+	return ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
+		!list_empty(&EXT4_I(inode)->i_orphan);
+}
+
 /*
  * Codes for operating systems
  */
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6c692151b0d6..7d949ed0ab5f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -354,7 +354,7 @@ static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
 	 * to cleanup the orphan list in ext4_handle_inode_extension(). Do it
 	 * now.
 	 */
-	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
+	if (ext4_inode_orphan_tracked(inode) && inode->i_nlink) {
 		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
 
 		if (IS_ERR(handle)) {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7923602271ad..558a585c5df5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4330,7 +4330,7 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
 		 * old inodes get re-used with the upper 16 bits of the
 		 * uid/gid intact.
 		 */
-		if (ei->i_dtime && list_empty(&ei->i_orphan)) {
+		if (ei->i_dtime && !ext4_inode_orphan_tracked(inode)) {
 			raw_inode->i_uid_high = 0;
 			raw_inode->i_gid_high = 0;
 		} else {
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index a23b0c01f809..c53918768cb2 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -109,11 +109,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 
 	WARN_ON_ONCE(!(inode->i_state & (I_NEW | I_FREEING)) &&
 		     !inode_is_locked(inode));
-	/*
-	 * Inode orphaned in orphan file or in orphan list?
-	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_ORPHAN_FILE) ||
-	    !list_empty(&EXT4_I(inode)->i_orphan))
+	if (ext4_inode_orphan_tracked(inode))
 		return 0;
 
 	/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 58d125ad2371..cbb65e61c492 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1461,9 +1461,9 @@ static void ext4_free_in_core_inode(struct inode *inode)
 
 static void ext4_destroy_inode(struct inode *inode)
 {
-	if (!list_empty(&(EXT4_I(inode)->i_orphan))) {
+	if (ext4_inode_orphan_tracked(inode)) {
 		ext4_msg(inode->i_sb, KERN_ERR,
-			 "Inode %lu (%p): orphan list check failed!",
+			 "Inode %lu (%p): inode tracked as orphan!",
 			 inode->i_ino, EXT4_I(inode));
 		print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 16, 4,
 				EXT4_I(inode), sizeof(struct ext4_inode_info),
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index efc30626760a..040c06dfb8c0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1781,12 +1781,13 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
 
-			f2fs_update_read_extent_cache_range(&dn,
-				start_pgofs, map->m_pblk + ofs,
-				map->m_len - ofs);
+			if (map->m_len > ofs)
+				f2fs_update_read_extent_cache_range(&dn,
+					start_pgofs, map->m_pblk + ofs,
+					map->m_len - ofs);
 		}
 		if (map->m_next_extent)
-			*map->m_next_extent = pgofs + 1;
+			*map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
 	}
 	f2fs_put_dnode(&dn);
 unlock_out:
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2dec22f2ea63..0d3ef487f72a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2331,8 +2331,6 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 {
 	if (!inode)
 		return true;
-	if (!test_opt(sbi, RESERVE_ROOT))
-		return false;
 	if (IS_NOQUOTA(inode))
 		return true;
 	if (uid_eq(F2FS_OPTION(sbi).s_resuid, current_fsuid()))
@@ -2353,7 +2351,7 @@ static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 	avail_user_block_count = sbi->user_block_count -
 					sbi->current_reserved_blocks;
 
-	if (!__allow_reserved_blocks(sbi, inode, cap))
+	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_blocks(sbi, inode, cap))
 		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
 
 	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fa77841f3e2c..2a108c561e8b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -35,15 +35,23 @@
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
-static void f2fs_zero_post_eof_page(struct inode *inode, loff_t new_size)
+static void f2fs_zero_post_eof_page(struct inode *inode,
+					loff_t new_size, bool lock)
 {
 	loff_t old_size = i_size_read(inode);
 
 	if (old_size >= new_size)
 		return;
 
+	if (mapping_empty(inode->i_mapping))
+		return;
+
+	if (lock)
+		filemap_invalidate_lock(inode->i_mapping);
 	/* zero or drop pages only in range of [old_size, new_size] */
-	truncate_pagecache(inode, old_size);
+	truncate_inode_pages_range(inode->i_mapping, old_size, new_size);
+	if (lock)
+		filemap_invalidate_unlock(inode->i_mapping);
 }
 
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
@@ -114,9 +122,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT);
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT, true);
 
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
@@ -856,8 +862,16 @@ int f2fs_truncate(struct inode *inode)
 	/* we should check inline_data size */
 	if (!f2fs_may_inline_data(inode)) {
 		err = f2fs_convert_inline_inode(inode);
-		if (err)
+		if (err) {
+			/*
+			 * Always truncate page #0 to avoid page cache
+			 * leak in evict() path.
+			 */
+			truncate_inode_pages_range(inode->i_mapping,
+					F2FS_BLK_TO_BYTES(0),
+					F2FS_BLK_END_BYTES(0));
 			return err;
+		}
 	}
 
 	err = f2fs_truncate_blocks(inode, i_size_read(inode), true);
@@ -1081,7 +1095,7 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		filemap_invalidate_lock(inode->i_mapping);
 
 		if (attr->ia_size > old_size)
-			f2fs_zero_post_eof_page(inode, attr->ia_size);
+			f2fs_zero_post_eof_page(inode, attr->ia_size, false);
 		truncate_setsize(inode, attr->ia_size);
 
 		if (attr->ia_size <= old_size)
@@ -1200,9 +1214,7 @@ static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, offset + len);
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len, true);
 
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
@@ -1487,7 +1499,7 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
-	f2fs_zero_post_eof_page(inode, offset + len);
+	f2fs_zero_post_eof_page(inode, offset + len, false);
 
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
@@ -1610,9 +1622,7 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
-	filemap_invalidate_lock(mapping);
-	f2fs_zero_post_eof_page(inode, offset + len);
-	filemap_invalidate_unlock(mapping);
+	f2fs_zero_post_eof_page(inode, offset + len, true);
 
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
@@ -1746,7 +1756,7 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(mapping);
 
-	f2fs_zero_post_eof_page(inode, offset + len);
+	f2fs_zero_post_eof_page(inode, offset + len, false);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1804,9 +1814,7 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 	if (err)
 		return err;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, offset + len);
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len, true);
 
 	f2fs_balance_fs(sbi, true);
 
@@ -4751,9 +4759,8 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	if (err)
 		return err;
 
-	filemap_invalidate_lock(inode->i_mapping);
-	f2fs_zero_post_eof_page(inode, iocb->ki_pos + iov_iter_count(from));
-	filemap_invalidate_unlock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode,
+		iocb->ki_pos + iov_iter_count(from), true);
 	return count;
 }
 
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 161fc76ed5b0..e5558e63e2cb 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -801,8 +801,6 @@ __acquires(&gl->gl_lockref.lock)
 			clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
 			return;
-		} else {
-			clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 		}
 	}
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index ea92483d5e71..c21e63027fc0 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9393,7 +9393,7 @@ static int nfs4_verify_back_channel_attrs(struct nfs41_create_session_args *args
 		goto out;
 	if (rcvd->max_rqst_sz > sent->max_rqst_sz)
 		return -EINVAL;
-	if (rcvd->max_resp_sz < sent->max_resp_sz)
+	if (rcvd->max_resp_sz > sent->max_resp_sz)
 		return -EINVAL;
 	if (rcvd->max_resp_sz_cached > sent->max_resp_sz_cached)
 		return -EINVAL;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1bf2a6593dec..6d1bf890929d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1508,6 +1508,16 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 			bmp_size = bmp_size_v = le32_to_cpu(bmp->res.data_size);
 		}
 
+		/*
+		 * Index blocks exist, but $BITMAP has zero valid bits.
+		 * This implies an on-disk corruption and must be rejected.
+		 */
+		if (in->name == I30_NAME &&
+		    unlikely(bmp_size_v == 0 && indx->alloc_run.count)) {
+			err = -EINVAL;
+			goto out1;
+		}
+
 		bit = bmp_size << 3;
 	}
 
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 48566dff0dc9..662add939da7 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/log2.h>
+#include <linux/overflow.h>
 
 #include "debug.h"
 #include "ntfs.h"
@@ -982,14 +983,18 @@ int run_unpack(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 
 			if (!dlcn)
 				return -EINVAL;
-			lcn = prev_lcn + dlcn;
+
+			if (check_add_overflow(prev_lcn, dlcn, &lcn))
+				return -EINVAL;
 			prev_lcn = lcn;
 		} else {
 			/* The size of 'dlcn' can't be > 8. */
 			return -EINVAL;
 		}
 
-		next_vcn = vcn64 + len;
+		if (check_add_overflow(vcn64, len, &next_vcn))
+			return -EINVAL;
+
 		/* Check boundary. */
 		if (next_vcn > evcn + 1)
 			return -EINVAL;
@@ -1153,7 +1158,8 @@ int run_get_highest_vcn(CLST vcn, const u8 *run_buf, u64 *highest_vcn)
 			return -EINVAL;
 
 		run_buf += size_size + offset_size;
-		vcn64 += len;
+		if (check_add_overflow(vcn64, len, &vcn64))
+			return -EINVAL;
 
 #ifndef CONFIG_NTFS3_64BIT_CLUSTER
 		if (vcn64 > 0x100000000ull)
diff --git a/fs/ocfs2/stack_user.c b/fs/ocfs2/stack_user.c
index 77edcd70f72c..c5236b3ed168 100644
--- a/fs/ocfs2/stack_user.c
+++ b/fs/ocfs2/stack_user.c
@@ -1018,6 +1018,7 @@ static int user_cluster_connect(struct ocfs2_cluster_connection *conn)
 			printk(KERN_ERR "ocfs2: Could not determine"
 					" locking version\n");
 			user_cluster_disconnect(conn);
+			lc = NULL;
 			goto out;
 		}
 		wait_event(lc->oc_wait, (atomic_read(&lc->oc_this_node) > 0));
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index ab911a967246..c946c3a09245 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4223,7 +4223,7 @@ fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
 static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst *rqst,
 				 int num_rqst, const u8 *sig, u8 **iv,
 				 struct aead_request **req, struct sg_table *sgt,
-				 unsigned int *num_sgs, size_t *sensitive_size)
+				 unsigned int *num_sgs)
 {
 	unsigned int req_size = sizeof(**req) + crypto_aead_reqsize(tfm);
 	unsigned int iv_size = crypto_aead_ivsize(tfm);
@@ -4240,9 +4240,8 @@ static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst
 	len += req_size;
 	len = ALIGN(len, __alignof__(struct scatterlist));
 	len += array_size(*num_sgs, sizeof(struct scatterlist));
-	*sensitive_size = len;
 
-	p = kvzalloc(len, GFP_NOFS);
+	p = kzalloc(len, GFP_NOFS);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -4256,16 +4255,14 @@ static void *smb2_aead_req_alloc(struct crypto_aead *tfm, const struct smb_rqst
 
 static void *smb2_get_aead_req(struct crypto_aead *tfm, struct smb_rqst *rqst,
 			       int num_rqst, const u8 *sig, u8 **iv,
-			       struct aead_request **req, struct scatterlist **sgl,
-			       size_t *sensitive_size)
+			       struct aead_request **req, struct scatterlist **sgl)
 {
 	struct sg_table sgtable = {};
 	unsigned int skip, num_sgs, i, j;
 	ssize_t rc;
 	void *p;
 
-	p = smb2_aead_req_alloc(tfm, rqst, num_rqst, sig, iv, req, &sgtable,
-				&num_sgs, sensitive_size);
+	p = smb2_aead_req_alloc(tfm, rqst, num_rqst, sig, iv, req, &sgtable, &num_sgs);
 	if (IS_ERR(p))
 		return ERR_CAST(p);
 
@@ -4354,7 +4351,6 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	DECLARE_CRYPTO_WAIT(wait);
 	unsigned int crypt_len = le32_to_cpu(tr_hdr->OriginalMessageSize);
 	void *creq;
-	size_t sensitive_size;
 
 	rc = smb2_get_enc_key(server, le64_to_cpu(tr_hdr->SessionId), enc, key);
 	if (rc) {
@@ -4380,8 +4376,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 		return rc;
 	}
 
-	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg,
-				 &sensitive_size);
+	creq = smb2_get_aead_req(tfm, rqst, num_rqst, sign, &iv, &req, &sg);
 	if (IS_ERR(creq))
 		return PTR_ERR(creq);
 
@@ -4411,7 +4406,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	if (!rc && enc)
 		memcpy(&tr_hdr->Signature, sign, SMB2_SIGNATURE_SIZE);
 
-	kvfree_sensitive(creq, sensitive_size);
+	kfree_sensitive(creq);
 	return rc;
 }
 
diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 3f07a612c05b..8ccd57fd904b 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -112,10 +112,11 @@ struct ksmbd_startup_request {
 	__u32	smbd_max_io_size;	/* smbd read write size */
 	__u32	max_connections;	/* Number of maximum simultaneous connections */
 	__s8	bind_interfaces_only;
-	__s8	reserved[503];		/* Reserved room */
+	__u32	max_ip_connections;	/* Number of maximum connection per ip address */
+	__s8	reserved[499];		/* Reserved room */
 	__u32	ifc_list_sz;		/* interfaces list size */
 	__s8	____payload[];
-};
+} __packed;
 
 #define KSMBD_STARTUP_CONFIG_INTERFACES(s)	((s)->____payload)
 
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 9dec4c2940bc..b36d0676dbe5 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -104,29 +104,32 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	if (!entry)
 		return -ENOMEM;
 
-	down_read(&sess->rpc_lock);
 	entry->method = method;
 	entry->id = id = ksmbd_ipc_id_alloc();
 	if (id < 0)
 		goto free_entry;
+
+	down_write(&sess->rpc_lock);
 	old = xa_store(&sess->rpc_handle_list, id, entry, KSMBD_DEFAULT_GFP);
-	if (xa_is_err(old))
+	if (xa_is_err(old)) {
+		up_write(&sess->rpc_lock);
 		goto free_id;
+	}
 
 	resp = ksmbd_rpc_open(sess, id);
-	if (!resp)
-		goto erase_xa;
+	if (!resp) {
+		xa_erase(&sess->rpc_handle_list, entry->id);
+		up_write(&sess->rpc_lock);
+		goto free_id;
+	}
 
-	up_read(&sess->rpc_lock);
+	up_write(&sess->rpc_lock);
 	kvfree(resp);
 	return id;
-erase_xa:
-	xa_erase(&sess->rpc_handle_list, entry->id);
 free_id:
 	ksmbd_rpc_id_free(entry->id);
 free_entry:
 	kfree(entry);
-	up_read(&sess->rpc_lock);
 	return -EINVAL;
 }
 
@@ -144,9 +147,14 @@ void ksmbd_session_rpc_close(struct ksmbd_session *sess, int id)
 int ksmbd_session_rpc_method(struct ksmbd_session *sess, int id)
 {
 	struct ksmbd_session_rpc *entry;
+	int method;
 
+	down_read(&sess->rpc_lock);
 	entry = xa_load(&sess->rpc_handle_list, id);
-	return entry ? entry->method : 0;
+	method = entry ? entry->method : 0;
+	up_read(&sess->rpc_lock);
+
+	return method;
 }
 
 void ksmbd_session_destroy(struct ksmbd_session *sess)
diff --git a/fs/smb/server/server.h b/fs/smb/server/server.h
index 995555febe7d..b8a7317be86b 100644
--- a/fs/smb/server/server.h
+++ b/fs/smb/server/server.h
@@ -43,6 +43,7 @@ struct ksmbd_server_config {
 	unsigned int		auth_mechs;
 	unsigned int		max_connections;
 	unsigned int		max_inflight_req;
+	unsigned int		max_ip_connections;
 
 	char			*conf[SERVER_CONF_WORK_GROUP + 1];
 	struct task_struct	*dh_task;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 6dafc2fbac25..d2182477566a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5600,7 +5600,8 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
-			rc = -EOPNOTSUPP;
+			path_put(&path);
+			return -EOPNOTSUPP;
 		} else {
 			info = (struct filesystem_posix_info *)(rsp->Buffer);
 			info->OptimalTransferSize = cpu_to_le32(stfs.f_bsize);
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2da2a5f6b983..4454bbe3c710 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -335,6 +335,9 @@ static int ipc_server_config_on_startup(struct ksmbd_startup_request *req)
 	if (req->max_connections)
 		server_conf.max_connections = req->max_connections;
 
+	if (req->max_ip_connections)
+		server_conf.max_ip_connections = req->max_ip_connections;
+
 	ret = ksmbd_set_netbios_name(req->netbios_name);
 	ret |= ksmbd_set_server_string(req->server_string);
 	ret |= ksmbd_set_work_group(req->work_group);
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index d059c890d142..05dfef7ad67f 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -152,6 +152,10 @@ struct smb_direct_transport {
 	struct work_struct	disconnect_work;
 
 	bool			negotiation_requested;
+
+	bool			legacy_iwarp;
+	u8			initiator_depth;
+	u8			responder_resources;
 };
 
 #define KSMBD_TRANS(t) ((struct ksmbd_transport *)&((t)->transport))
@@ -346,6 +350,9 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	t->cm_id = cm_id;
 	cm_id->context = t;
 
+	t->initiator_depth = SMB_DIRECT_CM_INITIATOR_DEPTH;
+	t->responder_resources = 1;
+
 	t->status = SMB_DIRECT_CS_NEW;
 	init_waitqueue_head(&t->wait_status);
 
@@ -1623,21 +1630,21 @@ static int smb_direct_send_negotiate_response(struct smb_direct_transport *t,
 static int smb_direct_accept_client(struct smb_direct_transport *t)
 {
 	struct rdma_conn_param conn_param;
-	struct ib_port_immutable port_immutable;
-	u32 ird_ord_hdr[2];
+	__be32 ird_ord_hdr[2];
 	int ret;
 
+	/*
+	 * smb_direct_handle_connect_request()
+	 * already negotiated t->initiator_depth
+	 * and t->responder_resources
+	 */
 	memset(&conn_param, 0, sizeof(conn_param));
-	conn_param.initiator_depth = min_t(u8, t->cm_id->device->attrs.max_qp_rd_atom,
-					   SMB_DIRECT_CM_INITIATOR_DEPTH);
-	conn_param.responder_resources = 0;
-
-	t->cm_id->device->ops.get_port_immutable(t->cm_id->device,
-						 t->cm_id->port_num,
-						 &port_immutable);
-	if (port_immutable.core_cap_flags & RDMA_CORE_PORT_IWARP) {
-		ird_ord_hdr[0] = conn_param.responder_resources;
-		ird_ord_hdr[1] = 1;
+	conn_param.initiator_depth = t->initiator_depth;
+	conn_param.responder_resources = t->responder_resources;
+
+	if (t->legacy_iwarp) {
+		ird_ord_hdr[0] = cpu_to_be32(conn_param.responder_resources);
+		ird_ord_hdr[1] = cpu_to_be32(conn_param.initiator_depth);
 		conn_param.private_data = ird_ord_hdr;
 		conn_param.private_data_len = sizeof(ird_ord_hdr);
 	} else {
@@ -2023,10 +2030,13 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 	return true;
 }
 
-static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
+static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id,
+					     struct rdma_cm_event *event)
 {
 	struct smb_direct_transport *t;
 	struct task_struct *handler;
+	u8 peer_initiator_depth;
+	u8 peer_responder_resources;
 	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
@@ -2040,6 +2050,67 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (!t)
 		return -ENOMEM;
 
+	peer_initiator_depth = event->param.conn.initiator_depth;
+	peer_responder_resources = event->param.conn.responder_resources;
+	if (rdma_protocol_iwarp(new_cm_id->device, new_cm_id->port_num) &&
+	    event->param.conn.private_data_len == 8) {
+		/*
+		 * Legacy clients with only iWarp MPA v1 support
+		 * need a private blob in order to negotiate
+		 * the IRD/ORD values.
+		 */
+		const __be32 *ird_ord_hdr = event->param.conn.private_data;
+		u32 ird32 = be32_to_cpu(ird_ord_hdr[0]);
+		u32 ord32 = be32_to_cpu(ird_ord_hdr[1]);
+
+		/*
+		 * cifs.ko sends the legacy IRD/ORD negotiation
+		 * event if iWarp MPA v2 was used.
+		 *
+		 * Here we check that the values match and only
+		 * mark the client as legacy if they don't match.
+		 */
+		if ((u32)event->param.conn.initiator_depth != ird32 ||
+		    (u32)event->param.conn.responder_resources != ord32) {
+			/*
+			 * There are broken clients (old cifs.ko)
+			 * using little endian and also
+			 * struct rdma_conn_param only uses u8
+			 * for initiator_depth and responder_resources,
+			 * so we truncate the value to U8_MAX.
+			 *
+			 * smb_direct_accept_client() will then
+			 * do the real negotiation in order to
+			 * select the minimum between client and
+			 * server.
+			 */
+			ird32 = min_t(u32, ird32, U8_MAX);
+			ord32 = min_t(u32, ord32, U8_MAX);
+
+			t->legacy_iwarp = true;
+			peer_initiator_depth = (u8)ird32;
+			peer_responder_resources = (u8)ord32;
+		}
+	}
+
+	/*
+	 * First set what the we as server are able to support
+	 */
+	t->initiator_depth = min_t(u8, t->initiator_depth,
+				   new_cm_id->device->attrs.max_qp_rd_atom);
+
+	/*
+	 * negotiate the value by using the minimum
+	 * between client and server if the client provided
+	 * non 0 values.
+	 */
+	if (peer_initiator_depth != 0)
+		t->initiator_depth = min_t(u8, t->initiator_depth,
+					   peer_initiator_depth);
+	if (peer_responder_resources != 0)
+		t->responder_resources = min_t(u8, t->responder_resources,
+					       peer_responder_resources);
+
 	ret = smb_direct_connect(t);
 	if (ret)
 		goto out_err;
@@ -2064,7 +2135,7 @@ static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
 {
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST: {
-		int ret = smb_direct_handle_connect_request(cm_id);
+		int ret = smb_direct_handle_connect_request(cm_id, event);
 
 		if (ret) {
 			pr_err("Can't create transport: %d\n", ret);
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index 756833c91b14..b51ccc16abe1 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -240,6 +240,7 @@ static int ksmbd_kthread_fn(void *p)
 	struct interface *iface = (struct interface *)p;
 	struct ksmbd_conn *conn;
 	int ret;
+	unsigned int max_ip_conns;
 
 	while (!kthread_should_stop()) {
 		mutex_lock(&iface->sock_release_lock);
@@ -257,34 +258,38 @@ static int ksmbd_kthread_fn(void *p)
 			continue;
 		}
 
+		if (!server_conf.max_ip_connections)
+			goto skip_max_ip_conns_limit;
+
 		/*
 		 * Limits repeated connections from clients with the same IP.
 		 */
+		max_ip_conns = 0;
 		down_read(&conn_list_lock);
-		list_for_each_entry(conn, &conn_list, conns_list)
+		list_for_each_entry(conn, &conn_list, conns_list) {
 #if IS_ENABLED(CONFIG_IPV6)
 			if (client_sk->sk->sk_family == AF_INET6) {
 				if (memcmp(&client_sk->sk->sk_v6_daddr,
-					   &conn->inet6_addr, 16) == 0) {
-					ret = -EAGAIN;
-					break;
-				}
+					   &conn->inet6_addr, 16) == 0)
+					max_ip_conns++;
 			} else if (inet_sk(client_sk->sk)->inet_daddr ==
-				 conn->inet_addr) {
-				ret = -EAGAIN;
-				break;
-			}
+				 conn->inet_addr)
+				max_ip_conns++;
 #else
 			if (inet_sk(client_sk->sk)->inet_daddr ==
-			    conn->inet_addr) {
+			    conn->inet_addr)
+				max_ip_conns++;
+#endif
+			if (server_conf.max_ip_connections <= max_ip_conns) {
 				ret = -EAGAIN;
 				break;
 			}
-#endif
+		}
 		up_read(&conn_list_lock);
 		if (ret == -EAGAIN)
 			continue;
 
+skip_max_ip_conns_limit:
 		if (server_conf.max_connections &&
 		    atomic_inc_return(&active_num_conn) >= server_conf.max_connections) {
 			pr_info_ratelimited("Limit the maximum number of connections(%u)\n",
diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index d5918eba27e3..53104f25de51 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -165,6 +165,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->start = le32_to_cpu(sqsh_ino->start_block);
 		squashfs_i(inode)->block_list_start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
@@ -212,6 +213,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->start = le64_to_cpu(sqsh_ino->start_block);
 		squashfs_i(inode)->block_list_start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
@@ -292,6 +294,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_mode |= S_IFLNK;
 		squashfs_i(inode)->start = block;
 		squashfs_i(inode)->offset = offset;
+		squashfs_i(inode)->parent = 0;
 
 		if (type == SQUASHFS_LSYMLINK_TYPE) {
 			__le32 xattr;
@@ -329,6 +332,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		rdev = le32_to_cpu(sqsh_ino->rdev);
 		init_special_inode(inode, inode->i_mode, new_decode_dev(rdev));
+		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
 				SQUASHFS_INODE_BLK(ino), offset, rdev);
@@ -353,6 +357,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		rdev = le32_to_cpu(sqsh_ino->rdev);
 		init_special_inode(inode, inode->i_mode, new_decode_dev(rdev));
+		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
 				SQUASHFS_INODE_BLK(ino), offset, rdev);
@@ -373,6 +378,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 			inode->i_mode |= S_IFSOCK;
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		init_special_inode(inode, inode->i_mode, 0);
+		squashfs_i(inode)->parent = 0;
 		break;
 	}
 	case SQUASHFS_LFIFO_TYPE:
@@ -392,6 +398,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_op = &squashfs_inode_ops;
 		set_nlink(inode, le32_to_cpu(sqsh_ino->nlink));
 		init_special_inode(inode, inode->i_mode, 0);
+		squashfs_i(inode)->parent = 0;
 		break;
 	}
 	default:
diff --git a/fs/squashfs/squashfs_fs_i.h b/fs/squashfs/squashfs_fs_i.h
index 2c82d6f2a456..8e497ac07b9a 100644
--- a/fs/squashfs/squashfs_fs_i.h
+++ b/fs/squashfs/squashfs_fs_i.h
@@ -16,6 +16,7 @@ struct squashfs_inode_info {
 	u64		xattr;
 	unsigned int	xattr_size;
 	int		xattr_count;
+	int		parent;
 	union {
 		struct {
 			u64		fragment_block;
@@ -27,7 +28,6 @@ struct squashfs_inode_info {
 			u64		dir_idx_start;
 			int		dir_idx_offset;
 			int		dir_idx_cnt;
-			int		parent;
 		};
 	};
 	struct inode	vfs_inode;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 4386dd845e40..0f97850a165a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -2265,6 +2265,9 @@ int udf_current_aext(struct inode *inode, struct extent_position *epos,
 		if (check_add_overflow(sizeof(struct allocExtDesc),
 				le32_to_cpu(header->lengthAllocDescs), &alen))
 			return -1;
+
+		if (alen > epos->bh->b_size)
+			return -1;
 	}
 
 	switch (iinfo->i_alloc_type) {
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 23b358a1271c..3c75199947f0 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -354,6 +354,7 @@
 	__start_once = .;						\
 	*(.data..once)							\
 	__end_once = .;							\
+	*(.data..do_once)						\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6db72c66de91..e8d9803cc675 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -281,6 +281,7 @@ struct bpf_map_owner {
 	bool xdp_has_frags;
 	u64 storage_cookie[MAX_BPF_CGROUP_STORAGE_TYPE];
 	const struct btf_type *attach_func_proto;
+	enum bpf_attach_type expected_attach_type;
 };
 
 struct bpf_map {
diff --git a/include/linux/btf.h b/include/linux/btf.h
index d99178ce01d2..e473bbfe4128 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -82,7 +82,7 @@
  * as to avoid issues such as the compiler inlining or eliding either a static
  * kfunc, or a global kfunc in an LTO build.
  */
-#define __bpf_kfunc __used __retain noinline
+#define __bpf_kfunc __used __retain __noclone noinline
 
 #define __bpf_kfunc_start_defs()					       \
 	__diag_push();							       \
diff --git a/include/linux/once.h b/include/linux/once.h
index 30346fcdc799..449a0e34ad5a 100644
--- a/include/linux/once.h
+++ b/include/linux/once.h
@@ -46,7 +46,7 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 #define DO_ONCE(func, ...)						     \
 	({								     \
 		bool ___ret = false;					     \
-		static bool __section(".data..once") ___done = false;	     \
+		static bool __section(".data..do_once") ___done = false;     \
 		static DEFINE_STATIC_KEY_TRUE(___once_key);		     \
 		if (static_branch_unlikely(&___once_key)) {		     \
 			unsigned long ___flags;				     \
@@ -64,7 +64,7 @@ void __do_once_sleepable_done(bool *done, struct static_key_true *once_key,
 #define DO_ONCE_SLEEPABLE(func, ...)						\
 	({									\
 		bool ___ret = false;						\
-		static bool __section(".data..once") ___done = false;		\
+		static bool __section(".data..do_once") ___done = false;	\
 		static DEFINE_STATIC_KEY_TRUE(___once_key);			\
 		if (static_branch_unlikely(&___once_key)) {			\
 			___ret = __do_once_sleepable_start(&___done);		\
diff --git a/include/trace/events/filelock.h b/include/trace/events/filelock.h
index b8d1e00a7982..2dfeb158e848 100644
--- a/include/trace/events/filelock.h
+++ b/include/trace/events/filelock.h
@@ -27,7 +27,8 @@
 		{ FL_SLEEP,		"FL_SLEEP" },			\
 		{ FL_DOWNGRADE_PENDING,	"FL_DOWNGRADE_PENDING" },	\
 		{ FL_UNLOCK_PENDING,	"FL_UNLOCK_PENDING" },		\
-		{ FL_OFDLCK,		"FL_OFDLCK" })
+		{ FL_OFDLCK,		"FL_OFDLCK" },			\
+		{ FL_RECLAIM,		"FL_RECLAIM"})
 
 #define show_fl_type(val)				\
 	__print_symbolic(val,				\
diff --git a/include/uapi/linux/hidraw.h b/include/uapi/linux/hidraw.h
index d5ee269864e0..ebd701b3c18d 100644
--- a/include/uapi/linux/hidraw.h
+++ b/include/uapi/linux/hidraw.h
@@ -48,6 +48,8 @@ struct hidraw_devinfo {
 #define HIDIOCGOUTPUT(len)    _IOC(_IOC_WRITE|_IOC_READ, 'H', 0x0C, len)
 #define HIDIOCREVOKE	      _IOW('H', 0x0D, int) /* Revoke device access */
 
+#define HIDIOCTL_LAST		_IOC_NR(HIDIOCREVOKE)
+
 #define HIDRAW_FIRST_MINOR 0
 #define HIDRAW_MAX_DEVICES 64
 /* number of reports to buffer */
diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index c50d152e7b3e..9ac161866653 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 struct __kernel_timespec;
+struct __kernel_old_timeval;
 struct timezone;
 
 #if !defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)
diff --git a/init/Kconfig b/init/Kconfig
index 45990792cb4a..219ccdb0af73 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1440,6 +1440,7 @@ config BOOT_CONFIG_EMBED_FILE
 
 config INITRAMFS_PRESERVE_MTIME
 	bool "Preserve cpio archive mtimes in initramfs"
+	depends on BLK_DEV_INITRD
 	default y
 	help
 	  Each entry in an initramfs cpio archive carries an mtime value. When
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 2f7b5eeab845..ecaa358d0ad8 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -272,13 +272,14 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
 	if (!pid_child_should_wake(wo, p))
 		return 0;
 
+	list_del_init(&wait->entry);
+
 	/* cancel is in progress */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return 1;
 
 	req->io_task_work.func = io_waitid_cb;
 	io_req_task_work_add(req);
-	list_del_init(&wait->entry);
 	return 1;
 }
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1f51c8f20722..08bdb623f4f9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2326,6 +2326,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		map->owner->type  = prog_type;
 		map->owner->jited = fp->jited;
 		map->owner->xdp_has_frags = aux->xdp_has_frags;
+		map->owner->expected_attach_type = fp->expected_attach_type;
 		map->owner->attach_func_proto = aux->attach_func_proto;
 		for_each_cgroup_storage_type(i) {
 			map->owner->storage_cookie[i] =
@@ -2337,6 +2338,10 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 		ret = map->owner->type  == prog_type &&
 		      map->owner->jited == fp->jited &&
 		      map->owner->xdp_has_frags == aux->xdp_has_frags;
+		if (ret &&
+		    map->map_type == BPF_MAP_TYPE_PROG_ARRAY &&
+		    map->owner->expected_attach_type != fp->expected_attach_type)
+			ret = false;
 		for_each_cgroup_storage_type(i) {
 			if (!ret)
 				break;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1829f62a74a9..96640a80fd9c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14545,7 +14545,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	} else {	/* all other ALU ops: and, sub, xor, add, ... */
 
 		if (BPF_SRC(insn->code) == BPF_X) {
-			if (insn->imm != 0 || insn->off > 1 ||
+			if (insn->imm != 0 || (insn->off != 0 && insn->off != 1) ||
 			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
@@ -14555,7 +14555,7 @@ static int check_alu_op(struct bpf_verifier_env *env, struct bpf_insn *insn)
 			if (err)
 				return err;
 		} else {
-			if (insn->src_reg != BPF_REG_0 || insn->off > 1 ||
+			if (insn->src_reg != BPF_REG_0 || (insn->off != 0 && insn->off != 1) ||
 			    (insn->off == 1 && opcode != BPF_MOD && opcode != BPF_DIV)) {
 				verbose(env, "BPF_ALU uses reserved fields\n");
 				return -EINVAL;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e60f5e71e35d..c00981cc6fe5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -114,7 +114,7 @@ struct xol_area {
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
 {
-	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
+	pr_warn("uprobe: %s:%d failed to %s\n", t->comm, t->pid, msg);
 }
 
 /*
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 0cd1f8b5a102..267b00005eaf 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1124,7 +1124,7 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
 static bool should_sleep_killable(struct seccomp_filter *match,
 				  struct seccomp_knotif *n)
 {
-	return match->wait_killable_recv && n->state == SECCOMP_NOTIFY_SENT;
+	return match->wait_killable_recv && n->state >= SECCOMP_NOTIFY_SENT;
 }
 
 static int seccomp_do_user_notification(int this_syscall,
@@ -1171,13 +1171,11 @@ static int seccomp_do_user_notification(int this_syscall,
 
 		if (err != 0) {
 			/*
-			 * Check to see if the notifcation got picked up and
-			 * whether we should switch to wait killable.
+			 * Check to see whether we should switch to wait
+			 * killable. Only return the interrupted error if not.
 			 */
-			if (!wait_killable && should_sleep_killable(match, &n))
-				continue;
-
-			goto interrupted;
+			if (!(!wait_killable && should_sleep_killable(match, &n)))
+				goto interrupted;
 		}
 
 		addfd = list_first_entry_or_null(&n.addfd,
diff --git a/kernel/smp.c b/kernel/smp.c
index f25e20617b7e..fa6faf50fb43 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -891,16 +891,15 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
- *        (atomically) until function has completed on other CPUs. If
- *        %SCF_RUN_LOCAL is set, the function will also be run locally
- *        if the local CPU is set in the @cpumask.
- *
- * If @wait is true, then returns once @func has returned.
+ * @wait: If true, wait (atomically) until function has completed
+ *        on other CPUs.
  *
  * You must not call this function with disabled interrupts or from a
  * hardware interrupt handler or from a bottom half handler. Preemption
  * must be disabled when calling this function.
+ *
+ * @func is not called on the local CPU even if @mask contains it.  Consider
+ * using on_each_cpu_cond_mask() instead if this is not desirable.
  */
 void smp_call_function_many(const struct cpumask *mask,
 			    smp_call_func_t func, void *info, bool wait)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 3ec7df7dbeec..4a44451efbcc 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2759,19 +2759,24 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
 	struct bpf_run_ctx *old_run_ctx;
 	int err;
 
+	/*
+	 * graph tracer framework ensures we won't migrate, so there is no need
+	 * to use migrate_disable for bpf_prog_run again. The check here just for
+	 * __this_cpu_inc_return.
+	 */
+	cant_sleep();
+
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		bpf_prog_inc_misses_counter(link->link.prog);
 		err = 0;
 		goto out;
 	}
 
-	migrate_disable();
 	rcu_read_lock();
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.session_ctx.run_ctx);
 	err = bpf_prog_run(link->link.prog, regs);
 	bpf_reset_run_ctx(old_run_ctx);
 	rcu_read_unlock();
-	migrate_enable();
 
  out:
 	__this_cpu_dec(bpf_prog_active);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f116af53a939..fff6edb1174d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6886,6 +6886,8 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 						psize);
 		}
 		spin_unlock(ptl);
+
+		cond_resched();
 	}
 	/*
 	 * Must flush TLB before releasing i_mmap_rwsem: x86's huge_pmd_unshare
diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 6b694f117aef..468f7e8f0277 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -231,6 +231,8 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	struct f_usb9pfs *usb9pfs = ep->driver_data;
 	struct usb_composite_dev *cdev = usb9pfs->function.config->cdev;
 	struct p9_req_t *p9_rx_req;
+	unsigned int req_size = req->actual;
+	int status = REQ_STATUS_RCVD;
 
 	if (req->status) {
 		dev_err(&cdev->gadget->dev, "%s usb9pfs complete --> %d, %d/%d\n",
@@ -242,11 +244,19 @@ static void usb9pfs_rx_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!p9_rx_req)
 		return;
 
-	memcpy(p9_rx_req->rc.sdata, req->buf, req->actual);
+	if (req_size > p9_rx_req->rc.capacity) {
+		dev_err(&cdev->gadget->dev,
+			"%s received data size %u exceeds buffer capacity %zu\n",
+			ep->name, req_size, p9_rx_req->rc.capacity);
+		req_size = 0;
+		status = REQ_STATUS_ERROR;
+	}
+
+	memcpy(p9_rx_req->rc.sdata, req->buf, req_size);
 
-	p9_rx_req->rc.size = req->actual;
+	p9_rx_req->rc.size = req_size;
 
-	p9_client_cb(usb9pfs->client, p9_rx_req, REQ_STATUS_RCVD);
+	p9_client_cb(usb9pfs->client, p9_rx_req, status);
 	p9_req_put(usb9pfs->client, p9_rx_req);
 
 	complete(&usb9pfs->received);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 333f32a9fd21..853acfa8e943 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1325,7 +1325,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 {
 	struct hci_cp_le_set_ext_adv_params cp;
 	struct hci_rp_le_set_ext_adv_params rp;
-	bool connectable;
+	bool connectable, require_privacy;
 	u32 flags;
 	bdaddr_t random_addr;
 	u8 own_addr_type;
@@ -1363,10 +1363,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
 		return -EPERM;
 
 	/* Set require_privacy to true only when non-connectable
-	 * advertising is used. In that case it is fine to use a
-	 * non-resolvable private address.
+	 * advertising is used and it is not periodic.
+	 * In that case it is fine to use a non-resolvable private address.
 	 */
-	err = hci_get_random_address(hdev, !connectable,
+	require_privacy = !connectable && !(adv && adv->periodic);
+
+	err = hci_get_random_address(hdev, require_privacy,
 				     adv_use_rpa(hdev, flags), adv,
 				     &own_addr_type, &random_addr);
 	if (err < 0)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index a08a0f3d5003..2cd0b963c96b 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -111,6 +111,8 @@ static void iso_conn_free(struct kref *ref)
 	/* Ensure no more work items will run since hci_conn has been dropped */
 	disable_delayed_work_sync(&conn->timeout_work);
 
+	kfree_skb(conn->rx_skb);
+
 	kfree(conn);
 }
 
@@ -743,6 +745,13 @@ static void iso_sock_kill(struct sock *sk)
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
+	/* Sock is dead, so set conn->sk to NULL to avoid possible UAF */
+	if (iso_pi(sk)->conn) {
+		iso_conn_lock(iso_pi(sk)->conn);
+		iso_pi(sk)->conn->sk = NULL;
+		iso_conn_unlock(iso_pi(sk)->conn);
+	}
+
 	/* Kill poor orphan */
 	bt_sock_unlink(&iso_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
@@ -2295,7 +2304,7 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-		return;
+		break;
 
 	case ISO_END:
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8b75647076ba..563cae4f76b0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4412,13 +4412,11 @@ static int read_exp_features_info(struct sock *sk, struct hci_dev *hdev,
 		return -ENOMEM;
 
 #ifdef CONFIG_BT_FEATURE_DEBUG
-	if (!hdev) {
-		flags = bt_dbg_get() ? BIT(0) : 0;
+	flags = bt_dbg_get() ? BIT(0) : 0;
 
-		memcpy(rp->features[idx].uuid, debug_uuid, 16);
-		rp->features[idx].flags = cpu_to_le32(flags);
-		idx++;
-	}
+	memcpy(rp->features[idx].uuid, debug_uuid, 16);
+	rp->features[idx].flags = cpu_to_le32(flags);
+	idx++;
 #endif
 
 	if (hdev && hci_dev_le_state_simultaneous(hdev)) {
diff --git a/net/core/filter.c b/net/core/filter.c
index 02fedc404d7f..c850e5d6cbd8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9233,13 +9233,17 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
-	default:
-		if (type == BPF_READ) {
-			if (size != size_default)
-				return false;
-		} else {
+	case bpf_ctx_range(struct bpf_sock_addr, user_family):
+	case bpf_ctx_range(struct bpf_sock_addr, family):
+	case bpf_ctx_range(struct bpf_sock_addr, type):
+	case bpf_ctx_range(struct bpf_sock_addr, protocol):
+		if (type != BPF_READ)
 			return false;
-		}
+		if (size != size_default)
+			return false;
+		break;
+	default:
+		return false;
 	}
 
 	return true;
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 619ddc087957..37a3fa98d904 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -77,6 +77,7 @@ static inline struct hlist_head *ping_hashslot(struct ping_table *table,
 
 int ping_get_port(struct sock *sk, unsigned short ident)
 {
+	struct net *net = sock_net(sk);
 	struct inet_sock *isk, *isk2;
 	struct hlist_head *hlist;
 	struct sock *sk2 = NULL;
@@ -90,9 +91,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		for (i = 0; i < (1L << 16); i++, result++) {
 			if (!result)
 				result++; /* avoid zero */
-			hlist = ping_hashslot(&ping_table, sock_net(sk),
-					    result);
+			hlist = ping_hashslot(&ping_table, net, result);
 			sk_for_each(sk2, hlist) {
+				if (!net_eq(sock_net(sk2), net))
+					continue;
 				isk2 = inet_sk(sk2);
 
 				if (isk2->inet_num == result)
@@ -108,8 +110,10 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		if (i >= (1L << 16))
 			goto fail;
 	} else {
-		hlist = ping_hashslot(&ping_table, sock_net(sk), ident);
+		hlist = ping_hashslot(&ping_table, net, ident);
 		sk_for_each(sk2, hlist) {
+			if (!net_eq(sock_net(sk2), net))
+				continue;
 			isk2 = inet_sk(sk2);
 
 			/* BUG? Why is this reuse and not reuseaddr? ping.c
@@ -129,7 +133,7 @@ int ping_get_port(struct sock *sk, unsigned short ident)
 		pr_debug("was not hashed\n");
 		sk_add_node_rcu(sk, hlist);
 		sock_set_flag(sk, SOCK_RCU_FREE);
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
+		sock_prot_inuse_add(net, sk->sk_prot, 1);
 	}
 	spin_unlock(&ping_table.lock);
 	return 0;
@@ -188,6 +192,8 @@ static struct sock *ping_lookup(struct net *net, struct sk_buff *skb, u16 ident)
 	}
 
 	sk_for_each_rcu(sk, hslot) {
+		if (!net_eq(sock_net(sk), net))
+			continue;
 		isk = inet_sk(sk);
 
 		pr_debug("iterate\n");
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 988992ff898b..739931aabb4e 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3058,8 +3058,8 @@ bool tcp_check_oom(const struct sock *sk, int shift)
 
 void __tcp_close(struct sock *sk, long timeout)
 {
+	bool data_was_unread = false;
 	struct sk_buff *skb;
-	int data_was_unread = 0;
 	int state;
 
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
@@ -3078,11 +3078,12 @@ void __tcp_close(struct sock *sk, long timeout)
 	 *  reader process may not have drained the data yet!
 	 */
 	while ((skb = __skb_dequeue(&sk->sk_receive_queue)) != NULL) {
-		u32 len = TCP_SKB_CB(skb)->end_seq - TCP_SKB_CB(skb)->seq;
+		u32 end_seq = TCP_SKB_CB(skb)->end_seq;
 
 		if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
-			len--;
-		data_was_unread += len;
+			end_seq--;
+		if (after(end_seq, tcp_sk(sk)->copied_seq))
+			data_was_unread = true;
 		__kfree_skb(skb);
 	}
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 8c0d91dfd7e2..538c6eea645f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5280,12 +5280,20 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			}
 
 			rx.sdata = prev_sta->sdata;
+			if (!status->link_valid && prev_sta->sta.mlo) {
+				struct link_sta_info *link_sta;
+
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					continue;
+
+				link_id = link_sta->link_id;
+			}
+
 			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
-			if (!status->link_valid && prev_sta->sta.mlo)
-				continue;
-
 			ieee80211_prepare_and_rx_handle(&rx, skb, false);
 
 			prev_sta = sta;
@@ -5293,10 +5301,18 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 
 		if (prev_sta) {
 			rx.sdata = prev_sta->sdata;
-			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
-				goto out;
+			if (!status->link_valid && prev_sta->sta.mlo) {
+				struct link_sta_info *link_sta;
+
+				link_sta = link_sta_info_get_bss(rx.sdata,
+								 hdr->addr2);
+				if (!link_sta)
+					goto out;
 
-			if (!status->link_valid && prev_sta->sta.mlo)
+				link_id = link_sta->link_id;
+			}
+
+			if (!ieee80211_rx_data_set_sta(&rx, prev_sta, link_id))
 				goto out;
 
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 5251524b96af..5e4453e9ef8e 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -63,7 +63,7 @@ struct hbucket {
 		: jhash_size((htable_bits) - HTABLE_REGION_BITS))
 #define ahash_sizeof_regions(htable_bits)		\
 	(ahash_numof_locks(htable_bits) * sizeof(struct ip_set_region))
-#define ahash_region(n, htable_bits)		\
+#define ahash_region(n)		\
 	((n) / jhash_size(HTABLE_REGION_BITS))
 #define ahash_bucket_start(h,  htable_bits)	\
 	((htable_bits) < HTABLE_REGION_BITS ? 0	\
@@ -702,7 +702,7 @@ mtype_resize(struct ip_set *set, bool retried)
 #endif
 				key = HKEY(data, h->initval, htable_bits);
 				m = __ipset_dereference(hbucket(t, key));
-				nr = ahash_region(key, htable_bits);
+				nr = ahash_region(key);
 				if (!m) {
 					m = kzalloc(sizeof(*m) +
 					    AHASH_INIT_SIZE * dsize,
@@ -852,7 +852,7 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	rcu_read_lock_bh();
 	t = rcu_dereference_bh(h->table);
 	key = HKEY(value, h->initval, t->htable_bits);
-	r = ahash_region(key, t->htable_bits);
+	r = ahash_region(key);
 	atomic_inc(&t->uref);
 	elements = t->hregion[r].elements;
 	maxelem = t->maxelem;
@@ -1050,7 +1050,7 @@ mtype_del(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	rcu_read_lock_bh();
 	t = rcu_dereference_bh(h->table);
 	key = HKEY(value, h->initval, t->htable_bits);
-	r = ahash_region(key, t->htable_bits);
+	r = ahash_region(key);
 	atomic_inc(&t->uref);
 	rcu_read_unlock_bh();
 
diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index c0289f83f96d..327baa17882a 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -885,7 +885,7 @@ static void ip_vs_conn_expire(struct timer_list *t)
 			 * conntrack cleanup for the net.
 			 */
 			smp_rmb();
-			if (ipvs->enable)
+			if (READ_ONCE(ipvs->enable))
 				ip_vs_conn_drop_conntrack(cp);
 		}
 
@@ -1433,7 +1433,7 @@ void ip_vs_expire_nodest_conn_flush(struct netns_ipvs *ipvs)
 		cond_resched_rcu();
 
 		/* netns clean up started, abort delayed work */
-		if (!ipvs->enable)
+		if (!READ_ONCE(ipvs->enable))
 			break;
 	}
 	rcu_read_unlock();
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index c7a8a08b7308..5ea7ab8bf4dc 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1353,9 +1353,6 @@ ip_vs_out_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *stat
 	if (unlikely(!skb_dst(skb)))
 		return NF_ACCEPT;
 
-	if (!ipvs->enable)
-		return NF_ACCEPT;
-
 	ip_vs_fill_iph_skb(af, skb, false, &iph);
 #ifdef CONFIG_IP_VS_IPV6
 	if (af == AF_INET6) {
@@ -1940,7 +1937,7 @@ ip_vs_in_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *state
 		return NF_ACCEPT;
 	}
 	/* ipvs enabled in this netns ? */
-	if (unlikely(sysctl_backup_only(ipvs) || !ipvs->enable))
+	if (unlikely(sysctl_backup_only(ipvs)))
 		return NF_ACCEPT;
 
 	ip_vs_fill_iph_skb(af, skb, false, &iph);
@@ -2108,7 +2105,7 @@ ip_vs_forward_icmp(void *priv, struct sk_buff *skb,
 	int r;
 
 	/* ipvs enabled in this netns ? */
-	if (unlikely(sysctl_backup_only(ipvs) || !ipvs->enable))
+	if (unlikely(sysctl_backup_only(ipvs)))
 		return NF_ACCEPT;
 
 	if (state->pf == NFPROTO_IPV4) {
@@ -2295,7 +2292,7 @@ static int __net_init __ip_vs_init(struct net *net)
 		return -ENOMEM;
 
 	/* Hold the beast until a service is registered */
-	ipvs->enable = 0;
+	WRITE_ONCE(ipvs->enable, 0);
 	ipvs->net = net;
 	/* Counters used for creating unique names */
 	ipvs->gen = atomic_read(&ipvs_netns_cnt);
@@ -2367,7 +2364,7 @@ static void __net_exit __ip_vs_dev_cleanup_batch(struct list_head *net_list)
 		ipvs = net_ipvs(net);
 		ip_vs_unregister_hooks(ipvs, AF_INET);
 		ip_vs_unregister_hooks(ipvs, AF_INET6);
-		ipvs->enable = 0;	/* Disable packet reception */
+		WRITE_ONCE(ipvs->enable, 0);	/* Disable packet reception */
 		smp_wmb();
 		ip_vs_sync_net_cleanup(ipvs);
 	}
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 3224f6e17e73..3219338feca4 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -256,7 +256,7 @@ static void est_reload_work_handler(struct work_struct *work)
 		struct ip_vs_est_kt_data *kd = ipvs->est_kt_arr[id];
 
 		/* netns clean up started, abort delayed work */
-		if (!ipvs->enable)
+		if (!READ_ONCE(ipvs->enable))
 			goto unlock;
 		if (!kd)
 			continue;
@@ -1482,9 +1482,9 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 
 	*svc_p = svc;
 
-	if (!ipvs->enable) {
+	if (!READ_ONCE(ipvs->enable)) {
 		/* Now there is a service - full throttle */
-		ipvs->enable = 1;
+		WRITE_ONCE(ipvs->enable, 1);
 
 		/* Start estimation for first time */
 		ip_vs_est_reload_start(ipvs);
diff --git a/net/netfilter/ipvs/ip_vs_est.c b/net/netfilter/ipvs/ip_vs_est.c
index f821ad2e19b3..3492108bb3b9 100644
--- a/net/netfilter/ipvs/ip_vs_est.c
+++ b/net/netfilter/ipvs/ip_vs_est.c
@@ -231,7 +231,7 @@ static int ip_vs_estimation_kthread(void *data)
 void ip_vs_est_reload_start(struct netns_ipvs *ipvs)
 {
 	/* Ignore reloads before first service is added */
-	if (!ipvs->enable)
+	if (!READ_ONCE(ipvs->enable))
 		return;
 	ip_vs_est_stopped_recalc(ipvs);
 	/* Bump the kthread configuration genid */
@@ -305,7 +305,7 @@ static int ip_vs_est_add_kthread(struct netns_ipvs *ipvs)
 	int i;
 
 	if ((unsigned long)ipvs->est_kt_count >= ipvs->est_max_threads &&
-	    ipvs->enable && ipvs->est_max_threads)
+	    READ_ONCE(ipvs->enable) && ipvs->est_max_threads)
 		return -EINVAL;
 
 	mutex_lock(&ipvs->est_mutex);
@@ -342,7 +342,7 @@ static int ip_vs_est_add_kthread(struct netns_ipvs *ipvs)
 	}
 
 	/* Start kthread tasks only when services are present */
-	if (ipvs->enable && !ip_vs_est_stopped(ipvs)) {
+	if (READ_ONCE(ipvs->enable) && !ip_vs_est_stopped(ipvs)) {
 		ret = ip_vs_est_kthread_start(ipvs, kd);
 		if (ret < 0)
 			goto out;
@@ -485,7 +485,7 @@ int ip_vs_start_estimator(struct netns_ipvs *ipvs, struct ip_vs_stats *stats)
 	struct ip_vs_estimator *est = &stats->est;
 	int ret;
 
-	if (!ipvs->est_max_threads && ipvs->enable)
+	if (!ipvs->est_max_threads && READ_ONCE(ipvs->enable))
 		ipvs->est_max_threads = ip_vs_est_max_threads(ipvs);
 
 	est->ktid = -1;
@@ -662,7 +662,7 @@ static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
 			/* Wait for cpufreq frequency transition */
 			wait_event_idle_timeout(wq, kthread_should_stop(),
 						HZ / 50);
-			if (!ipvs->enable || kthread_should_stop())
+			if (!READ_ONCE(ipvs->enable) || kthread_should_stop())
 				goto stop;
 		}
 
@@ -680,7 +680,7 @@ static int ip_vs_est_calc_limits(struct netns_ipvs *ipvs, int *chain_max)
 		rcu_read_unlock();
 		local_bh_enable();
 
-		if (!ipvs->enable || kthread_should_stop())
+		if (!READ_ONCE(ipvs->enable) || kthread_should_stop())
 			goto stop;
 		cond_resched();
 
@@ -756,7 +756,7 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	mutex_lock(&ipvs->est_mutex);
 	for (id = 1; id < ipvs->est_kt_count; id++) {
 		/* netns clean up started, abort */
-		if (!ipvs->enable)
+		if (!READ_ONCE(ipvs->enable))
 			goto unlock2;
 		kd = ipvs->est_kt_arr[id];
 		if (!kd)
@@ -786,7 +786,7 @@ static void ip_vs_est_calc_phase(struct netns_ipvs *ipvs)
 	id = ipvs->est_kt_count;
 
 next_kt:
-	if (!ipvs->enable || kthread_should_stop())
+	if (!READ_ONCE(ipvs->enable) || kthread_should_stop())
 		goto unlock;
 	id--;
 	if (id < 0)
diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index d8a284999544..206c6700e200 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -53,6 +53,7 @@ enum {
 	IP_VS_FTP_EPSV,
 };
 
+static bool exiting_module;
 /*
  * List of ports (up to IP_VS_APP_MAX_PORTS) to be handled by helper
  * First port is set to the default port.
@@ -605,7 +606,7 @@ static void __ip_vs_ftp_exit(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
 
-	if (!ipvs)
+	if (!ipvs || !exiting_module)
 		return;
 
 	unregister_ip_vs_app(ipvs, &ip_vs_ftp);
@@ -627,6 +628,7 @@ static int __init ip_vs_ftp_init(void)
  */
 static void __exit ip_vs_ftp_exit(void)
 {
+	exiting_module = true;
 	unregister_pernet_subsys(&ip_vs_ftp_ops);
 	/* rcu_barrier() is called by netns */
 }
diff --git a/net/netfilter/nfnetlink.c b/net/netfilter/nfnetlink.c
index 7784ec094097..f12d0d229aaa 100644
--- a/net/netfilter/nfnetlink.c
+++ b/net/netfilter/nfnetlink.c
@@ -376,6 +376,7 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 	const struct nfnetlink_subsystem *ss;
 	const struct nfnl_callback *nc;
 	struct netlink_ext_ack extack;
+	struct nlmsghdr *onlh = nlh;
 	LIST_HEAD(err_list);
 	u32 status;
 	int err;
@@ -386,6 +387,7 @@ static void nfnetlink_rcv_batch(struct sk_buff *skb, struct nlmsghdr *nlh,
 	status = 0;
 replay_abort:
 	skb = netlink_skb_clone(oskb, GFP_KERNEL);
+	nlh = onlh;
 	if (!skb)
 		return netlink_ack(oskb, nlh, -ENOMEM, NULL);
 
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 994a0a1efb58..cb2a672105dc 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -27,11 +27,16 @@
 
 /* Handle NCI Notification packets */
 
-static void nci_core_reset_ntf_packet(struct nci_dev *ndev,
-				      const struct sk_buff *skb)
+static int nci_core_reset_ntf_packet(struct nci_dev *ndev,
+				     const struct sk_buff *skb)
 {
 	/* Handle NCI 2.x core reset notification */
-	const struct nci_core_reset_ntf *ntf = (void *)skb->data;
+	const struct nci_core_reset_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_core_reset_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_reset_ntf *)skb->data;
 
 	ndev->nci_ver = ntf->nci_ver;
 	pr_debug("nci_ver 0x%x, config_status 0x%x\n",
@@ -42,15 +47,22 @@ static void nci_core_reset_ntf_packet(struct nci_dev *ndev,
 		__le32_to_cpu(ntf->manufact_specific_info);
 
 	nci_req_complete(ndev, NCI_STATUS_OK);
+
+	return 0;
 }
 
-static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
-					     struct sk_buff *skb)
+static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
+					    struct sk_buff *skb)
 {
-	struct nci_core_conn_credit_ntf *ntf = (void *) skb->data;
+	struct nci_core_conn_credit_ntf *ntf;
 	struct nci_conn_info *conn_info;
 	int i;
 
+	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_conn_credit_ntf *)skb->data;
+
 	pr_debug("num_entries %d\n", ntf->num_entries);
 
 	if (ntf->num_entries > NCI_MAX_NUM_CONN)
@@ -68,7 +80,7 @@ static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 		conn_info = nci_get_conn_info_by_conn_id(ndev,
 							 ntf->conn_entries[i].conn_id);
 		if (!conn_info)
-			return;
+			return 0;
 
 		atomic_add(ntf->conn_entries[i].credits,
 			   &conn_info->credits_cnt);
@@ -77,12 +89,19 @@ static void nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 	/* trigger the next tx */
 	if (!skb_queue_empty(&ndev->tx_q))
 		queue_work(ndev->tx_wq, &ndev->tx_work);
+
+	return 0;
 }
 
-static void nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
-					      const struct sk_buff *skb)
+static int nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
+					     const struct sk_buff *skb)
 {
-	__u8 status = skb->data[0];
+	__u8 status;
+
+	if (skb->len < 1)
+		return -EINVAL;
+
+	status = skb->data[0];
 
 	pr_debug("status 0x%x\n", status);
 
@@ -91,12 +110,19 @@ static void nci_core_generic_error_ntf_packet(struct nci_dev *ndev,
 		   (the state remains the same) */
 		nci_req_complete(ndev, status);
 	}
+
+	return 0;
 }
 
-static void nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
-						struct sk_buff *skb)
+static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
+					       struct sk_buff *skb)
 {
-	struct nci_core_intf_error_ntf *ntf = (void *) skb->data;
+	struct nci_core_intf_error_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_core_intf_error_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_core_intf_error_ntf *)skb->data;
 
 	ntf->conn_id = nci_conn_id(&ntf->conn_id);
 
@@ -105,6 +131,8 @@ static void nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
 	/* complete the data exchange transaction, if exists */
 	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
 		nci_data_exchange_complete(ndev, NULL, ntf->conn_id, -EIO);
+
+	return 0;
 }
 
 static const __u8 *
@@ -329,13 +357,18 @@ void nci_clear_target_list(struct nci_dev *ndev)
 	ndev->n_targets = 0;
 }
 
-static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
-				       const struct sk_buff *skb)
+static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
+				      const struct sk_buff *skb)
 {
 	struct nci_rf_discover_ntf ntf;
-	const __u8 *data = skb->data;
+	const __u8 *data;
 	bool add_target = true;
 
+	if (skb->len < sizeof(struct nci_rf_discover_ntf))
+		return -EINVAL;
+
+	data = skb->data;
+
 	ntf.rf_discovery_id = *data++;
 	ntf.rf_protocol = *data++;
 	ntf.rf_tech_and_mode = *data++;
@@ -390,6 +423,8 @@ static void nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 		nfc_targets_found(ndev->nfc_dev, ndev->targets,
 				  ndev->n_targets);
 	}
+
+	return 0;
 }
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
@@ -531,14 +566,19 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	return NCI_STATUS_OK;
 }
 
-static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
-					     const struct sk_buff *skb)
+static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
+					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
 	struct nci_rf_intf_activated_ntf ntf;
-	const __u8 *data = skb->data;
+	const __u8 *data;
 	int err = NCI_STATUS_OK;
 
+	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+		return -EINVAL;
+
+	data = skb->data;
+
 	ntf.rf_discovery_id = *data++;
 	ntf.rf_interface = *data++;
 	ntf.rf_protocol = *data++;
@@ -645,7 +685,7 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 	if (err == NCI_STATUS_OK) {
 		conn_info = ndev->rf_conn_info;
 		if (!conn_info)
-			return;
+			return 0;
 
 		conn_info->max_pkt_payload_len = ntf.max_data_pkt_payload_size;
 		conn_info->initial_num_credits = ntf.initial_num_credits;
@@ -691,19 +731,26 @@ static void nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 				pr_err("error when signaling tm activation\n");
 		}
 	}
+
+	return 0;
 }
 
-static void nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
-					 const struct sk_buff *skb)
+static int nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
+					const struct sk_buff *skb)
 {
 	const struct nci_conn_info *conn_info;
-	const struct nci_rf_deactivate_ntf *ntf = (void *)skb->data;
+	const struct nci_rf_deactivate_ntf *ntf;
+
+	if (skb->len < sizeof(struct nci_rf_deactivate_ntf))
+		return -EINVAL;
+
+	ntf = (struct nci_rf_deactivate_ntf *)skb->data;
 
 	pr_debug("entry, type 0x%x, reason 0x%x\n", ntf->type, ntf->reason);
 
 	conn_info = ndev->rf_conn_info;
 	if (!conn_info)
-		return;
+		return 0;
 
 	/* drop tx data queue */
 	skb_queue_purge(&ndev->tx_q);
@@ -735,14 +782,20 @@ static void nci_rf_deactivate_ntf_packet(struct nci_dev *ndev,
 	}
 
 	nci_req_complete(ndev, NCI_STATUS_OK);
+
+	return 0;
 }
 
-static void nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
-					  const struct sk_buff *skb)
+static int nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
+					 const struct sk_buff *skb)
 {
 	u8 status = NCI_STATUS_OK;
-	const struct nci_nfcee_discover_ntf *nfcee_ntf =
-				(struct nci_nfcee_discover_ntf *)skb->data;
+	const struct nci_nfcee_discover_ntf *nfcee_ntf;
+
+	if (skb->len < sizeof(struct nci_nfcee_discover_ntf))
+		return -EINVAL;
+
+	nfcee_ntf = (struct nci_nfcee_discover_ntf *)skb->data;
 
 	/* NFCForum NCI 9.2.1 HCI Network Specific Handling
 	 * If the NFCC supports the HCI Network, it SHALL return one,
@@ -753,6 +806,8 @@ static void nci_nfcee_discover_ntf_packet(struct nci_dev *ndev,
 	ndev->cur_params.id = nfcee_ntf->nfcee_id;
 
 	nci_req_complete(ndev, status);
+
+	return 0;
 }
 
 void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
@@ -779,35 +834,43 @@ void nci_ntf_packet(struct nci_dev *ndev, struct sk_buff *skb)
 
 	switch (ntf_opcode) {
 	case NCI_OP_CORE_RESET_NTF:
-		nci_core_reset_ntf_packet(ndev, skb);
+		if (nci_core_reset_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_CONN_CREDITS_NTF:
-		nci_core_conn_credits_ntf_packet(ndev, skb);
+		if (nci_core_conn_credits_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_GENERIC_ERROR_NTF:
-		nci_core_generic_error_ntf_packet(ndev, skb);
+		if (nci_core_generic_error_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_CORE_INTF_ERROR_NTF:
-		nci_core_conn_intf_error_ntf_packet(ndev, skb);
+		if (nci_core_conn_intf_error_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_DISCOVER_NTF:
-		nci_rf_discover_ntf_packet(ndev, skb);
+		if (nci_rf_discover_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_INTF_ACTIVATED_NTF:
-		nci_rf_intf_activated_ntf_packet(ndev, skb);
+		if (nci_rf_intf_activated_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_DEACTIVATE_NTF:
-		nci_rf_deactivate_ntf_packet(ndev, skb);
+		if (nci_rf_deactivate_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_NFCEE_DISCOVER_NTF:
-		nci_nfcee_discover_ntf_packet(ndev, skb);
+		if (nci_nfcee_discover_ntf_packet(ndev, skb))
+			goto end;
 		break;
 
 	case NCI_OP_RF_NFCEE_ACTION_NTF:
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 73a90ad873fb..2d5ac2b3d526 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -724,7 +724,7 @@ svcauth_gss_verify_header(struct svc_rqst *rqstp, struct rsc *rsci,
 		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}
-	if (flavor != RPC_AUTH_GSS) {
+	if (flavor != RPC_AUTH_GSS || checksum.len < XDR_UNIT) {
 		rqstp->rq_auth_stat = rpc_autherr_badverf;
 		return SVC_DENIED;
 	}
diff --git a/security/Kconfig b/security/Kconfig
index 28e685f53bd1..ce9f1a651ccc 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -264,6 +264,7 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
+	depends on SECURITY
 	default "landlock,lockdown,yama,loadpin,safesetid,smack,selinux,tomoyo,apparmor,ipe,bpf" if DEFAULT_SECURITY_SMACK
 	default "landlock,lockdown,yama,loadpin,safesetid,apparmor,selinux,smack,tomoyo,ipe,bpf" if DEFAULT_SECURITY_APPARMOR
 	default "landlock,lockdown,yama,loadpin,safesetid,tomoyo,ipe,bpf" if DEFAULT_SECURITY_TOMOYO
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9b91f68b3fff..d15de21f6ebf 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -84,19 +84,24 @@ void snd_pcm_group_init(struct snd_pcm_group *group)
 }
 
 /* define group lock helpers */
-#define DEFINE_PCM_GROUP_LOCK(action, mutex_action) \
+#define DEFINE_PCM_GROUP_LOCK(action, bh_lock, bh_unlock, mutex_action) \
 static void snd_pcm_group_ ## action(struct snd_pcm_group *group, bool nonatomic) \
 { \
-	if (nonatomic) \
+	if (nonatomic) { \
 		mutex_ ## mutex_action(&group->mutex); \
-	else \
-		spin_ ## action(&group->lock); \
-}
-
-DEFINE_PCM_GROUP_LOCK(lock, lock);
-DEFINE_PCM_GROUP_LOCK(unlock, unlock);
-DEFINE_PCM_GROUP_LOCK(lock_irq, lock);
-DEFINE_PCM_GROUP_LOCK(unlock_irq, unlock);
+	} else { \
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_lock)   \
+			local_bh_disable();			\
+		spin_ ## action(&group->lock);			\
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && bh_unlock) \
+			local_bh_enable();                      \
+	}							\
+}
+
+DEFINE_PCM_GROUP_LOCK(lock, false, false, lock);
+DEFINE_PCM_GROUP_LOCK(unlock, false, false, unlock);
+DEFINE_PCM_GROUP_LOCK(lock_irq, true, false, lock);
+DEFINE_PCM_GROUP_LOCK(unlock_irq, false, true, unlock);
 
 /**
  * snd_pcm_stream_lock - Lock the PCM stream
diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 9d95ecb299ae..a99acd1125e7 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -316,7 +316,7 @@ static int lx_message_send_atomic(struct lx6464es *chip, struct lx_rmh *rmh)
 /* low-level dsp access */
 int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 {
-	u16 ret;
+	int ret;
 
 	mutex_lock(&chip->msg_lock);
 
@@ -330,10 +330,10 @@ int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 
 int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq)
 {
-	u16 ret = 0;
 	u32 freq_raw = 0;
 	u32 freq = 0;
 	u32 frequency = 0;
+	int ret;
 
 	mutex_lock(&chip->msg_lock);
 
diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index c7f1b28f3b23..01f8d1296b18 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -5845,6 +5845,13 @@ static const struct snd_soc_component_driver wcd934x_component_drv = {
 	.endianness = 1,
 };
 
+static void wcd934x_put_device_action(void *data)
+{
+	struct device *dev = data;
+
+	put_device(dev);
+}
+
 static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 {
 	struct device *dev = &wcd->sdev->dev;
@@ -5861,11 +5868,13 @@ static int wcd934x_codec_parse_data(struct wcd934x_codec *wcd)
 		return dev_err_probe(dev, -EINVAL, "Unable to get SLIM Interface device\n");
 
 	slim_get_logical_addr(wcd->sidev);
-	wcd->if_regmap = regmap_init_slimbus(wcd->sidev,
+	wcd->if_regmap = devm_regmap_init_slimbus(wcd->sidev,
 				  &wcd934x_ifc_regmap_config);
-	if (IS_ERR(wcd->if_regmap))
+	if (IS_ERR(wcd->if_regmap)) {
+		put_device(&wcd->sidev->dev);
 		return dev_err_probe(dev, PTR_ERR(wcd->if_regmap),
 				     "Failed to allocate ifc register map\n");
+	}
 
 	of_property_read_u32(dev->parent->of_node, "qcom,dmic-sample-rate",
 			     &wcd->dmic_sample_rate);
@@ -5907,6 +5916,10 @@ static int wcd934x_codec_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, wcd934x_put_device_action, &wcd->sidev->dev);
+	if (ret)
+		return ret;
+
 	/* set default rate 9P6MHz */
 	regmap_update_bits(wcd->regmap, WCD934X_CODEC_RPM_CLK_MCLK_CFG,
 			   WCD934X_CODEC_RPM_CLK_MCLK_CFG_MCLK_MASK,
diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
index 1df827a084ca..17ddd91eac5f 100644
--- a/sound/soc/codecs/wcd937x.c
+++ b/sound/soc/codecs/wcd937x.c
@@ -2039,9 +2039,9 @@ static const struct snd_kcontrol_new wcd937x_snd_controls[] = {
 	SOC_ENUM_EXT("RX HPH Mode", rx_hph_mode_mux_enum,
 		     wcd937x_rx_hph_mode_get, wcd937x_rx_hph_mode_put),
 
-	SOC_SINGLE_EXT("HPHL_COMP Switch", SND_SOC_NOPM, 0, 1, 0,
+	SOC_SINGLE_EXT("HPHL_COMP Switch", WCD937X_COMP_L, 0, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
-	SOC_SINGLE_EXT("HPHR_COMP Switch", SND_SOC_NOPM, 1, 1, 0,
+	SOC_SINGLE_EXT("HPHR_COMP Switch", WCD937X_COMP_R, 1, 1, 0,
 		       wcd937x_get_compander, wcd937x_set_compander),
 
 	SOC_SINGLE_TLV("HPHL Volume", WCD937X_HPH_L_EN, 0, 20, 1, line_gain),
diff --git a/sound/soc/codecs/wcd937x.h b/sound/soc/codecs/wcd937x.h
index 4afa48dcaf74..7bfd0f630fcd 100644
--- a/sound/soc/codecs/wcd937x.h
+++ b/sound/soc/codecs/wcd937x.h
@@ -548,21 +548,21 @@ int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
 struct device *wcd937x_sdw_device_get(struct device_node *np);
 
 #else
-int wcd937x_sdw_free(struct wcd937x_sdw_priv *wcd,
+static inline int wcd937x_sdw_free(struct wcd937x_sdw_priv *wcd,
 		     struct snd_pcm_substream *substream,
 		     struct snd_soc_dai *dai)
 {
 	return -EOPNOTSUPP;
 }
 
-int wcd937x_sdw_set_sdw_stream(struct wcd937x_sdw_priv *wcd,
+static inline int wcd937x_sdw_set_sdw_stream(struct wcd937x_sdw_priv *wcd,
 			       struct snd_soc_dai *dai,
 			       void *stream, int direction)
 {
 	return -EOPNOTSUPP;
 }
 
-int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
+static inline int wcd937x_sdw_hw_params(struct wcd937x_sdw_priv *wcd,
 			  struct snd_pcm_substream *substream,
 			  struct snd_pcm_hw_params *params,
 			  struct snd_soc_dai *dai)
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index d3327bc237b5..7975dc0ceb35 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -47,7 +47,8 @@ enum {
 	BYT_CHT_ES8316_INTMIC_IN2_MAP,
 };
 
-#define BYT_CHT_ES8316_MAP(quirk)		((quirk) & GENMASK(3, 0))
+#define BYT_CHT_ES8316_MAP_MASK			GENMASK(3, 0)
+#define BYT_CHT_ES8316_MAP(quirk)		((quirk) & BYT_CHT_ES8316_MAP_MASK)
 #define BYT_CHT_ES8316_SSP0			BIT(16)
 #define BYT_CHT_ES8316_MONO_SPEAKER		BIT(17)
 #define BYT_CHT_ES8316_JD_INVERTED		BIT(18)
@@ -60,10 +61,23 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
-	if (BYT_CHT_ES8316_MAP(quirk) == BYT_CHT_ES8316_INTMIC_IN1_MAP)
+	int map;
+
+	map = BYT_CHT_ES8316_MAP(quirk);
+	switch (map) {
+	case BYT_CHT_ES8316_INTMIC_IN1_MAP:
 		dev_info(dev, "quirk IN1_MAP enabled");
-	if (BYT_CHT_ES8316_MAP(quirk) == BYT_CHT_ES8316_INTMIC_IN2_MAP)
+		break;
+	case BYT_CHT_ES8316_INTMIC_IN2_MAP:
 		dev_info(dev, "quirk IN2_MAP enabled");
+		break;
+	default:
+		dev_warn_once(dev, "quirk sets invalid input map: 0x%x, default to INTMIC_IN1_MAP\n", map);
+		quirk &= ~BYT_CHT_ES8316_MAP_MASK;
+		quirk |= BYT_CHT_ES8316_INTMIC_IN1_MAP;
+		break;
+	}
+
 	if (quirk & BYT_CHT_ES8316_SSP0)
 		dev_info(dev, "quirk SSP0 enabled");
 	if (quirk & BYT_CHT_ES8316_MONO_SPEAKER)
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index b6434b473126..d6991864c5a4 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -68,7 +68,8 @@ enum {
 	BYT_RT5640_OVCD_SF_1P5		= (RT5640_OVCD_SF_1P5 << 13),
 };
 
-#define BYT_RT5640_MAP(quirk)		((quirk) &  GENMASK(3, 0))
+#define BYT_RT5640_MAP_MASK		GENMASK(3, 0)
+#define BYT_RT5640_MAP(quirk)		((quirk) & BYT_RT5640_MAP_MASK)
 #define BYT_RT5640_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
 #define BYT_RT5640_OVCD_TH(quirk)	(((quirk) & GENMASK(12, 8)) >> 8)
 #define BYT_RT5640_OVCD_SF(quirk)	(((quirk) & GENMASK(14, 13)) >> 13)
@@ -140,7 +141,9 @@ static void log_quirks(struct device *dev)
 		dev_info(dev, "quirk NO_INTERNAL_MIC_MAP enabled\n");
 		break;
 	default:
-		dev_err(dev, "quirk map 0x%x is not supported, microphone input will not work\n", map);
+		dev_warn_once(dev, "quirk sets invalid input map: 0x%x, default to DMIC1_MAP\n", map);
+		byt_rt5640_quirk &= ~BYT_RT5640_MAP_MASK;
+		byt_rt5640_quirk |= BYT_RT5640_DMIC1_MAP;
 		break;
 	}
 	if (byt_rt5640_quirk & BYT_RT5640_HSMIC2_ON_IN1)
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 8e4b821efe92..6860ac41e6b3 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -58,7 +58,8 @@ enum {
 	BYT_RT5651_OVCD_SF_1P5	= (RT5651_OVCD_SF_1P5 << 13),
 };
 
-#define BYT_RT5651_MAP(quirk)		((quirk) & GENMASK(3, 0))
+#define BYT_RT5651_MAP_MASK		GENMASK(3, 0)
+#define BYT_RT5651_MAP(quirk)		((quirk) & BYT_RT5651_MAP_MASK)
 #define BYT_RT5651_JDSRC(quirk)		(((quirk) & GENMASK(7, 4)) >> 4)
 #define BYT_RT5651_OVCD_TH(quirk)	(((quirk) & GENMASK(12, 8)) >> 8)
 #define BYT_RT5651_OVCD_SF(quirk)	(((quirk) & GENMASK(14, 13)) >> 13)
@@ -100,14 +101,29 @@ MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 static void log_quirks(struct device *dev)
 {
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_DMIC_MAP)
+	int map;
+
+	map = BYT_RT5651_MAP(byt_rt5651_quirk);
+	switch (map) {
+	case BYT_RT5651_DMIC_MAP:
 		dev_info(dev, "quirk DMIC_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_MAP)
+		break;
+	case BYT_RT5651_IN1_MAP:
 		dev_info(dev, "quirk IN1_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
+		break;
+	case BYT_RT5651_IN2_MAP:
 		dev_info(dev, "quirk IN2_MAP enabled");
-	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_IN2_MAP)
+		break;
+	case BYT_RT5651_IN1_IN2_MAP:
 		dev_info(dev, "quirk IN1_IN2_MAP enabled");
+		break;
+	default:
+		dev_warn_once(dev, "quirk sets invalid input map: 0x%x, default to DMIC_MAP\n", map);
+		byt_rt5651_quirk &= ~BYT_RT5651_MAP_MASK;
+		byt_rt5651_quirk |= BYT_RT5651_DMIC_MAP;
+		break;
+	}
+
 	if (BYT_RT5651_JDSRC(byt_rt5651_quirk)) {
 		dev_info(dev, "quirk realtek,jack-detect-source %ld\n",
 			 BYT_RT5651_JDSRC(byt_rt5651_quirk));
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 5911a0558651..00d840d5e585 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -741,7 +741,7 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 			(*codec_conf)++;
 		}
 
-		if (sof_end->include_sidecar) {
+		if (sof_end->include_sidecar && sof_end->codec_info->add_sidecar) {
 			ret = sof_end->codec_info->add_sidecar(card, dai_links, codec_conf);
 			if (ret)
 				return ret;
diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index e98b53b67d12..19bbae725d83 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2485,11 +2485,6 @@ static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verif
 	if (ret < 0)
 		return ret;
 
-	/* free all the scheduler widgets now */
-	ret = sof_ipc3_free_widgets_in_list(sdev, true, &dyn_widgets, verify);
-	if (ret < 0)
-		return ret;
-
 	/*
 	 * Tear down all pipelines associated with PCMs that did not get suspended
 	 * and unset the prepare flag so that they can be set up again during resume.
@@ -2505,6 +2500,11 @@ static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verif
 		}
 	}
 
+	/* free all the scheduler widgets now. This will also power down the secondary cores */
+	ret = sof_ipc3_free_widgets_in_list(sdev, true, &dyn_widgets, verify);
+	if (ret < 0)
+		return ret;
+
 	list_for_each_entry(sroute, &sdev->route_list, list)
 		sroute->setup = false;
 
diff --git a/tools/include/nolibc/std.h b/tools/include/nolibc/std.h
index a9d8b5b51f37..f24953f8b949 100644
--- a/tools/include/nolibc/std.h
+++ b/tools/include/nolibc/std.h
@@ -33,6 +33,6 @@ typedef unsigned long       nlink_t;
 typedef   signed long         off_t;
 typedef   signed long     blksize_t;
 typedef   signed long      blkcnt_t;
-typedef __kernel_old_time_t  time_t;
+typedef __kernel_time_t      time_t;
 
 #endif /* _NOLIBC_STD_H */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e33cf3caf8b6..060aecf60b76 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -990,35 +990,33 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 	const struct btf_member *kern_data_member;
 	struct btf *btf = NULL;
 	__s32 kern_vtype_id, kern_type_id;
-	char tname[256];
+	char tname[192], stname[256];
 	__u32 i;
 
 	snprintf(tname, sizeof(tname), "%.*s",
 		 (int)bpf_core_essential_name_len(tname_raw), tname_raw);
 
-	kern_type_id = find_ksym_btf_id(obj, tname, BTF_KIND_STRUCT,
-					&btf, mod_btf);
-	if (kern_type_id < 0) {
-		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n",
-			tname);
-		return kern_type_id;
-	}
-	kern_type = btf__type_by_id(btf, kern_type_id);
+	snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname);
 
-	/* Find the corresponding "map_value" type that will be used
-	 * in map_update(BPF_MAP_TYPE_STRUCT_OPS).  For example,
-	 * find "struct bpf_struct_ops_tcp_congestion_ops" from the
-	 * btf_vmlinux.
+	/* Look for the corresponding "map_value" type that will be used
+	 * in map_update(BPF_MAP_TYPE_STRUCT_OPS) first, figure out the btf
+	 * and the mod_btf.
+	 * For example, find "struct bpf_struct_ops_tcp_congestion_ops".
 	 */
-	kern_vtype_id = find_btf_by_prefix_kind(btf, STRUCT_OPS_VALUE_PREFIX,
-						tname, BTF_KIND_STRUCT);
+	kern_vtype_id = find_ksym_btf_id(obj, stname, BTF_KIND_STRUCT, &btf, mod_btf);
 	if (kern_vtype_id < 0) {
-		pr_warn("struct_ops init_kern: struct %s%s is not found in kernel BTF\n",
-			STRUCT_OPS_VALUE_PREFIX, tname);
+		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n", stname);
 		return kern_vtype_id;
 	}
 	kern_vtype = btf__type_by_id(btf, kern_vtype_id);
 
+	kern_type_id = btf__find_by_name_kind(btf, tname, BTF_KIND_STRUCT);
+	if (kern_type_id < 0) {
+		pr_warn("struct_ops init_kern: struct %s is not found in kernel BTF\n", tname);
+		return kern_type_id;
+	}
+	kern_type = btf__type_by_id(btf, kern_type_id);
+
 	/* Find "struct tcp_congestion_ops" from
 	 * struct bpf_struct_ops_tcp_congestion_ops {
 	 *	[ ... ]
@@ -1031,8 +1029,8 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
 			break;
 	}
 	if (i == btf_vlen(kern_vtype)) {
-		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s%s\n",
-			tname, STRUCT_OPS_VALUE_PREFIX, tname);
+		pr_warn("struct_ops init_kern: struct %s data is not found in struct %s\n",
+			tname, stname);
 		return -EINVAL;
 	}
 
@@ -5056,6 +5054,16 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 		return false;
 	}
 
+	/*
+	 * bpf_get_map_info_by_fd() for DEVMAP will always return flags with
+	 * BPF_F_RDONLY_PROG set, but it generally is not set at map creation time.
+	 * Thus, ignore the BPF_F_RDONLY_PROG flag in the flags returned from
+	 * bpf_get_map_info_by_fd() when checking for compatibility with an
+	 * existing DEVMAP.
+	 */
+	if (map->def.type == BPF_MAP_TYPE_DEVMAP || map->def.type == BPF_MAP_TYPE_DEVMAP_HASH)
+		map_info.map_flags &= ~BPF_F_RDONLY_PROG;
+
 	return (map_info.type == map->def.type &&
 		map_info.key_size == map->def.key_size &&
 		map_info.value_size == map->def.value_size &&
diff --git a/tools/testing/nvdimm/test/ndtest.c b/tools/testing/nvdimm/test/ndtest.c
index 892e990c034a..22ee6309c53c 100644
--- a/tools/testing/nvdimm/test/ndtest.c
+++ b/tools/testing/nvdimm/test/ndtest.c
@@ -850,11 +850,22 @@ static int ndtest_probe(struct platform_device *pdev)
 
 	p->dcr_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				 sizeof(dma_addr_t), GFP_KERNEL);
+	if (!p->dcr_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	p->label_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				   sizeof(dma_addr_t), GFP_KERNEL);
+	if (!p->label_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	p->dimm_dma = devm_kcalloc(&p->pdev.dev, NUM_DCR,
 				  sizeof(dma_addr_t), GFP_KERNEL);
-
+	if (!p->dimm_dma) {
+		rc = -ENOMEM;
+		goto err;
+	}
 	rc = ndtest_nvdimm_init(p);
 	if (rc)
 		goto err;
diff --git a/tools/testing/selftests/arm64/pauth/exec_target.c b/tools/testing/selftests/arm64/pauth/exec_target.c
index 4435600ca400..e597861b26d6 100644
--- a/tools/testing/selftests/arm64/pauth/exec_target.c
+++ b/tools/testing/selftests/arm64/pauth/exec_target.c
@@ -13,7 +13,12 @@ int main(void)
 	unsigned long hwcaps;
 	size_t val;
 
-	fread(&val, sizeof(size_t), 1, stdin);
+	size_t size = fread(&val, sizeof(size_t), 1, stdin);
+
+	if (size != 1) {
+		fprintf(stderr, "Could not read input from stdin\n");
+		return EXIT_FAILURE;
+	}
 
 	/* don't try to execute illegal (unimplemented) instructions) caller
 	 * should have checked this and keep worker simple
diff --git a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
index 540181c115a8..ef00d38b0a8d 100644
--- a/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tcpnotify_kern.c
@@ -23,7 +23,6 @@ struct {
 
 struct {
 	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
-	__uint(max_entries, 2);
 	__type(key, int);
 	__type(value, __u32);
 } perf_event_map SEC(".maps");
diff --git a/tools/testing/selftests/bpf/test_tcpnotify_user.c b/tools/testing/selftests/bpf/test_tcpnotify_user.c
index 595194453ff8..35b4893ccdf8 100644
--- a/tools/testing/selftests/bpf/test_tcpnotify_user.c
+++ b/tools/testing/selftests/bpf/test_tcpnotify_user.c
@@ -15,20 +15,18 @@
 #include <bpf/libbpf.h>
 #include <sys/ioctl.h>
 #include <linux/rtnetlink.h>
-#include <signal.h>
 #include <linux/perf_event.h>
-#include <linux/err.h>
 
-#include "bpf_util.h"
 #include "cgroup_helpers.h"
 
 #include "test_tcpnotify.h"
-#include "trace_helpers.h"
 #include "testing_helpers.h"
 
 #define SOCKET_BUFFER_SIZE (getpagesize() < 8192L ? getpagesize() : 8192L)
 
 pthread_t tid;
+static bool exit_thread;
+
 int rx_callbacks;
 
 static void dummyfn(void *ctx, int cpu, void *data, __u32 size)
@@ -45,7 +43,7 @@ void tcp_notifier_poller(struct perf_buffer *pb)
 {
 	int err;
 
-	while (1) {
+	while (!exit_thread) {
 		err = perf_buffer__poll(pb, 100);
 		if (err < 0 && err != -EINTR) {
 			printf("failed perf_buffer__poll: %d\n", err);
@@ -78,15 +76,10 @@ int main(int argc, char **argv)
 	int error = EXIT_FAILURE;
 	struct bpf_object *obj;
 	char test_script[80];
-	cpu_set_t cpuset;
 	__u32 key = 0;
 
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 
-	CPU_ZERO(&cpuset);
-	CPU_SET(0, &cpuset);
-	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpuset);
-
 	cg_fd = cgroup_setup_and_join(cg_path);
 	if (cg_fd < 0)
 		goto err;
@@ -151,6 +144,13 @@ int main(int argc, char **argv)
 
 	sleep(10);
 
+	exit_thread = true;
+	int ret = pthread_join(tid, NULL);
+	if (ret) {
+		printf("FAILED: pthread_join\n");
+		goto err;
+	}
+
 	if (verify_result(&g)) {
 		printf("FAILED: Wrong stats Expected %d calls, got %d\n",
 			g.ncalls, rx_callbacks);
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 6fba7025c5e3..d73bff23c61e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -196,8 +196,8 @@ int expect_zr(int expr, int llen)
 }
 
 
-#define EXPECT_NZ(cond, expr, val)			\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
+#define EXPECT_NZ(cond, expr)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen); } while (0)
 
 static __attribute__((unused))
 int expect_nz(int expr, int llen)
diff --git a/tools/testing/selftests/vDSO/vdso_call.h b/tools/testing/selftests/vDSO/vdso_call.h
index bb237d771051..e7205584cbdc 100644
--- a/tools/testing/selftests/vDSO/vdso_call.h
+++ b/tools/testing/selftests/vDSO/vdso_call.h
@@ -44,7 +44,6 @@
 	register long _r6 asm ("r6");					\
 	register long _r7 asm ("r7");					\
 	register long _r8 asm ("r8");					\
-	register long _rval asm ("r3");					\
 									\
 	LOADARGS_##nr(fn, args);					\
 									\
@@ -54,13 +53,13 @@
 		"	bns+	1f\n"					\
 		"	neg	3, 3\n"					\
 		"1:"							\
-		: "+r" (_r0), "=r" (_r3), "+r" (_r4), "+r" (_r5),	\
+		: "+r" (_r0), "+r" (_r3), "+r" (_r4), "+r" (_r5),	\
 		  "+r" (_r6), "+r" (_r7), "+r" (_r8)			\
-		: "r" (_rval)						\
+		:							\
 		: "r9", "r10", "r11", "r12", "cr0", "cr1", "cr5",	\
 		  "cr6", "cr7", "xer", "lr", "ctr", "memory"		\
 	);								\
-	_rval;								\
+	_r3;								\
 })
 
 #else
diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/selftests/vDSO/vdso_test_abi.c
index a54424e2336f..67cbfc56e4e1 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -182,12 +182,11 @@ int main(int argc, char **argv)
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
 
 	ksft_print_header();
-	ksft_set_plan(VDSO_TEST_PLAN);
 
-	if (!sysinfo_ehdr) {
-		ksft_print_msg("AT_SYSINFO_EHDR is not present!\n");
-		return KSFT_SKIP;
-	}
+	if (!sysinfo_ehdr)
+		ksft_exit_skip("AT_SYSINFO_EHDR is not present!\n");
+
+	ksft_set_plan(VDSO_TEST_PLAN);
 
 	version = versions[VDSO_VERSION];
 	name = (const char **)&names[VDSO_NAMES];
diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index a1f506ba5578..4f09c5db0c7f 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -332,6 +332,12 @@ int main(int argc, char *argv[])
 	if (oneshot)
 		goto end;
 
+	/* Check if WDIOF_KEEPALIVEPING is supported */
+	if (!(info.options & WDIOF_KEEPALIVEPING)) {
+		printf("WDIOC_KEEPALIVE not supported by this device\n");
+		goto end;
+	}
+
 	printf("Watchdog Ticking Away!\n");
 
 	/*

