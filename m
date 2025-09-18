Return-Path: <stable+bounces-176627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA3BB3A278
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 16:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0D26170867
	for <lists+stable@lfdr.de>; Thu, 28 Aug 2025 14:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8D2314B65;
	Thu, 28 Aug 2025 14:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GhF/nG6w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2873E3128B7;
	Thu, 28 Aug 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756392017; cv=none; b=i25Oe05yxaNbZLX6MP/3TMWLirz/AQMJu/xhOIu8eYG99TSM/vZRitzI9yp+UIhtlG/ZiGrrKhC5aWnwGbRldP6BXce6z5aKgSWpibSA5b4BLXTwOznerT7z2k0Xhgh0mtKBkw58RD7xv1f4phD/hrul6k5K6jXEm8caxc/20D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756392017; c=relaxed/simple;
	bh=ogzlOa+kqgPRaiaRu0MthzrwMtOSRZ1P06v8bElDM2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahpEdXr/Tg8HaPdb3Im30oOOKgXMk/NVmsufqKGCpQ3FFbVBY+3JMn9L69mGzjw1JPUdD+IY/UdexDFkpakLbs1NjO0sqodd1g7BwPOFullaT2eDCw40ww+ssyBkbvRkJ04O9tl3Rfoa1P1aVvo/1n1cXaicJJIxK1/EVjuu5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GhF/nG6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914A7C4CEF5;
	Thu, 28 Aug 2025 14:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756392016;
	bh=ogzlOa+kqgPRaiaRu0MthzrwMtOSRZ1P06v8bElDM2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GhF/nG6wA7cvYEe2ElflY/yduJwp2bAq5CrwH+iQPnB9rufWqWF6wxDaXkz95FvE3
	 7MbBDT/kRJOBfGgh3aO3jLCntJtfXj+4ADisqNIcLIybflEjHKjnUmBKUx7o0y9CzH
	 s61A4tPS4FGNQkz3Wet2u5EWdA/ZPKDEEK2lo/JQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.44
Date: Thu, 28 Aug 2025 16:40:05 +0200
Message-ID: <2025082805-headboard-pancreas-0aa7@gregkh>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082805-unusable-android-7d68@gregkh>
References: <2025082805-unusable-android-7d68@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
index 4ebea60b8c5b..8c52fa0ea5f8 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dpu.yaml
@@ -25,7 +25,7 @@ properties:
     maxItems: 1
 
   clocks:
-    minItems: 2
+    maxItems: 2
 
   clock-names:
     items:
diff --git a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
index bc5594d18643..300bf2252c3e 100644
--- a/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
+++ b/Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
@@ -20,7 +20,7 @@ properties:
     maxItems: 2
 
   clocks:
-    minItems: 1
+    maxItems: 1
 
   clock-names:
     items:
diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
index 32fd535a514a..20f341d25ebc 100644
--- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
@@ -33,6 +33,10 @@ properties:
 
   vcc-supply: true
 
+  mediatek,ufs-disable-mcq:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: The mask to disable MCQ (Multi-Circular Queue) for UFS host.
+
 required:
   - compatible
   - clocks
diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 95598c21fc8e..09be0e68b9af 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -12,6 +12,8 @@ add_addr_timeout - INTEGER (seconds)
 	resent to an MPTCP peer that has not acknowledged a previous
 	ADD_ADDR message.
 
+	Do not retransmit if set to 0.
+
 	The default value matches TCP_RTO_MAX. This is a per-namespace
 	sysctl.
 
diff --git a/Makefile b/Makefile
index 3dc8acf73bfa..208a50953301 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 43
+SUBLEVEL = 44
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
@@ -1069,7 +1069,7 @@ KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD
 KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
 
 # userspace programs are linked via the compiler, use the correct linker
-ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_LD_IS_LLD),yy)
+ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += --ld-path=$(LD)
 endif
 
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 7caa2f3ef134..a509a59def42 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1360,6 +1360,7 @@ ufs_0: ufs@14700000 {
 				 <&cmu_hsi2 CLK_GOUT_HSI2_SYSREG_HSI2_PCLK>;
 			clock-names = "core_clk", "sclk_unipro_main", "fmp",
 				      "aclk", "pclk", "sysreg";
+			dma-coherent;
 			freq-table-hz = <0 0>, <0 0>, <0 0>, <0 0>, <0 0>, <0 0>;
 			pinctrl-0 = <&ufs_rst_n &ufs_refclk_out>;
 			pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index 8e9fc00a6b3c..4609f366006e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -69,20 +69,39 @@ vddshv_sdio: regulator-4 {
 		gpios = <&main_gpio0 31 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0>,
 			 <3300000 0x1>;
+		bootph-all;
 	};
 };
 
 &main_pmx0 {
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (V3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (Y1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (V2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (V1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (W2) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (W1) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (Y2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (W3) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (W4) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (V4) MMC0_DAT7 */
+		>;
+	};
+
 	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
 		>;
+		bootph-all;
 	};
 
 	main_gpio1_ioexp_intr_pins_default: main-gpio1-ioexp-intr-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (C13) UART0_RTSn.GPIO1_23 */
 		>;
+		bootph-all;
 	};
 
 	pmic_irq_pins_default: pmic-irq-default-pins {
@@ -118,6 +137,7 @@ exp1: gpio@22 {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
+		bootph-all;
 	};
 
 	exp2: gpio@23 {
@@ -140,6 +160,14 @@ exp2: gpio@23 {
 	};
 };
 
+&sdhci0 {
+	bootph-all;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	status = "okay";
+};
+
 &sdhci1 {
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vddshv_sdio>;
@@ -229,6 +257,14 @@ &tlv320aic3106 {
 	DVDD-supply = <&buck2_reg>;
 };
 
+&main_gpio0 {
+	bootph-all;
+};
+
+&main_gpio1 {
+	bootph-all;
+};
+
 &gpmc0 {
 	ranges = <0 0 0x00 0x51000000 0x01000000>; /* CS0 space. Min partition = 16MB */
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 3f3a31eced97..a74c8b523542 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -553,7 +553,6 @@ sdhci0: mmc@fa10000 {
 		clocks = <&k3_clks 57 5>, <&k3_clks 57 6>;
 		clock-names = "clk_ahb", "clk_xin";
 		bus-width = <8>;
-		mmc-ddr-1_8v;
 		mmc-hs200-1_8v;
 		ti,clkbuf-sel = <0x7>;
 		ti,otap-del-sel-legacy = <0x0>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
index 43488cc8bcb1..ec87d18568fa 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
@@ -317,7 +317,6 @@ serial_flash: flash@0 {
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index f0eac05f7483..86e7f98d430e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -507,16 +507,16 @@ AM62X_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A17) I2C1_SDA */ /* SODIMM 12 */
 	/* Verdin I2C_2_DSI */
 	pinctrl_i2c2: main-i2c2-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x00b0, PIN_INPUT, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */ /* SODIMM 55 */
-			AM62X_IOPAD(0x00b4, PIN_INPUT, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */ /* SODIMM 53 */
+			AM62X_IOPAD(0x00b0, PIN_INPUT_PULLUP, 1) /* (K22) GPMC0_CSn2.I2C2_SCL */ /* SODIMM 55 */
+			AM62X_IOPAD(0x00b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */ /* SODIMM 53 */
 		>;
 	};
 
 	/* Verdin I2C_4_CSI */
 	pinctrl_i2c3: main-i2c3-default-pins {
 		pinctrl-single,pins = <
-			AM62X_IOPAD(0x01d0, PIN_INPUT, 2) /* (A15) UART0_CTSn.I2C3_SCL */ /* SODIMM 95 */
-			AM62X_IOPAD(0x01d4, PIN_INPUT, 2) /* (B15) UART0_RTSn.I2C3_SDA */ /* SODIMM 93 */
+			AM62X_IOPAD(0x01d0, PIN_INPUT_PULLUP, 2) /* (A15) UART0_CTSn.I2C3_SCL */ /* SODIMM 95 */
+			AM62X_IOPAD(0x01d4, PIN_INPUT_PULLUP, 2) /* (B15) UART0_RTSn.I2C3_SDA */ /* SODIMM 93 */
 		>;
 	};
 
@@ -786,8 +786,8 @@ AM62X_MCU_IOPAD(0x0010, PIN_INPUT, 7) /* (C9) MCU_SPI0_D1.MCU_GPIO0_4 */ /* SODI
 	/* Verdin I2C_3_HDMI */
 	pinctrl_mcu_i2c0: mcu-i2c0-default-pins {
 		pinctrl-single,pins = <
-			AM62X_MCU_IOPAD(0x0044, PIN_INPUT, 0) /*  (A8) MCU_I2C0_SCL */ /* SODIMM 59 */
-			AM62X_MCU_IOPAD(0x0048, PIN_INPUT, 0) /* (D10) MCU_I2C0_SDA */ /* SODIMM 57 */
+			AM62X_MCU_IOPAD(0x0044, PIN_INPUT_PULLUP, 0) /*  (A8) MCU_I2C0_SCL */ /* SODIMM 59 */
+			AM62X_MCU_IOPAD(0x0048, PIN_INPUT_PULLUP, 0) /* (D10) MCU_I2C0_SDA */ /* SODIMM 57 */
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index a1cd47d7f5e3..f6ef1549801b 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -818,9 +818,9 @@ &main_spi2 {
 
 &sdhci0 {
 	bootph-all;
+	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_pins_default>;
-	disable-wp;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index ae81ebb39d02..0fa11d3aa71e 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -106,6 +106,22 @@ vcc_1v8: regulator-5 {
 };
 
 &main_pmx0 {
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
 	main_rgmii2_pins_default: main-rgmii2-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -195,6 +211,14 @@ exp1: gpio@22 {
 	};
 };
 
+&sdhci0 {
+	bootph-all;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	status = "okay";
+};
+
 &sdhci1 {
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
index a5aceaa39670..960a409d6fea 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-phycore-som.dtsi
@@ -324,7 +324,6 @@ serial_flash: flash@0 {
 &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
 	non-removable;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 67faf46d7a35..274a92d747d6 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -259,8 +259,8 @@ AM62AX_IOPAD(0x1cc, PIN_OUTPUT, 0) /* (D15) UART0_TXD */
 
 	main_uart1_pins_default: main-uart1-default-pins {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x01e8, PIN_INPUT, 1) /* (C17) I2C1_SCL.UART1_RXD */
-			AM62AX_IOPAD(0x01ec, PIN_OUTPUT, 1) /* (E17) I2C1_SDA.UART1_TXD */
+			AM62AX_IOPAD(0x01ac, PIN_INPUT, 2) /* (B21) MCASP0_AFSR.UART1_RXD */
+			AM62AX_IOPAD(0x01b0, PIN_OUTPUT, 2) /* (A21) MCASP0_ACLKR.UART1_TXD */
 			AM62AX_IOPAD(0x0194, PIN_INPUT, 2) /* (C19) MCASP0_AXR3.UART1_CTSn */
 			AM62AX_IOPAD(0x0198, PIN_OUTPUT, 2) /* (B19) MCASP0_AXR2.UART1_RTSn */
 		>;
@@ -301,6 +301,7 @@ AM62AX_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
 			AM62AX_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
 			AM62AX_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
 		>;
+		bootph-all;
 	};
 
 	main_mmc1_pins_default: main-mmc1-default-pins {
@@ -602,7 +603,7 @@ &sdhci0 {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
+	bootph-all;
 };
 
 &sdhci1 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 3efa12bb7254..b94093a7a392 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -444,8 +444,8 @@ &main_i2c2 {
 
 &sdhci0 {
 	status = "okay";
+	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index 44ff67b6bf1e..4f2d45fd3676 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -182,22 +182,6 @@ AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24/H19) GPMC0_CSn3.I2C2_SDA */
 		>;
 	};
 
-	main_mmc0_pins_default: main-mmc0-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3/V3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1/Y1) MMC0_CLK */
-			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2/V2) MMC0_DAT0 */
-			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1/V1) MMC0_DAT1 */
-			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3/W2) MMC0_DAT2 */
-			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4/W1) MMC0_DAT3 */
-			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2/Y2) MMC0_DAT4 */
-			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1/W3) MMC0_DAT5 */
-			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2/W4) MMC0_DAT6 */
-			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2/V4) MMC0_DAT7 */
-		>;
-	};
-
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -413,14 +397,6 @@ &main_i2c2 {
 	clock-frequency = <400000>;
 };
 
-&sdhci0 {
-	bootph-all;
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-	disable-wp;
-};
-
 &sdhci1 {
 	/* SD/MMC */
 	bootph-all;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 97ca16f00cd2..95c20e39342c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -584,7 +584,6 @@ &sdhci0 {
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 	bootph-all;
 };
 
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index aa7139cc8a92..c30425960398 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -456,7 +456,6 @@ &sdhci0 {
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 /*
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index ae842b85b70d..12af6cb7f65c 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -50,5 +50,4 @@ &sdhci0 {
 	bus-width = <8>;
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
index 1e36965a1403..3238dd17016a 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
@@ -926,7 +926,6 @@ &main_sdhci0 {
 	status = "okay";
 	non-removable;
 	ti,driver-strength-ohm = <50>;
-	disable-wp;
 };
 
 &main_sdhci1 {
diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
index 22b8d73cfd32..04bbedb56b58 100644
--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -8,11 +8,16 @@
 #ifndef DTS_ARM64_TI_K3_PINCTRL_H
 #define DTS_ARM64_TI_K3_PINCTRL_H
 
+#define ST_EN_SHIFT		(14)
 #define PULLUDEN_SHIFT		(16)
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
 #define DEBOUNCE_SHIFT		(11)
 
+/* Schmitt trigger configuration */
+#define ST_DISABLE		(0 << ST_EN_SHIFT)
+#define ST_ENABLE		(1 << ST_EN_SHIFT)
+
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
 
@@ -26,9 +31,13 @@
 #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
 #define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
 #define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
-#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
-#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
+#define PIN_INPUT		(INPUT_EN | ST_ENABLE | PULL_DISABLE)
+#define PIN_INPUT_PULLUP	(INPUT_EN | ST_ENABLE | PULL_UP)
+#define PIN_INPUT_PULLDOWN	(INPUT_EN | ST_ENABLE | PULL_DOWN)
+/* Input configurations with Schmitt Trigger disabled */
+#define PIN_INPUT_NOST		(INPUT_EN | PULL_DISABLE)
+#define PIN_INPUT_PULLUP_NOST	(INPUT_EN | PULL_UP)
+#define PIN_INPUT_PULLDOWN_NOST	(INPUT_EN | PULL_DOWN)
 
 #define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index e2f30ff9afde..a43ba7f9f987 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 #include <linux/ftrace.h>
+#include <linux/sort.h>
 
 Elf_Addr module_emit_got_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr val)
 {
@@ -61,39 +62,38 @@ Elf_Addr module_emit_plt_entry(struct module *mod, Elf_Shdr *sechdrs, Elf_Addr v
 	return (Elf_Addr)&plt[nr];
 }
 
-static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
-{
-	return x->r_info == y->r_info && x->r_addend == y->r_addend;
-}
+#define cmp_3way(a, b)  ((a) < (b) ? -1 : (a) > (b))
 
-static bool duplicate_rela(const Elf_Rela *rela, int idx)
+static int compare_rela(const void *x, const void *y)
 {
-	int i;
+	int ret;
+	const Elf_Rela *rela_x = x, *rela_y = y;
 
-	for (i = 0; i < idx; i++) {
-		if (is_rela_equal(&rela[i], &rela[idx]))
-			return true;
-	}
+	ret = cmp_3way(rela_x->r_info, rela_y->r_info);
+	if (ret == 0)
+		ret = cmp_3way(rela_x->r_addend, rela_y->r_addend);
 
-	return false;
+	return ret;
 }
 
 static void count_max_entries(Elf_Rela *relas, int num,
 			      unsigned int *plts, unsigned int *gots)
 {
-	unsigned int i, type;
+	unsigned int i;
+
+	sort(relas, num, sizeof(Elf_Rela), compare_rela, NULL);
 
 	for (i = 0; i < num; i++) {
-		type = ELF_R_TYPE(relas[i].r_info);
-		switch (type) {
+		if (i && !compare_rela(&relas[i-1], &relas[i]))
+			continue;
+
+		switch (ELF_R_TYPE(relas[i].r_info)) {
 		case R_LARCH_SOP_PUSH_PLT_PCREL:
 		case R_LARCH_B26:
-			if (!duplicate_rela(relas, i))
-				(*plts)++;
+			(*plts)++;
 			break;
 		case R_LARCH_GOT_PC_HI20:
-			if (!duplicate_rela(relas, i))
-				(*gots)++;
+			(*gots)++;
 			break;
 		default:
 			break; /* Do nothing. */
diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 4b0ae29b8aca..b5439a10b765 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1249,9 +1249,11 @@ int kvm_own_lbt(struct kvm_vcpu *vcpu)
 		return -EINVAL;
 
 	preempt_disable();
-	set_csr_euen(CSR_EUEN_LBTEN);
-	_restore_lbt(&vcpu->arch.lbt);
-	vcpu->arch.aux_inuse |= KVM_LARCH_LBT;
+	if (!(vcpu->arch.aux_inuse & KVM_LARCH_LBT)) {
+		set_csr_euen(CSR_EUEN_LBTEN);
+		_restore_lbt(&vcpu->arch.lbt);
+		vcpu->arch.aux_inuse |= KVM_LARCH_LBT;
+	}
 	preempt_enable();
 
 	return 0;
diff --git a/arch/m68k/kernel/head.S b/arch/m68k/kernel/head.S
index ba22bc2f3d6d..d96685489aac 100644
--- a/arch/m68k/kernel/head.S
+++ b/arch/m68k/kernel/head.S
@@ -3400,6 +3400,7 @@ L(console_clear_loop):
 
 	movel	%d4,%d1				/* screen height in pixels */
 	divul	%a0@(FONT_DESC_HEIGHT),%d1	/* d1 = max num rows */
+	subql	#1,%d1				/* row range is 0 to num - 1 */
 
 	movel	%d0,%a2@(Lconsole_struct_num_columns)
 	movel	%d1,%a2@(Lconsole_struct_num_rows)
@@ -3546,15 +3547,14 @@ func_start	console_putc,%a0/%a1/%d0-%d7
 	cmpib	#10,%d7
 	jne	L(console_not_lf)
 	movel	%a0@(Lconsole_struct_cur_row),%d0
-	addil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	movel	%a0@(Lconsole_struct_num_rows),%d1
 	cmpl	%d1,%d0
 	jcs	1f
-	subil	#1,%d0
-	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	console_scroll
+	jra	L(console_exit)
 1:
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_row)
 	jra	L(console_exit)
 
 L(console_not_lf):
@@ -3581,12 +3581,6 @@ L(console_not_cr):
  */
 L(console_not_home):
 	movel	%a0@(Lconsole_struct_cur_column),%d0
-	addql	#1,%a0@(Lconsole_struct_cur_column)
-	movel	%a0@(Lconsole_struct_num_columns),%d1
-	cmpl	%d1,%d0
-	jcs	1f
-	console_putc	#'\n'	/* recursion is OK! */
-1:
 	movel	%a0@(Lconsole_struct_cur_row),%d1
 
 	/*
@@ -3633,6 +3627,23 @@ L(console_do_font_scanline):
 	addq	#1,%d1
 	dbra	%d7,L(console_read_char_scanline)
 
+	/*
+	 *	Register usage in the code below:
+	 *	a0 = pointer to console globals
+	 *	d0 = cursor column
+	 *	d1 = cursor column limit
+	 */
+
+	lea	%pc@(L(console_globals)),%a0
+
+	movel	%a0@(Lconsole_struct_cur_column),%d0
+	addql	#1,%d0
+	movel	%d0,%a0@(Lconsole_struct_cur_column)	/* Update cursor pos */
+	movel	%a0@(Lconsole_struct_num_columns),%d1
+	cmpl	%d1,%d0
+	jcs	L(console_exit)
+	console_putc	#'\n'		/* Line wrap using tail recursion */
+
 L(console_exit):
 func_return	console_putc
 
diff --git a/arch/mips/crypto/chacha-core.S b/arch/mips/crypto/chacha-core.S
index 5755f69cfe00..706aeb850fb0 100644
--- a/arch/mips/crypto/chacha-core.S
+++ b/arch/mips/crypto/chacha-core.S
@@ -55,17 +55,13 @@
 #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define MSB 0
 #define LSB 3
-#define ROTx rotl
-#define ROTR(n) rotr n, 24
 #define	CPU_TO_LE32(n) \
-	wsbh	n; \
+	wsbh	n, n; \
 	rotr	n, 16;
 #else
 #define MSB 3
 #define LSB 0
-#define ROTx rotr
 #define CPU_TO_LE32(n)
-#define ROTR(n)
 #endif
 
 #define FOR_EACH_WORD(x) \
@@ -192,10 +188,10 @@ CONCAT3(.Lchacha_mips_xor_aligned_, PLUS_ONE(x), _b: ;) \
 	xor	X(W), X(B); \
 	xor	X(Y), X(C); \
 	xor	X(Z), X(D); \
-	rotl	X(V), S;    \
-	rotl	X(W), S;    \
-	rotl	X(Y), S;    \
-	rotl	X(Z), S;
+	rotr	X(V), 32 - S; \
+	rotr	X(W), 32 - S; \
+	rotr	X(Y), 32 - S; \
+	rotr	X(Z), 32 - S;
 
 .text
 .set	reorder
@@ -372,21 +368,19 @@ chacha_crypt_arch:
 	/* First byte */
 	lbu	T1, 0(IN)
 	addiu	$at, BYTES, 1
-	CPU_TO_LE32(SAVED_X)
-	ROTR(SAVED_X)
 	xor	T1, SAVED_X
 	sb	T1, 0(OUT)
 	beqz	$at, .Lchacha_mips_xor_done
 	/* Second byte */
 	lbu	T1, 1(IN)
 	addiu	$at, BYTES, 2
-	ROTx	SAVED_X, 8
+	rotr	SAVED_X, 8
 	xor	T1, SAVED_X
 	sb	T1, 1(OUT)
 	beqz	$at, .Lchacha_mips_xor_done
 	/* Third byte */
 	lbu	T1, 2(IN)
-	ROTx	SAVED_X, 8
+	rotr	SAVED_X, 8
 	xor	T1, SAVED_X
 	sb	T1, 2(OUT)
 	b	.Lchacha_mips_xor_done
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 9cd9aa3d16f2..48ae3c79557a 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -39,7 +39,9 @@ endif
 
 export LD_BFD
 
-# Set default 32 bits cross compilers for vdso
+# Set default 32 bits cross compilers for vdso.
+# This means that for 64BIT, both the 64-bit tools and the 32-bit tools
+# need to be in the path.
 CC_ARCHES_32 = hppa hppa2.0 hppa1.1
 CC_SUFFIXES  = linux linux-gnu unknown-linux-gnu suse-linux
 CROSS32_COMPILE := $(call cc-cross-prefix, \
diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
index babf65751e81..3446a5e2520b 100644
--- a/arch/parisc/include/asm/pgtable.h
+++ b/arch/parisc/include/asm/pgtable.h
@@ -276,7 +276,7 @@ extern unsigned long *empty_zero_page;
 #define pte_none(x)     (pte_val(x) == 0)
 #define pte_present(x)	(pte_val(x) & _PAGE_PRESENT)
 #define pte_user(x)	(pte_val(x) & _PAGE_USER)
-#define pte_clear(mm, addr, xp)  set_pte(xp, __pte(0))
+#define pte_clear(mm, addr, xp) set_pte_at((mm), (addr), (xp), __pte(0))
 
 #define pmd_flag(x)	(pmd_val(x) & PxD_FLAG_MASK)
 #define pmd_address(x)	((unsigned long)(pmd_val(x) &~ PxD_FLAG_MASK) << PxD_VALUE_SHIFT)
@@ -398,6 +398,7 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 #define set_ptes set_ptes
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 /* Used for deferring calls to flush_dcache_page() */
 
@@ -462,7 +463,7 @@ static inline int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned
 	if (!pte_young(pte)) {
 		return 0;
 	}
-	set_pte(ptep, pte_mkold(pte));
+	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
 	return 1;
 }
 
@@ -472,7 +473,7 @@ pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *pt
 struct mm_struct;
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	set_pte(ptep, pte_wrprotect(*ptep));
+	set_pte_at(mm, addr, ptep, pte_wrprotect(*ptep));
 }
 
 #define pte_same(A,B)	(pte_val(A) == pte_val(B))
diff --git a/arch/parisc/include/asm/special_insns.h b/arch/parisc/include/asm/special_insns.h
index 51f40eaf7780..1013eeba31e5 100644
--- a/arch/parisc/include/asm/special_insns.h
+++ b/arch/parisc/include/asm/special_insns.h
@@ -32,6 +32,34 @@
 	pa;						\
 })
 
+/**
+ * prober_user() - Probe user read access
+ * @sr:		Space regster.
+ * @va:		Virtual address.
+ *
+ * Return: Non-zero if address is accessible.
+ *
+ * Due to the way _PAGE_READ is handled in TLB entries, we need
+ * a special check to determine whether a user address is accessible.
+ * The ldb instruction does the initial access check. If it is
+ * successful, the probe instruction checks user access rights.
+ */
+#define prober_user(sr, va)	({			\
+	unsigned long read_allowed;			\
+	__asm__ __volatile__(				\
+		"copy %%r0,%0\n"			\
+		"8:\tldb 0(%%sr%1,%2),%%r0\n"		\
+		"\tproberi (%%sr%1,%2),%3,%0\n"		\
+		"9:\n"					\
+		ASM_EXCEPTIONTABLE_ENTRY(8b, 9b,	\
+				"or %%r0,%%r0,%%r0")	\
+		: "=&r" (read_allowed)			\
+		: "i" (sr), "r" (va), "i" (PRIV_USER)	\
+		: "memory"				\
+	);						\
+	read_allowed;					\
+})
+
 #define CR_EIEM 15	/* External Interrupt Enable Mask */
 #define CR_CR16 16	/* CR16 Interval Timer */
 #define CR_EIRR 23	/* External Interrupt Request Register */
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index 88d0ae5769dd..6c531d2c847e 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -42,9 +42,24 @@
 	__gu_err;					\
 })
 
-#define __get_user(val, ptr)				\
-({							\
-	__get_user_internal(SR_USER, val, ptr);	\
+#define __probe_user_internal(sr, error, ptr)			\
+({								\
+	__asm__("\tproberi (%%sr%1,%2),%3,%0\n"			\
+		"\tcmpiclr,= 1,%0,%0\n"				\
+		"\tldi %4,%0\n"					\
+		: "=r"(error)					\
+		: "i"(sr), "r"(ptr), "i"(PRIV_USER),		\
+		  "i"(-EFAULT));				\
+})
+
+#define __get_user(val, ptr)					\
+({								\
+	register long __gu_err;					\
+								\
+	__gu_err = __get_user_internal(SR_USER, val, ptr);	\
+	if (likely(!__gu_err))					\
+		__probe_user_internal(SR_USER, __gu_err, ptr);	\
+	__gu_err;						\
 })
 
 #define __get_user_asm(sr, val, ldx, ptr)		\
diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index db531e58d70e..37ca484cc495 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -429,7 +429,7 @@ static inline pte_t *get_ptep(struct mm_struct *mm, unsigned long addr)
 	return ptep;
 }
 
-static inline bool pte_needs_flush(pte_t pte)
+static inline bool pte_needs_cache_flush(pte_t pte)
 {
 	return (pte_val(pte) & (_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_NO_CACHE))
 		== (_PAGE_PRESENT | _PAGE_ACCESSED);
@@ -630,7 +630,7 @@ static void flush_cache_page_if_present(struct vm_area_struct *vma,
 	ptep = get_ptep(vma->vm_mm, vmaddr);
 	if (ptep) {
 		pte = ptep_get(ptep);
-		needs_flush = pte_needs_flush(pte);
+		needs_flush = pte_needs_cache_flush(pte);
 		pte_unmap(ptep);
 	}
 	if (needs_flush)
@@ -841,7 +841,7 @@ void flush_cache_vmap(unsigned long start, unsigned long end)
 	}
 
 	vm = find_vm_area((void *)start);
-	if (WARN_ON_ONCE(!vm)) {
+	if (!vm) {
 		flush_cache_all();
 		return;
 	}
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index ea57bcc21dc5..f4bf61a34701 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -499,6 +499,12 @@
 	 * this happens is quite subtle, read below */
 	.macro		make_insert_tlb	spc,pte,prot,tmp
 	space_to_prot   \spc \prot        /* create prot id from space */
+
+#if _PAGE_SPECIAL_BIT == _PAGE_DMB_BIT
+	/* need to drop DMB bit, as it's used as SPECIAL flag */
+	depi		0,_PAGE_SPECIAL_BIT,1,\pte
+#endif
+
 	/* The following is the real subtlety.  This is depositing
 	 * T <-> _PAGE_REFTRAP
 	 * D <-> _PAGE_DIRTY
@@ -511,17 +517,18 @@
 	 * Finally, _PAGE_READ goes in the top bit of PL1 (so we
 	 * trigger an access rights trap in user space if the user
 	 * tries to read an unreadable page */
-#if _PAGE_SPECIAL_BIT == _PAGE_DMB_BIT
-	/* need to drop DMB bit, as it's used as SPECIAL flag */
-	depi		0,_PAGE_SPECIAL_BIT,1,\pte
-#endif
 	depd            \pte,8,7,\prot
 
 	/* PAGE_USER indicates the page can be read with user privileges,
 	 * so deposit X1|11 to PL1|PL2 (remember the upper bit of PL1
-	 * contains _PAGE_READ) */
+	 * contains _PAGE_READ). While the kernel can't directly write
+	 * user pages which have _PAGE_WRITE zero, it can read pages
+	 * which have _PAGE_READ zero (PL <= PL1). Thus, the kernel
+	 * exception fault handler doesn't trigger when reading pages
+	 * that aren't user read accessible */
 	extrd,u,*=      \pte,_PAGE_USER_BIT+32,1,%r0
 	depdi		7,11,3,\prot
+
 	/* If we're a gateway page, drop PL2 back to zero for promotion
 	 * to kernel privilege (so we can execute the page as kernel).
 	 * Any privilege promotion page always denys read and write */
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index 0fa81bf1466b..f58c4bccfbce 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -613,6 +613,9 @@ lws_compare_and_swap32:
 lws_compare_and_swap:
 	/* Trigger memory reference interruptions without writing to memory */
 1:	ldw	0(%r26), %r28
+	proberi	(%r26), PRIV_USER, %r28
+	comb,=,n	%r28, %r0, lws_fault /* backwards, likely not taken */
+	nop
 2:	stbys,e	%r0, 0(%r26)
 
 	/* Calculate 8-bit hash index from virtual address */
@@ -767,6 +770,9 @@ cas2_lock_start:
 	copy	%r26, %r28
 	depi_safe	0, 31, 2, %r28
 10:	ldw	0(%r28), %r1
+	proberi	(%r28), PRIV_USER, %r1
+	comb,=,n	%r1, %r0, lws_fault /* backwards, likely not taken */
+	nop
 11:	stbys,e	%r0, 0(%r28)
 
 	/* Calculate 8-bit hash index from virtual address */
@@ -951,41 +957,47 @@ atomic_xchg_begin:
 
 	/* 8-bit exchange */
 1:	ldb	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 	b	atomic_xchg_start
 2:	stbys,e	%r0, 0(%r20)
-	nop
-	nop
-	nop
 
 	/* 16-bit exchange */
 3:	ldh	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 	b	atomic_xchg_start
 4:	stbys,e	%r0, 0(%r20)
-	nop
-	nop
-	nop
 
 	/* 32-bit exchange */
 5:	ldw	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	b	atomic_xchg_start
 6:	stbys,e	%r0, 0(%r23)
 	nop
 	nop
-	nop
-	nop
-	nop
 
 	/* 64-bit exchange */
 #ifdef CONFIG_64BIT
 7:	ldd	0(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 8:	stdby,e	%r0, 0(%r23)
 #else
 7:	ldw	0(%r24), %r20
 8:	ldw	4(%r24), %r20
+	proberi	(%r24), PRIV_USER, %r20
+	comb,=,n	%r20, %r0, lws_fault /* backwards, likely not taken */
+	nop
 	copy	%r23, %r20
 	depi_safe	0, 31, 2, %r20
 9:	stbys,e	%r0, 0(%r20)
diff --git a/arch/parisc/lib/memcpy.c b/arch/parisc/lib/memcpy.c
index 5fc0c852c84c..69d65ffab312 100644
--- a/arch/parisc/lib/memcpy.c
+++ b/arch/parisc/lib/memcpy.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/compiler.h>
 #include <linux/uaccess.h>
+#include <linux/mm.h>
 
 #define get_user_space()	mfsp(SR_USER)
 #define get_kernel_space()	SR_KERNEL
@@ -32,9 +33,25 @@ EXPORT_SYMBOL(raw_copy_to_user);
 unsigned long raw_copy_from_user(void *dst, const void __user *src,
 			       unsigned long len)
 {
+	unsigned long start = (unsigned long) src;
+	unsigned long end = start + len;
+	unsigned long newlen = len;
+
 	mtsp(get_user_space(), SR_TEMP1);
 	mtsp(get_kernel_space(), SR_TEMP2);
-	return pa_memcpy(dst, (void __force *)src, len);
+
+	/* Check region is user accessible */
+	if (start)
+	while (start < end) {
+		if (!prober_user(SR_TEMP1, start)) {
+			newlen = (start - (unsigned long) src);
+			break;
+		}
+		start += PAGE_SIZE;
+		/* align to page boundry which may have different permission */
+		start = PAGE_ALIGN_DOWN(start);
+	}
+	return len - newlen + pa_memcpy(dst, (void __force *)src, newlen);
 }
 EXPORT_SYMBOL(raw_copy_from_user);
 
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index c39de84e98b0..f1785640b049 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -363,6 +363,10 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 	mmap_read_unlock(mm);
 
 bad_area_nosemaphore:
+	if (!user_mode(regs) && fixup_exception(regs)) {
+		return;
+	}
+
 	if (user_mode(regs)) {
 		int signo, si_code;
 
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index fa8518067d38..60a495771c05 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -70,6 +70,7 @@ BOOTCPPFLAGS	:= -nostdinc $(LINUXINCLUDE)
 BOOTCPPFLAGS	+= -isystem $(shell $(BOOTCC) -print-file-name=include)
 
 BOOTCFLAGS	:= $(BOOTTARGETFLAGS) \
+		   -std=gnu11 \
 		   -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		   -fno-strict-aliasing -O2 \
 		   -msoft-float -mno-altivec -mno-vsx \
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index 3fa28db2fe59..14aee8524021 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -471,6 +471,9 @@ void setup_vmem(unsigned long kernel_start, unsigned long kernel_end, unsigned l
 			 lowcore_address + sizeof(struct lowcore),
 			 POPULATE_LOWCORE);
 	for_each_physmem_usable_range(i, &start, &end) {
+		/* Do not map lowcore with identity mapping */
+		if (!start)
+			start = sizeof(struct lowcore);
 		pgtable_populate((unsigned long)__identity_va(start),
 				 (unsigned long)__identity_va(end),
 				 POPULATE_IDENTITY);
diff --git a/arch/s390/hypfs/hypfs_dbfs.c b/arch/s390/hypfs/hypfs_dbfs.c
index 5d9effb0867c..41a0d2066fa0 100644
--- a/arch/s390/hypfs/hypfs_dbfs.c
+++ b/arch/s390/hypfs/hypfs_dbfs.c
@@ -6,6 +6,7 @@
  * Author(s): Michael Holzheu <holzheu@linux.vnet.ibm.com>
  */
 
+#include <linux/security.h>
 #include <linux/slab.h>
 #include "hypfs.h"
 
@@ -66,23 +67,27 @@ static long dbfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	long rc;
 
 	mutex_lock(&df->lock);
-	if (df->unlocked_ioctl)
-		rc = df->unlocked_ioctl(file, cmd, arg);
-	else
-		rc = -ENOTTY;
+	rc = df->unlocked_ioctl(file, cmd, arg);
 	mutex_unlock(&df->lock);
 	return rc;
 }
 
-static const struct file_operations dbfs_ops = {
+static const struct file_operations dbfs_ops_ioctl = {
 	.read		= dbfs_read,
 	.unlocked_ioctl = dbfs_ioctl,
 };
 
+static const struct file_operations dbfs_ops = {
+	.read		= dbfs_read,
+};
+
 void hypfs_dbfs_create_file(struct hypfs_dbfs_file *df)
 {
-	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df,
-					 &dbfs_ops);
+	const struct file_operations *fops = &dbfs_ops;
+
+	if (df->unlocked_ioctl && !security_locked_down(LOCKDOWN_DEBUGFS))
+		fops = &dbfs_ops_ioctl;
+	df->dentry = debugfs_create_file(df->name, 0400, dbfs_dir, df, fops);
 	mutex_init(&df->lock);
 }
 
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index f5936da235c7..16b799f37d6c 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -1285,6 +1285,7 @@ static void svsm_pval_4k_page(unsigned long paddr, bool validate)
 	pc->entry[0].page_size = RMP_PG_SIZE_4K;
 	pc->entry[0].action    = validate;
 	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].rsvd      = 0;
 	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
 
 	/* Protocol 0, Call ID 1 */
@@ -1373,6 +1374,7 @@ static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
 		pe->page_size = RMP_PG_SIZE_4K;
 		pe->action    = action;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = pfn;
 
 		pe++;
@@ -1403,6 +1405,7 @@ static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int d
 		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
 		pe->ignore_cf = 0;
+		pe->rsvd      = 0;
 		pe->pfn       = e->gfn;
 
 		pe++;
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 97771b9d33af..2759524b8ffc 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -94,12 +94,13 @@ DECLARE_STATIC_CALL(xen_hypercall, xen_hypercall_func);
 #ifdef MODULE
 #define __ADDRESSABLE_xen_hypercall
 #else
-#define __ADDRESSABLE_xen_hypercall __ADDRESSABLE_ASM_STR(__SCK__xen_hypercall)
+#define __ADDRESSABLE_xen_hypercall \
+	__stringify(.global STATIC_CALL_KEY(xen_hypercall);)
 #endif
 
 #define __HYPERCALL					\
 	__ADDRESSABLE_xen_hypercall			\
-	"call __SCT__xen_hypercall"
+	__stringify(call STATIC_CALL_TRAMP(xen_hypercall))
 
 #define __HYPERCALL_ENTRY(x)	"a" (x)
 
diff --git a/arch/x86/kernel/cpu/hygon.c b/arch/x86/kernel/cpu/hygon.c
index c5191b06f9f2..d2157f1d2769 100644
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -15,6 +15,7 @@
 #include <asm/cacheinfo.h>
 #include <asm/spec-ctrl.h>
 #include <asm/delay.h>
+#include <asm/resctrl.h>
 
 #include "cpu.h"
 
@@ -116,6 +117,8 @@ static void bsp_init_hygon(struct cpuinfo_x86 *c)
 			x86_amd_ls_cfg_ssbd_mask = 1ULL << 10;
 		}
 	}
+
+	resctrl_cpu_detect(c);
 }
 
 static void early_init_hygon(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8edfb4e4a73d..700926eb77df 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -7578,7 +7578,7 @@ static bool kvm_nx_huge_page_recovery_worker(void *data)
 	return true;
 }
 
-static void kvm_mmu_start_lpage_recovery(struct once *once)
+static int kvm_mmu_start_lpage_recovery(struct once *once)
 {
 	struct kvm_arch *ka = container_of(once, struct kvm_arch, nx_once);
 	struct kvm *kvm = container_of(ka, struct kvm, arch);
@@ -7590,12 +7590,13 @@ static void kvm_mmu_start_lpage_recovery(struct once *once)
 				      kvm, "kvm-nx-lpage-recovery");
 
 	if (IS_ERR(nx_thread))
-		return;
+		return PTR_ERR(nx_thread);
 
 	vhost_task_start(nx_thread);
 
 	/* Make the task visible only once it is fully started. */
 	WRITE_ONCE(kvm->arch.nx_huge_page_recovery_thread, nx_thread);
+	return 0;
 }
 
 int kvm_mmu_post_init_vm(struct kvm *kvm)
@@ -7603,10 +7604,7 @@ int kvm_mmu_post_init_vm(struct kvm *kvm)
 	if (nx_hugepage_mitigation_hard_disabled)
 		return 0;
 
-	call_once(&kvm->arch.nx_once, kvm_mmu_start_lpage_recovery);
-	if (!kvm->arch.nx_huge_page_recovery_thread)
-		return -ENOMEM;
-	return 0;
+	return call_once(&kvm->arch.nx_once, kvm_mmu_start_lpage_recovery);
 }
 
 void kvm_mmu_pre_destroy_vm(struct kvm *kvm)
diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index a38b88baadf2..5722e4128d3c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10437,7 +10437,7 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 				(u64 *)(lin_dma_pkts_arr), DEBUGFS_WRITE64);
 	WREG32(sob_addr, 0);
 
-	kfree(lin_dma_pkts_arr);
+	kvfree(lin_dma_pkts_arr);
 
 	return rc;
 }
diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
index 8b2910995fc1..35c7b04bc9d3 100644
--- a/drivers/acpi/pfr_update.c
+++ b/drivers/acpi/pfr_update.c
@@ -310,7 +310,7 @@ static bool applicable_image(const void *data, struct pfru_update_cap_info *cap,
 	if (type == PFRU_CODE_INJECT_TYPE)
 		return payload_hdr->rt_ver >= cap->code_rt_version;
 
-	return payload_hdr->rt_ver >= cap->drv_rt_version;
+	return payload_hdr->svn_ver >= cap->drv_svn;
 }
 
 static void print_update_debug_info(struct pfru_updated_result *result,
diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e00536b49552..120a2b7067fc 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -117,23 +117,39 @@ config SATA_AHCI
 
 config SATA_MOBILE_LPM_POLICY
 	int "Default SATA Link Power Management policy"
-	range 0 4
+	range 0 5
 	default 3
 	depends on SATA_AHCI
 	help
 	  Select the Default SATA Link Power Management (LPM) policy to use
 	  for chipsets / "South Bridges" supporting low-power modes. Such
 	  chipsets are ubiquitous across laptops, desktops and servers.
-
-	  The value set has the following meanings:
+	  Each policy combines power saving states and features:
+	   - Partial: The Phy logic is powered but is in a reduced power
+                      state. The exit latency from this state is no longer than
+                      10us).
+	   - Slumber: The Phy logic is powered but is in an even lower power
+                      state. The exit latency from this state is potentially
+		      longer, but no longer than 10ms.
+	   - DevSleep: The Phy logic may be powered down. The exit latency from
+	               this state is no longer than 20 ms, unless otherwise
+		       specified by DETO in the device Identify Device Data log.
+	   - HIPM: Host Initiated Power Management (host automatically
+		   transitions to partial and slumber).
+	   - DIPM: Device Initiated Power Management (device automatically
+		   transitions to partial and slumber).
+
+	  The possible values for the default SATA link power management
+	  policies are:
 		0 => Keep firmware settings
-		1 => Maximum performance
-		2 => Medium power
-		3 => Medium power with Device Initiated PM enabled
-		4 => Minimum power
-
-	  Note "Minimum power" is known to cause issues, including disk
-	  corruption, with some disks and should not be used.
+		1 => No power savings (maximum performance)
+		2 => HIPM (Partial)
+		3 => HIPM (Partial) and DIPM (Partial and Slumber)
+		4 => HIPM (Partial and DevSleep) and DIPM (Partial and Slumber)
+		5 => HIPM (Slumber and DevSleep) and DIPM (Partial and Slumber)
+
+	  Excluding the value 0, higher values represent policies with higher
+	  power savings.
 
 config SATA_AHCI_PLATFORM
 	tristate "Platform AHCI SATA support"
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1660f46dc08b..50f5d697297a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -855,18 +855,14 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static const unsigned char stat_table[][4] = {
-		/* Must be first because BUSY means no other bits valid */
-		{0x80,		ABORTED_COMMAND, 0x47, 0x00},
-		// Busy, fake parity for now
-		{0x40,		ILLEGAL_REQUEST, 0x21, 0x04},
-		// Device ready, unaligned write command
-		{0x20,		HARDWARE_ERROR,  0x44, 0x00},
-		// Device fault, internal target failure
-		{0x08,		ABORTED_COMMAND, 0x47, 0x00},
-		// Timed out in xfer, fake parity for now
-		{0x04,		RECOVERED_ERROR, 0x11, 0x00},
-		// Recovered ECC error	  Medium error, recovered
-		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
+		/* Busy: must be first because BUSY means no other bits valid */
+		{ ATA_BUSY,	ABORTED_COMMAND, 0x00, 0x00 },
+		/* Device fault: INTERNAL TARGET FAILURE */
+		{ ATA_DF,	HARDWARE_ERROR,  0x44, 0x00 },
+		/* Corrected data error */
+		{ ATA_CORR,	RECOVERED_ERROR, 0x00, 0x00 },
+
+		{ 0xFF, 0xFF, 0xFF, 0xFF }, /* END mark */
 	};
 
 	/*
@@ -938,6 +934,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
 			    "missing result TF: can't generate ATA PT sense data\n");
+		if (qc->err_mask)
+			ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 		return;
 	}
 
@@ -995,8 +993,8 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 
 	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
 		ata_dev_dbg(dev,
-			    "missing result TF: can't generate sense data\n");
-		return;
+			    "Missing result TF: reporting aborted command\n");
+		goto aborted;
 	}
 
 	/* Use ata_to_sense_error() to map status register bits
@@ -1007,19 +1005,20 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
-	} else {
-		/* Could not decode error */
-		ata_dev_warn(dev, "could not decode error status 0x%x err_mask 0x%x\n",
-			     tf->status, qc->err_mask);
-		ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
-		return;
-	}
 
-	block = ata_tf_read_block(&qc->result_tf, dev);
-	if (block == U64_MAX)
+		block = ata_tf_read_block(&qc->result_tf, dev);
+		if (block != U64_MAX)
+			scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE,
+						   block);
 		return;
+	}
 
-	scsi_set_sense_information(sb, SCSI_SENSE_BUFFERSIZE, block);
+	/* Could not decode error */
+	ata_dev_warn(dev,
+		"Could not decode error 0x%x, status 0x%x (err_mask=0x%x)\n",
+		tf->error, tf->status, qc->err_mask);
+aborted:
+	ata_scsi_set_sense(dev, cmd, ABORTED_COMMAND, 0, 0);
 }
 
 void ata_scsi_sdev_config(struct scsi_device *sdev)
@@ -3756,21 +3755,16 @@ static int ata_mselect_control_ata_feature(struct ata_queued_cmd *qc,
 	/* Check cdl_ctrl */
 	switch (buf[0] & 0x03) {
 	case 0:
-		/* Disable CDL if it is enabled */
-		if (!(dev->flags & ATA_DFLAG_CDL_ENABLED))
-			return 0;
+		/* Disable CDL */
 		ata_dev_dbg(dev, "Disabling CDL\n");
 		cdl_action = 0;
 		dev->flags &= ~ATA_DFLAG_CDL_ENABLED;
 		break;
 	case 0x02:
 		/*
-		 * Enable CDL if not already enabled. Since this is mutually
-		 * exclusive with NCQ priority, allow this only if NCQ priority
-		 * is disabled.
+		 * Enable CDL. Since CDL is mutually exclusive with NCQ
+		 * priority, allow this only if NCQ priority is disabled.
 		 */
-		if (dev->flags & ATA_DFLAG_CDL_ENABLED)
-			return 0;
 		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLED) {
 			ata_dev_err(dev,
 				"NCQ priority must be disabled to enable CDL\n");
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 317505eab126..c7ec69597a95 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1183,10 +1183,12 @@ EXPORT_SYMBOL_GPL(__pm_runtime_resume);
  *
  * Return -EINVAL if runtime PM is disabled for @dev.
  *
- * Otherwise, if the runtime PM status of @dev is %RPM_ACTIVE and either
- * @ign_usage_count is %true or the runtime PM usage counter of @dev is not
- * zero, increment the usage counter of @dev and return 1. Otherwise, return 0
- * without changing the usage counter.
+ * Otherwise, if its runtime PM status is %RPM_ACTIVE and (1) @ign_usage_count
+ * is set, or (2) @dev is not ignoring children and its active child count is
+ * nonero, or (3) the runtime PM usage counter of @dev is not zero, increment
+ * the usage counter of @dev and return 1.
+ *
+ * Otherwise, return 0 without changing the usage counter.
  *
  * If @ign_usage_count is %true, this function can be used to prevent suspending
  * the device when its runtime PM status is %RPM_ACTIVE.
@@ -1208,7 +1210,8 @@ static int pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
 		retval = -EINVAL;
 	} else if (dev->power.runtime_status != RPM_ACTIVE) {
 		retval = 0;
-	} else if (ign_usage_count) {
+	} else if (ign_usage_count || (!dev->power.ignore_children &&
+		   atomic_read(&dev->power.child_count) > 0)) {
 		retval = 1;
 		atomic_inc(&dev->power.usage_count);
 	} else {
@@ -1241,10 +1244,16 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_active);
  * @dev: Target device.
  *
  * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * %RPM_ACTIVE and its runtime PM usage counter is greater than 0, in which case
- * it returns 1. If the device is in a different state or its usage_count is 0,
- * 0 is returned. -EINVAL is returned if runtime PM is disabled for the device,
- * in which case also the usage_count will remain unmodified.
+ * %RPM_ACTIVE and its runtime PM usage counter is greater than 0 or it is not
+ * ignoring children and its active child count is nonzero.  1 is returned in
+ * this case.
+ *
+ * If @dev is in a different state or it is not in use (that is, its usage
+ * counter is 0, or it is ignoring children, or its active child count is 0),
+ * 0 is returned.
+ *
+ * -EINVAL is returned if runtime PM is disabled for the device, in which case
+ * also the usage counter of @dev is not updated.
  */
 int pm_runtime_get_if_in_use(struct device *dev)
 {
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 05de2e6f563d..07979d47eb76 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -642,12 +642,7 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	 * WMT command.
 	 */
 	err = wait_on_bit_timeout(&data->flags, BTMTK_TX_WAIT_VND_EVT,
-				  TASK_INTERRUPTIBLE, HCI_INIT_TIMEOUT);
-	if (err == -EINTR) {
-		bt_dev_err(hdev, "Execution of wmt command interrupted");
-		clear_bit(BTMTK_TX_WAIT_VND_EVT, &data->flags);
-		goto err_free_wc;
-	}
+				  TASK_UNINTERRUPTIBLE, HCI_INIT_TIMEOUT);
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
index dedd29ca8db3..05c896b192fd 100644
--- a/drivers/bus/mhi/host/boot.c
+++ b/drivers/bus/mhi/host/boot.c
@@ -31,8 +31,8 @@ int mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
 	int ret;
 
 	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = mhi_buf->len;
+		bhi_vec->dma_addr = cpu_to_le64(mhi_buf->dma_addr);
+		bhi_vec->size = cpu_to_le64(mhi_buf->len);
 	}
 
 	dev_dbg(dev, "BHIe programming for RDDM\n");
@@ -375,8 +375,8 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 	while (remainder) {
 		to_cpy = min(remainder, mhi_buf->len);
 		memcpy(mhi_buf->buf, buf, to_cpy);
-		bhi_vec->dma_addr = mhi_buf->dma_addr;
-		bhi_vec->size = to_cpy;
+		bhi_vec->dma_addr = cpu_to_le64(mhi_buf->dma_addr);
+		bhi_vec->size = cpu_to_le64(to_cpy);
 
 		buf += to_cpy;
 		remainder -= to_cpy;
diff --git a/drivers/bus/mhi/host/internal.h b/drivers/bus/mhi/host/internal.h
index d057e877932e..762df4bb7f64 100644
--- a/drivers/bus/mhi/host/internal.h
+++ b/drivers/bus/mhi/host/internal.h
@@ -25,8 +25,8 @@ struct mhi_ctxt {
 };
 
 struct bhi_vec_entry {
-	u64 dma_addr;
-	u64 size;
+	__le64 dma_addr;
+	__le64 size;
 };
 
 enum mhi_ch_state_type {
diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
index aa8a0ef697c7..45ec1b585577 100644
--- a/drivers/bus/mhi/host/main.c
+++ b/drivers/bus/mhi/host/main.c
@@ -602,7 +602,7 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 	{
 		dma_addr_t ptr = MHI_TRE_GET_EV_PTR(event);
 		struct mhi_ring_element *local_rp, *ev_tre;
-		void *dev_rp;
+		void *dev_rp, *next_rp;
 		struct mhi_buf_info *buf_info;
 		u16 xfer_len;
 
@@ -621,6 +621,16 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
 		result.dir = mhi_chan->dir;
 
 		local_rp = tre_ring->rp;
+
+		next_rp = local_rp + 1;
+		if (next_rp >= tre_ring->base + tre_ring->len)
+			next_rp = tre_ring->base;
+		if (dev_rp != next_rp && !MHI_TRE_DATA_GET_CHAIN(local_rp)) {
+			dev_err(&mhi_cntrl->mhi_dev->dev,
+				"Event element points to an unexpected TRE\n");
+			break;
+		}
+
 		while (local_rp != dev_rp) {
 			buf_info = buf_ring->rp;
 			/* If it's the last TRE, get length from the event */
diff --git a/drivers/cdx/controller/cdx_rpmsg.c b/drivers/cdx/controller/cdx_rpmsg.c
index 04b578a0be17..61f1a290ff08 100644
--- a/drivers/cdx/controller/cdx_rpmsg.c
+++ b/drivers/cdx/controller/cdx_rpmsg.c
@@ -129,8 +129,7 @@ static int cdx_rpmsg_probe(struct rpmsg_device *rpdev)
 
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = rpdev->dst;
-	strscpy(chinfo.name, cdx_rpmsg_id_table[0].name,
-		strlen(cdx_rpmsg_id_table[0].name));
+	strscpy(chinfo.name, cdx_rpmsg_id_table[0].name, sizeof(chinfo.name));
 
 	cdx_mcdi->ept = rpmsg_create_ept(rpdev, cdx_rpmsg_cb, NULL, chinfo);
 	if (!cdx_mcdi->ept) {
diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index bd8a44ea62d2..2a65d7fd0375 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1587,6 +1587,9 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 				memset(&data[n], 0, (MIN_SAMPLES - n) *
 						    sizeof(unsigned int));
 			}
+		} else {
+			memset(data, 0, max_t(unsigned int, n, MIN_SAMPLES) *
+					sizeof(unsigned int));
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
@@ -1670,6 +1673,8 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			memset(&data[insn->n], 0,
 			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
 		}
+	} else {
+		memset(data, 0, n_data * sizeof(unsigned int));
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index f1dc854928c1..c9ebaadc5e82 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -620,11 +620,9 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	unsigned int chan = CR_CHAN(insn->chanspec);
 	unsigned int base_chan = (chan < 32) ? 0 : chan;
 	unsigned int _data[2];
+	unsigned int i;
 	int ret;
 
-	if (insn->n == 0)
-		return 0;
-
 	memset(_data, 0, sizeof(_data));
 	memset(&_insn, 0, sizeof(_insn));
 	_insn.insn = INSN_BITS;
@@ -635,18 +633,21 @@ static int insn_rw_emulate_bits(struct comedi_device *dev,
 	if (insn->insn == INSN_WRITE) {
 		if (!(s->subdev_flags & SDF_WRITABLE))
 			return -EINVAL;
-		_data[0] = 1U << (chan - base_chan);		     /* mask */
-		_data[1] = data[0] ? (1U << (chan - base_chan)) : 0; /* bits */
+		_data[0] = 1U << (chan - base_chan);		/* mask */
 	}
+	for (i = 0; i < insn->n; i++) {
+		if (insn->insn == INSN_WRITE)
+			_data[1] = data[i] ? _data[0] : 0;	/* bits */
 
-	ret = s->insn_bits(dev, s, &_insn, _data);
-	if (ret < 0)
-		return ret;
+		ret = s->insn_bits(dev, s, &_insn, _data);
+		if (ret < 0)
+			return ret;
 
-	if (insn->insn == INSN_READ)
-		data[0] = (_data[1] >> (chan - base_chan)) & 1;
+		if (insn->insn == INSN_READ)
+			data[i] = (_data[1] >> (chan - base_chan)) & 1;
+	}
 
-	return 1;
+	return insn->n;
 }
 
 static int __comedi_device_postconfig_async(struct comedi_device *dev,
diff --git a/drivers/comedi/drivers/pcl726.c b/drivers/comedi/drivers/pcl726.c
index 0430630e6ebb..b542896fa0e4 100644
--- a/drivers/comedi/drivers/pcl726.c
+++ b/drivers/comedi/drivers/pcl726.c
@@ -328,7 +328,8 @@ static int pcl726_attach(struct comedi_device *dev,
 	 * Hook up the external trigger source interrupt only if the
 	 * user config option is valid and the board supports interrupts.
 	 */
-	if (it->options[1] && (board->irq_mask & (1 << it->options[1]))) {
+	if (it->options[1] > 0 && it->options[1] < 16 &&
+	    (board->irq_mask & (1U << it->options[1]))) {
 		ret = request_irq(it->options[1], pcl726_interrupt, 0,
 				  dev->board_name, dev);
 		if (ret == 0) {
diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index ccbc826cc4c0..e7bb4e9c70e0 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -103,7 +103,7 @@ static void armada_8k_cpufreq_free_table(struct freq_table *freq_tables)
 {
 	int opps_index, nb_cpus = num_possible_cpus();
 
-	for (opps_index = 0 ; opps_index <= nb_cpus; opps_index++) {
+	for (opps_index = 0 ; opps_index < nb_cpus; opps_index++) {
 		int i;
 
 		/* If cpu_dev is NULL then we reached the end of the array */
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 01322a905414..3eb543b1644d 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -19,7 +19,7 @@
 
 #include "gov.h"
 
-#define BUCKETS 12
+#define BUCKETS 6
 #define INTERVAL_SHIFT 3
 #define INTERVALS (1UL << INTERVAL_SHIFT)
 #define RESOLUTION 1024
@@ -29,12 +29,11 @@
 /*
  * Concepts and ideas behind the menu governor
  *
- * For the menu governor, there are 3 decision factors for picking a C
+ * For the menu governor, there are 2 decision factors for picking a C
  * state:
  * 1) Energy break even point
- * 2) Performance impact
- * 3) Latency tolerance (from pmqos infrastructure)
- * These three factors are treated independently.
+ * 2) Latency tolerance (from pmqos infrastructure)
+ * These two factors are treated independently.
  *
  * Energy break even point
  * -----------------------
@@ -75,30 +74,6 @@
  * intervals and if the stand deviation of these 8 intervals is below a
  * threshold value, we use the average of these intervals as prediction.
  *
- * Limiting Performance Impact
- * ---------------------------
- * C states, especially those with large exit latencies, can have a real
- * noticeable impact on workloads, which is not acceptable for most sysadmins,
- * and in addition, less performance has a power price of its own.
- *
- * As a general rule of thumb, menu assumes that the following heuristic
- * holds:
- *     The busier the system, the less impact of C states is acceptable
- *
- * This rule-of-thumb is implemented using a performance-multiplier:
- * If the exit latency times the performance multiplier is longer than
- * the predicted duration, the C state is not considered a candidate
- * for selection due to a too high performance impact. So the higher
- * this multiplier is, the longer we need to be idle to pick a deep C
- * state, and thus the less likely a busy CPU will hit such a deep
- * C state.
- *
- * Currently there is only one value determining the factor:
- * 10 points are added for each process that is waiting for IO on this CPU.
- * (This value was experimentally determined.)
- * Utilization is no longer a factor as it was shown that it never contributed
- * significantly to the performance multiplier in the first place.
- *
  */
 
 struct menu_device {
@@ -112,19 +87,10 @@ struct menu_device {
 	int		interval_ptr;
 };
 
-static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
+static inline int which_bucket(u64 duration_ns)
 {
 	int bucket = 0;
 
-	/*
-	 * We keep two groups of stats; one with no
-	 * IO pending, one without.
-	 * This allows us to calculate
-	 * E(duration)|iowait
-	 */
-	if (nr_iowaiters)
-		bucket = BUCKETS/2;
-
 	if (duration_ns < 10ULL * NSEC_PER_USEC)
 		return bucket;
 	if (duration_ns < 100ULL * NSEC_PER_USEC)
@@ -138,19 +104,6 @@ static inline int which_bucket(u64 duration_ns, unsigned int nr_iowaiters)
 	return bucket + 5;
 }
 
-/*
- * Return a multiplier for the exit latency that is intended
- * to take performance requirements into account.
- * The more performance critical we estimate the system
- * to be, the higher this multiplier, and thus the higher
- * the barrier to go to an expensive C state.
- */
-static inline int performance_multiplier(unsigned int nr_iowaiters)
-{
-	/* for IO wait tasks (per cpu!) we add 10x each */
-	return 1 + 10 * nr_iowaiters;
-}
-
 static DEFINE_PER_CPU(struct menu_device, menu_devices);
 
 static void menu_update_intervals(struct menu_device *data, unsigned int interval_us)
@@ -277,8 +230,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 	struct menu_device *data = this_cpu_ptr(&menu_devices);
 	s64 latency_req = cpuidle_governor_latency_req(dev->cpu);
 	u64 predicted_ns;
-	u64 interactivity_req;
-	unsigned int nr_iowaiters;
 	ktime_t delta, delta_tick;
 	int i, idx;
 
@@ -295,8 +246,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		menu_update_intervals(data, UINT_MAX);
 	}
 
-	nr_iowaiters = nr_iowait_cpu(dev->cpu);
-
 	/* Find the shortest expected idle interval. */
 	predicted_ns = get_typical_interval(data) * NSEC_PER_USEC;
 	if (predicted_ns > RESIDENCY_THRESHOLD_NS) {
@@ -310,7 +259,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		}
 
 		data->next_timer_ns = delta;
-		data->bucket = which_bucket(data->next_timer_ns, nr_iowaiters);
+		data->bucket = which_bucket(data->next_timer_ns);
 
 		/* Round up the result for half microseconds. */
 		timer_us = div_u64((RESOLUTION * DECAY * NSEC_PER_USEC) / 2 +
@@ -328,7 +277,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		 */
 		data->next_timer_ns = KTIME_MAX;
 		delta_tick = TICK_NSEC / 2;
-		data->bucket = which_bucket(KTIME_MAX, nr_iowaiters);
+		data->bucket = which_bucket(KTIME_MAX);
 	}
 
 	if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
@@ -344,27 +293,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		return 0;
 	}
 
-	if (tick_nohz_tick_stopped()) {
-		/*
-		 * If the tick is already stopped, the cost of possible short
-		 * idle duration misprediction is much higher, because the CPU
-		 * may be stuck in a shallow idle state for a long time as a
-		 * result of it.  In that case say we might mispredict and use
-		 * the known time till the closest timer event for the idle
-		 * state selection.
-		 */
-		if (predicted_ns < TICK_NSEC)
-			predicted_ns = data->next_timer_ns;
-	} else {
-		/*
-		 * Use the performance multiplier and the user-configurable
-		 * latency_req to determine the maximum exit latency.
-		 */
-		interactivity_req = div64_u64(predicted_ns,
-					      performance_multiplier(nr_iowaiters));
-		if (latency_req > interactivity_req)
-			latency_req = interactivity_req;
-	}
+	/*
+	 * If the tick is already stopped, the cost of possible short idle
+	 * duration misprediction is much higher, because the CPU may be stuck
+	 * in a shallow idle state for a long time as a result of it.  In that
+	 * case, say we might mispredict and use the known time till the closest
+	 * timer event for the idle state selection.
+	 */
+	if (tick_nohz_tick_stopped() && predicted_ns < TICK_NSEC)
+		predicted_ns = data->next_timer_ns;
 
 	/*
 	 * Find the idle state with the lowest power while satisfying
@@ -380,13 +317,15 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 		if (idx == -1)
 			idx = i; /* first enabled state */
 
+		if (s->exit_latency_ns > latency_req)
+			break;
+
 		if (s->target_residency_ns > predicted_ns) {
 			/*
 			 * Use a physical idle state, not busy polling, unless
 			 * a timer is going to trigger soon enough.
 			 */
 			if ((drv->states[idx].flags & CPUIDLE_FLAG_POLLING) &&
-			    s->exit_latency_ns <= latency_req &&
 			    s->target_residency_ns <= data->next_timer_ns) {
 				predicted_ns = s->target_residency_ns;
 				idx = i;
@@ -418,8 +357,6 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
 
 			return idx;
 		}
-		if (s->exit_latency_ns > latency_req)
-			break;
 
 		idx = i;
 	}
diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index d4b39184dbdb..707760fa1978 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -830,7 +830,7 @@ static int caam_ctrl_suspend(struct device *dev)
 {
 	const struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
 
-	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en)
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->no_page0)
 		caam_state_save(dev);
 
 	return 0;
@@ -841,7 +841,7 @@ static int caam_ctrl_resume(struct device *dev)
 	struct caam_drv_private *ctrlpriv = dev_get_drvdata(dev);
 	int ret = 0;
 
-	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en) {
+	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->no_page0) {
 		caam_state_restore(dev);
 
 		/* HW and rng will be reset so deinstantiation can be removed */
@@ -907,6 +907,7 @@ static int caam_probe(struct platform_device *pdev)
 
 		imx_soc_data = imx_soc_match->data;
 		reg_access = reg_access && imx_soc_data->page0_access;
+		ctrlpriv->no_page0 = !reg_access;
 		/*
 		 * CAAM clocks cannot be controlled from kernel.
 		 */
diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h
index e51320150872..51c90d17a40d 100644
--- a/drivers/crypto/caam/intern.h
+++ b/drivers/crypto/caam/intern.h
@@ -115,6 +115,7 @@ struct caam_drv_private {
 	u8 blob_present;	/* Nonzero if BLOB support present in device */
 	u8 mc_en;		/* Nonzero if MC f/w is active */
 	u8 optee_en;		/* Nonzero if OP-TEE f/w is active */
+	u8 no_page0;		/* Nonzero if register page 0 is not controlled by Linux */
 	bool pr_support;        /* RNG prediction resistance available */
 	int secvio_irq;		/* Security violation interrupt number */
 	int virt_en;		/* Virtualization enabled in CAAM */
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index f7ecabdf7805..25c940b06c36 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -190,6 +190,7 @@ void adf_exit_misc_wq(void);
 bool adf_misc_wq_queue_work(struct work_struct *work);
 bool adf_misc_wq_queue_delayed_work(struct delayed_work *work,
 				    unsigned long delay);
+void adf_misc_wq_flush(void);
 #if defined(CONFIG_PCI_IOV)
 int adf_sriov_configure(struct pci_dev *pdev, int numvfs);
 void adf_disable_sriov(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_init.c b/drivers/crypto/intel/qat/qat_common/adf_init.c
index f189cce7d153..46491048e0bb 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_init.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_init.c
@@ -404,6 +404,7 @@ static void adf_dev_shutdown(struct adf_accel_dev *accel_dev)
 		hw_data->exit_admin_comms(accel_dev);
 
 	adf_cleanup_etr_data(accel_dev);
+	adf_misc_wq_flush();
 	adf_dev_restore(accel_dev);
 }
 
diff --git a/drivers/crypto/intel/qat/qat_common/adf_isr.c b/drivers/crypto/intel/qat/qat_common/adf_isr.c
index cae1aee5479a..12e565613661 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_isr.c
@@ -407,3 +407,8 @@ bool adf_misc_wq_queue_delayed_work(struct delayed_work *work,
 {
 	return queue_delayed_work(adf_misc_wq, work, delay);
 }
+
+void adf_misc_wq_flush(void)
+{
+	flush_workqueue(adf_misc_wq);
+}
diff --git a/drivers/crypto/intel/qat/qat_common/qat_algs.c b/drivers/crypto/intel/qat/qat_common/qat_algs.c
index 3c4bba4a8779..d69cc1e5e023 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_algs.c
@@ -1277,7 +1277,7 @@ static struct aead_alg qat_aeads[] = { {
 	.base = {
 		.cra_name = "authenc(hmac(sha1),cbc(aes))",
 		.cra_driver_name = "qat_aes_cbc_hmac_sha1",
-		.cra_priority = 4001,
+		.cra_priority = 100,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
@@ -1294,7 +1294,7 @@ static struct aead_alg qat_aeads[] = { {
 	.base = {
 		.cra_name = "authenc(hmac(sha256),cbc(aes))",
 		.cra_driver_name = "qat_aes_cbc_hmac_sha256",
-		.cra_priority = 4001,
+		.cra_priority = 100,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
@@ -1311,7 +1311,7 @@ static struct aead_alg qat_aeads[] = { {
 	.base = {
 		.cra_name = "authenc(hmac(sha512),cbc(aes))",
 		.cra_driver_name = "qat_aes_cbc_hmac_sha512",
-		.cra_priority = 4001,
+		.cra_priority = 100,
 		.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
 		.cra_blocksize = AES_BLOCK_SIZE,
 		.cra_ctxsize = sizeof(struct qat_alg_aead_ctx),
@@ -1329,7 +1329,7 @@ static struct aead_alg qat_aeads[] = { {
 static struct skcipher_alg qat_skciphers[] = { {
 	.base.cra_name = "cbc(aes)",
 	.base.cra_driver_name = "qat_aes_cbc",
-	.base.cra_priority = 4001,
+	.base.cra_priority = 100,
 	.base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
 	.base.cra_blocksize = AES_BLOCK_SIZE,
 	.base.cra_ctxsize = sizeof(struct qat_alg_skcipher_ctx),
@@ -1347,7 +1347,7 @@ static struct skcipher_alg qat_skciphers[] = { {
 }, {
 	.base.cra_name = "ctr(aes)",
 	.base.cra_driver_name = "qat_aes_ctr",
-	.base.cra_priority = 4001,
+	.base.cra_priority = 100,
 	.base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_ALLOCATES_MEMORY,
 	.base.cra_blocksize = 1,
 	.base.cra_ctxsize = sizeof(struct qat_alg_skcipher_ctx),
@@ -1365,7 +1365,7 @@ static struct skcipher_alg qat_skciphers[] = { {
 }, {
 	.base.cra_name = "xts(aes)",
 	.base.cra_driver_name = "qat_aes_xts",
-	.base.cra_priority = 4001,
+	.base.cra_priority = 100,
 	.base.cra_flags = CRYPTO_ALG_ASYNC | CRYPTO_ALG_NEED_FALLBACK |
 			  CRYPTO_ALG_ALLOCATES_MEMORY,
 	.base.cra_blocksize = AES_BLOCK_SIZE,
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h b/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
index e27e849b01df..90a031421aac 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
+++ b/drivers/crypto/marvell/octeontx2/otx2_cpt_reqmgr.h
@@ -34,6 +34,9 @@
 #define SG_COMP_2    2
 #define SG_COMP_1    1
 
+#define OTX2_CPT_DPTR_RPTR_ALIGN	8
+#define OTX2_CPT_RES_ADDR_ALIGN		32
+
 union otx2_cpt_opcode {
 	u16 flags;
 	struct {
@@ -347,22 +350,48 @@ static inline struct otx2_cpt_inst_info *
 cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 		       gfp_t gfp)
 {
-	u32 dlen = 0, g_len, sg_len, info_len;
-	int align = OTX2_CPT_DMA_MINALIGN;
+	u32 dlen = 0, g_len, s_len, sg_len, info_len;
 	struct otx2_cpt_inst_info *info;
-	u16 g_sz_bytes, s_sz_bytes;
 	u32 total_mem_len;
 	int i;
 
-	g_sz_bytes = ((req->in_cnt + 2) / 3) *
-		      sizeof(struct cn10kb_cpt_sglist_component);
-	s_sz_bytes = ((req->out_cnt + 2) / 3) *
-		      sizeof(struct cn10kb_cpt_sglist_component);
+	/* Allocate memory to meet below alignment requirement:
+	 *  ------------------------------------
+	 * |    struct otx2_cpt_inst_info       |
+	 * |    (No alignment required)         |
+	 * |    --------------------------------|
+	 * |   | padding for ARCH_DMA_MINALIGN  |
+	 * |   | alignment                      |
+	 * |------------------------------------|
+	 * |    SG List Gather/Input memory     |
+	 * |    Length = multiple of 32Bytes    |
+	 * |    Alignment = 8Byte               |
+	 * |----------------------------------  |
+	 * |    SG List Scatter/Output memory   |
+	 * |    Length = multiple of 32Bytes    |
+	 * |    Alignment = 8Byte               |
+	 * |     -------------------------------|
+	 * |    | padding for 32B alignment     |
+	 * |------------------------------------|
+	 * |    Result response memory          |
+	 * |    Alignment = 32Byte              |
+	 *  ------------------------------------
+	 */
+
+	info_len = sizeof(*info);
+
+	g_len = ((req->in_cnt + 2) / 3) *
+		 sizeof(struct cn10kb_cpt_sglist_component);
+	s_len = ((req->out_cnt + 2) / 3) *
+		 sizeof(struct cn10kb_cpt_sglist_component);
+	sg_len = g_len + s_len;
 
-	g_len = ALIGN(g_sz_bytes, align);
-	sg_len = ALIGN(g_len + s_sz_bytes, align);
-	info_len = ALIGN(sizeof(*info), align);
-	total_mem_len = sg_len + info_len + sizeof(union otx2_cpt_res_s);
+	/* Allocate extra memory for SG and response address alignment */
+	total_mem_len = ALIGN(info_len, OTX2_CPT_DPTR_RPTR_ALIGN);
+	total_mem_len += (ARCH_DMA_MINALIGN - 1) &
+			  ~(OTX2_CPT_DPTR_RPTR_ALIGN - 1);
+	total_mem_len += ALIGN(sg_len, OTX2_CPT_RES_ADDR_ALIGN);
+	total_mem_len += sizeof(union otx2_cpt_res_s);
 
 	info = kzalloc(total_mem_len, gfp);
 	if (unlikely(!info))
@@ -372,7 +401,8 @@ cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 		dlen += req->in[i].size;
 
 	info->dlen = dlen;
-	info->in_buffer = (u8 *)info + info_len;
+	info->in_buffer = PTR_ALIGN((u8 *)info + info_len, ARCH_DMA_MINALIGN);
+	info->out_buffer = info->in_buffer + g_len;
 	info->gthr_sz = req->in_cnt;
 	info->sctr_sz = req->out_cnt;
 
@@ -384,7 +414,7 @@ cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	}
 
 	if (sgv2io_components_setup(pdev, req->out, req->out_cnt,
-				    &info->in_buffer[g_len])) {
+				    info->out_buffer)) {
 		dev_err(&pdev->dev, "Failed to setup scatter list\n");
 		goto destroy_info;
 	}
@@ -401,8 +431,10 @@ cn10k_sgv2_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	 * Get buffer for union otx2_cpt_res_s response
 	 * structure and its physical address
 	 */
-	info->completion_addr = info->in_buffer + sg_len;
-	info->comp_baddr = info->dptr_baddr + sg_len;
+	info->completion_addr = PTR_ALIGN((info->in_buffer + sg_len),
+					  OTX2_CPT_RES_ADDR_ALIGN);
+	info->comp_baddr = ALIGN((info->dptr_baddr + sg_len),
+				 OTX2_CPT_RES_ADDR_ALIGN);
 
 	return info;
 
@@ -417,10 +449,9 @@ static inline struct otx2_cpt_inst_info *
 otx2_sg_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 		    gfp_t gfp)
 {
-	int align = OTX2_CPT_DMA_MINALIGN;
 	struct otx2_cpt_inst_info *info;
-	u32 dlen, align_dlen, info_len;
-	u16 g_sz_bytes, s_sz_bytes;
+	u32 dlen, info_len;
+	u16 g_len, s_len;
 	u32 total_mem_len;
 
 	if (unlikely(req->in_cnt > OTX2_CPT_MAX_SG_IN_CNT ||
@@ -429,22 +460,54 @@ otx2_sg_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 		return NULL;
 	}
 
-	g_sz_bytes = ((req->in_cnt + 3) / 4) *
-		      sizeof(struct otx2_cpt_sglist_component);
-	s_sz_bytes = ((req->out_cnt + 3) / 4) *
-		      sizeof(struct otx2_cpt_sglist_component);
+	/* Allocate memory to meet below alignment requirement:
+	 *  ------------------------------------
+	 * |    struct otx2_cpt_inst_info       |
+	 * |    (No alignment required)         |
+	 * |    --------------------------------|
+	 * |   | padding for ARCH_DMA_MINALIGN  |
+	 * |   | alignment                      |
+	 * |------------------------------------|
+	 * |    SG List Header of 8 Byte        |
+	 * |------------------------------------|
+	 * |    SG List Gather/Input memory     |
+	 * |    Length = multiple of 32Bytes    |
+	 * |    Alignment = 8Byte               |
+	 * |----------------------------------  |
+	 * |    SG List Scatter/Output memory   |
+	 * |    Length = multiple of 32Bytes    |
+	 * |    Alignment = 8Byte               |
+	 * |     -------------------------------|
+	 * |    | padding for 32B alignment     |
+	 * |------------------------------------|
+	 * |    Result response memory          |
+	 * |    Alignment = 32Byte              |
+	 *  ------------------------------------
+	 */
+
+	info_len = sizeof(*info);
+
+	g_len = ((req->in_cnt + 3) / 4) *
+		 sizeof(struct otx2_cpt_sglist_component);
+	s_len = ((req->out_cnt + 3) / 4) *
+		 sizeof(struct otx2_cpt_sglist_component);
+
+	dlen = g_len + s_len + SG_LIST_HDR_SIZE;
 
-	dlen = g_sz_bytes + s_sz_bytes + SG_LIST_HDR_SIZE;
-	align_dlen = ALIGN(dlen, align);
-	info_len = ALIGN(sizeof(*info), align);
-	total_mem_len = align_dlen + info_len + sizeof(union otx2_cpt_res_s);
+	/* Allocate extra memory for SG and response address alignment */
+	total_mem_len = ALIGN(info_len, OTX2_CPT_DPTR_RPTR_ALIGN);
+	total_mem_len += (ARCH_DMA_MINALIGN - 1) &
+			  ~(OTX2_CPT_DPTR_RPTR_ALIGN - 1);
+	total_mem_len += ALIGN(dlen, OTX2_CPT_RES_ADDR_ALIGN);
+	total_mem_len += sizeof(union otx2_cpt_res_s);
 
 	info = kzalloc(total_mem_len, gfp);
 	if (unlikely(!info))
 		return NULL;
 
 	info->dlen = dlen;
-	info->in_buffer = (u8 *)info + info_len;
+	info->in_buffer = PTR_ALIGN((u8 *)info + info_len, ARCH_DMA_MINALIGN);
+	info->out_buffer = info->in_buffer + SG_LIST_HDR_SIZE + g_len;
 
 	((u16 *)info->in_buffer)[0] = req->out_cnt;
 	((u16 *)info->in_buffer)[1] = req->in_cnt;
@@ -460,7 +523,7 @@ otx2_sg_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	}
 
 	if (setup_sgio_components(pdev, req->out, req->out_cnt,
-				  &info->in_buffer[8 + g_sz_bytes])) {
+				  info->out_buffer)) {
 		dev_err(&pdev->dev, "Failed to setup scatter list\n");
 		goto destroy_info;
 	}
@@ -476,8 +539,10 @@ otx2_sg_info_create(struct pci_dev *pdev, struct otx2_cpt_req_info *req,
 	 * Get buffer for union otx2_cpt_res_s response
 	 * structure and its physical address
 	 */
-	info->completion_addr = info->in_buffer + align_dlen;
-	info->comp_baddr = info->dptr_baddr + align_dlen;
+	info->completion_addr = PTR_ALIGN((info->in_buffer + dlen),
+					  OTX2_CPT_RES_ADDR_ALIGN);
+	info->comp_baddr = ALIGN((info->dptr_baddr + dlen),
+				 OTX2_CPT_RES_ADDR_ALIGN);
 
 	return info;
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
index 357a7c6ac837..1493a373baf7 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_ucode.c
@@ -1490,12 +1490,13 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 	union otx2_cpt_opcode opcode;
 	union otx2_cpt_res_s *result;
 	union otx2_cpt_inst_s inst;
+	dma_addr_t result_baddr;
 	dma_addr_t rptr_baddr;
 	struct pci_dev *pdev;
-	u32 len, compl_rlen;
 	int timeout = 10000;
+	void *base, *rptr;
 	int ret, etype;
-	void *rptr;
+	u32 len;
 
 	/*
 	 * We don't get capabilities if it was already done
@@ -1520,22 +1521,28 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 	if (ret)
 		goto delete_grps;
 
-	compl_rlen = ALIGN(sizeof(union otx2_cpt_res_s), OTX2_CPT_DMA_MINALIGN);
-	len = compl_rlen + LOADFVC_RLEN;
+	/* Allocate extra memory for "rptr" and "result" pointer alignment */
+	len = LOADFVC_RLEN + ARCH_DMA_MINALIGN +
+	       sizeof(union otx2_cpt_res_s) + OTX2_CPT_RES_ADDR_ALIGN;
 
-	result = kzalloc(len, GFP_KERNEL);
-	if (!result) {
+	base = kzalloc(len, GFP_KERNEL);
+	if (!base) {
 		ret = -ENOMEM;
 		goto lf_cleanup;
 	}
-	rptr_baddr = dma_map_single(&pdev->dev, (void *)result, len,
-				    DMA_BIDIRECTIONAL);
+
+	rptr = PTR_ALIGN(base, ARCH_DMA_MINALIGN);
+	rptr_baddr = dma_map_single(&pdev->dev, rptr, len, DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(&pdev->dev, rptr_baddr)) {
 		dev_err(&pdev->dev, "DMA mapping failed\n");
 		ret = -EFAULT;
-		goto free_result;
+		goto free_rptr;
 	}
-	rptr = (u8 *)result + compl_rlen;
+
+	result = (union otx2_cpt_res_s *)PTR_ALIGN(rptr + LOADFVC_RLEN,
+						   OTX2_CPT_RES_ADDR_ALIGN);
+	result_baddr = ALIGN(rptr_baddr + LOADFVC_RLEN,
+			     OTX2_CPT_RES_ADDR_ALIGN);
 
 	/* Fill in the command */
 	opcode.s.major = LOADFVC_MAJOR_OP;
@@ -1547,14 +1554,14 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 	/* 64-bit swap for microcode data reads, not needed for addresses */
 	cpu_to_be64s(&iq_cmd.cmd.u);
 	iq_cmd.dptr = 0;
-	iq_cmd.rptr = rptr_baddr + compl_rlen;
+	iq_cmd.rptr = rptr_baddr;
 	iq_cmd.cptr.u = 0;
 
 	for (etype = 1; etype < OTX2_CPT_MAX_ENG_TYPES; etype++) {
 		result->s.compcode = OTX2_CPT_COMPLETION_CODE_INIT;
 		iq_cmd.cptr.s.grp = otx2_cpt_get_eng_grp(&cptpf->eng_grps,
 							 etype);
-		otx2_cpt_fill_inst(&inst, &iq_cmd, rptr_baddr);
+		otx2_cpt_fill_inst(&inst, &iq_cmd, result_baddr);
 		lfs->ops->send_cmd(&inst, 1, &cptpf->lfs.lf[0]);
 		timeout = 10000;
 
@@ -1577,8 +1584,8 @@ int otx2_cpt_discover_eng_capabilities(struct otx2_cptpf_dev *cptpf)
 
 error_no_response:
 	dma_unmap_single(&pdev->dev, rptr_baddr, len, DMA_BIDIRECTIONAL);
-free_result:
-	kfree(result);
+free_rptr:
+	kfree(base);
 lf_cleanup:
 	otx2_cptlf_shutdown(lfs);
 delete_grps:
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 4db3d80e10b0..e5272644a4a0 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 		}
 	}
 
-	priv->dma_nelms =
-	    dma_map_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
-	if (priv->dma_nelms == 0) {
+	err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
+	if (err) {
 		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
-		return -ENOMEM;
+		return err;
 	}
+	priv->dma_nelms = sgt->nents;
 
 	/* enable clock */
 	err = clk_enable(priv->clk);
@@ -478,7 +478,7 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
 	clk_disable(priv->clk);
 
 out_free:
-	dma_unmap_sg(mgr->dev.parent, sgt->sgl, sgt->nents, DMA_TO_DEVICE);
+	dma_unmap_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
 	return err;
 }
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 1160a439e92a..0dd0d996e53e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -105,10 +105,15 @@ config DRM_KMS_HELPER
 	help
 	  CRTC helpers for KMS drivers.
 
+config DRM_DRAW
+	bool
+	depends on DRM
+
 config DRM_PANIC
 	bool "Display a user-friendly message when a kernel panic occurs"
 	depends on DRM
 	select FONT_SUPPORT
+	select DRM_DRAW
 	help
 	  Enable a drm panic handler, which will display a user-friendly message
 	  when a kernel panic occurs. It's useful when using a user-space
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 1ec44529447a..f4a5edf746d2 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -89,6 +89,7 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += \
 	drm_privacy_screen_x86.o
 drm-$(CONFIG_DRM_ACCEL) += ../../accel/drm_accel.o
 drm-$(CONFIG_DRM_PANIC) += drm_panic.o
+drm-$(CONFIG_DRM_DRAW) += drm_draw.o
 drm-$(CONFIG_DRM_PANIC_SCREEN_QR_CODE) += drm_panic_qr.o
 obj-$(CONFIG_DRM)	+= drm.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8cf224fd4ff2..373c626247a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2387,9 +2387,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 
 	adev->firmware.gpu_info_fw = NULL;
 
-	if (adev->mman.discovery_bin)
-		return 0;
-
 	switch (adev->asic_type) {
 	default:
 		return 0;
@@ -2411,6 +2408,8 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 		chip_name = "arcturus";
 		break;
 	case CHIP_NAVI12:
+		if (adev->mman.discovery_bin)
+			return 0;
 		chip_name = "navi12";
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index eee434743deb..6042956cd5c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -273,7 +273,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	int i, ret = 0;
 
 	if (!amdgpu_sriov_vf(adev)) {
-		/* It can take up to a second for IFWI init to complete on some dGPUs,
+		/* It can take up to two second for IFWI init to complete on some dGPUs,
 		 * but generally it should be in the 60-100ms range.  Normally this starts
 		 * as soon as the device gets power so by the time the OS loads this has long
 		 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
@@ -281,7 +281,7 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		 * continue.
 		 */
 
-		for (i = 0; i < 1000; i++) {
+		for (i = 0; i < 2000; i++) {
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
 				break;
@@ -2455,40 +2455,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
-	case CHIP_VEGA12:
-	case CHIP_RAVEN:
-	case CHIP_VEGA20:
-	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
-		/* this is not fatal.  We have a fallback below
-		 * if the new firmwares are not present. some of
-		 * this will be overridden below to keep things
-		 * consistent with the current behavior.
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
 		 */
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (!r) {
-			amdgpu_discovery_harvest_ip(adev);
-			amdgpu_discovery_get_gfx_info(adev);
-			amdgpu_discovery_get_mall_info(adev);
-			amdgpu_discovery_get_vcn_info(adev);
-		}
-		break;
-	default:
-		r = amdgpu_discovery_reg_base_init(adev);
-		if (r) {
-			drm_err(&adev->ddev, "discovery failed: %d\n", r);
-			return r;
-		}
-
-		amdgpu_discovery_harvest_ip(adev);
-		amdgpu_discovery_get_gfx_info(adev);
-		amdgpu_discovery_get_mall_info(adev);
-		amdgpu_discovery_get_vcn_info(adev);
-		break;
-	}
-
-	switch (adev->asic_type) {
-	case CHIP_VEGA10:
+		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
 		adev->gmc.num_umc = 4;
@@ -2511,6 +2482,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 0);
 		break;
 	case CHIP_VEGA12:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
 		adev->gmc.num_umc = 4;
@@ -2533,6 +2509,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 0, 1);
 		break;
 	case CHIP_RAVEN:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		vega10_reg_base_init(adev);
 		adev->sdma.num_instances = 1;
 		adev->vcn.num_vcn_inst = 1;
@@ -2572,6 +2553,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		}
 		break;
 	case CHIP_VEGA20:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		vega20_reg_base_init(adev);
 		adev->sdma.num_instances = 2;
 		adev->gmc.num_umc = 8;
@@ -2595,6 +2581,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[DCI_HWIP][0] = IP_VERSION(12, 1, 0);
 		break;
 	case CHIP_ARCTURUS:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		arct_reg_base_init(adev);
 		adev->sdma.num_instances = 8;
 		adev->vcn.num_vcn_inst = 2;
@@ -2623,6 +2614,11 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[UVD_HWIP][1] = IP_VERSION(2, 5, 0);
 		break;
 	case CHIP_ALDEBARAN:
+		/* This is not fatal.  We only need the discovery
+		 * binary for sysfs.  We don't need it for a
+		 * functional system.
+		 */
+		amdgpu_discovery_init(adev);
 		aldebaran_reg_base_init(adev);
 		adev->sdma.num_instances = 5;
 		adev->vcn.num_vcn_inst = 2;
@@ -2649,6 +2645,16 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->ip_versions[XGMI_HWIP][0] = IP_VERSION(6, 1, 0);
 		break;
 	default:
+		r = amdgpu_discovery_reg_base_init(adev);
+		if (r) {
+			drm_err(&adev->ddev, "discovery failed: %d\n", r);
+			return r;
+		}
+
+		amdgpu_discovery_harvest_ip(adev);
+		amdgpu_discovery_get_gfx_info(adev);
+		amdgpu_discovery_get_mall_info(adev);
+		amdgpu_discovery_get_vcn_info(adev);
 		break;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 37d53578825b..0adb106e2c42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2292,13 +2292,11 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
-					DMA_RESV_USAGE_BOOKKEEP,
-					true, timeout);
+	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
+	return drm_sched_entity_flush(&vm->delayed, timeout);
 }
 
 static void amdgpu_vm_destroy_task_info(struct kref *kref)
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 1341f0292031..10054d07f20b 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -361,7 +361,7 @@ static void program_imu_rlc_ram(struct amdgpu_device *adev,
 static void imu_v12_0_program_rlc_ram(struct amdgpu_device *adev)
 {
 	u32 reg_data, size = 0;
-	const u32 *data;
+	const u32 *data = NULL;
 	int r = -EINVAL;
 
 	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_RAM_INDEX, 0x2);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 134c4ec10887..910337dc28d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -36,40 +36,47 @@
 
 static const char *mmhub_client_ids_v3_0_1[][2] = {
 	[0][0] = "VMC",
+	[1][0] = "ISPXT",
+	[2][0] = "ISPIXT",
 	[4][0] = "DCEDMC",
 	[5][0] = "DCEVGA",
 	[6][0] = "MP0",
 	[7][0] = "MP1",
-	[8][0] = "MPIO",
-	[16][0] = "HDP",
-	[17][0] = "LSDMA",
-	[18][0] = "JPEG",
-	[19][0] = "VCNU0",
-	[21][0] = "VSCH",
-	[22][0] = "VCNU1",
-	[23][0] = "VCN1",
-	[32+20][0] = "VCN0",
-	[2][1] = "DBGUNBIO",
+	[8][0] = "MPM",
+	[12][0] = "ISPTNR",
+	[14][0] = "ISPCRD0",
+	[15][0] = "ISPCRD1",
+	[16][0] = "ISPCRD2",
+	[22][0] = "HDP",
+	[23][0] = "LSDMA",
+	[24][0] = "JPEG",
+	[27][0] = "VSCH",
+	[28][0] = "VCNU",
+	[29][0] = "VCN",
+	[1][1] = "ISPXT",
+	[2][1] = "ISPIXT",
 	[3][1] = "DCEDWB",
 	[4][1] = "DCEDMC",
 	[5][1] = "DCEVGA",
 	[6][1] = "MP0",
 	[7][1] = "MP1",
-	[8][1] = "MPIO",
-	[10][1] = "DBGU0",
-	[11][1] = "DBGU1",
-	[12][1] = "DBGU2",
-	[13][1] = "DBGU3",
-	[14][1] = "XDP",
-	[15][1] = "OSSSYS",
-	[16][1] = "HDP",
-	[17][1] = "LSDMA",
-	[18][1] = "JPEG",
-	[19][1] = "VCNU0",
-	[20][1] = "VCN0",
-	[21][1] = "VSCH",
-	[22][1] = "VCNU1",
-	[23][1] = "VCN1",
+	[8][1] = "MPM",
+	[10][1] = "ISPMWR0",
+	[11][1] = "ISPMWR1",
+	[12][1] = "ISPTNR",
+	[13][1] = "ISPSWR",
+	[14][1] = "ISPCWR0",
+	[15][1] = "ISPCWR1",
+	[16][1] = "ISPCWR2",
+	[17][1] = "ISPCWR3",
+	[18][1] = "XDP",
+	[21][1] = "OSSSYS",
+	[22][1] = "HDP",
+	[23][1] = "LSDMA",
+	[24][1] = "JPEG",
+	[27][1] = "VSCH",
+	[28][1] = "VCNU",
+	[29][1] = "VCN",
 };
 
 static uint32_t mmhub_v3_0_1_get_invalidate_req(unsigned int vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index f2ab5001b492..951998454b25 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@ -37,39 +37,31 @@
 static const char *mmhub_client_ids_v4_1_0[][2] = {
 	[0][0] = "VMC",
 	[4][0] = "DCEDMC",
-	[5][0] = "DCEVGA",
 	[6][0] = "MP0",
 	[7][0] = "MP1",
 	[8][0] = "MPIO",
-	[16][0] = "HDP",
-	[17][0] = "LSDMA",
-	[18][0] = "JPEG",
-	[19][0] = "VCNU0",
-	[21][0] = "VSCH",
-	[22][0] = "VCNU1",
-	[23][0] = "VCN1",
-	[32+20][0] = "VCN0",
-	[2][1] = "DBGUNBIO",
+	[16][0] = "LSDMA",
+	[17][0] = "JPEG",
+	[19][0] = "VCNU",
+	[22][0] = "VSCH",
+	[23][0] = "HDP",
+	[32+23][0] = "VCNRD",
 	[3][1] = "DCEDWB",
 	[4][1] = "DCEDMC",
-	[5][1] = "DCEVGA",
 	[6][1] = "MP0",
 	[7][1] = "MP1",
 	[8][1] = "MPIO",
 	[10][1] = "DBGU0",
 	[11][1] = "DBGU1",
-	[12][1] = "DBGU2",
-	[13][1] = "DBGU3",
+	[12][1] = "DBGUNBIO",
 	[14][1] = "XDP",
 	[15][1] = "OSSSYS",
-	[16][1] = "HDP",
-	[17][1] = "LSDMA",
-	[18][1] = "JPEG",
-	[19][1] = "VCNU0",
-	[20][1] = "VCN0",
-	[21][1] = "VSCH",
-	[22][1] = "VCNU1",
-	[23][1] = "VCN1",
+	[16][1] = "LSDMA",
+	[17][1] = "JPEG",
+	[18][1] = "VCNWR",
+	[19][1] = "VCNU",
+	[22][1] = "VSCH",
+	[23][1] = "HDP",
 };
 
 static uint32_t mmhub_v4_1_0_get_invalidate_req(unsigned int vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 4cbe0da100d8..c162149b5494 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1183,6 +1183,8 @@ static int soc15_common_early_init(void *handle)
 			AMD_PG_SUPPORT_JPEG;
 		/*TODO: need a new external_rev_id for GC 9.4.4? */
 		adev->external_rev_id = adev->rev_id + 0x46;
+		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
+			adev->external_rev_id = adev->rev_id + 0x50;
 		break;
 	default:
 		/* FIXME: not supported yet */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index aee2212e52f6..33aa23450b3f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -78,8 +78,8 @@ static int kfd_init(void)
 static void kfd_exit(void)
 {
 	kfd_cleanup_processes();
-	kfd_debugfs_fini();
 	kfd_process_destroy_wq();
+	kfd_debugfs_fini();
 	kfd_procfs_shutdown();
 	kfd_topology_shutdown();
 	kfd_chardev_exit();
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 33a3e5e28fbc..9763752cf5cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7583,6 +7583,9 @@ amdgpu_dm_connector_atomic_check(struct drm_connector *conn,
 	struct amdgpu_dm_connector *aconn = to_amdgpu_dm_connector(conn);
 	int ret;
 
+	if (WARN_ON(unlikely(!old_con_state || !new_con_state)))
+		return -EINVAL;
+
 	trace_amdgpu_dm_connector_atomic_check(new_con_state);
 
 	if (conn->connector_type == DRM_MODE_CONNECTOR_DisplayPort) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 9a31e5da3687..2d3e62703274 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -302,6 +302,25 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
 	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
 
 	if (enable) {
+		struct dc *dc = adev->dm.dc;
+		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
+		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
+		struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
+		bool sr_supported = (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED) ||
+								pr->config.replay_supported;
+
+		/*
+		 * IPS & self-refresh feature can cause vblank counter resets between
+		 * vblank disable and enable.
+		 * It may cause system stuck due to waiting for the vblank counter.
+		 * Call this function to estimate missed vblanks by using timestamps and
+		 * update the vblank counter in DRM.
+		 */
+		if (dc->caps.ips_support &&
+			dc->config.disable_ips != DMUB_IPS_DISABLE_ALL &&
+			sr_supported && vblank->config.disable_immediate)
+			drm_crtc_vblank_restore(crtc);
+
 		/* vblank irq on -> Only need vupdate irq in vrr mode */
 		if (amdgpu_dm_crtc_vrr_active(acrtc_state))
 			rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, true);
@@ -664,6 +683,15 @@ static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 		return -EINVAL;
 	}
 
+	if (!state->legacy_cursor_update && amdgpu_dm_crtc_vrr_active(dm_crtc_state)) {
+		struct drm_plane_state *primary_state;
+
+		/* Pull in primary plane for correct VRR handling */
+		primary_state = drm_atomic_get_plane_state(state, crtc->primary);
+		if (IS_ERR(primary_state))
+			return PTR_ERR(primary_state);
+	}
+
 	/* In some use cases, like reset, no stream is attached */
 	if (!dm_crtc_state->stream)
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 15d94d2a0e2f..97a9b37f78a2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -3932,7 +3932,7 @@ static int capabilities_show(struct seq_file *m, void *unused)
 
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 
-	if (hubbub->funcs->get_mall_en)
+	if (hubbub && hubbub->funcs->get_mall_en)
 		hubbub->funcs->get_mall_en(hubbub, &mall_in_use);
 
 	if (dc->cap_funcs.get_subvp_en)
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 3bacf470f7c5..a523c5cfcd24 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -174,11 +174,8 @@ static struct graphics_object_id bios_parser_get_connector_id(
 		return object_id;
 	}
 
-	if (tbl->ucNumberOfObjects <= i) {
-		dm_error("Can't find connector id %d in connector table of size %d.\n",
-			 i, tbl->ucNumberOfObjects);
+	if (tbl->ucNumberOfObjects <= i)
 		return object_id;
-	}
 
 	id = le16_to_cpu(tbl->asObjects[i].usObjectID);
 	object_id = object_id_from_bios_object_id(id);
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 2bcae0643e61..58e88778da7f 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -993,7 +993,7 @@ static enum bp_result set_pixel_clock_v3(
 	allocation.sPCLKInput.usFbDiv =
 			cpu_to_le16((uint16_t)bp_params->feedback_divider);
 	allocation.sPCLKInput.ucFracFbDiv =
-			(uint8_t)bp_params->fractional_feedback_divider;
+			(uint8_t)(bp_params->fractional_feedback_divider / 100000);
 	allocation.sPCLKInput.ucPostDiv =
 			(uint8_t)bp_params->pixel_clock_post_divider;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 4c3e58c730b1..a0c1072c59a2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -158,7 +158,6 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			return NULL;
 		}
 		dce60_clk_mgr_construct(ctx, clk_mgr);
-		dce_clk_mgr_construct(ctx, clk_mgr);
 		return &clk_mgr->base;
 	}
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 26feefbb8990..b268c367c27c 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -386,8 +386,6 @@ static void dce_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
-	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index f8409453434c..13cf415e38e5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -120,9 +120,15 @@ void dce110_fill_display_configs(
 	const struct dc_state *context,
 	struct dm_pp_display_configuration *pp_display_cfg)
 {
+	struct dc *dc = context->clk_mgr->ctx->dc;
 	int j;
 	int num_cfgs = 0;
 
+	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
+	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
+	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
+	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
+
 	for (j = 0; j < context->stream_count; j++) {
 		int k;
 
@@ -164,6 +170,23 @@ void dce110_fill_display_configs(
 		cfg->v_refresh /= stream->timing.h_total;
 		cfg->v_refresh = (cfg->v_refresh + stream->timing.v_total / 2)
 							/ stream->timing.v_total;
+
+		/* Find first CRTC index and calculate its line time.
+		 * This is necessary for DPM on SI GPUs.
+		 */
+		if (cfg->pipe_idx < pp_display_cfg->crtc_index) {
+			const struct dc_crtc_timing *timing =
+				&context->streams[0]->timing;
+
+			pp_display_cfg->crtc_index = cfg->pipe_idx;
+			pp_display_cfg->line_time_in_us =
+				timing->h_total * 10000 / timing->pix_clk_100hz;
+		}
+	}
+
+	if (!num_cfgs) {
+		pp_display_cfg->crtc_index = 0;
+		pp_display_cfg->line_time_in_us = 0;
 	}
 
 	pp_display_cfg->display_count = num_cfgs;
@@ -223,25 +246,8 @@ void dce11_pplib_apply_display_requirements(
 	pp_display_cfg->min_engine_clock_deep_sleep_khz
 			= context->bw_ctx.bw.dce.sclk_deep_sleep_khz;
 
-	pp_display_cfg->avail_mclk_switch_time_us =
-						dce110_get_min_vblank_time_us(context);
-	/* TODO: dce11.2*/
-	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
-
-	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
-	/* TODO: is this still applicable?*/
-	if (pp_display_cfg->display_count == 1) {
-		const struct dc_crtc_timing *timing =
-			&context->streams[0]->timing;
-
-		pp_display_cfg->crtc_index =
-			pp_display_cfg->disp_configs[0].pipe_idx;
-		pp_display_cfg->line_time_in_us = timing->h_total * 10000 / timing->pix_clk_100hz;
-	}
-
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
 		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index 0267644717b2..a39641a0ff09 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -83,22 +83,13 @@ static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
 static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	int dprefclk_wdivider;
-	int dp_ref_clk_khz;
-	int target_div;
+	struct dc_context *ctx = clk_mgr_base->ctx;
+	int dp_ref_clk_khz = 0;
 
-	/* DCE6 has no DPREFCLK_CNTL to read DP Reference Clock source */
-
-	/* Read the mmDENTIST_DISPCLK_CNTL to get the currently
-	 * programmed DID DENTIST_DPREFCLK_WDIVIDER*/
-	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, &dprefclk_wdivider);
-
-	/* Convert DENTIST_DPREFCLK_WDIVIDERto actual divider*/
-	target_div = dentist_get_divider_from_did(dprefclk_wdivider);
-
-	/* Calculate the current DFS clock, in kHz.*/
-	dp_ref_clk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-		* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
+		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
+	else
+		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
 
 	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
 }
@@ -109,8 +100,6 @@ static void dce60_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
-	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
@@ -123,11 +112,9 @@ static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f5d938b9504c..84e377113e58 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -215,11 +215,24 @@ static bool create_links(
 		connectors_num,
 		num_virtual_links);
 
-	// condition loop on link_count to allow skipping invalid indices
+	/* When getting the number of connectors, the VBIOS reports the number of valid indices,
+	 * but it doesn't say which indices are valid, and not every index has an actual connector.
+	 * So, if we don't find a connector on an index, that is not an error.
+	 *
+	 * - There is no guarantee that the first N indices will be valid
+	 * - VBIOS may report a higher amount of valid indices than there are actual connectors
+	 * - Some VBIOS have valid configurations for more connectors than there actually are
+	 *   on the card. This may be because the manufacturer used the same VBIOS for different
+	 *   variants of the same card.
+	 */
 	for (i = 0; dc->link_count < connectors_num && i < MAX_LINKS; i++) {
+		struct graphics_object_id connector_id = bios->funcs->get_connector_id(bios, i);
 		struct link_init_data link_init_params = {0};
 		struct dc_link *link;
 
+		if (connector_id.id == CONNECTOR_ID_UNKNOWN)
+			continue;
+
 		DC_LOG_DC("BIOS object table - printing link object info for connector number: %d, link_index: %d", i, dc->link_count);
 
 		link_init_params.ctx = dc->ctx;
@@ -890,17 +903,18 @@ static void dc_destruct(struct dc *dc)
 	if (dc->link_srv)
 		link_destroy_link_service(&dc->link_srv);
 
-	if (dc->ctx->gpio_service)
-		dal_gpio_service_destroy(&dc->ctx->gpio_service);
-
-	if (dc->ctx->created_bios)
-		dal_bios_parser_destroy(&dc->ctx->dc_bios);
+	if (dc->ctx) {
+		if (dc->ctx->gpio_service)
+			dal_gpio_service_destroy(&dc->ctx->gpio_service);
 
-	kfree(dc->ctx->logger);
-	dc_perf_trace_destroy(&dc->ctx->perf_trace);
+		if (dc->ctx->created_bios)
+			dal_bios_parser_destroy(&dc->ctx->dc_bios);
+		kfree(dc->ctx->logger);
+		dc_perf_trace_destroy(&dc->ctx->perf_trace);
 
-	kfree(dc->ctx);
-	dc->ctx = NULL;
+		kfree(dc->ctx);
+		dc->ctx = NULL;
+	}
 
 	kfree(dc->bw_vbios);
 	dc->bw_vbios = NULL;
diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
index e58e7b93810b..6b7db8ec9a53 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp_psp.c
@@ -260,6 +260,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_create_session(struct mod_hdcp *hdcp)
 		return MOD_HDCP_STATUS_FAILURE;
 	}
 
+	if (!display)
+		return MOD_HDCP_STATUS_DISPLAY_NOT_FOUND;
+
 	hdcp_cmd = (struct ta_hdcp_shared_memory *)psp->hdcp_context.context.mem_context.shared_buf;
 
 	mutex_lock(&psp->hdcp_context.mutex);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3fd8da5dc761..b6657abe62fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2153,6 +2153,12 @@ static int smu_resume(void *handle)
 
 	adev->pm.dpm_enabled = true;
 
+	if (smu->current_power_limit) {
+		ret = smu_set_power_limit(smu, smu->current_power_limit);
+		if (ret && ret != -EOPNOTSUPP)
+			return ret;
+	}
+
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index e98a6a2f3e6a..d0aed85db18c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1668,9 +1668,11 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 				       uint32_t *min_power_limit)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
+	struct smu_14_0_2_powerplay_table *powerplay_table =
+		table_context->power_play_table;
 	PPTable_t *pptable = table_context->driver_pptable;
 	CustomSkuTable_t *skutable = &pptable->CustomSkuTable;
-	uint32_t power_limit;
+	uint32_t power_limit, od_percent_upper = 0, od_percent_lower = 0;
 	uint32_t msg_limit = pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
 
 	if (smu_v14_0_get_current_power_limit(smu, &power_limit))
@@ -1683,11 +1685,29 @@ static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
 	if (default_power_limit)
 		*default_power_limit = power_limit;
 
-	if (max_power_limit)
-		*max_power_limit = msg_limit;
+	if (powerplay_table) {
+		if (smu->od_enabled &&
+		    smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+			od_percent_upper = pptable->SkuTable.OverDriveLimitsBasicMax.Ppt;
+			od_percent_lower = pptable->SkuTable.OverDriveLimitsBasicMin.Ppt;
+		} else if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+			od_percent_upper = 0;
+			od_percent_lower = pptable->SkuTable.OverDriveLimitsBasicMin.Ppt;
+		}
+	}
+
+	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (default power: %d)\n",
+					od_percent_upper, od_percent_lower, power_limit);
+
+	if (max_power_limit) {
+		*max_power_limit = msg_limit * (100 + od_percent_upper);
+		*max_power_limit /= 100;
+	}
 
-	if (min_power_limit)
-		*min_power_limit = 0;
+	if (min_power_limit) {
+		*min_power_limit = power_limit * (100 + od_percent_lower);
+		*min_power_limit /= 100;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 9fa13da513d2..bb61bbdcce5b 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -664,7 +664,7 @@ ssize_t drm_dp_dpcd_read(struct drm_dp_aux *aux, unsigned int offset,
 	 * monitor doesn't power down exactly after the throw away read.
 	 */
 	if (!aux->is_remote) {
-		ret = drm_dp_dpcd_probe(aux, DP_DPCD_REV);
+		ret = drm_dp_dpcd_probe(aux, DP_LANE0_1_STATUS);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
new file mode 100644
index 000000000000..d41f8ae1c148
--- /dev/null
+++ b/drivers/gpu/drm/drm_draw.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+/*
+ * Copyright (c) 2023 Red Hat.
+ * Author: Jocelyn Falempe <jfalempe@redhat.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/iosys-map.h>
+#include <linux/types.h>
+
+#include <drm/drm_fourcc.h>
+
+#include "drm_draw_internal.h"
+#include "drm_format_internal.h"
+
+/**
+ * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
+ * @color: input color, in xrgb8888 format
+ * @format: output format
+ *
+ * Returns:
+ * Color in the format specified, casted to u32.
+ * Or 0 if the format is not supported.
+ */
+u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
+{
+	switch (format) {
+	case DRM_FORMAT_RGB565:
+		return drm_pixel_xrgb8888_to_rgb565(color);
+	case DRM_FORMAT_RGBA5551:
+		return drm_pixel_xrgb8888_to_rgba5551(color);
+	case DRM_FORMAT_XRGB1555:
+		return drm_pixel_xrgb8888_to_xrgb1555(color);
+	case DRM_FORMAT_ARGB1555:
+		return drm_pixel_xrgb8888_to_argb1555(color);
+	case DRM_FORMAT_RGB888:
+	case DRM_FORMAT_XRGB8888:
+		return color;
+	case DRM_FORMAT_ARGB8888:
+		return drm_pixel_xrgb8888_to_argb8888(color);
+	case DRM_FORMAT_XBGR8888:
+		return drm_pixel_xrgb8888_to_xbgr8888(color);
+	case DRM_FORMAT_ABGR8888:
+		return drm_pixel_xrgb8888_to_abgr8888(color);
+	case DRM_FORMAT_XRGB2101010:
+		return drm_pixel_xrgb8888_to_xrgb2101010(color);
+	case DRM_FORMAT_ARGB2101010:
+		return drm_pixel_xrgb8888_to_argb2101010(color);
+	case DRM_FORMAT_ABGR2101010:
+		return drm_pixel_xrgb8888_to_abgr2101010(color);
+	default:
+		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
+		return 0;
+	}
+}
+EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
+
+/*
+ * Blit functions
+ */
+void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u16 fg16)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
+				iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, fg16);
+}
+EXPORT_SYMBOL(drm_draw_blit16);
+
+void drm_draw_blit24(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			u32 off = y * dpitch + x * 3;
+
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale)) {
+				/* write blue-green-red to output in little endianness */
+				iosys_map_wr(dmap, off, u8, (fg32 & 0x000000FF) >> 0);
+				iosys_map_wr(dmap, off + 1, u8, (fg32 & 0x0000FF00) >> 8);
+				iosys_map_wr(dmap, off + 2, u8, (fg32 & 0x00FF0000) >> 16);
+			}
+		}
+	}
+}
+EXPORT_SYMBOL(drm_draw_blit24);
+
+void drm_draw_blit32(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
+				iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, fg32);
+}
+EXPORT_SYMBOL(drm_draw_blit32);
+
+/*
+ * Fill functions
+ */
+void drm_draw_fill16(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, color);
+}
+EXPORT_SYMBOL(drm_draw_fill16);
+
+void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++) {
+		for (x = 0; x < width; x++) {
+			unsigned int off = y * dpitch + x * 3;
+
+			/* write blue-green-red to output in little endianness */
+			iosys_map_wr(dmap, off, u8, (color & 0x000000FF) >> 0);
+			iosys_map_wr(dmap, off + 1, u8, (color & 0x0000FF00) >> 8);
+			iosys_map_wr(dmap, off + 2, u8, (color & 0x00FF0000) >> 16);
+		}
+	}
+}
+EXPORT_SYMBOL(drm_draw_fill24);
+
+void drm_draw_fill32(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u32 color)
+{
+	unsigned int y, x;
+
+	for (y = 0; y < height; y++)
+		for (x = 0; x < width; x++)
+			iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, color);
+}
+EXPORT_SYMBOL(drm_draw_fill32);
diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
new file mode 100644
index 000000000000..f121ee7339dc
--- /dev/null
+++ b/drivers/gpu/drm/drm_draw_internal.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+/*
+ * Copyright (c) 2023 Red Hat.
+ * Author: Jocelyn Falempe <jfalempe@redhat.com>
+ */
+
+#ifndef __DRM_DRAW_INTERNAL_H__
+#define __DRM_DRAW_INTERNAL_H__
+
+#include <linux/font.h>
+#include <linux/types.h>
+
+struct iosys_map;
+
+/* check if the pixel at coord x,y is 1 (foreground) or 0 (background) */
+static inline bool drm_draw_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, int x, int y)
+{
+	return (sbuf8[(y * spitch) + x / 8] & (0x80 >> (x % 8))) != 0;
+}
+
+static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
+						 char c, size_t font_pitch)
+{
+	return font->data + (c * font->height) * font_pitch;
+}
+
+u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);
+
+void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u16 fg16);
+
+void drm_draw_blit24(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32);
+
+void drm_draw_blit32(struct iosys_map *dmap, unsigned int dpitch,
+		     const u8 *sbuf8, unsigned int spitch,
+		     unsigned int height, unsigned int width,
+		     unsigned int scale, u32 fg32);
+
+void drm_draw_fill16(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color);
+
+void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u16 color);
+
+void drm_draw_fill32(struct iosys_map *dmap, unsigned int dpitch,
+		     unsigned int height, unsigned int width,
+		     u32 color);
+
+#endif /* __DRM_DRAW_INTERNAL_H__ */
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index b1be458ed4dd..3769760b15cd 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -20,6 +20,8 @@
 #include <drm/drm_print.h>
 #include <drm/drm_rect.h>
 
+#include "drm_format_internal.h"
+
 /**
  * drm_format_conv_state_init - Initialize format-conversion state
  * @state: The state to initialize
@@ -244,6 +246,18 @@ static int drm_fb_xfrm(struct iosys_map *dst,
 				     xfrm_line);
 }
 
+static __always_inline void drm_fb_xfrm_line_32to32(void *dbuf, const void *sbuf,
+						    unsigned int pixels,
+						    u32 (*xfrm_pixel)(u32))
+{
+	__le32 *dbuf32 = dbuf;
+	const __le32 *sbuf32 = sbuf;
+	const __le32 *send32 = sbuf32 + pixels;
+
+	while (sbuf32 < send32)
+		*dbuf32++ = cpu_to_le32(xfrm_pixel(le32_to_cpup(sbuf32++)));
+}
+
 /**
  * drm_fb_memcpy - Copy clip buffer
  * @dst: Array of destination buffers
@@ -702,20 +716,62 @@ void drm_fb_xrgb8888_to_rgb888(struct iosys_map *dst, const unsigned int *dst_pi
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888);
 
-static void drm_fb_xrgb8888_to_argb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
+static void drm_fb_xrgb8888_to_bgr888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	__le32 *dbuf32 = dbuf;
+	u8 *dbuf8 = dbuf;
 	const __le32 *sbuf32 = sbuf;
 	unsigned int x;
 	u32 pix;
 
 	for (x = 0; x < pixels; x++) {
 		pix = le32_to_cpu(sbuf32[x]);
-		pix |= GENMASK(31, 24); /* fill alpha bits */
-		dbuf32[x] = cpu_to_le32(pix);
+		/* write red-green-blue to output in little endianness */
+		*dbuf8++ = (pix & 0x00ff0000) >> 16;
+		*dbuf8++ = (pix & 0x0000ff00) >> 8;
+		*dbuf8++ = (pix & 0x000000ff) >> 0;
 	}
 }
 
+/**
+ * drm_fb_xrgb8888_to_bgr888 - Convert XRGB8888 to BGR888 clip buffer
+ * @dst: Array of BGR888 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffers
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. Destination and framebuffer formats must match. The
+ * parameters @dst, @dst_pitch and @src refer to arrays. Each array must have at
+ * least as many entries as there are planes in @fb's format. Each entry stores the
+ * value for the format's respective color plane at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for BGR888 devices that don't natively
+ * support XRGB8888.
+ */
+void drm_fb_xrgb8888_to_bgr888(struct iosys_map *dst, const unsigned int *dst_pitch,
+			       const struct iosys_map *src, const struct drm_framebuffer *fb,
+			       const struct drm_rect *clip, struct drm_format_conv_state *state)
+{
+	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
+		3,
+	};
+
+	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
+		    drm_fb_xrgb8888_to_bgr888_line);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_bgr888);
+
+static void drm_fb_xrgb8888_to_argb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
+{
+	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_argb8888);
+}
+
 /**
  * drm_fb_xrgb8888_to_argb8888 - Convert XRGB8888 to ARGB8888 clip buffer
  * @dst: Array of ARGB8888 destination buffers
@@ -753,26 +809,36 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_argb8888);
 
 static void drm_fb_xrgb8888_to_abgr8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	__le32 *dbuf32 = dbuf;
-	const __le32 *sbuf32 = sbuf;
-	unsigned int x;
-	u32 pix;
-
-	for (x = 0; x < pixels; x++) {
-		pix = le32_to_cpu(sbuf32[x]);
-		pix = ((pix & 0x00ff0000) >> 16) <<  0 |
-		      ((pix & 0x0000ff00) >>  8) <<  8 |
-		      ((pix & 0x000000ff) >>  0) << 16 |
-		      GENMASK(31, 24); /* fill alpha bits */
-		*dbuf32++ = cpu_to_le32(pix);
-	}
+	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_abgr8888);
 }
 
-static void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
-					const struct iosys_map *src,
-					const struct drm_framebuffer *fb,
-					const struct drm_rect *clip,
-					struct drm_format_conv_state *state)
+/**
+ * drm_fb_xrgb8888_to_abgr8888 - Convert XRGB8888 to ABGR8888 clip buffer
+ * @dst: Array of ABGR8888 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. The parameters @dst, @dst_pitch and @src refer
+ * to arrays. Each array must have at least as many entries as there are planes in
+ * @fb's format. Each entry stores the value for the format's respective color plane
+ * at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for ABGR8888 devices that don't support XRGB8888
+ * natively. It sets an opaque alpha channel as part of the conversion.
+ */
+void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src,
+				 const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip,
+				 struct drm_format_conv_state *state)
 {
 	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
 		4,
@@ -781,29 +847,40 @@ static void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned in
 	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
 		    drm_fb_xrgb8888_to_abgr8888_line);
 }
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_abgr8888);
 
 static void drm_fb_xrgb8888_to_xbgr8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	__le32 *dbuf32 = dbuf;
-	const __le32 *sbuf32 = sbuf;
-	unsigned int x;
-	u32 pix;
-
-	for (x = 0; x < pixels; x++) {
-		pix = le32_to_cpu(sbuf32[x]);
-		pix = ((pix & 0x00ff0000) >> 16) <<  0 |
-		      ((pix & 0x0000ff00) >>  8) <<  8 |
-		      ((pix & 0x000000ff) >>  0) << 16 |
-		      ((pix & 0xff000000) >> 24) << 24;
-		*dbuf32++ = cpu_to_le32(pix);
-	}
+	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_xbgr8888);
 }
 
-static void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
-					const struct iosys_map *src,
-					const struct drm_framebuffer *fb,
-					const struct drm_rect *clip,
-					struct drm_format_conv_state *state)
+/**
+ * drm_fb_xrgb8888_to_xbgr8888 - Convert XRGB8888 to XBGR8888 clip buffer
+ * @dst: Array of XBGR8888 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. The parameters @dst, @dst_pitch and @src refer
+ * to arrays. Each array must have at least as many entries as there are planes in
+ * @fb's format. Each entry stores the value for the format's respective color plane
+ * at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for XBGR8888 devices that don't support XRGB8888
+ * natively.
+ */
+void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src,
+				 const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip,
+				 struct drm_format_conv_state *state)
 {
 	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
 		4,
@@ -812,23 +889,53 @@ static void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned in
 	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
 		    drm_fb_xrgb8888_to_xbgr8888_line);
 }
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_xbgr8888);
 
-static void drm_fb_xrgb8888_to_xrgb2101010_line(void *dbuf, const void *sbuf, unsigned int pixels)
+static void drm_fb_xrgb8888_to_bgrx8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	__le32 *dbuf32 = dbuf;
-	const __le32 *sbuf32 = sbuf;
-	unsigned int x;
-	u32 val32;
-	u32 pix;
+	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_bgrx8888);
+}
 
-	for (x = 0; x < pixels; x++) {
-		pix = le32_to_cpu(sbuf32[x]);
-		val32 = ((pix & 0x000000FF) << 2) |
-			((pix & 0x0000FF00) << 4) |
-			((pix & 0x00FF0000) << 6);
-		pix = val32 | ((val32 >> 8) & 0x00300C03);
-		*dbuf32++ = cpu_to_le32(pix);
-	}
+/**
+ * drm_fb_xrgb8888_to_bgrx8888 - Convert XRGB8888 to BGRX8888 clip buffer
+ * @dst: Array of BGRX8888 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffer
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. The parameters @dst, @dst_pitch and @src refer
+ * to arrays. Each array must have at least as many entries as there are planes in
+ * @fb's format. Each entry stores the value for the format's respective color plane
+ * at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for BGRX8888 devices that don't support XRGB8888
+ * natively.
+ */
+void drm_fb_xrgb8888_to_bgrx8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src,
+				 const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip,
+				 struct drm_format_conv_state *state)
+{
+	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
+		4,
+	};
+
+	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
+		    drm_fb_xrgb8888_to_bgrx8888_line);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_bgrx8888);
+
+static void drm_fb_xrgb8888_to_xrgb2101010_line(void *dbuf, const void *sbuf, unsigned int pixels)
+{
+	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_xrgb2101010);
 }
 
 /**
@@ -869,21 +976,7 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010);
 
 static void drm_fb_xrgb8888_to_argb2101010_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
-	__le32 *dbuf32 = dbuf;
-	const __le32 *sbuf32 = sbuf;
-	unsigned int x;
-	u32 val32;
-	u32 pix;
-
-	for (x = 0; x < pixels; x++) {
-		pix = le32_to_cpu(sbuf32[x]);
-		val32 = ((pix & 0x000000ff) << 2) |
-			((pix & 0x0000ff00) << 4) |
-			((pix & 0x00ff0000) << 6);
-		pix = GENMASK(31, 30) | /* set alpha bits */
-		      val32 | ((val32 >> 8) & 0x00300c03);
-		*dbuf32++ = cpu_to_le32(pix);
-	}
+	drm_fb_xfrm_line_32to32(dbuf, sbuf, pixels, drm_pixel_xrgb8888_to_argb2101010);
 }
 
 /**
@@ -1035,6 +1128,9 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
 		} else if (dst_format == DRM_FORMAT_RGB888) {
 			drm_fb_xrgb8888_to_rgb888(dst, dst_pitch, src, fb, clip, state);
 			return 0;
+		} else if (dst_format == DRM_FORMAT_BGR888) {
+			drm_fb_xrgb8888_to_bgr888(dst, dst_pitch, src, fb, clip, state);
+			return 0;
 		} else if (dst_format == DRM_FORMAT_ARGB8888) {
 			drm_fb_xrgb8888_to_argb8888(dst, dst_pitch, src, fb, clip, state);
 			return 0;
diff --git a/drivers/gpu/drm/drm_format_internal.h b/drivers/gpu/drm/drm_format_internal.h
new file mode 100644
index 000000000000..f06f09989ddc
--- /dev/null
+++ b/drivers/gpu/drm/drm_format_internal.h
@@ -0,0 +1,127 @@
+/* SPDX-License-Identifier: GPL-2.0 or MIT */
+
+#ifndef DRM_FORMAT_INTERNAL_H
+#define DRM_FORMAT_INTERNAL_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+/*
+ * Each pixel-format conversion helper takes a raw pixel in a
+ * specific input format and returns a raw pixel in a specific
+ * output format. All pixels are in little-endian byte order.
+ *
+ * Function names are
+ *
+ *   drm_pixel_<input>_to_<output>_<algorithm>()
+ *
+ * where <input> and <output> refer to pixel formats. The
+ * <algorithm> is optional and hints to the method used for the
+ * conversion. Helpers with no algorithm given apply pixel-bit
+ * shifting.
+ *
+ * The argument type is u32. We expect this to be wide enough to
+ * hold all conversion input from 32-bit RGB to any output format.
+ * The Linux kernel should avoid format conversion for anything
+ * but XRGB8888 input data. Converting from other format can still
+ * be acceptable in some cases.
+ *
+ * The return type is u32. It is wide enough to hold all conversion
+ * output from XRGB8888. For output formats wider than 32 bit, a
+ * return type of u64 would be acceptable.
+ */
+
+/*
+ * Conversions from XRGB8888
+ */
+
+static inline u32 drm_pixel_xrgb8888_to_rgb565(u32 pix)
+{
+	return ((pix & 0x00f80000) >> 8) |
+	       ((pix & 0x0000fc00) >> 5) |
+	       ((pix & 0x000000f8) >> 3);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_rgbx5551(u32 pix)
+{
+	return ((pix & 0x00f80000) >> 8) |
+	       ((pix & 0x0000f800) >> 5) |
+	       ((pix & 0x000000f8) >> 2);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_rgba5551(u32 pix)
+{
+	return drm_pixel_xrgb8888_to_rgbx5551(pix) |
+	       BIT(0); /* set alpha bit */
+}
+
+static inline u32 drm_pixel_xrgb8888_to_xrgb1555(u32 pix)
+{
+	return ((pix & 0x00f80000) >> 9) |
+	       ((pix & 0x0000f800) >> 6) |
+	       ((pix & 0x000000f8) >> 3);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_argb1555(u32 pix)
+{
+	return BIT(15) | /* set alpha bit */
+	       drm_pixel_xrgb8888_to_xrgb1555(pix);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_argb8888(u32 pix)
+{
+	return GENMASK(31, 24) | /* fill alpha bits */
+	       pix;
+}
+
+static inline u32 drm_pixel_xrgb8888_to_xbgr8888(u32 pix)
+{
+	return ((pix & 0xff000000)) | /* also copy filler bits */
+	       ((pix & 0x00ff0000) >> 16) |
+	       ((pix & 0x0000ff00)) |
+	       ((pix & 0x000000ff) << 16);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_bgrx8888(u32 pix)
+{
+	return ((pix & 0xff000000) >> 24) | /* also copy filler bits */
+	       ((pix & 0x00ff0000) >> 8) |
+	       ((pix & 0x0000ff00) << 8) |
+	       ((pix & 0x000000ff) << 24);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_abgr8888(u32 pix)
+{
+	return GENMASK(31, 24) | /* fill alpha bits */
+	       drm_pixel_xrgb8888_to_xbgr8888(pix);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_xrgb2101010(u32 pix)
+{
+	pix = ((pix & 0x000000ff) << 2) |
+	      ((pix & 0x0000ff00) << 4) |
+	      ((pix & 0x00ff0000) << 6);
+	return pix | ((pix >> 8) & 0x00300c03);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_argb2101010(u32 pix)
+{
+	return GENMASK(31, 30) | /* set alpha bits */
+	       drm_pixel_xrgb8888_to_xrgb2101010(pix);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_xbgr2101010(u32 pix)
+{
+	pix = ((pix & 0x00ff0000) >> 14) |
+	      ((pix & 0x0000ff00) << 4) |
+	      ((pix & 0x000000ff) << 22);
+	return pix | ((pix >> 8) & 0x00300c03);
+}
+
+static inline u32 drm_pixel_xrgb8888_to_abgr2101010(u32 pix)
+{
+	return GENMASK(31, 30) | /* set alpha bits */
+	       drm_pixel_xrgb8888_to_xbgr2101010(pix);
+}
+
+#endif
diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 0a9ecc1380d2..f128d345b16d 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -31,6 +31,7 @@
 #include <drm/drm_rect.h>
 
 #include "drm_crtc_internal.h"
+#include "drm_draw_internal.h"
 
 MODULE_AUTHOR("Jocelyn Falempe");
 MODULE_DESCRIPTION("DRM panic handler");
@@ -139,181 +140,8 @@ device_initcall(drm_panic_setup_logo);
 #endif
 
 /*
- * Color conversion
+ *  Blit & Fill functions
  */
-
-static u16 convert_xrgb8888_to_rgb565(u32 pix)
-{
-	return ((pix & 0x00F80000) >> 8) |
-	       ((pix & 0x0000FC00) >> 5) |
-	       ((pix & 0x000000F8) >> 3);
-}
-
-static u16 convert_xrgb8888_to_rgba5551(u32 pix)
-{
-	return ((pix & 0x00f80000) >> 8) |
-	       ((pix & 0x0000f800) >> 5) |
-	       ((pix & 0x000000f8) >> 2) |
-	       BIT(0); /* set alpha bit */
-}
-
-static u16 convert_xrgb8888_to_xrgb1555(u32 pix)
-{
-	return ((pix & 0x00f80000) >> 9) |
-	       ((pix & 0x0000f800) >> 6) |
-	       ((pix & 0x000000f8) >> 3);
-}
-
-static u16 convert_xrgb8888_to_argb1555(u32 pix)
-{
-	return BIT(15) | /* set alpha bit */
-	       ((pix & 0x00f80000) >> 9) |
-	       ((pix & 0x0000f800) >> 6) |
-	       ((pix & 0x000000f8) >> 3);
-}
-
-static u32 convert_xrgb8888_to_argb8888(u32 pix)
-{
-	return pix | GENMASK(31, 24); /* fill alpha bits */
-}
-
-static u32 convert_xrgb8888_to_xbgr8888(u32 pix)
-{
-	return ((pix & 0x00ff0000) >> 16) <<  0 |
-	       ((pix & 0x0000ff00) >>  8) <<  8 |
-	       ((pix & 0x000000ff) >>  0) << 16 |
-	       ((pix & 0xff000000) >> 24) << 24;
-}
-
-static u32 convert_xrgb8888_to_abgr8888(u32 pix)
-{
-	return ((pix & 0x00ff0000) >> 16) <<  0 |
-	       ((pix & 0x0000ff00) >>  8) <<  8 |
-	       ((pix & 0x000000ff) >>  0) << 16 |
-	       GENMASK(31, 24); /* fill alpha bits */
-}
-
-static u32 convert_xrgb8888_to_xrgb2101010(u32 pix)
-{
-	pix = ((pix & 0x000000FF) << 2) |
-	      ((pix & 0x0000FF00) << 4) |
-	      ((pix & 0x00FF0000) << 6);
-	return pix | ((pix >> 8) & 0x00300C03);
-}
-
-static u32 convert_xrgb8888_to_argb2101010(u32 pix)
-{
-	pix = ((pix & 0x000000FF) << 2) |
-	      ((pix & 0x0000FF00) << 4) |
-	      ((pix & 0x00FF0000) << 6);
-	return GENMASK(31, 30) /* set alpha bits */ | pix | ((pix >> 8) & 0x00300C03);
-}
-
-static u32 convert_xrgb8888_to_abgr2101010(u32 pix)
-{
-	pix = ((pix & 0x00FF0000) >> 14) |
-	      ((pix & 0x0000FF00) << 4) |
-	      ((pix & 0x000000FF) << 22);
-	return GENMASK(31, 30) /* set alpha bits */ | pix | ((pix >> 8) & 0x00300C03);
-}
-
-/*
- * convert_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
- * @color: input color, in xrgb8888 format
- * @format: output format
- *
- * Returns:
- * Color in the format specified, casted to u32.
- * Or 0 if the format is not supported.
- */
-static u32 convert_from_xrgb8888(u32 color, u32 format)
-{
-	switch (format) {
-	case DRM_FORMAT_RGB565:
-		return convert_xrgb8888_to_rgb565(color);
-	case DRM_FORMAT_RGBA5551:
-		return convert_xrgb8888_to_rgba5551(color);
-	case DRM_FORMAT_XRGB1555:
-		return convert_xrgb8888_to_xrgb1555(color);
-	case DRM_FORMAT_ARGB1555:
-		return convert_xrgb8888_to_argb1555(color);
-	case DRM_FORMAT_RGB888:
-	case DRM_FORMAT_XRGB8888:
-		return color;
-	case DRM_FORMAT_ARGB8888:
-		return convert_xrgb8888_to_argb8888(color);
-	case DRM_FORMAT_XBGR8888:
-		return convert_xrgb8888_to_xbgr8888(color);
-	case DRM_FORMAT_ABGR8888:
-		return convert_xrgb8888_to_abgr8888(color);
-	case DRM_FORMAT_XRGB2101010:
-		return convert_xrgb8888_to_xrgb2101010(color);
-	case DRM_FORMAT_ARGB2101010:
-		return convert_xrgb8888_to_argb2101010(color);
-	case DRM_FORMAT_ABGR2101010:
-		return convert_xrgb8888_to_abgr2101010(color);
-	default:
-		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
-		return 0;
-	}
-}
-
-/*
- * Blit & Fill
- */
-/* check if the pixel at coord x,y is 1 (foreground) or 0 (background) */
-static bool drm_panic_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, int x, int y)
-{
-	return (sbuf8[(y * spitch) + x / 8] & (0x80 >> (x % 8))) != 0;
-}
-
-static void drm_panic_blit16(struct iosys_map *dmap, unsigned int dpitch,
-			     const u8 *sbuf8, unsigned int spitch,
-			     unsigned int height, unsigned int width,
-			     unsigned int scale, u16 fg16)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
-				iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, fg16);
-}
-
-static void drm_panic_blit24(struct iosys_map *dmap, unsigned int dpitch,
-			     const u8 *sbuf8, unsigned int spitch,
-			     unsigned int height, unsigned int width,
-			     unsigned int scale, u32 fg32)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++) {
-		for (x = 0; x < width; x++) {
-			u32 off = y * dpitch + x * 3;
-
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale)) {
-				/* write blue-green-red to output in little endianness */
-				iosys_map_wr(dmap, off, u8, (fg32 & 0x000000FF) >> 0);
-				iosys_map_wr(dmap, off + 1, u8, (fg32 & 0x0000FF00) >> 8);
-				iosys_map_wr(dmap, off + 2, u8, (fg32 & 0x00FF0000) >> 16);
-			}
-		}
-	}
-}
-
-static void drm_panic_blit32(struct iosys_map *dmap, unsigned int dpitch,
-			     const u8 *sbuf8, unsigned int spitch,
-			     unsigned int height, unsigned int width,
-			     unsigned int scale, u32 fg32)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
-				iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, fg32);
-}
-
 static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 				 const u8 *sbuf8, unsigned int spitch, unsigned int scale,
 				 u32 fg_color)
@@ -322,7 +150,7 @@ static void drm_panic_blit_pixel(struct drm_scanout_buffer *sb, struct drm_rect
 
 	for (y = 0; y < drm_rect_height(clip); y++)
 		for (x = 0; x < drm_rect_width(clip); x++)
-			if (drm_panic_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
+			if (drm_draw_is_pixel_fg(sbuf8, spitch, x / scale, y / scale))
 				sb->set_pixel(sb, clip->x1 + x, clip->y1 + y, fg_color);
 }
 
@@ -354,62 +182,22 @@ static void drm_panic_blit(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 
 	switch (sb->format->cpp[0]) {
 	case 2:
-		drm_panic_blit16(&map, sb->pitch[0], sbuf8, spitch,
-				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
+		drm_draw_blit16(&map, sb->pitch[0], sbuf8, spitch,
+				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	case 3:
-		drm_panic_blit24(&map, sb->pitch[0], sbuf8, spitch,
-				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
+		drm_draw_blit24(&map, sb->pitch[0], sbuf8, spitch,
+				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	case 4:
-		drm_panic_blit32(&map, sb->pitch[0], sbuf8, spitch,
-				 drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
+		drm_draw_blit32(&map, sb->pitch[0], sbuf8, spitch,
+				drm_rect_height(clip), drm_rect_width(clip), scale, fg_color);
 	break;
 	default:
 		WARN_ONCE(1, "Can't blit with pixel width %d\n", sb->format->cpp[0]);
 	}
 }
 
-static void drm_panic_fill16(struct iosys_map *dmap, unsigned int dpitch,
-			     unsigned int height, unsigned int width,
-			     u16 color)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			iosys_map_wr(dmap, y * dpitch + x * sizeof(u16), u16, color);
-}
-
-static void drm_panic_fill24(struct iosys_map *dmap, unsigned int dpitch,
-			     unsigned int height, unsigned int width,
-			     u32 color)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++) {
-		for (x = 0; x < width; x++) {
-			unsigned int off = y * dpitch + x * 3;
-
-			/* write blue-green-red to output in little endianness */
-			iosys_map_wr(dmap, off, u8, (color & 0x000000FF) >> 0);
-			iosys_map_wr(dmap, off + 1, u8, (color & 0x0000FF00) >> 8);
-			iosys_map_wr(dmap, off + 2, u8, (color & 0x00FF0000) >> 16);
-		}
-	}
-}
-
-static void drm_panic_fill32(struct iosys_map *dmap, unsigned int dpitch,
-			     unsigned int height, unsigned int width,
-			     u32 color)
-{
-	unsigned int y, x;
-
-	for (y = 0; y < height; y++)
-		for (x = 0; x < width; x++)
-			iosys_map_wr(dmap, y * dpitch + x * sizeof(u32), u32, color);
-}
-
 static void drm_panic_fill_pixel(struct drm_scanout_buffer *sb,
 				 struct drm_rect *clip,
 				 u32 color)
@@ -442,27 +230,22 @@ static void drm_panic_fill(struct drm_scanout_buffer *sb, struct drm_rect *clip,
 
 	switch (sb->format->cpp[0]) {
 	case 2:
-		drm_panic_fill16(&map, sb->pitch[0], drm_rect_height(clip),
-				 drm_rect_width(clip), color);
+		drm_draw_fill16(&map, sb->pitch[0], drm_rect_height(clip),
+				drm_rect_width(clip), color);
 	break;
 	case 3:
-		drm_panic_fill24(&map, sb->pitch[0], drm_rect_height(clip),
-				 drm_rect_width(clip), color);
+		drm_draw_fill24(&map, sb->pitch[0], drm_rect_height(clip),
+				drm_rect_width(clip), color);
 	break;
 	case 4:
-		drm_panic_fill32(&map, sb->pitch[0], drm_rect_height(clip),
-				 drm_rect_width(clip), color);
+		drm_draw_fill32(&map, sb->pitch[0], drm_rect_height(clip),
+				drm_rect_width(clip), color);
 	break;
 	default:
 		WARN_ONCE(1, "Can't fill with pixel width %d\n", sb->format->cpp[0]);
 	}
 }
 
-static const u8 *get_char_bitmap(const struct font_desc *font, char c, size_t font_pitch)
-{
-	return font->data + (c * font->height) * font_pitch;
-}
-
 static unsigned int get_max_line_len(const struct drm_panic_line *lines, int len)
 {
 	int i;
@@ -501,7 +284,7 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
 			rec.x1 += (drm_rect_width(clip) - (line_len * font->width)) / 2;
 
 		for (j = 0; j < line_len; j++) {
-			src = get_char_bitmap(font, msg[i].txt[j], font_pitch);
+			src = drm_draw_get_char_bitmap(font, msg[i].txt[j], font_pitch);
 			rec.x2 = rec.x1 + font->width;
 			drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
 			rec.x1 += font->width;
@@ -533,8 +316,10 @@ static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *
 
 static void draw_panic_static_user(struct drm_scanout_buffer *sb)
 {
-	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
-	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
+	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
+						    sb->format->format);
+	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
+						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg;
 	unsigned int msg_width, msg_height;
@@ -600,8 +385,10 @@ static int draw_line_with_wrap(struct drm_scanout_buffer *sb, const struct font_
  */
 static void draw_panic_static_kmsg(struct drm_scanout_buffer *sb)
 {
-	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
-	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
+	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
+						    sb->format->format);
+	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
+						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
 	struct kmsg_dump_iter iter;
@@ -791,8 +578,10 @@ static int drm_panic_get_qr_code(u8 **qr_image)
  */
 static int _draw_panic_static_qr_code(struct drm_scanout_buffer *sb)
 {
-	u32 fg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR, sb->format->format);
-	u32 bg_color = convert_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR, sb->format->format);
+	u32 fg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_FOREGROUND_COLOR,
+						    sb->format->format);
+	u32 bg_color = drm_draw_color_from_xrgb8888(CONFIG_DRM_PANIC_BACKGROUND_COLOR,
+						    sb->format->format);
 	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
 	struct drm_rect r_screen, r_logo, r_msg, r_qr, r_qr_canvas;
 	unsigned int max_qr_size, scale;
@@ -878,7 +667,7 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
 {
 	if (format->num_planes != 1)
 		return false;
-	return convert_from_xrgb8888(0xffffff, format->format) != 0;
+	return drm_draw_color_from_xrgb8888(0xffffff, format->format) != 0;
 }
 
 static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 9f9b19ea0587..1640609cdbc0 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -258,13 +258,13 @@ static int hibmc_load(struct drm_device *dev)
 
 	ret = hibmc_hw_init(priv);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0),
 				    pci_resource_len(pdev, 0));
 	if (ret) {
 		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
-		goto err;
+		return ret;
 	}
 
 	ret = hibmc_kms_init(priv);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 6b566f3aeecb..6eb0d41a0f68 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -20,9 +20,10 @@
 
 #include <drm/drm_framebuffer.h>
 
-struct hibmc_connector {
-	struct drm_connector base;
-
+struct hibmc_vdac {
+	struct drm_device *dev;
+	struct drm_encoder encoder;
+	struct drm_connector connector;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data bit_data;
 };
@@ -35,13 +36,12 @@ struct hibmc_drm_private {
 	struct drm_device dev;
 	struct drm_plane primary_plane;
 	struct drm_crtc crtc;
-	struct drm_encoder encoder;
-	struct hibmc_connector connector;
+	struct hibmc_vdac vdac;
 };
 
-static inline struct hibmc_connector *to_hibmc_connector(struct drm_connector *connector)
+static inline struct hibmc_vdac *to_hibmc_vdac(struct drm_connector *connector)
 {
-	return container_of(connector, struct hibmc_connector, base);
+	return container_of(connector, struct hibmc_vdac, connector);
 }
 
 static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *dev)
@@ -57,6 +57,7 @@ void hibmc_set_current_gate(struct hibmc_drm_private *priv,
 int hibmc_de_init(struct hibmc_drm_private *priv);
 int hibmc_vdac_init(struct hibmc_drm_private *priv);
 
-int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_connector *connector);
+int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *connector);
+void hibmc_ddc_del(struct hibmc_vdac *vdac);
 
 #endif
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
index e6e48651c15c..44860011855e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_i2c.c
@@ -25,8 +25,8 @@
 
 static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
 {
-	struct hibmc_connector *hibmc_connector = data;
-	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
+	struct hibmc_vdac *vdac = data;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
 	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
 
 	if (value) {
@@ -45,8 +45,8 @@ static void hibmc_set_i2c_signal(void *data, u32 mask, int value)
 
 static int hibmc_get_i2c_signal(void *data, u32 mask)
 {
-	struct hibmc_connector *hibmc_connector = data;
-	struct hibmc_drm_private *priv = to_hibmc_drm_private(hibmc_connector->base.dev);
+	struct hibmc_vdac *vdac = data;
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(vdac->connector.dev);
 	u32 tmp_dir = readl(priv->mmio + GPIO_DATA_DIRECTION);
 
 	if ((tmp_dir & mask) != mask) {
@@ -77,22 +77,26 @@ static int hibmc_ddc_getscl(void *data)
 	return hibmc_get_i2c_signal(data, I2C_SCL_MASK);
 }
 
-int hibmc_ddc_create(struct drm_device *drm_dev,
-		     struct hibmc_connector *connector)
+int hibmc_ddc_create(struct drm_device *drm_dev, struct hibmc_vdac *vdac)
 {
-	connector->adapter.owner = THIS_MODULE;
-	snprintf(connector->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
-	connector->adapter.dev.parent = drm_dev->dev;
-	i2c_set_adapdata(&connector->adapter, connector);
-	connector->adapter.algo_data = &connector->bit_data;
-
-	connector->bit_data.udelay = 20;
-	connector->bit_data.timeout = usecs_to_jiffies(2000);
-	connector->bit_data.data = connector;
-	connector->bit_data.setsda = hibmc_ddc_setsda;
-	connector->bit_data.setscl = hibmc_ddc_setscl;
-	connector->bit_data.getsda = hibmc_ddc_getsda;
-	connector->bit_data.getscl = hibmc_ddc_getscl;
-
-	return i2c_bit_add_bus(&connector->adapter);
+	vdac->adapter.owner = THIS_MODULE;
+	snprintf(vdac->adapter.name, I2C_NAME_SIZE, "HIS i2c bit bus");
+	vdac->adapter.dev.parent = drm_dev->dev;
+	i2c_set_adapdata(&vdac->adapter, vdac);
+	vdac->adapter.algo_data = &vdac->bit_data;
+
+	vdac->bit_data.udelay = 20;
+	vdac->bit_data.timeout = usecs_to_jiffies(2000);
+	vdac->bit_data.data = vdac;
+	vdac->bit_data.setsda = hibmc_ddc_setsda;
+	vdac->bit_data.setscl = hibmc_ddc_setscl;
+	vdac->bit_data.getsda = hibmc_ddc_getsda;
+	vdac->bit_data.getscl = hibmc_ddc_getscl;
+
+	return i2c_bit_add_bus(&vdac->adapter);
+}
+
+void hibmc_ddc_del(struct hibmc_vdac *vdac)
+{
+	i2c_del_adapter(&vdac->adapter);
 }
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
index 409c551c92af..9e29386700c8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
@@ -24,11 +24,11 @@
 
 static int hibmc_connector_get_modes(struct drm_connector *connector)
 {
-	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
+	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
 	const struct drm_edid *drm_edid;
 	int count;
 
-	drm_edid = drm_edid_read_ddc(connector, &hibmc_connector->adapter);
+	drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
 
 	drm_edid_connector_update(connector, drm_edid);
 
@@ -51,9 +51,9 @@ static int hibmc_connector_get_modes(struct drm_connector *connector)
 
 static void hibmc_connector_destroy(struct drm_connector *connector)
 {
-	struct hibmc_connector *hibmc_connector = to_hibmc_connector(connector);
+	struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
 
-	i2c_del_adapter(&hibmc_connector->adapter);
+	hibmc_ddc_del(vdac);
 	drm_connector_cleanup(connector);
 }
 
@@ -93,23 +93,23 @@ static const struct drm_encoder_helper_funcs hibmc_encoder_helper_funcs = {
 int hibmc_vdac_init(struct hibmc_drm_private *priv)
 {
 	struct drm_device *dev = &priv->dev;
-	struct hibmc_connector *hibmc_connector = &priv->connector;
-	struct drm_encoder *encoder = &priv->encoder;
+	struct hibmc_vdac *vdac = &priv->vdac;
+	struct drm_encoder *encoder = &vdac->encoder;
 	struct drm_crtc *crtc = &priv->crtc;
-	struct drm_connector *connector = &hibmc_connector->base;
+	struct drm_connector *connector = &vdac->connector;
 	int ret;
 
-	ret = hibmc_ddc_create(dev, hibmc_connector);
+	ret = hibmc_ddc_create(dev, vdac);
 	if (ret) {
 		drm_err(dev, "failed to create ddc: %d\n", ret);
 		return ret;
 	}
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DAC);
+	ret = drmm_encoder_init(dev, encoder, NULL, DRM_MODE_ENCODER_DAC, NULL);
 	if (ret) {
 		drm_err(dev, "failed to init encoder: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
@@ -117,10 +117,10 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	ret = drm_connector_init_with_ddc(dev, connector,
 					  &hibmc_connector_funcs,
 					  DRM_MODE_CONNECTOR_VGA,
-					  &hibmc_connector->adapter);
+					  &vdac->adapter);
 	if (ret) {
 		drm_err(dev, "failed to init connector: %d\n", ret);
-		return ret;
+		goto err;
 	}
 
 	drm_connector_helper_add(connector, &hibmc_connector_helper_funcs);
@@ -128,4 +128,9 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
 	drm_connector_attach_encoder(connector, encoder);
 
 	return 0;
+
+err:
+	hibmc_ddc_del(vdac);
+
+	return ret;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_tc.c b/drivers/gpu/drm/i915/display/intel_tc.c
index 6f2ee7dbc43b..2fabddc8b6d9 100644
--- a/drivers/gpu/drm/i915/display/intel_tc.c
+++ b/drivers/gpu/drm/i915/display/intel_tc.c
@@ -63,6 +63,7 @@ struct intel_tc_port {
 	enum tc_port_mode init_mode;
 	enum phy_fia phy_fia;
 	u8 phy_fia_idx;
+	u8 max_lane_count;
 };
 
 static enum intel_display_power_domain
@@ -366,12 +367,12 @@ static int intel_tc_port_get_max_lane_count(struct intel_digital_port *dig_port)
 	}
 }
 
-int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
+static int get_max_lane_count(struct intel_tc_port *tc)
 {
+	struct intel_digital_port *dig_port = tc->dig_port;
 	struct drm_i915_private *i915 = to_i915(dig_port->base.base.dev);
-	struct intel_tc_port *tc = to_tc_port(dig_port);
 
-	if (!intel_encoder_is_tc(&dig_port->base) || tc->mode != TC_PORT_DP_ALT)
+	if (tc->mode != TC_PORT_DP_ALT)
 		return 4;
 
 	assert_tc_cold_blocked(tc);
@@ -385,6 +386,21 @@ int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
 	return intel_tc_port_get_max_lane_count(dig_port);
 }
 
+static void read_pin_configuration(struct intel_tc_port *tc)
+{
+	tc->max_lane_count = get_max_lane_count(tc);
+}
+
+int intel_tc_port_max_lane_count(struct intel_digital_port *dig_port)
+{
+	struct intel_tc_port *tc = to_tc_port(dig_port);
+
+	if (!intel_encoder_is_tc(&dig_port->base))
+		return 4;
+
+	return get_max_lane_count(tc);
+}
+
 void intel_tc_port_set_fia_lane_count(struct intel_digital_port *dig_port,
 				      int required_lanes)
 {
@@ -597,9 +613,12 @@ static void icl_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	tc_cold_wref = __tc_cold_block(tc, &domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	__tc_cold_unblock(tc, domain, tc_cold_wref);
 }
 
@@ -657,8 +676,11 @@ static bool icl_tc_phy_connect(struct intel_tc_port *tc,
 
 	tc->lock_wakeref = tc_cold_block(tc);
 
-	if (tc->mode == TC_PORT_TBT_ALT)
+	if (tc->mode == TC_PORT_TBT_ALT) {
+		read_pin_configuration(tc);
+
 		return true;
+	}
 
 	if ((!tc_phy_is_ready(tc) ||
 	     !icl_tc_phy_take_ownership(tc, true)) &&
@@ -669,6 +691,7 @@ static bool icl_tc_phy_connect(struct intel_tc_port *tc,
 		goto out_unblock_tc_cold;
 	}
 
+	read_pin_configuration(tc);
 
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_release_phy;
@@ -859,9 +882,12 @@ static void adlp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	port_wakeref = intel_display_power_get(i915, port_power_domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	intel_display_power_put(i915, port_power_domain, port_wakeref);
 }
 
@@ -874,6 +900,9 @@ static bool adlp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 
 	if (tc->mode == TC_PORT_TBT_ALT) {
 		tc->lock_wakeref = tc_cold_block(tc);
+
+		read_pin_configuration(tc);
+
 		return true;
 	}
 
@@ -895,6 +924,8 @@ static bool adlp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 
 	tc->lock_wakeref = tc_cold_block(tc);
 
+	read_pin_configuration(tc);
+
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_unblock_tc_cold;
 
@@ -1094,9 +1125,12 @@ static void xelpdp_tc_phy_get_hw_state(struct intel_tc_port *tc)
 	tc_cold_wref = __tc_cold_block(tc, &domain);
 
 	tc->mode = tc_phy_get_current_mode(tc);
-	if (tc->mode != TC_PORT_DISCONNECTED)
+	if (tc->mode != TC_PORT_DISCONNECTED) {
 		tc->lock_wakeref = tc_cold_block(tc);
 
+		read_pin_configuration(tc);
+	}
+
 	drm_WARN_ON(&i915->drm,
 		    (tc->mode == TC_PORT_DP_ALT || tc->mode == TC_PORT_LEGACY) &&
 		    !xelpdp_tc_phy_tcss_power_is_enabled(tc));
@@ -1108,14 +1142,19 @@ static bool xelpdp_tc_phy_connect(struct intel_tc_port *tc, int required_lanes)
 {
 	tc->lock_wakeref = tc_cold_block(tc);
 
-	if (tc->mode == TC_PORT_TBT_ALT)
+	if (tc->mode == TC_PORT_TBT_ALT) {
+		read_pin_configuration(tc);
+
 		return true;
+	}
 
 	if (!xelpdp_tc_phy_enable_tcss_power(tc, true))
 		goto out_unblock_tccold;
 
 	xelpdp_tc_phy_take_ownership(tc, true);
 
+	read_pin_configuration(tc);
+
 	if (!tc_phy_verify_legacy_or_dp_alt_mode(tc, required_lanes))
 		goto out_release_phy;
 
@@ -1416,7 +1455,8 @@ static void intel_tc_port_reset_mode(struct intel_tc_port *tc,
 
 		aux_domain = intel_aux_power_domain(dig_port);
 		aux_powered = intel_display_power_is_enabled(i915, aux_domain);
-		drm_WARN_ON(&i915->drm, aux_powered);
+		drm_dbg_kms(&i915->drm, "Port %s: AUX powered %d\n",
+			    tc->port_name, aux_powered);
 	}
 
 	tc_phy_disconnect(tc);
diff --git a/drivers/gpu/drm/nouveau/nvif/vmm.c b/drivers/gpu/drm/nouveau/nvif/vmm.c
index 99296f03371a..07c1ebc2a941 100644
--- a/drivers/gpu/drm/nouveau/nvif/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvif/vmm.c
@@ -219,7 +219,8 @@ nvif_vmm_ctor(struct nvif_mmu *mmu, const char *name, s32 oclass,
 	case RAW: args->type = NVIF_VMM_V0_TYPE_RAW; break;
 	default:
 		WARN_ON(1);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto done;
 	}
 
 	memcpy(args->data, argv, argc);
diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 08992636ec05..e17643c408bf 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -60,6 +60,11 @@ struct convert_to_rgb888_result {
 	const u8 expected[TEST_BUF_SIZE];
 };
 
+struct convert_to_bgr888_result {
+	unsigned int dst_pitch;
+	const u8 expected[TEST_BUF_SIZE];
+};
+
 struct convert_to_argb8888_result {
 	unsigned int dst_pitch;
 	const u32 expected[TEST_BUF_SIZE];
@@ -107,6 +112,7 @@ struct convert_xrgb8888_case {
 	struct convert_to_argb1555_result argb1555_result;
 	struct convert_to_rgba5551_result rgba5551_result;
 	struct convert_to_rgb888_result rgb888_result;
+	struct convert_to_bgr888_result bgr888_result;
 	struct convert_to_argb8888_result argb8888_result;
 	struct convert_to_xrgb2101010_result xrgb2101010_result;
 	struct convert_to_argb2101010_result argb2101010_result;
@@ -151,6 +157,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = TEST_USE_DEFAULT_PITCH,
 			.expected = { 0x00, 0x00, 0xFF },
 		},
+		.bgr888_result = {
+			.dst_pitch = TEST_USE_DEFAULT_PITCH,
+			.expected = { 0xFF, 0x00, 0x00 },
+		},
 		.argb8888_result = {
 			.dst_pitch = TEST_USE_DEFAULT_PITCH,
 			.expected = { 0xFFFF0000 },
@@ -217,6 +227,10 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 			.dst_pitch = TEST_USE_DEFAULT_PITCH,
 			.expected = { 0x00, 0x00, 0xFF },
 		},
+		.bgr888_result = {
+			.dst_pitch = TEST_USE_DEFAULT_PITCH,
+			.expected = { 0xFF, 0x00, 0x00 },
+		},
 		.argb8888_result = {
 			.dst_pitch = TEST_USE_DEFAULT_PITCH,
 			.expected = { 0xFFFF0000 },
@@ -330,6 +344,15 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x00,
 			},
 		},
+		.bgr888_result = {
+			.dst_pitch = TEST_USE_DEFAULT_PITCH,
+			.expected = {
+				0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00,
+				0xFF, 0x00, 0x00, 0x00, 0xFF, 0x00,
+				0x00, 0x00, 0xFF, 0xFF, 0x00, 0xFF,
+				0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF,
+			},
+		},
 		.argb8888_result = {
 			.dst_pitch = TEST_USE_DEFAULT_PITCH,
 			.expected = {
@@ -468,6 +491,17 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
 				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 			},
 		},
+		.bgr888_result = {
+			.dst_pitch = 15,
+			.expected = {
+				0x0E, 0x44, 0x9C, 0x11, 0x4D, 0x05, 0xA8, 0xF3, 0x03,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				0x6C, 0xF0, 0x73, 0x0E, 0x44, 0x9C, 0x11, 0x4D, 0x05,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				0xA8, 0x03, 0x03, 0x6C, 0xF0, 0x73, 0x0E, 0x44, 0x9C,
+				0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+			},
+		},
 		.argb8888_result = {
 			.dst_pitch = 20,
 			.expected = {
@@ -714,14 +748,9 @@ static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
 	buf = dst.vaddr;
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGB565, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_rgb565(&dst, dst_pitch, &src, &fb, &params->clip,
+				  &fmtcnv_state, false);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -761,14 +790,8 @@ static void drm_test_fb_xrgb8888_to_xrgb1555(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB1555, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_xrgb1555(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -808,14 +831,8 @@ static void drm_test_fb_xrgb8888_to_argb1555(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB1555, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_argb1555(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -855,14 +872,8 @@ static void drm_test_fb_xrgb8888_to_rgba5551(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGBA5551, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_rgba5551(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -905,12 +916,49 @@ static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
+	drm_fb_xrgb8888_to_rgb888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+}
+
+static void drm_test_fb_xrgb8888_to_bgr888(struct kunit *test)
+{
+	const struct convert_xrgb8888_case *params = test->param_value;
+	const struct convert_to_bgr888_result *result = &params->bgr888_result;
+	size_t dst_size;
+	u8 *buf = NULL;
+	__le32 *xrgb8888 = NULL;
+	struct iosys_map dst, src;
+
+	struct drm_framebuffer fb = {
+		.format = drm_format_info(DRM_FORMAT_XRGB8888),
+		.pitches = { params->pitch, 0, 0 },
+	};
+
+	dst_size = conversion_buf_size(DRM_FORMAT_BGR888, result->dst_pitch,
+				       &params->clip, 0);
+	KUNIT_ASSERT_GT(test, dst_size, 0);
+
+	buf = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	iosys_map_set_vaddr(&dst, buf);
+
+	xrgb8888 = cpubuf_to_le32(test, params->xrgb8888, TEST_BUF_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xrgb8888);
+	iosys_map_set_vaddr(&src, xrgb8888);
 
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGB888, &src, &fb, &params->clip,
+	/*
+	 * BGR888 expected results are already in little-endian
+	 * order, so there's no need to convert the test output.
+	 */
+	drm_fb_xrgb8888_to_bgr888(&dst, &result->dst_pitch, &src, &fb, &params->clip,
 				  &fmtcnv_state);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
-	KUNIT_EXPECT_FALSE(test, blit_result);
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, dst_size);
+
+	drm_fb_xrgb8888_to_bgr888(&dst, &result->dst_pitch, &src, &fb, &params->clip,
+				  &fmtcnv_state);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -950,14 +998,8 @@ static void drm_test_fb_xrgb8888_to_argb8888(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_argb8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -991,18 +1033,14 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
 		NULL : &result->dst_pitch;
 
 	drm_fb_xrgb8888_to_xrgb2101010(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
-	buf = le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB2101010, &src, &fb,
-				  &params->clip, &fmtcnv_state);
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
+	drm_fb_xrgb8888_to_xrgb2101010(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1042,14 +1080,8 @@ static void drm_test_fb_xrgb8888_to_argb2101010(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB2101010, &src, &fb,
-				  &params->clip, &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_argb2101010(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1122,23 +1154,15 @@ static void drm_test_fb_swab(struct kunit *test)
 	buf = dst.vaddr; /* restore original value of buf */
 	memset(buf, 0, dst_size);
 
-	int blit_result;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB8888 | DRM_FORMAT_BIG_ENDIAN,
-				  &src, &fb, &params->clip, &fmtcnv_state);
+	drm_fb_swab(&dst, dst_pitch, &src, &fb, &params->clip, false, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
 	buf = dst.vaddr;
 	memset(buf, 0, dst_size);
 
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_BGRX8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
+	drm_fb_xrgb8888_to_bgrx8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 
 	buf = dst.vaddr;
@@ -1149,11 +1173,8 @@ static void drm_test_fb_swab(struct kunit *test)
 	mock_format.format |= DRM_FORMAT_BIG_ENDIAN;
 	fb.format = &mock_format;
 
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
+	drm_fb_swab(&dst, dst_pitch, &src, &fb, &params->clip, false, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1186,14 +1207,8 @@ static void drm_test_fb_xrgb8888_to_abgr8888(struct kunit *test)
 	const unsigned int *dst_pitch = (result->dst_pitch == TEST_USE_DEFAULT_PITCH) ?
 		NULL : &result->dst_pitch;
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ABGR8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_abgr8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1226,14 +1241,8 @@ static void drm_test_fb_xrgb8888_to_xbgr8888(struct kunit *test)
 	const unsigned int *dst_pitch = (result->dst_pitch == TEST_USE_DEFAULT_PITCH) ?
 		NULL : &result->dst_pitch;
 
-	int blit_result = 0;
-
-	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XBGR8888, &src, &fb, &params->clip,
-				  &fmtcnv_state);
-
+	drm_fb_xrgb8888_to_xbgr8888(&dst, dst_pitch, &src, &fb, &params->clip, &fmtcnv_state);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
-
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
@@ -1830,12 +1839,8 @@ static void drm_test_fb_memcpy(struct kunit *test)
 		memset(buf[i], 0, dst_size[i]);
 	}
 
-	int blit_result;
-
-	blit_result = drm_fb_blit(dst, dst_pitches, params->format, src, &fb, &params->clip,
-				  &fmtcnv_state);
+	drm_fb_memcpy(dst, dst_pitches, src, &fb, &params->clip);
 
-	KUNIT_EXPECT_FALSE(test, blit_result);
 	for (size_t i = 0; i < fb.format->num_planes; i++) {
 		expected[i] = cpubuf_to_le32(test, params->expected[i], TEST_BUF_SIZE);
 		KUNIT_EXPECT_MEMEQ_MSG(test, buf[i], expected[i], dst_size[i],
@@ -1851,6 +1856,7 @@ static struct kunit_case drm_format_helper_test_cases[] = {
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_argb1555, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgba5551, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_rgb888, convert_xrgb8888_gen_params),
+	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_bgr888, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_argb8888, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_xrgb2101010, convert_xrgb8888_gen_params),
 	KUNIT_CASE_PARAM(drm_test_fb_xrgb8888_to_argb2101010, convert_xrgb8888_gen_params),
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 93e742c1f21e..f15c27070ff4 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -3,6 +3,7 @@ config DRM_XE
 	tristate "Intel Xe Graphics"
 	depends on DRM && PCI && MMU
 	depends on KUNIT || !KUNIT
+	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs
diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
index 4514f3ed90cc..3e065e6ab4fc 100644
--- a/drivers/hwmon/gsc-hwmon.c
+++ b/drivers/hwmon/gsc-hwmon.c
@@ -65,7 +65,7 @@ static ssize_t pwm_auto_point_temp_show(struct device *dev,
 		return ret;
 
 	ret = regs[0] | regs[1] << 8;
-	return sprintf(buf, "%d\n", ret * 10);
+	return sprintf(buf, "%d\n", ret * 100);
 }
 
 static ssize_t pwm_auto_point_temp_store(struct device *dev,
@@ -100,7 +100,7 @@ static ssize_t pwm_auto_point_pwm_show(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 
-	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)));
+	return sprintf(buf, "%d\n", 255 * (50 + (attr->index * 10)) / 100);
 }
 
 static SENSOR_DEVICE_ATTR_RO(pwm1_auto_point1_pwm, pwm_auto_point_pwm, 0);
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 2eebc6f761a6..19b583e00753 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1243,6 +1243,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan_st_priv->cfg.bipolar = false;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
 		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
 
 		chan_index++;
@@ -1307,7 +1308,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
 		chan->channel = ain[0];
 		chan_st_priv->chan_reg = chan_index;
 		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
-		chan_st_priv->cfg.odr = 0;
+		chan_st_priv->cfg.odr = st->info->odr_start_value;
 
 		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
 		if (chan_st_priv->cfg.bipolar)
diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 39196a2862cf..5d0bfabc69ea 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -407,7 +407,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
+static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
@@ -535,7 +535,7 @@ static bool ad_sd_validate_scan_mask(struct iio_dev *indio_dev, const unsigned l
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.postdisable = &ad_sd_buffer_postdisable,
+	.predisable = &ad_sd_buffer_predisable,
 	.validate_scan_mask = &ad_sd_validate_scan_mask,
 };
 
diff --git a/drivers/iio/imu/bno055/bno055.c b/drivers/iio/imu/bno055/bno055.c
index ea6519b22b2f..0b2d6ad699f3 100644
--- a/drivers/iio/imu/bno055/bno055.c
+++ b/drivers/iio/imu/bno055/bno055.c
@@ -118,6 +118,7 @@ struct bno055_sysfs_attr {
 	int len;
 	int *fusion_vals;
 	int *hw_xlate;
+	int hw_xlate_len;
 	int type;
 };
 
@@ -170,20 +171,24 @@ static int bno055_gyr_scale_vals[] = {
 	1000, 1877467, 2000, 1877467,
 };
 
+static int bno055_gyr_scale_hw_xlate[] = {0, 1, 2, 3, 4};
 static struct bno055_sysfs_attr bno055_gyr_scale = {
 	.vals = bno055_gyr_scale_vals,
 	.len = ARRAY_SIZE(bno055_gyr_scale_vals),
 	.fusion_vals = (int[]){1, 900},
-	.hw_xlate = (int[]){4, 3, 2, 1, 0},
+	.hw_xlate = bno055_gyr_scale_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_scale_hw_xlate),
 	.type = IIO_VAL_FRACTIONAL,
 };
 
 static int bno055_gyr_lpf_vals[] = {12, 23, 32, 47, 64, 116, 230, 523};
+static int bno055_gyr_lpf_hw_xlate[] = {5, 4, 7, 3, 6, 2, 1, 0};
 static struct bno055_sysfs_attr bno055_gyr_lpf = {
 	.vals = bno055_gyr_lpf_vals,
 	.len = ARRAY_SIZE(bno055_gyr_lpf_vals),
 	.fusion_vals = (int[]){32},
-	.hw_xlate = (int[]){5, 4, 7, 3, 6, 2, 1, 0},
+	.hw_xlate = bno055_gyr_lpf_hw_xlate,
+	.hw_xlate_len = ARRAY_SIZE(bno055_gyr_lpf_hw_xlate),
 	.type = IIO_VAL_INT,
 };
 
@@ -561,7 +566,7 @@ static int bno055_get_regmask(struct bno055_priv *priv, int *val, int *val2,
 
 	idx = (hwval & mask) >> shift;
 	if (attr->hw_xlate)
-		for (i = 0; i < attr->len; i++)
+		for (i = 0; i < attr->hw_xlate_len; i++)
 			if (attr->hw_xlate[i] == idx) {
 				idx = i;
 				break;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 18787a43477b..76c3802beda8 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -164,11 +164,11 @@ struct inv_icm42600_state {
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
-	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
+	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
 	struct inv_icm42600_fifo fifo;
 	struct {
-		int64_t gyro;
-		int64_t accel;
+		s64 gyro;
+		s64 accel;
 	} timestamp;
 };
 
@@ -410,7 +410,7 @@ const struct iio_mount_matrix *
 inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
 			      const struct iio_chan_spec *chan);
 
-uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr);
+u32 inv_icm42600_odr_to_period(enum inv_icm42600_odr odr);
 
 int inv_icm42600_set_accel_conf(struct inv_icm42600_state *st,
 				struct inv_icm42600_sensor_conf *conf,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
index 7968aa27f9fd..8da15cde388a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
@@ -177,8 +177,8 @@ static const struct iio_chan_spec inv_icm42600_accel_channels[] = {
  */
 struct inv_icm42600_accel_buffer {
 	struct inv_icm42600_fifo_sensor_data accel;
-	int16_t temp;
-	int64_t timestamp __aligned(8);
+	s16 temp;
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_ACCEL_3AXIS				\
@@ -241,7 +241,7 @@ static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
 
 static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 					  struct iio_chan_spec const *chan,
-					  int16_t *val)
+					  s16 *val)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
@@ -284,7 +284,7 @@ static int inv_icm42600_accel_read_sensor(struct iio_dev *indio_dev,
 	if (ret)
 		goto exit;
 
-	*val = (int16_t)be16_to_cpup(data);
+	*val = (s16)be16_to_cpup(data);
 	if (*val == INV_ICM42600_DATA_INVALID)
 		ret = -EINVAL;
 exit:
@@ -492,11 +492,11 @@ static int inv_icm42600_accel_read_offset(struct inv_icm42600_state *st,
 					  int *val, int *val2)
 {
 	struct device *dev = regmap_get_device(st->map);
-	int64_t val64;
-	int32_t bias;
+	s64 val64;
+	s32 bias;
 	unsigned int reg;
-	int16_t offset;
-	uint8_t data[2];
+	s16 offset;
+	u8 data[2];
 	int ret;
 
 	if (chan->type != IIO_ACCEL)
@@ -550,7 +550,7 @@ static int inv_icm42600_accel_read_offset(struct inv_icm42600_state *st,
 	 * result in micro (1000000)
 	 * (offset * 5 * 9.806650 * 1000000) / 10000
 	 */
-	val64 = (int64_t)offset * 5LL * 9806650LL;
+	val64 = (s64)offset * 5LL * 9806650LL;
 	/* for rounding, add + or - divisor (10000) divided by 2 */
 	if (val64 >= 0)
 		val64 += 10000LL / 2LL;
@@ -568,10 +568,10 @@ static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
 					   int val, int val2)
 {
 	struct device *dev = regmap_get_device(st->map);
-	int64_t val64;
-	int32_t min, max;
+	s64 val64;
+	s32 min, max;
 	unsigned int reg, regval;
-	int16_t offset;
+	s16 offset;
 	int ret;
 
 	if (chan->type != IIO_ACCEL)
@@ -596,7 +596,7 @@ static int inv_icm42600_accel_write_offset(struct inv_icm42600_state *st,
 	      inv_icm42600_accel_calibbias[1];
 	max = inv_icm42600_accel_calibbias[4] * 1000000L +
 	      inv_icm42600_accel_calibbias[5];
-	val64 = (int64_t)val * 1000000LL + (int64_t)val2;
+	val64 = (s64)val * 1000000LL + (s64)val2;
 	if (val64 < min || val64 > max)
 		return -EINVAL;
 
@@ -671,7 +671,7 @@ static int inv_icm42600_accel_read_raw(struct iio_dev *indio_dev,
 				       int *val, int *val2, long mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	int16_t data;
+	s16 data;
 	int ret;
 
 	switch (chan->type) {
@@ -905,7 +905,8 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 	const int8_t *temp;
 	unsigned int odr;
 	int64_t ts_val;
-	struct inv_icm42600_accel_buffer buffer;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_accel_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -924,8 +925,6 @@ int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
index aae7c56481a3..00b9db52ca78 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.c
@@ -26,28 +26,28 @@
 #define INV_ICM42600_FIFO_HEADER_ODR_GYRO	BIT(0)
 
 struct inv_icm42600_fifo_1sensor_packet {
-	uint8_t header;
+	u8 header;
 	struct inv_icm42600_fifo_sensor_data data;
-	int8_t temp;
+	s8 temp;
 } __packed;
 #define INV_ICM42600_FIFO_1SENSOR_PACKET_SIZE		8
 
 struct inv_icm42600_fifo_2sensors_packet {
-	uint8_t header;
+	u8 header;
 	struct inv_icm42600_fifo_sensor_data accel;
 	struct inv_icm42600_fifo_sensor_data gyro;
-	int8_t temp;
+	s8 temp;
 	__be16 timestamp;
 } __packed;
 #define INV_ICM42600_FIFO_2SENSORS_PACKET_SIZE		16
 
 ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **accel,
-					const void **gyro, const int8_t **temp,
+					const void **gyro, const s8 **temp,
 					const void **timestamp, unsigned int *odr)
 {
 	const struct inv_icm42600_fifo_1sensor_packet *pack1 = packet;
 	const struct inv_icm42600_fifo_2sensors_packet *pack2 = packet;
-	uint8_t header = *((const uint8_t *)packet);
+	u8 header = *((const u8 *)packet);
 
 	/* FIFO empty */
 	if (header & INV_ICM42600_FIFO_HEADER_MSG) {
@@ -100,7 +100,7 @@ ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **accel,
 
 void inv_icm42600_buffer_update_fifo_period(struct inv_icm42600_state *st)
 {
-	uint32_t period_gyro, period_accel, period;
+	u32 period_gyro, period_accel, period;
 
 	if (st->fifo.en & INV_ICM42600_SENSOR_GYRO)
 		period_gyro = inv_icm42600_odr_to_period(st->conf.gyro.odr);
@@ -204,8 +204,8 @@ int inv_icm42600_buffer_update_watermark(struct inv_icm42600_state *st)
 {
 	size_t packet_size, wm_size;
 	unsigned int wm_gyro, wm_accel, watermark;
-	uint32_t period_gyro, period_accel, period;
-	uint32_t latency_gyro, latency_accel, latency;
+	u32 period_gyro, period_accel, period;
+	u32 latency_gyro, latency_accel, latency;
 	bool restore;
 	__le16 raw_wm;
 	int ret;
@@ -459,7 +459,7 @@ int inv_icm42600_buffer_fifo_read(struct inv_icm42600_state *st,
 	__be16 *raw_fifo_count;
 	ssize_t i, size;
 	const void *accel, *gyro, *timestamp;
-	const int8_t *temp;
+	const s8 *temp;
 	unsigned int odr;
 	int ret;
 
@@ -550,7 +550,7 @@ int inv_icm42600_buffer_hwfifo_flush(struct inv_icm42600_state *st,
 	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
 	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
 	struct inv_sensors_timestamp *ts;
-	int64_t gyro_ts, accel_ts;
+	s64 gyro_ts, accel_ts;
 	int ret;
 
 	gyro_ts = iio_get_time_ns(st->indio_gyro);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
index f6c85daf42b0..ffca4da1e249 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_buffer.h
@@ -28,7 +28,7 @@ struct inv_icm42600_state;
 struct inv_icm42600_fifo {
 	unsigned int on;
 	unsigned int en;
-	uint32_t period;
+	u32 period;
 	struct {
 		unsigned int gyro;
 		unsigned int accel;
@@ -41,7 +41,7 @@ struct inv_icm42600_fifo {
 		size_t accel;
 		size_t total;
 	} nb;
-	uint8_t data[2080] __aligned(IIO_DMA_MINALIGN);
+	u8 data[2080] __aligned(IIO_DMA_MINALIGN);
 };
 
 /* FIFO data packet */
@@ -52,7 +52,7 @@ struct inv_icm42600_fifo_sensor_data {
 } __packed;
 #define INV_ICM42600_FIFO_DATA_INVALID		-32768
 
-static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d)
+static inline s16 inv_icm42600_fifo_get_sensor_data(__be16 d)
 {
 	return be16_to_cpu(d);
 }
@@ -60,7 +60,7 @@ static inline int16_t inv_icm42600_fifo_get_sensor_data(__be16 d)
 static inline bool
 inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_data *s)
 {
-	int16_t x, y, z;
+	s16 x, y, z;
 
 	x = inv_icm42600_fifo_get_sensor_data(s->x);
 	y = inv_icm42600_fifo_get_sensor_data(s->y);
@@ -75,7 +75,7 @@ inv_icm42600_fifo_is_data_valid(const struct inv_icm42600_fifo_sensor_data *s)
 }
 
 ssize_t inv_icm42600_fifo_decode_packet(const void *packet, const void **accel,
-					const void **gyro, const int8_t **temp,
+					const void **gyro, const s8 **temp,
 					const void **timestamp, unsigned int *odr);
 
 extern const struct iio_buffer_setup_ops inv_icm42600_buffer_ops;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a0bed49c3ba6..73aeddf53b76 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -103,7 +103,7 @@ const struct regmap_config inv_icm42600_spi_regmap_config = {
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, IIO_ICM42600);
 
 struct inv_icm42600_hw {
-	uint8_t whoami;
+	u8 whoami;
 	const char *name;
 	const struct inv_icm42600_conf *conf;
 };
@@ -188,9 +188,9 @@ inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
 	return &st->orientation;
 }
 
-uint32_t inv_icm42600_odr_to_period(enum inv_icm42600_odr odr)
+u32 inv_icm42600_odr_to_period(enum inv_icm42600_odr odr)
 {
-	static uint32_t odr_periods[INV_ICM42600_ODR_NB] = {
+	static u32 odr_periods[INV_ICM42600_ODR_NB] = {
 		/* reserved values */
 		0, 0, 0,
 		/* 8kHz */
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
index c6bb68bf5e14..6c7430dac6db 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c
@@ -77,8 +77,8 @@ static const struct iio_chan_spec inv_icm42600_gyro_channels[] = {
  */
 struct inv_icm42600_gyro_buffer {
 	struct inv_icm42600_fifo_sensor_data gyro;
-	int16_t temp;
-	int64_t timestamp __aligned(8);
+	s16 temp;
+	aligned_s64 timestamp;
 };
 
 #define INV_ICM42600_SCAN_MASK_GYRO_3AXIS				\
@@ -139,7 +139,7 @@ static int inv_icm42600_gyro_update_scan_mode(struct iio_dev *indio_dev,
 
 static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
 					 struct iio_chan_spec const *chan,
-					 int16_t *val)
+					 s16 *val)
 {
 	struct device *dev = regmap_get_device(st->map);
 	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
@@ -179,7 +179,7 @@ static int inv_icm42600_gyro_read_sensor(struct inv_icm42600_state *st,
 	if (ret)
 		goto exit;
 
-	*val = (int16_t)be16_to_cpup(data);
+	*val = (s16)be16_to_cpup(data);
 	if (*val == INV_ICM42600_DATA_INVALID)
 		ret = -EINVAL;
 exit:
@@ -399,11 +399,11 @@ static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
 					 int *val, int *val2)
 {
 	struct device *dev = regmap_get_device(st->map);
-	int64_t val64;
-	int32_t bias;
+	s64 val64;
+	s32 bias;
 	unsigned int reg;
-	int16_t offset;
-	uint8_t data[2];
+	s16 offset;
+	u8 data[2];
 	int ret;
 
 	if (chan->type != IIO_ANGL_VEL)
@@ -457,7 +457,7 @@ static int inv_icm42600_gyro_read_offset(struct inv_icm42600_state *st,
 	 * result in nano (1000000000)
 	 * (offset * 64 * Pi * 1000000000) / (2048 * 180)
 	 */
-	val64 = (int64_t)offset * 64LL * 3141592653LL;
+	val64 = (s64)offset * 64LL * 3141592653LL;
 	/* for rounding, add + or - divisor (2048 * 180) divided by 2 */
 	if (val64 >= 0)
 		val64 += 2048 * 180 / 2;
@@ -475,9 +475,9 @@ static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
 					  int val, int val2)
 {
 	struct device *dev = regmap_get_device(st->map);
-	int64_t val64, min, max;
+	s64 val64, min, max;
 	unsigned int reg, regval;
-	int16_t offset;
+	s16 offset;
 	int ret;
 
 	if (chan->type != IIO_ANGL_VEL)
@@ -498,11 +498,11 @@ static int inv_icm42600_gyro_write_offset(struct inv_icm42600_state *st,
 	}
 
 	/* inv_icm42600_gyro_calibbias: min - step - max in nano */
-	min = (int64_t)inv_icm42600_gyro_calibbias[0] * 1000000000LL +
-	      (int64_t)inv_icm42600_gyro_calibbias[1];
-	max = (int64_t)inv_icm42600_gyro_calibbias[4] * 1000000000LL +
-	      (int64_t)inv_icm42600_gyro_calibbias[5];
-	val64 = (int64_t)val * 1000000000LL + (int64_t)val2;
+	min = (s64)inv_icm42600_gyro_calibbias[0] * 1000000000LL +
+	      (s64)inv_icm42600_gyro_calibbias[1];
+	max = (s64)inv_icm42600_gyro_calibbias[4] * 1000000000LL +
+	      (s64)inv_icm42600_gyro_calibbias[5];
+	val64 = (s64)val * 1000000000LL + (s64)val2;
 	if (val64 < min || val64 > max)
 		return -EINVAL;
 
@@ -577,7 +577,7 @@ static int inv_icm42600_gyro_read_raw(struct iio_dev *indio_dev,
 				      int *val, int *val2, long mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	int16_t data;
+	s16 data;
 	int ret;
 
 	switch (chan->type) {
@@ -806,10 +806,11 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 	ssize_t i, size;
 	unsigned int no;
 	const void *accel, *gyro, *timestamp;
-	const int8_t *temp;
+	const s8 *temp;
 	unsigned int odr;
-	int64_t ts_val;
-	struct inv_icm42600_gyro_buffer buffer;
+	s64 ts_val;
+	/* buffer is copied to userspace, zeroing it to avoid any data leak */
+	struct inv_icm42600_gyro_buffer buffer = { };
 
 	/* parse all fifo packets */
 	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
@@ -828,8 +829,6 @@ int inv_icm42600_gyro_parse_fifo(struct iio_dev *indio_dev)
 			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
 							st->fifo.nb.total, no);
 
-		/* buffer is copied to userspace, zeroing it to avoid any data leak */
-		memset(&buffer, 0, sizeof(buffer));
 		memcpy(&buffer.gyro, gyro, sizeof(buffer.gyro));
 		/* convert 8 bits FIFO temperature in high resolution format */
 		buffer.temp = temp ? (*temp * 64) : 0;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
index 91f0f381082b..51430b4f5e51 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_temp.c
@@ -13,7 +13,7 @@
 #include "inv_icm42600.h"
 #include "inv_icm42600_temp.h"
 
-static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int16_t *temp)
+static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
 {
 	struct device *dev = regmap_get_device(st->map);
 	__be16 *raw;
@@ -31,9 +31,13 @@ static int inv_icm42600_temp_read(struct inv_icm42600_state *st, int16_t *temp)
 	if (ret)
 		goto exit;
 
-	*temp = (int16_t)be16_to_cpup(raw);
+	*temp = (s16)be16_to_cpup(raw);
+	/*
+	 * Temperature data is invalid if both accel and gyro are off.
+	 * Return -EBUSY in this case.
+	 */
 	if (*temp == INV_ICM42600_DATA_INVALID)
-		ret = -EINVAL;
+		ret = -EBUSY;
 
 exit:
 	mutex_unlock(&st->lock);
@@ -48,7 +52,7 @@ int inv_icm42600_temp_read_raw(struct iio_dev *indio_dev,
 			       int *val, int *val2, long mask)
 {
 	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
-	int16_t temp;
+	s16 temp;
 	int ret;
 
 	if (chan->type != IIO_TEMP)
diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index c1b43053fbc7..cf96e3dd8bc6 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -56,7 +56,7 @@ struct adjd_s311_data {
 	struct i2c_client *client;
 	struct {
 		s16 chans[4];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
index 11fbdcdd26d6..36f6f2eb53b2 100644
--- a/drivers/iio/light/as73211.c
+++ b/drivers/iio/light/as73211.c
@@ -642,8 +642,8 @@ static irqreturn_t as73211_trigger_handler(int irq __always_unused, void *p)
 	struct as73211_data *data = iio_priv(indio_dev);
 	struct {
 		__le16 chan[4];
-		s64 ts __aligned(8);
-	} scan;
+		aligned_s64 ts;
+	} scan = { };
 	int data_result, ret;
 
 	mutex_lock(&data->mutex);
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index a025e279df07..617d098d202a 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -743,7 +743,7 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 	struct bh1745_data *data = iio_priv(indio_dev);
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 	u16 value;
 	int ret;
diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index b176bf4c884b..326dc39e7929 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -54,7 +54,7 @@ struct isl29125_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[3];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 640a5d3aa2c6..8c0b616815b2 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1285,7 +1285,7 @@ static irqreturn_t ltr501_trigger_handler(int irq, void *p)
 	struct ltr501_data *data = iio_priv(indio_dev);
 	struct {
 		u16 channels[3];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 	__le16 als_buf[2];
 	u8 mask = 0;
diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index b935976871a6..e8b767680133 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -78,7 +78,7 @@ struct max44000_data {
 	/* Ensure naturally aligned timestamp */
 	struct {
 		u16 channels[2];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27034.c
index 76711c3cdf7c..29da3313addb 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -205,7 +205,7 @@ struct bu27034_data {
 	struct {
 		u32 mlux;
 		__le16 channels[BU27034_NUM_HW_DATA_CHANS];
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 78c08e0bd077..0a5408c12cc0 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -203,7 +203,7 @@ struct rpr0521_data {
 	struct {
 		__le16 channels[3];
 		u8 garbage;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
index 283086887caf..1f93e3dc45c2 100644
--- a/drivers/iio/light/st_uvis25.h
+++ b/drivers/iio/light/st_uvis25.h
@@ -30,7 +30,7 @@ struct st_uvis25_hw {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u8 chan;
-		s64 ts __aligned(8);
+		aligned_s64 ts;
 	} scan;
 };
 
diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 4fecdf10aeb1..884e43e4cda4 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -56,7 +56,7 @@ struct tcs3414_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 04452b4664f3..afc90b5bb0ec 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -67,7 +67,7 @@ struct tcs3472_data {
 	/* Ensure timestamp is naturally aligned */
 	struct {
 		u16 chans[4];
-		s64 timestamp __aligned(8);
+		aligned_s64 timestamp;
 	} scan;
 };
 
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a8b97b9b0461..9e46aa65acef 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2727,11 +2727,12 @@ int bmp280_common_probe(struct device *dev,
 
 	/* Bring chip out of reset if there is an assigned GPIO line */
 	gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod))
+		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
+
 	/* Deassert the signal */
-	if (gpiod) {
-		dev_info(dev, "release reset\n");
-		gpiod_set_value(gpiod, 0);
-	}
+	dev_info(dev, "release reset\n");
+	gpiod_set_value(gpiod, 0);
 
 	data->regmap = regmap;
 
diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index dc66ca9bba6b..fde9bdd14506 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,12 +938,18 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
-
-	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
-		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+	u32 value;
+	struct {
+		u16 data;
+		aligned_s64 ts;
+	} scan = { };
+
+	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask)) {
+		isl29501_register_read(isl29501, REG_DISTANCE, &value);
+		scan.data = value;
+	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 555a61e2f3fd..44fba61ccfe2 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -122,8 +123,15 @@ struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
 	char tc_type;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
+	/* Buffer for reading up to 2 hardware channels. */
+	struct {
+		union {
+			__be16 raw16;
+			__be32 raw32;
+			__be16 raw[2];
+		};
+		aligned_s64 timestamp;
+	} buffer __aligned(IIO_DMA_MINALIGN);
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
@@ -131,18 +139,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
 {
 	unsigned int storage_bytes = data->chip->read_size;
 	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
-	__be16 buf16;
-	__be32 buf32;
 	int ret;
 
 	switch (storage_bytes) {
 	case 2:
-		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
-		*val = be16_to_cpu(buf16);
+		ret = spi_read(data->spi, &data->buffer.raw16, storage_bytes);
+		*val = be16_to_cpu(data->buffer.raw16);
 		break;
 	case 4:
-		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
-		*val = be32_to_cpu(buf32);
+		ret = spi_read(data->spi, &data->buffer.raw32, storage_bytes);
+		*val = be32_to_cpu(data->buffer.raw32);
 		break;
 	default:
 		ret = -EINVAL;
@@ -167,9 +173,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
 	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
+	ret = spi_read(data->spi, data->buffer.raw, data->chip->read_size);
 	if (!ret) {
-		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+		iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 						   iio_get_time_ns(indio_dev));
 	}
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 4a3ce61a3bba..b222bf4f38e1 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -1874,7 +1874,6 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 	struct bnxt_re_srq *srq = container_of(ib_srq, struct bnxt_re_srq,
 					       ib_srq);
 	struct bnxt_re_dev *rdev = srq->rdev;
-	int rc;
 
 	switch (srq_attr_mask) {
 	case IB_SRQ_MAX_WR:
@@ -1886,11 +1885,8 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr,
 			return -EINVAL;
 
 		srq->qplib_srq.threshold = srq_attr->srq_limit;
-		rc = bnxt_qplib_modify_srq(&rdev->qplib_res, &srq->qplib_srq);
-		if (rc) {
-			ibdev_err(&rdev->ibdev, "Modify HW SRQ failed!");
-			return rc;
-		}
+		bnxt_qplib_srq_arm_db(&srq->qplib_srq.dbinfo, srq->qplib_srq.threshold);
+
 		/* On success, update the shadow */
 		srq->srq_limit = srq_attr->srq_limit;
 		/* No need to Build and send response back to udata */
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9bd837a5b8a1..b213ecca2854 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1615,6 +1615,28 @@ static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
 	rdev->nqr = NULL;
 }
 
+/* When DEL_GID fails, driver is not freeing GID ctx memory.
+ * To avoid the memory leak, free the memory during unload
+ */
+static void bnxt_re_free_gid_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_sgid_tbl *sgid_tbl = &rdev->qplib_res.sgid_tbl;
+	struct bnxt_re_gid_ctx *ctx, **ctx_tbl;
+	int i;
+
+	if (!sgid_tbl->active)
+		return;
+
+	ctx_tbl = sgid_tbl->ctx;
+	for (i = 0; i < sgid_tbl->max; i++) {
+		if (sgid_tbl->hw_id[i] == 0xFFFF)
+			continue;
+
+		ctx = ctx_tbl[i];
+		kfree(ctx);
+	}
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -1623,6 +1645,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 	if (test_and_clear_bit(BNXT_RE_FLAG_QOS_WORK_REG, &rdev->flags))
 		cancel_delayed_work_sync(&rdev->worker);
 
+	bnxt_re_free_gid_ctx(rdev);
 	if (test_and_clear_bit(BNXT_RE_FLAG_RESOURCES_INITIALIZED,
 			       &rdev->flags))
 		bnxt_re_cleanup_res(rdev);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 7436ce551579..0f50c1ffbe01 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -704,9 +704,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	srq->dbinfo.db = srq->dpi->dbr;
 	srq->dbinfo.max_slot = 1;
 	srq->dbinfo.priv_db = res->dpi_tbl.priv_db;
-	if (srq->threshold)
-		bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
-	srq->arm_req = false;
+	bnxt_qplib_armen_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ_ARMENA);
 
 	return 0;
 fail:
@@ -716,24 +714,6 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 	return rc;
 }
 
-int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
-			  struct bnxt_qplib_srq *srq)
-{
-	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
-	u32 count;
-
-	count = __bnxt_qplib_get_avail(srq_hwq);
-	if (count > srq->threshold) {
-		srq->arm_req = false;
-		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
-	} else {
-		/* Deferred arming */
-		srq->arm_req = true;
-	}
-
-	return 0;
-}
-
 int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_srq *srq)
 {
@@ -775,7 +755,6 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 	struct bnxt_qplib_hwq *srq_hwq = &srq->hwq;
 	struct rq_wqe *srqe;
 	struct sq_sge *hw_sge;
-	u32 count = 0;
 	int i, next;
 
 	spin_lock(&srq_hwq->lock);
@@ -807,15 +786,8 @@ int bnxt_qplib_post_srq_recv(struct bnxt_qplib_srq *srq,
 
 	bnxt_qplib_hwq_incr_prod(&srq->dbinfo, srq_hwq, srq->dbinfo.max_slot);
 
-	spin_lock(&srq_hwq->lock);
-	count = __bnxt_qplib_get_avail(srq_hwq);
-	spin_unlock(&srq_hwq->lock);
 	/* Ring DB */
 	bnxt_qplib_ring_prod_db(&srq->dbinfo, DBC_DBC_TYPE_SRQ);
-	if (srq->arm_req == true && count > srq->threshold) {
-		srq->arm_req = false;
-		bnxt_qplib_srq_arm_db(&srq->dbinfo, srq->threshold);
-	}
 
 	return 0;
 }
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.h b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
index 6f02954eb142..fd4f9fada46a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.h
@@ -521,8 +521,6 @@ int bnxt_qplib_enable_nq(struct pci_dev *pdev, struct bnxt_qplib_nq *nq,
 			 srqn_handler_t srq_handler);
 int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
 			  struct bnxt_qplib_srq *srq);
-int bnxt_qplib_modify_srq(struct bnxt_qplib_res *res,
-			  struct bnxt_qplib_srq *srq);
 int bnxt_qplib_query_srq(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_srq *srq);
 void bnxt_qplib_destroy_srq(struct bnxt_qplib_res *res,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 02922a0987ad..b785d9e7774c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -121,6 +121,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 	pbl->pg_arr = vmalloc_array(pages, sizeof(void *));
 	if (!pbl->pg_arr)
 		return -ENOMEM;
+	memset(pbl->pg_arr, 0, pages * sizeof(void *));
 
 	pbl->pg_map_arr = vmalloc_array(pages, sizeof(dma_addr_t));
 	if (!pbl->pg_map_arr) {
@@ -128,6 +129,7 @@ static int __alloc_pbl(struct bnxt_qplib_res *res,
 		pbl->pg_arr = NULL;
 		return -ENOMEM;
 	}
+	memset(pbl->pg_map_arr, 0, pages * sizeof(dma_addr_t));
 	pbl->pg_count = 0;
 	pbl->pg_size = sginfo->pgsize;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index e56ba86d460e..a50fb03c9643 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -991,7 +991,9 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		if (ret)
 			goto err_out_cmd;
 	} else {
-		init_kernel_qp(dev, qp, attrs);
+		ret = init_kernel_qp(dev, qp, attrs);
+		if (ret)
+			goto err_out_xa;
 	}
 
 	qp->attrs.max_send_sge = attrs->cap.max_send_sge;
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 53fe0ef3883d..6a6daca9f606 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -3028,7 +3028,7 @@ static void hns_roce_v2_exit(struct hns_roce_dev *hr_dev)
 	if (!hr_dev->is_vf)
 		hns_roce_free_link_table(hr_dev);
 
-	if (hr_dev->pci_dev->revision == PCI_REVISION_ID_HIP09)
+	if (hr_dev->pci_dev->revision >= PCI_REVISION_ID_HIP09)
 		free_dip_entry(hr_dev);
 }
 
@@ -5498,7 +5498,7 @@ static int hns_roce_v2_query_srqc(struct hns_roce_dev *hr_dev, u32 srqn,
 	return ret;
 }
 
-static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 qpn,
+static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 sccn,
 				  void *buffer)
 {
 	struct hns_roce_v2_scc_context *context;
@@ -5510,7 +5510,7 @@ static int hns_roce_v2_query_sccc(struct hns_roce_dev *hr_dev, u32 qpn,
 		return PTR_ERR(mailbox);
 
 	ret = hns_roce_cmd_mbox(hr_dev, 0, mailbox->dma, HNS_ROCE_CMD_QUERY_SCCC,
-				qpn);
+				sccn);
 	if (ret)
 		goto out;
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_restrack.c b/drivers/infiniband/hw/hns/hns_roce_restrack.c
index f637b73b946e..230187dda6a0 100644
--- a/drivers/infiniband/hw/hns/hns_roce_restrack.c
+++ b/drivers/infiniband/hw/hns/hns_roce_restrack.c
@@ -100,6 +100,7 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 		struct hns_roce_v2_qp_context qpc;
 		struct hns_roce_v2_scc_context sccc;
 	} context = {};
+	u32 sccn = hr_qp->qpn;
 	int ret;
 
 	if (!hr_dev->hw->query_qpc)
@@ -116,7 +117,13 @@ int hns_roce_fill_res_qp_entry_raw(struct sk_buff *msg, struct ib_qp *ib_qp)
 	    !hr_dev->hw->query_sccc)
 		goto out;
 
-	ret = hr_dev->hw->query_sccc(hr_dev, hr_qp->qpn, &context.sccc);
+	if (hr_qp->cong_type == CONG_TYPE_DIP) {
+		if (!hr_qp->dip)
+			goto out;
+		sccn = hr_qp->dip->dip_idx;
+	}
+
+	ret = hr_dev->hw->query_sccc(hr_dev, sccn, &context.sccc);
 	if (ret)
 		ibdev_warn_ratelimited(&hr_dev->ib_dev,
 				       "failed to query SCCC, ret = %d.\n",
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 8cc64ceeb356..726b67e63301 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -345,33 +345,15 @@ int rxe_prepare(struct rxe_av *av, struct rxe_pkt_info *pkt,
 
 static void rxe_skb_tx_dtor(struct sk_buff *skb)
 {
-	struct net_device *ndev = skb->dev;
-	struct rxe_dev *rxe;
-	unsigned int qp_index;
-	struct rxe_qp *qp;
+	struct rxe_qp *qp = skb->sk->sk_user_data;
 	int skb_out;
 
-	rxe = rxe_get_dev_from_net(ndev);
-	if (!rxe && is_vlan_dev(ndev))
-		rxe = rxe_get_dev_from_net(vlan_dev_real_dev(ndev));
-	if (WARN_ON(!rxe))
-		return;
-
-	qp_index = (int)(uintptr_t)skb->sk->sk_user_data;
-	if (!qp_index)
-		return;
-
-	qp = rxe_pool_get_index(&rxe->qp_pool, qp_index);
-	if (!qp)
-		goto put_dev;
-
 	skb_out = atomic_dec_return(&qp->skb_out);
-	if (qp->need_req_skb && skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW)
+	if (unlikely(qp->need_req_skb &&
+		skb_out < RXE_INFLIGHT_SKBS_PER_QP_LOW))
 		rxe_sched_task(&qp->send_task);
 
 	rxe_put(qp);
-put_dev:
-	ib_device_put(&rxe->ib_dev);
 	sock_put(skb->sk);
 }
 
@@ -383,6 +365,7 @@ static int rxe_send(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	sock_hold(sk);
 	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
+	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -405,6 +388,7 @@ static int rxe_loopback(struct sk_buff *skb, struct rxe_pkt_info *pkt)
 	sock_hold(sk);
 	skb->sk = sk;
 	skb->destructor = rxe_skb_tx_dtor;
+	rxe_get(pkt->qp);
 	atomic_inc(&pkt->qp->skb_out);
 
 	if (skb->protocol == htons(ETH_P_IP))
@@ -497,6 +481,9 @@ struct sk_buff *rxe_init_packet(struct rxe_dev *rxe, struct rxe_av *av,
 		goto out;
 	}
 
+	/* Add time stamp to skb. */
+	skb->tstamp = ktime_get();
+
 	skb_reserve(skb, hdr_len + LL_RESERVED_SPACE(ndev));
 
 	/* FIXME: hold reference to this netdev until life of this skb. */
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 8b805b16136e..88fa62cd9ce5 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -244,7 +244,7 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
 	err = sock_create_kern(&init_net, AF_INET, SOCK_DGRAM, 0, &qp->sk);
 	if (err < 0)
 		return err;
-	qp->sk->sk->sk_user_data = (void *)(uintptr_t)qp->elem.index;
+	qp->sk->sk->sk_user_data = qp;
 
 	/* pick a source UDP port number for this QP based on
 	 * the source QPN. this spreads traffic for different QPs
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ff11cd7e5c06..f5b544e0f230 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3598,7 +3598,7 @@ static int __init parse_ivrs_acpihid(char *str)
 {
 	u32 seg = 0, bus, dev, fn;
 	char *hid, *uid, *p, *addr;
-	char acpiid[ACPIID_LEN] = {0};
+	char acpiid[ACPIID_LEN + 1] = { }; /* size with NULL terminator */
 	int i;
 
 	addr = strchr(str, '@');
@@ -3624,7 +3624,7 @@ static int __init parse_ivrs_acpihid(char *str)
 	/* We have the '@', make it the terminator to get just the acpiid */
 	*addr++ = 0;
 
-	if (strlen(str) > ACPIID_LEN + 1)
+	if (strlen(str) > ACPIID_LEN)
 		goto not_found;
 
 	if (sscanf(str, "=%s", acpiid) != 1)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 780e2d9e4ea8..172ce2030197 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2778,9 +2778,9 @@ static void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
 		/* ATS is being switched off, invalidate the entire ATC */
 		arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
 	}
-	master->ats_enabled = state->ats_enabled;
 
 	arm_smmu_remove_master_domain(master, state->old_domain, state->ssid);
+	master->ats_enabled = state->ats_enabled;
 }
 
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 78c975d7cd5f..b0ca9c9effe9 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -253,17 +253,35 @@ MODULE_PARM_DESC(max_read_size, "Maximum size of a read request");
 static unsigned int max_write_size = 0;
 module_param(max_write_size, uint, 0644);
 MODULE_PARM_DESC(max_write_size, "Maximum size of a write request");
-static unsigned get_max_request_size(struct crypt_config *cc, bool wrt)
+
+static unsigned get_max_request_sectors(struct dm_target *ti, struct bio *bio)
 {
+	struct crypt_config *cc = ti->private;
 	unsigned val, sector_align;
-	val = !wrt ? READ_ONCE(max_read_size) : READ_ONCE(max_write_size);
-	if (likely(!val))
-		val = !wrt ? DM_CRYPT_DEFAULT_MAX_READ_SIZE : DM_CRYPT_DEFAULT_MAX_WRITE_SIZE;
-	if (wrt || cc->used_tag_size) {
-		if (unlikely(val > BIO_MAX_VECS << PAGE_SHIFT))
-			val = BIO_MAX_VECS << PAGE_SHIFT;
-	}
-	sector_align = max(bdev_logical_block_size(cc->dev->bdev), (unsigned)cc->sector_size);
+	bool wrt = op_is_write(bio_op(bio));
+
+	if (wrt) {
+		/*
+		 * For zoned devices, splitting write operations creates the
+		 * risk of deadlocking queue freeze operations with zone write
+		 * plugging BIO work when the reminder of a split BIO is
+		 * issued. So always allow the entire BIO to proceed.
+		 */
+		if (ti->emulate_zone_append)
+			return bio_sectors(bio);
+
+		val = min_not_zero(READ_ONCE(max_write_size),
+				   DM_CRYPT_DEFAULT_MAX_WRITE_SIZE);
+	} else {
+		val = min_not_zero(READ_ONCE(max_read_size),
+				   DM_CRYPT_DEFAULT_MAX_READ_SIZE);
+	}
+
+	if (wrt || cc->used_tag_size)
+		val = min(val, BIO_MAX_VECS << PAGE_SHIFT);
+
+	sector_align = max(bdev_logical_block_size(cc->dev->bdev),
+			   (unsigned)cc->sector_size);
 	val = round_down(val, sector_align);
 	if (unlikely(!val))
 		val = sector_align;
@@ -3517,7 +3535,7 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	/*
 	 * Check if bio is too large, split as needed.
 	 */
-	max_sectors = get_max_request_size(cc, bio_data_dir(bio) == WRITE);
+	max_sectors = get_max_request_sectors(ti, bio);
 	if (unlikely(bio_sectors(bio) > max_sectors))
 		dm_accept_partial_bio(bio, max_sectors);
 
@@ -3754,6 +3772,17 @@ static void crypt_io_hints(struct dm_target *ti, struct queue_limits *limits)
 		max_t(unsigned int, limits->physical_block_size, cc->sector_size);
 	limits->io_min = max_t(unsigned int, limits->io_min, cc->sector_size);
 	limits->dma_alignment = limits->logical_block_size - 1;
+
+	/*
+	 * For zoned dm-crypt targets, there will be no internal splitting of
+	 * write BIOs to avoid exceeding BIO_MAX_VECS vectors per BIO. But
+	 * without respecting this limit, crypt_alloc_buffer() will trigger a
+	 * BUG(). Avoid this by forcing DM core to split write BIOs to this
+	 * limit.
+	 */
+	if (ti->emulate_zone_append)
+		limits->max_hw_sectors = min(limits->max_hw_sectors,
+					     BIO_MAX_VECS << PAGE_SECTORS_SHIFT);
 }
 
 static struct target_type crypt_target = {
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c5dcd632404c..a7deeda59a55 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1307,8 +1307,9 @@ static size_t dm_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgoff,
 /*
  * A target may call dm_accept_partial_bio only from the map routine.  It is
  * allowed for all bio types except REQ_PREFLUSH, REQ_OP_ZONE_* zone management
- * operations, REQ_OP_ZONE_APPEND (zone append writes) and any bio serviced by
- * __send_duplicate_bios().
+ * operations, zone append writes (native with REQ_OP_ZONE_APPEND or emulated
+ * with write BIOs flagged with BIO_EMULATES_ZONE_APPEND) and any bio serviced
+ * by __send_duplicate_bios().
  *
  * dm_accept_partial_bio informs the dm that the target only wants to process
  * additional n_sectors sectors of the bio and the rest of the data should be
@@ -1341,11 +1342,19 @@ void dm_accept_partial_bio(struct bio *bio, unsigned int n_sectors)
 	unsigned int bio_sectors = bio_sectors(bio);
 
 	BUG_ON(dm_tio_flagged(tio, DM_TIO_IS_DUPLICATE_BIO));
-	BUG_ON(op_is_zone_mgmt(bio_op(bio)));
-	BUG_ON(bio_op(bio) == REQ_OP_ZONE_APPEND);
 	BUG_ON(bio_sectors > *tio->len_ptr);
 	BUG_ON(n_sectors > bio_sectors);
 
+	if (static_branch_unlikely(&zoned_enabled) &&
+	    unlikely(bdev_is_zoned(bio->bi_bdev))) {
+		enum req_op op = bio_op(bio);
+
+		BUG_ON(op_is_zone_mgmt(op));
+		BUG_ON(op == REQ_OP_WRITE);
+		BUG_ON(op == REQ_OP_WRITE_ZEROES);
+		BUG_ON(op == REQ_OP_ZONE_APPEND);
+	}
+
 	*tio->len_ptr -= bio_sectors - n_sectors;
 	bio->bi_iter.bi_size = n_sectors << SECTOR_SHIFT;
 
diff --git a/drivers/media/cec/usb/rainshadow/rainshadow-cec.c b/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
index ee870ea1a886..6f8d6797c614 100644
--- a/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
+++ b/drivers/media/cec/usb/rainshadow/rainshadow-cec.c
@@ -171,11 +171,12 @@ static irqreturn_t rain_interrupt(struct serio *serio, unsigned char data,
 {
 	struct rain *rain = serio_get_drvdata(serio);
 
+	spin_lock(&rain->buf_lock);
 	if (rain->buf_len == DATA_SIZE) {
+		spin_unlock(&rain->buf_lock);
 		dev_warn_once(rain->dev, "buffer overflow\n");
 		return IRQ_HANDLED;
 	}
-	spin_lock(&rain->buf_lock);
 	rain->buf_len++;
 	rain->buf[rain->buf_wr_idx] = data;
 	rain->buf_wr_idx = (rain->buf_wr_idx + 1) & 0xff;
diff --git a/drivers/media/i2c/hi556.c b/drivers/media/i2c/hi556.c
index 3c84cf07275f..b915ad6e9f4f 100644
--- a/drivers/media/i2c/hi556.c
+++ b/drivers/media/i2c/hi556.c
@@ -756,21 +756,23 @@ static int hi556_test_pattern(struct hi556 *hi556, u32 pattern)
 	int ret;
 	u32 val;
 
-	if (pattern) {
-		ret = hi556_read_reg(hi556, HI556_REG_ISP,
-				     HI556_REG_VALUE_08BIT, &val);
-		if (ret)
-			return ret;
+	ret = hi556_read_reg(hi556, HI556_REG_ISP,
+			     HI556_REG_VALUE_08BIT, &val);
+	if (ret)
+		return ret;
 
-		ret = hi556_write_reg(hi556, HI556_REG_ISP,
-				      HI556_REG_VALUE_08BIT,
-				      val | HI556_REG_ISP_TPG_EN);
-		if (ret)
-			return ret;
-	}
+	val = pattern ? (val | HI556_REG_ISP_TPG_EN) :
+		(val & ~HI556_REG_ISP_TPG_EN);
+
+	ret = hi556_write_reg(hi556, HI556_REG_ISP,
+			      HI556_REG_VALUE_08BIT, val);
+	if (ret)
+		return ret;
+
+	val = pattern ? BIT(pattern - 1) : 0;
 
 	return hi556_write_reg(hi556, HI556_REG_TEST_PATTERN,
-			       HI556_REG_VALUE_08BIT, pattern);
+			       HI556_REG_VALUE_08BIT, val);
 }
 
 static int hi556_set_ctrl(struct v4l2_ctrl *ctrl)
diff --git a/drivers/media/i2c/mt9m114.c b/drivers/media/i2c/mt9m114.c
index 5f0b0ad8f885..c00f9412d08e 100644
--- a/drivers/media/i2c/mt9m114.c
+++ b/drivers/media/i2c/mt9m114.c
@@ -1599,13 +1599,9 @@ static int mt9m114_ifp_get_frame_interval(struct v4l2_subdev *sd,
 	if (interval->which != V4L2_SUBDEV_FORMAT_ACTIVE)
 		return -EINVAL;
 
-	mutex_lock(sensor->ifp.hdl.lock);
-
 	ival->numerator = 1;
 	ival->denominator = sensor->ifp.frame_rate;
 
-	mutex_unlock(sensor->ifp.hdl.lock);
-
 	return 0;
 }
 
@@ -1624,8 +1620,6 @@ static int mt9m114_ifp_set_frame_interval(struct v4l2_subdev *sd,
 	if (interval->which != V4L2_SUBDEV_FORMAT_ACTIVE)
 		return -EINVAL;
 
-	mutex_lock(sensor->ifp.hdl.lock);
-
 	if (ival->numerator != 0 && ival->denominator != 0)
 		sensor->ifp.frame_rate = min_t(unsigned int,
 					       ival->denominator / ival->numerator,
@@ -1639,8 +1633,6 @@ static int mt9m114_ifp_set_frame_interval(struct v4l2_subdev *sd,
 	if (sensor->streaming)
 		ret = mt9m114_set_frame_rate(sensor);
 
-	mutex_unlock(sensor->ifp.hdl.lock);
-
 	return ret;
 }
 
diff --git a/drivers/media/i2c/ov2659.c b/drivers/media/i2c/ov2659.c
index 06b7896c3eaf..586b31ba076b 100644
--- a/drivers/media/i2c/ov2659.c
+++ b/drivers/media/i2c/ov2659.c
@@ -1469,14 +1469,15 @@ static int ov2659_probe(struct i2c_client *client)
 				     V4L2_CID_TEST_PATTERN,
 				     ARRAY_SIZE(ov2659_test_pattern_menu) - 1,
 				     0, 0, ov2659_test_pattern_menu);
-	ov2659->sd.ctrl_handler = &ov2659->ctrls;
 
 	if (ov2659->ctrls.error) {
 		dev_err(&client->dev, "%s: control initialization error %d\n",
 			__func__, ov2659->ctrls.error);
+		v4l2_ctrl_handler_free(&ov2659->ctrls);
 		return  ov2659->ctrls.error;
 	}
 
+	ov2659->sd.ctrl_handler = &ov2659->ctrls;
 	sd = &ov2659->sd;
 	client->flags |= I2C_CLIENT_SCCB;
 
diff --git a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
index 051898ce53f4..08148bfc2b4b 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-isys-csi2.c
@@ -360,9 +360,9 @@ static int ipu6_isys_csi2_enable_streams(struct v4l2_subdev *sd,
 	remote_pad = media_pad_remote_pad_first(&sd->entity.pads[CSI2_PAD_SINK]);
 	remote_sd = media_entity_to_v4l2_subdev(remote_pad->entity);
 
-	sink_streams = v4l2_subdev_state_xlate_streams(state, CSI2_PAD_SRC,
-						       CSI2_PAD_SINK,
-						       &streams_mask);
+	sink_streams =
+		v4l2_subdev_state_xlate_streams(state, pad, CSI2_PAD_SINK,
+						&streams_mask);
 
 	ret = ipu6_isys_csi2_calc_timing(csi2, &timing, CSI2_ACCINV);
 	if (ret)
@@ -390,9 +390,9 @@ static int ipu6_isys_csi2_disable_streams(struct v4l2_subdev *sd,
 	struct media_pad *remote_pad;
 	u64 sink_streams;
 
-	sink_streams = v4l2_subdev_state_xlate_streams(state, CSI2_PAD_SRC,
-						       CSI2_PAD_SINK,
-						       &streams_mask);
+	sink_streams =
+		v4l2_subdev_state_xlate_streams(state, pad, CSI2_PAD_SINK,
+						&streams_mask);
 
 	remote_pad = media_pad_remote_pad_first(&sd->entity.pads[CSI2_PAD_SINK]);
 	remote_sd = media_entity_to_v4l2_subdev(remote_pad->entity);
diff --git a/drivers/media/pci/intel/ivsc/mei_ace.c b/drivers/media/pci/intel/ivsc/mei_ace.c
index 3622271c71c8..50d18b627e15 100644
--- a/drivers/media/pci/intel/ivsc/mei_ace.c
+++ b/drivers/media/pci/intel/ivsc/mei_ace.c
@@ -529,6 +529,8 @@ static void mei_ace_remove(struct mei_cl_device *cldev)
 
 	ace_set_camera_owner(ace, ACE_CAMERA_IVSC);
 
+	mei_cldev_disable(cldev);
+
 	mutex_destroy(&ace->lock);
 }
 
diff --git a/drivers/media/pci/intel/ivsc/mei_csi.c b/drivers/media/pci/intel/ivsc/mei_csi.c
index 2a9c12c975ca..bd3683b5edf6 100644
--- a/drivers/media/pci/intel/ivsc/mei_csi.c
+++ b/drivers/media/pci/intel/ivsc/mei_csi.c
@@ -786,6 +786,8 @@ static void mei_csi_remove(struct mei_cl_device *cldev)
 
 	pm_runtime_disable(&cldev->dev);
 
+	mei_cldev_disable(cldev);
+
 	mutex_destroy(&csi->lock);
 }
 
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 8c3bce738f2a..d00475d1bc57 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -2275,7 +2275,7 @@ static int camss_probe(struct platform_device *pdev)
 	ret = v4l2_device_register(camss->dev, &camss->v4l2_dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to register V4L2 device: %d\n", ret);
-		goto err_genpd_cleanup;
+		goto err_media_device_cleanup;
 	}
 
 	v4l2_async_nf_init(&camss->notifier, &camss->v4l2_dev);
@@ -2330,6 +2330,8 @@ static int camss_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&camss->v4l2_dev);
 	v4l2_async_nf_cleanup(&camss->notifier);
 	pm_runtime_disable(dev);
+err_media_device_cleanup:
+	media_device_cleanup(&camss->media_dev);
 err_genpd_cleanup:
 	camss_genpd_cleanup(camss);
 
diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 4d10e94eefe9..e26bb48f335d 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -340,13 +340,13 @@ static int venus_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&core->work, venus_sys_error_handler);
 	init_waitqueue_head(&core->sys_err_done);
 
-	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-					"venus", core);
+	ret = hfi_create(core, &venus_core_ops);
 	if (ret)
 		goto err_core_put;
 
-	ret = hfi_create(core, &venus_core_ops);
+	ret = devm_request_threaded_irq(dev, core->irq, hfi_isr, venus_isr_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"venus", core);
 	if (ret)
 		goto err_core_put;
 
@@ -593,11 +593,11 @@ static const struct venus_resources msm8996_res = {
 };
 
 static const struct freq_tbl msm8998_freq_table[] = {
-	{ 1944000, 465000000 },	/* 4k UHD @ 60 (decode only) */
-	{  972000, 465000000 },	/* 4k UHD @ 30 */
-	{  489600, 360000000 },	/* 1080p @ 60 */
-	{  244800, 186000000 },	/* 1080p @ 30 */
-	{  108000, 100000000 },	/* 720p @ 30 */
+	{ 1728000, 533000000 },	/* 4k UHD @ 60 (decode only) */
+	{ 1036800, 444000000 },	/* 2k @ 120 */
+	{  829440, 355200000 },	/* 4k @ 44 */
+	{  489600, 269330000 },/* 4k @ 30 */
+	{  108000, 200000000 },	/* 1080p @ 60 */
 };
 
 static const struct reg_val msm8998_reg_preset[] = {
diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 55202b89e1b9..4a6ff5704c8d 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -27,6 +27,8 @@
 #define VIDC_VCODEC_CLKS_NUM_MAX	2
 #define VIDC_RESETS_NUM_MAX		2
 
+#define VENUS_MAX_FPS			240
+
 extern int venus_fw_debug;
 
 struct freq_tbl {
diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
index ab93757fff4b..8e2115279601 100644
--- a/drivers/media/platform/qcom/venus/hfi_venus.c
+++ b/drivers/media/platform/qcom/venus/hfi_venus.c
@@ -239,6 +239,7 @@ static int venus_write_queue(struct venus_hfi_device *hdev,
 static int venus_read_queue(struct venus_hfi_device *hdev,
 			    struct iface_queue *queue, void *pkt, u32 *tx_req)
 {
+	struct hfi_pkt_hdr *pkt_hdr = NULL;
 	struct hfi_queue_header *qhdr;
 	u32 dwords, new_rd_idx;
 	u32 rd_idx, wr_idx, type, qsize;
@@ -304,6 +305,9 @@ static int venus_read_queue(struct venus_hfi_device *hdev,
 			memcpy(pkt, rd_ptr, len);
 			memcpy(pkt + len, queue->qmem.kva, new_rd_idx << 2);
 		}
+		pkt_hdr = (struct hfi_pkt_hdr *)(pkt);
+		if ((pkt_hdr->size >> 2) != dwords)
+			return -EINVAL;
 	} else {
 		/* bad packet received, dropping */
 		new_rd_idx = qhdr->write_idx;
@@ -1689,6 +1693,7 @@ void venus_hfi_destroy(struct venus_core *core)
 	venus_interface_queues_release(hdev);
 	mutex_destroy(&hdev->lock);
 	kfree(hdev);
+	disable_irq(core->irq);
 	core->ops = NULL;
 }
 
diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index d12089370d91..6846973a1159 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -481,11 +481,10 @@ static int vdec_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
-		return -EINVAL;
-
+	us_per_frame = clamp(us_per_frame, 1, USEC_PER_SEC);
 	fps = (u64)USEC_PER_SEC;
 	do_div(fps, us_per_frame);
+	fps = min(VENUS_MAX_FPS, fps);
 
 	inst->fps = fps;
 	inst->timeperframe = *timeperframe;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 3ec2fb8d9fab..cf5af5ea11e5 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -411,11 +411,10 @@ static int venc_s_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	us_per_frame = timeperframe->numerator * (u64)USEC_PER_SEC;
 	do_div(us_per_frame, timeperframe->denominator);
 
-	if (!us_per_frame)
-		return -EINVAL;
-
+	us_per_frame = clamp(us_per_frame, 1, USEC_PER_SEC);
 	fps = (u64)USEC_PER_SEC;
 	do_div(fps, us_per_frame);
+	fps = min(VENUS_MAX_FPS, fps);
 
 	inst->timeperframe = *timeperframe;
 	inst->fps = fps;
diff --git a/drivers/media/platform/raspberrypi/pisp_be/Kconfig b/drivers/media/platform/raspberrypi/pisp_be/Kconfig
index 46765a2e4c4d..a9e51fd94aad 100644
--- a/drivers/media/platform/raspberrypi/pisp_be/Kconfig
+++ b/drivers/media/platform/raspberrypi/pisp_be/Kconfig
@@ -3,6 +3,7 @@ config VIDEO_RASPBERRYPI_PISP_BE
 	depends on V4L_PLATFORM_DRIVERS
 	depends on VIDEO_DEV
 	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on PM
 	select VIDEO_V4L2_SUBDEV_API
 	select MEDIA_CONTROLLER
 	select VIDEOBUF2_DMA_CONTIG
diff --git a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c b/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
index 65ff2382cffe..49594e539c4f 100644
--- a/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
+++ b/drivers/media/platform/raspberrypi/pisp_be/pisp_be.c
@@ -1726,7 +1726,7 @@ static int pispbe_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(pispbe->dev);
 	pm_runtime_enable(pispbe->dev);
 
-	ret = pispbe_runtime_resume(pispbe->dev);
+	ret = pm_runtime_resume_and_get(pispbe->dev);
 	if (ret)
 		goto pm_runtime_disable_err;
 
@@ -1748,7 +1748,7 @@ static int pispbe_probe(struct platform_device *pdev)
 disable_devs_err:
 	pispbe_destroy_devices(pispbe);
 pm_runtime_suspend_err:
-	pispbe_runtime_suspend(pispbe->dev);
+	pm_runtime_put(pispbe->dev);
 pm_runtime_disable_err:
 	pm_runtime_dont_use_autosuspend(pispbe->dev);
 	pm_runtime_disable(pispbe->dev);
@@ -1762,7 +1762,6 @@ static void pispbe_remove(struct platform_device *pdev)
 
 	pispbe_destroy_devices(pispbe);
 
-	pispbe_runtime_suspend(pispbe->dev);
 	pm_runtime_dont_use_autosuspend(pispbe->dev);
 	pm_runtime_disable(pispbe->dev);
 }
diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
index 964122e7c355..842040f713c1 100644
--- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
+++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
@@ -17,7 +17,6 @@
 
 #define RK3066_ACLK_MAX_FREQ (300 * 1000 * 1000)
 #define RK3288_ACLK_MAX_FREQ (400 * 1000 * 1000)
-#define RK3588_ACLK_MAX_FREQ (300 * 1000 * 1000)
 
 #define ROCKCHIP_VPU981_MIN_SIZE 64
 
@@ -440,13 +439,6 @@ static int rk3066_vpu_hw_init(struct hantro_dev *vpu)
 	return 0;
 }
 
-static int rk3588_vpu981_hw_init(struct hantro_dev *vpu)
-{
-	/* Bump ACLKs to max. possible freq. to improve performance. */
-	clk_set_rate(vpu->clocks[0].clk, RK3588_ACLK_MAX_FREQ);
-	return 0;
-}
-
 static int rockchip_vpu_hw_init(struct hantro_dev *vpu)
 {
 	/* Bump ACLK to max. possible freq. to improve performance. */
@@ -807,7 +799,6 @@ const struct hantro_variant rk3588_vpu981_variant = {
 	.codec_ops = rk3588_vpu981_codec_ops,
 	.irqs = rk3588_vpu981_irqs,
 	.num_irqs = ARRAY_SIZE(rk3588_vpu981_irqs),
-	.init = rk3588_vpu981_hw_init,
 	.clk_names = rk3588_vpu981_vpu_clk_names,
 	.num_clocks = ARRAY_SIZE(rk3588_vpu981_vpu_clk_names)
 };
diff --git a/drivers/media/test-drivers/vivid/vivid-ctrls.c b/drivers/media/test-drivers/vivid/vivid-ctrls.c
index 2b5c8fbcd0a2..3fb4e08ac725 100644
--- a/drivers/media/test-drivers/vivid/vivid-ctrls.c
+++ b/drivers/media/test-drivers/vivid/vivid-ctrls.c
@@ -243,7 +243,8 @@ static const struct v4l2_ctrl_config vivid_ctrl_u8_pixel_array = {
 	.min = 0x00,
 	.max = 0xff,
 	.step = 1,
-	.dims = { 640 / PIXEL_ARRAY_DIV, 360 / PIXEL_ARRAY_DIV },
+	.dims = { DIV_ROUND_UP(360, PIXEL_ARRAY_DIV),
+		  DIV_ROUND_UP(640, PIXEL_ARRAY_DIV) },
 };
 
 static const struct v4l2_ctrl_config vivid_ctrl_s32_array = {
diff --git a/drivers/media/test-drivers/vivid/vivid-vid-cap.c b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
index 0d5919e00075..cc84d2671d84 100644
--- a/drivers/media/test-drivers/vivid/vivid-vid-cap.c
+++ b/drivers/media/test-drivers/vivid/vivid-vid-cap.c
@@ -453,8 +453,8 @@ void vivid_update_format_cap(struct vivid_dev *dev, bool keep_controls)
 	if (keep_controls)
 		return;
 
-	dims[0] = roundup(dev->src_rect.width, PIXEL_ARRAY_DIV);
-	dims[1] = roundup(dev->src_rect.height, PIXEL_ARRAY_DIV);
+	dims[0] = DIV_ROUND_UP(dev->src_rect.height, PIXEL_ARRAY_DIV);
+	dims[1] = DIV_ROUND_UP(dev->src_rect.width, PIXEL_ARRAY_DIV);
 	v4l2_ctrl_modify_dimensions(dev->pixel_array, dims);
 }
 
diff --git a/drivers/media/usb/gspca/vicam.c b/drivers/media/usb/gspca/vicam.c
index d98343fd33fe..91e177aa8136 100644
--- a/drivers/media/usb/gspca/vicam.c
+++ b/drivers/media/usb/gspca/vicam.c
@@ -227,6 +227,7 @@ static int sd_init(struct gspca_dev *gspca_dev)
 	const struct ihex_binrec *rec;
 	const struct firmware *fw;
 	u8 *firmware_buf;
+	int len;
 
 	ret = request_ihex_firmware(&fw, VICAM_FIRMWARE,
 				    &gspca_dev->dev->dev);
@@ -241,9 +242,14 @@ static int sd_init(struct gspca_dev *gspca_dev)
 		goto exit;
 	}
 	for (rec = (void *)fw->data; rec; rec = ihex_next_binrec(rec)) {
-		memcpy(firmware_buf, rec->data, be16_to_cpu(rec->len));
+		len = be16_to_cpu(rec->len);
+		if (len > PAGE_SIZE) {
+			ret = -EINVAL;
+			break;
+		}
+		memcpy(firmware_buf, rec->data, len);
 		ret = vicam_control_msg(gspca_dev, 0xff, 0, 0, firmware_buf,
-					be16_to_cpu(rec->len));
+					len);
 		if (ret < 0)
 			break;
 	}
diff --git a/drivers/media/usb/usbtv/usbtv-video.c b/drivers/media/usb/usbtv/usbtv-video.c
index 702f1c8bd2ab..9dc882c1a780 100644
--- a/drivers/media/usb/usbtv/usbtv-video.c
+++ b/drivers/media/usb/usbtv/usbtv-video.c
@@ -73,6 +73,10 @@ static int usbtv_configure_for_norm(struct usbtv *usbtv, v4l2_std_id norm)
 	}
 
 	if (params) {
+		if (vb2_is_busy(&usbtv->vb2q) &&
+		    (usbtv->width != params->cap_width ||
+		     usbtv->height != params->cap_height))
+			return -EBUSY;
 		usbtv->width = params->cap_width;
 		usbtv->height = params->cap_height;
 		usbtv->n_chunks = usbtv->width * usbtv->height
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index 675642af8601..4cc32685124c 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -1582,7 +1582,6 @@ void v4l2_ctrl_handler_free(struct v4l2_ctrl_handler *hdl)
 	kvfree(hdl->buckets);
 	hdl->buckets = NULL;
 	hdl->cached = NULL;
-	hdl->error = 0;
 	mutex_unlock(hdl->lock);
 	mutex_destroy(&hdl->_lock);
 }
diff --git a/drivers/memstick/core/memstick.c b/drivers/memstick/core/memstick.c
index e6801ad14318..2fcc40aa9634 100644
--- a/drivers/memstick/core/memstick.c
+++ b/drivers/memstick/core/memstick.c
@@ -547,7 +547,6 @@ EXPORT_SYMBOL(memstick_add_host);
  */
 void memstick_remove_host(struct memstick_host *host)
 {
-	host->removing = 1;
 	flush_workqueue(workqueue);
 	mutex_lock(&host->lock);
 	if (host->card)
diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index d99f8922d4ad..3f983d599d23 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -812,6 +812,7 @@ static void rtsx_usb_ms_drv_remove(struct platform_device *pdev)
 	int err;
 
 	host->eject = true;
+	msh->removing = true;
 	cancel_work_sync(&host->handle_req);
 	cancel_delayed_work_sync(&host->poll_card);
 
diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 68ce4920e01e..8477b9dd80b7 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -215,6 +215,20 @@
 #define GLI_MAX_TUNING_LOOP 40
 
 /* Genesys Logic chipset */
+static void sdhci_gli_mask_replay_timer_timeout(struct pci_dev *pdev)
+{
+	int aer;
+	u32 value;
+
+	/* mask the replay timer timeout of AER */
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (aer) {
+		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
+		value |= PCI_ERR_COR_REP_TIMER;
+		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
+	}
+}
+
 static inline void gl9750_wt_on(struct sdhci_host *host)
 {
 	u32 wt_value;
@@ -535,7 +549,6 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 {
 	struct sdhci_pci_slot *slot = sdhci_priv(host);
 	struct pci_dev *pdev;
-	int aer;
 	u32 value;
 
 	pdev = slot->chip->pdev;
@@ -554,12 +567,7 @@ static void gl9750_hw_setting(struct sdhci_host *host)
 	pci_set_power_state(pdev, PCI_D0);
 
 	/* mask the replay timer timeout of AER */
-	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (aer) {
-		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
-		value |= PCI_ERR_COR_REP_TIMER;
-		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
-	}
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9750_wt_off(host);
 }
@@ -734,7 +742,6 @@ static void sdhci_gl9755_set_clock(struct sdhci_host *host, unsigned int clock)
 static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
-	int aer;
 	u32 value;
 
 	gl9755_wt_on(pdev);
@@ -769,12 +776,7 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
 	pci_set_power_state(pdev, PCI_D0);
 
 	/* mask the replay timer timeout of AER */
-	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
-	if (aer) {
-		pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &value);
-		value |= PCI_ERR_COR_REP_TIMER;
-		pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, value);
-	}
+	sdhci_gli_mask_replay_timer_timeout(pdev);
 
 	gl9755_wt_off(pdev);
 }
@@ -1333,7 +1335,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *slot)
 	return ret;
 }
 
-static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
+static void gl9763e_hw_setting(struct sdhci_pci_slot *slot)
 {
 	struct pci_dev *pdev = slot->chip->pdev;
 	u32 value;
@@ -1362,6 +1364,9 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 	value |= FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDLY_5);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
 
+	/* mask the replay timer timeout of AER */
+	sdhci_gli_mask_replay_timer_timeout(pdev);
+
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
 	value &= ~GLI_9763E_VHS_REV;
 	value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
@@ -1505,7 +1510,7 @@ static int gli_probe_slot_gl9763e(struct sdhci_pci_slot *slot)
 	gli_pcie_enable_msi(slot);
 	host->mmc_host_ops.hs400_enhanced_strobe =
 					gl9763e_hs400_enhanced_strobe;
-	gli_set_gl9763e(slot);
+	gl9763e_hw_setting(slot);
 	sdhci_enable_v4_mode(host);
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8e0eb0acf442..47344e29a4c9 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -155,6 +155,7 @@ struct sdhci_am654_data {
 	u32 tuning_loop;
 
 #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
+#define SDHCI_AM654_QUIRK_DISABLE_HS400 BIT(1)
 };
 
 struct window {
@@ -734,6 +735,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	struct device *dev = mmc_dev(host->mmc);
 	u32 ctl_cfg_2 = 0;
 	u32 mask;
 	u32 val;
@@ -789,6 +791,12 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (ret)
 		goto err_cleanup_host;
 
+	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_DISABLE_HS400 &&
+	    host->mmc->caps2 & (MMC_CAP2_HS400 | MMC_CAP2_HS400_ES)) {
+		dev_info(dev, "HS400 mode not supported on this silicon revision, disabling it\n");
+		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
+	}
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -852,6 +860,12 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct soc_device_attribute sdhci_am654_descope_hs400[] = {
+	{ .family = "AM62PX", .revision = "SR1.0" },
+	{ .family = "AM62PX", .revision = "SR1.1" },
+	{ /* sentinel */ }
+};
+
 static const struct of_device_id sdhci_am654_of_match[] = {
 	{
 		.compatible = "ti,am654-sdhci-5.1",
@@ -943,6 +957,10 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
+	soc = soc_device_match(sdhci_am654_descope_hs400);
+	if (soc)
+		sdhci_am654->quirks |= SDHCI_AM654_QUIRK_DISABLE_HS400;
+
 	host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
 
 	pm_runtime_get_noresume(dev);
diff --git a/drivers/most/core.c b/drivers/most/core.c
index a635d5082ebb..da319d108ea1 100644
--- a/drivers/most/core.c
+++ b/drivers/most/core.c
@@ -538,8 +538,8 @@ static struct most_channel *get_channel(char *mdev, char *mdev_ch)
 	dev = bus_find_device_by_name(&mostbus, NULL, mdev);
 	if (!dev)
 		return NULL;
-	put_device(dev);
 	iface = dev_get_drvdata(dev);
+	put_device(dev);
 	list_for_each_entry_safe(c, tmp, &iface->p->channel_list, list) {
 		if (!strcmp(dev_name(&c->dev), mdev_ch))
 			return c;
diff --git a/drivers/mtd/nand/raw/fsmc_nand.c b/drivers/mtd/nand/raw/fsmc_nand.c
index 811982da3557..fe5912d31bee 100644
--- a/drivers/mtd/nand/raw/fsmc_nand.c
+++ b/drivers/mtd/nand/raw/fsmc_nand.c
@@ -503,6 +503,8 @@ static int dma_xfer(struct fsmc_nand_data *host, void *buffer, int len,
 
 	dma_dev = chan->device;
 	dma_addr = dma_map_single(dma_dev->dev, buffer, len, direction);
+	if (dma_mapping_error(dma_dev->dev, dma_addr))
+		return -EINVAL;
 
 	if (direction == DMA_TO_DEVICE) {
 		dma_src = dma_addr;
diff --git a/drivers/mtd/nand/raw/renesas-nand-controller.c b/drivers/mtd/nand/raw/renesas-nand-controller.c
index 0e92d50c5249..ed45d0add3e9 100644
--- a/drivers/mtd/nand/raw/renesas-nand-controller.c
+++ b/drivers/mtd/nand/raw/renesas-nand-controller.c
@@ -426,6 +426,9 @@ static int rnandc_read_page_hw_ecc(struct nand_chip *chip, u8 *buf,
 	/* Configure DMA */
 	dma_addr = dma_map_single(rnandc->dev, rnandc->buf, mtd->writesize,
 				  DMA_FROM_DEVICE);
+	if (dma_mapping_error(rnandc->dev, dma_addr))
+		return -ENOMEM;
+
 	writel(dma_addr, rnandc->regs + DMA_ADDR_LOW_REG);
 	writel(mtd->writesize, rnandc->regs + DMA_CNT_REG);
 	writel(DMA_TLVL_MAX, rnandc->regs + DMA_TLVL_REG);
@@ -606,6 +609,9 @@ static int rnandc_write_page_hw_ecc(struct nand_chip *chip, const u8 *buf,
 	/* Configure DMA */
 	dma_addr = dma_map_single(rnandc->dev, (void *)rnandc->buf, mtd->writesize,
 				  DMA_TO_DEVICE);
+	if (dma_mapping_error(rnandc->dev, dma_addr))
+		return -ENOMEM;
+
 	writel(dma_addr, rnandc->regs + DMA_ADDR_LOW_REG);
 	writel(mtd->writesize, rnandc->regs + DMA_CNT_REG);
 	writel(DMA_TLVL_MAX, rnandc->regs + DMA_TLVL_REG);
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 241f6a4df16c..c523a1a22c2b 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -659,7 +659,10 @@ static int spinand_write_page(struct spinand_device *spinand,
 			   SPINAND_WRITE_INITIAL_DELAY_US,
 			   SPINAND_WRITE_POLL_DELAY_US,
 			   &status);
-	if (!ret && (status & STATUS_PROG_FAILED))
+	if (ret)
+		return ret;
+
+	if (status & STATUS_PROG_FAILED)
 		return -EIO;
 
 	return nand_ecc_finish_io_req(nand, (struct nand_page_io_req *)req);
diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index e48c3cff247a..fdc411f2a23c 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -55,7 +55,6 @@ static u64 spi_nor_get_min_prot_length_sr(struct spi_nor *nor)
 static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 					u64 *len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
 	u8 tb_mask = spi_nor_get_sr_tb_mask(nor);
@@ -76,13 +75,13 @@ static void spi_nor_get_locked_range_sr(struct spi_nor *nor, u8 sr, loff_t *ofs,
 	min_prot_len = spi_nor_get_min_prot_length_sr(nor);
 	*len = min_prot_len << (bp - 1);
 
-	if (*len > mtd->size)
-		*len = mtd->size;
+	if (*len > nor->params->size)
+		*len = nor->params->size;
 
 	if (nor->flags & SNOR_F_HAS_SR_TB && sr & tb_mask)
 		*ofs = 0;
 	else
-		*ofs = mtd->size - *len;
+		*ofs = nor->params->size - *len;
 }
 
 /*
@@ -157,7 +156,6 @@ static bool spi_nor_is_unlocked_sr(struct spi_nor *nor, loff_t ofs, u64 len,
  */
 static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -182,7 +180,7 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
 		can_be_bottom = false;
 
 	/* If anything above us is unlocked, we can't use 'top' protection */
-	if (!spi_nor_is_locked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_locked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				  status_old))
 		can_be_top = false;
 
@@ -194,11 +192,11 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
 
 	/* lock_len: length of region that should end up locked */
 	if (use_top)
-		lock_len = mtd->size - ofs;
+		lock_len = nor->params->size - ofs;
 	else
 		lock_len = ofs + len;
 
-	if (lock_len == mtd->size) {
+	if (lock_len == nor->params->size) {
 		val = mask;
 	} else {
 		min_prot_len = spi_nor_get_min_prot_length_sr(nor);
@@ -247,7 +245,6 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, u64 len)
  */
 static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
 {
-	struct mtd_info *mtd = &nor->mtd;
 	u64 min_prot_len;
 	int ret, status_old, status_new;
 	u8 mask = spi_nor_get_sr_bp_mask(nor);
@@ -272,7 +269,7 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
 		can_be_top = false;
 
 	/* If anything above us is locked, we can't use 'bottom' protection */
-	if (!spi_nor_is_unlocked_sr(nor, ofs + len, mtd->size - (ofs + len),
+	if (!spi_nor_is_unlocked_sr(nor, ofs + len, nor->params->size - (ofs + len),
 				    status_old))
 		can_be_bottom = false;
 
@@ -284,7 +281,7 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
 
 	/* lock_len: length of region that should remain locked */
 	if (use_top)
-		lock_len = mtd->size - (ofs + len);
+		lock_len = nor->params->size - (ofs + len);
 	else
 		lock_len = ofs;
 
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..4c2560ae8866 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -95,13 +95,13 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker);
 static void ad_mux_machine(struct port *port, bool *update_slave_arr);
 static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port);
 static void ad_tx_machine(struct port *port);
-static void ad_periodic_machine(struct port *port, struct bond_params *bond_params);
+static void ad_periodic_machine(struct port *port);
 static void ad_port_selection_logic(struct port *port, bool *update_slave_arr);
 static void ad_agg_selection_logic(struct aggregator *aggregator,
 				   bool *update_slave_arr);
 static void ad_clear_agg(struct aggregator *aggregator);
 static void ad_initialize_agg(struct aggregator *aggregator);
-static void ad_initialize_port(struct port *port, int lacp_fast);
+static void ad_initialize_port(struct port *port, const struct bond_params *bond_params);
 static void ad_enable_collecting(struct port *port);
 static void ad_disable_distributing(struct port *port,
 				    bool *update_slave_arr);
@@ -1296,10 +1296,16 @@ static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port)
 			 * case of EXPIRED even if LINK_DOWN didn't arrive for
 			 * the port.
 			 */
-			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
 			port->sm_vars &= ~AD_PORT_MATCHED;
+			/* Based on IEEE 8021AX-2014, Figure 6-18 - Receive
+			 * machine state diagram, the statue should be
+			 * Partner_Oper_Port_State.Synchronization = FALSE;
+			 * Partner_Oper_Port_State.LACP_Timeout = Short Timeout;
+			 * start current_while_timer(Short Timeout);
+			 * Actor_Oper_Port_State.Expired = TRUE;
+			 */
+			port->partner_oper.port_state &= ~LACP_STATE_SYNCHRONIZATION;
 			port->partner_oper.port_state |= LACP_STATE_LACP_TIMEOUT;
-			port->partner_oper.port_state |= LACP_STATE_LACP_ACTIVITY;
 			port->sm_rx_timer_counter = __ad_timer_to_ticks(AD_CURRENT_WHILE_TIMER, (u16)(AD_SHORT_TIMEOUT));
 			port->actor_oper_port_state |= LACP_STATE_EXPIRED;
 			port->sm_vars |= AD_PORT_CHURNED;
@@ -1405,11 +1411,10 @@ static void ad_tx_machine(struct port *port)
 /**
  * ad_periodic_machine - handle a port's periodic state machine
  * @port: the port we're looking at
- * @bond_params: bond parameters we will use
  *
  * Turn ntt flag on priodically to perform periodic transmission of lacpdu's.
  */
-static void ad_periodic_machine(struct port *port, struct bond_params *bond_params)
+static void ad_periodic_machine(struct port *port)
 {
 	periodic_states_t last_state;
 
@@ -1418,8 +1423,7 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
 
 	/* check if port was reinitialized */
 	if (((port->sm_vars & AD_PORT_BEGIN) || !(port->sm_vars & AD_PORT_LACP_ENABLED) || !port->is_enabled) ||
-	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
-	    !bond_params->lacp_active) {
+	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY))) {
 		port->sm_periodic_state = AD_NO_PERIODIC;
 	}
 	/* check if state machine should change state */
@@ -1943,16 +1947,16 @@ static void ad_initialize_agg(struct aggregator *aggregator)
 /**
  * ad_initialize_port - initialize a given port's parameters
  * @port: the port we're looking at
- * @lacp_fast: boolean. whether fast periodic should be used
+ * @bond_params: bond parameters we will use
  */
-static void ad_initialize_port(struct port *port, int lacp_fast)
+static void ad_initialize_port(struct port *port, const struct bond_params *bond_params)
 {
 	static const struct port_params tmpl = {
 		.system_priority = 0xffff,
 		.key             = 1,
 		.port_number     = 1,
 		.port_priority   = 0xff,
-		.port_state      = 1,
+		.port_state      = 0,
 	};
 	static const struct lacpdu lacpdu = {
 		.subtype		= 0x01,
@@ -1970,12 +1974,14 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
 		port->actor_port_priority = 0xff;
 		port->actor_port_aggregator_identifier = 0;
 		port->ntt = false;
-		port->actor_admin_port_state = LACP_STATE_AGGREGATION |
-					       LACP_STATE_LACP_ACTIVITY;
-		port->actor_oper_port_state  = LACP_STATE_AGGREGATION |
-					       LACP_STATE_LACP_ACTIVITY;
+		port->actor_admin_port_state = LACP_STATE_AGGREGATION;
+		port->actor_oper_port_state  = LACP_STATE_AGGREGATION;
+		if (bond_params->lacp_active) {
+			port->actor_admin_port_state |= LACP_STATE_LACP_ACTIVITY;
+			port->actor_oper_port_state  |= LACP_STATE_LACP_ACTIVITY;
+		}
 
-		if (lacp_fast)
+		if (bond_params->lacp_fast)
 			port->actor_oper_port_state |= LACP_STATE_LACP_TIMEOUT;
 
 		memcpy(&port->partner_admin, &tmpl, sizeof(tmpl));
@@ -2187,7 +2193,7 @@ void bond_3ad_bind_slave(struct slave *slave)
 		/* port initialization */
 		port = &(SLAVE_AD_INFO(slave)->port);
 
-		ad_initialize_port(port, bond->params.lacp_fast);
+		ad_initialize_port(port, &bond->params);
 
 		port->slave = slave;
 		port->actor_port_number = SLAVE_AD_INFO(slave)->id;
@@ -2499,7 +2505,7 @@ void bond_3ad_state_machine_handler(struct work_struct *work)
 		}
 
 		ad_rx_machine(NULL, port);
-		ad_periodic_machine(port, &bond->params);
+		ad_periodic_machine(port);
 		ad_port_selection_logic(port, &update_slave_arr);
 		ad_mux_machine(port, &update_slave_arr);
 		ad_tx_machine(port);
@@ -2869,6 +2875,31 @@ void bond_3ad_update_lacp_rate(struct bonding *bond)
 	spin_unlock_bh(&bond->mode_lock);
 }
 
+/**
+ * bond_3ad_update_lacp_active - change the lacp active
+ * @bond: bonding struct
+ *
+ * Update actor_oper_port_state when lacp_active is modified.
+ */
+void bond_3ad_update_lacp_active(struct bonding *bond)
+{
+	struct port *port = NULL;
+	struct list_head *iter;
+	struct slave *slave;
+	int lacp_active;
+
+	lacp_active = bond->params.lacp_active;
+	spin_lock_bh(&bond->mode_lock);
+	bond_for_each_slave(bond, slave, iter) {
+		port = &(SLAVE_AD_INFO(slave)->port);
+		if (lacp_active)
+			port->actor_oper_port_state |= LACP_STATE_LACP_ACTIVITY;
+		else
+			port->actor_oper_port_state &= ~LACP_STATE_LACP_ACTIVITY;
+	}
+	spin_unlock_bh(&bond->mode_lock);
+}
+
 size_t bond_3ad_stats_size(void)
 {
 	return nla_total_size_64bit(sizeof(u64)) + /* BOND_3AD_STAT_LACPDU_RX */
diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
index d1b095af253b..e27d913b487b 100644
--- a/drivers/net/bonding/bond_options.c
+++ b/drivers/net/bonding/bond_options.c
@@ -1634,6 +1634,7 @@ static int bond_option_lacp_active_set(struct bonding *bond,
 	netdev_dbg(bond->dev, "Setting LACP active to %s (%llu)\n",
 		   newval->string, newval->value);
 	bond->params.lacp_active = newval->value;
+	bond_3ad_update_lacp_active(bond);
 
 	return 0;
 }
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index e6d6661a908a..644e8b8eb91e 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -383,7 +383,7 @@ static void ti_hecc_start(struct net_device *ndev)
 	 * overflows instead of the hardware silently dropping the
 	 * messages.
 	 */
-	mbx_mask = ~BIT_U32(HECC_RX_LAST_MBOX);
+	mbx_mask = ~BIT(HECC_RX_LAST_MBOX);
 	hecc_write(priv, HECC_CANOPC, mbx_mask);
 
 	/* Enable interrupts */
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index bf26cd0abf6d..0a34fd6887fc 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2208,6 +2208,12 @@ static void ksz_update_port_member(struct ksz_device *dev, int port)
 		dev->dev_ops->cfg_port_member(dev, i, val | cpu_port);
 	}
 
+	/* HSR ports are setup once so need to use the assigned membership
+	 * when the port is enabled.
+	 */
+	if (!port_member && p->stp_state == BR_STATE_FORWARDING &&
+	    (dev->hsr_ports & BIT(port)))
+		port_member = dev->hsr_ports;
 	dev->dev_ops->cfg_port_member(dev, port, port_member | cpu_port);
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8ea3c7493663..497a19ca198d 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2726,6 +2726,8 @@ static void gve_shutdown(struct pci_dev *pdev)
 	struct gve_priv *priv = netdev_priv(netdev);
 	bool was_up = netif_running(priv->dev);
 
+	netif_device_detach(netdev);
+
 	rtnl_lock();
 	if (was_up && gve_close(priv->dev)) {
 		/* If the dev was up, attempt to close, if close fails, reset */
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2a0c5a343e47..aadc0667fa04 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6987,6 +6987,13 @@ static int igc_probe(struct pci_dev *pdev,
 	adapter->port_num = hw->bus.func;
 	adapter->msg_enable = netif_msg_init(debug, DEFAULT_MSG_ENABLE);
 
+	/* PCI config space info */
+	hw->vendor_id = pdev->vendor;
+	hw->device_id = pdev->device;
+	hw->revision_id = pdev->revision;
+	hw->subsystem_vendor_id = pdev->subsystem_vendor;
+	hw->subsystem_device_id = pdev->subsystem_device;
+
 	/* Disable ASPM L1.2 on I226 devices to avoid packet loss */
 	if (igc_is_device_id_i226(hw))
 		pci_disable_link_state(pdev, PCIE_LINK_STATE_L1_2);
@@ -7013,13 +7020,6 @@ static int igc_probe(struct pci_dev *pdev,
 	netdev->mem_start = pci_resource_start(pdev, 0);
 	netdev->mem_end = pci_resource_end(pdev, 0);
 
-	/* PCI config space info */
-	hw->vendor_id = pdev->vendor;
-	hw->device_id = pdev->device;
-	hw->revision_id = pdev->revision;
-	hw->subsystem_vendor_id = pdev->subsystem_vendor;
-	hw->subsystem_device_id = pdev->subsystem_device;
-
 	/* Copy the default MAC and PHY function pointers */
 	memcpy(&hw->mac.ops, ei->mac_ops, sizeof(hw->mac.ops));
 	memcpy(&hw->phy.ops, ei->phy_ops, sizeof(hw->phy.ops));
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
index 3e3b471e53f0..b12c487f36cf 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
@@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 	dma_addr_t dma;
 	u32 cmd_type;
 
-	while (budget-- > 0) {
+	while (likely(budget)) {
 		if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
 			work_done = false;
 			break;
@@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
 		xdp_ring->next_to_use++;
 		if (xdp_ring->next_to_use == xdp_ring->count)
 			xdp_ring->next_to_use = 0;
+
+		budget--;
 	}
 
 	if (tx_desc) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 150635de2bd5..0c484120be79 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -606,8 +606,8 @@ static void npc_set_features(struct rvu *rvu, int blkaddr, u8 intf)
 		if (!npc_check_field(rvu, blkaddr, NPC_LB, intf))
 			*features &= ~BIT_ULL(NPC_OUTER_VID);
 
-	/* Set SPI flag only if AH/ESP and IPSEC_SPI are in the key */
-	if (npc_check_field(rvu, blkaddr, NPC_IPSEC_SPI, intf) &&
+	/* Allow extracting SPI field from AH and ESP headers at same offset */
+	if (npc_is_field_present(rvu, NPC_IPSEC_SPI, intf) &&
 	    (*features & (BIT_ULL(NPC_IPPROTO_ESP) | BIT_ULL(NPC_IPPROTO_AH))))
 		*features |= BIT_ULL(NPC_IPSEC_SPI);
 
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index c855fb799ce1..e9bd32741983 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -101,7 +101,9 @@ mtk_flow_get_wdma_info(struct net_device *dev, const u8 *addr, struct mtk_wdma_i
 	if (!IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED))
 		return -1;
 
+	rcu_read_lock();
 	err = dev_fill_forward_path(dev, addr, &stack);
+	rcu_read_unlock();
 	if (err)
 		return err;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
index b59aee75de94..2c98a5299df3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/dcbnl.h
@@ -26,7 +26,6 @@ struct mlx5e_dcbx {
 	u8                         cap;
 
 	/* Buffer configuration */
-	bool                       manual_buffer;
 	u32                        cable_len;
 	u32                        xoff;
 	u16                        port_buff_cell_sz;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 5ae787656a7c..3efa8bf1d14e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -272,8 +272,8 @@ static int port_update_shared_buffer(struct mlx5_core_dev *mdev,
 	/* Total shared buffer size is split in a ratio of 3:1 between
 	 * lossy and lossless pools respectively.
 	 */
-	lossy_epool_size = (shared_buffer_size / 4) * 3;
 	lossless_ipool_size = shared_buffer_size / 4;
+	lossy_epool_size    = shared_buffer_size - lossless_ipool_size;
 
 	mlx5e_port_set_sbpr(mdev, 0, MLX5_EGRESS_DIR, MLX5_LOSSY_POOL, 0,
 			    lossy_epool_size);
@@ -288,14 +288,12 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 	u16 port_buff_cell_sz = priv->dcbx.port_buff_cell_sz;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int sz = MLX5_ST_SZ_BYTES(pbmc_reg);
-	u32 new_headroom_size = 0;
-	u32 current_headroom_size;
+	u32 current_headroom_cells = 0;
+	u32 new_headroom_cells = 0;
 	void *in;
 	int err;
 	int i;
 
-	current_headroom_size = port_buffer->headroom_size;
-
 	in = kzalloc(sz, GFP_KERNEL);
 	if (!in)
 		return -ENOMEM;
@@ -306,12 +304,14 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 
 	for (i = 0; i < MLX5E_MAX_NETWORK_BUFFER; i++) {
 		void *buffer = MLX5_ADDR_OF(pbmc_reg, in, buffer[i]);
+		current_headroom_cells += MLX5_GET(bufferx_reg, buffer, size);
+
 		u64 size = port_buffer->buffer[i].size;
 		u64 xoff = port_buffer->buffer[i].xoff;
 		u64 xon = port_buffer->buffer[i].xon;
 
-		new_headroom_size += size;
 		do_div(size, port_buff_cell_sz);
+		new_headroom_cells += size;
 		do_div(xoff, port_buff_cell_sz);
 		do_div(xon, port_buff_cell_sz);
 		MLX5_SET(bufferx_reg, buffer, size, size);
@@ -320,10 +320,8 @@ static int port_set_buffer(struct mlx5e_priv *priv,
 		MLX5_SET(bufferx_reg, buffer, xon_threshold, xon);
 	}
 
-	new_headroom_size /= port_buff_cell_sz;
-	current_headroom_size /= port_buff_cell_sz;
-	err = port_update_shared_buffer(priv->mdev, current_headroom_size,
-					new_headroom_size);
+	err = port_update_shared_buffer(priv->mdev, current_headroom_cells,
+					new_headroom_cells);
 	if (err)
 		goto out;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 8705cffc747f..b08328fe1aa3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -362,6 +362,7 @@ static int mlx5e_dcbnl_ieee_getpfc(struct net_device *dev,
 static int mlx5e_dcbnl_ieee_setpfc(struct net_device *dev,
 				   struct ieee_pfc *pfc)
 {
+	u8 buffer_ownership = MLX5_BUF_OWNERSHIP_UNKNOWN;
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u32 old_cable_len = priv->dcbx.cable_len;
@@ -389,7 +390,14 @@ static int mlx5e_dcbnl_ieee_setpfc(struct net_device *dev,
 
 	if (MLX5_BUFFER_SUPPORTED(mdev)) {
 		pfc_new.pfc_en = (changed & MLX5E_PORT_BUFFER_PFC) ? pfc->pfc_en : curr_pfc_en;
-		if (priv->dcbx.manual_buffer)
+		ret = mlx5_query_port_buffer_ownership(mdev,
+						       &buffer_ownership);
+		if (ret)
+			netdev_err(dev,
+				   "%s, Failed to get buffer ownership: %d\n",
+				   __func__, ret);
+
+		if (buffer_ownership == MLX5_BUF_OWNERSHIP_SW_OWNED)
 			ret = mlx5e_port_manual_buffer_config(priv, changed,
 							      dev->mtu, &pfc_new,
 							      NULL, NULL);
@@ -982,7 +990,6 @@ static int mlx5e_dcbnl_setbuffer(struct net_device *dev,
 	if (!changed)
 		return 0;
 
-	priv->dcbx.manual_buffer = true;
 	err = mlx5e_port_manual_buffer_config(priv, changed, dev->mtu, NULL,
 					      buffer_size, prio2buffer);
 	return err;
@@ -1250,7 +1257,6 @@ void mlx5e_dcbnl_initialize(struct mlx5e_priv *priv)
 		priv->dcbx.cap |= DCB_CAP_DCBX_HOST;
 
 	priv->dcbx.port_buff_cell_sz = mlx5e_query_port_buffers_cell_size(priv);
-	priv->dcbx.manual_buffer = false;
 	priv->dcbx.cable_len = MLX5E_DEFAULT_CABLE_LEN;
 
 	mlx5e_ets_init(priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index f8869c9b6802..b0c97648ffc7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -47,10 +47,12 @@ static void mlx5_esw_offloads_pf_vf_devlink_port_attrs_set(struct mlx5_eswitch *
 		devlink_port_attrs_pci_vf_set(dl_port, controller_num, pfnum,
 					      vport_num - 1, external);
 	}  else if (mlx5_core_is_ec_vf_vport(esw->dev, vport_num)) {
+		u16 base_vport = mlx5_core_ec_vf_vport_base(dev);
+
 		memcpy(dl_port->attrs.switch_id.id, ppid.id, ppid.id_len);
 		dl_port->attrs.switch_id.id_len = ppid.id_len;
 		devlink_port_attrs_pci_vf_set(dl_port, 0, pfnum,
-					      vport_num - 1, false);
+					      vport_num - base_vport, false);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 62c770b0eaa8..dc6965f6746e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -114,6 +114,21 @@ struct mlx5_cmd_alias_obj_create_attr {
 	u8 access_key[ACCESS_KEY_LEN];
 };
 
+struct mlx5_port_eth_proto {
+	u32 cap;
+	u32 admin;
+	u32 oper;
+};
+
+struct mlx5_module_eeprom_query_params {
+	u16 size;
+	u16 offset;
+	u16 i2c_address;
+	u32 page;
+	u32 bank;
+	u32 module_number;
+};
+
 static inline void mlx5_printk(struct mlx5_core_dev *dev, int level, const char *format, ...)
 {
 	struct device *device = dev->device;
@@ -278,6 +293,78 @@ int mlx5_set_mtppse(struct mlx5_core_dev *mdev, u8 pin, u8 arm, u8 mode);
 struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev);
 void mlx5_dm_cleanup(struct mlx5_core_dev *dev);
 
+void mlx5_toggle_port_link(struct mlx5_core_dev *dev);
+int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
+			       enum mlx5_port_status status);
+int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
+				 enum mlx5_port_status *status);
+int mlx5_set_port_beacon(struct mlx5_core_dev *dev, u16 beacon_duration);
+
+int mlx5_set_port_mtu(struct mlx5_core_dev *dev, u16 mtu, u8 port);
+int mlx5_set_port_pause(struct mlx5_core_dev *dev, u32 rx_pause, u32 tx_pause);
+int mlx5_query_port_pause(struct mlx5_core_dev *dev,
+			  u32 *rx_pause, u32 *tx_pause);
+
+int mlx5_set_port_pfc(struct mlx5_core_dev *dev, u8 pfc_en_tx, u8 pfc_en_rx);
+int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx,
+			u8 *pfc_en_rx);
+
+int mlx5_set_port_stall_watermark(struct mlx5_core_dev *dev,
+				  u16 stall_critical_watermark,
+				  u16 stall_minor_watermark);
+int mlx5_query_port_stall_watermark(struct mlx5_core_dev *dev,
+				    u16 *stall_critical_watermark,
+				    u16 *stall_minor_watermark);
+
+int mlx5_max_tc(struct mlx5_core_dev *mdev);
+int mlx5_set_port_prio_tc(struct mlx5_core_dev *mdev, u8 *prio_tc);
+int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
+			    u8 prio, u8 *tc);
+int mlx5_set_port_tc_group(struct mlx5_core_dev *mdev, u8 *tc_group);
+int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
+			     u8 tc, u8 *tc_group);
+int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw);
+int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
+				u8 tc, u8 *bw_pct);
+int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
+				    u8 *max_bw_value,
+				    u8 *max_bw_unit);
+int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
+				   u8 *max_bw_value,
+				   u8 *max_bw_unit);
+int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode);
+int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode);
+
+int mlx5_query_ports_check(struct mlx5_core_dev *mdev, u32 *out, int outlen);
+int mlx5_set_ports_check(struct mlx5_core_dev *mdev, u32 *in, int inlen);
+int mlx5_set_port_fcs(struct mlx5_core_dev *mdev, u8 enable);
+void mlx5_query_port_fcs(struct mlx5_core_dev *mdev, bool *supported,
+			 bool *enabled);
+int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
+			     u16 offset, u16 size, u8 *data);
+int
+mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
+				 struct mlx5_module_eeprom_query_params *params,
+				 u8 *data);
+
+int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
+int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
+int mlx5_set_trust_state(struct mlx5_core_dev *mdev, u8 trust_state);
+int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state);
+int mlx5_query_port_buffer_ownership(struct mlx5_core_dev *mdev,
+				     u8 *buffer_ownership);
+int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio);
+int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio);
+
+int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
+			      struct mlx5_port_eth_proto *eproto);
+bool mlx5_ptys_ext_supported(struct mlx5_core_dev *mdev);
+u32 mlx5_port_ptys2speed(struct mlx5_core_dev *mdev, u32 eth_proto_oper,
+			 bool force_legacy);
+u32 mlx5_port_speed2linkmodes(struct mlx5_core_dev *mdev, u32 speed,
+			      bool force_legacy);
+int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);
+
 #define MLX5_PPS_CAP(mdev) (MLX5_CAP_GEN((mdev), pps) &&		\
 			    MLX5_CAP_GEN((mdev), pps_modify) &&		\
 			    MLX5_CAP_MCAM_FEATURE((mdev), mtpps_fs) &&	\
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 50931584132b..389b34d56b75 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -196,7 +196,6 @@ void mlx5_toggle_port_link(struct mlx5_core_dev *dev)
 	if (ps == MLX5_PORT_UP)
 		mlx5_set_port_admin_status(dev, MLX5_PORT_UP);
 }
-EXPORT_SYMBOL_GPL(mlx5_toggle_port_link);
 
 int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
 			       enum mlx5_port_status status)
@@ -210,7 +209,6 @@ int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				    sizeof(out), MLX5_REG_PAOS, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_admin_status);
 
 int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
 				 enum mlx5_port_status *status)
@@ -227,7 +225,6 @@ int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
 	*status = MLX5_GET(paos_reg, out, admin_status);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_admin_status);
 
 static void mlx5_query_port_mtu(struct mlx5_core_dev *dev, u16 *admin_mtu,
 				u16 *max_mtu, u16 *oper_mtu, u8 port)
@@ -257,7 +254,6 @@ int mlx5_set_port_mtu(struct mlx5_core_dev *dev, u16 mtu, u8 port)
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				   sizeof(out), MLX5_REG_PMTU, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_mtu);
 
 void mlx5_query_port_max_mtu(struct mlx5_core_dev *dev, u16 *max_mtu,
 			     u8 port)
@@ -447,7 +443,6 @@ int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
 
 	return mlx5_query_mcia(dev, &query, data);
 }
-EXPORT_SYMBOL_GPL(mlx5_query_module_eeprom);
 
 int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 				     struct mlx5_module_eeprom_query_params *params,
@@ -467,7 +462,6 @@ int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
 
 	return mlx5_query_mcia(dev, params, data);
 }
-EXPORT_SYMBOL_GPL(mlx5_query_module_eeprom_by_page);
 
 static int mlx5_query_port_pvlc(struct mlx5_core_dev *dev, u32 *pvlc,
 				int pvlc_size,  u8 local_port)
@@ -518,7 +512,6 @@ int mlx5_set_port_pause(struct mlx5_core_dev *dev, u32 rx_pause, u32 tx_pause)
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				    sizeof(out), MLX5_REG_PFCC, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_pause);
 
 int mlx5_query_port_pause(struct mlx5_core_dev *dev,
 			  u32 *rx_pause, u32 *tx_pause)
@@ -538,7 +531,6 @@ int mlx5_query_port_pause(struct mlx5_core_dev *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_pause);
 
 int mlx5_set_port_stall_watermark(struct mlx5_core_dev *dev,
 				  u16 stall_critical_watermark,
@@ -597,7 +589,6 @@ int mlx5_set_port_pfc(struct mlx5_core_dev *dev, u8 pfc_en_tx, u8 pfc_en_rx)
 	return mlx5_core_access_reg(dev, in, sizeof(in), out,
 				    sizeof(out), MLX5_REG_PFCC, 0, 1);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_pfc);
 
 int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx, u8 *pfc_en_rx)
 {
@@ -616,7 +607,6 @@ int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx, u8 *pfc_en_rx)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_pfc);
 
 int mlx5_max_tc(struct mlx5_core_dev *mdev)
 {
@@ -667,7 +657,6 @@ int mlx5_set_port_prio_tc(struct mlx5_core_dev *mdev, u8 *prio_tc)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_prio_tc);
 
 int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
 			    u8 prio, u8 *tc)
@@ -689,7 +678,6 @@ int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_prio_tc);
 
 static int mlx5_set_port_qetcr_reg(struct mlx5_core_dev *mdev, u32 *in,
 				   int inlen)
@@ -728,7 +716,6 @@ int mlx5_set_port_tc_group(struct mlx5_core_dev *mdev, u8 *tc_group)
 
 	return mlx5_set_port_qetcr_reg(mdev, in, sizeof(in));
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_tc_group);
 
 int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
 			     u8 tc, u8 *tc_group)
@@ -749,7 +736,6 @@ int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_tc_group);
 
 int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw)
 {
@@ -763,7 +749,6 @@ int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw)
 
 	return mlx5_set_port_qetcr_reg(mdev, in, sizeof(in));
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_tc_bw_alloc);
 
 int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 				u8 tc, u8 *bw_pct)
@@ -784,7 +769,6 @@ int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_tc_bw_alloc);
 
 int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 				    u8 *max_bw_value,
@@ -808,7 +792,6 @@ int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 
 	return mlx5_set_port_qetcr_reg(mdev, in, sizeof(in));
 }
-EXPORT_SYMBOL_GPL(mlx5_modify_port_ets_rate_limit);
 
 int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 				   u8 *max_bw_value,
@@ -834,7 +817,6 @@ int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_ets_rate_limit);
 
 int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode)
 {
@@ -845,7 +827,6 @@ int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode)
 	MLX5_SET(set_wol_rol_in, in, wol_mode, wol_mode);
 	return mlx5_cmd_exec_in(mdev, set_wol_rol, in);
 }
-EXPORT_SYMBOL_GPL(mlx5_set_port_wol);
 
 int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode)
 {
@@ -860,7 +841,6 @@ int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode)
 
 	return err;
 }
-EXPORT_SYMBOL_GPL(mlx5_query_port_wol);
 
 int mlx5_query_ports_check(struct mlx5_core_dev *mdev, u32 *out, int outlen)
 {
@@ -988,6 +968,26 @@ int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state)
 	return err;
 }
 
+int mlx5_query_port_buffer_ownership(struct mlx5_core_dev *mdev,
+				     u8 *buffer_ownership)
+{
+	u32 out[MLX5_ST_SZ_DW(pfcc_reg)] = {};
+	int err;
+
+	if (!MLX5_CAP_PCAM_FEATURE(mdev, buffer_ownership)) {
+		*buffer_ownership = MLX5_BUF_OWNERSHIP_UNKNOWN;
+		return 0;
+	}
+
+	err = mlx5_query_pfcc_reg(mdev, out, sizeof(out));
+	if (err)
+		return err;
+
+	*buffer_ownership = MLX5_GET(pfcc_reg, out, buf_ownership);
+
+	return 0;
+}
+
 int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio)
 {
 	int sz = MLX5_ST_SZ_BYTES(qpdpm_reg);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index 3f5e5d99251b..26401bb57572 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -2507,6 +2507,8 @@ static const struct mlxsw_listener mlxsw_sp_listener[] = {
 			     ROUTER_EXP, false),
 	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_DIP_LINK_LOCAL, FORWARD,
 			     ROUTER_EXP, false),
+	MLXSW_SP_RXL_NO_MARK(DISCARD_ING_ROUTER_SIP_LINK_LOCAL, FORWARD,
+			     ROUTER_EXP, false),
 	/* Multicast Router Traps */
 	MLXSW_SP_RXL_MARK(ACL1, TRAP_TO_CPU, MULTICAST, false),
 	MLXSW_SP_RXL_L3_MARK(ACL2, TRAP_TO_CPU, MULTICAST, false),
diff --git a/drivers/net/ethernet/mellanox/mlxsw/trap.h b/drivers/net/ethernet/mellanox/mlxsw/trap.h
index 83477c8e6971..5bfc1499347a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/trap.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/trap.h
@@ -95,6 +95,7 @@ enum {
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_SIP_BC = 0x16A,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_IPV4_DIP_LOCAL_NET = 0x16B,
 	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_DIP_LINK_LOCAL = 0x16C,
+	MLXSW_TRAP_ID_DISCARD_ING_ROUTER_SIP_LINK_LOCAL = 0x16D,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_IRIF_EN = 0x178,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_ERIF_EN = 0x179,
 	MLXSW_TRAP_ID_DISCARD_ROUTER_LPM4 = 0x17B,
diff --git a/drivers/net/ethernet/microchip/lan865x/lan865x.c b/drivers/net/ethernet/microchip/lan865x/lan865x.c
index dd436bdff0f8..84c41f193561 100644
--- a/drivers/net/ethernet/microchip/lan865x/lan865x.c
+++ b/drivers/net/ethernet/microchip/lan865x/lan865x.c
@@ -32,6 +32,10 @@
 /* MAC Specific Addr 1 Top Reg */
 #define LAN865X_REG_MAC_H_SADDR1	0x00010023
 
+/* MAC TSU Timer Increment Register */
+#define LAN865X_REG_MAC_TSU_TIMER_INCR		0x00010077
+#define MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS	0x0028
+
 struct lan865x_priv {
 	struct work_struct multicast_work;
 	struct net_device *netdev;
@@ -311,6 +315,8 @@ static int lan865x_net_open(struct net_device *netdev)
 
 	phy_start(netdev->phydev);
 
+	netif_start_queue(netdev);
+
 	return 0;
 }
 
@@ -344,6 +350,21 @@ static int lan865x_probe(struct spi_device *spi)
 		goto free_netdev;
 	}
 
+	/* LAN865x Rev.B0/B1 configuration parameters from AN1760
+	 * As per the Configuration Application Note AN1760 published in the
+	 * link, https://www.microchip.com/en-us/application-notes/an1760
+	 * Revision F (DS60001760G - June 2024), configure the MAC to set time
+	 * stamping at the end of the Start of Frame Delimiter (SFD) and set the
+	 * Timer Increment reg to 40 ns to be used as a 25 MHz internal clock.
+	 */
+	ret = oa_tc6_write_register(priv->tc6, LAN865X_REG_MAC_TSU_TIMER_INCR,
+				    MAC_TSU_TIMER_INCR_COUNT_NANOSECONDS);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to config TSU Timer Incr reg: %d\n",
+			ret);
+		goto oa_tc6_exit;
+	}
+
 	/* As per the point s3 in the below errata, SPI receive Ethernet frame
 	 * transfer may halt when starting the next frame in the same data block
 	 * (chunk) as the end of a previous frame. The RFA field should be
diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 4a4434869b10..b3310e342ccf 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -239,7 +239,7 @@ union rtase_rx_desc {
 #define RTASE_RX_RES        BIT(20)
 #define RTASE_RX_RUNT       BIT(19)
 #define RTASE_RX_RWT        BIT(18)
-#define RTASE_RX_CRC        BIT(16)
+#define RTASE_RX_CRC        BIT(17)
 #define RTASE_RX_V6F        BIT(31)
 #define RTASE_RX_V4F        BIT(30)
 #define RTASE_RX_UDPT       BIT(29)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index ddbc4624ae88..055c5765bd86 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -240,6 +240,44 @@ static void prueth_emac_stop(struct prueth *prueth)
 	}
 }
 
+static void icssg_enable_fw_offload(struct prueth *prueth)
+{
+	struct prueth_emac *emac;
+	int mac;
+
+	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
+		emac = prueth->emac[mac];
+		if (prueth->is_hsr_offload_mode) {
+			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
+				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
+			else
+				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
+		}
+
+		if (prueth->is_switch_mode || prueth->is_hsr_offload_mode) {
+			if (netif_running(emac->ndev)) {
+				icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
+						  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
+						  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
+						  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
+						  ICSSG_FDB_ENTRY_BLOCK,
+						  true);
+				icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
+						  BIT(emac->port_id) | DEFAULT_PORT_MASK,
+						  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
+						  true);
+				if (prueth->is_hsr_offload_mode)
+					icssg_vtbl_modify(emac, DEFAULT_VID,
+							  DEFAULT_PORT_MASK,
+							  DEFAULT_UNTAG_MASK, true);
+				icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
+				if (prueth->is_switch_mode)
+					icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
+			}
+		}
+	}
+}
+
 static int prueth_emac_common_start(struct prueth *prueth)
 {
 	struct prueth_emac *emac;
@@ -690,6 +728,7 @@ static int emac_ndo_open(struct net_device *ndev)
 		ret = prueth_emac_common_start(prueth);
 		if (ret)
 			goto free_rx_irq;
+		icssg_enable_fw_offload(prueth);
 	}
 
 	flow_cfg = emac->dram.va + ICSSG_CONFIG_OFFSET + PSI_L_REGULAR_FLOW_ID_BASE_OFFSET;
@@ -1146,8 +1185,7 @@ static int prueth_emac_restart(struct prueth *prueth)
 
 static void icssg_change_mode(struct prueth *prueth)
 {
-	struct prueth_emac *emac;
-	int mac, ret;
+	int ret;
 
 	ret = prueth_emac_restart(prueth);
 	if (ret) {
@@ -1155,35 +1193,7 @@ static void icssg_change_mode(struct prueth *prueth)
 		return;
 	}
 
-	for (mac = PRUETH_MAC0; mac < PRUETH_NUM_MACS; mac++) {
-		emac = prueth->emac[mac];
-		if (prueth->is_hsr_offload_mode) {
-			if (emac->ndev->features & NETIF_F_HW_HSR_TAG_RM)
-				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_ENABLE);
-			else
-				icssg_set_port_state(emac, ICSSG_EMAC_HSR_RX_OFFLOAD_DISABLE);
-		}
-
-		if (netif_running(emac->ndev)) {
-			icssg_fdb_add_del(emac, eth_stp_addr, prueth->default_vlan,
-					  ICSSG_FDB_ENTRY_P0_MEMBERSHIP |
-					  ICSSG_FDB_ENTRY_P1_MEMBERSHIP |
-					  ICSSG_FDB_ENTRY_P2_MEMBERSHIP |
-					  ICSSG_FDB_ENTRY_BLOCK,
-					  true);
-			icssg_vtbl_modify(emac, emac->port_vlan | DEFAULT_VID,
-					  BIT(emac->port_id) | DEFAULT_PORT_MASK,
-					  BIT(emac->port_id) | DEFAULT_UNTAG_MASK,
-					  true);
-			if (prueth->is_hsr_offload_mode)
-				icssg_vtbl_modify(emac, DEFAULT_VID,
-						  DEFAULT_PORT_MASK,
-						  DEFAULT_UNTAG_MASK, true);
-			icssg_set_pvid(prueth, emac->port_vlan, emac->port_id);
-			if (prueth->is_switch_mode)
-				icssg_set_port_state(emac, ICSSG_EMAC_PORT_VLAN_AWARE_ENABLE);
-		}
-	}
+	icssg_enable_fw_offload(prueth);
 }
 
 static int prueth_netdevice_port_link(struct net_device *ndev,
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 2d47b35443af..1775e060d39d 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1119,6 +1119,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	struct axienet_local *lp = data;
 	struct sk_buff *skb;
 	u32 *app_metadata;
+	int i;
 
 	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
 	skb = skbuf_dma->skb;
@@ -1137,7 +1138,10 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_add(&lp->rx_packets, 1);
 	u64_stats_add(&lp->rx_bytes, rx_len);
 	u64_stats_update_end(&lp->rx_stat_sync);
-	axienet_rx_submit_desc(lp->ndev);
+
+	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
+				   RX_BUF_NUM_DEFAULT); i++)
+		axienet_rx_submit_desc(lp->ndev);
 	dma_async_issue_pending(lp->rx_chan);
 }
 
@@ -1394,7 +1398,6 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	if (!skbuf_dma)
 		return;
 
-	lp->rx_ring_head++;
 	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
 	if (!skb)
 		return;
@@ -1419,6 +1422,7 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	skbuf_dma->desc = dma_rx_desc;
 	dma_rx_desc->callback_param = lp;
 	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	lp->rx_ring_head++;
 	dmaengine_submit(dma_rx_desc);
 
 	return;
diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index 6a3d8a754eb8..58c6d47fbe04 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -362,6 +362,13 @@ struct vsc85xx_hw_stat {
 	u16 mask;
 };
 
+struct vsc8531_skb_cb {
+	u32 ns;
+};
+
+#define VSC8531_SKB_CB(skb) \
+	((struct vsc8531_skb_cb *)((skb)->cb))
+
 struct vsc8531_private {
 	int rate_magic;
 	u16 supp_led_modes;
@@ -410,6 +417,11 @@ struct vsc8531_private {
 	 */
 	struct mutex ts_lock;
 	struct mutex phc_lock;
+
+	/* list of skbs that were received and need timestamp information but it
+	 * didn't received it yet
+	 */
+	struct sk_buff_head rx_skbs_list;
 };
 
 /* Shared structure between the PHYs of the same package.
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 6f74ce0ab1aa..42cafa68c400 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2335,6 +2335,13 @@ static int vsc85xx_probe(struct phy_device *phydev)
 	return vsc85xx_dt_led_modes_get(phydev, default_mode);
 }
 
+static void vsc85xx_remove(struct phy_device *phydev)
+{
+	struct vsc8531_private *priv = phydev->priv;
+
+	skb_queue_purge(&priv->rx_skbs_list);
+}
+
 /* Microsemi VSC85xx PHYs */
 static struct phy_driver vsc85xx_driver[] = {
 {
@@ -2589,6 +2596,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2614,6 +2622,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8574_probe,
 	.set_wol	= &vsc85xx_wol_set,
 	.get_wol	= &vsc85xx_wol_get,
@@ -2639,6 +2648,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2662,6 +2672,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
@@ -2685,6 +2696,7 @@ static struct phy_driver vsc85xx_driver[] = {
 	.config_intr    = &vsc85xx_config_intr,
 	.suspend	= &genphy_suspend,
 	.resume		= &genphy_resume,
+	.remove		= &vsc85xx_remove,
 	.probe		= &vsc8584_probe,
 	.get_tunable	= &vsc85xx_get_tunable,
 	.set_tunable	= &vsc85xx_set_tunable,
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index bce6cc5b04ee..80992827a3bd 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1191,9 +1191,7 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 {
 	struct vsc8531_private *vsc8531 =
 		container_of(mii_ts, struct vsc8531_private, mii_ts);
-	struct skb_shared_hwtstamps *shhwtstamps = NULL;
 	struct vsc85xx_ptphdr *ptphdr;
-	struct timespec64 ts;
 	unsigned long ns;
 
 	if (!vsc8531->ptp->configured)
@@ -1203,27 +1201,52 @@ static bool vsc85xx_rxtstamp(struct mii_timestamper *mii_ts,
 	    type == PTP_CLASS_NONE)
 		return false;
 
-	vsc85xx_gettime(&vsc8531->ptp->caps, &ts);
-
 	ptphdr = get_ptp_header_rx(skb, vsc8531->ptp->rx_filter);
 	if (!ptphdr)
 		return false;
 
-	shhwtstamps = skb_hwtstamps(skb);
-	memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
-
 	ns = ntohl(ptphdr->rsrvd2);
 
-	/* nsec is in reserved field */
-	if (ts.tv_nsec < ns)
-		ts.tv_sec--;
+	VSC8531_SKB_CB(skb)->ns = ns;
+	skb_queue_tail(&vsc8531->rx_skbs_list, skb);
 
-	shhwtstamps->hwtstamp = ktime_set(ts.tv_sec, ns);
-	netif_rx(skb);
+	ptp_schedule_worker(vsc8531->ptp->ptp_clock, 0);
 
 	return true;
 }
 
+static long vsc85xx_do_aux_work(struct ptp_clock_info *info)
+{
+	struct vsc85xx_ptp *ptp = container_of(info, struct vsc85xx_ptp, caps);
+	struct skb_shared_hwtstamps *shhwtstamps = NULL;
+	struct phy_device *phydev = ptp->phydev;
+	struct vsc8531_private *priv = phydev->priv;
+	struct sk_buff_head received;
+	struct sk_buff *rx_skb;
+	struct timespec64 ts;
+	unsigned long flags;
+
+	__skb_queue_head_init(&received);
+	spin_lock_irqsave(&priv->rx_skbs_list.lock, flags);
+	skb_queue_splice_tail_init(&priv->rx_skbs_list, &received);
+	spin_unlock_irqrestore(&priv->rx_skbs_list.lock, flags);
+
+	vsc85xx_gettime(info, &ts);
+	while ((rx_skb = __skb_dequeue(&received)) != NULL) {
+		shhwtstamps = skb_hwtstamps(rx_skb);
+		memset(shhwtstamps, 0, sizeof(struct skb_shared_hwtstamps));
+
+		if (ts.tv_nsec < VSC8531_SKB_CB(rx_skb)->ns)
+			ts.tv_sec--;
+
+		shhwtstamps->hwtstamp = ktime_set(ts.tv_sec,
+						  VSC8531_SKB_CB(rx_skb)->ns);
+		netif_rx(rx_skb);
+	}
+
+	return -1;
+}
+
 static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.owner		= THIS_MODULE,
 	.name		= "VSC85xx timer",
@@ -1237,6 +1260,7 @@ static const struct ptp_clock_info vsc85xx_clk_caps = {
 	.adjfine	= &vsc85xx_adjfine,
 	.gettime64	= &vsc85xx_gettime,
 	.settime64	= &vsc85xx_settime,
+	.do_aux_work	= &vsc85xx_do_aux_work,
 };
 
 static struct vsc8531_private *vsc8584_base_priv(struct phy_device *phydev)
@@ -1564,6 +1588,7 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	mutex_init(&vsc8531->phc_lock);
 	mutex_init(&vsc8531->ts_lock);
+	skb_queue_head_init(&vsc8531->rx_skbs_list);
 
 	/* Retrieve the shared load/save GPIO. Request it as non exclusive as
 	 * the same GPIO can be requested by all the PHYs of the same package.
diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 1420c4efa48e..0553b0b356b3 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -33,6 +33,7 @@
 #include <linux/ppp_channel.h>
 #include <linux/ppp-comp.h>
 #include <linux/skbuff.h>
+#include <linux/rculist.h>
 #include <linux/rtnetlink.h>
 #include <linux/if_arp.h>
 #include <linux/ip.h>
@@ -1613,11 +1614,14 @@ static int ppp_fill_forward_path(struct net_device_path_ctx *ctx,
 	if (ppp->flags & SC_MULTILINK)
 		return -EOPNOTSUPP;
 
-	if (list_empty(&ppp->channels))
+	pch = list_first_or_null_rcu(&ppp->channels, struct channel, clist);
+	if (!pch)
+		return -ENODEV;
+
+	chan = READ_ONCE(pch->chan);
+	if (!chan)
 		return -ENODEV;
 
-	pch = list_first_entry(&ppp->channels, struct channel, clist);
-	chan = pch->chan;
 	if (!chan->ops->fill_forward_path)
 		return -EOPNOTSUPP;
 
@@ -3000,7 +3004,7 @@ ppp_unregister_channel(struct ppp_channel *chan)
 	 */
 	down_write(&pch->chan_sem);
 	spin_lock_bh(&pch->downl);
-	pch->chan = NULL;
+	WRITE_ONCE(pch->chan, NULL);
 	spin_unlock_bh(&pch->downl);
 	up_write(&pch->chan_sem);
 	ppp_disconnect_channel(pch);
@@ -3506,7 +3510,7 @@ ppp_connect_channel(struct channel *pch, int unit)
 	hdrlen = pch->file.hdrlen + 2;	/* for protocol bytes */
 	if (hdrlen > ppp->dev->hard_header_len)
 		ppp->dev->hard_header_len = hdrlen;
-	list_add_tail(&pch->clist, &ppp->channels);
+	list_add_tail_rcu(&pch->clist, &ppp->channels);
 	++ppp->n_channels;
 	pch->ppp = ppp;
 	refcount_inc(&ppp->file.refcnt);
@@ -3536,10 +3540,11 @@ ppp_disconnect_channel(struct channel *pch)
 	if (ppp) {
 		/* remove it from the ppp unit's list */
 		ppp_lock(ppp);
-		list_del(&pch->clist);
+		list_del_rcu(&pch->clist);
 		if (--ppp->n_channels == 0)
 			wake_up_interruptible(&ppp->file.rwait);
 		ppp_unlock(ppp);
+		synchronize_net();
 		if (refcount_dec_and_test(&ppp->file.refcnt))
 			ppp_destroy_interface(ppp);
 		err = 0;
diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index d9f5942ccc44..792ddda1ad49 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,7 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
-	priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
+	priv->mdio->phy_mask = ~(BIT(priv->phy_addr & 0x1f) | BIT(AX_EMBD_PHY_ADDR));
 	/* mii bus name is usb-<usb bus number>-<usb device number> */
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);
diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
index 9d8efec46508..39d9aad33bc6 100644
--- a/drivers/net/wireless/ath/ath11k/ce.c
+++ b/drivers/net/wireless/ath/ath11k/ce.c
@@ -393,9 +393,6 @@ static int ath11k_ce_completed_recv_next(struct ath11k_ce_pipe *pipe,
 		goto err;
 	}
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	*nbytes = ath11k_hal_ce_dst_status_get_length(desc);
 
 	*skb = pipe->dest_ring->skb[sw_index];
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 007d86959042..66a00f330734 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2650,9 +2650,6 @@ int ath11k_dp_process_rx(struct ath11k_base *ab, int ring_id,
 try_again:
 	ath11k_hal_srng_access_begin(ab, srng);
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	while (likely(desc =
 	      (struct hal_reo_dest_ring *)ath11k_hal_srng_dst_get_next_entry(ab,
 									     srng))) {
diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
index f38decae77a9..65e52ab742b4 100644
--- a/drivers/net/wireless/ath/ath11k/hal.c
+++ b/drivers/net/wireless/ath/ath11k/hal.c
@@ -823,13 +823,23 @@ u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng)
 
 void ath11k_hal_srng_access_begin(struct ath11k_base *ab, struct hal_srng *srng)
 {
+	u32 hp;
+
 	lockdep_assert_held(&srng->lock);
 
 	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
 	} else {
-		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+
+		if (hp != srng->u.dst_ring.cached_hp) {
+			srng->u.dst_ring.cached_hp = hp;
+			/* Make sure descriptor is read after the head
+			 * pointer.
+			 */
+			dma_rmb();
+		}
 
 		/* Try to prefetch the next descriptor in the ring */
 		if (srng->flags & HAL_SRNG_FLAGS_CACHED)
@@ -844,7 +854,6 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -852,21 +861,37 @@ void ath11k_hal_srng_access_end(struct ath11k_base *ab, struct hal_srng *srng)
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
-			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
+			/* Make sure descriptor is written before updating the
+			 * head pointer.
+			 */
+			dma_wmb();
+			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
-			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			dma_mb();
+			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
 		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
+			/* Assume implementation use an MMIO write accessor
+			 * which has the required wmb() so that the descriptor
+			 * is written before the updating the head pointer.
+			 */
 			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.src_ring.hp_addr -
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			mb();
 			ath11k_hif_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
diff --git a/drivers/net/wireless/ath/ath12k/ce.c b/drivers/net/wireless/ath/ath12k/ce.c
index 740586fe49d1..b66d23d6b2bd 100644
--- a/drivers/net/wireless/ath/ath12k/ce.c
+++ b/drivers/net/wireless/ath/ath12k/ce.c
@@ -343,9 +343,6 @@ static int ath12k_ce_completed_recv_next(struct ath12k_ce_pipe *pipe,
 		goto err;
 	}
 
-	/* Make sure descriptor is read after the head pointer. */
-	dma_rmb();
-
 	*nbytes = ath12k_hal_ce_dst_status_get_length(desc);
 
 	*skb = pipe->dest_ring->skb[sw_index];
diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
index 3afb11c7bf18..cc187f59ff1c 100644
--- a/drivers/net/wireless/ath/ath12k/hal.c
+++ b/drivers/net/wireless/ath/ath12k/hal.c
@@ -2107,13 +2107,24 @@ void *ath12k_hal_srng_src_get_next_reaped(struct ath12k_base *ab,
 
 void ath12k_hal_srng_access_begin(struct ath12k_base *ab, struct hal_srng *srng)
 {
+	u32 hp;
+
 	lockdep_assert_held(&srng->lock);
 
-	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
+	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 		srng->u.src_ring.cached_tp =
 			*(volatile u32 *)srng->u.src_ring.tp_addr;
-	else
-		srng->u.dst_ring.cached_hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+	} else {
+		hp = READ_ONCE(*srng->u.dst_ring.hp_addr);
+
+		if (hp != srng->u.dst_ring.cached_hp) {
+			srng->u.dst_ring.cached_hp = hp;
+			/* Make sure descriptor is read after the head
+			 * pointer.
+			 */
+			dma_rmb();
+		}
+	}
 }
 
 /* Update cached ring head/tail pointers to HW. ath12k_hal_srng_access_begin()
@@ -2123,7 +2134,6 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 {
 	lockdep_assert_held(&srng->lock);
 
-	/* TODO: See if we need a write memory barrier here */
 	if (srng->flags & HAL_SRNG_FLAGS_LMAC_RING) {
 		/* For LMAC rings, ring pointer updates are done through FW and
 		 * hence written to a shared memory location that is read by FW
@@ -2131,21 +2141,37 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
-			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
+			/* Make sure descriptor is written before updating the
+			 * head pointer.
+			 */
+			dma_wmb();
+			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
-			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			dma_mb();
+			WRITE_ONCE(*srng->u.dst_ring.tp_addr, srng->u.dst_ring.tp);
 		}
 	} else {
 		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
 			srng->u.src_ring.last_tp =
 				*(volatile u32 *)srng->u.src_ring.tp_addr;
+			/* Assume implementation use an MMIO write accessor
+			 * which has the required wmb() so that the descriptor
+			 * is written before the updating the head pointer.
+			 */
 			ath12k_hif_write32(ab,
 					   (unsigned long)srng->u.src_ring.hp_addr -
 					   (unsigned long)ab->mem,
 					   srng->u.src_ring.hp);
 		} else {
 			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
+			/* Make sure descriptor is read before updating the
+			 * tail pointer.
+			 */
+			mb();
 			ath12k_hif_write32(ab,
 					   (unsigned long)srng->u.dst_ring.tp_addr -
 					   (unsigned long)ab->mem,
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
index d0faba240561..b4bba67a45ec 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
@@ -919,7 +919,7 @@ void wlc_lcnphy_read_table(struct brcms_phy *pi, struct phytbl_info *pti)
 
 static void
 wlc_lcnphy_common_read_table(struct brcms_phy *pi, u32 tbl_id,
-			     const u16 *tbl_ptr, u32 tbl_len,
+			     u16 *tbl_ptr, u32 tbl_len,
 			     u32 tbl_width, u32 tbl_offset)
 {
 	struct phytbl_info tab;
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 3b24fed3177d..c5254241942d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -72,6 +72,7 @@ enum imx_pcie_variants {
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
+	IMX8Q_EP,
 	IMX95_EP,
 };
 
@@ -778,7 +779,6 @@ static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_assert(imx_pcie->pciephy_reset);
-	reset_control_assert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, true);
@@ -790,7 +790,6 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
 	reset_control_deassert(imx_pcie->pciephy_reset);
-	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
 		imx_pcie->drvdata->core_reset(imx_pcie, false);
@@ -997,6 +996,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 		}
 	}
 
+	/* Make sure that PCIe LTSSM is cleared */
+	imx_pcie_ltssm_disable(dev);
+
 	ret = imx_pcie_deassert_core_reset(imx_pcie);
 	if (ret < 0) {
 		dev_err(dev, "pcie deassert core reset failed: %d\n", ret);
@@ -1097,6 +1099,18 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
+	.align = SZ_64K,
+};
+
+static const struct pci_epc_features imx8q_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.bar[BAR_1] = { .type = BAR_RESERVED, },
+	.bar[BAR_3] = { .type = BAR_RESERVED, },
+	.bar[BAR_5] = { .type = BAR_RESERVED, },
 	.align = SZ_64K,
 };
 
@@ -1188,9 +1202,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 
 	pci_epc_init_notify(ep->epc);
 
-	/* Start LTSSM. */
-	imx_pcie_ltssm_enable(dev);
-
 	return 0;
 }
 
@@ -1665,7 +1676,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-		.epc_features = &imx8m_pcie_epc_features,
+		.epc_features = &imx8q_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
@@ -1695,6 +1706,14 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.epc_features = &imx8m_pcie_epc_features,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
 	},
+	[IMX8Q_EP] = {
+		.variant = IMX8Q_EP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
+		.mode = DW_PCIE_EP_TYPE,
+		.epc_features = &imx8q_pcie_epc_features,
+		.clk_names = imx8q_clks,
+		.clks_cnt = ARRAY_SIZE(imx8q_clks),
+	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
@@ -1724,6 +1743,7 @@ static const struct of_device_id imx_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
+	{ .compatible = "fsl,imx8q-pcie-ep", .data = &drvdata[IMX8Q_EP], },
 	{ .compatible = "fsl,imx95-pcie-ep", .data = &drvdata[IMX95_EP], },
 	{},
 };
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 18e65571c145..ea1df03edc2e 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -11,6 +11,7 @@
  * ARM PCI Host generic driver.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitrev.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -40,18 +41,18 @@ static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip)
 {
 	u32 status;
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 }
 
 static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie *rockchip)
@@ -269,7 +270,7 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 	scale = 3; /* 0.001x */
 	curr = curr / 1000; /* convert to mA */
 	power = (curr * 3300) / 1000; /* milliwatt */
-	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
+	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
 		if (!scale) {
 			dev_warn(rockchip->dev, "invalid power supply\n");
 			return;
@@ -278,10 +279,10 @@ static void rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
 		power = power / 10;
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
-	status |= (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
-		  (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
+	status |= FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCAP);
 }
 
 /**
@@ -309,14 +310,14 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	rockchip_pcie_set_power_limit(rockchip);
 
 	/* Set RC's clock architecture as common clock */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKSTA_SLC << 16;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Set RC's RCB to 128 */
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 	status |= PCI_EXP_LNKCTL_RCB;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 	/* Enable Gen1 training */
 	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
@@ -341,9 +342,13 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 		 * Enable retrain for gen2. This should be configured only after
 		 * gen1 finished.
 		 */
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status &= ~PCI_EXP_LNKCTL2_TLS;
+		status |= PCI_EXP_LNKCTL2_TLS_5_0GT;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL2);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 		status |= PCI_EXP_LNKCTL_RL;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
 
 		err = readl_poll_timeout(rockchip->apb_base + PCIE_CORE_CTRL,
 					 status, PCIE_LINK_IS_GEN2(status), 20,
@@ -380,15 +385,15 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 
 	/* Clear L0s from RC's link cap */
 	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
-		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LINK_CAP);
-		status &= ~PCIE_RC_CONFIG_LINK_CAP_L0S;
-		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LINK_CAP);
+		status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
+		status &= ~PCI_EXP_LNKCAP_ASPM_L0S;
+		rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
 	}
 
-	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
-	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
-	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
-	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
+	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
+	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
 
 	return 0;
 err_power_off_phy:
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 688f51d9bde6..d916fcc8badb 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -144,16 +144,7 @@
 #define PCIE_EP_CONFIG_BASE		0xa00000
 #define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
 #define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
-#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
-#define   PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
-#define   PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
-#define   PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
-#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
-#define   PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
-#define   PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
-#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE + 0xcc)
-#define   PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
-#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
+#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
 #define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE + 0x90c)
 #define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE + 0x274)
 #define   PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20)
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index d712c7a866d2..ef50c82e647f 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -691,6 +691,7 @@ void pci_ep_cfs_remove_epf_group(struct config_group *group)
 	if (IS_ERR_OR_NULL(group))
 		return;
 
+	list_del(&group->group_entry);
 	configfs_unregister_default_group(group);
 }
 EXPORT_SYMBOL(pci_ep_cfs_remove_epf_group);
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 963d2f3aa5d4..9e7166a75579 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -334,7 +334,7 @@ static void pci_epf_remove_cfs(struct pci_epf_driver *driver)
 	mutex_lock(&pci_epf_mutex);
 	list_for_each_entry_safe(group, tmp, &driver->epf_group, group_entry)
 		pci_ep_cfs_remove_epf_group(group);
-	list_del(&driver->epf_group);
+	WARN_ON(!list_empty(&driver->epf_group));
 	mutex_unlock(&pci_epf_mutex);
 }
 
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 604c055f6078..ec2c768c687f 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -220,7 +220,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int services = 0;
 
-	if (dev->is_hotplug_bridge &&
+	if (dev->is_pciehp &&
 	    (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
 	     pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM) &&
 	    (pcie_ports_native || host->native_pcie_hotplug)) {
diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
index 20d4c020a83c..8b0f8a3a059c 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -58,14 +58,16 @@
  #define USB2_0_TX_ENABLE		BIT(2)
 
 #define USB2PHY_USB_PHY_M31_XCFGI_4	0xc8
- #define HSTX_SLEW_RATE_565PS		GENMASK(1, 0)
+ #define HSTX_SLEW_RATE_400PS		GENMASK(2, 0)
  #define PLL_CHARGING_PUMP_CURRENT_35UA	GENMASK(4, 3)
  #define ODT_VALUE_38_02_OHM		GENMASK(7, 6)
 
 #define USB2PHY_USB_PHY_M31_XCFGI_5	0xcc
- #define ODT_VALUE_45_02_OHM		BIT(2)
  #define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	BIT(0)
 
+#define USB2PHY_USB_PHY_M31_XCFGI_9	0xdc
+ #define HSTX_CURRENT_17_1MA_385MV	BIT(1)
+
 #define USB2PHY_USB_PHY_M31_XCFGI_11	0xe4
  #define XCFG_COARSE_TUNE_NUM		BIT(1)
  #define XCFG_FINE_TUNE_NUM		BIT(3)
@@ -164,7 +166,7 @@ static struct m31_phy_regs m31_ipq5332_regs[] = {
 	},
 	{
 		USB2PHY_USB_PHY_M31_XCFGI_4,
-		HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA | ODT_VALUE_38_02_OHM,
+		HSTX_SLEW_RATE_400PS | PLL_CHARGING_PUMP_CURRENT_35UA | ODT_VALUE_38_02_OHM,
 		0
 	},
 	{
@@ -174,9 +176,13 @@ static struct m31_phy_regs m31_ipq5332_regs[] = {
 	},
 	{
 		USB2PHY_USB_PHY_M31_XCFGI_5,
-		ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA,
+		HSTX_PRE_EMPHASIS_LEVEL_0_55MA,
 		4
 	},
+	{
+		USB2PHY_USB_PHY_M31_XCFGI_9,
+		HSTX_CURRENT_17_1MA_385MV,
+	},
 	{
 		USB_PHY_UTMI_CTRL5,
 		0x0,
diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index e821b3d39590..05b84f3b7f69 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -313,6 +313,9 @@ EXPORT_SYMBOL(cros_ec_register);
  */
 void cros_ec_unregister(struct cros_ec_device *ec_dev)
 {
+	if (ec_dev->mkbp_event_supported)
+		blocking_notifier_chain_unregister(&ec_dev->event_notifier,
+						   &ec_dev->notifier_ready);
 	platform_device_unregister(ec_dev->pd);
 	platform_device_unregister(ec_dev->ec);
 	mutex_destroy(&ec_dev->lock);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
index 5ab45b751666..9a5ff9163988 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-tpmi.c
@@ -189,9 +189,14 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *valu
 static int write_eff_lat_ctrl(struct uncore_data *data, unsigned int val, enum uncore_index index)
 {
 	struct tpmi_uncore_cluster_info *cluster_info;
+	struct tpmi_uncore_struct *uncore_root;
 	u64 control;
 
 	cluster_info = container_of(data, struct tpmi_uncore_cluster_info, uncore_data);
+	uncore_root = cluster_info->uncore_root;
+
+	if (uncore_root->write_blocked)
+		return -EPERM;
 
 	if (cluster_info->root_domain)
 		return -ENODATA;
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 7ee7b65b9b90..5b399de16d60 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -204,6 +204,15 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 		val |= FIELD_PREP(PWM_IMX_TPM_SC_PS, p->prescale);
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
 
+		/*
+		 * if the counter is disabled (CMOD == 0), programming the new
+		 * period length (MOD) will not reset the counter (CNT). If
+		 * CNT.COUNT happens to be bigger than the new MOD value then
+		 * the counter will end up being reset way too late. Therefore,
+		 * manually reset it to 0.
+		 */
+		if (!cmod)
+			writel(0x0, tpm->base + PWM_IMX_TPM_CNT);
 		/*
 		 * set period count:
 		 * if the PWM is disabled (CMOD[1:0] = 2b00), then MOD register
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 33d3554b9197..bfbfe7f2917b 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -115,6 +115,26 @@ static inline void pwm_mediatek_writel(struct pwm_mediatek_chip *chip,
 	writel(value, chip->regs + chip->soc->reg_offset[num] + offset);
 }
 
+static void pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value |= BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
+static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
+	u32 value;
+
+	value = readl(pc->regs);
+	value &= ~BIT(pwm->hwpwm);
+	writel(value, pc->regs);
+}
+
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       int duty_ns, int period_ns)
 {
@@ -144,7 +164,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(resolution, clk_rate);
 
 	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	while (cnt_period > 8191) {
+	if (!cnt_period)
+		return -EINVAL;
+
+	while (cnt_period > 8192) {
 		resolution *= 2;
 		clkdiv++;
 		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
@@ -167,9 +190,16 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
+
 	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+
+	if (cnt_duty) {
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty - 1);
+		pwm_mediatek_enable(chip, pwm);
+	} else {
+		pwm_mediatek_disable(chip, pwm);
+	}
 
 out:
 	pwm_mediatek_clk_disable(chip, pwm);
@@ -177,35 +207,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int pwm_mediatek_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-	int ret;
-
-	ret = pwm_mediatek_clk_enable(chip, pwm);
-	if (ret < 0)
-		return ret;
-
-	value = readl(pc->regs);
-	value |= BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	return 0;
-}
-
-static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 value;
-
-	value = readl(pc->regs);
-	value &= ~BIT(pwm->hwpwm);
-	writel(value, pc->regs);
-
-	pwm_mediatek_clk_disable(chip, pwm);
-}
-
 static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			      const struct pwm_state *state)
 {
@@ -215,8 +216,10 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		if (pwm->state.enabled)
+		if (pwm->state.enabled) {
 			pwm_mediatek_disable(chip, pwm);
+			pwm_mediatek_clk_disable(chip, pwm);
+		}
 
 		return 0;
 	}
@@ -226,7 +229,7 @@ static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return err;
 
 	if (!pwm->state.enabled)
-		err = pwm_mediatek_enable(chip, pwm);
+		err = pwm_mediatek_clk_enable(chip, pwm);
 
 	return err;
 }
diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index 45bd001206a2..d9899b4d4767 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -76,6 +76,13 @@ unsigned long sclp_console_full;
 /* The currently active SCLP command word. */
 static sclp_cmdw_t active_cmd;
 
+static inline struct sccb_header *sclpint_to_sccb(u32 sccb_int)
+{
+	if (sccb_int)
+		return __va(sccb_int);
+	return NULL;
+}
+
 static inline void sclp_trace(int prio, char *id, u32 a, u64 b, bool err)
 {
 	struct sclp_trace_entry e;
@@ -619,7 +626,7 @@ __sclp_find_req(u32 sccb)
 
 static bool ok_response(u32 sccb_int, sclp_cmdw_t cmd)
 {
-	struct sccb_header *sccb = (struct sccb_header *)__va(sccb_int);
+	struct sccb_header *sccb = sclpint_to_sccb(sccb_int);
 	struct evbuf_header *evbuf;
 	u16 response;
 
@@ -658,7 +665,7 @@ static void sclp_interrupt_handler(struct ext_code ext_code,
 
 	/* INT: Interrupt received (a=intparm, b=cmd) */
 	sclp_trace_sccb(0, "INT", param32, active_cmd, active_cmd,
-			(struct sccb_header *)__va(finished_sccb),
+			sclpint_to_sccb(finished_sccb),
 			!ok_response(finished_sccb, active_cmd));
 
 	if (finished_sccb) {
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index ab7c5f1fc041..840195373084 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -1131,6 +1131,8 @@ struct scmd_priv {
  * @logdata_buf: Circular buffer to store log data entries
  * @logdata_buf_idx: Index of entry in buffer to store
  * @logdata_entry_sz: log data entry size
+ * @adm_req_q_bar_writeq_lock: Admin request queue lock
+ * @adm_reply_q_bar_writeq_lock: Admin reply queue lock
  * @pend_large_data_sz: Counter to track pending large data
  * @io_throttle_data_length: I/O size to track in 512b blocks
  * @io_throttle_high: I/O size to start throttle in 512b blocks
@@ -1175,7 +1177,7 @@ struct mpi3mr_ioc {
 	char name[MPI3MR_NAME_LENGTH];
 	char driver_name[MPI3MR_NAME_LENGTH];
 
-	volatile struct mpi3_sysif_registers __iomem *sysif_regs;
+	struct mpi3_sysif_registers __iomem *sysif_regs;
 	resource_size_t sysif_regs_phys;
 	int bars;
 	u64 dma_mask;
@@ -1328,6 +1330,8 @@ struct mpi3mr_ioc {
 	u8 *logdata_buf;
 	u16 logdata_buf_idx;
 	u16 logdata_entry_sz;
+	spinlock_t adm_req_q_bar_writeq_lock;
+	spinlock_t adm_reply_q_bar_writeq_lock;
 
 	atomic_t pend_large_data_sz;
 	u32 io_throttle_data_length;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_fw.c b/drivers/scsi/mpi3mr/mpi3mr_fw.c
index 604f37e5c0c3..08c751884b32 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_fw.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_fw.c
@@ -23,17 +23,22 @@ module_param(poll_queues, int, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of queues for io_uring poll mode. (Range 1 - 126)");
 
 #if defined(writeq) && defined(CONFIG_64BIT)
-static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr,
+	spinlock_t *write_queue_lock)
 {
 	writeq(b, addr);
 }
 #else
-static inline void mpi3mr_writeq(__u64 b, volatile void __iomem *addr)
+static inline void mpi3mr_writeq(__u64 b, void __iomem *addr,
+	spinlock_t *write_queue_lock)
 {
 	__u64 data_out = b;
+	unsigned long flags;
 
+	spin_lock_irqsave(write_queue_lock, flags);
 	writel((u32)(data_out), addr);
 	writel((u32)(data_out >> 32), (addr + 4));
+	spin_unlock_irqrestore(write_queue_lock, flags);
 }
 #endif
 
@@ -428,8 +433,8 @@ static void mpi3mr_process_admin_reply_desc(struct mpi3mr_ioc *mrioc,
 				       MPI3MR_SENSE_BUF_SZ);
 			}
 			if (cmdptr->is_waiting) {
-				complete(&cmdptr->done);
 				cmdptr->is_waiting = 0;
+				complete(&cmdptr->done);
 			} else if (cmdptr->callback)
 				cmdptr->callback(mrioc, cmdptr);
 		}
@@ -2931,9 +2936,11 @@ static int mpi3mr_setup_admin_qpair(struct mpi3mr_ioc *mrioc)
 	    (mrioc->num_admin_req);
 	writel(num_admin_entries, &mrioc->sysif_regs->admin_queue_num_entries);
 	mpi3mr_writeq(mrioc->admin_req_dma,
-	    &mrioc->sysif_regs->admin_request_queue_address);
+		&mrioc->sysif_regs->admin_request_queue_address,
+		&mrioc->adm_req_q_bar_writeq_lock);
 	mpi3mr_writeq(mrioc->admin_reply_dma,
-	    &mrioc->sysif_regs->admin_reply_queue_address);
+		&mrioc->sysif_regs->admin_reply_queue_address,
+		&mrioc->adm_reply_q_bar_writeq_lock);
 	writel(mrioc->admin_req_pi, &mrioc->sysif_regs->admin_request_queue_pi);
 	writel(mrioc->admin_reply_ci, &mrioc->sysif_regs->admin_reply_queue_ci);
 	return retval;
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 990646e1e18d..1930e47cbf7b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -5251,6 +5251,8 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	spin_lock_init(&mrioc->tgtdev_lock);
 	spin_lock_init(&mrioc->watchdog_lock);
 	spin_lock_init(&mrioc->chain_buf_lock);
+	spin_lock_init(&mrioc->adm_req_q_bar_writeq_lock);
+	spin_lock_init(&mrioc->adm_reply_q_bar_writeq_lock);
 	spin_lock_init(&mrioc->sas_node_lock);
 	spin_lock_init(&mrioc->trigger_lock);
 
diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 97e9ca5a2a02..59ff6bb11d84 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -6606,6 +6606,8 @@ static struct iscsi_endpoint *qla4xxx_get_ep_fwdb(struct scsi_qla_host *ha,
 
 	ep = qla4xxx_ep_connect(ha->host, (struct sockaddr *)dst_addr, 0);
 	vfree(dst_addr);
+	if (IS_ERR(ep))
+		return NULL;
 	return ep;
 }
 
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ce4b428b63f8..a4cafc688c2a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -210,6 +210,9 @@ static int scsi_check_passthrough(struct scsi_cmnd *scmd,
 	struct scsi_sense_hdr sshdr;
 	enum sam_status status;
 
+	if (!scmd->result)
+		return 0;
+
 	if (!failures)
 		return 0;
 
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 44589d10b15b..64e0facc392e 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -18,6 +18,37 @@
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 
+static bool mdt_header_valid(const struct firmware *fw)
+{
+	const struct elf32_hdr *ehdr;
+	size_t phend;
+	size_t shend;
+
+	if (fw->size < sizeof(*ehdr))
+		return false;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG))
+		return false;
+
+	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
+		return false;
+
+	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
+	if (phend > fw->size)
+		return false;
+
+	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+		return false;
+
+	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+	if (shend > fw->size)
+		return false;
+
+	return true;
+}
+
 static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 {
 	if (phdr->p_type != PT_LOAD)
@@ -82,6 +113,9 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
 	phys_addr_t max_addr = 0;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
 
@@ -134,6 +168,9 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	ssize_t ret;
 	void *data;
 
+	if (!mdt_header_valid(fw))
+		return ERR_PTR(-EINVAL);
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
 
@@ -214,6 +251,9 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 	int ret;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
 
@@ -310,6 +350,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	is_split = qcom_mdt_bins_are_split(fw, fw_name);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(fw->data + ehdr->e_phoff);
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index a08c377933c5..0fdccd736209 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1233,7 +1233,7 @@ static int tegra_powergate_of_get_clks(struct tegra_powergate *pg,
 }
 
 static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
-					 struct device_node *np, bool off)
+					 struct device_node *np)
 {
 	struct device *dev = pg->pmc->dev;
 	int err;
@@ -1248,22 +1248,6 @@ static int tegra_powergate_of_get_resets(struct tegra_powergate *pg,
 	err = reset_control_acquire(pg->reset);
 	if (err < 0) {
 		pr_err("failed to acquire resets: %d\n", err);
-		goto out;
-	}
-
-	if (off) {
-		err = reset_control_assert(pg->reset);
-	} else {
-		err = reset_control_deassert(pg->reset);
-		if (err < 0)
-			goto out;
-
-		reset_control_release(pg->reset);
-	}
-
-out:
-	if (err) {
-		reset_control_release(pg->reset);
 		reset_control_put(pg->reset);
 	}
 
@@ -1308,20 +1292,43 @@ static int tegra_powergate_add(struct tegra_pmc *pmc, struct device_node *np)
 		goto set_available;
 	}
 
-	err = tegra_powergate_of_get_resets(pg, np, off);
+	err = tegra_powergate_of_get_resets(pg, np);
 	if (err < 0) {
 		dev_err(dev, "failed to get resets for %pOFn: %d\n", np, err);
 		goto remove_clks;
 	}
 
-	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
-		if (off)
-			WARN_ON(tegra_powergate_power_up(pg, true));
+	/*
+	 * If the power-domain is off, then ensure the resets are asserted.
+	 * If the power-domain is on, then power down to ensure that when is
+	 * it turned on the power-domain, clocks and resets are all in the
+	 * expected state.
+	 */
+	if (off) {
+		err = reset_control_assert(pg->reset);
+		if (err) {
+			pr_err("failed to assert resets: %d\n", err);
+			goto remove_resets;
+		}
+	} else {
+		err = tegra_powergate_power_down(pg);
+		if (err) {
+			dev_err(dev, "failed to turn off PM domain %s: %d\n",
+				pg->genpd.name, err);
+			goto remove_resets;
+		}
+	}
 
+	/*
+	 * If PM_GENERIC_DOMAINS is not enabled, power-on
+	 * the domain and skip the genpd registration.
+	 */
+	if (!IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS)) {
+		WARN_ON(tegra_powergate_power_up(pg, true));
 		goto remove_resets;
 	}
 
-	err = pm_genpd_init(&pg->genpd, NULL, off);
+	err = pm_genpd_init(&pg->genpd, NULL, true);
 	if (err < 0) {
 		dev_err(dev, "failed to initialise PM domain %pOFn: %d\n", np,
 		       err);
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 29b9676fe43d..f8cacb9c7408 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -330,13 +330,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 	}
 
 	if (config.speed_hz > perclk_rate / 2) {
-		dev_err(fsl_lpspi->dev,
-		      "per-clk should be at least two times of transfer speed");
-		return -EINVAL;
+		div = 2;
+	} else {
+		div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
 	}
 
-	div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
-
 	for (prescale = 0; prescale <= prescale_max; prescale++) {
 		scldiv = div / (1 << prescale) - 2;
 		if (scldiv >= 0 && scldiv < 256) {
diff --git a/drivers/staging/media/imx/imx-media-csc-scaler.c b/drivers/staging/media/imx/imx-media-csc-scaler.c
index 95cca281e8a3..07104e7f5a5f 100644
--- a/drivers/staging/media/imx/imx-media-csc-scaler.c
+++ b/drivers/staging/media/imx/imx-media-csc-scaler.c
@@ -914,7 +914,7 @@ imx_media_csc_scaler_device_init(struct imx_media_dev *md)
 	return &priv->vdev;
 
 err_m2m:
-	video_set_drvdata(vfd, NULL);
+	video_device_release(vfd);
 err_vfd:
 	kfree(priv);
 	return ERR_PTR(ret);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 051967992965..03aca7eaca16 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2351,9 +2351,8 @@ int serial8250_do_startup(struct uart_port *port)
 	/*
 	 * Now, initialize the UART
 	 */
-	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
-
 	uart_port_lock_irqsave(port, &flags);
+	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
index 0c043e4f292e..6af7bf8d5460 100644
--- a/drivers/tty/vt/defkeymap.c_shipped
+++ b/drivers/tty/vt/defkeymap.c_shipped
@@ -23,6 +23,22 @@ unsigned short plain_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short shift_map[NR_KEYS] = {
@@ -42,6 +58,22 @@ static unsigned short shift_map[NR_KEYS] = {
 	0xf20b,	0xf601,	0xf602,	0xf117,	0xf600,	0xf20a,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short altgr_map[NR_KEYS] = {
@@ -61,6 +93,22 @@ static unsigned short altgr_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short ctrl_map[NR_KEYS] = {
@@ -80,6 +128,22 @@ static unsigned short ctrl_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short shift_ctrl_map[NR_KEYS] = {
@@ -99,6 +163,22 @@ static unsigned short shift_ctrl_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short alt_map[NR_KEYS] = {
@@ -118,6 +198,22 @@ static unsigned short alt_map[NR_KEYS] = {
 	0xf118,	0xf210,	0xf211,	0xf117,	0xf600,	0xf119,	0xf115,	0xf116,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 static unsigned short ctrl_alt_map[NR_KEYS] = {
@@ -137,6 +233,22 @@ static unsigned short ctrl_alt_map[NR_KEYS] = {
 	0xf118,	0xf601,	0xf602,	0xf117,	0xf600,	0xf119,	0xf115,	0xf20c,
 	0xf11a,	0xf10c,	0xf10d,	0xf11b,	0xf11c,	0xf110,	0xf311,	0xf11d,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
+	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
 unsigned short *key_maps[MAX_NR_KEYMAPS] = {
diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 804355da46f5..00caf1c2bcee 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -1494,7 +1494,7 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
 		rc = atomic_notifier_call_chain(&keyboard_notifier_list,
 						KBD_UNICODE, &param);
 		if (rc != NOTIFY_STOP)
-			if (down && !raw_mode)
+			if (down && !(raw_mode || kbd->kbdmode == VC_OFF))
 				k_unicode(vc, keysym, !down);
 		return;
 	}
diff --git a/drivers/ufs/host/ufs-exynos.c b/drivers/ufs/host/ufs-exynos.c
index 5ba17ccf6417..6bd1532bfd1d 100644
--- a/drivers/ufs/host/ufs-exynos.c
+++ b/drivers/ufs/host/ufs-exynos.c
@@ -1078,8 +1078,8 @@ static int exynos_ufs_post_link(struct ufs_hba *hba)
 	hci_writel(ufs, val, HCI_TXPRDT_ENTRY_SIZE);
 
 	hci_writel(ufs, ilog2(DATA_UNIT_SIZE), HCI_RXPRDT_ENTRY_SIZE);
-	hci_writel(ufs, (1 << hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
-	hci_writel(ufs, (1 << hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutrs) - 1, HCI_UTRL_NEXUS_TYPE);
+	hci_writel(ufs, BIT(hba->nutmrs) - 1, HCI_UTMRL_NEXUS_TYPE);
 	hci_writel(ufs, 0xf, HCI_AXIDMA_RWDATA_BURST_LEN);
 
 	if (ufs->opts & EXYNOS_UFS_OPT_SKIP_CONNECTION_ESTAB)
diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index 850ff71130d5..570067483a04 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -216,6 +216,32 @@ static int ufs_intel_lkf_apply_dev_quirks(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufs_intel_ctrl_uic_compl(struct ufs_hba *hba, bool enable)
+{
+	u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
+
+	if (enable)
+		set |= UIC_COMMAND_COMPL;
+	else
+		set &= ~UIC_COMMAND_COMPL;
+	ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
+}
+
+static void ufs_intel_mtl_h8_notify(struct ufs_hba *hba,
+				    enum uic_cmd_dme cmd,
+				    enum ufs_notify_change_status status)
+{
+	/*
+	 * Disable UIC COMPL INTR to prevent access to UFSHCI after
+	 * checking HCS.UPMCRS
+	 */
+	if (status == PRE_CHANGE && cmd == UIC_CMD_DME_HIBER_ENTER)
+		ufs_intel_ctrl_uic_compl(hba, false);
+
+	if (status == POST_CHANGE && cmd == UIC_CMD_DME_HIBER_EXIT)
+		ufs_intel_ctrl_uic_compl(hba, true);
+}
+
 #define INTEL_ACTIVELTR		0x804
 #define INTEL_IDLELTR		0x808
 
@@ -442,10 +468,23 @@ static int ufs_intel_adl_init(struct ufs_hba *hba)
 	return ufs_intel_common_init(hba);
 }
 
+static void ufs_intel_mtl_late_init(struct ufs_hba *hba)
+{
+	hba->rpm_lvl = UFS_PM_LVL_2;
+	hba->spm_lvl = UFS_PM_LVL_2;
+}
+
 static int ufs_intel_mtl_init(struct ufs_hba *hba)
 {
+	struct ufs_host *ufs_host;
+	int err;
+
 	hba->caps |= UFSHCD_CAP_CRYPTO | UFSHCD_CAP_WB_EN;
-	return ufs_intel_common_init(hba);
+	err = ufs_intel_common_init(hba);
+	/* Get variant after it is set in ufs_intel_common_init() */
+	ufs_host = ufshcd_get_variant(hba);
+	ufs_host->late_init = ufs_intel_mtl_late_init;
+	return err;
 }
 
 static int ufs_qemu_get_hba_mac(struct ufs_hba *hba)
@@ -533,6 +572,7 @@ static struct ufs_hba_variant_ops ufs_intel_mtl_hba_vops = {
 	.init			= ufs_intel_mtl_init,
 	.exit			= ufs_intel_common_exit,
 	.hce_enable_notify	= ufs_intel_hce_enable_notify,
+	.hibern8_notify		= ufs_intel_mtl_h8_notify,
 	.link_startup_notify	= ufs_intel_link_startup_notify,
 	.resume			= ufs_intel_resume,
 	.device_reset		= ufs_intel_device_reset,
diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index 47d06af33747..08faf82ec31d 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -980,25 +980,60 @@ static int cxacru_fw(struct usb_device *usb_dev, enum cxacru_fw_request fw,
 	return ret;
 }
 
-static void cxacru_upload_firmware(struct cxacru_data *instance,
-				   const struct firmware *fw,
-				   const struct firmware *bp)
+
+static int cxacru_find_firmware(struct cxacru_data *instance,
+				char *phase, const struct firmware **fw_p)
 {
-	int ret;
+	struct usbatm_data *usbatm = instance->usbatm;
+	struct device *dev = &usbatm->usb_intf->dev;
+	char buf[16];
+
+	sprintf(buf, "cxacru-%s.bin", phase);
+	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
+
+	if (request_firmware(fw_p, buf, dev)) {
+		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
+		return -ENOENT;
+	}
+
+	usb_info(usbatm, "found firmware %s\n", buf);
+
+	return 0;
+}
+
+static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
+			     struct usb_interface *usb_intf)
+{
+	const struct firmware *fw, *bp;
+	struct cxacru_data *instance = usbatm_instance->driver_data;
 	struct usbatm_data *usbatm = instance->usbatm;
 	struct usb_device *usb_dev = usbatm->usb_dev;
 	__le16 signature[] = { usb_dev->descriptor.idVendor,
 			       usb_dev->descriptor.idProduct };
 	__le32 val;
+	int ret;
 
-	usb_dbg(usbatm, "%s\n", __func__);
+	ret = cxacru_find_firmware(instance, "fw", &fw);
+	if (ret) {
+		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
+		return ret;
+	}
+
+	if (instance->modem_type->boot_rom_patch) {
+		ret = cxacru_find_firmware(instance, "bp", &bp);
+		if (ret) {
+			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
+			release_firmware(fw);
+			return ret;
+		}
+	}
 
 	/* FirmwarePllFClkValue */
 	val = cpu_to_le32(instance->modem_type->pll_f_clk);
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLFCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllFClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* FirmwarePllBClkValue */
@@ -1006,7 +1041,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, PLLBCLK_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "FirmwarePllBClkValue failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Enable SDRAM */
@@ -1014,7 +1049,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SDRAMEN_ADDR, (u8 *) &val, 4);
 	if (ret) {
 		usb_err(usbatm, "Enable SDRAM failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Firmware */
@@ -1022,7 +1057,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, FW_ADDR, fw->data, fw->size);
 	if (ret) {
 		usb_err(usbatm, "Firmware upload failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Boot ROM patch */
@@ -1031,7 +1066,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 		ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, BR_ADDR, bp->data, bp->size);
 		if (ret) {
 			usb_err(usbatm, "Boot ROM patching failed: %d\n", ret);
-			return;
+			goto done;
 		}
 	}
 
@@ -1039,7 +1074,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_fw(usb_dev, FW_WRITE_MEM, 0x2, 0x0, SIG_ADDR, (u8 *) signature, 4);
 	if (ret) {
 		usb_err(usbatm, "Signature storing failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	usb_info(usbatm, "starting device\n");
@@ -1051,7 +1086,7 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	}
 	if (ret) {
 		usb_err(usbatm, "Passing control to firmware failed: %d\n", ret);
-		return;
+		goto done;
 	}
 
 	/* Delay to allow firmware to start up. */
@@ -1065,53 +1100,10 @@ static void cxacru_upload_firmware(struct cxacru_data *instance,
 	ret = cxacru_cm(instance, CM_REQUEST_CARD_GET_STATUS, NULL, 0, NULL, 0);
 	if (ret < 0) {
 		usb_err(usbatm, "modem failed to initialize: %d\n", ret);
-		return;
-	}
-}
-
-static int cxacru_find_firmware(struct cxacru_data *instance,
-				char *phase, const struct firmware **fw_p)
-{
-	struct usbatm_data *usbatm = instance->usbatm;
-	struct device *dev = &usbatm->usb_intf->dev;
-	char buf[16];
-
-	sprintf(buf, "cxacru-%s.bin", phase);
-	usb_dbg(usbatm, "cxacru_find_firmware: looking for %s\n", buf);
-
-	if (request_firmware(fw_p, buf, dev)) {
-		usb_dbg(usbatm, "no stage %s firmware found\n", phase);
-		return -ENOENT;
-	}
-
-	usb_info(usbatm, "found firmware %s\n", buf);
-
-	return 0;
-}
-
-static int cxacru_heavy_init(struct usbatm_data *usbatm_instance,
-			     struct usb_interface *usb_intf)
-{
-	const struct firmware *fw, *bp;
-	struct cxacru_data *instance = usbatm_instance->driver_data;
-	int ret = cxacru_find_firmware(instance, "fw", &fw);
-
-	if (ret) {
-		usb_warn(usbatm_instance, "firmware (cxacru-fw.bin) unavailable (system misconfigured?)\n");
-		return ret;
+		goto done;
 	}
 
-	if (instance->modem_type->boot_rom_patch) {
-		ret = cxacru_find_firmware(instance, "bp", &bp);
-		if (ret) {
-			usb_warn(usbatm_instance, "boot ROM patch (cxacru-bp.bin) unavailable (system misconfigured?)\n");
-			release_firmware(fw);
-			return ret;
-		}
-	}
-
-	cxacru_upload_firmware(instance, fw, bp);
-
+done:
 	if (instance->modem_type->boot_rom_patch)
 		release_firmware(bp);
 	release_firmware(fw);
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 0b2490347b9f..bc795257696e 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1623,7 +1623,6 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	struct usb_hcd *hcd = bus_to_hcd(urb->dev->bus);
 	struct usb_anchor *anchor = urb->anchor;
 	int status = urb->unlinked;
-	unsigned long flags;
 
 	urb->hcpriv = NULL;
 	if (unlikely((urb->transfer_flags & URB_SHORT_NOT_OK) &&
@@ -1641,14 +1640,13 @@ static void __usb_hcd_giveback_urb(struct urb *urb)
 	/* pass ownership to the completion handler */
 	urb->status = status;
 	/*
-	 * Only collect coverage in the softirq context and disable interrupts
-	 * to avoid scenarios with nested remote coverage collection sections
-	 * that KCOV does not support.
-	 * See the comment next to kcov_remote_start_usb_softirq() for details.
+	 * This function can be called in task context inside another remote
+	 * coverage collection section, but kcov doesn't support that kind of
+	 * recursion yet. Only collect coverage in softirq context for now.
 	 */
-	flags = kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
+	kcov_remote_start_usb_softirq((u64)urb->dev->bus->busnum);
 	urb->complete(urb);
-	kcov_remote_stop_softirq(flags);
+	kcov_remote_stop_softirq();
 
 	usb_anchor_resume_wakeups(anchor);
 	atomic_dec(&urb->use_count);
@@ -2153,7 +2151,7 @@ static struct urb *request_single_step_set_feature_urb(
 	urb->complete = usb_ehset_completion;
 	urb->status = -EINPROGRESS;
 	urb->actual_length = 0;
-	urb->transfer_flags = URB_DIR_IN;
+	urb->transfer_flags = URB_DIR_IN | URB_NO_TRANSFER_DMA_MAP;
 	usb_get_urb(urb);
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
@@ -2217,9 +2215,15 @@ int ehset_single_step_set_feature(struct usb_hcd *hcd, int port)
 
 	/* Complete remaining DATA and STATUS stages using the same URB */
 	urb->status = -EINPROGRESS;
+	urb->transfer_flags &= ~URB_NO_TRANSFER_DMA_MAP;
 	usb_get_urb(urb);
 	atomic_inc(&urb->use_count);
 	atomic_inc(&urb->dev->urbnum);
+	if (map_urb_for_dma(hcd, urb, GFP_KERNEL)) {
+		usb_put_urb(urb);
+		goto out1;
+	}
+
 	retval = hcd->driver->submit_single_step_set_feature(hcd, urb, 0);
 	if (!retval && !wait_for_completion_timeout(&done,
 						msecs_to_jiffies(2000))) {
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 46db600fdd82..bfd97cad8aa4 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -371,6 +371,7 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x0781, 0x5591), .driver_info = USB_QUIRK_NO_LPM },
 
 	/* SanDisk Corp. SanDisk 3.2Gen1 */
+	{ USB_DEVICE(0x0781, 0x5596), .driver_info = USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x0781, 0x55a3), .driver_info = USB_QUIRK_DELAY_INIT },
 
 	/* SanDisk Extreme 55AE */
diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index e99faf014c78..449c12bb1d4b 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -244,7 +244,7 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto depopulate;
+		goto put_dwc3;
 	}
 
 	device_set_wakeup_capable(dev, true);
@@ -252,6 +252,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	return 0;
 
+put_dwc3:
+	put_device(&dwc3_imx->dwc3->dev);
 depopulate:
 	of_platform_depopulate(dev);
 remove_swnode:
@@ -265,8 +267,11 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 static void dwc3_imx8mp_remove(struct platform_device *pdev)
 {
+	struct dwc3_imx8mp *dwc3_imx = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
 
+	put_device(&dwc3_imx->dwc3->dev);
+
 	pm_runtime_get_sync(dev);
 	of_platform_depopulate(dev);
 	device_remove_software_node(dev);
diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 2c07c038b584..6ea1a876203d 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -837,6 +837,9 @@ static void dwc3_meson_g12a_remove(struct platform_device *pdev)
 
 	usb_role_switch_unregister(priv->role_switch);
 
+	put_device(priv->switch_desc.udc);
+	put_device(priv->switch_desc.usb2_port);
+
 	of_platform_depopulate(dev);
 
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 54a4ee2b90b7..39c72cb52ce7 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -41,6 +41,7 @@
 #define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
 #define PCI_DEVICE_ID_INTEL_JSP			0x4dee
+#define PCI_DEVICE_ID_INTEL_WCL			0x4d7e
 #define PCI_DEVICE_ID_INTEL_ADL			0x460e
 #define PCI_DEVICE_ID_INTEL_ADL_PCH		0x51ee
 #define PCI_DEVICE_ID_INTEL_ADLN		0x465e
@@ -431,6 +432,7 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_DEVICE_DATA(INTEL, TGPLP, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGPH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, JSP, &dwc3_pci_intel_swnode) },
+	{ PCI_DEVICE_DATA(INTEL, WCL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ADL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ADL_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ADLN, &dwc3_pci_intel_swnode) },
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 874497f86499..876a839f2d1d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
+
 	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
 		struct dwc3_ep *dwc3_ep;
 
@@ -1061,7 +1063,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_err(dwc->dev,
+			"ep0 data phase start transfer failed: %d\n", ret);
 }
 
 static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
@@ -1078,7 +1082,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
-	WARN_ON(dwc3_ep0_start_control_status(dep));
+	int	ret;
+
+	ret = dwc3_ep0_start_control_status(dep);
+	if (ret)
+		dev_err(dwc->dev,
+			"ep0 status phase start transfer failed: %d\n", ret);
 }
 
 static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
@@ -1121,7 +1130,10 @@ void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		dev_err_ratelimited(dwc->dev,
+			"ep0 data phase end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 37ae1dd3345d..c137b2f395c3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1763,7 +1763,11 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 		dep->flags |= DWC3_EP_DELAY_STOP;
 		return 0;
 	}
-	WARN_ON_ONCE(ret);
+
+	if (ret)
+		dev_err_ratelimited(dep->dwc->dev,
+				"end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 
 	if (!interrupt)
@@ -3707,6 +3711,15 @@ static void dwc3_gadget_endpoint_transfer_complete(struct dwc3_ep *dep,
 static void dwc3_gadget_endpoint_transfer_not_ready(struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event)
 {
+	/*
+	 * During a device-initiated disconnect, a late xferNotReady event can
+	 * be generated after the End Transfer command resets the event filter,
+	 * but before the controller is halted. Ignore it to prevent a new
+	 * transfer from starting.
+	 */
+	if (!dep->dwc->connected)
+		return;
+
 	dwc3_gadget_endpoint_frame_from_event(dep, event);
 
 	/*
@@ -4008,7 +4021,9 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 		dep->flags &= ~DWC3_EP_STALL;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
-		WARN_ON_ONCE(ret);
+		if (ret)
+			dev_err_ratelimited(dwc->dev,
+				"failed to clear STALL on %s\n", dep->name);
 	}
 }
 
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index a93ad93390ba..34685c714473 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2658,6 +2658,7 @@ static void renesas_usb3_remove(struct platform_device *pdev)
 	struct renesas_usb3 *usb3 = platform_get_drvdata(pdev);
 
 	debugfs_remove_recursive(usb3->dentry);
+	put_device(usb3->host_dev);
 	device_remove_file(&pdev->dev, &dev_attr_role);
 
 	cancel_work_sync(&usb3->role_work);
diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 1952e0503340..69aedce9d67b 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -704,8 +704,7 @@ static int xhci_enter_test_mode(struct xhci_hcd *xhci,
 		if (!xhci->devs[i])
 			continue;
 
-		retval = xhci_disable_slot(xhci, i);
-		xhci_free_virt_device(xhci, i);
+		retval = xhci_disable_and_free_slot(xhci, i);
 		if (retval)
 			xhci_err(xhci, "Failed to disable slot %d, %d. Enter test mode anyway\n",
 				 i, retval);
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 1111650757ea..69188afa5266 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -842,21 +842,20 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
  * will be manipulated by the configure endpoint, allocate device, or update
  * hub functions while this function is removing the TT entries from the list.
  */
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
+		int slot_id)
 {
-	struct xhci_virt_device *dev;
 	int i;
 	int old_active_eps = 0;
 
 	/* Slot ID 0 is reserved */
-	if (slot_id == 0 || !xhci->devs[slot_id])
+	if (slot_id == 0 || !dev)
 		return;
 
-	dev = xhci->devs[slot_id];
-
-	xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
-	if (!dev)
-		return;
+	/* If device ctx array still points to _this_ device, clear it */
+	if (dev->out_ctx &&
+	    xhci->dcbaa->dev_context_ptrs[slot_id] == cpu_to_le64(dev->out_ctx->dma))
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
 
 	trace_xhci_free_virt_device(dev);
 
@@ -897,8 +896,9 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id)
 		dev->udev->slot_id = 0;
 	if (dev->rhub_port && dev->rhub_port->slot_id == slot_id)
 		dev->rhub_port->slot_id = 0;
-	kfree(xhci->devs[slot_id]);
-	xhci->devs[slot_id] = NULL;
+	if (xhci->devs[slot_id] == dev)
+		xhci->devs[slot_id] = NULL;
+	kfree(dev);
 }
 
 /*
@@ -939,7 +939,7 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 out:
 	/* we are now at a leaf device */
 	xhci_debugfs_remove_slot(xhci, slot_id);
-	xhci_free_virt_device(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
 }
 
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id,
diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index 65fc9319d5e7..d8bd88139456 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -47,8 +47,9 @@
 #define RENESAS_ROM_ERASE_MAGIC				0x5A65726F
 #define RENESAS_ROM_WRITE_MAGIC				0x53524F4D
 
-#define RENESAS_RETRY	10000
-#define RENESAS_DELAY	10
+#define RENESAS_RETRY			50000	/* 50000 * RENESAS_DELAY ~= 500ms */
+#define RENESAS_CHIP_ERASE_RETRY	500000	/* 500000 * RENESAS_DELAY ~= 5s */
+#define RENESAS_DELAY			10
 
 #define RENESAS_FW_NAME	"renesas_usb_fw.mem"
 
@@ -407,7 +408,7 @@ static void renesas_rom_erase(struct pci_dev *pdev)
 	/* sleep a bit while ROM is erased */
 	msleep(20);
 
-	for (i = 0; i < RENESAS_RETRY; i++) {
+	for (i = 0; i < RENESAS_CHIP_ERASE_RETRY; i++) {
 		retval = pci_read_config_byte(pdev, RENESAS_ROM_STATUS,
 					      &status);
 		status &= RENESAS_ROM_STATUS_ERASE;
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index f6ecb3b9fb14..1002fa51a25a 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1562,7 +1562,8 @@ static void xhci_handle_cmd_enable_slot(int slot_id, struct xhci_command *comman
 		command->slot_id = 0;
 }
 
-static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
+static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id,
+					u32 cmd_comp_code)
 {
 	struct xhci_virt_device *virt_dev;
 	struct xhci_slot_ctx *slot_ctx;
@@ -1577,6 +1578,10 @@ static void xhci_handle_cmd_disable_slot(struct xhci_hcd *xhci, int slot_id)
 	if (xhci->quirks & XHCI_EP_LIMIT_QUIRK)
 		/* Delete default control endpoint resources */
 		xhci_free_device_endpoint_resources(xhci, virt_dev, true);
+	if (cmd_comp_code == COMP_SUCCESS) {
+		xhci->dcbaa->dev_context_ptrs[slot_id] = 0;
+		xhci->devs[slot_id] = NULL;
+	}
 }
 
 static void xhci_handle_cmd_config_ep(struct xhci_hcd *xhci, int slot_id)
@@ -1824,7 +1829,7 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 		xhci_handle_cmd_enable_slot(slot_id, cmd, cmd_comp_code);
 		break;
 	case TRB_DISABLE_SLOT:
-		xhci_handle_cmd_disable_slot(xhci, slot_id);
+		xhci_handle_cmd_disable_slot(xhci, slot_id, cmd_comp_code);
 		break;
 	case TRB_CONFIG_EP:
 		if (!cmd->completion)
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e399638d6000..d5bcd5475b72 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3763,8 +3763,7 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 		 * Obtaining a new device slot to inform the xHCI host that
 		 * the USB device has been reset.
 		 */
-		ret = xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			ret = xhci_alloc_dev(hcd, udev);
 			if (ret == 1)
@@ -3919,7 +3918,7 @@ static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	xhci_disable_slot(xhci, udev->slot_id);
 
 	spin_lock_irqsave(&xhci->lock, flags);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_free_virt_device(xhci, virt_dev, udev->slot_id);
 	spin_unlock_irqrestore(&xhci->lock, flags);
 
 }
@@ -3968,6 +3967,16 @@ int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id)
 	return 0;
 }
 
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id)
+{
+	struct xhci_virt_device *vdev = xhci->devs[slot_id];
+	int ret;
+
+	ret = xhci_disable_slot(xhci, slot_id);
+	xhci_free_virt_device(xhci, vdev, slot_id);
+	return ret;
+}
+
 /*
  * Checks if we have enough host controller resources for the default control
  * endpoint.
@@ -4074,8 +4083,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;
 
 disable_slot:
-	xhci_disable_slot(xhci, udev->slot_id);
-	xhci_free_virt_device(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, udev->slot_id);
 
 	return 0;
 }
@@ -4211,8 +4219,7 @@ static int xhci_setup_device(struct usb_hcd *hcd, struct usb_device *udev,
 		dev_warn(&udev->dev, "Device not responding to setup %s.\n", act);
 
 		mutex_unlock(&xhci->mutex);
-		ret = xhci_disable_slot(xhci, udev->slot_id);
-		xhci_free_virt_device(xhci, udev->slot_id);
+		ret = xhci_disable_and_free_slot(xhci, udev->slot_id);
 		if (!ret) {
 			if (xhci_alloc_dev(hcd, udev) == 1)
 				xhci_setup_addressable_virt_dev(xhci, udev);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 11580495e09c..67ee2e049943 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1774,7 +1774,7 @@ void xhci_dbg_trace(struct xhci_hcd *xhci, void (*trace)(struct va_format *),
 /* xHCI memory management */
 void xhci_mem_cleanup(struct xhci_hcd *xhci);
 int xhci_mem_init(struct xhci_hcd *xhci, gfp_t flags);
-void xhci_free_virt_device(struct xhci_hcd *xhci, int slot_id);
+void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev, int slot_id);
 int xhci_alloc_virt_device(struct xhci_hcd *xhci, int slot_id, struct usb_device *udev, gfp_t flags);
 int xhci_setup_addressable_virt_dev(struct xhci_hcd *xhci, struct usb_device *udev);
 void xhci_copy_ep0_dequeue_into_input_ctx(struct xhci_hcd *xhci,
@@ -1866,6 +1866,7 @@ void xhci_reset_bandwidth(struct usb_hcd *hcd, struct usb_device *udev);
 int xhci_update_hub_device(struct usb_hcd *hcd, struct usb_device *hdev,
 			   struct usb_tt *tt, gfp_t mem_flags);
 int xhci_disable_slot(struct xhci_hcd *xhci, u32 slot_id);
+int xhci_disable_and_free_slot(struct xhci_hcd *xhci, u32 slot_id);
 int xhci_ext_cap_init(struct xhci_hcd *xhci);
 
 int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup);
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index b4a4c1df4e0d..a4668c6d575d 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -400,7 +400,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	ret = platform_device_add_resources(musb, pdev->resource, pdev->num_resources);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add resources\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	if (populate_irqs) {
@@ -413,7 +413,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!res) {
 			ret = -EINVAL;
-			goto err2;
+			goto err_put_control_otghs;
 		}
 
 		musb_res[i].start = res->start;
@@ -441,14 +441,14 @@ static int omap2430_probe(struct platform_device *pdev)
 		ret = platform_device_add_resources(musb, musb_res, i);
 		if (ret) {
 			dev_err(&pdev->dev, "failed to add IRQ resources\n");
-			goto err2;
+			goto err_put_control_otghs;
 		}
 	}
 
 	ret = platform_device_add_data(musb, pdata, sizeof(*pdata));
 	if (ret) {
 		dev_err(&pdev->dev, "failed to add platform_data\n");
-		goto err2;
+		goto err_put_control_otghs;
 	}
 
 	pm_runtime_enable(glue->dev);
@@ -463,7 +463,9 @@ static int omap2430_probe(struct platform_device *pdev)
 
 err3:
 	pm_runtime_disable(glue->dev);
-
+err_put_control_otghs:
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 err2:
 	platform_device_put(musb);
 
@@ -477,6 +479,8 @@ static void omap2430_remove(struct platform_device *pdev)
 
 	platform_device_unregister(glue->musb);
 	pm_runtime_disable(glue->dev);
+	if (!IS_ERR(glue->control_otghs))
+		put_device(glue->control_otghs);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/usb/storage/realtek_cr.c b/drivers/usb/storage/realtek_cr.c
index 0c423916d7bf..a026c6cb6e68 100644
--- a/drivers/usb/storage/realtek_cr.c
+++ b/drivers/usb/storage/realtek_cr.c
@@ -252,7 +252,7 @@ static int rts51x_bulk_transport(struct us_data *us, u8 lun,
 		return USB_STOR_TRANSPORT_ERROR;
 	}
 
-	residue = bcs->Residue;
+	residue = le32_to_cpu(bcs->Residue);
 	if (bcs->Tag != us->tag)
 		return USB_STOR_TRANSPORT_ERROR;
 
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
index 54f0b1c83317..dfa5276a5a43 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -934,6 +934,13 @@ UNUSUAL_DEV(  0x05e3, 0x0723, 0x9451, 0x9451,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_SANE_SENSE ),
 
+/* Added by Maël GUERIN <mael.guerin@murena.io> */
+UNUSUAL_DEV(  0x0603, 0x8611, 0x0000, 0xffff,
+		"Novatek",
+		"NTK96550-based camera",
+		USB_SC_SCSI, USB_PR_BULK, NULL,
+		US_FL_BULK_IGNORE_TAG ),
+
 /*
  * Reported by Hanno Boeck <hanno@gmx.de>
  * Taken from the Lycoris Kernel
@@ -1494,6 +1501,28 @@ UNUSUAL_DEV( 0x0bc2, 0x3332, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_WP_DETECT ),
 
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0x1a2b, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
+/*
+ * Reported by Zenm Chen <zenmchen@gmail.com>
+ * Ignore driver CD mode, otherwise usb_modeswitch may fail to switch
+ * the device into Wi-Fi mode.
+ */
+UNUSUAL_DEV( 0x0bda, 0xa192, 0x0000, 0xffff,
+		"Realtek",
+		"DISK",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE ),
+
 UNUSUAL_DEV(  0x0d49, 0x7310, 0x0000, 0x9999,
 		"Maxtor",
 		"USB to SATA",
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 5c75634b8fa3..c9c3dea8ba07 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/usb/typec_retimer.h>
@@ -354,7 +355,7 @@ active_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct typec_altmode *alt = to_typec_altmode(dev);
 
-	return sprintf(buf, "%s\n", alt->active ? "yes" : "no");
+	return sprintf(buf, "%s\n", str_yes_no(alt->active));
 }
 
 static ssize_t active_store(struct device *dev, struct device_attribute *attr,
@@ -630,7 +631,7 @@ static ssize_t supports_usb_power_delivery_show(struct device *dev,
 {
 	struct typec_partner *p = to_typec_partner(dev);
 
-	return sprintf(buf, "%s\n", p->usb_pd ? "yes" : "no");
+	return sprintf(buf, "%s\n", str_yes_no(p->usb_pd));
 }
 static DEVICE_ATTR_RO(supports_usb_power_delivery);
 
@@ -1688,7 +1689,7 @@ static ssize_t vconn_source_show(struct device *dev,
 	struct typec_port *port = to_typec_port(dev);
 
 	return sprintf(buf, "%s\n",
-		       port->vconn_role == TYPEC_SOURCE ? "yes" : "no");
+		       str_yes_no(port->vconn_role == TYPEC_SOURCE));
 }
 static DEVICE_ATTR_RW(vconn_source);
 
diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index e2fe479e16ad..870a71f953f6 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 #include <linux/usb.h>
 #include <linux/usb/typec.h>
@@ -103,6 +104,7 @@ struct fusb302_chip {
 	bool vconn_on;
 	bool vbus_on;
 	bool charge_on;
+	bool pd_rx_on;
 	bool vbus_present;
 	enum typec_cc_polarity cc_polarity;
 	enum typec_cc_status cc1;
@@ -733,7 +735,7 @@ static int tcpm_set_vconn(struct tcpc_dev *dev, bool on)
 
 	mutex_lock(&chip->lock);
 	if (chip->vconn_on == on) {
-		fusb302_log(chip, "vconn is already %s", on ? "On" : "Off");
+		fusb302_log(chip, "vconn is already %s", str_on_off(on));
 		goto done;
 	}
 	if (on) {
@@ -746,7 +748,7 @@ static int tcpm_set_vconn(struct tcpc_dev *dev, bool on)
 	if (ret < 0)
 		goto done;
 	chip->vconn_on = on;
-	fusb302_log(chip, "vconn := %s", on ? "On" : "Off");
+	fusb302_log(chip, "vconn := %s", str_on_off(on));
 done:
 	mutex_unlock(&chip->lock);
 
@@ -761,7 +763,7 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 
 	mutex_lock(&chip->lock);
 	if (chip->vbus_on == on) {
-		fusb302_log(chip, "vbus is already %s", on ? "On" : "Off");
+		fusb302_log(chip, "vbus is already %s", str_on_off(on));
 	} else {
 		if (on)
 			ret = regulator_enable(chip->vbus);
@@ -769,15 +771,14 @@ static int tcpm_set_vbus(struct tcpc_dev *dev, bool on, bool charge)
 			ret = regulator_disable(chip->vbus);
 		if (ret < 0) {
 			fusb302_log(chip, "cannot %s vbus regulator, ret=%d",
-				    on ? "enable" : "disable", ret);
+				    str_enable_disable(on), ret);
 			goto done;
 		}
 		chip->vbus_on = on;
-		fusb302_log(chip, "vbus := %s", on ? "On" : "Off");
+		fusb302_log(chip, "vbus := %s", str_on_off(on));
 	}
 	if (chip->charge_on == charge)
-		fusb302_log(chip, "charge is already %s",
-			    charge ? "On" : "Off");
+		fusb302_log(chip, "charge is already %s", str_on_off(charge));
 	else
 		chip->charge_on = charge;
 
@@ -841,6 +842,11 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 	int ret = 0;
 
 	mutex_lock(&chip->lock);
+	if (chip->pd_rx_on == on) {
+		fusb302_log(chip, "pd is already %s", str_on_off(on));
+		goto done;
+	}
+
 	ret = fusb302_pd_rx_flush(chip);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
@@ -854,16 +860,18 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 	ret = fusb302_pd_set_auto_goodcrc(chip, on);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot turn %s auto GCRC, ret=%d",
-			    on ? "on" : "off", ret);
+			    str_on_off(on), ret);
 		goto done;
 	}
 	ret = fusb302_pd_set_interrupts(chip, on);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot turn %s pd interrupts, ret=%d",
-			    on ? "on" : "off", ret);
+			    str_on_off(on), ret);
 		goto done;
 	}
-	fusb302_log(chip, "pd := %s", on ? "on" : "off");
+
+	chip->pd_rx_on = on;
+	fusb302_log(chip, "pd := %s", str_on_off(on));
 done:
 	mutex_unlock(&chip->lock);
 
@@ -1531,7 +1539,7 @@ static void fusb302_irq_work(struct work_struct *work)
 	if (interrupt & FUSB_REG_INTERRUPT_VBUSOK) {
 		vbus_present = !!(status0 & FUSB_REG_STATUS0_VBUSOK);
 		fusb302_log(chip, "IRQ: VBUS_OK, vbus=%s",
-			    vbus_present ? "On" : "Off");
+			    str_on_off(vbus_present));
 		if (vbus_present != chip->vbus_present) {
 			chip->vbus_present = vbus_present;
 			tcpm_vbus_change(chip->tcpm_port);
@@ -1562,7 +1570,7 @@ static void fusb302_irq_work(struct work_struct *work)
 	if ((interrupt & FUSB_REG_INTERRUPT_COMP_CHNG) && intr_comp_chng) {
 		comp_result = !!(status0 & FUSB_REG_STATUS0_COMP);
 		fusb302_log(chip, "IRQ: COMP_CHNG, comp=%s",
-			    comp_result ? "true" : "false");
+			    str_true_false(comp_result));
 		if (comp_result) {
 			/* cc level > Rd_threshold, detach */
 			chip->cc1 = TYPEC_CC_OPEN;
diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 0cdda06592fd..af8da6dc60ae 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -188,6 +188,11 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
 	if (ret < 0)
 		return ret;
 
+	/* Disable low power mode */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+				 FIELD_PREP(CCLPMODESEL,
+					    LOW_POWER_MODE_DISABLE));
+
 	/* Sleep to allow comparators settle */
 	usleep_range(5000, 6000);
 	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_ORIENTATION, PLUG_ORNT_CC1);
@@ -324,6 +329,39 @@ static int max_contaminant_enable_dry_detection(struct max_tcpci_chip *chip)
 	return 0;
 }
 
+static int max_contaminant_enable_toggling(struct max_tcpci_chip *chip)
+{
+	struct regmap *regmap = chip->data.regmap;
+	int ret;
+
+	/* Disable dry detection if enabled. */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+				 FIELD_PREP(CCLPMODESEL,
+					    LOW_POWER_MODE_DISABLE));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL1, CCCONNDRY, 0);
+	if (ret)
+		return ret;
+
+	ret = max_tcpci_write8(chip, TCPC_ROLE_CTRL, TCPC_ROLE_CTRL_DRP |
+			       FIELD_PREP(TCPC_ROLE_CTRL_CC1,
+					  TCPC_ROLE_CTRL_CC_RD) |
+			       FIELD_PREP(TCPC_ROLE_CTRL_CC2,
+					  TCPC_ROLE_CTRL_CC_RD));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL,
+				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT,
+				 TCPC_TCPC_CTRL_EN_LK4CONN_ALRT);
+	if (ret)
+		return ret;
+
+	return max_tcpci_write8(chip, TCPC_COMMAND, TCPC_CMD_LOOK4CONNECTION);
+}
+
 bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect_while_debounce,
 				    bool *cc_handled)
 {
@@ -340,6 +378,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 	if (ret < 0)
 		return false;
 
+	if (cc_status & TCPC_CC_STATUS_TOGGLING) {
+		if (chip->contaminant_state == DETECTED)
+			return true;
+		return false;
+	}
+
 	if (chip->contaminant_state == NOT_DETECTED || chip->contaminant_state == SINK) {
 		if (!disconnect_while_debounce)
 			msleep(100);
@@ -372,6 +416,12 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 				max_contaminant_enable_dry_detection(chip);
 				return true;
 			}
+
+			ret = max_contaminant_enable_toggling(chip);
+			if (ret)
+				dev_err(chip->dev,
+					"Failed to enable toggling, ret=%d",
+					ret);
 		}
 	} else if (chip->contaminant_state == DETECTED) {
 		if (!(cc_status & TCPC_CC_STATUS_TOGGLING)) {
@@ -379,6 +429,14 @@ bool max_contaminant_is_contaminant(struct max_tcpci_chip *chip, bool disconnect
 			if (chip->contaminant_state == DETECTED) {
 				max_contaminant_enable_dry_detection(chip);
 				return true;
+			} else {
+				ret = max_contaminant_enable_toggling(chip);
+				if (ret) {
+					dev_err(chip->dev,
+						"Failed to enable toggling, ret=%d",
+						ret);
+					return true;
+				}
 			}
 		}
 	}
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index 726423684bae..18303b34594b 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/tcpm.h>
 #include "qcom_pmic_typec.h"
@@ -418,7 +419,7 @@ static int qcom_pmic_typec_pdphy_set_pd_rx(struct tcpc_dev *tcpc, bool on)
 
 	spin_unlock_irqrestore(&pmic_typec_pdphy->lock, flags);
 
-	dev_dbg(pmic_typec_pdphy->dev, "set_pd_rx: %s\n", on ? "on" : "off");
+	dev_dbg(pmic_typec_pdphy->dev, "set_pd_rx: %s\n", str_on_off(on));
 
 	return ret;
 }
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
index df79059cda67..8fac171778da 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/tcpm.h>
 #include "qcom_pmic_typec.h"
@@ -38,7 +39,7 @@ static int qcom_pmic_typec_pdphy_stub_set_pd_rx(struct tcpc_dev *tcpc, bool on)
 	struct pmic_typec *tcpm = tcpc_to_tcpm(tcpc);
 	struct device *dev = tcpm->dev;
 
-	dev_dbg(dev, "set_pd_rx: %s\n", on ? "on" : "off");
+	dev_dbg(dev, "set_pd_rx: %s\n", str_on_off(on));
 
 	return 0;
 }
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
index c37dede62e12..4fc83dcfae64 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
@@ -13,6 +13,7 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/usb/tcpm.h>
 #include <linux/usb/typec_mux.h>
 #include <linux/workqueue.h>
@@ -562,7 +563,8 @@ static int qcom_pmic_typec_port_set_vconn(struct tcpc_dev *tcpc, bool on)
 	spin_unlock_irqrestore(&pmic_typec_port->lock, flags);
 
 	dev_dbg(dev, "set_vconn: orientation %d control 0x%08x state %s cc %s vconn %s\n",
-		orientation, value, on ? "on" : "off", misc_to_vconn(misc), misc_to_cc(misc));
+		orientation, value, str_on_off(on), misc_to_vconn(misc),
+		misc_to_cc(misc));
 
 	return ret;
 }
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 76270d5c2838..b33540a42a95 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -21,6 +21,7 @@
 #define CCOVPDIS                                BIT(6)
 #define SBURPCTRL                               BIT(5)
 #define CCLPMODESEL                             GENMASK(4, 3)
+#define LOW_POWER_MODE_DISABLE                  0
 #define ULTRA_LOW_POWER_MODE                    1
 #define CCRPCTRL                                GENMASK(2, 0)
 #define UA_1_SRC                                1
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index aa2fa720af15..43e3dac5129f 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -21,6 +21,7 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/string_choices.h>
 #include <linux/usb.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/pd_ado.h>
@@ -874,8 +875,8 @@ static int tcpm_enable_auto_vbus_discharge(struct tcpm_port *port, bool enable)
 
 	if (port->tcpc->enable_auto_vbus_discharge) {
 		ret = port->tcpc->enable_auto_vbus_discharge(port->tcpc, enable);
-		tcpm_log_force(port, "%s vbus discharge ret:%d", enable ? "enable" : "disable",
-			       ret);
+		tcpm_log_force(port, "%s vbus discharge ret:%d",
+			       str_enable_disable(enable), ret);
 		if (!ret)
 			port->auto_vbus_discharge_enabled = enable;
 	}
@@ -4429,7 +4430,7 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
 static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capable)
 {
-	tcpm_log(port, "Setting usb_comm capable %s", capable ? "true" : "false");
+	tcpm_log(port, "Setting usb_comm capable %s", str_true_false(capable));
 
 	if (port->tcpc->set_partner_usb_comm_capable)
 		port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 802153e23073..66a0f060770e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -344,6 +344,9 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 
 	len = iov_length(vq->iov, out);
 
+	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
+		return NULL;
+
 	/* len contains both payload and hdr */
 	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
 	if (!skb)
@@ -367,8 +370,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return skb;
 
 	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
-	    payload_len + sizeof(*hdr) > len) {
+	if (payload_len + sizeof(*hdr) > len) {
 		kfree_skb(skb);
 		return NULL;
 	}
diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index f9cdbf8c53e3..37bd18730fe0 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1168,7 +1168,7 @@ static bool vgacon_scroll(struct vc_data *c, unsigned int t, unsigned int b,
 				     c->vc_screenbuf_size - delta);
 			c->vc_origin = vga_vram_end - c->vc_screenbuf_size;
 			vga_rolled_over = 0;
-		} else if (oldo - delta >= (unsigned long)c->vc_screenbuf)
+		} else
 			c->vc_origin -= delta;
 		c->vc_scr_end = c->vc_origin + c->vc_screenbuf_size;
 		scr_memsetw((u16 *) (c->vc_origin), c->vc_video_erase_char,
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 7eef79ece5b3..83a196521670 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1481,6 +1481,32 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 	return ret == 0;
 }
 
+/*
+ * Link the block_group to a list via bg_list.
+ *
+ * @bg:       The block_group to link to the list.
+ * @list:     The list to link it to.
+ *
+ * Use this rather than list_add_tail() directly to ensure proper respect
+ * to locking and refcounting.
+ *
+ * Returns: true if the bg was linked with a refcount bump and false otherwise.
+ */
+static bool btrfs_link_bg_list(struct btrfs_block_group *bg, struct list_head *list)
+{
+	struct btrfs_fs_info *fs_info = bg->fs_info;
+	bool added = false;
+
+	spin_lock(&fs_info->unused_bgs_lock);
+	if (list_empty(&bg->bg_list)) {
+		btrfs_get_block_group(bg);
+		list_add_tail(&bg->bg_list, list);
+		added = true;
+	}
+	spin_unlock(&fs_info->unused_bgs_lock);
+	return added;
+}
+
 /*
  * Process the unused_bgs list and remove any that don't have any allocated
  * space inside of them.
@@ -1597,8 +1623,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 			 * drop under the "next" label for the
 			 * fs_info->unused_bgs list.
 			 */
-			btrfs_get_block_group(block_group);
-			list_add_tail(&block_group->bg_list, &retry_list);
+			btrfs_link_bg_list(block_group, &retry_list);
 
 			trace_btrfs_skip_unused_block_group(block_group);
 			spin_unlock(&block_group->lock);
@@ -1621,8 +1646,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		ret = btrfs_zone_finish(block_group);
 		if (ret < 0) {
 			btrfs_dec_block_group_ro(block_group);
-			if (ret == -EAGAIN)
+			if (ret == -EAGAIN) {
+				btrfs_link_bg_list(block_group, &retry_list);
 				ret = 0;
+			}
 			goto next;
 		}
 
@@ -1971,20 +1998,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 		spin_unlock(&space_info->lock);
 
 next:
-		if (ret && !READ_ONCE(space_info->periodic_reclaim)) {
-			/* Refcount held by the reclaim_bgs list after splice. */
-			spin_lock(&fs_info->unused_bgs_lock);
-			/*
-			 * This block group might be added to the unused list
-			 * during the above process. Move it back to the
-			 * reclaim list otherwise.
-			 */
-			if (list_empty(&bg->bg_list)) {
-				btrfs_get_block_group(bg);
-				list_add_tail(&bg->bg_list, &retry_list);
-			}
-			spin_unlock(&fs_info->unused_bgs_lock);
-		}
+		if (ret && !READ_ONCE(space_info->periodic_reclaim))
+			btrfs_link_bg_list(bg, &retry_list);
 		btrfs_put_block_group(bg);
 
 		mutex_unlock(&fs_info->reclaim_bgs_lock);
@@ -2024,13 +2039,8 @@ void btrfs_mark_bg_to_reclaim(struct btrfs_block_group *bg)
 {
 	struct btrfs_fs_info *fs_info = bg->fs_info;
 
-	spin_lock(&fs_info->unused_bgs_lock);
-	if (list_empty(&bg->bg_list)) {
-		btrfs_get_block_group(bg);
+	if (btrfs_link_bg_list(bg, &fs_info->reclaim_bgs))
 		trace_btrfs_add_reclaim_block_group(bg);
-		list_add_tail(&bg->bg_list, &fs_info->reclaim_bgs);
-	}
-	spin_unlock(&fs_info->unused_bgs_lock);
 }
 
 static int read_bg_from_eb(struct btrfs_fs_info *fs_info, const struct btrfs_key *key,
@@ -2807,6 +2817,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
 		spin_lock(&fs_info->unused_bgs_lock);
 		list_del_init(&block_group->bg_list);
 		clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
+		btrfs_put_block_group(block_group);
 		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
@@ -2945,7 +2956,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	}
 #endif
 
-	list_add_tail(&cache->bg_list, &trans->new_bgs);
+	btrfs_link_bg_list(cache, &trans->new_bgs);
 	btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
 
 	set_avail_alloc_bits(fs_info, type);
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3ba15d9c3e88..81735d19feff 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -350,7 +350,14 @@ int btrfs_copy_root(struct btrfs_trans_handle *trans,
 
 	write_extent_buffer_fsid(cow, fs_info->fs_devices->metadata_uuid);
 
-	WARN_ON(btrfs_header_generation(buf) > trans->transid);
+	if (unlikely(btrfs_header_generation(buf) > trans->transid)) {
+		btrfs_tree_unlock(cow);
+		free_extent_buffer(cow);
+		ret = -EUCLEAN;
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
 	if (new_root_objectid == BTRFS_TREE_RELOC_OBJECTID)
 		ret = btrfs_inc_ref(trans, root, cow, 1);
 	else
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 308abbf8855b..51f286d5d00a 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -1379,12 +1379,17 @@ static int __add_block_group_free_space(struct btrfs_trans_handle *trans,
 	clear_bit(BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE, &block_group->runtime_flags);
 
 	ret = add_new_free_space_info(trans, block_group, path);
-	if (ret)
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
 		return ret;
+	}
+
+	ret = __add_to_free_space_tree(trans, block_group, path,
+				       block_group->start, block_group->length);
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
 
-	return __add_to_free_space_tree(trans, block_group, path,
-					block_group->start,
-					block_group->length);
+	return 0;
 }
 
 int add_block_group_free_space(struct btrfs_trans_handle *trans,
@@ -1404,16 +1409,14 @@ int add_block_group_free_space(struct btrfs_trans_handle *trans,
 	path = btrfs_alloc_path();
 	if (!path) {
 		ret = -ENOMEM;
+		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
 
 	ret = __add_block_group_free_space(trans, block_group, path);
-
 out:
 	btrfs_free_path(path);
 	mutex_unlock(&block_group->free_space_lock);
-	if (ret)
-		btrfs_abort_transaction(trans, ret);
 	return ret;
 }
 
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 6b181bf9f156..530a2bab6ada 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -226,8 +226,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	return qgroup;
 }
 
-static void __del_qgroup_rb(struct btrfs_fs_info *fs_info,
-			    struct btrfs_qgroup *qgroup)
+static void __del_qgroup_rb(struct btrfs_qgroup *qgroup)
 {
 	struct btrfs_qgroup_list *list;
 
@@ -258,7 +257,7 @@ static int del_qgroup_rb(struct btrfs_fs_info *fs_info, u64 qgroupid)
 		return -ENOENT;
 
 	rb_erase(&qgroup->node, &fs_info->qgroup_tree);
-	__del_qgroup_rb(fs_info, qgroup);
+	__del_qgroup_rb(qgroup);
 	return 0;
 }
 
@@ -631,22 +630,30 @@ bool btrfs_check_quota_leak(const struct btrfs_fs_info *fs_info)
 
 /*
  * This is called from close_ctree() or open_ctree() or btrfs_quota_disable(),
- * first two are in single-threaded paths.And for the third one, we have set
- * quota_root to be null with qgroup_lock held before, so it is safe to clean
- * up the in-memory structures without qgroup_lock held.
+ * first two are in single-threaded paths.
  */
 void btrfs_free_qgroup_config(struct btrfs_fs_info *fs_info)
 {
 	struct rb_node *n;
 	struct btrfs_qgroup *qgroup;
 
+	/*
+	 * btrfs_quota_disable() can be called concurrently with
+	 * btrfs_qgroup_rescan() -> qgroup_rescan_zero_tracking(), so take the
+	 * lock.
+	 */
+	spin_lock(&fs_info->qgroup_lock);
 	while ((n = rb_first(&fs_info->qgroup_tree))) {
 		qgroup = rb_entry(n, struct btrfs_qgroup, node);
 		rb_erase(n, &fs_info->qgroup_tree);
-		__del_qgroup_rb(fs_info, qgroup);
+		__del_qgroup_rb(qgroup);
+		spin_unlock(&fs_info->qgroup_lock);
 		btrfs_sysfs_del_one_qgroup(fs_info, qgroup);
 		kfree(qgroup);
+		spin_lock(&fs_info->qgroup_lock);
 	}
+	spin_unlock(&fs_info->qgroup_lock);
+
 	/*
 	 * We call btrfs_free_qgroup_config() when unmounting
 	 * filesystem and disabling quota, so we set qgroup_ulist
@@ -4057,12 +4064,21 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	qgroup_rescan_zero_tracking(fs_info);
 
 	mutex_lock(&fs_info->qgroup_rescan_lock);
-	fs_info->qgroup_rescan_running = true;
-	btrfs_queue_work(fs_info->qgroup_rescan_workers,
-			 &fs_info->qgroup_rescan_work);
+	/*
+	 * The rescan worker is only for full accounting qgroups, check if it's
+	 * enabled as it is pointless to queue it otherwise. A concurrent quota
+	 * disable may also have just cleared BTRFS_FS_QUOTA_ENABLED.
+	 */
+	if (btrfs_qgroup_full_accounting(fs_info)) {
+		fs_info->qgroup_rescan_running = true;
+		btrfs_queue_work(fs_info->qgroup_rescan_workers,
+				 &fs_info->qgroup_rescan_work);
+	} else {
+		ret = -ENOTCONN;
+	}
 	mutex_unlock(&fs_info->qgroup_rescan_lock);
 
-	return 0;
+	return ret;
 }
 
 int btrfs_qgroup_wait_for_completion(struct btrfs_fs_info *fs_info,
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index c843b4aefb8a..41b7cbd07025 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/bsearch.h>
+#include <linux/falloc.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/sort.h>
@@ -178,6 +179,7 @@ struct send_ctx {
 	u64 cur_inode_rdev;
 	u64 cur_inode_last_extent;
 	u64 cur_inode_next_write_offset;
+	struct fs_path cur_inode_path;
 	bool cur_inode_new;
 	bool cur_inode_new_gen;
 	bool cur_inode_deleted;
@@ -436,6 +438,14 @@ static void fs_path_reset(struct fs_path *p)
 	}
 }
 
+static void init_path(struct fs_path *p)
+{
+	p->reversed = 0;
+	p->buf = p->inline_buf;
+	p->buf_len = FS_PATH_INLINE_SIZE;
+	fs_path_reset(p);
+}
+
 static struct fs_path *fs_path_alloc(void)
 {
 	struct fs_path *p;
@@ -443,10 +453,7 @@ static struct fs_path *fs_path_alloc(void)
 	p = kmalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
 		return NULL;
-	p->reversed = 0;
-	p->buf = p->inline_buf;
-	p->buf_len = FS_PATH_INLINE_SIZE;
-	fs_path_reset(p);
+	init_path(p);
 	return p;
 }
 
@@ -471,7 +478,7 @@ static void fs_path_free(struct fs_path *p)
 	kfree(p);
 }
 
-static int fs_path_len(struct fs_path *p)
+static inline int fs_path_len(const struct fs_path *p)
 {
 	return p->end - p->start;
 }
@@ -624,6 +631,14 @@ static void fs_path_unreverse(struct fs_path *p)
 	p->reversed = 0;
 }
 
+static inline bool is_current_inode_path(const struct send_ctx *sctx,
+					 const struct fs_path *path)
+{
+	const struct fs_path *cur = &sctx->cur_inode_path;
+
+	return (strncmp(path->start, cur->start, fs_path_len(cur)) == 0);
+}
+
 static struct btrfs_path *alloc_path_for_send(void)
 {
 	struct btrfs_path *path;
@@ -2450,6 +2465,14 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 	u64 parent_inode = 0;
 	u64 parent_gen = 0;
 	int stop = 0;
+	const bool is_cur_inode = (ino == sctx->cur_ino && gen == sctx->cur_inode_gen);
+
+	if (is_cur_inode && fs_path_len(&sctx->cur_inode_path) > 0) {
+		if (dest != &sctx->cur_inode_path)
+			return fs_path_copy(dest, &sctx->cur_inode_path);
+
+		return 0;
+	}
 
 	name = fs_path_alloc();
 	if (!name) {
@@ -2501,8 +2524,12 @@ static int get_cur_path(struct send_ctx *sctx, u64 ino, u64 gen,
 
 out:
 	fs_path_free(name);
-	if (!ret)
+	if (!ret) {
 		fs_path_unreverse(dest);
+		if (is_cur_inode && dest != &sctx->cur_inode_path)
+			ret = fs_path_copy(&sctx->cur_inode_path, dest);
+	}
+
 	return ret;
 }
 
@@ -2597,6 +2624,47 @@ static int send_subvol_begin(struct send_ctx *sctx)
 	return ret;
 }
 
+static struct fs_path *get_cur_inode_path(struct send_ctx *sctx)
+{
+	if (fs_path_len(&sctx->cur_inode_path) == 0) {
+		int ret;
+
+		ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen,
+				   &sctx->cur_inode_path);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
+	return &sctx->cur_inode_path;
+}
+
+static struct fs_path *get_path_for_command(struct send_ctx *sctx, u64 ino, u64 gen)
+{
+	struct fs_path *path;
+	int ret;
+
+	if (ino == sctx->cur_ino && gen == sctx->cur_inode_gen)
+		return get_cur_inode_path(sctx);
+
+	path = fs_path_alloc();
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	ret = get_cur_path(sctx, ino, gen, path);
+	if (ret < 0) {
+		fs_path_free(path);
+		return ERR_PTR(ret);
+	}
+
+	return path;
+}
+
+static void free_path_for_command(const struct send_ctx *sctx, struct fs_path *path)
+{
+	if (path != &sctx->cur_inode_path)
+		fs_path_free(path);
+}
+
 static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 {
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
@@ -2605,17 +2673,14 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
 	btrfs_debug(fs_info, "send_truncate %llu size=%llu", ino, size);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_TRUNCATE);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, size);
 
@@ -2623,7 +2688,7 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2635,17 +2700,14 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
 	btrfs_debug(fs_info, "send_chmod %llu mode=%llu", ino, mode);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_CHMOD);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_MODE, mode & 07777);
 
@@ -2653,7 +2715,7 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2668,17 +2730,14 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
 	btrfs_debug(fs_info, "send_fileattr %llu fileattr=%llu", ino, fileattr);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_FILEATTR);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILEATTR, fileattr);
 
@@ -2686,7 +2745,7 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2699,17 +2758,14 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 	btrfs_debug(fs_info, "send_chown %llu uid=%llu, gid=%llu",
 		    ino, uid, gid);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_CHOWN);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UID, uid);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_GID, gid);
@@ -2718,7 +2774,7 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2735,9 +2791,9 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 	btrfs_debug(fs_info, "send_utimes %llu", ino);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	path = alloc_path_for_send();
 	if (!path) {
@@ -2762,9 +2818,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
@@ -2776,7 +2829,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -3112,6 +3165,11 @@ static int orphanize_inode(struct send_ctx *sctx, u64 ino, u64 gen,
 		goto out;
 
 	ret = send_rename(sctx, path, orphan);
+	if (ret < 0)
+		goto out;
+
+	if (ino == sctx->cur_ino && gen == sctx->cur_inode_gen)
+		ret = fs_path_copy(&sctx->cur_inode_path, orphan);
 
 out:
 	fs_path_free(orphan);
@@ -4165,6 +4223,23 @@ static int refresh_ref_path(struct send_ctx *sctx, struct recorded_ref *ref)
 	return ret;
 }
 
+static int rename_current_inode(struct send_ctx *sctx,
+				struct fs_path *current_path,
+				struct fs_path *new_path)
+{
+	int ret;
+
+	ret = send_rename(sctx, current_path, new_path);
+	if (ret < 0)
+		return ret;
+
+	ret = fs_path_copy(&sctx->cur_inode_path, new_path);
+	if (ret < 0)
+		return ret;
+
+	return fs_path_copy(current_path, new_path);
+}
+
 /*
  * This does all the move/link/unlink/rmdir magic.
  */
@@ -4179,9 +4254,9 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 	u64 ow_inode = 0;
 	u64 ow_gen;
 	u64 ow_mode;
-	int did_overwrite = 0;
-	int is_orphan = 0;
 	u64 last_dir_ino_rm = 0;
+	bool did_overwrite = false;
+	bool is_orphan = false;
 	bool can_rename = true;
 	bool orphanized_dir = false;
 	bool orphanized_ancestor = false;
@@ -4223,14 +4298,14 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		if (ret < 0)
 			goto out;
 		if (ret)
-			did_overwrite = 1;
+			did_overwrite = true;
 	}
 	if (sctx->cur_inode_new || did_overwrite) {
 		ret = gen_unique_name(sctx, sctx->cur_ino,
 				sctx->cur_inode_gen, valid_path);
 		if (ret < 0)
 			goto out;
-		is_orphan = 1;
+		is_orphan = true;
 	} else {
 		ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen,
 				valid_path);
@@ -4355,6 +4430,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				if (ret > 0) {
 					orphanized_ancestor = true;
 					fs_path_reset(valid_path);
+					fs_path_reset(&sctx->cur_inode_path);
 					ret = get_cur_path(sctx, sctx->cur_ino,
 							   sctx->cur_inode_gen,
 							   valid_path);
@@ -4450,13 +4526,10 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 		 * it depending on the inode mode.
 		 */
 		if (is_orphan && can_rename) {
-			ret = send_rename(sctx, valid_path, cur->full_path);
-			if (ret < 0)
-				goto out;
-			is_orphan = 0;
-			ret = fs_path_copy(valid_path, cur->full_path);
+			ret = rename_current_inode(sctx, valid_path, cur->full_path);
 			if (ret < 0)
 				goto out;
+			is_orphan = false;
 		} else if (can_rename) {
 			if (S_ISDIR(sctx->cur_inode_mode)) {
 				/*
@@ -4464,10 +4537,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				 * dirs, we always have one new and one deleted
 				 * ref. The deleted ref is ignored later.
 				 */
-				ret = send_rename(sctx, valid_path,
-						  cur->full_path);
-				if (!ret)
-					ret = fs_path_copy(valid_path,
+				ret = rename_current_inode(sctx, valid_path,
 							   cur->full_path);
 				if (ret < 0)
 					goto out;
@@ -4514,7 +4584,7 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 					sctx->cur_inode_gen, valid_path);
 			if (ret < 0)
 				goto out;
-			is_orphan = 1;
+			is_orphan = true;
 		}
 
 		list_for_each_entry(cur, &sctx->deleted_refs, list) {
@@ -4560,6 +4630,8 @@ static int process_recorded_refs(struct send_ctx *sctx, int *pending_move)
 				ret = send_unlink(sctx, cur->full_path);
 				if (ret < 0)
 					goto out;
+				if (is_current_inode_path(sctx, cur->full_path))
+					fs_path_reset(&sctx->cur_inode_path);
 			}
 			ret = dup_ref(cur, &check_dirs);
 			if (ret < 0)
@@ -4878,11 +4950,15 @@ static int process_all_refs(struct send_ctx *sctx,
 }
 
 static int send_set_xattr(struct send_ctx *sctx,
-			  struct fs_path *path,
 			  const char *name, int name_len,
 			  const char *data, int data_len)
 {
-	int ret = 0;
+	struct fs_path *path;
+	int ret;
+
+	path = get_cur_inode_path(sctx);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_SET_XATTR);
 	if (ret < 0)
@@ -4923,19 +4999,13 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 			       const char *name, int name_len, const char *data,
 			       int data_len, void *ctx)
 {
-	int ret;
 	struct send_ctx *sctx = ctx;
-	struct fs_path *p;
 	struct posix_acl_xattr_header dummy_acl;
 
 	/* Capabilities are emitted by finish_inode_if_needed */
 	if (!strncmp(name, XATTR_NAME_CAPS, name_len))
 		return 0;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
 	/*
 	 * This hack is needed because empty acls are stored as zero byte
 	 * data in xattrs. Problem with that is, that receiving these zero byte
@@ -4952,38 +5022,21 @@ static int __process_new_xattr(int num, struct btrfs_key *di_key,
 		}
 	}
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
-	ret = send_set_xattr(sctx, p, name, name_len, data, data_len);
-
-out:
-	fs_path_free(p);
-	return ret;
+	return send_set_xattr(sctx, name, name_len, data, data_len);
 }
 
 static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
 				   const char *name, int name_len,
 				   const char *data, int data_len, void *ctx)
 {
-	int ret;
 	struct send_ctx *sctx = ctx;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
-	ret = send_remove_xattr(sctx, p, name, name_len);
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-out:
-	fs_path_free(p);
-	return ret;
+	return send_remove_xattr(sctx, p, name, name_len);
 }
 
 static int process_new_xattr(struct send_ctx *sctx)
@@ -5216,21 +5269,13 @@ static int process_verity(struct send_ctx *sctx)
 	if (ret < 0)
 		goto iput;
 
-	p = fs_path_alloc();
-	if (!p) {
-		ret = -ENOMEM;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p)) {
+		ret = PTR_ERR(p);
 		goto iput;
 	}
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto free_path;
 
 	ret = send_verity(sctx, p, sctx->verity_descriptor);
-	if (ret < 0)
-		goto free_path;
-
-free_path:
-	fs_path_free(p);
 iput:
 	iput(inode);
 	return ret;
@@ -5352,31 +5397,25 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
 	int ret = 0;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
 	btrfs_debug(fs_info, "send_write offset=%llu, len=%d", offset, len);
 
-	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
-	if (ret < 0)
-		goto out;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	ret = put_file_data(sctx, offset, len);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5389,6 +5428,7 @@ static int send_clone(struct send_ctx *sctx,
 {
 	int ret = 0;
 	struct fs_path *p;
+	struct fs_path *cur_inode_path;
 	u64 gen;
 
 	btrfs_debug(sctx->send_root->fs_info,
@@ -5396,6 +5436,10 @@ static int send_clone(struct send_ctx *sctx,
 		    offset, len, btrfs_root_id(clone_root->root),
 		    clone_root->ino, clone_root->offset);
 
+	cur_inode_path = get_cur_inode_path(sctx);
+	if (IS_ERR(cur_inode_path))
+		return PTR_ERR(cur_inode_path);
+
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -5404,13 +5448,9 @@ static int send_clone(struct send_ctx *sctx,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_CLONE_LEN, len);
-	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, cur_inode_path);
 
 	if (clone_root->root == sctx->send_root) {
 		ret = get_inode_gen(sctx->send_root, clone_root->ino, &gen);
@@ -5461,27 +5501,45 @@ static int send_update_extent(struct send_ctx *sctx,
 	int ret = 0;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_UPDATE_EXTENT);
 	if (ret < 0)
-		goto out;
+		return ret;
+
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
+	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
+
+	ret = send_cmd(sctx);
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+tlv_put_failure:
+	return ret;
+}
+
+static int send_fallocate(struct send_ctx *sctx, u32 mode, u64 offset, u64 len)
+{
+	struct fs_path *path;
+	int ret;
+
+	path = get_cur_inode_path(sctx);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	ret = begin_cmd(sctx, BTRFS_SEND_C_FALLOCATE);
 	if (ret < 0)
-		goto out;
+		return ret;
 
-	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, path);
+	TLV_PUT_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, mode);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, len);
 
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5492,6 +5550,14 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	u64 offset = sctx->cur_inode_last_extent;
 	int ret = 0;
 
+	/*
+	 * Starting with send stream v2 we have fallocate and can use it to
+	 * punch holes instead of sending writes full of zeroes.
+	 */
+	if (proto_cmd_ok(sctx, BTRFS_SEND_C_FALLOCATE))
+		return send_fallocate(sctx, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				      offset, end - offset);
+
 	/*
 	 * A hole that starts at EOF or beyond it. Since we do not yet support
 	 * fallocate (for extent preallocation and hole punching), sending a
@@ -5510,12 +5576,10 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, end - offset);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto tlv_put_failure;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
 	while (offset < end) {
 		u64 len = min(end - offset, read_size);
 
@@ -5536,7 +5600,6 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	}
 	sctx->cur_inode_next_write_offset = offset;
 tlv_put_failure:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5559,9 +5622,9 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	fspath = fs_path_alloc();
-	if (!fspath) {
-		ret = -ENOMEM;
+	fspath = get_cur_inode_path(sctx);
+	if (IS_ERR(fspath)) {
+		ret = PTR_ERR(fspath);
 		goto out;
 	}
 
@@ -5569,10 +5632,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
@@ -5601,7 +5660,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
@@ -5626,9 +5684,9 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	fspath = fs_path_alloc();
-	if (!fspath) {
-		ret = -ENOMEM;
+	fspath = get_cur_inode_path(sctx);
+	if (IS_ERR(fspath)) {
+		ret = PTR_ERR(fspath);
 		goto out;
 	}
 
@@ -5636,10 +5694,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
@@ -5706,7 +5760,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
@@ -5836,7 +5889,6 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
  */
 static int send_capabilities(struct send_ctx *sctx)
 {
-	struct fs_path *fspath = NULL;
 	struct btrfs_path *path;
 	struct btrfs_dir_item *di;
 	struct extent_buffer *leaf;
@@ -5862,25 +5914,19 @@ static int send_capabilities(struct send_ctx *sctx)
 	leaf = path->nodes[0];
 	buf_len = btrfs_dir_data_len(leaf, di);
 
-	fspath = fs_path_alloc();
 	buf = kmalloc(buf_len, GFP_KERNEL);
-	if (!fspath || !buf) {
+	if (!buf) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	data_ptr = (unsigned long)(di + 1) + btrfs_dir_name_len(leaf, di);
 	read_extent_buffer(leaf, buf, data_ptr, buf_len);
 
-	ret = send_set_xattr(sctx, fspath, XATTR_NAME_CAPS,
+	ret = send_set_xattr(sctx, XATTR_NAME_CAPS,
 			strlen(XATTR_NAME_CAPS), buf, buf_len);
 out:
 	kfree(buf);
-	fs_path_free(fspath);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -6906,6 +6952,7 @@ static int changed_inode(struct send_ctx *sctx,
 	sctx->cur_inode_last_extent = (u64)-1;
 	sctx->cur_inode_next_write_offset = 0;
 	sctx->ignore_cur_inode = false;
+	fs_path_reset(&sctx->cur_inode_path);
 
 	/*
 	 * Set send_progress to current inode. This will tell all get_cur_xxx
@@ -8178,6 +8225,7 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		goto out;
 	}
 
+	init_path(&sctx->cur_inode_path);
 	INIT_LIST_HEAD(&sctx->new_refs);
 	INIT_LIST_HEAD(&sctx->deleted_refs);
 
@@ -8463,6 +8511,9 @@ long btrfs_ioctl_send(struct btrfs_inode *inode, const struct btrfs_ioctl_send_a
 		btrfs_lru_cache_clear(&sctx->dir_created_cache);
 		btrfs_lru_cache_clear(&sctx->dir_utimes_cache);
 
+		if (sctx->cur_inode_path.buf != sctx->cur_inode_path.inline_buf)
+			kfree(sctx->cur_inode_path.buf);
+
 		kfree(sctx);
 	}
 
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 88a01d51ab11..71a56aaac7ad 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -452,8 +452,25 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
 
 	spin_lock_irqsave(&subpage->lock, flags);
 	bitmap_set(subpage->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
+
+	/*
+	 * Don't clear the TOWRITE tag when starting writeback on a still-dirty
+	 * folio. Doing so can cause WB_SYNC_ALL writepages() to overlook it,
+	 * assume writeback is complete, and exit too early — violating sync
+	 * ordering guarantees.
+	 */
 	if (!folio_test_writeback(folio))
-		folio_start_writeback(folio);
+		__folio_start_writeback(folio, true);
+	if (!folio_test_dirty(folio)) {
+		struct address_space *mapping = folio_mapping(folio);
+		XA_STATE(xas, &mapping->i_pages, folio->index);
+		unsigned long flags;
+
+		xas_lock_irqsave(&xas, flags);
+		xas_load(&xas);
+		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
+		xas_unlock_irqrestore(&xas, flags);
+	}
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 6119a06b0569..69f9d5f5cc3c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -88,6 +88,9 @@ struct btrfs_fs_context {
 	refcount_t refs;
 };
 
+static void btrfs_emit_options(struct btrfs_fs_info *info,
+			       struct btrfs_fs_context *old);
+
 enum {
 	Opt_acl,
 	Opt_clear_cache,
@@ -697,12 +700,9 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
 
 	if (!test_bit(BTRFS_FS_STATE_REMOUNTING, &info->fs_state)) {
 		if (btrfs_raw_test_opt(*mount_opt, SPACE_CACHE)) {
-			btrfs_info(info, "disk space caching is enabled");
 			btrfs_warn(info,
 "space cache v1 is being deprecated and will be removed in a future release, please use -o space_cache=v2");
 		}
-		if (btrfs_raw_test_opt(*mount_opt, FREE_SPACE_TREE))
-			btrfs_info(info, "using free-space-tree");
 	}
 
 	return ret;
@@ -979,6 +979,8 @@ static int btrfs_fill_super(struct super_block *sb,
 		return err;
 	}
 
+	btrfs_emit_options(fs_info, NULL);
+
 	inode = btrfs_iget(BTRFS_FIRST_FREE_OBJECTID, fs_info->fs_root);
 	if (IS_ERR(inode)) {
 		err = PTR_ERR(inode);
@@ -1436,7 +1438,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 {
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
 	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
-	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(info, old, NODATACOW, "setting nodatacow");
 	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
 	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
 	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
@@ -1458,10 +1460,11 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, IGNOREMETACSUMS, "ignoring meta csums");
 	btrfs_info_if_set(info, old, IGNORESUPERFLAGS, "ignoring unknown super block flags");
 
+	btrfs_info_if_unset(info, old, NODATASUM, "setting datasum");
 	btrfs_info_if_unset(info, old, NODATACOW, "setting datacow");
 	btrfs_info_if_unset(info, old, SSD, "not using ssd optimizations");
 	btrfs_info_if_unset(info, old, SSD_SPREAD, "not using spread ssd allocation scheme");
-	btrfs_info_if_unset(info, old, NOBARRIER, "turning off barriers");
+	btrfs_info_if_unset(info, old, NOBARRIER, "turning on barriers");
 	btrfs_info_if_unset(info, old, NOTREELOG, "enabling tree log");
 	btrfs_info_if_unset(info, old, SPACE_CACHE, "disabling disk space caching");
 	btrfs_info_if_unset(info, old, FREE_SPACE_TREE, "disabling free space tree");
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index dbef80cd5a9f..1a029392eac5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2113,6 +2113,7 @@ static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handle *trans)
 		*/
 	       spin_lock(&fs_info->unused_bgs_lock);
                list_del_init(&block_group->bg_list);
+	       btrfs_put_block_group(block_group);
 	       spin_unlock(&fs_info->unused_bgs_lock);
        }
 }
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 53d8c49ec058..2fdb2987c83a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2092,10 +2092,15 @@ bool btrfs_zone_activate(struct btrfs_block_group *block_group)
 		goto out_unlock;
 	}
 
-	/* No space left */
-	if (btrfs_zoned_bg_is_full(block_group)) {
-		ret = false;
-		goto out_unlock;
+	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA) {
+		/* The caller should check if the block group is full. */
+		if (WARN_ON_ONCE(btrfs_zoned_bg_is_full(block_group))) {
+			ret = false;
+			goto out_unlock;
+		}
+	} else {
+		/* Since it is already written, it should have been active. */
+		WARN_ON_ONCE(block_group->meta_write_pointer != block_group->start);
 	}
 
 	for (i = 0; i < map->num_stripes; i++) {
diff --git a/fs/buffer.c b/fs/buffer.c
index e9e84512a027..79c19ffa4401 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -157,8 +157,8 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
  */
 void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
 {
-	__end_buffer_read_notouch(bh, uptodate);
 	put_bh(bh);
+	__end_buffer_read_notouch(bh, uptodate);
 }
 EXPORT_SYMBOL(end_buffer_read_sync);
 
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 66d9b3b4c588..525f3aa780cd 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -183,6 +183,9 @@ static int debugfs_reconfigure(struct fs_context *fc)
 	struct debugfs_fs_info *sb_opts = sb->s_fs_info;
 	struct debugfs_fs_info *new_opts = fc->s_fs_info;
 
+	if (!new_opts)
+		return 0;
+
 	sync_filesystem(sb);
 
 	/* structure copy of new mount options to sb */
@@ -269,10 +272,16 @@ static int debugfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int debugfs_get_tree(struct fs_context *fc)
 {
+	int err;
+
 	if (!(debugfs_allow & DEBUGFS_ALLOW_API))
 		return -EPERM;
 
-	return get_tree_single(fc, debugfs_fill_super);
+	err = get_tree_single(fc, debugfs_fill_super);
+	if (err)
+		return err;
+
+	return debugfs_reconfigure(fc);
 }
 
 static void debugfs_free_fc(struct fs_context *fc)
diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
index 383c6edea6dd..91185c40f755 100644
--- a/fs/ext4/fsmap.c
+++ b/fs/ext4/fsmap.c
@@ -393,6 +393,14 @@ static unsigned int ext4_getfsmap_find_sb(struct super_block *sb,
 	/* Reserved GDT blocks */
 	if (!ext4_has_feature_meta_bg(sb) || metagroup < first_meta_bg) {
 		len = le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks);
+
+		/*
+		 * mkfs.ext4 can set s_reserved_gdt_blocks as 0 in some cases,
+		 * check for that.
+		 */
+		if (!len)
+			return 0;
+
 		error = ext4_getfsmap_fill(meta_list, fsb, len,
 					   EXT4_FMR_OWN_RESV_GDT);
 		if (error)
@@ -526,6 +534,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 	ext4_group_t end_ag;
 	ext4_grpblk_t first_cluster;
 	ext4_grpblk_t last_cluster;
+	struct ext4_fsmap irec;
 	int error = 0;
 
 	bofs = le32_to_cpu(sbi->s_es->s_first_data_block);
@@ -609,10 +618,18 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
 			goto err;
 	}
 
-	/* Report any gaps at the end of the bg */
+	/*
+	 * The dummy record below will cause ext4_getfsmap_helper() to report
+	 * any allocated blocks at the end of the range.
+	 */
+	irec.fmr_device = 0;
+	irec.fmr_physical = end_fsb + 1;
+	irec.fmr_length = 0;
+	irec.fmr_owner = EXT4_FMR_OWN_FREE;
+	irec.fmr_flags = 0;
+
 	info->gfi_last = true;
-	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
-					     0, info);
+	error = ext4_getfsmap_helper(sb, info, &irec);
 	if (error)
 		goto err;
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 7de327fa7b1c..d45124318200 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 	int indirect_blks;
 	int blocks_to_boundary = 0;
 	int depth;
-	int count = 0;
+	u64 count = 0;
 	ext4_fsblk_t first_block = 0;
 
 	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
 		count++;
 		/* Fill in size of a hole we found */
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, count);
+		map->m_len = umin(map->m_len, count);
 		goto cleanup;
 	}
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 232131804bb8..7923602271ad 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -151,7 +151,7 @@ static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
  */
 int ext4_inode_is_fast_symlink(struct inode *inode)
 {
-	if (!(EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)) {
+	if (!ext4_has_feature_ea_inode(inode->i_sb)) {
 		int ea_blocks = EXT4_I(inode)->i_file_acl ?
 				EXT4_CLUSTER_SIZE(inode->i_sb) >> 9 : 0;
 
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index e5b47dda3317..a23b0c01f809 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -590,8 +590,9 @@ int ext4_init_orphan_info(struct super_block *sb)
 	}
 	oi->of_blocks = inode->i_size >> sb->s_blocksize_bits;
 	oi->of_csum_seed = EXT4_I(inode)->i_csum_seed;
-	oi->of_binfo = kmalloc(oi->of_blocks*sizeof(struct ext4_orphan_block),
-			       GFP_KERNEL);
+	oi->of_binfo = kmalloc_array(oi->of_blocks,
+				     sizeof(struct ext4_orphan_block),
+				     GFP_KERNEL);
 	if (!oi->of_binfo) {
 		ret = -ENOMEM;
 		goto out_put;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 99117d1e1bdd..722ac723f49b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2019,6 +2019,9 @@ int ext4_init_fs_context(struct fs_context *fc)
 	fc->fs_private = ctx;
 	fc->ops = &ext4_context_ops;
 
+	/* i_version is always enabled now */
+	fc->sb_flags |= SB_I_VERSION;
+
 	return 0;
 }
 
@@ -5277,9 +5280,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
 
-	/* i_version is always enabled now */
-	sb->s_flags |= SB_I_VERSION;
-
 	err = ext4_check_feature_compatibility(sb, es, silent);
 	if (err)
 		goto failed_mount;
@@ -5373,6 +5373,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		err = ext4_load_and_init_journal(sb, es, ctx);
 		if (err)
 			goto failed_mount3a;
+		if (bdev_read_only(sb->s_bdev))
+		    needs_recovery = 0;
 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
 		   ext4_has_feature_journal_needs_recovery(sb)) {
 		ext4_msg(sb, KERN_ERR, "required journal recovery "
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 12c76e3d1cd4..7c2787829369 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -799,6 +799,16 @@ int f2fs_get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	for (i = 1; i <= level; i++) {
 		bool done = false;
 
+		if (nids[i] && nids[i] == dn->inode->i_ino) {
+			err = -EFSCORRUPTED;
+			f2fs_err_ratelimited(sbi,
+				"inode mapping table is corrupted, run fsck to fix it, "
+				"ino:%lu, nid:%u, level:%d, offset:%d",
+				dn->inode->i_ino, nids[i], level, offset[level]);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			goto release_pages;
+		}
+
 		if (!nids[i] && mode == ALLOC_NODE) {
 			/* alloc new node */
 			if (!f2fs_alloc_nid(sbi, &(nids[i]))) {
diff --git a/fs/file.c b/fs/file.c
index 4579c3296498..bfc9eb9e7229 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -90,18 +90,11 @@ static void copy_fdtable(struct fdtable *nfdt, struct fdtable *ofdt)
  * 'unsigned long' in some places, but simply because that is how the Linux
  * kernel bitmaps are defined to work: they are not "bits in an array of bytes",
  * they are very much "bits in an array of unsigned long".
- *
- * The ALIGN(nr, BITS_PER_LONG) here is for clarity: since we just multiplied
- * by that "1024/sizeof(ptr)" before, we already know there are sufficient
- * clear low bits. Clang seems to realize that, gcc ends up being confused.
- *
- * On a 128-bit machine, the ALIGN() would actually matter. In the meantime,
- * let's consider it documentation (and maybe a test-case for gcc to improve
- * its code generation ;)
  */
-static struct fdtable * alloc_fdtable(unsigned int nr)
+static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 {
 	struct fdtable *fdt;
+	unsigned int nr;
 	void *data;
 
 	/*
@@ -109,22 +102,32 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 	 * Allocation steps are keyed to the size of the fdarray, since it
 	 * grows far faster than any of the other dynamic data. We try to fit
 	 * the fdarray into comfortable page-tuned chunks: starting at 1024B
-	 * and growing in powers of two from there on.
+	 * and growing in powers of two from there on.  Since we called only
+	 * with slots_wanted > BITS_PER_LONG (embedded instance in files->fdtab
+	 * already gives BITS_PER_LONG slots), the above boils down to
+	 * 1.  use the smallest power of two large enough to give us that many
+	 * slots.
+	 * 2.  on 32bit skip 64 and 128 - the minimal capacity we want there is
+	 * 256 slots (i.e. 1Kb fd array).
+	 * 3.  on 64bit don't skip anything, 1Kb fd array means 128 slots there
+	 * and we are never going to be asked for 64 or less.
 	 */
-	nr /= (1024 / sizeof(struct file *));
-	nr = roundup_pow_of_two(nr + 1);
-	nr *= (1024 / sizeof(struct file *));
-	nr = ALIGN(nr, BITS_PER_LONG);
+	if (IS_ENABLED(CONFIG_32BIT) && slots_wanted < 256)
+		nr = 256;
+	else
+		nr = roundup_pow_of_two(slots_wanted);
 	/*
 	 * Note that this can drive nr *below* what we had passed if sysctl_nr_open
-	 * had been set lower between the check in expand_files() and here.  Deal
-	 * with that in caller, it's cheaper that way.
+	 * had been set lower between the check in expand_files() and here.
 	 *
 	 * We make sure that nr remains a multiple of BITS_PER_LONG - otherwise
 	 * bitmaps handling below becomes unpleasant, to put it mildly...
 	 */
-	if (unlikely(nr > sysctl_nr_open))
-		nr = ((sysctl_nr_open - 1) | (BITS_PER_LONG - 1)) + 1;
+	if (unlikely(nr > sysctl_nr_open)) {
+		nr = round_down(sysctl_nr_open, BITS_PER_LONG);
+		if (nr < slots_wanted)
+			return ERR_PTR(-EMFILE);
+	}
 
 	/*
 	 * Check if the allocation size would exceed INT_MAX. kvmalloc_array()
@@ -168,7 +171,7 @@ static struct fdtable * alloc_fdtable(unsigned int nr)
 out_fdt:
 	kfree(fdt);
 out:
-	return NULL;
+	return ERR_PTR(-ENOMEM);
 }
 
 /*
@@ -185,7 +188,7 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 	struct fdtable *new_fdt, *cur_fdt;
 
 	spin_unlock(&files->file_lock);
-	new_fdt = alloc_fdtable(nr);
+	new_fdt = alloc_fdtable(nr + 1);
 
 	/* make sure all fd_install() have seen resize_in_progress
 	 * or have finished their rcu_read_lock_sched() section.
@@ -194,16 +197,8 @@ static int expand_fdtable(struct files_struct *files, unsigned int nr)
 		synchronize_rcu();
 
 	spin_lock(&files->file_lock);
-	if (!new_fdt)
-		return -ENOMEM;
-	/*
-	 * extremely unlikely race - sysctl_nr_open decreased between the check in
-	 * caller and alloc_fdtable().  Cheaper to catch it here...
-	 */
-	if (unlikely(new_fdt->max_fds <= nr)) {
-		__free_fdtable(new_fdt);
-		return -EMFILE;
-	}
+	if (IS_ERR(new_fdt))
+		return PTR_ERR(new_fdt);
 	cur_fdt = files_fdtable(files);
 	BUG_ON(nr < cur_fdt->max_fds);
 	copy_fdtable(new_fdt, cur_fdt);
@@ -322,7 +317,6 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	struct file **old_fds, **new_fds;
 	unsigned int open_files, i;
 	struct fdtable *old_fdt, *new_fdt;
-	int error;
 
 	newf = kmem_cache_alloc(files_cachep, GFP_KERNEL);
 	if (!newf)
@@ -354,17 +348,10 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 		if (new_fdt != &newf->fdtab)
 			__free_fdtable(new_fdt);
 
-		new_fdt = alloc_fdtable(open_files - 1);
-		if (!new_fdt) {
-			error = -ENOMEM;
-			goto out_release;
-		}
-
-		/* beyond sysctl_nr_open; nothing to do */
-		if (unlikely(new_fdt->max_fds < open_files)) {
-			__free_fdtable(new_fdt);
-			error = -EMFILE;
-			goto out_release;
+		new_fdt = alloc_fdtable(open_files);
+		if (IS_ERR(new_fdt)) {
+			kmem_cache_free(files_cachep, newf);
+			return ERR_CAST(new_fdt);
 		}
 
 		/*
@@ -413,10 +400,6 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	rcu_assign_pointer(newf->fdt, new_fdt);
 
 	return newf;
-
-out_release:
-	kmem_cache_free(files_cachep, newf);
-	return ERR_PTR(error);
 }
 
 static struct fdtable *close_files(struct files_struct * files)
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index b3971e91e8eb..38861ca04899 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -285,6 +285,7 @@ int jbd2_log_do_checkpoint(journal_t *journal)
 		retry:
 			if (batch_count)
 				__flush_batch(journal, &batch_count);
+			cond_resched();
 			spin_lock(&journal->j_list_lock);
 			goto restart;
 	}
diff --git a/fs/namespace.c b/fs/namespace.c
index bb1560b0d25c..962fda4fa246 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2683,6 +2683,19 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	return attach_recursive_mnt(mnt, p, mp, 0);
 }
 
+static int may_change_propagation(const struct mount *m)
+{
+        struct mnt_namespace *ns = m->mnt_ns;
+
+	 // it must be mounted in some namespace
+	 if (IS_ERR_OR_NULL(ns))         // is_mounted()
+		 return -EINVAL;
+	 // and the caller must be admin in userns of that namespace
+	 if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
+		 return -EPERM;
+	 return 0;
+}
+
 /*
  * Sanity check the flags to change_mnt_propagation.
  */
@@ -2719,10 +2732,10 @@ static int do_change_type(struct path *path, int ms_flags)
 		return -EINVAL;
 
 	namespace_lock();
-	if (!check_mnt(mnt)) {
-		err = -EINVAL;
+	err = may_change_propagation(mnt);
+	if (err)
 		goto out_unlock;
-	}
+
 	if (type == MS_SHARED) {
 		err = invent_group_ids(mnt, recurse);
 		if (err)
@@ -3116,18 +3129,11 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 
 	namespace_lock();
 
-	err = -EINVAL;
-	/* To and From must be mounted */
-	if (!is_mounted(&from->mnt))
-		goto out;
-	if (!is_mounted(&to->mnt))
-		goto out;
-
-	err = -EPERM;
-	/* We should be allowed to modify mount namespaces of both mounts */
-	if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(from);
+	if (err)
 		goto out;
-	if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
+	err = may_change_propagation(to);
+	if (err)
 		goto out;
 
 	err = -EINVAL;
diff --git a/fs/netfs/write_collect.c b/fs/netfs/write_collect.c
index a968688a7323..c349867d74c3 100644
--- a/fs/netfs/write_collect.c
+++ b/fs/netfs/write_collect.c
@@ -433,6 +433,7 @@ static void netfs_collect_write_results(struct netfs_io_request *wreq)
 			if (front->start + front->transferred > stream->collected_to) {
 				stream->collected_to = front->start + front->transferred;
 				stream->transferred = stream->collected_to - wreq->start;
+				stream->transferred_valid = true;
 				notes |= MADE_PROGRESS;
 			}
 			if (test_bit(NETFS_SREQ_FAILED, &front->flags)) {
@@ -538,6 +539,7 @@ void netfs_write_collection_worker(struct work_struct *work)
 	struct netfs_io_request *wreq = container_of(work, struct netfs_io_request, work);
 	struct netfs_inode *ictx = netfs_inode(wreq->inode);
 	size_t transferred;
+	bool transferred_valid = false;
 	int s;
 
 	_enter("R=%x", wreq->debug_id);
@@ -568,12 +570,16 @@ void netfs_write_collection_worker(struct work_struct *work)
 			netfs_put_request(wreq, false, netfs_rreq_trace_put_work);
 			return;
 		}
-		if (stream->transferred < transferred)
+		if (stream->transferred_valid &&
+		    stream->transferred < transferred) {
 			transferred = stream->transferred;
+			transferred_valid = true;
+		}
 	}
 
 	/* Okay, declare that all I/O is complete. */
-	wreq->transferred = transferred;
+	if (transferred_valid)
+		wreq->transferred = transferred;
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
 	if (wreq->io_streams[1].active &&
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index bf6d507578e5..b7830a15ae40 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -115,12 +115,12 @@ struct netfs_io_request *netfs_create_write_req(struct address_space *mapping,
 	wreq->io_streams[0].prepare_write	= ictx->ops->prepare_write;
 	wreq->io_streams[0].issue_write		= ictx->ops->issue_write;
 	wreq->io_streams[0].collected_to	= start;
-	wreq->io_streams[0].transferred		= LONG_MAX;
+	wreq->io_streams[0].transferred		= 0;
 
 	wreq->io_streams[1].stream_nr		= 1;
 	wreq->io_streams[1].source		= NETFS_WRITE_TO_CACHE;
 	wreq->io_streams[1].collected_to	= start;
-	wreq->io_streams[1].transferred		= LONG_MAX;
+	wreq->io_streams[1].transferred		= 0;
 	if (fscache_resources_valid(&wreq->cache_resources)) {
 		wreq->io_streams[1].avail	= true;
 		wreq->io_streams[1].active	= true;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index e27c07bd8929..82c3e2ca59a2 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -253,13 +253,14 @@ nfs_page_group_unlock(struct nfs_page *req)
 	nfs_page_clear_headlock(req);
 }
 
-/*
- * nfs_page_group_sync_on_bit_locked
+/**
+ * nfs_page_group_sync_on_bit_locked - Test if all requests have @bit set
+ * @req: request in page group
+ * @bit: PG_* bit that is used to sync page group
  *
  * must be called with page group lock held
  */
-static bool
-nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
+bool nfs_page_group_sync_on_bit_locked(struct nfs_page *req, unsigned int bit)
 {
 	struct nfs_page *head = req->wb_head;
 	struct nfs_page *tmp;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 8ff8db09a1e0..2b6b3542405c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -153,20 +153,10 @@ nfs_page_set_inode_ref(struct nfs_page *req, struct inode *inode)
 	}
 }
 
-static int
-nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
+static void nfs_cancel_remove_inode(struct nfs_page *req, struct inode *inode)
 {
-	int ret;
-
-	if (!test_bit(PG_REMOVE, &req->wb_flags))
-		return 0;
-	ret = nfs_page_group_lock(req);
-	if (ret)
-		return ret;
 	if (test_and_clear_bit(PG_REMOVE, &req->wb_flags))
 		nfs_page_set_inode_ref(req, inode);
-	nfs_page_group_unlock(req);
-	return 0;
 }
 
 /**
@@ -585,19 +575,18 @@ static struct nfs_page *nfs_lock_and_join_requests(struct folio *folio)
 		}
 	}
 
+	ret = nfs_page_group_lock(head);
+	if (ret < 0)
+		goto out_unlock;
+
 	/* Ensure that nobody removed the request before we locked it */
 	if (head != folio->private) {
+		nfs_page_group_unlock(head);
 		nfs_unlock_and_release_request(head);
 		goto retry;
 	}
 
-	ret = nfs_cancel_remove_inode(head, inode);
-	if (ret < 0)
-		goto out_unlock;
-
-	ret = nfs_page_group_lock(head);
-	if (ret < 0)
-		goto out_unlock;
+	nfs_cancel_remove_inode(head, inode);
 
 	/* lock each request in the page group */
 	for (subreq = head->wb_this_page;
@@ -801,7 +790,8 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 {
 	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
 
-	if (nfs_page_group_sync_on_bit(req, PG_REMOVE)) {
+	nfs_page_group_lock(req);
+	if (nfs_page_group_sync_on_bit_locked(req, PG_REMOVE)) {
 		struct folio *folio = nfs_page_to_folio(req->wb_head);
 		struct address_space *mapping = folio->mapping;
 
@@ -812,6 +802,7 @@ static void nfs_inode_remove_request(struct nfs_page *req)
 		}
 		spin_unlock(&mapping->i_private_lock);
 	}
+	nfs_page_group_unlock(req);
 
 	if (test_and_clear_bit(PG_INODE_REF, &req->wb_flags)) {
 		atomic_long_dec(&nfsi->nrequests);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4388004a319d..a00af67cee98 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -780,7 +780,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		return err;
 
 	ovl_start_write(c->dentry);
-	inode_lock(wdir);
+	inode_lock_nested(wdir, I_MUTEX_PARENT);
 	temp = ovl_create_temp(ofs, c->workdir, &cattr);
 	inode_unlock(wdir);
 	ovl_end_write(c->dentry);
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4bababee965a..ab911a967246 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -4522,7 +4522,7 @@ smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
 	for (int i = 1; i < num_rqst; i++) {
 		struct smb_rqst *old = &old_rq[i - 1];
 		struct smb_rqst *new = &new_rq[i];
-		struct folio_queue *buffer;
+		struct folio_queue *buffer = NULL;
 		size_t size = iov_iter_count(&old->rq_iter);
 
 		orig_len += smb_rqst_len(server, old);
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 9eb3e6010aa6..1c37d1e9aef3 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -503,7 +503,8 @@ void ksmbd_conn_transport_destroy(void)
 {
 	mutex_lock(&init_lock);
 	ksmbd_tcp_destroy();
-	ksmbd_rdma_destroy();
+	ksmbd_rdma_stop_listening();
 	stop_sessions();
+	ksmbd_rdma_destroy();
 	mutex_unlock(&init_lock);
 }
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index 31dd1caac1e8..2aa8084bb593 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -46,7 +46,12 @@ struct ksmbd_conn {
 	struct mutex			srv_mutex;
 	int				status;
 	unsigned int			cli_cap;
-	__be32				inet_addr;
+	union {
+		__be32			inet_addr;
+#if IS_ENABLED(CONFIG_IPV6)
+		u8			inet6_addr[16];
+#endif
+	};
 	char				*request_buf;
 	struct ksmbd_transport		*transport;
 	struct nls_table		*local_nls;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index d7a8a580d013..a04d5702820d 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1102,8 +1102,10 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 			if (!atomic_inc_not_zero(&opinfo->refcount))
 				continue;
 
-			if (ksmbd_conn_releasing(opinfo->conn))
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				opinfo_put(opinfo);
 				continue;
+			}
 
 			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
 			opinfo_put(opinfo);
@@ -1139,8 +1141,11 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 			if (!atomic_inc_not_zero(&opinfo->refcount))
 				continue;
 
-			if (ksmbd_conn_releasing(opinfo->conn))
+			if (ksmbd_conn_releasing(opinfo->conn)) {
+				opinfo_put(opinfo);
 				continue;
+			}
+
 			oplock_break(opinfo, SMB2_OPLOCK_LEVEL_NONE, NULL);
 			opinfo_put(opinfo);
 		}
@@ -1343,8 +1348,10 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
 
-		if (ksmbd_conn_releasing(brk_op->conn))
+		if (ksmbd_conn_releasing(brk_op->conn)) {
+			opinfo_put(brk_op);
 			continue;
+		}
 
 		if (brk_op->is_lease && (brk_op->o_lease->state &
 		    (~(SMB2_LEASE_READ_CACHING_LE |
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 805c20f619b0..67c989e5ddaa 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -2193,7 +2193,7 @@ int ksmbd_rdma_init(void)
 	return 0;
 }
 
-void ksmbd_rdma_destroy(void)
+void ksmbd_rdma_stop_listening(void)
 {
 	if (!smb_direct_listener.cm_id)
 		return;
@@ -2202,7 +2202,10 @@ void ksmbd_rdma_destroy(void)
 	rdma_destroy_id(smb_direct_listener.cm_id);
 
 	smb_direct_listener.cm_id = NULL;
+}
 
+void ksmbd_rdma_destroy(void)
+{
 	if (smb_direct_wq) {
 		destroy_workqueue(smb_direct_wq);
 		smb_direct_wq = NULL;
diff --git a/fs/smb/server/transport_rdma.h b/fs/smb/server/transport_rdma.h
index 77aee4e5c9dc..a2291b77488a 100644
--- a/fs/smb/server/transport_rdma.h
+++ b/fs/smb/server/transport_rdma.h
@@ -54,13 +54,15 @@ struct smb_direct_data_transfer {
 
 #ifdef CONFIG_SMB_SERVER_SMBDIRECT
 int ksmbd_rdma_init(void);
+void ksmbd_rdma_stop_listening(void);
 void ksmbd_rdma_destroy(void);
 bool ksmbd_rdma_capable_netdev(struct net_device *netdev);
 void init_smbd_max_io_size(unsigned int sz);
 unsigned int get_smbd_max_read_write_size(void);
 #else
 static inline int ksmbd_rdma_init(void) { return 0; }
-static inline int ksmbd_rdma_destroy(void) { return 0; }
+static inline void ksmbd_rdma_stop_listening(void) { }
+static inline void ksmbd_rdma_destroy(void) { }
 static inline bool ksmbd_rdma_capable_netdev(struct net_device *netdev) { return false; }
 static inline void init_smbd_max_io_size(unsigned int sz) { }
 static inline unsigned int get_smbd_max_read_write_size(void) { return 0; }
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index d72588f33b9c..756833c91b14 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -87,7 +87,14 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 		return NULL;
 	}
 
+#if IS_ENABLED(CONFIG_IPV6)
+	if (client_sk->sk->sk_family == AF_INET6)
+		memcpy(&conn->inet6_addr, &client_sk->sk->sk_v6_daddr, 16);
+	else
+		conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
+#else
 	conn->inet_addr = inet_sk(client_sk->sk)->inet_daddr;
+#endif
 	conn->transport = KSMBD_TRANS(t);
 	KSMBD_TRANS(t)->conn = conn;
 	KSMBD_TRANS(t)->ops = &ksmbd_tcp_transport_ops;
@@ -231,7 +238,6 @@ static int ksmbd_kthread_fn(void *p)
 {
 	struct socket *client_sk = NULL;
 	struct interface *iface = (struct interface *)p;
-	struct inet_sock *csk_inet;
 	struct ksmbd_conn *conn;
 	int ret;
 
@@ -254,13 +260,27 @@ static int ksmbd_kthread_fn(void *p)
 		/*
 		 * Limits repeated connections from clients with the same IP.
 		 */
-		csk_inet = inet_sk(client_sk->sk);
 		down_read(&conn_list_lock);
 		list_for_each_entry(conn, &conn_list, conns_list)
-			if (csk_inet->inet_daddr == conn->inet_addr) {
+#if IS_ENABLED(CONFIG_IPV6)
+			if (client_sk->sk->sk_family == AF_INET6) {
+				if (memcmp(&client_sk->sk->sk_v6_daddr,
+					   &conn->inet6_addr, 16) == 0) {
+					ret = -EAGAIN;
+					break;
+				}
+			} else if (inet_sk(client_sk->sk)->inet_daddr ==
+				 conn->inet_addr) {
+				ret = -EAGAIN;
+				break;
+			}
+#else
+			if (inet_sk(client_sk->sk)->inet_daddr ==
+			    conn->inet_addr) {
 				ret = -EAGAIN;
 				break;
 			}
+#endif
 		up_read(&conn_list_lock);
 		if (ret == -EAGAIN)
 			continue;
diff --git a/fs/splice.c b/fs/splice.c
index 38f8c9426731..ed8177f6d620 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -744,6 +744,9 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
+		WARN_ONCE(ret > sd.total_len - left,
+			  "Splice Exceeded! ret=%zd tot=%zu left=%zu\n",
+			  ret, sd.total_len, left);
 
 		sd.num_spliced += ret;
 		sd.total_len -= ret;
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 3a27d4268b3c..494d21777ed0 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -187,10 +187,15 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	unsigned short flags;
 	unsigned int fragments;
 	u64 lookup_table_start, xattr_id_table_start, next_table;
-	int err;
+	int err, devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
+	if (!devblksize) {
+		errorf(fc, "squashfs: unable to set blocksize\n");
+		return -EINVAL;
+	}
+
 	sb->s_fs_info = kzalloc(sizeof(*msblk), GFP_KERNEL);
 	if (sb->s_fs_info == NULL) {
 		ERROR("Failed to allocate squashfs_sb_info\n");
@@ -201,12 +206,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
 
-	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
-	if (!msblk->devblksize) {
-		errorf(fc, "squashfs: unable to set blocksize\n");
-		return -EINVAL;
-	}
-
+	msblk->devblksize = devblksize;
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
 
 	mutex_init(&msblk->meta_index_mutex);
diff --git a/fs/xfs/xfs_itable.c b/fs/xfs/xfs_itable.c
index c0757ab99495..dc395cd2f33b 100644
--- a/fs/xfs/xfs_itable.c
+++ b/fs/xfs/xfs_itable.c
@@ -430,11 +430,15 @@ xfs_inumbers(
 		.breq		= breq,
 	};
 	struct xfs_trans	*tp;
+	unsigned int		iwalk_flags = 0;
 	int			error = 0;
 
 	if (xfs_bulkstat_already_done(breq->mp, breq->startino))
 		return 0;
 
+	if (breq->flags & XFS_IBULK_SAME_AG)
+		iwalk_flags |= XFS_IWALK_SAME_AG;
+
 	/*
 	 * Grab an empty transaction so that we can use its recursive buffer
 	 * locking abilities to detect cycles in the inobt without deadlocking.
@@ -443,7 +447,7 @@ xfs_inumbers(
 	if (error)
 		goto out;
 
-	error = xfs_inobt_walk(breq->mp, tp, breq->startino, breq->flags,
+	error = xfs_inobt_walk(breq->mp, tp, breq->startino, iwalk_flags,
 			xfs_inumbers_walk, breq->icount, &ic);
 	xfs_trans_cancel(tp);
 out:
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 428d81afe215..2de9974992c3 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -96,9 +96,21 @@ void drm_fb_xrgb8888_to_rgba5551(struct iosys_map *dst, const unsigned int *dst_
 void drm_fb_xrgb8888_to_rgb888(struct iosys_map *dst, const unsigned int *dst_pitch,
 			       const struct iosys_map *src, const struct drm_framebuffer *fb,
 			       const struct drm_rect *clip, struct drm_format_conv_state *state);
+void drm_fb_xrgb8888_to_bgr888(struct iosys_map *dst, const unsigned int *dst_pitch,
+			       const struct iosys_map *src, const struct drm_framebuffer *fb,
+			       const struct drm_rect *clip, struct drm_format_conv_state *state);
 void drm_fb_xrgb8888_to_argb8888(struct iosys_map *dst, const unsigned int *dst_pitch,
 				 const struct iosys_map *src, const struct drm_framebuffer *fb,
 				 const struct drm_rect *clip, struct drm_format_conv_state *state);
+void drm_fb_xrgb8888_to_abgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src, const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip, struct drm_format_conv_state *state);
+void drm_fb_xrgb8888_to_xbgr8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src, const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip, struct drm_format_conv_state *state);
+void drm_fb_xrgb8888_to_bgrx8888(struct iosys_map *dst, const unsigned int *dst_pitch,
+				 const struct iosys_map *src, const struct drm_framebuffer *fb,
+				 const struct drm_rect *clip, struct drm_format_conv_state *state);
 void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *dst_pitch,
 				    const struct iosys_map *src, const struct drm_framebuffer *fb,
 				    const struct drm_rect *clip,
diff --git a/include/linux/call_once.h b/include/linux/call_once.h
index 6261aa0b3fb0..13cd6469e7e5 100644
--- a/include/linux/call_once.h
+++ b/include/linux/call_once.h
@@ -26,20 +26,41 @@ do {									\
 	__once_init((once), #once, &__key);				\
 } while (0)
 
-static inline void call_once(struct once *once, void (*cb)(struct once *))
+/*
+ * call_once - Ensure a function has been called exactly once
+ *
+ * @once: Tracking struct
+ * @cb: Function to be called
+ *
+ * If @once has never completed successfully before, call @cb and, if
+ * it returns a zero or positive value, mark @once as completed.  Return
+ * the value returned by @cb
+ *
+ * If @once has completed succesfully before, return 0.
+ *
+ * The call to @cb is implicitly surrounded by a mutex, though for
+ * efficiency the * function avoids taking it after the first call.
+ */
+static inline int call_once(struct once *once, int (*cb)(struct once *))
 {
-        /* Pairs with atomic_set_release() below.  */
-        if (atomic_read_acquire(&once->state) == ONCE_COMPLETED)
-                return;
-
-        guard(mutex)(&once->lock);
-        WARN_ON(atomic_read(&once->state) == ONCE_RUNNING);
-        if (atomic_read(&once->state) != ONCE_NOT_STARTED)
-                return;
-
-        atomic_set(&once->state, ONCE_RUNNING);
-        cb(once);
-        atomic_set_release(&once->state, ONCE_COMPLETED);
+	int r, state;
+
+	/* Pairs with atomic_set_release() below.  */
+	if (atomic_read_acquire(&once->state) == ONCE_COMPLETED)
+		return 0;
+
+	guard(mutex)(&once->lock);
+	state = atomic_read(&once->state);
+	if (unlikely(state != ONCE_NOT_STARTED))
+		return WARN_ON_ONCE(state != ONCE_COMPLETED) ? -EINVAL : 0;
+
+	atomic_set(&once->state, ONCE_RUNNING);
+	r = cb(once);
+	if (r < 0)
+		atomic_set(&once->state, ONCE_NOT_STARTED);
+	else
+		atomic_set_release(&once->state, ONCE_COMPLETED);
+	return r;
 }
 
 #endif /* _LINUX_CALL_ONCE_H */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index b15911e201bf..d18542d7e17b 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -223,14 +223,6 @@ static inline void *offset_to_ptr(const int *off)
 #define __ADDRESSABLE(sym) \
 	___ADDRESSABLE(sym, __section(".discard.addressable"))
 
-#define __ADDRESSABLE_ASM(sym)						\
-	.pushsection .discard.addressable,"aw";				\
-	.align ARCH_SEL(8,4);						\
-	ARCH_SEL(.quad, .long) __stringify(sym);			\
-	.popsection;
-
-#define __ADDRESSABLE_ASM_STR(sym) __stringify(__ADDRESSABLE_ASM(sym))
-
 /* &a[0] degrades to a pointer: a different type from an array */
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 
diff --git a/include/linux/iosys-map.h b/include/linux/iosys-map.h
index 4696abfd311c..3e85afe794c0 100644
--- a/include/linux/iosys-map.h
+++ b/include/linux/iosys-map.h
@@ -264,12 +264,7 @@ static inline bool iosys_map_is_set(const struct iosys_map *map)
  */
 static inline void iosys_map_clear(struct iosys_map *map)
 {
-	if (map->is_iomem) {
-		map->vaddr_iomem = NULL;
-		map->is_iomem = false;
-	} else {
-		map->vaddr = NULL;
-	}
+	memset(map, 0, sizeof(*map));
 }
 
 /**
diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index c4aa58032faf..f9a17fbbd398 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -160,7 +160,7 @@ size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2
 
 	do {
 		struct folio *folio = folioq_folio(folioq, slot);
-		size_t part, remain, consumed;
+		size_t part, remain = 0, consumed;
 		size_t fsize;
 		void *base;
 
@@ -168,14 +168,16 @@ size_t iterate_folioq(struct iov_iter *iter, size_t len, void *priv, void *priv2
 			break;
 
 		fsize = folioq_folio_size(folioq, slot);
-		base = kmap_local_folio(folio, skip);
-		part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
-		remain = step(base, progress, part, priv, priv2);
-		kunmap_local(base);
-		consumed = part - remain;
-		len -= consumed;
-		progress += consumed;
-		skip += consumed;
+		if (skip < fsize) {
+			base = kmap_local_folio(folio, skip);
+			part = umin(len, PAGE_SIZE - skip % PAGE_SIZE);
+			remain = step(base, progress, part, priv, priv2);
+			kunmap_local(base);
+			consumed = part - remain;
+			len -= consumed;
+			progress += consumed;
+			skip += consumed;
+		}
 		if (skip >= fsize) {
 			skip = 0;
 			slot++;
diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 75a2fb8b16c3..0143358874b0 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -57,47 +57,21 @@ static inline void kcov_remote_start_usb(u64 id)
 
 /*
  * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
- * workaround for KCOV's lack of nested remote coverage sections support.
- *
- * Adding support is tracked in https://bugzilla.kernel.org/show_bug.cgi?id=210337.
- *
- * kcov_remote_start_usb_softirq():
- *
- * 1. Only collects coverage when called in the softirq context. This allows
- *    avoiding nested remote coverage collection sections in the task context.
- *    For example, USB/IP calls usb_hcd_giveback_urb() in the task context
- *    within an existing remote coverage collection section. Thus, KCOV should
- *    not attempt to start collecting coverage within the coverage collection
- *    section in __usb_hcd_giveback_urb() in this case.
- *
- * 2. Disables interrupts for the duration of the coverage collection section.
- *    This allows avoiding nested remote coverage collection sections in the
- *    softirq context (a softirq might occur during the execution of a work in
- *    the BH workqueue, which runs with in_serving_softirq() > 0).
- *    For example, usb_giveback_urb_bh() runs in the BH workqueue with
- *    interrupts enabled, so __usb_hcd_giveback_urb() might be interrupted in
- *    the middle of its remote coverage collection section, and the interrupt
- *    handler might invoke __usb_hcd_giveback_urb() again.
+ * work around for kcov's lack of nested remote coverage sections support in
+ * task context. Adding support for nested sections is tracked in:
+ * https://bugzilla.kernel.org/show_bug.cgi?id=210337
  */
 
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
+static inline void kcov_remote_start_usb_softirq(u64 id)
 {
-	unsigned long flags = 0;
-
-	if (in_serving_softirq()) {
-		local_irq_save(flags);
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_start_usb(id);
-	}
-
-	return flags;
 }
 
-static inline void kcov_remote_stop_softirq(unsigned long flags)
+static inline void kcov_remote_stop_softirq(void)
 {
-	if (in_serving_softirq()) {
+	if (in_serving_softirq() && !in_hardirq())
 		kcov_remote_stop();
-		local_irq_restore(flags);
-	}
 }
 
 #ifdef CONFIG_64BIT
@@ -131,11 +105,8 @@ static inline u64 kcov_common_handle(void)
 }
 static inline void kcov_remote_start_common(u64 id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
-static inline unsigned long kcov_remote_start_usb_softirq(u64 id)
-{
-	return 0;
-}
-static inline void kcov_remote_stop_softirq(unsigned long flags) {}
+static inline void kcov_remote_start_usb_softirq(u64 id) {}
+static inline void kcov_remote_stop_softirq(void) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 512e25c416ae..2b1a816e4d59 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10358,8 +10358,16 @@ struct mlx5_ifc_pifr_reg_bits {
 	u8         port_filter_update_en[8][0x20];
 };
 
+enum {
+	MLX5_BUF_OWNERSHIP_UNKNOWN	= 0x0,
+	MLX5_BUF_OWNERSHIP_FW_OWNED	= 0x1,
+	MLX5_BUF_OWNERSHIP_SW_OWNED	= 0x2,
+};
+
 struct mlx5_ifc_pfcc_reg_bits {
-	u8         reserved_at_0[0x8];
+	u8         reserved_at_0[0x4];
+	u8	   buf_ownership[0x2];
+	u8	   reserved_at_6[0x2];
 	u8         local_port[0x8];
 	u8         reserved_at_10[0xb];
 	u8         ppan_mask_n[0x1];
@@ -10491,7 +10499,9 @@ struct mlx5_ifc_mtutc_reg_bits {
 struct mlx5_ifc_pcam_enhanced_features_bits {
 	u8         reserved_at_0[0x48];
 	u8         fec_100G_per_lane_in_pplm[0x1];
-	u8         reserved_at_49[0x1f];
+	u8         reserved_at_49[0xa];
+	u8	   buffer_ownership[0x1];
+	u8	   resereved_at_54[0x14];
 	u8         fec_50G_per_lane_in_pplm[0x1];
 	u8         reserved_at_69[0x4];
 	u8         rx_icrc_encapsulated_counter[0x1];
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index e68d42b8ce65..e288569225bd 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -61,15 +61,6 @@ enum mlx5_an_status {
 #define MLX5_EEPROM_PAGE_LENGTH		256
 #define MLX5_EEPROM_HIGH_PAGE_LENGTH	128
 
-struct mlx5_module_eeprom_query_params {
-	u16 size;
-	u16 offset;
-	u16 i2c_address;
-	u32 page;
-	u32 bank;
-	u32 module_number;
-};
-
 enum mlx5e_link_mode {
 	MLX5E_1000BASE_CX_SGMII	 = 0,
 	MLX5E_1000BASE_KX	 = 1,
@@ -142,12 +133,6 @@ enum mlx5_ptys_width {
 	MLX5_PTYS_WIDTH_12X	= 1 << 4,
 };
 
-struct mlx5_port_eth_proto {
-	u32 cap;
-	u32 admin;
-	u32 oper;
-};
-
 #define MLX5E_PROT_MASK(link_mode) (1U << link_mode)
 #define MLX5_GET_ETH_PROTO(reg, out, ext, field)	\
 	(ext ? MLX5_GET(reg, out, ext_##field) :	\
@@ -160,14 +145,7 @@ int mlx5_query_port_ptys(struct mlx5_core_dev *dev, u32 *ptys,
 
 int mlx5_query_ib_port_oper(struct mlx5_core_dev *dev, u16 *link_width_oper,
 			    u16 *proto_oper, u8 local_port, u8 plane_index);
-void mlx5_toggle_port_link(struct mlx5_core_dev *dev);
-int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
-			       enum mlx5_port_status status);
-int mlx5_query_port_admin_status(struct mlx5_core_dev *dev,
-				 enum mlx5_port_status *status);
-int mlx5_set_port_beacon(struct mlx5_core_dev *dev, u16 beacon_duration);
-
-int mlx5_set_port_mtu(struct mlx5_core_dev *dev, u16 mtu, u8 port);
+
 void mlx5_query_port_max_mtu(struct mlx5_core_dev *dev, u16 *max_mtu, u8 port);
 void mlx5_query_port_oper_mtu(struct mlx5_core_dev *dev, u16 *oper_mtu,
 			      u8 port);
@@ -175,65 +153,4 @@ void mlx5_query_port_oper_mtu(struct mlx5_core_dev *dev, u16 *oper_mtu,
 int mlx5_query_port_vl_hw_cap(struct mlx5_core_dev *dev,
 			      u8 *vl_hw_cap, u8 local_port);
 
-int mlx5_set_port_pause(struct mlx5_core_dev *dev, u32 rx_pause, u32 tx_pause);
-int mlx5_query_port_pause(struct mlx5_core_dev *dev,
-			  u32 *rx_pause, u32 *tx_pause);
-
-int mlx5_set_port_pfc(struct mlx5_core_dev *dev, u8 pfc_en_tx, u8 pfc_en_rx);
-int mlx5_query_port_pfc(struct mlx5_core_dev *dev, u8 *pfc_en_tx,
-			u8 *pfc_en_rx);
-
-int mlx5_set_port_stall_watermark(struct mlx5_core_dev *dev,
-				  u16 stall_critical_watermark,
-				  u16 stall_minor_watermark);
-int mlx5_query_port_stall_watermark(struct mlx5_core_dev *dev,
-				    u16 *stall_critical_watermark, u16 *stall_minor_watermark);
-
-int mlx5_max_tc(struct mlx5_core_dev *mdev);
-
-int mlx5_set_port_prio_tc(struct mlx5_core_dev *mdev, u8 *prio_tc);
-int mlx5_query_port_prio_tc(struct mlx5_core_dev *mdev,
-			    u8 prio, u8 *tc);
-int mlx5_set_port_tc_group(struct mlx5_core_dev *mdev, u8 *tc_group);
-int mlx5_query_port_tc_group(struct mlx5_core_dev *mdev,
-			     u8 tc, u8 *tc_group);
-int mlx5_set_port_tc_bw_alloc(struct mlx5_core_dev *mdev, u8 *tc_bw);
-int mlx5_query_port_tc_bw_alloc(struct mlx5_core_dev *mdev,
-				u8 tc, u8 *bw_pct);
-int mlx5_modify_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				    u8 *max_bw_value,
-				    u8 *max_bw_unit);
-int mlx5_query_port_ets_rate_limit(struct mlx5_core_dev *mdev,
-				   u8 *max_bw_value,
-				   u8 *max_bw_unit);
-int mlx5_set_port_wol(struct mlx5_core_dev *mdev, u8 wol_mode);
-int mlx5_query_port_wol(struct mlx5_core_dev *mdev, u8 *wol_mode);
-
-int mlx5_query_ports_check(struct mlx5_core_dev *mdev, u32 *out, int outlen);
-int mlx5_set_ports_check(struct mlx5_core_dev *mdev, u32 *in, int inlen);
-int mlx5_set_port_fcs(struct mlx5_core_dev *mdev, u8 enable);
-void mlx5_query_port_fcs(struct mlx5_core_dev *mdev, bool *supported,
-			 bool *enabled);
-int mlx5_query_module_eeprom(struct mlx5_core_dev *dev,
-			     u16 offset, u16 size, u8 *data);
-int mlx5_query_module_eeprom_by_page(struct mlx5_core_dev *dev,
-				     struct mlx5_module_eeprom_query_params *params, u8 *data);
-
-int mlx5_query_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *out);
-int mlx5_set_port_dcbx_param(struct mlx5_core_dev *mdev, u32 *in);
-
-int mlx5_set_trust_state(struct mlx5_core_dev *mdev, u8 trust_state);
-int mlx5_query_trust_state(struct mlx5_core_dev *mdev, u8 *trust_state);
-int mlx5_set_dscp2prio(struct mlx5_core_dev *mdev, u8 dscp, u8 prio);
-int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio);
-
-int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
-			      struct mlx5_port_eth_proto *eproto);
-bool mlx5_ptys_ext_supported(struct mlx5_core_dev *mdev);
-u32 mlx5_port_ptys2speed(struct mlx5_core_dev *mdev, u32 eth_proto_oper,
-			 bool force_legacy);
-u32 mlx5_port_speed2linkmodes(struct mlx5_core_dev *mdev, u32 speed,
-			      bool force_legacy);
-int mlx5_port_max_linkspeed(struct mlx5_core_dev *mdev, u32 *speed);
-
 #endif /* __MLX5_PORT_H__ */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 474481ee8b7c..83d313718cd5 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -150,6 +150,7 @@ struct netfs_io_stream {
 	bool			active;		/* T if stream is active */
 	bool			need_retry;	/* T if this stream needs retrying */
 	bool			failed;		/* T if this stream failed */
+	bool			transferred_valid; /* T is ->transferred is valid */
 };
 
 /*
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff4..9aed39abc94b 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -160,6 +160,7 @@ extern void nfs_join_page_group(struct nfs_page *head,
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
+extern bool nfs_page_group_sync_on_bit_locked(struct nfs_page *, unsigned int);
 extern	int nfs_page_set_headlock(struct nfs_page *req);
 extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 2053cd8e788a..dba369a2cf27 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -307,6 +307,7 @@ int bond_3ad_lacpdu_recv(const struct sk_buff *skb, struct bonding *bond,
 			 struct slave *slave);
 int bond_3ad_set_carrier(struct bonding *bond);
 void bond_3ad_update_lacp_rate(struct bonding *bond);
+void bond_3ad_update_lacp_active(struct bonding *bond);
 void bond_3ad_update_ad_actor_settings(struct bonding *bond);
 int bond_3ad_stats_fill(struct sk_buff *skb, struct bond_3ad_stats *stats);
 size_t bond_3ad_stats_size(void);
diff --git a/include/uapi/linux/pfrut.h b/include/uapi/linux/pfrut.h
index 42fa15f8310d..b77d5c210c26 100644
--- a/include/uapi/linux/pfrut.h
+++ b/include/uapi/linux/pfrut.h
@@ -89,6 +89,7 @@ struct pfru_payload_hdr {
 	__u32 hw_ver;
 	__u32 rt_ver;
 	__u8 platform_id[16];
+	__u32 svn_ver;
 };
 
 enum pfru_dsm_status {
diff --git a/io_uring/futex.c b/io_uring/futex.c
index 01f044f89f8f..a3d2b700b480 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -337,6 +337,7 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 		goto done_unlock;
 	}
 
+	req->flags |= REQ_F_ASYNC_DATA;
 	req->async_data = ifd;
 	ifd->q = futex_q_init;
 	ifd->q.bitset = iof->futex_mask;
@@ -359,6 +360,8 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
+	req->async_data = NULL;
+	req->flags &= ~REQ_F_ASYNC_DATA;
 	kfree(ifd);
 	return IOU_OK;
 }
diff --git a/io_uring/net.c b/io_uring/net.c
index 356f95c33aa2..b7c93765fcff 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -498,6 +498,15 @@ static int io_bundle_nbufs(struct io_async_msghdr *kmsg, int ret)
 	return nbufs;
 }
 
+static int io_net_kbuf_recyle(struct io_kiocb *req,
+			      struct io_async_msghdr *kmsg, int len)
+{
+	req->flags |= REQ_F_BL_NO_RECYCLE;
+	if (req->flags & REQ_F_BUFFERS_COMMIT)
+		io_kbuf_commit(req, req->buf_list, len, io_bundle_nbufs(kmsg, len));
+	return -EAGAIN;
+}
+
 static inline bool io_send_finish(struct io_kiocb *req, int *ret,
 				  struct io_async_msghdr *kmsg,
 				  unsigned issue_flags)
@@ -566,8 +575,7 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 			kmsg->msg.msg_controllen = 0;
 			kmsg->msg.msg_control = NULL;
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -664,8 +672,7 @@ int io_send(struct io_kiocb *req, unsigned int issue_flags)
 			sr->len -= ret;
 			sr->buf += ret;
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1068,8 +1075,7 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 		}
 		if (ret > 0 && io_net_retry(sock, flags)) {
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1211,8 +1217,7 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 			sr->len -= ret;
 			sr->buf += ret;
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1441,8 +1446,7 @@ int io_send_zc(struct io_kiocb *req, unsigned int issue_flags)
 			zc->len -= ret;
 			zc->buf += ret;
 			zc->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
@@ -1502,8 +1506,7 @@ int io_sendmsg_zc(struct io_kiocb *req, unsigned int issue_flags)
 
 		if (ret > 0 && io_net_retry(sock, flags)) {
 			sr->done_io += ret;
-			req->flags |= REQ_F_BL_NO_RECYCLE;
-			return -EAGAIN;
+			return io_net_kbuf_recyle(req, kmsg, ret);
 		}
 		if (ret == -ERESTARTSYS)
 			ret = -EINTR;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d1fb4bfbbd4c..25f9565f798d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -267,7 +267,7 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
 {
 	if (!cpusets_insane_config() &&
 		movable_only_nodes(nodes)) {
-		static_branch_enable(&cpusets_insane_config_key);
+		static_branch_enable_cpuslocked(&cpusets_insane_config_key);
 		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)!\n"
 			"Cpuset allocations might fail even with a lot of memory available.\n",
 			nodemask_pr_args(nodes));
@@ -1771,7 +1771,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 			if (is_partition_valid(cs))
 				adding = cpumask_and(tmp->addmask,
 						xcpus, parent->effective_xcpus);
-		} else if (is_partition_invalid(cs) &&
+		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
 			   cpumask_subset(xcpus, parent->effective_xcpus)) {
 			struct cgroup_subsys_state *css;
 			struct cpuset *child;
@@ -3792,9 +3792,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		partcmd = partcmd_invalidate;
 	/*
 	 * On the other hand, an invalid partition root may be transitioned
-	 * back to a regular one.
+	 * back to a regular one with a non-empty effective xcpus.
 	 */
-	else if (is_partition_valid(parent) && is_partition_invalid(cs))
+	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
+		 !cpumask_empty(cs->effective_xcpus))
 		partcmd = partcmd_update;
 
 	if (partcmd >= 0) {
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c801dd20c63d..563a7dc2ece6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5220,6 +5220,13 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	for_each_possible_cpu(cpu)
 		cpu_rq(cpu)->scx.cpuperf_target = SCX_CPUPERF_ONE;
 
+	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
+		reset_idle_masks();
+		static_branch_enable(&scx_builtin_idle_enabled);
+	} else {
+		static_branch_disable(&scx_builtin_idle_enabled);
+	}
+
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
 	 * online CPUs by watching ->on/offline_cpu() after ->init().
@@ -5287,13 +5294,6 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (scx_ops.cpu_acquire || scx_ops.cpu_release)
 		static_branch_enable(&scx_ops_cpu_preempt);
 
-	if (!ops->update_idle || (ops->flags & SCX_OPS_KEEP_BUILTIN_IDLE)) {
-		reset_idle_masks();
-		static_branch_enable(&scx_builtin_idle_enabled);
-	} else {
-		static_branch_disable(&scx_builtin_idle_enabled);
-	}
-
 	/*
 	 * Lock out forks, cgroup on/offlining and moves before opening the
 	 * floodgate so that they don't wander into the operations prematurely.
@@ -5372,6 +5372,9 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (!tryget_task_struct(p))
+			continue;
+
 		if (old_class != new_class && p->se.sched_delayed)
 			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 
@@ -5384,6 +5387,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		sched_enq_and_set_task(&ctx);
 
 		check_class_changed(task_rq(p), p, old_class, p->prio);
+		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ad7db84b0409..370cde32c696 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4569,13 +4569,17 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		if (hash)
+			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		else
+			iter->hash = EMPTY_HASH;
+	}
 
-		if (!iter->hash) {
-			trace_parser_put(&iter->parser);
-			goto out_unlock;
-		}
-	} else
-		iter->hash = hash;
+	if (!iter->hash) {
+		trace_parser_put(&iter->parser);
+		goto out_unlock;
+	}
 
 	ret = 0;
 
@@ -6445,9 +6449,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
-	} else {
-		/* For read only, the hash is the ops hash */
-		iter->hash = NULL;
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 801def692f92..2f662ca4d3ff 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1754,7 +1754,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		goto out;
+		goto fail;
 
 	read++;
 	cnt--;
@@ -1768,7 +1768,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				goto out;
+				goto fail;
 			read++;
 			cnt--;
 		}
@@ -1778,8 +1778,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* only spaces were written */
 		if (isspace(ch) || !ch) {
 			*ppos += read;
-			ret = read;
-			goto out;
+			return read;
 		}
 	}
 
@@ -1789,11 +1788,12 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 			parser->buffer[parser->idx++] = ch;
 		else {
 			ret = -EINVAL;
-			goto out;
+			goto fail;
 		}
+
 		ret = get_user(ch, ubuf++);
 		if (ret)
-			goto out;
+			goto fail;
 		read++;
 		cnt--;
 	}
@@ -1809,13 +1809,13 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		parser->buffer[parser->idx] = 0;
 	} else {
 		ret = -EINVAL;
-		goto out;
+		goto fail;
 	}
 
 	*ppos += read;
-	ret = read;
-
-out:
+	return read;
+fail:
+	trace_parser_fail(parser);
 	return ret;
 }
 
@@ -2318,10 +2318,10 @@ int __init register_tracer(struct tracer *type)
 	mutex_unlock(&trace_types_lock);
 
 	if (ret || !default_bootup_tracer)
-		goto out_unlock;
+		return ret;
 
 	if (strncmp(default_bootup_tracer, type->name, MAX_TRACER_SIZE))
-		goto out_unlock;
+		return 0;
 
 	printk(KERN_INFO "Starting tracer '%s'\n", type->name);
 	/* Do we want this tracer to start on bootup? */
@@ -2333,8 +2333,7 @@ int __init register_tracer(struct tracer *type)
 	/* disable other selftests, since this will break it. */
 	disable_tracing_selftest("running a tracer");
 
- out_unlock:
-	return ret;
+	return 0;
 }
 
 static void tracing_reset_cpu(struct array_buffer *buf, int cpu)
@@ -8563,12 +8562,12 @@ ftrace_trace_snapshot_callback(struct trace_array *tr, struct ftrace_hash *hash,
  out_reg:
 	ret = tracing_arm_snapshot(tr);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = register_ftrace_function_probe(glob, tr, ops, count);
 	if (ret < 0)
 		tracing_disarm_snapshot(tr);
- out:
+
 	return ret < 0 ? ret : 0;
 }
 
@@ -10469,7 +10468,7 @@ __init static int tracer_alloc_buffers(void)
 	BUILD_BUG_ON(TRACE_ITER_LAST_BIT > TRACE_FLAGS_MAX_SIZE);
 
 	if (!alloc_cpumask_var(&tracing_buffer_mask, GFP_KERNEL))
-		goto out;
+		return -ENOMEM;
 
 	if (!alloc_cpumask_var(&global_trace.tracing_cpumask, GFP_KERNEL))
 		goto out_free_buffer_mask;
@@ -10582,7 +10581,6 @@ __init static int tracer_alloc_buffers(void)
 	free_cpumask_var(global_trace.tracing_cpumask);
 out_free_buffer_mask:
 	free_cpumask_var(tracing_buffer_mask);
-out:
 	return ret;
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 57e1af1d3e6d..9b2ae7652cbc 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1230,6 +1230,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
  */
 struct trace_parser {
 	bool		cont;
+	bool		fail;
 	char		*buffer;
 	unsigned	idx;
 	unsigned	size;
@@ -1237,7 +1238,7 @@ struct trace_parser {
 
 static inline bool trace_parser_loaded(struct trace_parser *parser)
 {
-	return (parser->idx != 0);
+	return !parser->fail && parser->idx != 0;
 }
 
 static inline bool trace_parser_cont(struct trace_parser *parser)
@@ -1251,6 +1252,11 @@ static inline void trace_parser_clear(struct trace_parser *parser)
 	parser->idx = 0;
 }
 
+static inline void trace_parser_fail(struct trace_parser *parser)
+{
+	parser->fail = true;
+}
+
 extern int trace_parser_get_init(struct trace_parser *parser, int size);
 extern void trace_parser_put(struct trace_parser *parser);
 extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
@@ -2145,7 +2151,7 @@ static inline bool is_good_system_name(const char *name)
 static inline void sanitize_event_name(char *name)
 {
 	while (*name++ != '\0')
-		if (*name == ':' || *name == '.')
+		if (*name == ':' || *name == '.' || *name == '*')
 			*name = '_';
 }
 
diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 8813038abc6f..4120a73f4933 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -431,6 +431,10 @@ static unsigned long damon_pa_migrate_pages(struct list_head *folio_list,
 	if (list_empty(folio_list))
 		return nr_migrated;
 
+	if (target_nid < 0 || target_nid >= MAX_NUMNODES ||
+			!node_state(target_nid, N_MEMORY))
+		return nr_migrated;
+
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nid = folio_nid(lru_to_folio(folio_list));
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index bc748f700a9e..80cc409ba78a 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1049,29 +1049,34 @@ static void __init destroy_args(struct pgtable_debug_args *args)
 
 	/* Free page table entries */
 	if (args->start_ptep) {
+		pmd_clear(args->pmdp);
 		pte_free(args->mm, args->start_ptep);
 		mm_dec_nr_ptes(args->mm);
 	}
 
 	if (args->start_pmdp) {
+		pud_clear(args->pudp);
 		pmd_free(args->mm, args->start_pmdp);
 		mm_dec_nr_pmds(args->mm);
 	}
 
 	if (args->start_pudp) {
+		p4d_clear(args->p4dp);
 		pud_free(args->mm, args->start_pudp);
 		mm_dec_nr_puds(args->mm);
 	}
 
-	if (args->start_p4dp)
+	if (args->start_p4dp) {
+		pgd_clear(args->pgdp);
 		p4d_free(args->mm, args->start_p4dp);
+	}
 
 	/* Free vma and mm struct */
 	if (args->vma)
 		vm_area_free(args->vma);
 
 	if (args->mm)
-		mmdrop(args->mm);
+		mmput(args->mm);
 }
 
 static struct page * __init
diff --git a/mm/filemap.c b/mm/filemap.c
index fa18e71f9c88..ec69fadf014c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1750,8 +1750,9 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
+	unsigned long nr = max_scan;
 
-	while (max_scan--) {
+	while (nr--) {
 		void *entry = xas_next(&xas);
 		if (!entry || xa_is_value(entry))
 			return xas.xa_index;
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 70b2ccf0d51e..8c8d78d6d306 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -845,9 +845,17 @@ static int hwpoison_hugetlb_range(pte_t *ptep, unsigned long hmask,
 #define hwpoison_hugetlb_range	NULL
 #endif
 
+static int hwpoison_test_walk(unsigned long start, unsigned long end,
+			     struct mm_walk *walk)
+{
+	/* We also want to consider pages mapped into VM_PFNMAP. */
+	return 0;
+}
+
 static const struct mm_walk_ops hwpoison_walk_ops = {
 	.pmd_entry = hwpoison_pte_range,
 	.hugetlb_entry = hwpoison_hugetlb_range,
+	.test_walk = hwpoison_test_walk,
 	.walk_lock = PGWALK_RDLOCK,
 };
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c6c1232db4e2..dad902047414 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -338,7 +338,8 @@ static int hci_enhanced_setup_sync(struct hci_dev *hdev, void *data)
 	case BT_CODEC_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-			return false;
+			return -EINVAL;
+
 		param = &esco_param_msbc[conn->attempt - 1];
 		cp.tx_coding_format.id = 0x03;
 		cp.rx_coding_format.id = 0x03;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 38643ffa65a9..768bd5fd808f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6725,8 +6725,8 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		qos->ucast.out.latency =
 			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
 					  1000);
-		qos->ucast.in.sdu = le16_to_cpu(ev->c_mtu);
-		qos->ucast.out.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.in.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
+		qos->ucast.out.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.in.phy = ev->c_phy;
 		qos->ucast.out.phy = ev->p_phy;
 		break;
@@ -6740,8 +6740,8 @@ static void hci_le_cis_estabilished_evt(struct hci_dev *hdev, void *data,
 		qos->ucast.in.latency =
 			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->p_latency),
 					  1000);
-		qos->ucast.out.sdu = le16_to_cpu(ev->c_mtu);
-		qos->ucast.in.sdu = le16_to_cpu(ev->p_mtu);
+		qos->ucast.out.sdu = ev->c_bn ? le16_to_cpu(ev->c_mtu) : 0;
+		qos->ucast.in.sdu = ev->p_bn ? le16_to_cpu(ev->p_mtu) : 0;
 		qos->ucast.out.phy = ev->c_phy;
 		qos->ucast.in.phy = ev->p_phy;
 		break;
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index bbd809414b2f..af86df9de941 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6960,8 +6960,6 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
-	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-
 	if (!hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
 
@@ -7022,10 +7020,13 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 	/* SID has not been set listen for HCI_EV_LE_EXT_ADV_REPORT to update
 	 * it.
 	 */
-	if (conn->sid == HCI_SID_INVALID)
-		__hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
-					 HCI_EV_LE_EXT_ADV_REPORT,
-					 conn->conn_timeout, NULL);
+	if (conn->sid == HCI_SID_INVALID) {
+		err = __hci_cmd_sync_status_sk(hdev, HCI_OP_NOP, 0, NULL,
+					       HCI_EV_LE_EXT_ADV_REPORT,
+					       conn->conn_timeout, NULL);
+		if (err == -ETIMEDOUT)
+			goto done;
+	}
 
 	memset(&cp, 0, sizeof(cp));
 	cp.options = qos->bcast.options;
@@ -7055,6 +7056,12 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 		__hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
 				      0, NULL, HCI_CMD_TIMEOUT);
 
+done:
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+
+	/* Update passive scan since HCI_PA_SYNC flag has been cleared */
+	hci_update_passive_scan_sync(hdev);
+
 	return err;
 }
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 733ff6b758f6..0a00c3f57815 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4808,6 +4808,14 @@ void br_multicast_set_query_intvl(struct net_bridge_mcast *brmctx,
 		intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MIN;
 	}
 
+	if (intvl_jiffies > BR_MULTICAST_QUERY_INTVL_MAX) {
+		br_info(brmctx->br,
+			"trying to set multicast query interval above maximum, setting to %lu (%ums)\n",
+			jiffies_to_clock_t(BR_MULTICAST_QUERY_INTVL_MAX),
+			jiffies_to_msecs(BR_MULTICAST_QUERY_INTVL_MAX));
+		intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MAX;
+	}
+
 	brmctx->multicast_query_interval = intvl_jiffies;
 }
 
@@ -4824,6 +4832,14 @@ void br_multicast_set_startup_query_intvl(struct net_bridge_mcast *brmctx,
 		intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MIN;
 	}
 
+	if (intvl_jiffies > BR_MULTICAST_STARTUP_QUERY_INTVL_MAX) {
+		br_info(brmctx->br,
+			"trying to set multicast startup query interval above maximum, setting to %lu (%ums)\n",
+			jiffies_to_clock_t(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX),
+			jiffies_to_msecs(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX));
+		intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MAX;
+	}
+
 	brmctx->multicast_startup_query_interval = intvl_jiffies;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6a1bce8959af..5026a256bf92 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -31,6 +31,8 @@
 #define BR_MULTICAST_DEFAULT_HASH_MAX 4096
 #define BR_MULTICAST_QUERY_INTVL_MIN msecs_to_jiffies(1000)
 #define BR_MULTICAST_STARTUP_QUERY_INTVL_MIN BR_MULTICAST_QUERY_INTVL_MIN
+#define BR_MULTICAST_QUERY_INTVL_MAX msecs_to_jiffies(86400000) /* 24 hours */
+#define BR_MULTICAST_STARTUP_QUERY_INTVL_MAX BR_MULTICAST_QUERY_INTVL_MAX
 
 #define BR_HWDOM_MAX BITS_PER_LONG
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 2ba2160dd093..cfd32bd02a69 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3603,6 +3603,18 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
 			features &= ~NETIF_F_TSO_MANGLEID;
 	}
 
+	/* NETIF_F_IPV6_CSUM does not support IPv6 extension headers,
+	 * so neither does TSO that depends on it.
+	 */
+	if (features & NETIF_F_IPV6_CSUM &&
+	    (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV6 ||
+	     (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
+	      vlan_get_protocol(skb) == htons(ETH_P_IPV6))) &&
+	    skb_transport_header_was_set(skb) &&
+	    skb_network_header_len(skb) != sizeof(struct ipv6hdr) &&
+	    !ipv6_has_hopopt_jumbo(skb))
+		features &= ~(NETIF_F_IPV6_CSUM | NETIF_F_TSO6 | NETIF_F_GSO_UDP_L4);
+
 	return features;
 }
 
diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
index 464f683e016d..b17909ef6632 100644
--- a/net/hsr/hsr_slave.c
+++ b/net/hsr/hsr_slave.c
@@ -63,8 +63,14 @@ static rx_handler_result_t hsr_handle_frame(struct sk_buff **pskb)
 	skb_push(skb, ETH_HLEN);
 	skb_reset_mac_header(skb);
 	if ((!hsr->prot_version && protocol == htons(ETH_P_PRP)) ||
-	    protocol == htons(ETH_P_HSR))
+	    protocol == htons(ETH_P_HSR)) {
+		if (!pskb_may_pull(skb, ETH_HLEN + HSR_HLEN)) {
+			kfree_skb(skb);
+			goto finish_consume;
+		}
+
 		skb_set_network_header(skb, ETH_HLEN + HSR_HLEN);
+	}
 	skb_reset_mac_len(skb);
 
 	/* Only the frames received over the interlink port will assign a
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 87fd945a0d27..0d3cb2ba6fc8 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -247,8 +247,7 @@ void nf_send_reset(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	if (!oth)
 		return;
 
-	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(oldskb) < 0)
+	if (!skb_dst(oldskb) && nf_reject_fill_skb_dst(oldskb) < 0)
 		return;
 
 	if (skb_rtable(oldskb)->rt_flags & (RTCF_BROADCAST | RTCF_MULTICAST))
@@ -321,8 +320,7 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (iph->frag_off & htons(IP_OFFSET))
 		return;
 
-	if ((hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) &&
-	    nf_reject_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
 	if (skb_csum_unnecessary(skb_in) ||
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 9ae2b2725bf9..c3d64c4b69d7 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -293,7 +293,7 @@ void nf_send_reset6(struct net *net, struct sock *sk, struct sk_buff *oldskb,
 	fl6.fl6_sport = otcph->dest;
 	fl6.fl6_dport = otcph->source;
 
-	if (hook == NF_INET_PRE_ROUTING || hook == NF_INET_INGRESS) {
+	if (!skb_dst(oldskb)) {
 		nf_ip6_route(net, &dst, flowi6_to_flowi(&fl6), false);
 		if (!dst)
 			return;
@@ -397,8 +397,7 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
 		skb_in->dev = net->loopback_dev;
 
-	if ((hooknum == NF_INET_PRE_ROUTING || hooknum == NF_INET_INGRESS) &&
-	    nf_reject6_fill_skb_dst(skb_in) < 0)
+	if (!skb_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
 		return;
 
 	icmpv6_send(skb_in, ICMPV6_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index bbf5b84a70fc..5d21a74c1165 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -35,6 +35,7 @@
 #include <net/xfrm.h>
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <net/seg6.h>
 #include <net/genetlink.h>
 #include <net/seg6_hmac.h>
@@ -271,7 +272,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	if (seg6_hmac_compute(hinfo, srh, &ipv6_hdr(skb)->saddr, hmac_output))
 		return false;
 
-	if (memcmp(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN) != 0)
+	if (crypto_memneq(hmac_output, tlv->hmac, SEG6_HMAC_FIELD_LEN))
 		return false;
 
 	return true;
@@ -295,6 +296,9 @@ int seg6_hmac_info_add(struct net *net, u32 key, struct seg6_hmac_info *hinfo)
 	struct seg6_pernet_data *sdata = seg6_pernet(net);
 	int err;
 
+	if (!__hmac_get_algo(hinfo->alg_id))
+		return -EINVAL;
+
 	err = rhashtable_lookup_insert_fast(&sdata->hmac_infos, &hinfo->node,
 					    rht_params);
 
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a97505b78671..7d4718a57bdc 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1118,7 +1118,9 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
 	return hmac == mp_opt->ahmac;
 }
 
-/* Return false if a subflow has been reset, else return true */
+/* Return false in case of error (or subflow has been reset),
+ * else return true.
+ */
 bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
@@ -1222,7 +1224,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 
 	mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
 	if (!mpext)
-		return true;
+		return false;
 
 	memset(mpext, 0, sizeof(*mpext));
 
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 2a085ec5bfd0..b763729b85e0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -293,6 +293,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	struct mptcp_pm_add_entry *entry = from_timer(entry, timer, add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
+	unsigned int timeout;
 
 	pr_debug("msk=%p\n", msk);
 
@@ -310,6 +311,10 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 		goto out;
 	}
 
+	timeout = mptcp_get_add_addr_timeout(sock_net(sk));
+	if (!timeout)
+		goto out;
+
 	spin_lock_bh(&msk->pm.lock);
 
 	if (!mptcp_pm_should_add_signal_addr(msk)) {
@@ -321,7 +326,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	if (entry->retrans_times < ADD_ADDR_RETRANS_MAX)
 		sk_reset_timer(sk, timer,
-			       jiffies + mptcp_get_add_addr_timeout(sock_net(sk)));
+			       jiffies + timeout);
 
 	spin_unlock_bh(&msk->pm.lock);
 
@@ -363,6 +368,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	struct mptcp_pm_add_entry *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	struct net *net = sock_net(sk);
+	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -372,9 +378,7 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
 
-		sk_reset_timer(sk, &add_entry->add_timer,
-			       jiffies + mptcp_get_add_addr_timeout(net));
-		return true;
+		goto reset_timer;
 	}
 
 	add_entry = kmalloc(sizeof(*add_entry), GFP_ATOMIC);
@@ -388,8 +392,10 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	add_entry->retrans_times = 0;
 
 	timer_setup(&add_entry->add_timer, mptcp_pm_add_timer, 0);
-	sk_reset_timer(sk, &add_entry->add_timer,
-		       jiffies + mptcp_get_add_addr_timeout(net));
+reset_timer:
+	timeout = mptcp_get_add_addr_timeout(net);
+	if (timeout)
+		sk_reset_timer(sk, &add_entry->add_timer, jiffies + timeout);
 
 	return true;
 }
@@ -1737,7 +1743,6 @@ static void __flush_addrs(struct list_head *list)
 static void __reset_counters(struct pm_nl_pernet *pernet)
 {
 	WRITE_ONCE(pernet->add_addr_signal_max, 0);
-	WRITE_ONCE(pernet->add_addr_accept_max, 0);
 	WRITE_ONCE(pernet->local_addr_max, 0);
 	pernet->addrs = 0;
 }
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 2c2e2a67f3b2..6cbe8a7a0e5c 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1745,7 +1745,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
-	u32 idx;
+	u32 idx, tin;
 
 	/* choose flow to insert into */
 	idx = cake_classify(sch, &b, skb, q->flow_mode, &ret);
@@ -1755,6 +1755,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+	tin = (u32)(b - q->tins);
 	idx--;
 	flow = &b->flows[idx];
 
@@ -1922,13 +1923,22 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->buffer_max_used = q->buffer_used;
 
 	if (q->buffer_used > q->buffer_limit) {
+		bool same_flow = false;
 		u32 dropped = 0;
+		u32 drop_id;
 
 		while (q->buffer_used > q->buffer_limit) {
 			dropped++;
-			cake_drop(sch, to_free);
+			drop_id = cake_drop(sch, to_free);
+
+			if ((drop_id >> 16) == tin &&
+			    (drop_id & 0xFFFF) == idx)
+				same_flow = true;
 		}
 		b->drop_overlimit += dropped;
+
+		if (same_flow)
+			return NET_XMIT_CN;
 	}
 	return NET_XMIT_SUCCESS;
 }
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 1021681a5718..2c13de8bf16f 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -592,7 +592,7 @@ htb_change_class_mode(struct htb_sched *q, struct htb_class *cl, s64 *diff)
  */
 static inline void htb_activate(struct htb_sched *q, struct htb_class *cl)
 {
-	WARN_ON(cl->level || !cl->leaf.q || !cl->leaf.q->q.qlen);
+	WARN_ON(cl->level || !cl->leaf.q);
 
 	if (!cl->prio_activity) {
 		cl->prio_activity = 1 << cl->prio;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index cdd445d40b94..02e08ac1da3a 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2565,8 +2565,9 @@ static void smc_listen_work(struct work_struct *work)
 			goto out_decl;
 	}
 
-	smc_listen_out_connected(new_smc);
 	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
+	/* smc_listen_out() will release smcsk */
+	smc_listen_out_connected(new_smc);
 	goto out_free;
 
 out_unlock:
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 6385329ef98d..ee92ce3255f9 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1774,6 +1774,9 @@ int decrypt_skb(struct sock *sk, struct scatterlist *sgout)
 	return tls_decrypt_sg(sk, NULL, sgout, &darg);
 }
 
+/* All records returned from a recvmsg() call must have the same type.
+ * 0 is not a valid content type. Use it as "no type reported, yet".
+ */
 static int tls_record_content_type(struct msghdr *msg, struct tls_msg *tlm,
 				   u8 *control)
 {
@@ -2017,8 +2020,10 @@ int tls_sw_recvmsg(struct sock *sk,
 	if (err < 0)
 		goto end;
 
+	/* process_rx_list() will set @control if it processed any records */
 	copied = err;
-	if (len <= copied || (copied && control != TLS_RECORD_TYPE_DATA) || rx_more)
+	if (len <= copied || rx_more ||
+	    (control && control != TLS_RECORD_TYPE_DATA))
 		goto end;
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index f01f9e878106..1ef6f7829d29 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -624,8 +624,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
+			unsigned int len, payload_len;
+			struct virtio_vsock_hdr *hdr;
 			struct sk_buff *skb;
-			unsigned int len;
 
 			if (!virtio_transport_more_replies(vsock)) {
 				/* Stop rx until the device processes already
@@ -642,12 +643,19 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			vsock->rx_buf_nr--;
 
 			/* Drop short/long packets */
-			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
+			if (unlikely(len < sizeof(*hdr) ||
 				     len > virtio_vsock_skb_len(skb))) {
 				kfree_skb(skb);
 				continue;
 			}
 
+			hdr = virtio_vsock_hdr(skb);
+			payload_len = le32_to_cpu(hdr->len);
+			if (unlikely(payload_len > len - sizeof(*hdr))) {
+				kfree_skb(skb);
+				continue;
+			}
+
 			virtio_vsock_skb_rx_put(skb);
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 439985e29fbc..e4cd29100007 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -43,17 +43,6 @@
 /// For more details see [self].
 pub struct KVmalloc;
 
-/// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
-fn aligned_size(new_layout: Layout) -> usize {
-    // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
-    let layout = new_layout.pad_to_align();
-
-    // Note that `layout.size()` (after padding) is guaranteed to be a multiple of `layout.align()`
-    // which together with the slab guarantees means the `krealloc` will return a properly aligned
-    // object (see comments in `kmalloc()` for more information).
-    layout.size()
-}
-
 /// # Invariants
 ///
 /// One of the following: `krealloc`, `vrealloc`, `kvrealloc`.
@@ -87,7 +76,7 @@ unsafe fn call(
         old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
-        let size = aligned_size(layout);
+        let size = layout.size();
         let ptr = match ptr {
             Some(ptr) => {
                 if old_layout.size() == 0 {
@@ -122,6 +111,17 @@ unsafe fn call(
     }
 }
 
+impl Kmalloc {
+    /// Returns a [`Layout`] that makes [`Kmalloc`] fulfill the requested size and alignment of
+    /// `layout`.
+    pub fn aligned_layout(layout: Layout) -> Layout {
+        // Note that `layout.size()` (after padding) is guaranteed to be a multiple of
+        // `layout.align()` which together with the slab guarantees means that `Kmalloc` will return
+        // a properly aligned object (see comments in `kmalloc()` for more information).
+        layout.pad_to_align()
+    }
+}
+
 // SAFETY: `realloc` delegates to `ReallocFunc::call`, which guarantees that
 // - memory remains valid until it is explicitly freed,
 // - passing a pointer to a valid memory allocation is OK,
@@ -134,6 +134,8 @@ unsafe fn realloc(
         old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
+        let layout = Kmalloc::aligned_layout(layout);
+
         // SAFETY: `ReallocFunc::call` has the same safety requirements as `Allocator::realloc`.
         unsafe { ReallocFunc::KREALLOC.call(ptr, layout, old_layout, flags) }
     }
@@ -175,6 +177,10 @@ unsafe fn realloc(
         old_layout: Layout,
         flags: Flags,
     ) -> Result<NonNull<[u8]>, AllocError> {
+        // `KVmalloc` may use the `Kmalloc` backend, hence we have to enforce a `Kmalloc`
+        // compatible layout.
+        let layout = Kmalloc::aligned_layout(layout);
+
         // TODO: Support alignments larger than PAGE_SIZE.
         if layout.align() > bindings::PAGE_SIZE {
             pr_warn!("KVmalloc does not support alignments larger than PAGE_SIZE yet.\n");
diff --git a/rust/kernel/alloc/allocator_test.rs b/rust/kernel/alloc/allocator_test.rs
index c37d4c0c64e9..ec13385489df 100644
--- a/rust/kernel/alloc/allocator_test.rs
+++ b/rust/kernel/alloc/allocator_test.rs
@@ -22,6 +22,17 @@
 pub type Vmalloc = Kmalloc;
 pub type KVmalloc = Kmalloc;
 
+impl Cmalloc {
+    /// Returns a [`Layout`] that makes [`Kmalloc`] fulfill the requested size and alignment of
+    /// `layout`.
+    pub fn aligned_layout(layout: Layout) -> Layout {
+        // Note that `layout.size()` (after padding) is guaranteed to be a multiple of
+        // `layout.align()` which together with the slab guarantees means that `Kmalloc` will return
+        // a properly aligned object (see comments in `kmalloc()` for more information).
+        layout.pad_to_align()
+    }
+}
+
 extern "C" {
     #[link_name = "aligned_alloc"]
     fn libc_aligned_alloc(align: usize, size: usize) -> *mut crate::ffi::c_void;
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index f5d05297d59e..9a78fd36542d 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -2144,12 +2144,12 @@ static int __init apparmor_nf_ip_init(void)
 __initcall(apparmor_nf_ip_init);
 #endif
 
-static char nulldfa_src[] = {
+static char nulldfa_src[] __aligned(8) = {
 	#include "nulldfa.in"
 };
 static struct aa_dfa *nulldfa;
 
-static char stacksplitdfa_src[] = {
+static char stacksplitdfa_src[] __aligned(8) = {
 	#include "stacksplitdfa.in"
 };
 struct aa_dfa *stacksplitdfa;
diff --git a/sound/core/timer.c b/sound/core/timer.c
index d774b9b71ce2..a0dcb4ebb059 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2139,14 +2139,14 @@ static int snd_utimer_create(struct snd_timer_uinfo *utimer_info,
 		goto err_take_id;
 	}
 
+	utimer->id = utimer_id;
+
 	utimer->name = kasprintf(GFP_KERNEL, "snd-utimer%d", utimer_id);
 	if (!utimer->name) {
 		err = -ENOMEM;
 		goto err_get_name;
 	}
 
-	utimer->id = utimer_id;
-
 	tid.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION;
 	tid.dev_class = SNDRV_TIMER_CLASS_GLOBAL;
 	tid.card = -1;
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 840cde49935d..b31b15cf453a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10576,6 +10576,8 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x84e7, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_MIC3),
 	SND_PCI_QUIRK(0x103c, 0x8519, "HP Spectre x360 15-df0xxx", ALC285_FIXUP_HP_SPECTRE_X360),
 	SND_PCI_QUIRK(0x103c, 0x8537, "HP ProBook 440 G6", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8548, "HP EliteBook x360 830 G6", ALC285_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x854a, "HP EliteBook 830 G6", ALC285_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x860f, "HP ZBook 15 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index 077af9e2af8d..5cc7d9880180 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -65,7 +65,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 			dma_size = page_count * ACP_PAGE_SIZE;
 			adata->bin_buf = dma_alloc_coherent(&pci->dev, dma_size,
 							    &adata->sha_dma_addr,
-							    GFP_ATOMIC);
+							    GFP_KERNEL);
 			if (!adata->bin_buf)
 				return -ENOMEM;
 		}
@@ -77,7 +77,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 			adata->data_buf = dma_alloc_coherent(&pci->dev,
 							     ACP_DEFAULT_DRAM_LENGTH,
 							     &adata->dma_addr,
-							     GFP_ATOMIC);
+							     GFP_KERNEL);
 			if (!adata->data_buf)
 				return -ENOMEM;
 		}
@@ -90,7 +90,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 			adata->sram_data_buf = dma_alloc_coherent(&pci->dev,
 								  ACP_DEFAULT_SRAM_LENGTH,
 								  &adata->sram_dma_addr,
-								  GFP_ATOMIC);
+								  GFP_KERNEL);
 			if (!adata->sram_data_buf)
 				return -ENOMEM;
 		}
diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 1cb52373e70f..db2c9bac00ad 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 		u16 cs_len;
 		u8 cs_type;
 
-		if (len < sizeof(*p))
+		if (len < sizeof(*cs_desc))
 			break;
 		cs_len = le16_to_cpu(cs_desc->wLength);
 		if (len < cs_len)
diff --git a/sound/usb/validate.c b/sound/usb/validate.c
index 4f4e8e87a14c..a0d55b77c994 100644
--- a/sound/usb/validate.c
+++ b/sound/usb/validate.c
@@ -285,7 +285,7 @@ static const struct usb_desc_validator audio_validators[] = {
 	/* UAC_VERSION_3, UAC3_EXTENDED_TERMINAL: not implemented yet */
 	FUNC(UAC_VERSION_3, UAC3_MIXER_UNIT, validate_mixer_unit),
 	FUNC(UAC_VERSION_3, UAC3_SELECTOR_UNIT, validate_selector_unit),
-	FUNC(UAC_VERSION_3, UAC_FEATURE_UNIT, validate_uac3_feature_unit),
+	FUNC(UAC_VERSION_3, UAC3_FEATURE_UNIT, validate_uac3_feature_unit),
 	/*  UAC_VERSION_3, UAC3_EFFECT_UNIT: not implemented yet */
 	FUNC(UAC_VERSION_3, UAC3_PROCESSING_UNIT, validate_processing_unit),
 	FUNC(UAC_VERSION_3, UAC3_EXTENSION_UNIT, validate_processing_unit),
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 2e6648a2b2c0..ac7ec6f94023 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -198,6 +198,7 @@ set_limits 1 9 2>/dev/null
 check "get_limits" "${default_limits}" "subflows above hard limit"
 
 set_limits 8 8
+flush_endpoint  ## to make sure it doesn't affect the limits
 check "get_limits" "$(format_limits 8 8)" "set limits"
 
 flush_endpoint

