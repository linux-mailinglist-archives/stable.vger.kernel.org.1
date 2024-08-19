Return-Path: <stable+bounces-69441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBD195626A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009E1280F57
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2742F146D7E;
	Mon, 19 Aug 2024 04:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjjKK0sJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC71482E8;
	Mon, 19 Aug 2024 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040785; cv=none; b=bA5jpFT1UK2BCh11ZvHtu0NEEr5jcdj255AVh7vIIb6ZztaDyhKONu9kz6tBoN0D/Vn7LvlD9a4hGxBFWoCXbOkj/Ogl2I/l7iCWWgH1l53BR8CwH7ZtP0SvUGyu0Usdn+F4s4TXkEmkQtT3ErSU2RL1gM6jcqE/lwpSsqFGZMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040785; c=relaxed/simple;
	bh=xpbAUw/fs/vURgLzEGxz3Gdl0B/W4MWMe03RI6dGUWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsCOFT2TXWrC8ite41OAGrLQwlv4SX/JVAu/b0653Da2tsQ1uo50R0xDzn+TuJZ1Hmlz5gKlGqMMhaP9o6WMTqiChh0qndDBXNJD/eGrNyEvQ+KlUSAuvxFnNzOFzq0Ux/1pqnt9yJ35U6VBX3qBCkDJ1vLLLpP5/mIcyrpnZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjjKK0sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4CAC4AF0D;
	Mon, 19 Aug 2024 04:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040784;
	bh=xpbAUw/fs/vURgLzEGxz3Gdl0B/W4MWMe03RI6dGUWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TjjKK0sJTNfwFgf+6uvT4naoH6VH/uqO3KZzv2dwQ5ZoDD3xCAj0LiTKaU4m9PQf1
	 BPfaNHM/cmQrLNvfQvdVZQKWQdImsGk4nAwCKmyG0fX7z0hMMQIW2TNxv56MyhMN/R
	 U7A9GWf9zF0+lnvHY5wj0Do8R233KBwPVPXIRtMY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.165
Date: Mon, 19 Aug 2024 06:12:51 +0200
Message-ID: <2024081951-statue-cadmium-7214@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024081951-swab-polio-dc69@gregkh>
References: <2024081951-swab-polio-dc69@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e61f0d038c6d..cf35b2cf90c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -600,12 +600,6 @@
 			loops can be debugged more effectively on production
 			systems.
 
-	clocksource.max_cswd_read_retries= [KNL]
-			Number of clocksource_watchdog() retries due to
-			external delays before the clock will be marked
-			unstable.  Defaults to three retries, that is,
-			four attempts to read the clock under test.
-
 	clocksource.verify_n_cpus= [KNL]
 			Limit the number of CPUs checked for clocksources
 			marked with CLOCK_SOURCE_VERIFY_PERCPU that
@@ -4355,11 +4349,9 @@
 
 	profile=	[KNL] Enable kernel profiling via /proc/profile
 			Format: [<profiletype>,]<number>
-			Param: <profiletype>: "schedule", "sleep", or "kvm"
+			Param: <profiletype>: "schedule" or "kvm"
 				[defaults to kernel profiling]
 			Param: "schedule" - profile schedule points.
-			Param: "sleep" - profile D-state sleeping (millisecs).
-				Requires CONFIG_SCHEDSTATS
 			Param: "kvm" - profile VM exits.
 			Param: <number> - step/bucket size as a power of 2 for
 				statistical time based profiling.
diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
index 749ae970c319..8aaa5d13d3cc 100644
--- a/Documentation/arm64/cpu-feature-registers.rst
+++ b/Documentation/arm64/cpu-feature-registers.rst
@@ -92,7 +92,7 @@ operation if the source belongs to the supported system register space.
 
 The infrastructure emulates only the following system register space::
 
-	Op0=3, Op1=0, CRn=0, CRm=0,4,5,6,7
+	Op0=3, Op1=0, CRn=0, CRm=0,2,3,4,5,6,7
 
 (See Table C5-6 'System instruction encodings for non-Debug System
 register accesses' in ARMv8 ARM DDI 0487A.h, for the list of
@@ -291,6 +291,42 @@ infrastructure:
      | RPRES                        | [7-4]   |    y    |
      +------------------------------+---------+---------+
 
+  10) MVFR0_EL1 - AArch32 Media and VFP Feature Register 0
+
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | FPDP                         | [11-8]  |    y    |
+     +------------------------------+---------+---------+
+
+  11) MVFR1_EL1 - AArch32 Media and VFP Feature Register 1
+
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | SIMDFMAC                     | [31-28] |    y    |
+     +------------------------------+---------+---------+
+     | SIMDSP                       | [19-16] |    y    |
+     +------------------------------+---------+---------+
+     | SIMDInt                      | [15-12] |    y    |
+     +------------------------------+---------+---------+
+     | SIMDLS                       | [11-8]  |    y    |
+     +------------------------------+---------+---------+
+
+  12) ID_ISAR5_EL1 - AArch32 Instruction Set Attribute Register 5
+
+     +------------------------------+---------+---------+
+     | Name                         |  bits   | visible |
+     +------------------------------+---------+---------+
+     | CRC32                        | [19-16] |    y    |
+     +------------------------------+---------+---------+
+     | SHA2                         | [15-12] |    y    |
+     +------------------------------+---------+---------+
+     | SHA1                         | [11-8]  |    y    |
+     +------------------------------+---------+---------+
+     | AES                          | [7-4]   |    y    |
+     +------------------------------+---------+---------+
+
 
 Appendix I: Example
 -------------------
diff --git a/Documentation/arm64/silicon-errata.rst b/Documentation/arm64/silicon-errata.rst
index df7c53102a5f..9868eb45c56a 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -96,8 +96,16 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A76      | #1463225        | ARM64_ERRATUM_1463225       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A76      | #3324349        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A77      | #1508412        | ARM64_ERRATUM_1508412       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A77      | #3324348        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78      | #3324344        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A78C     | #3324346,3324347| ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2441009        | ARM64_ERRATUM_2441009       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
@@ -108,18 +116,46 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A710     | #2224489        | ARM64_ERRATUM_2224489       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A710     | #3324338        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A720     | #3456091        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A725     | #3456106        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1       | #3324344        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X1C      | #3324346        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X2       | #3324338        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X3       | #3324335        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X4       | #3194386        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-X925     | #3324334        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1188873,1418040| ARM64_ERRATUM_1418040       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1349291        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N1     | #1542419        | ARM64_ERRATUM_1542419       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N1     | #3324349        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2139208        | ARM64_ERRATUM_2139208       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2067961        | ARM64_ERRATUM_2067961       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Neoverse-N2     | #2253138        | ARM64_ERRATUM_2253138       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-N2     | #3324339        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V1     | #3324341        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V2     | #3324336        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Neoverse-V3     | #3312417        | ARM64_ERRATUM_3194386       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-500         | #841119,826419  | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | MMU-600         | #1076982,1209401| N/A                         |
diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 2d34f3ccb257..b5e9f22b28f0 100644
--- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
+++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
@@ -49,7 +49,10 @@ properties:
       to take when the temperature crosses those thresholds.
 
 patternProperties:
-  "^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$":
+  # Node name is limited in size due to Linux kernel requirements - 19
+  # characters in total (see THERMAL_NAME_LENGTH, including terminating NUL
+  # byte):
+  "^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$":
     type: object
     description:
       Each thermal zone node contains information about how frequently it
diff --git a/Makefile b/Makefile
index 78f5cc32b729..2105600c8d7c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 164
+SUBLEVEL = 165
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi b/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
index 4d6a0c3e8455..ff062f4fd726 100644
--- a/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
@@ -5,31 +5,8 @@
 
 #include "imx6q.dtsi"
 #include "imx6qdl-kontron-samx6i.dtsi"
-#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Kontron SMARC sAMX6i Quad/Dual";
 	compatible = "kontron,imx6q-samx6i", "fsl,imx6q";
 };
-
-/* Quad/Dual SoMs have 3 chip-select signals */
-&ecspi4 {
-	cs-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>,
-		   <&gpio3 29 GPIO_ACTIVE_LOW>,
-		   <&gpio3 25 GPIO_ACTIVE_LOW>;
-};
-
-&pinctrl_ecspi4 {
-	fsl,pins = <
-		MX6QDL_PAD_EIM_D21__ECSPI4_SCLK 0x100b1
-		MX6QDL_PAD_EIM_D28__ECSPI4_MOSI 0x100b1
-		MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
-
-		/* SPI4_IMX_CS2# - connected to internal flash */
-		MX6QDL_PAD_EIM_D24__GPIO3_IO24 0x1b0b0
-		/* SPI4_IMX_CS0# - connected to SMARC SPI0_CS0# */
-		MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b0
-		/* SPI4_CS3# - connected to  SMARC SPI0_CS1# */
-		MX6QDL_PAD_EIM_D25__GPIO3_IO25 0x1b0b0
-	>;
-};
diff --git a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
index 683f6e58ab23..668d33d1ff0c 100644
--- a/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-kontron-samx6i.dtsi
@@ -244,7 +244,8 @@ &ecspi4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi4>;
 	cs-gpios = <&gpio3 24 GPIO_ACTIVE_LOW>,
-		   <&gpio3 29 GPIO_ACTIVE_LOW>;
+		   <&gpio3 29 GPIO_ACTIVE_LOW>,
+		   <&gpio3 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	/* default boot source: workaround #1 for errata ERR006282 */
@@ -259,8 +260,20 @@ smarc_flash: flash@0 {
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
+	phy-connection-type = "rgmii-id";
+	phy-handle = <&ethphy>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <1000>;
+		};
+	};
 };
 
 &hdmi {
@@ -452,6 +465,8 @@ MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
 			MX6QDL_PAD_EIM_D24__GPIO3_IO24 0x1b0b0
 			/* SPI_IMX_CS0# - connected to SMARC SPI0_CS0# */
 			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b0
+			/* SPI4_CS3# - connected to SMARC SPI0_CS1# */
+			MX6QDL_PAD_EIM_D25__GPIO3_IO25 0x1b0b0
 		>;
 	};
 
@@ -504,7 +519,7 @@ MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
 			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
 			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25    0x1b0b0 /* RST_GBE0_PHY# */
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x1b0b0 /* RST_GBE0_PHY# */
 		>;
 	};
 
@@ -717,7 +732,7 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	wake-up-gpio = <&gpio6 18 GPIO_ACTIVE_HIGH>;
-	reset-gpio = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	reset-gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
 };
 
 /* LCD_BKLT_PWM */
@@ -805,5 +820,6 @@ &wdog1 {
 	/* CPLD is feeded by watchdog (hardwired) */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_wdog1>;
+	fsl,ext-reset-output;
 	status = "okay";
 };
diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
deleted file mode 100644
index 04828d8918aa..000000000000
--- a/arch/arm/mach-pxa/include/mach/spitz.h
+++ /dev/null
@@ -1,185 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Hardware specific definitions for SL-Cx000 series of PDAs
- *
- * Copyright (c) 2005 Alexander Wykes
- * Copyright (c) 2005 Richard Purdie
- *
- * Based on Sharp's 2.4 kernel patches
- */
-#ifndef __ASM_ARCH_SPITZ_H
-#define __ASM_ARCH_SPITZ_H  1
-#endif
-
-#include "irqs.h" /* PXA_NR_BUILTIN_GPIO, PXA_GPIO_TO_IRQ */
-#include <linux/fb.h>
-
-/* Spitz/Akita GPIOs */
-
-#define SPITZ_GPIO_KEY_INT         (0) /* Key Interrupt */
-#define SPITZ_GPIO_RESET           (1)
-#define SPITZ_GPIO_nSD_DETECT      (9)
-#define SPITZ_GPIO_TP_INT          (11) /* Touch Panel interrupt */
-#define SPITZ_GPIO_AK_INT          (13) /* Remote Control */
-#define SPITZ_GPIO_ADS7846_CS      (14)
-#define SPITZ_GPIO_SYNC            (16)
-#define SPITZ_GPIO_MAX1111_CS      (20)
-#define SPITZ_GPIO_FATAL_BAT       (21)
-#define SPITZ_GPIO_HSYNC           (22)
-#define SPITZ_GPIO_nSD_CLK         (32)
-#define SPITZ_GPIO_USB_DEVICE      (35)
-#define SPITZ_GPIO_USB_HOST        (37)
-#define SPITZ_GPIO_USB_CONNECT     (41)
-#define SPITZ_GPIO_LCDCON_CS       (53)
-#define SPITZ_GPIO_nPCE            (54)
-#define SPITZ_GPIO_nSD_WP          (81)
-#define SPITZ_GPIO_ON_RESET        (89)
-#define SPITZ_GPIO_BAT_COVER       (90)
-#define SPITZ_GPIO_CF_CD           (94)
-#define SPITZ_GPIO_ON_KEY          (95)
-#define SPITZ_GPIO_SWA             (97)
-#define SPITZ_GPIO_SWB             (96)
-#define SPITZ_GPIO_CHRG_FULL       (101)
-#define SPITZ_GPIO_CO              (101)
-#define SPITZ_GPIO_CF_IRQ          (105)
-#define SPITZ_GPIO_AC_IN           (115)
-#define SPITZ_GPIO_HP_IN           (116)
-
-/* Spitz Only GPIOs */
-
-#define SPITZ_GPIO_CF2_IRQ         (106) /* CF slot1 Ready */
-#define SPITZ_GPIO_CF2_CD          (93)
-
-
-/* Spitz/Akita Keyboard Definitions */
-
-#define SPITZ_KEY_STROBE_NUM         (11)
-#define SPITZ_KEY_SENSE_NUM          (7)
-#define SPITZ_GPIO_G0_STROBE_BIT     0x0f800000
-#define SPITZ_GPIO_G1_STROBE_BIT     0x00100000
-#define SPITZ_GPIO_G2_STROBE_BIT     0x01000000
-#define SPITZ_GPIO_G3_STROBE_BIT     0x00041880
-#define SPITZ_GPIO_G0_SENSE_BIT      0x00021000
-#define SPITZ_GPIO_G1_SENSE_BIT      0x000000d4
-#define SPITZ_GPIO_G2_SENSE_BIT      0x08000000
-#define SPITZ_GPIO_G3_SENSE_BIT      0x00000000
-
-#define SPITZ_GPIO_KEY_STROBE0       88
-#define SPITZ_GPIO_KEY_STROBE1       23
-#define SPITZ_GPIO_KEY_STROBE2       24
-#define SPITZ_GPIO_KEY_STROBE3       25
-#define SPITZ_GPIO_KEY_STROBE4       26
-#define SPITZ_GPIO_KEY_STROBE5       27
-#define SPITZ_GPIO_KEY_STROBE6       52
-#define SPITZ_GPIO_KEY_STROBE7       103
-#define SPITZ_GPIO_KEY_STROBE8       107
-#define SPITZ_GPIO_KEY_STROBE9       108
-#define SPITZ_GPIO_KEY_STROBE10      114
-
-#define SPITZ_GPIO_KEY_SENSE0        12
-#define SPITZ_GPIO_KEY_SENSE1        17
-#define SPITZ_GPIO_KEY_SENSE2        91
-#define SPITZ_GPIO_KEY_SENSE3        34
-#define SPITZ_GPIO_KEY_SENSE4        36
-#define SPITZ_GPIO_KEY_SENSE5        38
-#define SPITZ_GPIO_KEY_SENSE6        39
-
-
-/* Spitz Scoop Device (No. 1) GPIOs */
-/* Suspend States in comments */
-#define SPITZ_SCP_LED_GREEN     SCOOP_GPCR_PA11  /* Keep */
-#define SPITZ_SCP_JK_B          SCOOP_GPCR_PA12  /* Keep */
-#define SPITZ_SCP_CHRG_ON       SCOOP_GPCR_PA13  /* Keep */
-#define SPITZ_SCP_MUTE_L        SCOOP_GPCR_PA14  /* Low */
-#define SPITZ_SCP_MUTE_R        SCOOP_GPCR_PA15  /* Low */
-#define SPITZ_SCP_CF_POWER      SCOOP_GPCR_PA16  /* Keep */
-#define SPITZ_SCP_LED_ORANGE    SCOOP_GPCR_PA17  /* Keep */
-#define SPITZ_SCP_JK_A          SCOOP_GPCR_PA18  /* Low */
-#define SPITZ_SCP_ADC_TEMP_ON   SCOOP_GPCR_PA19  /* Low */
-
-#define SPITZ_SCP_IO_DIR      (SPITZ_SCP_JK_B | SPITZ_SCP_CHRG_ON | \
-                               SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | \
-                               SPITZ_SCP_CF_POWER | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
-#define SPITZ_SCP_IO_OUT      (SPITZ_SCP_CHRG_ON | SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R)
-#define SPITZ_SCP_SUS_CLR     (SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
-#define SPITZ_SCP_SUS_SET     0
-
-#define SPITZ_SCP_GPIO_BASE	(PXA_NR_BUILTIN_GPIO)
-#define SPITZ_GPIO_LED_GREEN	(SPITZ_SCP_GPIO_BASE + 0)
-#define SPITZ_GPIO_JK_B		(SPITZ_SCP_GPIO_BASE + 1)
-#define SPITZ_GPIO_CHRG_ON	(SPITZ_SCP_GPIO_BASE + 2)
-#define SPITZ_GPIO_MUTE_L	(SPITZ_SCP_GPIO_BASE + 3)
-#define SPITZ_GPIO_MUTE_R	(SPITZ_SCP_GPIO_BASE + 4)
-#define SPITZ_GPIO_CF_POWER	(SPITZ_SCP_GPIO_BASE + 5)
-#define SPITZ_GPIO_LED_ORANGE	(SPITZ_SCP_GPIO_BASE + 6)
-#define SPITZ_GPIO_JK_A		(SPITZ_SCP_GPIO_BASE + 7)
-#define SPITZ_GPIO_ADC_TEMP_ON	(SPITZ_SCP_GPIO_BASE + 8)
-
-/* Spitz Scoop Device (No. 2) GPIOs */
-/* Suspend States in comments */
-#define SPITZ_SCP2_IR_ON           SCOOP_GPCR_PA11  /* High */
-#define SPITZ_SCP2_AKIN_PULLUP     SCOOP_GPCR_PA12  /* Keep */
-#define SPITZ_SCP2_RESERVED_1      SCOOP_GPCR_PA13  /* High */
-#define SPITZ_SCP2_RESERVED_2      SCOOP_GPCR_PA14  /* Low */
-#define SPITZ_SCP2_RESERVED_3      SCOOP_GPCR_PA15  /* Low */
-#define SPITZ_SCP2_RESERVED_4      SCOOP_GPCR_PA16  /* Low */
-#define SPITZ_SCP2_BACKLIGHT_CONT  SCOOP_GPCR_PA17  /* Low */
-#define SPITZ_SCP2_BACKLIGHT_ON    SCOOP_GPCR_PA18  /* Low */
-#define SPITZ_SCP2_MIC_BIAS        SCOOP_GPCR_PA19  /* Low */
-
-#define SPITZ_SCP2_IO_DIR (SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1 | \
-                           SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
-                           SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
-
-#define SPITZ_SCP2_IO_OUT   (SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1)
-#define SPITZ_SCP2_SUS_CLR  (SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
-                             SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
-#define SPITZ_SCP2_SUS_SET  (SPITZ_SCP2_IR_ON | SPITZ_SCP2_RESERVED_1)
-
-#define SPITZ_SCP2_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
-#define SPITZ_GPIO_IR_ON		(SPITZ_SCP2_GPIO_BASE + 0)
-#define SPITZ_GPIO_AKIN_PULLUP		(SPITZ_SCP2_GPIO_BASE + 1)
-#define SPITZ_GPIO_RESERVED_1		(SPITZ_SCP2_GPIO_BASE + 2)
-#define SPITZ_GPIO_RESERVED_2		(SPITZ_SCP2_GPIO_BASE + 3)
-#define SPITZ_GPIO_RESERVED_3		(SPITZ_SCP2_GPIO_BASE + 4)
-#define SPITZ_GPIO_RESERVED_4		(SPITZ_SCP2_GPIO_BASE + 5)
-#define SPITZ_GPIO_BACKLIGHT_CONT	(SPITZ_SCP2_GPIO_BASE + 6)
-#define SPITZ_GPIO_BACKLIGHT_ON		(SPITZ_SCP2_GPIO_BASE + 7)
-#define SPITZ_GPIO_MIC_BIAS		(SPITZ_SCP2_GPIO_BASE + 8)
-
-/* Akita IO Expander GPIOs */
-#define AKITA_IOEXP_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
-#define AKITA_GPIO_RESERVED_0		(AKITA_IOEXP_GPIO_BASE + 0)
-#define AKITA_GPIO_RESERVED_1		(AKITA_IOEXP_GPIO_BASE + 1)
-#define AKITA_GPIO_MIC_BIAS		(AKITA_IOEXP_GPIO_BASE + 2)
-#define AKITA_GPIO_BACKLIGHT_ON		(AKITA_IOEXP_GPIO_BASE + 3)
-#define AKITA_GPIO_BACKLIGHT_CONT	(AKITA_IOEXP_GPIO_BASE + 4)
-#define AKITA_GPIO_AKIN_PULLUP		(AKITA_IOEXP_GPIO_BASE + 5)
-#define AKITA_GPIO_IR_ON		(AKITA_IOEXP_GPIO_BASE + 6)
-#define AKITA_GPIO_RESERVED_7		(AKITA_IOEXP_GPIO_BASE + 7)
-
-/* Spitz IRQ Definitions */
-
-#define SPITZ_IRQ_GPIO_KEY_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_KEY_INT)
-#define SPITZ_IRQ_GPIO_AC_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_AC_IN)
-#define SPITZ_IRQ_GPIO_AK_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_AK_INT)
-#define SPITZ_IRQ_GPIO_HP_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_HP_IN)
-#define SPITZ_IRQ_GPIO_TP_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT)
-#define SPITZ_IRQ_GPIO_SYNC           PXA_GPIO_TO_IRQ(SPITZ_GPIO_SYNC)
-#define SPITZ_IRQ_GPIO_ON_KEY         PXA_GPIO_TO_IRQ(SPITZ_GPIO_ON_KEY)
-#define SPITZ_IRQ_GPIO_SWA            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWA)
-#define SPITZ_IRQ_GPIO_SWB            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWB)
-#define SPITZ_IRQ_GPIO_BAT_COVER      PXA_GPIO_TO_IRQ(SPITZ_GPIO_BAT_COVER)
-#define SPITZ_IRQ_GPIO_FATAL_BAT      PXA_GPIO_TO_IRQ(SPITZ_GPIO_FATAL_BAT)
-#define SPITZ_IRQ_GPIO_CO             PXA_GPIO_TO_IRQ(SPITZ_GPIO_CO)
-#define SPITZ_IRQ_GPIO_CF_IRQ         PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_IRQ)
-#define SPITZ_IRQ_GPIO_CF_CD          PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_CD)
-#define SPITZ_IRQ_GPIO_CF2_IRQ        PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF2_IRQ)
-#define SPITZ_IRQ_GPIO_nSD_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_INT)
-#define SPITZ_IRQ_GPIO_nSD_DETECT     PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_DETECT)
-
-/*
- * Shared data structures
- */
-extern struct platform_device spitzssp_device;
-extern struct sharpsl_charger_machinfo spitz_pm_machinfo;
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 264de0bc97d6..9bdc20706d18 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -43,7 +43,7 @@
 #include <linux/platform_data/mmc-pxamci.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 #include <linux/platform_data/video-pxafb.h>
-#include <mach/spitz.h>
+#include "spitz.h"
 #include "sharpsl_pm.h"
 #include <mach/smemc.h>
 
@@ -516,10 +516,8 @@ static struct pxa2xx_spi_chip spitz_ads7846_chip = {
 static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_BACKLIGHT_CONT,
-			    "BL_CONT", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", SPITZ_GPIO_BACKLIGHT_ON,
-			    "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.1", 6, "BL_CONT", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("sharp-scoop.1", 7, "BL_ON", GPIO_ACTIVE_HIGH),
 		{ },
 	},
 };
@@ -527,10 +525,8 @@ static struct gpiod_lookup_table spitz_lcdcon_gpio_table = {
 static struct gpiod_lookup_table akita_lcdcon_gpio_table = {
 	.dev_id = "spi2.1",
 	.table = {
-		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_BACKLIGHT_CONT,
-			    "BL_CONT", GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP("gpio-pxa", AKITA_GPIO_BACKLIGHT_ON,
-			    "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 3, "BL_ON", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 4, "BL_CONT", GPIO_ACTIVE_LOW),
 		{ },
 	},
 };
@@ -954,11 +950,36 @@ static void __init spitz_i2c_init(void)
 static inline void spitz_i2c_init(void) {}
 #endif
 
+static struct gpiod_lookup_table spitz_audio_gpio_table = {
+	.dev_id = "spitz-audio",
+	.table = {
+		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.1", 8, "mic", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
+static struct gpiod_lookup_table akita_audio_gpio_table = {
+	.dev_id = "spitz-audio",
+	.table = {
+		GPIO_LOOKUP("sharp-scoop.0", 3, "mute-l", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("sharp-scoop.0", 4, "mute-r", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("i2c-max7310", 2, "mic", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 /******************************************************************************
  * Audio devices
  ******************************************************************************/
 static inline void spitz_audio_init(void)
 {
+	if (machine_is_akita())
+		gpiod_add_lookup_table(&akita_audio_gpio_table);
+	else
+		gpiod_add_lookup_table(&spitz_audio_gpio_table);
+
 	platform_device_register_simple("spitz-audio", -1, NULL, 0);
 }
 
diff --git a/arch/arm/mach-pxa/spitz.h b/arch/arm/mach-pxa/spitz.h
new file mode 100644
index 000000000000..f97e3ebd762d
--- /dev/null
+++ b/arch/arm/mach-pxa/spitz.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Hardware specific definitions for SL-Cx000 series of PDAs
+ *
+ * Copyright (c) 2005 Alexander Wykes
+ * Copyright (c) 2005 Richard Purdie
+ *
+ * Based on Sharp's 2.4 kernel patches
+ */
+#ifndef __ASM_ARCH_SPITZ_H
+#define __ASM_ARCH_SPITZ_H  1
+#endif
+
+#include <mach/irqs.h> /* PXA_NR_BUILTIN_GPIO, PXA_GPIO_TO_IRQ */
+#include <linux/fb.h>
+
+/* Spitz/Akita GPIOs */
+
+#define SPITZ_GPIO_KEY_INT         (0) /* Key Interrupt */
+#define SPITZ_GPIO_RESET           (1)
+#define SPITZ_GPIO_nSD_DETECT      (9)
+#define SPITZ_GPIO_TP_INT          (11) /* Touch Panel interrupt */
+#define SPITZ_GPIO_AK_INT          (13) /* Remote Control */
+#define SPITZ_GPIO_ADS7846_CS      (14)
+#define SPITZ_GPIO_SYNC            (16)
+#define SPITZ_GPIO_MAX1111_CS      (20)
+#define SPITZ_GPIO_FATAL_BAT       (21)
+#define SPITZ_GPIO_HSYNC           (22)
+#define SPITZ_GPIO_nSD_CLK         (32)
+#define SPITZ_GPIO_USB_DEVICE      (35)
+#define SPITZ_GPIO_USB_HOST        (37)
+#define SPITZ_GPIO_USB_CONNECT     (41)
+#define SPITZ_GPIO_LCDCON_CS       (53)
+#define SPITZ_GPIO_nPCE            (54)
+#define SPITZ_GPIO_nSD_WP          (81)
+#define SPITZ_GPIO_ON_RESET        (89)
+#define SPITZ_GPIO_BAT_COVER       (90)
+#define SPITZ_GPIO_CF_CD           (94)
+#define SPITZ_GPIO_ON_KEY          (95)
+#define SPITZ_GPIO_SWA             (97)
+#define SPITZ_GPIO_SWB             (96)
+#define SPITZ_GPIO_CHRG_FULL       (101)
+#define SPITZ_GPIO_CO              (101)
+#define SPITZ_GPIO_CF_IRQ          (105)
+#define SPITZ_GPIO_AC_IN           (115)
+#define SPITZ_GPIO_HP_IN           (116)
+
+/* Spitz Only GPIOs */
+
+#define SPITZ_GPIO_CF2_IRQ         (106) /* CF slot1 Ready */
+#define SPITZ_GPIO_CF2_CD          (93)
+
+
+/* Spitz/Akita Keyboard Definitions */
+
+#define SPITZ_KEY_STROBE_NUM         (11)
+#define SPITZ_KEY_SENSE_NUM          (7)
+#define SPITZ_GPIO_G0_STROBE_BIT     0x0f800000
+#define SPITZ_GPIO_G1_STROBE_BIT     0x00100000
+#define SPITZ_GPIO_G2_STROBE_BIT     0x01000000
+#define SPITZ_GPIO_G3_STROBE_BIT     0x00041880
+#define SPITZ_GPIO_G0_SENSE_BIT      0x00021000
+#define SPITZ_GPIO_G1_SENSE_BIT      0x000000d4
+#define SPITZ_GPIO_G2_SENSE_BIT      0x08000000
+#define SPITZ_GPIO_G3_SENSE_BIT      0x00000000
+
+#define SPITZ_GPIO_KEY_STROBE0       88
+#define SPITZ_GPIO_KEY_STROBE1       23
+#define SPITZ_GPIO_KEY_STROBE2       24
+#define SPITZ_GPIO_KEY_STROBE3       25
+#define SPITZ_GPIO_KEY_STROBE4       26
+#define SPITZ_GPIO_KEY_STROBE5       27
+#define SPITZ_GPIO_KEY_STROBE6       52
+#define SPITZ_GPIO_KEY_STROBE7       103
+#define SPITZ_GPIO_KEY_STROBE8       107
+#define SPITZ_GPIO_KEY_STROBE9       108
+#define SPITZ_GPIO_KEY_STROBE10      114
+
+#define SPITZ_GPIO_KEY_SENSE0        12
+#define SPITZ_GPIO_KEY_SENSE1        17
+#define SPITZ_GPIO_KEY_SENSE2        91
+#define SPITZ_GPIO_KEY_SENSE3        34
+#define SPITZ_GPIO_KEY_SENSE4        36
+#define SPITZ_GPIO_KEY_SENSE5        38
+#define SPITZ_GPIO_KEY_SENSE6        39
+
+
+/* Spitz Scoop Device (No. 1) GPIOs */
+/* Suspend States in comments */
+#define SPITZ_SCP_LED_GREEN     SCOOP_GPCR_PA11  /* Keep */
+#define SPITZ_SCP_JK_B          SCOOP_GPCR_PA12  /* Keep */
+#define SPITZ_SCP_CHRG_ON       SCOOP_GPCR_PA13  /* Keep */
+#define SPITZ_SCP_MUTE_L        SCOOP_GPCR_PA14  /* Low */
+#define SPITZ_SCP_MUTE_R        SCOOP_GPCR_PA15  /* Low */
+#define SPITZ_SCP_CF_POWER      SCOOP_GPCR_PA16  /* Keep */
+#define SPITZ_SCP_LED_ORANGE    SCOOP_GPCR_PA17  /* Keep */
+#define SPITZ_SCP_JK_A          SCOOP_GPCR_PA18  /* Low */
+#define SPITZ_SCP_ADC_TEMP_ON   SCOOP_GPCR_PA19  /* Low */
+
+#define SPITZ_SCP_IO_DIR      (SPITZ_SCP_JK_B | SPITZ_SCP_CHRG_ON | \
+                               SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | \
+                               SPITZ_SCP_CF_POWER | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
+#define SPITZ_SCP_IO_OUT      (SPITZ_SCP_CHRG_ON | SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R)
+#define SPITZ_SCP_SUS_CLR     (SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
+#define SPITZ_SCP_SUS_SET     0
+
+#define SPITZ_SCP_GPIO_BASE	(PXA_NR_BUILTIN_GPIO)
+#define SPITZ_GPIO_LED_GREEN	(SPITZ_SCP_GPIO_BASE + 0)
+#define SPITZ_GPIO_JK_B		(SPITZ_SCP_GPIO_BASE + 1)
+#define SPITZ_GPIO_CHRG_ON	(SPITZ_SCP_GPIO_BASE + 2)
+#define SPITZ_GPIO_MUTE_L	(SPITZ_SCP_GPIO_BASE + 3)
+#define SPITZ_GPIO_MUTE_R	(SPITZ_SCP_GPIO_BASE + 4)
+#define SPITZ_GPIO_CF_POWER	(SPITZ_SCP_GPIO_BASE + 5)
+#define SPITZ_GPIO_LED_ORANGE	(SPITZ_SCP_GPIO_BASE + 6)
+#define SPITZ_GPIO_JK_A		(SPITZ_SCP_GPIO_BASE + 7)
+#define SPITZ_GPIO_ADC_TEMP_ON	(SPITZ_SCP_GPIO_BASE + 8)
+
+/* Spitz Scoop Device (No. 2) GPIOs */
+/* Suspend States in comments */
+#define SPITZ_SCP2_IR_ON           SCOOP_GPCR_PA11  /* High */
+#define SPITZ_SCP2_AKIN_PULLUP     SCOOP_GPCR_PA12  /* Keep */
+#define SPITZ_SCP2_RESERVED_1      SCOOP_GPCR_PA13  /* High */
+#define SPITZ_SCP2_RESERVED_2      SCOOP_GPCR_PA14  /* Low */
+#define SPITZ_SCP2_RESERVED_3      SCOOP_GPCR_PA15  /* Low */
+#define SPITZ_SCP2_RESERVED_4      SCOOP_GPCR_PA16  /* Low */
+#define SPITZ_SCP2_BACKLIGHT_CONT  SCOOP_GPCR_PA17  /* Low */
+#define SPITZ_SCP2_BACKLIGHT_ON    SCOOP_GPCR_PA18  /* Low */
+#define SPITZ_SCP2_MIC_BIAS        SCOOP_GPCR_PA19  /* Low */
+
+#define SPITZ_SCP2_IO_DIR (SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1 | \
+                           SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
+                           SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
+
+#define SPITZ_SCP2_IO_OUT   (SPITZ_SCP2_AKIN_PULLUP | SPITZ_SCP2_RESERVED_1)
+#define SPITZ_SCP2_SUS_CLR  (SPITZ_SCP2_RESERVED_2 | SPITZ_SCP2_RESERVED_3 | SPITZ_SCP2_RESERVED_4 | \
+                             SPITZ_SCP2_BACKLIGHT_CONT | SPITZ_SCP2_BACKLIGHT_ON | SPITZ_SCP2_MIC_BIAS)
+#define SPITZ_SCP2_SUS_SET  (SPITZ_SCP2_IR_ON | SPITZ_SCP2_RESERVED_1)
+
+#define SPITZ_SCP2_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
+#define SPITZ_GPIO_IR_ON		(SPITZ_SCP2_GPIO_BASE + 0)
+#define SPITZ_GPIO_AKIN_PULLUP		(SPITZ_SCP2_GPIO_BASE + 1)
+#define SPITZ_GPIO_RESERVED_1		(SPITZ_SCP2_GPIO_BASE + 2)
+#define SPITZ_GPIO_RESERVED_2		(SPITZ_SCP2_GPIO_BASE + 3)
+#define SPITZ_GPIO_RESERVED_3		(SPITZ_SCP2_GPIO_BASE + 4)
+#define SPITZ_GPIO_RESERVED_4		(SPITZ_SCP2_GPIO_BASE + 5)
+#define SPITZ_GPIO_BACKLIGHT_CONT	(SPITZ_SCP2_GPIO_BASE + 6)
+#define SPITZ_GPIO_BACKLIGHT_ON		(SPITZ_SCP2_GPIO_BASE + 7)
+#define SPITZ_GPIO_MIC_BIAS		(SPITZ_SCP2_GPIO_BASE + 8)
+
+/* Akita IO Expander GPIOs */
+#define AKITA_IOEXP_GPIO_BASE		(PXA_NR_BUILTIN_GPIO + 12)
+#define AKITA_GPIO_RESERVED_0		(AKITA_IOEXP_GPIO_BASE + 0)
+#define AKITA_GPIO_RESERVED_1		(AKITA_IOEXP_GPIO_BASE + 1)
+#define AKITA_GPIO_MIC_BIAS		(AKITA_IOEXP_GPIO_BASE + 2)
+#define AKITA_GPIO_BACKLIGHT_ON		(AKITA_IOEXP_GPIO_BASE + 3)
+#define AKITA_GPIO_BACKLIGHT_CONT	(AKITA_IOEXP_GPIO_BASE + 4)
+#define AKITA_GPIO_AKIN_PULLUP		(AKITA_IOEXP_GPIO_BASE + 5)
+#define AKITA_GPIO_IR_ON		(AKITA_IOEXP_GPIO_BASE + 6)
+#define AKITA_GPIO_RESERVED_7		(AKITA_IOEXP_GPIO_BASE + 7)
+
+/* Spitz IRQ Definitions */
+
+#define SPITZ_IRQ_GPIO_KEY_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_KEY_INT)
+#define SPITZ_IRQ_GPIO_AC_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_AC_IN)
+#define SPITZ_IRQ_GPIO_AK_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_AK_INT)
+#define SPITZ_IRQ_GPIO_HP_IN          PXA_GPIO_TO_IRQ(SPITZ_GPIO_HP_IN)
+#define SPITZ_IRQ_GPIO_TP_INT         PXA_GPIO_TO_IRQ(SPITZ_GPIO_TP_INT)
+#define SPITZ_IRQ_GPIO_SYNC           PXA_GPIO_TO_IRQ(SPITZ_GPIO_SYNC)
+#define SPITZ_IRQ_GPIO_ON_KEY         PXA_GPIO_TO_IRQ(SPITZ_GPIO_ON_KEY)
+#define SPITZ_IRQ_GPIO_SWA            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWA)
+#define SPITZ_IRQ_GPIO_SWB            PXA_GPIO_TO_IRQ(SPITZ_GPIO_SWB)
+#define SPITZ_IRQ_GPIO_BAT_COVER      PXA_GPIO_TO_IRQ(SPITZ_GPIO_BAT_COVER)
+#define SPITZ_IRQ_GPIO_FATAL_BAT      PXA_GPIO_TO_IRQ(SPITZ_GPIO_FATAL_BAT)
+#define SPITZ_IRQ_GPIO_CO             PXA_GPIO_TO_IRQ(SPITZ_GPIO_CO)
+#define SPITZ_IRQ_GPIO_CF_IRQ         PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_IRQ)
+#define SPITZ_IRQ_GPIO_CF_CD          PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF_CD)
+#define SPITZ_IRQ_GPIO_CF2_IRQ        PXA_GPIO_TO_IRQ(SPITZ_GPIO_CF2_IRQ)
+#define SPITZ_IRQ_GPIO_nSD_INT        PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_INT)
+#define SPITZ_IRQ_GPIO_nSD_DETECT     PXA_GPIO_TO_IRQ(SPITZ_GPIO_nSD_DETECT)
+
+/*
+ * Shared data structures
+ */
+extern struct platform_device spitzssp_device;
+extern struct sharpsl_charger_machinfo spitz_pm_machinfo;
diff --git a/arch/arm/mach-pxa/spitz_pm.c b/arch/arm/mach-pxa/spitz_pm.c
index 25a1f8c5a738..6167f96d7b41 100644
--- a/arch/arm/mach-pxa/spitz_pm.c
+++ b/arch/arm/mach-pxa/spitz_pm.c
@@ -20,7 +20,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 
-#include <mach/spitz.h>
+#include "spitz.h"
 #include "pxa27x.h"
 #include "sharpsl_pm.h"
 
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 68874d3856b9..2d77e9269eb5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -848,6 +848,44 @@ config ARM64_ERRATUM_2224489
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_3194386
+	bool "Cortex-*/Neoverse-*: workaround for MSR SSBS not self-synchronizing"
+	default y
+	help
+	  This option adds the workaround for the following errata:
+
+	  * ARM Cortex-A76 erratum 3324349
+	  * ARM Cortex-A77 erratum 3324348
+	  * ARM Cortex-A78 erratum 3324344
+	  * ARM Cortex-A78C erratum 3324346
+	  * ARM Cortex-A78C erratum 3324347
+	  * ARM Cortex-A710 erratam 3324338
+	  * ARM Cortex-A720 erratum 3456091
+	  * ARM Cortex-A725 erratum 3456106
+	  * ARM Cortex-X1 erratum 3324344
+	  * ARM Cortex-X1C erratum 3324346
+	  * ARM Cortex-X2 erratum 3324338
+	  * ARM Cortex-X3 erratum 3324335
+	  * ARM Cortex-X4 erratum 3194386
+	  * ARM Cortex-X925 erratum 3324334
+	  * ARM Neoverse-N1 erratum 3324349
+	  * ARM Neoverse N2 erratum 3324339
+	  * ARM Neoverse-V1 erratum 3324341
+	  * ARM Neoverse V2 erratum 3324336
+	  * ARM Neoverse-V3 erratum 3312417
+
+	  On affected cores "MSR SSBS, #0" instructions may not affect
+	  subsequent speculative instructions, which may permit unexepected
+	  speculative store bypassing.
+
+	  Work around this problem by placing a Speculation Barrier (SB) or
+	  Instruction Synchronization Barrier (ISB) after kernel changes to
+	  SSBS. The presence of the SSBS special-purpose register is hidden
+	  from hwcaps and EL0 reads of ID_AA64PFR1_EL1, such that userspace
+	  will use the PR_SPEC_STORE_BYPASS prctl to change SSBS.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 7c029f552a23..256c46771db7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -311,8 +311,8 @@ &hdmi_tx {
 		 <&reset RESET_HDMI_SYSTEM_RESET>,
 		 <&reset RESET_HDMI_TX>;
 	reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
-	clocks = <&clkc CLKID_HDMI_PCLK>,
-		 <&clkc CLKID_CLK81>,
+	clocks = <&clkc CLKID_HDMI>,
+		 <&clkc CLKID_HDMI_PCLK>,
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 350022935052..a689bd14ece9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -323,8 +323,8 @@ &hdmi_tx {
 		 <&reset RESET_HDMI_SYSTEM_RESET>,
 		 <&reset RESET_HDMI_TX>;
 	reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
-	clocks = <&clkc CLKID_HDMI_PCLK>,
-		 <&clkc CLKID_CLK81>,
+	clocks = <&clkc CLKID_HDMI>,
+		 <&clkc CLKID_HDMI_PCLK>,
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index 483f7ab4f31c..b4aa9a9712fe 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -285,8 +285,8 @@ asm_sel {
 	/* eMMC is shared pin with parallel NAND */
 	emmc_pins_default: emmc-pins-default {
 		mux {
-			function = "emmc", "emmc_rst";
-			groups = "emmc";
+			function = "emmc";
+			groups = "emmc", "emmc_rst";
 		};
 
 		/* "NDL0","NDL1","NDL2","NDL3","NDL4","NDL5","NDL6","NDL7",
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index 28e17a7e2a5a..e1ad840dc317 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -249,8 +249,8 @@ &pio {
 	/* eMMC is shared pin with parallel NAND */
 	emmc_pins_default: emmc-pins-default {
 		mux {
-			function = "emmc", "emmc_rst";
-			groups = "emmc";
+			function = "emmc";
+			groups = "emmc", "emmc_rst";
 		};
 
 		/* "NDL0","NDL1","NDL2","NDL3","NDL4","NDL5","NDL6","NDL7",
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
index 88fca67dead0..13757d7ac792 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
@@ -169,21 +169,24 @@ anx_bridge: anx7625@58 {
 		vdd18-supply = <&pp1800_mipibrdg>;
 		vdd33-supply = <&vddio_mipibrdg>;
 
-		#address-cells = <1>;
-		#size-cells = <0>;
-		port@0 {
-			reg = <0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
 
-			anx7625_in: endpoint {
-				remote-endpoint = <&dsi_out>;
+			port@0 {
+				reg = <0>;
+
+				anx7625_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
 			};
-		};
 
-		port@1 {
-			reg = <1>;
+			port@1 {
+				reg = <1>;
 
-			anx7625_out: endpoint {
-				remote-endpoint = <&panel_in>;
+				anx7625_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 22a1c66325c2..5e77f3b1b84b 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -703,7 +703,6 @@ pins-tx {
 		};
 		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
-			output-enable;
 		};
 		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
@@ -722,7 +721,6 @@ pins-tx {
 		};
 		pins-rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
-			output-enable;
 		};
 		pins-cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 17eeff106bab..384904344baf 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -91,7 +91,6 @@ soc: soc {
 		ssphy_1: phy@58000 {
 			compatible = "qcom,ipq8074-qmp-usb3-phy";
 			reg = <0x00058000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -112,6 +111,7 @@ usb1_ssphy: phy@58200 {
 				      <0x00058800 0x1f8>,     /* PCS  */
 				      <0x00058600 0x044>;     /* PCS misc*/
 				#phy-cells = <0>;
+				#clock-cells = <1>;
 				clocks = <&gcc GCC_USB1_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3phy_1_cc_pipe_clk";
@@ -134,7 +134,6 @@ qusb_phy_1: phy@59000 {
 		ssphy_0: phy@78000 {
 			compatible = "qcom,ipq8074-qmp-usb3-phy";
 			reg = <0x00078000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -155,6 +154,7 @@ usb0_ssphy: phy@78200 {
 				      <0x00078800 0x1f8>,     /* PCS  */
 				      <0x00078600 0x044>;     /* PCS misc*/
 				#phy-cells = <0>;
+				#clock-cells = <1>;
 				clocks = <&gcc GCC_USB0_PIPE_CLK>;
 				clock-names = "pipe0";
 				clock-output-names = "usb3phy_0_cc_pipe_clk";
@@ -514,6 +514,7 @@ dwc_0: dwc3@8a00000 {
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_0>, <&usb0_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
@@ -554,6 +555,7 @@ dwc_1: dwc3@8c00000 {
 				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 				phys = <&qusb_phy_1>, <&usb1_ssphy>;
 				phy-names = "usb2-phy", "usb3-phy";
+				snps,parkmode-disable-ss-quirk;
 				snps,is-utmi-l1-suspend;
 				snps,hird-threshold = /bits/ 8 <0x0>;
 				snps,dis_u2_susphy_quirk;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 8b3e753c1a2a..9ee8eebfcdb5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -615,7 +615,6 @@ soc: soc {
 		pcie_phy: phy@34000 {
 			compatible = "qcom,msm8996-qmp-pcie-phy";
 			reg = <0x00034000 0x488>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -637,6 +636,7 @@ pciephy_0: phy@35000 {
 				      <0x00035400 0x1dc>;
 				#phy-cells = <0>;
 
+				#clock-cells = <0>;
 				clock-output-names = "pcie_0_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -650,6 +650,7 @@ pciephy_1: phy@36000 {
 				      <0x00036400 0x1dc>;
 				#phy-cells = <0>;
 
+				#clock-cells = <0>;
 				clock-output-names = "pcie_1_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
 				clock-names = "pipe1";
@@ -663,6 +664,7 @@ pciephy_2: phy@37000 {
 				      <0x00037400 0x1dc>;
 				#phy-cells = <0>;
 
+				#clock-cells = <0>;
 				clock-output-names = "pcie_2_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
 				clock-names = "pipe2";
@@ -1756,7 +1758,7 @@ ufshc: ufshc@624000 {
 				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
 			freq-table-hz =
 				<100000000 200000000>,
-				<0 0>,
+				<100000000 200000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>,
@@ -2642,7 +2644,6 @@ usb3_dwc3: dwc3@6a00000 {
 		usb3phy: phy@7410000 {
 			compatible = "qcom,msm8996-qmp-usb3-phy";
 			reg = <0x07410000 0x1c4>;
-			#clock-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
@@ -2663,6 +2664,7 @@ ssusb_phy_0: phy@7410200 {
 				      <0x07410600 0x1a8>;
 				#phy-cells = <0>;
 
+				#clock-cells = <0>;
 				clock-output-names = "usb3_phy_pipe_clk_src";
 				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
 				clock-names = "pipe0";
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index d636718adbde..8ca6a6f1a541 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1982,7 +1982,8 @@ usb3_dwc3: dwc3@a800000 {
 				interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 				snps,dis_u2_susphy_quirk;
 				snps,dis_enblslpm_quirk;
-				phys = <&qusb2phy>, <&usb1_ssphy>;
+				snps,parkmode-disable-ss-quirk;
+				phys = <&qusb2phy>, <&usb3phy>;
 				phy-names = "usb2-phy", "usb3-phy";
 				snps,has-lpm-erratum;
 				snps,hird-threshold = /bits/ 8 <0x10>;
@@ -1991,33 +1992,26 @@ usb3_dwc3: dwc3@a800000 {
 
 		usb3phy: phy@c010000 {
 			compatible = "qcom,msm8998-qmp-usb3-phy";
-			reg = <0x0c010000 0x18c>;
-			status = "disabled";
-			#clock-cells = <1>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
+			reg = <0x0c010000 0x1000>;
 
 			clocks = <&gcc GCC_USB3_PHY_AUX_CLK>,
+				 <&gcc GCC_USB3_CLKREF_CLK>,
 				 <&gcc GCC_USB_PHY_CFG_AHB2PHY_CLK>,
-				 <&gcc GCC_USB3_CLKREF_CLK>;
-			clock-names = "aux", "cfg_ahb", "ref";
+				 <&gcc GCC_USB3_PHY_PIPE_CLK>;
+			clock-names = "aux",
+				      "ref",
+				      "cfg_ahb",
+				      "pipe";
+			clock-output-names = "usb3_phy_pipe_clk_src";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
 
 			resets = <&gcc GCC_USB3_PHY_BCR>,
 				 <&gcc GCC_USB3PHY_PHY_BCR>;
-			reset-names = "phy", "common";
+			reset-names = "phy",
+				      "phy_phy";
 
-			usb1_ssphy: phy@c010200 {
-				reg = <0xc010200 0x128>,
-				      <0xc010400 0x200>,
-				      <0xc010c00 0x20c>,
-				      <0xc010600 0x128>,
-				      <0xc010800 0x200>;
-				#phy-cells = <0>;
-				clocks = <&gcc GCC_USB3_PHY_PIPE_CLK>;
-				clock-names = "pipe0";
-				clock-output-names = "usb3_phy_pipe_clk_src";
-			};
+			status = "disabled";
 		};
 
 		qusb2phy: phy@c012000 {
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 6f7061c878e4..cff5423e9c88 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2299,6 +2299,8 @@ ufs_mem_phy: phy@1d87000 {
 			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 8880e9cbc974..5f504569731a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -1702,7 +1702,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				     "jedec,ufs-2.0";
 			reg = <0 0x01d84000 0 0x3000>;
 			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
-			phys = <&ufs_mem_phy_lanes>;
+			phys = <&ufs_mem_phy>;
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			#reset-cells = <1>;
@@ -1746,10 +1746,8 @@ ufs_mem_hc: ufshc@1d84000 {
 
 		ufs_mem_phy: phy@1d87000 {
 			compatible = "qcom,sm8250-qmp-ufs-phy";
-			reg = <0 0x01d87000 0 0x1c0>;
-			#address-cells = <2>;
-			#size-cells = <2>;
-			ranges;
+			reg = <0 0x01d87000 0 0x1000>;
+
 			clock-names = "ref",
 				      "ref_aux";
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
@@ -1757,16 +1755,12 @@ ufs_mem_phy: phy@1d87000 {
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-			status = "disabled";
 
-			ufs_mem_phy_lanes: phy@1d87400 {
-				reg = <0 0x01d87400 0 0x16c>,
-				      <0 0x01d87600 0 0x200>,
-				      <0 0x01d87c00 0 0x200>,
-				      <0 0x01d87800 0 0x16c>,
-				      <0 0x01d87a00 0 0x200>;
-				#phy-cells = <0>;
-			};
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
+			#phy-cells = <0>;
+
+			status = "disabled";
 		};
 
 		ipa_virt: interconnect@1e00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index b0ba63b5869d..8506dc841c86 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1119,7 +1119,6 @@ ufs_mem_phy: phy@1d87000 {
 			reg = <0 0x01d87000 0 0x1c4>;
 			#address-cells = <2>;
 			#size-cells = <2>;
-			#clock-cells = <1>;
 			ranges;
 			clock-names = "ref",
 				      "ref_aux";
@@ -1254,7 +1253,6 @@ usb_1_qmpphy: phy-wrapper@88e9000 {
 			      <0 0x088e8000 0 0x20>;
 			reg-names = "reg-base", "dp_com";
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
@@ -1287,7 +1285,6 @@ usb_2_qmpphy: phy-wrapper@88eb000 {
 			compatible = "qcom,sm8350-qmp-usb3-uni-phy";
 			reg = <0 0x088eb000 0 0x200>;
 			status = "disabled";
-			#clock-cells = <1>;
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 26f02cc70dc5..21755dd5b4c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -807,8 +807,8 @@ cru: clock-controller@ff440000 {
 			<0>, <24000000>,
 			<24000000>, <24000000>,
 			<15000000>, <15000000>,
-			<100000000>, <100000000>,
-			<100000000>, <100000000>,
+			<300000000>, <100000000>,
+			<400000000>, <100000000>,
 			<50000000>, <100000000>,
 			<100000000>, <100000000>,
 			<50000000>, <50000000>,
diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1c5a00598458..6e3f4eea1f34 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -26,6 +26,10 @@
 #define __tsb_csync()	asm volatile("hint #18" : : : "memory")
 #define csdb()		asm volatile("hint #20" : : : "memory")
 
+#define spec_bar()	asm volatile(ALTERNATIVE("dsb nsh\nisb\n",		\
+						 SB_BARRIER_INSN"nop\n",	\
+						 ARM64_HAS_SB))
+
 #ifdef CONFIG_ARM64_PSEUDO_NMI
 #define pmr_sync()						\
 	do {							\
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 3656bbbb7c7b..59f135b280a8 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -85,6 +85,14 @@
 #define ARM_CPU_PART_CORTEX_X2		0xD48
 #define ARM_CPU_PART_NEOVERSE_N2	0xD49
 #define ARM_CPU_PART_CORTEX_A78C	0xD4B
+#define ARM_CPU_PART_CORTEX_X1C		0xD4C
+#define ARM_CPU_PART_CORTEX_X3		0xD4E
+#define ARM_CPU_PART_NEOVERSE_V2	0xD4F
+#define ARM_CPU_PART_CORTEX_A720	0xD81
+#define ARM_CPU_PART_CORTEX_X4		0xD82
+#define ARM_CPU_PART_NEOVERSE_V3	0xD84
+#define ARM_CPU_PART_CORTEX_X925	0xD85
+#define ARM_CPU_PART_CORTEX_A725	0xD87
 
 #define APM_CPU_PART_POTENZA		0x000
 
@@ -139,6 +147,14 @@
 #define MIDR_CORTEX_X2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X2)
 #define MIDR_NEOVERSE_N2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N2)
 #define MIDR_CORTEX_A78C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78C)
+#define MIDR_CORTEX_X1C	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X1C)
+#define MIDR_CORTEX_X3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X3)
+#define MIDR_NEOVERSE_V2 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V2)
+#define MIDR_CORTEX_A720 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A720)
+#define MIDR_CORTEX_X4 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X4)
+#define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
+#define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
+#define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 4f12d8c1e55b..c358bc1c2954 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -402,6 +402,30 @@ static struct midr_range trbe_write_out_of_range_cpus[] = {
 };
 #endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
 
+#ifdef CONFIG_ARM64_ERRATUM_3194386
+static const struct midr_range erratum_spec_ssbs_list[] = {
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A78C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A720),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A725),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X1C),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X2),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X3),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X4),
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_X925),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2),
+	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
+	{}
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -648,6 +672,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
 		CAP_MIDR_RANGE_LIST(trbe_write_out_of_range_cpus),
 	},
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_3194386
+	{
+		.desc = "SSBS not fully self-synchronizing",
+		.capability = ARM64_WORKAROUND_SPECULATIVE_SSBS,
+		ERRATA_MIDR_RANGE_LIST(erratum_spec_ssbs_list),
+	},
 #endif
 	{
 	}
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index f17d6cdea260..e9d1e429456f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -422,6 +422,30 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_mvfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPROUND_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSHVEC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSQRT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPDIVIDE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPTRAP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPDP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_FPSP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_SIMD_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
+static const struct arm64_ftr_bits ftr_mvfr1[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDFMAC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPHP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDHP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDSP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDINT_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_SIMDLS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPDNAN_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR1_FPFTZ_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_mvfr2[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR2_FPMISC_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR2_SIMDMISC_SHIFT, 4, 0),
@@ -452,10 +476,10 @@ static const struct arm64_ftr_bits ftr_id_isar0[] = {
 
 static const struct arm64_ftr_bits ftr_id_isar5[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_RDM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_CRC32_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA1_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_AES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_CRC32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SHA1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_AES_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_ISAR5_SEVL_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -562,7 +586,7 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
  * 0. Covers the following 32bit registers:
- * id_isar[1-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ * id_isar[1-3], id_mmfr[1-3]
  */
 static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
@@ -629,8 +653,8 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_id_isar6),
 
 	/* Op1 = 0, CRn = 0, CRm = 3 */
-	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
-	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_mvfr0),
+	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_mvfr1),
 	ARM64_FTR_REG(SYS_MVFR2_EL1, ftr_mvfr2),
 	ARM64_FTR_REG(SYS_ID_PFR2_EL1, ftr_id_pfr2),
 	ARM64_FTR_REG(SYS_ID_DFR1_EL1, ftr_id_dfr1),
@@ -1319,20 +1343,42 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 	return val >= entry->min_field_value;
 }
 
-static bool
-has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+static u64
+read_scoped_sysreg(const struct arm64_cpu_capabilities *entry, int scope)
 {
-	u64 val;
-
 	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
 	if (scope == SCOPE_SYSTEM)
-		val = read_sanitised_ftr_reg(entry->sys_reg);
+		return read_sanitised_ftr_reg(entry->sys_reg);
 	else
-		val = __read_sysreg_by_encoding(entry->sys_reg);
+		return __read_sysreg_by_encoding(entry->sys_reg);
+}
+
+static bool
+has_user_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	int mask;
+	struct arm64_ftr_reg *regp;
+	u64 val = read_scoped_sysreg(entry, scope);
+
+	regp = get_arm64_ftr_reg(entry->sys_reg);
+	if (!regp)
+		return false;
+
+	mask = cpuid_feature_extract_unsigned_field(regp->user_mask,
+						    entry->field_pos);
+	if (!mask)
+		return false;
 
 	return feature_matches(val, entry);
 }
 
+static bool
+has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u64 val = read_scoped_sysreg(entry, scope);
+	return feature_matches(val, entry);
+}
+
 const struct cpumask *system_32bit_el0_cpumask(void)
 {
 	if (!system_supports_32bit_el0())
@@ -1917,6 +1963,17 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
 }
 #endif /* CONFIG_ARM64_MTE */
 
+static void user_feature_fixup(void)
+{
+	if (cpus_have_cap(ARM64_WORKAROUND_SPECULATIVE_SSBS)) {
+		struct arm64_ftr_reg *regp;
+
+		regp = get_arm64_ftr_reg(SYS_ID_AA64PFR1_EL1);
+		if (regp)
+			regp->user_mask &= ~GENMASK(7, 4); /* SSBS */
+	}
+}
+
 static void elf_hwcap_fixup(void)
 {
 #ifdef CONFIG_ARM64_ERRATUM_1742098
@@ -2376,7 +2433,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 };
 
 #define HWCAP_CPUID_MATCH(reg, field, s, min_value)				\
-		.matches = has_cpuid_feature,					\
+		.matches = has_user_cpuid_feature,				\
 		.sys_reg = reg,							\
 		.field_pos = field,						\
 		.sign = s,							\
@@ -2950,6 +3007,7 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 
 	setup_system_capabilities();
+	user_feature_fixup();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0()) {
@@ -3034,7 +3092,7 @@ static void __maybe_unused cpu_enable_cnp(struct arm64_cpu_capabilities const *c
 
 /*
  * We emulate only the following system register space.
- * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
+ * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 2 - 7]
  * See Table C5-6 System instruction encodings for System register accesses,
  * ARMv8 ARM(ARM DDI 0487A.f) for more details.
  */
@@ -3044,7 +3102,7 @@ static inline bool __attribute_const__ is_emulated(u32 id)
 		sys_reg_CRn(id) == 0x0 &&
 		sys_reg_Op1(id) == 0x0 &&
 		(sys_reg_CRm(id) == 0 ||
-		 ((sys_reg_CRm(id) >= 4) && (sys_reg_CRm(id) <= 7))));
+		 ((sys_reg_CRm(id) >= 2) && (sys_reg_CRm(id) <= 7))));
 }
 
 /*
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 7515ed1f0669..ebce46c4e942 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -558,6 +558,18 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 
 	/* SCTLR_EL1.DSSBS was initialised to 0 during boot */
 	set_pstate_ssbs(0);
+
+	/*
+	 * SSBS is self-synchronizing and is intended to affect subsequent
+	 * speculative instructions, but some CPUs can speculate with a stale
+	 * value of SSBS.
+	 *
+	 * Mitigate this with an unconditional speculation barrier, as CPUs
+	 * could mis-speculate branches and bypass a conditional barrier.
+	 */
+	if (IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386))
+		spec_bar();
+
 	return SPECTRE_MITIGATED;
 }
 
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index fcaeec5a5125..e7f4ae17f31b 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -70,3 +70,4 @@ WORKAROUND_NVIDIA_CARMEL_CNP
 WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
+WORKAROUND_SPECULATIVE_SSBS
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index be2dfab48fd4..ed54c55c6934 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -179,6 +179,15 @@ int __init amiga_parse_bootinfo(const struct bi_record *record)
 			dev->slotsize = be16_to_cpu(cd->cd_SlotSize);
 			dev->boardaddr = be32_to_cpu(cd->cd_BoardAddr);
 			dev->boardsize = be32_to_cpu(cd->cd_BoardSize);
+
+			/* CS-LAB Warp 1260 workaround */
+			if (be16_to_cpu(dev->rom.er_Manufacturer) == ZORRO_MANUF(ZORRO_PROD_CSLAB_WARP_1260) &&
+			    dev->rom.er_Product == ZORRO_PROD(ZORRO_PROD_CSLAB_WARP_1260)) {
+
+				/* turn off all interrupts */
+				pr_info("Warp 1260 card detected: applying interrupt storm workaround\n");
+				*(uint32_t *)(dev->boardaddr + 0x1000) = 0xfff;
+			}
 		} else
 			pr_warn("amiga_parse_bootinfo: too many AutoConfig devices\n");
 #endif /* CONFIG_ZORRO */
diff --git a/arch/m68k/atari/ataints.c b/arch/m68k/atari/ataints.c
index 56f02ea2c248..715d1e0d973e 100644
--- a/arch/m68k/atari/ataints.c
+++ b/arch/m68k/atari/ataints.c
@@ -302,11 +302,7 @@ void __init atari_init_IRQ(void)
 
 	if (ATARIHW_PRESENT(SCU)) {
 		/* init the SCU if present */
-		tt_scu.sys_mask = 0x10;		/* enable VBL (for the cursor) and
-									 * disable HSYNC interrupts (who
-									 * needs them?)  MFP and SCC are
-									 * enabled in VME mask
-									 */
+		tt_scu.sys_mask = 0x0;		/* disable all interrupts */
 		tt_scu.vme_mask = 0x60;		/* enable MFP and SCC ints */
 	} else {
 		/* If no SCU and no Hades, the HSYNC interrupt needs to be
diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index e8ca4b0ccefa..9765910d0ad2 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -33,7 +33,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 		x = tmp;
 		break;
 	default:
-		tmp = __invalid_xchg_size(x, ptr, size);
+		x = __invalid_xchg_size(x, ptr, size);
 		break;
 	}
 
diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index d73d8f4fd78e..f3fad477ddce 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -23,14 +23,6 @@ cpu0: cpu@0 {
 		};
 	};
 
-	memory@200000 {
-		compatible = "memory";
-		device_type = "memory";
-		reg = <0x00000000 0x00200000 0x00000000 0x0ee00000>, /* 238 MB at 2 MB */
-			<0x00000000 0x20000000 0x00000000 0x1f000000>, /* 496 MB at 512 MB */
-			<0x00000001 0x10000000 0x00000001 0xb0000000>; /* 6912 MB at 4352MB */
-	};
-
 	cpu_clk: cpu_clk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
@@ -92,12 +84,19 @@ liointc1: interrupt-controller@1fe11440 {
 						<0x00000000>; /* int3 */
 		};
 
+		rtc0: rtc@1fe07800 {
+			compatible = "loongson,ls2k1000-rtc";
+			reg = <0 0x1fe07800 0 0x78>;
+			interrupt-parent = <&liointc1>;
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		uart0: serial@1fe00000 {
 			compatible = "ns16550a";
 			reg = <0 0x1fe00000 0 0x8>;
 			clock-frequency = <125000000>;
 			interrupt-parent = <&liointc0>;
-			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 			no-loopback-test;
 		};
 
@@ -106,7 +105,6 @@ pci@1a000000 {
 			device_type = "pci";
 			#address-cells = <3>;
 			#size-cells = <2>;
-			#interrupt-cells = <2>;
 
 			reg = <0 0x1a000000 0 0x02000000>,
 				<0xfe 0x00000000 0 0x20000000>;
@@ -121,11 +119,12 @@ gmac@3,0 {
 						   "pciclass0c03";
 
 				reg = <0x1800 0x0 0x0 0x0 0x0>;
-				interrupts = <12 IRQ_TYPE_LEVEL_LOW>,
-					     <13 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <12 IRQ_TYPE_LEVEL_HIGH>,
+					     <13 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&liointc0>;
-				phy-mode = "rgmii";
+				phy-mode = "rgmii-id";
+				phy-handle = <&phy1>;
 				mdio {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -144,11 +143,12 @@ gmac@3,1 {
 						   "loongson, pci-gmac";
 
 				reg = <0x1900 0x0 0x0 0x0 0x0>;
-				interrupts = <14 IRQ_TYPE_LEVEL_LOW>,
-					     <15 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <14 IRQ_TYPE_LEVEL_HIGH>,
+					     <15 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "macirq", "eth_lpi";
 				interrupt-parent = <&liointc0>;
-				phy-mode = "rgmii";
+				phy-mode = "rgmii-id";
+				phy-handle = <&phy1>;
 				mdio {
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -166,7 +166,7 @@ ehci@4,1 {
 						   "pciclass0c03";
 
 				reg = <0x2100 0x0 0x0 0x0 0x0>;
-				interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 			};
 
@@ -177,7 +177,7 @@ ohci@4,2 {
 						   "pciclass0c03";
 
 				reg = <0x2200 0x0 0x0 0x0 0x0>;
-				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 			};
 
@@ -188,97 +188,121 @@ sata@8,0 {
 						   "pciclass0106";
 
 				reg = <0x4000 0x0 0x0 0x0 0x0>;
-				interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <19 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc0>;
 			};
 
-			pci_bridge@9,0 {
+			pcie@9,0 {
 				compatible = "pci0014,7a19.0",
 						   "pci0014,7a19",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x4800 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 0 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 0 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@a,0 {
+			pcie@a,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x5000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 1 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 1 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@b,0 {
+			pcie@b,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x5800 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 2 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 2 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@c,0 {
+			pcie@c,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x6000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 3 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 3 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@d,0 {
+			pcie@d,0 {
 				compatible = "pci0014,7a19.0",
 						   "pci0014,7a19",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x6800 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <4 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <4 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 4 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 4 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
-			pci_bridge@e,0 {
+			pcie@e,0 {
 				compatible = "pci0014,7a09.0",
 						   "pci0014,7a09",
 						   "pciclass060400",
 						   "pciclass0604";
 
 				reg = <0x7000 0x0 0x0 0x0 0x0>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				device_type = "pci";
 				#interrupt-cells = <1>;
-				interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+				interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&liointc1>;
 				interrupt-map-mask = <0 0 0 0>;
-				interrupt-map = <0 0 0 0 &liointc1 5 IRQ_TYPE_LEVEL_LOW>;
+				interrupt-map = <0 0 0 0 &liointc1 5 IRQ_TYPE_LEVEL_HIGH>;
+				ranges;
 				external-facing;
 			};
 
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index e007edd6b60a..9218b3ae3383 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -42,12 +42,14 @@ enum loongson_cpu_type {
 	Legacy_1B = 0x5,
 	Legacy_2G = 0x6,
 	Legacy_2H = 0x7,
+	Legacy_2K = 0x8,
 	Loongson_1A = 0x100,
 	Loongson_1B = 0x101,
 	Loongson_2E = 0x200,
 	Loongson_2F = 0x201,
 	Loongson_2G = 0x202,
 	Loongson_2H = 0x203,
+	Loongson_2K = 0x204,
 	Loongson_3A = 0x300,
 	Loongson_3B = 0x301
 };
diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b1..696b40beb774 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -228,6 +228,10 @@ GCR_ACCESSOR_RO(32, 0x0d0, gic_status)
 GCR_ACCESSOR_RO(32, 0x0f0, cpc_status)
 #define CM_GCR_CPC_STATUS_EX			BIT(0)
 
+/* GCR_ACCESS - Controls core/IOCU access to GCRs */
+GCR_ACCESSOR_RW(32, 0x120, access_cm3)
+#define CM_GCR_ACCESS_ACCESSEN			GENMASK(7, 0)
+
 /* GCR_L2_CONFIG - Indicates L2 cache configuration when Config5.L2C=1 */
 GCR_ACCESSOR_RW(32, 0x130, l2_config)
 #define CM_GCR_L2_CONFIG_BYPASS			BIT(20)
diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index f2df0cae1b4d..7409d46ce31a 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -230,7 +230,10 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
 	write_gcr_co_reset_ext_base(CM_GCR_Cx_RESET_EXT_BASE_UEB);
 
 	/* Ensure the core can access the GCRs */
-	set_gcr_access(1 << core);
+	if (mips_cm_revision() < CM_REV_CM3)
+		set_gcr_access(1 << core);
+	else
+		set_gcr_access_cm3(1 << core);
 
 	if (mips_cpc_present()) {
 		/* Reset the core */
diff --git a/arch/mips/loongson64/env.c b/arch/mips/loongson64/env.c
index ef3750a6ffac..09ff05269861 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -88,6 +88,12 @@ void __init prom_lefi_init_env(void)
 	cpu_clock_freq = ecpu->cpu_clock_freq;
 	loongson_sysconf.cputype = ecpu->cputype;
 	switch (ecpu->cputype) {
+	case Legacy_2K:
+	case Loongson_2K:
+		smp_group[0] = 0x900000001fe11000;
+		loongson_sysconf.cores_per_node = 2;
+		loongson_sysconf.cores_per_package = 2;
+		break;
 	case Legacy_3A:
 	case Loongson_3A:
 		loongson_sysconf.cores_per_node = 4;
@@ -221,6 +227,8 @@ void __init prom_lefi_init_env(void)
 		default:
 			break;
 		}
+	} else if ((read_c0_prid() & PRID_IMP_MASK) == PRID_IMP_LOONGSON_64R) {
+		loongson_fdt_blob = __dtb_loongson64_2core_2k1000_begin;
 	} else if ((read_c0_prid() & PRID_IMP_MASK) == PRID_IMP_LOONGSON_64G) {
 		if (loongson_sysconf.bridgetype == LS7A)
 			loongson_fdt_blob = __dtb_loongson64g_4core_ls7a_begin;
diff --git a/arch/mips/loongson64/reset.c b/arch/mips/loongson64/reset.c
index e420800043b0..2a8e4cd72605 100644
--- a/arch/mips/loongson64/reset.c
+++ b/arch/mips/loongson64/reset.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kexec.h>
 #include <linux/pm.h>
+#include <linux/reboot.h>
 #include <linux/slab.h>
 
 #include <asm/bootinfo.h>
@@ -21,36 +22,21 @@
 #include <loongson.h>
 #include <boot_param.h>
 
-static void loongson_restart(char *command)
+static int firmware_restart(struct sys_off_data *unusedd)
 {
 
 	void (*fw_restart)(void) = (void *)loongson_sysconf.restart_addr;
 
 	fw_restart();
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
+	return NOTIFY_DONE;
 }
 
-static void loongson_poweroff(void)
+static int firmware_poweroff(struct sys_off_data *unused)
 {
 	void (*fw_poweroff)(void) = (void *)loongson_sysconf.poweroff_addr;
 
 	fw_poweroff();
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
-}
-
-static void loongson_halt(void)
-{
-	pr_notice("\n\n** You can safely turn off the power now **\n\n");
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
+	return NOTIFY_DONE;
 }
 
 #ifdef CONFIG_KEXEC
@@ -154,9 +140,17 @@ static void loongson_crash_shutdown(struct pt_regs *regs)
 
 static int __init mips_reboot_setup(void)
 {
-	_machine_restart = loongson_restart;
-	_machine_halt = loongson_halt;
-	pm_power_off = loongson_poweroff;
+	if (loongson_sysconf.restart_addr) {
+		register_sys_off_handler(SYS_OFF_MODE_RESTART,
+				 SYS_OFF_PRIO_FIRMWARE,
+				 firmware_restart, NULL);
+	}
+
+	if (loongson_sysconf.poweroff_addr) {
+		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF,
+				 SYS_OFF_PRIO_FIRMWARE,
+				 firmware_poweroff, NULL);
+	}
 
 #ifdef CONFIG_KEXEC
 	kexec_argv = kmalloc(KEXEC_ARGV_SIZE, GFP_KERNEL);
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index 09ebe84a17fe..ae33661cd187 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -479,12 +479,25 @@ static void loongson3_smp_finish(void)
 static void __init loongson3_smp_setup(void)
 {
 	int i = 0, num = 0; /* i: physical id, num: logical id */
+	int max_cpus = 0;
 
 	init_cpu_possible(cpu_none_mask);
 
+	for (i = 0; i < ARRAY_SIZE(smp_group); i++) {
+		if (!smp_group[i])
+			break;
+		max_cpus += loongson_sysconf.cores_per_node;
+	}
+
+	if (max_cpus < loongson_sysconf.nr_cpus) {
+		pr_err("SMP Groups are less than the number of CPUs\n");
+		loongson_sysconf.nr_cpus = max_cpus ? max_cpus : 1;
+	}
+
 	/* For unified kernel, NR_CPUS is the maximum possible value,
 	 * loongson_sysconf.nr_cpus is the really present value
 	 */
+	i = 0;
 	while (i < loongson_sysconf.nr_cpus) {
 		if (loongson_sysconf.reserved_cpus_mask & (1<<i)) {
 			/* Reserved physical CPU cores */
@@ -505,14 +518,14 @@ static void __init loongson3_smp_setup(void)
 		__cpu_logical_map[num] = -1;
 		num++;
 	}
-
 	csr_ipi_probe();
 	ipi_set0_regs_init();
 	ipi_clear0_regs_init();
 	ipi_status0_regs_init();
 	ipi_en0_regs_init();
 	ipi_mailbox_buf_init();
-	ipi_write_enable(0);
+	if (smp_group[0])
+		ipi_write_enable(0);
 
 	cpu_set_core(&cpu_data[0],
 		     cpu_logical_map(0) % loongson_sysconf.cores_per_package);
@@ -830,6 +843,9 @@ static int loongson3_disable_clock(unsigned int cpu)
 	uint64_t core_id = cpu_core(&cpu_data[cpu]);
 	uint64_t package_id = cpu_data[cpu].package;
 
+	if (!loongson_chipcfg[package_id] || !loongson_freqctrl[package_id])
+		return 0;
+
 	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
 		LOONGSON_CHIPCFG(package_id) &= ~(1 << (12 + core_id));
 	} else {
@@ -844,6 +860,9 @@ static int loongson3_enable_clock(unsigned int cpu)
 	uint64_t core_id = cpu_core(&cpu_data[cpu]);
 	uint64_t package_id = cpu_data[cpu].package;
 
+	if (!loongson_chipcfg[package_id] || !loongson_freqctrl[package_id])
+		return 0;
+
 	if ((read_c0_prid() & PRID_REV_MASK) == PRID_REV_LOONGSON3A_R1) {
 		LOONGSON_CHIPCFG(package_id) |= 1 << (12 + core_id);
 	} else {
diff --git a/arch/mips/pci/pcie-octeon.c b/arch/mips/pci/pcie-octeon.c
old mode 100755
new mode 100644
diff --git a/arch/mips/sgi-ip30/ip30-console.c b/arch/mips/sgi-ip30/ip30-console.c
index b91f8c4fdc78..a087b7ebe129 100644
--- a/arch/mips/sgi-ip30/ip30-console.c
+++ b/arch/mips/sgi-ip30/ip30-console.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/io.h>
+#include <linux/processor.h>
 
 #include <asm/sn/ioc3.h>
 
diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index 524db76f47b7..8aff83217397 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -24,6 +24,7 @@ CONFIG_FS_ENET=y
 CONFIG_FSL_CORENET_CF=y
 CONFIG_FSL_DMA=y
 CONFIG_FSL_HV_MANAGER=y
+CONFIG_FSL_IFC=y
 CONFIG_FSL_PQ_MDIO=y
 CONFIG_FSL_RIO=y
 CONFIG_FSL_XGMAC_MDIO=y
@@ -58,6 +59,7 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_MARVELL_PHY=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
+CONFIG_MEMORY=y
 CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI=y
diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index e592e65e7665..49285b147afe 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -285,18 +285,24 @@ static inline void interrupt_nmi_enter_prepare(struct pt_regs *regs, struct inte
 	/*
 	 * Do not use nmi_enter() for pseries hash guest taking a real-mode
 	 * NMI because not everything it touches is within the RMA limit.
+	 *
+	 * Likewise, do not use it in real mode if percpu first chunk is not
+	 * embedded. With CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there
+	 * are chances where percpu allocation can come from vmalloc area.
 	 */
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
+	if ((!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
 			!firmware_has_feature(FW_FEATURE_LPAR) ||
-			radix_enabled() || (mfmsr() & MSR_DR))
+			radix_enabled() || (mfmsr() & MSR_DR)) &&
+			!percpu_first_chunk_is_paged)
 		nmi_enter();
 }
 
 static inline void interrupt_nmi_exit_prepare(struct pt_regs *regs, struct interrupt_nmi_state *state)
 {
-	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
+	if ((!IS_ENABLED(CONFIG_PPC_BOOK3S_64) ||
 			!firmware_has_feature(FW_FEATURE_LPAR) ||
-			radix_enabled() || (mfmsr() & MSR_DR))
+			radix_enabled() || (mfmsr() & MSR_DR)) &&
+			!percpu_first_chunk_is_paged)
 		nmi_exit();
 
 	/*
diff --git a/arch/powerpc/include/asm/percpu.h b/arch/powerpc/include/asm/percpu.h
index 8e5b7d0b851c..634970ce13c6 100644
--- a/arch/powerpc/include/asm/percpu.h
+++ b/arch/powerpc/include/asm/percpu.h
@@ -15,6 +15,16 @@
 #endif /* CONFIG_SMP */
 #endif /* __powerpc64__ */
 
+#if defined(CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK) && defined(CONFIG_SMP)
+#include <linux/jump_label.h>
+DECLARE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
+
+#define percpu_first_chunk_is_paged	\
+		(static_key_enabled(&__percpu_first_chunk_is_paged.key))
+#else
+#define percpu_first_chunk_is_paged	false
+#endif /* CONFIG_PPC64 && CONFIG_SMP */
+
 #include <asm-generic/percpu.h>
 
 #include <asm/paca.h>
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index eaa79a0996d1..37d5683ab298 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -825,6 +825,7 @@ static int pcpu_cpu_distance(unsigned int from, unsigned int to)
 
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
+DEFINE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
 
 static void __init pcpu_populate_pte(unsigned long addr)
 {
@@ -904,6 +905,7 @@ void __init setup_per_cpu_areas(void)
 	if (rc < 0)
 		panic("cannot initialize percpu area (err=%d)", rc);
 
+	static_key_enable(&__percpu_first_chunk_is_paged.key);
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ee305455bd8d..fc7174b32e98 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1963,8 +1963,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			break;
 
 		r = -ENXIO;
-		if (!xive_enabled())
+		if (!xive_enabled()) {
+			fdput(f);
 			break;
+		}
 
 		r = -EPERM;
 		dev = kvm_device_from_filp(f.file);
diff --git a/arch/powerpc/xmon/ppc-dis.c b/arch/powerpc/xmon/ppc-dis.c
index 75fa98221d48..af105e1bc3fc 100644
--- a/arch/powerpc/xmon/ppc-dis.c
+++ b/arch/powerpc/xmon/ppc-dis.c
@@ -122,32 +122,21 @@ int print_insn_powerpc (unsigned long insn, unsigned long memaddr)
   bool insn_is_short;
   ppc_cpu_t dialect;
 
-  dialect = PPC_OPCODE_PPC | PPC_OPCODE_COMMON
-            | PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_ALTIVEC;
+  dialect = PPC_OPCODE_PPC | PPC_OPCODE_COMMON;
 
-  if (cpu_has_feature(CPU_FTRS_POWER5))
-    dialect |= PPC_OPCODE_POWER5;
+  if (IS_ENABLED(CONFIG_PPC64))
+    dialect |= PPC_OPCODE_64 | PPC_OPCODE_POWER4 | PPC_OPCODE_CELL |
+	PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7 | PPC_OPCODE_POWER8 |
+	PPC_OPCODE_POWER9;
 
-  if (cpu_has_feature(CPU_FTRS_CELL))
-    dialect |= (PPC_OPCODE_CELL | PPC_OPCODE_ALTIVEC);
+  if (cpu_has_feature(CPU_FTR_TM))
+    dialect |= PPC_OPCODE_HTM;
 
-  if (cpu_has_feature(CPU_FTRS_POWER6))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_ALTIVEC);
+  if (cpu_has_feature(CPU_FTR_ALTIVEC))
+    dialect |= PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2;
 
-  if (cpu_has_feature(CPU_FTRS_POWER7))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-                | PPC_OPCODE_ALTIVEC | PPC_OPCODE_VSX);
-
-  if (cpu_has_feature(CPU_FTRS_POWER8))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-		| PPC_OPCODE_POWER8 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2 | PPC_OPCODE_VSX);
-
-  if (cpu_has_feature(CPU_FTRS_POWER9))
-    dialect |= (PPC_OPCODE_POWER5 | PPC_OPCODE_POWER6 | PPC_OPCODE_POWER7
-		| PPC_OPCODE_POWER8 | PPC_OPCODE_POWER9 | PPC_OPCODE_HTM
-		| PPC_OPCODE_ALTIVEC | PPC_OPCODE_ALTIVEC2
-		| PPC_OPCODE_VSX | PPC_OPCODE_VSX3);
+  if (cpu_has_feature(CPU_FTR_VSX))
+    dialect |= PPC_OPCODE_VSX | PPC_OPCODE_VSX3;
 
   /* Get the major opcode of the insn.  */
   opcode = NULL;
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 884a3c76573c..3fc62e05bac1 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -60,26 +60,27 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 
 static inline void mm_fault_error(struct pt_regs *regs, unsigned long addr, vm_fault_t fault)
 {
+	if (!user_mode(regs)) {
+		no_context(regs, addr);
+		return;
+	}
+
 	if (fault & VM_FAULT_OOM) {
 		/*
 		 * We ran out of memory, call the OOM killer, and return the userspace
 		 * (which will retry the fault, or kill us if we got oom-killed).
 		 */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		pagefault_out_of_memory();
 		return;
 	} else if (fault & VM_FAULT_SIGBUS) {
 		/* Kernel mode? Handle exceptions or die */
-		if (!user_mode(regs)) {
-			no_context(regs, addr);
-			return;
-		}
 		do_trap(regs, SIGBUS, BUS_ADRERR, addr);
 		return;
+	} else if (fault & VM_FAULT_SIGSEGV) {
+		do_trap(regs, SIGSEGV, SEGV_MAPERR, addr);
+		return;
 	}
+
 	BUG();
 }
 
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index a67abebd4359..1b86d02a8455 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -247,6 +247,7 @@ void prom_sun4v_guest_soft_state(void);
 int prom_ihandle2path(int handle, char *buffer, int bufsize);
 
 /* Client interface level routines. */
+void prom_cif_init(void *cif_handler);
 void p1275_cmd_direct(unsigned long *);
 
 #endif /* !(__SPARC64_OPLIB_H) */
diff --git a/arch/sparc/prom/init_64.c b/arch/sparc/prom/init_64.c
index 103aa9104318..f7b8a1a865b8 100644
--- a/arch/sparc/prom/init_64.c
+++ b/arch/sparc/prom/init_64.c
@@ -26,9 +26,6 @@ phandle prom_chosen_node;
  * routines in the prom library.
  * It gets passed the pointer to the PROM vector.
  */
-
-extern void prom_cif_init(void *);
-
 void __init prom_init(void *cif_handler)
 {
 	phandle node;
diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 889aa602f8d8..51c3f984bbf7 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -49,7 +49,7 @@ void p1275_cmd_direct(unsigned long *args)
 	local_irq_restore(flags);
 }
 
-void prom_cif_init(void *cif_handler, void *cif_stack)
+void prom_cif_init(void *cif_handler)
 {
 	p1275buf.prom_cif_handler = (void (*)(long *))cif_handler;
 }
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 3e270da6b6f6..c8c4ef94c753 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -874,9 +874,9 @@ int setup_time_travel_start(char *str)
 	return 1;
 }
 
-__setup("time-travel-start", setup_time_travel_start);
+__setup("time-travel-start=", setup_time_travel_start);
 __uml_help(setup_time_travel_start,
-"time-travel-start=<seconds>\n"
+"time-travel-start=<nanoseconds>\n"
 "Configure the UML instance's wall clock to start at this value rather than\n"
 "the host's wall clock at the time of UML boot.\n");
 #endif
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 24a403a70a02..850d21e6473e 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -8,6 +8,7 @@
 
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <signal.h>
 #include <string.h>
@@ -65,9 +66,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 
 int signals_enabled;
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
-static int signals_blocked;
-#else
-#define signals_blocked 0
+static int signals_blocked, signals_blocked_pending;
 #endif
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
@@ -76,14 +75,27 @@ void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	int enabled = signals_enabled;
 
-	if ((signals_blocked || !enabled) && (sig == SIGIO)) {
+#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+	if ((signals_blocked ||
+	     __atomic_load_n(&signals_blocked_pending, __ATOMIC_SEQ_CST)) &&
+	    (sig == SIGIO)) {
+		/* increment so unblock will do another round */
+		__atomic_add_fetch(&signals_blocked_pending, 1,
+				   __ATOMIC_SEQ_CST);
+		return;
+	}
+#endif
+
+	if (!enabled && (sig == SIGIO)) {
 		/*
 		 * In TT_MODE_EXTERNAL, need to still call time-travel
-		 * handlers unless signals are also blocked for the
-		 * external time message processing. This will mark
-		 * signals_pending by itself (only if necessary.)
+		 * handlers. This will mark signals_pending by itself
+		 * (only if necessary.)
+		 * Note we won't get here if signals are hard-blocked
+		 * (which is handled above), in that case the hard-
+		 * unblock will handle things.
 		 */
-		if (!signals_blocked && time_travel_mode == TT_MODE_EXTERNAL)
+		if (time_travel_mode == TT_MODE_EXTERNAL)
 			sigio_run_timetravel_handlers();
 		else
 			signals_pending |= SIGIO_MASK;
@@ -380,33 +392,99 @@ int um_set_signals_trace(int enable)
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
 void mark_sigio_pending(void)
 {
+	/*
+	 * It would seem that this should be atomic so
+	 * it isn't a read-modify-write with a signal
+	 * that could happen in the middle, losing the
+	 * value set by the signal.
+	 *
+	 * However, this function is only called when in
+	 * time-travel=ext simulation mode, in which case
+	 * the only signal ever pending is SIGIO, which
+	 * is blocked while this can be called, and the
+	 * timer signal (SIGALRM) cannot happen.
+	 */
 	signals_pending |= SIGIO_MASK;
 }
 
 void block_signals_hard(void)
 {
-	if (signals_blocked)
-		return;
-	signals_blocked = 1;
+	signals_blocked++;
 	barrier();
 }
 
 void unblock_signals_hard(void)
 {
+	static bool unblocking;
+
 	if (!signals_blocked)
+		panic("unblocking signals while not blocked");
+
+	if (--signals_blocked)
 		return;
-	/* Must be set to 0 before we check the pending bits etc. */
-	signals_blocked = 0;
+	/*
+	 * Must be set to 0 before we check pending so the
+	 * SIGIO handler will run as normal unless we're still
+	 * going to process signals_blocked_pending.
+	 */
 	barrier();
 
-	if (signals_pending && signals_enabled) {
-		/* this is a bit inefficient, but that's not really important */
-		block_signals();
-		unblock_signals();
-	} else if (signals_pending & SIGIO_MASK) {
-		/* we need to run time-travel handlers even if not enabled */
-		sigio_run_timetravel_handlers();
+	/*
+	 * Note that block_signals_hard()/unblock_signals_hard() can be called
+	 * within the unblock_signals()/sigio_run_timetravel_handlers() below.
+	 * This would still be prone to race conditions since it's actually a
+	 * call _within_ e.g. vu_req_read_message(), where we observed this
+	 * issue, which loops. Thus, if the inner call handles the recorded
+	 * pending signals, we can get out of the inner call with the real
+	 * signal hander no longer blocked, and still have a race. Thus don't
+	 * handle unblocking in the inner call, if it happens, but only in
+	 * the outermost call - 'unblocking' serves as an ownership for the
+	 * signals_blocked_pending decrement.
+	 */
+	if (unblocking)
+		return;
+	unblocking = true;
+
+	while (__atomic_load_n(&signals_blocked_pending, __ATOMIC_SEQ_CST)) {
+		if (signals_enabled) {
+			/* signals are enabled so we can touch this */
+			signals_pending |= SIGIO_MASK;
+			/*
+			 * this is a bit inefficient, but that's
+			 * not really important
+			 */
+			block_signals();
+			unblock_signals();
+		} else {
+			/*
+			 * we need to run time-travel handlers even
+			 * if not enabled
+			 */
+			sigio_run_timetravel_handlers();
+		}
+
+		/*
+		 * The decrement of signals_blocked_pending must be atomic so
+		 * that the signal handler will either happen before or after
+		 * the decrement, not during a read-modify-write:
+		 *  - If it happens before, it can increment it and we'll
+		 *    decrement it and do another round in the loop.
+		 *  - If it happens after it'll see 0 for both signals_blocked
+		 *    and signals_blocked_pending and thus run the handler as
+		 *    usual (subject to signals_enabled, but that's unrelated.)
+		 *
+		 * Note that a call to unblock_signals_hard() within the calls
+		 * to unblock_signals() or sigio_run_timetravel_handlers() above
+		 * will do nothing due to the 'unblocking' state, so this cannot
+		 * underflow as the only one decrementing will be the outermost
+		 * one.
+		 */
+		if (__atomic_sub_fetch(&signals_blocked_pending, 1,
+				       __ATOMIC_SEQ_CST) < 0)
+			panic("signals_blocked_pending underflow");
 	}
+
+	unblocking = false;
 }
 #endif
 
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index a85d3138839c..adaaed466e5c 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -861,7 +861,7 @@ static void pt_update_head(struct pt *pt)
  */
 static void *pt_buffer_region(struct pt_buffer *buf)
 {
-	return phys_to_virt(TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
+	return phys_to_virt((phys_addr_t)TOPA_ENTRY(buf->cur, buf->cur_idx)->base << TOPA_SHIFT);
 }
 
 /**
@@ -973,7 +973,7 @@ pt_topa_entry_for_page(struct pt_buffer *buf, unsigned int pg)
 	 * order allocations, there shouldn't be many of these.
 	 */
 	list_for_each_entry(topa, &buf->tables, list) {
-		if (topa->offset + topa->size > pg << PAGE_SHIFT)
+		if (topa->offset + topa->size > (unsigned long)pg << PAGE_SHIFT)
 			goto found;
 	}
 
diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 96906a62aacd..f5e46c04c145 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -33,8 +33,8 @@ struct topa_entry {
 	u64	rsvd2	: 1;
 	u64	size	: 4;
 	u64	rsvd3	: 2;
-	u64	base	: 36;
-	u64	rsvd4	: 16;
+	u64	base	: 40;
+	u64	rsvd4	: 12;
 };
 
 /* TSC to Core Crystal Clock Ratio */
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 9b5859812f4f..d081eb89ba12 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -459,6 +459,7 @@
 #define SPR_RAW_EVENT_MASK_EXT			0xffffff
 
 /* SPR CHA */
+#define SPR_CHA_EVENT_MASK_EXT			0xffffffff
 #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
 #define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
 						 SPR_CHA_PMON_CTL_TID_EN)
@@ -475,6 +476,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, umask, "config:8-15,32-43,45-55");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -5648,7 +5650,7 @@ static struct intel_uncore_ops spr_uncore_chabox_ops = {
 
 static struct attribute *spr_uncore_cha_formats_attr[] = {
 	&format_attr_event.attr,
-	&format_attr_umask_ext4.attr,
+	&format_attr_umask_ext5.attr,
 	&format_attr_tid_en2.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
@@ -5684,7 +5686,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
 static struct intel_uncore_type spr_uncore_chabox = {
 	.name			= "cha",
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
-	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.event_mask_ext		= SPR_CHA_EVENT_MASK_EXT,
 	.num_shared_regs	= 1,
 	.constraints		= skx_uncore_chabox_constraints,
 	.ops			= &spr_uncore_chabox_ops,
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 2746cac9d8a9..dbebb646c9fc 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -816,7 +816,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 6a4cb71c2498..bd4386bf51ac 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -92,7 +92,7 @@ static int x86_of_pci_irq_enable(struct pci_dev *dev)
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_PIN, &pin);
 	if (ret)
-		return ret;
+		return pcibios_err_to_errno(ret);
 	if (!pin)
 		return 0;
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bedbd077e50e..283f3205d7d7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4706,14 +4706,19 @@ static int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 	return !vmx_nmi_blocked(vcpu);
 }
 
+bool __vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
+{
+	return !(vmx_get_rflags(vcpu) & X86_EFLAGS_IF) ||
+	       (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
+		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
+}
+
 bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu)
 {
 	if (is_guest_mode(vcpu) && nested_exit_on_intr(vcpu))
 		return false;
 
-	return !(vmx_get_rflags(vcpu) & X86_EFLAGS_IF) ||
-	       (vmcs_read32(GUEST_INTERRUPTIBILITY_INFO) &
-		(GUEST_INTR_STATE_STI | GUEST_INTR_STATE_MOV_SS));
+	return __vmx_interrupt_blocked(vcpu);
 }
 
 static int vmx_interrupt_allowed(struct kvm_vcpu *vcpu, bool for_injection)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 20f1213a9368..a1792d96618a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -388,6 +388,7 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, hpa_t root_hpa, int root_level);
 bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
 bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
+bool __vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
 bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
 void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 5d5c7bb50ce9..189b242d3e89 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -374,14 +374,14 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			 */
 			*target_pmd = *pmd;
 
-			addr += PMD_SIZE;
+			addr = round_up(addr + 1, PMD_SIZE);
 
 		} else if (level == PTI_CLONE_PTE) {
 
 			/* Walk the page-table down to the pte level */
 			pte = pte_offset_kernel(pmd, addr);
 			if (pte_none(*pte)) {
-				addr += PAGE_SIZE;
+				addr = round_up(addr + 1, PAGE_SIZE);
 				continue;
 			}
 
@@ -401,7 +401,7 @@ pti_clone_pgtable(unsigned long start, unsigned long end,
 			/* Clone the PTE */
 			*target_pte = *pte;
 
-			addr += PAGE_SIZE;
+			addr = round_up(addr + 1, PAGE_SIZE);
 
 		} else {
 			BUG();
@@ -496,7 +496,7 @@ static void pti_clone_entry_text(void)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+			  PTI_LEVEL_KERNEL_IMAGE);
 }
 
 /*
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 8edd62206604..722a33be08a1 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -233,9 +233,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (ret < 0) {
+	if (ret) {
 		dev_warn(&dev->dev, "Failed to read interrupt line: %d\n", ret);
-		return ret;
+		return pcibios_err_to_errno(ret);
 	}
 
 	id = x86_match_cpu(intel_mid_cpu_ids);
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index f153e9ab8c96..8e4165b5b295 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -37,10 +37,10 @@ static int xen_pcifront_enable_irq(struct pci_dev *dev)
 	u8 gsi;
 
 	rc = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (rc < 0) {
+	if (rc) {
 		dev_warn(&dev->dev, "Xen PCI: failed to read interrupt line: %d\n",
 			 rc);
-		return rc;
+		return pcibios_err_to_errno(rc);
 	}
 	/* In PV DomU the Xen PCI backend puts the PIRQ in the interrupt line.*/
 	pirq = gsi;
diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index fdd49d70b437..c81cea208c2c 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -62,7 +62,7 @@ static int iosf_mbi_pci_read_mdr(u32 mcrx, u32 mcr, u32 *mdr)
 
 fail_read:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
 
 static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 mdr)
@@ -91,7 +91,7 @@ static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 mdr)
 
 fail_write:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
 
 int iosf_mbi_read(u8 port, u8 opcode, u32 offset, u32 *mdr)
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 5e6e236977c7..9b3a9fa4a0ad 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -736,7 +736,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 		 * immediate unmapping.
 		 */
 		map_ops[i].status = GNTST_general_error;
-		unmap[0].host_addr = map_ops[i].host_addr,
+		unmap[0].host_addr = map_ops[i].host_addr;
 		unmap[0].handle = map_ops[i].handle;
 		map_ops[i].handle = INVALID_GRANT_HANDLE;
 		if (map_ops[i].flags & GNTMAP_device_map)
@@ -746,7 +746,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 
 		if (kmap_ops) {
 			kmap_ops[i].status = GNTST_general_error;
-			unmap[1].host_addr = kmap_ops[i].host_addr,
+			unmap[1].host_addr = kmap_ops[i].host_addr;
 			unmap[1].handle = kmap_ops[i].handle;
 			kmap_ops[i].handle = INVALID_GRANT_HANDLE;
 			if (kmap_ops[i].flags & GNTMAP_device_map)
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4f34ac27c47d..bb364a25ac86 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -203,8 +203,7 @@ bool bio_integrity_prep(struct bio *bio)
 	unsigned long start, end;
 	unsigned int len, nr_pages;
 	unsigned int bytes, offset, i;
-	unsigned int intervals;
-	blk_status_t status;
+	gfp_t gfp = GFP_NOIO;
 
 	if (!bi)
 		return true;
@@ -227,13 +226,19 @@ bool bio_integrity_prep(struct bio *bio)
 		if (!bi->profile->generate_fn ||
 		    !(bi->flags & BLK_INTEGRITY_GENERATE))
 			return true;
+
+		/*
+		 * Zero the memory allocated to not leak uninitialized kernel
+		 * memory to disk.  For PI this only affects the app tag, but
+		 * for non-integrity metadata it affects the entire metadata
+		 * buffer.
+		 */
+		gfp |= __GFP_ZERO;
 	}
-	intervals = bio_integrity_intervals(bi, bio_sectors(bio));
 
 	/* Allocate kernel buffer for protection data */
-	len = intervals * bi->tuple_size;
-	buf = kmalloc(len, GFP_NOIO);
-	status = BLK_STS_RESOURCE;
+	len = bio_integrity_bytes(bi, bio_sectors(bio));
+	buf = kmalloc(len, gfp);
 	if (unlikely(buf == NULL)) {
 		printk(KERN_ERR "could not allocate integrity buffer\n");
 		goto err_end_io;
@@ -248,7 +253,6 @@ bool bio_integrity_prep(struct bio *bio)
 	if (IS_ERR(bip)) {
 		printk(KERN_ERR "could not allocate data integrity bioset\n");
 		kfree(buf);
-		status = BLK_STS_RESOURCE;
 		goto err_end_io;
 	}
 
@@ -276,7 +280,6 @@ bool bio_integrity_prep(struct bio *bio)
 
 		if (ret == 0) {
 			printk(KERN_ERR "could not attach integrity payload\n");
-			status = BLK_STS_RESOURCE;
 			goto err_end_io;
 		}
 
@@ -298,7 +301,7 @@ bool bio_integrity_prep(struct bio *bio)
 	return true;
 
 err_end_io:
-	bio->bi_status = status;
+	bio->bi_status = BLK_STS_RESOURCE;
 	bio_endio(bio);
 	return false;
 
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c7569151fd02..aed4132985a9 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -676,12 +676,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	return count;
 }
 
-static const struct device_attribute alarm_attr = {
+static struct device_attribute alarm_attr = {
 	.attr = {.name = "alarm", .mode = 0644},
 	.show = acpi_battery_alarm_show,
 	.store = acpi_battery_alarm_store,
 };
 
+static struct attribute *acpi_battery_attrs[] = {
+	&alarm_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(acpi_battery);
+
 /*
  * The Battery Hooking API
  *
@@ -818,7 +824,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -863,7 +872,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -874,7 +883,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index 4938010fcac7..11083d0333d1 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -77,7 +77,6 @@ struct acpi_battery {
 	u16 spec;
 	u8 id;
 	u8 present:1;
-	u8 have_sysfs_alarm:1;
 };
 
 #define to_acpi_battery(x) power_supply_get_drvdata(x)
@@ -462,12 +461,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
 	return count;
 }
 
-static const struct device_attribute alarm_attr = {
+static struct device_attribute alarm_attr = {
 	.attr = {.name = "alarm", .mode = 0644},
 	.show = acpi_battery_alarm_show,
 	.store = acpi_battery_alarm_store,
 };
 
+static struct attribute *acpi_battery_attrs[] = {
+	&alarm_attr.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(acpi_battery);
+
 /* --------------------------------------------------------------------------
                                  Driver Interface
    -------------------------------------------------------------------------- */
@@ -509,7 +514,10 @@ static int acpi_battery_read(struct acpi_battery *battery)
 static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	int result;
 
 	battery->id = id;
@@ -539,10 +547,6 @@ static int acpi_battery_add(struct acpi_sbs *sbs, int id)
 		goto end;
 	}
 
-	result = device_create_file(&battery->bat->dev, &alarm_attr);
-	if (result)
-		goto end;
-	battery->have_sysfs_alarm = 1;
       end:
 	pr_info("%s [%s]: Battery Slot [%s] (battery %s)\n",
 	       ACPI_SBS_DEVICE_NAME, acpi_device_bid(sbs->device),
@@ -554,11 +558,8 @@ static void acpi_battery_remove(struct acpi_sbs *sbs, int id)
 {
 	struct acpi_battery *battery = &sbs->battery[id];
 
-	if (battery->bat) {
-		if (battery->have_sysfs_alarm)
-			device_remove_file(&battery->bat->dev, &alarm_attr);
+	if (battery->bat)
 		power_supply_unregister(battery->bat);
-	}
 }
 
 static int acpi_charger_add(struct acpi_sbs *sbs)
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 3abd5619a9e6..269d314e73a7 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -542,9 +542,7 @@ static bool binder_has_work(struct binder_thread *thread, bool do_proc_work)
 static bool binder_available_for_proc_work_ilocked(struct binder_thread *thread)
 {
 	return !thread->transaction_stack &&
-		binder_worklist_empty_ilocked(&thread->todo) &&
-		(thread->looper & (BINDER_LOOPER_STATE_ENTERED |
-				   BINDER_LOOPER_STATE_REGISTERED));
+		binder_worklist_empty_ilocked(&thread->todo);
 }
 
 static void binder_wakeup_poll_threads_ilocked(struct binder_proc *proc,
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 9d0596dabfb9..66a43b16e400 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -874,7 +874,15 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	} else {
 		/*
 		 * ATA PASS-THROUGH INFORMATION AVAILABLE
-		 * Always in descriptor format sense.
+		 *
+		 * Note: we are supposed to call ata_scsi_set_sense(), which
+		 * respects the D_SENSE bit, instead of unconditionally
+		 * generating the sense data in descriptor format. However,
+		 * because hdparm, hddtemp, and udisks incorrectly assume sense
+		 * data in descriptor format, without even looking at the
+		 * RESPONSE CODE field in the returned sense data (to see which
+		 * format the returned sense data is in), we are stuck with
+		 * being bug compatible with older kernels.
 		 */
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d995d768c362..81572c081333 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,6 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
+#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/swiotlb.h>
@@ -2305,6 +2306,7 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 		      struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -2333,8 +2335,12 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 	if (dev->type && dev->type->name)
 		add_uevent_var(env, "DEVTYPE=%s", dev->type->name);
 
-	if (dev->driver)
-		add_uevent_var(env, "DRIVER=%s", dev->driver->name);
+	/* Synchronize with module_remove_driver() */
+	rcu_read_lock();
+	driver = READ_ONCE(dev->driver);
+	if (driver)
+		add_uevent_var(env, "DRIVER=%s", driver->name);
+	rcu_read_unlock();
 
 	/* Add common DT information about the device */
 	of_device_uevent(dev, env);
@@ -2404,11 +2410,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
 	if (!env)
 		return -ENOMEM;
 
-	/* Synchronize with really_probe() */
-	device_lock(dev);
 	/* let the kset specific function add its keys */
 	retval = kset->uevent_ops->uevent(kset, &dev->kobj, env);
-	device_unlock(dev);
 	if (retval)
 		goto out;
 
diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index eaa9a5cd1db9..27a43b4960f5 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -890,9 +890,12 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
 	/*
 	 * Otherwise: allocate new, larger chunk. We need to allocate before
 	 * taking the lock as most probably the caller uses GFP_KERNEL.
+	 * alloc_dr() will call check_dr_size() to reserve extra memory
+	 * for struct devres automatically, so size @new_size user request
+	 * is delivered to it directly as devm_kmalloc() does.
 	 */
 	new_dr = alloc_dr(devm_kmalloc_release,
-			  total_new_size, gfp, dev_to_node(dev));
+			  new_size, gfp, dev_to_node(dev));
 	if (!new_dr)
 		return NULL;
 
@@ -1216,7 +1219,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
  */
 void devm_free_percpu(struct device *dev, void __percpu *pdata)
 {
-	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
+	/*
+	 * Use devres_release() to prevent memory leakage as
+	 * devm_free_pages() does.
+	 */
+	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
 			       (__force void *)pdata));
 }
 EXPORT_SYMBOL_GPL(devm_free_percpu);
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..851cc5367c04 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -7,6 +7,7 @@
 #include <linux/errno.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/rcupdate.h>
 #include "base.h"
 
 static char *make_driver_name(struct device_driver *drv)
@@ -77,6 +78,9 @@ void module_remove_driver(struct device_driver *drv)
 	if (!drv)
 		return;
 
+	/* Synchronize with dev_uevent() */
+	synchronize_rcu();
+
 	sysfs_remove_link(&drv->p->kobj, "module");
 
 	if (drv->owner)
diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3d6b12f27d0c..f617fc3a1102 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -362,7 +362,7 @@ enum rbd_watch_state {
 enum rbd_lock_state {
 	RBD_LOCK_STATE_UNLOCKED,
 	RBD_LOCK_STATE_LOCKED,
-	RBD_LOCK_STATE_RELEASING,
+	RBD_LOCK_STATE_QUIESCING,
 };
 
 /* WatchNotify::ClientId */
@@ -422,7 +422,7 @@ struct rbd_device {
 	struct list_head	running_list;
 	struct completion	acquire_wait;
 	int			acquire_err;
-	struct completion	releasing_wait;
+	struct completion	quiescing_wait;
 
 	spinlock_t		object_map_lock;
 	u8			*object_map;
@@ -525,7 +525,7 @@ static bool __rbd_is_lock_owner(struct rbd_device *rbd_dev)
 	lockdep_assert_held(&rbd_dev->lock_rwsem);
 
 	return rbd_dev->lock_state == RBD_LOCK_STATE_LOCKED ||
-	       rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING;
+	       rbd_dev->lock_state == RBD_LOCK_STATE_QUIESCING;
 }
 
 static bool rbd_is_lock_owner(struct rbd_device *rbd_dev)
@@ -3459,13 +3459,14 @@ static void rbd_lock_del_request(struct rbd_img_request *img_req)
 	lockdep_assert_held(&rbd_dev->lock_rwsem);
 	spin_lock(&rbd_dev->lock_lists_lock);
 	if (!list_empty(&img_req->lock_item)) {
+		rbd_assert(!list_empty(&rbd_dev->running_list));
 		list_del_init(&img_req->lock_item);
-		need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_RELEASING &&
+		need_wakeup = (rbd_dev->lock_state == RBD_LOCK_STATE_QUIESCING &&
 			       list_empty(&rbd_dev->running_list));
 	}
 	spin_unlock(&rbd_dev->lock_lists_lock);
 	if (need_wakeup)
-		complete(&rbd_dev->releasing_wait);
+		complete(&rbd_dev->quiescing_wait);
 }
 
 static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
@@ -3478,11 +3479,6 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
 	if (rbd_lock_add_request(img_req))
 		return 1;
 
-	if (rbd_dev->opts->exclusive) {
-		WARN_ON(1); /* lock got released? */
-		return -EROFS;
-	}
-
 	/*
 	 * Note the use of mod_delayed_work() in rbd_acquire_lock()
 	 * and cancel_delayed_work() in wake_lock_waiters().
@@ -4183,16 +4179,16 @@ static bool rbd_quiesce_lock(struct rbd_device *rbd_dev)
 	/*
 	 * Ensure that all in-flight IO is flushed.
 	 */
-	rbd_dev->lock_state = RBD_LOCK_STATE_RELEASING;
-	rbd_assert(!completion_done(&rbd_dev->releasing_wait));
+	rbd_dev->lock_state = RBD_LOCK_STATE_QUIESCING;
+	rbd_assert(!completion_done(&rbd_dev->quiescing_wait));
 	if (list_empty(&rbd_dev->running_list))
 		return true;
 
 	up_write(&rbd_dev->lock_rwsem);
-	wait_for_completion(&rbd_dev->releasing_wait);
+	wait_for_completion(&rbd_dev->quiescing_wait);
 
 	down_write(&rbd_dev->lock_rwsem);
-	if (rbd_dev->lock_state != RBD_LOCK_STATE_RELEASING)
+	if (rbd_dev->lock_state != RBD_LOCK_STATE_QUIESCING)
 		return false;
 
 	rbd_assert(list_empty(&rbd_dev->running_list));
@@ -4603,6 +4599,10 @@ static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
 			rbd_warn(rbd_dev, "failed to update lock cookie: %d",
 				 ret);
 
+		if (rbd_dev->opts->exclusive)
+			rbd_warn(rbd_dev,
+			     "temporarily releasing lock on exclusive mapping");
+
 		/*
 		 * Lock cookie cannot be updated on older OSDs, so do
 		 * a manual release and queue an acquire.
@@ -5387,7 +5387,7 @@ static struct rbd_device *__rbd_dev_create(struct rbd_spec *spec)
 	INIT_LIST_HEAD(&rbd_dev->acquiring_list);
 	INIT_LIST_HEAD(&rbd_dev->running_list);
 	init_completion(&rbd_dev->acquire_wait);
-	init_completion(&rbd_dev->releasing_wait);
+	init_completion(&rbd_dev->quiescing_wait);
 
 	spin_lock_init(&rbd_dev->object_map_lock);
 
@@ -6592,11 +6592,6 @@ static int rbd_add_acquire_lock(struct rbd_device *rbd_dev)
 	if (ret)
 		return ret;
 
-	/*
-	 * The lock may have been released by now, unless automatic lock
-	 * transitions are disabled.
-	 */
-	rbd_assert(!rbd_dev->opts->exclusive || rbd_is_lock_owner(rbd_dev));
 	return 0;
 }
 
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8c3db223d634..e45bfe8463a4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -559,6 +559,10 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x0cb5, 0xc547), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
diff --git a/drivers/char/hw_random/amd-rng.c b/drivers/char/hw_random/amd-rng.c
index 0555e3838bce..5229da114377 100644
--- a/drivers/char/hw_random/amd-rng.c
+++ b/drivers/char/hw_random/amd-rng.c
@@ -142,8 +142,10 @@ static int __init amd_rng_mod_init(void)
 
 found:
 	err = pci_read_config_dword(pdev, 0x58, &pmbase);
-	if (err)
+	if (err) {
+		err = pcibios_err_to_errno(err);
 		goto put_dev;
+	}
 
 	pmbase &= 0x0000FF00;
 	if (pmbase == 0) {
diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 8512ec76d526..4a6186f9f889 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -47,6 +47,8 @@ static int tpm_bios_measurements_open(struct inode *inode,
 	if (!err) {
 		seq = file->private_data;
 		seq->private = chip;
+	} else {
+		put_device(&chip->dev);
 	}
 
 	return err;
diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index 77d18276bfe8..90d96ee4a58b 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -505,7 +505,7 @@ da8xx_cfgchip_register_usb0_clk48(struct device *dev,
 	const char * const parent_names[] = { "usb_refclkin", "pll0_auxclk" };
 	struct clk *fck_clk;
 	struct da8xx_usb0_clk48 *usb0;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	fck_clk = devm_clk_get(dev, "fck");
@@ -580,7 +580,7 @@ da8xx_cfgchip_register_usb1_clk48(struct device *dev,
 {
 	const char * const parent_names[] = { "usb0_clk48", "usb_refclkin" };
 	struct da8xx_usb1_clk48 *usb1;
-	struct clk_init_data init;
+	struct clk_init_data init = {};
 	int ret;
 
 	usb1 = devm_kzalloc(dev, sizeof(*usb1), GFP_KERNEL);
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 17a58119165e..55b3a2c3afed 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -37,6 +37,32 @@ struct clk_branch {
 	struct clk_regmap clkr;
 };
 
+/* Branch clock common bits for HLOS-owned clocks */
+#define CBCR_FORCE_MEM_CORE_ON		BIT(14)
+#define CBCR_FORCE_MEM_PERIPH_ON	BIT(13)
+#define CBCR_FORCE_MEM_PERIPH_OFF	BIT(12)
+
+static inline void qcom_branch_set_force_mem_core(struct regmap *regmap,
+						  struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_CORE_ON,
+			   on ? CBCR_FORCE_MEM_CORE_ON : 0);
+}
+
+static inline void qcom_branch_set_force_periph_on(struct regmap *regmap,
+						   struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_PERIPH_ON,
+			   on ? CBCR_FORCE_MEM_PERIPH_ON : 0);
+}
+
+static inline void qcom_branch_set_force_periph_off(struct regmap *regmap,
+						    struct clk_branch clk, bool on)
+{
+	regmap_update_bits(regmap, clk.halt_reg, CBCR_FORCE_MEM_PERIPH_OFF,
+			   on ? CBCR_FORCE_MEM_PERIPH_OFF : 0);
+}
+
 extern const struct clk_ops clk_branch_ops;
 extern const struct clk_ops clk_branch2_ops;
 extern const struct clk_ops clk_branch_simple_ops;
diff --git a/drivers/clk/qcom/gcc-sc7280.c b/drivers/clk/qcom/gcc-sc7280.c
index d10efbf260b7..76d5a9f49d8e 100644
--- a/drivers/clk/qcom/gcc-sc7280.c
+++ b/drivers/clk/qcom/gcc-sc7280.c
@@ -3573,6 +3573,9 @@ static int gcc_sc7280_probe(struct platform_device *pdev)
 	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
 	regmap_update_bits(regmap, 0x7100C, BIT(13), BIT(13));
 
+	/* FORCE_MEM_CORE_ON for ufs phy ice core clocks */
+	qcom_branch_set_force_mem_core(regmap, gcc_ufs_phy_ice_core_clk, true);
+
 	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
 			ARRAY_SIZE(gcc_dfs_clocks));
 	if (ret)
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index d35548aa026f..8e06767e0d4c 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -529,6 +529,7 @@ static void sh_cmt_set_next(struct sh_cmt_channel *ch, unsigned long delta)
 static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 {
 	struct sh_cmt_channel *ch = dev_id;
+	unsigned long flags;
 
 	/* clear flags */
 	sh_cmt_write_cmcsr(ch, sh_cmt_read_cmcsr(ch) &
@@ -559,6 +560,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_SKIPEVENT;
 
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (ch->flags & FLAG_REPROGRAM) {
 		ch->flags &= ~FLAG_REPROGRAM;
 		sh_cmt_clock_event_program_verify(ch, 1);
@@ -571,6 +574,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_IRQCONTEXT;
 
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -781,12 +786,18 @@ static int sh_cmt_clock_event_next(unsigned long delta,
 				   struct clock_event_device *ced)
 {
 	struct sh_cmt_channel *ch = ced_to_sh_cmt(ced);
+	unsigned long flags;
 
 	BUG_ON(!clockevent_state_oneshot(ced));
+
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (likely(ch->flags & FLAG_IRQCONTEXT))
 		ch->next_match_value = delta - 1;
 	else
-		sh_cmt_set_next(ch, delta - 1);
+		__sh_cmt_set_next(ch, delta - 1);
+
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 698fb898847c..9db45c4eaaf2 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -4415,7 +4415,9 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 		ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
 		break;
 	case DMA_TYPE_BCDMA:
-		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2);
+		ud->bchan_cnt = BCDMA_CAP2_BCHAN_CNT(cap2) +
+				BCDMA_CAP3_HBCHAN_CNT(cap3) +
+				BCDMA_CAP3_UBCHAN_CNT(cap3);
 		ud->tchan_cnt = BCDMA_CAP2_TCHAN_CNT(cap2);
 		ud->rchan_cnt = BCDMA_CAP2_RCHAN_CNT(cap2);
 		ud->rflow_cnt = ud->rchan_cnt;
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 2d1641a27a28..a98e1981df15 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -54,11 +54,13 @@ obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
 layerscape_edac_mod-y			:= fsl_ddr_edac.o layerscape_edac.o
 obj-$(CONFIG_EDAC_LAYERSCAPE)		+= layerscape_edac_mod.o
 
-skx_edac-y				:= skx_common.o skx_base.o
-obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o
+skx_edac_common-y			:= skx_common.o
 
-i10nm_edac-y				:= skx_common.o i10nm_base.o
-obj-$(CONFIG_EDAC_I10NM)		+= i10nm_edac.o
+skx_edac-y				:= skx_base.o
+obj-$(CONFIG_EDAC_SKX)			+= skx_edac.o skx_edac_common.o
+
+i10nm_edac-y				:= i10nm_base.o
+obj-$(CONFIG_EDAC_I10NM)		+= i10nm_edac.o skx_edac_common.o
 
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
 obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 19c17c5198c5..88c44d535907 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -46,7 +46,7 @@ static u64 skx_tolm, skx_tohm;
 static LIST_HEAD(dev_edac_list);
 static bool skx_mem_cfg_2lm;
 
-int __init skx_adxl_get(void)
+int skx_adxl_get(void)
 {
 	const char * const *names;
 	int i, j;
@@ -108,12 +108,14 @@ int __init skx_adxl_get(void)
 
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(skx_adxl_get);
 
-void __exit skx_adxl_put(void)
+void skx_adxl_put(void)
 {
 	kfree(adxl_values);
 	kfree(adxl_msg);
 }
+EXPORT_SYMBOL_GPL(skx_adxl_put);
 
 static bool skx_adxl_decode(struct decoded_addr *res, bool error_in_1st_level_mem)
 {
@@ -180,12 +182,14 @@ void skx_set_mem_cfg(bool mem_cfg_2lm)
 {
 	skx_mem_cfg_2lm = mem_cfg_2lm;
 }
+EXPORT_SYMBOL_GPL(skx_set_mem_cfg);
 
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 {
 	skx_decode = decode;
 	skx_show_retry_rd_err_log = show_retry_log;
 }
+EXPORT_SYMBOL_GPL(skx_set_decode);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
 {
@@ -199,6 +203,7 @@ int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
 	*id = GET_BITFIELD(reg, 12, 14);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(skx_get_src_id);
 
 int skx_get_node_id(struct skx_dev *d, u8 *id)
 {
@@ -212,6 +217,7 @@ int skx_get_node_id(struct skx_dev *d, u8 *id)
 	*id = GET_BITFIELD(reg, 0, 2);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(skx_get_node_id);
 
 static int get_width(u32 mtr)
 {
@@ -277,6 +283,7 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 		*list = &dev_edac_list;
 	return ndev;
 }
+EXPORT_SYMBOL_GPL(skx_get_all_bus_mappings);
 
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 {
@@ -316,6 +323,7 @@ int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 	pci_dev_put(pdev);
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(skx_get_hi_lo);
 
 static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 			     int minval, int maxval, const char *name)
@@ -387,6 +395,7 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(skx_get_dimm_info);
 
 int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 			int chan, int dimmno, const char *mod_str)
@@ -435,6 +444,7 @@ int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 
 	return (size == 0 || size == ~0ull) ? 0 : 1;
 }
+EXPORT_SYMBOL_GPL(skx_get_nvdimm_info);
 
 int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 		     const char *ctl_name, const char *mod_str,
@@ -505,6 +515,7 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 	imc->mci = NULL;
 	return rc;
 }
+EXPORT_SYMBOL_GPL(skx_register_mci);
 
 static void skx_unregister_mci(struct skx_imc *imc)
 {
@@ -686,6 +697,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	mce->kflags |= MCE_HANDLED_EDAC;
 	return NOTIFY_DONE;
 }
+EXPORT_SYMBOL_GPL(skx_mce_check_error);
 
 void skx_remove(void)
 {
@@ -723,3 +735,8 @@ void skx_remove(void)
 		kfree(d);
 	}
 }
+EXPORT_SYMBOL_GPL(skx_remove);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Tony Luck");
+MODULE_DESCRIPTION("MC Driver for Intel server processors");
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 03ac067a80b9..13f761930b4f 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -162,8 +162,8 @@ typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci,
 typedef bool (*skx_decode_f)(struct decoded_addr *res);
 typedef void (*skx_show_retry_log_f)(struct decoded_addr *res, char *msg, int len, bool scrub_err);
 
-int __init skx_adxl_get(void);
-void __exit skx_adxl_put(void);
+int skx_adxl_get(void);
+void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
 void skx_set_mem_cfg(bool mem_cfg_2lm);
 
diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index c2d34dc8ba46..c3d49fcc5330 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -2,7 +2,7 @@
 /*
  * Turris Mox rWTM firmware driver
  *
- * Copyright (C) 2019 Marek Behún <kabel@kernel.org>
+ * Copyright (C) 2019, 2024 Marek Behún <kabel@kernel.org>
  */
 
 #include <linux/armada-37xx-rwtm-mailbox.h>
@@ -174,6 +174,9 @@ static void mox_rwtm_rx_callback(struct mbox_client *cl, void *data)
 	struct mox_rwtm *rwtm = dev_get_drvdata(cl->dev);
 	struct armada_37xx_rwtm_rx_msg *msg = data;
 
+	if (completion_done(&rwtm->cmd_done))
+		return;
+
 	rwtm->reply = *msg;
 	complete(&rwtm->cmd_done);
 }
@@ -199,9 +202,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (!wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2))
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
 	if (ret == -ENODATA) {
@@ -235,9 +237,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (!wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2))
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
 	if (ret == -ENODATA) {
@@ -274,9 +275,8 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (!wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2))
+		return -ETIMEDOUT;
 
 	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
 }
@@ -499,6 +499,7 @@ static int turris_mox_rwtm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rwtm);
 
 	mutex_init(&rwtm->busy);
+	init_completion(&rwtm->cmd_done);
 
 	rwtm->mbox_client.dev = dev;
 	rwtm->mbox_client.rx_callback = mox_rwtm_rx_callback;
@@ -512,8 +513,6 @@ static int turris_mox_rwtm_probe(struct platform_device *pdev)
 		goto remove_files;
 	}
 
-	init_completion(&rwtm->cmd_done);
-
 	ret = mox_get_board_info(rwtm);
 	if (ret < 0)
 		dev_warn(dev, "Cannot read board information: %i\n", ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5f6c32ec674d..300d3b236bb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5531,7 +5531,7 @@ int amdgpu_device_baco_exit(struct drm_device *dev)
 	    adev->nbio.funcs->enable_doorbell_interrupt)
 		adev->nbio.funcs->enable_doorbell_interrupt(adev, true);
 
-	if (amdgpu_passthrough(adev) &&
+	if (amdgpu_passthrough(adev) && adev->nbio.funcs &&
 	    adev->nbio.funcs->clear_doorbell_interrupt)
 		adev->nbio.funcs->clear_doorbell_interrupt(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c963b87014b6..92a4f0785878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1509,12 +1509,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
 int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 		struct ras_dispatch_if *info)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_manager *obj;
+	struct ras_ih_data *data;
 
+	obj = amdgpu_ras_find_obj(adev, &info->head);
 	if (!obj)
 		return -EINVAL;
 
+	data = &obj->ih_data;
+
 	if (data->inuse == 0)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 3ed9e8ed3518..1a39103ac10f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -298,6 +298,14 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
+		/* SDMA seems to miss doorbells sometimes when powergating kicks in.
+		 * Updating the wptr directly will wake it. This is only safe because
+		 * we disallow gfxoff in begin_use() and then allow it again in end_use().
+		 */
+		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
+		       lower_32_bits(ring->wptr << 2));
+		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
+		       upper_32_bits(ring->wptr << 2));
 	} else {
 		DRM_DEBUG("Not using doorbell -- "
 				"mmSDMA%i_GFX_RB_WPTR == 0x%08x "
@@ -1675,6 +1683,10 @@ static void sdma_v5_2_ring_begin_use(struct amdgpu_ring *ring)
 	 * but it shouldn't hurt for other parts since
 	 * this GFXOFF will be disallowed anyway when SDMA is
 	 * active, this just makes it explicit.
+	 * sdma_v5_2_ring_set_wptr() takes advantage of this
+	 * to update the wptr because sometimes SDMA seems to miss
+	 * doorbells when entering PG.  If you remove this, update
+	 * sdma_v5_2_ring_set_wptr() as well!
 	 */
 	amdgpu_gfx_off_ctrl(adev, false);
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b821abb56ac3..333be0541893 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2431,7 +2431,8 @@ static int dm_suspend(void *handle)
 
 		dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
 
-		dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
+		if (dm->cached_dc_state)
+			dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
 
 		amdgpu_dm_commit_zero_streams(dm->dc);
 
@@ -6884,7 +6885,8 @@ static void create_eml_sink(struct amdgpu_dm_connector *aconnector)
 		aconnector->dc_sink = aconnector->dc_link->local_sink ?
 		aconnector->dc_link->local_sink :
 		aconnector->dc_em_sink;
-		dc_sink_retain(aconnector->dc_sink);
+		if (aconnector->dc_sink)
+			dc_sink_retain(aconnector->dc_sink);
 	}
 }
 
@@ -8218,7 +8220,8 @@ static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		if (encoder)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index e6b9c6a71841..c8e21c9d2e42 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -154,7 +154,8 @@ const struct dc_plane_status *dc_plane_get_status(
 		if (pipe_ctx->plane_state != plane_state)
 			continue;
 
-		pipe_ctx->plane_state->status.is_flip_pending = false;
+		if (pipe_ctx->plane_state)
+			pipe_ctx->plane_state->status.is_flip_pending = false;
 
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 9bfc465d08fb..9c7c3c06327d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2907,6 +2907,7 @@ static int smu7_update_edc_leakage_table(struct pp_hwmgr *hwmgr)
 
 static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
 	struct smu7_hwmgr *data;
 	int result = 0;
 
@@ -2943,40 +2944,37 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 	/* Initalize Dynamic State Adjustment Rule Settings */
 	result = phm_initializa_dynamic_state_adjustment_rule_settings(hwmgr);
 
-	if (0 == result) {
-		struct amdgpu_device *adev = hwmgr->adev;
+	if (result)
+		goto fail;
 
-		data->is_tlu_enabled = false;
+	data->is_tlu_enabled = false;
 
-		hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
+	hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
 							SMU7_MAX_HARDWARE_POWERLEVELS;
-		hwmgr->platform_descriptor.hardwarePerformanceLevels = 2;
-		hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
+	hwmgr->platform_descriptor.hardwarePerformanceLevels = 2;
+	hwmgr->platform_descriptor.minimumClocksReductionPercentage = 50;
 
-		data->pcie_gen_cap = adev->pm.pcie_gen_mask;
-		if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
-			data->pcie_spc_cap = 20;
-		else
-			data->pcie_spc_cap = 16;
-		data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
-
-		hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
-/* The true clock step depends on the frequency, typically 4.5 or 9 MHz. Here we use 5. */
-		hwmgr->platform_descriptor.clockStep.engineClock = 500;
-		hwmgr->platform_descriptor.clockStep.memoryClock = 500;
-		smu7_thermal_parameter_init(hwmgr);
-	} else {
-		/* Ignore return value in here, we are cleaning up a mess. */
-		smu7_hwmgr_backend_fini(hwmgr);
-	}
+	data->pcie_gen_cap = adev->pm.pcie_gen_mask;
+	if (data->pcie_gen_cap & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		data->pcie_spc_cap = 20;
+	else
+		data->pcie_spc_cap = 16;
+	data->pcie_lane_cap = adev->pm.pcie_mlw_mask;
+
+	hwmgr->platform_descriptor.vbiosInterruptId = 0x20000400; /* IRQ_SOURCE1_SW_INT */
+	/* The true clock step depends on the frequency, typically 4.5 or 9 MHz. Here we use 5. */
+	hwmgr->platform_descriptor.clockStep.engineClock = 500;
+	hwmgr->platform_descriptor.clockStep.memoryClock = 500;
+	smu7_thermal_parameter_init(hwmgr);
 
 	result = smu7_update_edc_leakage_table(hwmgr);
-	if (result) {
-		smu7_hwmgr_backend_fini(hwmgr);
-		return result;
-	}
+	if (result)
+		goto fail;
 
 	return 0;
+fail:
+	smu7_hwmgr_backend_fini(hwmgr);
+	return result;
 }
 
 static int smu7_force_dpm_highest(struct pp_hwmgr *hwmgr)
@@ -3277,8 +3275,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct smu7_power_state *smu7_ps =
-				cast_phw_smu7_power_state(&request_ps->hardware);
+	struct smu7_power_state *smu7_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -3295,6 +3292,10 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	uint32_t latency;
 	bool latency_allowed = false;
 
+	smu7_ps = cast_phw_smu7_power_state(&request_ps->hardware);
+	if (!smu7_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 	data->mclk_ignore_signal = false;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 03bf8f069222..f0f8ebffd9f2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -1051,16 +1051,18 @@ static int smu8_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 				struct pp_power_state  *prequest_ps,
 			const struct pp_power_state *pcurrent_ps)
 {
-	struct smu8_power_state *smu8_ps =
-				cast_smu8_power_state(&prequest_ps->hardware);
-
-	const struct smu8_power_state *smu8_current_ps =
-				cast_const_smu8_power_state(&pcurrent_ps->hardware);
-
+	struct smu8_power_state *smu8_ps;
+	const struct smu8_power_state *smu8_current_ps;
 	struct smu8_hwmgr *data = hwmgr->backend;
 	struct PP_Clocks clocks = {0, 0, 0, 0};
 	bool force_high;
 
+	smu8_ps = cast_smu8_power_state(&prequest_ps->hardware);
+	smu8_current_ps = cast_const_smu8_power_state(&pcurrent_ps->hardware);
+
+	if (!smu8_ps || !smu8_current_ps)
+		return -EINVAL;
+
 	smu8_ps->need_dfs_bypass = true;
 
 	data->battery_state = (PP_StateUILabel_Battery == prequest_ps->classification.ui_label);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index e6336654c565..aba8904ac75f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3237,8 +3237,7 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct vega10_power_state *vega10_ps =
-				cast_phw_vega10_power_state(&request_ps->hardware);
+	struct vega10_power_state *vega10_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -3256,6 +3255,10 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	uint32_t stable_pstate_sclk = 0, stable_pstate_mclk = 0;
 	uint32_t latency;
 
+	vega10_ps = cast_phw_vega10_power_state(&request_ps->hardware);
+	if (!vega10_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index a3723ba35923..7671a8b3c195 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -69,8 +69,8 @@ MODULE_FIRMWARE("amdgpu/aldebaran_smc.bin");
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
 #define smnPCIE_LC_SPEED_CNTL			0x11140290
-#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xC000
-#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
 
 static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
 static const int link_speed[] = {25, 50, 80, 160};
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index 6a4f20fccf84..7b0bc9704eac 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1027,7 +1027,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 	u32 status_reg;
 	u8 *buffer = msg->buffer;
 	unsigned int i;
-	int num_transferred = 0;
 	int ret;
 
 	/* Buffer size of AUX CH is 16 bytes */
@@ -1079,7 +1078,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			reg = buffer[i];
 			writel(reg, dp->reg_base + ANALOGIX_DP_BUF_DATA_0 +
 			       4 * i);
-			num_transferred++;
 		}
 	}
 
@@ -1127,7 +1125,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			reg = readl(dp->reg_base + ANALOGIX_DP_BUF_DATA_0 +
 				    4 * i);
 			buffer[i] = (unsigned char)reg;
-			num_transferred++;
 		}
 	}
 
@@ -1144,7 +1141,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 		 (msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_READ)
 		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
 
-	return num_transferred > 0 ? num_transferred : -EBUSY;
+	return msg->size;
 
 aux_error:
 	/* if aux err happen, reset aux */
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 957b6dd0751a..a95f9f3c71b0 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -867,6 +867,11 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 
 			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
+			if (!modeset->mode) {
+				ret = -ENOMEM;
+				break;
+			}
+
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
 			modeset->x = offset->x;
diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 865c7f39143e..f24667a003a2 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -2974,7 +2974,7 @@ static int drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 
 	/* FIXME: Actually do some real error handling here */
 	ret = drm_dp_mst_wait_tx_reply(mstb, txmsg);
-	if (ret <= 0) {
+	if (ret < 0) {
 		drm_err(mgr->dev, "Sending link address failed with %d\n", ret);
 		goto out;
 	}
@@ -3026,7 +3026,7 @@ static int drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 	mutex_unlock(&mgr->lock);
 
 out:
-	if (ret <= 0)
+	if (ret < 0)
 		mstb->link_address_sent = false;
 	kfree(txmsg);
 	return ret < 0 ? ret : changed;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index f0b2540e60e4..87da2278398a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -353,9 +353,11 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 
 static inline enum dma_data_direction etnaviv_op_to_dma_dir(u32 op)
 {
-	if (op & ETNA_PREP_READ)
+	op &= ETNA_PREP_READ | ETNA_PREP_WRITE;
+
+	if (op == ETNA_PREP_READ)
 		return DMA_FROM_DEVICE;
-	else if (op & ETNA_PREP_WRITE)
+	else if (op == ETNA_PREP_WRITE)
 		return DMA_TO_DEVICE;
 	else
 		return DMA_BIDIRECTIONAL;
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 8a2219fcf9b4..c3eb15c2b3c3 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -310,6 +310,9 @@ static int cdv_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index ace95d4bdb6f..cfecebc126c7 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -508,6 +508,9 @@ static int psb_intel_lvds_get_modes(struct drm_connector *connector)
 	if (mode_dev->panel_fixed_mode != NULL) {
 		struct drm_display_mode *mode =
 		    drm_mode_duplicate(dev, mode_dev->panel_fixed_mode);
+		if (!mode)
+			return 0;
+
 		drm_mode_probed_add(connector, mode);
 		return 1;
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 7a3abeca4e51..40852cb5831f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3627,6 +3627,8 @@ int intel_dp_retrain_link(struct intel_encoder *encoder,
 		    !intel_dp_mst_is_master_trans(crtc_state))
 			continue;
 
+		intel_dp->link_trained = false;
+
 		intel_dp_check_frl_training(intel_dp);
 		intel_dp_pcon_dsc_configure(intel_dp, crtc_state);
 		intel_dp_start_link_train(intel_dp, crtc_state);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 5c6362a55cfa..2c4ef176593f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -286,6 +286,41 @@ static vm_fault_t vm_fault_cpu(struct vm_fault *vmf)
 	return i915_error_to_vmf_fault(err);
 }
 
+static void set_address_limits(struct vm_area_struct *area,
+			       struct i915_vma *vma,
+			       unsigned long obj_offset,
+			       unsigned long *start_vaddr,
+			       unsigned long *end_vaddr)
+{
+	unsigned long vm_start, vm_end, vma_size; /* user's memory parameters */
+	long start, end; /* memory boundaries */
+
+	/*
+	 * Let's move into the ">> PAGE_SHIFT"
+	 * domain to be sure not to lose bits
+	 */
+	vm_start = area->vm_start >> PAGE_SHIFT;
+	vm_end = area->vm_end >> PAGE_SHIFT;
+	vma_size = vma->size >> PAGE_SHIFT;
+
+	/*
+	 * Calculate the memory boundaries by considering the offset
+	 * provided by the user during memory mapping and the offset
+	 * provided for the partial mapping.
+	 */
+	start = vm_start;
+	start -= obj_offset;
+	start += vma->ggtt_view.partial.offset;
+	end = start + vma_size;
+
+	start = max_t(long, start, vm_start);
+	end = min_t(long, end, vm_end);
+
+	/* Let's move back into the "<< PAGE_SHIFT" domain */
+	*start_vaddr = (unsigned long)start << PAGE_SHIFT;
+	*end_vaddr = (unsigned long)end << PAGE_SHIFT;
+}
+
 static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 {
 #define MIN_CHUNK_PAGES (SZ_1M >> PAGE_SHIFT)
@@ -298,14 +333,18 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 	struct i915_ggtt *ggtt = &i915->ggtt;
 	bool write = area->vm_flags & VM_WRITE;
 	struct i915_gem_ww_ctx ww;
+	unsigned long obj_offset;
+	unsigned long start, end; /* memory boundaries */
 	intel_wakeref_t wakeref;
 	struct i915_vma *vma;
 	pgoff_t page_offset;
+	unsigned long pfn;
 	int srcu;
 	int ret;
 
-	/* We don't use vmf->pgoff since that has the fake offset */
+	obj_offset = area->vm_pgoff - drm_vma_node_start(&mmo->vma_node);
 	page_offset = (vmf->address - area->vm_start) >> PAGE_SHIFT;
+	page_offset += obj_offset;
 
 	trace_i915_gem_object_fault(obj, page_offset, true, write);
 
@@ -376,12 +415,14 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 	if (ret)
 		goto err_unpin;
 
+	set_address_limits(area, vma, obj_offset, &start, &end);
+
+	pfn = (ggtt->gmadr.start + i915_ggtt_offset(vma)) >> PAGE_SHIFT;
+	pfn += (start - area->vm_start) >> PAGE_SHIFT;
+	pfn += obj_offset - vma->ggtt_view.partial.offset;
+
 	/* Finally, remap it using the new GTT offset */
-	ret = remap_io_mapping(area,
-			       area->vm_start + (vma->ggtt_view.partial.offset << PAGE_SHIFT),
-			       (ggtt->gmadr.start + vma->node.start) >> PAGE_SHIFT,
-			       min_t(u64, vma->size, area->vm_end - area->vm_start),
-			       &ggtt->iomap);
+	ret = remap_io_mapping(area, start, pfn, end - start, &ggtt->iomap);
 	if (ret)
 		goto err_fence;
 
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index eac55083c574..02b353641eab 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -3231,11 +3231,7 @@ static void remove_from_engine(struct i915_request *rq)
 
 static bool can_preempt(struct intel_engine_cs *engine)
 {
-	if (GRAPHICS_VER(engine->i915) > 8)
-		return true;
-
-	/* GPGPU on bdw requires extra w/a; not implemented */
-	return engine->class != RENDER_CLASS;
+	return GRAPHICS_VER(engine->i915) > 8;
 }
 
 static void kick_execlists(const struct i915_request *rq, int prio)
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 411cf0f21661..c54d56fb7b4c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -204,27 +204,20 @@ int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
 			struct mtk_plane_state *mtk_state)
 {
 	struct drm_plane_state *state = &mtk_state->base;
-	unsigned int rotation = 0;
 
-	rotation = drm_rotation_simplify(state->rotation,
-					 DRM_MODE_ROTATE_0 |
-					 DRM_MODE_REFLECT_X |
-					 DRM_MODE_REFLECT_Y);
-	rotation &= ~DRM_MODE_ROTATE_0;
-
-	/* We can only do reflection, not rotation */
-	if ((rotation & DRM_MODE_ROTATE_MASK) != 0)
+	/* check if any unsupported rotation is set */
+	if (state->rotation & ~mtk_ovl_supported_rotations(dev))
 		return -EINVAL;
 
 	/*
 	 * TODO: Rotating/reflecting YUV buffers is not supported at this time.
 	 *	 Only RGB[AX] variants are supported.
+	 *	 Since DRM_MODE_ROTATE_0 means "no rotation", we should not
+	 *	 reject layers with this property.
 	 */
-	if (state->fb->format->is_yuv && rotation != 0)
+	if (state->fb->format->is_yuv && (state->rotation & ~DRM_MODE_ROTATE_0))
 		return -EINVAL;
 
-	state->rotation = rotation;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 25cb50f2391f..fa9616505ed6 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -145,7 +145,11 @@ unsigned int mtk_ddp_comp_supported_rotations(struct mtk_ddp_comp *comp)
 	if (comp->funcs && comp->funcs->supported_rotations)
 		return comp->funcs->supported_rotations(comp->dev);
 
-	return 0;
+	/*
+	 * In order to pass IGT tests, DRM_MODE_ROTATE_0 is required when
+	 * rotation is not supported.
+	 */
+	return DRM_MODE_ROTATE_0;
 }
 
 static inline unsigned int mtk_ddp_comp_layer_nr(struct mtk_ddp_comp *comp)
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index eda072a3bf9a..b0c3bc2cf2f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -154,6 +154,8 @@ static void mtk_plane_atomic_async_update(struct drm_plane *plane,
 	plane->state->src_y = new_state->src_y;
 	plane->state->src_h = new_state->src_h;
 	plane->state->src_w = new_state->src_w;
+	plane->state->dst.x1 = new_state->dst.x1;
+	plane->state->dst.y1 = new_state->dst.y1;
 
 	mtk_plane_update_new_state(new_state, new_plane_state);
 	swap(plane->state->fb, new_state->fb);
@@ -256,7 +258,7 @@ int mtk_plane_init(struct drm_device *dev, struct drm_plane *plane,
 		return err;
 	}
 
-	if (supported_rotations & ~DRM_MODE_ROTATE_0) {
+	if (supported_rotations) {
 		err = drm_plane_create_rotation_property(plane,
 							 DRM_MODE_ROTATE_0,
 							 supported_rotations);
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 207b309a21c0..829aadc1258a 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -248,29 +248,20 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (ret)
 		goto free_drm;
 	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_0);
-	if (ret) {
-		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
-		goto free_drm;
-	}
+	if (ret)
+		goto free_canvas_osd1;
 	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_1);
-	if (ret) {
-		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
-		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
-		goto free_drm;
-	}
+	if (ret)
+		goto free_canvas_vd1_0;
 	ret = meson_canvas_alloc(priv->canvas, &priv->canvas_id_vd1_2);
-	if (ret) {
-		meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
-		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
-		meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
-		goto free_drm;
-	}
+	if (ret)
+		goto free_canvas_vd1_1;
 
 	priv->vsync_irq = platform_get_irq(pdev, 0);
 
 	ret = drm_vblank_init(drm, 1);
 	if (ret)
-		goto free_drm;
+		goto free_canvas_vd1_2;
 
 	/* Assign limits per soc revision/package */
 	for (i = 0 ; i < ARRAY_SIZE(meson_drm_soc_attrs) ; ++i) {
@@ -286,11 +277,11 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	 */
 	ret = drm_aperture_remove_framebuffers(false, &meson_driver);
 	if (ret)
-		goto free_drm;
+		goto free_canvas_vd1_2;
 
 	ret = drmm_mode_config_init(drm);
 	if (ret)
-		goto free_drm;
+		goto free_canvas_vd1_2;
 	drm->mode_config.max_width = 3840;
 	drm->mode_config.max_height = 2160;
 	drm->mode_config.funcs = &meson_mode_config_funcs;
@@ -305,7 +296,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	if (priv->afbcd.ops) {
 		ret = priv->afbcd.ops->init(priv);
 		if (ret)
-			goto free_drm;
+			goto free_canvas_vd1_2;
 	}
 
 	/* Encoder Initialization */
@@ -364,6 +355,14 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 exit_afbcd:
 	if (priv->afbcd.ops)
 		priv->afbcd.ops->exit(priv);
+free_canvas_vd1_2:
+	meson_canvas_free(priv->canvas, priv->canvas_id_vd1_2);
+free_canvas_vd1_1:
+	meson_canvas_free(priv->canvas, priv->canvas_id_vd1_1);
+free_canvas_vd1_0:
+	meson_canvas_free(priv->canvas, priv->canvas_id_vd1_0);
+free_canvas_osd1:
+	meson_canvas_free(priv->canvas, priv->canvas_id_osd1);
 free_drm:
 	drm_dev_put(drm);
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_i2c.c b/drivers/gpu/drm/mgag200/mgag200_i2c.c
index ac8e34eef513..07f7e43c0dca 100644
--- a/drivers/gpu/drm/mgag200/mgag200_i2c.c
+++ b/drivers/gpu/drm/mgag200/mgag200_i2c.c
@@ -134,7 +134,7 @@ struct mga_i2c_chan *mgag200_i2c_create(struct drm_device *dev)
 	i2c->adapter.algo_data = &i2c->bit;
 
 	i2c->bit.udelay = 10;
-	i2c->bit.timeout = 2;
+	i2c->bit.timeout = usecs_to_jiffies(2200);
 	i2c->bit.data = i2c;
 	i2c->bit.setsda		= mga_gpio_setsda;
 	i2c->bit.setscl		= mga_gpio_setscl;
diff --git a/drivers/gpu/drm/nouveau/nouveau_prime.c b/drivers/gpu/drm/nouveau/nouveau_prime.c
index 531615719f6d..89fcbfdb5f0a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_prime.c
+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
@@ -63,7 +63,8 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
 	 * to the caller, instead of a normal nouveau_bo ttm reference. */
 	ret = drm_gem_object_init(dev, &nvbo->bo.base, size);
 	if (ret) {
-		nouveau_bo_ref(NULL, &nvbo);
+		drm_gem_object_release(&nvbo->bo.base);
+		kfree(nvbo);
 		obj = ERR_PTR(-ENOMEM);
 		goto unlock;
 	}
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 9e518213a54f..0a2d5f461aee 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -553,7 +553,11 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	usleep_range(5000, 10000);
 
 	if (boe->desc->lp11_before_reset) {
-		mipi_dsi_dcs_nop(boe->dsi);
+		ret = mipi_dsi_dcs_nop(boe->dsi);
+		if (ret < 0) {
+			dev_err(&boe->dsi->dev, "Failed to send NOP: %d\n", ret);
+			goto poweroff;
+		}
 		usleep_range(1000, 2000);
 	}
 	gpiod_set_value(boe->enable_gpio, 1);
@@ -574,13 +578,13 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	return 0;
 
 poweroff:
+	gpiod_set_value(boe->enable_gpio, 0);
 	regulator_disable(boe->avee);
 poweroffavdd:
 	regulator_disable(boe->avdd);
 poweroff1v8:
 	usleep_range(5000, 7000);
 	regulator_disable(boe->pp1800);
-	gpiod_set_value(boe->enable_gpio, 0);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 4c271244092b..c2d1633ddec5 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -687,3 +687,4 @@ module_platform_driver(panfrost_driver);
 MODULE_AUTHOR("Panfrost Project Developers");
 MODULE_DESCRIPTION("Panfrost DRM Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: governor_simpleondemand");
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index dc04412784a0..c17b24eee0cf 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -233,6 +233,9 @@ static int qxl_add_mode(struct drm_connector *connector,
 		return 0;
 
 	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (!mode)
+		return 0;
+
 	if (preferred)
 		mode->type |= DRM_MODE_TYPE_PREFERRED;
 	mode->hdisplay = width;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 50eba25456bb..61fcd86edf4e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -32,7 +32,6 @@
 #define VMW_FENCE_WRAP (1 << 31)
 
 struct vmw_fence_manager {
-	int num_fence_objects;
 	struct vmw_private *dev_priv;
 	spinlock_t lock;
 	struct list_head fence_list;
@@ -127,13 +126,13 @@ static void vmw_fence_obj_destroy(struct dma_fence *f)
 {
 	struct vmw_fence_obj *fence =
 		container_of(f, struct vmw_fence_obj, base);
-
 	struct vmw_fence_manager *fman = fman_from_fence(fence);
 
-	spin_lock(&fman->lock);
-	list_del_init(&fence->head);
-	--fman->num_fence_objects;
-	spin_unlock(&fman->lock);
+	if (!list_empty(&fence->head)) {
+		spin_lock(&fman->lock);
+		list_del_init(&fence->head);
+		spin_unlock(&fman->lock);
+	}
 	fence->destroy(fence);
 }
 
@@ -260,7 +259,6 @@ static const struct dma_fence_ops vmw_fence_ops = {
 	.release = vmw_fence_obj_destroy,
 };
 
-
 /*
  * Execute signal actions on fences recently signaled.
  * This is done from a workqueue so we don't have to execute
@@ -363,7 +361,6 @@ static int vmw_fence_obj_init(struct vmw_fence_manager *fman,
 		goto out_unlock;
 	}
 	list_add_tail(&fence->head, &fman->fence_list);
-	++fman->num_fence_objects;
 
 out_unlock:
 	spin_unlock(&fman->lock);
@@ -411,7 +408,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 				      u32 passed_seqno)
 {
 	u32 goal_seqno;
-	struct vmw_fence_obj *fence;
+	struct vmw_fence_obj *fence, *next_fence;
 
 	if (likely(!fman->seqno_valid))
 		return false;
@@ -421,7 +418,7 @@ static bool vmw_fence_goal_new_locked(struct vmw_fence_manager *fman,
 		return false;
 
 	fman->seqno_valid = false;
-	list_for_each_entry(fence, &fman->fence_list, head) {
+	list_for_each_entry_safe(fence, next_fence, &fman->fence_list, head) {
 		if (!list_empty(&fence->seq_passed_actions)) {
 			fman->seqno_valid = true;
 			vmw_fence_goal_write(fman->dev_priv,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index 54c5d16eb3b7..ec46b3b70d04 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -98,7 +98,7 @@ static int vmw_overlay_send_put(struct vmw_private *dev_priv,
 {
 	struct vmw_escape_video_flush *flush;
 	size_t fifo_size;
-	bool have_so = (dev_priv->active_display_unit == vmw_du_screen_object);
+	bool have_so = (dev_priv->active_display_unit != vmw_du_legacy);
 	int i, num_items;
 	SVGAGuestPtr ptr;
 
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 115d862d3e91..11d15c83f502 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -714,13 +714,12 @@ static int wacom_intuos_get_tool_type(int tool_id)
 	case 0x8e2: /* IntuosHT2 pen */
 	case 0x022:
 	case 0x200: /* Pro Pen 3 */
-	case 0x04200: /* Pro Pen 3 */
 	case 0x10842: /* MobileStudio Pro Pro Pen slim */
 	case 0x14802: /* Intuos4/5 13HD/24HD Classic Pen */
 	case 0x16802: /* Cintiq 13HD Pro Pen */
 	case 0x18802: /* DTH2242 Pen */
 	case 0x10802: /* Intuos4/5 13HD/24HD General Pen */
-	case 0x80842: /* Intuos Pro and Cintiq Pro 3D Pen */
+	case 0x8842: /* Intuos Pro and Cintiq Pro 3D Pen */
 		tool_type = BTN_TOOL_PEN;
 		break;
 
diff --git a/drivers/hwmon/adt7475.c b/drivers/hwmon/adt7475.c
index 22e314725def..b4c0f01f52c4 100644
--- a/drivers/hwmon/adt7475.c
+++ b/drivers/hwmon/adt7475.c
@@ -1770,7 +1770,7 @@ static void adt7475_read_pwm(struct i2c_client *client, int index)
 		data->pwm[CONTROL][index] &= ~0xE0;
 		data->pwm[CONTROL][index] |= (7 << 5);
 
-		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
+		i2c_smbus_write_byte_data(client, PWM_REG(index),
 					  data->pwm[INPUT][index]);
 
 		i2c_smbus_write_byte_data(client, PWM_CONFIG_REG(index),
diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 2895cea54193..266baae94e3e 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -312,6 +312,7 @@ static ssize_t temp_store(struct device *dev,
 		return ret;
 
 	mutex_lock(&data->update_lock);
+	temp = clamp_val(temp, -1000000, 1000000);	/* prevent underflow */
 	temp = DIV_ROUND_CLOSEST(temp, 1000) + data->temp_offset;
 	temp = clamp_val(temp, 0, data->type == max6581 ? 255 : 127);
 	data->temp[nr][index] = temp;
@@ -429,14 +430,14 @@ static SENSOR_DEVICE_ATTR_RO(temp6_max_alarm, alarm, 20);
 static SENSOR_DEVICE_ATTR_RO(temp7_max_alarm, alarm, 21);
 static SENSOR_DEVICE_ATTR_RO(temp8_max_alarm, alarm, 23);
 
-static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 14);
+static SENSOR_DEVICE_ATTR_RO(temp1_crit_alarm, alarm, 15);
 static SENSOR_DEVICE_ATTR_RO(temp2_crit_alarm, alarm, 8);
 static SENSOR_DEVICE_ATTR_RO(temp3_crit_alarm, alarm, 9);
 static SENSOR_DEVICE_ATTR_RO(temp4_crit_alarm, alarm, 10);
 static SENSOR_DEVICE_ATTR_RO(temp5_crit_alarm, alarm, 11);
 static SENSOR_DEVICE_ATTR_RO(temp6_crit_alarm, alarm, 12);
 static SENSOR_DEVICE_ATTR_RO(temp7_crit_alarm, alarm, 13);
-static SENSOR_DEVICE_ATTR_RO(temp8_crit_alarm, alarm, 15);
+static SENSOR_DEVICE_ATTR_RO(temp8_crit_alarm, alarm, 14);
 
 static SENSOR_DEVICE_ATTR_RO(temp2_fault, alarm, 1);
 static SENSOR_DEVICE_ATTR_RO(temp3_fault, alarm, 2);
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index c594f45319fc..dfb8022c4da1 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -323,8 +323,10 @@ static int of_get_coresight_platform_data(struct device *dev,
 			continue;
 
 		ret = of_coresight_parse_endpoint(dev, ep, pdata);
-		if (ret)
+		if (ret) {
+			of_node_put(ep);
 			return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index d3d06e3b4f3b..44582cf29e16 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -34,6 +34,7 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	struct i2c_client *client = i2c_verify_client(dev);
 	struct alert_data *data = addrp;
 	struct i2c_driver *driver;
+	int ret;
 
 	if (!client || client->addr != data->addr)
 		return 0;
@@ -47,16 +48,47 @@ static int smbus_do_alert(struct device *dev, void *addrp)
 	device_lock(dev);
 	if (client->dev.driver) {
 		driver = to_i2c_driver(client->dev.driver);
-		if (driver->alert)
+		if (driver->alert) {
+			/* Stop iterating after we find the device */
 			driver->alert(client, data->type, data->data);
-		else
+			ret = -EBUSY;
+		} else {
 			dev_warn(&client->dev, "no driver alert()!\n");
-	} else
+			ret = -EOPNOTSUPP;
+		}
+	} else {
 		dev_dbg(&client->dev, "alert with no driver\n");
+		ret = -ENODEV;
+	}
+	device_unlock(dev);
+
+	return ret;
+}
+
+/* Same as above, but call back all drivers with alert handler */
+
+static int smbus_do_alert_force(struct device *dev, void *addrp)
+{
+	struct i2c_client *client = i2c_verify_client(dev);
+	struct alert_data *data = addrp;
+	struct i2c_driver *driver;
+
+	if (!client || (client->flags & I2C_CLIENT_TEN))
+		return 0;
+
+	/*
+	 * Drivers should either disable alerts, or provide at least
+	 * a minimal handler. Lock so the driver won't change.
+	 */
+	device_lock(dev);
+	if (client->dev.driver) {
+		driver = to_i2c_driver(client->dev.driver);
+		if (driver->alert)
+			driver->alert(client, data->type, data->data);
+	}
 	device_unlock(dev);
 
-	/* Stop iterating after we find the device */
-	return -EBUSY;
+	return 0;
 }
 
 /*
@@ -67,6 +99,7 @@ static irqreturn_t smbus_alert(int irq, void *d)
 {
 	struct i2c_smbus_alert *alert = d;
 	struct i2c_client *ara;
+	unsigned short prev_addr = I2C_CLIENT_END; /* Not a valid address */
 
 	ara = alert->ara;
 
@@ -94,8 +127,25 @@ static irqreturn_t smbus_alert(int irq, void *d)
 			data.addr, data.data);
 
 		/* Notify driver for the device which issued the alert */
-		device_for_each_child(&ara->adapter->dev, &data,
-				      smbus_do_alert);
+		status = device_for_each_child(&ara->adapter->dev, &data,
+					       smbus_do_alert);
+		/*
+		 * If we read the same address more than once, and the alert
+		 * was not handled by a driver, it won't do any good to repeat
+		 * the loop because it will never terminate. Try again, this
+		 * time calling the alert handlers of all devices connected to
+		 * the bus, and abort the loop afterwards. If this helps, we
+		 * are all set. If it doesn't, there is nothing else we can do,
+		 * so we might as well abort the loop.
+		 * Note: This assumes that a driver with alert handler handles
+		 * the alert properly and clears it if necessary.
+		 */
+		if (data.addr == prev_addr && status != -EBUSY) {
+			device_for_each_child(&ara->adapter->dev, &data,
+					      smbus_do_alert_force);
+			break;
+		}
+		prev_addr = data.addr;
 	}
 
 	return IRQ_HANDLED;
diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index 0c98dd3dee67..98f3d8b382c1 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -794,7 +794,6 @@ static struct ib_gid_table *alloc_gid_table(int sz)
 static void release_gid_table(struct ib_device *device,
 			      struct ib_gid_table *table)
 {
-	bool leak = false;
 	int i;
 
 	if (!table)
@@ -803,15 +802,12 @@ static void release_gid_table(struct ib_device *device,
 	for (i = 0; i < table->sz; i++) {
 		if (is_gid_entry_free(table->data_vec[i]))
 			continue;
-		if (kref_read(&table->data_vec[i]->kref) > 1) {
-			dev_err(&device->dev,
-				"GID entry ref leak for index %d ref=%u\n", i,
-				kref_read(&table->data_vec[i]->kref));
-			leak = true;
-		}
+
+		WARN_ONCE(true,
+			  "GID entry ref leak for dev %s index %d ref=%u\n",
+			  dev_name(&device->dev), i,
+			  kref_read(&table->data_vec[i]->kref));
 	}
-	if (leak)
-		return;
 
 	mutex_destroy(&table->lock);
 	kfree(table->data_vec);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 725f2719132f..5d1ce55fda71 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2145,6 +2145,9 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	unsigned long flags;
 	int ret;
 
+	if (!rdma_is_port_valid(ib_dev, port))
+		return -EINVAL;
+
 	/*
 	 * Drivers wish to call this before ib_register_driver, so we have to
 	 * setup the port data early.
@@ -2153,9 +2156,6 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	if (ret)
 		return ret;
 
-	if (!rdma_is_port_valid(ib_dev, port))
-		return -EINVAL;
-
 	pdata = &ib_dev->port_data[port];
 	spin_lock_irqsave(&pdata->netdev_lock, flags);
 	old_ndev = rcu_dereference_protected(
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 2b47073c61a6..2d09d1be38f1 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -369,8 +369,10 @@ EXPORT_SYMBOL(iw_cm_disconnect);
  *
  * Clean up all resources associated with the connection and release
  * the initial reference taken by iw_create_cm_id.
+ *
+ * Returns true if and only if the last cm_id_priv reference has been dropped.
  */
-static void destroy_cm_id(struct iw_cm_id *cm_id)
+static bool destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
 	struct ib_qp *qp;
@@ -440,7 +442,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
 
-	(void)iwcm_deref_id(cm_id_priv);
+	return iwcm_deref_id(cm_id_priv);
 }
 
 /*
@@ -451,7 +453,8 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	destroy_cm_id(cm_id);
+	if (!destroy_cm_id(cm_id))
+		flush_workqueue(iwcm_wq);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
 
@@ -1035,7 +1038,7 @@ static void cm_work_handler(struct work_struct *_work)
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret = process_event(cm_id_priv, &levent);
 			if (ret)
-				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 91b71fa3c121..e29894197f5c 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2354,7 +2354,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp *qp,
 		break;
 	case IB_WR_SEND_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM;
-		wqe->send.imm_data = wr->ex.imm_data;
+		wqe->send.imm_data = be32_to_cpu(wr->ex.imm_data);
 		break;
 	case IB_WR_SEND_WITH_INV:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
@@ -2384,7 +2384,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_send_wr *wr,
 		break;
 	case IB_WR_RDMA_WRITE_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_WRITE_WITH_IMM;
-		wqe->rdma.imm_data = wr->ex.imm_data;
+		wqe->rdma.imm_data = be32_to_cpu(wr->ex.imm_data);
 		break;
 	case IB_WR_RDMA_READ:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_RDMA_READ;
@@ -3334,7 +3334,7 @@ static void bnxt_re_process_res_shadow_qp_wc(struct bnxt_re_qp *gsi_sqp,
 	wc->byte_len = orig_cqe->length;
 	wc->qp = &gsi_qp->ib_qp;
 
-	wc->ex.imm_data = orig_cqe->immdata;
+	wc->ex.imm_data = cpu_to_be32(le32_to_cpu(orig_cqe->immdata));
 	wc->src_qp = orig_cqe->src_qp;
 	memcpy(wc->smac, orig_cqe->smac, ETH_ALEN);
 	if (bnxt_re_is_vlan_pkt(orig_cqe, &vlan_id, &sl)) {
@@ -3470,7 +3470,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				 (unsigned long)(cqe->qp_handle),
 				 struct bnxt_re_qp, qplib_qp);
 			wc->qp = &qp->ib_qp;
-			wc->ex.imm_data = cqe->immdata;
+			wc->ex.imm_data = cpu_to_be32(le32_to_cpu(cqe->immdata));
 			wc->src_qp = cqe->src_qp;
 			memcpy(wc->smac, cqe->smac, ETH_ALEN);
 			wc->port_num = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 49d89c080827..4f1a845f9be6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -164,7 +164,7 @@ struct bnxt_qplib_swqe {
 		/* Send, with imm, inval key */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
 				u32	inv_key;
 			};
 			u32		q_key;
@@ -182,7 +182,7 @@ struct bnxt_qplib_swqe {
 		/* RDMA write, with imm, read */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
 				u32	inv_key;
 			};
 			u64		remote_va;
@@ -374,7 +374,7 @@ struct bnxt_qplib_cqe {
 	u16				cfa_meta;
 	u64				wr_id;
 	union {
-		__be32			immdata;
+		__le32			immdata;
 		u32			invrkey;
 	};
 	u64				qp_handle;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index e02107123c97..f234fd8e4a2b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -100,6 +100,7 @@
 #define MR_TYPE_DMA				0x03
 
 #define HNS_ROCE_FRMR_MAX_PA			512
+#define HNS_ROCE_FRMR_ALIGN_SIZE		128
 
 #define PKEY_ID					0xffff
 #define GUID_LEN				8
@@ -220,6 +221,9 @@ enum {
 #define HNS_HW_PAGE_SHIFT			12
 #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
 
+#define HNS_HW_MAX_PAGE_SHIFT			27
+#define HNS_HW_MAX_PAGE_SIZE			(1 << HNS_HW_MAX_PAGE_SHIFT)
+
 struct hns_roce_uar {
 	u64		pfn;
 	unsigned long	index;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 4accc9efa694..3cd65bcca224 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -2598,14 +2598,16 @@ static int set_llm_cfg_to_hw(struct hns_roce_dev *hr_dev,
 static struct hns_roce_link_table *
 alloc_link_table_buf(struct hns_roce_dev *hr_dev)
 {
+	u16 total_sl = hr_dev->caps.sl_num * hr_dev->func_num;
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	struct hns_roce_link_table *link_tbl;
 	u32 pg_shift, size, min_size;
 
 	link_tbl = &priv->ext_llm;
 	pg_shift = hr_dev->caps.llm_buf_pg_sz + PAGE_SHIFT;
-	size = hr_dev->caps.num_qps * HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
-	min_size = HNS_ROCE_EXT_LLM_MIN_PAGES(hr_dev->caps.sl_num) << pg_shift;
+	size = hr_dev->caps.num_qps * hr_dev->func_num *
+	       HNS_ROCE_V2_EXT_LLM_ENTRY_SZ;
+	min_size = HNS_ROCE_EXT_LLM_MIN_PAGES(total_sl) << pg_shift;
 
 	/* Alloc data table */
 	size = max(size, min_size);
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index 7106e51d5fad..938db3f5aabe 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -446,6 +446,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
 	struct hns_roce_mtr *mtr = &mr->pbl_mtr;
 	int ret, sg_num = 0;
 
+	if (!IS_ALIGNED(*sg_offset, HNS_ROCE_FRMR_ALIGN_SIZE) ||
+	    ibmr->page_size < HNS_HW_PAGE_SIZE ||
+	    ibmr->page_size > HNS_HW_MAX_PAGE_SIZE)
+		return sg_num;
+
 	mr->npages = 0;
 	mr->page_list = kvcalloc(mr->pbl_mtr.hem_cfg.buf_pg_count,
 				 sizeof(dma_addr_t), GFP_KERNEL);
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index 35001fb99b94..873069d6ebae 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -295,7 +295,7 @@ static int set_srq_basic_param(struct hns_roce_srq *srq,
 
 	max_sge = proc_srq_sge(hr_dev, srq, !!udata);
 	if (attr->max_wr > hr_dev->caps.max_srq_wrs ||
-	    attr->max_sge > max_sge) {
+	    attr->max_sge > max_sge || !attr->max_sge) {
 		ibdev_err(&hr_dev->ib_dev,
 			  "invalid SRQ attr, depth = %u, sge = %u.\n",
 			  attr->max_wr, attr->max_sge);
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 571d9c542024..6b8ad5859014 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -832,7 +832,7 @@ void mlx4_ib_destroy_alias_guid_service(struct mlx4_ib_dev *dev)
 
 int mlx4_ib_init_alias_guid_service(struct mlx4_ib_dev *dev)
 {
-	char alias_wq_name[15];
+	char alias_wq_name[22];
 	int ret = 0;
 	int i, j;
 	union ib_gid gid;
diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index d13ecbdd4391..3d29d5baf503 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -2158,7 +2158,7 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 				       struct mlx4_ib_demux_ctx *ctx,
 				       int port)
 {
-	char name[12];
+	char name[21];
 	int ret = 0;
 	int i;
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index bf20a388eabe..08c59c5a1e10 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -109,6 +109,19 @@ unsigned long __mlx5_umem_find_best_quantized_pgoff(
 		__mlx5_bit_sz(typ, page_offset_fld), 0, scale,                 \
 		page_offset_quantized)
 
+static inline unsigned long
+mlx5_umem_dmabuf_find_best_pgsz(struct ib_umem_dmabuf *umem_dmabuf)
+{
+	/*
+	 * mkeys used for dmabuf are fixed at PAGE_SIZE because we must be able
+	 * to hold any sgl after a move operation. Ideally the mkc page size
+	 * could be changed at runtime to be optimal, but right now the driver
+	 * cannot do that.
+	 */
+	return ib_umem_find_best_pgsz(&umem_dmabuf->umem, PAGE_SIZE,
+				      umem_dmabuf->umem.iova);
+}
+
 enum {
 	MLX5_IB_MMAP_OFFSET_START = 9,
 	MLX5_IB_MMAP_OFFSET_END = 255,
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index fcf6447b4a4e..66e53e895d34 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -704,10 +704,8 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 		return err;
 	}
 
-	page_size = mlx5_umem_find_best_pgsz(&umem_dmabuf->umem, mkc,
-					     log_page_size, 0,
-					     umem_dmabuf->umem.iova);
-	if (unlikely(page_size < PAGE_SIZE)) {
+	page_size = mlx5_umem_dmabuf_find_best_pgsz(umem_dmabuf);
+	if (!page_size) {
 		ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 		err = -EINVAL;
 	} else {
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 8c0e7ecd4141..093808419207 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -374,7 +374,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	int			solicited;
 	u16			pkey;
 	u32			qp_num;
-	int			ack_req;
+	int			ack_req = 0;
 
 	/* length from start of bth to end of icrc */
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
@@ -407,8 +407,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	qp_num = (pkt->mask & RXE_DETH_MASK) ? ibwr->wr.ud.remote_qpn :
 					 qp->attr.dest_qp_num;
 
-	ack_req = ((pkt->mask & RXE_END_MASK) ||
-		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
+	if (qp_type(qp) != IB_QPT_UD && qp_type(qp) != IB_QPT_UC)
+		ack_req = ((pkt->mask & RXE_END_MASK) ||
+			   (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
 	if (ack_req)
 		qp->req.noack_pkts = 0;
 
diff --git a/drivers/input/keyboard/qt1050.c b/drivers/input/keyboard/qt1050.c
index 403060d05c3b..7193a4198e21 100644
--- a/drivers/input/keyboard/qt1050.c
+++ b/drivers/input/keyboard/qt1050.c
@@ -226,7 +226,12 @@ static bool qt1050_identify(struct qt1050_priv *ts)
 	int err;
 
 	/* Read Chip ID */
-	regmap_read(ts->regmap, QT1050_CHIP_ID, &val);
+	err = regmap_read(ts->regmap, QT1050_CHIP_ID, &val);
+	if (err) {
+		dev_err(&ts->client->dev, "Failed to read chip ID: %d\n", err);
+		return false;
+	}
+
 	if (val != QT1050_CHIP_ID_VER) {
 		dev_err(&ts->client->dev, "ID %d not supported\n", val);
 		return false;
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index e1758d5ffe42..a5f067b93ab9 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1378,6 +1378,8 @@ static int __maybe_unused elan_suspend(struct device *dev)
 	}
 
 err:
+	if (ret)
+		enable_irq(client->irq);
 	mutex_unlock(&data->sysfs_mutex);
 	return ret;
 }
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 6b11770e3d75..f9392dbe6511 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -234,8 +234,8 @@ static void sprd_iommu_cleanup(struct sprd_iommu_domain *dom)
 
 	pgt_size = sprd_iommu_pgt_size(&dom->domain);
 	dma_free_coherent(dom->sdev->dev, pgt_size, dom->pgt_va, dom->pgt_pa);
-	dom->sdev = NULL;
 	sprd_iommu_hw_en(dom->sdev, false);
+	dom->sdev = NULL;
 }
 
 static void sprd_iommu_domain_free(struct iommu_domain *domain)
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 8d91a02593fc..44ce85c27f57 100644
--- a/drivers/irqchip/irq-imx-irqsteer.c
+++ b/drivers/irqchip/irq-imx-irqsteer.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 
 #define CTRL_STRIDE_OFF(_t, _r)	(_t * 4 * _r)
@@ -34,6 +35,7 @@ struct irqsteer_data {
 	int			channel;
 	struct irq_domain	*domain;
 	u32			*saved_reg;
+	struct device		*dev;
 };
 
 static int imx_irqsteer_get_reg_index(struct irqsteer_data *data,
@@ -70,10 +72,26 @@ static void imx_irqsteer_irq_mask(struct irq_data *d)
 	raw_spin_unlock_irqrestore(&data->lock, flags);
 }
 
-static struct irq_chip imx_irqsteer_irq_chip = {
-	.name		= "irqsteer",
-	.irq_mask	= imx_irqsteer_irq_mask,
-	.irq_unmask	= imx_irqsteer_irq_unmask,
+static void imx_irqsteer_irq_bus_lock(struct irq_data *d)
+{
+	struct irqsteer_data *data = d->chip_data;
+
+	pm_runtime_get_sync(data->dev);
+}
+
+static void imx_irqsteer_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct irqsteer_data *data = d->chip_data;
+
+	pm_runtime_put_autosuspend(data->dev);
+}
+
+static const struct irq_chip imx_irqsteer_irq_chip = {
+	.name			= "irqsteer",
+	.irq_mask		= imx_irqsteer_irq_mask,
+	.irq_unmask		= imx_irqsteer_irq_unmask,
+	.irq_bus_lock		= imx_irqsteer_irq_bus_lock,
+	.irq_bus_sync_unlock	= imx_irqsteer_irq_bus_sync_unlock,
 };
 
 static int imx_irqsteer_irq_map(struct irq_domain *h, unsigned int irq,
@@ -148,6 +166,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->dev = &pdev->dev;
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize reg\n");
@@ -175,7 +194,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	data->irq_count = DIV_ROUND_UP(irqs_num, 64);
 	data->reg_num = irqs_num / 32;
 
-	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+	if (IS_ENABLED(CONFIG_PM)) {
 		data->saved_reg = devm_kzalloc(&pdev->dev,
 					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
@@ -199,6 +218,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto out;
 	}
+	irq_domain_set_pm_device(data->domain, &pdev->dev);
 
 	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
 		ret = -EINVAL;
@@ -219,6 +239,9 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 out:
 	clk_disable_unprepare(data->ipg_clk);
@@ -241,7 +264,7 @@ static int imx_irqsteer_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 static void imx_irqsteer_save_regs(struct irqsteer_data *data)
 {
 	int i;
@@ -288,7 +311,10 @@ static int imx_irqsteer_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops imx_irqsteer_pm_ops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_irqsteer_suspend, imx_irqsteer_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				      pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(imx_irqsteer_suspend,
+			   imx_irqsteer_resume, NULL)
 };
 
 static const struct of_device_id imx_irqsteer_dt_ids[] = {
diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index 12df2162108e..e6f824a2ee51 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -64,6 +64,20 @@ struct mbigen_device {
 	void __iomem		*base;
 };
 
+static inline unsigned int get_mbigen_node_offset(unsigned int nid)
+{
+	unsigned int offset = nid * MBIGEN_NODE_OFFSET;
+
+	/*
+	 * To avoid touched clear register in unexpected way, we need to directly
+	 * skip clear register when access to more than 10 mbigen nodes.
+	 */
+	if (nid >= (REG_MBIGEN_CLEAR_OFFSET / MBIGEN_NODE_OFFSET))
+		offset += MBIGEN_NODE_OFFSET;
+
+	return offset;
+}
+
 static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 {
 	unsigned int nid, pin;
@@ -72,8 +86,7 @@ static inline unsigned int get_mbigen_vec_reg(irq_hw_number_t hwirq)
 	nid = hwirq / IRQS_PER_MBIGEN_NODE + 1;
 	pin = hwirq % IRQS_PER_MBIGEN_NODE;
 
-	return pin * 4 + nid * MBIGEN_NODE_OFFSET
-			+ REG_MBIGEN_VEC_OFFSET;
+	return pin * 4 + get_mbigen_node_offset(nid) + REG_MBIGEN_VEC_OFFSET;
 }
 
 static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
@@ -88,8 +101,7 @@ static inline void get_mbigen_type_reg(irq_hw_number_t hwirq,
 	*mask = 1 << (irq_ofst % 32);
 	ofst = irq_ofst / 32 * 4;
 
-	*addr = ofst + nid * MBIGEN_NODE_OFFSET
-		+ REG_MBIGEN_TYPE_OFFSET;
+	*addr = ofst + get_mbigen_node_offset(nid) + REG_MBIGEN_TYPE_OFFSET;
 }
 
 static inline void get_mbigen_clear_reg(irq_hw_number_t hwirq,
diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
index e50676ce2ec8..6a3d18d5ba2f 100644
--- a/drivers/irqchip/irq-meson-gpio.c
+++ b/drivers/irqchip/irq-meson-gpio.c
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#define NUM_CHANNEL 8
+#define MAX_NUM_CHANNEL 64
 #define MAX_INPUT_MUX 256
 
 #define REG_EDGE_POL	0x00
@@ -60,6 +60,7 @@ struct irq_ctl_ops {
 
 struct meson_gpio_irq_params {
 	unsigned int nr_hwirq;
+	unsigned int nr_channels;
 	bool support_edge_both;
 	unsigned int edge_both_offset;
 	unsigned int edge_single_offset;
@@ -81,6 +82,7 @@ struct meson_gpio_irq_params {
 	.edge_single_offset = 0,				\
 	.pol_low_offset = 16,					\
 	.pin_sel_mask = 0xff,					\
+	.nr_channels = 8,					\
 
 #define INIT_MESON_A1_COMMON_DATA(irqs)				\
 	INIT_MESON_COMMON(irqs, meson_a1_gpio_irq_init,		\
@@ -90,6 +92,7 @@ struct meson_gpio_irq_params {
 	.edge_single_offset = 8,				\
 	.pol_low_offset = 0,					\
 	.pin_sel_mask = 0x7f,					\
+	.nr_channels = 8,					\
 
 static const struct meson_gpio_irq_params meson8_params = {
 	INIT_MESON8_COMMON_DATA(134)
@@ -136,9 +139,9 @@ static const struct of_device_id meson_irq_gpio_matches[] = {
 struct meson_gpio_irq_controller {
 	const struct meson_gpio_irq_params *params;
 	void __iomem *base;
-	u32 channel_irqs[NUM_CHANNEL];
-	DECLARE_BITMAP(channel_map, NUM_CHANNEL);
-	spinlock_t lock;
+	u32 channel_irqs[MAX_NUM_CHANNEL];
+	DECLARE_BITMAP(channel_map, MAX_NUM_CHANNEL);
+	raw_spinlock_t lock;
 };
 
 static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
@@ -147,14 +150,14 @@ static void meson_gpio_irq_update_bits(struct meson_gpio_irq_controller *ctl,
 	unsigned long flags;
 	u32 tmp;
 
-	spin_lock_irqsave(&ctl->lock, flags);
+	raw_spin_lock_irqsave(&ctl->lock, flags);
 
 	tmp = readl_relaxed(ctl->base + reg);
 	tmp &= ~mask;
 	tmp |= val;
 	writel_relaxed(tmp, ctl->base + reg);
 
-	spin_unlock_irqrestore(&ctl->lock, flags);
+	raw_spin_unlock_irqrestore(&ctl->lock, flags);
 }
 
 static void meson_gpio_irq_init_dummy(struct meson_gpio_irq_controller *ctl)
@@ -204,12 +207,12 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	unsigned long flags;
 	unsigned int idx;
 
-	spin_lock_irqsave(&ctl->lock, flags);
+	raw_spin_lock_irqsave(&ctl->lock, flags);
 
 	/* Find a free channel */
-	idx = find_first_zero_bit(ctl->channel_map, NUM_CHANNEL);
-	if (idx >= NUM_CHANNEL) {
-		spin_unlock_irqrestore(&ctl->lock, flags);
+	idx = find_first_zero_bit(ctl->channel_map, ctl->params->nr_channels);
+	if (idx >= ctl->params->nr_channels) {
+		raw_spin_unlock_irqrestore(&ctl->lock, flags);
 		pr_err("No channel available\n");
 		return -ENOSPC;
 	}
@@ -217,7 +220,7 @@ meson_gpio_irq_request_channel(struct meson_gpio_irq_controller *ctl,
 	/* Mark the channel as used */
 	set_bit(idx, ctl->channel_map);
 
-	spin_unlock_irqrestore(&ctl->lock, flags);
+	raw_spin_unlock_irqrestore(&ctl->lock, flags);
 
 	/*
 	 * Setup the mux of the channel to route the signal of the pad
@@ -451,10 +454,10 @@ static int __init meson_gpio_irq_parse_dt(struct device_node *node,
 	ret = of_property_read_variable_u32_array(node,
 						  "amlogic,channel-interrupts",
 						  ctl->channel_irqs,
-						  NUM_CHANNEL,
-						  NUM_CHANNEL);
+						  ctl->params->nr_channels,
+						  ctl->params->nr_channels);
 	if (ret < 0) {
-		pr_err("can't get %d channel interrupts\n", NUM_CHANNEL);
+		pr_err("can't get %d channel interrupts\n", ctl->params->nr_channels);
 		return ret;
 	}
 
@@ -485,7 +488,7 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
 	if (!ctl)
 		return -ENOMEM;
 
-	spin_lock_init(&ctl->lock);
+	raw_spin_lock_init(&ctl->lock);
 
 	ctl->base = of_iomap(node, 0);
 	if (!ctl->base) {
@@ -509,7 +512,7 @@ static int __init meson_gpio_irq_of_init(struct device_node *node,
 	}
 
 	pr_info("%d to %d gpio interrupt mux initialized\n",
-		ctl->params->nr_hwirq, NUM_CHANNEL);
+		ctl->params->nr_hwirq, ctl->params->nr_channels);
 
 	return 0;
 
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 356a59755d63..d8c3f5a60e52 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -188,7 +188,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		irqc->intr_mask = 0;
 	}
 
-	if (irqc->intr_mask >> irqc->nr_irq)
+	if ((u64)irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",
diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index e840609c50eb..2063afffd085 100644
--- a/drivers/isdn/hardware/mISDN/hfcmulti.c
+++ b/drivers/isdn/hardware/mISDN/hfcmulti.c
@@ -1931,7 +1931,7 @@ hfcmulti_dtmf(struct hfc_multi *hc)
 static void
 hfcmulti_tx(struct hfc_multi *hc, int ch)
 {
-	int i, ii, temp, len = 0;
+	int i, ii, temp, tmp_len, len = 0;
 	int Zspace, z1, z2; /* must be int for calculation */
 	int Fspace, f1, f2;
 	u_char *d;
@@ -2152,14 +2152,15 @@ hfcmulti_tx(struct hfc_multi *hc, int ch)
 		HFC_wait_nodebug(hc);
 	}
 
+	tmp_len = (*sp)->len;
 	dev_kfree_skb(*sp);
 	/* check for next frame */
 	if (bch && get_next_bframe(bch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 	if (dch && get_next_dframe(dch)) {
-		len = (*sp)->len;
+		len = tmp_len;
 		goto next_frame;
 	}
 
diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 1024b1562aaf..6e88df4c87fa 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -235,7 +235,6 @@ struct led_classdev *of_led_get(struct device_node *np, int index)
 
 	led_dev = class_find_device_by_of_node(leds_class, led_node);
 	of_node_put(led_node);
-	put_device(led_dev);
 
 	if (!led_dev)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 4e7b78a84149..3d3673c197e3 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -157,7 +157,6 @@ EXPORT_SYMBOL_GPL(led_trigger_read);
 /* Caller must ensure led_cdev->trigger_lock held */
 int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 {
-	unsigned long flags;
 	char *event = NULL;
 	char *envp[2];
 	const char *name;
@@ -171,31 +170,47 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 
 	/* Remove any existing trigger */
 	if (led_cdev->trigger) {
-		write_lock_irqsave(&led_cdev->trigger->leddev_list_lock, flags);
-		list_del(&led_cdev->trig_list);
-		write_unlock_irqrestore(&led_cdev->trigger->leddev_list_lock,
-			flags);
+		spin_lock(&led_cdev->trigger->leddev_list_lock);
+		list_del_rcu(&led_cdev->trig_list);
+		spin_unlock(&led_cdev->trigger->leddev_list_lock);
+
+		/* ensure it's no longer visible on the led_cdevs list */
+		synchronize_rcu();
+
 		cancel_work_sync(&led_cdev->set_brightness_work);
 		led_stop_software_blink(led_cdev);
+		device_remove_groups(led_cdev->dev, led_cdev->trigger->groups);
 		if (led_cdev->trigger->deactivate)
 			led_cdev->trigger->deactivate(led_cdev);
-		device_remove_groups(led_cdev->dev, led_cdev->trigger->groups);
 		led_cdev->trigger = NULL;
 		led_cdev->trigger_data = NULL;
 		led_cdev->activated = false;
 		led_set_brightness(led_cdev, LED_OFF);
 	}
 	if (trig) {
-		write_lock_irqsave(&trig->leddev_list_lock, flags);
-		list_add_tail(&led_cdev->trig_list, &trig->led_cdevs);
-		write_unlock_irqrestore(&trig->leddev_list_lock, flags);
+		spin_lock(&trig->leddev_list_lock);
+		list_add_tail_rcu(&led_cdev->trig_list, &trig->led_cdevs);
+		spin_unlock(&trig->leddev_list_lock);
 		led_cdev->trigger = trig;
 
+		/*
+		 * Some activate() calls use led_trigger_event() to initialize
+		 * the brightness of the LED for which the trigger is being set.
+		 * Ensure the led_cdev is visible on trig->led_cdevs for this.
+		 */
+		synchronize_rcu();
+
+		/*
+		 * If "set brightness to 0" is pending in workqueue,
+		 * we don't want that to be reordered after ->activate()
+		 */
+		flush_work(&led_cdev->set_brightness_work);
+
+		ret = 0;
 		if (trig->activate)
 			ret = trig->activate(led_cdev);
 		else
-			ret = 0;
-
+			led_set_brightness(led_cdev, trig->brightness);
 		if (ret)
 			goto err_activate;
 
@@ -223,9 +238,10 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 		trig->deactivate(led_cdev);
 err_activate:
 
-	write_lock_irqsave(&led_cdev->trigger->leddev_list_lock, flags);
-	list_del(&led_cdev->trig_list);
-	write_unlock_irqrestore(&led_cdev->trigger->leddev_list_lock, flags);
+	spin_lock(&led_cdev->trigger->leddev_list_lock);
+	list_del_rcu(&led_cdev->trig_list);
+	spin_unlock(&led_cdev->trigger->leddev_list_lock);
+	synchronize_rcu();
 	led_cdev->trigger = NULL;
 	led_cdev->trigger_data = NULL;
 	led_set_brightness(led_cdev, LED_OFF);
@@ -265,19 +281,6 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 }
 EXPORT_SYMBOL_GPL(led_trigger_set_default);
 
-void led_trigger_rename_static(const char *name, struct led_trigger *trig)
-{
-	/* new name must be on a temporary string to prevent races */
-	BUG_ON(name == trig->name);
-
-	down_write(&triggers_list_lock);
-	/* this assumes that trig->name was originaly allocated to
-	 * non constant storage */
-	strcpy((char *)trig->name, name);
-	up_write(&triggers_list_lock);
-}
-EXPORT_SYMBOL_GPL(led_trigger_rename_static);
-
 /* LED Trigger Interface */
 
 int led_trigger_register(struct led_trigger *trig)
@@ -285,7 +288,7 @@ int led_trigger_register(struct led_trigger *trig)
 	struct led_classdev *led_cdev;
 	struct led_trigger *_trig;
 
-	rwlock_init(&trig->leddev_list_lock);
+	spin_lock_init(&trig->leddev_list_lock);
 	INIT_LIST_HEAD(&trig->led_cdevs);
 
 	down_write(&triggers_list_lock);
@@ -378,15 +381,16 @@ void led_trigger_event(struct led_trigger *trig,
 			enum led_brightness brightness)
 {
 	struct led_classdev *led_cdev;
-	unsigned long flags;
 
 	if (!trig)
 		return;
 
-	read_lock_irqsave(&trig->leddev_list_lock, flags);
-	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list)
+	trig->brightness = brightness;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(led_cdev, &trig->led_cdevs, trig_list)
 		led_set_brightness(led_cdev, brightness);
-	read_unlock_irqrestore(&trig->leddev_list_lock, flags);
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(led_trigger_event);
 
@@ -397,20 +401,19 @@ static void led_trigger_blink_setup(struct led_trigger *trig,
 			     int invert)
 {
 	struct led_classdev *led_cdev;
-	unsigned long flags;
 
 	if (!trig)
 		return;
 
-	read_lock_irqsave(&trig->leddev_list_lock, flags);
-	list_for_each_entry(led_cdev, &trig->led_cdevs, trig_list) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(led_cdev, &trig->led_cdevs, trig_list) {
 		if (oneshot)
 			led_blink_set_oneshot(led_cdev, delay_on, delay_off,
 					      invert);
 		else
 			led_blink_set(led_cdev, delay_on, delay_off);
 	}
-	read_unlock_irqrestore(&trig->leddev_list_lock, flags);
+	rcu_read_unlock();
 }
 
 void led_trigger_blink(struct led_trigger *trig,
diff --git a/drivers/leds/leds-ss4200.c b/drivers/leds/leds-ss4200.c
index fcaa34706b6c..2ef9fc7371bd 100644
--- a/drivers/leds/leds-ss4200.c
+++ b/drivers/leds/leds-ss4200.c
@@ -356,8 +356,10 @@ static int ich7_lpc_probe(struct pci_dev *dev,
 
 	nas_gpio_pci_dev = dev;
 	status = pci_read_config_dword(dev, PMBASE, &g_pm_io_base);
-	if (status)
+	if (status) {
+		status = pcibios_err_to_errno(status);
 		goto out;
+	}
 	g_pm_io_base &= 0x00000ff80;
 
 	status = pci_read_config_dword(dev, GPIO_CTRL, &gc);
@@ -369,8 +371,9 @@ static int ich7_lpc_probe(struct pci_dev *dev,
 	}
 
 	status = pci_read_config_dword(dev, GPIO_BASE, &nas_gpio_io_base);
-	if (0 > status) {
+	if (status) {
 		dev_info(&dev->dev, "Unable to read GPIOBASE.\n");
+		status = pcibios_err_to_errno(status);
 		goto out;
 	}
 	dev_dbg(&dev->dev, ": GPIOBASE = 0x%08x\n", nas_gpio_io_base);
diff --git a/drivers/leds/trigger/ledtrig-timer.c b/drivers/leds/trigger/ledtrig-timer.c
index b4688d1d9d2b..1d213c999d40 100644
--- a/drivers/leds/trigger/ledtrig-timer.c
+++ b/drivers/leds/trigger/ledtrig-timer.c
@@ -110,11 +110,6 @@ static int timer_trig_activate(struct led_classdev *led_cdev)
 		led_cdev->flags &= ~LED_INIT_DEFAULT_TRIGGER;
 	}
 
-	/*
-	 * If "set brightness to 0" is pending in workqueue, we don't
-	 * want that to be reordered after blink_set()
-	 */
-	flush_work(&led_cdev->set_brightness_work);
 	led_blink_set(led_cdev, &led_cdev->blink_delay_on,
 		      &led_cdev->blink_delay_off);
 
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index f55f6adf5e5f..49805eb4d145 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -549,7 +549,7 @@ g4fan_exit( void )
 	platform_driver_unregister( &therm_of_driver );
 
 	if( x.of_dev )
-		of_device_unregister( x.of_dev );
+		of_platform_device_destroy(&x.of_dev->dev, NULL);
 }
 
 module_init(g4fan_init);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 45ef1ddd2bd0..5b6c366587d5 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -509,7 +509,6 @@ void mddev_suspend(struct mddev *mddev)
 	clear_bit_unlock(MD_ALLOW_SB_UPDATE, &mddev->flags);
 	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
 
-	del_timer_sync(&mddev->safemode_timer);
 	/* restrict memory reclaim I/O during raid array is suspend */
 	mddev->noio_flag = memalloc_noio_save();
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index bcd43cca94f9..87b713142e15 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6007,7 +6007,9 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	safepos = conf->reshape_safe;
 	sector_div(safepos, data_disks);
 	if (mddev->reshape_backwards) {
-		BUG_ON(writepos < reshape_sectors);
+		if (WARN_ON(writepos < reshape_sectors))
+			return MaxSector;
+
 		writepos -= reshape_sectors;
 		readpos += reshape_sectors;
 		safepos += reshape_sectors;
@@ -6025,14 +6027,18 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 	 * to set 'stripe_addr' which is where we will write to.
 	 */
 	if (mddev->reshape_backwards) {
-		BUG_ON(conf->reshape_progress == 0);
+		if (WARN_ON(conf->reshape_progress == 0))
+			return MaxSector;
+
 		stripe_addr = writepos;
-		BUG_ON((mddev->dev_sectors &
-			~((sector_t)reshape_sectors - 1))
-		       - reshape_sectors - stripe_addr
-		       != sector_nr);
+		if (WARN_ON((mddev->dev_sectors &
+		    ~((sector_t)reshape_sectors - 1)) -
+		    reshape_sectors - stripe_addr != sector_nr))
+			return MaxSector;
 	} else {
-		BUG_ON(writepos != sector_nr + reshape_sectors);
+		if (WARN_ON(writepos != sector_nr + reshape_sectors))
+			return MaxSector;
+
 		stripe_addr = sector_nr;
 	}
 
diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
index 84279a680873..3d4d81392391 100644
--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -535,14 +535,13 @@ static int imx412_update_controls(struct imx412 *imx412,
  */
 static int imx412_update_exp_gain(struct imx412 *imx412, u32 exposure, u32 gain)
 {
-	u32 lpfr, shutter;
+	u32 lpfr;
 	int ret;
 
 	lpfr = imx412->vblank + imx412->cur_mode->height;
-	shutter = lpfr - exposure;
 
-	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, shutter %u, lpfr %u",
-		exposure, gain, shutter, lpfr);
+	dev_dbg(imx412->dev, "Set exp %u, analog gain %u, lpfr %u",
+		exposure, gain, lpfr);
 
 	ret = imx412_write_reg(imx412, IMX412_REG_HOLD, 1, 1);
 	if (ret)
@@ -552,7 +551,7 @@ static int imx412_update_exp_gain(struct imx412 *imx412, u32 exposure, u32 gain)
 	if (ret)
 		goto error_release_group_hold;
 
-	ret = imx412_write_reg(imx412, IMX412_REG_EXPOSURE_CIT, 2, shutter);
+	ret = imx412_write_reg(imx412, IMX412_REG_EXPOSURE_CIT, 2, exposure);
 	if (ret)
 		goto error_release_group_hold;
 
diff --git a/drivers/media/pci/saa7134/saa7134-dvb.c b/drivers/media/pci/saa7134/saa7134-dvb.c
index f359cd5c006a..c786b83a69d2 100644
--- a/drivers/media/pci/saa7134/saa7134-dvb.c
+++ b/drivers/media/pci/saa7134/saa7134-dvb.c
@@ -466,7 +466,9 @@ static int philips_europa_tuner_sleep(struct dvb_frontend *fe)
 	/* switch the board to analog mode */
 	if (fe->ops.i2c_gate_ctrl)
 		fe->ops.i2c_gate_ctrl(fe, 1);
-	i2c_transfer(&dev->i2c_adap, &analog_msg, 1);
+	if (i2c_transfer(&dev->i2c_adap, &analog_msg, 1) != 1)
+		return -EIO;
+
 	return 0;
 }
 
@@ -1018,7 +1020,9 @@ static int md8800_set_voltage2(struct dvb_frontend *fe,
 	else
 		wbuf[1] = rbuf & 0xef;
 	msg[0].len = 2;
-	i2c_transfer(&dev->i2c_adap, msg, 1);
+	if (i2c_transfer(&dev->i2c_adap, msg, 1) != 1)
+		return -EIO;
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 6e0466772339..42134cde120d 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1165,7 +1165,7 @@ static int vdec_stop_output(struct venus_inst *inst)
 		break;
 	case VENUS_DEC_STATE_INIT:
 	case VENUS_DEC_STATE_CAPTURE_SETUP:
-		ret = hfi_session_flush(inst, HFI_FLUSH_INPUT, true);
+		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
 		break;
 	default:
 		break;
@@ -1632,6 +1632,7 @@ static int vdec_close(struct file *file)
 
 	vdec_pm_get(inst);
 
+	cancel_work_sync(&inst->delayed_process_work);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	vdec_ctrl_deinit(inst);
diff --git a/drivers/media/platform/vsp1/vsp1_histo.c b/drivers/media/platform/vsp1/vsp1_histo.c
index 5e5013d2cd2a..897dfe99323a 100644
--- a/drivers/media/platform/vsp1/vsp1_histo.c
+++ b/drivers/media/platform/vsp1/vsp1_histo.c
@@ -36,9 +36,8 @@ struct vsp1_histogram_buffer *
 vsp1_histogram_buffer_get(struct vsp1_histogram *histo)
 {
 	struct vsp1_histogram_buffer *buf = NULL;
-	unsigned long flags;
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock(&histo->irqlock);
 
 	if (list_empty(&histo->irqqueue))
 		goto done;
@@ -49,7 +48,7 @@ vsp1_histogram_buffer_get(struct vsp1_histogram *histo)
 	histo->readout = true;
 
 done:
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock(&histo->irqlock);
 	return buf;
 }
 
@@ -58,7 +57,6 @@ void vsp1_histogram_buffer_complete(struct vsp1_histogram *histo,
 				    size_t size)
 {
 	struct vsp1_pipeline *pipe = histo->entity.pipe;
-	unsigned long flags;
 
 	/*
 	 * The pipeline pointer is guaranteed to be valid as this function is
@@ -70,10 +68,10 @@ void vsp1_histogram_buffer_complete(struct vsp1_histogram *histo,
 	vb2_set_plane_payload(&buf->buf.vb2_buf, 0, size);
 	vb2_buffer_done(&buf->buf.vb2_buf, VB2_BUF_STATE_DONE);
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock(&histo->irqlock);
 	histo->readout = false;
 	wake_up(&histo->wait_queue);
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock(&histo->irqlock);
 }
 
 /* -----------------------------------------------------------------------------
@@ -124,11 +122,10 @@ static void histo_buffer_queue(struct vb2_buffer *vb)
 	struct vb2_v4l2_buffer *vbuf = to_vb2_v4l2_buffer(vb);
 	struct vsp1_histogram *histo = vb2_get_drv_priv(vb->vb2_queue);
 	struct vsp1_histogram_buffer *buf = to_vsp1_histogram_buffer(vbuf);
-	unsigned long flags;
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock_irq(&histo->irqlock);
 	list_add_tail(&buf->queue, &histo->irqqueue);
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock_irq(&histo->irqlock);
 }
 
 static int histo_start_streaming(struct vb2_queue *vq, unsigned int count)
@@ -140,9 +137,8 @@ static void histo_stop_streaming(struct vb2_queue *vq)
 {
 	struct vsp1_histogram *histo = vb2_get_drv_priv(vq);
 	struct vsp1_histogram_buffer *buffer;
-	unsigned long flags;
 
-	spin_lock_irqsave(&histo->irqlock, flags);
+	spin_lock_irq(&histo->irqlock);
 
 	/* Remove all buffers from the IRQ queue. */
 	list_for_each_entry(buffer, &histo->irqqueue, queue)
@@ -152,7 +148,7 @@ static void histo_stop_streaming(struct vb2_queue *vq)
 	/* Wait for the buffer being read out (if any) to complete. */
 	wait_event_lock_irq(histo->wait_queue, !histo->readout, histo->irqlock);
 
-	spin_unlock_irqrestore(&histo->irqlock, flags);
+	spin_unlock_irq(&histo->irqlock);
 }
 
 static const struct vb2_ops histo_video_queue_qops = {
diff --git a/drivers/media/platform/vsp1/vsp1_pipe.h b/drivers/media/platform/vsp1/vsp1_pipe.h
index ae646c9ef337..15daf35bda21 100644
--- a/drivers/media/platform/vsp1/vsp1_pipe.h
+++ b/drivers/media/platform/vsp1/vsp1_pipe.h
@@ -73,7 +73,7 @@ struct vsp1_partition_window {
  * @wpf: The WPF partition window configuration
  */
 struct vsp1_partition {
-	struct vsp1_partition_window rpf;
+	struct vsp1_partition_window rpf[VSP1_MAX_RPF];
 	struct vsp1_partition_window uds_sink;
 	struct vsp1_partition_window uds_source;
 	struct vsp1_partition_window sru;
diff --git a/drivers/media/platform/vsp1/vsp1_rpf.c b/drivers/media/platform/vsp1/vsp1_rpf.c
index 75083cb234fe..996a3058d5b7 100644
--- a/drivers/media/platform/vsp1/vsp1_rpf.c
+++ b/drivers/media/platform/vsp1/vsp1_rpf.c
@@ -271,8 +271,8 @@ static void rpf_configure_partition(struct vsp1_entity *entity,
 	 * 'width' need to be adjusted.
 	 */
 	if (pipe->partitions > 1) {
-		crop.width = pipe->partition->rpf.width;
-		crop.left += pipe->partition->rpf.left;
+		crop.width = pipe->partition->rpf[rpf->entity.index].width;
+		crop.left += pipe->partition->rpf[rpf->entity.index].left;
 	}
 
 	if (pipe->interlaced) {
@@ -327,7 +327,9 @@ static void rpf_partition(struct vsp1_entity *entity,
 			  unsigned int partition_idx,
 			  struct vsp1_partition_window *window)
 {
-	partition->rpf = *window;
+	struct vsp1_rwpf *rpf = to_rwpf(&entity->subdev);
+
+	partition->rpf[rpf->entity.index] = *window;
 }
 
 static const struct vsp1_entity_operations rpf_entity_ops = {
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 4e7c3d889d5c..9faf8365afa7 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1150,10 +1150,7 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 
 	memcpy(ictx->usb_tx_buf, &ir_proto_packet, sizeof(ir_proto_packet));
 
-	if (!mutex_is_locked(&ictx->lock)) {
-		unlock = true;
-		mutex_lock(&ictx->lock);
-	}
+	unlock = mutex_trylock(&ictx->lock);
 
 	retval = send_packet(ictx);
 	if (retval)
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index d73f02b0db84..54f4a7cd88f4 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -841,8 +841,10 @@ struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (write && !(f.file->f_mode & FMODE_WRITE))
+	if (write && !(f.file->f_mode & FMODE_WRITE)) {
+		fdput(f);
 		return ERR_PTR(-EPERM);
+	}
 
 	fh = f.file->private_data;
 	dev = fh->rc;
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 05335866e6d6..050d33426582 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1868,7 +1868,13 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	else
 		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
 				     dev->intfnum, info->selector, data, 1);
-	if (!ret)
+
+	if (!ret) {
+		info->flags &= ~(UVC_CTRL_FLAG_GET_CUR |
+				 UVC_CTRL_FLAG_SET_CUR |
+				 UVC_CTRL_FLAG_AUTO_UPDATE |
+				 UVC_CTRL_FLAG_ASYNCHRONOUS);
+
 		info->flags |= (data[0] & UVC_CONTROL_CAP_GET ?
 				UVC_CTRL_FLAG_GET_CUR : 0)
 			    |  (data[0] & UVC_CONTROL_CAP_SET ?
@@ -1877,6 +1883,7 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 				UVC_CTRL_FLAG_AUTO_UPDATE : 0)
 			    |  (data[0] & UVC_CONTROL_CAP_ASYNCHRONOUS ?
 				UVC_CTRL_FLAG_ASYNCHRONOUS : 0);
+	}
 
 	kfree(data);
 	return ret;
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index f477cfbbb905..446fe67e07c4 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -210,13 +210,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
 		/* Compute a bandwidth estimation by multiplying the frame
 		 * size by the number of video frames per second, divide the
 		 * result by the number of USB frames (or micro-frames for
-		 * high-speed devices) per second and add the UVC header size
-		 * (assumed to be 12 bytes long).
+		 * high- and super-speed devices) per second and add the UVC
+		 * header size (assumed to be 12 bytes long).
 		 */
 		bandwidth = frame->wWidth * frame->wHeight / 8 * format->bpp;
 		bandwidth *= 10000000 / interval + 1;
 		bandwidth /= 1000;
-		if (stream->dev->udev->speed == USB_SPEED_HIGH)
+		if (stream->dev->udev->speed >= USB_SPEED_HIGH)
 			bandwidth /= 8;
 		bandwidth += 12;
 
@@ -471,6 +471,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;
+	u32 dev_stc;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -515,6 +516,34 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (dev_sof == stream->clock.last_sof)
 		return;
 
+	dev_stc = get_unaligned_le32(&data[header_size - 6]);
+
+	/*
+	 * STC (Source Time Clock) is the clock used by the camera. The UVC 1.5
+	 * standard states that it "must be captured when the first video data
+	 * of a video frame is put on the USB bus". This is generally understood
+	 * as requiring devices to clear the payload header's SCR bit before
+	 * the first packet containing video data.
+	 *
+	 * Most vendors follow that interpretation, but some (namely SunplusIT
+	 * on some devices) always set the `UVC_STREAM_SCR` bit, fill the SCR
+	 * field with 0's,and expect that the driver only processes the SCR if
+	 * there is data in the packet.
+	 *
+	 * Ignore all the hardware timestamp information if we haven't received
+	 * any data for this frame yet, the packet contains no data, and both
+	 * STC and SOF are zero. This heuristics should be safe on compliant
+	 * devices. This should be safe with compliant devices, as in the very
+	 * unlikely case where a UVC 1.1 device would send timing information
+	 * only before the first packet containing data, and both STC and SOF
+	 * happen to be zero for a particular frame, we would only miss one
+	 * clock sample from many and the clock recovery algorithm wouldn't
+	 * suffer from this condition.
+	 */
+	if (buf && buf->bytesused == 0 && len == header_size &&
+	    dev_stc == 0 && dev_sof == 0)
+		return;
+
 	stream->clock.last_sof = dev_sof;
 
 	host_sof = usb_get_current_frame_number(stream->dev->udev);
@@ -552,7 +581,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	spin_lock_irqsave(&stream->clock.lock, flags);
 
 	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample->dev_stc = dev_stc;
 	sample->dev_sof = dev_sof;
 	sample->host_sof = host_sof;
 	sample->host_time = time;
@@ -697,11 +726,11 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	unsigned long flags;
 	u64 timestamp;
 	u32 delta_stc;
-	u32 y1, y2;
+	u32 y1;
 	u32 x1, x2;
 	u32 mean;
 	u32 sof;
-	u64 y;
+	u64 y, y2;
 
 	if (!uvc_hw_timestamps_param)
 		return;
@@ -741,7 +770,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	sof = y;
 
 	uvc_dbg(stream->dev, CLOCK,
-		"%s: PTS %u y %llu.%06llu SOF %u.%06llu (x1 %u x2 %u y1 %u y2 %u SOF offset %u)\n",
+		"%s: PTS %u y %llu.%06llu SOF %u.%06llu (x1 %u x2 %u y1 %u y2 %llu SOF offset %u)\n",
 		stream->dev->name, buf->pts,
 		y >> 16, div_u64((y & 0xffff) * 1000000, 65536),
 		sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
@@ -756,7 +785,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		goto done;
 
 	y1 = NSEC_PER_SEC;
-	y2 = (u32)ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
+	y2 = ktime_to_ns(ktime_sub(last->host_time, first->host_time)) + y1;
 
 	/* Interpolated and host SOF timestamps can wrap around at slightly
 	 * different times. Handle this by adding or removing 2048 to or from
@@ -776,7 +805,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	timestamp = ktime_to_ns(first->host_time) + y - y1;
 
 	uvc_dbg(stream->dev, CLOCK,
-		"%s: SOF %u.%06llu y %llu ts %llu buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %u)\n",
+		"%s: SOF %u.%06llu y %llu ts %llu buf ts %llu (x1 %u/%u/%u x2 %u/%u/%u y1 %u y2 %llu)\n",
 		stream->dev->name,
 		sof >> 16, div_u64(((u64)sof & 0xffff) * 1000000LLU, 65536),
 		y, timestamp, vbuf->vb2_buf.timestamp,
diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 72c0df129d5c..5a410a40f914 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -168,7 +168,7 @@ config FSL_CORENET_CF
 	  represents a coherency violation.
 
 config FSL_IFC
-	bool "Freescale IFC driver" if COMPILE_TEST
+	bool "Freescale IFC driver"
 	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST
 	depends on HAS_IOMEM
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2ba6646e874c..aa0d43914269 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -274,7 +274,5 @@ obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
 obj-$(CONFIG_MFD_ATC260X)	+= atc260x-core.o
 obj-$(CONFIG_MFD_ATC260X_I2C)	+= atc260x-i2c.o
 
-rsmu-i2c-objs			:= rsmu_core.o rsmu_i2c.o
-rsmu-spi-objs			:= rsmu_core.o rsmu_spi.o
-obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu-i2c.o
-obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu-spi.o
+obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
+obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 080d7970a377..5971b5cb290a 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -237,8 +237,7 @@ static int usbtll_omap_probe(struct platform_device *pdev)
 		break;
 	}
 
-	tll = devm_kzalloc(dev, sizeof(*tll) + sizeof(tll->ch_clk[nch]),
-			   GFP_KERNEL);
+	tll = devm_kzalloc(dev, struct_size(tll, ch_clk, nch), GFP_KERNEL);
 	if (!tll) {
 		pm_runtime_put_sync(dev);
 		pm_runtime_disable(dev);
diff --git a/drivers/mfd/rsmu_core.c b/drivers/mfd/rsmu_core.c
index 29437fd0bd5b..fd04a6e5dfa3 100644
--- a/drivers/mfd/rsmu_core.c
+++ b/drivers/mfd/rsmu_core.c
@@ -78,11 +78,13 @@ int rsmu_core_init(struct rsmu_ddata *rsmu)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rsmu_core_init);
 
 void rsmu_core_exit(struct rsmu_ddata *rsmu)
 {
 	mutex_destroy(&rsmu->lock);
 }
+EXPORT_SYMBOL_GPL(rsmu_core_exit);
 
 MODULE_DESCRIPTION("Renesas SMU core driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 67b7cb67c030..aa584aaf8ae3 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -254,8 +254,7 @@ config MTD_NAND_FSL_IFC
 	tristate "Freescale IFC NAND controller"
 	depends on FSL_SOC || ARCH_LAYERSCAPE || SOC_LS1021A || COMPILE_TEST
 	depends on HAS_IOMEM
-	select FSL_IFC
-	select MEMORY
+	depends on FSL_IFC
 	help
 	  Various Freescale chips e.g P1010, include a NAND Flash machine
 	  with built-in hardware ECC capabilities.
diff --git a/drivers/mtd/tests/Makefile b/drivers/mtd/tests/Makefile
index 5de0378f90db..7dae831ee8b6 100644
--- a/drivers/mtd/tests/Makefile
+++ b/drivers/mtd/tests/Makefile
@@ -1,19 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_MTD_TESTS) += mtd_oobtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_pagetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_readtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_speedtest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_stresstest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_subpagetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_torturetest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_nandecctest.o
-obj-$(CONFIG_MTD_TESTS) += mtd_nandbiterrs.o
+obj-$(CONFIG_MTD_TESTS) += mtd_oobtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_pagetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_readtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_speedtest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_stresstest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_subpagetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_torturetest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_nandecctest.o mtd_test.o
+obj-$(CONFIG_MTD_TESTS) += mtd_nandbiterrs.o mtd_test.o
 
-mtd_oobtest-objs := oobtest.o mtd_test.o
-mtd_pagetest-objs := pagetest.o mtd_test.o
-mtd_readtest-objs := readtest.o mtd_test.o
-mtd_speedtest-objs := speedtest.o mtd_test.o
-mtd_stresstest-objs := stresstest.o mtd_test.o
-mtd_subpagetest-objs := subpagetest.o mtd_test.o
-mtd_torturetest-objs := torturetest.o mtd_test.o
-mtd_nandbiterrs-objs := nandbiterrs.o mtd_test.o
+mtd_oobtest-objs := oobtest.o
+mtd_pagetest-objs := pagetest.o
+mtd_readtest-objs := readtest.o
+mtd_speedtest-objs := speedtest.o
+mtd_stresstest-objs := stresstest.o
+mtd_subpagetest-objs := subpagetest.o
+mtd_torturetest-objs := torturetest.o
+mtd_nandbiterrs-objs := nandbiterrs.o
diff --git a/drivers/mtd/tests/mtd_test.c b/drivers/mtd/tests/mtd_test.c
index c84250beffdc..f391e0300cdc 100644
--- a/drivers/mtd/tests/mtd_test.c
+++ b/drivers/mtd/tests/mtd_test.c
@@ -25,6 +25,7 @@ int mtdtest_erase_eraseblock(struct mtd_info *mtd, unsigned int ebnum)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_erase_eraseblock);
 
 static int is_block_bad(struct mtd_info *mtd, unsigned int ebnum)
 {
@@ -57,6 +58,7 @@ int mtdtest_scan_for_bad_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_scan_for_bad_eraseblocks);
 
 int mtdtest_erase_good_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 				unsigned int eb, int ebcnt)
@@ -75,6 +77,7 @@ int mtdtest_erase_good_eraseblocks(struct mtd_info *mtd, unsigned char *bbt,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtdtest_erase_good_eraseblocks);
 
 int mtdtest_read(struct mtd_info *mtd, loff_t addr, size_t size, void *buf)
 {
@@ -92,6 +95,7 @@ int mtdtest_read(struct mtd_info *mtd, loff_t addr, size_t size, void *buf)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mtdtest_read);
 
 int mtdtest_write(struct mtd_info *mtd, loff_t addr, size_t size,
 		const void *buf)
@@ -107,3 +111,8 @@ int mtdtest_write(struct mtd_info *mtd, loff_t addr, size_t size,
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(mtdtest_write);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MTD function test helpers");
+MODULE_AUTHOR("Akinobu Mita");
diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 4d05b8d32083..41e0f098705c 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1560,6 +1560,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
 					  GFP_KERNEL);
 		if (!fm_eba[i]) {
 			ret = -ENOMEM;
+			kfree(scan_eba[i]);
 			goto out_free;
 		}
 
@@ -1595,7 +1596,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
 	}
 
 out_free:
-	for (i = 0; i < num_volumes; i++) {
+	while (--i >= 0) {
 		if (!ubi->volumes[i])
 			continue;
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 9aed194d308d..6a91229b0e05 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1087,13 +1087,10 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
 	return bestslave;
 }
 
+/* must be called in RCU critical section or with RTNL held */
 static bool bond_should_notify_peers(struct bonding *bond)
 {
-	struct slave *slave;
-
-	rcu_read_lock();
-	slave = rcu_dereference(bond->curr_active_slave);
-	rcu_read_unlock();
+	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
 
 	if (!slave || !bond->send_peer_notif ||
 	    bond->send_peer_notif %
diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 604f54112665..e23f184ffdda 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2223,6 +2223,9 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	if (is5325(dev) || is5365(dev))
 		return -EOPNOTSUPP;
 
+	if (!dsa_is_cpu_port(ds, port))
+		return 0;
+
 	enable_jumbo = (mtu >= JMS_MIN_SIZE);
 	allow_10_100 = (dev->chip_id == BCM583XX_DEVICE_ID);
 
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index 1fa392aee52d..f259b0add5b2 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -638,8 +638,10 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
 			of_remove_property(child, prop);
 
 		phydev = of_phy_find_device(child);
-		if (phydev)
+		if (phydev) {
 			phy_device_remove(phydev);
+			phy_device_free(phydev);
+		}
 	}
 
 	err = mdiobus_register(priv->slave_mii_bus);
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 7985a48e0830..2a55ecceab8c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3104,7 +3104,8 @@ static int mv88e6xxx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	mv88e6xxx_reg_lock(chip);
 	if (chip->info->ops->port_set_jumbo_size)
 		ret = chip->info->ops->port_set_jumbo_size(chip, port, new_mtu);
-	else if (chip->info->ops->set_max_frame_size)
+	else if (chip->info->ops->set_max_frame_size &&
+		 dsa_is_cpu_port(ds, port))
 		ret = chip->info->ops->set_max_frame_size(chip, new_mtu);
 	mv88e6xxx_reg_unlock(chip);
 
diff --git a/drivers/net/ethernet/brocade/bna/bna_types.h b/drivers/net/ethernet/brocade/bna/bna_types.h
index 666b6922e24d..ebf54d74c2bb 100644
--- a/drivers/net/ethernet/brocade/bna/bna_types.h
+++ b/drivers/net/ethernet/brocade/bna/bna_types.h
@@ -410,7 +410,7 @@ struct bna_ib {
 /* Tx object */
 
 /* Tx datapath control structure */
-#define BNA_Q_NAME_SIZE		16
+#define BNA_Q_NAME_SIZE		(IFNAMSIZ + 6)
 struct bna_tcb {
 	/* Fast path */
 	void			**sw_qpt;
diff --git a/drivers/net/ethernet/brocade/bna/bnad.c b/drivers/net/ethernet/brocade/bna/bnad.c
index 0347c9d3aff3..a3b6b9af0b05 100644
--- a/drivers/net/ethernet/brocade/bna/bnad.c
+++ b/drivers/net/ethernet/brocade/bna/bnad.c
@@ -1535,8 +1535,9 @@ bnad_tx_msix_register(struct bnad *bnad, struct bnad_tx_info *tx_info,
 
 	for (i = 0; i < num_txqs; i++) {
 		vector_num = tx_info->tcb[i]->intr_vector;
-		sprintf(tx_info->tcb[i]->name, "%s TXQ %d", bnad->netdev->name,
-				tx_id + tx_info->tcb[i]->id);
+		snprintf(tx_info->tcb[i]->name, BNA_Q_NAME_SIZE, "%s TXQ %d",
+			 bnad->netdev->name,
+			 tx_id + tx_info->tcb[i]->id);
 		err = request_irq(bnad->msix_table[vector_num].vector,
 				  (irq_handler_t)bnad_msix_tx, 0,
 				  tx_info->tcb[i]->name,
@@ -1586,9 +1587,9 @@ bnad_rx_msix_register(struct bnad *bnad, struct bnad_rx_info *rx_info,
 
 	for (i = 0; i < num_rxps; i++) {
 		vector_num = rx_info->rx_ctrl[i].ccb->intr_vector;
-		sprintf(rx_info->rx_ctrl[i].ccb->name, "%s CQ %d",
-			bnad->netdev->name,
-			rx_id + rx_info->rx_ctrl[i].ccb->id);
+		snprintf(rx_info->rx_ctrl[i].ccb->name, BNA_Q_NAME_SIZE,
+			 "%s CQ %d", bnad->netdev->name,
+			 rx_id + rx_info->rx_ctrl[i].ccb->id);
 		err = request_irq(bnad->msix_table[vector_num].vector,
 				  (irq_handler_t)bnad_msix_rx, 0,
 				  rx_info->rx_ctrl[i].ccb->name,
diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index f02376555ed4..0a3cf22dc260 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -252,8 +252,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define PKT_MINBUF_SIZE		64
 
 /* FEC receive acceleration */
-#define FEC_RACC_IPDIS		(1 << 1)
-#define FEC_RACC_PRODIS		(1 << 2)
+#define FEC_RACC_IPDIS		BIT(1)
+#define FEC_RACC_PRODIS		BIT(2)
 #define FEC_RACC_SHIFT16	BIT(7)
 #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
 
@@ -285,8 +285,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define FEC_MMFR_TA		(2 << 16)
 #define FEC_MMFR_DATA(v)	(v & 0xffff)
 /* FEC ECR bits definition */
-#define FEC_ECR_MAGICEN		(1 << 2)
-#define FEC_ECR_SLEEP		(1 << 3)
+#define FEC_ECR_RESET           BIT(0)
+#define FEC_ECR_ETHEREN         BIT(1)
+#define FEC_ECR_MAGICEN         BIT(2)
+#define FEC_ECR_SLEEP           BIT(3)
+#define FEC_ECR_EN1588          BIT(4)
+#define FEC_ECR_BYTESWP         BIT(8)
+/* FEC RCR bits definition */
+#define FEC_RCR_LOOP            BIT(0)
+#define FEC_RCR_HALFDPX         BIT(1)
+#define FEC_RCR_MII             BIT(2)
+#define FEC_RCR_PROMISC         BIT(3)
+#define FEC_RCR_BC_REJ          BIT(4)
+#define FEC_RCR_FLOWCTL         BIT(5)
+#define FEC_RCR_RMII            BIT(8)
+#define FEC_RCR_10BASET         BIT(9)
+/* TX WMARK bits */
+#define FEC_TXWMRK_STRFWD       BIT(8)
 
 #define FEC_MII_TIMEOUT		30000 /* us */
 
@@ -981,7 +996,7 @@ fec_restart(struct net_device *ndev)
 	struct fec_enet_private *fep = netdev_priv(ndev);
 	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
-	u32 ecntl = 0x2; /* ETHEREN */
+	u32 ecntl = FEC_ECR_ETHEREN;
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
@@ -1059,18 +1074,18 @@ fec_restart(struct net_device *ndev)
 		    fep->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
 			rcntl |= (1 << 6);
 		else if (fep->phy_interface == PHY_INTERFACE_MODE_RMII)
-			rcntl |= (1 << 8);
+			rcntl |= FEC_RCR_RMII;
 		else
-			rcntl &= ~(1 << 8);
+			rcntl &= ~FEC_RCR_RMII;
 
 		/* 1G, 100M or 10M */
 		if (ndev->phydev) {
 			if (ndev->phydev->speed == SPEED_1000)
 				ecntl |= (1 << 5);
 			else if (ndev->phydev->speed == SPEED_100)
-				rcntl &= ~(1 << 9);
+				rcntl &= ~FEC_RCR_10BASET;
 			else
-				rcntl |= (1 << 9);
+				rcntl |= FEC_RCR_10BASET;
 		}
 	} else {
 #ifdef FEC_MIIGSK_ENR
@@ -1129,13 +1144,13 @@ fec_restart(struct net_device *ndev)
 
 	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
 		/* enable ENET endian swap */
-		ecntl |= (1 << 8);
+		ecntl |= FEC_ECR_BYTESWP;
 		/* enable ENET store and forward mode */
-		writel(1 << 8, fep->hwp + FEC_X_WMRK);
+		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
 	}
 
 	if (fep->bufdesc_ex)
-		ecntl |= (1 << 4);
+		ecntl |= FEC_ECR_EN1588;
 
 	if (fep->quirks & FEC_QUIRK_DELAYED_CLKS_SUPPORT &&
 	    fep->rgmii_txc_dly)
@@ -1189,7 +1204,7 @@ static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
 	u32 val;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
@@ -1208,7 +1223,7 @@ fec_stop(struct net_device *ndev)
 		if (fep->quirks & FEC_QUIRK_HAS_MULTI_QUEUES) {
 			writel(0, fep->hwp + FEC_ECNTRL);
 		} else {
-			writel(1, fep->hwp + FEC_ECNTRL);
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 			udelay(10);
 		}
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
@@ -1224,11 +1239,16 @@ fec_stop(struct net_device *ndev)
 	/* We have to keep ENET enabled to have MII interrupt stay working */
 	if (fep->quirks & FEC_QUIRK_ENET_MAC &&
 		!(fep->wol_flag & FEC_WOL_FLAG_SLEEP_ON)) {
-		writel(2, fep->hwp + FEC_ECNTRL);
+		writel(FEC_ECR_ETHEREN, fep->hwp + FEC_ECNTRL);
 		writel(rmii_mode, fep->hwp + FEC_R_CNTRL);
 	}
-}
 
+	if (fep->bufdesc_ex) {
+		val = readl(fep->hwp + FEC_ECNTRL);
+		val |= FEC_ECR_EN1588;
+		writel(val, fep->hwp + FEC_ECNTRL);
+	}
+}
 
 static void
 fec_timeout(struct net_device *ndev, unsigned int txqueue)
diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 780fbb3e1ed0..84e0855069a8 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -640,6 +640,9 @@ void fec_ptp_stop(struct platform_device *pdev)
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct fec_enet_private *fep = netdev_priv(ndev);
 
+	if (fep->pps_enable)
+		fec_ptp_enable_pps(fep, 0);
+
 	cancel_delayed_work_sync(&fep->time_keep);
 	if (fep->ptp_clock)
 		ptp_clock_unregister(fep->ptp_clock);
diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
index 94e3b74a10f2..dfbb524bf739 100644
--- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
@@ -606,22 +606,42 @@ static bool gve_can_send_tso(const struct sk_buff *skb)
 	const struct skb_shared_info *shinfo = skb_shinfo(skb);
 	const int gso_size = shinfo->gso_size;
 	int cur_seg_num_bufs;
+	int prev_frag_size;
 	int cur_seg_size;
 	int i;
 
 	cur_seg_size = skb_headlen(skb) - header_len;
+	prev_frag_size = skb_headlen(skb);
 	cur_seg_num_bufs = cur_seg_size > 0;
 
 	for (i = 0; i < shinfo->nr_frags; i++) {
 		if (cur_seg_size >= gso_size) {
 			cur_seg_size %= gso_size;
 			cur_seg_num_bufs = cur_seg_size > 0;
+
+			if (prev_frag_size > GVE_TX_MAX_BUF_SIZE_DQO) {
+				int prev_frag_remain = prev_frag_size %
+					GVE_TX_MAX_BUF_SIZE_DQO;
+
+				/* If the last descriptor of the previous frag
+				 * is less than cur_seg_size, the segment will
+				 * span two descriptors in the previous frag.
+				 * Since max gso size (9728) is less than
+				 * GVE_TX_MAX_BUF_SIZE_DQO, it is impossible
+				 * for the segment to span more than two
+				 * descriptors.
+				 */
+				if (prev_frag_remain &&
+				    cur_seg_size > prev_frag_remain)
+					cur_seg_num_bufs++;
+			}
 		}
 
 		if (unlikely(++cur_seg_num_bufs > max_bufs_per_seg))
 			return false;
 
-		cur_seg_size += skb_frag_size(&shinfo->frags[i]);
+		prev_frag_size = skb_frag_size(&shinfo->frags[i]);
+		cur_seg_size += prev_frag_size;
 	}
 
 	return true;
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index ba44d1d9cfcd..2a60f949d953 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -953,13 +953,13 @@ static void mvpp2_bm_pool_update_fc(struct mvpp2_port *port,
 static void mvpp2_bm_pool_update_priv_fc(struct mvpp2 *priv, bool en)
 {
 	struct mvpp2_port *port;
-	int i;
+	int i, j;
 
 	for (i = 0; i < priv->port_count; i++) {
 		port = priv->port_list[i];
 		if (port->priv->percpu_pools) {
-			for (i = 0; i < port->nrxqs; i++)
-				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[i],
+			for (j = 0; j < port->nrxqs; j++)
+				mvpp2_bm_pool_update_fc(port, &port->priv->bm_pools[j],
 							port->tx_fc & en);
 		} else {
 			mvpp2_bm_pool_update_fc(port, port->pool_long, port->tx_fc & en);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 2d3cd237355a..06f6809b1c2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1181,7 +1181,12 @@ int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	if (!an_changes && link_modes == eproto.admin)
 		goto out;
 
-	mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
+	err = mlx5_port_set_eth_ptys(mdev, an_disable, link_modes, ext);
+	if (err) {
+		netdev_err(priv->netdev, "%s: failed to set ptys reg: %d\n", __func__, err);
+		goto out;
+	}
+
 	mlx5_toggle_port_link(mdev);
 
 out:
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
index 4b713832fdd5..f5c0a4214c4e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_atcam.c
@@ -391,7 +391,8 @@ mlxsw_sp_acl_atcam_region_entry_insert(struct mlxsw_sp *mlxsw_sp,
 	if (err)
 		return err;
 
-	lkey_id = aregion->ops->lkey_id_get(aregion, aentry->enc_key, erp_id);
+	lkey_id = aregion->ops->lkey_id_get(aregion, aentry->ht_key.enc_key,
+					    erp_id);
 	if (IS_ERR(lkey_id))
 		return PTR_ERR(lkey_id);
 	aentry->lkey_id = lkey_id;
@@ -399,7 +400,7 @@ mlxsw_sp_acl_atcam_region_entry_insert(struct mlxsw_sp *mlxsw_sp,
 	kvdl_index = mlxsw_afa_block_first_kvdl_index(rulei->act_block);
 	mlxsw_reg_ptce3_pack(ptce3_pl, true, MLXSW_REG_PTCE3_OP_WRITE_WRITE,
 			     priority, region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -428,7 +429,7 @@ mlxsw_sp_acl_atcam_region_entry_remove(struct mlxsw_sp *mlxsw_sp,
 
 	mlxsw_reg_ptce3_pack(ptce3_pl, false, MLXSW_REG_PTCE3_OP_WRITE_WRITE, 0,
 			     region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -457,7 +458,7 @@ mlxsw_sp_acl_atcam_region_entry_action_replace(struct mlxsw_sp *mlxsw_sp,
 	kvdl_index = mlxsw_afa_block_first_kvdl_index(rulei->act_block);
 	mlxsw_reg_ptce3_pack(ptce3_pl, true, MLXSW_REG_PTCE3_OP_WRITE_UPDATE,
 			     priority, region->tcam_region_info,
-			     aentry->enc_key, erp_id,
+			     aentry->ht_key.enc_key, erp_id,
 			     aentry->delta_info.start,
 			     aentry->delta_info.mask,
 			     aentry->delta_info.value,
@@ -480,15 +481,13 @@ __mlxsw_sp_acl_atcam_entry_add(struct mlxsw_sp *mlxsw_sp,
 	int err;
 
 	mlxsw_afk_encode(afk, region->key_info, &rulei->values,
-			 aentry->ht_key.full_enc_key, mask);
+			 aentry->ht_key.enc_key, mask);
 
 	erp_mask = mlxsw_sp_acl_erp_mask_get(aregion, mask, false);
 	if (IS_ERR(erp_mask))
 		return PTR_ERR(erp_mask);
 	aentry->erp_mask = erp_mask;
 	aentry->ht_key.erp_id = mlxsw_sp_acl_erp_mask_erp_id(erp_mask);
-	memcpy(aentry->enc_key, aentry->ht_key.full_enc_key,
-	       sizeof(aentry->enc_key));
 
 	/* Compute all needed delta information and clear the delta bits
 	 * from the encrypted key.
@@ -497,9 +496,8 @@ __mlxsw_sp_acl_atcam_entry_add(struct mlxsw_sp *mlxsw_sp,
 	aentry->delta_info.start = mlxsw_sp_acl_erp_delta_start(delta);
 	aentry->delta_info.mask = mlxsw_sp_acl_erp_delta_mask(delta);
 	aentry->delta_info.value =
-		mlxsw_sp_acl_erp_delta_value(delta,
-					     aentry->ht_key.full_enc_key);
-	mlxsw_sp_acl_erp_delta_clear(delta, aentry->enc_key);
+		mlxsw_sp_acl_erp_delta_value(delta, aentry->ht_key.enc_key);
+	mlxsw_sp_acl_erp_delta_clear(delta, aentry->ht_key.enc_key);
 
 	/* Add rule to the list of A-TCAM rules, assuming this
 	 * rule is intended to A-TCAM. In case this rule does
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
index 2e8b17e3b935..3ab87db83b7f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_bloom_filter.c
@@ -116,9 +116,10 @@ static u16 mlxsw_sp_acl_bf_crc(const u8 *buffer, size_t len)
 }
 
 static void
-mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
-			   struct mlxsw_sp_acl_atcam_entry *aentry,
-			   char *output, u8 *len)
+__mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
+			     struct mlxsw_sp_acl_atcam_entry *aentry,
+			     char *output, u8 *len, u8 max_chunks, u8 pad_bytes,
+			     u8 key_offset, u8 chunk_key_len, u8 chunk_len)
 {
 	struct mlxsw_afk_key_info *key_info = aregion->region->key_info;
 	u8 chunk_index, chunk_count, block_count;
@@ -129,17 +130,30 @@ mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
 	chunk_count = 1 + ((block_count - 1) >> 2);
 	erp_region_id = cpu_to_be16(aentry->ht_key.erp_id |
 				   (aregion->region->id << 4));
-	for (chunk_index = MLXSW_BLOOM_KEY_CHUNKS - chunk_count;
-	     chunk_index < MLXSW_BLOOM_KEY_CHUNKS; chunk_index++) {
-		memset(chunk, 0, MLXSW_BLOOM_CHUNK_PAD_BYTES);
-		memcpy(chunk + MLXSW_BLOOM_CHUNK_PAD_BYTES, &erp_region_id,
+	for (chunk_index = max_chunks - chunk_count; chunk_index < max_chunks;
+	     chunk_index++) {
+		memset(chunk, 0, pad_bytes);
+		memcpy(chunk + pad_bytes, &erp_region_id,
 		       sizeof(erp_region_id));
-		memcpy(chunk + MLXSW_BLOOM_CHUNK_KEY_OFFSET,
-		       &aentry->enc_key[chunk_key_offsets[chunk_index]],
-		       MLXSW_BLOOM_CHUNK_KEY_BYTES);
-		chunk += MLXSW_BLOOM_KEY_CHUNK_BYTES;
+		memcpy(chunk + key_offset,
+		       &aentry->ht_key.enc_key[chunk_key_offsets[chunk_index]],
+		       chunk_key_len);
+		chunk += chunk_len;
 	}
-	*len = chunk_count * MLXSW_BLOOM_KEY_CHUNK_BYTES;
+	*len = chunk_count * chunk_len;
+}
+
+static void
+mlxsw_sp_acl_bf_key_encode(struct mlxsw_sp_acl_atcam_region *aregion,
+			   struct mlxsw_sp_acl_atcam_entry *aentry,
+			   char *output, u8 *len)
+{
+	__mlxsw_sp_acl_bf_key_encode(aregion, aentry, output, len,
+				     MLXSW_BLOOM_KEY_CHUNKS,
+				     MLXSW_BLOOM_CHUNK_PAD_BYTES,
+				     MLXSW_BLOOM_CHUNK_KEY_OFFSET,
+				     MLXSW_BLOOM_CHUNK_KEY_BYTES,
+				     MLXSW_BLOOM_KEY_CHUNK_BYTES);
 }
 
 static unsigned int
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
index d231f4d2888b..9eee229303cc 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c
@@ -1217,18 +1217,6 @@ static bool mlxsw_sp_acl_erp_delta_check(void *priv, const void *parent_obj,
 	return err ? false : true;
 }
 
-static int mlxsw_sp_acl_erp_hints_obj_cmp(const void *obj1, const void *obj2)
-{
-	const struct mlxsw_sp_acl_erp_key *key1 = obj1;
-	const struct mlxsw_sp_acl_erp_key *key2 = obj2;
-
-	/* For hints purposes, two objects are considered equal
-	 * in case the masks are the same. Does not matter what
-	 * the "ctcam" value is.
-	 */
-	return memcmp(key1->mask, key2->mask, sizeof(key1->mask));
-}
-
 static void *mlxsw_sp_acl_erp_delta_create(void *priv, void *parent_obj,
 					   void *obj)
 {
@@ -1308,7 +1296,6 @@ static void mlxsw_sp_acl_erp_root_destroy(void *priv, void *root_priv)
 static const struct objagg_ops mlxsw_sp_acl_erp_objagg_ops = {
 	.obj_size = sizeof(struct mlxsw_sp_acl_erp_key),
 	.delta_check = mlxsw_sp_acl_erp_delta_check,
-	.hints_obj_cmp = mlxsw_sp_acl_erp_hints_obj_cmp,
 	.delta_create = mlxsw_sp_acl_erp_delta_create,
 	.delta_destroy = mlxsw_sp_acl_erp_delta_destroy,
 	.root_create = mlxsw_sp_acl_erp_root_create,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
index a41df10ade9b..f28c47ae5488 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
@@ -171,9 +171,9 @@ struct mlxsw_sp_acl_atcam_region {
 };
 
 struct mlxsw_sp_acl_atcam_entry_ht_key {
-	char full_enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded
-								 * key.
-								 */
+	char enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded key, minus
+							    * delta bits.
+							    */
 	u8 erp_id;
 };
 
@@ -185,9 +185,6 @@ struct mlxsw_sp_acl_atcam_entry {
 	struct rhash_head ht_node;
 	struct list_head list; /* Member in entries_list */
 	struct mlxsw_sp_acl_atcam_entry_ht_key ht_key;
-	char enc_key[MLXSW_REG_PTCEX_FLEX_KEY_BLOCKS_LEN]; /* Encoded key,
-							    * minus delta bits.
-							    */
 	struct {
 		u16 start;
 		u8 mask;
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 76d820c4e6ee..49a3cd4ce89c 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4283,7 +4283,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
 		if (net_ratelimit())
 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
-		goto err_stop_0;
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
 	}
 
 	opts[1] = rtl8169_tx_vlan_tag(skb);
@@ -4356,11 +4357,6 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	dev_kfree_skb_any(skb);
 	dev->stats.tx_dropped++;
 	return NETDEV_TX_OK;
-
-err_stop_0:
-	netif_stop_queue(dev);
-	dev->stats.tx_dropped++;
-	return NETDEV_TX_BUSY;
 }
 
 static unsigned int rtl_last_frag_len(struct sk_buff *skb)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 026e3645e566..e5c5a9c5389c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -972,7 +972,7 @@ static void dwmac4_set_mac_loopback(void __iomem *ioaddr, bool enable)
 }
 
 static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				    __le16 perfect_match, bool is_double)
+				    u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index dd73f38ec08d..813327d04c56 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -582,7 +582,7 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
 }
 
 static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      __le16 perfect_match, bool is_double)
+				      u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 58e5c6c428dc..414b63d5b9eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -370,7 +370,7 @@ struct stmmac_ops {
 			     struct stmmac_rss *cfg, u32 num_rxq);
 	/* VLAN */
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 __le16 perfect_match, bool is_double);
+				 u16 perfect_match, bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
 	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b0ab8f6986f8..cd92b8e03a9a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1286,6 +1286,8 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 	if (!fwnode)
 		fwnode = dev_fwnode(priv->device);
 
+	priv->phylink_config.mac_managed_pm = true;
+
 	phylink = phylink_create(&priv->phylink_config, fwnode,
 				 mode, &stmmac_phylink_mac_ops);
 	if (IS_ERR(phylink))
@@ -6237,7 +6239,7 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 {
 	u32 crc, hash = 0;
-	__le16 pmatch = 0;
+	u16 pmatch = 0;
 	int count = 0;
 	u16 vid = 0;
 
@@ -6252,7 +6254,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		if (count > 2) /* VID = 0 always passes filter */
 			return -EOPNOTSUPP;
 
-		pmatch = cpu_to_le16(vid);
+		pmatch = vid;
 		hash = 0;
 	}
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index ccecba908ded..4292105323f4 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -716,6 +716,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				/* rtnl_lock already held
 				 * we might sleep in __netpoll_cleanup()
 				 */
+				nt->enabled = false;
 				spin_unlock_irqrestore(&target_list_lock, flags);
 
 				__netpoll_cleanup(&nt->np);
@@ -723,7 +724,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				spin_lock_irqsave(&target_list_lock, flags);
 				dev_put(nt->np.dev);
 				nt->np.dev = NULL;
-				nt->enabled = false;
 				stopped = true;
 				netconsole_target_put(nt);
 				goto restart;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index fb09e95cbc25..773a54c083f6 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -201,6 +201,7 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			break;
 		default:
 			/* not ip - do not know what to do */
+			kfree_skb(skbn);
 			goto skip;
 		}
 
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 1c4a4bd46be6..3cff3c9d7b89 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -179,6 +179,7 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 	__le16 res;
 	int rc = 0;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(netdev, "Only internal phy supported\n");
@@ -189,11 +190,17 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	if (loc == MII_BMSR) {
 		u8 value;
 
-		sr_read_reg(dev, SR_NSR, &value);
+		err = sr_read_reg(dev, SR_NSR, &value);
+		if (err < 0)
+			return err;
+
 		if (value & NSR_LINKST)
 			rc = 1;
 	}
-	sr_share_read_word(dev, 1, loc, &res);
+	err = sr_share_read_word(dev, 1, loc, &res);
+	if (err < 0)
+		return err;
+
 	if (rc == 1)
 		res = le16_to_cpu(res) | BMSR_LSTATUS;
 	else
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index dfdb2eeaf040..6920cce493f6 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1861,8 +1861,7 @@ static void ath11k_dp_rx_h_csum_offload(struct ath11k *ar, struct sk_buff *msdu)
 			  CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static int ath11k_dp_rx_crypto_mic_len(struct ath11k *ar,
-				       enum hal_encrypt_type enctype)
+int ath11k_dp_rx_crypto_mic_len(struct ath11k *ar, enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
 	case HAL_ENCRYPT_TYPE_OPEN:
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index 623da3bf9dc8..c322e30caa96 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 #ifndef ATH11K_DP_RX_H
 #define ATH11K_DP_RX_H
@@ -95,4 +96,6 @@ int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id
 int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab);
 int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer);
 
+int ath11k_dp_rx_crypto_mic_len(struct ath11k *ar, enum hal_encrypt_type enctype);
+
 #endif /* ATH11K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c58fd836d4ad..81a8e1102d72 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2675,6 +2675,7 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_CCM;
 		/* TODO: Re-check if flag is valid */
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
@@ -2684,12 +2685,10 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
 		arg.key_txmic_len = 8;
 		arg.key_rxmic_len = 8;
 		break;
-	case WLAN_CIPHER_SUITE_CCMP_256:
-		arg.key_cipher = WMI_CIPHER_AES_CCM;
-		break;
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_GCM;
+		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
 		break;
 	default:
 		ath11k_warn(ar->ab, "cipher %d is not supported\n", key->cipher);
@@ -4204,7 +4203,10 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ath11k_skb_cb *skb_cb = ATH11K_SKB_CB(skb);
 	struct ieee80211_tx_info *info;
+	enum hal_encrypt_type enctype;
+	unsigned int mic_len;
 	dma_addr_t paddr;
 	int buf_id;
 	int ret;
@@ -4224,7 +4226,12 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
 		     ieee80211_is_deauth(hdr->frame_control) ||
 		     ieee80211_is_disassoc(hdr->frame_control)) &&
 		     ieee80211_has_protected(hdr->frame_control)) {
-			skb_put(skb, IEEE80211_CCMP_MIC_LEN);
+			if (!(skb_cb->flags & ATH11K_SKB_CIPHER_SET))
+				ath11k_warn(ab, "WMI management tx frame without ATH11K_SKB_CIPHER_SET");
+
+			enctype = ath11k_dp_tx_get_encrypt_type(skb_cb->cipher);
+			mic_len = ath11k_dp_rx_crypto_mic_len(ar, enctype);
+			skb_put(skb, mic_len);
 		}
 	}
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index 7717eb85a1db..47c0e8e429e5 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -2567,7 +2567,6 @@ wlc_lcnphy_tx_iqlo_cal(struct brcms_phy *pi,
 
 	struct lcnphy_txgains cal_gains, temp_gains;
 	u16 hash;
-	u8 band_idx;
 	int j;
 	u16 ncorr_override[5];
 	u16 syst_coeffs[] = { 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
@@ -2599,6 +2598,9 @@ wlc_lcnphy_tx_iqlo_cal(struct brcms_phy *pi,
 	u16 *values_to_save;
 	struct brcms_phy_lcnphy *pi_lcn = pi->u.pi_lcnphy;
 
+	if (WARN_ON(CHSPEC_IS5G(pi->radio_chanspec)))
+		return;
+
 	values_to_save = kmalloc_array(20, sizeof(u16), GFP_ATOMIC);
 	if (NULL == values_to_save)
 		return;
@@ -2662,20 +2664,18 @@ wlc_lcnphy_tx_iqlo_cal(struct brcms_phy *pi,
 	hash = (target_gains->gm_gain << 8) |
 	       (target_gains->pga_gain << 4) | (target_gains->pad_gain);
 
-	band_idx = (CHSPEC_IS5G(pi->radio_chanspec) ? 1 : 0);
-
 	cal_gains = *target_gains;
 	memset(ncorr_override, 0, sizeof(ncorr_override));
-	for (j = 0; j < iqcal_gainparams_numgains_lcnphy[band_idx]; j++) {
-		if (hash == tbl_iqcal_gainparams_lcnphy[band_idx][j][0]) {
+	for (j = 0; j < iqcal_gainparams_numgains_lcnphy[0]; j++) {
+		if (hash == tbl_iqcal_gainparams_lcnphy[0][j][0]) {
 			cal_gains.gm_gain =
-				tbl_iqcal_gainparams_lcnphy[band_idx][j][1];
+				tbl_iqcal_gainparams_lcnphy[0][j][1];
 			cal_gains.pga_gain =
-				tbl_iqcal_gainparams_lcnphy[band_idx][j][2];
+				tbl_iqcal_gainparams_lcnphy[0][j][2];
 			cal_gains.pad_gain =
-				tbl_iqcal_gainparams_lcnphy[band_idx][j][3];
+				tbl_iqcal_gainparams_lcnphy[0][j][3];
 			memcpy(ncorr_override,
-			       &tbl_iqcal_gainparams_lcnphy[band_idx][j][3],
+			       &tbl_iqcal_gainparams_lcnphy[0][j][3],
 			       sizeof(ncorr_override));
 			break;
 		}
diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index 017d9e03d652..4257b4ca7d6e 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -930,6 +930,8 @@ mwifiex_init_new_priv_params(struct mwifiex_private *priv,
 		return -EOPNOTSUPP;
 	}
 
+	priv->bss_num = mwifiex_get_unused_bss_num(adapter, priv->bss_type);
+
 	spin_lock_irqsave(&adapter->main_proc_lock, flags);
 	adapter->main_locked = false;
 	spin_unlock_irqrestore(&adapter->main_proc_lock, flags);
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 514f2c1124b6..dd6675436bda 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -136,6 +136,9 @@ static struct ieee80211_supported_band band_5ghz = {
 /* Assigned at module init. Guaranteed locally-administered and unicast. */
 static u8 fake_router_bssid[ETH_ALEN] __ro_after_init = {};
 
+#define VIRT_WIFI_SSID "VirtWifi"
+#define VIRT_WIFI_SSID_LEN 8
+
 static void virt_wifi_inform_bss(struct wiphy *wiphy)
 {
 	u64 tsf = div_u64(ktime_get_boottime_ns(), 1000);
@@ -146,8 +149,8 @@ static void virt_wifi_inform_bss(struct wiphy *wiphy)
 		u8 ssid[8];
 	} __packed ssid = {
 		.tag = WLAN_EID_SSID,
-		.len = 8,
-		.ssid = "VirtWifi",
+		.len = VIRT_WIFI_SSID_LEN,
+		.ssid = VIRT_WIFI_SSID,
 	};
 
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
@@ -213,6 +216,8 @@ struct virt_wifi_netdev_priv {
 	struct net_device *upperdev;
 	u32 tx_packets;
 	u32 tx_failed;
+	u32 connect_requested_ssid_len;
+	u8 connect_requested_ssid[IEEE80211_MAX_SSID_LEN];
 	u8 connect_requested_bss[ETH_ALEN];
 	bool is_up;
 	bool is_connected;
@@ -229,6 +234,12 @@ static int virt_wifi_connect(struct wiphy *wiphy, struct net_device *netdev,
 	if (priv->being_deleted || !priv->is_up)
 		return -EBUSY;
 
+	if (!sme->ssid)
+		return -EINVAL;
+
+	priv->connect_requested_ssid_len = sme->ssid_len;
+	memcpy(priv->connect_requested_ssid, sme->ssid, sme->ssid_len);
+
 	could_schedule = schedule_delayed_work(&priv->connect, HZ * 2);
 	if (!could_schedule)
 		return -EBUSY;
@@ -252,12 +263,15 @@ static void virt_wifi_connect_complete(struct work_struct *work)
 		container_of(work, struct virt_wifi_netdev_priv, connect.work);
 	u8 *requested_bss = priv->connect_requested_bss;
 	bool right_addr = ether_addr_equal(requested_bss, fake_router_bssid);
+	bool right_ssid = priv->connect_requested_ssid_len == VIRT_WIFI_SSID_LEN &&
+			  !memcmp(priv->connect_requested_ssid, VIRT_WIFI_SSID,
+				  priv->connect_requested_ssid_len);
 	u16 status = WLAN_STATUS_SUCCESS;
 
 	if (is_zero_ether_addr(requested_bss))
 		requested_bss = NULL;
 
-	if (!priv->is_up || (requested_bss && !right_addr))
+	if (!priv->is_up || (requested_bss && !right_addr) || !right_ssid)
 		status = WLAN_STATUS_UNSPECIFIED_FAILURE;
 	else
 		priv->is_connected = true;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a3ba7e39054..7a363f02625d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -479,22 +479,13 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
-/**
- * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
- * @nvmeq: The queue to use
- * @cmd: The command to send
- * @write_sq: whether to write to the SQ doorbell
- */
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
-			    bool write_sq)
+static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
+				    struct nvme_command *cmd)
 {
-	spin_lock(&nvmeq->sq_lock);
 	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
-	       cmd, sizeof(*cmd));
+		absolute_pointer(cmd), sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	nvme_write_sq_db(nvmeq, write_sq);
-	spin_unlock(&nvmeq->sq_lock);
 }
 
 static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -895,60 +886,73 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	return BLK_STS_OK;
 }
 
-/*
- * NOTE: ns is NULL when called on the admin queue.
- */
-static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
-			 const struct blk_mq_queue_data *bd)
+static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
-	struct nvme_queue *nvmeq = hctx->driver_data;
-	struct nvme_dev *dev = nvmeq->dev;
-	struct request *req = bd->rq;
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct nvme_command *cmnd = &iod->cmd;
 	blk_status_t ret;
 
 	iod->aborted = 0;
 	iod->npages = -1;
 	iod->nents = 0;
 
-	/*
-	 * We should not need to do this, but we're still using this to
-	 * ensure we can drain requests on a dying queue.
-	 */
-	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
-		return BLK_STS_IOERR;
-
-	if (!nvme_check_ready(&dev->ctrl, req, true))
-		return nvme_fail_nonready_command(&dev->ctrl, req);
-
-	ret = nvme_setup_cmd(ns, req);
+	ret = nvme_setup_cmd(req->q->queuedata, req);
 	if (ret)
 		return ret;
 
 	if (blk_rq_nr_phys_segments(req)) {
-		ret = nvme_map_data(dev, req, cmnd);
+		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
 			goto out_free_cmd;
 	}
 
 	if (blk_integrity_rq(req)) {
-		ret = nvme_map_metadata(dev, req, cmnd);
+		ret = nvme_map_metadata(dev, req, &iod->cmd);
 		if (ret)
 			goto out_unmap_data;
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, cmnd, bd->last);
 	return BLK_STS_OK;
 out_unmap_data:
-	nvme_unmap_data(dev, req);
+	if (blk_rq_nr_phys_segments(req))
+		nvme_unmap_data(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
 }
 
+/*
+ * NOTE: ns is NULL when called on the admin queue.
+ */
+static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
+	struct request *req = bd->rq;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	blk_status_t ret;
+
+	/*
+	 * We should not need to do this, but we're still using this to
+	 * ensure we can drain requests on a dying queue.
+	 */
+	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
+		return BLK_STS_IOERR;
+
+	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
+		return nvme_fail_nonready_command(&dev->ctrl, req);
+
+	ret = nvme_prep_rq(dev, req);
+	if (unlikely(ret))
+		return ret;
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	nvme_write_sq_db(nvmeq, bd->last);
+	spin_unlock(&nvmeq->sq_lock);
+	return BLK_STS_OK;
+}
+
 static void nvme_pci_complete_rq(struct request *req)
 {
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
@@ -1109,7 +1113,11 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-	nvme_submit_cmd(nvmeq, &c, true);
+
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &c);
+	nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -2968,6 +2976,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 
diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index d740eba3c099..8400a379186e 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -51,12 +51,12 @@ static int do_active_device(struct ctl_table *table, int write,
 	
 	for (dev = port->devices; dev ; dev = dev->next) {
 		if(dev == port->cad) {
-			len += sprintf(buffer, "%s\n", dev->name);
+			len += snprintf(buffer, sizeof(buffer), "%s\n", dev->name);
 		}
 	}
 
 	if(!len) {
-		len += sprintf(buffer, "%s\n", "none");
+		len += snprintf(buffer, sizeof(buffer), "%s\n", "none");
 	}
 
 	if (len > *lenp)
@@ -87,19 +87,19 @@ static int do_autoprobe(struct ctl_table *table, int write,
 	}
 	
 	if ((str = info->class_name) != NULL)
-		len += sprintf (buffer + len, "CLASS:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
 
 	if ((str = info->model) != NULL)
-		len += sprintf (buffer + len, "MODEL:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
 
 	if ((str = info->mfr) != NULL)
-		len += sprintf (buffer + len, "MANUFACTURER:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "MANUFACTURER:%s;\n", str);
 
 	if ((str = info->description) != NULL)
-		len += sprintf (buffer + len, "DESCRIPTION:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "DESCRIPTION:%s;\n", str);
 
 	if ((str = info->cmdset) != NULL)
-		len += sprintf (buffer + len, "COMMAND SET:%s;\n", str);
+		len += snprintf (buffer + len, sizeof(buffer) - len, "COMMAND SET:%s;\n", str);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -117,7 +117,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 				 void *result, size_t *lenp, loff_t *ppos)
 {
 	struct parport *port = (struct parport *)table->extra1;
-	char buffer[20];
+	char buffer[64];
 	int len = 0;
 
 	if (*ppos) {
@@ -128,7 +128,7 @@ static int do_hardware_base_addr(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%lu\t%lu\n", port->base, port->base_hi);
+	len += snprintf (buffer, sizeof(buffer), "%lu\t%lu\n", port->base, port->base_hi);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -155,7 +155,7 @@ static int do_hardware_irq(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%d\n", port->irq);
+	len += snprintf (buffer, sizeof(buffer), "%d\n", port->irq);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -182,7 +182,7 @@ static int do_hardware_dma(struct ctl_table *table, int write,
 	if (write) /* permissions prevent this anyway */
 		return -EACCES;
 
-	len += sprintf (buffer, "%d\n", port->dma);
+	len += snprintf (buffer, sizeof(buffer), "%d\n", port->dma);
 
 	if (len > *lenp)
 		len = *lenp;
@@ -213,7 +213,7 @@ static int do_hardware_modes(struct ctl_table *table, int write,
 #define printmode(x)							\
 do {									\
 	if (port->modes & PARPORT_MODE_##x)				\
-		len += sprintf(buffer + len, "%s%s", f++ ? "," : "", #x); \
+		len += snprintf(buffer + len, sizeof(buffer) - len, "%s%s", f++ ? "," : "", #x); \
 } while (0)
 		int f = 0;
 		printmode(PCSPP);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f561e87cd5f6..962e700f90f5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -352,6 +352,12 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			if (ret < 0)
 				return ret;
 		} else if (pp->has_msi_ctrl) {
+			u32 ctrl, num_ctrls;
+
+			num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+			for (ctrl = 0; ctrl < num_ctrls; ctrl++)
+				pp->irq_mask[ctrl] = ~0;
+
 			if (!pp->msi_irq) {
 				pp->msi_irq = platform_get_irq_byname_optional(pdev, "msi");
 				if (pp->msi_irq < 0) {
@@ -550,7 +556,6 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 		/* Initialize IRQ Status array */
 		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-			pp->irq_mask[ctrl] = ~0;
 			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
 					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
 					    pp->irq_mask[ctrl]);
diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c9b341e55cbb..b7f848eb2d76 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -148,7 +148,7 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 		return PTR_ERR(rockchip->apb_base);
 
 	rockchip->rst_gpio = devm_gpiod_get_optional(&pdev->dev, "reset",
-						     GPIOD_OUT_HIGH);
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(rockchip->rst_gpio))
 		return PTR_ERR(rockchip->rst_gpio);
 
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 9b15c0130bbb..4325b98993a4 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -707,8 +707,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
 		   PCI_CAPABILITY_LIST) {
 		/* ROM BARs are unimplemented */
 		*val = 0;
-	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
-		   PCI_INTERRUPT_PIN) {
+	} else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
+		   (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
 		/*
 		 * Interrupt Line and Interrupt PIN are hard-wired to zero
 		 * because this front-end only supports message-signaled
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 1aa84035a8bc..bdce1ba7c1bc 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -120,7 +120,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 
 	if (rockchip->is_rc) {
 		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
-							    GPIOD_OUT_HIGH);
+							    GPIOD_OUT_LOW);
 		if (IS_ERR(rockchip->ep_gpio))
 			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
 					     "failed to get ep GPIO\n");
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index d4cd4bd4a088..fb926b300c95 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -993,8 +993,10 @@ static int vpci_scan_bus(void *sysdata)
 	struct epf_ntb *ndev = sysdata;
 
 	vpci_bus = pci_scan_bus(ndev->vbus_number, &vpci_ops, sysdata);
-	if (vpci_bus)
-		pr_err("create pci bus\n");
+	if (!vpci_bus) {
+		pr_err("create pci bus failed\n");
+		return -EINVAL;
+	}
 
 	pci_bus_add_devices(vpci_bus);
 
@@ -1313,10 +1315,14 @@ static int epf_ntb_bind(struct pci_epf *epf)
 		goto err_bar_alloc;
 	}
 
-	vpci_scan_bus(ntb);
+	ret = vpci_scan_bus(ntb);
+	if (ret)
+		goto err_unregister;
 
 	return 0;
 
+err_unregister:
+	pci_unregister_driver(&vntb_pci_driver);
 err_bar_alloc:
 	epf_ntb_config_spad_bar_free(ntb);
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 67216f4ea215..a88909f2ae65 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4916,7 +4916,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 				      int timeout)
 {
 	struct pci_dev *child;
-	int delay;
+	int delay, ret = 0;
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4944,8 +4944,8 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 		return 0;
 	}
 
-	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
-				 bus_list);
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
@@ -4955,7 +4955,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	if (!pci_is_pcie(dev)) {
 		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
 		msleep(1000 + delay);
-		return 0;
+		goto put_child;
 	}
 
 	/*
@@ -4976,7 +4976,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	 * until the timeout expires.
 	 */
 	if (!pcie_downstream_port(dev))
-		return 0;
+		goto put_child;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
@@ -4987,11 +4987,16 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 		if (!pcie_wait_for_link_delay(dev, true, delay)) {
 			/* Did not train, no need to wait any further */
 			pci_info(dev, "Data Link Layer Link Active not set in 1000 msec\n");
-			return -ENOTTY;
+			ret = -ENOTTY;
+			goto put_child;
 		}
 	}
 
-	return pci_dev_wait(child, reset_type, timeout - delay);
+	ret = pci_dev_wait(child, reset_type, timeout - delay);
+
+put_child:
+	pci_dev_put(child);
+	return ret;
 }
 
 void pci_reset_secondary_bus(struct pci_dev *dev)
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 16d291e10627..a159bfdfa251 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -824,11 +824,9 @@ static resource_size_t calculate_memsize(resource_size_t size,
 		size = min_size;
 	if (old_size == 1)
 		old_size = 0;
-	if (size < old_size)
-		size = old_size;
 
-	size = ALIGN(max(size, add_size) + children_add_size, align);
-	return size;
+	size = max(size, add_size) + children_add_size;
+	return ALIGN(max(size, old_size), align);
 }
 
 resource_size_t __weak pcibios_window_alignment(struct pci_bus *bus,
diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 415ace64adc5..8f23146d62bf 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1056,6 +1056,9 @@ static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
 	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
 				       read_val, (read_val & mask) == value, 0,
 				       POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
 	ndelay(100);
 
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index f567805cbde8..8f4cc52b2a06 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2062,6 +2062,14 @@ pinctrl_init_controller(struct pinctrl_desc *pctldesc, struct device *dev,
 	return ERR_PTR(ret);
 }
 
+static void pinctrl_uninit_controller(struct pinctrl_dev *pctldev, struct pinctrl_desc *pctldesc)
+{
+	pinctrl_free_pindescs(pctldev, pctldesc->pins,
+			      pctldesc->npins);
+	mutex_destroy(&pctldev->mutex);
+	kfree(pctldev);
+}
+
 static int pinctrl_claim_hogs(struct pinctrl_dev *pctldev)
 {
 	pctldev->p = create_pinctrl(pctldev->dev, pctldev);
@@ -2142,8 +2150,10 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
 		return pctldev;
 
 	error = pinctrl_enable(pctldev);
-	if (error)
+	if (error) {
+		pinctrl_uninit_controller(pctldev, pctldesc);
 		return ERR_PTR(error);
+	}
 
 	return pctldev;
 }
diff --git a/drivers/pinctrl/freescale/pinctrl-mxs.c b/drivers/pinctrl/freescale/pinctrl-mxs.c
index 735cedd0958a..5b0fcf15f280 100644
--- a/drivers/pinctrl/freescale/pinctrl-mxs.c
+++ b/drivers/pinctrl/freescale/pinctrl-mxs.c
@@ -405,8 +405,8 @@ static int mxs_pinctrl_probe_dt(struct platform_device *pdev,
 	int ret;
 	u32 val;
 
-	child = of_get_next_child(np, NULL);
-	if (!child) {
+	val = of_get_child_count(np);
+	if (val == 0) {
 		dev_err(&pdev->dev, "no group is defined\n");
 		return -ENOENT;
 	}
diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
index 4ff70527755a..790467dcde4f 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -748,9 +748,8 @@ static struct rockchip_mux_route_data rk3308_mux_route_data[] = {
 	RK_MUXROUTE_SAME(0, RK_PC3, 1, 0x314, BIT(16 + 0) | BIT(0)), /* rtc_clk */
 	RK_MUXROUTE_SAME(1, RK_PC6, 2, 0x314, BIT(16 + 2) | BIT(16 + 3)), /* uart2_rxm0 */
 	RK_MUXROUTE_SAME(4, RK_PD2, 2, 0x314, BIT(16 + 2) | BIT(16 + 3) | BIT(2)), /* uart2_rxm1 */
-	RK_MUXROUTE_SAME(0, RK_PB7, 2, 0x608, BIT(16 + 8) | BIT(16 + 9)), /* i2c3_sdam0 */
-	RK_MUXROUTE_SAME(3, RK_PB4, 2, 0x608, BIT(16 + 8) | BIT(16 + 9) | BIT(8)), /* i2c3_sdam1 */
-	RK_MUXROUTE_SAME(2, RK_PA0, 3, 0x608, BIT(16 + 8) | BIT(16 + 9) | BIT(9)), /* i2c3_sdam2 */
+	RK_MUXROUTE_SAME(0, RK_PB7, 2, 0x314, BIT(16 + 4)), /* i2c3_sdam0 */
+	RK_MUXROUTE_SAME(3, RK_PB4, 2, 0x314, BIT(16 + 4) | BIT(4)), /* i2c3_sdam1 */
 	RK_MUXROUTE_SAME(1, RK_PA3, 2, 0x308, BIT(16 + 3)), /* i2s-8ch-1-sclktxm0 */
 	RK_MUXROUTE_SAME(1, RK_PA4, 2, 0x308, BIT(16 + 3)), /* i2s-8ch-1-sclkrxm0 */
 	RK_MUXROUTE_SAME(1, RK_PB5, 2, 0x308, BIT(16 + 3) | BIT(3)), /* i2s-8ch-1-sclktxm1 */
@@ -759,18 +758,6 @@ static struct rockchip_mux_route_data rk3308_mux_route_data[] = {
 	RK_MUXROUTE_SAME(1, RK_PB6, 4, 0x308, BIT(16 + 12) | BIT(16 + 13) | BIT(12)), /* pdm-clkm1 */
 	RK_MUXROUTE_SAME(2, RK_PA6, 2, 0x308, BIT(16 + 12) | BIT(16 + 13) | BIT(13)), /* pdm-clkm2 */
 	RK_MUXROUTE_SAME(2, RK_PA4, 3, 0x600, BIT(16 + 2) | BIT(2)), /* pdm-clkm-m2 */
-	RK_MUXROUTE_SAME(3, RK_PB2, 3, 0x314, BIT(16 + 9)), /* spi1_miso */
-	RK_MUXROUTE_SAME(2, RK_PA4, 2, 0x314, BIT(16 + 9) | BIT(9)), /* spi1_miso_m1 */
-	RK_MUXROUTE_SAME(0, RK_PB3, 3, 0x314, BIT(16 + 10) | BIT(16 + 11)), /* owire_m0 */
-	RK_MUXROUTE_SAME(1, RK_PC6, 7, 0x314, BIT(16 + 10) | BIT(16 + 11) | BIT(10)), /* owire_m1 */
-	RK_MUXROUTE_SAME(2, RK_PA2, 5, 0x314, BIT(16 + 10) | BIT(16 + 11) | BIT(11)), /* owire_m2 */
-	RK_MUXROUTE_SAME(0, RK_PB3, 2, 0x314, BIT(16 + 12) | BIT(16 + 13)), /* can_rxd_m0 */
-	RK_MUXROUTE_SAME(1, RK_PC6, 5, 0x314, BIT(16 + 12) | BIT(16 + 13) | BIT(12)), /* can_rxd_m1 */
-	RK_MUXROUTE_SAME(2, RK_PA2, 4, 0x314, BIT(16 + 12) | BIT(16 + 13) | BIT(13)), /* can_rxd_m2 */
-	RK_MUXROUTE_SAME(1, RK_PC4, 3, 0x314, BIT(16 + 14)), /* mac_rxd0_m0 */
-	RK_MUXROUTE_SAME(4, RK_PA2, 2, 0x314, BIT(16 + 14) | BIT(14)), /* mac_rxd0_m1 */
-	RK_MUXROUTE_SAME(3, RK_PB4, 4, 0x314, BIT(16 + 15)), /* uart3_rx */
-	RK_MUXROUTE_SAME(0, RK_PC1, 3, 0x314, BIT(16 + 15) | BIT(15)), /* uart3_rx_m1 */
 };
 
 static struct rockchip_mux_route_data rk3328_mux_route_data[] = {
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 9ad8f7020614..cd23479f352a 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1328,7 +1328,6 @@ static void pcs_irq_free(struct pcs_device *pcs)
 static void pcs_free_resources(struct pcs_device *pcs)
 {
 	pcs_irq_free(pcs);
-	pinctrl_unregister(pcs->pctl);
 
 #if IS_BUILTIN(CONFIG_PINCTRL_SINGLE)
 	if (pcs->missing_nr_pinctrl_cells)
@@ -1885,7 +1884,7 @@ static int pcs_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto free;
 
-	ret = pinctrl_register_and_init(&pcs->desc, pcs->dev, pcs, &pcs->pctl);
+	ret = devm_pinctrl_register_and_init(pcs->dev, &pcs->desc, pcs, &pcs->pctl);
 	if (ret) {
 		dev_err(pcs->dev, "could not register single pinctrl driver\n");
 		goto free;
@@ -1918,8 +1917,10 @@ static int pcs_probe(struct platform_device *pdev)
 
 	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
 
-	return pinctrl_enable(pcs->pctl);
+	if (pinctrl_enable(pcs->pctl))
+		goto free;
 
+	return 0;
 free:
 	pcs_free_resources(pcs);
 
diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index 4e2382778d38..f3411e3eaf2e 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -883,7 +883,7 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 	iod->desc.name = dev_name(dev);
 	iod->desc.owner = THIS_MODULE;
 
-	ret = pinctrl_register_and_init(&iod->desc, dev, iod, &iod->pctl);
+	ret = devm_pinctrl_register_and_init(dev, &iod->desc, iod, &iod->pctl);
 	if (ret) {
 		dev_err(dev, "Failed to register pinctrl\n");
 		goto exit_out;
@@ -891,7 +891,11 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iod);
 
-	return pinctrl_enable(iod->pctl);
+	ret = pinctrl_enable(iod->pctl);
+	if (ret)
+		goto exit_out;
+
+	return 0;
 
 exit_out:
 	of_node_put(np);
@@ -908,12 +912,6 @@ static int ti_iodelay_remove(struct platform_device *pdev)
 {
 	struct ti_iodelay_device *iod = platform_get_drvdata(pdev);
 
-	if (!iod)
-		return 0;
-
-	if (iod->pctl)
-		pinctrl_unregister(iod->pctl);
-
 	ti_iodelay_pinconf_deinit_dev(iod);
 
 	/* Expect other allocations to be freed by devm */
diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 0dbceee87a4b..2928c3cb3785 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -326,6 +326,7 @@ static int ec_read_version_supported(struct cros_ec_dev *ec)
 	if (!msg)
 		return 0;
 
+	msg->version = 1;
 	msg->command = EC_CMD_GET_CMD_VERSIONS + ec->cmd_offset;
 	msg->outsize = sizeof(*params);
 	msg->insize = sizeof(*response);
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 9d1f431bdc24..818a02c84f76 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -780,9 +780,11 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev,
 	if (ret == -ENOPROTOOPT) {
 		dev_dbg(ec_dev->dev,
 			"GET_NEXT_EVENT returned invalid version error.\n");
+		mutex_lock(&ec_dev->lock);
 		ret = cros_ec_get_host_command_version_mask(ec_dev,
 							EC_CMD_GET_NEXT_EVENT,
 							&ver_mask);
+		mutex_unlock(&ec_dev->lock);
 		if (ret < 0 || ver_mask == 0)
 			/*
 			 * Do not change the MKBP supported version if we can't
diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
index d8c5f9195f85..2ac2f31090f9 100644
--- a/drivers/platform/mips/cpu_hwmon.c
+++ b/drivers/platform/mips/cpu_hwmon.c
@@ -139,6 +139,9 @@ static int __init loongson_hwmon_init(void)
 		csr_temp_enable = csr_readl(LOONGSON_CSR_FEATURES) &
 				  LOONGSON_CSRF_TEMP;
 
+	if (!csr_temp_enable && !loongson_chiptemp[0])
+		return -ENODEV;
+
 	nr_packages = loongson_sysconf.nr_cpus /
 		loongson_sysconf.cores_per_package;
 
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 22378dad4d9f..012c8574ece2 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -168,18 +168,18 @@ static inline int axp288_charger_set_cv(struct axp288_chrg_info *info, int cv)
 	u8 reg_val;
 	int ret;
 
-	if (cv <= CV_4100MV) {
-		reg_val = CHRG_CCCV_CV_4100MV;
-		cv = CV_4100MV;
-	} else if (cv <= CV_4150MV) {
-		reg_val = CHRG_CCCV_CV_4150MV;
-		cv = CV_4150MV;
-	} else if (cv <= CV_4200MV) {
+	if (cv >= CV_4350MV) {
+		reg_val = CHRG_CCCV_CV_4350MV;
+		cv = CV_4350MV;
+	} else if (cv >= CV_4200MV) {
 		reg_val = CHRG_CCCV_CV_4200MV;
 		cv = CV_4200MV;
+	} else if (cv >= CV_4150MV) {
+		reg_val = CHRG_CCCV_CV_4150MV;
+		cv = CV_4150MV;
 	} else {
-		reg_val = CHRG_CCCV_CV_4350MV;
-		cv = CV_4350MV;
+		reg_val = CHRG_CCCV_CV_4100MV;
+		cv = CV_4100MV;
 	}
 
 	reg_val = reg_val << CHRG_CCCV_CV_BIT_POS;
@@ -371,8 +371,8 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 			dev_warn(&info->pdev->dev, "set charge current failed\n");
 		break;
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
-		scaled_val = min(val->intval, info->max_cv);
-		scaled_val = DIV_ROUND_CLOSEST(scaled_val, 1000);
+		scaled_val = DIV_ROUND_CLOSEST(val->intval, 1000);
+		scaled_val = min(scaled_val, info->max_cv);
 		ret = axp288_charger_set_cv(info, scaled_val);
 		if (ret < 0)
 			dev_warn(&info->pdev->dev, "set charge voltage failed\n");
diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 90ac5e59a5d6..8a4729ee1ab1 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1727,7 +1727,7 @@ static int bq24190_probe(struct i2c_client *client,
 
 	bdi->client = client;
 	bdi->dev = dev;
-	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
+	strscpy(bdi->model_name, id->name, sizeof(bdi->model_name));
 	mutex_init(&bdi->f_reg_lock);
 	bdi->f_reg = 0;
 	bdi->ss_reg = BQ24190_REG_SS_VBUS_STAT_MASK; /* impossible state */
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index c40a6548ce7d..2070d107c632 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -452,8 +452,9 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	enabled = pwm->state.enabled;
 
-	if (enabled && !state->enabled) {
-		stm32_pwm_disable(priv, pwm->hwpwm);
+	if (!state->enabled) {
+		if (enabled)
+			stm32_pwm_disable(priv, pwm->hwpwm);
 		return 0;
 	}
 
diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index c4e1ad813e09..d5ce97e75f02 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -588,31 +588,37 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		struct resource res;
 
 		node = of_parse_phandle(np, "memory-region", a);
+		if (!node)
+			continue;
 		/* Not map vdevbuffer, vdevring region */
 		if (!strncmp(node->name, "vdev", strlen("vdev"))) {
 			of_node_put(node);
 			continue;
 		}
 		err = of_address_to_resource(node, 0, &res);
-		of_node_put(node);
 		if (err) {
 			dev_err(dev, "unable to resolve memory region\n");
+			of_node_put(node);
 			return err;
 		}
 
-		if (b >= IMX_RPROC_MEM_MAX)
+		if (b >= IMX_RPROC_MEM_MAX) {
+			of_node_put(node);
 			break;
+		}
 
 		/* Not use resource version, because we might share region */
 		priv->mem[b].cpu_addr = devm_ioremap(&pdev->dev, res.start, resource_size(&res));
 		if (!priv->mem[b].cpu_addr) {
 			dev_err(dev, "failed to remap %pr\n", &res);
+			of_node_put(node);
 			return -ENOMEM;
 		}
 		priv->mem[b].sys_addr = res.start;
 		priv->mem[b].size = resource_size(&res);
 		if (!strcmp(node->name, "rsc-table"))
 			priv->rsc_table = priv->mem[b].cpu_addr;
+		of_node_put(node);
 		b++;
 	}
 
diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index 9a29285246f4..5f26d4728438 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -293,7 +293,7 @@ static void stm32_rproc_mb_vq_work(struct work_struct *work)
 
 	mutex_lock(&rproc->lock);
 
-	if (rproc->state != RPROC_RUNNING)
+	if (rproc->state != RPROC_RUNNING && rproc->state != RPROC_ATTACHED)
 		goto unlock_mutex;
 
 	if (rproc_vq_interrupt(rproc, mb->vq_id) == IRQ_NONE)
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index f49ab45455d7..29c12947e73f 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -274,10 +274,9 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 			return err;
 
 		/* full-function RTCs won't have such missing fields */
-		if (rtc_valid_tm(&alarm->time) == 0) {
-			rtc_add_offset(rtc, &alarm->time);
-			return 0;
-		}
+		err = rtc_valid_tm(&alarm->time);
+		if (!err)
+			goto done;
 
 		/* get the "after" timestamp, to detect wrapped fields */
 		err = rtc_read_time(rtc, &now);
@@ -379,6 +378,8 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	if (err)
 		dev_warn(&rtc->dev, "invalid alarm value: %ptR\n",
 			 &alarm->time);
+	else
+		rtc_add_offset(rtc, &alarm->time);
 
 	return err;
 }
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 178ee5563224..9f776c048a83 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -643,11 +643,10 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 			   size_t count)
 {
 	unsigned char *buf = val;
-	int	retval;
 
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		if (off < 128)
 			*buf++ = CMOS_READ(off);
 		else if (can_bank2)
@@ -657,7 +656,7 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 static int cmos_nvram_write(void *priv, unsigned int off, void *val,
@@ -665,7 +664,6 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 {
 	struct cmos_rtc	*cmos = priv;
 	unsigned char	*buf = val;
-	int		retval;
 
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
@@ -674,7 +672,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	 */
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		/* don't trash RTC registers */
 		if (off == cmos->day_alrm
 				|| off == cmos->mon_alrm
@@ -689,7 +687,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 /*----------------------------------------------------------------*/
diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 182dfa605515..56043479b30b 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -743,14 +743,13 @@ static int isl1208_nvmem_read(void *priv, unsigned int off, void *buf,
 {
 	struct isl1208_state *isl1208 = priv;
 	struct i2c_client *client = to_i2c_client(isl1208->rtc->dev.parent);
-	int ret;
 
 	/* nvmem sanitizes offset/count for us, but count==0 is possible */
 	if (!count)
 		return count;
-	ret = isl1208_i2c_read_regs(client, ISL1208_REG_USR1 + off, buf,
+
+	return isl1208_i2c_read_regs(client, ISL1208_REG_USR1 + off, buf,
 				    count);
-	return ret == 0 ? count : ret;
 }
 
 static int isl1208_nvmem_write(void *priv, unsigned int off, void *buf,
@@ -758,15 +757,13 @@ static int isl1208_nvmem_write(void *priv, unsigned int off, void *buf,
 {
 	struct isl1208_state *isl1208 = priv;
 	struct i2c_client *client = to_i2c_client(isl1208->rtc->dev.parent);
-	int ret;
 
 	/* nvmem sanitizes off/count for us, but count==0 is possible */
 	if (!count)
 		return count;
-	ret = isl1208_i2c_set_regs(client, ISL1208_REG_USR1 + off, buf,
-				   count);
 
-	return ret == 0 ? count : ret;
+	return isl1208_i2c_set_regs(client, ISL1208_REG_USR1 + off, buf,
+				   count);
 }
 
 static const struct nvmem_config isl1208_nvmem_config = {
diff --git a/drivers/s390/char/sclp_sd.c b/drivers/s390/char/sclp_sd.c
index 1e244f78f192..64581433c334 100644
--- a/drivers/s390/char/sclp_sd.c
+++ b/drivers/s390/char/sclp_sd.c
@@ -319,8 +319,14 @@ static int sclp_sd_store_data(struct sclp_sd_data *result, u8 di)
 			  &esize);
 	if (rc) {
 		/* Cancel running request if interrupted */
-		if (rc == -ERESTARTSYS)
-			sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL);
+		if (rc == -ERESTARTSYS) {
+			if (sclp_sd_sync(page, SD_EQ_HALT, di, 0, 0, NULL, NULL)) {
+				pr_warn("Could not stop Store Data request - leaking at least %zu bytes\n",
+					(size_t)dsize * PAGE_SIZE);
+				data = NULL;
+				asce = 0;
+			}
+		}
 		vfree(data);
 		goto out;
 	}
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 859e2c1e38e1..8f88e6e202a0 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2411,6 +2411,17 @@ static int mpi3mr_prepare_sg_scmd(struct mpi3mr_ioc *mrioc,
 		    scmd->sc_data_direction);
 		priv->meta_sg_valid = 1; /* To unmap meta sg DMA */
 	} else {
+		/*
+		 * Some firmware versions byte-swap the REPORT ZONES command
+		 * reply from ATA-ZAC devices by directly accessing in the host
+		 * buffer. This does not respect the default command DMA
+		 * direction and causes IOMMU page faults on some architectures
+		 * with an IOMMU enforcing write mappings (e.g. AMD hosts).
+		 * Avoid such issue by making the REPORT ZONES buffer mapping
+		 * bi-directional.
+		 */
+		if (scmd->cmnd[0] == ZBC_IN && scmd->cmnd[1] == ZI_REPORT_ZONES)
+			scmd->sc_data_direction = DMA_BIDIRECTIONAL;
 		sg_scmd = scsi_sglist(scmd);
 		sges_left = scsi_dma_map(scmd);
 	}
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 8428411ee959..0fc2c355fc37 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2672,6 +2672,22 @@ _base_build_zero_len_sge_ieee(struct MPT3SAS_ADAPTER *ioc, void *paddr)
 	_base_add_sg_single_ieee(paddr, sgl_flags, 0, 0, -1);
 }
 
+static inline int _base_scsi_dma_map(struct scsi_cmnd *cmd)
+{
+	/*
+	 * Some firmware versions byte-swap the REPORT ZONES command reply from
+	 * ATA-ZAC devices by directly accessing in the host buffer. This does
+	 * not respect the default command DMA direction and causes IOMMU page
+	 * faults on some architectures with an IOMMU enforcing write mappings
+	 * (e.g. AMD hosts). Avoid such issue by making the report zones buffer
+	 * mapping bi-directional.
+	 */
+	if (cmd->cmnd[0] == ZBC_IN && cmd->cmnd[1] == ZI_REPORT_ZONES)
+		cmd->sc_data_direction = DMA_BIDIRECTIONAL;
+
+	return scsi_dma_map(cmd);
+}
+
 /**
  * _base_build_sg_scmd - main sg creation routine
  *		pcie_device is unused here!
@@ -2718,7 +2734,7 @@ _base_build_sg_scmd(struct MPT3SAS_ADAPTER *ioc,
 	sgl_flags = sgl_flags << MPI2_SGE_FLAGS_SHIFT;
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 
@@ -2862,7 +2878,7 @@ _base_build_sg_scmd_ieee(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
+	sges_left = _base_scsi_dma_map(scmd);
 	if (sges_left < 0)
 		return -ENOMEM;
 
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 5db43b6b76c5..0d922022a15b 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -324,7 +324,7 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 		    "request_sg_cnt=%x reply_sg_cnt=%x.\n",
 		    bsg_job->request_payload.sg_cnt,
 		    bsg_job->reply_payload.sg_cnt);
-		rval = -EPERM;
+		rval = -ENOBUFS;
 		goto done;
 	}
 
@@ -2966,17 +2966,61 @@ qla24xx_bsg_request(struct bsg_job *bsg_job)
 	return ret;
 }
 
-int
-qla24xx_bsg_timeout(struct bsg_job *bsg_job)
+static bool qla_bsg_found(struct qla_qpair *qpair, struct bsg_job *bsg_job)
 {
+	bool found = false;
 	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
 	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
 	struct qla_hw_data *ha = vha->hw;
-	srb_t *sp;
-	int cnt, que;
+	srb_t *sp = NULL;
+	int cnt;
 	unsigned long flags;
 	struct req_que *req;
 
+	spin_lock_irqsave(qpair->qp_lock_ptr, flags);
+	req = qpair->req;
+
+	for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
+		sp = req->outstanding_cmds[cnt];
+		if (sp &&
+		    (sp->type == SRB_CT_CMD ||
+		     sp->type == SRB_ELS_CMD_HST ||
+		     sp->type == SRB_ELS_CMD_HST_NOLOGIN) &&
+		    sp->u.bsg_job == bsg_job) {
+			req->outstanding_cmds[cnt] = NULL;
+			spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+			if (!ha->flags.eeh_busy && ha->isp_ops->abort_command(sp)) {
+				ql_log(ql_log_warn, vha, 0x7089,
+						"mbx abort_command failed.\n");
+				bsg_reply->result = -EIO;
+			} else {
+				ql_dbg(ql_dbg_user, vha, 0x708a,
+						"mbx abort_command success.\n");
+				bsg_reply->result = 0;
+			}
+			/* ref: INIT */
+			kref_put(&sp->cmd_kref, qla2x00_sp_release);
+
+			found = true;
+			goto done;
+		}
+	}
+	spin_unlock_irqrestore(qpair->qp_lock_ptr, flags);
+
+done:
+	return found;
+}
+
+int
+qla24xx_bsg_timeout(struct bsg_job *bsg_job)
+{
+	struct fc_bsg_reply *bsg_reply = bsg_job->reply;
+	scsi_qla_host_t *vha = shost_priv(fc_bsg_to_shost(bsg_job));
+	struct qla_hw_data *ha = vha->hw;
+	int i;
+	struct qla_qpair *qpair;
+
 	ql_log(ql_log_info, vha, 0x708b, "%s CMD timeout. bsg ptr %p.\n",
 	    __func__, bsg_job);
 
@@ -2986,47 +3030,21 @@ qla24xx_bsg_timeout(struct bsg_job *bsg_job)
 		qla_pci_set_eeh_busy(vha);
 	}
 
+	if (qla_bsg_found(ha->base_qpair, bsg_job))
+		goto done;
+
 	/* find the bsg job from the active list of commands */
-	spin_lock_irqsave(&ha->hardware_lock, flags);
-	for (que = 0; que < ha->max_req_queues; que++) {
-		req = ha->req_q_map[que];
-		if (!req)
+	for (i = 0; i < ha->max_qpairs; i++) {
+		qpair = vha->hw->queue_pair_map[i];
+		if (!qpair)
 			continue;
-
-		for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
-			sp = req->outstanding_cmds[cnt];
-			if (sp &&
-			    (sp->type == SRB_CT_CMD ||
-			     sp->type == SRB_ELS_CMD_HST ||
-			     sp->type == SRB_ELS_CMD_HST_NOLOGIN ||
-			     sp->type == SRB_FXIOCB_BCMD) &&
-			    sp->u.bsg_job == bsg_job) {
-				req->outstanding_cmds[cnt] = NULL;
-				spin_unlock_irqrestore(&ha->hardware_lock, flags);
-
-				if (!ha->flags.eeh_busy && ha->isp_ops->abort_command(sp)) {
-					ql_log(ql_log_warn, vha, 0x7089,
-					    "mbx abort_command failed.\n");
-					bsg_reply->result = -EIO;
-				} else {
-					ql_dbg(ql_dbg_user, vha, 0x708a,
-					    "mbx abort_command success.\n");
-					bsg_reply->result = 0;
-				}
-				spin_lock_irqsave(&ha->hardware_lock, flags);
-				goto done;
-
-			}
-		}
+		if (qla_bsg_found(qpair, bsg_job))
+			goto done;
 	}
-	spin_unlock_irqrestore(&ha->hardware_lock, flags);
+
 	ql_log(ql_log_info, vha, 0x708b, "SRB not found to abort.\n");
 	bsg_reply->result = -ENXIO;
-	return 0;
 
 done:
-	spin_unlock_irqrestore(&ha->hardware_lock, flags);
-	/* ref: INIT */
-	kref_put(&sp->cmd_kref, qla2x00_sp_release);
 	return 0;
 }
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 87ada9b44717..9cec49e6602c 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3264,6 +3264,8 @@ struct fab_scan_rp {
 struct fab_scan {
 	struct fab_scan_rp *l;
 	u32 size;
+	u32 rscn_gen_start;
+	u32 rscn_gen_end;
 	u16 scan_retry;
 #define MAX_SCAN_RETRIES 5
 	enum scan_flags_t scan_flags;
@@ -4971,6 +4973,7 @@ typedef struct scsi_qla_host {
 
 	/* Counter to detect races between ELS and RSCN events */
 	atomic_t		generation_tick;
+	atomic_t		rscn_gen;
 	/* Time when global fcport update has been scheduled */
 	int			total_fcport_update_gen;
 	/* List of pending LOGOs, protected by tgt_mutex */
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index b0f3bf42c340..d0c3710b5cdf 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1709,7 +1709,7 @@ qla2x00_hba_attributes(scsi_qla_host_t *vha, void *entries,
 	eiter->type = cpu_to_be16(FDMI_HBA_OPTION_ROM_VERSION);
 	alen = scnprintf(
 		eiter->a.orom_version, sizeof(eiter->a.orom_version),
-		"%d.%02d", ha->bios_revision[1], ha->bios_revision[0]);
+		"%d.%02d", ha->efi_revision[1], ha->efi_revision[0]);
 	alen += FDMI_ATTR_ALIGNMENT(alen);
 	alen += FDMI_ATTR_TYPELEN(eiter);
 	eiter->len = cpu_to_be16(alen);
@@ -3464,6 +3464,29 @@ static int qla2x00_is_a_vp(scsi_qla_host_t *vha, u64 wwn)
 	return rc;
 }
 
+static bool qla_ok_to_clear_rscn(scsi_qla_host_t *vha, fc_port_t *fcport)
+{
+	u32 rscn_gen;
+
+	rscn_gen = atomic_read(&vha->rscn_gen);
+	ql_dbg(ql_dbg_disc + ql_dbg_verbose, vha, 0x2017,
+	    "%s %d %8phC rscn_gen %x start %x end %x current %x\n",
+	    __func__, __LINE__, fcport->port_name, fcport->rscn_gen,
+	    vha->scan.rscn_gen_start, vha->scan.rscn_gen_end, rscn_gen);
+
+	if (val_is_in_range(fcport->rscn_gen, vha->scan.rscn_gen_start,
+	    vha->scan.rscn_gen_end))
+		/* rscn came in before fabric scan */
+		return true;
+
+	if (val_is_in_range(fcport->rscn_gen, vha->scan.rscn_gen_end, rscn_gen))
+		/* rscn came in after fabric scan */
+		return false;
+
+	/* rare: fcport's scan_needed + rscn_gen must be stale */
+	return true;
+}
+
 void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 {
 	fc_port_t *fcport;
@@ -3577,10 +3600,10 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 				   (fcport->scan_needed &&
 				    fcport->port_type != FCT_INITIATOR &&
 				    fcport->port_type != FCT_NVME_INITIATOR)) {
+				fcport->scan_needed = 0;
 				qlt_schedule_sess_for_deletion(fcport);
 			}
 			fcport->d_id.b24 = rp->id.b24;
-			fcport->scan_needed = 0;
 			break;
 		}
 
@@ -3621,7 +3644,9 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 				do_delete = true;
 			}
 
-			fcport->scan_needed = 0;
+			if (qla_ok_to_clear_rscn(vha, fcport))
+				fcport->scan_needed = 0;
+
 			if (((qla_dual_mode_enabled(vha) ||
 			      qla_ini_mode_enabled(vha)) &&
 			    atomic_read(&fcport->state) == FCS_ONLINE) ||
@@ -3651,7 +3676,9 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 					    fcport->port_name, fcport->loop_id,
 					    fcport->login_retry);
 				}
-				fcport->scan_needed = 0;
+
+				if (qla_ok_to_clear_rscn(vha, fcport))
+					fcport->scan_needed = 0;
 				qla24xx_fcport_handle_login(vha, fcport);
 			}
 		}
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 531e0ea87202..214861459b41 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1845,10 +1845,18 @@ int qla24xx_post_newsess_work(struct scsi_qla_host *vha, port_id_t *id,
 	return qla2x00_post_work(vha, e);
 }
 
+static void qla_rscn_gen_tick(scsi_qla_host_t *vha, u32 *ret_rscn_gen)
+{
+	*ret_rscn_gen = atomic_inc_return(&vha->rscn_gen);
+	/* memory barrier */
+	wmb();
+}
+
 void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 {
 	fc_port_t *fcport;
 	unsigned long flags;
+	u32 rscn_gen;
 
 	switch (ea->id.b.rsvd_1) {
 	case RSCN_PORT_ADDR:
@@ -1877,15 +1885,16 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 					 * Otherwise we're already in the middle of a relogin
 					 */
 					fcport->scan_needed = 1;
-					fcport->rscn_gen++;
+					qla_rscn_gen_tick(vha, &fcport->rscn_gen);
 				}
 			} else {
 				fcport->scan_needed = 1;
-				fcport->rscn_gen++;
+				qla_rscn_gen_tick(vha, &fcport->rscn_gen);
 			}
 		}
 		break;
 	case RSCN_AREA_ADDR:
+		qla_rscn_gen_tick(vha, &rscn_gen);
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (fcport->flags & FCF_FCP2_DEVICE &&
 			    atomic_read(&fcport->state) == FCS_ONLINE)
@@ -1893,11 +1902,12 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 
 			if ((ea->id.b24 & 0xffff00) == (fcport->d_id.b24 & 0xffff00)) {
 				fcport->scan_needed = 1;
-				fcport->rscn_gen++;
+				fcport->rscn_gen = rscn_gen;
 			}
 		}
 		break;
 	case RSCN_DOM_ADDR:
+		qla_rscn_gen_tick(vha, &rscn_gen);
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (fcport->flags & FCF_FCP2_DEVICE &&
 			    atomic_read(&fcport->state) == FCS_ONLINE)
@@ -1905,19 +1915,20 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 
 			if ((ea->id.b24 & 0xff0000) == (fcport->d_id.b24 & 0xff0000)) {
 				fcport->scan_needed = 1;
-				fcport->rscn_gen++;
+				fcport->rscn_gen = rscn_gen;
 			}
 		}
 		break;
 	case RSCN_FAB_ADDR:
 	default:
+		qla_rscn_gen_tick(vha, &rscn_gen);
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (fcport->flags & FCF_FCP2_DEVICE &&
 			    atomic_read(&fcport->state) == FCS_ONLINE)
 				continue;
 
 			fcport->scan_needed = 1;
-			fcport->rscn_gen++;
+			fcport->rscn_gen = rscn_gen;
 		}
 		break;
 	}
@@ -1926,6 +1937,7 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 	if (vha->scan.scan_flags == 0) {
 		ql_dbg(ql_dbg_disc, vha, 0xffff, "%s: schedule\n", __func__);
 		vha->scan.scan_flags |= SF_QUEUED;
+		vha->scan.rscn_gen_start = atomic_read(&vha->rscn_gen);
 		schedule_delayed_work(&vha->scan.scan_work, 5);
 	}
 	spin_unlock_irqrestore(&vha->work_lock, flags);
@@ -6423,6 +6435,8 @@ qla2x00_configure_fabric(scsi_qla_host_t *vha)
 		qlt_do_generation_tick(vha, &discovery_gen);
 
 		if (USE_ASYNC_SCAN(ha)) {
+			/* start of scan begins here */
+			vha->scan.rscn_gen_end = atomic_read(&vha->rscn_gen);
 			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI,
 			    NULL);
 			if (rval)
@@ -8282,15 +8296,21 @@ qla28xx_get_aux_images(
 	struct qla27xx_image_status pri_aux_image_status, sec_aux_image_status;
 	bool valid_pri_image = false, valid_sec_image = false;
 	bool active_pri_image = false, active_sec_image = false;
+	int rc;
 
 	if (!ha->flt_region_aux_img_status_pri) {
 		ql_dbg(ql_dbg_init, vha, 0x018a, "Primary aux image not addressed\n");
 		goto check_sec_image;
 	}
 
-	qla24xx_read_flash_data(vha, (uint32_t *)&pri_aux_image_status,
+	rc = qla24xx_read_flash_data(vha, (uint32_t *)&pri_aux_image_status,
 	    ha->flt_region_aux_img_status_pri,
 	    sizeof(pri_aux_image_status) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a1,
+		    "Unable to read Primary aux image(%x).\n", rc);
+		goto check_sec_image;
+	}
 	qla27xx_print_image(vha, "Primary aux image", &pri_aux_image_status);
 
 	if (qla28xx_check_aux_image_status_signature(&pri_aux_image_status)) {
@@ -8321,9 +8341,15 @@ qla28xx_get_aux_images(
 		goto check_valid_image;
 	}
 
-	qla24xx_read_flash_data(vha, (uint32_t *)&sec_aux_image_status,
+	rc = qla24xx_read_flash_data(vha, (uint32_t *)&sec_aux_image_status,
 	    ha->flt_region_aux_img_status_sec,
 	    sizeof(sec_aux_image_status) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a2,
+		    "Unable to read Secondary aux image(%x).\n", rc);
+		goto check_valid_image;
+	}
+
 	qla27xx_print_image(vha, "Secondary aux image", &sec_aux_image_status);
 
 	if (qla28xx_check_aux_image_status_signature(&sec_aux_image_status)) {
@@ -8380,6 +8406,7 @@ qla27xx_get_active_image(struct scsi_qla_host *vha,
 	struct qla27xx_image_status pri_image_status, sec_image_status;
 	bool valid_pri_image = false, valid_sec_image = false;
 	bool active_pri_image = false, active_sec_image = false;
+	int rc;
 
 	if (!ha->flt_region_img_status_pri) {
 		ql_dbg(ql_dbg_init, vha, 0x018a, "Primary image not addressed\n");
@@ -8421,8 +8448,14 @@ qla27xx_get_active_image(struct scsi_qla_host *vha,
 		goto check_valid_image;
 	}
 
-	qla24xx_read_flash_data(vha, (uint32_t *)(&sec_image_status),
+	rc = qla24xx_read_flash_data(vha, (uint32_t *)(&sec_image_status),
 	    ha->flt_region_img_status_sec, sizeof(sec_image_status) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a3,
+		    "Unable to read Secondary image status(%x).\n", rc);
+		goto check_valid_image;
+	}
+
 	qla27xx_print_image(vha, "Secondary image", &sec_image_status);
 
 	if (qla27xx_check_image_status_signature(&sec_image_status)) {
@@ -8494,11 +8527,10 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 	    "FW: Loading firmware from flash (%x).\n", faddr);
 
 	dcode = (uint32_t *)req->ring;
-	qla24xx_read_flash_data(vha, dcode, faddr, 8);
-	if (qla24xx_risc_firmware_invalid(dcode)) {
+	rval = qla24xx_read_flash_data(vha, dcode, faddr, 8);
+	if (rval || qla24xx_risc_firmware_invalid(dcode)) {
 		ql_log(ql_log_fatal, vha, 0x008c,
-		    "Unable to verify the integrity of flash firmware "
-		    "image.\n");
+		    "Unable to verify the integrity of flash firmware image (rval %x).\n", rval);
 		ql_log(ql_log_fatal, vha, 0x008d,
 		    "Firmware data: %08x %08x %08x %08x.\n",
 		    dcode[0], dcode[1], dcode[2], dcode[3]);
@@ -8512,7 +8544,12 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 	for (j = 0; j < segments; j++) {
 		ql_dbg(ql_dbg_init, vha, 0x008d,
 		    "-> Loading segment %u...\n", j);
-		qla24xx_read_flash_data(vha, dcode, faddr, 10);
+		rval = qla24xx_read_flash_data(vha, dcode, faddr, 10);
+		if (rval) {
+			ql_log(ql_log_fatal, vha, 0x016a,
+			    "-> Unable to read segment addr + size .\n");
+			return QLA_FUNCTION_FAILED;
+		}
 		risc_addr = be32_to_cpu((__force __be32)dcode[2]);
 		risc_size = be32_to_cpu((__force __be32)dcode[3]);
 		if (!*srisc_addr) {
@@ -8528,7 +8565,13 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 			ql_dbg(ql_dbg_init, vha, 0x008e,
 			    "-> Loading fragment %u: %#x <- %#x (%#lx dwords)...\n",
 			    fragment, risc_addr, faddr, dlen);
-			qla24xx_read_flash_data(vha, dcode, faddr, dlen);
+			rval = qla24xx_read_flash_data(vha, dcode, faddr, dlen);
+			if (rval) {
+				ql_log(ql_log_fatal, vha, 0x016b,
+				    "-> Unable to read fragment(faddr %#x dlen %#lx).\n",
+				    faddr, dlen);
+				return QLA_FUNCTION_FAILED;
+			}
 			for (i = 0; i < dlen; i++)
 				dcode[i] = swab32(dcode[i]);
 
@@ -8557,7 +8600,14 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 		fwdt->length = 0;
 
 		dcode = (uint32_t *)req->ring;
-		qla24xx_read_flash_data(vha, dcode, faddr, 7);
+
+		rval = qla24xx_read_flash_data(vha, dcode, faddr, 7);
+		if (rval) {
+			ql_log(ql_log_fatal, vha, 0x016c,
+			    "-> Unable to read template size.\n");
+			goto failed;
+		}
+
 		risc_size = be32_to_cpu((__force __be32)dcode[2]);
 		ql_dbg(ql_dbg_init, vha, 0x0161,
 		    "-> fwdt%u template array at %#x (%#x dwords)\n",
@@ -8583,11 +8633,12 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 		}
 
 		dcode = fwdt->template;
-		qla24xx_read_flash_data(vha, dcode, faddr, risc_size);
+		rval = qla24xx_read_flash_data(vha, dcode, faddr, risc_size);
 
-		if (!qla27xx_fwdt_template_valid(dcode)) {
+		if (rval || !qla27xx_fwdt_template_valid(dcode)) {
 			ql_log(ql_log_warn, vha, 0x0165,
-			    "-> fwdt%u failed template validate\n", j);
+			    "-> fwdt%u failed template validate (rval %x)\n",
+			    j, rval);
 			goto failed;
 		}
 
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index a4a56ab0ba74..ef4b3cc1cd77 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -631,3 +631,11 @@ static inline int qla_mapq_alloc_qp_cpu_map(struct qla_hw_data *ha)
 	}
 	return 0;
 }
+
+static inline bool val_is_in_range(u32 val, u32 start, u32 end)
+{
+	if (val >= start && val <= end)
+		return true;
+	else
+		return false;
+}
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index eb43a5f1b399..aa6aaf7f6b6a 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -180,7 +180,7 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 	atomic_set(&vha->loop_state, LOOP_DOWN);
 	atomic_set(&vha->loop_down_timer, LOOP_DOWN_TIME);
 	list_for_each_entry(fcport, &vha->vp_fcports, list)
-		fcport->logout_on_delete = 0;
+		fcport->logout_on_delete = 1;
 
 	if (!vha->hw->flags.edif_enabled)
 		qla2x00_wait_for_sess_deletion(vha);
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 088e84042efc..9746f6debdcb 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -27,7 +27,10 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 		return 0;
 	}
 
-	if (!vha->nvme_local_port && qla_nvme_register_hba(vha))
+	if (qla_nvme_register_hba(vha))
+		return 0;
+
+	if (!vha->nvme_local_port)
 		return 0;
 
 	if (!(fcport->nvme_prli_service_param &
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index f418d43ee841..24714acfc284 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1861,14 +1861,9 @@ __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
 	for (cnt = 1; cnt < req->num_outstanding_cmds; cnt++) {
 		sp = req->outstanding_cmds[cnt];
 		if (sp) {
-			/*
-			 * perform lockless completion during driver unload
-			 */
 			if (qla2x00_chip_is_down(vha)) {
 				req->outstanding_cmds[cnt] = NULL;
-				spin_unlock_irqrestore(qp->qp_lock_ptr, flags);
 				sp->done(sp, res);
-				spin_lock_irqsave(qp->qp_lock_ptr, flags);
 				continue;
 			}
 
@@ -4634,7 +4629,7 @@ static void
 qla2x00_number_of_exch(scsi_qla_host_t *vha, u32 *ret_cnt, u16 max_cnt)
 {
 	u32 temp;
-	struct init_cb_81xx *icb = (struct init_cb_81xx *)&vha->hw->init_cb;
+	struct init_cb_81xx *icb = (struct init_cb_81xx *)vha->hw->init_cb;
 	*ret_cnt = FW_DEF_EXCHANGES_CNT;
 
 	if (max_cnt > vha->hw->max_exchg)
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index c092a6b1ced4..6d16546e1729 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -555,6 +555,7 @@ qla2xxx_find_flt_start(scsi_qla_host_t *vha, uint32_t *start)
 	struct qla_flt_location *fltl = (void *)req->ring;
 	uint32_t *dcode = (uint32_t *)req->ring;
 	uint8_t *buf = (void *)req->ring, *bcode,  last_image;
+	int rc;
 
 	/*
 	 * FLT-location structure resides after the last PCI region.
@@ -584,14 +585,24 @@ qla2xxx_find_flt_start(scsi_qla_host_t *vha, uint32_t *start)
 	pcihdr = 0;
 	do {
 		/* Verify PCI expansion ROM header. */
-		qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		rc = qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		if (rc) {
+			ql_log(ql_log_info, vha, 0x016d,
+			    "Unable to read PCI Expansion Rom Header (%x).\n", rc);
+			return QLA_FUNCTION_FAILED;
+		}
 		bcode = buf + (pcihdr % 4);
 		if (bcode[0x0] != 0x55 || bcode[0x1] != 0xaa)
 			goto end;
 
 		/* Locate PCI data structure. */
 		pcids = pcihdr + ((bcode[0x19] << 8) | bcode[0x18]);
-		qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		rc = qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		if (rc) {
+			ql_log(ql_log_info, vha, 0x0179,
+			    "Unable to read PCI Data Structure (%x).\n", rc);
+			return QLA_FUNCTION_FAILED;
+		}
 		bcode = buf + (pcihdr % 4);
 
 		/* Validate signature of PCI data structure. */
@@ -606,7 +617,12 @@ qla2xxx_find_flt_start(scsi_qla_host_t *vha, uint32_t *start)
 	} while (!last_image);
 
 	/* Now verify FLT-location structure. */
-	qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, sizeof(*fltl) >> 2);
+	rc = qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, sizeof(*fltl) >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x017a,
+		    "Unable to read FLT (%x).\n", rc);
+		return QLA_FUNCTION_FAILED;
+	}
 	if (memcmp(fltl->sig, "QFLT", 4))
 		goto end;
 
@@ -2605,13 +2621,18 @@ qla24xx_read_optrom_data(struct scsi_qla_host *vha, void *buf,
     uint32_t offset, uint32_t length)
 {
 	struct qla_hw_data *ha = vha->hw;
+	int rc;
 
 	/* Suspend HBA. */
 	scsi_block_requests(vha->host);
 	set_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
 
 	/* Go with read. */
-	qla24xx_read_flash_data(vha, buf, offset >> 2, length >> 2);
+	rc = qla24xx_read_flash_data(vha, buf, offset >> 2, length >> 2);
+	if (rc) {
+		ql_log(ql_log_info, vha, 0x01a0,
+		    "Unable to perform optrom read(%x).\n", rc);
+	}
 
 	/* Resume HBA. */
 	clear_bit(MBX_UPDATE_FLASH_ACTIVE, &ha->mbx_cmd_flags);
@@ -3412,7 +3433,7 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
 	struct active_regions active_regions = { };
 
 	if (IS_P3P_TYPE(ha))
-		return ret;
+		return QLA_SUCCESS;
 
 	if (!mbuf)
 		return QLA_FUNCTION_FAILED;
@@ -3432,20 +3453,31 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
 
 	do {
 		/* Verify PCI expansion ROM header. */
-		qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		ret = qla24xx_read_flash_data(vha, dcode, pcihdr >> 2, 0x20);
+		if (ret) {
+			ql_log(ql_log_info, vha, 0x017d,
+			    "Unable to read PCI EXP Rom Header(%x).\n", ret);
+			return QLA_FUNCTION_FAILED;
+		}
+
 		bcode = mbuf + (pcihdr % 4);
 		if (memcmp(bcode, "\x55\xaa", 2)) {
 			/* No signature */
 			ql_log(ql_log_fatal, vha, 0x0059,
 			    "No matching ROM signature.\n");
-			ret = QLA_FUNCTION_FAILED;
-			break;
+			return QLA_FUNCTION_FAILED;
 		}
 
 		/* Locate PCI data structure. */
 		pcids = pcihdr + ((bcode[0x19] << 8) | bcode[0x18]);
 
-		qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		ret = qla24xx_read_flash_data(vha, dcode, pcids >> 2, 0x20);
+		if (ret) {
+			ql_log(ql_log_info, vha, 0x018e,
+			    "Unable to read PCI Data Structure (%x).\n", ret);
+			return QLA_FUNCTION_FAILED;
+		}
+
 		bcode = mbuf + (pcihdr % 4);
 
 		/* Validate signature of PCI data structure. */
@@ -3454,8 +3486,7 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
 			ql_log(ql_log_fatal, vha, 0x005a,
 			    "PCI data struct not found pcir_adr=%x.\n", pcids);
 			ql_dump_buffer(ql_dbg_init, vha, 0x0059, dcode, 32);
-			ret = QLA_FUNCTION_FAILED;
-			break;
+			return QLA_FUNCTION_FAILED;
 		}
 
 		/* Read version */
@@ -3507,20 +3538,26 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
 			faddr = ha->flt_region_fw_sec;
 	}
 
-	qla24xx_read_flash_data(vha, dcode, faddr, 8);
-	if (qla24xx_risc_firmware_invalid(dcode)) {
-		ql_log(ql_log_warn, vha, 0x005f,
-		    "Unrecognized fw revision at %x.\n",
-		    ha->flt_region_fw * 4);
-		ql_dump_buffer(ql_dbg_init, vha, 0x005f, dcode, 32);
+	ret = qla24xx_read_flash_data(vha, dcode, faddr, 8);
+	if (ret) {
+		ql_log(ql_log_info, vha, 0x019e,
+		    "Unable to read FW version (%x).\n", ret);
+		return ret;
 	} else {
-		for (i = 0; i < 4; i++)
-			ha->fw_revision[i] =
+		if (qla24xx_risc_firmware_invalid(dcode)) {
+			ql_log(ql_log_warn, vha, 0x005f,
+			    "Unrecognized fw revision at %x.\n",
+			    ha->flt_region_fw * 4);
+			ql_dump_buffer(ql_dbg_init, vha, 0x005f, dcode, 32);
+		} else {
+			for (i = 0; i < 4; i++)
+				ha->fw_revision[i] =
 				be32_to_cpu((__force __be32)dcode[4+i]);
-		ql_dbg(ql_dbg_init, vha, 0x0060,
-		    "Firmware revision (flash) %u.%u.%u (%x).\n",
-		    ha->fw_revision[0], ha->fw_revision[1],
-		    ha->fw_revision[2], ha->fw_revision[3]);
+			ql_dbg(ql_dbg_init, vha, 0x0060,
+			    "Firmware revision (flash) %u.%u.%u (%x).\n",
+			    ha->fw_revision[0], ha->fw_revision[1],
+			    ha->fw_revision[2], ha->fw_revision[3]);
+		}
 	}
 
 	/* Check for golden firmware and get version if available */
@@ -3531,18 +3568,23 @@ qla24xx_get_flash_version(scsi_qla_host_t *vha, void *mbuf)
 
 	memset(ha->gold_fw_version, 0, sizeof(ha->gold_fw_version));
 	faddr = ha->flt_region_gold_fw;
-	qla24xx_read_flash_data(vha, dcode, ha->flt_region_gold_fw, 8);
-	if (qla24xx_risc_firmware_invalid(dcode)) {
-		ql_log(ql_log_warn, vha, 0x0056,
-		    "Unrecognized golden fw at %#x.\n", faddr);
-		ql_dump_buffer(ql_dbg_init, vha, 0x0056, dcode, 32);
+	ret = qla24xx_read_flash_data(vha, dcode, ha->flt_region_gold_fw, 8);
+	if (ret) {
+		ql_log(ql_log_info, vha, 0x019f,
+		    "Unable to read Gold FW version (%x).\n", ret);
 		return ret;
-	}
-
-	for (i = 0; i < 4; i++)
-		ha->gold_fw_version[i] =
-			be32_to_cpu((__force __be32)dcode[4+i]);
+	} else {
+		if (qla24xx_risc_firmware_invalid(dcode)) {
+			ql_log(ql_log_warn, vha, 0x0056,
+			    "Unrecognized golden fw at %#x.\n", faddr);
+			ql_dump_buffer(ql_dbg_init, vha, 0x0056, dcode, 32);
+			return QLA_FUNCTION_FAILED;
+		}
 
+		for (i = 0; i < 4; i++)
+			ha->gold_fw_version[i] =
+			   be32_to_cpu((__force __be32)dcode[4+i]);
+	}
 	return ret;
 }
 
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index b7abf1f6410c..e199abc4e617 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3795,11 +3795,16 @@ static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
 			min_sleep_time_us =
 				MIN_DELAY_BEFORE_DME_CMDS_US - delta;
 		else
-			return; /* no more delay required */
+			min_sleep_time_us = 0; /* no more delay required */
 	}
 
-	/* allow sleep for extra 50us if needed */
-	usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	if (min_sleep_time_us > 0) {
+		/* allow sleep for extra 50us if needed */
+		usleep_range(min_sleep_time_us, min_sleep_time_us + 50);
+	}
+
+	/* update the last_dme_cmd_tstamp */
+	hba->last_dme_cmd_tstamp = ktime_get();
 }
 
 /**
diff --git a/drivers/soc/qcom/pdr_interface.c b/drivers/soc/qcom/pdr_interface.c
index 915d5bc3d46e..e20d97d7fb65 100644
--- a/drivers/soc/qcom/pdr_interface.c
+++ b/drivers/soc/qcom/pdr_interface.c
@@ -76,12 +76,12 @@ static int pdr_locator_new_server(struct qmi_handle *qmi,
 					      locator_hdl);
 	struct pdr_service *pds;
 
+	mutex_lock(&pdr->lock);
 	/* Create a local client port for QMI communication */
 	pdr->locator_addr.sq_family = AF_QIPCRTR;
 	pdr->locator_addr.sq_node = svc->node;
 	pdr->locator_addr.sq_port = svc->port;
 
-	mutex_lock(&pdr->lock);
 	pdr->locator_init_complete = true;
 	mutex_unlock(&pdr->lock);
 
@@ -104,10 +104,10 @@ static void pdr_locator_del_server(struct qmi_handle *qmi,
 
 	mutex_lock(&pdr->lock);
 	pdr->locator_init_complete = false;
-	mutex_unlock(&pdr->lock);
 
 	pdr->locator_addr.sq_node = 0;
 	pdr->locator_addr.sq_port = 0;
+	mutex_unlock(&pdr->lock);
 }
 
 static const struct qmi_ops pdr_locator_ops = {
@@ -366,12 +366,14 @@ static int pdr_get_domain_list(struct servreg_get_domain_list_req *req,
 	if (ret < 0)
 		return ret;
 
+	mutex_lock(&pdr->lock);
 	ret = qmi_send_request(&pdr->locator_hdl,
 			       &pdr->locator_addr,
 			       &txn, SERVREG_GET_DOMAIN_LIST_REQ,
 			       SERVREG_GET_DOMAIN_LIST_REQ_MAX_LEN,
 			       servreg_get_domain_list_req_ei,
 			       req);
+	mutex_unlock(&pdr->lock);
 	if (ret < 0) {
 		qmi_txn_cancel(&txn);
 		return ret;
@@ -416,7 +418,7 @@ static int pdr_locate_service(struct pdr_handle *pdr, struct pdr_service *pds)
 		if (ret < 0)
 			goto out;
 
-		for (i = domains_read; i < resp->domain_list_len; i++) {
+		for (i = 0; i < resp->domain_list_len; i++) {
 			entry = &resp->domain_list[i];
 
 			if (strnlen(entry->name, sizeof(entry->name)) == sizeof(entry->name))
diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index b722e28d9ed6..4c9400cf6686 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -608,13 +608,14 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 {
 	struct tcs_group *tcs;
 	int tcs_id;
-	unsigned long flags;
+
+	might_sleep();
 
 	tcs = get_tcs_for_msg(drv, msg);
 	if (IS_ERR(tcs))
 		return PTR_ERR(tcs);
 
-	spin_lock_irqsave(&drv->lock, flags);
+	spin_lock_irq(&drv->lock);
 
 	/* Wait forever for a free tcs. It better be there eventually! */
 	wait_event_lock_irq(drv->tcs_wait,
@@ -632,7 +633,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_ENABLE, tcs_id, 0);
 		enable_tcs_irq(drv, tcs_id, true);
 	}
-	spin_unlock_irqrestore(&drv->lock, flags);
+	spin_unlock_irq(&drv->lock);
 
 	/*
 	 * These two can be done after the lock is released because:
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 01765ee9cdfb..c6df7ac0afeb 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -189,7 +189,6 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	}
 
 	if (state == RPMH_ACTIVE_ONLY_STATE) {
-		WARN_ON(irqs_disabled());
 		ret = rpmh_rsc_send_data(ctrlr_to_drv(ctrlr), &rpm_msg->msg);
 	} else {
 		/* Clean up our call by spoofing tx_done */
diff --git a/drivers/soc/xilinx/zynqmp_pm_domains.c b/drivers/soc/xilinx/zynqmp_pm_domains.c
index 226d343f0a6a..81e8e10f1092 100644
--- a/drivers/soc/xilinx/zynqmp_pm_domains.c
+++ b/drivers/soc/xilinx/zynqmp_pm_domains.c
@@ -152,11 +152,17 @@ static int zynqmp_gpd_power_off(struct generic_pm_domain *domain)
 static int zynqmp_gpd_attach_dev(struct generic_pm_domain *domain,
 				 struct device *dev)
 {
+	struct device_link *link;
 	int ret;
 	struct zynqmp_pm_domain *pd;
 
 	pd = container_of(domain, struct zynqmp_pm_domain, gpd);
 
+	link = device_link_add(dev, &domain->dev, DL_FLAG_SYNC_STATE_ONLY);
+	if (!link)
+		dev_dbg(&domain->dev, "failed to create device link for %s\n",
+			dev_name(dev));
+
 	/* If this is not the first device to attach there is nothing to do */
 	if (domain->device_count)
 		return 0;
@@ -299,9 +305,19 @@ static int zynqmp_gpd_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static void zynqmp_gpd_sync_state(struct device *dev)
+{
+	int ret;
+
+	ret = zynqmp_pm_init_finalize();
+	if (ret)
+		dev_warn(dev, "failed to release power management to firmware\n");
+}
+
 static struct platform_driver zynqmp_power_domain_driver = {
 	.driver	= {
 		.name = "zynqmp_power_controller",
+		.sync_state = zynqmp_gpd_sync_state,
 	},
 	.probe = zynqmp_gpd_probe,
 	.remove = zynqmp_gpd_remove,
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index c556623dae02..2653d29ba829 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -178,8 +178,9 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	u32 pm_api_version;
 	struct mbox_client *client;
 
-	zynqmp_pm_init_finalize();
-	zynqmp_pm_get_api_version(&pm_api_version);
+	ret = zynqmp_pm_get_api_version(&pm_api_version);
+	if (ret)
+		return ret;
 
 	/* Check PM API version number */
 	if (pm_api_version < ZYNQMP_PM_VERSION)
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index c5ff6e8c45be..c21d7959dcd2 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -297,7 +297,7 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
-	unsigned int perclk_rate, scldiv;
+	unsigned int perclk_rate, scldiv, div;
 	u8 prescale;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
@@ -308,8 +308,10 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 		return -EINVAL;
 	}
 
+	div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
+
 	for (prescale = 0; prescale < 8; prescale++) {
-		scldiv = perclk_rate / config.speed_hz / (1 << prescale) - 2;
+		scldiv = div / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale = prescale;
 			break;
diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 922d778df064..0b97e5b97a01 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -8,19 +8,18 @@
  */
 
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/ioctl.h>
 #include <linux/fs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/compat.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/acpi.h>
 
 #include <linux/spi/spi.h>
 #include <linux/spi/spidev.h>
@@ -683,6 +682,7 @@ static const struct file_operations spidev_fops = {
 static struct class *spidev_class;
 
 static const struct spi_device_id spidev_spi_ids[] = {
+	{ .name = "bh2228fv" },
 	{ .name = "dh2228fv" },
 	{ .name = "ltc2488" },
 	{ .name = "sx1301" },
@@ -691,29 +691,45 @@ static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = "m53cpld" },
 	{ .name = "spi-petra" },
 	{ .name = "spi-authenta" },
+	{ .name = "em3581" },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, spidev_spi_ids);
 
-#ifdef CONFIG_OF
+/*
+ * spidev should never be referenced in DT without a specific compatible string,
+ * it is a Linux implementation thing rather than a description of the hardware.
+ */
+static int spidev_of_check(struct device *dev)
+{
+	if (device_property_match_string(dev, "compatible", "spidev") < 0)
+		return 0;
+
+	dev_err(dev, "spidev listed directly in DT is not supported\n");
+	return -EINVAL;
+}
+
 static const struct of_device_id spidev_dt_ids[] = {
-	{ .compatible = "rohm,dh2228fv" },
-	{ .compatible = "lineartechnology,ltc2488" },
-	{ .compatible = "semtech,sx1301" },
-	{ .compatible = "lwn,bk4" },
-	{ .compatible = "dh,dhcom-board" },
-	{ .compatible = "menlo,m53cpld" },
-	{ .compatible = "cisco,spi-petra" },
-	{ .compatible = "micron,spi-authenta" },
+	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
+	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
+	{ .compatible = "lineartechnology,ltc2488", .data = &spidev_of_check },
+	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
+	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
+	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "rohm,bh2228fv", .data = &spidev_of_check },
+	{ .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
+	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
+	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
 	{},
 };
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
-#endif
-
-#ifdef CONFIG_ACPI
 
 /* Dummy SPI devices not to be used in production systems */
-#define SPIDEV_ACPI_DUMMY	1
+static int spidev_acpi_check(struct device *dev)
+{
+	dev_warn(dev, "do not use this driver in production systems!\n");
+	return 0;
+}
 
 static const struct acpi_device_id spidev_acpi_ids[] = {
 	/*
@@ -722,49 +738,28 @@ static const struct acpi_device_id spidev_acpi_ids[] = {
 	 * description of the connected peripheral and they should also use
 	 * a proper driver instead of poking directly to the SPI bus.
 	 */
-	{ "SPT0001", SPIDEV_ACPI_DUMMY },
-	{ "SPT0002", SPIDEV_ACPI_DUMMY },
-	{ "SPT0003", SPIDEV_ACPI_DUMMY },
+	{ "SPT0001", (kernel_ulong_t)&spidev_acpi_check },
+	{ "SPT0002", (kernel_ulong_t)&spidev_acpi_check },
+	{ "SPT0003", (kernel_ulong_t)&spidev_acpi_check },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spidev_acpi_ids);
 
-static void spidev_probe_acpi(struct spi_device *spi)
-{
-	const struct acpi_device_id *id;
-
-	if (!has_acpi_companion(&spi->dev))
-		return;
-
-	id = acpi_match_device(spidev_acpi_ids, &spi->dev);
-	if (WARN_ON(!id))
-		return;
-
-	if (id->driver_data == SPIDEV_ACPI_DUMMY)
-		dev_warn(&spi->dev, "do not use this driver in production systems!\n");
-}
-#else
-static inline void spidev_probe_acpi(struct spi_device *spi) {}
-#endif
-
 /*-------------------------------------------------------------------------*/
 
 static int spidev_probe(struct spi_device *spi)
 {
+	int (*match)(struct device *dev);
 	struct spidev_data	*spidev;
 	int			status;
 	unsigned long		minor;
 
-	/*
-	 * spidev should never be referenced in DT without a specific
-	 * compatible string, it is a Linux implementation thing
-	 * rather than a description of the hardware.
-	 */
-	WARN(spi->dev.of_node &&
-	     of_device_is_compatible(spi->dev.of_node, "spidev"),
-	     "%pOF: buggy DT: spidev listed directly in DT\n", spi->dev.of_node);
-
-	spidev_probe_acpi(spi);
+	match = device_get_match_data(&spi->dev);
+	if (match) {
+		status = match(&spi->dev);
+		if (status)
+			return status;
+	}
 
 	/* Allocate driver data */
 	spidev = kzalloc(sizeof(*spidev), GFP_KERNEL);
@@ -835,8 +830,8 @@ static int spidev_remove(struct spi_device *spi)
 static struct spi_driver spidev_spi_driver = {
 	.driver = {
 		.name =		"spidev",
-		.of_match_table = of_match_ptr(spidev_dt_ids),
-		.acpi_match_table = ACPI_PTR(spidev_acpi_ids),
+		.of_match_table = spidev_dt_ids,
+		.acpi_match_table = spidev_acpi_ids,
 	},
 	.probe =	spidev_probe,
 	.remove =	spidev_remove,
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b638b2fd2d3d..7cd12ea88c0b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -836,6 +836,14 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	new_flags = (__force upf_t)new_info->flags;
 	old_custom_divisor = uport->custom_divisor;
 
+	if (!(uport->flags & UPF_FIXED_PORT)) {
+		unsigned int uartclk = new_info->baud_base * 16;
+		/* check needs to be done here before other settings made */
+		if (uartclk == 0) {
+			retval = -EINVAL;
+			goto exit;
+		}
+	}
 	if (!capable(CAP_SYS_ADMIN)) {
 		retval = -EPERM;
 		if (change_irq || change_port ||
diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 5e34a7ff1b63..6bd908c7bfe6 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -474,15 +474,24 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 	struct usb_ep *ep, *ep_fback;
 	struct uac_rtd_params *prm;
 	struct uac_params *params = &audio_dev->params;
-	int req_len, i;
+	int req_len, i, ret;
 
 	ep = audio_dev->out_ep;
 	prm = &uac->c_prm;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed for out_ep failed (%d)\n", ret);
+		return ret;
+	}
+
 	req_len = ep->maxpacket;
 
 	prm->ep_enabled = true;
-	usb_ep_enable(ep);
+	ret = usb_ep_enable(ep);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for out_ep (%d)\n", ret);
+		return ret;
+	}
 
 	for (i = 0; i < params->req_number; i++) {
 		if (!prm->reqs[i]) {
@@ -508,9 +517,18 @@ int u_audio_start_capture(struct g_audio *audio_dev)
 		return 0;
 
 	/* Setup feedback endpoint */
-	config_ep_by_speed(gadget, &audio_dev->func, ep_fback);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep_fback);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed in_ep_fback failed (%d)\n", ret);
+		return ret; // TODO: Clean up out_ep
+	}
+
 	prm->fb_ep_enabled = true;
-	usb_ep_enable(ep_fback);
+	ret = usb_ep_enable(ep_fback);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for in_ep_fback (%d)\n", ret);
+		return ret; // TODO: Clean up out_ep
+	}
 	req_len = ep_fback->maxpacket;
 
 	req_fback = usb_ep_alloc_request(ep_fback, GFP_ATOMIC);
@@ -565,11 +583,15 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	struct uac_params *params = &audio_dev->params;
 	unsigned int factor;
 	const struct usb_endpoint_descriptor *ep_desc;
-	int req_len, i;
+	int req_len, i, ret;
 
 	ep = audio_dev->in_ep;
 	prm = &uac->p_prm;
-	config_ep_by_speed(gadget, &audio_dev->func, ep);
+	ret = config_ep_by_speed(gadget, &audio_dev->func, ep);
+	if (ret < 0) {
+		dev_err(dev, "config_ep_by_speed for in_ep failed (%d)\n", ret);
+		return ret;
+	}
 
 	ep_desc = ep->desc;
 
@@ -598,7 +620,11 @@ int u_audio_start_playback(struct g_audio *audio_dev)
 	uac->p_residue = 0;
 
 	prm->ep_enabled = true;
-	usb_ep_enable(ep);
+	ret = usb_ep_enable(ep);
+	if (ret < 0) {
+		dev_err(dev, "usb_ep_enable failed for in_ep (%d)\n", ret);
+		return ret;
+	}
 
 	for (i = 0; i < params->req_number; i++) {
 		if (!prm->reqs[i]) {
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index f975dc03a190..5111fcc0cac3 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1436,6 +1436,7 @@ void gserial_suspend(struct gserial *gser)
 	spin_lock(&port->port_lock);
 	spin_unlock(&serial_port_lock);
 	port->suspended = true;
+	port->start_delayed = true;
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 EXPORT_SYMBOL_GPL(gserial_suspend);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 808a8d062e6a..d865c4677ad7 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -101,12 +101,10 @@ int usb_ep_enable(struct usb_ep *ep)
 		goto out;
 
 	/* UDC drivers can't handle endpoints with maxpacket size 0 */
-	if (usb_endpoint_maxp(ep->desc) == 0) {
-		/*
-		 * We should log an error message here, but we can't call
-		 * dev_err() because there's no way to find the gadget
-		 * given only ep.
-		 */
+	if (!ep->desc || usb_endpoint_maxp(ep->desc) == 0) {
+		WARN_ONCE(1, "%s: ep%d (%s) has %s\n", __func__, ep->address, ep->name,
+			  (!ep->desc) ? "NULL descriptor" : "maxpacket 0");
+
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
index aaf4813e4971..406cb326e812 100644
--- a/drivers/usb/serial/usb_debug.c
+++ b/drivers/usb/serial/usb_debug.c
@@ -69,6 +69,11 @@ static void usb_debug_process_read_urb(struct urb *urb)
 	usb_serial_generic_process_read_urb(urb);
 }
 
+static void usb_debug_init_termios(struct tty_struct *tty)
+{
+	tty->termios.c_lflag &= ~(ECHO | ECHONL);
+}
+
 static struct usb_serial_driver debug_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
@@ -78,6 +83,7 @@ static struct usb_serial_driver debug_device = {
 	.num_ports =		1,
 	.bulk_out_size =	USB_DEBUG_MAX_PACKET_SIZE,
 	.break_ctl =		usb_debug_break_ctl,
+	.init_termios =		usb_debug_init_termios,
 	.process_read_urb =	usb_debug_process_read_urb,
 };
 
@@ -89,6 +95,7 @@ static struct usb_serial_driver dbc_device = {
 	.id_table =		dbc_id_table,
 	.num_ports =		1,
 	.break_ctl =		usb_debug_break_ctl,
+	.init_termios =		usb_debug_init_termios,
 	.process_read_urb =	usb_debug_process_read_urb,
 };
 
diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 233265550fc6..6b98f5ab6dfe 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -745,6 +745,7 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 	 *
 	 */
 	if (usb_pipedevice(urb->pipe) == 0) {
+		struct usb_device *old;
 		__u8 type = usb_pipetype(urb->pipe);
 		struct usb_ctrlrequest *ctrlreq =
 			(struct usb_ctrlrequest *) urb->setup_packet;
@@ -755,14 +756,15 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 			goto no_need_xmit;
 		}
 
+		old = vdev->udev;
 		switch (ctrlreq->bRequest) {
 		case USB_REQ_SET_ADDRESS:
 			/* set_address may come when a device is reset */
 			dev_info(dev, "SetAddress Request (%d) to port %d\n",
 				 ctrlreq->wValue, vdev->rhport);
 
-			usb_put_dev(vdev->udev);
 			vdev->udev = usb_get_dev(urb->dev);
+			usb_put_dev(old);
 
 			spin_lock(&vdev->ud.lock);
 			vdev->ud.status = VDEV_ST_USED;
@@ -781,8 +783,8 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 				usbip_dbg_vhci_hc(
 					"Not yet?:Get_Descriptor to device 0 (get max pipe size)\n");
 
-			usb_put_dev(vdev->udev);
 			vdev->udev = usb_get_dev(urb->dev);
+			usb_put_dev(old);
 			goto out;
 
 		default:
@@ -1067,6 +1069,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 static void vhci_device_reset(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	struct usb_device *old = vdev->udev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ud->lock, flags);
@@ -1074,8 +1077,8 @@ static void vhci_device_reset(struct usbip_device *ud)
 	vdev->speed  = 0;
 	vdev->devid  = 0;
 
-	usb_put_dev(vdev->udev);
 	vdev->udev = NULL;
+	usb_put_dev(old);
 
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 9ca8b92d92ae..019e8c9bedff 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1059,13 +1059,7 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
 
 	notify = ops->get_vq_notification(vdpa, index);
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
-			    PFN_DOWN(notify.addr), PAGE_SIZE,
-			    vma->vm_page_prot))
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, vmf->address & PAGE_MASK, PFN_DOWN(notify.addr));
 }
 
 static const struct vm_operations_struct vhost_vdpa_vm_ops = {
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 74ac0c28fe43..531e3e139c0d 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -684,6 +684,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	}
 
 	vsock->guest_cid = 0; /* no CID assigned yet */
+	vsock->seqpacket_allow = false;
 
 	atomic_set(&vsock->queued_replies, 0);
 
@@ -842,8 +843,7 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 			goto err;
 	}
 
-	if (features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
-		vsock->seqpacket_allow = true;
+	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
 
 	for (i = 0; i < ARRAY_SIZE(vsock->vqs); i++) {
 		vq = &vsock->vqs[i];
diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 7ca3e0db06ff..250651cdce0a 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -76,8 +76,10 @@
 
 #ifdef CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET
 #define DATA_START_OFFSET_WORDS		(0)
+#define MAX_SHARED_LIBS_UPDATE		(0)
 #else
 #define DATA_START_OFFSET_WORDS		(MAX_SHARED_LIBS)
+#define MAX_SHARED_LIBS_UPDATE		(MAX_SHARED_LIBS)
 #endif
 
 struct lib_info {
@@ -991,7 +993,7 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		return res;
 
 	/* Update data segment pointers for all libraries */
-	for (i = 0; i < MAX_SHARED_LIBS; i++) {
+	for (i = 0; i < MAX_SHARED_LIBS_UPDATE; i++) {
 		if (!libinfo.lib_list[i].loaded)
 			continue;
 		for (j = 0; j < MAX_SHARED_LIBS; j++) {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 17ebcf19b444..f19c6aa3ea4b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1383,6 +1383,7 @@ struct btrfs_drop_extents_args {
 struct btrfs_file_private {
 	void *filldir_buf;
 	u64 last_index;
+	bool fsync_skip_inode_lock;
 };
 
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index eae622ef4c6d..c44dfb4370d7 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1983,22 +1983,38 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	 * So here we disable page faults in the iov_iter and then retry if we
 	 * got -EFAULT, faulting in the pages before the retry.
 	 */
+again:
 	from->nofault = true;
 	dio = __iomap_dio_rw(iocb, from, &btrfs_dio_iomap_ops, &btrfs_dio_ops,
 			     IOMAP_DIO_PARTIAL, written);
 	from->nofault = false;
 
-	/*
-	 * iomap_dio_complete() will call btrfs_sync_file() if we have a dsync
-	 * iocb, and that needs to lock the inode. So unlock it before calling
-	 * iomap_dio_complete() to avoid a deadlock.
-	 */
-	btrfs_inode_unlock(inode, ilock_flags);
-
-	if (IS_ERR_OR_NULL(dio))
+	if (IS_ERR_OR_NULL(dio)) {
 		err = PTR_ERR_OR_ZERO(dio);
-	else
+	} else {
+		struct btrfs_file_private stack_private = { 0 };
+		struct btrfs_file_private *private;
+		const bool have_private = (file->private_data != NULL);
+
+		if (!have_private)
+			file->private_data = &stack_private;
+
+		/*
+		 * If we have a synchoronous write, we must make sure the fsync
+		 * triggered by the iomap_dio_complete() call below doesn't
+		 * deadlock on the inode lock - we are already holding it and we
+		 * can't call it after unlocking because we may need to complete
+		 * partial writes due to the input buffer (or parts of it) not
+		 * being already faulted in.
+		 */
+		private = file->private_data;
+		private->fsync_skip_inode_lock = true;
 		err = iomap_dio_complete(dio);
+		private->fsync_skip_inode_lock = false;
+
+		if (!have_private)
+			file->private_data = NULL;
+	}
 
 	/* No increment (+=) because iomap returns a cumulative value. */
 	if (err > 0)
@@ -2025,10 +2041,12 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		} else {
 			fault_in_iov_iter_readable(from, left);
 			prev_left = left;
-			goto relock;
+			goto again;
 		}
 	}
 
+	btrfs_inode_unlock(inode, ilock_flags);
+
 	/* If 'err' is -ENOTBLK then it means we must fallback to buffered IO. */
 	if ((err < 0 && err != -ENOTBLK) || !iov_iter_count(from))
 		goto out;
@@ -2177,6 +2195,7 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
  */
 int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
+	struct btrfs_file_private *private = file->private_data;
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -2186,6 +2205,7 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0, err;
 	u64 len;
 	bool full_sync;
+	const bool skip_ilock = (private ? private->fsync_skip_inode_lock : false);
 
 	trace_btrfs_sync_file(file, datasync);
 
@@ -2213,7 +2233,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (ret)
 		goto out;
 
-	btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		down_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_lock(inode, BTRFS_ILOCK_MMAP);
 
 	atomic_inc(&root->log_batch);
 
@@ -2245,7 +2268,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 */
 	ret = start_ordered_ops(inode, start, end);
 	if (ret) {
-		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+		if (skip_ilock)
+			up_write(&BTRFS_I(inode)->i_mmap_lock);
+		else
+			btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 		goto out;
 	}
 
@@ -2337,7 +2363,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 * file again, but that will end up using the synchronization
 	 * inside btrfs_sync_log to keep things safe.
 	 */
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 
 	if (ret == BTRFS_NO_LOG_SYNC) {
 		ret = btrfs_end_transaction(trans);
@@ -2404,7 +2433,10 @@ int btrfs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 
 out_release_extents:
 	btrfs_release_log_ctx_extents(&ctx);
-	btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
+	if (skip_ilock)
+		up_write(&BTRFS_I(inode)->i_mmap_lock);
+	else
+		btrfs_inode_unlock(inode, BTRFS_ILOCK_MMAP);
 	goto out;
 }
 
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 9161bc4f4064..0004488eeb06 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -829,6 +829,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 1723ec21cd47..b5ed6d9a19f4 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -783,7 +783,8 @@ static int __init init_caches(void)
 	if (!ceph_mds_request_cachep)
 		goto bad_mds_req;
 
-	ceph_wb_pagevec_pool = mempool_create_kmalloc_pool(10, CEPH_MAX_WRITE_SIZE >> PAGE_SHIFT);
+	ceph_wb_pagevec_pool = mempool_create_kmalloc_pool(10,
+	    (CEPH_MAX_WRITE_SIZE >> PAGE_SHIFT) * sizeof(struct page *));
 	if (!ceph_wb_pagevec_pool)
 		goto bad_pagevec_pool;
 
diff --git a/fs/exec.c b/fs/exec.c
index 03516b704d8a..05c47a168b7b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1603,6 +1603,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	unsigned int mode;
 	kuid_t uid;
 	kgid_t gid;
+	int err;
 
 	if (!mnt_may_suid(file->f_path.mnt))
 		return;
@@ -1620,12 +1621,17 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
-	/* reload atomically mode/uid/gid now that lock held */
+	/* Atomically reload and check mode/uid/gid now that lock held. */
 	mode = inode->i_mode;
 	uid = i_uid_into_mnt(mnt_userns, inode);
 	gid = i_gid_into_mnt(mnt_userns, inode);
+	err = inode_permission(mnt_userns, inode, MAY_EXEC);
 	inode_unlock(inode);
 
+	/* Did the exec bit vanish out from under us? Give up. */
+	if (err)
+		return;
+
 	/* We ignore suid/sgid if there are no mappings for them in the ns */
 	if (!kuid_has_mapping(bprm->cred->user_ns, uid) ||
 		 !kgid_has_mapping(bprm->cred->user_ns, gid))
diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index c17ccc19b938..9bf086821eb3 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -79,26 +79,33 @@ static int ext2_valid_block_bitmap(struct super_block *sb,
 	ext2_grpblk_t next_zero_bit;
 	ext2_fsblk_t bitmap_blk;
 	ext2_fsblk_t group_first_block;
+	ext2_grpblk_t max_bit;
 
 	group_first_block = ext2_group_first_block_no(sb, block_group);
+	max_bit = ext2_group_last_block_no(sb, block_group) - group_first_block;
 
 	/* check whether block bitmap block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_block_bitmap);
 	offset = bitmap_blk - group_first_block;
-	if (!ext2_test_bit(offset, bh->b_data))
+	if (offset < 0 || offset > max_bit ||
+	    !ext2_test_bit(offset, bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode bitmap block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_inode_bitmap);
 	offset = bitmap_blk - group_first_block;
-	if (!ext2_test_bit(offset, bh->b_data))
+	if (offset < 0 || offset > max_bit ||
+	    !ext2_test_bit(offset, bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
 
 	/* check whether the inode table block number is set */
 	bitmap_blk = le32_to_cpu(desc->bg_inode_table);
 	offset = bitmap_blk - group_first_block;
+	if (offset < 0 || offset > max_bit ||
+	    offset + EXT2_SB(sb)->s_itb_per_group - 1 > max_bit)
+		goto err_out;
 	next_zero_bit = ext2_find_next_zero_bit(bh->b_data,
 				offset + EXT2_SB(sb)->s_itb_per_group,
 				offset);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index cece004b32d5..6c41bf322315 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3112,8 +3112,9 @@ static int ext4_zeroout_es(struct inode *inode, struct ext4_extent *ex)
 	if (ee_len == 0)
 		return 0;
 
-	return ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
-				     EXTENT_STATUS_WRITTEN);
+	ext4_es_insert_extent(inode, ee_block, ee_len, ee_pblock,
+			      EXTENT_STATUS_WRITTEN);
+	return 0;
 }
 
 /* FIXME!! we need to try to merge to left or right after zero-out  */
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index cccbdfd49a86..be3b3ccbf70b 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -312,6 +312,8 @@ void ext4_es_find_extent_range(struct inode *inode,
 			       ext4_lblk_t lblk, ext4_lblk_t end,
 			       struct extent_status *es)
 {
+	es->es_lblk = es->es_len = es->es_pblk = 0;
+
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
@@ -846,12 +848,10 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
 /*
  * ext4_es_insert_extent() adds information to an inode's extent
  * status tree.
- *
- * Return 0 on success, error code on failure.
  */
-int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-			  ext4_lblk_t len, ext4_fsblk_t pblk,
-			  unsigned int status)
+void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+			   ext4_lblk_t len, ext4_fsblk_t pblk,
+			   unsigned int status)
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
@@ -863,13 +863,13 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	bool revise_pending = false;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
-		return 0;
+		return;
 
 	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, inode->i_ino);
 
 	if (!len)
-		return 0;
+		return;
 
 	BUG_ON(end < lblk);
 
@@ -938,7 +938,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		goto retry;
 
 	ext4_es_print_tree(inode);
-	return 0;
+	return;
 }
 
 /*
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 4ec30a798260..481ec4381bee 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -127,9 +127,9 @@ extern int __init ext4_init_es(void);
 extern void ext4_exit_es(void);
 extern void ext4_es_init_tree(struct ext4_es_tree *tree);
 
-extern int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
-				 ext4_lblk_t len, ext4_fsblk_t pblk,
-				 unsigned int status);
+extern void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
+				  ext4_lblk_t len, ext4_fsblk_t pblk,
+				  unsigned int status);
 extern void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t len, ext4_fsblk_t pblk,
 				 unsigned int status);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 2660c34c770e..e81b886d9c67 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -353,13 +353,6 @@ static int ext4_fc_track_template(
 	tid_t tid = 0;
 	int ret;
 
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (sbi->s_mount_state & EXT4_FC_REPLAY))
-		return -EOPNOTSUPP;
-
-	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
-		return -EINVAL;
-
 	tid = handle->h_transaction->t_tid;
 	mutex_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
@@ -468,7 +461,17 @@ void __ext4_fc_track_unlink(handle_t *handle,
 
 void ext4_fc_track_unlink(handle_t *handle, struct dentry *dentry)
 {
-	__ext4_fc_track_unlink(handle, d_inode(dentry), dentry);
+	struct inode *inode = d_inode(dentry);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
+	__ext4_fc_track_unlink(handle, inode, dentry);
 }
 
 void __ext4_fc_track_link(handle_t *handle,
@@ -487,7 +490,17 @@ void __ext4_fc_track_link(handle_t *handle,
 
 void ext4_fc_track_link(handle_t *handle, struct dentry *dentry)
 {
-	__ext4_fc_track_link(handle, d_inode(dentry), dentry);
+	struct inode *inode = d_inode(dentry);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
+	__ext4_fc_track_link(handle, inode, dentry);
 }
 
 void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
@@ -506,7 +519,17 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
 {
-	__ext4_fc_track_create(handle, d_inode(dentry), dentry);
+	struct inode *inode = d_inode(dentry);
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
+	__ext4_fc_track_create(handle, inode, dentry);
 }
 
 /* __track_fn for inode tracking */
@@ -522,6 +545,7 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -533,6 +557,13 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		return;
 	}
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(inode, ret);
 }
@@ -572,12 +603,26 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t start,
 			 ext4_lblk_t end)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct __track_range_args args;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
 		return;
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (sbi->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE))
+		return;
+
+	if (ext4_has_inline_data(inode)) {
+		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_XATTR,
+					handle);
+		return;
+	}
+
 	args.start = start;
 	args.end = end;
 
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 6fe665de1b20..bc7f6417888d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1446,7 +1446,11 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 			hinfo->hash = EXT4_DIRENT_HASH(de);
 			hinfo->minor_hash = EXT4_DIRENT_MINOR_HASH(de);
 		} else {
-			ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			err = ext4fs_dirhash(dir, de->name, de->name_len, hinfo);
+			if (err) {
+				ret = err;
+				goto out;
+			}
 		}
 		if ((hinfo->hash < start_hash) ||
 		    ((hinfo->hash == start_hash) &&
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 64a783f22105..e765c0d05fea 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -484,6 +484,35 @@ static void ext4_map_blocks_es_recheck(handle_t *handle,
 }
 #endif /* ES_AGGRESSIVE_TEST */
 
+static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
+				 struct ext4_map_blocks *map)
+{
+	unsigned int status;
+	int retval;
+
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		retval = ext4_ext_map_blocks(handle, inode, map, 0);
+	else
+		retval = ext4_ind_map_blocks(handle, inode, map, 0);
+
+	if (retval <= 0)
+		return retval;
+
+	if (unlikely(retval != map->m_len)) {
+		ext4_warning(inode->i_sb,
+			     "ES len assertion failed for inode "
+			     "%lu: retval %d != map->m_len %d",
+			     inode->i_ino, retval, map->m_len);
+		WARN_ON(1);
+	}
+
+	status = map->m_flags & EXT4_MAP_UNWRITTEN ?
+			EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
+	ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+			      map->m_pblk, status);
+	return retval;
+}
+
 /*
  * The ext4_map_blocks() function tries to look up the requested blocks,
  * and returns if the blocks are already mapped.
@@ -589,10 +618,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk,
-					    map->m_len, map->m_pblk, status);
-		if (ret < 0)
-			retval = ret;
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 	up_read((&EXT4_I(inode)->i_data_sem));
 
@@ -701,12 +728,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		    ext4_es_scan_range(inode, &ext4_es_is_delayed, map->m_lblk,
 				       map->m_lblk + map->m_len - 1))
 			status |= EXTENT_STATUS_DELAYED;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret < 0) {
-			retval = ret;
-			goto out_sem;
-		}
+		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
+				      map->m_pblk, status);
 	}
 
 out_sem:
@@ -1718,12 +1741,10 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		if (ext4_es_is_hole(&es)) {
-			retval = 0;
-			down_read(&EXT4_I(inode)->i_data_sem);
+		if (ext4_es_is_hole(&es))
 			goto add_delayed;
-		}
 
+found:
 		/*
 		 * Delayed extent could be allocated by fallocate.
 		 * So we need to check it.
@@ -1760,52 +1781,42 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_has_inline_data(inode))
 		retval = 0;
-	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
-		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
+		retval = ext4_map_query_blocks(NULL, inode, map);
+	up_read(&EXT4_I(inode)->i_data_sem);
+	if (retval)
+		return retval;
 
 add_delayed:
-	if (retval == 0) {
-		int ret;
-
-		/*
-		 * XXX: __block_prepare_write() unmaps passed block,
-		 * is it OK?
-		 */
-
-		ret = ext4_insert_delayed_block(inode, map->m_lblk);
-		if (ret != 0) {
-			retval = ret;
-			goto out_unlock;
+	down_write(&EXT4_I(inode)->i_data_sem);
+	/*
+	 * Page fault path (ext4_page_mkwrite does not take i_rwsem)
+	 * and fallocate path (no folio lock) can race. Make sure we
+	 * lookup the extent status tree here again while i_data_sem
+	 * is held in write mode, before inserting a new da entry in
+	 * the extent status tree.
+	 */
+	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		if (!ext4_es_is_hole(&es)) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto found;
 		}
-
-		map_bh(bh, inode->i_sb, invalid_block);
-		set_buffer_new(bh);
-		set_buffer_delay(bh);
-	} else if (retval > 0) {
-		int ret;
-		unsigned int status;
-
-		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
-				     "ES len assertion failed for inode "
-				     "%lu: retval %d != map->m_len %d",
-				     inode->i_ino, retval, map->m_len);
-			WARN_ON(1);
+	} else if (!ext4_has_inline_data(inode)) {
+		retval = ext4_map_query_blocks(NULL, inode, map);
+		if (retval) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			return retval;
 		}
-
-		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ret = ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-					    map->m_pblk, status);
-		if (ret != 0)
-			retval = ret;
 	}
 
-out_unlock:
-	up_read((&EXT4_I(inode)->i_data_sem));
+	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	up_write(&EXT4_I(inode)->i_data_sem);
+	if (retval)
+		return retval;
 
+	map_bh(bh, inode->i_sb, invalid_block);
+	set_buffer_new(bh);
+	set_buffer_delay(bh);
 	return retval;
 }
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 1145664a0bb7..630a5e5a380e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2270,8 +2270,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (max >= ac->ac_g_ex.fe_len && ac->ac_g_ex.fe_len == sbi->s_stripe) {
 		ext4_fsblk_t start;
 
-		start = ext4_group_first_block_no(ac->ac_sb, e4b->bd_group) +
-			ex.fe_start;
+		start = ext4_grp_offs_to_block(ac->ac_sb, &ex);
 		/* use do_div to get remainder (would be 64-bit modulo) */
 		if (do_div(start, sbi->s_stripe) == 0) {
 			ac->ac_found++;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e9501fb28477..a80f2cdab374 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -151,10 +151,11 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 
 		return bh;
 	}
-	if (!bh && (type == INDEX || type == DIRENT_HTREE)) {
+	/* The first directory block must not be a hole. */
+	if (!bh && (type == INDEX || type == DIRENT_HTREE || block == 0)) {
 		ext4_error_inode(inode, func, line, block,
-				 "Directory hole found for htree %s block",
-				 (type == INDEX) ? "index" : "leaf");
+				 "Directory hole found for htree %s block %u",
+				 (type == INDEX) ? "index" : "leaf", block);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 	if (!bh)
@@ -2218,6 +2219,52 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 	return err ? err : err2;
 }
 
+static bool ext4_check_dx_root(struct inode *dir, struct dx_root *root)
+{
+	struct fake_dirent *fde;
+	const char *error_msg;
+	unsigned int rlen;
+	unsigned int blocksize = dir->i_sb->s_blocksize;
+	char *blockend = (char *)root + dir->i_sb->s_blocksize;
+
+	fde = &root->dot;
+	if (unlikely(fde->name_len != 1)) {
+		error_msg = "invalid name_len for '.'";
+		goto corrupted;
+	}
+	if (unlikely(strncmp(root->dot_name, ".", fde->name_len))) {
+		error_msg = "invalid name for '.'";
+		goto corrupted;
+	}
+	rlen = ext4_rec_len_from_disk(fde->rec_len, blocksize);
+	if (unlikely((char *)fde + rlen >= blockend)) {
+		error_msg = "invalid rec_len for '.'";
+		goto corrupted;
+	}
+
+	fde = &root->dotdot;
+	if (unlikely(fde->name_len != 2)) {
+		error_msg = "invalid name_len for '..'";
+		goto corrupted;
+	}
+	if (unlikely(strncmp(root->dotdot_name, "..", fde->name_len))) {
+		error_msg = "invalid name for '..'";
+		goto corrupted;
+	}
+	rlen = ext4_rec_len_from_disk(fde->rec_len, blocksize);
+	if (unlikely((char *)fde + rlen >= blockend)) {
+		error_msg = "invalid rec_len for '..'";
+		goto corrupted;
+	}
+
+	return true;
+
+corrupted:
+	EXT4_ERROR_INODE(dir, "Corrupt dir, %s, running e2fsck is recommended",
+			 error_msg);
+	return false;
+}
+
 /*
  * This converts a one block unindexed directory to a 3 block indexed
  * directory, and adds the dentry to the indexed directory.
@@ -2252,17 +2299,17 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 		brelse(bh);
 		return retval;
 	}
+
 	root = (struct dx_root *) bh->b_data;
+	if (!ext4_check_dx_root(dir, root)) {
+		brelse(bh);
+		return -EFSCORRUPTED;
+	}
 
 	/* The 0th block becomes the root, move the dirents out */
 	fde = &root->dotdot;
 	de = (struct ext4_dir_entry_2 *)((char *)fde +
 		ext4_rec_len_from_disk(fde->rec_len, blocksize));
-	if ((char *) de >= (((char *) root) + blocksize)) {
-		EXT4_ERROR_INODE(dir, "invalid rec_len for '..'");
-		brelse(bh);
-		return -EFSCORRUPTED;
-	}
 	len = ((char *) root) + (blocksize - csum_size) - (char *) de;
 
 	/* Allocate new block for the 0th block's dirents */
@@ -3087,10 +3134,7 @@ bool ext4_empty_dir(struct inode *inode)
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return false;
 	}
-	/* The first directory block must not be a hole,
-	 * so treat it as DIRENT_HTREE
-	 */
-	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+	bh = ext4_read_dirblock(inode, 0, EITHER);
 	if (IS_ERR(bh))
 		return false;
 
@@ -3548,10 +3592,7 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 		struct ext4_dir_entry_2 *de;
 		unsigned int offset;
 
-		/* The first directory block must not be a hole, so
-		 * treat it as DIRENT_HTREE
-		 */
-		bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+		bh = ext4_read_dirblock(inode, 0, EITHER);
 		if (IS_ERR(bh)) {
 			*retval = PTR_ERR(bh);
 			return NULL;
@@ -4011,12 +4052,19 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		ext4_fc_mark_ineligible(old.inode->i_sb,
 			EXT4_FC_REASON_RENAME_DIR, handle);
 	} else {
+		struct super_block *sb = old.inode->i_sb;
+
 		if (new.inode)
 			ext4_fc_track_unlink(handle, new.dentry);
-		__ext4_fc_track_link(handle, old.inode, new.dentry);
-		__ext4_fc_track_unlink(handle, old.inode, old.dentry);
-		if (whiteout)
-			__ext4_fc_track_create(handle, whiteout, old.dentry);
+		if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
+		    !(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY) &&
+		    !(ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE))) {
+			__ext4_fc_track_link(handle, old.inode, new.dentry);
+			__ext4_fc_track_unlink(handle, old.inode, old.dentry);
+			if (whiteout)
+				__ext4_fc_track_create(handle, whiteout,
+						       old.dentry);
+		}
 	}
 
 	if (new.inode) {
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 37f3c2ebe6f8..e788f291ae86 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1384,6 +1384,12 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 			goto out;
 
 		memcpy(bh->b_data, buf, csize);
+		/*
+		 * Zero out block tail to avoid writing uninitialized memory
+		 * to disk.
+		 */
+		if (csize < blocksize)
+			memset(bh->b_data + csize, 0, blocksize - csize);
 		set_buffer_uptodate(bh);
 		ext4_handle_dirty_metadata(handle, ea_inode, bh);
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e4fc169a07f5..6246ea2e1c62 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -203,8 +203,10 @@ int f2fs_convert_inline_inode(struct inode *inode)
 	struct page *ipage, *page;
 	int err = 0;
 
-	if (!f2fs_has_inline_data(inode) ||
-			f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
+	if (f2fs_hw_is_readonly(sbi) || f2fs_readonly(sbi->sb))
+		return -EROFS;
+
+	if (!f2fs_has_inline_data(inode))
 		return 0;
 
 	err = f2fs_dquot_initialize(inode);
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index ddb297409f41..27bd8d1bae4d 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -27,6 +27,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (is_inode_flag_set(inode, FI_NEW_INODE))
 		return;
 
+	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+		return;
+
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
diff --git a/fs/file.c b/fs/file.c
index b46a4a725a0e..0669cc0f1809 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1148,6 +1148,7 @@ __releases(&files->file_lock)
 	 * tables and this condition does not arise without those.
 	 */
 	fdt = files_fdtable(files);
+	fd = array_index_nospec(fd, fdt->max_fds);
 	tofree = fdt->fd[fd];
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 62b4143ccf26..396866f9d72c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -686,6 +686,8 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 	struct fs_parse_result result;
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
 	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 		/*
@@ -730,16 +732,30 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fsc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
+		kuid =  make_kuid(fsc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
 			return invalfc(fsc, "Invalid user_id");
+		/*
+		 * The requested uid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kuid_has_mapping(fsc->user_ns, kuid))
+			return invalfc(fsc, "Invalid user_id");
+		ctx->user_id = kuid;
 		ctx->user_id_present = true;
 		break;
 
 	case OPT_GROUP_ID:
-		ctx->group_id = make_kgid(fsc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
+		kgid = make_kgid(fsc->user_ns, result.uint_32);;
+		if (!gid_valid(kgid))
+			return invalfc(fsc, "Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fsc->user_ns, kgid))
 			return invalfc(fsc, "Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = true;
 		break;
 
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 7c9c6d0b38fd..9730ad3622d4 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -202,6 +202,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	HFS_I(inode)->fs_blocks = 0;
+	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		HFS_SB(sb)->folder_count++;
@@ -277,6 +278,8 @@ void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
 	for (count = 0, i = 0; i < 3; i++)
 		count += be16_to_cpu(ext[i].count);
 	HFS_I(inode)->first_blocks = count;
+	HFS_I(inode)->cached_start = 0;
+	HFS_I(inode)->cached_blocks = 0;
 
 	inode->i_size = HFS_I(inode)->phys_size = log_size;
 	HFS_I(inode)->fs_blocks = (log_size + sb->s_blocksize - 1) >> sb->s_blocksize_bits;
diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca2ba8c9f82e..901e83d65d20 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -25,19 +25,8 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->key = ptr + tree->max_key_len + 2;
 	hfs_dbg(BNODE_REFS, "find_init: %d (%p)\n",
 		tree->cnid, __builtin_return_address(0));
-	switch (tree->cnid) {
-	case HFSPLUS_CAT_CNID:
-		mutex_lock_nested(&tree->tree_lock, CATALOG_BTREE_MUTEX);
-		break;
-	case HFSPLUS_EXT_CNID:
-		mutex_lock_nested(&tree->tree_lock, EXTENTS_BTREE_MUTEX);
-		break;
-	case HFSPLUS_ATTR_CNID:
-		mutex_lock_nested(&tree->tree_lock, ATTR_BTREE_MUTEX);
-		break;
-	default:
-		BUG();
-	}
+	mutex_lock_nested(&tree->tree_lock,
+			hfsplus_btree_lock_class(tree));
 	return 0;
 }
 
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 7054a542689f..c95a2f0ed4a7 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -430,7 +430,8 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		hfsplus_free_extents(sb, ext_entry, total_blocks - start,
 				     total_blocks);
 		total_blocks = start;
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+			hfsplus_btree_lock_class(fd.tree));
 	} while (total_blocks > blocks);
 	hfs_find_exit(&fd);
 
@@ -592,7 +593,8 @@ void hfsplus_file_truncate(struct inode *inode)
 					     alloc_cnt, alloc_cnt - blk_cnt);
 			hfsplus_dump_extent(hip->first_extents);
 			hip->first_blocks = blk_cnt;
-			mutex_lock(&fd.tree->tree_lock);
+			mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 			break;
 		}
 		res = __hfsplus_ext_cache_extent(&fd, inode, alloc_cnt);
@@ -606,7 +608,8 @@ void hfsplus_file_truncate(struct inode *inode)
 		hfsplus_free_extents(sb, hip->cached_extents,
 				     alloc_cnt - start, alloc_cnt - blk_cnt);
 		hfsplus_dump_extent(hip->cached_extents);
-		mutex_lock(&fd.tree->tree_lock);
+		mutex_lock_nested(&fd.tree->tree_lock,
+				hfsplus_btree_lock_class(fd.tree));
 		if (blk_cnt > start) {
 			hip->extent_state |= HFSPLUS_EXT_DIRTY;
 			break;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ebc0d5c678d0..decb671db91b 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -550,6 +550,27 @@ static inline __be32 __hfsp_ut2mt(time64_t ut)
 	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
 }
 
+static inline enum hfsplus_btree_mutex_classes
+hfsplus_btree_lock_class(struct hfs_btree *tree)
+{
+	enum hfsplus_btree_mutex_classes class;
+
+	switch (tree->cnid) {
+	case HFSPLUS_CAT_CNID:
+		class = CATALOG_BTREE_MUTEX;
+		break;
+	case HFSPLUS_EXT_CNID:
+		class = EXTENTS_BTREE_MUTEX;
+		break;
+	case HFSPLUS_ATTR_CNID:
+		class = ATTR_BTREE_MUTEX;
+		break;
+	default:
+		BUG();
+	}
+	return class;
+}
+
 /* compatibility */
 #define hfsp_mt2ut(t)		(struct timespec64){ .tv_sec = __hfsp_mt2ut(t) }
 #define hfsp_ut2mt(t)		__hfsp_ut2mt((t).tv_sec)
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index f858d1152368..540a3ccb3287 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -800,7 +800,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (first_block < journal->j_tail)
 			freed += journal->j_last - journal->j_first;
 		/* Update tail only if we free significant amount of space */
-		if (freed < jbd2_journal_get_max_txn_bufs(journal))
+		if (freed < journal->j_max_transaction_buffers)
 			update_tail = 0;
 	}
 	J_ASSERT(commit_transaction->t_state == T_COMMIT);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b7af1727a016..b10c144c6084 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -412,6 +412,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
 		tmp = jbd2_alloc(bh_in->b_size, GFP_NOFS);
 		if (!tmp) {
 			brelse(new_bh);
+			free_buffer_head(new_bh);
 			return -ENOMEM;
 		}
 		spin_lock(&jh_in->b_state_lock);
@@ -1529,6 +1530,11 @@ static void journal_fail_superblock(journal_t *journal)
 	journal->j_sb_buffer = NULL;
 }
 
+static int jbd2_journal_get_max_txn_bufs(journal_t *journal)
+{
+	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
+}
+
 /*
  * Given a journal_t structure, initialise the various fields for
  * startup of a new journaling session.  We use this both when creating
diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index ac42f8ee553f..ba6f28521360 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -290,7 +290,7 @@ int diSync(struct inode *ipimap)
 int diRead(struct inode *ip)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
-	int iagno, ino, extno, rc;
+	int iagno, ino, extno, rc, agno;
 	struct inode *ipimap;
 	struct dinode *dp;
 	struct iag *iagp;
@@ -339,8 +339,11 @@ int diRead(struct inode *ip)
 
 	/* get the ag for the iag */
 	agstart = le64_to_cpu(iagp->agstart);
+	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
 
 	release_metapage(mp);
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
 
 	rel_inode = (ino & (INOSPERPAGE - 1));
 	pageno = blkno >> sbi->l2nbperpage;
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index cba8b4c1fb4a..8557b2218aa1 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -230,9 +230,8 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 		__set_bit(NFS_CS_INFINITE_SLOTS, &clp->cl_flags);
 	__set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
 	__set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
-
-	if (test_bit(NFS_CS_DS, &cl_init->init_flags))
-		__set_bit(NFS_CS_DS, &clp->cl_flags);
+	if (test_bit(NFS_CS_PNFS, &cl_init->init_flags))
+		__set_bit(NFS_CS_PNFS, &clp->cl_flags);
 	/*
 	 * Set up the connection to the server before we add add to the
 	 * global list.
@@ -997,7 +996,6 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
-	__set_bit(NFS_CS_DS, &cl_init.init_flags);
 	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
 	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 167f2cc3c379..770fa1cb112d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8718,7 +8718,7 @@ nfs4_run_exchange_id(struct nfs_client *clp, const struct cred *cred,
 #ifdef CONFIG_NFS_V4_1_MIGRATION
 	calldata->args.flags |= EXCHGID4_FLAG_SUPP_MOVED_MIGR;
 #endif
-	if (test_bit(NFS_CS_DS, &clp->cl_flags))
+	if (test_bit(NFS_CS_PNFS, &clp->cl_flags))
 		calldata->args.flags |= EXCHGID4_FLAG_USE_PNFS_DS;
 	msg.rpc_argp = &calldata->args;
 	msg.rpc_resp = &calldata->res;
diff --git a/fs/nilfs2/btnode.c b/fs/nilfs2/btnode.c
index 1776121677e2..28a726553318 100644
--- a/fs/nilfs2/btnode.c
+++ b/fs/nilfs2/btnode.c
@@ -51,12 +51,21 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 
 	bh = nilfs_grab_buffer(inode, btnc, blocknr, BIT(BH_NILFS_Node));
 	if (unlikely(!bh))
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (unlikely(buffer_mapped(bh) || buffer_uptodate(bh) ||
 		     buffer_dirty(bh))) {
-		brelse(bh);
-		BUG();
+		/*
+		 * The block buffer at the specified new address was already
+		 * in use.  This can happen if it is a virtual block number
+		 * and has been reallocated due to corruption of the bitmap
+		 * used to manage its allocation state (if not, the buffer
+		 * clearing of an abandoned b-tree node is missing somewhere).
+		 */
+		nilfs_error(inode->i_sb,
+			    "state inconsistency probably due to duplicate use of b-tree node block address %llu (ino=%lu)",
+			    (unsigned long long)blocknr, inode->i_ino);
+		goto failed;
 	}
 	memset(bh->b_data, 0, i_blocksize(inode));
 	bh->b_bdev = inode->i_sb->s_bdev;
@@ -67,6 +76,12 @@ nilfs_btnode_create_block(struct address_space *btnc, __u64 blocknr)
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
 	return bh;
+
+failed:
+	unlock_page(bh->b_page);
+	put_page(bh->b_page);
+	brelse(bh);
+	return ERR_PTR(-EIO);
 }
 
 int nilfs_btnode_submit_block(struct address_space *btnc, __u64 blocknr,
@@ -217,8 +232,8 @@ int nilfs_btnode_prepare_change_key(struct address_space *btnc,
 	}
 
 	nbh = nilfs_btnode_create_block(btnc, newkey);
-	if (!nbh)
-		return -ENOMEM;
+	if (IS_ERR(nbh))
+		return PTR_ERR(nbh);
 
 	BUG_ON(nbh == obh);
 	ctxt->newbh = nbh;
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 385ec71fcdef..8e3d343b9a79 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -63,8 +63,8 @@ static int nilfs_btree_get_new_block(const struct nilfs_bmap *btree,
 	struct buffer_head *bh;
 
 	bh = nilfs_btnode_create_block(btnc, ptr);
-	if (!bh)
-		return -ENOMEM;
+	if (IS_ERR(bh))
+		return PTR_ERR(bh);
 
 	set_buffer_nilfs_volatile(bh);
 	*bhp = bh;
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 440e628f9d4f..c90435e8e748 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -136,7 +136,7 @@ static void nilfs_dispose_list(struct the_nilfs *, struct list_head *, int);
 
 #define nilfs_cnt32_ge(a, b)   \
 	(typecheck(__u32, a) && typecheck(__u32, b) && \
-	 ((__s32)(a) - (__s32)(b) >= 0))
+	 ((__s32)((a) - (b)) >= 0))
 
 static int nilfs_prepare_segment_lock(struct super_block *sb,
 				      struct nilfs_transaction_info *ti)
diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 64a6d255c468..83c15c70f594 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -242,7 +242,7 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	struct ntfs_sb_info *sbi;
 	struct ATTRIB *attr_s;
 	struct MFT_REC *rec;
-	u32 used, asize, rsize, aoff, align;
+	u32 used, asize, rsize, aoff;
 	bool is_data;
 	CLST len, alen;
 	char *next;
@@ -263,10 +263,13 @@ int attr_make_nonresident(struct ntfs_inode *ni, struct ATTRIB *attr,
 	rsize = le32_to_cpu(attr->res.data_size);
 	is_data = attr->type == ATTR_DATA && !attr->name_len;
 
-	align = sbi->cluster_size;
-	if (is_attr_compressed(attr))
-		align <<= COMPRESSION_UNIT;
-	len = (rsize + align - 1) >> sbi->cluster_bits;
+	/* len - how many clusters required to store 'rsize' bytes */
+	if (is_attr_compressed(attr)) {
+		u8 shift = sbi->cluster_bits + NTFS_LZNT_CUNIT;
+		len = ((rsize + (1u << shift) - 1) >> shift) << NTFS_LZNT_CUNIT;
+	} else {
+		len = bytes_to_cluster(sbi, rsize);
+	}
 
 	run_init(run);
 
@@ -1562,6 +1565,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 
 	attr_b->nres.total_size = cpu_to_le64(total_size);
 	inode_set_bytes(&ni->vfs_inode, total_size);
+	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 
 	mi_b->dirty = true;
 	mark_inode_dirty(&ni->vfs_inode);
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 21536b72aa5e..95589a496f0f 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -1363,7 +1363,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 
 		err = ntfs_vbo_to_lbo(sbi, &wnd->run, vbo, &lbo, &bytes);
 		if (err)
-			break;
+			return err;
 
 		bh = ntfs_bread(sb, lbo >> sb->s_blocksize_bits);
 		if (!bh)
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 98f57d0c702e..dcd689ed4baa 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -326,7 +326,8 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 	 * It does additional locks/reads just to get the type of name.
 	 * Should we use additional mount option to enable branch below?
 	 */
-	if ((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) &&
+	if (((fname->dup.fa & FILE_ATTRIBUTE_REPARSE_POINT) ||
+	     fname->dup.ea_size) &&
 	    ino != ni->mi.rno) {
 		struct inode *inode = ntfs_iget5(sbi->sb, &e->ref, NULL);
 		if (!IS_ERR_OR_NULL(inode)) {
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 6d4f3431bc75..af7e13806462 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -398,10 +398,7 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		}
 
 		if (ni->i_valid < to) {
-			if (!inode_trylock(inode)) {
-				err = -EAGAIN;
-				goto out;
-			}
+			inode_lock(inode);
 			err = ntfs_extend_initialized_size(file, ni,
 							   ni->i_valid, to);
 			inode_unlock(inode);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index b02778cbb1d3..da21a044d3f8 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1453,7 +1453,7 @@ int ni_insert_nonresident(struct ntfs_inode *ni, enum ATTR_TYPE type,
 
 	if (is_ext) {
 		if (flags & ATTR_FLAG_COMPRESSED)
-			attr->nres.c_unit = COMPRESSION_UNIT;
+			attr->nres.c_unit = NTFS_LZNT_CUNIT;
 		attr->nres.total_size = attr->nres.alloc_size;
 	}
 
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 8ac677e3b250..ba4dc7385b44 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -2999,7 +2999,7 @@ static struct ATTRIB *attr_create_nonres_log(struct ntfs_sb_info *sbi,
 	if (is_ext) {
 		attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
 		if (is_attr_compressed(attr))
-			attr->nres.c_unit = COMPRESSION_UNIT;
+			attr->nres.c_unit = NTFS_LZNT_CUNIT;
 
 		attr->nres.run_off =
 			cpu_to_le16(SIZEOF_NONRESIDENT_EX + name_size);
@@ -3935,6 +3935,9 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		goto out;
 	}
 
+	log->page_mask = log->page_size - 1;
+	log->page_bits = blksize_bits(log->page_size);
+
 	/* If the file size has shrunk then we won't mount it. */
 	if (l_size < le64_to_cpu(ra2->l_size)) {
 		err = -EINVAL;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 1b082b7a67ee..4bd3e6718ee6 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -475,7 +475,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 	struct ATTRIB *attr;
 	struct wnd_bitmap *wnd = &sbi->mft.bitmap;
 
-	new_mft_total = (wnd->nbits + MFT_INCREASE_CHUNK + 127) & (CLST)~127;
+	new_mft_total = ALIGN(wnd->nbits + NTFS_MFT_INCREASE_STEP, 128);
 	new_mft_bytes = (u64)new_mft_total << sbi->record_bits;
 
 	/* Step 1: Resize $MFT::DATA. */
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index a069ae7a748e..13f492d0d971 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -979,7 +979,7 @@ static struct indx_node *indx_new(struct ntfs_index *indx,
 		hdr->used =
 			cpu_to_le32(eo + sizeof(struct NTFS_DE) + sizeof(u64));
 		de_set_vbn_le(e, *sub_vbn);
-		hdr->flags = 1;
+		hdr->flags = NTFS_INDEX_HDR_HAS_SUBNODES;
 	} else {
 		e->size = cpu_to_le16(sizeof(struct NTFS_DE));
 		hdr->used = cpu_to_le32(eo + sizeof(struct NTFS_DE));
@@ -1684,7 +1684,7 @@ static int indx_insert_into_root(struct ntfs_index *indx, struct ntfs_inode *ni,
 	e->size = cpu_to_le16(sizeof(struct NTFS_DE) + sizeof(u64));
 	e->flags = NTFS_IE_HAS_SUBNODES | NTFS_IE_LAST;
 
-	hdr->flags = 1;
+	hdr->flags = NTFS_INDEX_HDR_HAS_SUBNODES;
 	hdr->used = hdr->total =
 		cpu_to_le32(new_root_size - offsetof(struct INDEX_ROOT, ihdr));
 
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index ff45ad967fb8..7adfa19a2f06 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1465,7 +1465,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 			attr->size = cpu_to_le32(SIZEOF_NONRESIDENT_EX + 8);
 			attr->name_off = SIZEOF_NONRESIDENT_EX_LE;
 			attr->flags = ATTR_FLAG_COMPRESSED;
-			attr->nres.c_unit = COMPRESSION_UNIT;
+			attr->nres.c_unit = NTFS_LZNT_CUNIT;
 			asize = SIZEOF_NONRESIDENT_EX + 8;
 		} else {
 			attr->size = cpu_to_le32(SIZEOF_NONRESIDENT + 8);
diff --git a/fs/ntfs3/ntfs.h b/fs/ntfs3/ntfs.h
index 324c0b036fdc..625f2b52bd58 100644
--- a/fs/ntfs3/ntfs.h
+++ b/fs/ntfs3/ntfs.h
@@ -82,10 +82,6 @@ typedef u32 CLST;
 #define RESIDENT_LCN   ((CLST)-2)
 #define COMPRESSED_LCN ((CLST)-3)
 
-#define COMPRESSION_UNIT     4
-#define COMPRESS_MAX_CLUSTER 0x1000
-#define MFT_INCREASE_CHUNK   1024
-
 enum RECORD_NUM {
 	MFT_REC_MFT		= 0,
 	MFT_REC_MIRR		= 1,
@@ -690,14 +686,15 @@ static inline bool de_has_vcn_ex(const struct NTFS_DE *e)
 	      offsetof(struct ATTR_FILE_NAME, name) + \
 	      NTFS_NAME_LEN * sizeof(short), 8)
 
+#define NTFS_INDEX_HDR_HAS_SUBNODES cpu_to_le32(1)
+
 struct INDEX_HDR {
 	__le32 de_off;	// 0x00: The offset from the start of this structure
 			// to the first NTFS_DE.
 	__le32 used;	// 0x04: The size of this structure plus all
 			// entries (quad-word aligned).
 	__le32 total;	// 0x08: The allocated size of for this structure plus all entries.
-	u8 flags;	// 0x0C: 0x00 = Small directory, 0x01 = Large directory.
-	u8 res[3];
+	__le32 flags;	// 0x0C: 0x00 = Small directory, 0x01 = Large directory.
 
 	//
 	// de_off + used <= total
@@ -744,7 +741,7 @@ static inline struct NTFS_DE *hdr_next_de(const struct INDEX_HDR *hdr,
 
 static inline bool hdr_has_subnode(const struct INDEX_HDR *hdr)
 {
-	return hdr->flags & 1;
+	return hdr->flags & NTFS_INDEX_HDR_HAS_SUBNODES;
 }
 
 struct INDEX_BUFFER {
@@ -764,7 +761,7 @@ static inline bool ib_is_empty(const struct INDEX_BUFFER *ib)
 
 static inline bool ib_is_leaf(const struct INDEX_BUFFER *ib)
 {
-	return !(ib->ihdr.flags & 1);
+	return !(ib->ihdr.flags & NTFS_INDEX_HDR_HAS_SUBNODES);
 }
 
 /* Index root structure ( 0x90 ). */
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 12a3b41d351c..e67bef401807 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -198,6 +198,8 @@ struct ntfs_index {
 
 /* Minimum MFT zone. */
 #define NTFS_MIN_MFT_ZONE 100
+/* Step to increase the MFT. */
+#define NTFS_MFT_INCREASE_STEP 1024
 
 /* Ntfs file system in-core superblock data. */
 struct ntfs_sb_info {
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 4192fe6ec3da..213ea008fe2d 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -466,12 +466,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 			make_empty_dir_inode(inode);
 	}
 
+	inode->i_uid = GLOBAL_ROOT_UID;
+	inode->i_gid = GLOBAL_ROOT_GID;
 	if (root->set_ownership)
 		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
-	else {
-		inode->i_uid = GLOBAL_ROOT_UID;
-		inode->i_gid = GLOBAL_ROOT_GID;
-	}
 
 	return inode;
 }
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 705a41f4d6b3..b255e3dfded1 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1471,6 +1471,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		}
 #endif
 
+		if (page && !PageAnon(page))
+			flags |= PM_FILE;
 		if (page && !migration && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
diff --git a/fs/super.c b/fs/super.c
index 048576b19af6..39d866f7d7c6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -528,6 +528,17 @@ struct super_block *sget_fc(struct fs_context *fc,
 	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
 	int err;
 
+	/*
+	 * Never allow s_user_ns != &init_user_ns when FS_USERNS_MOUNT is
+	 * not set, as the filesystem is likely unprepared to handle it.
+	 * This can happen when fsconfig() is called from init_user_ns with
+	 * an fs_fd opened in another user namespace.
+	 */
+	if (user_ns != &init_user_ns && !(fc->fs_type->fs_flags & FS_USERNS_MOUNT)) {
+		errorfc(fc, "VFS: Mounting from non-initial user namespace is not allowed");
+		return ERR_PTR(-EPERM);
+	}
+
 retry:
 	spin_lock(&sb_lock);
 	if (test) {
diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index f416b7fe092f..aa73ab1b50a5 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -22,6 +22,7 @@
 #include "udfdecl.h"
 
 #include <linux/bitops.h>
+#include <linux/overflow.h>
 
 #include "udf_i.h"
 #include "udf_sb.h"
@@ -68,8 +69,12 @@ static int read_block_bitmap(struct super_block *sb,
 	}
 
 	for (i = 0; i < count; i++)
-		if (udf_test_bit(i + off, bh->b_data))
+		if (udf_test_bit(i + off, bh->b_data)) {
+			bitmap->s_block_bitmap[bitmap_nr] =
+							ERR_PTR(-EFSCORRUPTED);
+			brelse(bh);
 			return -EFSCORRUPTED;
+		}
 	return 0;
 }
 
@@ -85,8 +90,15 @@ static int __load_block_bitmap(struct super_block *sb,
 			  block_group, nr_groups);
 	}
 
-	if (bitmap->s_block_bitmap[block_group])
+	if (bitmap->s_block_bitmap[block_group]) {
+		/*
+		 * The bitmap failed verification in the past. No point in
+		 * trying again.
+		 */
+		if (IS_ERR(bitmap->s_block_bitmap[block_group]))
+			return PTR_ERR(bitmap->s_block_bitmap[block_group]);
 		return block_group;
+	}
 
 	retval = read_block_bitmap(sb, bitmap, block_group, block_group);
 	if (retval < 0)
@@ -133,7 +145,6 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct buffer_head *bh = NULL;
-	struct udf_part_map *partmap;
 	unsigned long block;
 	unsigned long block_group;
 	unsigned long bit;
@@ -142,19 +153,9 @@ static void udf_bitmap_free_blocks(struct super_block *sb,
 	unsigned long overflow;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
+	/* We make sure this cannot overflow when mounting the filesystem */
 	block = bloc->logicalBlockNum + offset +
 		(sizeof(struct spaceBitmapDesc) << 3);
-
 	do {
 		overflow = 0;
 		block_group = block >> (sb->s_blocksize_bits + 3);
@@ -384,7 +385,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 				  uint32_t count)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-	struct udf_part_map *partmap;
 	uint32_t start, end;
 	uint32_t elen;
 	struct kernel_lb_addr eloc;
@@ -393,16 +393,6 @@ static void udf_table_free_blocks(struct super_block *sb,
 	struct udf_inode_info *iinfo;
 
 	mutex_lock(&sbi->s_alloc_mutex);
-	partmap = &sbi->s_partmaps[bloc->partitionReferenceNum];
-	if (bloc->logicalBlockNum + count < count ||
-	    (bloc->logicalBlockNum + count) > partmap->s_partition_len) {
-		udf_debug("%u < %d || %u + %u > %u\n",
-			  bloc->logicalBlockNum, 0,
-			  bloc->logicalBlockNum, count,
-			  partmap->s_partition_len);
-		goto error_return;
-	}
-
 	iinfo = UDF_I(table);
 	udf_add_free_space(sb, sbi->s_partition, count);
 
@@ -677,6 +667,17 @@ void udf_free_blocks(struct super_block *sb, struct inode *inode,
 {
 	uint16_t partition = bloc->partitionReferenceNum;
 	struct udf_part_map *map = &UDF_SB(sb)->s_partmaps[partition];
+	uint32_t blk;
+
+	if (check_add_overflow(bloc->logicalBlockNum, offset, &blk) ||
+	    check_add_overflow(blk, count, &blk) ||
+	    bloc->logicalBlockNum + count > map->s_partition_len) {
+		udf_debug("Invalid request to free blocks: (%d, %u), off %u, "
+			  "len %u, partition len %u\n",
+			  partition, bloc->logicalBlockNum, offset, count,
+			  map->s_partition_len);
+		return;
+	}
 
 	if (map->s_partition_flags & UDF_PART_FLAG_UNALLOC_BITMAP) {
 		udf_bitmap_free_blocks(sb, map->s_uspace.s_bitmap,
diff --git a/fs/udf/super.c b/fs/udf/super.c
index 6b85c66722d3..e2f3d2b6c245 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -266,7 +266,8 @@ static void udf_sb_free_bitmap(struct udf_bitmap *bitmap)
 	int nr_groups = bitmap->s_nr_groups;
 
 	for (i = 0; i < nr_groups; i++)
-		brelse(bitmap->s_block_bitmap[i]);
+		if (!IS_ERR_OR_NULL(bitmap->s_block_bitmap[i]))
+			brelse(bitmap->s_block_bitmap[i]);
 
 	kvfree(bitmap);
 }
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 3d844a250b71..705cd5a60fbc 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -2972,7 +2972,7 @@ xlog_do_recovery_pass(
 	int			error = 0, h_size, h_len;
 	int			error2 = 0;
 	int			bblks, split_bblks;
-	int			hblks, split_hblks, wrapped_hblks;
+	int			hblks = 1, split_hblks, wrapped_hblks;
 	int			i;
 	struct hlist_head	rhash[XLOG_RHASH_SIZE];
 	LIST_HEAD		(buffer_list);
@@ -3028,14 +3028,22 @@ xlog_do_recovery_pass(
 		if (error)
 			goto bread_err1;
 
-		hblks = xlog_logrec_hblks(log, rhead);
-		if (hblks != 1) {
-			kmem_free(hbp);
-			hbp = xlog_alloc_buffer(log, hblks);
+		/*
+		 * This open codes xlog_logrec_hblks so that we can reuse the
+		 * fixed up h_size value calculated above.  Without that we'd
+		 * still allocate the buffer based on the incorrect on-disk
+		 * size.
+		 */
+		if (h_size > XLOG_HEADER_CYCLE_SIZE &&
+		    (rhead->h_version & cpu_to_be32(XLOG_VERSION_2))) {
+			hblks = DIV_ROUND_UP(h_size, XLOG_HEADER_CYCLE_SIZE);
+			if (hblks > 1) {
+				kmem_free(hbp);
+				hbp = xlog_alloc_buffer(log, hblks);
+			}
 		}
 	} else {
 		ASSERT(log->l_sectBBsize == 1);
-		hblks = 1;
 		hbp = xlog_alloc_buffer(log, 1);
 		h_size = XLOG_BIG_RECORD_BSIZE;
 	}
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index dd9ea351bc02..4132a76a3e2e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -101,7 +101,7 @@
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliteral* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
-#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
+#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..L* .bss..compoundliteral*
 #define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b17327..0ad8b550bb4b 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -291,7 +291,19 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
-extern ulong max_cswd_read_retries;
+static inline unsigned int clocksource_get_max_watchdog_retry(void)
+{
+	/*
+	 * When system is in the boot phase or under heavy workload, there
+	 * can be random big latencies during the clocksource/watchdog
+	 * read, so allow retries to filter the noise latency. As the
+	 * latency's frequency and maximum value goes up with the number of
+	 * CPUs, scale the number of retries with the number of online
+	 * CPUs.
+	 */
+	return (ilog2(num_online_cpus()) / 2) + 1;
+}
+
 void clocksource_verify_percpu(struct clocksource *cs);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4ede8df5818e..f96f10957a98 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -600,6 +600,7 @@ HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
 /* Defines one hugetlb page size */
 struct hstate {
 	struct mutex resize_lock;
+	struct lock_class_key resize_key;
 	int next_nid_to_alloc;
 	int next_nid_to_free;
 	unsigned int order;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f9e6449fbbba..4fd8d900a1b8 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -709,10 +709,11 @@ extern struct irq_chip no_irq_chip;
 extern struct irq_chip dummy_irq_chip;
 
 extern void
-irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+irq_set_chip_and_handler_name(unsigned int irq, const struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name);
 
-static inline void irq_set_chip_and_handler(unsigned int irq, struct irq_chip *chip,
+static inline void irq_set_chip_and_handler(unsigned int irq,
+					    const struct irq_chip *chip,
 					    irq_flow_handler_t handle)
 {
 	irq_set_chip_and_handler_name(irq, chip, handle, NULL);
@@ -802,7 +803,7 @@ static inline void irq_set_percpu_devid_flags(unsigned int irq)
 }
 
 /* Set/get chip/data for an IRQ: */
-extern int irq_set_chip(unsigned int irq, struct irq_chip *chip);
+extern int irq_set_chip(unsigned int irq, const struct irq_chip *chip);
 extern int irq_set_handler_data(unsigned int irq, void *data);
 extern int irq_set_chip_data(unsigned int irq, void *data);
 extern int irq_set_irq_type(unsigned int irq, unsigned int type);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9ee238ad29ce..a7c80bd4b45b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -147,6 +147,8 @@ struct irq_domain_chip_generic;
  * @gc: Pointer to a list of generic chips. There is a helper function for
  *      setting up one or more generic chips for interrupt controllers
  *      drivers using the generic chip library which uses this pointer.
+ * @dev: Pointer to a device that the domain represent, and that will be
+ *       used for power management purposes.
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
  *
  * Revmap data, used internally by irq_domain
@@ -167,6 +169,7 @@ struct irq_domain {
 	struct fwnode_handle *fwnode;
 	enum irq_domain_bus_token bus_token;
 	struct irq_domain_chip_generic *gc;
+	struct device *dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
 #endif
@@ -222,6 +225,13 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 	return to_of_node(d->fwnode);
 }
 
+static inline void irq_domain_set_pm_device(struct irq_domain *d,
+					    struct device *dev)
+{
+	if (d)
+		d->dev = dev;
+}
+
 #ifdef CONFIG_IRQ_DOMAIN
 struct fwnode_handle *__irq_domain_alloc_fwnode(unsigned int type, int id,
 						const char *name, phys_addr_t *pa);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index d19f527ade3b..5377df8c8545 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1669,11 +1669,6 @@ int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
 int jbd2_fc_wait_bufs(journal_t *journal, int num_blks);
 int jbd2_fc_release_bufs(journal_t *journal);
 
-static inline int jbd2_journal_get_max_txn_bufs(journal_t *journal)
-{
-	return (journal->j_total_len - journal->j_fc_wbufsize) / 4;
-}
-
 /*
  * is_journal_abort
  *
diff --git a/include/linux/leds.h b/include/linux/leds.h
index a0b730be40ad..79ab2dfd3c72 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -356,11 +356,14 @@ struct led_trigger {
 	int		(*activate)(struct led_classdev *led_cdev);
 	void		(*deactivate)(struct led_classdev *led_cdev);
 
+	/* Brightness set by led_trigger_event */
+	enum led_brightness brightness;
+
 	/* LED-private triggers have this set */
 	struct led_hw_trigger_type *trigger_type;
 
 	/* LEDs under control by this trigger (for simple triggers) */
-	rwlock_t	  leddev_list_lock;
+	spinlock_t	  leddev_list_lock;
 	struct list_head  led_cdevs;
 
 	/* Link to next registered trigger */
@@ -409,22 +412,11 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 	return led_cdev->trigger_data;
 }
 
-/**
- * led_trigger_rename_static - rename a trigger
- * @name: the new trigger name
- * @trig: the LED trigger to rename
- *
- * Change a LED trigger name by copying the string passed in
- * name into current trigger name, which MUST be large
- * enough for the new string.
- *
- * Note that name must NOT point to the same string used
- * during LED registration, as that could lead to races.
- *
- * This is meant to be used on triggers with statically
- * allocated name.
- */
-void led_trigger_rename_static(const char *name, struct led_trigger *trig);
+static inline enum led_brightness
+led_trigger_get_brightness(const struct led_trigger *trigger)
+{
+	return trigger ? trigger->brightness : LED_OFF;
+}
 
 #define module_led_trigger(__led_trigger) \
 	module_driver(__led_trigger, led_trigger_register, \
@@ -462,6 +454,12 @@ static inline void *led_get_trigger_data(struct led_classdev *led_cdev)
 	return NULL;
 }
 
+static inline enum led_brightness
+led_trigger_get_brightness(const struct led_trigger *trigger)
+{
+	return LED_OFF;
+}
+
 #endif /* CONFIG_LEDS_TRIGGERS */
 
 /* Trigger specific functions */
diff --git a/include/linux/objagg.h b/include/linux/objagg.h
index 78021777df46..6df5b887dc54 100644
--- a/include/linux/objagg.h
+++ b/include/linux/objagg.h
@@ -8,7 +8,6 @@ struct objagg_ops {
 	size_t obj_size;
 	bool (*delta_check)(void *priv, const void *parent_obj,
 			    const void *obj);
-	int (*hints_obj_cmp)(const void *obj1, const void *obj2);
 	void * (*delta_create)(void *priv, void *parent_obj, void *obj);
 	void (*delta_destroy)(void *priv, void *delta_priv);
 	void * (*root_create)(void *priv, void *obj, unsigned int root_id);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2590ccda29ab..66e95df2e686 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2113,6 +2113,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 200995c5210e..7cc581e0ee69 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -732,6 +732,7 @@ struct perf_event {
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
+	struct rcuwait			pending_work_wait;
 
 	atomic_t			event_limit;
 
diff --git a/include/linux/profile.h b/include/linux/profile.h
index fd18ca96f557..c5cb3155597e 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -11,7 +11,6 @@
 
 #define CPU_PROFILING	1
 #define SCHED_PROFILING	2
-#define SLEEP_PROFILING	3
 #define KVM_PROFILING	4
 
 struct proc_dir_entry;
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 9743f7d173a0..13c95782c063 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -347,6 +347,12 @@ extern void sigqueue_free(struct sigqueue *);
 extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
+static inline void clear_notify_signal(void)
+{
+	clear_thread_flag(TIF_NOTIFY_SIGNAL);
+	smp_mb__after_atomic();
+}
+
 static inline int restart_syscall(void)
 {
 	set_tsk_thread_flag(current, TIF_SIGPENDING);
diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index 5b8a93f288bb..ad9432313627 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -24,7 +24,8 @@ int task_work_add(struct task_struct *task, struct callback_head *twork,
 
 struct callback_head *task_work_cancel_match(struct task_struct *task,
 	bool (*match)(struct callback_head *, void *data), void *data);
-struct callback_head *task_work_cancel(struct task_struct *, task_work_func_t);
+struct callback_head *task_work_cancel_func(struct task_struct *, task_work_func_t);
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb);
 void task_work_run(void);
 
 static inline void exit_task_work(struct task_struct *task)
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 511c43ce9421..d5618d96ade6 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -828,7 +828,6 @@ do {									\
 struct perf_event;
 
 DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
-DECLARE_PER_CPU(int, bpf_kprobe_override);
 
 extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index 6047058d6703..29b19d0a324c 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -51,6 +51,7 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 	unsigned int thlen = 0;
 	unsigned int p_off = 0;
 	unsigned int ip_proto;
+	u64 ret, remainder, gso_size;
 
 	if (hdr->gso_type != VIRTIO_NET_HDR_GSO_NONE) {
 		switch (hdr->gso_type & ~VIRTIO_NET_HDR_GSO_ECN) {
@@ -87,6 +88,16 @@ static inline int virtio_net_hdr_to_skb(struct sk_buff *skb,
 		u32 off = __virtio16_to_cpu(little_endian, hdr->csum_offset);
 		u32 needed = start + max_t(u32, thlen, off + sizeof(__sum16));
 
+		if (hdr->gso_size) {
+			gso_size = __virtio16_to_cpu(little_endian, hdr->gso_size);
+			ret = div64_u64_rem(skb->len, gso_size, &remainder);
+			if (!(ret && (hdr->gso_size > needed) &&
+						((remainder > needed) || (remainder == 0)))) {
+				return -EINVAL;
+			}
+			skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
+		}
+
 		if (!pskb_may_pull(skb, needed))
 			return -EINVAL;
 
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3ff6b3362800..3e92331d8c9a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -374,7 +374,7 @@ static inline void *nft_expr_priv(const struct nft_expr *expr)
 	return (void *)expr->data;
 }
 
-int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src);
+int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp);
 void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr);
 int nft_expr_dump(struct sk_buff *skb, unsigned int attr,
 		  const struct nft_expr *expr);
@@ -772,10 +772,16 @@ static inline struct nft_set_elem_expr *nft_set_ext_expr(const struct nft_set_ex
 	return nft_set_ext(ext, NFT_SET_EXT_EXPRESSIONS);
 }
 
-static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+static inline bool __nft_set_elem_expired(const struct nft_set_ext *ext,
+					  u64 tstamp)
 {
 	return nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION) &&
-	       time_is_before_eq_jiffies64(*nft_set_ext_expiration(ext));
+	       time_after_eq64(tstamp, *nft_set_ext_expiration(ext));
+}
+
+static inline bool nft_set_elem_expired(const struct nft_set_ext *ext)
+{
+	return __nft_set_elem_expired(ext, get_jiffies_64());
 }
 
 static inline struct nft_set_ext *nft_set_elem_ext(const struct nft_set *set,
@@ -866,7 +872,7 @@ struct nft_expr_ops {
 						struct nft_regs *regs,
 						const struct nft_pktinfo *pkt);
 	int				(*clone)(struct nft_expr *dst,
-						 const struct nft_expr *src);
+						 const struct nft_expr *src, gfp_t gfp);
 	unsigned int			size;
 
 	int				(*init)(const struct nft_ctx *ctx,
@@ -1679,6 +1685,7 @@ struct nftables_pernet {
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
 	u64			table_handle;
+	u64			tstamp;
 	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
@@ -1691,4 +1698,9 @@ static inline struct nftables_pernet *nft_pernet(const struct net *net)
 	return net_generic(net, nf_tables_net_id);
 }
 
+static inline u64 nft_net_tstamp(const struct net *net)
+{
+	return nft_pernet(net)->tstamp;
+}
+
 #endif /* _NET_NF_TABLES_H */
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 3ae61ce2eabd..bf3716fe83e0 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -509,8 +509,8 @@ static inline int sctp_ep_hashfn(struct net *net, __u16 lport)
 	return (net_hash_mix(net) + lport) & (sctp_ep_hashsize - 1);
 }
 
-#define sctp_for_each_hentry(epb, head) \
-	hlist_for_each_entry(epb, head, node)
+#define sctp_for_each_hentry(ep, head) \
+	hlist_for_each_entry(ep, head, node)
 
 /* Is a socket of this style? */
 #define sctp_style(sk, style) __sctp_style((sk), (SCTP_SOCKET_##style))
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 790252c1478b..821b20a0f882 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1244,10 +1244,6 @@ enum sctp_endpoint_type {
  */
 
 struct sctp_ep_common {
-	/* Fields to help us manage our entries in the hash tables. */
-	struct hlist_node node;
-	int hashent;
-
 	/* Runtime type information.  What kind of endpoint is this? */
 	enum sctp_endpoint_type type;
 
@@ -1299,6 +1295,10 @@ struct sctp_endpoint {
 	/* Common substructure for endpoint and association. */
 	struct sctp_ep_common base;
 
+	/* Fields to help us manage our entries in the hash tables. */
+	struct hlist_node node;
+	int hashent;
+
 	/* Associations: A list of current associations and mappings
 	 *	      to the data consumers for each association. This
 	 *	      may be in the form of a hash table or other
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 30f8111f750b..061e15a1ac87 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -612,6 +612,7 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
 /* tcp_input.c */
 void tcp_rearm_rto(struct sock *sk);
 void tcp_synack_rtt_meas(struct sock *sk, struct request_sock *req);
+void tcp_done_with_error(struct sock *sk, int err);
 void tcp_reset(struct sock *sk, struct sk_buff *skb);
 void tcp_skb_mark_lost_uncond_verify(struct tcp_sock *tp, struct sk_buff *skb);
 void tcp_fin(struct sock *sk);
diff --git a/include/trace/events/mptcp.h b/include/trace/events/mptcp.h
index 6bf43176f14c..df26c1dd3d8d 100644
--- a/include/trace/events/mptcp.h
+++ b/include/trace/events/mptcp.h
@@ -34,7 +34,7 @@ TRACE_EVENT(mptcp_subflow_get_send,
 		struct sock *ssk;
 
 		__entry->active = mptcp_subflow_active(subflow);
-		__entry->backup = subflow->backup;
+		__entry->backup = subflow->backup || subflow->request_bkup;
 
 		if (subflow->tcp_sock && sk_fullsock(subflow->tcp_sock))
 			__entry->free = sk_stream_memory_free(subflow->tcp_sock);
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index 6959255ccfa9..3e4f767fbfc1 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -54,7 +54,7 @@ TRACE_DEFINE_ENUM(GSS_S_UNSEQ_TOKEN);
 TRACE_DEFINE_ENUM(GSS_S_GAP_TOKEN);
 
 #define show_gss_status(x)						\
-	__print_flags(x, "|",						\
+	__print_symbolic(x, 						\
 		{ GSS_S_BAD_MECH, "GSS_S_BAD_MECH" },			\
 		{ GSS_S_BAD_NAME, "GSS_S_BAD_NAME" },			\
 		{ GSS_S_BAD_NAMETYPE, "GSS_S_BAD_NAMETYPE" },		\
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 62cc780a168a..c0edc1a2c8e6 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1320,7 +1320,7 @@ enum nft_secmark_attributes {
 #define NFTA_SECMARK_MAX	(__NFTA_SECMARK_MAX - 1)
 
 /* Max security context length */
-#define NFT_SECMARK_CTX_MAXLEN		256
+#define NFT_SECMARK_CTX_MAXLEN		4096
 
 /**
  * enum nft_reject_types - nf_tables reject expression reject types
diff --git a/include/uapi/linux/zorro_ids.h b/include/uapi/linux/zorro_ids.h
index 6e574d7b7d79..393f2ee9c042 100644
--- a/include/uapi/linux/zorro_ids.h
+++ b/include/uapi/linux/zorro_ids.h
@@ -449,6 +449,9 @@
 #define  ZORRO_PROD_VMC_ISDN_BLASTER_Z2				ZORRO_ID(VMC, 0x01, 0)
 #define  ZORRO_PROD_VMC_HYPERCOM_4				ZORRO_ID(VMC, 0x02, 0)
 
+#define ZORRO_MANUF_CSLAB					0x1400
+#define  ZORRO_PROD_CSLAB_WARP_1260				ZORRO_ID(CSLAB, 0x65, 0)
+
 #define ZORRO_MANUF_INFORMATION					0x157C
 #define  ZORRO_PROD_INFORMATION_ISDN_ENGINE_I			ZORRO_ID(INFORMATION, 0x64, 0)
 
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index fe8594a0396c..c5d249f5d214 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -19,6 +19,7 @@
 #include "io-wq.h"
 
 #define WORKER_IDLE_TIMEOUT	(5 * HZ)
+#define WORKER_INIT_LIMIT	3
 
 enum {
 	IO_WORKER_F_UP		= 1,	/* up and active */
@@ -54,6 +55,7 @@ struct io_worker {
 	unsigned long create_state;
 	struct callback_head create_work;
 	int create_index;
+	int init_retries;
 
 	union {
 		struct rcu_head rcu;
@@ -732,7 +734,7 @@ static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
 	return true;
 }
 
-static inline bool io_should_retry_thread(long err)
+static inline bool io_should_retry_thread(struct io_worker *worker, long err)
 {
 	/*
 	 * Prevent perpetual task_work retry, if the task (or its group) is
@@ -740,6 +742,8 @@ static inline bool io_should_retry_thread(long err)
 	 */
 	if (fatal_signal_pending(current))
 		return false;
+	if (worker->init_retries++ >= WORKER_INIT_LIMIT)
+		return false;
 
 	switch (err) {
 	case -EAGAIN:
@@ -766,7 +770,7 @@ static void create_worker_cont(struct callback_head *cb)
 		io_init_new_worker(wqe, worker, tsk);
 		io_worker_release(worker);
 		return;
-	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
+	} else if (!io_should_retry_thread(worker, PTR_ERR(tsk))) {
 		struct io_wqe_acct *acct = io_wqe_get_acct(worker);
 
 		atomic_dec(&acct->nr_running);
@@ -831,7 +835,7 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
 	if (!IS_ERR(tsk)) {
 		io_init_new_worker(wqe, worker, tsk);
-	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
+	} else if (!io_should_retry_thread(worker, PTR_ERR(tsk))) {
 		kfree(worker);
 		goto fail;
 	} else {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ea005700c8ce..8ed2c6552971 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -9856,8 +9856,11 @@ static void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 	atomic_inc(&tctx->in_idle);
 	do {
 		io_uring_drop_tctx_refs(current);
+		if (!tctx_inflight(tctx, !cancel_all))
+			break;
+
 		/* read completions before cancelations */
-		inflight = tctx_inflight(tctx, !cancel_all);
+		inflight = tctx_inflight(tctx, false);
 		if (!inflight)
 			break;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index a0c7e13e0ab4..d3eb75bfd971 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -349,7 +349,7 @@ const char *btf_type_str(const struct btf_type *t)
 struct btf_show {
 	u64 flags;
 	void *target;	/* target of show operation (seq file, buffer) */
-	void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
+	__printf(2, 0) void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
 	const struct btf *btf;
 	/* below are used during iteration */
 	struct {
@@ -5808,8 +5808,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
 	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
 }
 
-static void btf_seq_show(struct btf_show *show, const char *fmt,
-			 va_list args)
+__printf(2, 0) static void btf_seq_show(struct btf_show *show, const char *fmt,
+					va_list args)
 {
 	seq_vprintf((struct seq_file *)show->target, fmt, args);
 }
@@ -5842,8 +5842,8 @@ struct btf_show_snprintf {
 	int len;		/* length we would have written */
 };
 
-static void btf_snprintf_show(struct btf_show *show, const char *fmt,
-			      va_list args)
+__printf(2, 0) static void btf_snprintf_show(struct btf_show *show, const char *fmt,
+					     va_list args)
 {
 	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
 	int len;
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index a3b4b55d2e2e..b28b8a5ef638 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -194,7 +194,7 @@ char kdb_getchar(void)
  */
 static void kdb_position_cursor(char *prompt, char *buffer, char *cp)
 {
-	kdb_printf("\r%s", kdb_prompt_str);
+	kdb_printf("\r%s", prompt);
 	if (cp > buffer)
 		kdb_printf("%.*s", (int)(cp - buffer), buffer);
 }
@@ -358,7 +358,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			if (i >= dtab_count)
 				kdb_printf("...");
 			kdb_printf("\n");
-			kdb_printf(kdb_prompt_str);
+			kdb_printf("%s",  kdb_prompt_str);
 			kdb_printf("%s", buffer);
 			if (cp != lastchar)
 				kdb_position_cursor(kdb_prompt_str, buffer, cp);
@@ -450,7 +450,7 @@ char *kdb_getstr(char *buffer, size_t bufsize, const char *prompt)
 {
 	if (prompt && kdb_prompt_str != prompt)
 		strscpy(kdb_prompt_str, prompt, CMD_BUFLEN);
-	kdb_printf(kdb_prompt_str);
+	kdb_printf("%s", kdb_prompt_str);
 	kdb_nextline = 1;	/* Prompt and input resets line number */
 	return kdb_read(buffer, bufsize);
 }
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index c9dbc8f5812b..9e1a724ae7e7 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -62,8 +62,8 @@ void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	struct dma_devres match_data = { size, vaddr, dma_handle };
 
-	dma_free_coherent(dev, size, vaddr, dma_handle);
 	WARN_ON(devres_destroy(dev, dmam_release, dmam_match, &match_data));
+	dma_free_coherent(dev, size, vaddr, dma_handle);
 }
 EXPORT_SYMBOL(dmam_free_coherent);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80d9c8fcc30a..9f3da1e05e46 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2395,18 +2395,14 @@ event_sched_out(struct perf_event *event,
 	}
 
 	if (event->pending_sigtrap) {
-		bool dec = true;
-
 		event->pending_sigtrap = 0;
 		if (state != PERF_EVENT_STATE_OFF &&
-		    !event->pending_work) {
+		    !event->pending_work &&
+		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
 			event->pending_work = 1;
-			dec = false;
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-			task_work_add(current, &event->pending_task, TWA_RESUME);
-		}
-		if (dec)
+		} else {
 			local_dec(&event->ctx->nr_pending);
+		}
 	}
 
 	perf_event_set_state(event, state);
@@ -5101,9 +5097,35 @@ static bool exclusive_event_installable(struct perf_event *event,
 static void perf_addr_filters_splice(struct perf_event *event,
 				       struct list_head *head);
 
+static void perf_pending_task_sync(struct perf_event *event)
+{
+	struct callback_head *head = &event->pending_task;
+
+	if (!event->pending_work)
+		return;
+	/*
+	 * If the task is queued to the current task's queue, we
+	 * obviously can't wait for it to complete. Simply cancel it.
+	 */
+	if (task_work_cancel(current, head)) {
+		event->pending_work = 0;
+		local_dec(&event->ctx->nr_pending);
+		return;
+	}
+
+	/*
+	 * All accesses related to the event are within the same
+	 * non-preemptible section in perf_pending_task(). The RCU
+	 * grace period before the event is freed will make sure all
+	 * those accesses are complete by then.
+	 */
+	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
+}
+
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	perf_pending_task_sync(event);
 
 	unaccount_event(event);
 
@@ -6401,6 +6423,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EINVAL;
 
 		nr_pages = vma_size / PAGE_SIZE;
+		if (nr_pages > INT_MAX)
+			return -ENOMEM;
 
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;
@@ -6731,24 +6755,28 @@ static void perf_pending_task(struct callback_head *head)
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
+	/*
+	 * All accesses to the event must belong to the same implicit RCU read-side
+	 * critical section as the ->pending_work reset. See comment in
+	 * perf_pending_task_sync().
+	 */
+	preempt_disable_notrace();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
 	 */
-	preempt_disable_notrace();
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
 		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_pending);
+		rcuwait_wake_up(&event->pending_work_wait);
 	}
 
 	if (rctx >= 0)
 		perf_swevent_put_recursion_context(rctx);
 	preempt_enable_notrace();
-
-	put_event(event);
 }
 
 /*              
@@ -9166,21 +9194,19 @@ static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
 	bool unregister = type == PERF_BPF_EVENT_PROG_UNLOAD;
 	int i;
 
-	if (prog->aux->func_cnt == 0) {
-		perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
-				   (u64)(unsigned long)prog->bpf_func,
-				   prog->jited_len, unregister,
-				   prog->aux->ksym.name);
-	} else {
-		for (i = 0; i < prog->aux->func_cnt; i++) {
-			struct bpf_prog *subprog = prog->aux->func[i];
-
-			perf_event_ksymbol(
-				PERF_RECORD_KSYMBOL_TYPE_BPF,
-				(u64)(unsigned long)subprog->bpf_func,
-				subprog->jited_len, unregister,
-				subprog->aux->ksym.name);
-		}
+	perf_event_ksymbol(PERF_RECORD_KSYMBOL_TYPE_BPF,
+			   (u64)(unsigned long)prog->bpf_func,
+			   prog->jited_len, unregister,
+			   prog->aux->ksym.name);
+
+	for (i = 1; i < prog->aux->func_cnt; i++) {
+		struct bpf_prog *subprog = prog->aux->func[i];
+
+		perf_event_ksymbol(
+			PERF_RECORD_KSYMBOL_TYPE_BPF,
+			(u64)(unsigned long)subprog->bpf_func,
+			subprog->jited_len, unregister,
+			subprog->aux->ksym.name);
 	}
 }
 
@@ -11786,6 +11812,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
 	init_task_work(&event->pending_task, perf_pending_task);
+	rcuwait_init(&event->pending_work_wait);
 
 	mutex_init(&event->mmap_mutex);
 	raw_spin_lock_init(&event->addr_filters.lock);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c03..386d21c7edfa 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -128,7 +128,7 @@ static inline unsigned long perf_data_size(struct perf_buffer *rb)
 
 static inline unsigned long perf_aux_size(struct perf_buffer *rb)
 {
-	return rb->aux_nr_pages << PAGE_SHIFT;
+	return (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
 }
 
 #define __DEFINE_OUTPUT_COPY_BODY(advance_buf, memcpy_func, ...)	\
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 45965f13757e..f3a3c294ff2b 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -683,7 +683,9 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 		 * max_order, to aid PMU drivers in double buffering.
 		 */
 		if (!watermark)
-			watermark = nr_pages << (PAGE_SHIFT - 1);
+			watermark = min_t(unsigned long,
+					  U32_MAX,
+					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
 
 		/*
 		 * Use aux_watermark as the basis for chunking to
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f3920374f71c..0a893df1b809 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -38,7 +38,7 @@ struct irqaction chained_action = {
  *	@irq:	irq number
  *	@chip:	pointer to irq chip description structure
  */
-int irq_set_chip(unsigned int irq, struct irq_chip *chip)
+int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 {
 	unsigned long flags;
 	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
@@ -46,10 +46,7 @@ int irq_set_chip(unsigned int irq, struct irq_chip *chip)
 	if (!desc)
 		return -EINVAL;
 
-	if (!chip)
-		chip = &no_irq_chip;
-
-	desc->irq_data.chip = chip;
+	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1075,7 +1072,7 @@ irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
 EXPORT_SYMBOL_GPL(irq_set_chained_handler_and_data);
 
 void
-irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+irq_set_chip_and_handler_name(unsigned int irq, const struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name)
 {
 	irq_set_chip(irq, chip);
@@ -1559,6 +1556,17 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	return 0;
 }
 
+static struct device *irq_get_parent_device(struct irq_data *data)
+{
+	if (data->chip->parent_device)
+		return data->chip->parent_device;
+
+	if (data->domain)
+		return data->domain->dev;
+
+	return NULL;
+}
+
 /**
  * irq_chip_pm_get - Enable power for an IRQ chip
  * @data:	Pointer to interrupt specific data
@@ -1568,12 +1576,13 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
  */
 int irq_chip_pm_get(struct irq_data *data)
 {
+	struct device *dev = irq_get_parent_device(data);
 	int retval;
 
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device) {
-		retval = pm_runtime_get_sync(data->chip->parent_device);
+	if (IS_ENABLED(CONFIG_PM) && dev) {
+		retval = pm_runtime_get_sync(dev);
 		if (retval < 0) {
-			pm_runtime_put_noidle(data->chip->parent_device);
+			pm_runtime_put_noidle(dev);
 			return retval;
 		}
 	}
@@ -1591,10 +1600,11 @@ int irq_chip_pm_get(struct irq_data *data)
  */
 int irq_chip_pm_put(struct irq_data *data)
 {
+	struct device *dev = irq_get_parent_device(data);
 	int retval = 0;
 
-	if (IS_ENABLED(CONFIG_PM) && data->chip->parent_device)
-		retval = pm_runtime_put(data->chip->parent_device);
+	if (IS_ENABLED(CONFIG_PM) && dev)
+		retval = pm_runtime_put(dev);
 
 	return (retval < 0) ? retval : 0;
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 7a45fd593245..d5010a24ed16 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -493,6 +493,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |= IRQD_AFFINITY_SET;
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e0b67784ac1e..4ac1c01346d4 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -153,7 +153,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->fwnode = fwnode;
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name) {
 				kfree(domain);
@@ -162,7 +161,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
-			domain->fwnode = fwnode;
 			domain->name = fwid->name;
 			break;
 		}
@@ -184,7 +182,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		strreplace(name, '/', ':');
 
 		domain->name = name;
-		domain->fwnode = fwnode;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
@@ -200,8 +197,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
-	fwnode_handle_get(fwnode);
-	fwnode_dev_initialized(fwnode, true);
+	domain->fwnode = fwnode_handle_get(fwnode);
+	fwnode_dev_initialized(domain->fwnode, true);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 9862372e0f01..b46fbfbb929f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1330,7 +1330,7 @@ static int irq_thread(void *data)
 	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
-	task_work_cancel(current, irq_thread_dtor);
+	task_work_cancel_func(current, irq_thread_dtor);
 	return 0;
 }
 
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 793486e00dd6..9e89b34321f7 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -151,6 +151,15 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
 	list_add(&area->list, &kcov_remote_areas);
 }
 
+/*
+ * Unlike in_serving_softirq(), this function returns false when called during
+ * a hardirq or an NMI that happened in the softirq context.
+ */
+static inline bool in_softirq_really(void)
+{
+	return in_serving_softirq() && !in_hardirq() && !in_nmi();
+}
+
 static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 {
 	unsigned int mode;
@@ -160,7 +169,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
 	 * so we ignore code executed in interrupts, unless we are in a remote
 	 * coverage collection section in a softirq.
 	 */
-	if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
+	if (!in_task() && !(in_softirq_really() && t->kcov_softirq))
 		return false;
 	mode = READ_ONCE(t->kcov_mode);
 	/*
@@ -822,7 +831,7 @@ void kcov_remote_start(u64 handle)
 
 	if (WARN_ON(!kcov_check_handle(handle, true, true, true)))
 		return;
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_irq_save(flags);
@@ -963,7 +972,7 @@ void kcov_remote_stop(void)
 	int sequence;
 	unsigned long flags;
 
-	if (!in_task() && !in_serving_softirq())
+	if (!in_task() && !in_softirq_really())
 		return;
 
 	local_irq_save(flags);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 258d425b2c4a..0d463859ad32 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1545,8 +1545,8 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
 	if (lookup_symbol_name(addr, symbuf))
 		return false;
 
-	return str_has_prefix("__cfi_", symbuf) ||
-		str_has_prefix("__pfx_", symbuf);
+	return str_has_prefix(symbuf, "__cfi_") ||
+		str_has_prefix(symbuf, "__pfx_");
 }
 
 static int check_kprobe_address_safe(struct kprobe *p,
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 4a38d32b89fa..eca42c14ec09 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1286,7 +1286,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline int __down_write_common(struct rw_semaphore *sem, int state)
+static __always_inline int __down_write_common(struct rw_semaphore *sem, int state)
 {
 	if (unlikely(!rwsem_write_trylock(sem))) {
 		if (IS_ERR(rwsem_down_write_slowpath(sem, state)))
@@ -1296,12 +1296,12 @@ static inline int __down_write_common(struct rw_semaphore *sem, int state)
 	return 0;
 }
 
-static inline void __down_write(struct rw_semaphore *sem)
+static __always_inline void __down_write(struct rw_semaphore *sem)
 {
 	__down_write_common(sem, TASK_UNINTERRUPTIBLE);
 }
 
-static inline int __down_write_killable(struct rw_semaphore *sem)
+static __always_inline int __down_write_killable(struct rw_semaphore *sem)
 {
 	return __down_write_common(sem, TASK_KILLABLE);
 }
diff --git a/kernel/padata.c b/kernel/padata.c
index 809978bb249c..7c52f9de5d4e 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -508,6 +508,13 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
 	ps.chunk_size = max(ps.chunk_size, job->min_chunk);
 	ps.chunk_size = roundup(ps.chunk_size, job->align);
 
+	/*
+	 * chunk_size can be 0 if the caller sets min_chunk to 0. So force it
+	 * to at least 1 to prevent divide-by-0 panic in padata_mt_helper().`
+	 */
+	if (!ps.chunk_size)
+		ps.chunk_size = 1U;
+
 	list_for_each_entry(pw, &works, pw_list)
 		queue_work(system_unbound_wq, &pw->pw_work);
 
diff --git a/kernel/profile.c b/kernel/profile.c
index 0db1122855c0..e9a1efe18caf 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -57,24 +57,10 @@ static DEFINE_MUTEX(profile_flip_mutex);
 int profile_setup(char *str)
 {
 	static const char schedstr[] = "schedule";
-	static const char sleepstr[] = "sleep";
 	static const char kvmstr[] = "kvm";
 	int par;
 
-	if (!strncmp(str, sleepstr, strlen(sleepstr))) {
-#ifdef CONFIG_SCHEDSTATS
-		force_schedstat_enabled();
-		prof_on = SLEEP_PROFILING;
-		if (str[strlen(sleepstr)] == ',')
-			str += strlen(sleepstr) + 1;
-		if (get_option(&str, &par))
-			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
-		pr_info("kernel sleep profiling enabled (shift: %u)\n",
-			prof_shift);
-#else
-		pr_warn("kernel sleep profiling requires CONFIG_SCHEDSTATS\n");
-#endif /* CONFIG_SCHEDSTATS */
-	} else if (!strncmp(str, schedstr, strlen(schedstr))) {
+	if (!strncmp(str, schedstr, strlen(schedstr))) {
 		prof_on = SCHED_PROFILING;
 		if (str[strlen(schedstr)] == ',')
 			str += strlen(schedstr) + 1;
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9d8d1f233d7b..a3bab6af4028 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2186,7 +2186,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
 	rfcpp = rfp->rcu_fwd_cb_tail;
 	rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
-	WRITE_ONCE(*rfcpp, rfcp);
+	smp_store_release(rfcpp, rfcp);
 	WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
 	i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
 	if (i >= ARRAY_SIZE(rfp->n_launders_hist))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b43da6201b9a..21b4f96d80a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1203,27 +1203,24 @@ int tg_nop(struct task_group *tg, void *data)
 static void set_load_weight(struct task_struct *p, bool update_load)
 {
 	int prio = p->static_prio - MAX_RT_PRIO;
-	struct load_weight *load = &p->se.load;
+	struct load_weight lw;
 
-	/*
-	 * SCHED_IDLE tasks get minimal weight:
-	 */
 	if (task_has_idle_policy(p)) {
-		load->weight = scale_load(WEIGHT_IDLEPRIO);
-		load->inv_weight = WMULT_IDLEPRIO;
-		return;
+		lw.weight = scale_load(WEIGHT_IDLEPRIO);
+		lw.inv_weight = WMULT_IDLEPRIO;
+	} else {
+		lw.weight = scale_load(sched_prio_to_weight[prio]);
+		lw.inv_weight = sched_prio_to_wmult[prio];
 	}
 
 	/*
 	 * SCHED_OTHER tasks have to update their load when changing their
 	 * weight
 	 */
-	if (update_load && p->sched_class == &fair_sched_class) {
-		reweight_task(p, prio);
-	} else {
-		load->weight = scale_load(sched_prio_to_weight[prio]);
-		load->inv_weight = sched_prio_to_wmult[prio];
-	}
+	if (update_load && p->sched_class == &fair_sched_class)
+		reweight_task(p, &lw);
+	else
+		p->se.load = lw;
 }
 
 #ifdef CONFIG_UCLAMP_TASK
@@ -9104,6 +9101,22 @@ static int cpuset_cpu_inactive(unsigned int cpu)
 	return 0;
 }
 
+static inline void sched_smt_present_inc(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_inc_cpuslocked(&sched_smt_present);
+#endif
+}
+
+static inline void sched_smt_present_dec(int cpu)
+{
+#ifdef CONFIG_SCHED_SMT
+	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
+		static_branch_dec_cpuslocked(&sched_smt_present);
+#endif
+}
+
 int sched_cpu_activate(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -9115,13 +9128,10 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	balance_push_set(cpu, false);
 
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_inc_cpuslocked(&sched_smt_present);
-#endif
+	sched_smt_present_inc(cpu);
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
@@ -9190,13 +9200,12 @@ int sched_cpu_deactivate(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
-#ifdef CONFIG_SCHED_SMT
 	/*
 	 * When going down, decrement the number of cores with SMT present.
 	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) == 2)
-		static_branch_dec_cpuslocked(&sched_smt_present);
+	sched_smt_present_dec(cpu);
 
+#ifdef CONFIG_SCHED_SMT
 	sched_core_cpu_deactivate(cpu);
 #endif
 
@@ -9205,6 +9214,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
+		sched_smt_present_inc(cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		return ret;
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 042a6dbce8f3..e3022598f7b0 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -577,6 +577,12 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	}
 
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	/*
+	 * Because mul_u64_u64_div_u64() can approximate on some
+	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
+	 */
+	if (unlikely(stime > rtime))
+		stime = rtime;
 
 update:
 	/*
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 94fcd585eb7f..68793b50adad 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -988,16 +988,6 @@ update_stats_enqueue_sleeper(struct cfs_rq *cfs_rq, struct sched_entity *se)
 
 			trace_sched_stat_blocked(tsk, delta);
 
-			/*
-			 * Blocking time is in units of nanosecs, so shift by
-			 * 20 to get a milliseconds-range estimation of the
-			 * amount of time that the task spent sleeping:
-			 */
-			if (unlikely(prof_on == SLEEP_PROFILING)) {
-				profile_hits(SLEEP_PROFILING,
-						(void *)get_wchan(tsk),
-						delta >> 20);
-			}
 			account_scheduler_latency(tsk, delta >> 10, 0);
 		}
 	}
@@ -3121,15 +3111,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 }
 
-void reweight_task(struct task_struct *p, int prio)
+void reweight_task(struct task_struct *p, const struct load_weight *lw)
 {
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct load_weight *load = &se->load;
-	unsigned long weight = scale_load(sched_prio_to_weight[prio]);
 
-	reweight_entity(cfs_rq, se, weight);
-	load->inv_weight = sched_prio_to_wmult[prio];
+	reweight_entity(cfs_rq, se, lw->weight);
+	load->inv_weight = lw->inv_weight;
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -8242,7 +8231,7 @@ static int detach_tasks(struct lb_env *env)
 		case migrate_util:
 			util = task_util_est(p);
 
-			if (util > env->imbalance)
+			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= util;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5061093d9baa..48bcc1876df8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2322,7 +2322,7 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
+extern void reweight_task(struct task_struct *p, const struct load_weight *lw);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
diff --git a/kernel/signal.c b/kernel/signal.c
index c7dbb19219b9..08bccdbb1b46 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2579,6 +2579,14 @@ static void do_freezer_trap(void)
 	spin_unlock_irq(&current->sighand->siglock);
 	cgroup_enter_frozen();
 	freezable_schedule();
+
+	/*
+	 * We could've been woken by task_work, run it to clear
+	 * TIF_NOTIFY_SIGNAL. The caller will retry if necessary.
+	 */
+	clear_notify_signal();
+	if (unlikely(READ_ONCE(current->task_works)))
+		task_work_run();
 }
 
 static int ptrace_signal(int signr, kernel_siginfo_t *info)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 1698fbe6f0e1..b8515291f742 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -104,9 +104,9 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
 }
 
 /**
- * task_work_cancel - cancel a pending work added by task_work_add()
- * @task: the task which should execute the work
- * @func: identifies the work to remove
+ * task_work_cancel_func - cancel a pending work matching a function added by task_work_add()
+ * @task: the task which should execute the func's work
+ * @func: identifies the func to match with a work to remove
  *
  * Find the last queued pending work with ->func == @func and remove
  * it from queue.
@@ -115,11 +115,35 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
  * The found work or NULL if not found.
  */
 struct callback_head *
-task_work_cancel(struct task_struct *task, task_work_func_t func)
+task_work_cancel_func(struct task_struct *task, task_work_func_t func)
 {
 	return task_work_cancel_match(task, task_work_func_match, func);
 }
 
+static bool task_work_match(struct callback_head *cb, void *data)
+{
+	return cb == data;
+}
+
+/**
+ * task_work_cancel - cancel a pending work added by task_work_add()
+ * @task: the task which should execute the work
+ * @cb: the callback to remove if queued
+ *
+ * Remove a callback from a task's queue if queued.
+ *
+ * RETURNS:
+ * True if the callback was queued and got cancelled, false otherwise.
+ */
+bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
+{
+	struct callback_head *ret;
+
+	ret = task_work_cancel_match(task, task_work_match, cb);
+
+	return ret == cb;
+}
+
 /**
  * task_work_run - execute the works added by task_work_add()
  *
@@ -152,7 +176,7 @@ void task_work_run(void)
 		if (!work)
 			break;
 		/*
-		 * Synchronize with task_work_cancel(). It can not remove
+		 * Synchronize with task_work_cancel_match(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
 		 * But it can remove another entry from the ->next list.
 		 */
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index df922f49d171..d06185e054ea 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -104,8 +104,8 @@ static void wdtest_ktime_clocksource_reset(void)
 static int wdtest_func(void *arg)
 {
 	unsigned long j1, j2;
+	int i, max_retries;
 	char *s;
-	int i;
 
 	schedule_timeout_uninterruptible(holdoff * HZ);
 
@@ -139,18 +139,19 @@ static int wdtest_func(void *arg)
 	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
 
 	/* Verify tsc-like stability with various numbers of errors injected. */
-	for (i = 0; i <= max_cswd_read_retries + 1; i++) {
-		if (i <= 1 && i < max_cswd_read_retries)
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (i = 0; i <= max_retries + 1; i++) {
+		if (i <= 1 && i < max_retries)
 			s = "";
-		else if (i <= max_cswd_read_retries)
+		else if (i <= max_retries)
 			s = ", expect message";
 		else
 			s = ", expect clock skew";
-		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
+		pr_info("--- Watchdog with %dx error injection, %d retries%s.\n", i, max_retries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
 		schedule_timeout_uninterruptible(2 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
+		WARN_ON_ONCE((i <= max_retries) !=
 			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
 		wdtest_ktime_clocksource_reset();
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 7d6d87a22ad5..3ccb383741d0 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -201,9 +201,6 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
-ulong max_cswd_read_retries = 3;
-module_param(max_cswd_read_retries, ulong, 0644);
-EXPORT_SYMBOL_GPL(max_cswd_read_retries);
 static int verify_n_cpus = 8;
 module_param(verify_n_cpus, int, 0644);
 
@@ -215,11 +212,12 @@ enum wd_read_status {
 
 static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 {
-	unsigned int nretries;
+	unsigned int nretries, max_retries;
 	u64 wd_end, wd_end2, wd_delta;
 	int64_t wd_delay, wd_seq_delay;
 
-	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+	max_retries = clocksource_get_max_watchdog_retry();
+	for (nretries = 0; nretries <= max_retries; nretries++) {
 		local_irq_disable();
 		*wdnow = watchdog->read(watchdog);
 		*csnow = cs->read(cs);
@@ -231,7 +229,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult,
 					      watchdog->shift);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+			if (nretries > 1 && nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 406dccb79c2b..8d2dd214ec68 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -727,17 +727,16 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror = txc->maxerror;
+		time_maxerror = clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror = txc->esterror;
+		time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant = txc->constant;
+		time_constant = clamp(txc->constant, 0, MAXTC);
 		if (!(time_status & STA_NANO))
 			time_constant += 4;
-		time_constant = min(time_constant, (long)MAXTC);
-		time_constant = max(time_constant, 0l);
+		time_constant = clamp(time_constant, 0, MAXTC);
 	}
 
 	if (txc->modes & ADJ_TAI &&
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index 0916cc9adb82..13a71a894cc1 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -1144,6 +1144,30 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
 	bc = tick_broadcast_device.evtdev;
 
 	if (bc && broadcast_needs_cpu(bc, deadcpu)) {
+		/*
+		 * If the broadcast force bit of the current CPU is set,
+		 * then the current CPU has not yet reprogrammed the local
+		 * timer device to avoid a ping-pong race. See
+		 * ___tick_broadcast_oneshot_control().
+		 *
+		 * If the broadcast device is hrtimer based then
+		 * programming the broadcast event below does not have any
+		 * effect because the local clockevent device is not
+		 * running and not programmed because the broadcast event
+		 * is not earlier than the pending event of the local clock
+		 * event device. As a consequence all CPUs waiting for a
+		 * broadcast event are stuck forever.
+		 *
+		 * Detect this condition and reprogram the cpu local timer
+		 * device to avoid the starvation.
+		 */
+		if (tick_check_broadcast_expired()) {
+			struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
+
+			cpumask_clear_cpu(smp_processor_id(), tick_broadcast_force_mask);
+			tick_program_event(td->evtdev->next_event, 1);
+		}
+
 		/* This moves the broadcast assignment to this CPU: */
 		clockevents_program_event(bc, bc->next_event, 1);
 	}
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dfa6649c490d..ce3d1377cbc7 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2459,7 +2459,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set(CLOCK_REALTIME);
+		clock_was_set(CLOCK_SET_WALL);
 
 	ntp_notify_cmos_timer();
 
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index 3edf5e515813..7efb74220920 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -454,7 +454,7 @@ static struct tracing_map_elt *get_free_elt(struct tracing_map *map)
 	struct tracing_map_elt *elt = NULL;
 	int idx;
 
-	idx = atomic_inc_return(&map->next_elt);
+	idx = atomic_fetch_add_unless(&map->next_elt, 1, map->max_elts);
 	if (idx < map->max_elts) {
 		elt = *(TRACING_MAP_ELT(map->elts, idx));
 		if (map->ops && map->ops->elt_init)
@@ -699,7 +699,7 @@ void tracing_map_clear(struct tracing_map *map)
 {
 	unsigned int i;
 
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 	atomic64_set(&map->hits, 0);
 	atomic64_set(&map->drops, 0);
 
@@ -783,7 +783,7 @@ struct tracing_map *tracing_map_create(unsigned int map_bits,
 
 	map->map_bits = map_bits;
 	map->max_elts = (1 << map_bits);
-	atomic_set(&map->next_elt, -1);
+	atomic_set(&map->next_elt, 0);
 
 	map->map_size = (1 << (map_bits + 1));
 	map->ops = ops;
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 1e8a49dc956e..8ba4b269ab89 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -91,11 +91,15 @@ static bool watchdog_check_timestamp(void)
 	__this_cpu_write(last_timestamp, now);
 	return true;
 }
-#else
-static inline bool watchdog_check_timestamp(void)
+
+static void watchdog_init_timestamp(void)
 {
-	return true;
+	__this_cpu_write(nmi_rearmed, 0);
+	__this_cpu_write(last_timestamp, ktime_get_mono_fast_ns());
 }
+#else
+static inline bool watchdog_check_timestamp(void) { return true; }
+static inline void watchdog_init_timestamp(void) { }
 #endif
 
 static struct perf_event_attr wd_hw_attr = {
@@ -196,6 +200,7 @@ void hardlockup_detector_perf_enable(void)
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	watchdog_init_timestamp();
 	perf_event_enable(this_cpu_read(watchdog_ev));
 }
 
diff --git a/lib/decompress_bunzip2.c b/lib/decompress_bunzip2.c
index 3518e7394eca..ca736166f100 100644
--- a/lib/decompress_bunzip2.c
+++ b/lib/decompress_bunzip2.c
@@ -232,7 +232,8 @@ static int INIT get_next_block(struct bunzip_data *bd)
 	   RUNB) */
 	symCount = symTotal+2;
 	for (j = 0; j < groupCount; j++) {
-		unsigned char length[MAX_SYMBOLS], temp[MAX_HUFCODE_BITS+1];
+		unsigned char length[MAX_SYMBOLS];
+		unsigned short temp[MAX_HUFCODE_BITS+1];
 		int	minLen,	maxLen, pp;
 		/* Read Huffman code lengths for each symbol.  They're
 		   stored in a way similar to mtf; record a starting
diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index c87d5b6a8a55..38716b2eb671 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -432,8 +432,23 @@ static void zap_modalias_env(struct kobj_uevent_env *env)
 		len = strlen(env->envp[i]) + 1;
 
 		if (i != env->envp_idx - 1) {
+			/* @env->envp[] contains pointers to @env->buf[]
+			 * with @env->buflen chars, and we are removing
+			 * variable MODALIAS here pointed by @env->envp[i]
+			 * with length @len as shown below:
+			 *
+			 * 0               @env->buf[]      @env->buflen
+			 * ---------------------------------------------
+			 * ^             ^              ^              ^
+			 * |             |->   @len   <-| target block |
+			 * @env->envp[0] @env->envp[i]  @env->envp[i + 1]
+			 *
+			 * so the "target block" indicated above is moved
+			 * backward by @len, and its right size is
+			 * @env->buflen - (@env->envp[i + 1] - @env->envp[0]).
+			 */
 			memmove(env->envp[i], env->envp[i + 1],
-				env->buflen - len);
+				env->buflen - (env->envp[i + 1] - env->envp[0]));
 
 			for (j = i; j < env->envp_idx - 1; j++)
 				env->envp[j] = env->envp[j + 1] - len;
diff --git a/lib/objagg.c b/lib/objagg.c
index 5e1676ccdadd..57bde522f249 100644
--- a/lib/objagg.c
+++ b/lib/objagg.c
@@ -167,6 +167,9 @@ static int objagg_obj_parent_assign(struct objagg *objagg,
 {
 	void *delta_priv;
 
+	if (WARN_ON(!objagg_obj_is_root(parent)))
+		return -EINVAL;
+
 	delta_priv = objagg->ops->delta_create(objagg->priv, parent->obj,
 					       objagg_obj->obj);
 	if (IS_ERR(delta_priv))
@@ -906,20 +909,6 @@ static const struct objagg_opt_algo *objagg_opt_algos[] = {
 	[OBJAGG_OPT_ALGO_SIMPLE_GREEDY] = &objagg_opt_simple_greedy,
 };
 
-static int objagg_hints_obj_cmp(struct rhashtable_compare_arg *arg,
-				const void *obj)
-{
-	struct rhashtable *ht = arg->ht;
-	struct objagg_hints *objagg_hints =
-			container_of(ht, struct objagg_hints, node_ht);
-	const struct objagg_ops *ops = objagg_hints->ops;
-	const char *ptr = obj;
-
-	ptr += ht->p.key_offset;
-	return ops->hints_obj_cmp ? ops->hints_obj_cmp(ptr, arg->key) :
-				    memcmp(ptr, arg->key, ht->p.key_len);
-}
-
 /**
  * objagg_hints_get - obtains hints instance
  * @objagg:		objagg instance
@@ -958,7 +947,6 @@ struct objagg_hints *objagg_hints_get(struct objagg *objagg,
 				offsetof(struct objagg_hints_node, obj);
 	objagg_hints->ht_params.head_offset =
 				offsetof(struct objagg_hints_node, ht_node);
-	objagg_hints->ht_params.obj_cmpfn = objagg_hints_obj_cmp;
 
 	err = rhashtable_init(&objagg_hints->node_ht, &objagg_hints->ht_params);
 	if (err)
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2f5c1b2456ef..01a685963a99 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3717,7 +3717,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	BUG_ON(hugetlb_max_hstate >= HUGE_MAX_HSTATE);
 	BUG_ON(order == 0);
 	h = &hstates[hugetlb_max_hstate++];
-	mutex_init(&h->resize_lock);
+	__mutex_init(&h->resize_lock, "resize mutex", &h->resize_key);
 	h->order = order;
 	h->mask = ~(huge_page_size(h) - 1);
 	for (i = 0; i < MAX_NUMNODES; ++i)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 818753635e42..f089de8564ca 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2921,8 +2921,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
  * @pol:  pointer to mempolicy to be formatted
  *
  * Convert @pol into a string.  If @buffer is too short, truncate the string.
- * Recommend a @maxlen of at least 32 for the longest mode, "interleave", the
- * longest flag, "relative", and to display at least a few node ids.
+ * Recommend a @maxlen of at least 51 for the longest mode, "weighted
+ * interleave", plus the longest flag flags, "relative|balancing", and to
+ * display at least a few node ids.
  */
 void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 {
@@ -2931,7 +2932,10 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	unsigned short mode = MPOL_DEFAULT;
 	unsigned short flags = 0;
 
-	if (pol && pol != &default_policy && !(pol->flags & MPOL_F_MORON)) {
+	if (pol &&
+	    pol != &default_policy &&
+	    !(pol >= &preferred_node_policy[0] &&
+	      pol <= &preferred_node_policy[ARRAY_SIZE(preferred_node_policy) - 1])) {
 		mode = pol->mode;
 		flags = pol->flags;
 	}
@@ -2958,12 +2962,18 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 		p += snprintf(p, buffer + maxlen - p, "=");
 
 		/*
-		 * Currently, the only defined flags are mutually exclusive
+		 * Static and relative are mutually exclusive.
 		 */
 		if (flags & MPOL_F_STATIC_NODES)
 			p += snprintf(p, buffer + maxlen - p, "static");
 		else if (flags & MPOL_F_RELATIVE_NODES)
 			p += snprintf(p, buffer + maxlen - p, "relative");
+
+		if (flags & MPOL_F_NUMA_BALANCING) {
+			if (!is_power_of_2(flags & MPOL_MODE_FLAGS))
+				p += snprintf(p, buffer + maxlen - p, "|");
+			p += snprintf(p, buffer + maxlen - p, "balancing");
+		}
 	}
 
 	if (!nodes_empty(nodes))
diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
index 1854850b4b89..368b840e7508 100644
--- a/mm/mmap_lock.c
+++ b/mm/mmap_lock.c
@@ -19,14 +19,7 @@ EXPORT_TRACEPOINT_SYMBOL(mmap_lock_released);
 
 #ifdef CONFIG_MEMCG
 
-/*
- * Our various events all share the same buffer (because we don't want or need
- * to allocate a set of buffers *per event type*), so we need to protect against
- * concurrent _reg() and _unreg() calls, and count how many _reg() calls have
- * been made.
- */
-static DEFINE_MUTEX(reg_lock);
-static int reg_refcount; /* Protected by reg_lock. */
+static atomic_t reg_refcount;
 
 /*
  * Size of the buffer for memcg path names. Ignoring stack trace support,
@@ -34,136 +27,22 @@ static int reg_refcount; /* Protected by reg_lock. */
  */
 #define MEMCG_PATH_BUF_SIZE MAX_FILTER_STR_VAL
 
-/*
- * How many contexts our trace events might be called in: normal, softirq, irq,
- * and NMI.
- */
-#define CONTEXT_COUNT 4
-
-struct memcg_path {
-	local_lock_t lock;
-	char __rcu *buf;
-	local_t buf_idx;
-};
-static DEFINE_PER_CPU(struct memcg_path, memcg_paths) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-	.buf_idx = LOCAL_INIT(0),
-};
-
-static char **tmp_bufs;
-
-/* Called with reg_lock held. */
-static void free_memcg_path_bufs(void)
-{
-	struct memcg_path *memcg_path;
-	int cpu;
-	char **old = tmp_bufs;
-
-	for_each_possible_cpu(cpu) {
-		memcg_path = per_cpu_ptr(&memcg_paths, cpu);
-		*(old++) = rcu_dereference_protected(memcg_path->buf,
-			lockdep_is_held(&reg_lock));
-		rcu_assign_pointer(memcg_path->buf, NULL);
-	}
-
-	/* Wait for inflight memcg_path_buf users to finish. */
-	synchronize_rcu();
-
-	old = tmp_bufs;
-	for_each_possible_cpu(cpu) {
-		kfree(*(old++));
-	}
-
-	kfree(tmp_bufs);
-	tmp_bufs = NULL;
-}
-
 int trace_mmap_lock_reg(void)
 {
-	int cpu;
-	char *new;
-
-	mutex_lock(&reg_lock);
-
-	/* If the refcount is going 0->1, proceed with allocating buffers. */
-	if (reg_refcount++)
-		goto out;
-
-	tmp_bufs = kmalloc_array(num_possible_cpus(), sizeof(*tmp_bufs),
-				 GFP_KERNEL);
-	if (tmp_bufs == NULL)
-		goto out_fail;
-
-	for_each_possible_cpu(cpu) {
-		new = kmalloc(MEMCG_PATH_BUF_SIZE * CONTEXT_COUNT, GFP_KERNEL);
-		if (new == NULL)
-			goto out_fail_free;
-		rcu_assign_pointer(per_cpu_ptr(&memcg_paths, cpu)->buf, new);
-		/* Don't need to wait for inflights, they'd have gotten NULL. */
-	}
-
-out:
-	mutex_unlock(&reg_lock);
+	atomic_inc(&reg_refcount);
 	return 0;
-
-out_fail_free:
-	free_memcg_path_bufs();
-out_fail:
-	/* Since we failed, undo the earlier ref increment. */
-	--reg_refcount;
-
-	mutex_unlock(&reg_lock);
-	return -ENOMEM;
 }
 
 void trace_mmap_lock_unreg(void)
 {
-	mutex_lock(&reg_lock);
-
-	/* If the refcount is going 1->0, proceed with freeing buffers. */
-	if (--reg_refcount)
-		goto out;
-
-	free_memcg_path_bufs();
-
-out:
-	mutex_unlock(&reg_lock);
-}
-
-static inline char *get_memcg_path_buf(void)
-{
-	struct memcg_path *memcg_path = this_cpu_ptr(&memcg_paths);
-	char *buf;
-	int idx;
-
-	rcu_read_lock();
-	buf = rcu_dereference(memcg_path->buf);
-	if (buf == NULL) {
-		rcu_read_unlock();
-		return NULL;
-	}
-	idx = local_add_return(MEMCG_PATH_BUF_SIZE, &memcg_path->buf_idx) -
-	      MEMCG_PATH_BUF_SIZE;
-	return &buf[idx];
+	atomic_dec(&reg_refcount);
 }
 
-static inline void put_memcg_path_buf(void)
-{
-	local_sub(MEMCG_PATH_BUF_SIZE, &this_cpu_ptr(&memcg_paths)->buf_idx);
-	rcu_read_unlock();
-}
-
-#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                                   \
-	do {                                                                   \
-		const char *memcg_path;                                        \
-		local_lock(&memcg_paths.lock);                                 \
-		memcg_path = get_mm_memcg_path(mm);                            \
-		trace_mmap_lock_##type(mm,                                     \
-				       memcg_path != NULL ? memcg_path : "",   \
-				       ##__VA_ARGS__);                         \
-		if (likely(memcg_path != NULL))                                \
-			put_memcg_path_buf();                                  \
-		local_unlock(&memcg_paths.lock);                               \
+#define TRACE_MMAP_LOCK_EVENT(type, mm, ...)                    \
+	do {                                                    \
+		char buf[MEMCG_PATH_BUF_SIZE];                  \
+		get_mm_memcg_path(mm, buf, sizeof(buf));        \
+		trace_mmap_lock_##type(mm, buf, ##__VA_ARGS__); \
 	} while (0)
 
 #else /* !CONFIG_MEMCG */
@@ -185,37 +64,23 @@ void trace_mmap_lock_unreg(void)
 #ifdef CONFIG_TRACING
 #ifdef CONFIG_MEMCG
 /*
- * Write the given mm_struct's memcg path to a percpu buffer, and return a
- * pointer to it. If the path cannot be determined, or no buffer was available
- * (because the trace event is being unregistered), NULL is returned.
- *
- * Note: buffers are allocated per-cpu to avoid locking, so preemption must be
- * disabled by the caller before calling us, and re-enabled only after the
- * caller is done with the pointer.
- *
- * The caller must call put_memcg_path_buf() once the buffer is no longer
- * needed. This must be done while preemption is still disabled.
+ * Write the given mm_struct's memcg path to a buffer. If the path cannot be
+ * determined or the trace event is being unregistered, empty string is written.
  */
-static const char *get_mm_memcg_path(struct mm_struct *mm)
+static void get_mm_memcg_path(struct mm_struct *mm, char *buf, size_t buflen)
 {
-	char *buf = NULL;
-	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
+	struct mem_cgroup *memcg;
 
+	buf[0] = '\0';
+	/* No need to get path if no trace event is registered. */
+	if (!atomic_read(&reg_refcount))
+		return;
+	memcg = get_mem_cgroup_from_mm(mm);
 	if (memcg == NULL)
-		goto out;
-	if (unlikely(memcg->css.cgroup == NULL))
-		goto out_put;
-
-	buf = get_memcg_path_buf();
-	if (buf == NULL)
-		goto out_put;
-
-	cgroup_path(memcg->css.cgroup, buf, MEMCG_PATH_BUF_SIZE);
-
-out_put:
+		return;
+	if (memcg->css.cgroup)
+		cgroup_path(memcg->css.cgroup, buf, buflen);
 	css_put(&memcg->css);
-out:
-	return buf;
 }
 
 #endif /* CONFIG_MEMCG */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 43a21a90619d..4d5dd82f2614 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7767,6 +7767,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	bt_cb(skb)->l2cap.psm = psm;
 
 	if (!chan->ops->recv(chan, skb)) {
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 9765f9f9bf7f..3cd2b648408d 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1890,16 +1890,14 @@ void br_multicast_del_port(struct net_bridge_port *port)
 {
 	struct net_bridge *br = port->br;
 	struct net_bridge_port_group *pg;
-	HLIST_HEAD(deleted_head);
 	struct hlist_node *n;
 
 	/* Take care of the remaining groups, only perm ones should be left */
 	spin_lock_bh(&br->multicast_lock);
 	hlist_for_each_entry_safe(pg, n, &port->mglist, mglist)
 		br_multicast_find_del_pg(br, pg);
-	hlist_move_list(&br->mcast_gc_list, &deleted_head);
 	spin_unlock_bh(&br->multicast_lock);
-	br_multicast_gc(&deleted_head);
+	flush_work(&br->mcast_gc_work);
 	br_multicast_port_ctx_deinit(&port->multicast_ctx);
 	free_percpu(port->mcast_stats);
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index a873c8fd51b6..a92a35c0f1e7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3507,13 +3507,20 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 	if (skb_is_gso(skb)) {
 		struct skb_shared_info *shinfo = skb_shinfo(skb);
 
-		/* Due to header grow, MSS needs to be downgraded. */
-		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
-			skb_decrease_gso_size(shinfo, len_diff);
-
 		/* Header must be checked, and gso_segs recomputed. */
 		shinfo->gso_type |= gso_type;
 		shinfo->gso_segs = 0;
+
+		/* Due to header growth, MSS needs to be downgraded.
+		 * There is a BUG_ON() when segmenting the frag_list with
+		 * head_frag true, so linearize the skb after downgrading
+		 * the MSS.
+		 */
+		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
+			skb_decrease_gso_size(shinfo, len_diff);
+			if (shinfo->frag_list)
+				return skb_linearize(skb);
+		}
 	}
 
 	return 0;
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
index 9599afd0862d..010b39f4a189 100644
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -138,9 +138,9 @@ static void linkwatch_schedule_work(int urgent)
 	 * override the existing timer.
 	 */
 	if (test_bit(LW_URGENT, &linkwatch_flags))
-		mod_delayed_work(system_wq, &linkwatch_work, 0);
+		mod_delayed_work(system_unbound_wq, &linkwatch_work, 0);
 	else
-		schedule_delayed_work(&linkwatch_work, delay);
+		queue_delayed_work(system_unbound_wq, &linkwatch_work, delay);
 }
 
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d25632fbfa89..eca7f6f4a52f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2617,17 +2617,23 @@ static int do_set_proto_down(struct net_device *dev,
 static int do_setlink(const struct sk_buff *skb,
 		      struct net_device *dev, struct ifinfomsg *ifm,
 		      struct netlink_ext_ack *extack,
-		      struct nlattr **tb, char *ifname, int status)
+		      struct nlattr **tb, int status)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	char ifname[IFNAMSIZ];
 	int err;
 
 	err = validate_linkmsg(dev, tb, extack);
 	if (err < 0)
 		return err;
 
+	if (tb[IFLA_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
+	else
+		ifname[0] = '\0';
+
 	if (tb[IFLA_NET_NS_PID] || tb[IFLA_NET_NS_FD] || tb[IFLA_TARGET_NETNSID]) {
-		const char *pat = ifname && ifname[0] ? ifname : NULL;
+		const char *pat = ifname[0] ? ifname : NULL;
 		struct net *net;
 		int new_ifindex;
 
@@ -2974,21 +2980,16 @@ static int do_setlink(const struct sk_buff *skb,
 }
 
 static struct net_device *rtnl_dev_get(struct net *net,
-				       struct nlattr *ifname_attr,
-				       struct nlattr *altifname_attr,
-				       char *ifname)
-{
-	char buffer[ALTIFNAMSIZ];
-
-	if (!ifname) {
-		ifname = buffer;
-		if (ifname_attr)
-			nla_strscpy(ifname, ifname_attr, IFNAMSIZ);
-		else if (altifname_attr)
-			nla_strscpy(ifname, altifname_attr, ALTIFNAMSIZ);
-		else
-			return NULL;
-	}
+				       struct nlattr *tb[])
+{
+	char ifname[ALTIFNAMSIZ];
+
+	if (tb[IFLA_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
+	else if (tb[IFLA_ALT_IFNAME])
+		nla_strscpy(ifname, tb[IFLA_ALT_IFNAME], ALTIFNAMSIZ);
+	else
+		return NULL;
 
 	return __dev_get_by_name(net, ifname);
 }
@@ -3001,7 +3002,6 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct net_device *dev;
 	int err;
 	struct nlattr *tb[IFLA_MAX+1];
-	char ifname[IFNAMSIZ];
 
 	err = nlmsg_parse_deprecated(nlh, sizeof(*ifm), tb, IFLA_MAX,
 				     ifla_policy, extack);
@@ -3012,17 +3012,12 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		goto errout;
 
-	if (tb[IFLA_IFNAME])
-		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
-	else
-		ifname[0] = '\0';
-
 	err = -EINVAL;
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, NULL, tb[IFLA_ALT_IFNAME], ifname);
+		dev = rtnl_dev_get(net, tb);
 	else
 		goto errout;
 
@@ -3031,7 +3026,7 @@ static int rtnl_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout;
 	}
 
-	err = do_setlink(skb, dev, ifm, extack, tb, ifname, 0);
+	err = do_setlink(skb, dev, ifm, extack, tb, 0);
 errout:
 	return err;
 }
@@ -3120,8 +3115,7 @@ static int rtnl_dellink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, tb[IFLA_IFNAME],
-				   tb[IFLA_ALT_IFNAME], NULL);
+		dev = rtnl_dev_get(tgt_net, tb);
 	else if (tb[IFLA_GROUP])
 		err = rtnl_group_dellink(tgt_net, nla_get_u32(tb[IFLA_GROUP]));
 	else
@@ -3267,7 +3261,7 @@ static int rtnl_group_changelink(const struct sk_buff *skb,
 
 	for_each_netdev_safe(net, dev, aux) {
 		if (dev->group == group) {
-			err = do_setlink(skb, dev, ifm, extack, tb, NULL, 0);
+			err = do_setlink(skb, dev, ifm, extack, tb, 0);
 			if (err < 0)
 				return err;
 		}
@@ -3309,11 +3303,6 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	if (tb[IFLA_IFNAME])
-		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
-	else
-		ifname[0] = '\0';
-
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
@@ -3323,7 +3312,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, NULL, tb[IFLA_ALT_IFNAME], ifname);
+		dev = rtnl_dev_get(net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
@@ -3426,7 +3415,7 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 			status |= DO_SETLINK_NOTIFY;
 		}
 
-		return do_setlink(skb, dev, ifm, extack, tb, ifname, status);
+		return do_setlink(skb, dev, ifm, extack, tb, status);
 	}
 
 	if (!(nlh->nlmsg_flags & NLM_F_CREATE)) {
@@ -3463,7 +3452,9 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (!ops->alloc && !ops->setup)
 		return -EOPNOTSUPP;
 
-	if (!ifname[0]) {
+	if (tb[IFLA_IFNAME]) {
+		nla_strscpy(ifname, tb[IFLA_IFNAME], IFNAMSIZ);
+	} else {
 		snprintf(ifname, IFNAMSIZ, "%s%%d", ops->kind);
 		name_assign_type = NET_NAME_ENUM;
 	}
@@ -3635,8 +3626,7 @@ static int rtnl_getlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(tgt_net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(tgt_net, tb[IFLA_IFNAME],
-				   tb[IFLA_ALT_IFNAME], NULL);
+		dev = rtnl_dev_get(tgt_net, tb);
 	else
 		goto out;
 
@@ -3731,8 +3721,7 @@ static int rtnl_linkprop(int cmd, struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (ifm->ifi_index > 0)
 		dev = __dev_get_by_index(net, ifm->ifi_index);
 	else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME])
-		dev = rtnl_dev_get(net, tb[IFLA_IFNAME],
-				   tb[IFLA_ALT_IFNAME], NULL);
+		dev = rtnl_dev_get(net, tb);
 	else
 		return -EINVAL;
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index e9a9694c4fdc..4a9c2f4eceda 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -124,10 +124,8 @@ void xdp_unreg_mem_model(struct xdp_mem_info *mem)
 		return;
 
 	if (type == MEM_TYPE_PAGE_POOL) {
-		rcu_read_lock();
-		xa = rhashtable_lookup(mem_id_ht, &id, mem_id_rht_params);
+		xa = rhashtable_lookup_fast(mem_id_ht, &id, mem_id_rht_params);
 		page_pool_destroy(xa->page_pool);
-		rcu_read_unlock();
 	}
 }
 EXPORT_SYMBOL_GPL(xdp_unreg_mem_model);
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index ca0cd94eb22d..e578d065d904 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -237,8 +237,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 #else
 static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 {
-	kfree_skb(skb);
-
+	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 #endif
diff --git a/net/ipv4/netfilter/iptable_nat.c b/net/ipv4/netfilter/iptable_nat.c
index 45d7e072e6a5..226000a74086 100644
--- a/net/ipv4/netfilter/iptable_nat.c
+++ b/net/ipv4/netfilter/iptable_nat.c
@@ -152,25 +152,27 @@ static struct pernet_operations iptable_nat_net_ops = {
 
 static int __init iptable_nat_init(void)
 {
-	int ret = xt_register_template(&nf_nat_ipv4_table,
-				       iptable_nat_table_init);
+	int ret;
 
+	/* net->gen->ptr[iptable_nat_net_id] must be allocated
+	 * before calling iptable_nat_table_init().
+	 */
+	ret = register_pernet_subsys(&iptable_nat_net_ops);
 	if (ret < 0)
 		return ret;
 
-	ret = register_pernet_subsys(&iptable_nat_net_ops);
-	if (ret < 0) {
-		xt_unregister_template(&nf_nat_ipv4_table);
-		return ret;
-	}
+	ret = xt_register_template(&nf_nat_ipv4_table,
+				   iptable_nat_table_init);
+	if (ret < 0)
+		unregister_pernet_subsys(&iptable_nat_net_ops);
 
 	return ret;
 }
 
 static void __exit iptable_nat_exit(void)
 {
-	unregister_pernet_subsys(&iptable_nat_net_ops);
 	xt_unregister_template(&nf_nat_ipv4_table);
+	unregister_pernet_subsys(&iptable_nat_net_ops);
 }
 
 module_init(iptable_nat_init);
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index c140a36bd1e6..633eab6ff55d 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -675,9 +675,10 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 
 	p = nla_data(nla);
 	for (i = 0; i < nhg->num_nh; ++i) {
-		p->id = nhg->nh_entries[i].nh->id;
-		p->weight = nhg->nh_entries[i].weight - 1;
-		p += 1;
+		*p++ = (struct nexthop_grp) {
+			.id = nhg->nh_entries[i].nh->id,
+			.weight = nhg->nh_entries[i].weight - 1,
+		};
 	}
 
 	if (nhg->resilient && nla_put_nh_group_res(skb, nhg))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e7130a9f0e1a..60fc35defdf8 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1282,7 +1282,7 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
-			.flowi4_tos = RT_TOS(iph->tos),
+			.flowi4_tos = iph->tos & IPTOS_RT_MASK,
 			.flowi4_oif = rt->dst.dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c1602b36dee4..3c85ecab1445 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -592,9 +592,10 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
 		 */
 		mask |= EPOLLOUT | EPOLLWRNORM;
 	}
-	/* This barrier is coupled with smp_wmb() in tcp_reset() */
+	/* This barrier is coupled with smp_wmb() in tcp_done_with_error() */
 	smp_rmb();
-	if (sk->sk_err || !skb_queue_empty_lockless(&sk->sk_error_queue))
+	if (READ_ONCE(sk->sk_err) ||
+	    !skb_queue_empty_lockless(&sk->sk_error_queue))
 		mask |= EPOLLERR;
 
 	return mask;
@@ -2995,7 +2996,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	if (old_state == TCP_LISTEN) {
 		inet_csk_listen_stop(sk);
 	} else if (unlikely(tp->repair)) {
-		sk->sk_err = ECONNABORTED;
+		WRITE_ONCE(sk->sk_err, ECONNABORTED);
 	} else if (tcp_need_reset(old_state) ||
 		   (tp->snd_nxt != tp->write_seq &&
 		    (1 << old_state) & (TCPF_CLOSING | TCPF_LAST_ACK))) {
@@ -3003,9 +3004,9 @@ int tcp_disconnect(struct sock *sk, int flags)
 		 * states
 		 */
 		tcp_send_active_reset(sk, gfp_any());
-		sk->sk_err = ECONNRESET;
+		WRITE_ONCE(sk->sk_err, ECONNRESET);
 	} else if (old_state == TCP_SYN_SENT)
-		sk->sk_err = ECONNRESET;
+		WRITE_ONCE(sk->sk_err, ECONNRESET);
 
 	tcp_clear_xmit_timers(sk);
 	__skb_queue_purge(&sk->sk_receive_queue);
@@ -4513,7 +4514,7 @@ int tcp_abort(struct sock *sk, int err)
 	bh_lock_sock(sk);
 
 	if (!sock_flag(sk, SOCK_DEAD)) {
-		sk->sk_err = err;
+		WRITE_ONCE(sk->sk_err, err);
 		/* This barrier is coupled with smp_rmb() in tcp_poll() */
 		smp_wmb();
 		sk_error_report(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 48d45022deda..c51ad6b353ee 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3915,7 +3915,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	/* We passed data and got it acked, remove any soft error
 	 * log. Something worked...
 	 */
-	sk->sk_err_soft = 0;
+	WRITE_ONCE(sk->sk_err_soft, 0);
 	icsk->icsk_probes_out = 0;
 	tp->rcv_tstamp = tcp_jiffies32;
 	if (!prior_packets)
@@ -4348,9 +4348,26 @@ static inline bool tcp_sequence(const struct tcp_sock *tp, u32 seq, u32 end_seq)
 		!after(seq, tp->rcv_nxt + tcp_receive_window(tp));
 }
 
+
+void tcp_done_with_error(struct sock *sk, int err)
+{
+	/* This barrier is coupled with smp_rmb() in tcp_poll() */
+	WRITE_ONCE(sk->sk_err, err);
+	smp_wmb();
+
+	tcp_write_queue_purge(sk);
+	tcp_done(sk);
+
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk_error_report(sk);
+}
+EXPORT_SYMBOL(tcp_done_with_error);
+
 /* When we get a reset we do this. */
 void tcp_reset(struct sock *sk, struct sk_buff *skb)
 {
+	int err;
+
 	trace_tcp_receive_reset(sk);
 
 	/* mptcp can't tell us to ignore reset pkts,
@@ -4362,24 +4379,17 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb)
 	/* We want the right error as BSD sees it (and indeed as we do). */
 	switch (sk->sk_state) {
 	case TCP_SYN_SENT:
-		sk->sk_err = ECONNREFUSED;
+		err = ECONNREFUSED;
 		break;
 	case TCP_CLOSE_WAIT:
-		sk->sk_err = EPIPE;
+		err = EPIPE;
 		break;
 	case TCP_CLOSE:
 		return;
 	default:
-		sk->sk_err = ECONNRESET;
+		err = ECONNRESET;
 	}
-	/* This barrier is coupled with smp_rmb() in tcp_poll() */
-	smp_wmb();
-
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
-
-	if (!sock_flag(sk, SOCK_DEAD))
-		sk_error_report(sk);
+	tcp_done_with_error(sk, err);
 }
 
 /*
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index e9b1dcf2d463..44a9fa957301 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -361,7 +361,7 @@ void tcp_v4_mtu_reduced(struct sock *sk)
 	 * for the case, if this connection will not able to recover.
 	 */
 	if (mtu < dst_mtu(dst) && ip_dont_fragment(sk, dst))
-		sk->sk_err_soft = EMSGSIZE;
+		WRITE_ONCE(sk->sk_err_soft, EMSGSIZE);
 
 	mtu = dst_mtu(dst);
 
@@ -592,15 +592,10 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 
 		ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
 
-		if (!sock_owned_by_user(sk)) {
-			sk->sk_err = err;
-
-			sk_error_report(sk);
-
-			tcp_done(sk);
-		} else {
-			sk->sk_err_soft = err;
-		}
+		if (!sock_owned_by_user(sk))
+			tcp_done_with_error(sk, err);
+		else
+			WRITE_ONCE(sk->sk_err_soft, err);
 		goto out;
 	}
 
@@ -622,10 +617,10 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 
 	inet = inet_sk(sk);
 	if (!sock_owned_by_user(sk) && inet->recverr) {
-		sk->sk_err = err;
+		WRITE_ONCE(sk->sk_err, err);
 		sk_error_report(sk);
 	} else	{ /* Only an error on timeout */
-		sk->sk_err_soft = err;
+		WRITE_ONCE(sk->sk_err_soft, err);
 	}
 
 out:
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0fb84e57a2d4..2c9670c83202 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3724,7 +3724,7 @@ static void tcp_connect_init(struct sock *sk)
 	tp->rx_opt.rcv_wscale = rcv_wscale;
 	tp->rcv_ssthresh = tp->rcv_wnd;
 
-	sk->sk_err = 0;
+	WRITE_ONCE(sk->sk_err, 0);
 	sock_reset_flag(sk, SOCK_DONE);
 	tp->snd_wnd = 0;
 	tcp_init_wl(tp, 0);
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index 11569900b729..1a3a84992b9b 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -67,11 +67,7 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
 
 static void tcp_write_err(struct sock *sk)
 {
-	sk->sk_err = sk->sk_err_soft ? : ETIMEDOUT;
-	sk_error_report(sk);
-
-	tcp_write_queue_purge(sk);
-	tcp_done(sk);
+	tcp_done_with_error(sk, READ_ONCE(sk->sk_err_soft) ? : ETIMEDOUT);
 	__NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPABORTONTIMEOUT);
 }
 
@@ -110,7 +106,7 @@ static int tcp_out_of_resources(struct sock *sk, bool do_reset)
 		shift++;
 
 	/* If some dubious ICMP arrived, penalize even more. */
-	if (sk->sk_err_soft)
+	if (READ_ONCE(sk->sk_err_soft))
 		shift++;
 
 	if (tcp_check_oom(sk, shift)) {
@@ -146,7 +142,7 @@ static int tcp_orphan_retries(struct sock *sk, bool alive)
 	int retries = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_orphan_retries); /* May be zero. */
 
 	/* We know from an ICMP that something is wrong. */
-	if (sk->sk_err_soft && !alive)
+	if (READ_ONCE(sk->sk_err_soft) && !alive)
 		retries = 0;
 
 	/* However, if socket sent something recently, select some safe
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba22470b7476..932a10f64adc 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1831,7 +1831,8 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 							    master, &dst,
 							    scores, hiscore_idx);
 
-			if (scores[hiscore_idx].ifa)
+			if (scores[hiscore_idx].ifa &&
+			    scores[hiscore_idx].scopedist >= 0)
 				goto out;
 		}
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 26d476494676..a4b8c70ae527 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -255,8 +255,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 #else
 static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 {
-	kfree_skb(skb);
-
+	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 #endif
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 856edbe81e11..d56e80741c5b 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -226,6 +226,7 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 		return NULL;
 	memset(ndopts, 0, sizeof(*ndopts));
 	while (opt_len) {
+		bool unknown = false;
 		int l;
 		if (opt_len < sizeof(struct nd_opt_hdr))
 			return NULL;
@@ -261,22 +262,23 @@ struct ndisc_options *ndisc_parse_options(const struct net_device *dev,
 			break;
 #endif
 		default:
-			if (ndisc_is_useropt(dev, nd_opt)) {
-				ndopts->nd_useropts_end = nd_opt;
-				if (!ndopts->nd_useropts)
-					ndopts->nd_useropts = nd_opt;
-			} else {
-				/*
-				 * Unknown options must be silently ignored,
-				 * to accommodate future extension to the
-				 * protocol.
-				 */
-				ND_PRINTK(2, notice,
-					  "%s: ignored unsupported option; type=%d, len=%d\n",
-					  __func__,
-					  nd_opt->nd_opt_type,
-					  nd_opt->nd_opt_len);
-			}
+			unknown = true;
+		}
+		if (ndisc_is_useropt(dev, nd_opt)) {
+			ndopts->nd_useropts_end = nd_opt;
+			if (!ndopts->nd_useropts)
+				ndopts->nd_useropts = nd_opt;
+		} else if (unknown) {
+			/*
+			 * Unknown options must be silently ignored,
+			 * to accommodate future extension to the
+			 * protocol.
+			 */
+			ND_PRINTK(2, notice,
+				  "%s: ignored unsupported option; type=%d, len=%d\n",
+				  __func__,
+				  nd_opt->nd_opt_type,
+				  nd_opt->nd_opt_len);
 		}
 next_opt:
 		opt_len -= l;
diff --git a/net/ipv6/netfilter/ip6table_nat.c b/net/ipv6/netfilter/ip6table_nat.c
index 921c1723a01e..229a81cf1a72 100644
--- a/net/ipv6/netfilter/ip6table_nat.c
+++ b/net/ipv6/netfilter/ip6table_nat.c
@@ -154,23 +154,27 @@ static struct pernet_operations ip6table_nat_net_ops = {
 
 static int __init ip6table_nat_init(void)
 {
-	int ret = xt_register_template(&nf_nat_ipv6_table,
-				       ip6table_nat_table_init);
+	int ret;
 
+	/* net->gen->ptr[ip6table_nat_net_id] must be allocated
+	 * before calling ip6t_nat_register_lookups().
+	 */
+	ret = register_pernet_subsys(&ip6table_nat_net_ops);
 	if (ret < 0)
 		return ret;
 
-	ret = register_pernet_subsys(&ip6table_nat_net_ops);
+	ret = xt_register_template(&nf_nat_ipv6_table,
+				   ip6table_nat_table_init);
 	if (ret)
-		xt_unregister_template(&nf_nat_ipv6_table);
+		unregister_pernet_subsys(&ip6table_nat_net_ops);
 
 	return ret;
 }
 
 static void __exit ip6table_nat_exit(void)
 {
-	unregister_pernet_subsys(&ip6table_nat_net_ops);
 	xt_unregister_template(&nf_nat_ipv6_table);
+	unregister_pernet_subsys(&ip6table_nat_net_ops);
 }
 
 module_init(ip6table_nat_init);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 78c7b0fb6ffe..fedbce7ed853 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -485,13 +485,10 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 
 		ipv6_icmp_error(sk, skb, err, th->dest, ntohl(info), (u8 *)th);
 
-		if (!sock_owned_by_user(sk)) {
-			sk->sk_err = err;
-			sk_error_report(sk);		/* Wake people up to see the error (see connect in sock.c) */
-
-			tcp_done(sk);
-		} else
-			sk->sk_err_soft = err;
+		if (!sock_owned_by_user(sk))
+			tcp_done_with_error(sk, err);
+		else
+			WRITE_ONCE(sk->sk_err_soft, err);
 		goto out;
 	case TCP_LISTEN:
 		break;
@@ -505,11 +502,11 @@ static int tcp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	}
 
 	if (!sock_owned_by_user(sk) && np->recverr) {
-		sk->sk_err = err;
+		WRITE_ONCE(sk->sk_err, err);
 		sk_error_report(sk);
-	} else
-		sk->sk_err_soft = err;
-
+	} else {
+		WRITE_ONCE(sk->sk_err_soft, err);
+	}
 out:
 	bh_unlock_sock(sk);
 	sock_put(sk);
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 18316ee3c692..e6cb3e1cbbf9 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -336,8 +336,8 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
 	struct iucv_sock *iucv = iucv_sk(sk);
 	struct iucv_path *path = iucv->path;
 
-	if (iucv->path) {
-		iucv->path = NULL;
+	/* Whoever resets the path pointer, must sever and free it. */
+	if (xchg(&iucv->path, NULL)) {
 		if (with_user_data) {
 			low_nmcpy(user_data, iucv->src_name);
 			high_nmcpy(user_data, iucv->dst_name);
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index a2b13e213e06..acd5b67858dd 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -88,6 +88,11 @@
 /* Default trace flags */
 #define L2TP_DEFAULT_DEBUG_FLAGS	0
 
+#define L2TP_DEPTH_NESTING		2
+#if L2TP_DEPTH_NESTING == SINGLE_DEPTH_NESTING
+#error "L2TP requires its own lockdep subclass"
+#endif
+
 /* Private data stored for received packets in the skb.
  */
 struct l2tp_skb_cb {
@@ -1041,7 +1046,13 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	IPCB(skb)->flags &= ~(IPSKB_XFRM_TUNNEL_SIZE | IPSKB_XFRM_TRANSFORMED | IPSKB_REROUTED);
 	nf_reset_ct(skb);
 
-	bh_lock_sock_nested(sk);
+	/* L2TP uses its own lockdep subclass to avoid lockdep splats caused by
+	 * nested socket calls on the same lockdep socket class. This can
+	 * happen when data from a user socket is routed over l2tp, which uses
+	 * another userspace socket.
+	 */
+	spin_lock_nested(&sk->sk_lock.slock, L2TP_DEPTH_NESTING);
+
 	if (sock_owned_by_user(sk)) {
 		kfree_skb(skb);
 		ret = NET_XMIT_DROP;
@@ -1093,7 +1104,7 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
 	ret = l2tp_xmit_queue(tunnel, skb, &inet->cork.fl);
 
 out_unlock:
-	bh_unlock_sock(sk);
+	spin_unlock(&sk->sk_lock.slock);
 
 	return ret;
 }
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f277ce839ddb..f652982a106b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2339,6 +2339,17 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 	if (!sband)
 		return -EINVAL;
 
+	if (params->basic_rates) {
+		if (!ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
+					      wiphy->bands[sband->band],
+					      params->basic_rates,
+					      params->basic_rates_len,
+					      &sdata->vif.bss_conf.basic_rates))
+			return -EINVAL;
+		changed |= BSS_CHANGED_BASIC_RATES;
+		ieee80211_check_rate_mask(sdata);
+	}
+
 	if (params->use_cts_prot >= 0) {
 		sdata->vif.bss_conf.use_cts_prot = params->use_cts_prot;
 		changed |= BSS_CHANGED_ERP_CTS_PROT;
@@ -2362,16 +2373,6 @@ static int ieee80211_change_bss(struct wiphy *wiphy,
 		changed |= BSS_CHANGED_ERP_SLOT;
 	}
 
-	if (params->basic_rates) {
-		ieee80211_parse_bitrates(&sdata->vif.bss_conf.chandef,
-					 wiphy->bands[sband->band],
-					 params->basic_rates,
-					 params->basic_rates_len,
-					 &sdata->vif.bss_conf.basic_rates);
-		changed |= BSS_CHANGED_BASIC_RATES;
-		ieee80211_check_rate_mask(sdata);
-	}
-
 	if (params->ap_isolate >= 0) {
 		if (params->ap_isolate)
 			sdata->flags |= IEEE80211_SDATA_DONT_BRIDGE_PACKETS;
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index 8d1c67b93591..c2fadfcfd6d6 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -19,7 +19,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
 	SNMP_MIB_ITEM("MPTCPRetrans", MPTCP_MIB_RETRANSSEGS),
 	SNMP_MIB_ITEM("MPJoinNoTokenFound", MPTCP_MIB_JOINNOTOKEN),
 	SNMP_MIB_ITEM("MPJoinSynRx", MPTCP_MIB_JOINSYNRX),
+	SNMP_MIB_ITEM("MPJoinSynBackupRx", MPTCP_MIB_JOINSYNBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckRx", MPTCP_MIB_JOINSYNACKRX),
+	SNMP_MIB_ITEM("MPJoinSynAckBackupRx", MPTCP_MIB_JOINSYNACKBACKUPRX),
 	SNMP_MIB_ITEM("MPJoinSynAckHMacFailure", MPTCP_MIB_JOINSYNACKMAC),
 	SNMP_MIB_ITEM("MPJoinAckRx", MPTCP_MIB_JOINACKRX),
 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
index 2966fcb6548b..90025acdcf72 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -12,7 +12,9 @@ enum linux_mptcp_mib_field {
 	MPTCP_MIB_RETRANSSEGS,		/* Segments retransmitted at the MPTCP-level */
 	MPTCP_MIB_JOINNOTOKEN,		/* Received MP_JOIN but the token was not found */
 	MPTCP_MIB_JOINSYNRX,		/* Received a SYN + MP_JOIN */
+	MPTCP_MIB_JOINSYNBACKUPRX,	/* Received a SYN + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKRX,		/* Received a SYN/ACK + MP_JOIN */
+	MPTCP_MIB_JOINSYNACKBACKUPRX,	/* Received a SYN/ACK + MP_JOIN + backup flag */
 	MPTCP_MIB_JOINSYNACKMAC,	/* HMAC was wrong on SYN/ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKRX,		/* Received an ACK + MP_JOIN */
 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 3b4ce8a06f99..2baed0c01922 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -877,7 +877,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
@@ -923,7 +923,8 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 	}
 
 	if (((mp_opt->suboptions & OPTION_MPTCP_DSS) && mp_opt->use_ack) ||
-	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) && !mp_opt->echo)) {
+	    ((mp_opt->suboptions & OPTION_MPTCP_ADD_ADDR) &&
+	     (!mp_opt->echo || subflow->mp_join))) {
 		/* subflows are fully established as soon as we get any
 		 * additional ack, including ADD_ADDR.
 		 */
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d9790d6fbce9..55e8407bcc25 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -341,6 +341,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_get_local_id(msk, skc);
 }
 
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
+{
+	struct mptcp_addr_info skc_local;
+
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
+
+	return mptcp_pm_nl_is_backup(msk, &skc_local);
+}
+
 void mptcp_pm_subflow_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 7b312aa03e6b..1ae164711783 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -97,8 +97,7 @@ static bool address_zero(const struct mptcp_addr_info *addr)
 	return addresses_equal(addr, &zero, true);
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->family = skc->skc_family;
 	addr->port = htons(skc->skc_num);
@@ -133,7 +132,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (addresses_equal(&cur, saddr, saddr->port))
 			return true;
 	}
@@ -286,7 +285,7 @@ bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)sk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -693,13 +692,12 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
 		struct sock *sk = (struct sock *)msk;
 		struct mptcp_addr_info local;
 
-		local_address((struct sock_common *)ssk, &local);
+		mptcp_local_address((struct sock_common *)ssk, &local);
 		if (!addresses_equal(&local, addr, addr->port))
 			continue;
 
 		if (subflow->backup != bkup)
 			msk->last_snd = NULL;
-		subflow->backup = bkup;
 		subflow->send_mp_prio = 1;
 		subflow->request_bkup = bkup;
 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
@@ -977,8 +975,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
@@ -1016,6 +1014,26 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	return ret;
 }
 
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc)
+{
+	struct mptcp_pm_addr_entry *entry;
+	struct pm_nl_pernet *pernet;
+	bool backup = false;
+
+	pernet = net_generic(sock_net((struct sock *)msk), pm_nl_pernet_id);
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
+		if (addresses_equal(&entry->addr, skc, entry->addr.port)) {
+			backup = !!(entry->flags & MPTCP_PM_ADDR_FLAG_BACKUP);
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return backup;
+}
+
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk)
 {
 	struct mptcp_pm_data *pm = &msk->pm;
@@ -1323,6 +1341,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, &list);
 		spin_unlock_bh(&msk->pm.lock);
 	}
@@ -1388,7 +1407,7 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
 		if (list_empty(&msk->conn_list))
 			goto next;
 
-		local_address((struct sock_common *)msk, &msk_local);
+		mptcp_local_address((struct sock_common *)msk, &msk_local);
 		if (!addresses_equal(&msk_local, addr, addr->port))
 			goto next;
 
@@ -1462,19 +1481,20 @@ static void mptcp_pm_remove_addrs_and_subflows(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *entry;
 
 	list_for_each_entry(entry, rm_list, list) {
-		if (lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
-		    alist.nr < MPTCP_RM_IDS_MAX &&
-		    slist.nr < MPTCP_RM_IDS_MAX) {
+		if (alist.nr < MPTCP_RM_IDS_MAX &&
+		    slist.nr < MPTCP_RM_IDS_MAX &&
+		    lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
 			alist.ids[alist.nr++] = entry->addr.id;
 			slist.ids[slist.nr++] = entry->addr.id;
-		} else if (remove_anno_list_by_saddr(msk, &entry->addr) &&
-			 alist.nr < MPTCP_RM_IDS_MAX) {
+		} else if (alist.nr < MPTCP_RM_IDS_MAX &&
+			   remove_anno_list_by_saddr(msk, &entry->addr)) {
 			alist.ids[alist.nr++] = entry->addr.id;
 		}
 	}
 
 	if (alist.nr) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= alist.nr;
 		mptcp_pm_remove_addr(msk, &alist);
 		spin_unlock_bh(&msk->pm.lock);
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 081c8d00472d..9273316cdbde 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -288,8 +288,10 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, struct sock *ssk,
 	if (!sk_rmem_schedule(sk, skb, skb->truesize)) {
 		int amount = sk_mem_pages(skb->truesize) << SK_MEM_QUANTUM_SHIFT;
 
-		if (ssk->sk_forward_alloc < amount)
+		if (ssk->sk_forward_alloc < amount) {
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
 			goto drop;
+		}
 
 		ssk->sk_forward_alloc -= amount;
 		sk->sk_forward_alloc += amount;
@@ -774,10 +776,8 @@ void mptcp_data_ready(struct sock *sk, struct sock *ssk)
 		sk_rbuf = ssk_rbuf;
 
 	/* over limit? can't append more skbs to msk, Also, no need to wake-up*/
-	if (__mptcp_rmem(sk) > sk_rbuf) {
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
+	if (__mptcp_rmem(sk) > sk_rbuf)
 		return;
-	}
 
 	/* Wake-up the reader only for in-sequence data */
 	mptcp_data_lock(sk);
@@ -1514,13 +1514,15 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 		send_info[i].ratio = -1;
 	}
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		trace_mptcp_subflow_get_send(subflow);
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
 		tout = max(tout, mptcp_timeout_from_subflow(subflow));
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		if (!sk_stream_memory_free(subflow->tcp_sock) || !tcp_sk(ssk)->snd_wnd)
 			continue;
 
@@ -1530,9 +1532,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 
 		ratio = div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
 				pace);
-		if (ratio < send_info[subflow->backup].ratio) {
-			send_info[subflow->backup].ssk = ssk;
-			send_info[subflow->backup].ratio = ratio;
+		if (ratio < send_info[backup].ratio) {
+			send_info[backup].ssk = ssk;
+			send_info[backup].ratio = ratio;
 		}
 	}
 	__mptcp_set_timeout(sk, tout);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b4ccae4f6849..234cf918db97 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -370,6 +370,7 @@ struct mptcp_subflow_request_sock {
 	u16	mp_capable : 1,
 		mp_join : 1,
 		backup : 1,
+		request_bkup : 1,
 		csum_reqd : 1,
 		allow_join_id0 : 1;
 	u8	local_id;
@@ -582,6 +583,7 @@ void mptcp_subflow_send_ack(struct sock *ssk);
 void mptcp_subflow_reset(struct sock *ssk);
 void mptcp_sock_graft(struct sock *sk, struct socket *parent);
 struct socket *__mptcp_nmpc_socket(const struct mptcp_sock *msk);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
@@ -819,6 +821,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, struct sk_buff *skb,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     struct mptcp_rm_list *rm_list);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
@@ -826,6 +829,7 @@ void mptcp_pm_nl_work(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk,
 				     const struct mptcp_rm_list *rm_list);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 unsigned int mptcp_pm_get_add_addr_signal_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_add_addr_accept_max(struct mptcp_sock *msk);
 unsigned int mptcp_pm_get_subflows_max(struct mptcp_sock *msk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index ff7239fe3d2c..2f94387f2ade 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -97,6 +97,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req)
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	return msk;
 }
@@ -163,6 +164,9 @@ static int subflow_check_req(struct request_sock *req,
 			return 0;
 	} else if (opt_mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (opt_mp_capable && listener->request_mptcp) {
@@ -462,6 +466,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
 
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
+
 		if (subflow_use_different_dport(mptcp_sk(parent), sk)) {
 			pr_debug("synack inet_dport=%d %d",
 				 ntohs(inet_sk(sk)->inet_dport),
@@ -1099,14 +1106,22 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	bool fin = TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN;
-	u32 incr;
+	struct tcp_sock *tp = tcp_sk(ssk);
+	u32 offset, incr, avail_len;
+
+	offset = tp->copied_seq - TCP_SKB_CB(skb)->seq;
+	if (WARN_ON_ONCE(offset > skb->len))
+		goto out;
 
-	incr = limit >= skb->len ? skb->len + fin : limit;
+	avail_len = skb->len - offset;
+	incr = limit >= avail_len ? avail_len + fin : limit;
 
-	pr_debug("discarding=%d len=%d seq=%d", incr, skb->len,
-		 subflow->map_subflow_seq);
+	pr_debug("discarding=%d len=%d offset=%d seq=%d", incr, skb->len,
+		 offset, subflow->map_subflow_seq);
 	MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DUPDATA);
 	tcp_sk(ssk)->copied_seq += incr;
+
+out:
 	if (!before(tcp_sk(ssk)->copied_seq, TCP_SKB_CB(skb)->end_seq))
 		sk_eat_skb(ssk, skb);
 	if (mptcp_subflow_get_map_offset(subflow) >= subflow->map_data_len)
@@ -1758,6 +1773,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
 		new_ctx->mp_join = 1;
 		new_ctx->fully_established = 1;
 		new_ctx->backup = subflow_req->backup;
+		new_ctx->request_bkup = subflow_req->request_bkup;
 		new_ctx->local_id = subflow_req->local_id;
 		new_ctx->remote_id = subflow_req->remote_id;
 		new_ctx->token = subflow_req->token;
diff --git a/net/netfilter/ipset/ip_set_list_set.c b/net/netfilter/ipset/ip_set_list_set.c
index e839c356bcb5..902ff2f3bc72 100644
--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -547,6 +547,9 @@ list_set_cancel_gc(struct ip_set *set)
 
 	if (SET_WITH_TIMEOUT(set))
 		del_timer_sync(&map->gc);
+
+	/* Flush list to drop references to other ipsets */
+	list_set_flush(set);
 }
 
 static const struct ip_set_type_variant set_variant = {
diff --git a/net/netfilter/ipvs/ip_vs_proto_sctp.c b/net/netfilter/ipvs/ip_vs_proto_sctp.c
index 1e689c714127..83e452916403 100644
--- a/net/netfilter/ipvs/ip_vs_proto_sctp.c
+++ b/net/netfilter/ipvs/ip_vs_proto_sctp.c
@@ -126,7 +126,7 @@ sctp_snat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	if (sctph->source != cp->vport || payload_csum ||
 	    skb->ip_summed == CHECKSUM_PARTIAL) {
 		sctph->source = cp->vport;
-		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+		if (!skb_is_gso(skb))
 			sctp_nat_csum(skb, sctph, sctphoff);
 	} else {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -175,7 +175,7 @@ sctp_dnat_handler(struct sk_buff *skb, struct ip_vs_protocol *pp,
 	    (skb->ip_summed == CHECKSUM_PARTIAL &&
 	     !(skb_dst(skb)->dev->features & NETIF_F_SCTP_CRC))) {
 		sctph->dest = cp->dport;
-		if (!skb_is_gso(skb) || !skb_is_gso_sctp(skb))
+		if (!skb_is_gso(skb))
 			sctp_nat_csum(skb, sctph, sctphoff);
 	} else if (skb->ip_summed != CHECKSUM_PARTIAL) {
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 1466015bc56d..b429ffde25b1 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3426,7 +3426,8 @@ static int ctnetlink_del_expect(struct sk_buff *skb,
 
 		if (cda[CTA_EXPECT_ID]) {
 			__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
-			if (ntohl(id) != (u32)(unsigned long)exp) {
+
+			if (id != nf_expect_get_id(exp)) {
 				nf_ct_expect_put(exp);
 				return -ENOENT;
 			}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 6e4ce511f51b..8ded61a3f93e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3049,18 +3049,17 @@ static struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
 	return ERR_PTR(err);
 }
 
-int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src)
+int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp)
 {
 	int err;
 
-	if (src->ops->clone) {
-		dst->ops = src->ops;
-		err = src->ops->clone(dst, src);
-		if (err < 0)
-			return err;
-	} else {
-		memcpy(dst, src, src->ops->size);
-	}
+	if (WARN_ON_ONCE(!src->ops->clone))
+		return -EINVAL;
+
+	dst->ops = src->ops;
+	err = src->ops->clone(dst, src, gfp);
+	if (err < 0)
+		return err;
 
 	__module_get(src->ops->type->owner);
 
@@ -3446,6 +3445,15 @@ static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *r
 	nf_tables_rule_destroy(ctx, rule);
 }
 
+/** nft_chain_validate - loop detection and hook validation
+ *
+ * @ctx: context containing call depth and base chain
+ * @chain: chain to validate
+ *
+ * Walk through the rules of the given chain and chase all jumps/gotos
+ * and set lookups until either the jump limit is hit or all reachable
+ * chains have been validated.
+ */
 int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 {
 	struct nft_expr *expr, *last;
@@ -3464,6 +3472,9 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 			if (!expr->ops->validate)
 				continue;
 
+			/* This may call nft_chain_validate() recursively,
+			 * callers that do so must increment ctx->level.
+			 */
 			err = expr->ops->validate(ctx, expr, &data);
 			if (err < 0)
 				return err;
@@ -5769,8 +5780,10 @@ static int nf_tables_getsetelem(struct sk_buff *skb,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 
 	return err;
@@ -5953,7 +5966,7 @@ int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
 		if (!expr)
 			goto err_expr;
 
-		err = nft_expr_clone(expr, set->exprs[i]);
+		err = nft_expr_clone(expr, set->exprs[i], GFP_KERNEL_ACCOUNT);
 		if (err < 0) {
 			kfree(expr);
 			goto err_expr;
@@ -5981,7 +5994,7 @@ static int nft_set_elem_expr_setup(struct nft_ctx *ctx,
 
 	for (i = 0; i < num_exprs; i++) {
 		expr = nft_setelem_expr_at(elem_expr, elem_expr->size);
-		err = nft_expr_clone(expr, expr_array[i]);
+		err = nft_expr_clone(expr, expr_array[i], GFP_KERNEL_ACCOUNT);
 		if (err < 0)
 			goto err_elem_expr_setup;
 
@@ -6589,8 +6602,10 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_add_set_elem(&ctx, set, attr, info->nlh->nlmsg_flags);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			return err;
+		}
 	}
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
@@ -6866,8 +6881,10 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_del_setelem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 	return err;
 }
@@ -9179,6 +9196,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
 struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 {
 	struct nft_set_elem_catchall *catchall, *next;
+	u64 tstamp = nft_net_tstamp(gc->net);
 	const struct nft_set *set = gc->set;
 	struct nft_set_elem elem;
 	struct nft_set_ext *ext;
@@ -9188,7 +9206,7 @@ struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 
-		if (!nft_set_elem_expired(ext))
+		if (!__nft_set_elem_expired(ext, tstamp))
 			continue;
 
 		gc = nft_trans_gc_queue_sync(gc, GFP_KERNEL);
@@ -9940,6 +9958,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	bool genid_ok;
 
 	mutex_lock(&nft_net->commit_mutex);
+	nft_net->tstamp = get_jiffies_64();
 
 	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
@@ -9992,143 +10011,6 @@ int nft_chain_validate_hooks(const struct nft_chain *chain,
 }
 EXPORT_SYMBOL_GPL(nft_chain_validate_hooks);
 
-/*
- * Loop detection - walk through the ruleset beginning at the destination chain
- * of a new jump until either the source chain is reached (loop) or all
- * reachable chains have been traversed.
- *
- * The loop check is performed whenever a new jump verdict is added to an
- * expression or verdict map or a verdict map is bound to a new chain.
- */
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain);
-
-static int nft_check_loops(const struct nft_ctx *ctx,
-			   const struct nft_set_ext *ext)
-{
-	const struct nft_data *data;
-	int ret;
-
-	data = nft_set_ext_data(ext);
-	switch (data->verdict.code) {
-	case NFT_JUMP:
-	case NFT_GOTO:
-		ret = nf_tables_check_loops(ctx, data->verdict.chain);
-		break;
-	default:
-		ret = 0;
-		break;
-	}
-
-	return ret;
-}
-
-static int nf_tables_loop_check_setelem(const struct nft_ctx *ctx,
-					struct nft_set *set,
-					const struct nft_set_iter *iter,
-					struct nft_set_elem *elem)
-{
-	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
-
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_FLAGS) &&
-	    *nft_set_ext_flags(ext) & NFT_SET_ELEM_INTERVAL_END)
-		return 0;
-
-	return nft_check_loops(ctx, ext);
-}
-
-static int nft_set_catchall_loops(const struct nft_ctx *ctx,
-				  struct nft_set *set)
-{
-	u8 genmask = nft_genmask_next(ctx->net);
-	struct nft_set_elem_catchall *catchall;
-	struct nft_set_ext *ext;
-	int ret = 0;
-
-	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
-		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_set_elem_active(ext, genmask))
-			continue;
-
-		ret = nft_check_loops(ctx, ext);
-		if (ret < 0)
-			return ret;
-	}
-
-	return ret;
-}
-
-static int nf_tables_check_loops(const struct nft_ctx *ctx,
-				 const struct nft_chain *chain)
-{
-	const struct nft_rule *rule;
-	const struct nft_expr *expr, *last;
-	struct nft_set *set;
-	struct nft_set_binding *binding;
-	struct nft_set_iter iter;
-
-	if (ctx->chain == chain)
-		return -ELOOP;
-
-	list_for_each_entry(rule, &chain->rules, list) {
-		nft_rule_for_each_expr(expr, last, rule) {
-			struct nft_immediate_expr *priv;
-			const struct nft_data *data;
-			int err;
-
-			if (strcmp(expr->ops->type->name, "immediate"))
-				continue;
-
-			priv = nft_expr_priv(expr);
-			if (priv->dreg != NFT_REG_VERDICT)
-				continue;
-
-			data = &priv->data;
-			switch (data->verdict.code) {
-			case NFT_JUMP:
-			case NFT_GOTO:
-				err = nf_tables_check_loops(ctx,
-							data->verdict.chain);
-				if (err < 0)
-					return err;
-				break;
-			default:
-				break;
-			}
-		}
-	}
-
-	list_for_each_entry(set, &ctx->table->sets, list) {
-		if (!nft_is_active_next(ctx->net, set))
-			continue;
-		if (!(set->flags & NFT_SET_MAP) ||
-		    set->dtype != NFT_DATA_VERDICT)
-			continue;
-
-		list_for_each_entry(binding, &set->bindings, list) {
-			if (!(binding->flags & NFT_SET_MAP) ||
-			    binding->chain != chain)
-				continue;
-
-			iter.genmask	= nft_genmask_next(ctx->net);
-			iter.skip 	= 0;
-			iter.count	= 0;
-			iter.err	= 0;
-			iter.fn		= nf_tables_loop_check_setelem;
-
-			set->ops->walk(ctx, set, &iter);
-			if (!iter.err)
-				iter.err = nft_set_catchall_loops(ctx, set);
-
-			if (iter.err < 0)
-				return iter.err;
-		}
-	}
-
-	return 0;
-}
-
 /**
  *	nft_parse_u32_check - fetch u32 attribute and check for maximum value
  *
@@ -10241,7 +10123,7 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		if (data != NULL &&
 		    (data->verdict.code == NFT_GOTO ||
 		     data->verdict.code == NFT_JUMP)) {
-			err = nf_tables_check_loops(ctx, data->verdict.chain);
+			err = nft_chain_validate(ctx, data->verdict.chain);
 			if (err < 0)
 				return err;
 		}
diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index f5df535bcbd0..403fffa14fa3 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -209,12 +209,12 @@ static void nft_connlimit_destroy(const struct nft_ctx *ctx,
 	nft_connlimit_do_destroy(ctx, priv);
 }
 
-static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_connlimit *priv_dst = nft_expr_priv(dst);
 	struct nft_connlimit *priv_src = nft_expr_priv(src);
 
-	priv_dst->list = kmalloc(sizeof(*priv_dst->list), GFP_ATOMIC);
+	priv_dst->list = kmalloc(sizeof(*priv_dst->list), gfp);
 	if (!priv_dst->list)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 9f78f8ad4ee1..1b468a16b523 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -225,7 +225,7 @@ static void nft_counter_destroy(const struct nft_ctx *ctx,
 	nft_counter_do_destroy(priv);
 }
 
-static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_counter_percpu_priv *priv = nft_expr_priv(src);
 	struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
@@ -235,7 +235,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
 
 	nft_counter_fetch(priv, &total);
 
-	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
+	cpu_stats = alloc_percpu_gfp(struct nft_counter, gfp);
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index e714e0efa736..ecdd4a60db9c 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -35,7 +35,7 @@ static int nft_dynset_expr_setup(const struct nft_dynset *priv,
 
 	for (i = 0; i < priv->num_exprs; i++) {
 		expr = nft_setelem_expr_at(elem_expr, elem_expr->size);
-		if (nft_expr_clone(expr, priv->expr_array[i]) < 0)
+		if (nft_expr_clone(expr, priv->expr_array[i], GFP_ATOMIC) < 0)
 			return -1;
 
 		elem_expr->size += priv->expr_array[i]->ops->size;
diff --git a/net/netfilter/nft_last.c b/net/netfilter/nft_last.c
index 63145a5e69ef..0959e5adfe96 100644
--- a/net/netfilter/nft_last.c
+++ b/net/netfilter/nft_last.c
@@ -101,12 +101,12 @@ static void nft_last_destroy(const struct nft_ctx *ctx,
 	kfree(priv->last);
 }
 
-static int nft_last_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_last_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_last_priv *priv_dst = nft_expr_priv(dst);
 	struct nft_last_priv *priv_src = nft_expr_priv(src);
 
-	priv_dst->last = kzalloc(sizeof(*priv_dst->last), GFP_ATOMIC);
+	priv_dst->last = kzalloc(sizeof(*priv_dst->last), gfp);
 	if (!priv_dst->last)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_limit.c b/net/netfilter/nft_limit.c
index b23a671fa9d8..9f69be2016c4 100644
--- a/net/netfilter/nft_limit.c
+++ b/net/netfilter/nft_limit.c
@@ -150,7 +150,7 @@ static void nft_limit_destroy(const struct nft_ctx *ctx,
 }
 
 static int nft_limit_clone(struct nft_limit_priv *priv_dst,
-			   const struct nft_limit_priv *priv_src)
+			   const struct nft_limit_priv *priv_src, gfp_t gfp)
 {
 	priv_dst->tokens_max = priv_src->tokens_max;
 	priv_dst->rate = priv_src->rate;
@@ -158,7 +158,7 @@ static int nft_limit_clone(struct nft_limit_priv *priv_dst,
 	priv_dst->burst = priv_src->burst;
 	priv_dst->invert = priv_src->invert;
 
-	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), GFP_ATOMIC);
+	priv_dst->limit = kmalloc(sizeof(*priv_dst->limit), gfp);
 	if (!priv_dst->limit)
 		return -ENOMEM;
 
@@ -222,14 +222,15 @@ static void nft_limit_pkts_destroy(const struct nft_ctx *ctx,
 	nft_limit_destroy(ctx, &priv->limit);
 }
 
-static int nft_limit_pkts_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_limit_pkts_clone(struct nft_expr *dst, const struct nft_expr *src,
+				gfp_t gfp)
 {
 	struct nft_limit_priv_pkts *priv_dst = nft_expr_priv(dst);
 	struct nft_limit_priv_pkts *priv_src = nft_expr_priv(src);
 
 	priv_dst->cost = priv_src->cost;
 
-	return nft_limit_clone(&priv_dst->limit, &priv_src->limit);
+	return nft_limit_clone(&priv_dst->limit, &priv_src->limit, gfp);
 }
 
 static struct nft_expr_type nft_limit_type;
@@ -279,12 +280,13 @@ static void nft_limit_bytes_destroy(const struct nft_ctx *ctx,
 	nft_limit_destroy(ctx, priv);
 }
 
-static int nft_limit_bytes_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_limit_bytes_clone(struct nft_expr *dst, const struct nft_expr *src,
+				 gfp_t gfp)
 {
 	struct nft_limit_priv *priv_dst = nft_expr_priv(dst);
 	struct nft_limit_priv *priv_src = nft_expr_priv(src);
 
-	return nft_limit_clone(priv_dst, priv_src);
+	return nft_limit_clone(priv_dst, priv_src, gfp);
 }
 
 static const struct nft_expr_ops nft_limit_bytes_ops = {
diff --git a/net/netfilter/nft_quota.c b/net/netfilter/nft_quota.c
index 73de40007dfe..586a6df645bc 100644
--- a/net/netfilter/nft_quota.c
+++ b/net/netfilter/nft_quota.c
@@ -232,7 +232,7 @@ static void nft_quota_destroy(const struct nft_ctx *ctx,
 	return nft_quota_do_destroy(ctx, priv);
 }
 
-static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_quota *priv_dst = nft_expr_priv(dst);
 	struct nft_quota *priv_src = nft_expr_priv(src);
@@ -240,7 +240,7 @@ static int nft_quota_clone(struct nft_expr *dst, const struct nft_expr *src)
 	priv_dst->quota = priv_src->quota;
 	priv_dst->flags = priv_src->flags;
 
-	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), GFP_ATOMIC);
+	priv_dst->consumed = kmalloc(sizeof(*priv_dst->consumed), gfp);
 	if (!priv_dst->consumed)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 2013de934cef..1fd3b413350d 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -35,6 +35,7 @@ struct nft_rhash_cmp_arg {
 	const struct nft_set		*set;
 	const u32			*key;
 	u8				genmask;
+	u64				tstamp;
 };
 
 static inline u32 nft_rhash_key(const void *data, u32 len, u32 seed)
@@ -61,7 +62,7 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 		return 1;
 	if (nft_set_elem_is_dead(&he->ext))
 		return 1;
-	if (nft_set_elem_expired(&he->ext))
+	if (__nft_set_elem_expired(&he->ext, x->tstamp))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
 		return 1;
@@ -86,6 +87,7 @@ bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -104,6 +106,7 @@ static void *nft_rhash_get(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -127,6 +130,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 		.genmask = NFT_GENMASK_ANY,
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -170,6 +174,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 	struct nft_rhash_elem *prev;
 
@@ -212,6 +217,7 @@ static void *nft_rhash_deactivate(const struct net *net,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 2299ced939c4..d9c1c467ea68 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -360,7 +360,7 @@
  * Return: -1 on no match, bit position on 'match_only', 0 otherwise.
  */
 int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
-		  union nft_pipapo_map_bucket *mt, bool match_only)
+		  const union nft_pipapo_map_bucket *mt, bool match_only)
 {
 	unsigned long bitset;
 	int k, ret = -1;
@@ -412,9 +412,9 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo_scratch *scratch;
 	unsigned long *res_map, *fill_map;
 	u8 genmask = nft_genmask_cur(net);
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
-	struct nft_pipapo_match *m;
-	struct nft_pipapo_field *f;
 	bool map_index;
 	int i;
 
@@ -432,7 +432,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 	res_map  = scratch->map + (map_index ? m->bsize_max : 0);
 	fill_map = scratch->map + (map_index ? 0 : m->bsize_max);
 
-	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
+	pipapo_resmap_init(m, res_map);
 
 	nft_pipapo_for_each_field(f, i, m) {
 		bool last = i == m->field_count - 1;
@@ -504,6 +504,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * @set:	nftables API set representation
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	timestamp to check for expired elements
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -513,15 +514,18 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
-					  const u8 *data, u8 genmask)
+					  const u8 *data, u8 genmask,
+					  u64 tstamp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *m = priv->clone;
 	unsigned long *res_map, *fill_map = NULL;
-	struct nft_pipapo_field *f;
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	int i;
 
+	m = priv->clone;
+
 	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
@@ -534,7 +538,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 		goto out;
 	}
 
-	memset(res_map, 0xff, m->bsize_max * sizeof(*res_map));
+	pipapo_resmap_init(m, res_map);
 
 	nft_pipapo_for_each_field(f, i, m) {
 		bool last = i == m->field_count - 1;
@@ -566,7 +570,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext))
+			if (__nft_set_elem_expired(&f->mt[b].e->ext, tstamp))
 				goto next_match;
 			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
@@ -603,7 +607,7 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			 nft_genmask_cur(net));
+			 nft_genmask_cur(net), get_jiffies_64());
 }
 
 /**
@@ -1197,6 +1201,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *m = priv->clone;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
@@ -1206,7 +1211,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask);
+	dup = pipapo_get(net, set, start, genmask, tstamp);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1228,7 +1233,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net));
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1581,6 +1586,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 	struct nft_set *set = (struct nft_set *) _set;
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
+	u64 tstamp = nft_net_tstamp(net);
 	int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
 	struct nft_trans_gc *gc;
@@ -1591,7 +1597,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
-		struct nft_pipapo_field *f;
+		const struct nft_pipapo_field *f;
 		int i, start, rules_fx;
 
 		start = first_rule;
@@ -1615,7 +1621,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 		/* synchronous gc never fails, there is no need to set on
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
-		if (nft_set_elem_expired(&e->ext)) {
+		if (__nft_set_elem_expired(&e->ext, tstamp)) {
 			priv->dirty = true;
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
@@ -1786,7 +1792,7 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
 	if (IS_ERR(e))
 		return NULL;
 
@@ -2037,8 +2043,8 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
-	struct nft_pipapo_match *m;
-	struct nft_pipapo_field *f;
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	int i, r;
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_pipapo.h b/net/netfilter/nft_set_pipapo.h
index 30a3d092cd84..519a2e6dc206 100644
--- a/net/netfilter/nft_set_pipapo.h
+++ b/net/netfilter/nft_set_pipapo.h
@@ -185,7 +185,7 @@ struct nft_pipapo_elem {
 };
 
 int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
-		  union nft_pipapo_map_bucket *mt, bool match_only);
+		  const union nft_pipapo_map_bucket *mt, bool match_only);
 
 /**
  * pipapo_and_field_buckets_4bit() - Intersect 4-bit buckets
@@ -193,7 +193,7 @@ int pipapo_refill(unsigned long *map, int len, int rules, unsigned long *dst,
  * @dst:	Area to store result
  * @data:	Input data selecting table buckets
  */
-static inline void pipapo_and_field_buckets_4bit(struct nft_pipapo_field *f,
+static inline void pipapo_and_field_buckets_4bit(const struct nft_pipapo_field *f,
 						 unsigned long *dst,
 						 const u8 *data)
 {
@@ -221,7 +221,7 @@ static inline void pipapo_and_field_buckets_4bit(struct nft_pipapo_field *f,
  * @dst:	Area to store result
  * @data:	Input data selecting table buckets
  */
-static inline void pipapo_and_field_buckets_8bit(struct nft_pipapo_field *f,
+static inline void pipapo_and_field_buckets_8bit(const struct nft_pipapo_field *f,
 						 unsigned long *dst,
 						 const u8 *data)
 {
@@ -285,4 +285,25 @@ static u64 pipapo_estimate_size(const struct nft_set_desc *desc)
 	return size;
 }
 
+/**
+ * pipapo_resmap_init() - Initialise result map before first use
+ * @m:		Matching data, including mapping table
+ * @res_map:	Result map
+ *
+ * Initialize all bits covered by the first field to one, so that after
+ * the first step, only the matching bits of the first bit group remain.
+ *
+ * If other fields have a large bitmap, set remainder of res_map to 0.
+ */
+static inline void pipapo_resmap_init(const struct nft_pipapo_match *m, unsigned long *res_map)
+{
+	const struct nft_pipapo_field *f = m->f;
+	int i;
+
+	for (i = 0; i < f->bsize; i++)
+		res_map[i] = ULONG_MAX;
+
+	for (i = f->bsize; i < m->bsize_max; i++)
+		res_map[i] = 0ul;
+}
 #endif /* _NFT_SET_PIPAPO_H */
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 0d9f8e79eb00..dfae90cd3493 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -212,8 +212,9 @@ static int nft_pipapo_avx2_refill(int offset, unsigned long *map,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_2(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	u8 pg[2] = { pkt[0] >> 4, pkt[0] & 0xf };
@@ -274,8 +275,9 @@ static int nft_pipapo_avx2_lookup_4b_2(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_4(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	u8 pg[4] = { pkt[0] >> 4, pkt[0] & 0xf, pkt[1] >> 4, pkt[1] & 0xf };
@@ -350,8 +352,9 @@ static int nft_pipapo_avx2_lookup_4b_4(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_8(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	u8 pg[8] = {  pkt[0] >> 4,  pkt[0] & 0xf,  pkt[1] >> 4,  pkt[1] & 0xf,
 		      pkt[2] >> 4,  pkt[2] & 0xf,  pkt[3] >> 4,  pkt[3] & 0xf,
@@ -445,8 +448,9 @@ static int nft_pipapo_avx2_lookup_4b_8(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_12(unsigned long *map, unsigned long *fill,
-				        struct nft_pipapo_field *f, int offset,
-				        const u8 *pkt, bool first, bool last)
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	u8 pg[12] = {  pkt[0] >> 4,  pkt[0] & 0xf,  pkt[1] >> 4,  pkt[1] & 0xf,
 		       pkt[2] >> 4,  pkt[2] & 0xf,  pkt[3] >> 4,  pkt[3] & 0xf,
@@ -534,8 +538,9 @@ static int nft_pipapo_avx2_lookup_4b_12(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_4b_32(unsigned long *map, unsigned long *fill,
-					struct nft_pipapo_field *f, int offset,
-					const u8 *pkt, bool first, bool last)
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	u8 pg[32] = {  pkt[0] >> 4,  pkt[0] & 0xf,  pkt[1] >> 4,  pkt[1] & 0xf,
 		       pkt[2] >> 4,  pkt[2] & 0xf,  pkt[3] >> 4,  pkt[3] & 0xf,
@@ -669,8 +674,9 @@ static int nft_pipapo_avx2_lookup_4b_32(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_1(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -726,8 +732,9 @@ static int nft_pipapo_avx2_lookup_8b_1(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_2(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -790,8 +797,9 @@ static int nft_pipapo_avx2_lookup_8b_2(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_4(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -865,8 +873,9 @@ static int nft_pipapo_avx2_lookup_8b_4(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_6(unsigned long *map, unsigned long *fill,
-				       struct nft_pipapo_field *f, int offset,
-				       const u8 *pkt, bool first, bool last)
+				       const struct nft_pipapo_field *f,
+				       int offset, const u8 *pkt,
+				       bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -950,8 +959,9 @@ static int nft_pipapo_avx2_lookup_8b_6(unsigned long *map, unsigned long *fill,
  * word index to be checked next (i.e. first filled word).
  */
 static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
-					struct nft_pipapo_field *f, int offset,
-					const u8 *pkt, bool first, bool last)
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	int i, ret = -1, m256_size = f->bsize / NFT_PIPAPO_LONGS_PER_M256, b;
 	unsigned long *lt = f->lt, bsize = f->bsize;
@@ -1026,6 +1036,7 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
 
 /**
  * nft_pipapo_avx2_lookup_slow() - Fallback function for uncommon field sizes
+ * @mdata:	Matching data, including mapping table
  * @map:	Previous match result, used as initial bitmap
  * @fill:	Destination bitmap to be filled with current match result
  * @f:		Field, containing lookup and mapping tables
@@ -1041,9 +1052,11 @@ static int nft_pipapo_avx2_lookup_8b_16(unsigned long *map, unsigned long *fill,
  * Return: -1 on no match, rule index of match if @last, otherwise first long
  * word index to be checked next (i.e. first filled word).
  */
-static int nft_pipapo_avx2_lookup_slow(unsigned long *map, unsigned long *fill,
-					struct nft_pipapo_field *f, int offset,
-					const u8 *pkt, bool first, bool last)
+static int nft_pipapo_avx2_lookup_slow(const struct nft_pipapo_match *mdata,
+					unsigned long *map, unsigned long *fill,
+					const struct nft_pipapo_field *f,
+					int offset, const u8 *pkt,
+					bool first, bool last)
 {
 	unsigned long *lt = f->lt, bsize = f->bsize;
 	int i, ret = -1, b;
@@ -1051,7 +1064,7 @@ static int nft_pipapo_avx2_lookup_slow(unsigned long *map, unsigned long *fill,
 	lt += offset * NFT_PIPAPO_LONGS_PER_M256;
 
 	if (first)
-		memset(map, 0xff, bsize * sizeof(*map));
+		pipapo_resmap_init(mdata, map);
 
 	for (i = offset; i < bsize; i++) {
 		if (f->bb == 8)
@@ -1121,15 +1134,21 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_scratch *scratch;
 	u8 genmask = nft_genmask_cur(net);
+	const struct nft_pipapo_match *m;
+	const struct nft_pipapo_field *f;
 	const u8 *rp = (const u8 *)key;
-	struct nft_pipapo_match *m;
-	struct nft_pipapo_field *f;
 	unsigned long *res, *fill;
 	bool map_index;
 	int i, ret = 0;
 
-	if (unlikely(!irq_fpu_usable()))
-		return nft_pipapo_lookup(net, set, key, ext);
+	local_bh_disable();
+
+	if (unlikely(!irq_fpu_usable())) {
+		bool fallback_res = nft_pipapo_lookup(net, set, key, ext);
+
+		local_bh_enable();
+		return fallback_res;
+	}
 
 	m = rcu_dereference(priv->match);
 
@@ -1144,6 +1163,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	scratch = *raw_cpu_ptr(m->scratch);
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
+		local_bh_enable();
 		return false;
 	}
 
@@ -1177,7 +1197,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			} else if (f->groups == 16) {
 				NFT_SET_PIPAPO_AVX2_LOOKUP(8, 16);
 			} else {
-				ret = nft_pipapo_avx2_lookup_slow(res, fill, f,
+				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
 								  ret, rp,
 								  first, last);
 			}
@@ -1193,7 +1213,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 			} else if (f->groups == 32) {
 				NFT_SET_PIPAPO_AVX2_LOOKUP(4, 32);
 			} else {
-				ret = nft_pipapo_avx2_lookup_slow(res, fill, f,
+				ret = nft_pipapo_avx2_lookup_slow(m, res, fill, f,
 								  ret, rp,
 								  first, last);
 			}
@@ -1224,6 +1244,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	if (i % 2)
 		scratch->map_index = !map_index;
 	kernel_fpu_end();
+	local_bh_enable();
 
 	return ret >= 0;
 }
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 5bf5572e945c..021d9e76129a 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -314,6 +314,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -361,7 +362,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		/* perform garbage collection to avoid bogus overlap reports
 		 * but skip new elements in this transaction.
 		 */
-		if (nft_set_elem_expired(&rbe->ext) &&
+		if (__nft_set_elem_expired(&rbe->ext, tstamp) &&
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
@@ -548,6 +549,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 	const struct rb_node *parent = priv->root.rb_node;
 	struct nft_rbtree_elem *rbe, *this = elem->priv;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	while (parent != NULL) {
@@ -568,7 +570,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
-			} else if (nft_set_elem_expired(&rbe->ext)) {
+			} else if (__nft_set_elem_expired(&rbe->ext, tstamp)) {
 				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8d0feb9ad5a5..d1ae1d9133d3 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -505,6 +505,61 @@ static void *packet_current_frame(struct packet_sock *po,
 	return packet_lookup_frame(po, rb, rb->head, status);
 }
 
+static u16 vlan_get_tci(struct sk_buff *skb, struct net_device *dev)
+{
+	u8 *skb_orig_data = skb->data;
+	int skb_orig_len = skb->len;
+	struct vlan_hdr vhdr, *vh;
+	unsigned int header_len;
+
+	if (!dev)
+		return 0;
+
+	/* In the SOCK_DGRAM scenario, skb data starts at the network
+	 * protocol, which is after the VLAN headers. The outer VLAN
+	 * header is at the hard_header_len offset in non-variable
+	 * length link layer headers. If it's a VLAN device, the
+	 * min_header_len should be used to exclude the VLAN header
+	 * size.
+	 */
+	if (dev->min_header_len == dev->hard_header_len)
+		header_len = dev->hard_header_len;
+	else if (is_vlan_dev(dev))
+		header_len = dev->min_header_len;
+	else
+		return 0;
+
+	skb_push(skb, skb->data - skb_mac_header(skb));
+	vh = skb_header_pointer(skb, header_len, sizeof(vhdr), &vhdr);
+	if (skb_orig_data != skb->data) {
+		skb->data = skb_orig_data;
+		skb->len = skb_orig_len;
+	}
+	if (unlikely(!vh))
+		return 0;
+
+	return ntohs(vh->h_vlan_TCI);
+}
+
+static __be16 vlan_get_protocol_dgram(struct sk_buff *skb)
+{
+	__be16 proto = skb->protocol;
+
+	if (unlikely(eth_type_vlan(proto))) {
+		u8 *skb_orig_data = skb->data;
+		int skb_orig_len = skb->len;
+
+		skb_push(skb, skb->data - skb_mac_header(skb));
+		proto = __vlan_get_protocol(skb, proto, NULL);
+		if (skb_orig_data != skb->data) {
+			skb->data = skb_orig_data;
+			skb->len = skb_orig_len;
+		}
+	}
+
+	return proto;
+}
+
 static void prb_del_retire_blk_timer(struct tpacket_kbdq_core *pkc)
 {
 	del_timer_sync(&pkc->retire_blk_timer);
@@ -974,10 +1029,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
 static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
 			struct tpacket3_hdr *ppd)
 {
+	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
+
 	if (skb_vlan_tag_present(pkc->skb)) {
 		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
 		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
 		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
+		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
+		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
+		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 	} else {
 		ppd->hv1.tp_vlan_tci = 0;
 		ppd->hv1.tp_vlan_tpid = 0;
@@ -2393,6 +2454,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 			h.h2->tp_vlan_tci = skb_vlan_tag_get(skb);
 			h.h2->tp_vlan_tpid = ntohs(skb->vlan_proto);
 			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sk->sk_type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			h.h2->tp_vlan_tci = vlan_get_tci(skb, skb->dev);
+			h.h2->tp_vlan_tpid = ntohs(skb->protocol);
+			status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
 		} else {
 			h.h2->tp_vlan_tci = 0;
 			h.h2->tp_vlan_tpid = 0;
@@ -2422,7 +2487,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3447,7 +3513,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_ts_and_drops(msg, sk, skb);
@@ -3502,6 +3569,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 			aux.tp_vlan_tci = skb_vlan_tag_get(skb);
 			aux.tp_vlan_tpid = ntohs(skb->vlan_proto);
 			aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+		} else if (unlikely(sock->type == SOCK_DGRAM && eth_type_vlan(skb->protocol))) {
+			struct sockaddr_ll *sll = &PACKET_SKB_CB(skb)->sa.ll;
+			struct net_device *dev;
+
+			rcu_read_lock();
+			dev = dev_get_by_index_rcu(sock_net(sk), sll->sll_ifindex);
+			if (dev) {
+				aux.tp_vlan_tci = vlan_get_tci(skb, dev);
+				aux.tp_vlan_tpid = ntohs(skb->protocol);
+				aux.tp_status |= TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
+			} else {
+				aux.tp_vlan_tci = 0;
+				aux.tp_vlan_tpid = 0;
+			}
+			rcu_read_unlock();
 		} else {
 			aux.tp_vlan_tci = 0;
 			aux.tp_vlan_tpid = 0;
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index c602b0d698f2..a6c3b7145a10 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -41,6 +41,8 @@ static DEFINE_MUTEX(zones_mutex);
 struct zones_ht_key {
 	struct net *net;
 	u16 zone;
+	/* Note : pad[] must be the last field. */
+	u8  pad[];
 };
 
 struct tcf_ct_flow_table {
@@ -57,7 +59,7 @@ struct tcf_ct_flow_table {
 static const struct rhashtable_params zones_params = {
 	.head_offset = offsetof(struct tcf_ct_flow_table, node),
 	.key_offset = offsetof(struct tcf_ct_flow_table, key),
-	.key_len = sizeof_field(struct tcf_ct_flow_table, key),
+	.key_len = offsetof(struct zones_ht_key, pad),
 	.automatic_shrinking = true,
 };
 
diff --git a/net/sctp/input.c b/net/sctp/input.c
index d16b3885dccc..4ee9374dcfb9 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -748,23 +748,25 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 	struct sock *sk = ep->base.sk;
 	struct net *net = sock_net(sk);
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
+	int err = 0;
 
-	epb = &ep->base;
-	epb->hashent = sctp_ep_hashfn(net, epb->bind_addr.port);
-	head = &sctp_ep_hashtable[epb->hashent];
+	ep->hashent = sctp_ep_hashfn(net, ep->base.bind_addr.port);
+	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (sk->sk_reuseport) {
 		bool any = sctp_is_ep_boundall(sk);
-		struct sctp_ep_common *epb2;
+		struct sctp_endpoint *ep2;
 		struct list_head *list;
-		int cnt = 0, err = 1;
+		int cnt = 0;
+
+		err = 1;
 
 		list_for_each(list, &ep->base.bind_addr.address_list)
 			cnt++;
 
-		sctp_for_each_hentry(epb2, &head->chain) {
-			struct sock *sk2 = epb2->sk;
+		sctp_for_each_hentry(ep2, &head->chain) {
+			struct sock *sk2 = ep2->base.sk;
 
 			if (!net_eq(sock_net(sk2), net) || sk2 == sk ||
 			    !uid_eq(sock_i_uid(sk2), sock_i_uid(sk)) ||
@@ -776,24 +778,24 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
 			if (!err) {
 				err = reuseport_add_sock(sk, sk2, any);
 				if (err)
-					return err;
+					goto out;
 				break;
 			} else if (err < 0) {
-				return err;
+				goto out;
 			}
 		}
 
 		if (err) {
 			err = reuseport_alloc(sk, any);
 			if (err)
-				return err;
+				goto out;
 		}
 	}
 
-	write_lock(&head->lock);
-	hlist_add_head(&epb->node, &head->chain);
+	hlist_add_head(&ep->node, &head->chain);
+out:
 	write_unlock(&head->lock);
-	return 0;
+	return err;
 }
 
 /* Add an endpoint to the hash. Local BH-safe. */
@@ -813,19 +815,15 @@ static void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
 {
 	struct sock *sk = ep->base.sk;
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
-
-	epb = &ep->base;
 
-	epb->hashent = sctp_ep_hashfn(sock_net(sk), epb->bind_addr.port);
+	ep->hashent = sctp_ep_hashfn(sock_net(sk), ep->base.bind_addr.port);
 
-	head = &sctp_ep_hashtable[epb->hashent];
+	head = &sctp_ep_hashtable[ep->hashent];
 
+	write_lock(&head->lock);
 	if (rcu_access_pointer(sk->sk_reuseport_cb))
 		reuseport_detach_sock(sk);
-
-	write_lock(&head->lock);
-	hlist_del_init(&epb->node);
+	hlist_del_init(&ep->node);
 	write_unlock(&head->lock);
 }
 
@@ -858,7 +856,6 @@ static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(
 					const union sctp_addr *paddr)
 {
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
 	struct sctp_endpoint *ep;
 	struct sock *sk;
 	__be16 lport;
@@ -868,8 +865,7 @@ static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(
 	hash = sctp_ep_hashfn(net, ntohs(lport));
 	head = &sctp_ep_hashtable[hash];
 	read_lock(&head->lock);
-	sctp_for_each_hentry(epb, &head->chain) {
-		ep = sctp_ep(epb);
+	sctp_for_each_hentry(ep, &head->chain) {
 		if (sctp_endpoint_is_match(ep, net, laddr))
 			goto hit;
 	}
diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index 963b94517ec2..ec00ee75d59a 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -161,7 +161,6 @@ static void *sctp_eps_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 static int sctp_eps_seq_show(struct seq_file *seq, void *v)
 {
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
 	struct sctp_endpoint *ep;
 	struct sock *sk;
 	int    hash = *(loff_t *)v;
@@ -171,18 +170,17 @@ static int sctp_eps_seq_show(struct seq_file *seq, void *v)
 
 	head = &sctp_ep_hashtable[hash];
 	read_lock_bh(&head->lock);
-	sctp_for_each_hentry(epb, &head->chain) {
-		ep = sctp_ep(epb);
-		sk = epb->sk;
+	sctp_for_each_hentry(ep, &head->chain) {
+		sk = ep->base.sk;
 		if (!net_eq(sock_net(sk), seq_file_net(seq)))
 			continue;
 		seq_printf(seq, "%8pK %8pK %-3d %-3d %-4d %-5d %5u %5lu ", ep, sk,
 			   sctp_sk(sk)->type, sk->sk_state, hash,
-			   epb->bind_addr.port,
+			   ep->base.bind_addr.port,
 			   from_kuid_munged(seq_user_ns(seq), sock_i_uid(sk)),
 			   sock_i_ino(sk));
 
-		sctp_seq_dump_local_addrs(seq, epb);
+		sctp_seq_dump_local_addrs(seq, &ep->base);
 		seq_printf(seq, "\n");
 	}
 	read_unlock_bh(&head->lock);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 967b330ffd4e..9fe13de66b27 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5303,14 +5303,14 @@ int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
 			   void *p) {
 	int err = 0;
 	int hash = 0;
-	struct sctp_ep_common *epb;
+	struct sctp_endpoint *ep;
 	struct sctp_hashbucket *head;
 
 	for (head = sctp_ep_hashtable; hash < sctp_ep_hashsize;
 	     hash++, head++) {
 		read_lock_bh(&head->lock);
-		sctp_for_each_hentry(epb, &head->chain) {
-			err = cb(sctp_ep(epb), p);
+		sctp_for_each_hentry(ep, &head->chain) {
+			err = cb(ep, p);
 			if (err)
 				break;
 		}
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index b84896acd473..0b32612b86aa 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1772,7 +1772,6 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
  */
 static u8 smc_compress_bufsize(int size, bool is_smcd, bool is_rmb)
 {
-	const unsigned int max_scat = SG_MAX_SINGLE_ALLOC * PAGE_SIZE;
 	u8 compressed;
 
 	if (size <= SMC_BUF_MIN_SIZE)
@@ -1782,9 +1781,11 @@ static u8 smc_compress_bufsize(int size, bool is_smcd, bool is_rmb)
 	compressed = min_t(u8, ilog2(size) + 1,
 			   is_smcd ? SMCD_DMBE_SIZES : SMCR_RMBE_SIZES);
 
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
 	if (!is_smcd && is_rmb)
 		/* RMBs are backed by & limited to max size of scatterlists */
-		compressed = min_t(u8, compressed, ilog2(max_scat >> 14));
+		compressed = min_t(u8, compressed, ilog2((SG_MAX_SINGLE_ALLOC * PAGE_SIZE) >> 14));
+#endif
 
 	return compressed;
 }
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 726c076950c0..fc4639687c0f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -161,7 +161,7 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 	if (IS_ERR(cipher))
 		goto err_return;
 	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
-		goto err_return;
+		goto err_free_cipher;
 
 	/* allocate and set up buffers */
 
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index f73d4593625c..38071a678021 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2226,12 +2226,13 @@ call_transmit_status(struct rpc_task *task)
 		task->tk_action = call_transmit;
 		task->tk_status = 0;
 		break;
-	case -ECONNREFUSED:
 	case -EHOSTDOWN:
 	case -ENETDOWN:
 	case -EHOSTUNREACH:
 	case -ENETUNREACH:
 	case -EPERM:
+		break;
+	case -ECONNREFUSED:
 		if (RPC_IS_SOFTCONN(task)) {
 			if (!task->tk_msg.rpc_proc->p_proc)
 				trace_xprt_ping(task->tk_xprt,
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index a00890962e11..540220264b31 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -348,8 +348,10 @@ static void rpc_make_runnable(struct workqueue_struct *wq,
 	if (RPC_IS_ASYNC(task)) {
 		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
 		queue_work(wq, &task->u.tk_work);
-	} else
+	} else {
+		smp_mb__after_atomic();
 		wake_up_bit(&task->tk_runstate, RPC_TASK_QUEUED);
+	}
 }
 
 /*
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index f700b34a5bfd..551f3dd4e623 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -96,7 +96,8 @@ static void frwr_mr_put(struct rpcrdma_mr *mr)
 	rpcrdma_mr_push(mr, &mr->mr_req->rl_free_mrs);
 }
 
-/* frwr_reset - Place MRs back on the free list
+/**
+ * frwr_reset - Place MRs back on @req's free list
  * @req: request to reset
  *
  * Used after a failed marshal. For FRWR, this means the MRs
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 34413d4ab0e5..b61ade10254d 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -924,6 +924,8 @@ static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt)
 
 static void rpcrdma_req_reset(struct rpcrdma_req *req)
 {
+	struct rpcrdma_mr *mr;
+
 	/* Credits are valid for only one connection */
 	req->rl_slot.rq_cong = 0;
 
@@ -933,7 +935,19 @@ static void rpcrdma_req_reset(struct rpcrdma_req *req)
 	rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
 	rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
 
-	frwr_reset(req);
+	/* The verbs consumer can't know the state of an MR on the
+	 * req->rl_registered list unless a successful completion
+	 * has occurred, so they cannot be re-used.
+	 */
+	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
+		struct rpcrdma_buffer *buf = &mr->mr_xprt->rx_buf;
+
+		spin_lock(&buf->rb_lock);
+		list_del(&mr->mr_all);
+		spin_unlock(&buf->rb_lock);
+
+		frwr_mr_release(mr);
+	}
 }
 
 /* ASSUMPTION: the rb_allreqs list is stable for the duration,
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 0a85244fd618..73e461dc12d7 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -135,8 +135,11 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
 		snprintf(buf, size, "%pI4:%u", &ua->ipv4, ntohs(ua->port));
 	else if (ntohs(ua->proto) == ETH_P_IPV6)
 		snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port));
-	else
+	else {
 		pr_err("Invalid UDP media address\n");
+		return 1;
+	}
+
 	return 0;
 }
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 90f6cbe5cd5d..c17c3a14b9c1 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -468,7 +468,6 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct tls_rec *rec;
-	bool ready = false;
 
 	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
 		return;
@@ -502,19 +501,16 @@ static void tls_encrypt_done(struct crypto_async_request *req, int err)
 		/* If received record is at head of tx_list, schedule tx */
 		first_rec = list_first_entry(&ctx->tx_list,
 					     struct tls_rec, list);
-		if (rec == first_rec)
-			ready = true;
+		if (rec == first_rec) {
+			/* Schedule the transmission */
+			if (!test_and_set_bit(BIT_TX_SCHEDULED,
+					      &ctx->tx_bitmask))
+				schedule_delayed_work(&ctx->tx_work.work, 1);
+		}
 	}
 
 	if (atomic_dec_and_test(&ctx->encrypt_pending))
 		complete(&ctx->async_wait.completion);
-
-	if (!ready)
-		return;
-
-	/* Schedule the transmission */
-	if (!test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
-		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
 static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d758ec565589..a46278cf67da 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -438,6 +438,10 @@ sar_policy[NL80211_SAR_ATTR_MAX + 1] = {
 	[NL80211_SAR_ATTR_SPECS] = NLA_POLICY_NESTED_ARRAY(sar_specs_policy),
 };
 
+static struct netlink_range_validation q_range = {
+	.max = INT_MAX,
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -720,7 +724,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
-	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
+	[NL80211_ATTR_TXQ_QUANTUM] = NLA_POLICY_FULL_RANGE(NLA_U32, &q_range),
 	[NL80211_ATTR_HE_CAPABILITY] =
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_HE_MIN_CAPABILITY_LEN,
@@ -4137,10 +4141,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	struct nlattr *key;
 	struct get_key_cookie *cookie = c;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_ATTR_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_ATTR_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
@@ -4152,10 +4153,7 @@ static void get_key_callback(void *c, struct key_params *params)
 	if (!key)
 		goto nla_put_failure;
 
-	if ((params->key &&
-	     nla_put(cookie->msg, NL80211_KEY_DATA,
-		     params->key_len, params->key)) ||
-	    (params->seq &&
+	if ((params->seq &&
 	     nla_put(cookie->msg, NL80211_KEY_SEQ,
 		     params->seq_len, params->seq)) ||
 	    (params->cipher &&
diff --git a/net/wireless/util.c b/net/wireless/util.c
index d40c2cf777dc..6ebc6567b287 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1363,7 +1363,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 		  5120, /*  0.833333... */
 	};
 	u32 rates_160M[3] = { 960777777, 907400000, 816666666 };
-	u32 rates_969[3] =  { 480388888, 453700000, 408333333 };
+	u32 rates_996[3] =  { 480388888, 453700000, 408333333 };
 	u32 rates_484[3] =  { 229411111, 216666666, 195000000 };
 	u32 rates_242[3] =  { 114711111, 108333333,  97500000 };
 	u32 rates_106[3] =  {  40000000,  37777777,  34000000 };
@@ -1383,12 +1383,14 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	if (WARN_ON_ONCE(rate->nss < 1 || rate->nss > 8))
 		return 0;
 
-	if (rate->bw == RATE_INFO_BW_160)
+	if (rate->bw == RATE_INFO_BW_160 ||
+	    (rate->bw == RATE_INFO_BW_HE_RU &&
+	     rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_2x996))
 		result = rates_160M[rate->he_gi];
 	else if (rate->bw == RATE_INFO_BW_80 ||
 		 (rate->bw == RATE_INFO_BW_HE_RU &&
 		  rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_996))
-		result = rates_969[rate->he_gi];
+		result = rates_996[rate->he_gi];
 	else if (rate->bw == RATE_INFO_BW_40 ||
 		 (rate->bw == RATE_INFO_BW_HE_RU &&
 		  rate->he_ru_alloc == NL80211_RATE_INFO_HE_RU_ALLOC_484))
diff --git a/scripts/gcc-x86_32-has-stack-protector.sh b/scripts/gcc-x86_32-has-stack-protector.sh
index 825c75c5b715..9459ca4f0f11 100755
--- a/scripts/gcc-x86_32-has-stack-protector.sh
+++ b/scripts/gcc-x86_32-has-stack-protector.sh
@@ -5,4 +5,4 @@
 # -mstack-protector-guard-reg, added by
 # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81708
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m32 -O0 -fstack-protector -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard - -o - 2> /dev/null | grep -q "%fs"
diff --git a/scripts/gcc-x86_64-has-stack-protector.sh b/scripts/gcc-x86_64-has-stack-protector.sh
index 75e4e22b986a..f680bb01aeeb 100755
--- a/scripts/gcc-x86_64-has-stack-protector.sh
+++ b/scripts/gcc-x86_64-has-stack-protector.sh
@@ -1,4 +1,4 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 
-echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
+echo "int foo(void) { char X[200]; return 3; }" | $* -S -x c -m64 -O0 -mcmodel=kernel -fno-PIE -fstack-protector - -o - 2> /dev/null | grep -q "%gs"
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 10274eb90fa3..cf26ffe8cccb 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1057,6 +1057,13 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	if (!skb->secmark)
 		return 0;
 
+	/*
+	 * If reach here before socket_post_create hook is called, in which
+	 * case label is null, drop the packet.
+	 */
+	if (!ctx->label)
+		return -EACCES;
+
 	return apparmor_secmark_check(ctx->label, OP_RECVMSG, AA_MAY_RECEIVE,
 				      skb->secmark, sk);
 }
diff --git a/security/apparmor/policy.c b/security/apparmor/policy.c
index fcf22577f606..e59bdb750ef0 100644
--- a/security/apparmor/policy.c
+++ b/security/apparmor/policy.c
@@ -187,7 +187,7 @@ static void aa_free_data(void *ptr, void *arg)
 {
 	struct aa_data *data = ptr;
 
-	kfree_sensitive(data->data);
+	kvfree_sensitive(data->data, data->size);
 	kfree_sensitive(data->key);
 	kfree_sensitive(data);
 }
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index d1a385b44d63..851fd6212831 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -915,6 +915,7 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 
 			if (rhashtable_insert_fast(profile->data, &data->head,
 						   profile->data->p)) {
+				kvfree_sensitive(data->data, data->size);
 				kfree_sensitive(data->key);
 				kfree_sensitive(data);
 				info = "failed to insert data to table";
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index cfb500087692..255115251ce5 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1694,7 +1694,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
diff --git a/security/landlock/cred.c b/security/landlock/cred.c
index ec6c37f04a19..e215607fd46c 100644
--- a/security/landlock/cred.c
+++ b/security/landlock/cred.c
@@ -14,8 +14,8 @@
 #include "ruleset.h"
 #include "setup.h"
 
-static int hook_cred_prepare(struct cred *const new,
-			     const struct cred *const old, const gfp_t gfp)
+static void hook_cred_transfer(struct cred *const new,
+			       const struct cred *const old)
 {
 	struct landlock_ruleset *const old_dom = landlock_cred(old)->domain;
 
@@ -23,6 +23,12 @@ static int hook_cred_prepare(struct cred *const new,
 		landlock_get_ruleset(old_dom);
 		landlock_cred(new)->domain = old_dom;
 	}
+}
+
+static int hook_cred_prepare(struct cred *const new,
+			     const struct cred *const old, const gfp_t gfp)
+{
+	hook_cred_transfer(new, old);
 	return 0;
 }
 
@@ -36,6 +42,7 @@ static void hook_cred_free(struct cred *const cred)
 
 static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(cred_prepare, hook_cred_prepare),
+	LSM_HOOK_INIT(cred_transfer, hook_cred_transfer),
 	LSM_HOOK_INIT(cred_free, hook_cred_free),
 };
 
diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index 875312568369..842fe127c537 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -77,6 +77,8 @@
 // overrun. Actual device can skip more, then this module stops the packet streaming.
 #define IR_JUMBO_PAYLOAD_MAX_SKIP_CYCLES	5
 
+static void pcm_period_work(struct work_struct *work);
+
 /**
  * amdtp_stream_init - initialize an AMDTP stream structure
  * @s: the AMDTP stream to initialize
@@ -105,6 +107,7 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
+	INIT_WORK(&s->period_work, pcm_period_work);
 	s->packet_index = 0;
 
 	init_waitqueue_head(&s->ready_wait);
@@ -343,6 +346,7 @@ EXPORT_SYMBOL(amdtp_stream_get_max_payload);
  */
 void amdtp_stream_pcm_prepare(struct amdtp_stream *s)
 {
+	cancel_work_sync(&s->period_work);
 	s->pcm_buffer_pointer = 0;
 	s->pcm_period_pointer = 0;
 }
@@ -609,19 +613,21 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 		// The program in user process should periodically check the status of intermediate
 		// buffer associated to PCM substream to process PCM frames in the buffer, instead
 		// of receiving notification of period elapsed by poll wait.
-		if (!pcm->runtime->no_period_wakeup) {
-			if (in_softirq()) {
-				// In software IRQ context for 1394 OHCI.
-				snd_pcm_period_elapsed(pcm);
-			} else {
-				// In process context of ALSA PCM application under acquired lock of
-				// PCM substream.
-				snd_pcm_period_elapsed_under_stream_lock(pcm);
-			}
-		}
+		if (!pcm->runtime->no_period_wakeup)
+			queue_work(system_highpri_wq, &s->period_work);
 	}
 }
 
+static void pcm_period_work(struct work_struct *work)
+{
+	struct amdtp_stream *s = container_of(work, struct amdtp_stream,
+					      period_work);
+	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
+
+	if (pcm)
+		snd_pcm_period_elapsed(pcm);
+}
+
 static int queue_packet(struct amdtp_stream *s, struct fw_iso_packet *params,
 			bool sched_irq)
 {
@@ -1738,11 +1744,14 @@ unsigned long amdtp_domain_stream_pcm_pointer(struct amdtp_domain *d,
 {
 	struct amdtp_stream *irq_target = d->irq_target;
 
-	// Process isochronous packets queued till recent isochronous cycle to handle PCM frames.
 	if (irq_target && amdtp_stream_running(irq_target)) {
-		// In software IRQ context, the call causes dead-lock to disable the tasklet
-		// synchronously.
-		if (!in_softirq())
+		// use wq to prevent AB/BA deadlock competition for
+		// substream lock:
+		// fw_iso_context_flush_completions() acquires
+		// lock by ohci_flush_iso_completions(),
+		// amdtp-stream process_rx_packets() attempts to
+		// acquire same lock by snd_pcm_elapsed()
+		if (current_work() != &s->period_work)
 			fw_iso_context_flush_completions(irq_target->context);
 	}
 
@@ -1798,6 +1807,7 @@ static void amdtp_stream_stop(struct amdtp_stream *s)
 		return;
 	}
 
+	cancel_work_sync(&s->period_work);
 	fw_iso_context_stop(s->context);
 	fw_iso_context_destroy(s->context);
 	s->context = ERR_PTR(-1);
diff --git a/sound/firewire/amdtp-stream.h b/sound/firewire/amdtp-stream.h
index cf9ab347277f..011d0f0c3941 100644
--- a/sound/firewire/amdtp-stream.h
+++ b/sound/firewire/amdtp-stream.h
@@ -190,6 +190,7 @@ struct amdtp_stream {
 
 	/* For a PCM substream processing. */
 	struct snd_pcm_substream *pcm;
+	struct work_struct period_work;
 	snd_pcm_uframes_t pcm_buffer_pointer;
 	unsigned int pcm_period_pointer;
 
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 876380ad2ed1..09a272c65be1 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -21,12 +21,6 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
-enum {
-	CX_HEADSET_NOPRESENT = 0,
-	CX_HEADSET_PARTPRESENT,
-	CX_HEADSET_ALLPRESENT,
-};
-
 struct conexant_spec {
 	struct hda_gen_spec gen;
 
@@ -48,7 +42,6 @@ struct conexant_spec {
 	unsigned int gpio_led;
 	unsigned int gpio_mute_led_mask;
 	unsigned int gpio_mic_led_mask;
-	unsigned int headset_present_flag;
 	bool is_cx8070_sn6140;
 };
 
@@ -250,48 +243,19 @@ static void cx_process_headset_plugin(struct hda_codec *codec)
 	}
 }
 
-static void cx_update_headset_mic_vref(struct hda_codec *codec, unsigned int res)
+static void cx_update_headset_mic_vref(struct hda_codec *codec, struct hda_jack_callback *event)
 {
-	unsigned int phone_present, mic_persent, phone_tag, mic_tag;
-	struct conexant_spec *spec = codec->spec;
+	unsigned int mic_present;
 
 	/* In cx8070 and sn6140, the node 16 can only be config to headphone or disabled,
 	 * the node 19 can only be config to microphone or disabled.
 	 * Check hp&mic tag to process headset pulgin&plugout.
 	 */
-	phone_tag = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	mic_tag = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_UNSOLICITED_RESPONSE, 0x0);
-	if ((phone_tag & (res >> AC_UNSOL_RES_TAG_SHIFT)) ||
-	    (mic_tag & (res >> AC_UNSOL_RES_TAG_SHIFT))) {
-		phone_present = snd_hda_codec_read(codec, 0x16, 0, AC_VERB_GET_PIN_SENSE, 0x0);
-		if (!(phone_present & AC_PINSENSE_PRESENCE)) {/* headphone plugout */
-			spec->headset_present_flag = CX_HEADSET_NOPRESENT;
-			snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
-			return;
-		}
-		if (spec->headset_present_flag == CX_HEADSET_NOPRESENT) {
-			spec->headset_present_flag = CX_HEADSET_PARTPRESENT;
-		} else if (spec->headset_present_flag == CX_HEADSET_PARTPRESENT) {
-			mic_persent = snd_hda_codec_read(codec, 0x19, 0,
-							 AC_VERB_GET_PIN_SENSE, 0x0);
-			/* headset is present */
-			if ((phone_present & AC_PINSENSE_PRESENCE) &&
-			    (mic_persent & AC_PINSENSE_PRESENCE)) {
-				cx_process_headset_plugin(codec);
-				spec->headset_present_flag = CX_HEADSET_ALLPRESENT;
-			}
-		}
-	}
-}
-
-static void cx_jack_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	struct conexant_spec *spec = codec->spec;
-
-	if (spec->is_cx8070_sn6140)
-		cx_update_headset_mic_vref(codec, res);
-
-	snd_hda_jack_unsol_event(codec, res);
+	mic_present = snd_hda_codec_read(codec, 0x19, 0, AC_VERB_GET_PIN_SENSE, 0x0);
+	if (!(mic_present & AC_PINSENSE_PRESENCE)) /* mic plugout */
+		snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x20);
+	else
+		cx_process_headset_plugin(codec);
 }
 
 #ifdef CONFIG_PM
@@ -307,7 +271,7 @@ static const struct hda_codec_ops cx_auto_patch_ops = {
 	.build_pcms = snd_hda_gen_build_pcms,
 	.init = cx_auto_init,
 	.free = cx_auto_free,
-	.unsol_event = cx_jack_unsol_event,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.suspend = cx_auto_suspend,
 	.check_power_status = snd_hda_gen_check_power_status,
@@ -1167,7 +1131,7 @@ static int patch_conexant_auto(struct hda_codec *codec)
 	case 0x14f11f86:
 	case 0x14f11f87:
 		spec->is_cx8070_sn6140 = true;
-		spec->headset_present_flag = CX_HEADSET_NOPRESENT;
+		snd_hda_jack_detect_enable_callback(codec, 0x19, cx_update_headset_mic_vref);
 		break;
 	}
 
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 20a899db2f15..81025d45306d 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1960,6 +1960,8 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 }
 
 static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
+	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 18fda6eb2790..8729896c7f9c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8958,6 +8958,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1025, 0x079b, "Acer Aspire V5-573G", ALC282_FIXUP_ASPIRE_V5_PINS),
 	SND_PCI_QUIRK(0x1025, 0x080d, "Acer Aspire V5-122P", ALC269_FIXUP_ASPIRE_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x0840, "Acer Aspire E1", ALC269VB_FIXUP_ASPIRE_E1_COEF),
+	SND_PCI_QUIRK(0x1025, 0x100c, "Acer Aspire E5-574G", ALC255_FIXUP_ACER_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1025, 0x101c, "Acer Veriton N2510G", ALC269_FIXUP_LIFEBOOK),
 	SND_PCI_QUIRK(0x1025, 0x102b, "Acer Aspire C24-860", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1025, 0x1065, "Acer Aspire C20-820", ALC269VC_FIXUP_ACER_HEADSET_MIC),
diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index f8e49e45ce33..a71fbfddc29a 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1319,6 +1319,7 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
                                   enum snd_soc_bias_level level)
 {
 	struct max98088_priv *max98088 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -1334,10 +1335,13 @@ static int max98088_set_bias_level(struct snd_soc_component *component,
 		 */
 		if (!IS_ERR(max98088->mclk)) {
 			if (snd_soc_component_get_bias_level(component) ==
-			    SND_SOC_BIAS_ON)
+			    SND_SOC_BIAS_ON) {
 				clk_disable_unprepare(max98088->mclk);
-			else
-				clk_prepare_enable(max98088->mclk);
+			} else {
+				ret = clk_prepare_enable(max98088->mclk);
+				if (ret)
+					return ret;
+			}
 		}
 		break;
 
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 84a67bd98dc0..cfe694fddd13 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -250,12 +250,12 @@ static int wcd9380_probe(struct sdw_slave *pdev,
 					SDW_SCP_INT1_PARITY;
 	pdev->prop.lane_control_support = true;
 	if (wcd->is_tx) {
-		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
+		pdev->prop.source_ports = GENMASK(WCD938X_MAX_SWR_PORTS - 1, 0);
 		pdev->prop.src_dpn_prop = wcd938x_dpn_prop;
 		wcd->ch_info = &wcd938x_sdw_tx_ch_info[0];
 		pdev->prop.wake_capable = true;
 	} else {
-		pdev->prop.sink_ports = GENMASK(WCD938X_MAX_SWR_PORTS, 0);
+		pdev->prop.sink_ports = GENMASK(WCD938X_MAX_SWR_PORTS - 1, 0);
 		pdev->prop.sink_dpn_prop = wcd938x_dpn_prop;
 		wcd->ch_info = &wcd938x_sdw_rx_ch_info[0];
 	}
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 855904769487..c8d3dc634103 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1120,7 +1120,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	wsa881x->sconfig.frame_rate = 48000;
 	wsa881x->sconfig.direction = SDW_DATA_DIR_RX;
 	wsa881x->sconfig.type = SDW_STREAM_PDM;
-	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
+	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS - 1, 0);
 	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 	gpiod_direction_output(wsa881x->sd_n, 1);
diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
index de4e550c5b34..42bd51456b94 100644
--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -11,7 +11,7 @@
 
 #include <linux/platform_data/x86/soc.h>
 
-#if IS_ENABLED(CONFIG_X86)
+#if IS_REACHABLE(CONFIG_IOSF_MBI)
 
 #include <linux/dmi.h>
 #include <asm/iosf_mbi.h>
diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 94b169a5493b..5218e40aeb1b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -207,25 +207,18 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	status = FIELD_GET(STATUS1_INT_STS, status);
 	axg_fifo_ack_irq(fifo, status);
 
-	/* Use the thread to call period elapsed on nonatomic links */
-	if (status & FIFO_INT_COUNT_REPEAT)
-		return IRQ_WAKE_THREAD;
+	if (status & ~FIFO_INT_COUNT_REPEAT)
+		dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
+			status);
 
-	dev_dbg(axg_fifo_dev(ss), "unexpected irq - STS 0x%02x\n",
-		status);
+	if (status & FIFO_INT_COUNT_REPEAT) {
+		snd_pcm_period_elapsed(ss);
+		return IRQ_HANDLED;
+	}
 
 	return IRQ_NONE;
 }
 
-static irqreturn_t axg_fifo_pcm_irq_block_thread(int irq, void *dev_id)
-{
-	struct snd_pcm_substream *ss = dev_id;
-
-	snd_pcm_period_elapsed(ss);
-
-	return IRQ_HANDLED;
-}
-
 int axg_fifo_pcm_open(struct snd_soc_component *component,
 		      struct snd_pcm_substream *ss)
 {
@@ -251,8 +244,9 @@ int axg_fifo_pcm_open(struct snd_soc_component *component,
 	if (ret)
 		return ret;
 
-	ret = request_threaded_irq(fifo->irq, axg_fifo_pcm_irq_block,
-				   axg_fifo_pcm_irq_block_thread,
+	/* Use the threaded irq handler only with non-atomic links */
+	ret = request_threaded_irq(fifo->irq, NULL,
+				   axg_fifo_pcm_irq_block,
 				   IRQF_ONESHOT, dev_name(dev), ss);
 	if (ret)
 		return ret;
diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
index 7c1384a869ca..44303b6eb228 100644
--- a/sound/soc/pxa/spitz.c
+++ b/sound/soc/pxa/spitz.c
@@ -14,13 +14,12 @@
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
 #include <asm/mach-types.h>
-#include <mach/spitz.h>
 #include "../codecs/wm8750.h"
 #include "pxa2xx-i2s.h"
 
@@ -37,7 +36,7 @@
 
 static int spitz_jack_func;
 static int spitz_spk_func;
-static int spitz_mic_gpio;
+static struct gpio_desc *gpiod_mic, *gpiod_mute_l, *gpiod_mute_r;
 
 static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 {
@@ -56,8 +55,8 @@ static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Mic Jack");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Line Jack");
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Headphone Jack");
-		gpio_set_value(SPITZ_GPIO_MUTE_L, 1);
-		gpio_set_value(SPITZ_GPIO_MUTE_R, 1);
+		gpiod_set_value(gpiod_mute_l, 1);
+		gpiod_set_value(gpiod_mute_r, 1);
 		break;
 	case SPITZ_MIC:
 		/* enable mic jack and bias, mute hp */
@@ -65,8 +64,8 @@ static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Headset Jack");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Line Jack");
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Mic Jack");
-		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
-		gpio_set_value(SPITZ_GPIO_MUTE_R, 0);
+		gpiod_set_value(gpiod_mute_l, 0);
+		gpiod_set_value(gpiod_mute_r, 0);
 		break;
 	case SPITZ_LINE:
 		/* enable line jack, disable mic bias and mute hp */
@@ -74,8 +73,8 @@ static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Headset Jack");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Mic Jack");
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Line Jack");
-		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
-		gpio_set_value(SPITZ_GPIO_MUTE_R, 0);
+		gpiod_set_value(gpiod_mute_l, 0);
+		gpiod_set_value(gpiod_mute_r, 0);
 		break;
 	case SPITZ_HEADSET:
 		/* enable and unmute headset jack enable mic bias, mute L hp */
@@ -83,8 +82,8 @@ static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Mic Jack");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Line Jack");
 		snd_soc_dapm_enable_pin_unlocked(dapm, "Headset Jack");
-		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
-		gpio_set_value(SPITZ_GPIO_MUTE_R, 1);
+		gpiod_set_value(gpiod_mute_l, 0);
+		gpiod_set_value(gpiod_mute_r, 1);
 		break;
 	case SPITZ_HP_OFF:
 
@@ -93,8 +92,8 @@ static void spitz_ext_control(struct snd_soc_dapm_context *dapm)
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Headset Jack");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Mic Jack");
 		snd_soc_dapm_disable_pin_unlocked(dapm, "Line Jack");
-		gpio_set_value(SPITZ_GPIO_MUTE_L, 0);
-		gpio_set_value(SPITZ_GPIO_MUTE_R, 0);
+		gpiod_set_value(gpiod_mute_l, 0);
+		gpiod_set_value(gpiod_mute_r, 0);
 		break;
 	}
 
@@ -199,7 +198,7 @@ static int spitz_set_spk(struct snd_kcontrol *kcontrol,
 static int spitz_mic_bias(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *k, int event)
 {
-	gpio_set_value_cansleep(spitz_mic_gpio, SND_SOC_DAPM_EVENT_ON(event));
+	gpiod_set_value_cansleep(gpiod_mic, SND_SOC_DAPM_EVENT_ON(event));
 	return 0;
 }
 
@@ -287,39 +286,28 @@ static int spitz_probe(struct platform_device *pdev)
 	struct snd_soc_card *card = &snd_soc_spitz;
 	int ret;
 
-	if (machine_is_akita())
-		spitz_mic_gpio = AKITA_GPIO_MIC_BIAS;
-	else
-		spitz_mic_gpio = SPITZ_GPIO_MIC_BIAS;
-
-	ret = gpio_request(spitz_mic_gpio, "MIC GPIO");
-	if (ret)
-		goto err1;
-
-	ret = gpio_direction_output(spitz_mic_gpio, 0);
-	if (ret)
-		goto err2;
+	gpiod_mic = devm_gpiod_get(&pdev->dev, "mic", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_mic))
+		return PTR_ERR(gpiod_mic);
+	gpiod_mute_l = devm_gpiod_get(&pdev->dev, "mute-l", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_mute_l))
+		return PTR_ERR(gpiod_mute_l);
+	gpiod_mute_r = devm_gpiod_get(&pdev->dev, "mute-r", GPIOD_OUT_LOW);
+	if (IS_ERR(gpiod_mute_r))
+		return PTR_ERR(gpiod_mute_r);
 
 	card->dev = &pdev->dev;
 
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "snd_soc_register_card() failed: %d\n",
 			ret);
-		goto err2;
-	}
-
-	return 0;
 
-err2:
-	gpio_free(spitz_mic_gpio);
-err1:
 	return ret;
 }
 
 static int spitz_remove(struct platform_device *pdev)
 {
-	gpio_free(spitz_mic_gpio);
 	return 0;
 }
 
diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index f4437015d43a..9df49a880b75 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -286,12 +286,14 @@ static void line6_data_received(struct urb *urb)
 {
 	struct usb_line6 *line6 = (struct usb_line6 *)urb->context;
 	struct midi_buffer *mb = &line6->line6midi->midibuf_in;
+	unsigned long flags;
 	int done;
 
 	if (urb->status == -ESHUTDOWN)
 		return;
 
 	if (line6->properties->capabilities & LINE6_CAP_CONTROL_MIDI) {
+		spin_lock_irqsave(&line6->line6midi->lock, flags);
 		done =
 			line6_midibuf_write(mb, urb->transfer_buffer, urb->actual_length);
 
@@ -300,12 +302,15 @@ static void line6_data_received(struct urb *urb)
 			dev_dbg(line6->ifcdev, "%d %d buffer overflow - message skipped\n",
 				done, urb->actual_length);
 		}
+		spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 
 		for (;;) {
+			spin_lock_irqsave(&line6->line6midi->lock, flags);
 			done =
 				line6_midibuf_read(mb, line6->buffer_message,
 						   LINE6_MIDI_MESSAGE_MAXLEN,
 						   LINE6_MIDIBUF_READ_RX);
+			spin_unlock_irqrestore(&line6->line6midi->lock, flags);
 
 			if (done <= 0)
 				break;
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index d818eee53c90..9906785a02e9 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1212,6 +1212,13 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 			cval->res = 16;
 		}
 		break;
+	case USB_ID(0x1bcf, 0x2281): /* HD Webcam */
+		if (!strcmp(kctl->id.name, "Mic Capture Volume")) {
+			usb_audio_info(chip,
+				"set resolution quirk: cval->res = 16\n");
+			cval->res = 16;
+		}
+		break;
 	}
 }
 
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 6d332c9eb444..b03d671f218d 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2594,6 +2594,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* Stanton ScratchAmp */
+{ USB_DEVICE(0x103d, 0x0100) },
+{ USB_DEVICE(0x103d, 0x0101) },
+
 /* Novation EMS devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 1226ce5d5a30..cf1ba2837d10 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1810,6 +1810,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
 	DEVICE_FLG(0x0b0e, 0x0349, /* Jabra 550a */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M),
+	DEVICE_FLG(0x0c45, 0x6340, /* Sonix HD USB Camera */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
@@ -1850,6 +1852,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x19f7, 0x0035, /* RODE NT-USB+ */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x1bcf, 0x2281, /* HD Webcam */
+		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x1bcf, 0x2283, /* NexiGo N930AF FHD Webcam */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x2040, 0x7200, /* Hauppauge HVR-950Q */
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index d5409f387945..e14c725acebf 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -244,8 +244,8 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
 		SNDRV_CHMAP_FR,		/* right front */
 		SNDRV_CHMAP_FC,		/* center front */
 		SNDRV_CHMAP_LFE,	/* LFE */
-		SNDRV_CHMAP_SL,		/* left surround */
-		SNDRV_CHMAP_SR,		/* right surround */
+		SNDRV_CHMAP_RL,		/* left surround */
+		SNDRV_CHMAP_RR,		/* right surround */
 		SNDRV_CHMAP_FLC,	/* left of center */
 		SNDRV_CHMAP_FRC,	/* right of center */
 		SNDRV_CHMAP_RC,		/* surround */
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index b91dd7cd4ffb..c2bf996fcba8 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1458,10 +1458,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 			 * Clang for BPF target generates func_proto with no
 			 * args as a func_proto with a single void arg (e.g.,
 			 * `int (*f)(void)` vs just `int (*f)()`). We are
-			 * going to pretend there are no args for such case.
+			 * going to emit valid empty args (void) syntax for
+			 * such case. Similarly and conveniently, valid
+			 * no args case can be special-cased here as well.
 			 */
-			if (vlen == 1 && p->type == 0) {
-				btf_dump_printf(d, ")");
+			if (vlen == 0 || (vlen == 1 && p->type == 0)) {
+				btf_dump_printf(d, "void)");
 				return;
 			}
 
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 6b2f59ddb691..bfe0c30841b9 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2193,10 +2193,17 @@ static int linker_fixup_btf(struct src_obj *obj)
 		vi = btf_var_secinfos(t);
 		for (j = 0, m = btf_vlen(t); j < m; j++, vi++) {
 			const struct btf_type *vt = btf__type_by_id(obj->btf, vi->type);
-			const char *var_name = btf__str_by_offset(obj->btf, vt->name_off);
-			int var_linkage = btf_var(vt)->linkage;
+			const char *var_name;
+			int var_linkage;
 			Elf64_Sym *sym;
 
+			/* could be a variable or function */
+			if (!btf_is_var(vt))
+				continue;
+
+			var_name = btf__str_by_offset(obj->btf, vt->name_off);
+			var_linkage = btf_var(vt)->linkage;
+
 			/* no need to patch up static or extern vars */
 			if (var_linkage != BTF_VAR_GLOBAL_ALLOCATED)
 				continue;
diff --git a/tools/memory-model/lock.cat b/tools/memory-model/lock.cat
index 6b52f365d73a..9f3b5b38221b 100644
--- a/tools/memory-model/lock.cat
+++ b/tools/memory-model/lock.cat
@@ -102,19 +102,19 @@ let rf-lf = rfe-lf | rfi-lf
  * within one of the lock's critical sections returns False.
  *)
 
-(* rfi for RU events: an RU may read from the last po-previous UL *)
-let rfi-ru = ([UL] ; po-loc ; [RU]) \ ([UL] ; po-loc ; [LKW] ; po-loc)
-
-(* rfe for RU events: an RU may read from an external UL or the initial write *)
-let all-possible-rfe-ru =
-	let possible-rfe-ru r =
+(*
+ * rf for RU events: an RU may read from an external UL or the initial write,
+ * or from the last po-previous UL
+ *)
+let all-possible-rf-ru =
+	let possible-rf-ru r =
 		let pair-to-relation p = p ++ 0
-		in map pair-to-relation (((UL | IW) * {r}) & loc & ext)
-	in map possible-rfe-ru RU
+		in map pair-to-relation ((((UL | IW) * {r}) & loc & ext) |
+			(((UL * {r}) & po-loc) \ ([UL] ; po-loc ; [LKW] ; po-loc)))
+	in map possible-rf-ru RU
 
 (* Generate all rf relations for RU events *)
-with rfe-ru from cross(all-possible-rfe-ru)
-let rf-ru = rfe-ru | rfi-ru
+with rf-ru from cross(all-possible-rf-ru)
 
 (* Final rf relation *)
 let rf = rf | rf-lf | rf-ru
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 6df0dc00d73a..7cb21803455a 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -31,6 +31,7 @@
 #include "../../../util/tsc.h"
 #include <internal/lib.h> // page_size
 #include "../../../util/intel-pt.h"
+#include <api/fs/fs.h>
 
 #define KiB(x) ((x) * 1024)
 #define MiB(x) ((x) * 1024 * 1024)
@@ -438,6 +439,16 @@ static int intel_pt_track_switches(struct evlist *evlist)
 	return 0;
 }
 
+static bool intel_pt_exclude_guest(void)
+{
+	int pt_mode;
+
+	if (sysfs__read_int("module/kvm_intel/parameters/pt_mode", &pt_mode))
+		pt_mode = 0;
+
+	return pt_mode == 1;
+}
+
 static void intel_pt_valid_str(char *str, size_t len, u64 valid)
 {
 	unsigned int val, last = 0, state = 1;
@@ -641,6 +652,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 			}
 			evsel->core.attr.freq = 0;
 			evsel->core.attr.sample_period = 1;
+			evsel->core.attr.exclude_guest = intel_pt_exclude_guest();
 			evsel->no_aux_samples = true;
 			intel_pt_evsel = evsel;
 			opts->full_auxtrace = true;
@@ -777,7 +789,8 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	}
 
 	if (!opts->auxtrace_snapshot_mode && !opts->auxtrace_sample_mode) {
-		u32 aux_watermark = opts->auxtrace_mmap_pages * page_size / 4;
+		size_t aw = opts->auxtrace_mmap_pages * (size_t)page_size / 4;
+		u32 aux_watermark = aw > UINT_MAX ? UINT_MAX : aw;
 
 		intel_pt_evsel->core.attr.aux_watermark = aux_watermark;
 	}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index a4f2ffe2bdb6..d5133786d3e1 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -275,7 +275,7 @@ sort__sym_cmp(struct hist_entry *left, struct hist_entry *right)
 	 * comparing symbol address alone is not enough since it's a
 	 * relative address within a dso.
 	 */
-	if (!hists__has(left->hists, dso) || hists__has(right->hists, dso)) {
+	if (!hists__has(left->hists, dso)) {
 		ret = sort__dso_cmp(left, right);
 		if (ret != 0)
 			return ret;
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 776916b61c40..7b1343f70e65 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -149,7 +149,8 @@ static void test_send_signal_tracepoint(bool signal_thread)
 static void test_send_signal_perf(bool signal_thread)
 {
 	struct perf_event_attr attr = {
-		.sample_period = 1,
+		.freq = 1,
+		.sample_freq = 1000,
 		.type = PERF_TYPE_SOFTWARE,
 		.config = PERF_COUNT_SW_CPU_CLOCK,
 	};
diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 6db07401bc49..651c23d6836b 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -964,7 +964,7 @@ static void drop_on_reuseport(const struct test *t)
 
 	err = update_lookup_map(t->sock_map, SERVER_A, server1);
 	if (err)
-		goto detach;
+		goto close_srv1;
 
 	/* second server on destination address we should never reach */
 	server2 = make_server(t->sotype, t->connect_to.ip, t->connect_to.port,
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c
index ba97165bdb28..a657651eba52 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_multidim.c
@@ -14,9 +14,9 @@ typedef int *ptr_arr_t[6];
 
 typedef int *ptr_multiarr_t[7][8][9][10];
 
-typedef int * (*fn_ptr_arr_t[11])();
+typedef int * (*fn_ptr_arr_t[11])(void);
 
-typedef int * (*fn_ptr_multiarr_t[12][13])();
+typedef int * (*fn_ptr_multiarr_t[12][13])(void);
 
 struct root_struct {
 	arr_t _1;
diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
index 970598dda732..7fda004c153a 100644
--- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
+++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_syntax.c
@@ -67,7 +67,7 @@ typedef void (*printf_fn_t)(const char *, ...);
  *   `int -> char *` function and returns pointer to a char. Equivalent:
  *   typedef char * (*fn_input_t)(int);
  *   typedef char * (*fn_output_outer_t)(fn_input_t);
- *   typedef const fn_output_outer_t (* fn_output_inner_t)();
+ *   typedef const fn_output_outer_t (* fn_output_inner_t)(void);
  *   typedef const fn_output_inner_t fn_ptr_arr2_t[5];
  */
 /* ----- START-EXPECTED-OUTPUT ----- */
@@ -94,7 +94,7 @@ typedef void (* (*signal_t)(int, void (*)(int)))(int);
 
 typedef char * (*fn_ptr_arr1_t[10])(int **);
 
-typedef char * (* (* const fn_ptr_arr2_t[5])())(char * (*)(int));
+typedef char * (* (* const fn_ptr_arr2_t[5])(void))(char * (*)(int));
 
 struct struct_w_typedefs {
 	int_t a;
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 7465cbe19bb0..230ca335a991 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -65,7 +65,7 @@ int passed;
 int failed;
 int map_fd[9];
 struct bpf_map *maps[9];
-int prog_fd[11];
+int prog_fd[9];
 
 int txmsg_pass;
 int txmsg_redir;
@@ -663,7 +663,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 				}
 			}
 
-			s->bytes_recvd += recv;
+			if (recv > 0)
+				s->bytes_recvd += recv;
 
 			if (data) {
 				int chunk_sz = opt->sendpage ?
@@ -1708,8 +1709,6 @@ int prog_attach_type[] = {
 	BPF_SK_MSG_VERDICT,
 	BPF_SK_MSG_VERDICT,
 	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
-	BPF_SK_MSG_VERDICT,
 };
 
 int prog_type[] = {
@@ -1722,8 +1721,6 @@ int prog_type[] = {
 	BPF_PROG_TYPE_SK_MSG,
 	BPF_PROG_TYPE_SK_MSG,
 	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
-	BPF_PROG_TYPE_SK_MSG,
 };
 
 static int populate_progs(char *bpf_file)
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
index 616d3581419c..21d0f419cc6d 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/tc_flower.sh
@@ -11,7 +11,7 @@ ALL_TESTS="single_mask_test identical_filters_test two_masks_test \
 	multiple_masks_test ctcam_edge_cases_test delta_simple_test \
 	delta_two_masks_one_key_test delta_simple_rehash_test \
 	bloom_simple_test bloom_complex_test bloom_delta_test \
-	max_erp_entries_test max_group_size_test"
+	max_erp_entries_test max_group_size_test collision_test"
 NUM_NETIFS=2
 source $lib_dir/lib.sh
 source $lib_dir/tc_common.sh
@@ -457,7 +457,7 @@ delta_two_masks_one_key_test()
 {
 	# If 2 keys are the same and only differ in mask in a way that
 	# they belong under the same ERP (second is delta of the first),
-	# there should be no C-TCAM spill.
+	# there should be C-TCAM spill.
 
 	RET=0
 
@@ -474,8 +474,8 @@ delta_two_masks_one_key_test()
 	tp_record "mlxsw:*" "tc filter add dev $h2 ingress protocol ip \
 		   pref 2 handle 102 flower $tcflags dst_ip 192.0.2.2 \
 		   action drop"
-	tp_check_hits "mlxsw:mlxsw_sp_acl_atcam_entry_add_ctcam_spill" 0
-	check_err $? "incorrect C-TCAM spill while inserting the second rule"
+	tp_check_hits "mlxsw:mlxsw_sp_acl_atcam_entry_add_ctcam_spill" 1
+	check_err $? "C-TCAM spill did not happen while inserting the second rule"
 
 	$MZ $h1 -c 1 -p 64 -a $h1mac -b $h2mac -A 192.0.2.1 -B 192.0.2.2 \
 		-t ip -q
@@ -1087,6 +1087,53 @@ max_group_size_test()
 	log_test "max ACL group size test ($tcflags). max size $max_size"
 }
 
+collision_test()
+{
+	# Filters cannot share an eRP if in the common unmasked part (i.e.,
+	# without the delta bits) they have the same values. If the driver does
+	# not prevent such configuration (by spilling into the C-TCAM), then
+	# multiple entries will be present in the device with the same key,
+	# leading to collisions and a reduced scale.
+	#
+	# Create such a scenario and make sure all the filters are successfully
+	# added.
+
+	RET=0
+
+	local ret
+
+	if [[ "$tcflags" != "skip_sw" ]]; then
+		return 0;
+	fi
+
+	# Add a single dst_ip/24 filter and multiple dst_ip/32 filters that all
+	# have the same values in the common unmasked part (dst_ip/24).
+
+	tc filter add dev $h2 ingress pref 1 proto ipv4 handle 101 \
+		flower $tcflags dst_ip 198.51.100.0/24 \
+		action drop
+
+	for i in {0..255}; do
+		tc filter add dev $h2 ingress pref 2 proto ipv4 \
+			handle $((102 + i)) \
+			flower $tcflags dst_ip 198.51.100.${i}/32 \
+			action drop
+		ret=$?
+		[[ $ret -ne 0 ]] && break
+	done
+
+	check_err $ret "failed to add all the filters"
+
+	for i in {255..0}; do
+		tc filter del dev $h2 ingress pref 2 proto ipv4 \
+			handle $((102 + i)) flower
+	done
+
+	tc filter del dev $h2 ingress pref 1 proto ipv4 handle 101 flower
+
+	log_test "collision test ($tcflags)"
+}
+
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 35f64832b869..1a8fa6b0c887 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -9,6 +9,7 @@
 #define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/keyctl.h>
 #include <linux/landlock.h>
 #include <string.h>
 #include <sys/prctl.h>
@@ -356,4 +357,77 @@ TEST(ruleset_fd_transfer)
 	ASSERT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
 }
 
+TEST(cred_transfer)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_DIR,
+	};
+	int ruleset_fd, dir_fd;
+	pid_t child;
+	int status;
+
+	drop_caps(_metadata);
+
+	dir_fd = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	EXPECT_LE(0, dir_fd);
+	EXPECT_EQ(0, close(dir_fd));
+
+	/* Denies opening directories. */
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	EXPECT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Checks ruleset enforcement. */
+	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+
+	/* Needed for KEYCTL_SESSION_TO_PARENT permission checks */
+	EXPECT_NE(-1, syscall(__NR_keyctl, KEYCTL_JOIN_SESSION_KEYRING, NULL, 0,
+			      0, 0))
+	{
+		TH_LOG("Failed to join session keyring: %s", strerror(errno));
+	}
+
+	child = fork();
+	ASSERT_LE(0, child);
+	if (child == 0) {
+		/* Checks ruleset enforcement. */
+		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		EXPECT_EQ(EACCES, errno);
+
+		/*
+		 * KEYCTL_SESSION_TO_PARENT is a no-op unless we have a
+		 * different session keyring in the child, so make that happen.
+		 */
+		EXPECT_NE(-1, syscall(__NR_keyctl, KEYCTL_JOIN_SESSION_KEYRING,
+				      NULL, 0, 0, 0));
+
+		/*
+		 * KEYCTL_SESSION_TO_PARENT installs credentials on the parent
+		 * that never go through the cred_prepare hook, this path uses
+		 * cred_transfer instead.
+		 */
+		EXPECT_EQ(0, syscall(__NR_keyctl, KEYCTL_SESSION_TO_PARENT, 0,
+				     0, 0, 0));
+
+		/* Re-checks ruleset enforcement. */
+		EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+		EXPECT_EQ(EACCES, errno);
+
+		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		return;
+	}
+
+	EXPECT_EQ(child, waitpid(child, &status, 0));
+	EXPECT_EQ(1, WIFEXITED(status));
+	EXPECT_EQ(EXIT_SUCCESS, WEXITSTATUS(status));
+
+	/* Re-checks ruleset enforcement. */
+	EXPECT_EQ(-1, open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	EXPECT_EQ(EACCES, errno);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/landlock/config b/tools/testing/selftests/landlock/config
index 0f0a65287bac..177f4878bdf3 100644
--- a/tools/testing/selftests/landlock/config
+++ b/tools/testing/selftests/landlock/config
@@ -1,7 +1,8 @@
+CONFIG_KEYS=y
 CONFIG_OVERLAY_FS=y
+CONFIG_SECURITY=y
 CONFIG_SECURITY_LANDLOCK=y
 CONFIG_SECURITY_PATH=y
-CONFIG_SECURITY=y
 CONFIG_SHMEM=y
-CONFIG_TMPFS_XATTR=y
 CONFIG_TMPFS=y
+CONFIG_TMPFS_XATTR=y
diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index 2c14a86adaaa..6bb0f929dad7 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -122,6 +122,8 @@ devlink_reload()
 	still_pending=$(devlink resource show "$DEVLINK_DEV" | \
 			grep -c "size_new")
 	check_err $still_pending "Failed reload - There are still unset sizes"
+
+	udevadm settle
 }
 
 declare -A DEVLINK_ORIG
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index e725285298a0..145749460bec 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -925,6 +925,8 @@ chk_prio_nr()
 {
 	local mp_prio_nr_tx=$1
 	local mp_prio_nr_rx=$2
+	local mpj_syn=$3
+	local mpj_syn_ack=$4
 	local count
 	local dump_stats
 
@@ -952,6 +954,30 @@ chk_prio_nr()
 		echo "[ ok ]"
 	fi
 
+	printf "%-39s %s" " " "bkp syn"
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynBackupRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mpj_syn" ]; then
+		echo "[fail] got $count JOIN[s] syn with Backup expected $mpj_syn"
+		ret=1
+		dump_stats=1
+	else
+		echo -n "[ ok ]"
+	fi
+
+	echo -n " - synack   "
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckBackupRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mpj_syn_ack" ]; then
+		echo "[fail] got $count JOIN[s] synack with Backup expected $mpj_syn_ack"
+		ret=1
+		dump_stats=1
+	else
+		echo "[ ok ]"
+	fi
+
 	if [ "${dump_stats}" = 1 ]; then
 		echo Server ns stats
 		ip netns exec $ns1 nstat -as | grep MPTcp
@@ -1557,17 +1583,26 @@ backup_tests()
 	ip netns exec $ns2 ./pm_nl_ctl add 10.0.3.2 flags subflow,backup
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
 	chk_join_nr "single subflow, backup" 1 1 1
-	chk_prio_nr 0 1
+	chk_prio_nr 0 1 1 0
 
 	# single address, backup
+	reset
+	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
+	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal,backup
+	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow nobackup
+	chk_join_nr "single address, backup" 1 1 1
+	chk_add_nr 1 1
+	chk_prio_nr 1 0 0 1
+
 	reset
 	ip netns exec $ns1 ./pm_nl_ctl limits 0 1
 	ip netns exec $ns1 ./pm_nl_ctl add 10.0.2.1 flags signal
 	ip netns exec $ns2 ./pm_nl_ctl limits 1 1
 	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
-	chk_join_nr "single address, backup" 1 1 1
+	chk_join_nr "single address, switch to backup" 1 1 1
 	chk_add_nr 1 1
-	chk_prio_nr 1 0
+	chk_prio_nr 1 0 0 0
 }
 
 add_addr_ports_tests()
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 66f0f724a1a6..d9513e50f24c 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -386,16 +386,16 @@ fi
 
 if test "$do_clocksourcewd" = "yes"
 then
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-1" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
-	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 clocksource.max_cswd_read_retries=1"
+	torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 	torture_set "clocksourcewd-2" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --kconfig "CONFIG_TEST_CLOCKSOURCE_WATCHDOG=y" --trust-make
 
 	# In case our work is already done...
 	if test "$do_rcutorture" != "yes"
 	then
-		torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000"
+		torture_bootargs="rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 tsc=watchdog"
 		torture_set "clocksourcewd-3" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 45s --configs TREE03 --trust-make
 	fi
 fi
diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
index ea9bdf3a90b1..09da8f1011ce 100644
--- a/tools/testing/selftests/sigaltstack/current_stack_pointer.h
+++ b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
@@ -8,7 +8,7 @@ register unsigned long sp asm("sp");
 register unsigned long sp asm("esp");
 #elif __loongarch64
 register unsigned long sp asm("$sp");
-#elif __ppc__
+#elif __powerpc__
 register unsigned long sp asm("r1");
 #elif __s390x__
 register unsigned long sp asm("%15");

