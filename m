Return-Path: <stable+bounces-126977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2904FA75204
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 22:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 581407A723B
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D8F1F3D54;
	Fri, 28 Mar 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BkPFvBt4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E841EF375;
	Fri, 28 Mar 2025 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196873; cv=none; b=uTodP9QsPs9jMhwBrQMRxPtuoqwQXr5liD2R68iLiHT6zEnTjrE+Ay8dbhgo+pXMSW2ULZJzGZdSDnucsJLSKAlo70MuRkg29FxJE9EygyH3S/TpK2Ta/3R6tsNVvfGCPxsrq+93ZfW4VMWvuah1Ly1PN2xkBVQ7yXTlboDnIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196873; c=relaxed/simple;
	bh=JuNFlBY4EoNgdUTrxdxi0qbOIhDBulAK5HJ5EgUOCF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuIoJh9uDt0b0ITH/xwUdI571YusVgWbj2EkeFxEExlBYQrNdz6slHmvlZLuHNAxY/z0l5OCxJnBphqul5ANhJQwKdPKgVpuLHKYsZqPbT3TmVWBMm1P43FezJAAxC+5UsRuTTLgBhmI2PHdpt7ImujqQMRLmgJVdLODdSfW7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BkPFvBt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8CDC4CEE9;
	Fri, 28 Mar 2025 21:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743196873;
	bh=JuNFlBY4EoNgdUTrxdxi0qbOIhDBulAK5HJ5EgUOCF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkPFvBt4fdUCOZ3xr0Y3BNC+5Ja1IvY0wqZl8rqT9aaMs+Tw3RlXfpmy2iEUHYK/s
	 oOnJxWffFWz6i9fxc0qig3JKR3uZWfIV7QPO/OgPe8aKIIgJ6VHMAk1DT17bjQzTbZ
	 3307xv/dFA85tUIdXv7Ec9z7n25zXUM0A1RrzEKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.21
Date: Fri, 28 Mar 2025 22:19:39 +0100
Message-ID: <2025032839-crestless-annually-f251@gregkh>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <2025032838-studio-keg-302e@gregkh>
References: <2025032838-studio-keg-302e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 7c5ac5d2e880..f6884f6e59e7 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -170,7 +170,7 @@ allOf:
             const: renesas,r8a779h0-canfd
     then:
       patternProperties:
-        "^channel[5-7]$": false
+        "^channel[4-7]$": false
     else:
       if:
         not:
diff --git a/Makefile b/Makefile
index ca000bd227be..a646151342b8 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 20
+SUBLEVEL = 21
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi b/arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi
index 6bf4241fe3b7..c78ed064d166 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi.dtsi
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "bcm2835-rpi.dtsi"
 
-#include <dt-bindings/power/raspberrypi-power.h>
 #include <dt-bindings/reset/raspberrypi,firmware-reset.h>
 
 / {
@@ -101,7 +100,3 @@ &v3d {
 &vchiq {
 	interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 };
-
-&xhci {
-	power-domains = <&power RPI_POWER_DOMAIN_USB>;
-};
diff --git a/arch/arm/boot/dts/broadcom/bcm2711.dtsi b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
index e4e42af21ef3..c06d9f5e53c8 100644
--- a/arch/arm/boot/dts/broadcom/bcm2711.dtsi
+++ b/arch/arm/boot/dts/broadcom/bcm2711.dtsi
@@ -134,7 +134,7 @@ uart2: serial@7e201400 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -145,7 +145,7 @@ uart3: serial@7e201600 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -156,7 +156,7 @@ uart4: serial@7e201800 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -167,7 +167,7 @@ uart5: serial@7e201a00 {
 			clocks = <&clocks BCM2835_CLOCK_UART>,
 				 <&clocks BCM2835_CLOCK_VPU>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
@@ -451,8 +451,6 @@ IRQ_TYPE_LEVEL_LOW)>,
 					  IRQ_TYPE_LEVEL_LOW)>,
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) |
 					  IRQ_TYPE_LEVEL_LOW)>;
-		/* This only applies to the ARMv7 stub */
-		arm,cpu-registers-not-fw-configured;
 	};
 
 	cpus: cpus {
@@ -610,6 +608,7 @@ xhci: usb@7e9c0000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pm BCM2835_POWER_DOMAIN_USB>;
 			/* DWC2 and this IP block share the same USB PHY,
 			 * enabling both at the same time results in lockups.
 			 * So keep this node disabled and let the bootloader
@@ -1177,6 +1176,7 @@ &txp {
 };
 
 &uart0 {
+	arm,primecell-periphid = <0x00341011>;
 	interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 };
 
diff --git a/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
index 53cb0c58f6d0..3da2daee0c84 100644
--- a/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
+++ b/arch/arm/boot/dts/broadcom/bcm4709-asus-rt-ac3200.dts
@@ -124,19 +124,19 @@ port@0 {
 		};
 
 		port@1 {
-			label = "lan1";
+			label = "lan4";
 		};
 
 		port@2 {
-			label = "lan2";
+			label = "lan3";
 		};
 
 		port@3 {
-			label = "lan3";
+			label = "lan2";
 		};
 
 		port@4 {
-			label = "lan4";
+			label = "lan1";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
index 6c666dc7ad23..01ec8c03686a 100644
--- a/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
+++ b/arch/arm/boot/dts/broadcom/bcm47094-asus-rt-ac5300.dts
@@ -126,11 +126,11 @@ &srab {
 
 	ports {
 		port@0 {
-			label = "lan4";
+			label = "wan";
 		};
 
 		port@1 {
-			label = "lan3";
+			label = "lan1";
 		};
 
 		port@2 {
@@ -138,11 +138,11 @@ port@2 {
 		};
 
 		port@3 {
-			label = "lan1";
+			label = "lan3";
 		};
 
 		port@4 {
-			label = "wan";
+			label = "lan4";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
index edf55760a5c1..1a63a6add439 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi
@@ -108,6 +108,11 @@ lvds_panel_in: endpoint {
 		};
 	};
 
+	poweroff {
+		compatible = "regulator-poweroff";
+		cpu-supply = <&vgen2_reg>;
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-always-on;
@@ -236,10 +241,6 @@ &can2 {
 	status = "disabled";
 };
 
-&clks {
-	fsl,pmic-stby-poweroff;
-};
-
 /* Apalis SPI1 */
 &ecspi1 {
 	cs-gpios = <&gpio5 25 GPIO_ACTIVE_LOW>;
@@ -527,7 +528,6 @@ &i2c2 {
 
 	pmic: pmic@8 {
 		compatible = "fsl,pfuze100";
-		fsl,pmic-stby-poweroff;
 		reg = <0x08>;
 
 		regulators {
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 2a8a9fe46586..3fa15f342240 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -27,6 +27,7 @@ config ARCH_DAVINCI_DA830
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
+	select ARCH_DAVINCI_DA8XX
 	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA8XX
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index a643b71e30a3..08ec6bd84ada 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -8,6 +8,7 @@ menuconfig ARCH_OMAP1
 	select ARCH_OMAP
 	select CLKSRC_MMIO
 	select FORCE_PCI if PCCARD
+	select GENERIC_IRQ_CHIP
 	select GPIOLIB
 	help
 	  Support for older TI OMAP1 (omap7xx, omap15xx or omap16xx)
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index a956b489b6ea..2bc7e73a8582 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -136,6 +136,7 @@ ENDPROC(shmobile_smp_sleep)
 	.long	shmobile_smp_arg - 1b
 
 	.bss
+	.align	2
 	.globl	shmobile_smp_mpidr
 shmobile_smp_mpidr:
 	.space	NR_CPUS * 4
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
index 26a29e5e5078..447bfa060918 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm2712.dtsi
@@ -232,7 +232,7 @@ uart10: serial@7d001000 {
 			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_uart>, <&clk_vpu>;
 			clock-names = "uartclk", "apb_pclk";
-			arm,primecell-periphid = <0x00241011>;
+			arm,primecell-periphid = <0x00341011>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
index ce20de259805..3d0b14968131 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi
@@ -16,10 +16,10 @@ sound_card: sound-card {
 			"Headphone Jack", "HPOUTR",
 			"IN2L", "Line In Jack",
 			"IN2R", "Line In Jack",
-			"Headphone Jack", "MICBIAS",
-			"IN1L", "Headphone Jack";
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Microphone", "Headphone Jack",
+			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
 			"Line", "Line In Jack";
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
index 336785a9fba8..3ddc5aaa7c5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql.dtsi
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2021-2022 TQ-Systems GmbH
- * Author: Alexander Stein <alexander.stein@tq-group.com>
+ * Copyright 2021-2025 TQ-Systems GmbH <linux@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Alexander Stein
  */
 
 #include "imx8mp.dtsi"
@@ -23,15 +24,6 @@ reg_vcc3v3: regulator-vcc3v3 {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
-
-	/* e-MMC IO, needed for HS modes */
-	reg_vcc1v8: regulator-vcc1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-always-on;
-	};
 };
 
 &A53_0 {
@@ -197,7 +189,7 @@ &usdhc3 {
 	no-sd;
 	no-sdio;
 	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc1v8>;
+	vqmmc-supply = <&buck5_reg>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
index da8902c5f7e5..1493319aa748 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi
@@ -28,10 +28,10 @@ sound {
 			"Headphone Jack", "HPOUTR",
 			"IN2L", "Line In Jack",
 			"IN2R", "Line In Jack",
-			"Headphone Jack", "MICBIAS",
-			"IN1L", "Headphone Jack";
+			"Microphone Jack", "MICBIAS",
+			"IN1L", "Microphone Jack";
 		simple-audio-card,widgets =
-			"Microphone", "Headphone Jack",
+			"Microphone", "Microphone Jack",
 			"Headphone", "Headphone Jack",
 			"Line", "Line In Jack";
 
diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 0905668cbe1f..3d5e81a0afdc 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -194,6 +194,13 @@ sd_card_led_pin: sd-card-led-pin {
 			  <3 RK_PB3 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
+
+	uart {
+		uart5_rts_pin: uart5-rts-pin {
+			rockchip,pins =
+			  <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &pwm0 {
@@ -222,10 +229,15 @@ &u2phy_otg {
 };
 
 &uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_xfer>;
 	status = "okay";
 };
 
 &uart5 {
+	/* Add pinmux for rts-gpios (uart5_rts_pin) */
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart5_xfer &uart5_rts_pin>;
 	rts-gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index fe5b52610010..6a6b36c36ce2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -117,7 +117,7 @@ &u2phy0_host {
 };
 
 &u2phy1_host {
-	status = "disabled";
+	phy-supply = <&vdd_5v>;
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
index 9a2f59a351de..48ccdd6b4711 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
@@ -512,7 +512,6 @@ &sdhci {
 
 &sdmmc0 {
 	max-frequency = <150000000>;
-	supports-sd;
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 31d2f8994f85..e61c5731fb99 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -455,7 +455,6 @@ &sdhci {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
-	supports-cqe;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 615094bb8ba3..a82fe75bda55 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -367,7 +367,6 @@ &sdhci {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
-	supports-cqe;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1bf70fa1045d..122a1e12582c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -602,23 +602,13 @@ struct kvm_host_data {
 	struct kvm_cpu_context host_ctxt;
 
 	/*
-	 * All pointers in this union are hyp VA.
+	 * Hyp VA.
 	 * sve_state is only used in pKVM and if system_supports_sve().
 	 */
-	union {
-		struct user_fpsimd_state *fpsimd_state;
-		struct cpu_sve_state *sve_state;
-	};
-
-	union {
-		/* HYP VA pointer to the host storage for FPMR */
-		u64	*fpmr_ptr;
-		/*
-		 * Used by pKVM only, as it needs to provide storage
-		 * for the host
-		 */
-		u64	fpmr;
-	};
+	struct cpu_sve_state *sve_state;
+
+	/* Used by pKVM only. */
+	u64	fpmr;
 
 	/* Ownership of the FP regs */
 	enum {
@@ -697,7 +687,6 @@ struct kvm_vcpu_arch {
 	u64 hcr_el2;
 	u64 hcrx_el2;
 	u64 mdcr_el2;
-	u64 cptr_el2;
 
 	/* Exception Information */
 	struct kvm_vcpu_fault_info fault;
@@ -902,10 +891,6 @@ struct kvm_vcpu_arch {
 /* Save TRBE context if active  */
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 
-/* SVE enabled for host EL0 */
-#define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
-/* SME enabled for EL0 */
-#define HOST_SME_ENABLED	__vcpu_single_flag(sflags, BIT(1))
 /* Physical CPU not in supported_cpus */
 #define ON_UNSUPPORTED_CPU	__vcpu_single_flag(sflags, BIT(2))
 /* WFIT instruction trapped */
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 6d21971ae559..f38d22dac140 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1694,31 +1694,6 @@ void fpsimd_signal_preserve_current_state(void)
 		sve_to_fpsimd(current);
 }
 
-/*
- * Called by KVM when entering the guest.
- */
-void fpsimd_kvm_prepare(void)
-{
-	if (!system_supports_sve())
-		return;
-
-	/*
-	 * KVM does not save host SVE state since we can only enter
-	 * the guest from a syscall so the ABI means that only the
-	 * non-saved SVE state needs to be saved.  If we have left
-	 * SVE enabled for performance reasons then update the task
-	 * state to be FPSIMD only.
-	 */
-	get_cpu_fpsimd_context();
-
-	if (test_and_clear_thread_flag(TIF_SVE)) {
-		sve_to_fpsimd(current);
-		current->thread.fp_type = FP_STATE_FPSIMD;
-	}
-
-	put_cpu_fpsimd_context();
-}
-
 /*
  * Associate current's FPSIMD context with this cpu
  * The caller must have ownership of the cpu FPSIMD context before calling
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3cf65daa75a5..634d3f624818 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1577,7 +1577,6 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
 	}
 
 	vcpu_reset_hcr(vcpu);
-	vcpu->arch.cptr_el2 = kvm_get_reset_cptr_el2(vcpu);
 
 	/*
 	 * Handle the "start in power-off" case.
@@ -2477,14 +2476,6 @@ static void finalize_init_hyp_mode(void)
 			per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->sve_state =
 				kern_hyp_va(sve_state);
 		}
-	} else {
-		for_each_possible_cpu(cpu) {
-			struct user_fpsimd_state *fpsimd_state;
-
-			fpsimd_state = &per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->host_ctxt.fp_regs;
-			per_cpu_ptr_nvhe_sym(kvm_host_data, cpu)->fpsimd_state =
-				kern_hyp_va(fpsimd_state);
-		}
 	}
 }
 
diff --git a/arch/arm64/kvm/fpsimd.c b/arch/arm64/kvm/fpsimd.c
index ea5484ce1f3b..3cbb999419af 100644
--- a/arch/arm64/kvm/fpsimd.c
+++ b/arch/arm64/kvm/fpsimd.c
@@ -54,43 +54,16 @@ void kvm_arch_vcpu_load_fp(struct kvm_vcpu *vcpu)
 	if (!system_supports_fpsimd())
 		return;
 
-	fpsimd_kvm_prepare();
-
 	/*
-	 * We will check TIF_FOREIGN_FPSTATE just before entering the
-	 * guest in kvm_arch_vcpu_ctxflush_fp() and override this to
-	 * FP_STATE_FREE if the flag set.
+	 * Ensure that any host FPSIMD/SVE/SME state is saved and unbound such
+	 * that the host kernel is responsible for restoring this state upon
+	 * return to userspace, and the hyp code doesn't need to save anything.
+	 *
+	 * When the host may use SME, fpsimd_save_and_flush_cpu_state() ensures
+	 * that PSTATE.{SM,ZA} == {0,0}.
 	 */
-	*host_data_ptr(fp_owner) = FP_STATE_HOST_OWNED;
-	*host_data_ptr(fpsimd_state) = kern_hyp_va(&current->thread.uw.fpsimd_state);
-	*host_data_ptr(fpmr_ptr) = kern_hyp_va(&current->thread.uw.fpmr);
-
-	vcpu_clear_flag(vcpu, HOST_SVE_ENABLED);
-	if (read_sysreg(cpacr_el1) & CPACR_EL1_ZEN_EL0EN)
-		vcpu_set_flag(vcpu, HOST_SVE_ENABLED);
-
-	if (system_supports_sme()) {
-		vcpu_clear_flag(vcpu, HOST_SME_ENABLED);
-		if (read_sysreg(cpacr_el1) & CPACR_EL1_SMEN_EL0EN)
-			vcpu_set_flag(vcpu, HOST_SME_ENABLED);
-
-		/*
-		 * If PSTATE.SM is enabled then save any pending FP
-		 * state and disable PSTATE.SM. If we leave PSTATE.SM
-		 * enabled and the guest does not enable SME via
-		 * CPACR_EL1.SMEN then operations that should be valid
-		 * may generate SME traps from EL1 to EL1 which we
-		 * can't intercept and which would confuse the guest.
-		 *
-		 * Do the same for PSTATE.ZA in the case where there
-		 * is state in the registers which has not already
-		 * been saved, this is very unlikely to happen.
-		 */
-		if (read_sysreg_s(SYS_SVCR) & (SVCR_SM_MASK | SVCR_ZA_MASK)) {
-			*host_data_ptr(fp_owner) = FP_STATE_FREE;
-			fpsimd_save_and_flush_cpu_state();
-		}
-	}
+	fpsimd_save_and_flush_cpu_state();
+	*host_data_ptr(fp_owner) = FP_STATE_FREE;
 
 	/*
 	 * If normal guests gain SME support, maintain this behavior for pKVM
@@ -162,52 +135,7 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 
 	local_irq_save(flags);
 
-	/*
-	 * If we have VHE then the Hyp code will reset CPACR_EL1 to
-	 * the default value and we need to reenable SME.
-	 */
-	if (has_vhe() && system_supports_sme()) {
-		/* Also restore EL0 state seen on entry */
-		if (vcpu_get_flag(vcpu, HOST_SME_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_ELx_SMEN);
-		else
-			sysreg_clear_set(CPACR_EL1,
-					 CPACR_EL1_SMEN_EL0EN,
-					 CPACR_EL1_SMEN_EL1EN);
-		isb();
-	}
-
 	if (guest_owns_fp_regs()) {
-		if (vcpu_has_sve(vcpu)) {
-			u64 zcr = read_sysreg_el1(SYS_ZCR);
-
-			/*
-			 * If the vCPU is in the hyp context then ZCR_EL1 is
-			 * loaded with its vEL2 counterpart.
-			 */
-			__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr;
-
-			/*
-			 * Restore the VL that was saved when bound to the CPU,
-			 * which is the maximum VL for the guest. Because the
-			 * layout of the data when saving the sve state depends
-			 * on the VL, we need to use a consistent (i.e., the
-			 * maximum) VL.
-			 * Note that this means that at guest exit ZCR_EL1 is
-			 * not necessarily the same as on guest entry.
-			 *
-			 * ZCR_EL2 holds the guest hypervisor's VL when running
-			 * a nested guest, which could be smaller than the
-			 * max for the vCPU. Similar to above, we first need to
-			 * switch to a VL consistent with the layout of the
-			 * vCPU's SVE state. KVM support for NV implies VHE, so
-			 * using the ZCR_EL1 alias is safe.
-			 */
-			if (!has_vhe() || (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu)))
-				sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1,
-						       SYS_ZCR_EL1);
-		}
-
 		/*
 		 * Flush (save and invalidate) the fpsimd/sve state so that if
 		 * the host tries to use fpsimd/sve, it's not using stale data
@@ -219,18 +147,6 @@ void kvm_arch_vcpu_put_fp(struct kvm_vcpu *vcpu)
 		 * when needed.
 		 */
 		fpsimd_save_and_flush_cpu_state();
-	} else if (has_vhe() && system_supports_sve()) {
-		/*
-		 * The FPSIMD/SVE state in the CPU has not been touched, and we
-		 * have SVE (and VHE): CPACR_EL1 (alias CPTR_EL2) has been
-		 * reset by kvm_reset_cptr_el2() in the Hyp code, disabling SVE
-		 * for EL0.  To avoid spurious traps, restore the trap state
-		 * seen by kvm_arch_vcpu_load_fp():
-		 */
-		if (vcpu_get_flag(vcpu, HOST_SVE_ENABLED))
-			sysreg_clear_set(CPACR_EL1, 0, CPACR_EL1_ZEN_EL0EN);
-		else
-			sysreg_clear_set(CPACR_EL1, CPACR_EL1_ZEN_EL0EN, 0);
 	}
 
 	local_irq_restore(flags);
diff --git a/arch/arm64/kvm/hyp/entry.S b/arch/arm64/kvm/hyp/entry.S
index 4433a234aa9b..9f4e8d68ab50 100644
--- a/arch/arm64/kvm/hyp/entry.S
+++ b/arch/arm64/kvm/hyp/entry.S
@@ -44,6 +44,11 @@ alternative_if ARM64_HAS_RAS_EXTN
 alternative_else_nop_endif
 	mrs	x1, isr_el1
 	cbz	x1,  1f
+
+	// Ensure that __guest_enter() always provides a context
+	// synchronization event so that callers don't need ISBs for anything
+	// that would usually be synchonized by the ERET.
+	isb
 	mov	x0, #ARM_EXCEPTION_IRQ
 	ret
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 5310fe1da616..cc9cb6395946 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -295,7 +295,7 @@ static inline bool __populate_fault_info(struct kvm_vcpu *vcpu)
 	return __get_fault_info(vcpu->arch.fault.esr_el2, &vcpu->arch.fault);
 }
 
-static bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	*vcpu_pc(vcpu) = read_sysreg_el2(SYS_ELR);
 	arm64_mops_reset_regs(vcpu_gp_regs(vcpu), vcpu->arch.fault.esr_el2);
@@ -344,7 +344,87 @@ static inline void __hyp_sve_save_host(void)
 			 true);
 }
 
-static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu);
+static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs())
+		return;
+
+	if (vcpu_has_sve(vcpu)) {
+		/* A guest hypervisor may restrict the effective max VL. */
+		if (vcpu_has_nv(vcpu) && !is_hyp_ctxt(vcpu))
+			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
+		else
+			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
+		write_sysreg_el2(zcr_el2, SYS_ZCR);
+
+		zcr_el1 = __vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu));
+		write_sysreg_el1(zcr_el1, SYS_ZCR);
+	}
+}
+
+static inline void fpsimd_lazy_switch_to_host(struct kvm_vcpu *vcpu)
+{
+	u64 zcr_el1, zcr_el2;
+
+	if (!guest_owns_fp_regs())
+		return;
+
+	/*
+	 * When the guest owns the FP regs, we know that guest+hyp traps for
+	 * any FPSIMD/SVE/SME features exposed to the guest have been disabled
+	 * by either fpsimd_lazy_switch_to_guest() or kvm_hyp_handle_fpsimd()
+	 * prior to __guest_entry(). As __guest_entry() guarantees a context
+	 * synchronization event, we don't need an ISB here to avoid taking
+	 * traps for anything that was exposed to the guest.
+	 */
+	if (vcpu_has_sve(vcpu)) {
+		zcr_el1 = read_sysreg_el1(SYS_ZCR);
+		__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)) = zcr_el1;
+
+		/*
+		 * The guest's state is always saved using the guest's max VL.
+		 * Ensure that the host has the guest's max VL active such that
+		 * the host can save the guest's state lazily, but don't
+		 * artificially restrict the host to the guest's max VL.
+		 */
+		if (has_vhe()) {
+			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el2(zcr_el2, SYS_ZCR);
+		} else {
+			zcr_el2 = sve_vq_from_vl(kvm_host_sve_max_vl) - 1;
+			write_sysreg_el2(zcr_el2, SYS_ZCR);
+
+			zcr_el1 = vcpu_sve_max_vq(vcpu) - 1;
+			write_sysreg_el1(zcr_el1, SYS_ZCR);
+		}
+	}
+}
+
+static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Non-protected kvm relies on the host restoring its sve state.
+	 * Protected kvm restores the host's sve state as not to reveal that
+	 * fpsimd was used by a guest nor leak upper sve bits.
+	 */
+	if (system_supports_sve()) {
+		__hyp_sve_save_host();
+
+		/* Re-enable SVE traps if not supported for the guest vcpu. */
+		if (!vcpu_has_sve(vcpu))
+			cpacr_clear_set(CPACR_ELx_ZEN, 0);
+
+	} else {
+		__fpsimd_save_state(host_data_ptr(host_ctxt.fp_regs));
+	}
+
+	if (kvm_has_fpmr(kern_hyp_va(vcpu->kvm)))
+		*host_data_ptr(fpmr) = read_sysreg_s(SYS_FPMR);
+}
+
 
 /*
  * We trap the first access to the FP/SIMD to save the host context and
@@ -352,7 +432,7 @@ static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu);
  * If FP/SIMD is not implemented, handle the trap and inject an undefined
  * instruction exception to the guest. Similarly for trapped SVE accesses.
  */
-static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	bool sve_guest;
 	u8 esr_ec;
@@ -394,7 +474,7 @@ static bool kvm_hyp_handle_fpsimd(struct kvm_vcpu *vcpu, u64 *exit_code)
 	isb();
 
 	/* Write out the host state if it's in the registers */
-	if (host_owns_fp_regs())
+	if (is_protected_kvm_enabled() && host_owns_fp_regs())
 		kvm_hyp_save_fpsimd_host(vcpu);
 
 	/* Restore the guest state */
@@ -543,7 +623,7 @@ static bool handle_ampere1_tcr(struct kvm_vcpu *vcpu)
 	return true;
 }
 
-static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (cpus_have_final_cap(ARM64_WORKAROUND_CAVIUM_TX2_219_TVM) &&
 	    handle_tx2_tvm(vcpu))
@@ -563,7 +643,7 @@ static bool kvm_hyp_handle_sysreg(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return false;
 }
 
-static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (static_branch_unlikely(&vgic_v3_cpuif_trap) &&
 	    __vgic_v3_perform_cpuif_access(vcpu) == 1)
@@ -572,19 +652,18 @@ static bool kvm_hyp_handle_cp15_32(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return false;
 }
 
-static bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_memory_fault(struct kvm_vcpu *vcpu,
+					       u64 *exit_code)
 {
 	if (!__populate_fault_info(vcpu))
 		return true;
 
 	return false;
 }
-static bool kvm_hyp_handle_iabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
-	__alias(kvm_hyp_handle_memory_fault);
-static bool kvm_hyp_handle_watchpt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
-	__alias(kvm_hyp_handle_memory_fault);
+#define kvm_hyp_handle_iabt_low		kvm_hyp_handle_memory_fault
+#define kvm_hyp_handle_watchpt_low	kvm_hyp_handle_memory_fault
 
-static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	if (kvm_hyp_handle_memory_fault(vcpu, exit_code))
 		return true;
@@ -614,23 +693,16 @@ static bool kvm_hyp_handle_dabt_low(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 typedef bool (*exit_handler_fn)(struct kvm_vcpu *, u64 *);
 
-static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu);
-
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code);
-
 /*
  * Allow the hypervisor to handle the exit with an exit handler if it has one.
  *
  * Returns true if the hypervisor handled the exit, and control should go back
  * to the guest, or false if it hasn't.
  */
-static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool kvm_hyp_handle_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
+				       const exit_handler_fn *handlers)
 {
-	const exit_handler_fn *handlers = kvm_get_exit_handler_array(vcpu);
-	exit_handler_fn fn;
-
-	fn = handlers[kvm_vcpu_trap_get_class(vcpu)];
-
+	exit_handler_fn fn = handlers[kvm_vcpu_trap_get_class(vcpu)];
 	if (fn)
 		return fn(vcpu, exit_code);
 
@@ -660,20 +732,9 @@ static inline void synchronize_vcpu_pstate(struct kvm_vcpu *vcpu, u64 *exit_code
  * the guest, false when we should restore the host state and return to the
  * main run loop.
  */
-static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool __fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code,
+				      const exit_handler_fn *handlers)
 {
-	/*
-	 * Save PSTATE early so that we can evaluate the vcpu mode
-	 * early on.
-	 */
-	synchronize_vcpu_pstate(vcpu, exit_code);
-
-	/*
-	 * Check whether we want to repaint the state one way or
-	 * another.
-	 */
-	early_exit_filter(vcpu, exit_code);
-
 	if (ARM_EXCEPTION_CODE(*exit_code) != ARM_EXCEPTION_IRQ)
 		vcpu->arch.fault.esr_el2 = read_sysreg_el2(SYS_ESR);
 
@@ -703,7 +764,7 @@ static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 		goto exit;
 
 	/* Check if there's an exit handler and allow it to handle the exit. */
-	if (kvm_hyp_handle_exit(vcpu, exit_code))
+	if (kvm_hyp_handle_exit(vcpu, exit_code, handlers))
 		goto guest;
 exit:
 	/* Return to the host kernel and handle the exit */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index fefc89209f9e..75f7e386de75 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -5,6 +5,7 @@
  */
 
 #include <hyp/adjust_pc.h>
+#include <hyp/switch.h>
 
 #include <asm/pgtable-types.h>
 #include <asm/kvm_asm.h>
@@ -83,7 +84,7 @@ static void fpsimd_sve_sync(struct kvm_vcpu *vcpu)
 	if (system_supports_sve())
 		__hyp_sve_restore_host();
 	else
-		__fpsimd_restore_state(*host_data_ptr(fpsimd_state));
+		__fpsimd_restore_state(host_data_ptr(host_ctxt.fp_regs));
 
 	if (has_fpmr)
 		write_sysreg_s(*host_data_ptr(fpmr), SYS_FPMR);
@@ -177,7 +178,9 @@ static void handle___kvm_vcpu_run(struct kvm_cpu_context *host_ctxt)
 		pkvm_put_hyp_vcpu(hyp_vcpu);
 	} else {
 		/* The host is fully trusted, run its vCPU directly. */
+		fpsimd_lazy_switch_to_guest(host_vcpu);
 		ret = __kvm_vcpu_run(host_vcpu);
+		fpsimd_lazy_switch_to_host(host_vcpu);
 	}
 
 out:
@@ -486,12 +489,6 @@ void handle_trap(struct kvm_cpu_context *host_ctxt)
 	case ESR_ELx_EC_SMC64:
 		handle_host_smc(host_ctxt);
 		break;
-	case ESR_ELx_EC_SVE:
-		cpacr_clear_set(0, CPACR_ELx_ZEN);
-		isb();
-		sve_cond_update_zcr_vq(sve_vq_from_vl(kvm_host_sve_max_vl) - 1,
-				       SYS_ZCR_EL2);
-		break;
 	case ESR_ELx_EC_IABT_LOW:
 	case ESR_ELx_EC_DABT_LOW:
 		handle_host_mem_abort(host_ctxt);
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 077d4098548d..7c464340bcd0 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -28,8 +28,6 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64PFR0_EL1);
 	u64 hcr_set = HCR_RW;
 	u64 hcr_clear = 0;
-	u64 cptr_set = 0;
-	u64 cptr_clear = 0;
 
 	/* Protected KVM does not support AArch32 guests. */
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
@@ -59,21 +57,10 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 	/* Trap AMU */
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_AMU), feature_ids)) {
 		hcr_clear |= HCR_AMVOFFEN;
-		cptr_set |= CPTR_EL2_TAM;
-	}
-
-	/* Trap SVE */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_SVE), feature_ids)) {
-		if (has_hvhe())
-			cptr_clear |= CPACR_ELx_ZEN;
-		else
-			cptr_set |= CPTR_EL2_TZ;
 	}
 
 	vcpu->arch.hcr_el2 |= hcr_set;
 	vcpu->arch.hcr_el2 &= ~hcr_clear;
-	vcpu->arch.cptr_el2 |= cptr_set;
-	vcpu->arch.cptr_el2 &= ~cptr_clear;
 }
 
 /*
@@ -103,7 +90,6 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 	const u64 feature_ids = pvm_read_id_reg(vcpu, SYS_ID_AA64DFR0_EL1);
 	u64 mdcr_set = 0;
 	u64 mdcr_clear = 0;
-	u64 cptr_set = 0;
 
 	/* Trap/constrain PMU */
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_PMUVer), feature_ids)) {
@@ -130,21 +116,12 @@ static void pvm_init_traps_aa64dfr0(struct kvm_vcpu *vcpu)
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceFilt), feature_ids))
 		mdcr_set |= MDCR_EL2_TTRF;
 
-	/* Trap Trace */
-	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_TraceVer), feature_ids)) {
-		if (has_hvhe())
-			cptr_set |= CPACR_EL1_TTA;
-		else
-			cptr_set |= CPTR_EL2_TTA;
-	}
-
 	/* Trap External Trace */
 	if (!FIELD_GET(ARM64_FEATURE_MASK(ID_AA64DFR0_EL1_ExtTrcBuff), feature_ids))
 		mdcr_clear |= MDCR_EL2_E2TB_MASK << MDCR_EL2_E2TB_SHIFT;
 
 	vcpu->arch.mdcr_el2 |= mdcr_set;
 	vcpu->arch.mdcr_el2 &= ~mdcr_clear;
-	vcpu->arch.cptr_el2 |= cptr_set;
 }
 
 /*
@@ -195,10 +172,6 @@ static void pvm_init_trap_regs(struct kvm_vcpu *vcpu)
 	/* Clear res0 and set res1 bits to trap potential new features. */
 	vcpu->arch.hcr_el2 &= ~(HCR_RES0);
 	vcpu->arch.mdcr_el2 &= ~(MDCR_EL2_RES0);
-	if (!has_hvhe()) {
-		vcpu->arch.cptr_el2 |= CPTR_NVHE_EL2_RES1;
-		vcpu->arch.cptr_el2 &= ~(CPTR_NVHE_EL2_RES0);
-	}
 }
 
 /*
@@ -579,8 +552,6 @@ int __pkvm_init_vcpu(pkvm_handle_t handle, struct kvm_vcpu *host_vcpu,
 		return ret;
 	}
 
-	hyp_vcpu->vcpu.arch.cptr_el2 = kvm_get_reset_cptr_el2(&hyp_vcpu->vcpu);
-
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index cc69106734ca..a1245fa83831 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -36,33 +36,71 @@ DEFINE_PER_CPU(unsigned long, kvm_hyp_vector);
 
 extern void kvm_nvhe_prepare_backtrace(unsigned long fp, unsigned long pc);
 
-static void __activate_traps(struct kvm_vcpu *vcpu)
+static void __activate_cptr_traps(struct kvm_vcpu *vcpu)
 {
-	u64 val;
+	u64 val = CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
 
-	___activate_traps(vcpu, vcpu->arch.hcr_el2);
-	__activate_traps_common(vcpu);
+	if (!guest_owns_fp_regs())
+		__activate_traps_fpsimd32(vcpu);
 
-	val = vcpu->arch.cptr_el2;
-	val |= CPTR_EL2_TAM;	/* Same bit irrespective of E2H */
-	val |= has_hvhe() ? CPACR_EL1_TTA : CPTR_EL2_TTA;
-	if (cpus_have_final_cap(ARM64_SME)) {
-		if (has_hvhe())
-			val &= ~CPACR_ELx_SMEN;
-		else
-			val |= CPTR_EL2_TSM;
+	if (has_hvhe()) {
+		val |= CPACR_ELx_TTA;
+
+		if (guest_owns_fp_regs()) {
+			val |= CPACR_ELx_FPEN;
+			if (vcpu_has_sve(vcpu))
+				val |= CPACR_ELx_ZEN;
+		}
+
+		write_sysreg(val, cpacr_el1);
+	} else {
+		val |= CPTR_EL2_TTA | CPTR_NVHE_EL2_RES1;
+
+		/*
+		 * Always trap SME since it's not supported in KVM.
+		 * TSM is RES1 if SME isn't implemented.
+		 */
+		val |= CPTR_EL2_TSM;
+
+		if (!vcpu_has_sve(vcpu) || !guest_owns_fp_regs())
+			val |= CPTR_EL2_TZ;
+
+		if (!guest_owns_fp_regs())
+			val |= CPTR_EL2_TFP;
+
+		write_sysreg(val, cptr_el2);
 	}
+}
 
-	if (!guest_owns_fp_regs()) {
-		if (has_hvhe())
-			val &= ~(CPACR_ELx_FPEN | CPACR_ELx_ZEN);
-		else
-			val |= CPTR_EL2_TFP | CPTR_EL2_TZ;
+static void __deactivate_cptr_traps(struct kvm_vcpu *vcpu)
+{
+	if (has_hvhe()) {
+		u64 val = CPACR_ELx_FPEN;
 
-		__activate_traps_fpsimd32(vcpu);
+		if (cpus_have_final_cap(ARM64_SVE))
+			val |= CPACR_ELx_ZEN;
+		if (cpus_have_final_cap(ARM64_SME))
+			val |= CPACR_ELx_SMEN;
+
+		write_sysreg(val, cpacr_el1);
+	} else {
+		u64 val = CPTR_NVHE_EL2_RES1;
+
+		if (!cpus_have_final_cap(ARM64_SVE))
+			val |= CPTR_EL2_TZ;
+		if (!cpus_have_final_cap(ARM64_SME))
+			val |= CPTR_EL2_TSM;
+
+		write_sysreg(val, cptr_el2);
 	}
+}
+
+static void __activate_traps(struct kvm_vcpu *vcpu)
+{
+	___activate_traps(vcpu, vcpu->arch.hcr_el2);
+	__activate_traps_common(vcpu);
+	__activate_cptr_traps(vcpu);
 
-	kvm_write_cptr_el2(val);
 	write_sysreg(__this_cpu_read(kvm_hyp_vector), vbar_el2);
 
 	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT)) {
@@ -107,7 +145,7 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 
 	write_sysreg(this_cpu_ptr(&kvm_init_params)->hcr_el2, hcr_el2);
 
-	kvm_reset_cptr_el2(vcpu);
+	__deactivate_cptr_traps(vcpu);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
 
@@ -180,34 +218,6 @@ static bool kvm_handle_pvm_sys64(struct kvm_vcpu *vcpu, u64 *exit_code)
 		kvm_handle_pvm_sysreg(vcpu, exit_code));
 }
 
-static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
-{
-	/*
-	 * Non-protected kvm relies on the host restoring its sve state.
-	 * Protected kvm restores the host's sve state as not to reveal that
-	 * fpsimd was used by a guest nor leak upper sve bits.
-	 */
-	if (unlikely(is_protected_kvm_enabled() && system_supports_sve())) {
-		__hyp_sve_save_host();
-
-		/* Re-enable SVE traps if not supported for the guest vcpu. */
-		if (!vcpu_has_sve(vcpu))
-			cpacr_clear_set(CPACR_ELx_ZEN, 0);
-
-	} else {
-		__fpsimd_save_state(*host_data_ptr(fpsimd_state));
-	}
-
-	if (kvm_has_fpmr(kern_hyp_va(vcpu->kvm))) {
-		u64 val = read_sysreg_s(SYS_FPMR);
-
-		if (unlikely(is_protected_kvm_enabled()))
-			*host_data_ptr(fpmr) = val;
-		else
-			**host_data_ptr(fpmr_ptr) = val;
-	}
-}
-
 static const exit_handler_fn hyp_exit_handlers[] = {
 	[0 ... ESR_ELx_EC_MAX]		= NULL,
 	[ESR_ELx_EC_CP15_32]		= kvm_hyp_handle_cp15_32,
@@ -239,19 +249,21 @@ static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
 	return hyp_exit_handlers;
 }
 
-/*
- * Some guests (e.g., protected VMs) are not be allowed to run in AArch32.
- * The ARMv8 architecture does not give the hypervisor a mechanism to prevent a
- * guest from dropping to AArch32 EL0 if implemented by the CPU. If the
- * hypervisor spots a guest in such a state ensure it is handled, and don't
- * trust the host to spot or fix it.  The check below is based on the one in
- * kvm_arch_vcpu_ioctl_run().
- *
- * Returns false if the guest ran in AArch32 when it shouldn't have, and
- * thus should exit to the host, or true if a the guest run loop can continue.
- */
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
+static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
+	const exit_handler_fn *handlers = kvm_get_exit_handler_array(vcpu);
+
+	synchronize_vcpu_pstate(vcpu, exit_code);
+
+	/*
+	 * Some guests (e.g., protected VMs) are not be allowed to run in
+	 * AArch32.  The ARMv8 architecture does not give the hypervisor a
+	 * mechanism to prevent a guest from dropping to AArch32 EL0 if
+	 * implemented by the CPU. If the hypervisor spots a guest in such a
+	 * state ensure it is handled, and don't trust the host to spot or fix
+	 * it.  The check below is based on the one in
+	 * kvm_arch_vcpu_ioctl_run().
+	 */
 	if (unlikely(vcpu_is_protected(vcpu) && vcpu_mode_is_32bit(vcpu))) {
 		/*
 		 * As we have caught the guest red-handed, decide that it isn't
@@ -264,6 +276,8 @@ static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
 		*exit_code &= BIT(ARM_EXIT_WITH_SERROR_BIT);
 		*exit_code |= ARM_EXCEPTION_IL;
 	}
+
+	return __fixup_guest_exit(vcpu, exit_code, handlers);
 }
 
 /* Switch to the guest for legacy non-VHE systems */
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 80581b1c3995..496abfd3646b 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -309,14 +309,6 @@ static bool kvm_hyp_handle_eret(struct kvm_vcpu *vcpu, u64 *exit_code)
 	return true;
 }
 
-static void kvm_hyp_save_fpsimd_host(struct kvm_vcpu *vcpu)
-{
-	__fpsimd_save_state(*host_data_ptr(fpsimd_state));
-
-	if (kvm_has_fpmr(vcpu->kvm))
-		**host_data_ptr(fpmr_ptr) = read_sysreg_s(SYS_FPMR);
-}
-
 static bool kvm_hyp_handle_tlbi_el2(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
 	int ret = -EINVAL;
@@ -431,13 +423,10 @@ static const exit_handler_fn hyp_exit_handlers[] = {
 	[ESR_ELx_EC_MOPS]		= kvm_hyp_handle_mops,
 };
 
-static const exit_handler_fn *kvm_get_exit_handler_array(struct kvm_vcpu *vcpu)
+static inline bool fixup_guest_exit(struct kvm_vcpu *vcpu, u64 *exit_code)
 {
-	return hyp_exit_handlers;
-}
+	synchronize_vcpu_pstate(vcpu, exit_code);
 
-static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
-{
 	/*
 	 * If we were in HYP context on entry, adjust the PSTATE view
 	 * so that the usual helpers work correctly.
@@ -457,6 +446,8 @@ static void early_exit_filter(struct kvm_vcpu *vcpu, u64 *exit_code)
 		*vcpu_cpsr(vcpu) &= ~(PSR_MODE_MASK | PSR_MODE32_BIT);
 		*vcpu_cpsr(vcpu) |= mode;
 	}
+
+	return __fixup_guest_exit(vcpu, exit_code, hyp_exit_handlers);
 }
 
 /* Switch to the guest for VHE systems running in EL2 */
@@ -471,6 +462,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	sysreg_save_host_state_vhe(host_ctxt);
 
+	fpsimd_lazy_switch_to_guest(vcpu);
+
 	/*
 	 * Note that ARM erratum 1165522 requires us to configure both stage 1
 	 * and stage 2 translation for the guest context before we clear
@@ -495,6 +488,8 @@ static int __kvm_vcpu_run_vhe(struct kvm_vcpu *vcpu)
 
 	__deactivate_traps(vcpu);
 
+	fpsimd_lazy_switch_to_host(vcpu);
+
 	sysreg_restore_host_state_vhe(host_ctxt);
 
 	if (guest_owns_fp_regs())
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
index 256de17f5261..ae49c908e7fb 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
+++ b/arch/riscv/boot/dts/starfive/jh7110-pinfunc.h
@@ -89,7 +89,7 @@
 #define GPOUT_SYS_SDIO1_DATA1			59
 #define GPOUT_SYS_SDIO1_DATA2			60
 #define GPOUT_SYS_SDIO1_DATA3			61
-#define GPOUT_SYS_SDIO1_DATA4			63
+#define GPOUT_SYS_SDIO1_DATA4			62
 #define GPOUT_SYS_SDIO1_DATA5			63
 #define GPOUT_SYS_SDIO1_DATA6			64
 #define GPOUT_SYS_SDIO1_DATA7			65
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index c20eb63750f5..43aba57b48f0 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -172,9 +172,10 @@ static void free_slice(struct kref *kref)
 static int clone_range_of_sgt_for_slice(struct qaic_device *qdev, struct sg_table **sgt_out,
 					struct sg_table *sgt_in, u64 size, u64 offset)
 {
-	int total_len, len, nents, offf = 0, offl = 0;
 	struct scatterlist *sg, *sgn, *sgf, *sgl;
+	unsigned int len, nents, offf, offl;
 	struct sg_table *sgt;
+	size_t total_len;
 	int ret, j;
 
 	/* find out number of relevant nents needed for this mem */
@@ -182,6 +183,8 @@ static int clone_range_of_sgt_for_slice(struct qaic_device *qdev, struct sg_tabl
 	sgf = NULL;
 	sgl = NULL;
 	nents = 0;
+	offf = 0;
+	offl = 0;
 
 	size = size ? size : PAGE_SIZE;
 	for_each_sgtable_dma_sg(sgt_in, sg, j) {
@@ -554,6 +557,7 @@ static bool invalid_sem(struct qaic_sem *sem)
 static int qaic_validate_req(struct qaic_device *qdev, struct qaic_attach_slice_entry *slice_ent,
 			     u32 count, u64 total_size)
 {
+	u64 total;
 	int i;
 
 	for (i = 0; i < count; i++) {
@@ -563,7 +567,8 @@ static int qaic_validate_req(struct qaic_device *qdev, struct qaic_attach_slice_
 		      invalid_sem(&slice_ent[i].sem2) || invalid_sem(&slice_ent[i].sem3))
 			return -EINVAL;
 
-		if (slice_ent[i].offset + slice_ent[i].size > total_size)
+		if (check_add_overflow(slice_ent[i].offset, slice_ent[i].size, &total) ||
+		    total > total_size)
 			return -EINVAL;
 	}
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index c085dd81ebe7..d956735e2a76 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2845,6 +2845,10 @@ int ata_dev_configure(struct ata_device *dev)
 	    (id[ATA_ID_SATA_CAPABILITY] & 0xe) == 0x2)
 		dev->quirks |= ATA_QUIRK_NOLPM;
 
+	if (dev->quirks & ATA_QUIRK_NO_LPM_ON_ATI &&
+	    ata_dev_check_adapter(dev, PCI_VENDOR_ID_ATI))
+		dev->quirks |= ATA_QUIRK_NOLPM;
+
 	if (ap->flags & ATA_FLAG_NO_LPM)
 		dev->quirks |= ATA_QUIRK_NOLPM;
 
@@ -3897,6 +3901,7 @@ static const char * const ata_quirk_names[] = {
 	[__ATA_QUIRK_MAX_SEC_1024]	= "maxsec1024",
 	[__ATA_QUIRK_MAX_TRIM_128M]	= "maxtrim128m",
 	[__ATA_QUIRK_NO_NCQ_ON_ATI]	= "noncqonati",
+	[__ATA_QUIRK_NO_LPM_ON_ATI]	= "nolpmonati",
 	[__ATA_QUIRK_NO_ID_DEV_LOG]	= "noiddevlog",
 	[__ATA_QUIRK_NO_LOG_DIR]	= "nologdir",
 	[__ATA_QUIRK_NO_FUA]		= "nofua",
@@ -4142,13 +4147,16 @@ static const struct ata_dev_quirks_entry __ata_dev_quirks[] = {
 						ATA_QUIRK_ZERO_AFTER_TRIM },
 	{ "Samsung SSD 860*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
-						ATA_QUIRK_NO_NCQ_ON_ATI },
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NO_LPM_ON_ATI },
 	{ "Samsung SSD 870*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
-						ATA_QUIRK_NO_NCQ_ON_ATI },
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NO_LPM_ON_ATI },
 	{ "SAMSUNG*MZ7LH*",		NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM |
-						ATA_QUIRK_NO_NCQ_ON_ATI, },
+						ATA_QUIRK_NO_NCQ_ON_ATI |
+						ATA_QUIRK_NO_LPM_ON_ATI },
 	{ "FCCT*M500*",			NULL,	ATA_QUIRK_NO_NCQ_TRIM |
 						ATA_QUIRK_ZERO_AFTER_TRIM },
 
diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 32019dc33cca..1877201d1aa9 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -505,7 +505,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
 	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
 			      &dpll_pin_xa_id, GFP_KERNEL);
-	if (ret)
+	if (ret < 0)
 		goto err_xa_alloc;
 	return pin;
 err_xa_alloc:
diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/efi/libstub/randomalloc.c
index 8ad3efb9b1ff..593e98e3b993 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -75,6 +75,10 @@ efi_status_t efi_random_alloc(unsigned long size,
 	if (align < EFI_ALLOC_ALIGN)
 		align = EFI_ALLOC_ALIGN;
 
+	/* Avoid address 0x0, as it can be mistaken for NULL */
+	if (alloc_min == 0)
+		alloc_min = align;
+
 	size = round_up(size, EFI_ALLOC_ALIGN);
 
 	/* count the suitable slots in each memory map entry */
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 1dd4362ef9a3..8c28e25ddc8a 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -280,6 +280,7 @@ static int imx_scu_probe(struct platform_device *pdev)
 		return ret;
 
 	sc_ipc->fast_ipc = of_device_is_compatible(args.np, "fsl,imx8-mu-scu");
+	of_node_put(args.np);
 
 	num_channel = sc_ipc->fast_ipc ? 2 : SCU_MU_CHAN_NUM;
 	for (i = 0; i < num_channel; i++) {
diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 447246bd04be..98a463e9774b 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -814,15 +814,6 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 
 	qcuefi->client = container_of(aux_dev, struct qseecom_client, aux_dev);
 
-	auxiliary_set_drvdata(aux_dev, qcuefi);
-	status = qcuefi_set_reference(qcuefi);
-	if (status)
-		return status;
-
-	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
-	if (status)
-		qcuefi_set_reference(NULL);
-
 	memset(&pool_config, 0, sizeof(pool_config));
 	pool_config.initial_size = SZ_4K;
 	pool_config.policy = QCOM_TZMEM_POLICY_MULTIPLIER;
@@ -833,6 +824,15 @@ static int qcom_uefisecapp_probe(struct auxiliary_device *aux_dev,
 	if (IS_ERR(qcuefi->mempool))
 		return PTR_ERR(qcuefi->mempool);
 
+	auxiliary_set_drvdata(aux_dev, qcuefi);
+	status = qcuefi_set_reference(qcuefi);
+	if (status)
+		return status;
+
+	status = efivars_register(&qcuefi->efivars, &qcom_efivar_ops);
+	if (status)
+		qcuefi_set_reference(NULL);
+
 	return status;
 }
 
diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 2e093c39b610..23aefbf6fca5 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2054,8 +2054,8 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	__scm->mempool = devm_qcom_tzmem_pool_new(__scm->dev, &pool_config);
 	if (IS_ERR(__scm->mempool)) {
-		dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
-			      "Failed to create the SCM memory pool\n");
+		ret = dev_err_probe(__scm->dev, PTR_ERR(__scm->mempool),
+				    "Failed to create the SCM memory pool\n");
 		goto err;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ca130880edfd..d3798a333d1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -2395,7 +2395,7 @@ static int gfx_v12_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
 				      (void **)&adev->gfx.me.me_fw_data_ptr);
 	if (r) {
 		dev_err(adev->dev, "(%d) failed to create me data bo\n", r);
-		gfx_v12_0_pfp_fini(adev);
+		gfx_v12_0_me_fini(adev);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 9c6824e1c156..60acf676000b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -498,9 +498,6 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 				 uint64_t *flags)
 {
 	struct amdgpu_bo *bo = mapping->bo_va->base.bo;
-	struct amdgpu_device *bo_adev;
-	bool coherent, is_system;
-
 
 	*flags &= ~AMDGPU_PTE_EXECUTABLE;
 	*flags |= mapping->flags & AMDGPU_PTE_EXECUTABLE;
@@ -516,26 +513,11 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (!bo)
-		return;
-
-	if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
-
-	bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
-	is_system = bo->tbo.resource &&
-		(bo->tbo.resource->mem_type == TTM_PL_TT ||
-		 bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT);
-
 	if (bo && bo->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
 		*flags |= AMDGPU_PTE_DCC;
 
-	/* WA for HW bug */
-	if (is_system || ((bo_adev != adev) && coherent))
-		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
-
+	if (bo && bo->flags & AMDGPU_GEM_CREATE_UNCACHED)
+		*flags = AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
 }
 
 static unsigned gmc_v12_0_get_vbios_fb_size(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 73065a85e0d2..4f94a119d627 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -78,12 +78,12 @@ static const struct amdgpu_video_codecs nv_video_codecs_encode = {
 
 /* Navi1x */
 static const struct amdgpu_video_codec_info nv_video_codecs_decode_array[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
 };
 
@@ -104,10 +104,10 @@ static const struct amdgpu_video_codecs sc_video_codecs_encode = {
 };
 
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
@@ -115,10 +115,10 @@ static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn0[]
 };
 
 static const struct amdgpu_video_codec_info sc_video_codecs_decode_array_vcn1[] = {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 307185c0e1b8..4cbe0da100d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -103,12 +103,11 @@ static const struct amdgpu_video_codecs vega_video_codecs_encode =
 /* Vega */
 static const struct amdgpu_video_codec_info vega_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
 };
 
 static const struct amdgpu_video_codecs vega_video_codecs_decode =
@@ -120,12 +119,12 @@ static const struct amdgpu_video_codecs vega_video_codecs_decode =
 /* Raven */
 static const struct amdgpu_video_codec_info rv_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 4096, 4096, 186)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 4096, 4096, 0)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 8192, 8192, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 4096, 4096, 0)},
 };
 
@@ -138,10 +137,10 @@ static const struct amdgpu_video_codecs rv_video_codecs_decode =
 /* Renoir, Arcturus */
 static const struct amdgpu_video_codec_info rn_video_codecs_decode_array[] =
 {
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 4096, 4096, 3)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 4096, 4096, 5)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2, 1920, 1088, 3)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4, 1920, 1088, 5)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4_AVC, 4096, 4096, 52)},
-	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 4096, 4096, 4)},
+	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1, 1920, 1088, 4)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_HEVC, 8192, 4352, 186)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG, 16384, 16384, 0)},
 	{codec_info_build(AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VP9, 8192, 4352, 0)},
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 792b2eb6bbac..48ab93e715c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -167,16 +167,16 @@ static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
 {
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 3,
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 5,
 	},
 	{
@@ -188,9 +188,9 @@ static const struct amdgpu_video_codec_info tonga_video_codecs_decode_array[] =
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 4,
 	},
 };
@@ -206,16 +206,16 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 {
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG2,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 3,
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_MPEG4,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 5,
 	},
 	{
@@ -227,9 +227,9 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 	},
 	{
 		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_VC1,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
+		.max_width = 1920,
+		.max_height = 1088,
+		.max_pixels_per_frame = 1920 * 1088,
 		.max_level = 4,
 	},
 	{
@@ -239,13 +239,6 @@ static const struct amdgpu_video_codec_info cz_video_codecs_decode_array[] =
 		.max_pixels_per_frame = 4096 * 4096,
 		.max_level = 186,
 	},
-	{
-		.codec_type = AMDGPU_INFO_VIDEO_CAPS_CODEC_IDX_JPEG,
-		.max_width = 4096,
-		.max_height = 4096,
-		.max_pixels_per_frame = 4096 * 4096,
-		.max_level = 0,
-	},
 };
 
 static const struct amdgpu_video_codecs cz_video_codecs_decode =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 80c85b6cc478..29d7cb4cfe69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -233,6 +233,7 @@ void kfd_queue_buffer_put(struct amdgpu_bo **bo)
 int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	struct kfd_topology_device *topo_dev;
+	u64 expected_queue_size;
 	struct amdgpu_vm *vm;
 	u32 total_cwsr_size;
 	int err;
@@ -241,6 +242,15 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 	if (!topo_dev)
 		return -EINVAL;
 
+	/* AQL queues on GFX7 and GFX8 appear twice their actual size */
+	if (properties->type == KFD_QUEUE_TYPE_COMPUTE &&
+	    properties->format == KFD_QUEUE_FORMAT_AQL &&
+	    topo_dev->node_props.gfx_target_version >= 70000 &&
+	    topo_dev->node_props.gfx_target_version < 90000)
+		expected_queue_size = properties->queue_size / 2;
+	else
+		expected_queue_size = properties->queue_size;
+
 	vm = drm_priv_to_vm(pdd->drm_priv);
 	err = amdgpu_bo_reserve(vm->root.bo, false);
 	if (err)
@@ -255,7 +265,7 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 		goto out_err_unreserve;
 
 	err = kfd_queue_buffer_get(vm, (void *)properties->queue_address,
-				   &properties->ring_bo, properties->queue_size);
+				   &properties->ring_bo, expected_queue_size);
 	if (err)
 		goto out_err_unreserve;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 1893c27746a5..8c61dee5ca0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1276,13 +1276,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
 		break;
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-		if (domain == SVM_RANGE_VRAM_DOMAIN) {
-			if (bo_node != node)
-				mapping_flags |= AMDGPU_VM_MTYPE_NC;
-		} else {
-			mapping_flags |= coherent ?
-				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
-		}
+		mapping_flags |= AMDGPU_VM_MTYPE_NC;
 		break;
 	default:
 		mapping_flags |= coherent ?
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0688a428ee4f..d9a3917d207e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1720,7 +1720,7 @@ static void retrieve_dmi_info(struct amdgpu_display_manager *dm, struct dc_init_
 	}
 	if (quirk_entries.support_edp0_on_dp1) {
 		init_data->flags.support_edp0_on_dp1 = true;
-		drm_info(dev, "aux_hpd_discon_quirk attached\n");
+		drm_info(dev, "support_edp0_on_dp1 attached\n");
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
index bf636b28e3e1..6e2fce329d73 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_hw_lock_mgr.c
@@ -69,5 +69,16 @@ bool should_use_dmub_lock(struct dc_link *link)
 	if (link->replay_settings.replay_feature_enabled)
 		return true;
 
+	/* only use HW lock for PSR1 on single eDP */
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_1) {
+		struct dc_link *edp_links[MAX_NUM_EDP];
+		int edp_num;
+
+		dc_get_edp_links(link->dc, edp_links, &edp_num);
+
+		if (edp_num == 1)
+			return true;
+	}
+
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 0fa6fbee1978..bfdfba676025 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2493,6 +2493,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
 		case IP_VERSION(11, 0, 3):
+		case IP_VERSION(12, 0, 0):
+		case IP_VERSION(12, 0, 1):
 			*states = ATTR_STATE_SUPPORTED;
 			break;
 		default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 9ec53431f2c3..e98a6a2f3e6a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1206,16 +1206,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
 			break;
 
-		PPTable_t *pptable = smu->smu_table.driver_pptable;
-		const OverDriveLimits_t * const overdrive_upperlimits =
-					&pptable->SkuTable.OverDriveLimitsBasicMax;
-		const OverDriveLimits_t * const overdrive_lowerlimits =
-					&pptable->SkuTable.OverDriveLimitsBasicMin;
-
 		size += sysfs_emit_at(buf, size, "OD_SCLK_OFFSET:\n");
-		size += sysfs_emit_at(buf, size, "0: %dMhz\n1: %uMhz\n",
-					overdrive_lowerlimits->GfxclkFoffset,
-					overdrive_upperlimits->GfxclkFoffset);
+		size += sysfs_emit_at(buf, size, "%dMhz\n",
+					od_table->OverDriveTable.GfxclkFoffset);
 		break;
 
 	case SMU_OD_MCLK:
@@ -1349,13 +1342,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
 
 		if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT)) {
-			smu_v14_0_2_get_od_setting_limits(smu,
-							  PP_OD_FEATURE_GFXCLK_FMIN,
-							  &min_value,
-							  NULL);
 			smu_v14_0_2_get_od_setting_limits(smu,
 							  PP_OD_FEATURE_GFXCLK_FMAX,
-							  NULL,
+							  &min_value,
 							  &max_value);
 			size += sysfs_emit_at(buf, size, "SCLK_OFFSET: %7dMhz %10uMhz\n",
 					      min_value, max_value);
@@ -1639,6 +1628,39 @@ static void smu_v14_0_2_get_unique_id(struct smu_context *smu)
 	adev->unique_id = ((uint64_t)upper32 << 32) | lower32;
 }
 
+static int smu_v14_0_2_get_fan_speed_pwm(struct smu_context *smu,
+					 uint32_t *speed)
+{
+	int ret;
+
+	if (!speed)
+		return -EINVAL;
+
+	ret = smu_v14_0_2_get_smu_metrics_data(smu,
+					       METRICS_CURR_FANPWM,
+					       speed);
+	if (ret) {
+		dev_err(smu->adev->dev, "Failed to get fan speed(PWM)!");
+		return ret;
+	}
+
+	/* Convert the PMFW output which is in percent to pwm(255) based */
+	*speed = min(*speed * 255 / 100, (uint32_t)255);
+
+	return 0;
+}
+
+static int smu_v14_0_2_get_fan_speed_rpm(struct smu_context *smu,
+					 uint32_t *speed)
+{
+	if (!speed)
+		return -EINVAL;
+
+	return smu_v14_0_2_get_smu_metrics_data(smu,
+						METRICS_CURR_FANSPEED,
+						speed);
+}
+
 static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 				       uint32_t *current_power_limit,
 				       uint32_t *default_power_limit,
@@ -2429,36 +2451,24 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 			return -ENOTSUPP;
 		}
 
-		for (i = 0; i < size; i += 2) {
-			if (i + 2 > size) {
-				dev_info(adev->dev, "invalid number of input parameters %d\n", size);
-				return -EINVAL;
-			}
-
-			switch (input[i]) {
-			case 1:
-				smu_v14_0_2_get_od_setting_limits(smu,
-								  PP_OD_FEATURE_GFXCLK_FMAX,
-								  &minimum,
-								  &maximum);
-				if (input[i + 1] < minimum ||
-				    input[i + 1] > maximum) {
-					dev_info(adev->dev, "GfxclkFmax (%ld) must be within [%u, %u]!\n",
-						input[i + 1], minimum, maximum);
-					return -EINVAL;
-				}
-
-				od_table->OverDriveTable.GfxclkFoffset = input[i + 1];
-				od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
-				break;
+		if (size != 1) {
+			dev_info(adev->dev, "invalid number of input parameters %d\n", size);
+			return -EINVAL;
+		}
 
-			default:
-				dev_info(adev->dev, "Invalid SCLK_VDDC_TABLE index: %ld\n", input[i]);
-				dev_info(adev->dev, "Supported indices: [0:min,1:max]\n");
-				return -EINVAL;
-			}
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_GFXCLK_FMAX,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "GfxclkFoffset must be within [%d, %u]!\n",
+				 minimum, maximum);
+			return -EINVAL;
 		}
 
+		od_table->OverDriveTable.GfxclkFoffset = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= 1U << PP_OD_FEATURE_GFXCLK_BIT;
 		break;
 
 	case PP_OD_EDIT_MCLK_VDDC_TABLE:
@@ -2817,6 +2827,8 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.set_performance_level = smu_v14_0_set_performance_level,
 	.gfx_off_control = smu_v14_0_gfx_off_control,
 	.get_unique_id = smu_v14_0_2_get_unique_id,
+	.get_fan_speed_pwm = smu_v14_0_2_get_fan_speed_pwm,
+	.get_fan_speed_rpm = smu_v14_0_2_get_fan_speed_rpm,
 	.get_power_limit = smu_v14_0_2_get_power_limit,
 	.set_power_limit = smu_v14_0_2_set_power_limit,
 	.get_power_profile_mode = smu_v14_0_2_get_power_profile_mode,
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index d1871af967d4..2355a78e1b69 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -557,7 +557,7 @@ int radeon_vce_cs_parse(struct radeon_cs_parser *p)
 {
 	int session_idx = -1;
 	bool destroyed = false, created = false, allocated = false;
-	uint32_t tmp, handle = 0;
+	uint32_t tmp = 0, handle = 0;
 	uint32_t *size = &tmp;
 	int i, r = 0;
 
diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index a75eede8bf8d..002057be0d84 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -259,9 +259,16 @@ static void drm_sched_entity_kill(struct drm_sched_entity *entity)
 		struct drm_sched_fence *s_fence = job->s_fence;
 
 		dma_fence_get(&s_fence->finished);
-		if (!prev || dma_fence_add_callback(prev, &job->finish_cb,
-					   drm_sched_entity_kill_jobs_cb))
+		if (!prev ||
+		    dma_fence_add_callback(prev, &job->finish_cb,
+					   drm_sched_entity_kill_jobs_cb)) {
+			/*
+			 * Adding callback above failed.
+			 * dma_fence_put() checks for NULL.
+			 */
+			dma_fence_put(prev);
 			drm_sched_entity_kill_jobs_cb(NULL, &job->finish_cb);
+		}
 
 		prev = &s_fence->finished;
 	}
diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index 4f935f1d50a9..3066cfdb054c 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -319,11 +319,15 @@ v3d_tfu_job_run(struct drm_sched_job *sched_job)
 	struct drm_device *dev = &v3d->drm;
 	struct dma_fence *fence;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
+	v3d->tfu_job = job;
+
 	fence = v3d_fence_create(v3d, V3D_TFU);
 	if (IS_ERR(fence))
 		return NULL;
 
-	v3d->tfu_job = job;
 	if (job->base.irq_fence)
 		dma_fence_put(job->base.irq_fence);
 	job->base.irq_fence = dma_fence_get(fence);
@@ -361,6 +365,9 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence;
 	int i, csd_cfg0_reg;
 
+	if (unlikely(job->base.base.s_fence->finished.error))
+		return NULL;
+
 	v3d->csd_job = job;
 
 	v3d_invalidate_caches(v3d);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 6e4be52306df..d22269a230aa 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -314,7 +314,6 @@ static inline unsigned int xe_sg_segment_size(struct device *dev)
 
 #define i915_gem_object_flush_if_display(obj)		((void)(obj))
 
-#if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 /**
  * xe_bo_is_mem_type - Whether the bo currently resides in the given
  * TTM memory type
@@ -329,4 +328,3 @@ static inline bool xe_bo_is_mem_type(struct xe_bo *bo, u32 mem_type)
 	return bo->ttm.resource->mem_type == mem_type;
 }
 #endif
-#endif
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 68f309f5e981..f3bf7d3157b4 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -58,7 +58,7 @@ static int xe_dma_buf_pin(struct dma_buf_attachment *attach)
 	 * 1) Avoid pinning in a placement not accessible to some importers.
 	 * 2) Pinning in VRAM requires PIN accounting which is a to-do.
 	 */
-	if (xe_bo_is_pinned(bo) && bo->ttm.resource->placement != XE_PL_TT) {
+	if (xe_bo_is_pinned(bo) && !xe_bo_is_mem_type(bo, XE_PL_TT)) {
 		drm_dbg(&xe->drm, "Can't migrate pinned bo for dma-buf pin.\n");
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 710674ef40a9..3f23a7d91519 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -367,6 +367,10 @@ static bool host1x_wants_iommu(struct host1x *host1x)
 	return true;
 }
 
+/*
+ * Returns ERR_PTR on failure, NULL if the translation is IDENTITY, otherwise a
+ * valid paging domain.
+ */
 static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 {
 	struct iommu_domain *domain = iommu_get_domain_for_dev(host->dev);
@@ -391,6 +395,8 @@ static struct iommu_domain *host1x_iommu_attach(struct host1x *host)
 	 * Similarly, if host1x is already attached to an IOMMU (via the DMA
 	 * API), don't try to attach again.
 	 */
+	if (domain && domain->type == IOMMU_DOMAIN_IDENTITY)
+		domain = NULL;
 	if (!host1x_wants_iommu(host) || domain)
 		return domain;
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 1d9ad25c89ae..8c9cf08ad45e 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1048,23 +1048,6 @@ static int omap_i2c_transmit_data(struct omap_i2c_dev *omap, u8 num_bytes,
 	return 0;
 }
 
-static irqreturn_t
-omap_i2c_isr(int irq, void *dev_id)
-{
-	struct omap_i2c_dev *omap = dev_id;
-	irqreturn_t ret = IRQ_HANDLED;
-	u16 mask;
-	u16 stat;
-
-	stat = omap_i2c_read_reg(omap, OMAP_I2C_STAT_REG);
-	mask = omap_i2c_read_reg(omap, OMAP_I2C_IE_REG) & ~OMAP_I2C_STAT_NACK;
-
-	if (stat & mask)
-		ret = IRQ_WAKE_THREAD;
-
-	return ret;
-}
-
 static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 {
 	u16 bits;
@@ -1095,8 +1078,13 @@ static int omap_i2c_xfer_data(struct omap_i2c_dev *omap)
 		}
 
 		if (stat & OMAP_I2C_STAT_NACK) {
-			err |= OMAP_I2C_STAT_NACK;
+			omap->cmd_err |= OMAP_I2C_STAT_NACK;
 			omap_i2c_ack_stat(omap, OMAP_I2C_STAT_NACK);
+
+			if (!(stat & ~OMAP_I2C_STAT_NACK)) {
+				err = -EAGAIN;
+				break;
+			}
 		}
 
 		if (stat & OMAP_I2C_STAT_AL) {
@@ -1472,7 +1460,7 @@ omap_i2c_probe(struct platform_device *pdev)
 				IRQF_NO_SUSPEND, pdev->name, omap);
 	else
 		r = devm_request_threaded_irq(&pdev->dev, omap->irq,
-				omap_i2c_isr, omap_i2c_isr_thread,
+				NULL, omap_i2c_isr_thread,
 				IRQF_NO_SUSPEND | IRQF_ONESHOT,
 				pdev->name, omap);
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 613b5fc70e13..7436ce551579 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1216,8 +1216,6 @@ static void __modify_flags_from_init_state(struct bnxt_qplib_qp *qp)
 			qp->path_mtu =
 				CMDQ_MODIFY_QP_PATH_MTU_MTU_2048;
 		}
-		qp->modify_flags &=
-			~CMDQ_MODIFY_QP_MODIFY_MASK_VLAN_ID;
 		/* Bono FW require the max_dest_rd_atomic to be >= 1 */
 		if (qp->max_dest_rd_atomic < 1)
 			qp->max_dest_rd_atomic = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 07779aeb7575..a4deb45ec849 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -283,9 +283,10 @@ int bnxt_qplib_deinit_rcfw(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 			 struct bnxt_qplib_ctx *ctx, int is_virtfn);
 void bnxt_qplib_mark_qp_error(void *qp_handle);
+
 static inline u32 map_qp_id_to_tbl_indx(u32 qid, struct bnxt_qplib_rcfw *rcfw)
 {
 	/* Last index of the qp_tbl is for QP1 ie. qp_tbl_size - 1*/
-	return (qid == 1) ? rcfw->qp_tbl_size - 1 : qid % rcfw->qp_tbl_size - 2;
+	return (qid == 1) ? rcfw->qp_tbl_size - 1 : (qid % (rcfw->qp_tbl_size - 2));
 }
 #endif /* __BNXT_QPLIB_RCFW_H__ */
diff --git a/drivers/infiniband/hw/hns/hns_roce_alloc.c b/drivers/infiniband/hw/hns/hns_roce_alloc.c
index 950c133d4220..6ee911f6885b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_alloc.c
+++ b/drivers/infiniband/hw/hns/hns_roce_alloc.c
@@ -175,8 +175,10 @@ void hns_roce_cleanup_bitmap(struct hns_roce_dev *hr_dev)
 	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_XRC)
 		ida_destroy(&hr_dev->xrcd_ida.ida);
 
-	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ)
+	if (hr_dev->caps.flags & HNS_ROCE_CAP_FLAG_SRQ) {
 		ida_destroy(&hr_dev->srq_table.srq_ida.ida);
+		xa_destroy(&hr_dev->srq_table.xa);
+	}
 	hns_roce_cleanup_qp_table(hr_dev);
 	hns_roce_cleanup_cq_table(hr_dev);
 	ida_destroy(&hr_dev->mr_table.mtpt_ida.ida);
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 4106423a1b39..3a5c93c9fb3e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -537,5 +537,6 @@ void hns_roce_cleanup_cq_table(struct hns_roce_dev *hr_dev)
 
 	for (i = 0; i < HNS_ROCE_CQ_BANK_NUM; i++)
 		ida_destroy(&hr_dev->cq_table.bank[i].ida);
+	xa_destroy(&hr_dev->cq_table.array);
 	mutex_destroy(&hr_dev->cq_table.bank_mutex);
 }
diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index 605562122ecc..ca0798224e56 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1361,6 +1361,11 @@ static int hem_list_alloc_root_bt(struct hns_roce_dev *hr_dev,
 	return ret;
 }
 
+/* This is the bottom bt pages number of a 100G MR on 4K OS, assuming
+ * the bt page size is not expanded by cal_best_bt_pg_sz()
+ */
+#define RESCHED_LOOP_CNT_THRESHOLD_ON_4K 12800
+
 /* construct the base address table and link them by address hop config */
 int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			      struct hns_roce_hem_list *hem_list,
@@ -1369,6 +1374,7 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 {
 	const struct hns_roce_buf_region *r;
 	int ofs, end;
+	int loop;
 	int unit;
 	int ret;
 	int i;
@@ -1386,7 +1392,10 @@ int hns_roce_hem_list_request(struct hns_roce_dev *hr_dev,
 			continue;
 
 		end = r->offset + r->count;
-		for (ofs = r->offset; ofs < end; ofs += unit) {
+		for (ofs = r->offset, loop = 1; ofs < end; ofs += unit, loop++) {
+			if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+				cond_resched();
+
 			ret = hem_list_alloc_mid_bt(hr_dev, r, unit, ofs,
 						    hem_list->mid_bt[i],
 						    &hem_list->btm_bt);
@@ -1443,9 +1452,14 @@ void *hns_roce_hem_list_find_mtt(struct hns_roce_dev *hr_dev,
 	struct list_head *head = &hem_list->btm_bt;
 	struct hns_roce_hem_item *hem, *temp_hem;
 	void *cpu_base = NULL;
+	int loop = 1;
 	int nr = 0;
 
 	list_for_each_entry_safe(hem, temp_hem, head, sibling) {
+		if (!(loop % RESCHED_LOOP_CNT_THRESHOLD_ON_4K))
+			cond_resched();
+		loop++;
+
 		if (hem_list_page_is_in_range(hem, offset)) {
 			nr = offset - hem->start;
 			cpu_base = hem->addr + nr * BA_BYTE_LEN;
diff --git a/drivers/infiniband/hw/hns/hns_roce_main.c b/drivers/infiniband/hw/hns/hns_roce_main.c
index ae24c81c9812..cf89a8db4f64 100644
--- a/drivers/infiniband/hw/hns/hns_roce_main.c
+++ b/drivers/infiniband/hw/hns/hns_roce_main.c
@@ -183,7 +183,7 @@ static int hns_roce_query_device(struct ib_device *ib_dev,
 				  IB_DEVICE_RC_RNR_NAK_GEN;
 	props->max_send_sge = hr_dev->caps.max_sq_sg;
 	props->max_recv_sge = hr_dev->caps.max_rq_sg;
-	props->max_sge_rd = 1;
+	props->max_sge_rd = hr_dev->caps.max_sq_sg;
 	props->max_cq = hr_dev->caps.num_cqs;
 	props->max_cqe = hr_dev->caps.max_cqes;
 	props->max_mr = hr_dev->caps.num_mtpts;
diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 9e2e76c59406..8901c142c1b6 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -868,12 +868,14 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 			    struct hns_roce_ib_create_qp *ucmd,
 			    struct hns_roce_ib_create_qp_resp *resp)
 {
+	bool has_sdb = user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd);
 	struct hns_roce_ucontext *uctx = rdma_udata_to_drv_context(udata,
 		struct hns_roce_ucontext, ibucontext);
+	bool has_rdb = user_qp_has_rdb(hr_dev, init_attr, udata, resp);
 	struct ib_device *ibdev = &hr_dev->ib_dev;
 	int ret;
 
-	if (user_qp_has_sdb(hr_dev, init_attr, udata, resp, ucmd)) {
+	if (has_sdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->sdb_addr, &hr_qp->sdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -884,7 +886,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 		hr_qp->en_flags |= HNS_ROCE_QP_CAP_SQ_RECORD_DB;
 	}
 
-	if (user_qp_has_rdb(hr_dev, init_attr, udata, resp)) {
+	if (has_rdb) {
 		ret = hns_roce_db_map_user(uctx, ucmd->db_addr, &hr_qp->rdb);
 		if (ret) {
 			ibdev_err(ibdev,
@@ -898,7 +900,7 @@ static int alloc_user_qp_db(struct hns_roce_dev *hr_dev,
 	return 0;
 
 err_sdb:
-	if (hr_qp->en_flags & HNS_ROCE_QP_CAP_SQ_RECORD_DB)
+	if (has_sdb)
 		hns_roce_db_unmap_user(uctx, &hr_qp->sdb);
 err_out:
 	return ret;
@@ -1119,24 +1121,23 @@ static int set_qp_param(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp,
 						 ibucontext);
 		hr_qp->config = uctx->config;
 		ret = set_user_sq_size(hr_dev, &init_attr->cap, hr_qp, ucmd);
-		if (ret)
+		if (ret) {
 			ibdev_err(ibdev,
 				  "failed to set user SQ size, ret = %d.\n",
 				  ret);
+			return ret;
+		}
 
 		ret = set_congest_param(hr_dev, hr_qp, ucmd);
-		if (ret)
-			return ret;
 	} else {
 		if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
 			hr_qp->config = HNS_ROCE_EXSGE_FLAGS;
+		default_congest_type(hr_dev, hr_qp);
 		ret = set_kernel_sq_size(hr_dev, &init_attr->cap, hr_qp);
 		if (ret)
 			ibdev_err(ibdev,
 				  "failed to set kernel SQ size, ret = %d.\n",
 				  ret);
-
-		default_congest_type(hr_dev, hr_qp);
 	}
 
 	return ret;
@@ -1219,7 +1220,7 @@ static int hns_roce_create_qp_common(struct hns_roce_dev *hr_dev,
 				       min(udata->outlen, sizeof(resp)));
 		if (ret) {
 			ibdev_err(ibdev, "copy qp resp failed!\n");
-			goto err_store;
+			goto err_flow_ctrl;
 		}
 	}
 
@@ -1602,6 +1603,7 @@ void hns_roce_cleanup_qp_table(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < HNS_ROCE_QP_BANK_NUM; i++)
 		ida_destroy(&hr_dev->qp_table.bank[i].ida);
 	xa_destroy(&hr_dev->qp_table.dip_xa);
+	xa_destroy(&hr_dev->qp_table_xa);
 	mutex_destroy(&hr_dev->qp_table.bank_mutex);
 	mutex_destroy(&hr_dev->qp_table.scc_mutex);
 }
diff --git a/drivers/infiniband/hw/mlx5/ah.c b/drivers/infiniband/hw/mlx5/ah.c
index 99036afb3aef..531a57f9ee7e 100644
--- a/drivers/infiniband/hw/mlx5/ah.c
+++ b/drivers/infiniband/hw/mlx5/ah.c
@@ -50,11 +50,12 @@ static __be16 mlx5_ah_get_udp_sport(const struct mlx5_ib_dev *dev,
 	return sport;
 }
 
-static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
+static int create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 			 struct rdma_ah_init_attr *init_attr)
 {
 	struct rdma_ah_attr *ah_attr = init_attr->ah_attr;
 	enum ib_gid_type gid_type;
+	int rate_val;
 
 	if (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) {
 		const struct ib_global_route *grh = rdma_ah_read_grh(ah_attr);
@@ -67,8 +68,10 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.tclass = grh->traffic_class;
 	}
 
-	ah->av.stat_rate_sl =
-		(mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr)) << 4);
+	rate_val = mlx5r_ib_rate(dev, rdma_ah_get_static_rate(ah_attr));
+	if (rate_val < 0)
+		return rate_val;
+	ah->av.stat_rate_sl = rate_val << 4;
 
 	if (ah_attr->type == RDMA_AH_ATTR_TYPE_ROCE) {
 		if (init_attr->xmit_slave)
@@ -89,6 +92,8 @@ static void create_ib_ah(struct mlx5_ib_dev *dev, struct mlx5_ib_ah *ah,
 		ah->av.fl_mlid = rdma_ah_get_path_bits(ah_attr) & 0x7f;
 		ah->av.stat_rate_sl |= (rdma_ah_get_sl(ah_attr) & 0xf);
 	}
+
+	return 0;
 }
 
 int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
@@ -121,8 +126,7 @@ int mlx5_ib_create_ah(struct ib_ah *ibah, struct rdma_ah_init_attr *init_attr,
 			return err;
 	}
 
-	create_ib_ah(dev, ah, init_attr);
-	return 0;
+	return create_ib_ah(dev, ah, init_attr);
 }
 
 int mlx5_ib_query_ah(struct ib_ah *ibah, struct rdma_ah_attr *ah_attr)
diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
index 1ba4a0c8726a..e27478fe9456 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -38,10 +38,8 @@ void rxe_dealloc(struct ib_device *ib_dev)
 }
 
 /* initialize rxe device parameters */
-static void rxe_init_device_param(struct rxe_dev *rxe)
+static void rxe_init_device_param(struct rxe_dev *rxe, struct net_device *ndev)
 {
-	struct net_device *ndev;
-
 	rxe->max_inline_data			= RXE_MAX_INLINE_DATA;
 
 	rxe->attr.vendor_id			= RXE_VENDOR_ID;
@@ -74,15 +72,9 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
 	rxe->attr.max_pkeys			= RXE_MAX_PKEYS;
 	rxe->attr.local_ca_ack_delay		= RXE_LOCAL_CA_ACK_DELAY;
 
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
-
 	addrconf_addr_eui48((unsigned char *)&rxe->attr.sys_image_guid,
 			ndev->dev_addr);
 
-	dev_put(ndev);
-
 	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
 }
 
@@ -115,18 +107,13 @@ static void rxe_init_port_param(struct rxe_port *port)
 /* initialize port state, note IB convention that HCA ports are always
  * numbered from 1
  */
-static void rxe_init_ports(struct rxe_dev *rxe)
+static void rxe_init_ports(struct rxe_dev *rxe, struct net_device *ndev)
 {
 	struct rxe_port *port = &rxe->port;
-	struct net_device *ndev;
 
 	rxe_init_port_param(port);
-	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-	if (!ndev)
-		return;
 	addrconf_addr_eui48((unsigned char *)&port->port_guid,
 			    ndev->dev_addr);
-	dev_put(ndev);
 	spin_lock_init(&port->port_lock);
 }
 
@@ -144,12 +131,12 @@ static void rxe_init_pools(struct rxe_dev *rxe)
 }
 
 /* initialize rxe device state */
-static void rxe_init(struct rxe_dev *rxe)
+static void rxe_init(struct rxe_dev *rxe, struct net_device *ndev)
 {
 	/* init default device parameters */
-	rxe_init_device_param(rxe);
+	rxe_init_device_param(rxe, ndev);
 
-	rxe_init_ports(rxe);
+	rxe_init_ports(rxe, ndev);
 	rxe_init_pools(rxe);
 
 	/* init pending mmap list */
@@ -184,7 +171,7 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
 int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name,
 			struct net_device *ndev)
 {
-	rxe_init(rxe);
+	rxe_init(rxe, ndev);
 	rxe_set_mtu(rxe, mtu);
 
 	return rxe_register_device(rxe, ibdev_name, ndev);
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index cdbd2edf4b2e..8c0853dca8b9 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2499,8 +2499,10 @@ static int atmci_probe(struct platform_device *pdev)
 	/* Get MCI capabilities and set operations according to it */
 	atmci_get_cap(host);
 	ret = atmci_configure_dma(host);
-	if (ret == -EPROBE_DEFER)
+	if (ret == -EPROBE_DEFER) {
+		clk_disable_unprepare(host->mck);
 		goto err_dma_probe_defer;
+	}
 	if (ret == 0) {
 		host->prepare_data = &atmci_prepare_data_dma;
 		host->submit_data = &atmci_submit_data_dma;
diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 031a4b514d16..9d9ddc2f6f70 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
 
 	clk_disable_unprepare(priv->base_clk);
+	if (host->mmc->caps2 & MMC_CAP2_CQE) {
+		ret = cqhci_suspend(host->mmc);
+		if (ret)
+			return ret;
+	}
+
 	return sdhci_pltfm_suspend(dev);
 }
 
@@ -529,6 +536,9 @@ static int sdhci_brcmstb_resume(struct device *dev)
 			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
 	}
 
+	if (host->mmc->caps2 & MMC_CAP2_CQE)
+		ret = cqhci_resume(host->mmc);
+
 	return ret;
 }
 #endif
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..b080740bcb10 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2260,14 +2260,19 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 
 			flexcan_chip_interrupts_disable(dev);
 
+			err = flexcan_transceiver_disable(priv);
+			if (err)
+				return err;
+
 			err = pinctrl_pm_select_sleep_state(device);
 			if (err)
 				return err;
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+
+		priv->can.state = CAN_STATE_SLEEPING;
 	}
-	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
 }
@@ -2278,7 +2283,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -2292,12 +2296,20 @@ static int __maybe_unused flexcan_resume(struct device *device)
 			if (err)
 				return err;
 
-			err = flexcan_chip_start(dev);
+			err = flexcan_transceiver_enable(priv);
 			if (err)
 				return err;
 
+			err = flexcan_chip_start(dev);
+			if (err) {
+				flexcan_transceiver_disable(priv);
+				return err;
+			}
+
 			flexcan_chip_interrupts_enable(dev);
 		}
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
 
 	return 0;
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index df1a5d0b37b2..aa3df0d05b85 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -787,22 +787,14 @@ static void rcar_canfd_configure_controller(struct rcar_canfd_global *gpriv)
 }
 
 static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
-					   u32 ch)
+					   u32 ch, u32 rule_entry)
 {
-	u32 cfg;
-	int offset, start, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	int offset, page, num_rules = RCANFD_CHANNEL_NUMRULES;
+	u32 rule_entry_index = rule_entry % 16;
 	u32 ridx = ch + RCANFD_RFFIFO_IDX;
 
-	if (ch == 0) {
-		start = 0; /* Channel 0 always starts from 0th rule */
-	} else {
-		/* Get number of Channel 0 rules and adjust */
-		cfg = rcar_canfd_read(gpriv->base, RCANFD_GAFLCFG(ch));
-		start = RCANFD_GAFLCFG_GETRNC(gpriv, 0, cfg);
-	}
-
 	/* Enable write access to entry */
-	page = RCANFD_GAFL_PAGENUM(start);
+	page = RCANFD_GAFL_PAGENUM(rule_entry);
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLECTR,
 			   (RCANFD_GAFLECTR_AFLPN(gpriv, page) |
 			    RCANFD_GAFLECTR_AFLDAE));
@@ -818,13 +810,13 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 		offset = RCANFD_C_GAFL_OFFSET;
 
 	/* Accept all IDs */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLID(offset, rule_entry_index), 0);
 	/* IDE or RTR is not considered for matching */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLM(offset, rule_entry_index), 0);
 	/* Any data length accepted */
-	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, start), 0);
+	rcar_canfd_write(gpriv->base, RCANFD_GAFLP0(offset, rule_entry_index), 0);
 	/* Place the msg in corresponding Rx FIFO entry */
-	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, start),
+	rcar_canfd_set_bit(gpriv->base, RCANFD_GAFLP1(offset, rule_entry_index),
 			   RCANFD_GAFLP1_GAFLFDP(ridx));
 
 	/* Disable write access to page */
@@ -1851,6 +1843,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	unsigned long channels_mask = 0;
 	int err, ch_irq, g_irq;
 	int g_err_irq, g_recc_irq;
+	u32 rule_entry = 0;
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	int i;
@@ -2023,7 +2016,8 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 		rcar_canfd_configure_tx(gpriv, ch);
 
 		/* Configure receive rules */
-		rcar_canfd_configure_afl_rules(gpriv, ch);
+		rcar_canfd_configure_afl_rules(gpriv, ch, rule_entry);
+		rule_entry += RCANFD_CHANNEL_NUMRULES;
 	}
 
 	/* Configure common interrupts */
diff --git a/drivers/net/can/usb/ucan.c b/drivers/net/can/usb/ucan.c
index 39a63b7313a4..07406daf7c88 100644
--- a/drivers/net/can/usb/ucan.c
+++ b/drivers/net/can/usb/ucan.c
@@ -186,7 +186,7 @@ union ucan_ctl_payload {
 	 */
 	struct ucan_ctl_cmd_get_protocol_version cmd_get_protocol_version;
 
-	u8 raw[128];
+	u8 fw_str[128];
 } __packed;
 
 enum {
@@ -424,18 +424,20 @@ static int ucan_ctrl_command_out(struct ucan_priv *up,
 			       UCAN_USB_CTL_PIPE_TIMEOUT);
 }
 
-static int ucan_device_request_in(struct ucan_priv *up,
-				  u8 cmd, u16 subcmd, u16 datalen)
+static void ucan_get_fw_str(struct ucan_priv *up, char *fw_str, size_t size)
 {
-	return usb_control_msg(up->udev,
-			       usb_rcvctrlpipe(up->udev, 0),
-			       cmd,
-			       USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			       subcmd,
-			       0,
-			       up->ctl_msg_buffer,
-			       datalen,
-			       UCAN_USB_CTL_PIPE_TIMEOUT);
+	int ret;
+
+	ret = usb_control_msg(up->udev, usb_rcvctrlpipe(up->udev, 0),
+			      UCAN_DEVICE_GET_FW_STRING,
+			      USB_DIR_IN | USB_TYPE_VENDOR |
+			      USB_RECIP_DEVICE,
+			      0, 0, fw_str, size - 1,
+			      UCAN_USB_CTL_PIPE_TIMEOUT);
+	if (ret > 0)
+		fw_str[ret] = '\0';
+	else
+		strscpy(fw_str, "unknown", size);
 }
 
 /* Parse the device information structure reported by the device and
@@ -1314,7 +1316,6 @@ static int ucan_probe(struct usb_interface *intf,
 	u8 in_ep_addr;
 	u8 out_ep_addr;
 	union ucan_ctl_payload *ctl_msg_buffer;
-	char firmware_str[sizeof(union ucan_ctl_payload) + 1];
 
 	udev = interface_to_usbdev(intf);
 
@@ -1527,17 +1528,6 @@ static int ucan_probe(struct usb_interface *intf,
 	 */
 	ucan_parse_device_info(up, &ctl_msg_buffer->cmd_get_device_info);
 
-	/* just print some device information - if available */
-	ret = ucan_device_request_in(up, UCAN_DEVICE_GET_FW_STRING, 0,
-				     sizeof(union ucan_ctl_payload));
-	if (ret > 0) {
-		/* copy string while ensuring zero termination */
-		strscpy(firmware_str, up->ctl_msg_buffer->raw,
-			sizeof(union ucan_ctl_payload) + 1);
-	} else {
-		strcpy(firmware_str, "unknown");
-	}
-
 	/* device is compatible, reset it */
 	ret = ucan_ctrl_command_out(up, UCAN_COMMAND_RESET, 0, 0);
 	if (ret < 0)
@@ -1555,7 +1545,10 @@ static int ucan_probe(struct usb_interface *intf,
 
 	/* initialisation complete, log device info */
 	netdev_info(up->netdev, "registered device\n");
-	netdev_info(up->netdev, "firmware string: %s\n", firmware_str);
+	ucan_get_fw_str(up, up->ctl_msg_buffer->fw_str,
+			sizeof(up->ctl_msg_buffer->fw_str));
+	netdev_info(up->netdev, "firmware string: %s\n",
+		    up->ctl_msg_buffer->fw_str);
 
 	/* success */
 	return 0;
diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 0c2ba2fa88c4..36802e0a8b57 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -131,9 +131,10 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 	struct gdma_list_devices_resp resp = {};
 	struct gdma_general_req req = {};
 	struct gdma_dev_id dev;
-	u32 i, max_num_devs;
+	int found_dev = 0;
 	u16 dev_type;
 	int err;
+	u32 i;
 
 	mana_gd_init_req_hdr(&req.hdr, GDMA_LIST_DEVICES, sizeof(req),
 			     sizeof(resp));
@@ -145,12 +146,17 @@ static int mana_gd_detect_devices(struct pci_dev *pdev)
 		return err ? err : -EPROTO;
 	}
 
-	max_num_devs = min_t(u32, MAX_NUM_GDMA_DEVICES, resp.num_of_devs);
-
-	for (i = 0; i < max_num_devs; i++) {
+	for (i = 0; i < GDMA_DEV_LIST_SIZE &&
+	     found_dev < resp.num_of_devs; i++) {
 		dev = resp.devs[i];
 		dev_type = dev.type;
 
+		/* Skip empty devices */
+		if (dev.as_uint32 == 0)
+			continue;
+
+		found_dev++;
+
 		/* HWC is already detected in mana_hwc_create_channel(). */
 		if (dev_type == GDMA_DEVICE_HWC)
 			continue;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 3e090f87f97e..308a2b72a65d 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2225,14 +2225,18 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 {
 	struct device *dev = common->dev;
+	struct am65_cpsw_tx_chn *tx_chn;
 	int i, ret = 0;
 
 	for (i = 0; i < common->tx_ch_num; i++) {
-		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
+		tx_chn = &common->tx_chns[i];
 
 		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
 		tx_chn->tx_hrtimer.function = &am65_cpsw_nuss_tx_timer_callback;
 
+		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
+				  am65_cpsw_nuss_tx_poll);
+
 		ret = devm_request_irq(dev, tx_chn->irq,
 				       am65_cpsw_nuss_tx_irq,
 				       IRQF_TRIGGER_HIGH,
@@ -2242,19 +2246,16 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am65_cpsw_common *common)
 				tx_chn->id, tx_chn->irq, ret);
 			goto err;
 		}
-
-		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
-				  am65_cpsw_nuss_tx_poll);
 	}
 
 	return 0;
 
 err:
-	for (--i ; i >= 0 ; i--) {
-		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
-
-		netif_napi_del(&tx_chn->napi_tx);
+	netif_napi_del(&tx_chn->napi_tx);
+	for (--i; i >= 0; i--) {
+		tx_chn = &common->tx_chns[i];
 		devm_free_irq(dev, tx_chn->irq, tx_chn);
+		netif_napi_del(&tx_chn->napi_tx);
 	}
 
 	return ret;
@@ -2488,6 +2489,9 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			     HRTIMER_MODE_REL_PINNED);
 		flow->rx_hrtimer.function = &am65_cpsw_nuss_rx_timer_callback;
 
+		netif_napi_add(common->dma_ndev, &flow->napi_rx,
+			       am65_cpsw_nuss_rx_poll);
+
 		ret = devm_request_irq(dev, flow->irq,
 				       am65_cpsw_nuss_rx_irq,
 				       IRQF_TRIGGER_HIGH,
@@ -2496,11 +2500,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 			dev_err(dev, "failure requesting rx %d irq %u, %d\n",
 				i, flow->irq, ret);
 			flow->irq = -EINVAL;
-			goto err_flow;
+			goto err_request_irq;
 		}
-
-		netif_napi_add(common->dma_ndev, &flow->napi_rx,
-			       am65_cpsw_nuss_rx_poll);
 	}
 
 	/* setup classifier to route priorities to flows */
@@ -2508,11 +2509,14 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cpsw_common *common)
 
 	return 0;
 
+err_request_irq:
+	netif_napi_del(&flow->napi_rx);
+
 err_flow:
-	for (--i; i >= 0 ; i--) {
+	for (--i; i >= 0; i--) {
 		flow = &rx_chn->flows[i];
-		netif_napi_del(&flow->napi_rx);
 		devm_free_irq(dev, flow->irq, flow);
+		netif_napi_del(&flow->napi_rx);
 	}
 
 err:
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index cb11635a8d12..6f0700d156e7 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -1555,6 +1555,7 @@ static int prueth_probe(struct platform_device *pdev)
 	}
 
 	spin_lock_init(&prueth->vtbl_lock);
+	spin_lock_init(&prueth->stats_lock);
 	/* setup netdev interfaces */
 	if (eth0_node) {
 		ret = prueth_netdev_init(prueth, eth0_node);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 5473315ea204..e456a11c5d4e 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -297,6 +297,8 @@ struct prueth {
 	int default_vlan;
 	/** @vtbl_lock: Lock for vtbl in shared memory */
 	spinlock_t vtbl_lock;
+	/** @stats_lock: Lock for reading icssg stats */
+	spinlock_t stats_lock;
 };
 
 struct emac_tx_ts_response {
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 8800bd3a8d07..6f0edae38ea2 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -26,6 +26,8 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 	u32 val, reg;
 	int i;
 
+	spin_lock(&prueth->stats_lock);
+
 	for (i = 0; i < ARRAY_SIZE(icssg_all_miig_stats); i++) {
 		regmap_read(prueth->miig_rt,
 			    base + icssg_all_miig_stats[i].offset,
@@ -51,6 +53,8 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 			emac->pa_stats[i] += val;
 		}
 	}
+
+	spin_unlock(&prueth->stats_lock);
 }
 
 void icssg_stats_work_handler(struct work_struct *work)
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 4a5d73002a1a..0e9e987f37dd 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -73,7 +73,7 @@ int phy_link_topo_add_phy(struct net_device *dev,
 				      xa_limit_32b, &topo->next_phy_index,
 				      GFP_KERNEL);
 
-	if (ret)
+	if (ret < 0)
 		goto err;
 
 	return 0;
diff --git a/drivers/pmdomain/amlogic/meson-secure-pwrc.c b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
index 42ce41a2fe3a..ff76ea36835e 100644
--- a/drivers/pmdomain/amlogic/meson-secure-pwrc.c
+++ b/drivers/pmdomain/amlogic/meson-secure-pwrc.c
@@ -221,7 +221,7 @@ static const struct meson_secure_pwrc_domain_desc t7_pwrc_domains[] = {
 	SEC_PD(T7_VI_CLK2,	0),
 	/* ETH is for ethernet online wakeup, and should be always on */
 	SEC_PD(T7_ETH,		GENPD_FLAG_ALWAYS_ON),
-	SEC_PD(T7_ISP,		0),
+	TOP_PD(T7_ISP,		0, PWRC_T7_MIPI_ISP_ID),
 	SEC_PD(T7_MIPI_ISP,	0),
 	TOP_PD(T7_GDC,		0, PWRC_T7_NIC3_ID),
 	TOP_PD(T7_DEWARP,	0, PWRC_T7_NIC3_ID),
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 4bb2652740d0..1f4698d724bb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2024,6 +2024,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 
 		if (have_full_constraints()) {
 			r = dummy_regulator_rdev;
+			if (!r) {
+				ret = -EPROBE_DEFER;
+				goto out;
+			}
 			get_device(&r->dev);
 		} else {
 			dev_err(dev, "Failed to resolve %s-supply for %s\n",
@@ -2041,6 +2045,10 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 			goto out;
 		}
 		r = dummy_regulator_rdev;
+		if (!r) {
+			ret = -EPROBE_DEFER;
+			goto out;
+		}
 		get_device(&r->dev);
 	}
 
@@ -2166,8 +2174,10 @@ struct regulator *_regulator_get_common(struct regulator_dev *rdev, struct devic
 			 * enabled, even if it isn't hooked up, and just
 			 * provide a dummy.
 			 */
-			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			rdev = dummy_regulator_rdev;
+			if (!rdev)
+				return ERR_PTR(-EPROBE_DEFER);
+			dev_warn(dev, "supply %s not found, using dummy regulator\n", id);
 			get_device(&rdev->dev);
 			break;
 
diff --git a/drivers/regulator/dummy.c b/drivers/regulator/dummy.c
index 5b9b9e4e762d..9f59889129ab 100644
--- a/drivers/regulator/dummy.c
+++ b/drivers/regulator/dummy.c
@@ -60,7 +60,7 @@ static struct platform_driver dummy_regulator_driver = {
 	.probe		= dummy_regulator_probe,
 	.driver		= {
 		.name		= "reg-dummy",
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
+		.probe_type	= PROBE_FORCE_SYNCHRONOUS,
 	},
 };
 
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 5ea8887828c0..3ed8161d7d28 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -30,11 +30,9 @@
 
 struct imx8_soc_data {
 	char *name;
-	int (*soc_revision)(u32 *socrev);
+	int (*soc_revision)(u32 *socrev, u64 *socuid);
 };
 
-static u64 soc_uid;
-
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
 {
@@ -51,24 +49,22 @@ static u32 imx8mq_soc_revision_from_atf(void)
 static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
 #endif
 
-static int imx8mq_soc_revision(u32 *socrev)
+static int imx8mq_soc_revision(u32 *socrev, u64 *socuid)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	void __iomem *ocotp_base;
 	u32 magic;
 	u32 rev;
 	struct clk *clk;
 	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
 	if (!np)
 		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	if (!ocotp_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!ocotp_base)
+		return -EINVAL;
 
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
@@ -89,44 +85,39 @@ static int imx8mq_soc_revision(u32 *socrev)
 			rev = REV_B1;
 	}
 
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
+	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
+	*socuid <<= 32;
+	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
 
 	*socrev = rev;
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 	iounmap(ocotp_base);
-	of_node_put(np);
 
 	return 0;
 
 err_clk:
 	iounmap(ocotp_base);
-err_iomap:
-	of_node_put(np);
 	return ret;
 }
 
-static int imx8mm_soc_uid(void)
+static int imx8mm_soc_uid(u64 *socuid)
 {
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	void __iomem *ocotp_base;
-	struct device_node *np;
 	struct clk *clk;
 	int ret = 0;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
 	if (!np)
 		return -EINVAL;
 
 	ocotp_base = of_iomap(np, 0);
-	if (!ocotp_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!ocotp_base)
+		return -EINVAL;
 
 	clk = of_clk_get_by_name(np, NULL);
 	if (IS_ERR(clk)) {
@@ -136,47 +127,36 @@ static int imx8mm_soc_uid(void)
 
 	clk_prepare_enable(clk);
 
-	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
-	soc_uid <<= 32;
-	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
+	*socuid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
+	*socuid <<= 32;
+	*socuid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
 	clk_disable_unprepare(clk);
 	clk_put(clk);
 
 err_clk:
 	iounmap(ocotp_base);
-err_iomap:
-	of_node_put(np);
-
 	return ret;
 }
 
-static int imx8mm_soc_revision(u32 *socrev)
+static int imx8mm_soc_revision(u32 *socrev, u64 *socuid)
 {
-	struct device_node *np;
+	struct device_node *np __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	void __iomem *anatop_base;
-	int ret;
 
-	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
 	if (!np)
 		return -EINVAL;
 
 	anatop_base = of_iomap(np, 0);
-	if (!anatop_base) {
-		ret = -EINVAL;
-		goto err_iomap;
-	}
+	if (!anatop_base)
+		return -EINVAL;
 
 	*socrev = readl_relaxed(anatop_base + ANADIG_DIGPROG_IMX8MM);
 
 	iounmap(anatop_base);
-	of_node_put(np);
 
-	return imx8mm_soc_uid();
-
-err_iomap:
-	of_node_put(np);
-	return ret;
+	return imx8mm_soc_uid(socuid);
 }
 
 static const struct imx8_soc_data imx8mq_soc_data = {
@@ -207,21 +187,34 @@ static __maybe_unused const struct of_device_id imx8_soc_match[] = {
 	{ }
 };
 
-#define imx8_revision(soc_rev) \
-	soc_rev ? \
-	kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev & 0xf) : \
+#define imx8_revision(dev, soc_rev) \
+	(soc_rev) ? \
+	devm_kasprintf((dev), GFP_KERNEL, "%d.%d", ((soc_rev) >> 4) & 0xf, (soc_rev) & 0xf) : \
 	"unknown"
 
+static void imx8m_unregister_soc(void *data)
+{
+	soc_device_unregister(data);
+}
+
+static void imx8m_unregister_cpufreq(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int imx8m_soc_probe(struct platform_device *pdev)
 {
 	struct soc_device_attribute *soc_dev_attr;
-	struct soc_device *soc_dev;
+	struct platform_device *cpufreq_dev;
+	const struct imx8_soc_data *data;
+	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
+	struct soc_device *soc_dev;
 	u32 soc_rev = 0;
-	const struct imx8_soc_data *data;
+	u64 soc_uid = 0;
 	int ret;
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	soc_dev_attr = devm_kzalloc(dev, sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
 
@@ -229,58 +222,52 @@ static int imx8m_soc_probe(struct platform_device *pdev)
 
 	ret = of_property_read_string(of_root, "model", &soc_dev_attr->machine);
 	if (ret)
-		goto free_soc;
+		return ret;
 
 	id = of_match_node(imx8_soc_match, of_root);
-	if (!id) {
-		ret = -ENODEV;
-		goto free_soc;
-	}
+	if (!id)
+		return -ENODEV;
 
 	data = id->data;
 	if (data) {
 		soc_dev_attr->soc_id = data->name;
 		if (data->soc_revision) {
-			ret = data->soc_revision(&soc_rev);
+			ret = data->soc_revision(&soc_rev, &soc_uid);
 			if (ret)
-				goto free_soc;
+				return ret;
 		}
 	}
 
-	soc_dev_attr->revision = imx8_revision(soc_rev);
-	if (!soc_dev_attr->revision) {
-		ret = -ENOMEM;
-		goto free_soc;
-	}
+	soc_dev_attr->revision = imx8_revision(dev, soc_rev);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
-	if (!soc_dev_attr->serial_number) {
-		ret = -ENOMEM;
-		goto free_rev;
-	}
+	soc_dev_attr->serial_number = devm_kasprintf(dev, GFP_KERNEL, "%016llX", soc_uid);
+	if (!soc_dev_attr->serial_number)
+		return -ENOMEM;
 
 	soc_dev = soc_device_register(soc_dev_attr);
-	if (IS_ERR(soc_dev)) {
-		ret = PTR_ERR(soc_dev);
-		goto free_serial_number;
-	}
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	ret = devm_add_action(dev, imx8m_unregister_soc, soc_dev);
+	if (ret)
+		return ret;
 
 	pr_info("SoC: %s revision %s\n", soc_dev_attr->soc_id,
 		soc_dev_attr->revision);
 
-	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT))
-		platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+	if (IS_ENABLED(CONFIG_ARM_IMX_CPUFREQ_DT)) {
+		cpufreq_dev = platform_device_register_simple("imx-cpufreq-dt", -1, NULL, 0);
+		if (IS_ERR(cpufreq_dev))
+			return dev_err_probe(dev, PTR_ERR(cpufreq_dev),
+					     "Failed to register imx-cpufreq-dev device\n");
+		ret = devm_add_action(dev, imx8m_unregister_cpufreq, cpufreq_dev);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
-
-free_serial_number:
-	kfree(soc_dev_attr->serial_number);
-free_rev:
-	if (strcmp(soc_dev_attr->revision, "unknown"))
-		kfree(soc_dev_attr->revision);
-free_soc:
-	kfree(soc_dev_attr);
-	return ret;
 }
 
 static struct platform_driver imx8m_soc_driver = {
diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 328b6153b2be..71be378d2e43 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -75,7 +75,6 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 {
 	struct pdr_handle *pdr = container_of(qmi, struct pdr_handle,
 					      locator_hdl);
-	struct pdr_service *pds;
 
 	mutex_lock(&pdr->lock);
 	/* Create a local client port for QMI communication */
@@ -87,12 +86,7 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 	mutex_unlock(&pdr->lock);
 
 	/* Service pending lookup requests */
-	mutex_lock(&pdr->list_lock);
-	list_for_each_entry(pds, &pdr->lookups, node) {
-		if (pds->need_locator_lookup)
-			schedule_work(&pdr->locator_work);
-	}
-	mutex_unlock(&pdr->list_lock);
+	schedule_work(&pdr->locator_work);
 
 	return 0;
 }
diff --git a/fs/libfs.c b/fs/libfs.c
index b0f262223b53..3cb49463a849 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -492,7 +492,7 @@ offset_dir_lookup(struct dentry *parent, loff_t offset)
 		found = find_positive_dentry(parent, NULL, false);
 	else {
 		rcu_read_lock();
-		child = mas_find(&mas, DIR_OFFSET_MAX);
+		child = mas_find_rev(&mas, DIR_OFFSET_MIN);
 		found = find_positive_dentry(parent, child, false);
 		rcu_read_unlock();
 	}
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index 82290c92ba7a..412d4da74227 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -576,7 +576,8 @@ void netfs_write_collection_worker(struct work_struct *work)
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
-	    wreq->io_streams[1].failed) {
+	    wreq->io_streams[1].failed &&
+	    ictx->ops->invalidate_cache) {
 		/* Cache write failure doesn't prevent writeback completion
 		 * unless we're in disconnected mode.
 		 */
diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index dbe82cf23ee4..3431b083f7d0 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -557,10 +557,16 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static inline void pde_set_flags(struct proc_dir_entry *pde)
+static void pde_set_flags(struct proc_dir_entry *pde)
 {
 	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
 		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (pde->proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (pde->proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
@@ -624,6 +630,7 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -654,6 +661,7 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
+	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index 626ad7bd94f2..a3eb3b740f76 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -656,13 +656,13 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = de->proc_iops;
-		if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_read_iter(de))
 			inode->i_fop = &proc_iter_file_ops;
 		else
 			inode->i_fop = &proc_reg_file_ops;
 #ifdef CONFIG_COMPAT
-		if (de->proc_ops->proc_compat_ioctl) {
-			if (de->proc_ops->proc_read_iter)
+		if (pde_has_proc_compat_ioctl(de)) {
+			if (pde_has_proc_read_iter(de))
 				inode->i_fop = &proc_iter_file_ops_compat;
 			else
 				inode->i_fop = &proc_reg_file_ops_compat;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 87e4d6282025..4e0c5b57ffdb 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -85,6 +85,20 @@ static inline void pde_make_permanent(struct proc_dir_entry *pde)
 	pde->flags |= PROC_ENTRY_PERMANENT;
 }
 
+static inline bool pde_has_proc_read_iter(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_read_iter;
+}
+
+static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
+{
+#ifdef CONFIG_COMPAT
+	return pde->flags & PROC_ENTRY_proc_compat_ioctl;
+#else
+	return false;
+#endif
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index da8ed72f335d..109036e2227c 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -398,7 +398,9 @@ static void parse_dacl(struct mnt_idmap *idmap,
 	if (num_aces <= 0)
 		return;
 
-	if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
+	if (num_aces > (le16_to_cpu(pdacl->size) - sizeof(struct smb_acl)) /
+			(offsetof(struct smb_ace, sid) +
+			 offsetof(struct smb_sid, sub_auth) + sizeof(__le16)))
 		return;
 
 	ret = init_acl_state(&acl_state, num_aces);
@@ -432,6 +434,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 			offsetof(struct smb_sid, sub_auth);
 
 		if (end_of_acl - acl_base < acl_size ||
+		    ppace[i]->sid.num_subauth == 0 ||
 		    ppace[i]->sid.num_subauth > SID_MAX_SUB_AUTHORITIES ||
 		    (end_of_acl - acl_base <
 		     acl_size + sizeof(__le32) * ppace[i]->sid.num_subauth) ||
diff --git a/include/linux/key.h b/include/linux/key.h
index 074dca3222b9..ba05de8579ec 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -236,6 +236,7 @@ struct key {
 #define KEY_FLAG_ROOT_CAN_INVAL	7	/* set if key can be invalidated by root without permission */
 #define KEY_FLAG_KEEP		8	/* set if key should not be removed */
 #define KEY_FLAG_UID_KEYRING	9	/* set if key is a user or user session keyring */
+#define KEY_FLAG_FINAL_PUT	10	/* set if final put has happened on key */
 
 	/* the key type and key description string
 	 * - the desc is used to match a key against search criteria
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 9b4a6ff03235..79974a99265f 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -88,6 +88,7 @@ enum ata_quirks {
 	__ATA_QUIRK_MAX_SEC_1024,	/* Limit max sects to 1024 */
 	__ATA_QUIRK_MAX_TRIM_128M,	/* Limit max trim size to 128M */
 	__ATA_QUIRK_NO_NCQ_ON_ATI,	/* Disable NCQ on ATI chipset */
+	__ATA_QUIRK_NO_LPM_ON_ATI,	/* Disable LPM on ATI chipset */
 	__ATA_QUIRK_NO_ID_DEV_LOG,	/* Identify device log missing */
 	__ATA_QUIRK_NO_LOG_DIR,		/* Do not read log directory */
 	__ATA_QUIRK_NO_FUA,		/* Do not use FUA */
@@ -434,6 +435,7 @@ enum {
 	ATA_QUIRK_MAX_SEC_1024		= (1U << __ATA_QUIRK_MAX_SEC_1024),
 	ATA_QUIRK_MAX_TRIM_128M		= (1U << __ATA_QUIRK_MAX_TRIM_128M),
 	ATA_QUIRK_NO_NCQ_ON_ATI		= (1U << __ATA_QUIRK_NO_NCQ_ON_ATI),
+	ATA_QUIRK_NO_LPM_ON_ATI		= (1U << __ATA_QUIRK_NO_LPM_ON_ATI),
 	ATA_QUIRK_NO_ID_DEV_LOG		= (1U << __ATA_QUIRK_NO_ID_DEV_LOG),
 	ATA_QUIRK_NO_LOG_DIR		= (1U << __ATA_QUIRK_NO_LOG_DIR),
 	ATA_QUIRK_NO_FUA		= (1U << __ATA_QUIRK_NO_FUA),
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 0b2a89854440..ea62201c74c4 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -20,10 +20,13 @@ enum {
 	 * If in doubt, ignore this flag.
 	 */
 #ifdef MODULE
-	PROC_ENTRY_PERMANENT = 0U,
+	PROC_ENTRY_PERMANENT		= 0U,
 #else
-	PROC_ENTRY_PERMANENT = 1U << 0,
+	PROC_ENTRY_PERMANENT		= 1U << 0,
 #endif
+
+	PROC_ENTRY_proc_read_iter	= 1U << 1,
+	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
 };
 
 struct proc_ops {
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5bb4eaa52e14..dd10e02bfc74 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -683,7 +683,7 @@ enum {
 #define HCI_ERROR_REMOTE_POWER_OFF	0x15
 #define HCI_ERROR_LOCAL_HOST_TERM	0x16
 #define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
-#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1e
+#define HCI_ERROR_UNSUPPORTED_REMOTE_FEATURE	0x1a
 #define HCI_ERROR_INVALID_LL_PARAMS	0x1e
 #define HCI_ERROR_UNSPECIFIED		0x1f
 #define HCI_ERROR_ADVERTISING_TIMEOUT	0x3c
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index de47fa533b15..6a0e83ac0fdb 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -406,8 +406,6 @@ struct gdma_context {
 	struct gdma_dev		mana_ib;
 };
 
-#define MAX_NUM_GDMA_DEVICES	4
-
 static inline bool mana_gd_is_mana(struct gdma_dev *gd)
 {
 	return gd->dev_id.type == GDMA_DEVICE_MANA;
@@ -554,11 +552,15 @@ enum {
 #define GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG BIT(3)
 #define GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT BIT(5)
 
+/* Driver can handle holes (zeros) in the device list */
+#define GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP BIT(11)
+
 #define GDMA_DRV_CAP_FLAGS1 \
 	(GDMA_DRV_CAP_FLAG_1_EQ_SHARING_MULTI_VPORT | \
 	 GDMA_DRV_CAP_FLAG_1_NAPI_WKDONE_FIX | \
 	 GDMA_DRV_CAP_FLAG_1_HWC_TIMEOUT_RECONFIG | \
-	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT)
+	 GDMA_DRV_CAP_FLAG_1_VARIABLE_INDIRECTION_TABLE_SUPPORT | \
+	 GDMA_DRV_CAP_FLAG_1_DEV_LIST_HOLES_SUP)
 
 #define GDMA_DRV_CAP_FLAGS2 0
 
@@ -619,11 +621,12 @@ struct gdma_query_max_resources_resp {
 }; /* HW DATA */
 
 /* GDMA_LIST_DEVICES */
+#define GDMA_DEV_LIST_SIZE 64
 struct gdma_list_devices_resp {
 	struct gdma_resp_hdr hdr;
 	u32 num_of_devs;
 	u32 reserved;
-	struct gdma_dev_id devs[64];
+	struct gdma_dev_id devs[GDMA_DEV_LIST_SIZE];
 }; /* HW DATA */
 
 /* GDMA_REGISTER_DEVICE */
diff --git a/io_uring/net.c b/io_uring/net.c
index f32311f64113..7ea99e082e97 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -152,7 +152,7 @@ static void io_netmsg_recycle(struct io_kiocb *req, unsigned int issue_flags)
 		if (iov)
 			kasan_mempool_poison_object(iov);
 		req->async_data = NULL;
-		req->flags &= ~REQ_F_ASYNC_DATA;
+		req->flags &= ~(REQ_F_ASYNC_DATA|REQ_F_NEED_CLEANUP);
 	}
 }
 
@@ -447,7 +447,6 @@ int io_sendmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 static void io_req_msg_cleanup(struct io_kiocb *req,
 			       unsigned int issue_flags)
 {
-	req->flags &= ~REQ_F_NEED_CLEANUP;
 	io_netmsg_recycle(req, issue_flags);
 }
 
@@ -1428,6 +1427,7 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 	 */
 	if (!(issue_flags & IO_URING_F_UNLOCKED)) {
 		io_notif_flush(zc->notif);
+		zc->notif = NULL;
 		io_req_msg_cleanup(req, 0);
 	}
 	io_req_set_res(req, ret, IORING_CQE_F_MORE);
@@ -1488,6 +1488,7 @@ int io_sendmsg_zc(struct io_kiocb *req, unsigned int issue_flags)
 	 */
 	if (!(issue_flags & IO_URING_F_UNLOCKED)) {
 		io_notif_flush(sr->notif);
+		sr->notif = NULL;
 		io_req_msg_cleanup(req, 0);
 	}
 	io_req_set_res(req, ret, IORING_CQE_F_MORE);
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5b4e6d3bf7bc..b8fe0b3d0ffb 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -584,6 +584,22 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	return mask >= phys_to_dma_unencrypted(dev, min_mask);
 }
 
+static const struct bus_dma_region *dma_find_range(struct device *dev,
+						   unsigned long start_pfn)
+{
+	const struct bus_dma_region *m;
+
+	for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
+		unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+
+		if (start_pfn >= cpu_start_pfn &&
+		    start_pfn - cpu_start_pfn < PFN_DOWN(m->size))
+			return m;
+	}
+
+	return NULL;
+}
+
 /*
  * To check whether all ram resource ranges are covered by dma range map
  * Returns 0 when further check is needed
@@ -593,20 +609,12 @@ static int check_ram_in_range_map(unsigned long start_pfn,
 				  unsigned long nr_pages, void *data)
 {
 	unsigned long end_pfn = start_pfn + nr_pages;
-	const struct bus_dma_region *bdr = NULL;
-	const struct bus_dma_region *m;
 	struct device *dev = data;
 
 	while (start_pfn < end_pfn) {
-		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
-			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
+		const struct bus_dma_region *bdr;
 
-			if (start_pfn >= cpu_start_pfn &&
-			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
-				bdr = m;
-				break;
-			}
-		}
+		bdr = dma_find_range(dev, start_pfn);
 		if (!bdr)
 			return 1;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1f817d0c5d2d..e9bb1b4c5842 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8919,7 +8919,7 @@ void sched_release_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-static struct task_group *sched_get_task_group(struct task_struct *tsk)
+static void sched_change_group(struct task_struct *tsk)
 {
 	struct task_group *tg;
 
@@ -8931,13 +8931,7 @@ static struct task_group *sched_get_task_group(struct task_struct *tsk)
 	tg = container_of(task_css_check(tsk, cpu_cgrp_id, true),
 			  struct task_group, css);
 	tg = autogroup_task_group(tsk, tg);
-
-	return tg;
-}
-
-static void sched_change_group(struct task_struct *tsk, struct task_group *group)
-{
-	tsk->sched_task_group = group;
+	tsk->sched_task_group = tg;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (tsk->sched_class->task_change_group)
@@ -8958,20 +8952,11 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
-	struct task_group *group;
 	struct rq *rq;
 
 	CLASS(task_rq_lock, rq_guard)(tsk);
 	rq = rq_guard.rq;
 
-	/*
-	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
-	 * group changes.
-	 */
-	group = sched_get_task_group(tsk);
-	if (group == tsk->sched_task_group)
-		return;
-
 	update_rq_clock(rq);
 
 	running = task_current(rq, tsk);
@@ -8982,7 +8967,7 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 	if (running)
 		put_prev_task(rq, tsk);
 
-	sched_change_group(tsk, group);
+	sched_change_group(tsk);
 	if (!for_autogroup)
 		scx_cgroup_move_task(tsk);
 
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 99048c330382..4acdab165793 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -889,13 +889,8 @@ static void __find_tracepoint_module_cb(struct tracepoint *tp, struct module *mo
 
 	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
 		data->tpoint = tp;
-		if (!data->mod) {
+		if (!data->mod)
 			data->mod = mod;
-			if (!try_module_get(data->mod)) {
-				data->tpoint = NULL;
-				data->mod = NULL;
-			}
-		}
 	}
 }
 
@@ -907,13 +902,7 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
 		data->tpoint = tp;
 }
 
-/*
- * Find a tracepoint from kernel and module. If the tracepoint is in a module,
- * this increments the module refcount to prevent unloading until the
- * trace_fprobe is registered to the list. After registering the trace_fprobe
- * on the trace_fprobe list, the module refcount is decremented because
- * tracepoint_probe_module_cb will handle it.
- */
+/* Find a tracepoint from kernel and module. */
 static struct tracepoint *find_tracepoint(const char *tp_name,
 					  struct module **tp_mod)
 {
@@ -942,6 +931,7 @@ static void reenable_trace_fprobe(struct trace_fprobe *tf)
 	}
 }
 
+/* Find a tracepoint from specified module. */
 static struct tracepoint *find_tracepoint_in_module(struct module *mod,
 						    const char *tp_name)
 {
@@ -977,10 +967,13 @@ static int __tracepoint_probe_module_cb(struct notifier_block *self,
 					reenable_trace_fprobe(tf);
 			}
 		} else if (val == MODULE_STATE_GOING && tp_mod->mod == tf->mod) {
-			tracepoint_probe_unregister(tf->tpoint,
+			unregister_fprobe(&tf->fp);
+			if (trace_fprobe_is_tracepoint(tf)) {
+				tracepoint_probe_unregister(tf->tpoint,
 					tf->tpoint->probestub, NULL);
-			tf->tpoint = NULL;
-			tf->mod = NULL;
+				tf->tpoint = TRACEPOINT_STUB;
+				tf->mod = NULL;
+			}
 		}
 	}
 	mutex_unlock(&event_mutex);
@@ -1174,6 +1167,11 @@ static int __trace_fprobe_create(int argc, const char *argv[])
 	if (is_tracepoint) {
 		ctx.flags |= TPARG_FL_TPOINT;
 		tpoint = find_tracepoint(symbol, &tp_mod);
+		/* lock module until register this tprobe. */
+		if (tp_mod && !try_module_get(tp_mod)) {
+			tpoint = NULL;
+			tp_mod = NULL;
+		}
 		if (tpoint) {
 			ctx.funcname = kallsyms_lookup(
 				(unsigned long)tpoint->probestub,
diff --git a/mm/filemap.c b/mm/filemap.c
index 05adf0392625..3c37ad6c598b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1966,8 +1966,19 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
 
 		if (err == -EEXIST)
 			goto repeat;
-		if (err)
+		if (err) {
+			/*
+			 * When NOWAIT I/O fails to allocate folios this could
+			 * be due to a nonblocking memory allocation and not
+			 * because the system actually is out of memory.
+			 * Return -EAGAIN so that there caller retries in a
+			 * blocking fashion instead of propagating -ENOMEM
+			 * to the application.
+			 */
+			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
+				err = -EAGAIN;
 			return ERR_PTR(err);
+		}
 		/*
 		 * filemap_add_folio locks the page, and for mmap
 		 * we expect an unlocked page.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f127b61f04a8..40ac11e29423 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3224,7 +3224,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
 			__filemap_remove_folio(tail, NULL);
-			folio_put(tail);
+			folio_put_refs(tail, folio_nr_pages(tail));
 		} else if (!PageAnon(page)) {
 			__xa_store(&folio->mapping->i_pages, head[i].index,
 					head + i, 0);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ae1d184d035a..2d1e402f06f2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1882,9 +1882,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old;
+	unsigned long flags;
 
 	stock = &per_cpu(memcg_stock, cpu);
+
+	/* drain_obj_stock requires stock_lock */
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	old = drain_obj_stock(stock);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+
 	drain_stock(stock);
+	obj_cgroup_put(old);
 
 	return 0;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index dfa24e41e8f9..25e7438af968 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -526,15 +526,13 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 	if (folio_test_anon(folio) && folio_test_large(folio))
 		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON, 1);
 	folio_ref_add(newfolio, nr); /* add cache reference */
-	if (folio_test_swapbacked(folio)) {
+	if (folio_test_swapbacked(folio))
 		__folio_set_swapbacked(newfolio);
-		if (folio_test_swapcache(folio)) {
-			folio_set_swapcache(newfolio);
-			newfolio->private = folio_get_private(folio);
-		}
+	if (folio_test_swapcache(folio)) {
+		folio_set_swapcache(newfolio);
+		newfolio->private = folio_get_private(folio);
 		entries = nr;
 	} else {
-		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
 		entries = 1;
 	}
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e0a77fe1b630..fd4e0e1cd65e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7094,7 +7094,7 @@ static inline bool has_unaccepted_memory(void)
 
 static bool cond_accept_memory(struct zone *zone, unsigned int order)
 {
-	long to_accept;
+	long to_accept, wmark;
 	bool ret = false;
 
 	if (!has_unaccepted_memory())
@@ -7103,8 +7103,18 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order)
 	if (list_empty(&zone->unaccepted_pages))
 		return false;
 
+	wmark = promo_wmark_pages(zone);
+
+	/*
+	 * Watermarks have not been initialized yet.
+	 *
+	 * Accepting one MAX_ORDER page to ensure progress.
+	 */
+	if (!wmark)
+		return try_to_accept_memory_one(zone);
+
 	/* How much to accept to get to promo watermark? */
-	to_accept = promo_wmark_pages(zone) -
+	to_accept = wmark -
 		    (zone_page_state(zone, NR_FREE_PAGES) -
 		    __zone_watermark_unusable_free(zone, order, 0) -
 		    zone_page_state(zone, NR_UNACCEPTED));
diff --git a/net/atm/lec.c b/net/atm/lec.c
index ffef658862db..a948dd47c3f3 100644
--- a/net/atm/lec.c
+++ b/net/atm/lec.c
@@ -181,6 +181,7 @@ static void
 lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 {
 	struct net_device *dev = skb->dev;
+	unsigned int len = skb->len;
 
 	ATM_SKB(skb)->vcc = vcc;
 	atm_account_tx(vcc, skb);
@@ -191,7 +192,7 @@ lec_send(struct atm_vcc *vcc, struct sk_buff *skb)
 	}
 
 	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
+	dev->stats.tx_bytes += len;
 }
 
 static void lec_tx_timeout(struct net_device *dev, unsigned int txqueue)
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74b49c35ddc1..209180b4c268 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -324,8 +324,7 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /* send a batman ogm to a given interface */
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e503ee0d896b..8f89ffe6020c 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -839,8 +839,7 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 	/* check if there is enough space for the optional TVLV */
 	next_buff_pos += ntohs(ogm2_packet->tvlv_len);
 
-	return (next_buff_pos <= packet_len) &&
-	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
+	return next_buff_pos <= packet_len;
 }
 
 /**
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 50cfec8ccac4..3c29778171c5 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -825,11 +825,16 @@ static struct sk_buff *chan_alloc_skb_cb(struct l2cap_chan *chan,
 					 unsigned long hdr_len,
 					 unsigned long len, int nb)
 {
+	struct sk_buff *skb;
+
 	/* Note that we must allocate using GFP_ATOMIC here as
 	 * this function is called originally from netdev hard xmit
 	 * function in atomic context.
 	 */
-	return bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	skb = bt_skb_alloc(hdr_len + len, GFP_ATOMIC);
+	if (!skb)
+		return ERR_PTR(-ENOMEM);
+	return skb;
 }
 
 static void chan_suspend_cb(struct l2cap_chan *chan)
diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
index 711cd3b4347a..4417a18b3e95 100644
--- a/net/core/lwtunnel.c
+++ b/net/core/lwtunnel.c
@@ -23,6 +23,8 @@
 #include <net/ip6_fib.h>
 #include <net/rtnh.h>
 
+#include "dev.h"
+
 DEFINE_STATIC_KEY_FALSE(nf_hooks_lwtunnel_enabled);
 EXPORT_SYMBOL_GPL(nf_hooks_lwtunnel_enabled);
 
@@ -325,13 +327,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_cmp_encap);
 
 int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
+
+	if (dev_xmit_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
+		goto drop;
+	}
 
-	if (!dst)
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
 		goto drop;
+	}
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
@@ -341,8 +353,11 @@ int lwtunnel_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->output))
+	if (likely(ops && ops->output)) {
+		dev_xmit_recursion_inc();
 		ret = ops->output(net, sk, skb);
+		dev_xmit_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
@@ -359,13 +374,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_output);
 
 int lwtunnel_xmit(struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
+
+	if (dev_xmit_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
+		goto drop;
+	}
 
-	if (!dst)
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
 		goto drop;
+	}
 
 	lwtstate = dst->lwtstate;
 
@@ -376,8 +401,11 @@ int lwtunnel_xmit(struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->xmit))
+	if (likely(ops && ops->xmit)) {
+		dev_xmit_recursion_inc();
 		ret = ops->xmit(skb);
+		dev_xmit_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
@@ -394,13 +422,23 @@ EXPORT_SYMBOL_GPL(lwtunnel_xmit);
 
 int lwtunnel_input(struct sk_buff *skb)
 {
-	struct dst_entry *dst = skb_dst(skb);
 	const struct lwtunnel_encap_ops *ops;
 	struct lwtunnel_state *lwtstate;
-	int ret = -EINVAL;
+	struct dst_entry *dst;
+	int ret;
 
-	if (!dst)
+	if (dev_xmit_recursion()) {
+		net_crit_ratelimited("%s(): recursion limit reached on datapath\n",
+				     __func__);
+		ret = -ENETDOWN;
 		goto drop;
+	}
+
+	dst = skb_dst(skb);
+	if (!dst) {
+		ret = -EINVAL;
+		goto drop;
+	}
 	lwtstate = dst->lwtstate;
 
 	if (lwtstate->type == LWTUNNEL_ENCAP_NONE ||
@@ -410,8 +448,11 @@ int lwtunnel_input(struct sk_buff *skb)
 	ret = -EOPNOTSUPP;
 	rcu_read_lock();
 	ops = rcu_dereference(lwtun_encaps[lwtstate->type]);
-	if (likely(ops && ops->input))
+	if (likely(ops && ops->input)) {
+		dev_xmit_recursion_inc();
 		ret = ops->input(skb);
+		dev_xmit_recursion_dec();
+	}
 	rcu_read_unlock();
 
 	if (ret == -EOPNOTSUPP)
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index c7f7ea61b524..8082cc6be4fc 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2301,6 +2301,7 @@ static const struct nla_policy nl_neightbl_policy[NDTA_MAX+1] = {
 static const struct nla_policy nl_ntbl_parm_policy[NDTPA_MAX+1] = {
 	[NDTPA_IFINDEX]			= { .type = NLA_U32 },
 	[NDTPA_QUEUE_LEN]		= { .type = NLA_U32 },
+	[NDTPA_QUEUE_LENBYTES]		= { .type = NLA_U32 },
 	[NDTPA_PROXY_QLEN]		= { .type = NLA_U32 },
 	[NDTPA_APP_PROBES]		= { .type = NLA_U32 },
 	[NDTPA_UCAST_PROBES]		= { .type = NLA_U32 },
diff --git a/net/devlink/core.c b/net/devlink/core.c
index f49cd83f1955..7203c39532fc 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -117,7 +117,7 @@ static struct devlink_rel *devlink_rel_alloc(void)
 
 	err = xa_alloc_cyclic(&devlink_rels, &rel->index, rel,
 			      xa_limit_32b, &next, GFP_KERNEL);
-	if (err) {
+	if (err < 0) {
 		kfree(rel);
 		return ERR_PTR(err);
 	}
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 26cdb6657475..f7c17388ff6a 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3237,13 +3237,16 @@ static void add_v4_addrs(struct inet6_dev *idev)
 	struct in6_addr addr;
 	struct net_device *dev;
 	struct net *net = dev_net(idev->dev);
-	int scope, plen;
+	int scope, plen, offset = 0;
 	u32 pflags = 0;
 
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr, 4);
+	/* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
+	if (idev->dev->addr_len == sizeof(struct in6_addr))
+		offset = sizeof(struct in6_addr) - 4;
+	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr + offset, 4);
 
 	if (!(idev->dev->flags & IFF_POINTOPOINT) && idev->dev->type == ARPHRD_SIT) {
 		scope = IPV6_ADDR_COMPATv4;
@@ -3554,13 +3557,7 @@ static void addrconf_gre_config(struct net_device *dev)
 		return;
 	}
 
-	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
-	 * unless we have an IPv4 GRE device not bound to an IP address and
-	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
-	 * case). Such devices fall back to add_v4_addrs() instead.
-	 */
-	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
-	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
+	if (dev->type == ARPHRD_ETHER) {
 		addrconf_addr_gen(idev, true);
 		return;
 	}
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 4215cebe7d85..647dd8417c6c 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -339,7 +339,6 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb), *cache_dst = NULL;
-	struct in6_addr orig_daddr;
 	struct ioam6_lwt *ilwt;
 	int err = -EINVAL;
 	u32 pkt_cnt;
@@ -354,8 +353,6 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (pkt_cnt % ilwt->freq.n >= ilwt->freq.k)
 		goto out;
 
-	orig_daddr = ipv6_hdr(skb)->daddr;
-
 	local_bh_disable();
 	cache_dst = dst_cache_get(&ilwt->cache);
 	local_bh_enable();
@@ -424,7 +421,10 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 	}
 
-	if (!ipv6_addr_equal(&orig_daddr, &ipv6_hdr(skb)->daddr)) {
+	/* avoid lwtunnel_output() reentry loop when destination is the same
+	 * after transformation (e.g., with the inline mode)
+	 */
+	if (dst->lwtstate != cache_dst->lwtstate) {
 		skb_dst_drop(skb);
 		skb_dst_set(skb, cache_dst);
 		return dst_output(net, sk, skb);
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 2736dea77575..b393c37d2424 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3644,7 +3644,8 @@ int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
 		in6_dev_put(idev);
 
 	if (err) {
-		lwtstate_put(fib6_nh->fib_nh_lws);
+		fib_nh_common_release(&fib6_nh->nh_common);
+		fib6_nh->nh_common.nhc_pcpu_rth_output = NULL;
 		fib6_nh->fib_nh_lws = NULL;
 		netdev_put(dev, dev_tracker);
 	}
@@ -3802,10 +3803,12 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (nh) {
 		if (rt->fib6_src.plen) {
 			NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
+			err = -EINVAL;
 			goto out_free;
 		}
 		if (!nexthop_get(nh)) {
 			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
+			err = -ENOENT;
 			goto out_free;
 		}
 		rt->nh = nh;
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index a45bf17cb2a1..ae2da28f9dfb 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -94,14 +94,23 @@ INDIRECT_CALLABLE_SCOPE int tcp6_gro_complete(struct sk_buff *skb, int thoff)
 }
 
 static void __tcpv6_gso_segment_csum(struct sk_buff *seg,
+				     struct in6_addr *oldip,
+				     const struct in6_addr *newip,
 				     __be16 *oldport, __be16 newport)
 {
-	struct tcphdr *th;
+	struct tcphdr *th = tcp_hdr(seg);
+
+	if (!ipv6_addr_equal(oldip, newip)) {
+		inet_proto_csum_replace16(&th->check, seg,
+					  oldip->s6_addr32,
+					  newip->s6_addr32,
+					  true);
+		*oldip = *newip;
+	}
 
 	if (*oldport == newport)
 		return;
 
-	th = tcp_hdr(seg);
 	inet_proto_csum_replace2(&th->check, seg, *oldport, newport, false);
 	*oldport = newport;
 }
@@ -129,10 +138,10 @@ static struct sk_buff *__tcpv6_gso_segment_list_csum(struct sk_buff *segs)
 		th2 = tcp_hdr(seg);
 		iph2 = ipv6_hdr(seg);
 
-		iph2->saddr = iph->saddr;
-		iph2->daddr = iph->daddr;
-		__tcpv6_gso_segment_csum(seg, &th2->source, th->source);
-		__tcpv6_gso_segment_csum(seg, &th2->dest, th->dest);
+		__tcpv6_gso_segment_csum(seg, &iph2->saddr, &iph->saddr,
+					 &th2->source, th->source);
+		__tcpv6_gso_segment_csum(seg, &iph2->daddr, &iph->daddr,
+					 &th2->dest, th->dest);
 	}
 
 	return segs;
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index fd2de185bc93..23949ae2a3a8 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -651,6 +651,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
 	bool drop_other_suboptions = false;
 	unsigned int opt_size = *size;
+	struct mptcp_addr_info addr;
 	bool echo;
 	int len;
 
@@ -659,7 +660,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	 */
 	if (!mptcp_pm_should_add_signal(msk) ||
 	    (opts->suboptions & (OPTION_MPTCP_MPJ_ACK | OPTION_MPTCP_MPC_ACK)) ||
-	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &opts->addr,
+	    !mptcp_pm_add_addr_signal(msk, skb, opt_size, remaining, &addr,
 		    &echo, &drop_other_suboptions))
 		return false;
 
@@ -672,7 +673,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 	else if (opts->suboptions & OPTION_MPTCP_DSS)
 		return false;
 
-	len = mptcp_add_addr_len(opts->addr.family, echo, !!opts->addr.port);
+	len = mptcp_add_addr_len(addr.family, echo, !!addr.port);
 	if (remaining < len)
 		return false;
 
@@ -689,6 +690,7 @@ static bool mptcp_established_options_add_addr(struct sock *sk, struct sk_buff *
 		opts->ahmac = 0;
 		*size -= opt_size;
 	}
+	opts->addr = addr;
 	opts->suboptions |= OPTION_MPTCP_ADD_ADDR;
 	if (!echo) {
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDRTX);
diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
index 0662d34b09ee..87e865b9b83a 100644
--- a/net/xdp/xsk_buff_pool.c
+++ b/net/xdp/xsk_buff_pool.c
@@ -106,7 +106,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
 		if (pool->unaligned)
 			pool->free_heads[i] = xskb;
 		else
-			xp_init_xskb_addr(xskb, pool, i * pool->chunk_size);
+			xp_init_xskb_addr(xskb, pool, (u64)i * pool->chunk_size);
 	}
 
 	return pool;
diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index e5722c95b8bb..a30538a980cc 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -610,6 +610,40 @@ int xfrm_output_resume(struct sock *sk, struct sk_buff *skb, int err)
 }
 EXPORT_SYMBOL_GPL(xfrm_output_resume);
 
+static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
+				  struct sk_buff *skb)
+{
+	struct dst_entry *dst = skb_dst(skb);
+	struct net *net = xs_net(x);
+	int err;
+
+	dst = skb_dst_pop(skb);
+	if (!dst) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+		kfree_skb(skb);
+		return -EHOSTUNREACH;
+	}
+	skb_dst_set(skb, dst);
+	nf_reset_ct(skb);
+
+	err = skb_dst(skb)->ops->local_out(net, sk, skb);
+	if (unlikely(err != 1)) {
+		kfree_skb(skb);
+		return err;
+	}
+
+	/* In transport mode, network destination is
+	 * directly reachable, while in tunnel mode,
+	 * inner packet network may not be. In packet
+	 * offload type, HW is responsible for hard
+	 * header packet mangling so directly xmit skb
+	 * to netdevice.
+	 */
+	skb->dev = x->xso.dev;
+	__skb_push(skb, skb->dev->hard_header_len);
+	return dev_queue_xmit(skb);
+}
+
 static int xfrm_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return xfrm_output_resume(sk, skb, 1);
@@ -729,6 +763,13 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 			return -EHOSTUNREACH;
 		}
 
+		/* Exclusive direct xmit for tunnel mode, as
+		 * some filtering or matching rules may apply
+		 * in transport mode.
+		 */
+		if (x->props.mode == XFRM_MODE_TUNNEL)
+			return xfrm_dev_direct_output(sk, x, skb);
+
 		return xfrm_output_resume(sk, skb, 0);
 	}
 
@@ -752,7 +793,7 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 		skb->encapsulation = 1;
 
 		if (skb_is_gso(skb)) {
-			if (skb->inner_protocol)
+			if (skb->inner_protocol && x->props.mode == XFRM_MODE_TUNNEL)
 				return xfrm_output_gso(net, sk, skb);
 
 			skb_shinfo(skb)->gso_type |= SKB_GSO_ESP;
diff --git a/security/keys/gc.c b/security/keys/gc.c
index 7d687b0962b1..f27223ea4578 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -218,8 +218,10 @@ static void key_garbage_collector(struct work_struct *work)
 		key = rb_entry(cursor, struct key, serial_node);
 		cursor = rb_next(cursor);
 
-		if (refcount_read(&key->usage) == 0)
+		if (test_bit(KEY_FLAG_FINAL_PUT, &key->flags)) {
+			smp_mb(); /* Clobber key->user after FINAL_PUT seen. */
 			goto found_unreferenced_key;
+		}
 
 		if (unlikely(gc_state & KEY_GC_REAPING_DEAD_1)) {
 			if (key->type == key_gc_dead_keytype) {
diff --git a/security/keys/key.c b/security/keys/key.c
index 3d7d185019d3..7198cd2ac3a3 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -658,6 +658,8 @@ void key_put(struct key *key)
 				key->user->qnbytes -= key->quotalen;
 				spin_unlock_irqrestore(&key->user->lock, flags);
 			}
+			smp_mb(); /* key->user before FINAL_PUT set. */
+			set_bit(KEY_FLAG_FINAL_PUT, &key->flags);
 			schedule_work(&key_gc_work);
 		}
 	}
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index eb896d30545b..555d617c1f50 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -807,7 +807,7 @@ static int option__cmp(const void *va, const void *vb)
 static struct option *options__order(const struct option *opts)
 {
 	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
-	const struct option *o, *p = opts;
+	const struct option *o = NULL, *p = opts;
 	struct option *opt, *ordered = NULL, *group;
 
 	/* flatten the options that have parents */
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index c5797ad1d37b..d86ca1554d6d 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -300,7 +300,9 @@ uffd_stress_bin=./uffd-stress
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} anon 20 16
 # Hugetlb tests require source and destination huge pages. Pass in half
 # the size of the free pages we have, which is used for *each*.
-half_ufd_size_MB=$((freepgs / 2))
+# uffd-stress expects a region expressed in MiB, so we adjust
+# half_ufd_size_MB accordingly.
+half_ufd_size_MB=$(((freepgs * hpgsize_KB) / 1024 / 2))
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} hugetlb-private "$half_ufd_size_MB" 32
 CATEGORY="userfaultfd" run_test ${uffd_stress_bin} shmem 20 16

