Return-Path: <stable+bounces-69440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2F4956268
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 06:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB42281448
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 04:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E9145A0F;
	Mon, 19 Aug 2024 04:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="elz0jLeb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A171459E0;
	Mon, 19 Aug 2024 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724040777; cv=none; b=BTHfT4QkbI+GsRJZdxpc+kp4vlKcj1YIDLfnl7slHkNHA9GYZgIjaf29OjU9FHrkf1KxUZ+Pj84QIXtJE5GvKZV+qMQeu/GWTCqFUtHuXRuRZ9FUh0iuL2zcYh7qSNSd1xwsDBlEgP4CWd5RgjEXbQjM4SKM4JERpWcSl/cL+Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724040777; c=relaxed/simple;
	bh=lGXp/idknoAR+t9oaoD9vRmD0E3SCJ1hEbguOKaTuL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bmvx+hjJzGUIc1R4FLa+i+LK3vxNEF3qhad2A5bHlR95HlxsDsQpZ96XTwzxMPKUBA0Mjh0+ChSuRnV9HmM3Vb6Ox4RvTdITWaIPeszpaURswZrJPDCFuG1fga0vxS4kYrCm/YtT8u6YQ0cUyt3gqbS9NoGB8uByQidj2ruoTBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=elz0jLeb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84BBC32782;
	Mon, 19 Aug 2024 04:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724040776;
	bh=lGXp/idknoAR+t9oaoD9vRmD0E3SCJ1hEbguOKaTuL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elz0jLebKX/iJeISCf+5YbUCh+BFWNI0EgcpC5aMunKd6Lc4RqkFFlsHw7aXUJB7Z
	 O8tIqb8PLKvrQ8BVVQ+P3Frly5N5pFrWzO5wECdJKSWl+1Fzc93Tn+iHAZm1kapIeg
	 Z2lwd+7Ab/Y/CdVm+s8eB2zyUAvPC9f4csvrXtuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.224
Date: Mon, 19 Aug 2024 06:12:43 +0200
Message-ID: <2024081943-grouped-cytoplasm-b68c@gregkh>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <2024081943-say-engaging-7543@gregkh>
References: <2024081943-say-engaging-7543@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 10a26d44ef4a..14eef7e93614 100644
--- a/Documentation/arm64/silicon-errata.rst
+++ b/Documentation/arm64/silicon-errata.rst
@@ -94,16 +94,52 @@ stable kernels.
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
 | ARM            | Cortex-A510     | #2457168        | ARM64_ERRATUM_2457168       |
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
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
index 1b3954aa71c1..af946e3da82a 100644
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
index 91c79c64f5a3..38351794f6c9 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 223
+SUBLEVEL = 224
 EXTRAVERSION =
 NAME = Dare mighty things
 
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
index 37d94aa45a8b..2d1cc67628b4 100644
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
 
 &i2c_intern {
@@ -448,6 +461,8 @@ MX6QDL_PAD_EIM_D22__ECSPI4_MISO 0x100b1
 			MX6QDL_PAD_EIM_D24__GPIO3_IO24 0x1b0b0
 			/* SPI_IMX_CS0# - connected to SMARC SPI0_CS0# */
 			MX6QDL_PAD_EIM_D29__GPIO3_IO29 0x1b0b0
+			/* SPI4_CS3# - connected to SMARC SPI0_CS1# */
+			MX6QDL_PAD_EIM_D25__GPIO3_IO25 0x1b0b0
 		>;
 	};
 
@@ -500,7 +515,7 @@ MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL 0x1b0b0
 			MX6QDL_PAD_ENET_MDIO__ENET_MDIO       0x1b0b0
 			MX6QDL_PAD_ENET_MDC__ENET_MDC         0x1b0b0
 			MX6QDL_PAD_ENET_REF_CLK__ENET_TX_CLK  0x1b0b0
-			MX6QDL_PAD_ENET_CRS_DV__GPIO1_IO25    0x1b0b0 /* RST_GBE0_PHY# */
+			MX6QDL_PAD_NANDF_D1__GPIO2_IO01       0x1b0b0 /* RST_GBE0_PHY# */
 		>;
 	};
 
@@ -713,7 +728,7 @@ &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
 	wake-up-gpio = <&gpio6 18 GPIO_ACTIVE_HIGH>;
-	reset-gpio = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+	reset-gpio = <&gpio3 13 GPIO_ACTIVE_LOW>;
 };
 
 /* LCD_BKLT_PWM */
@@ -801,5 +816,6 @@ &wdog1 {
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
index 13cf137da999..9fdf8b036428 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -691,6 +691,44 @@ config ARM64_ERRATUM_2457168
 
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
index 778174a7d649..46e412b436ed 100644
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
index 810575de6670..5dd993496a5c 100644
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
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index a4f860bb4a84..ad8b11267c7d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -628,7 +628,6 @@ pins_tx {
 		};
 		pins_rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
-			output-enable;
 		};
 		pins_cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
@@ -647,7 +646,6 @@ pins_tx {
 		};
 		pins_rts {
 			pinmux = <PINMUX_GPIO47__FUNC_URTS1>;
-			output-enable;
 		};
 		pins_cts {
 			pinmux = <PINMUX_GPIO46__FUNC_UCTS1>;
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index e990e727cc0f..118fd1e47d5c 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -927,7 +927,7 @@ ufshc: ufshc@624000 {
 				<&gcc GCC_UFS_RX_SYMBOL_0_CLK>;
 			freq-table-hz =
 				<100000000 200000000>,
-				<0 0>,
+				<100000000 200000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>,
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index b00f6d8bc8ba..da48ae60155a 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2125,6 +2125,8 @@ ufs_mem_phy: phy@1d87000 {
 			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
 				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
 
+			power-domains = <&gcc UFS_PHY_GDSC>;
+
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 10df6636a6b6..3c6398e98f76 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -811,8 +811,8 @@ cru: clock-controller@ff440000 {
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
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index d2080a41f6e6..931c88182fb8 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -69,7 +69,8 @@
 #define ARM64_SPECTRE_BHB			59
 #define ARM64_WORKAROUND_2457168		60
 #define ARM64_WORKAROUND_1742098		61
+#define ARM64_WORKAROUND_SPECULATIVE_SSBS	62
 
-#define ARM64_NCAPS				62
+#define ARM64_NCAPS				63
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index c2a1ccd5fd46..91890e9fcb6c 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -84,6 +84,14 @@
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
 
@@ -136,6 +144,14 @@
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
index 5d6f19bc628c..6e63dc8f0e8c 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -364,6 +364,30 @@ static struct midr_range broken_aarch32_aes[] = {
 };
 #endif
 
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
@@ -570,6 +594,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		CAP_MIDR_RANGE_LIST(broken_aarch32_aes),
 		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
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
index 1f0a2deafd64..2dc269b865de 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -399,6 +399,30 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
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
@@ -424,10 +448,10 @@ static const struct arm64_ftr_bits ftr_id_isar0[] = {
 
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
@@ -534,7 +558,7 @@ static const struct arm64_ftr_bits ftr_zcr[] = {
  * Common ftr bits for a 32bit register with all hidden, strict
  * attributes, with 4bit feature fields and a default safe value of
  * 0. Covers the following 32bit registers:
- * id_isar[1-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ * id_isar[1-3], id_mmfr[1-3]
  */
 static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
@@ -590,8 +614,8 @@ static const struct __ftr_reg_entry {
 	ARM64_FTR_REG(SYS_ID_ISAR6_EL1, ftr_id_isar6),
 
 	/* Op1 = 0, CRn = 0, CRm = 3 */
-	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_32bits),
-	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_generic_32bits),
+	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_mvfr0),
+	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_mvfr1),
 	ARM64_FTR_REG(SYS_MVFR2_EL1, ftr_mvfr2),
 	ARM64_FTR_REG(SYS_ID_PFR2_EL1, ftr_id_pfr2),
 	ARM64_FTR_REG(SYS_ID_DFR1_EL1, ftr_id_dfr1),
@@ -1196,20 +1220,42 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
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
 static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	bool has_sre;
@@ -1731,6 +1777,17 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
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
@@ -2172,7 +2229,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 };
 
 #define HWCAP_CPUID_MATCH(reg, field, s, min_value)				\
-		.matches = has_cpuid_feature,					\
+		.matches = has_user_cpuid_feature,				\
 		.sys_reg = reg,							\
 		.field_pos = field,						\
 		.sign = s,							\
@@ -2742,6 +2799,7 @@ void __init setup_cpu_features(void)
 	u32 cwg;
 
 	setup_system_capabilities();
+	user_feature_fixup();
 	setup_elf_hwcaps(arm64_elf_hwcaps);
 
 	if (system_supports_32bit_el0()) {
@@ -2780,7 +2838,7 @@ static void __maybe_unused cpu_enable_cnp(struct arm64_cpu_capabilities const *c
 
 /*
  * We emulate only the following system register space.
- * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 4 - 7]
+ * Op0 = 0x3, CRn = 0x0, Op1 = 0x0, CRm = [0, 2 - 7]
  * See Table C5-6 System instruction encodings for System register accesses,
  * ARMv8 ARM(ARM DDI 0487A.f) for more details.
  */
@@ -2790,7 +2848,7 @@ static inline bool __attribute_const__ is_emulated(u32 id)
 		sys_reg_CRn(id) == 0x0 &&
 		sys_reg_Op1(id) == 0x0 &&
 		(sys_reg_CRm(id) == 0 ||
-		 ((sys_reg_CRm(id) >= 4) && (sys_reg_CRm(id) <= 7))));
+		 ((sys_reg_CRm(id) >= 2) && (sys_reg_CRm(id) <= 7))));
 }
 
 /*
diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 9c0e9d9eed6e..90337910c3f5 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -574,6 +574,18 @@ static enum mitigation_state spectre_v4_enable_hw_mitigation(void)
 
 	/* SCTLR_EL1.DSSBS was initialised to 0 during boot */
 	asm volatile(SET_PSTATE_SSBS(0));
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
 
diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index bee9f240f35d..c92c1e559da0 100644
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
index 3a3bdcfcd375..2035b30d7951 100644
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
 
diff --git a/arch/mips/include/asm/mach-loongson64/boot_param.h b/arch/mips/include/asm/mach-loongson64/boot_param.h
index afc92b7a61c6..deafd177f095 100644
--- a/arch/mips/include/asm/mach-loongson64/boot_param.h
+++ b/arch/mips/include/asm/mach-loongson64/boot_param.h
@@ -38,12 +38,14 @@ enum loongson_cpu_type {
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
index f659adb681bc..02ae0b29e688 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -229,7 +229,10 @@ static void boot_core(unsigned int core, unsigned int vpe_id)
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
index 134cb8e9efc2..c9db6c496138 100644
--- a/arch/mips/loongson64/env.c
+++ b/arch/mips/loongson64/env.c
@@ -65,6 +65,12 @@ void __init prom_init_env(void)
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
@@ -213,6 +219,8 @@ void __init prom_init_env(void)
 		default:
 			break;
 		}
+	} else if ((read_c0_prid() & PRID_IMP_MASK) == PRID_IMP_LOONGSON_64R) {
+		loongson_fdt_blob = __dtb_loongson64_2core_2k1000_begin;
 	} else if ((read_c0_prid() & PRID_IMP_MASK) == PRID_IMP_LOONGSON_64G) {
 		if (loongson_sysconf.bridgetype == LS7A)
 			loongson_fdt_blob = __dtb_loongson64g_4core_ls7a_begin;
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
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 63702c0badb9..259343040e1b 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -594,8 +594,15 @@ long notrace machine_check_early(struct pt_regs *regs)
 	u8 ftrace_enabled = this_cpu_get_ftrace_enabled();
 
 	this_cpu_set_ftrace_enabled(0);
-	/* Do not use nmi_enter/exit for pseries hpte guest */
-	if (radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR))
+	/*
+	 * Do not use nmi_enter/exit for pseries hpte guest
+	 *
+	 * Likewise, do not use it in real mode if percpu first chunk is not
+	 * embedded. With CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled there
+	 * are chances where percpu allocation can come from vmalloc area.
+	 */
+	if ((radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR)) &&
+	    !percpu_first_chunk_is_paged)
 		nmi_enter();
 
 	hv_nmi_check_nonrecoverable(regs);
@@ -606,7 +613,8 @@ long notrace machine_check_early(struct pt_regs *regs)
 	if (ppc_md.machine_check_early)
 		handled = ppc_md.machine_check_early(regs);
 
-	if (radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR))
+	if ((radix_enabled() || !firmware_has_feature(FW_FEATURE_LPAR)) &&
+	    !percpu_first_chunk_is_paged)
 		nmi_exit();
 
 	this_cpu_set_ftrace_enabled(ftrace_enabled);
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3f8426bccd16..899d87de0165 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -824,6 +824,7 @@ static int pcpu_cpu_distance(unsigned int from, unsigned int to)
 
 unsigned long __per_cpu_offset[NR_CPUS] __read_mostly;
 EXPORT_SYMBOL(__per_cpu_offset);
+DEFINE_STATIC_KEY_FALSE(__percpu_first_chunk_is_paged);
 
 static void __init pcpu_populate_pte(unsigned long addr)
 {
@@ -903,6 +904,7 @@ void __init setup_per_cpu_areas(void)
 	if (rc < 0)
 		panic("cannot initialize percpu area (err=%d)", rc);
 
+	static_key_enable(&__percpu_first_chunk_is_paged.key);
 	delta = (unsigned long)pcpu_base_addr - (unsigned long)__per_cpu_start;
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b0e87dce2b9a..b4d108bef814 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -835,8 +835,14 @@ void machine_check_exception(struct pt_regs *regs)
 	 * This is silly. The BOOK3S_64 should just call a different function
 	 * rather than expecting semantics to magically change. Something
 	 * like 'non_nmi_machine_check_exception()', perhaps?
+	 *
+	 * Do not use nmi_enter/exit in real mode if percpu first chunk is
+	 * not embedded. With CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK enabled
+	 * there are chances where percpu allocation can come from
+	 * vmalloc area.
 	 */
-	const bool nmi = !IS_ENABLED(CONFIG_PPC_BOOK3S_64);
+	const bool nmi = !IS_ENABLED(CONFIG_PPC_BOOK3S_64) &&
+			 !percpu_first_chunk_is_paged;
 
 	if (nmi) nmi_enter();
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ef8077a739b8..0f5ebec660a7 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1956,8 +1956,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
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
index 54b12943cc7b..9bed32089197 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -39,26 +39,27 @@ static inline void no_context(struct pt_regs *regs, unsigned long addr)
 
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
index 8dafc3f2add4..9a0fcafafd00 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -756,9 +756,9 @@ int setup_time_travel_start(char *str)
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
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 5667b8b994e3..da7e8c2b5347 100644
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
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 5f436cb4f7c4..9d5313118660 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -817,7 +817,7 @@ void mtrr_save_state(void)
 {
 	int first_cpu;
 
-	if (!mtrr_enabled())
+	if (!mtrr_enabled() || !mtrr_state.have_fixed)
 		return;
 
 	first_cpu = cpumask_first(cpu_online_mask);
diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index ddffd80f5c52..2d654fdf001d 100644
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
index 3e9bb9ae836d..b29be51b72b4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4738,14 +4738,19 @@ static int vmx_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
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
index ed4b6da83aa8..811d7ef4638b 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -359,6 +359,7 @@ bool vmx_guest_inject_ac(struct kvm_vcpu *vcpu);
 void update_exception_bitmap(struct kvm_vcpu *vcpu);
 void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
 bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);
+bool __vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
 bool vmx_interrupt_blocked(struct kvm_vcpu *vcpu);
 bool vmx_get_nmi_mask(struct kvm_vcpu *vcpu);
 void vmx_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked);
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1aab92930569..50e31d14351b 100644
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
@@ -497,7 +497,7 @@ static void pti_clone_entry_text(void)
 {
 	pti_clone_pgtable((unsigned long) __entry_text_start,
 			  (unsigned long) __entry_text_end,
-			  PTI_CLONE_PMD);
+			  PTI_LEVEL_KERNEL_IMAGE);
 }
 
 /*
diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 24ca4ee2802f..3399dcdd526c 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -223,9 +223,9 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		return 0;
 
 	ret = pci_read_config_byte(dev, PCI_INTERRUPT_LINE, &gsi);
-	if (ret < 0) {
+	if (ret) {
 		dev_warn(&dev->dev, "Failed to read interrupt line: %d\n", ret);
-		return ret;
+		return pcibios_err_to_errno(ret);
 	}
 
 	switch (intel_mid_identify_cpu()) {
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 326d6d173733..cbe9ab42cbeb 100644
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
index 526f70f27c1c..70a1c3877f8e 100644
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
index e809f1446846..bfa972f7e874 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -736,7 +736,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 		 * immediate unmapping.
 		 */
 		map_ops[i].status = GNTST_general_error;
-		unmap[0].host_addr = map_ops[i].host_addr,
+		unmap[0].host_addr = map_ops[i].host_addr;
 		unmap[0].handle = map_ops[i].handle;
 		map_ops[i].handle = ~0;
 		if (map_ops[i].flags & GNTMAP_device_map)
@@ -746,7 +746,7 @@ int set_foreign_p2m_mapping(struct gnttab_map_grant_ref *map_ops,
 
 		if (kmap_ops) {
 			kmap_ops[i].status = GNTST_general_error;
-			unmap[1].host_addr = kmap_ops[i].host_addr,
+			unmap[1].host_addr = kmap_ops[i].host_addr;
 			unmap[1].handle = kmap_ops[i].handle;
 			kmap_ops[i].handle = ~0;
 			if (kmap_ops[i].flags & GNTMAP_device_map)
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8b43efe97da5..2e1462b8929c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -670,12 +670,18 @@ static ssize_t acpi_battery_alarm_store(struct device *dev,
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
@@ -812,7 +818,10 @@ static void __exit battery_hook_exit(void)
 
 static int sysfs_add_battery(struct acpi_battery *battery)
 {
-	struct power_supply_config psy_cfg = { .drv_data = battery, };
+	struct power_supply_config psy_cfg = {
+		.drv_data = battery,
+		.attr_grp = acpi_battery_groups,
+	};
 	bool full_cap_broken = false;
 
 	if (!ACPI_BATTERY_CAPACITY_VALID(battery->full_charge_capacity) &&
@@ -857,7 +866,7 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 		return result;
 	}
 	battery_hook_add_battery(battery);
-	return device_create_file(&battery->bat->dev, &alarm_attr);
+	return 0;
 }
 
 static void sysfs_remove_battery(struct acpi_battery *battery)
@@ -868,7 +877,6 @@ static void sysfs_remove_battery(struct acpi_battery *battery)
 		return;
 	}
 	battery_hook_remove_battery(battery);
-	device_remove_file(&battery->bat->dev, &alarm_attr);
 	power_supply_unregister(battery->bat);
 	battery->bat = NULL;
 	mutex_unlock(&battery->sysfs_lock);
diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index e6d9f4de2800..54396cb8930a 100644
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
 	printk(KERN_INFO PREFIX "%s [%s]: Battery Slot [%s] (battery %s)\n",
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
index 6631a65f632b..cd3de4ec1767 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -928,9 +928,7 @@ static bool binder_has_work(struct binder_thread *thread, bool do_proc_work)
 static bool binder_available_for_proc_work_ilocked(struct binder_thread *thread)
 {
 	return !thread->transaction_stack &&
-		binder_worklist_empty_ilocked(&thread->todo) &&
-		(thread->looper & (BINDER_LOOPER_STATE_ENTERED |
-				   BINDER_LOOPER_STATE_REGISTERED));
+		binder_worklist_empty_ilocked(&thread->todo);
 }
 
 static void binder_wakeup_poll_threads_ilocked(struct binder_proc *proc,
diff --git a/drivers/base/core.c b/drivers/base/core.c
index b13a60de5a86..b81fd39226ca 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -25,6 +25,7 @@
 #include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
+#include <linux/rcupdate.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/sysfs.h>
@@ -1909,6 +1910,7 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
 		      struct kobj_uevent_env *env)
 {
 	struct device *dev = kobj_to_dev(kobj);
+	struct device_driver *driver;
 	int retval = 0;
 
 	/* add device node properties if present */
@@ -1937,8 +1939,12 @@ static int dev_uevent(struct kset *kset, struct kobject *kobj,
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
@@ -2008,11 +2014,8 @@ static ssize_t uevent_show(struct device *dev, struct device_attribute *attr,
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
index 586e9a75c840..8a74008c13c4 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -901,9 +901,12 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
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
 
@@ -1227,7 +1230,11 @@ EXPORT_SYMBOL_GPL(__devm_alloc_percpu);
  */
 void devm_free_percpu(struct device *dev, void __percpu *pdata)
 {
-	WARN_ON(devres_destroy(dev, devm_percpu_release, devm_percpu_match,
-			       (void *)pdata));
+	/*
+	 * Use devres_release() to prevent memory leakage as
+	 * devm_free_pages() does.
+	 */
+	WARN_ON(devres_release(dev, devm_percpu_release, devm_percpu_match,
+			       (__force void *)pdata));
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
index 5b102d333a41..0ceef7bcfe8e 100644
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
@@ -3522,13 +3522,14 @@ static void rbd_lock_del_request(struct rbd_img_request *img_req)
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
@@ -3541,11 +3542,6 @@ static int rbd_img_exclusive_lock(struct rbd_img_request *img_req)
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
@@ -4237,16 +4233,16 @@ static bool rbd_quiesce_lock(struct rbd_device *rbd_dev)
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
@@ -4657,6 +4653,10 @@ static void rbd_reacquire_lock(struct rbd_device *rbd_dev)
 			rbd_warn(rbd_dev, "failed to update lock cookie: %d",
 				 ret);
 
+		if (rbd_dev->opts->exclusive)
+			rbd_warn(rbd_dev,
+			     "temporarily releasing lock on exclusive mapping");
+
 		/*
 		 * Lock cookie cannot be updated on older OSDs, so do
 		 * a manual release and queue an acquire.
@@ -5455,7 +5455,7 @@ static struct rbd_device *__rbd_dev_create(struct rbd_spec *spec)
 	INIT_LIST_HEAD(&rbd_dev->acquiring_list);
 	INIT_LIST_HEAD(&rbd_dev->running_list);
 	init_completion(&rbd_dev->acquire_wait);
-	init_completion(&rbd_dev->releasing_wait);
+	init_completion(&rbd_dev->quiescing_wait);
 
 	spin_lock_init(&rbd_dev->object_map_lock);
 
@@ -6660,11 +6660,6 @@ static int rbd_add_acquire_lock(struct rbd_device *rbd_dev)
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
index b2836e8efefd..b0d97c9ffd26 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -428,6 +428,10 @@ static const struct usb_device_id blacklist_table[] = {
 						     BTUSB_WIDEBAND_SPEECH },
 	{ USB_DEVICE(0x13d3, 0x3571), .driver_info = BTUSB_REALTEK |
 						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x13d3, 0x3591), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
+	{ USB_DEVICE(0x0489, 0xe125), .driver_info = BTUSB_REALTEK |
+						     BTUSB_WIDEBAND_SPEECH },
 
 	/* Realtek Bluetooth devices */
 	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
diff --git a/drivers/char/hw_random/amd-rng.c b/drivers/char/hw_random/amd-rng.c
index db3dd467194c..3f3fdf6ee3d5 100644
--- a/drivers/char/hw_random/amd-rng.c
+++ b/drivers/char/hw_random/amd-rng.c
@@ -142,8 +142,10 @@ static int __init mod_init(void)
 
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
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 66e4872ab34f..26dbf01d2ec5 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -530,6 +530,7 @@ static void sh_cmt_set_next(struct sh_cmt_channel *ch, unsigned long delta)
 static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 {
 	struct sh_cmt_channel *ch = dev_id;
+	unsigned long flags;
 
 	/* clear flags */
 	sh_cmt_write_cmcsr(ch, sh_cmt_read_cmcsr(ch) &
@@ -560,6 +561,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_SKIPEVENT;
 
+	raw_spin_lock_irqsave(&ch->lock, flags);
+
 	if (ch->flags & FLAG_REPROGRAM) {
 		ch->flags &= ~FLAG_REPROGRAM;
 		sh_cmt_clock_event_program_verify(ch, 1);
@@ -572,6 +575,8 @@ static irqreturn_t sh_cmt_interrupt(int irq, void *dev_id)
 
 	ch->flags &= ~FLAG_IRQCONTEXT;
 
+	raw_spin_unlock_irqrestore(&ch->lock, flags);
+
 	return IRQ_HANDLED;
 }
 
@@ -770,12 +775,18 @@ static int sh_cmt_clock_event_next(unsigned long delta,
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
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 3a849168780d..eec69c885c1d 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -58,11 +58,13 @@ obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac_mod.o
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
 
 obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
diff --git a/drivers/edac/skx_common.c b/drivers/edac/skx_common.c
index 2b4ce8e5ac2f..b585cbe3eff9 100644
--- a/drivers/edac/skx_common.c
+++ b/drivers/edac/skx_common.c
@@ -23,10 +23,13 @@
 #include "skx_common.h"
 
 static const char * const component_names[] = {
-	[INDEX_SOCKET]	= "ProcessorSocketId",
-	[INDEX_MEMCTRL]	= "MemoryControllerId",
-	[INDEX_CHANNEL]	= "ChannelId",
-	[INDEX_DIMM]	= "DimmSlotId",
+	[INDEX_SOCKET]		= "ProcessorSocketId",
+	[INDEX_MEMCTRL]		= "MemoryControllerId",
+	[INDEX_CHANNEL]		= "ChannelId",
+	[INDEX_DIMM]		= "DimmSlotId",
+	[INDEX_NM_MEMCTRL]	= "NmMemoryControllerId",
+	[INDEX_NM_CHANNEL]	= "NmChannelId",
+	[INDEX_NM_DIMM]		= "NmDimmSlotId",
 };
 
 static int component_indices[ARRAY_SIZE(component_names)];
@@ -34,14 +37,16 @@ static int adxl_component_count;
 static const char * const *adxl_component_names;
 static u64 *adxl_values;
 static char *adxl_msg;
+static unsigned long adxl_nm_bitmap;
 
 static char skx_msg[MSG_SIZE];
 static skx_decode_f skx_decode;
 static skx_show_retry_log_f skx_show_retry_rd_err_log;
 static u64 skx_tolm, skx_tohm;
 static LIST_HEAD(dev_edac_list);
+static bool skx_mem_cfg_2lm;
 
-int __init skx_adxl_get(void)
+int skx_adxl_get(void)
 {
 	const char * const *names;
 	int i, j;
@@ -56,14 +61,25 @@ int __init skx_adxl_get(void)
 		for (j = 0; names[j]; j++) {
 			if (!strcmp(component_names[i], names[j])) {
 				component_indices[i] = j;
+
+				if (i >= INDEX_NM_FIRST)
+					adxl_nm_bitmap |= 1 << i;
+
 				break;
 			}
 		}
 
-		if (!names[j])
+		if (!names[j] && i < INDEX_NM_FIRST)
 			goto err;
 	}
 
+	if (skx_mem_cfg_2lm) {
+		if (!adxl_nm_bitmap)
+			skx_printk(KERN_NOTICE, "Not enough ADXL components for 2-level memory.\n");
+		else
+			edac_dbg(2, "adxl_nm_bitmap: 0x%lx\n", adxl_nm_bitmap);
+	}
+
 	adxl_component_names = names;
 	while (*names++)
 		adxl_component_count++;
@@ -92,14 +108,16 @@ int __init skx_adxl_get(void)
 
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
 
-static bool skx_adxl_decode(struct decoded_addr *res)
+static bool skx_adxl_decode(struct decoded_addr *res, bool error_in_1st_level_mem)
 {
 	struct skx_dev *d;
 	int i, len = 0;
@@ -116,11 +134,20 @@ static bool skx_adxl_decode(struct decoded_addr *res)
 	}
 
 	res->socket  = (int)adxl_values[component_indices[INDEX_SOCKET]];
-	res->imc     = (int)adxl_values[component_indices[INDEX_MEMCTRL]];
-	res->channel = (int)adxl_values[component_indices[INDEX_CHANNEL]];
-	res->dimm    = (int)adxl_values[component_indices[INDEX_DIMM]];
+	if (error_in_1st_level_mem) {
+		res->imc     = (adxl_nm_bitmap & BIT_NM_MEMCTRL) ?
+			       (int)adxl_values[component_indices[INDEX_NM_MEMCTRL]] : -1;
+		res->channel = (adxl_nm_bitmap & BIT_NM_CHANNEL) ?
+			       (int)adxl_values[component_indices[INDEX_NM_CHANNEL]] : -1;
+		res->dimm    = (adxl_nm_bitmap & BIT_NM_DIMM) ?
+			       (int)adxl_values[component_indices[INDEX_NM_DIMM]] : -1;
+	} else {
+		res->imc     = (int)adxl_values[component_indices[INDEX_MEMCTRL]];
+		res->channel = (int)adxl_values[component_indices[INDEX_CHANNEL]];
+		res->dimm    = (int)adxl_values[component_indices[INDEX_DIMM]];
+	}
 
-	if (res->imc > NUM_IMC - 1) {
+	if (res->imc > NUM_IMC - 1 || res->imc < 0) {
 		skx_printk(KERN_ERR, "Bad imc %d\n", res->imc);
 		return false;
 	}
@@ -151,11 +178,18 @@ static bool skx_adxl_decode(struct decoded_addr *res)
 	return true;
 }
 
+void skx_set_mem_cfg(bool mem_cfg_2lm)
+{
+	skx_mem_cfg_2lm = mem_cfg_2lm;
+}
+EXPORT_SYMBOL_GPL(skx_set_mem_cfg);
+
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log)
 {
 	skx_decode = decode;
 	skx_show_retry_rd_err_log = show_retry_log;
 }
+EXPORT_SYMBOL_GPL(skx_set_decode);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
 {
@@ -169,6 +203,7 @@ int skx_get_src_id(struct skx_dev *d, int off, u8 *id)
 	*id = GET_BITFIELD(reg, 12, 14);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(skx_get_src_id);
 
 int skx_get_node_id(struct skx_dev *d, u8 *id)
 {
@@ -182,6 +217,7 @@ int skx_get_node_id(struct skx_dev *d, u8 *id)
 	*id = GET_BITFIELD(reg, 0, 2);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(skx_get_node_id);
 
 static int get_width(u32 mtr)
 {
@@ -247,6 +283,7 @@ int skx_get_all_bus_mappings(struct res_config *cfg, struct list_head **list)
 		*list = &dev_edac_list;
 	return ndev;
 }
+EXPORT_SYMBOL_GPL(skx_get_all_bus_mappings);
 
 int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 {
@@ -286,6 +323,7 @@ int skx_get_hi_lo(unsigned int did, int off[], u64 *tolm, u64 *tohm)
 	pci_dev_put(pdev);
 	return -ENODEV;
 }
+EXPORT_SYMBOL_GPL(skx_get_hi_lo);
 
 static int skx_get_dimm_attr(u32 reg, int lobit, int hibit, int add,
 			     int minval, int maxval, const char *name)
@@ -339,6 +377,7 @@ int skx_get_dimm_info(u32 mtr, u32 mcmtr, u32 amap, struct dimm_info *dimm,
 
 	return 1;
 }
+EXPORT_SYMBOL_GPL(skx_get_dimm_info);
 
 int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 			int chan, int dimmno, const char *mod_str)
@@ -387,6 +426,7 @@ int skx_get_nvdimm_info(struct dimm_info *dimm, struct skx_imc *imc,
 
 	return (size == 0 || size == ~0ull) ? 0 : 1;
 }
+EXPORT_SYMBOL_GPL(skx_get_nvdimm_info);
 
 int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 		     const char *ctl_name, const char *mod_str,
@@ -454,6 +494,7 @@ int skx_register_mci(struct skx_imc *imc, struct pci_dev *pdev,
 	imc->mci = NULL;
 	return rc;
 }
+EXPORT_SYMBOL_GPL(skx_register_mci);
 
 static void skx_unregister_mci(struct skx_imc *imc)
 {
@@ -565,6 +606,21 @@ static void skx_mce_output_error(struct mem_ctl_info *mci,
 			     optype, skx_msg);
 }
 
+static bool skx_error_in_1st_level_mem(const struct mce *m)
+{
+	u32 errcode;
+
+	if (!skx_mem_cfg_2lm)
+		return false;
+
+	errcode = GET_BITFIELD(m->status, 0, 15);
+
+	if ((errcode & 0xef80) != 0x280)
+		return false;
+
+	return true;
+}
+
 int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 			void *data)
 {
@@ -584,7 +640,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	res.addr = mce->addr;
 
 	if (adxl_component_count) {
-		if (!skx_adxl_decode(&res))
+		if (!skx_adxl_decode(&res, skx_error_in_1st_level_mem(mce)))
 			return NOTIFY_DONE;
 	} else if (!skx_decode || !skx_decode(&res)) {
 		return NOTIFY_DONE;
@@ -618,6 +674,7 @@ int skx_mce_check_error(struct notifier_block *nb, unsigned long val,
 	mce->kflags |= MCE_HANDLED_EDAC;
 	return NOTIFY_DONE;
 }
+EXPORT_SYMBOL_GPL(skx_mce_check_error);
 
 void skx_remove(void)
 {
@@ -653,3 +710,8 @@ void skx_remove(void)
 		kfree(d);
 	}
 }
+EXPORT_SYMBOL_GPL(skx_remove);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Tony Luck");
+MODULE_DESCRIPTION("MC Driver for Intel server processors");
diff --git a/drivers/edac/skx_common.h b/drivers/edac/skx_common.h
index 78f8c1de0b71..b93c33ac8e60 100644
--- a/drivers/edac/skx_common.h
+++ b/drivers/edac/skx_common.h
@@ -9,6 +9,8 @@
 #ifndef _SKX_COMM_EDAC_H
 #define _SKX_COMM_EDAC_H
 
+#include <linux/bits.h>
+
 #define MSG_SIZE		1024
 
 /*
@@ -90,9 +92,17 @@ enum {
 	INDEX_MEMCTRL,
 	INDEX_CHANNEL,
 	INDEX_DIMM,
+	INDEX_NM_FIRST,
+	INDEX_NM_MEMCTRL = INDEX_NM_FIRST,
+	INDEX_NM_CHANNEL,
+	INDEX_NM_DIMM,
 	INDEX_MAX
 };
 
+#define BIT_NM_MEMCTRL	BIT_ULL(INDEX_NM_MEMCTRL)
+#define BIT_NM_CHANNEL	BIT_ULL(INDEX_NM_CHANNEL)
+#define BIT_NM_DIMM	BIT_ULL(INDEX_NM_DIMM)
+
 struct decoded_addr {
 	struct skx_dev *dev;
 	u64	addr;
@@ -124,9 +134,10 @@ typedef int (*get_dimm_config_f)(struct mem_ctl_info *mci);
 typedef bool (*skx_decode_f)(struct decoded_addr *res);
 typedef void (*skx_show_retry_log_f)(struct decoded_addr *res, char *msg, int len);
 
-int __init skx_adxl_get(void);
-void __exit skx_adxl_put(void);
+int skx_adxl_get(void);
+void skx_adxl_put(void);
 void skx_set_decode(skx_decode_f decode, skx_show_retry_log_f show_retry_log);
+void skx_set_mem_cfg(bool mem_cfg_2lm);
 
 int skx_get_src_id(struct skx_dev *d, int off, u8 *id);
 int skx_get_node_id(struct skx_dev *d, u8 *id);
diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index 0bef988580ad..dcb717254c79 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -199,9 +199,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (!wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2))
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
 	if (ret == -ENODATA) {
@@ -235,9 +234,8 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (!wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2))
+		return -ETIMEDOUT;
 
 	ret = mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
 	if (ret == -ENODATA) {
@@ -274,9 +272,8 @@ static int check_get_random_support(struct mox_rwtm *rwtm)
 	if (ret < 0)
 		return ret;
 
-	ret = wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
-	if (ret < 0)
-		return ret;
+	if (!wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2))
+		return -ETIMEDOUT;
 
 	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
 }
@@ -499,6 +496,7 @@ static int turris_mox_rwtm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, rwtm);
 
 	mutex_init(&rwtm->busy);
+	init_completion(&rwtm->cmd_done);
 
 	rwtm->mbox_client.dev = dev;
 	rwtm->mbox_client.rx_callback = mox_rwtm_rx_callback;
@@ -512,8 +510,6 @@ static int turris_mox_rwtm_probe(struct platform_device *pdev)
 		goto remove_files;
 	}
 
-	init_completion(&rwtm->cmd_done);
-
 	ret = mox_get_board_info(rwtm);
 	if (ret < 0)
 		dev_warn(dev, "Cannot read board information: %i\n", ret);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e971d2b9e3c0..56f10679a26d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1351,12 +1351,15 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
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
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 3d7d27435f15..98391ba103d6 100644
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
index 7931528bc864..5e72b7555eda 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -2983,8 +2983,7 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct smu7_power_state *smu7_ps =
-				cast_phw_smu7_power_state(&request_ps->hardware);
+	struct smu7_power_state *smu7_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -2998,6 +2997,10 @@ static int smu7_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	int32_t count;
 	int32_t stable_pstate_sclk = 0, stable_pstate_mclk = 0;
 
+	smu7_ps = cast_phw_smu7_power_state(&request_ps->hardware);
+	if (!smu7_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 35ed47ebaf09..35d0ff57a596 100644
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
index 4dc27ec4d012..10678b519995 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -3232,8 +3232,7 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 			const struct pp_power_state *current_ps)
 {
 	struct amdgpu_device *adev = hwmgr->adev;
-	struct vega10_power_state *vega10_ps =
-				cast_phw_vega10_power_state(&request_ps->hardware);
+	struct vega10_power_state *vega10_ps;
 	uint32_t sclk;
 	uint32_t mclk;
 	struct PP_Clocks minimum_clocks = {0};
@@ -3251,6 +3250,10 @@ static int vega10_apply_state_adjust_rules(struct pp_hwmgr *hwmgr,
 	uint32_t stable_pstate_sclk = 0, stable_pstate_mclk = 0;
 	uint32_t latency;
 
+	vega10_ps = cast_phw_vega10_power_state(&request_ps->hardware);
+	if (!vega10_ps)
+		return -EINVAL;
+
 	data->battery_state = (PP_StateUILabel_Battery ==
 			request_ps->classification.ui_label);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
index cab3f5c4e2fc..37c62794e213 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
@@ -1115,7 +1115,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 	u32 status_reg;
 	u8 *buffer = msg->buffer;
 	unsigned int i;
-	int num_transferred = 0;
 	int ret;
 
 	/* Buffer size of AUX CH is 16 bytes */
@@ -1167,7 +1166,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			reg = buffer[i];
 			writel(reg, dp->reg_base + ANALOGIX_DP_BUF_DATA_0 +
 			       4 * i);
-			num_transferred++;
 		}
 	}
 
@@ -1215,7 +1213,6 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 			reg = readl(dp->reg_base + ANALOGIX_DP_BUF_DATA_0 +
 				    4 * i);
 			buffer[i] = (unsigned char)reg;
-			num_transferred++;
 		}
 	}
 
@@ -1232,7 +1229,7 @@ ssize_t analogix_dp_transfer(struct analogix_dp_device *dp,
 		 (msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_READ)
 		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
 
-	return num_transferred > 0 ? num_transferred : -EBUSY;
+	return msg->size;
 
 aux_error:
 	/* if aux err happen, reset aux */
diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 7872a04e9a72..3884fab01110 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -866,6 +866,11 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 
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
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
index 424474041c94..aa372982335e 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
@@ -364,9 +364,11 @@ static void *etnaviv_gem_vmap_impl(struct etnaviv_gem_object *obj)
 
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
index eaaf4efec217..b13c34fa29ed 100644
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
index 063c66bb946d..889964efe62d 100644
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
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 01a88b03bc6d..0021b039b72b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -273,6 +273,41 @@ static vm_fault_t vm_fault_cpu(struct vm_fault *vmf)
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
@@ -285,14 +320,18 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
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
 
@@ -363,12 +402,14 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
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
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_i2c.c b/drivers/gpu/drm/mgag200/mgag200_i2c.c
index 09731e614e46..40cda2468332 100644
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
index f08bda533bd9..65874a48dc80 100644
--- a/drivers/gpu/drm/nouveau/nouveau_prime.c
+++ b/drivers/gpu/drm/nouveau/nouveau_prime.c
@@ -81,7 +81,8 @@ struct drm_gem_object *nouveau_gem_prime_import_sg_table(struct drm_device *dev,
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
index 4af25c0b6570..ba098b4dee2e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -681,3 +681,4 @@ module_platform_driver(panfrost_driver);
 MODULE_AUTHOR("Panfrost Project Developers");
 MODULE_DESCRIPTION("Panfrost DRM Driver");
 MODULE_LICENSE("GPL v2");
+MODULE_SOFTDEP("pre: governor_simpleondemand");
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index f22a1b776f4b..3ffa721d777b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -232,6 +232,9 @@ static int qxl_add_mode(struct drm_connector *connector,
 		return 0;
 
 	mode = drm_cvt_mode(dev, width, height, 60, false, false, false);
+	if (!mode)
+		return 0;
+
 	if (preferred)
 		mode->type |= DRM_MODE_TYPE_PREFERRED;
 	mode->hdisplay = width;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index cd7ed1650d60..7aa1d9218ea6 100644
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
index c454768ffb49..f6ee287a892c 100644
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
index fc3241101178..7508d67c3dfb 100644
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
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 94c3bad72cc5..3848fe0449a4 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2106,6 +2106,9 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	unsigned long flags;
 	int ret;
 
+	if (!rdma_is_port_valid(ib_dev, port))
+		return -EINVAL;
+
 	/*
 	 * Drivers wish to call this before ib_register_driver, so we have to
 	 * setup the port data early.
@@ -2114,9 +2117,6 @@ int ib_device_set_netdev(struct ib_device *ib_dev, struct net_device *ndev,
 	if (ret)
 		return ret;
 
-	if (!rdma_is_port_valid(ib_dev, port))
-		return -EINVAL;
-
 	pdata = &ib_dev->port_data[port];
 	spin_lock_irqsave(&pdata->netdev_lock, flags);
 	old_ndev = rcu_dereference_protected(
diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 75b6da00065a..7a6747850aea 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -370,8 +370,10 @@ EXPORT_SYMBOL(iw_cm_disconnect);
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
@@ -441,7 +443,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		iwpm_remove_mapping(&cm_id->local_addr, RDMA_NL_IWCM);
 	}
 
-	(void)iwcm_deref_id(cm_id_priv);
+	return iwcm_deref_id(cm_id_priv);
 }
 
 /*
@@ -452,7 +454,8 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
  */
 void iw_destroy_cm_id(struct iw_cm_id *cm_id)
 {
-	destroy_cm_id(cm_id);
+	if (!destroy_cm_id(cm_id))
+		flush_workqueue(iwcm_wq);
 }
 EXPORT_SYMBOL(iw_destroy_cm_id);
 
@@ -1036,7 +1039,7 @@ static void cm_work_handler(struct work_struct *_work)
 		if (!test_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags)) {
 			ret = process_event(cm_id_priv, &levent);
 			if (ret)
-				destroy_cm_id(&cm_id_priv->id);
+				WARN_ON_ONCE(destroy_cm_id(&cm_id_priv->id));
 		} else
 			pr_debug("dropping event %d\n", levent.event);
 		if (iwcm_deref_id(cm_id_priv))
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index a0d7777acb6d..f16e0b2c7895 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2357,7 +2357,7 @@ static int bnxt_re_build_send_wqe(struct bnxt_re_qp *qp,
 		break;
 	case IB_WR_SEND_WITH_IMM:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_IMM;
-		wqe->send.imm_data = wr->ex.imm_data;
+		wqe->send.imm_data = be32_to_cpu(wr->ex.imm_data);
 		break;
 	case IB_WR_SEND_WITH_INV:
 		wqe->type = BNXT_QPLIB_SWQE_TYPE_SEND_WITH_INV;
@@ -2387,7 +2387,7 @@ static int bnxt_re_build_rdma_wqe(const struct ib_send_wr *wr,
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
@@ -3474,7 +3474,7 @@ int bnxt_re_poll_cq(struct ib_cq *ib_cq, int num_entries, struct ib_wc *wc)
 				continue;
 			}
 			wc->qp = &qp->ib_qp;
-			wc->ex.imm_data = cqe->immdata;
+			wc->ex.imm_data = cpu_to_be32(le32_to_cpu(cqe->immdata));
 			wc->src_qp = cqe->src_qp;
 			memcpy(wc->smac, cqe->smac, ETH_ALEN);
 			wc->port_num = 1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 667f93d90045..f112f013df7d 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -162,7 +162,7 @@ struct bnxt_qplib_swqe {
 		/* Send, with imm, inval key */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
 				u32	inv_key;
 			};
 			u32		q_key;
@@ -180,7 +180,7 @@ struct bnxt_qplib_swqe {
 		/* RDMA write, with imm, read */
 		struct {
 			union {
-				__be32	imm_data;
+				u32	imm_data;
 				u32	inv_key;
 			};
 			u64		remote_va;
@@ -372,7 +372,7 @@ struct bnxt_qplib_cqe {
 	u16				cfa_meta;
 	u64				wr_id;
 	union {
-		__be32			immdata;
+		__le32			immdata;
 		u32			invrkey;
 	};
 	u64				qp_handle;
diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
index fe54e09eeccd..72a41f34ecfd 100644
--- a/drivers/infiniband/hw/hns/hns_roce_device.h
+++ b/drivers/infiniband/hw/hns/hns_roce_device.h
@@ -98,6 +98,7 @@
 #define MR_TYPE_DMA				0x03
 
 #define HNS_ROCE_FRMR_MAX_PA			512
+#define HNS_ROCE_FRMR_ALIGN_SIZE		128
 
 #define PKEY_ID					0xffff
 #define GUID_LEN				8
@@ -267,6 +268,9 @@ enum {
 #define HNS_HW_PAGE_SHIFT			12
 #define HNS_HW_PAGE_SIZE			(1 << HNS_HW_PAGE_SHIFT)
 
+#define HNS_HW_MAX_PAGE_SHIFT			27
+#define HNS_HW_MAX_PAGE_SIZE			(1 << HNS_HW_MAX_PAGE_SHIFT)
+
 struct hns_roce_uar {
 	u64		pfn;
 	unsigned long	index;
diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
index c038ed7d9496..7e93c9b4a33f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_mr.c
+++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
@@ -486,6 +486,11 @@ int hns_roce_map_mr_sg(struct ib_mr *ibmr, struct scatterlist *sg, int sg_nents,
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
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index cca414ecfcd5..05420e189ca9 100644
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
index 8bd16474708f..44ea25e82549 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -2155,7 +2155,7 @@ static int mlx4_ib_alloc_demux_ctx(struct mlx4_ib_dev *dev,
 				       struct mlx4_ib_demux_ctx *ctx,
 				       int port)
 {
-	char name[12];
+	char name[21];
 	int ret = 0;
 	int i;
 
diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 69238f856c67..a034aa8fc5ca 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -362,7 +362,7 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
 	int			solicited;
 	u16			pkey;
 	u32			qp_num;
-	int			ack_req;
+	int			ack_req = 0;
 
 	/* length from start of bth to end of icrc */
 	paylen = rxe_opcode[opcode].length + payload + pad + RXE_ICRC_SIZE;
@@ -396,8 +396,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
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
index 6f59c8b245f2..14c2c66414f4 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1340,6 +1340,8 @@ static int __maybe_unused elan_suspend(struct device *dev)
 	}
 
 err:
+	if (ret)
+		enable_irq(client->irq);
 	mutex_unlock(&data->sysfs_mutex);
 	return ret;
 }
diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
index 1edf7692a790..4bdcefa44f11 100644
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
@@ -151,6 +169,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
+	data->dev = &pdev->dev;
 	data->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(data->regs)) {
 		dev_err(&pdev->dev, "failed to initialize reg\n");
@@ -178,7 +197,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 	data->irq_count = DIV_ROUND_UP(irqs_num, 64);
 	data->reg_num = irqs_num / 32;
 
-	if (IS_ENABLED(CONFIG_PM_SLEEP)) {
+	if (IS_ENABLED(CONFIG_PM)) {
 		data->saved_reg = devm_kzalloc(&pdev->dev,
 					sizeof(u32) * data->reg_num,
 					GFP_KERNEL);
@@ -202,6 +221,7 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto out;
 	}
+	irq_domain_set_pm_device(data->domain, &pdev->dev);
 
 	if (!data->irq_count || data->irq_count > CHAN_MAX_OUTPUT_INT) {
 		ret = -EINVAL;
@@ -222,6 +242,9 @@ static int imx_irqsteer_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	return 0;
 out:
 	clk_disable_unprepare(data->ipg_clk);
@@ -244,7 +267,7 @@ static int imx_irqsteer_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM
 static void imx_irqsteer_save_regs(struct irqsteer_data *data)
 {
 	int i;
@@ -291,7 +314,10 @@ static int imx_irqsteer_resume(struct device *dev)
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
index ff7627b57772..192950e9909b 100644
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
index 8cd1bfc73057..b48c3fb4b35e 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -201,7 +201,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		irqc->intr_mask = 0;
 	}
 
-	if (irqc->intr_mask >> irqc->nr_irq)
+	if ((u64)irqc->intr_mask >> irqc->nr_irq)
 		pr_warn("irq-xilinx: mismatch in kind-of-intr param\n");
 
 	pr_info("irq-xilinx: %pOF: num_irq=%d, edge=0x%x\n",
diff --git a/drivers/isdn/hardware/mISDN/hfcmulti.c b/drivers/isdn/hardware/mISDN/hfcmulti.c
index 4c5b6772562d..a0697d64aab3 100644
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
index fcb9eee3b609..e28a4bb71603 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -236,7 +236,6 @@ struct led_classdev *of_led_get(struct device_node *np, int index)
 
 	led_dev = class_find_device_by_of_node(leds_class, led_node);
 	of_node_put(led_node);
-	put_device(led_dev);
 
 	if (!led_dev)
 		return ERR_PTR(-EPROBE_DEFER);
diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 4e7b78a84149..cbe70f38cb57 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -177,9 +177,9 @@ int led_trigger_set(struct led_classdev *led_cdev, struct led_trigger *trig)
 			flags);
 		cancel_work_sync(&led_cdev->set_brightness_work);
 		led_stop_software_blink(led_cdev);
+		device_remove_groups(led_cdev->dev, led_cdev->trigger->groups);
 		if (led_cdev->trigger->deactivate)
 			led_cdev->trigger->deactivate(led_cdev);
-		device_remove_groups(led_cdev->dev, led_cdev->trigger->groups);
 		led_cdev->trigger = NULL;
 		led_cdev->trigger_data = NULL;
 		led_cdev->activated = false;
diff --git a/drivers/leds/leds-ss4200.c b/drivers/leds/leds-ss4200.c
index 245de443fe9c..833bb721a8e0 100644
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
index 67ceab4573be..f1f029243e0c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -524,7 +524,6 @@ void mddev_suspend(struct mddev *mddev)
 	clear_bit_unlock(MD_ALLOW_SB_UPDATE, &mddev->flags);
 	wait_event(mddev->sb_wait, !test_bit(MD_UPDATING_SB, &mddev->flags));
 
-	del_timer_sync(&mddev->safemode_timer);
 	/* restrict memory reclaim I/O during raid array is suspend */
 	mddev->noio_flag = memalloc_noio_save();
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 66167c4c7bc9..7cdc6f20f504 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -6005,7 +6005,9 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
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
@@ -6023,14 +6025,18 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
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
index c437a929a545..d91030a134c0 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1142,7 +1142,7 @@ static int vdec_stop_output(struct venus_inst *inst)
 		break;
 	case VENUS_DEC_STATE_INIT:
 	case VENUS_DEC_STATE_CAPTURE_SETUP:
-		ret = hfi_session_flush(inst, HFI_FLUSH_INPUT, true);
+		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
 		break;
 	default:
 		break;
@@ -1587,6 +1587,7 @@ static int vdec_close(struct file *file)
 
 	vdec_pm_get(inst);
 
+	cancel_work_sync(&inst->delayed_process_work);
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	vdec_ctrl_deinit(inst);
diff --git a/drivers/media/platform/vsp1/vsp1_histo.c b/drivers/media/platform/vsp1/vsp1_histo.c
index a91e142bcb94..37df7d2d4639 100644
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
index 253a1d1a840a..cd4995e74b97 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1153,10 +1153,7 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 
 	memcpy(ictx->usb_tx_buf, &ir_proto_packet, sizeof(ir_proto_packet));
 
-	if (!mutex_is_locked(&ictx->lock)) {
-		unlock = true;
-		mutex_lock(&ictx->lock);
-	}
+	unlock = mutex_trylock(&ictx->lock);
 
 	retval = send_packet(ictx);
 	if (retval)
diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
index 14243ce03b46..c59601487334 100644
--- a/drivers/media/rc/lirc_dev.c
+++ b/drivers/media/rc/lirc_dev.c
@@ -840,8 +840,10 @@ struct rc_dev *rc_dev_get_from_fd(int fd, bool write)
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
index 5e0acabed37a..dc8d790eb911 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -992,26 +992,56 @@ static s32 __uvc_ctrl_get_value(struct uvc_control_mapping *mapping,
 	return value;
 }
 
-static int __uvc_ctrl_get(struct uvc_video_chain *chain,
-	struct uvc_control *ctrl, struct uvc_control_mapping *mapping,
-	s32 *value)
+static int __uvc_ctrl_load_cur(struct uvc_video_chain *chain,
+			       struct uvc_control *ctrl)
 {
+	u8 *data;
 	int ret;
 
-	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0)
-		return -EACCES;
+	if (ctrl->loaded)
+		return 0;
 
-	if (!ctrl->loaded) {
-		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR, ctrl->entity->id,
-				chain->dev->intfnum, ctrl->info.selector,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				ctrl->info.size);
-		if (ret < 0)
-			return ret;
+	data = uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT);
 
+	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0) {
+		memset(data, 0, ctrl->info.size);
 		ctrl->loaded = 1;
+
+		return 0;
 	}
 
+	if (ctrl->entity->get_cur)
+		ret = ctrl->entity->get_cur(chain->dev, ctrl->entity,
+					    ctrl->info.selector, data,
+					    ctrl->info.size);
+	else
+		ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
+				     ctrl->entity->id, chain->dev->intfnum,
+				     ctrl->info.selector, data,
+				     ctrl->info.size);
+
+	if (ret < 0)
+		return ret;
+
+	ctrl->loaded = 1;
+
+	return ret;
+}
+
+static int __uvc_ctrl_get(struct uvc_video_chain *chain,
+			  struct uvc_control *ctrl,
+			  struct uvc_control_mapping *mapping,
+			  s32 *value)
+{
+	int ret;
+
+	if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0)
+		return -EACCES;
+
+	ret = __uvc_ctrl_load_cur(chain, ctrl);
+	if (ret < 0)
+		return ret;
+
 	*value = __uvc_ctrl_get_value(mapping,
 				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT));
 
@@ -1665,21 +1695,10 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	 * needs to be loaded from the device to perform the read-modify-write
 	 * operation.
 	 */
-	if (!ctrl->loaded && (ctrl->info.size * 8) != mapping->size) {
-		if ((ctrl->info.flags & UVC_CTRL_FLAG_GET_CUR) == 0) {
-			memset(uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				0, ctrl->info.size);
-		} else {
-			ret = uvc_query_ctrl(chain->dev, UVC_GET_CUR,
-				ctrl->entity->id, chain->dev->intfnum,
-				ctrl->info.selector,
-				uvc_ctrl_data(ctrl, UVC_CTRL_DATA_CURRENT),
-				ctrl->info.size);
-			if (ret < 0)
-				return ret;
-		}
-
-		ctrl->loaded = 1;
+	if ((ctrl->info.size * 8) != mapping->size) {
+		ret = __uvc_ctrl_load_cur(chain, ctrl);
+		if (ret < 0)
+			return ret;
 	}
 
 	/* Backup the current value in case we need to rollback later. */
@@ -1718,9 +1737,19 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 	if (data == NULL)
 		return -ENOMEM;
 
-	ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id, dev->intfnum,
-			     info->selector, data, 1);
-	if (!ret)
+	if (ctrl->entity->get_info)
+		ret = ctrl->entity->get_info(dev, ctrl->entity,
+					     ctrl->info.selector, data);
+	else
+		ret = uvc_query_ctrl(dev, UVC_GET_INFO, ctrl->entity->id,
+				     dev->intfnum, info->selector, data, 1);
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
@@ -1729,6 +1758,7 @@ static int uvc_ctrl_get_flags(struct uvc_device *dev,
 				UVC_CTRL_FLAG_AUTO_UPDATE : 0)
 			    |  (data[0] & UVC_CONTROL_CAP_ASYNCHRONOUS ?
 				UVC_CTRL_FLAG_ASYNCHRONOUS : 0);
+	}
 
 	kfree(data);
 	return ret;
diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 03dfe96bceba..288f097e2e6f 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -207,13 +207,13 @@ static void uvc_fixup_video_ctrl(struct uvc_streaming *stream,
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
 
@@ -468,6 +468,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;
+	u32 dev_stc;
 
 	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
 	case UVC_STREAM_PTS | UVC_STREAM_SCR:
@@ -512,6 +513,34 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
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
@@ -549,7 +578,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	spin_lock_irqsave(&stream->clock.lock, flags);
 
 	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample->dev_stc = dev_stc;
 	sample->dev_sof = dev_sof;
 	sample->host_sof = host_sof;
 	sample->host_time = time;
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index c75990c0957e..c3241cf5f7b4 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -354,6 +354,11 @@ struct uvc_entity {
 	u8 bNrInPins;
 	u8 *baSourceID;
 
+	int (*get_info)(struct uvc_device *dev, struct uvc_entity *entity,
+			u8 cs, u8 *caps);
+	int (*get_cur)(struct uvc_device *dev, struct uvc_entity *entity,
+		       u8 cs, void *data, u16 size);
+
 	unsigned int ncontrols;
 	struct uvc_control *controls;
 };
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 16fad79c73f1..99ca0dfa127b 100644
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
index b4cdf2351cac..d33deb84b6ec 100644
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
index 50fabba04248..c07b9bac1a6a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1052,13 +1052,10 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
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
index d3b37cebcfde..2bf07a398054 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2180,6 +2180,9 @@ static int b53_change_mtu(struct dsa_switch *ds, int port, int mtu)
 	if (is5325(dev) || is5365(dev))
 		return -EOPNOTSUPP;
 
+	if (!dsa_is_cpu_port(ds, port))
+		return 0;
+
 	enable_jumbo = (mtu >= JMS_MIN_SIZE);
 	allow_10_100 = (dev->chip_id == BCM583XX_DEVICE_ID);
 
diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index a5849663f65c..d0f94a5fae5a 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -558,8 +558,10 @@ static int bcm_sf2_mdio_register(struct dsa_switch *ds)
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
index 6a1ae774cfe9..c7f93329ae75 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2774,7 +2774,8 @@ static int mv88e6xxx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
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
index 7e4e831d720f..9ccfb038ffc7 100644
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
index adb76db66031..a591ca0b3778 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -220,8 +220,8 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
 #define PKT_MINBUF_SIZE		64
 
 /* FEC receive acceleration */
-#define FEC_RACC_IPDIS		(1 << 1)
-#define FEC_RACC_PRODIS		(1 << 2)
+#define FEC_RACC_IPDIS		BIT(1)
+#define FEC_RACC_PRODIS		BIT(2)
 #define FEC_RACC_SHIFT16	BIT(7)
 #define FEC_RACC_OPTIONS	(FEC_RACC_IPDIS | FEC_RACC_PRODIS)
 
@@ -253,8 +253,23 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC address");
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
 
@@ -949,7 +964,7 @@ fec_restart(struct net_device *ndev)
 	u32 val;
 	u32 temp_mac[2];
 	u32 rcntl = OPT_FRAME_SIZE | 0x04;
-	u32 ecntl = 0x2; /* ETHEREN */
+	u32 ecntl = FEC_ECR_ETHEREN;
 
 	/* Whack a reset.  We should wait for this.
 	 * For i.MX6SX SOC, enet use AXI bus, we use disable MAC
@@ -1025,18 +1040,18 @@ fec_restart(struct net_device *ndev)
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
@@ -1095,13 +1110,13 @@ fec_restart(struct net_device *ndev)
 
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
 
 #ifndef CONFIG_M5272
 	/* Enable the MIB statistic event counters */
@@ -1148,7 +1163,7 @@ static void
 fec_stop(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & (1 << 8);
+	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
 	u32 val;
 
 	/* We cannot expect a graceful transmit stop without link !!! */
@@ -1167,7 +1182,7 @@ fec_stop(struct net_device *ndev)
 		if (fep->quirks & FEC_QUIRK_HAS_AVB) {
 			writel(0, fep->hwp + FEC_ECNTRL);
 		} else {
-			writel(1, fep->hwp + FEC_ECNTRL);
+			writel(FEC_ECR_RESET, fep->hwp + FEC_ECNTRL);
 			udelay(10);
 		}
 		writel(FEC_DEFAULT_IMASK, fep->hwp + FEC_IMASK);
@@ -1183,11 +1198,16 @@ fec_stop(struct net_device *ndev)
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index d3817dd07e3d..1fdb42899a9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1155,7 +1155,12 @@ int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
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
diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 0157bcd2efff..198022bc1f94 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -2762,25 +2762,6 @@ static int qed_configure_filter_mcast(struct qed_dev *cdev,
 	return qed_filter_mcast_cmd(cdev, &mcast, QED_SPQ_MODE_CB, NULL);
 }
 
-static int qed_configure_filter(struct qed_dev *cdev,
-				struct qed_filter_params *params)
-{
-	enum qed_filter_rx_mode_type accept_flags;
-
-	switch (params->type) {
-	case QED_FILTER_TYPE_UCAST:
-		return qed_configure_filter_ucast(cdev, &params->filter.ucast);
-	case QED_FILTER_TYPE_MCAST:
-		return qed_configure_filter_mcast(cdev, &params->filter.mcast);
-	case QED_FILTER_TYPE_RX_MODE:
-		accept_flags = params->filter.accept_flags;
-		return qed_configure_filter_rx_mode(cdev, accept_flags);
-	default:
-		DP_NOTICE(cdev, "Unknown filter type %d\n", (int)params->type);
-		return -EINVAL;
-	}
-}
-
 static int qed_configure_arfs_searcher(struct qed_dev *cdev,
 				       enum qed_filter_config_mode mode)
 {
@@ -2903,7 +2884,9 @@ static const struct qed_eth_ops qed_eth_ops_pass = {
 	.q_rx_stop = &qed_stop_rxq,
 	.q_tx_start = &qed_start_txq,
 	.q_tx_stop = &qed_stop_txq,
-	.filter_config = &qed_configure_filter,
+	.filter_config_rx_mode = &qed_configure_filter_rx_mode,
+	.filter_config_ucast = &qed_configure_filter_ucast,
+	.filter_config_mcast = &qed_configure_filter_mcast,
 	.fastpath_stop = &qed_fastpath_stop,
 	.eth_cqe_completion = &qed_fp_cqe_completion,
 	.get_vport_stats = &qed_get_vport_stats,
diff --git a/drivers/net/ethernet/qlogic/qede/qede_filter.c b/drivers/net/ethernet/qlogic/qede/qede_filter.c
index 5f4962d90022..f4385466418c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_filter.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_filter.c
@@ -619,30 +619,28 @@ static int qede_set_ucast_rx_mac(struct qede_dev *edev,
 				 enum qed_filter_xcast_params_type opcode,
 				 unsigned char mac[ETH_ALEN])
 {
-	struct qed_filter_params filter_cmd;
+	struct qed_filter_ucast_params ucast;
 
-	memset(&filter_cmd, 0, sizeof(filter_cmd));
-	filter_cmd.type = QED_FILTER_TYPE_UCAST;
-	filter_cmd.filter.ucast.type = opcode;
-	filter_cmd.filter.ucast.mac_valid = 1;
-	ether_addr_copy(filter_cmd.filter.ucast.mac, mac);
+	memset(&ucast, 0, sizeof(ucast));
+	ucast.type = opcode;
+	ucast.mac_valid = 1;
+	ether_addr_copy(ucast.mac, mac);
 
-	return edev->ops->filter_config(edev->cdev, &filter_cmd);
+	return edev->ops->filter_config_ucast(edev->cdev, &ucast);
 }
 
 static int qede_set_ucast_rx_vlan(struct qede_dev *edev,
 				  enum qed_filter_xcast_params_type opcode,
 				  u16 vid)
 {
-	struct qed_filter_params filter_cmd;
+	struct qed_filter_ucast_params ucast;
 
-	memset(&filter_cmd, 0, sizeof(filter_cmd));
-	filter_cmd.type = QED_FILTER_TYPE_UCAST;
-	filter_cmd.filter.ucast.type = opcode;
-	filter_cmd.filter.ucast.vlan_valid = 1;
-	filter_cmd.filter.ucast.vlan = vid;
+	memset(&ucast, 0, sizeof(ucast));
+	ucast.type = opcode;
+	ucast.vlan_valid = 1;
+	ucast.vlan = vid;
 
-	return edev->ops->filter_config(edev->cdev, &filter_cmd);
+	return edev->ops->filter_config_ucast(edev->cdev, &ucast);
 }
 
 static int qede_config_accept_any_vlan(struct qede_dev *edev, bool action)
@@ -1057,18 +1055,17 @@ static int qede_set_mcast_rx_mac(struct qede_dev *edev,
 				 enum qed_filter_xcast_params_type opcode,
 				 unsigned char *mac, int num_macs)
 {
-	struct qed_filter_params filter_cmd;
+	struct qed_filter_mcast_params mcast;
 	int i;
 
-	memset(&filter_cmd, 0, sizeof(filter_cmd));
-	filter_cmd.type = QED_FILTER_TYPE_MCAST;
-	filter_cmd.filter.mcast.type = opcode;
-	filter_cmd.filter.mcast.num = num_macs;
+	memset(&mcast, 0, sizeof(mcast));
+	mcast.type = opcode;
+	mcast.num = num_macs;
 
 	for (i = 0; i < num_macs; i++, mac += ETH_ALEN)
-		ether_addr_copy(filter_cmd.filter.mcast.mac[i], mac);
+		ether_addr_copy(mcast.mac[i], mac);
 
-	return edev->ops->filter_config(edev->cdev, &filter_cmd);
+	return edev->ops->filter_config_mcast(edev->cdev, &mcast);
 }
 
 int qede_set_mac_addr(struct net_device *ndev, void *p)
@@ -1194,7 +1191,6 @@ void qede_config_rx_mode(struct net_device *ndev)
 {
 	enum qed_filter_rx_mode_type accept_flags;
 	struct qede_dev *edev = netdev_priv(ndev);
-	struct qed_filter_params rx_mode;
 	unsigned char *uc_macs, *temp;
 	struct netdev_hw_addr *ha;
 	int rc, uc_count;
@@ -1220,10 +1216,6 @@ void qede_config_rx_mode(struct net_device *ndev)
 
 	netif_addr_unlock_bh(ndev);
 
-	/* Configure the struct for the Rx mode */
-	memset(&rx_mode, 0, sizeof(struct qed_filter_params));
-	rx_mode.type = QED_FILTER_TYPE_RX_MODE;
-
 	/* Remove all previous unicast secondary macs and multicast macs
 	 * (configure / leave the primary mac)
 	 */
@@ -1271,8 +1263,7 @@ void qede_config_rx_mode(struct net_device *ndev)
 		qede_config_accept_any_vlan(edev, false);
 	}
 
-	rx_mode.filter.accept_flags = accept_flags;
-	edev->ops->filter_config(edev->cdev, &rx_mode);
+	edev->ops->filter_config_rx_mode(edev->cdev, accept_flags);
 out:
 	kfree(uc_macs);
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d24eb5ee152a..4c588fc43eb9 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -4288,7 +4288,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 	if (unlikely(!rtl_tx_slots_avail(tp))) {
 		if (net_ratelimit())
 			netdev_err(dev, "BUG! Tx Ring full when queue awake!\n");
-		goto err_stop_0;
+		netif_stop_queue(dev);
+		return NETDEV_TX_BUSY;
 	}
 
 	opts[1] = rtl8169_tx_vlan_tag(skb);
@@ -4361,11 +4362,6 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
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
index 5c6073d95f02..c315e0605baa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -938,7 +938,7 @@ static void dwmac4_set_mac_loopback(void __iomem *ioaddr, bool enable)
 }
 
 static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				    __le16 perfect_match, bool is_double)
+				    u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 86f70ea9a520..357762ce23ff 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -581,7 +581,7 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
 }
 
 static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      __le16 perfect_match, bool is_double)
+				      u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 8b7ec2457eba..d7ea2fd944ee 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -368,7 +368,7 @@ struct stmmac_ops {
 			     struct stmmac_rss *cfg, u32 num_rxq);
 	/* VLAN */
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 __le16 perfect_match, bool is_double);
+				 u16 perfect_match, bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
 	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 8416a186cd7f..b8581a711514 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4660,7 +4660,7 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 {
 	u32 crc, hash = 0;
-	__le16 pmatch = 0;
+	u16 pmatch = 0;
 	int count = 0;
 	u16 vid = 0;
 
@@ -4675,7 +4675,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		if (count > 2) /* VID = 0 always passes filter */
 			return -EOPNOTSUPP;
 
-		pmatch = cpu_to_le16(vid);
+		pmatch = vid;
 		hash = 0;
 	}
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 92001f7af380..924370e53003 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -715,6 +715,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				/* rtnl_lock already held
 				 * we might sleep in __netpoll_cleanup()
 				 */
+				nt->enabled = false;
 				spin_unlock_irqrestore(&target_list_lock, flags);
 
 				__netpoll_cleanup(&nt->np);
@@ -722,7 +723,6 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				spin_lock_irqsave(&target_list_lock, flags);
 				dev_put(nt->np.dev);
 				nt->np.dev = NULL;
-				nt->enabled = false;
 				stopped = true;
 				netconsole_target_put(nt);
 				goto restart;
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index d2a8238e144a..47cc54a64b56 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -216,6 +216,7 @@ static int qmimux_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 			break;
 		default:
 			/* not ip - do not know what to do */
+			kfree_skb(skbn);
 			goto skip;
 		}
 
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 3fac642bec77..8d2e3daf03cf 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -178,6 +178,7 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
 	struct usbnet *dev = netdev_priv(netdev);
 	__le16 res;
 	int rc = 0;
+	int err;
 
 	if (phy_id) {
 		netdev_dbg(netdev, "Only internal phy supported\n");
@@ -188,11 +189,17 @@ static int sr_mdio_read(struct net_device *netdev, int phy_id, int loc)
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
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index c4972233149f..89dc3ab2e2fb 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -40,6 +40,7 @@ struct dp_rx_tid {
 
 #define DP_REO_DESC_FREE_THRESHOLD  64
 #define DP_REO_DESC_FREE_TIMEOUT_MS 1000
+#define DP_MON_PURGE_TIMEOUT_MS     100
 #define DP_MON_SERVICE_BUDGET       128
 
 struct dp_reo_cache_flush_elem {
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index a50325f4634b..6c4b84282e44 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -274,6 +274,28 @@ static void ath11k_dp_service_mon_ring(struct timer_list *t)
 		  msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
 }
 
+static int ath11k_dp_purge_mon_ring(struct ath11k_base *ab)
+{
+	int i, reaped = 0;
+	unsigned long timeout = jiffies + msecs_to_jiffies(DP_MON_PURGE_TIMEOUT_MS);
+
+	do {
+		for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++)
+			reaped += ath11k_dp_rx_process_mon_rings(ab, i,
+								 NULL,
+								 DP_MON_SERVICE_BUDGET);
+
+		/* nothing more to reap */
+		if (reaped < DP_MON_SERVICE_BUDGET)
+			return 0;
+
+	} while (time_before(jiffies, timeout));
+
+	ath11k_warn(ab, "dp mon ring purge timeout");
+
+	return -ETIMEDOUT;
+}
+
 /* Returns number of Rx buffers replenished */
 int ath11k_dp_rxbufs_replenish(struct ath11k_base *ab, int mac_id,
 			       struct dp_rxdma_ring *rx_ring,
@@ -1830,8 +1852,7 @@ static void ath11k_dp_rx_h_csum_offload(struct sk_buff *msdu)
 			  CHECKSUM_NONE : CHECKSUM_UNNECESSARY;
 }
 
-static int ath11k_dp_rx_crypto_mic_len(struct ath11k *ar,
-				       enum hal_encrypt_type enctype)
+int ath11k_dp_rx_crypto_mic_len(struct ath11k *ar, enum hal_encrypt_type enctype)
 {
 	switch (enctype) {
 	case HAL_ENCRYPT_TYPE_OPEN:
@@ -5065,3 +5086,29 @@ int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar)
 	ath11k_dp_mon_link_free(ar);
 	return 0;
 }
+
+int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab)
+{
+	/* start reap timer */
+	mod_timer(&ab->mon_reap_timer,
+		  jiffies + msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
+
+	return 0;
+}
+
+int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer)
+{
+	int ret;
+
+	if (stop_timer)
+		del_timer_sync(&ab->mon_reap_timer);
+
+	/* reap all the monitor related rings */
+	ret = ath11k_dp_purge_mon_ring(ab);
+	if (ret) {
+		ath11k_warn(ab, "failed to purge dp mon ring: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.h b/drivers/net/wireless/ath/ath11k/dp_rx.h
index 6986752fc4b6..c322e30caa96 100644
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
@@ -92,4 +93,9 @@ int ath11k_dp_rx_pdev_mon_detach(struct ath11k *ar);
 int ath11k_dp_rx_pdev_mon_attach(struct ath11k *ar);
 int ath11k_peer_rx_frag_setup(struct ath11k *ar, const u8 *peer_mac, int vdev_id);
 
+int ath11k_dp_rx_pktlog_start(struct ath11k_base *ab);
+int ath11k_dp_rx_pktlog_stop(struct ath11k_base *ab, bool stop_timer);
+
+int ath11k_dp_rx_crypto_mic_len(struct ath11k *ar, enum hal_encrypt_type enctype);
+
 #endif /* ATH11K_DP_RX_H */
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3170c54c97b7..b66b6a7072d8 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2410,6 +2410,7 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_CCMP:
+	case WLAN_CIPHER_SUITE_CCMP_256:
 		arg.key_cipher = WMI_CIPHER_AES_CCM;
 		/* TODO: Re-check if flag is valid */
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV_MGMT;
@@ -2419,12 +2420,10 @@ static int ath11k_install_key(struct ath11k_vif *arvif,
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
@@ -3946,7 +3945,10 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
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
@@ -3966,7 +3968,12 @@ static int ath11k_mac_mgmt_tx_wmi(struct ath11k *ar, struct ath11k_vif *arvif,
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
 
@@ -4149,6 +4156,10 @@ static int ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
 						       &tlv_filter);
 	}
 
+	if (enable && !ar->ab->hw_params.rxdma1_enable)
+		mod_timer(&ar->ab->mon_reap_timer, jiffies +
+			  msecs_to_jiffies(ATH11K_MON_TIMER_INTERVAL));
+
 	return ret;
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
index e1196c565a62..03ba8ed995bf 100644
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
index a7131f4752e2..78cac4220e03 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -486,22 +486,13 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
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
@@ -945,10 +936,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, cmnd, bd->last);
+	spin_lock(&nvmeq->sq_lock);
+	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
+	nvme_write_sq_db(nvmeq, bd->last);
+	spin_unlock(&nvmeq->sq_lock);
 	return BLK_STS_OK;
 out_unmap_data:
-	nvme_unmap_data(dev, req);
+	if (blk_rq_nr_phys_segments(req))
+		nvme_unmap_data(dev, req);
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;
@@ -1120,7 +1115,11 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	memset(&c, 0, sizeof(c));
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
@@ -2847,6 +2846,13 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 			return NVME_QUIRK_SIMPLE_SUSPEND;
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
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 2d6c77dcc815..d0b3ec237385 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -680,8 +680,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 530ced8f7abd..09d5fa637b98 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4817,7 +4817,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 				      int timeout)
 {
 	struct pci_dev *child;
-	int delay;
+	int delay, ret = 0;
 
 	if (pci_dev_is_disconnected(dev))
 		return 0;
@@ -4845,8 +4845,8 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 		return 0;
 	}
 
-	child = list_first_entry(&dev->subordinate->devices, struct pci_dev,
-				 bus_list);
+	child = pci_dev_get(list_first_entry(&dev->subordinate->devices,
+					     struct pci_dev, bus_list));
 	up_read(&pci_bus_sem);
 
 	/*
@@ -4856,7 +4856,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	if (!pci_is_pcie(dev)) {
 		pci_dbg(dev, "waiting %d ms for secondary bus\n", 1000 + delay);
 		msleep(1000 + delay);
-		return 0;
+		goto put_child;
 	}
 
 	/*
@@ -4877,7 +4877,7 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
 	 * until the timeout expires.
 	 */
 	if (!pcie_downstream_port(dev))
-		return 0;
+		goto put_child;
 
 	if (pcie_get_speed_cap(dev) <= PCIE_SPEED_5_0GT) {
 		pci_dbg(dev, "waiting %d ms for downstream link\n", delay);
@@ -4888,11 +4888,16 @@ int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type,
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
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 3d44d6f48cc4..8152d24e128a 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -2039,6 +2039,14 @@ pinctrl_init_controller(struct pinctrl_desc *pctldesc, struct device *dev,
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
@@ -2119,8 +2127,10 @@ struct pinctrl_dev *pinctrl_register(struct pinctrl_desc *pctldesc,
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
index 02b41f1bafe7..e0f22ce219ee 100644
--- a/drivers/pinctrl/pinctrl-rockchip.c
+++ b/drivers/pinctrl/pinctrl-rockchip.c
@@ -720,9 +720,8 @@ static struct rockchip_mux_route_data rk3308_mux_route_data[] = {
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
@@ -731,18 +730,6 @@ static struct rockchip_mux_route_data rk3308_mux_route_data[] = {
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
index 22e471933b37..4860c4dd853f 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1332,7 +1332,6 @@ static void pcs_irq_free(struct pcs_device *pcs)
 static void pcs_free_resources(struct pcs_device *pcs)
 {
 	pcs_irq_free(pcs);
-	pinctrl_unregister(pcs->pctl);
 
 #if IS_BUILTIN(CONFIG_PINCTRL_SINGLE)
 	if (pcs->missing_nr_pinctrl_cells)
@@ -1889,7 +1888,7 @@ static int pcs_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto free;
 
-	ret = pinctrl_register_and_init(&pcs->desc, pcs->dev, pcs, &pcs->pctl);
+	ret = devm_pinctrl_register_and_init(pcs->dev, &pcs->desc, pcs, &pcs->pctl);
 	if (ret) {
 		dev_err(pcs->dev, "could not register single pinctrl driver\n");
 		goto free;
@@ -1922,8 +1921,10 @@ static int pcs_probe(struct platform_device *pdev)
 
 	dev_info(pcs->dev, "%i pins, size %u\n", pcs->desc.npins, pcs->size);
 
-	return pinctrl_enable(pcs->pctl);
+	if (pinctrl_enable(pcs->pctl))
+		goto free;
 
+	return 0;
 free:
 	pcs_free_resources(pcs);
 
diff --git a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
index cfb924228d87..6e1b067fb72e 100644
--- a/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
+++ b/drivers/pinctrl/ti/pinctrl-ti-iodelay.c
@@ -881,7 +881,7 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 	iod->desc.name = dev_name(dev);
 	iod->desc.owner = THIS_MODULE;
 
-	ret = pinctrl_register_and_init(&iod->desc, dev, iod, &iod->pctl);
+	ret = devm_pinctrl_register_and_init(dev, &iod->desc, iod, &iod->pctl);
 	if (ret) {
 		dev_err(dev, "Failed to register pinctrl\n");
 		goto exit_out;
@@ -889,7 +889,11 @@ static int ti_iodelay_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, iod);
 
-	return pinctrl_enable(iod->pctl);
+	ret = pinctrl_enable(iod->pctl);
+	if (ret)
+		goto exit_out;
+
+	return 0;
 
 exit_out:
 	of_node_put(np);
@@ -906,12 +910,6 @@ static int ti_iodelay_remove(struct platform_device *pdev)
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
index 8ffbf92ec1e0..39c41aeb57e4 100644
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
index f65bf7b295c5..c4f1a2bac333 100644
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
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 3e5f1b622af8..7146b3f6755b 100644
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
index 8957ed271d20..373fce8b9106 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -287,6 +287,11 @@ static int imx_rproc_addr_init(struct imx_rproc *priv,
 		struct resource res;
 
 		node = of_parse_phandle(np, "memory-region", a);
+		if (!node)
+			continue;
+		/* Not map vdevbuffer, vdevring region */
+		if (!strncmp(node->name, "vdev", strlen("vdev")))
+			continue;
 		err = of_address_to_resource(node, 0, &res);
 		if (err) {
 			dev_err(dev, "unable to resolve memory region\n");
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 146056858135..154ea5ae2c0c 100644
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
index 2c4ccab6e462..a55a1cff2ef0 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -649,11 +649,10 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
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
@@ -663,7 +662,7 @@ static int cmos_nvram_read(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 static int cmos_nvram_write(void *priv, unsigned int off, void *val,
@@ -671,7 +670,6 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 {
 	struct cmos_rtc	*cmos = priv;
 	unsigned char	*buf = val;
-	int		retval;
 
 	/* NOTE:  on at least PCs and Ataris, the boot firmware uses a
 	 * checksum on part of the NVRAM data.  That's currently ignored
@@ -680,7 +678,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	 */
 	off += NVRAM_OFFSET;
 	spin_lock_irq(&rtc_lock);
-	for (retval = 0; count; count--, off++, retval++) {
+	for (; count; count--, off++) {
 		/* don't trash RTC registers */
 		if (off == cmos->day_alrm
 				|| off == cmos->mon_alrm
@@ -695,7 +693,7 @@ static int cmos_nvram_write(void *priv, unsigned int off, void *val,
 	}
 	spin_unlock_irq(&rtc_lock);
 
-	return retval;
+	return count ? -EIO : 0;
 }
 
 /*----------------------------------------------------------------*/
diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index ebb691fa48a6..cba0dfe21a15 100644
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
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 2803b475dae6..53528711dac1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2431,12 +2431,8 @@ _base_check_pcie_native_sgl(struct MPT3SAS_ADAPTER *ioc,
 
 	/* Get the SG list pointer and info. */
 	sges_left = scsi_dma_map(scmd);
-	if (sges_left < 0) {
-		sdev_printk(KERN_ERR, scmd->device,
-			"scsi_dma_map failed: request for %d bytes!\n",
-			scsi_bufflen(scmd));
+	if (sges_left < 0)
 		return 1;
-	}
 
 	/* Check if we need to build a native SG list. */
 	if (base_is_prp_possible(ioc, pcie_device,
@@ -2496,6 +2492,22 @@ _base_build_zero_len_sge_ieee(struct MPT3SAS_ADAPTER *ioc, void *paddr)
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
@@ -2542,13 +2554,9 @@ _base_build_sg_scmd(struct MPT3SAS_ADAPTER *ioc,
 	sgl_flags = sgl_flags << MPI2_SGE_FLAGS_SHIFT;
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
-	if (sges_left < 0) {
-		sdev_printk(KERN_ERR, scmd->device,
-		 "scsi_dma_map failed: request for %d bytes!\n",
-		 scsi_bufflen(scmd));
+	sges_left = _base_scsi_dma_map(scmd);
+	if (sges_left < 0)
 		return -ENOMEM;
-	}
 
 	sg_local = &mpi_request->SGL;
 	sges_in_segment = ioc->max_sges_in_main_message;
@@ -2690,13 +2698,9 @@ _base_build_sg_scmd_ieee(struct MPT3SAS_ADAPTER *ioc,
 	}
 
 	sg_scmd = scsi_sglist(scmd);
-	sges_left = scsi_dma_map(scmd);
-	if (sges_left < 0) {
-		sdev_printk(KERN_ERR, scmd->device,
-			"scsi_dma_map failed: request for %d bytes!\n",
-			scsi_bufflen(scmd));
+	sges_left = _base_scsi_dma_map(scmd);
+	if (sges_left < 0)
 		return -ENOMEM;
-	}
 
 	sg_local = &mpi_request->SGL;
 	sges_in_segment = (ioc->request_sz -
diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index 804cac4c3476..d415e816ad0e 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -306,7 +306,7 @@ qla2x00_process_els(struct bsg_job *bsg_job)
 		    "request_sg_cnt=%x reply_sg_cnt=%x.\n",
 		    bsg_job->request_payload.sg_cnt,
 		    bsg_job->reply_payload.sg_cnt);
-		rval = -EPERM;
+		rval = -ENOBUFS;
 		goto done;
 	}
 
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index d9ac17dbad78..b08a92d346f5 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1708,7 +1708,7 @@ qla2x00_hba_attributes(scsi_qla_host_t *vha, void *entries,
 	eiter->type = cpu_to_be16(FDMI_HBA_OPTION_ROM_VERSION);
 	alen = scnprintf(
 		eiter->a.orom_version, sizeof(eiter->a.orom_version),
-		"%d.%02d", ha->bios_revision[1], ha->bios_revision[0]);
+		"%d.%02d", ha->efi_revision[1], ha->efi_revision[0]);
 	alen += FDMI_ATTR_ALIGNMENT(alen);
 	alen += FDMI_ATTR_TYPELEN(eiter);
 	eiter->len = cpu_to_be16(alen);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 8d54f6099802..affb3bc39006 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -7696,15 +7696,21 @@ qla28xx_get_aux_images(
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
@@ -7735,9 +7741,15 @@ qla28xx_get_aux_images(
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
@@ -7794,6 +7806,7 @@ qla27xx_get_active_image(struct scsi_qla_host *vha,
 	struct qla27xx_image_status pri_image_status, sec_image_status;
 	bool valid_pri_image = false, valid_sec_image = false;
 	bool active_pri_image = false, active_sec_image = false;
+	int rc;
 
 	if (!ha->flt_region_img_status_pri) {
 		ql_dbg(ql_dbg_init, vha, 0x018a, "Primary image not addressed\n");
@@ -7835,8 +7848,14 @@ qla27xx_get_active_image(struct scsi_qla_host *vha,
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
@@ -7908,11 +7927,10 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
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
@@ -7926,7 +7944,12 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
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
@@ -7942,7 +7965,13 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
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
 
@@ -7972,7 +8001,14 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
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
@@ -7998,11 +8034,12 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
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
 
diff --git a/drivers/scsi/qla2xxx/qla_mid.c b/drivers/scsi/qla2xxx/qla_mid.c
index c7caf322f445..b98c390b4b27 100644
--- a/drivers/scsi/qla2xxx/qla_mid.c
+++ b/drivers/scsi/qla2xxx/qla_mid.c
@@ -164,7 +164,7 @@ qla24xx_disable_vp(scsi_qla_host_t *vha)
 	atomic_set(&vha->loop_state, LOOP_DOWN);
 	atomic_set(&vha->loop_down_timer, LOOP_DOWN_TIME);
 	list_for_each_entry(fcport, &vha->vp_fcports, list)
-		fcport->logout_on_delete = 0;
+		fcport->logout_on_delete = 1;
 
 	qla2x00_mark_all_devices_lost(vha);
 
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 6dad7787f20d..28a5b40e0f32 100644
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
index 0930bf996cd3..00b971d1c419 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1752,14 +1752,9 @@ __qla2x00_abort_all_cmds(struct qla_qpair *qp, int res)
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
 
@@ -4453,7 +4448,7 @@ static void
 qla2x00_number_of_exch(scsi_qla_host_t *vha, u32 *ret_cnt, u16 max_cnt)
 {
 	u32 temp;
-	struct init_cb_81xx *icb = (struct init_cb_81xx *)&vha->hw->init_cb;
+	struct init_cb_81xx *icb = (struct init_cb_81xx *)vha->hw->init_cb;
 	*ret_cnt = FW_DEF_EXCHANGES_CNT;
 
 	if (max_cnt > vha->hw->max_exchg)
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index 0fa9c529fca1..c55135f1463e 100644
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
index 0b0230b46f28..a4c70fbc809f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3653,11 +3653,16 @@ static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba)
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
index 205cc96823b7..6e3cbd822663 100644
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
 
 static struct qmi_ops pdr_locator_ops = {
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
index a297911afe57..26e6dd860b5d 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -629,13 +629,14 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
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
@@ -654,7 +655,7 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const struct tcs_request *msg)
 		write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, 0);
 		enable_tcs_irq(drv, tcs_id, true);
 	}
-	spin_unlock_irqrestore(&drv->lock, flags);
+	spin_unlock_irq(&drv->lock);
 
 	/*
 	 * These two can be done after the lock is released because:
diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index b61e183ede69..707e176ed4ed 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -193,7 +193,6 @@ static int __rpmh_write(const struct device *dev, enum rpmh_state state,
 	rpm_msg->msg.state = state;
 
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
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 10b8785b9982..c7adcf97e2a3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -862,6 +862,14 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
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
diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index a717b53847a8..03ad1ed83c92 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -1438,6 +1438,7 @@ void gserial_suspend(struct gserial *gser)
 	spin_lock(&port->port_lock);
 	spin_unlock(&serial_port_lock);
 	port->suspended = true;
+	port->start_delayed = true;
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 EXPORT_SYMBOL_GPL(gserial_suspend);
diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index e80aa717c8b5..dd2fafc5b0c3 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -99,12 +99,10 @@ int usb_ep_enable(struct usb_ep *ep)
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
index b07b2925ff78..affcb928771d 100644
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
@@ -1095,6 +1097,7 @@ static void vhci_shutdown_connection(struct usbip_device *ud)
 static void vhci_device_reset(struct usbip_device *ud)
 {
 	struct vhci_device *vdev = container_of(ud, struct vhci_device, ud);
+	struct usb_device *old = vdev->udev;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ud->lock, flags);
@@ -1102,8 +1105,8 @@ static void vhci_device_reset(struct usbip_device *ud)
 	vdev->speed  = 0;
 	vdev->devid  = 0;
 
-	usb_put_dev(vdev->udev);
 	vdev->udev = NULL;
+	usb_put_dev(old);
 
 	if (ud->tcp_socket) {
 		sockfd_put(ud->tcp_socket);
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 04578aa87e4d..c9f585db1553 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -519,15 +519,15 @@ static void vhost_vdpa_iotlb_unmap(struct vhost_vdpa *v, u64 start, u64 last)
 	unsigned long pfn, pinned;
 
 	while ((map = vhost_iotlb_itree_first(iotlb, start, last)) != NULL) {
-		pinned = map->size >> PAGE_SHIFT;
-		for (pfn = map->addr >> PAGE_SHIFT;
+		pinned = PFN_DOWN(map->size);
+		for (pfn = PFN_DOWN(map->addr);
 		     pinned > 0; pfn++, pinned--) {
 			page = pfn_to_page(pfn);
 			if (map->perm & VHOST_ACCESS_WO)
 				set_page_dirty_lock(page);
 			unpin_user_page(page);
 		}
-		atomic64_sub(map->size >> PAGE_SHIFT, &dev->mm->pinned_vm);
+		atomic64_sub(PFN_DOWN(map->size), &dev->mm->pinned_vm);
 		vhost_iotlb_map_free(iotlb, map);
 	}
 }
@@ -589,7 +589,7 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
 	if (r)
 		vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
 	else
-		atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
+		atomic64_add(PFN_DOWN(size), &dev->mm->pinned_vm);
 
 	return r;
 }
@@ -643,7 +643,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 	if (msg->perm & VHOST_ACCESS_WO)
 		gup_flags |= FOLL_WRITE;
 
-	npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK)) >> PAGE_SHIFT;
+	npages = PFN_UP(msg->size + (iova & ~PAGE_MASK));
 	if (!npages) {
 		ret = -EINVAL;
 		goto free;
@@ -651,7 +651,7 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 
 	mmap_read_lock(dev->mm);
 
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
 	if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
 		ret = -ENOMEM;
 		goto unlock;
@@ -685,9 +685,9 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 
 			if (last_pfn && (this_pfn != last_pfn + 1)) {
 				/* Pin a contiguous chunk of memory */
-				csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
+				csize = PFN_PHYS(last_pfn - map_pfn + 1);
 				ret = vhost_vdpa_map(v, iova, csize,
-						     map_pfn << PAGE_SHIFT,
+						     PFN_PHYS(map_pfn),
 						     msg->perm);
 				if (ret) {
 					/*
@@ -711,13 +711,13 @@ static int vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
 			last_pfn = this_pfn;
 		}
 
-		cur_base += pinned << PAGE_SHIFT;
+		cur_base += PFN_PHYS(pinned);
 		npages -= pinned;
 	}
 
 	/* Pin the rest chunk */
-	ret = vhost_vdpa_map(v, iova, (last_pfn - map_pfn + 1) << PAGE_SHIFT,
-			     map_pfn << PAGE_SHIFT, msg->perm);
+	ret = vhost_vdpa_map(v, iova, PFN_PHYS(last_pfn - map_pfn + 1),
+			     PFN_PHYS(map_pfn), msg->perm);
 out:
 	if (ret) {
 		if (nchunks) {
@@ -959,13 +959,7 @@ static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
 
 	notify = ops->get_vq_notification(vdpa, index);
 
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
-			    notify.addr >> PAGE_SHIFT, PAGE_SIZE,
-			    vma->vm_page_prot))
-		return VM_FAULT_SIGBUS;
-
-	return VM_FAULT_NOPAGE;
+	return vmf_insert_pfn(vma, vmf->address & PAGE_MASK, PFN_DOWN(notify.addr));
 }
 
 static const struct vm_operations_struct vhost_vdpa_vm_ops = {
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 4989c60b1df9..af52c9e005b3 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -798,6 +798,7 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 				spin_unlock(&ctl->tree_lock);
 				btrfs_err(fs_info,
 					"Duplicate entries in free space cache, dumping");
+				kmem_cache_free(btrfs_free_space_bitmap_cachep, e->bitmap);
 				kmem_cache_free(btrfs_free_space_cachep, e);
 				goto free_cache;
 			}
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index f2aff97348bc..4e09d8e06647 100644
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
index d5c8f085235b..6a4bbe58d3c0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1588,6 +1588,7 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	unsigned int mode;
 	kuid_t uid;
 	kgid_t gid;
+	int err;
 
 	if (!mnt_may_suid(file->f_path.mnt))
 		return;
@@ -1603,12 +1604,17 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	/* Be careful if suid/sgid is set */
 	inode_lock(inode);
 
-	/* reload atomically mode/uid/gid now that lock held */
+	/* Atomically reload and check mode/uid/gid now that lock held. */
 	mode = inode->i_mode;
 	uid = inode->i_uid;
 	gid = inode->i_gid;
+	err = inode_permission(inode, MAY_EXEC);
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
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index f37e62546745..be3b3ccbf70b 100644
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
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8b48ed351c4b..6e9323a56d28 100644
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
@@ -1731,6 +1760,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		if (ext4_es_is_hole(&es))
 			goto add_delayed;
 
+found:
 		/*
 		 * Delayed extent could be allocated by fallocate.
 		 * So we need to check it.
@@ -1767,36 +1797,34 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 	down_read(&EXT4_I(inode)->i_data_sem);
 	if (ext4_has_inline_data(inode))
 		retval = 0;
-	else if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
-		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-	if (retval < 0) {
-		up_read(&EXT4_I(inode)->i_data_sem);
+		retval = ext4_map_query_blocks(NULL, inode, map);
+	up_read(&EXT4_I(inode)->i_data_sem);
+	if (retval)
 		return retval;
-	}
-	if (retval > 0) {
-		unsigned int status;
 
-		if (unlikely(retval != map->m_len)) {
-			ext4_warning(inode->i_sb,
-				     "ES len assertion failed for inode "
-				     "%lu: retval %d != map->m_len %d",
-				     inode->i_ino, retval, map->m_len);
-			WARN_ON(1);
+add_delayed:
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
+		}
+	} else if (!ext4_has_inline_data(inode)) {
+		retval = ext4_map_query_blocks(NULL, inode, map);
+		if (retval) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			return retval;
 		}
-
-		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
-				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
-		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
-				      map->m_pblk, status);
-		up_read(&EXT4_I(inode)->i_data_sem);
-		return retval;
 	}
-	up_read(&EXT4_I(inode)->i_data_sem);
 
-add_delayed:
-	down_write(&EXT4_I(inode)->i_data_sem);
 	retval = ext4_insert_delayed_block(inode, map->m_lblk);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 87378d08a414..bc5db22df9fe 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1927,8 +1927,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	if (max >= ac->ac_g_ex.fe_len && ac->ac_g_ex.fe_len == sbi->s_stripe) {
 		ext4_fsblk_t start;
 
-		start = ext4_group_first_block_no(ac->ac_sb, e4b->bd_group) +
-			ex.fe_start;
+		start = ext4_grp_offs_to_block(ac->ac_sb, &ex);
 		/* use do_div to get remainder (would be 64-bit modulo) */
 		if (do_div(start, sbi->s_stripe) == 0) {
 			ac->ac_found++;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index af0801593abb..bf312f94c3bf 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -145,10 +145,11 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 
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
@@ -2098,6 +2099,52 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
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
@@ -2131,17 +2178,17 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
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
@@ -2931,10 +2978,7 @@ bool ext4_empty_dir(struct inode *inode)
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
 
@@ -3565,10 +3609,7 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
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
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 2dcb7d2bb85e..b91a1d1099d5 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1377,6 +1377,12 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
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
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 724760353bcd..b23e6a848e9b 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -23,6 +23,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (is_inode_flag_set(inode, FI_NEW_INODE))
 		return;
 
+	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+		return;
+
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 979296b835b5..665e0e186687 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -371,7 +371,8 @@ static inline unsigned int get_ckpt_valid_blocks(struct f2fs_sb_info *sbi,
 				unsigned int segno, bool use_section)
 {
 	if (use_section && __is_large_section(sbi)) {
-		unsigned int start_segno = START_SEGNO(segno);
+		unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
+		unsigned int start_segno = GET_SEG_FROM_SEC(sbi, secno);
 		unsigned int blocks = 0;
 		int i;
 
diff --git a/fs/file.c b/fs/file.c
index 913f7d897d2f..105a084b7924 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1057,6 +1057,7 @@ __releases(&files->file_lock)
 	 * tables and this condition does not arise without those.
 	 */
 	fdt = files_fdtable(files);
+	fd = array_index_nospec(fd, fdt->max_fds);
 	tofree = fdt->fd[fd];
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 24b4d9db231d..79f01d09c78c 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -328,7 +328,7 @@ void fuse_ctl_remove_conn(struct fuse_conn *fc)
 	drop_nlink(d_inode(fuse_control_sb->s_root));
 }
 
-static int fuse_ctl_fill_super(struct super_block *sb, struct fs_context *fctx)
+static int fuse_ctl_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
 	static const struct tree_descr empty_descr = {""};
 	struct fuse_conn *fc;
@@ -354,18 +354,18 @@ static int fuse_ctl_fill_super(struct super_block *sb, struct fs_context *fctx)
 	return 0;
 }
 
-static int fuse_ctl_get_tree(struct fs_context *fc)
+static int fuse_ctl_get_tree(struct fs_context *fsc)
 {
-	return get_tree_single(fc, fuse_ctl_fill_super);
+	return get_tree_single(fsc, fuse_ctl_fill_super);
 }
 
 static const struct fs_context_operations fuse_ctl_context_ops = {
 	.get_tree	= fuse_ctl_get_tree,
 };
 
-static int fuse_ctl_init_fs_context(struct fs_context *fc)
+static int fuse_ctl_init_fs_context(struct fs_context *fsc)
 {
-	fc->ops = &fuse_ctl_context_ops;
+	fsc->ops = &fuse_ctl_context_ops;
 	return 0;
 }
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4a7ebccd359e..a5d1eb0bc521 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -141,12 +141,12 @@ static void fuse_evict_inode(struct inode *inode)
 	}
 }
 
-static int fuse_reconfigure(struct fs_context *fc)
+static int fuse_reconfigure(struct fs_context *fsc)
 {
-	struct super_block *sb = fc->root->d_sb;
+	struct super_block *sb = fsc->root->d_sb;
 
 	sync_filesystem(sb);
-	if (fc->sb_flags & SB_MANDLOCK)
+	if (fsc->sb_flags & SB_MANDLOCK)
 		return -EINVAL;
 
 	return 0;
@@ -535,38 +535,40 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
 	{}
 };
 
-static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
+static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
 {
 	struct fs_parse_result result;
-	struct fuse_fs_context *ctx = fc->fs_private;
+	struct fuse_fs_context *ctx = fsc->fs_private;
 	int opt;
+	kuid_t kuid;
+	kgid_t kgid;
 
-	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
+	if (fsc->purpose == FS_CONTEXT_FOR_RECONFIGURE) {
 		/*
 		 * Ignore options coming from mount(MS_REMOUNT) for backward
 		 * compatibility.
 		 */
-		if (fc->oldapi)
+		if (fsc->oldapi)
 			return 0;
 
-		return invalfc(fc, "No changes allowed in reconfigure");
+		return invalfc(fsc, "No changes allowed in reconfigure");
 	}
 
-	opt = fs_parse(fc, fuse_fs_parameters, param, &result);
+	opt = fs_parse(fsc, fuse_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
 
 	switch (opt) {
 	case OPT_SOURCE:
-		if (fc->source)
-			return invalfc(fc, "Multiple sources specified");
-		fc->source = param->string;
+		if (fsc->source)
+			return invalfc(fsc, "Multiple sources specified");
+		fsc->source = param->string;
 		param->string = NULL;
 		break;
 
 	case OPT_SUBTYPE:
 		if (ctx->subtype)
-			return invalfc(fc, "Multiple subtypes specified");
+			return invalfc(fsc, "Multiple subtypes specified");
 		ctx->subtype = param->string;
 		param->string = NULL;
 		return 0;
@@ -578,22 +580,36 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	case OPT_ROOTMODE:
 		if (!fuse_valid_type(result.uint_32))
-			return invalfc(fc, "Invalid rootmode");
+			return invalfc(fsc, "Invalid rootmode");
 		ctx->rootmode = result.uint_32;
 		ctx->rootmode_present = true;
 		break;
 
 	case OPT_USER_ID:
-		ctx->user_id = make_kuid(fc->user_ns, result.uint_32);
-		if (!uid_valid(ctx->user_id))
-			return invalfc(fc, "Invalid user_id");
+		kuid =  make_kuid(fsc->user_ns, result.uint_32);
+		if (!uid_valid(kuid))
+			return invalfc(fsc, "Invalid user_id");
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
-		ctx->group_id = make_kgid(fc->user_ns, result.uint_32);
-		if (!gid_valid(ctx->group_id))
-			return invalfc(fc, "Invalid group_id");
+		kgid = make_kgid(fsc->user_ns, result.uint_32);;
+		if (!gid_valid(kgid))
+			return invalfc(fsc, "Invalid group_id");
+		/*
+		 * The requested gid must be representable in the
+		 * filesystem's idmapping.
+		 */
+		if (!kgid_has_mapping(fsc->user_ns, kgid))
+			return invalfc(fsc, "Invalid group_id");
+		ctx->group_id = kgid;
 		ctx->group_id_present = true;
 		break;
 
@@ -611,7 +627,7 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 
 	case OPT_BLKSIZE:
 		if (!ctx->is_bdev)
-			return invalfc(fc, "blksize only supported for fuseblk");
+			return invalfc(fsc, "blksize only supported for fuseblk");
 		ctx->blksize = result.uint_32;
 		break;
 
@@ -622,9 +638,9 @@ static int fuse_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	return 0;
 }
 
-static void fuse_free_fc(struct fs_context *fc)
+static void fuse_free_fsc(struct fs_context *fsc)
 {
-	struct fuse_fs_context *ctx = fc->fs_private;
+	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	if (ctx) {
 		kfree(ctx->subtype);
@@ -1486,9 +1502,9 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	return err;
 }
 
-static int fuse_get_tree(struct fs_context *fc)
+static int fuse_get_tree(struct fs_context *fsc)
 {
-	struct fuse_fs_context *ctx = fc->fs_private;
+	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	if (!ctx->fd_present || !ctx->rootmode_present ||
 	    !ctx->user_id_present || !ctx->group_id_present)
@@ -1496,14 +1512,14 @@ static int fuse_get_tree(struct fs_context *fc)
 
 #ifdef CONFIG_BLOCK
 	if (ctx->is_bdev)
-		return get_tree_bdev(fc, fuse_fill_super);
+		return get_tree_bdev(fsc, fuse_fill_super);
 #endif
 
-	return get_tree_nodev(fc, fuse_fill_super);
+	return get_tree_nodev(fsc, fuse_fill_super);
 }
 
 static const struct fs_context_operations fuse_context_ops = {
-	.free		= fuse_free_fc,
+	.free		= fuse_free_fsc,
 	.parse_param	= fuse_parse_param,
 	.reconfigure	= fuse_reconfigure,
 	.get_tree	= fuse_get_tree,
@@ -1512,7 +1528,7 @@ static const struct fs_context_operations fuse_context_ops = {
 /*
  * Set up the filesystem mount context.
  */
-static int fuse_init_fs_context(struct fs_context *fc)
+static int fuse_init_fs_context(struct fs_context *fsc)
 {
 	struct fuse_fs_context *ctx;
 
@@ -1525,14 +1541,14 @@ static int fuse_init_fs_context(struct fs_context *fc)
 	ctx->legacy_opts_show = true;
 
 #ifdef CONFIG_BLOCK
-	if (fc->fs_type == &fuseblk_fs_type) {
+	if (fsc->fs_type == &fuseblk_fs_type) {
 		ctx->is_bdev = true;
 		ctx->destroy = true;
 	}
 #endif
 
-	fc->fs_private = ctx;
-	fc->ops = &fuse_context_ops;
+	fsc->fs_private = ctx;
+	fsc->ops = &fuse_context_ops;
 	return 0;
 }
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index faadc80485e7..7d4655022afc 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -97,14 +97,14 @@ static const struct fs_parameter_spec virtio_fs_parameters[] = {
 	{}
 };
 
-static int virtio_fs_parse_param(struct fs_context *fc,
+static int virtio_fs_parse_param(struct fs_context *fsc,
 				 struct fs_parameter *param)
 {
 	struct fs_parse_result result;
-	struct fuse_fs_context *ctx = fc->fs_private;
+	struct fuse_fs_context *ctx = fsc->fs_private;
 	int opt;
 
-	opt = fs_parse(fc, virtio_fs_parameters, param, &result);
+	opt = fs_parse(fsc, virtio_fs_parameters, param, &result);
 	if (opt < 0)
 		return opt;
 
@@ -119,9 +119,9 @@ static int virtio_fs_parse_param(struct fs_context *fc,
 	return 0;
 }
 
-static void virtio_fs_free_fc(struct fs_context *fc)
+static void virtio_fs_free_fsc(struct fs_context *fsc)
 {
-	struct fuse_fs_context *ctx = fc->fs_private;
+	struct fuse_fs_context *ctx = fsc->fs_private;
 
 	kfree(ctx);
 }
@@ -1500,7 +1500,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 }
 
 static const struct fs_context_operations virtio_fs_context_ops = {
-	.free		= virtio_fs_free_fc,
+	.free		= virtio_fs_free_fsc,
 	.parse_param	= virtio_fs_parse_param,
 	.get_tree	= virtio_fs_get_tree,
 };
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 6fbde990e056..3d59cdb31278 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -200,6 +200,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	HFS_I(inode)->fs_blocks = 0;
+	HFS_I(inode)->tz_secondswest = sys_tz.tz_minuteswest * 60;
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		HFS_SB(sb)->folder_count++;
@@ -275,6 +276,8 @@ void hfs_inode_read_fork(struct inode *inode, struct hfs_extent *ext,
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
index c438680ef9f7..bfbe88e804eb 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -557,6 +557,27 @@ static inline __be32 __hfsp_ut2mt(time64_t ut)
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
index db137671a41f..7d548821854e 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -813,7 +813,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		if (first_block < journal->j_tail)
 			freed += journal->j_last - journal->j_first;
 		/* Update tail only if we free significant amount of space */
-		if (freed < jbd2_journal_get_max_txn_bufs(journal))
+		if (freed < journal->j_max_transaction_buffers)
 			update_tail = 0;
 	}
 	J_ASSERT(commit_transaction->t_state == T_COMMIT);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index effd837b8c1f..205e6c7c2fd0 100644
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
@@ -1481,6 +1482,11 @@ static void journal_fail_superblock(journal_t *journal)
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
index b0965f3ef186..36ed75682064 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -292,7 +292,7 @@ int diSync(struct inode *ipimap)
 int diRead(struct inode *ip)
 {
 	struct jfs_sb_info *sbi = JFS_SBI(ip->i_sb);
-	int iagno, ino, extno, rc;
+	int iagno, ino, extno, rc, agno;
 	struct inode *ipimap;
 	struct dinode *dp;
 	struct iag *iagp;
@@ -341,8 +341,11 @@ int diRead(struct inode *ip)
 
 	/* get the ag for the iag */
 	agstart = le64_to_cpu(iagp->agstart);
+	agno = BLKTOAG(agstart, JFS_SBI(ip->i_sb));
 
 	release_metapage(mp);
+	if (agno >= MAXAG || agno < 0)
+		return -EIO;
 
 	rel_inode = (ino & (INOSPERPAGE - 1));
 	pageno = blkno >> sbi->l2nbperpage;
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
index 4905b7cd7bf3..a426e4e2acda 100644
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
index 02407c524382..d9f92df15a84 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -134,14 +134,9 @@ static void nilfs_segctor_do_flush(struct nilfs_sc_info *, int);
 static void nilfs_segctor_do_immediate_flush(struct nilfs_sc_info *);
 static void nilfs_dispose_list(struct the_nilfs *, struct list_head *, int);
 
-#define nilfs_cnt32_gt(a, b)   \
-	(typecheck(__u32, a) && typecheck(__u32, b) && \
-	 ((__s32)(b) - (__s32)(a) < 0))
 #define nilfs_cnt32_ge(a, b)   \
 	(typecheck(__u32, a) && typecheck(__u32, b) && \
-	 ((__s32)(a) - (__s32)(b) >= 0))
-#define nilfs_cnt32_lt(a, b)  nilfs_cnt32_gt(b, a)
-#define nilfs_cnt32_le(a, b)  nilfs_cnt32_ge(b, a)
+	 ((__s32)((a) - (b)) >= 0))
 
 static int nilfs_prepare_segment_lock(struct super_block *sb,
 				      struct nilfs_transaction_info *ti)
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index aff9593feb73..f5c967735335 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -471,12 +471,10 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
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
index 39b1038076c3..97023c0dca60 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1468,6 +1468,8 @@ static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		}
 #endif
 
+		if (page && !PageAnon(page))
+			flags |= PM_FILE;
 		if (page && !migration && page_mapcount(page) == 1)
 			flags |= PM_MMAP_EXCLUSIVE;
 
diff --git a/fs/super.c b/fs/super.c
index f9795e72e3bf..282aa36901eb 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -518,6 +518,17 @@ struct super_block *sget_fc(struct fs_context *fc,
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
index 4af9ce34ee80..1939678f0b62 100644
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
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 3982c2dc541e..a3b85459959e 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -37,6 +37,7 @@
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
 # define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
+# define __GCC4_has_attribute___uninitialized__       0
 # define __GCC4_has_attribute___fallthrough__         0
 # define __GCC4_has_attribute___warning__             1
 #endif
diff --git a/include/linux/irq.h b/include/linux/irq.h
index b89a8ac83d1b..eb7af809e6e5 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -708,10 +708,11 @@ extern struct irq_chip no_irq_chip;
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
@@ -801,7 +802,7 @@ static inline void irq_set_percpu_devid_flags(unsigned int irq)
 }
 
 /* Set/get chip/data for an IRQ: */
-extern int irq_set_chip(unsigned int irq, struct irq_chip *chip);
+extern int irq_set_chip(unsigned int irq, const struct irq_chip *chip);
 extern int irq_set_handler_data(unsigned int irq, void *data);
 extern int irq_set_chip_data(unsigned int irq, void *data);
 extern int irq_set_irq_type(unsigned int irq, unsigned int type);
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 9b9743f7538c..60f53eadfa42 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -149,6 +149,8 @@ struct irq_domain_chip_generic;
  * @gc: Pointer to a list of generic chips. There is a helper function for
  *      setting up one or more generic chips for interrupt controllers
  *      drivers using the generic chip library which uses this pointer.
+ * @dev: Pointer to a device that the domain represent, and that will be
+ *       used for power management purposes.
  * @parent: Pointer to parent irq_domain to support hierarchy irq_domains
  * @debugfs_file: dentry for the domain debugfs file
  *
@@ -171,6 +173,7 @@ struct irq_domain {
 	struct fwnode_handle *fwnode;
 	enum irq_domain_bus_token bus_token;
 	struct irq_domain_chip_generic *gc;
+	struct device *dev;
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	struct irq_domain *parent;
 #endif
@@ -227,6 +230,13 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
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
index 578ff196b3ce..80f573d1b3b8 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1626,11 +1626,6 @@ int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode);
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
index 80744a7b5e33..b2418bfda4a9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2137,6 +2137,8 @@
 
 #define PCI_VENDOR_ID_CHELSIO		0x1425
 
+#define PCI_VENDOR_ID_EDIMAX		0x1432
+
 #define PCI_VENDOR_ID_ADLINK		0x144a
 
 #define PCI_VENDOR_ID_SAMSUNG		0x144d
diff --git a/include/linux/qed/qed_eth_if.h b/include/linux/qed/qed_eth_if.h
index 812a4d751163..4df0bf0a0864 100644
--- a/include/linux/qed/qed_eth_if.h
+++ b/include/linux/qed/qed_eth_if.h
@@ -145,12 +145,6 @@ struct qed_filter_mcast_params {
 	unsigned char mac[64][ETH_ALEN];
 };
 
-union qed_filter_type_params {
-	enum qed_filter_rx_mode_type accept_flags;
-	struct qed_filter_ucast_params ucast;
-	struct qed_filter_mcast_params mcast;
-};
-
 enum qed_filter_type {
 	QED_FILTER_TYPE_UCAST,
 	QED_FILTER_TYPE_MCAST,
@@ -158,11 +152,6 @@ enum qed_filter_type {
 	QED_MAX_FILTER_TYPES,
 };
 
-struct qed_filter_params {
-	enum qed_filter_type type;
-	union qed_filter_type_params filter;
-};
-
 struct qed_tunn_params {
 	u16 vxlan_port;
 	u8 update_vxlan_port;
@@ -314,8 +303,14 @@ struct qed_eth_ops {
 
 	int (*q_tx_stop)(struct qed_dev *cdev, u8 rss_id, void *handle);
 
-	int (*filter_config)(struct qed_dev *cdev,
-			     struct qed_filter_params *params);
+	int (*filter_config_rx_mode)(struct qed_dev *cdev,
+				     enum qed_filter_rx_mode_type type);
+
+	int (*filter_config_ucast)(struct qed_dev *cdev,
+				   struct qed_filter_ucast_params *params);
+
+	int (*filter_config_mcast)(struct qed_dev *cdev,
+				   struct qed_filter_mcast_params *params);
 
 	int (*fastpath_stop)(struct qed_dev *cdev);
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 2c634010cc7b..5e4194e12a7d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -348,6 +348,12 @@ extern void sigqueue_free(struct sigqueue *);
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
index dbf0993153d3..64af1e11ea13 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -729,7 +729,6 @@ do {									\
 struct perf_event;
 
 DECLARE_PER_CPU(struct pt_regs, perf_trace_regs);
-DECLARE_PER_CPU(int, bpf_kprobe_override);
 
 extern int  perf_trace_init(struct perf_event *event);
 extern void perf_trace_destroy(struct perf_event *event);
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2b99ee1303d9..3cc25a5faa23 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -13,6 +13,7 @@
 #include <net/netfilter/nf_flow_table.h>
 #include <net/netlink.h>
 #include <net/flow_offload.h>
+#include <net/netns/generic.h>
 
 #define NFT_MAX_HOOKS	(NF_INET_INGRESS + 1)
 
@@ -686,10 +687,16 @@ static inline struct nft_expr *nft_set_ext_expr(const struct nft_set_ext *ext)
 	return nft_set_ext(ext, NFT_SET_EXT_EXPR);
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
@@ -779,7 +786,7 @@ struct nft_expr_ops {
 						struct nft_regs *regs,
 						const struct nft_pktinfo *pkt);
 	int				(*clone)(struct nft_expr *dst,
-						 const struct nft_expr *src);
+						 const struct nft_expr *src, gfp_t gfp);
 	unsigned int			size;
 
 	int				(*init)(const struct nft_ctx *ctx,
@@ -830,7 +837,7 @@ static inline void *nft_expr_priv(const struct nft_expr *expr)
 	return (void *)expr->data;
 }
 
-int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src);
+int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp);
 void nft_expr_destroy(const struct nft_ctx *ctx, struct nft_expr *expr);
 int nft_expr_dump(struct sk_buff *skb, unsigned int attr,
 		  const struct nft_expr *expr);
@@ -1580,9 +1587,19 @@ struct nftables_pernet {
 	struct list_head	module_list;
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
+	u64			tstamp;
 	unsigned int		base_seq;
 	u8			validate_state;
 	unsigned int		gc_seq;
 };
 
+extern unsigned int nf_tables_net_id;
+
+static inline u64 nft_net_tstamp(const struct net *net)
+{
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return nft_net->tstamp;
+}
+
 #endif /* _NET_NF_TABLES_H */
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 33475d061823..6d89a7f3f6a4 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -506,8 +506,8 @@ static inline int sctp_ep_hashfn(struct net *net, __u16 lport)
 	return (net_hash_mix(net) + lport) & (sctp_ep_hashsize - 1);
 }
 
-#define sctp_for_each_hentry(epb, head) \
-	hlist_for_each_entry(epb, head, node)
+#define sctp_for_each_hentry(ep, head) \
+	hlist_for_each_entry(ep, head, node)
 
 /* Is a socket of this style? */
 #define sctp_style(sk, style) __sctp_style((sk), (SCTP_SOCKET_##style))
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index be59e8df0bff..108eb62cdc2c 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1218,10 +1218,6 @@ enum sctp_endpoint_type {
  */
 
 struct sctp_ep_common {
-	/* Fields to help us manage our entries in the hash tables. */
-	struct hlist_node node;
-	int hashent;
-
 	/* Runtime type information.  What kind of endpoint is this? */
 	enum sctp_endpoint_type type;
 
@@ -1273,6 +1269,10 @@ struct sctp_endpoint {
 	/* Common substructure for endpoint and association. */
 	struct sctp_ep_common base;
 
+	/* Fields to help us manage our entries in the hash tables. */
+	struct hlist_node node;
+	int hashent;
+
 	/* Associations: A list of current associations and mappings
 	 *	      to the data consumers for each association. This
 	 *	      may be in the form of a hash table or other
diff --git a/include/trace/events/rpcgss.h b/include/trace/events/rpcgss.h
index ffdbe6f85da8..9c8cb69c7911 100644
--- a/include/trace/events/rpcgss.h
+++ b/include/trace/events/rpcgss.h
@@ -52,7 +52,7 @@ TRACE_DEFINE_ENUM(GSS_S_UNSEQ_TOKEN);
 TRACE_DEFINE_ENUM(GSS_S_GAP_TOKEN);
 
 #define show_gss_status(x)						\
-	__print_flags(x, "|",						\
+	__print_symbolic(x, 						\
 		{ GSS_S_BAD_MECH, "GSS_S_BAD_MECH" },			\
 		{ GSS_S_BAD_NAME, "GSS_S_BAD_NAME" },			\
 		{ GSS_S_BAD_NAMETYPE, "GSS_S_BAD_NAMETYPE" },		\
diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index f93ffb1b6739..40d900537093 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1284,7 +1284,7 @@ enum nft_secmark_attributes {
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
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 06c028bdb8d4..cfbb038d150c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -340,7 +340,7 @@ static const char *btf_type_str(const struct btf_type *t)
 struct btf_show {
 	u64 flags;
 	void *target;	/* target of show operation (seq file, buffer) */
-	void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
+	__printf(2, 0) void (*showfn)(struct btf_show *show, const char *fmt, va_list args);
 	const struct btf *btf;
 	/* below are used during iteration */
 	struct {
@@ -5344,8 +5344,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
 	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
 }
 
-static void btf_seq_show(struct btf_show *show, const char *fmt,
-			 va_list args)
+__printf(2, 0) static void btf_seq_show(struct btf_show *show, const char *fmt,
+					va_list args)
 {
 	seq_vprintf((struct seq_file *)show->target, fmt, args);
 }
@@ -5378,8 +5378,8 @@ struct btf_show_snprintf {
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
index 51bb8fa8eb89..453c0fbe87ff 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -60,8 +60,8 @@ void dmam_free_coherent(struct device *dev, size_t size, void *vaddr,
 {
 	struct dma_devres match_data = { size, vaddr, dma_handle };
 
-	dma_free_coherent(dev, size, vaddr, dma_handle);
 	WARN_ON(devres_destroy(dev, dmam_release, dmam_match, &match_data));
+	dma_free_coherent(dev, size, vaddr, dma_handle);
 }
 EXPORT_SYMBOL(dmam_free_coherent);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3a191bec69ac..b60325cc8604 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6239,6 +6239,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			return -EINVAL;
 
 		nr_pages = vma_size / PAGE_SIZE;
+		if (nr_pages > INT_MAX)
+			return -ENOMEM;
 
 		mutex_lock(&event->mmap_mutex);
 		ret = -EINVAL;
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index aa23ffdaf819..8e63cc2bd4f7 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -128,7 +128,7 @@ static inline unsigned long perf_data_size(struct perf_buffer *rb)
 
 static inline unsigned long perf_aux_size(struct perf_buffer *rb)
 {
-	return rb->aux_nr_pages << PAGE_SHIFT;
+	return (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
 }
 
 #define __DEFINE_OUTPUT_COPY_BODY(advance_buf, memcpy_func, ...)	\
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index e7d284261d45..09b91aebb90b 100644
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
@@ -1102,7 +1099,7 @@ irq_set_chained_handler_and_data(unsigned int irq, irq_flow_handler_t handle,
 EXPORT_SYMBOL_GPL(irq_set_chained_handler_and_data);
 
 void
-irq_set_chip_and_handler_name(unsigned int irq, struct irq_chip *chip,
+irq_set_chip_and_handler_name(unsigned int irq, const struct irq_chip *chip,
 			      irq_flow_handler_t handle, const char *name)
 {
 	irq_set_chip(irq, chip);
@@ -1586,6 +1583,17 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
@@ -1595,12 +1603,13 @@ int irq_chip_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
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
@@ -1618,10 +1627,11 @@ int irq_chip_pm_get(struct irq_data *data)
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
index 6c009a033c73..68183511226a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -491,6 +491,7 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 				flags = IRQD_AFFINITY_MANAGED |
 					IRQD_MANAGED_SHUTDOWN;
 			}
+			flags |= IRQD_AFFINITY_SET;
 			mask = &affinity->mask;
 			node = cpu_to_node(cpumask_first(mask));
 			affinity++;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 0159925054fa..c7f4f948f17e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1230,7 +1230,7 @@ static int irq_thread(void *data)
 	 * synchronize_hardirq(). So neither IRQTF_RUNTHREAD nor the
 	 * oneshot mask bit can be set.
 	 */
-	task_work_cancel(current, irq_thread_dtor);
+	task_work_cancel_func(current, irq_thread_dtor);
 	return 0;
 }
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index dba6541c0fc3..c8e62458d323 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1632,8 +1632,8 @@ static bool is_cfi_preamble_symbol(unsigned long addr)
 	if (lookup_symbol_name(addr, symbuf))
 		return false;
 
-	return str_has_prefix("__cfi_", symbuf) ||
-		str_has_prefix("__pfx_", symbuf);
+	return str_has_prefix(symbuf, "__cfi_") ||
+		str_has_prefix(symbuf, "__pfx_");
 }
 
 static int check_kprobe_address_safe(struct kprobe *p,
diff --git a/kernel/padata.c b/kernel/padata.c
index 471ccbc44541..2a514cf8379b 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -521,6 +521,13 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
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
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 9f505688291e..5c4bdbe76df0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1867,7 +1867,7 @@ static void rcu_torture_fwd_cb_cr(struct rcu_head *rhp)
 	spin_lock_irqsave(&rfp->rcu_fwd_lock, flags);
 	rfcpp = rfp->rcu_fwd_cb_tail;
 	rfp->rcu_fwd_cb_tail = &rfcp->rfc_next;
-	WRITE_ONCE(*rfcpp, rfcp);
+	smp_store_release(rfcpp, rfcp);
 	WRITE_ONCE(rfp->n_launders_cb, rfp->n_launders_cb + 1);
 	i = ((jiffies - rfp->rcu_fwd_startat) / (HZ / FWD_CBS_HIST_DIV));
 	if (i >= ARRAY_SIZE(rfp->n_launders_hist))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 40f40f359c5d..29d8fc3a7bbd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -848,27 +848,24 @@ static void set_load_weight(struct task_struct *p)
 {
 	bool update_load = !(READ_ONCE(p->state) & TASK_NEW);
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
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index ca0eef7d3852..f03b3af2fb79 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -579,6 +579,12 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
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
index 73a89fbd81be..a6a755aec32b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3119,15 +3119,14 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
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
@@ -7951,7 +7950,7 @@ static int detach_tasks(struct lb_env *env)
 		case migrate_util:
 			util = task_util_est(p);
 
-			if (util > env->imbalance)
+			if (shr_bound(util, env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= util;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8de07aba8bdd..df6cf8aa59f8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1938,7 +1938,7 @@ extern void init_sched_dl_class(void);
 extern void init_sched_rt_class(void);
 extern void init_sched_fair_class(void);
 
-extern void reweight_task(struct task_struct *p, int prio);
+extern void reweight_task(struct task_struct *p, const struct load_weight *lw);
 
 extern void resched_curr(struct rq *rq);
 extern void resched_cpu(int cpu);
diff --git a/kernel/signal.c b/kernel/signal.c
index e487c4660921..bfc1da526ebb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2464,6 +2464,14 @@ static void do_freezer_trap(void)
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
index e9316198c64b..6138e13dce3d 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -101,9 +101,9 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
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
@@ -112,11 +112,35 @@ static bool task_work_func_match(struct callback_head *cb, void *data)
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
@@ -149,7 +173,7 @@ void task_work_run(void)
 		if (!work)
 			break;
 		/*
-		 * Synchronize with task_work_cancel(). It can not remove
+		 * Synchronize with task_work_cancel_match(). It can not remove
 		 * the first entry == work, cmpxchg(task_works) must fail.
 		 * But it can remove another entry from the ->next list.
 		 */
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 069ca78fb0bf..02d96c007673 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -679,17 +679,16 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror = txc->maxerror;
+		time_maxerror = clamp(txc->maxerror, (long long)0, (long long)NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror = txc->esterror;
+		time_esterror = clamp(txc->esterror, (long long)0, (long long)NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant = txc->constant;
+		time_constant = clamp(txc->constant, (long long)0, (long long)MAXTC);
 		if (!(time_status & STA_NANO))
 			time_constant += 4;
-		time_constant = min(time_constant, (long)MAXTC);
-		time_constant = max(time_constant, 0l);
+		time_constant = clamp(time_constant, (long)0, (long)MAXTC);
 	}
 
 	if (txc->modes & ADJ_TAI &&
diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index a9530e866e5f..dc3838c00d6c 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -951,6 +951,30 @@ void hotplug_cpu__broadcast_tick_pull(int deadcpu)
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
diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index d47641f9740b..e6cc8d5ab1a4 100644
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
index c72c865032fa..0cc292256fd3 100644
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
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9cc034e6074c..23fc03f7bf31 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7762,6 +7762,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	bt_cb(skb)->l2cap.psm = psm;
 
 	if (!chan->ops->recv(chan, skb)) {
+		l2cap_chan_unlock(chan);
 		l2cap_chan_put(chan);
 		return;
 	}
diff --git a/net/core/filter.c b/net/core/filter.c
index a3101cdfd47b..99fdd8afeeda 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3535,13 +3535,20 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
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
index 1a455847da54..0311d4d309e1 100644
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
 
 
diff --git a/net/core/xdp.c b/net/core/xdp.c
index fd98d6059007..b2ad644df21f 100644
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
index 412a3c153cad..adfefcd88bbc 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -239,8 +239,7 @@ static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 #else
 static int esp_output_tail_tcp(struct xfrm_state *x, struct sk_buff *skb)
 {
-	kfree_skb(skb);
-
+	WARN_ON(1);
 	return -EOPNOTSUPP;
 }
 #endif
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7a0102a4b1de..a508fd94b8be 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -210,9 +210,10 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nh_group *nhg)
 
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
 
 	return 0;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b3b49d8b386d..1eb1e4316ed6 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1302,7 +1302,7 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
-			.flowi4_tos = RT_TOS(iph->tos),
+			.flowi4_tos = iph->tos & IPTOS_RT_MASK,
 			.flowi4_oif = rt->dst.dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac09d4543f3e..455bb4668407 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1822,7 +1822,8 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 							    master, &dst,
 							    scores, hiscore_idx);
 
-			if (scores[hiscore_idx].ifa)
+			if (scores[hiscore_idx].ifa &&
+			    scores[hiscore_idx].scopedist >= 0)
 				goto out;
 		}
 
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index fddc811bbde1..39154531d455 100644
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
index 14251347c4a5..4f46b0a2e568 100644
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
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 7c73faa5336c..3d0424e4ae6c 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -359,8 +359,8 @@ static void iucv_sever_path(struct sock *sk, int with_user_data)
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
index a4b793d1b7d7..b6dcfca740c1 100644
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
diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
index b921cbdd9aaa..f4034e000f3e 100644
--- a/net/mptcp/mib.c
+++ b/net/mptcp/mib.c
@@ -16,7 +16,9 @@ static const struct snmp_mib mptcp_snmp_list[] = {
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
index 47bcecce1106..a9f43ff00b3c 100644
--- a/net/mptcp/mib.h
+++ b/net/mptcp/mib.h
@@ -9,7 +9,9 @@ enum linux_mptcp_mib_field {
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
index c389d7e47135..f7a91266d5a9 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -708,7 +708,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
 		return true;
 	} else if (subflow_req->mp_join) {
 		opts->suboptions = OPTION_MPTCP_MPJ_SYNACK;
-		opts->backup = subflow_req->backup;
+		opts->backup = subflow_req->request_bkup;
 		opts->join_id = subflow_req->local_id;
 		opts->thmac = subflow_req->thmac;
 		opts->nonce = subflow_req->local_nonce;
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index e19e1525ecbb..1f310abbf1ed 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -225,6 +225,15 @@ int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
 void mptcp_pm_data_init(struct mptcp_sock *msk)
 {
 	msk->pm.add_addr_signaled = 0;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 452c7e21befd..ca57d856d5df 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -84,8 +84,7 @@ static bool address_zero(const struct mptcp_addr_info *addr)
 	return addresses_equal(addr, &zero, false);
 }
 
-static void local_address(const struct sock_common *skc,
-			  struct mptcp_addr_info *addr)
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr)
 {
 	addr->port = 0;
 	addr->family = skc->skc_family;
@@ -120,7 +119,7 @@ static bool lookup_subflow_by_saddr(const struct list_head *list,
 	list_for_each_entry(subflow, list, node) {
 		skc = (struct sock_common *)mptcp_subflow_tcp_sock(subflow);
 
-		local_address(skc, &cur);
+		mptcp_local_address(skc, &cur);
 		if (addresses_equal(&cur, saddr, false))
 			return true;
 	}
@@ -533,8 +532,8 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
 	/* The 0 ID mapping is defined by the first subflow, copied into the msk
 	 * addr
 	 */
-	local_address((struct sock_common *)msk, &msk_local);
-	local_address((struct sock_common *)skc, &skc_local);
+	mptcp_local_address((struct sock_common *)msk, &msk_local);
+	mptcp_local_address((struct sock_common *)skc, &skc_local);
 	if (addresses_equal(&msk_local, &skc_local, false))
 		return 0;
 
@@ -569,6 +568,26 @@ int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc)
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
+			backup = !!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_BACKUP);
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
@@ -759,6 +778,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 	ret = remove_anno_list_by_saddr(msk, addr);
 	if (ret || force) {
 		spin_lock_bh(&msk->pm.lock);
+		msk->pm.add_addr_signaled -= ret;
 		mptcp_pm_remove_addr(msk, addr->id);
 		spin_unlock_bh(&msk->pm.lock);
 	}
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a36493bbf895..a343b3077458 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1124,11 +1124,13 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 		send_info[i].ratio = -1;
 	}
 	mptcp_for_each_subflow(msk, subflow) {
+		bool backup = subflow->backup || subflow->request_bkup;
+
 		ssk =  mptcp_subflow_tcp_sock(subflow);
 		if (!mptcp_subflow_active(subflow))
 			continue;
 
-		nr_active += !subflow->backup;
+		nr_active += !backup;
 		*sndbuf = max(tcp_sk(ssk)->snd_wnd, *sndbuf);
 		if (!sk_stream_memory_free(subflow->tcp_sock))
 			continue;
@@ -1139,9 +1141,9 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk,
 
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
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 3e5af8397434..4348bccb982f 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -261,7 +261,8 @@ struct mptcp_subflow_request_sock {
 	struct	tcp_request_sock sk;
 	u16	mp_capable : 1,
 		mp_join : 1,
-		backup : 1;
+		backup : 1,
+		request_bkup : 1;
 	u8	local_id;
 	u8	remote_id;
 	u64	local_key;
@@ -371,6 +372,7 @@ void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		       struct mptcp_subflow_context *subflow,
 		       long timeout);
 void mptcp_subflow_reset(struct sock *ssk);
+void mptcp_local_address(const struct sock_common *skc, struct mptcp_addr_info *addr);
 
 /* called with sk socket lock held */
 int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
@@ -479,6 +481,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
 			     u8 *rm_id);
 int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc);
 
 void __init mptcp_pm_nl_init(void);
 void mptcp_pm_nl_data_init(struct mptcp_sock *msk);
@@ -488,6 +491,7 @@ void mptcp_pm_nl_add_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *msk);
 void mptcp_pm_nl_rm_subflow_received(struct mptcp_sock *msk, u8 rm_id);
 int mptcp_pm_nl_get_local_id(struct mptcp_sock *msk, struct sock_common *skc);
+bool mptcp_pm_nl_is_backup(struct mptcp_sock *msk, struct mptcp_addr_info *skc);
 
 static inline struct mptcp_ext *mptcp_get_ext(struct sk_buff *skb)
 {
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 276fe9f44df7..ba86cb06d6d8 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -80,6 +80,7 @@ static struct mptcp_sock *subflow_token_join_request(struct request_sock *req,
 		return NULL;
 	}
 	subflow_req->local_id = local_id;
+	subflow_req->request_bkup = mptcp_pm_is_backup(msk, (struct sock_common *)req);
 
 	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
 
@@ -135,6 +136,9 @@ static void subflow_init_req(struct request_sock *req,
 			return;
 	} else if (mp_opt.mp_join) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNRX);
+
+		if (mp_opt.backup)
+			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINSYNBACKUPRX);
 	}
 
 	if (mp_opt.mp_capable && listener->request_mptcp) {
@@ -347,6 +351,9 @@ static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
 
 		subflow->mp_join = 1;
 		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKRX);
+
+		if (subflow->backup)
+			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_JOINSYNACKBACKUPRX);
 	} else if (mptcp_check_fallback(sk)) {
 fallback:
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
@@ -863,14 +870,22 @@ static void mptcp_subflow_discard_data(struct sock *ssk, struct sk_buff *skb,
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
@@ -1387,6 +1402,7 @@ static void subflow_ulp_clone(const struct request_sock *req,
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
index ceb7c988edef..b55e87143c2c 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3413,7 +3413,8 @@ static int ctnetlink_del_expect(struct net *net, struct sock *ctnl,
 
 		if (cda[CTA_EXPECT_ID]) {
 			__be32 id = nla_get_be32(cda[CTA_EXPECT_ID]);
-			if (ntohl(id) != (u32)(unsigned long)exp) {
+
+			if (id != nf_expect_get_id(exp)) {
 				nf_ct_expect_put(exp);
 				return -ENOENT;
 			}
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index f4bbddfbbc24..249c30c47cbd 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2968,13 +2968,13 @@ static struct nft_expr *nft_expr_init(const struct nft_ctx *ctx,
 	return ERR_PTR(err);
 }
 
-int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src)
+int nft_expr_clone(struct nft_expr *dst, struct nft_expr *src, gfp_t gfp)
 {
 	int err;
 
 	if (src->ops->clone) {
 		dst->ops = src->ops;
-		err = src->ops->clone(dst, src);
+		err = src->ops->clone(dst, src, gfp);
 		if (err < 0)
 			return err;
 	} else {
@@ -3349,6 +3349,15 @@ static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *r
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
@@ -3367,6 +3376,9 @@ int nft_chain_validate(const struct nft_ctx *ctx, const struct nft_chain *chain)
 			if (!expr->ops->validate)
 				continue;
 
+			/* This may call nft_chain_validate() recursively,
+			 * callers that do so must increment ctx->level.
+			 */
 			err = expr->ops->validate(ctx, expr, &data);
 			if (err < 0)
 				return err;
@@ -5354,8 +5366,10 @@ static int nf_tables_getsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_get_set_elem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
+		}
 	}
 
 	return err;
@@ -5522,7 +5536,7 @@ static int nft_set_elem_expr_setup(struct nft_ctx *ctx,
 	if (expr == NULL)
 		return 0;
 
-	err = nft_expr_clone(elem_expr, expr);
+	err = nft_expr_clone(elem_expr, expr, GFP_KERNEL);
 	if (err < 0)
 		return -ENOMEM;
 
@@ -5630,7 +5644,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		if (!expr)
 			return -ENOMEM;
 
-		err = nft_expr_clone(expr, set->expr);
+		err = nft_expr_clone(expr, set->expr, GFP_KERNEL);
 		if (err < 0)
 			goto err_set_elem_expr;
 	}
@@ -5848,8 +5862,10 @@ static int nf_tables_newsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_add_set_elem(&ctx, set, attr, nlh->nlmsg_flags);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			return err;
+		}
 	}
 
 	if (nft_net->validate_state == NFT_VALIDATE_DO)
@@ -6058,9 +6074,10 @@ static int nf_tables_delsetelem(struct net *net, struct sock *nlsk,
 
 	nla_for_each_nested(attr, nla[NFTA_SET_ELEM_LIST_ELEMENTS], rem) {
 		err = nft_del_setelem(&ctx, set, attr);
-		if (err < 0)
+		if (err < 0) {
+			NL_SET_BAD_ATTR(extack, attr);
 			break;
-
+		}
 		set->ndeact++;
 	}
 	return err;
@@ -9029,6 +9046,7 @@ static bool nf_tables_valid_genid(struct net *net, u32 genid)
 	bool genid_ok;
 
 	mutex_lock(&nft_net->commit_mutex);
+	nft_net->tstamp = get_jiffies_64();
 
 	genid_ok = genid == 0 || nft_net->base_seq == genid;
 	if (!genid_ok)
@@ -9081,119 +9099,6 @@ int nft_chain_validate_hooks(const struct nft_chain *chain,
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
@@ -9329,7 +9234,7 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 		if (data != NULL &&
 		    (data->verdict.code == NFT_GOTO ||
 		     data->verdict.code == NFT_JUMP)) {
-			err = nf_tables_check_loops(ctx, data->verdict.chain);
+			err = nft_chain_validate(ctx, data->verdict.chain);
 			if (err < 0)
 				return err;
 		}
diff --git a/net/netfilter/nft_connlimit.c b/net/netfilter/nft_connlimit.c
index 7d0761fad37e..091457e5c260 100644
--- a/net/netfilter/nft_connlimit.c
+++ b/net/netfilter/nft_connlimit.c
@@ -195,7 +195,7 @@ static void nft_connlimit_destroy(const struct nft_ctx *ctx,
 	nft_connlimit_do_destroy(ctx, priv);
 }
 
-static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_connlimit_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_connlimit *priv_dst = nft_expr_priv(dst);
 	struct nft_connlimit *priv_src = nft_expr_priv(src);
diff --git a/net/netfilter/nft_counter.c b/net/netfilter/nft_counter.c
index 85ed461ec24e..75fa6fcd6cd6 100644
--- a/net/netfilter/nft_counter.c
+++ b/net/netfilter/nft_counter.c
@@ -224,7 +224,7 @@ static void nft_counter_destroy(const struct nft_ctx *ctx,
 	nft_counter_do_destroy(priv);
 }
 
-static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
+static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src, gfp_t gfp)
 {
 	struct nft_counter_percpu_priv *priv = nft_expr_priv(src);
 	struct nft_counter_percpu_priv *priv_clone = nft_expr_priv(dst);
@@ -234,7 +234,7 @@ static int nft_counter_clone(struct nft_expr *dst, const struct nft_expr *src)
 
 	nft_counter_fetch(priv, &total);
 
-	cpu_stats = alloc_percpu_gfp(struct nft_counter, GFP_ATOMIC);
+	cpu_stats = alloc_percpu_gfp(struct nft_counter, gfp);
 	if (cpu_stats == NULL)
 		return -ENOMEM;
 
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 408b7f5faa5e..9461293182e8 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -48,7 +48,7 @@ static void *nft_dynset_new(struct nft_set *set, const struct nft_expr *expr,
 
 	ext = nft_set_elem_ext(set, elem);
 	if (priv->expr != NULL &&
-	    nft_expr_clone(nft_set_ext_expr(ext), priv->expr) < 0)
+	    nft_expr_clone(nft_set_ext_expr(ext), priv->expr, GFP_ATOMIC) < 0)
 		goto err2;
 
 	return elem;
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index f0a9ad1c4ea4..2499d25a5c85 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -38,6 +38,7 @@ struct nft_rhash_cmp_arg {
 	const struct nft_set		*set;
 	const u32			*key;
 	u8				genmask;
+	u64				tstamp;
 };
 
 static inline u32 nft_rhash_key(const void *data, u32 len, u32 seed)
@@ -64,7 +65,7 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 		return 1;
 	if (nft_set_elem_is_dead(&he->ext))
 		return 1;
-	if (nft_set_elem_expired(&he->ext))
+	if (__nft_set_elem_expired(&he->ext, x->tstamp))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
 		return 1;
@@ -88,6 +89,7 @@ static bool nft_rhash_lookup(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -106,6 +108,7 @@ static void *nft_rhash_get(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_cur(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -129,6 +132,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 		.genmask = NFT_GENMASK_ANY,
 		.set	 = set,
 		.key	 = key,
+		.tstamp  = get_jiffies_64(),
 	};
 
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
@@ -172,6 +176,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 	struct nft_rhash_elem *prev;
 
@@ -214,6 +219,7 @@ static void *nft_rhash_deactivate(const struct net *net,
 		.genmask = nft_genmask_next(net),
 		.set	 = set,
 		.key	 = elem->key.val.data,
+		.tstamp	 = nft_net_tstamp(net),
 	};
 
 	rcu_read_lock();
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 5a8521abd8f5..9e0269e85017 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -504,6 +504,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * @set:	nftables API set representation
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
+ * @tstamp:	timestamp to check for expired elements
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -513,7 +514,8 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
-					  const u8 *data, u8 genmask)
+					  const u8 *data, u8 genmask,
+					  u64 tstamp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -566,7 +568,7 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext))
+			if (__nft_set_elem_expired(&f->mt[b].e->ext, tstamp))
 				goto next_match;
 			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
@@ -603,7 +605,7 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			  nft_genmask_cur(net));
+			  nft_genmask_cur(net), get_jiffies_64());
 }
 
 /**
@@ -1197,6 +1199,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *m = priv->clone;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
@@ -1206,7 +1209,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask);
+	dup = pipapo_get(net, set, start, genmask, tstamp);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1228,7 +1231,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net));
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1580,6 +1583,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 	struct nft_set *set = (struct nft_set *) _set;
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct net *net = read_pnet(&set->net);
+	u64 tstamp = nft_net_tstamp(net);
 	int rules_f0, first_rule = 0;
 	struct nft_trans_gc *gc;
 
@@ -1613,7 +1617,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 		/* synchronous gc never fails, there is no need to set on
 		 * NFT_SET_ELEM_DEAD_BIT.
 		 */
-		if (nft_set_elem_expired(&e->ext)) {
+		if (__nft_set_elem_expired(&e->ext, tstamp)) {
 			priv->dirty = true;
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
@@ -1772,7 +1776,7 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
 	if (IS_ERR(e))
 		return NULL;
 
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 60fb8bc0fdcc..13c7e22c9384 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1129,8 +1129,14 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
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
 
@@ -1140,6 +1146,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	scratch = *raw_cpu_ptr(m->scratch);
 	if (unlikely(!scratch)) {
 		kernel_fpu_end();
+		local_bh_enable();
 		return false;
 	}
 
@@ -1220,6 +1227,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 	if (i % 2)
 		scratch->map_index = !map_index;
 	kernel_fpu_end();
+	local_bh_enable();
 
 	return ret >= 0;
 }
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 18c0d163dc76..bbced30113e4 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -316,6 +316,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree *priv = nft_set_priv(set);
 	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	/* Descend the tree to search for an existing element greater than the
@@ -363,7 +364,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		/* perform garbage collection to avoid bogus overlap reports
 		 * but skip new elements in this transaction.
 		 */
-		if (nft_set_elem_expired(&rbe->ext) &&
+		if (__nft_set_elem_expired(&rbe->ext, tstamp) &&
 		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			const struct nft_rbtree_elem *removed_end;
 
@@ -550,6 +551,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 	const struct rb_node *parent = priv->root.rb_node;
 	struct nft_rbtree_elem *rbe, *this = elem->priv;
 	u8 genmask = nft_genmask_next(net);
+	u64 tstamp = nft_net_tstamp(net);
 	int d;
 
 	while (parent != NULL) {
@@ -570,7 +572,7 @@ static void *nft_rbtree_deactivate(const struct net *net,
 				   nft_rbtree_interval_end(this)) {
 				parent = parent->rb_right;
 				continue;
-			} else if (nft_set_elem_expired(&rbe->ext)) {
+			} else if (__nft_set_elem_expired(&rbe->ext, tstamp)) {
 				break;
 			} else if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = parent->rb_left;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 9bec88fe3505..ce3e20bcde4a 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -503,6 +503,61 @@ static void *packet_current_frame(struct packet_sock *po,
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
@@ -972,10 +1027,16 @@ static void prb_clear_rxhash(struct tpacket_kbdq_core *pkc,
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
@@ -2390,6 +2451,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
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
@@ -2419,7 +2484,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	sll->sll_halen = dev_parse_header(skb, sll->sll_addr);
 	sll->sll_family = AF_PACKET;
 	sll->sll_hatype = dev->type;
-	sll->sll_protocol = skb->protocol;
+	sll->sll_protocol = (sk->sk_type == SOCK_DGRAM) ?
+		vlan_get_protocol_dgram(skb) : skb->protocol;
 	sll->sll_pkttype = skb->pkt_type;
 	if (unlikely(packet_sock_flag(po, PACKET_SOCK_ORIGDEV)))
 		sll->sll_ifindex = orig_dev->ifindex;
@@ -3451,7 +3517,8 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		/* Original length was stored in sockaddr_ll fields */
 		origlen = PACKET_SKB_CB(skb)->sa.origlen;
 		sll->sll_family = AF_PACKET;
-		sll->sll_protocol = skb->protocol;
+		sll->sll_protocol = (sock->type == SOCK_DGRAM) ?
+			vlan_get_protocol_dgram(skb) : skb->protocol;
 	}
 
 	sock_recv_ts_and_drops(msg, sk, skb);
@@ -3506,6 +3573,21 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
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
index a59a8ad38721..4ea7a81707f3 100644
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
index 8f3aab6a4458..8fe1a74f0618 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -723,23 +723,25 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
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
@@ -751,24 +753,24 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
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
@@ -788,19 +790,15 @@ static void __sctp_unhash_endpoint(struct sctp_endpoint *ep)
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
 
@@ -833,7 +831,6 @@ static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(
 					const union sctp_addr *paddr)
 {
 	struct sctp_hashbucket *head;
-	struct sctp_ep_common *epb;
 	struct sctp_endpoint *ep;
 	struct sock *sk;
 	__be16 lport;
@@ -843,8 +840,7 @@ static struct sctp_endpoint *__sctp_rcv_lookup_endpoint(
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
index 79cf4cda2cf6..5053d813e91c 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5193,14 +5193,14 @@ int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
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
index ab9ecdd1af0a..0e9d22e9c760 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1375,21 +1375,31 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 	return rc;
 }
 
-/* convert the RMB size into the compressed notation - minimum 16K.
+#define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
+#define SMCR_RMBE_SIZES		5 /* 0 -> 16KB, 1 -> 32KB, .. 5 -> 512KB */
+
+/* convert the RMB size into the compressed notation (minimum 16K, see
+ * SMCD/R_DMBE_SIZES.
  * In contrast to plain ilog2, this rounds towards the next power of 2,
  * so the socket application gets at least its desired sndbuf / rcvbuf size.
  */
-static u8 smc_compress_bufsize(int size)
+static u8 smc_compress_bufsize(int size, bool is_smcd, bool is_rmb)
 {
 	u8 compressed;
 
 	if (size <= SMC_BUF_MIN_SIZE)
 		return 0;
 
-	size = (size - 1) >> 14;
-	compressed = ilog2(size) + 1;
-	if (compressed >= SMC_RMBE_SIZES)
-		compressed = SMC_RMBE_SIZES - 1;
+	size = (size - 1) >> 14;  /* convert to 16K multiple */
+	compressed = min_t(u8, ilog2(size) + 1,
+			   is_smcd ? SMCD_DMBE_SIZES : SMCR_RMBE_SIZES);
+
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
+	if (!is_smcd && is_rmb)
+		/* RMBs are backed by & limited to max size of scatterlists */
+		compressed = min_t(u8, compressed, ilog2((SG_MAX_SINGLE_ALLOC * PAGE_SIZE) >> 14));
+#endif
+
 	return compressed;
 }
 
@@ -1608,17 +1618,12 @@ static int smcr_buf_map_usable_links(struct smc_link_group *lgr,
 	return rc;
 }
 
-#define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
-
 static struct smc_buf_desc *smcd_new_buf_create(struct smc_link_group *lgr,
 						bool is_dmb, int bufsize)
 {
 	struct smc_buf_desc *buf_desc;
 	int rc;
 
-	if (smc_compress_bufsize(bufsize) > SMCD_DMBE_SIZES)
-		return ERR_PTR(-EAGAIN);
-
 	/* try to alloc a new DMB */
 	buf_desc = kzalloc(sizeof(*buf_desc), GFP_KERNEL);
 	if (!buf_desc)
@@ -1666,9 +1671,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		/* use socket send buffer size (w/o overhead) as start value */
 		sk_buf_size = smc->sk.sk_sndbuf / 2;
 
-	for (bufsize_short = smc_compress_bufsize(sk_buf_size);
+	for (bufsize_short = smc_compress_bufsize(sk_buf_size, is_smcd, is_rmb);
 	     bufsize_short >= 0; bufsize_short--) {
-
 		if (is_rmb) {
 			lock = &lgr->rmbs_lock;
 			buf_list = &lgr->rmbs[bufsize_short];
@@ -1677,8 +1681,6 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 			buf_list = &lgr->sndbufs[bufsize_short];
 		}
 		bufsize = smc_uncompress_bufsize(bufsize_short);
-		if ((1 << get_order(bufsize)) > SG_MAX_SINGLE_ALLOC)
-			continue;
 
 		/* check for reusable slot in the link group */
 		buf_desc = smc_buf_get_slot(bufsize_short, lock, buf_list);
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
index 196a3b11d150..86397f9c4bc8 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2188,12 +2188,13 @@ call_transmit_status(struct rpc_task *task)
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
index a4c9d410eb8d..f4b1b7fee2c0 100644
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
index bf3627dce552..2035d748d923 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -50,11 +50,11 @@
 #endif
 
 /**
- * frwr_release_mr - Destroy one MR
+ * frwr_mr_release - Destroy one MR
  * @mr: MR allocated by frwr_mr_init
  *
  */
-void frwr_release_mr(struct rpcrdma_mr *mr)
+void frwr_mr_release(struct rpcrdma_mr *mr)
 {
 	int rc;
 
@@ -83,10 +83,11 @@ static void frwr_mr_recycle(struct rpcrdma_mr *mr)
 	r_xprt->rx_stats.mrs_recycled++;
 	spin_unlock(&r_xprt->rx_buf.rb_lock);
 
-	frwr_release_mr(mr);
+	frwr_mr_release(mr);
 }
 
-/* frwr_reset - Place MRs back on the free list
+/**
+ * frwr_reset - Place MRs back on @req's free list
  * @req: request to reset
  *
  * Used after a failed marshal. For FRWR, this means the MRs
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 9e9df38b29f7..9262c94a13c1 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -932,6 +932,8 @@ static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt)
 
 static void rpcrdma_req_reset(struct rpcrdma_req *req)
 {
+	struct rpcrdma_mr *mr;
+
 	/* Credits are valid for only one connection */
 	req->rl_slot.rq_cong = 0;
 
@@ -941,7 +943,19 @@ static void rpcrdma_req_reset(struct rpcrdma_req *req)
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
@@ -1100,7 +1114,7 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
 		list_del(&mr->mr_all);
 		spin_unlock(&buf->rb_lock);
 
-		frwr_release_mr(mr);
+		frwr_mr_release(mr);
 	}
 
 	rpcrdma_regbuf_free(req->rl_recvbuf);
@@ -1131,7 +1145,7 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt)
 		list_del(&mr->mr_all);
 		spin_unlock(&buf->rb_lock);
 
-		frwr_release_mr(mr);
+		frwr_mr_release(mr);
 
 		spin_lock(&buf->rb_lock);
 	}
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 702f0344523c..73c8ab89456b 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -520,7 +520,7 @@ rpcrdma_data_dir(bool writing)
 void frwr_reset(struct rpcrdma_req *req);
 int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device);
 int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr);
-void frwr_release_mr(struct rpcrdma_mr *mr);
+void frwr_mr_release(struct rpcrdma_mr *mr);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 3e47501f024f..ec6d7730b852 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -129,8 +129,11 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
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
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 846e40dc00bb..9a6bbf24b0f7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -403,6 +403,10 @@ nl80211_unsol_bcast_probe_resp_policy[NL80211_UNSOL_BCAST_PROBE_RESP_ATTR_MAX +
 						       .len = IEEE80211_MAX_DATA_LEN }
 };
 
+static struct netlink_range_validation q_range = {
+	.max = INT_MAX,
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[0] = { .strict_start_type = NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] = { .type = NLA_U32 },
@@ -685,7 +689,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_TXQ_LIMIT] = { .type = NLA_U32 },
 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] = { .type = NLA_U32 },
-	[NL80211_ATTR_TXQ_QUANTUM] = { .type = NLA_U32 },
+	[NL80211_ATTR_TXQ_QUANTUM] = NLA_POLICY_FULL_RANGE(NLA_U32, &q_range),
 	[NL80211_ATTR_HE_CAPABILITY] =
 		NLA_POLICY_RANGE(NLA_BINARY,
 				 NL80211_HE_MIN_CAPABILITY_LEN,
@@ -3968,10 +3972,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
@@ -3983,10 +3984,7 @@ static void get_key_callback(void *c, struct key_params *params)
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
index 4b32e85c2d9a..37719fc39f64 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1334,7 +1334,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 		 2048, /*  1.000000... */
 	};
 	u32 rates_160M[3] = { 960777777, 907400000, 816666666 };
-	u32 rates_969[3] =  { 480388888, 453700000, 408333333 };
+	u32 rates_996[3] =  { 480388888, 453700000, 408333333 };
 	u32 rates_484[3] =  { 229411111, 216666666, 195000000 };
 	u32 rates_242[3] =  { 114711111, 108333333,  97500000 };
 	u32 rates_106[3] =  {  40000000,  37777777,  34000000 };
@@ -1354,12 +1354,14 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
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
diff --git a/samples/Kconfig b/samples/Kconfig
index e76cdfc50e25..a98e89992a18 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -120,6 +120,14 @@ config SAMPLE_CONNECTOR
 	  with it.
 	  See also Documentation/driver-api/connector.rst
 
+config SAMPLE_FANOTIFY_ERROR
+	bool "Build fanotify error monitoring sample"
+	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
+	help
+	  When enabled, this builds an example code that uses the
+	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
+	  errors.
+
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
 	depends on CC_CAN_LINK && HEADERS_INSTALL
diff --git a/samples/Makefile b/samples/Makefile
index c3392a595e4b..93e2d64bc9a7 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -5,6 +5,7 @@ subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
 subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
 obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
 obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
+obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
 subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
 obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
 obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
diff --git a/samples/fanotify/.gitignore b/samples/fanotify/.gitignore
new file mode 100644
index 000000000000..d74593e8b2de
--- /dev/null
+++ b/samples/fanotify/.gitignore
@@ -0,0 +1 @@
+fs-monitor
diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
new file mode 100644
index 000000000000..e20db1bdde3b
--- /dev/null
+++ b/samples/fanotify/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+userprogs-always-y += fs-monitor
+
+userccflags += -I usr/include -Wall
+
diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
new file mode 100644
index 000000000000..a0e44cd31e6f
--- /dev/null
+++ b/samples/fanotify/fs-monitor.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021, Collabora Ltd.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <err.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/fanotify.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/types.h>
+
+#ifndef FAN_FS_ERROR
+#define FAN_FS_ERROR		0x00008000
+#define FAN_EVENT_INFO_TYPE_ERROR	5
+
+struct fanotify_event_info_error {
+	struct fanotify_event_info_header hdr;
+	__s32 error;
+	__u32 error_count;
+};
+#endif
+
+#ifndef FILEID_INO32_GEN
+#define FILEID_INO32_GEN	1
+#endif
+
+#ifndef FILEID_INVALID
+#define	FILEID_INVALID		0xff
+#endif
+
+static void print_fh(struct file_handle *fh)
+{
+	int i;
+	uint32_t *h = (uint32_t *) fh->f_handle;
+
+	printf("\tfh: ");
+	for (i = 0; i < fh->handle_bytes; i++)
+		printf("%hhx", fh->f_handle[i]);
+	printf("\n");
+
+	printf("\tdecoded fh: ");
+	if (fh->handle_type == FILEID_INO32_GEN)
+		printf("inode=%u gen=%u\n", h[0], h[1]);
+	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
+		printf("Type %d (Superblock error)\n", fh->handle_type);
+	else
+		printf("Type %d (Unknown)\n", fh->handle_type);
+
+}
+
+static void handle_notifications(char *buffer, int len)
+{
+	struct fanotify_event_metadata *event =
+		(struct fanotify_event_metadata *) buffer;
+	struct fanotify_event_info_header *info;
+	struct fanotify_event_info_error *err;
+	struct fanotify_event_info_fid *fid;
+	int off;
+
+	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {
+
+		if (event->mask != FAN_FS_ERROR) {
+			printf("unexpected FAN MARK: %llx\n", event->mask);
+			goto next_event;
+		}
+
+		if (event->fd != FAN_NOFD) {
+			printf("Unexpected fd (!= FAN_NOFD)\n");
+			goto next_event;
+		}
+
+		printf("FAN_FS_ERROR (len=%d)\n", event->event_len);
+
+		for (off = sizeof(*event) ; off < event->event_len;
+		     off += info->len) {
+			info = (struct fanotify_event_info_header *)
+				((char *) event + off);
+
+			switch (info->info_type) {
+			case FAN_EVENT_INFO_TYPE_ERROR:
+				err = (struct fanotify_event_info_error *) info;
+
+				printf("\tGeneric Error Record: len=%d\n",
+				       err->hdr.len);
+				printf("\terror: %d\n", err->error);
+				printf("\terror_count: %d\n", err->error_count);
+				break;
+
+			case FAN_EVENT_INFO_TYPE_FID:
+				fid = (struct fanotify_event_info_fid *) info;
+
+				printf("\tfsid: %x%x\n",
+				       fid->fsid.val[0], fid->fsid.val[1]);
+				print_fh((struct file_handle *) &fid->handle);
+				break;
+
+			default:
+				printf("\tUnknown info type=%d len=%d:\n",
+				       info->info_type, info->len);
+			}
+		}
+next_event:
+		printf("---\n\n");
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int fd;
+
+	char buffer[BUFSIZ];
+
+	if (argc < 2) {
+		printf("Missing path argument\n");
+		return 1;
+	}
+
+	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
+	if (fd < 0)
+		errx(1, "fanotify_init");
+
+	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
+			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
+		errx(1, "fanotify_mark");
+	}
+
+	while (1) {
+		int n = read(fd, buffer, BUFSIZ);
+
+		if (n < 0)
+			errx(1, "read");
+
+		handle_notifications(buffer, n);
+	}
+
+	return 0;
+}
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
index 052f1b920e43..37aa1650c74e 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -1048,6 +1048,13 @@ static int apparmor_socket_sock_rcv_skb(struct sock *sk, struct sk_buff *skb)
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
index 6c2a536173b5..93fcafdaa548 100644
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
index e3ffaf5ad639..c283474ecea5 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1694,7 +1694,7 @@ long keyctl_session_to_parent(void)
 		goto unlock;
 
 	/* cancel an already pending keyring replacement */
-	oldwork = task_work_cancel(parent, key_change_session_keyring);
+	oldwork = task_work_cancel_func(parent, key_change_session_keyring);
 
 	/* the replacement session keyring is applied just prior to userspace
 	 * restarting */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0d1c6c4c1ee6..0ffab5541de8 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1963,6 +1963,8 @@ static int hdmi_add_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 }
 
 static const struct snd_pci_quirk force_connect_list[] = {
+	SND_PCI_QUIRK(0x103c, 0x83e2, "HP EliteDesk 800 G4", 1),
+	SND_PCI_QUIRK(0x103c, 0x83ef, "HP MP9 G4 Retail System AMS", 1),
 	SND_PCI_QUIRK(0x103c, 0x870f, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x871a, "HP", 1),
 	SND_PCI_QUIRK(0x103c, 0x8711, "HP", 1),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 28dbe8cbbffd..e8e9cfb4a935 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8893,6 +8893,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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
 
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 9f66f6dc2c67..77012979e131 100644
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
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 97fe2fadcafb..8f2fb2ac7af6 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2573,6 +2573,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* Stanton ScratchAmp */
+{ USB_DEVICE(0x103d, 0x0100) },
+{ USB_DEVICE(0x103d, 0x0101) },
+
 /* Novation EMS devices */
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x0001),
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index f51e901a9689..0c77f244e5d6 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -245,8 +245,8 @@ static struct snd_pcm_chmap_elem *convert_chmap(int channels, unsigned int bits,
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
index 61aa2c47fbd5..2342aec3c5a3 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1426,10 +1426,12 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
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
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 42806102010b..bbebb1e51b88 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -272,7 +272,7 @@ sort__sym_cmp(struct hist_entry *left, struct hist_entry *right)
 	 * comparing symbol address alone is not enough since it's a
 	 * relative address within a dso.
 	 */
-	if (!hists__has(left->hists, dso) || hists__has(right->hists, dso)) {
+	if (!hists__has(left->hists, dso)) {
 		ret = sort__dso_cmp(left, right);
 		if (ret != 0)
 			return ret;
diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools/testing/selftests/bpf/prog_tests/send_signal.c
index 75b72c751772..0b6349070824 100644
--- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
+++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
@@ -155,7 +155,8 @@ static void test_send_signal_tracepoint(bool signal_thread)
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
index b4c9f4a96ae4..95a1d3ee55a7 100644
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
index fe43556e1a61..956b24ce8145 100644
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
index 85d57633c8b6..61be5993416e 100644
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
diff --git a/tools/testing/selftests/net/forwarding/devlink_lib.sh b/tools/testing/selftests/net/forwarding/devlink_lib.sh
index 9c12c4fd3afc..6edfd207e324 100644
--- a/tools/testing/selftests/net/forwarding/devlink_lib.sh
+++ b/tools/testing/selftests/net/forwarding/devlink_lib.sh
@@ -113,6 +113,8 @@ devlink_reload()
 	still_pending=$(devlink resource show "$DEVLINK_DEV" | \
 			grep -c "size_new")
 	check_err $still_pending "Failed reload - There are still unset sizes"
+
+	udevadm settle
 }
 
 declare -A DEVLINK_ORIG
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

