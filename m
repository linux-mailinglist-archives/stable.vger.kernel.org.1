Return-Path: <stable+bounces-249110-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHGLCxDkCWo6twQAu9opvQ
	(envelope-from <stable+bounces-249110-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:51:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FA56226B
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A538D3034DDF
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BE3BAD81;
	Sun, 17 May 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bDsQiXdb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D1F361641;
	Sun, 17 May 2026 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032387; cv=none; b=XIq/0EkXV6teO/Z1OOPx/zVCcOuMOs9DyQ/pVw46wNH67xznJSm09gK9mYWvX5q7u5zF5VJchVFEGDUfBovSKoFxkNritnFP+M3c4BC72BSPeHmr67NRcToAgTeuXuY17b1671eFEFiyHWN8O7GECaGT+jQA2OlDPJuIb1DPjAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032387; c=relaxed/simple;
	bh=keAa1hXN8H43PVRSpbL6h2wMfKSYI8XnXZKELSCY+Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gT+m8GqVUc5OYLvDI7akPTGtAhmpWu2b93JarJJzQXYhX0A+A+gZ23wSREXPjvne7sxoBWsv+m/71IITTyVgVszqBOPGYT8IO3ysoSzZ1bBTmlLIf1iVxULq6V5ctqTWdP0YFvYm0/doc6eFjizaZamxUXRIUWMiFjvJA23uOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bDsQiXdb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E7EC2BCB8;
	Sun, 17 May 2026 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779032386;
	bh=keAa1hXN8H43PVRSpbL6h2wMfKSYI8XnXZKELSCY+Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bDsQiXdbsk1zrw0bhu9tfDucuaai6dzDrVTN65RvlE9ptn0d9yugnab6hoQ6rXwDT
	 A15bSzeshlkZPlneqv6fexeiOLtGIjYvOOJvDGMM9nKEqyFKPq7tcgmZbk+h8d/bsz
	 u7ykuvIspUr7MbFS8zx1P9Zxm+pMTo2AKSlSF6N0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.9
Date: Sun, 17 May 2026 17:39:43 +0200
Message-ID: <2026051743-marvelous-fantastic-8301@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026051743-alienate-rubbing-8458@gregkh>
References: <2026051743-alienate-rubbing-8458@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B26FA56226B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249110-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.13.179.208:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,0.0.0.15:email,0.0.0.51:email,linuxfoundation.org:dkim,base.sk:url,1c0e000:email]
X-Rspamd-Action: no action

diff --git a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
index 809fda45b3bd..42022401d0ff 100644
--- a/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
+++ b/Documentation/devicetree/bindings/media/rockchip,vdec.yaml
@@ -28,16 +28,20 @@ properties:
 
   reg:
     minItems: 1
-    items:
-      - description: The function configuration registers base
-      - description: The link table configuration registers base
-      - description: The cache configuration registers base
+    maxItems: 3
 
   reg-names:
-    items:
-      - const: function
-      - const: link
-      - const: cache
+    oneOf:
+      - items:
+          - const: link
+          - const: function
+          - const: cache
+      - items:
+          - const: function
+          - const: link
+          - const: cache
+        deprecated: true
+        description: Use link,function,cache block order instead.
 
   interrupts:
     maxItems: 1
@@ -123,6 +127,8 @@ allOf:
           minItems: 5
         reset-names:
           minItems: 5
+      required:
+        - reg-names
     else:
       properties:
         reg:
diff --git a/Makefile b/Makefile
index a0565b83ae40..9da9c1f3b238 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 8
+SUBLEVEL = 9
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts
index 7de24d60bcd1..127be0fc27c2 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-d-rpi-5-b.dts
@@ -35,3 +35,17 @@ &gio_aon {
 		"PMIC_SCL", // AON_SGPIO_04
 		"PMIC_SDA"; // AON_SGPIO_05
 };
+
+&pinctrl {
+	compatible = "brcm,bcm2712d0-pinctrl";
+	reg = <0x7d504100 0x20>;
+};
+
+&pinctrl_aon {
+	compatible = "brcm,bcm2712d0-aon-pinctrl";
+	reg = <0x7d510700 0x1c>;
+};
+
+&uart10 {
+	interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index eec2cd6c6d32..7f6e39e27ce5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -162,6 +162,8 @@ rtc@51 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -177,6 +179,11 @@ flash@0 {
 	};
 };
 
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
index af6258b2fe82..580ee9b3026e 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
@@ -89,6 +89,8 @@ &emdio2 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 853b01452813..af74e77efabc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1721,6 +1721,10 @@ i2c1_scl_gpio: i2c1-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 0x1 0x7>;
 			};
 
+			esdhc0_cd_wp_pins: iic2-sdhc-pins {
+				pinctrl-single,bits = <0x0 0x6 0x7>;
+			};
+
 			i2c2_scl: i2c2-scl-pins {
 				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
 			};
@@ -1753,6 +1757,26 @@ i2c5_scl_gpio: i2c5-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
 			};
 
+			fspi_data74_pins: xspi1-data74-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 15)>;
+			};
+
+			fspi_data30_pins: xspi1-data30-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 18)>;
+			};
+
+			fspi_dqs_sck_cs10_pins: xspi1-base-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 21)>;
+			};
+
+			esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 24)>;
+			};
+
+			gpio0_14_12_pins: sdhc1-dir-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 27) (0x7 << 27)>;
+			};
+
 			i2c6_scl: i2c6-scl-pins {
 				pinctrl-single,bits = <0x4 0x2 0x7>;
 			};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
index eafef8718a0f..8920326a0673 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -223,6 +223,8 @@ ethernet_phy8: ethernet-phy@15 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
index e914291e63a1..e1344942eaae 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -30,6 +30,8 @@ &esdhc1 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -80,3 +82,8 @@ rtc@6f {
 		reg = <0x6f>;
 	};
 };
+
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};
diff --git a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
index 5932ba238a8a..f64c05dc50f8 100644
--- a/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95-toradex-smarc.dtsi
@@ -262,7 +262,6 @@ &gpio3 {
 			  "",
 			  "",
 			  "",
-			  "",
 			  "PMIC_SD2_VSEL";
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
index 6079e67ea829..ba0f7e5c89a0 100644
--- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
+++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
@@ -2445,7 +2445,7 @@ pcie1_phy: phy@1c0e000 {
 			reg = <0 0x01c0e000 0 0x1000>;
 			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
 				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
-				 <&gcc GCC_PCIE_CLKREF_EN>,
+				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_PCIE1_PHY_RCHNG_CLK>,
 				 <&gcc GCC_PCIE_1_PIPE_CLK>;
 			clock-names = "aux",
diff --git a/arch/arm64/boot/dts/qcom/lemans.dtsi b/arch/arm64/boot/dts/qcom/lemans.dtsi
index 808827b83553..2db2ab9cb2e0 100644
--- a/arch/arm64/boot/dts/qcom/lemans.dtsi
+++ b/arch/arm64/boot/dts/qcom/lemans.dtsi
@@ -1512,7 +1512,7 @@ i2c20: i2c@898000 {
 				reg = <0x0 0x898000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_i2c20_default>;
@@ -1539,7 +1539,7 @@ spi20: spi@898000 {
 				reg = <0x0 0x898000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_spi20_default>;
@@ -1564,7 +1564,7 @@ &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>,
 			uart20: serial@898000 {
 				compatible = "qcom,geni-uart";
 				reg = <0x0 0x00898000 0x0 0x4000>;
-				interrupts = <GIC_SPI 834 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP2_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_uart20_default>;
@@ -2510,7 +2510,7 @@ i2c13: i2c@a98000 {
 				reg = <0x0 0xa98000 0x0 0x4000>;
 				#address-cells = <1>;
 				#size-cells = <0>;
-				interrupts = <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 835 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
 				clock-names = "se";
 				pinctrl-0 = <&qup_i2c13_default>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index e99bdbc2e0cb..b1a6f10adf26 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -398,7 +398,7 @@ AM62AX_IOPAD(0x01d4, PIN_INPUT, 7) /* (C15) UART0_RTSn.GPIO1_23 */
 
 	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
-			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
+			AM62AX_IOPAD(0x07c, PIN_OUTPUT, 7) /* (N22) GPMC0_CLK.GPIO0_31 */
 		>;
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
index ec8ff4587715..dc0d3cf2f985 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-clover.dts
@@ -26,7 +26,7 @@ reg_3v3_dp: regulator-3v3-dp {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_21_dp>;
 		/* Aquila GPIO_21_DP (AQUILA B57) */
-		gpio = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+		gpio = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
index f48601ae38b7..d3677c2c2547 100644
--- a/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
+++ b/arch/arm64/boot/dts/ti/k3-am69-aquila-dev.dts
@@ -33,7 +33,7 @@ reg_3v3_dp: regulator-3v3-dp {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_21_dp>;
 		/* Aquila GPIO_21_DP (AQUILA B57) */
-		gpio = <&main_gpio0 37 GPIO_ACTIVE_HIGH>;
+		gpio = <&main_gpio0 21 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 		regulator-max-microvolt = <3300000>;
 		regulator-min-microvolt = <3300000>;
diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 162fb1736f55..97ec05d68bbb 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -70,6 +70,8 @@
 #define XDDR5_BUS_WIDTH_32		1
 #define XDDR5_BUS_WIDTH_16		2
 
+#define MC_NAME_LEN			32
+
 /**
  * struct ecc_error_info - ECC error log information.
  * @burstpos:		Burst position.
@@ -760,110 +762,122 @@ static void versal_edac_release(struct device *dev)
 	kfree(dev);
 }
 
-static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
+static void remove_one_mc(struct mc_priv *priv, int i)
+{
+	struct mem_ctl_info *mci;
+
+	mci = priv->mci[i];
+	device_unregister(mci->pdev);
+	edac_mc_del_mc(mci->pdev);
+	edac_mc_free(mci);
+}
+
+static int init_one_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
 {
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
 	struct mem_ctl_info *mci;
+	char name[MC_NAME_LEN];
 	struct device *dev;
 	enum dev_type dt;
-	char *name;
-	int rc, i;
-
-	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		config = priv->adec[CONF + i * ADEC_NUM];
-		num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
-		rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
-		dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
-
-		switch (dwidth) {
-		case XDDR5_BUS_WIDTH_16:
-			dt = DEV_X16;
-			break;
-		case XDDR5_BUS_WIDTH_32:
-			dt = DEV_X32;
-			break;
-		case XDDR5_BUS_WIDTH_64:
-			dt = DEV_X64;
-			break;
-		default:
-			dt = DEV_UNKNOWN;
-		}
+	int rc;
 
-		if (dt == DEV_UNKNOWN)
-			continue;
+	config = priv->adec[CONF + i * ADEC_NUM];
+	num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
+	rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
+	dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
+
+	switch (dwidth) {
+	case XDDR5_BUS_WIDTH_16:
+		dt = DEV_X16;
+		break;
+	case XDDR5_BUS_WIDTH_32:
+		dt = DEV_X32;
+		break;
+	case XDDR5_BUS_WIDTH_64:
+		dt = DEV_X64;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
 
-		/* Find the first enabled device and register that one. */
-		layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-		layers[0].size = rank;
-		layers[0].is_virt_csrow = true;
-		layers[1].type = EDAC_MC_LAYER_CHANNEL;
-		layers[1].size = num_chans;
-		layers[1].is_virt_csrow = false;
+	if (dt == DEV_UNKNOWN)
+		return 0;
 
-		rc = -ENOMEM;
-		mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
-				    sizeof(struct mc_priv));
-		if (!mci) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
-			goto err_alloc;
-		}
+	/* Find the first enabled device and register that one. */
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = rank;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = num_chans;
+	layers[1].is_virt_csrow = false;
+
+	rc = -ENOMEM;
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return rc;
+
+	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers, sizeof(struct mc_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
+		goto err_dev_free;
+	}
 
-		priv->mci[i] = mci;
-		priv->dwidth = dt;
+	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
 
-		dev = kzalloc_obj(*dev);
-		dev->release = versal_edac_release;
-		name = kmalloc(32, GFP_KERNEL);
-		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
-		dev->init_name = name;
-		rc = device_register(dev);
-		if (rc)
-			goto err_alloc;
+	dev->init_name = name;
+	dev->release = versal_edac_release;
 
-		mci->pdev = dev;
+	rc = device_register(dev);
+	if (rc)
+		goto err_mc_free;
 
-		platform_set_drvdata(pdev, priv);
+	mci->pdev = dev;
+	mc_init(mci, dev);
 
-		mc_init(mci, dev);
-		rc = edac_mc_add_mc(mci);
-		if (rc) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
-			goto err_alloc;
-		}
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
+		goto err_unreg;
 	}
-	return 0;
 
-err_alloc:
-	while (i--) {
-		mci = priv->mci[i];
-		if (!mci)
-			continue;
-
-		if (mci->pdev) {
-			device_unregister(mci->pdev);
-			edac_mc_del_mc(mci->pdev);
-		}
+	priv->mci[i] = mci;
+	priv->dwidth = dt;
 
-		edac_mc_free(mci);
-	}
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+
+err_unreg:
+	device_unregister(mci->pdev);
+err_mc_free:
+	edac_mc_free(mci);
+err_dev_free:
+	kfree(dev);
 
 	return rc;
 }
 
-static void remove_versalnet(struct mc_priv *priv)
+static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 {
-	struct mem_ctl_info *mci;
-	int i;
+	int rc, i;
 
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		device_unregister(priv->mci[i]->pdev);
-		mci = edac_mc_del_mc(priv->mci[i]->pdev);
-		if (!mci)
-			return;
+		rc = init_one_mc(priv, pdev, i);
+		if (rc) {
+			while (i--)
+				remove_one_mc(priv, i);
 
-		edac_mc_free(mci);
+			return rc;
+		}
 	}
+	return 0;
+}
+
+static void remove_versalnet(struct mc_priv *priv)
+{
+	for (int i = 0; i < NUM_CONTROLLERS; i++)
+		remove_one_mc(priv, i);
 }
 
 static int mc_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 29b400cdd6d5..72a5a29e63f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1735,7 +1735,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 			alloc_flags = 0;
 		} else {
-			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
+			alloc_flags = AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE |
+				AMDGPU_GEM_CREATE_VRAM_CLEARED;
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6d8531f9b882..2ec69fa05cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3539,8 +3539,12 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	 * that checks whether the PSP is running. A solution for those issues
 	 * in the APU is to trigger a GPU reset, but this should be done during
 	 * the unload phase to avoid adding boot latency and screen flicker.
+	 * GFX V11 has GC block as default off IP. Every time AMDGPU driver sends
+	 * a request to PMFW to unload MP1, PMFW will put GC in reset and power down
+	 * the voltage. Hence, skipping reset for APUs with GFX V11 or later.
 	 */
-	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
+	if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu &&
+		amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 0, 0)) {
 		r = amdgpu_asic_reset(adev);
 		if (r)
 			dev_err(adev->dev, "asic reset on %s failed\n", __func__);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index bc772ca3dab7..b6f849d51c2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -262,12 +262,19 @@ void amdgpu_gart_table_ram_free(struct amdgpu_device *adev)
  */
 int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
 {
+	int r;
+
 	if (adev->gart.bo != NULL)
 		return 0;
 
-	return amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
-				       AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
-				       NULL, (void *)&adev->gart.ptr);
+	r = amdgpu_bo_create_kernel(adev,  adev->gart.table_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_VRAM, &adev->gart.bo,
+				    NULL, (void *)&adev->gart.ptr);
+	if (r)
+		return r;
+
+	memset_io(adev->gart.ptr, adev->gart.gart_pte_flags, adev->gart.table_size);
+	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index cb0fb1a989d2..14fd31d3437a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -553,15 +553,18 @@ void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 
 int amdgpu_ring_init_mqd(struct amdgpu_ring *ring);
 
-static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, int idx)
+static inline u32 amdgpu_ib_get_value(struct amdgpu_ib *ib, uint32_t idx)
 {
-	return ib->ptr[idx];
+	if (idx < ib->length_dw)
+		return ib->ptr[idx];
+	return 0;
 }
 
-static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, int idx,
+static inline void amdgpu_ib_set_value(struct amdgpu_ib *ib, uint32_t idx,
 				       uint32_t value)
 {
-	ib->ptr[idx] = value;
+	if (idx < ib->length_dw)
+		ib->ptr[idx] = value;
 }
 
 int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index a7d8f1ce6ac2..97cf2f4c58a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -698,6 +698,9 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, struct amdgpu_ib *ib,
 	uint64_t addr;
 	int r;
 
+	if (lo >= ib->length_dw || hi >= ib->length_dw)
+		return -EINVAL;
+
 	if (index == 0xffffffff)
 		index = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 22e2e5b47341..f078db3fef79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,8 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
 
@@ -108,11 +110,19 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 				struct dma_fence **fence)
 {
+	struct amdgpu_device *adev = p->adev;
+
 	if (p->needs_flush)
 		atomic64_inc(&p->vm->tlb_seq);
 
 	mb();
-	amdgpu_device_flush_hdp(p->adev, NULL);
+	/* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return 0;
+
+	amdgpu_device_flush_hdp(adev, NULL);
+	up_read(&adev->reset_domain->sem);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 427975b5a1d9..8d73193de06f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -64,6 +64,11 @@
 #define regPC_CONFIG_CNTL_1		0x194d
 #define regPC_CONFIG_CNTL_1_BASE_IDX	1
 
+#define regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0               0x0030
+#define regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0_BASE_IDX      1
+#define regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0               0x0031
+#define regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0_BASE_IDX      1
+
 #define regCP_GFX_MQD_CONTROL_DEFAULT                                             0x00000100
 #define regCP_GFX_HQD_VMID_DEFAULT                                                0x00000000
 #define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                                      0x00000000
@@ -5187,11 +5192,27 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(struct amdgpu_device *adev)
 		amdgpu_gfx_off_ctrl(adev, true);
 	} else {
 		preempt_disable();
-		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
-		clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
-		clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_UPPER);
-		if (clock_counter_hi_pre != clock_counter_hi_after)
-			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0, regGOLDEN_TSC_COUNT_LOWER);
+		if (amdgpu_ip_version(adev, SMUIO_HWIP, 0) < IP_VERSION(15, 0, 0)) {
+			clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER);
+			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_LOWER);
+			clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER);
+			if (clock_counter_hi_pre != clock_counter_hi_after)
+				clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+						regGOLDEN_TSC_COUNT_LOWER);
+		} else {
+			clock_counter_hi_pre = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0);
+			clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0);
+			clock_counter_hi_after = (uint64_t)RREG32_SOC15(SMUIO, 0,
+					regGOLDEN_TSC_COUNT_UPPER_smu_15_0_0);
+			if (clock_counter_hi_pre != clock_counter_hi_after)
+				clock_counter_lo = (uint64_t)RREG32_SOC15(SMUIO, 0,
+						regGOLDEN_TSC_COUNT_LOWER_smu_15_0_0);
+		}
 		preempt_enable();
 	}
 	clock = clock_counter_lo | (clock_counter_hi_after << 32ULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7e9d753f4a80..8fe6d0db3dad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5660,9 +5660,6 @@ static void gfx_v9_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	/* we only allocate 32bit for each seq wb address */
-	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
 	/* write fence seq to the "addr" */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index faac21ee5739..312604847e06 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -30,34 +30,6 @@
 #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
 #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
 
-static int
-mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
-{
-	int ret;
-
-	ret = amdgpu_bo_reserve(bo, true);
-	if (ret) {
-		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
-		goto err_reserve_bo_failed;
-	}
-
-	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
-	if (ret) {
-		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
-		goto err_map_bo_gart_failed;
-	}
-
-	amdgpu_bo_unreserve(bo);
-	bo = amdgpu_bo_ref(bo);
-
-	return 0;
-
-err_map_bo_gart_failed:
-	amdgpu_bo_unreserve(bo);
-err_reserve_bo_failed:
-	return ret;
-}
-
 static int
 mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 			      struct amdgpu_userq_mgr *uq_mgr,
@@ -65,55 +37,62 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 			      uint64_t wptr)
 {
 	struct amdgpu_bo_va_mapping *wptr_mapping;
-	struct amdgpu_vm *wptr_vm;
 	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
+	struct amdgpu_bo *obj;
+	struct amdgpu_vm *vm = queue->vm;
+	struct drm_exec exec;
 	int ret;
 
-	wptr_vm = queue->vm;
-	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
-	if (ret)
-		return ret;
-
 	wptr &= AMDGPU_GMC_HOLE_MASK;
-	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
-	amdgpu_bo_unreserve(wptr_vm->root.bo);
-	if (!wptr_mapping) {
-		DRM_ERROR("Failed to lookup wptr bo\n");
-		return -EINVAL;
-	}
 
-	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
-	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
-		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
-		return -EINVAL;
-	}
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto fail_lock;
+
+		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
+		if (!wptr_mapping) {
+			ret = -EINVAL;
+			goto fail_lock;
+		}
 
-	ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
-	if (ret) {
-		DRM_ERROR("Failed to map wptr bo to GART\n");
-		return ret;
+		obj = wptr_mapping->bo_va->base.bo;
+		ret = drm_exec_lock_obj(&exec, &obj->tbo.base);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto fail_lock;
 	}
 
-	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
-	if (ret) {
-		DRM_ERROR("Failed to reserve wptr bo\n");
-		return ret;
+	wptr_obj->obj = amdgpu_bo_ref(wptr_mapping->bo_va->base.bo);
+	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
+		ret = -EINVAL;
+		goto fail_map;
 	}
 
 	/* TODO use eviction fence instead of pinning. */
 	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
 	if (ret) {
-		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
-		goto unresv_bo;
+		DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
+		goto fail_map;
+	}
+
+	ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
+	if (ret) {
+		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
+		goto fail_map;
 	}
 
 	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
-	amdgpu_bo_unreserve(wptr_obj->obj);
 
+	drm_exec_fini(&exec);
 	return 0;
 
-unresv_bo:
-	amdgpu_bo_unreserve(wptr_obj->obj);
+fail_map:
+	amdgpu_bo_unref(&wptr_obj->obj);
+fail_lock:
+	drm_exec_fini(&exec);
 	return ret;
 
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index db14a1a326d2..b6f832c53860 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -54,6 +54,8 @@
 #define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                                                  3
 #define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                                          0x4f0af6
 #define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                                                 3
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                                              0x0021
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                                                     2
 
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
@@ -65,7 +67,12 @@ static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10);
+	else
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
index 73a709773e85..2a8582e87f2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -32,6 +32,7 @@
 #include "mp/mp_15_0_0_sh_mask.h"
 
 MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_15_0_0_ta.bin");
 
 static int psp_v15_0_0_init_microcode(struct psp_context *psp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index f38004e6064e..4d0dc58c9045 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -890,7 +890,7 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 	/* zero in first two bits */
-	BUG_ON(addr & 0x3);
+	WARN_ON(addr & 0x3);
 	amdgpu_ring_write(ring, lower_32_bits(addr));
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
@@ -900,7 +900,7 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 		addr += 4;
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 		/* zero in first two bits */
-		BUG_ON(addr & 0x3);
+		WARN_ON(addr & 0x3);
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(seq));
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 02d5c5af65f2..2fe5b3fe287f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1909,7 +1909,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1930,6 +1930,11 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
 	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -1946,8 +1951,8 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
-	/* Check length */
 	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -1955,9 +1960,19 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
+		uint64_t buf_end;
 
 		if (msg[0] != RDECODE_MESSAGE_CREATE)
 			continue;
@@ -1965,14 +1980,16 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || check_add_overflow(offset, size, &buf_end) ||
+		    buf_end > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
 		}
 
 		create = ptr + addr + offset - start;
 
-		/* H246, HEVC and VP9 can run on any instance */
+		/* H264, HEVC and VP9 can run on any instance */
 		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
 			continue;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d17219be50f3..63d37b475c2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1826,7 +1826,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers;
+	uint32_t *msg, num_buffers, len_dw;
 	struct amdgpu_bo *bo;
 	uint64_t start, end;
 	unsigned int i;
@@ -1847,6 +1847,11 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		return -EINVAL;
 	}
 
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
 	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
@@ -1863,8 +1868,8 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 
 	msg = ptr + addr - start;
 
-	/* Check length */
 	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
 		r = -EINVAL;
 		goto out;
 	}
@@ -1872,9 +1877,19 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	if (msg[3] != RDECODE_MSG_CREATE)
 		goto out;
 
+	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
 		uint32_t offset, size, *create;
+		uint64_t buf_end;
 
 		if (msg[0] != RDECODE_MESSAGE_CREATE)
 			continue;
@@ -1882,7 +1897,9 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 		offset = msg[1];
 		size = msg[2];
 
-		if (offset + size > end) {
+		if (size < 4 || check_add_overflow(offset, size, &buf_end) ||
+		    buf_end > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
 			r = -EINVAL;
 			goto out;
 		}
@@ -1913,9 +1930,10 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 static int vcn_v4_0_enc_find_ib_param(struct amdgpu_ib *ib, uint32_t id, int start)
 {
 	int i;
+	uint32_t len;
 
-	for (i = start; i < ib->length_dw && ib->ptr[i] >= 8; i += ib->ptr[i] / 4) {
-		if (ib->ptr[i + 1] == id)
+	for (i = start; (len = amdgpu_ib_get_value(ib, i)) >= 8; i += len / 4) {
+		if (amdgpu_ib_get_value(ib, i + 1) == id)
 			return i;
 	}
 	return -1;
@@ -1926,8 +1944,6 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_ib *ib)
 {
 	struct amdgpu_ring *ring = amdgpu_job_ring(job);
-	struct amdgpu_vcn_decode_buffer *decode_buffer;
-	uint64_t addr;
 	uint32_t val;
 	int idx = 0, sidx;
 
@@ -1938,20 +1954,22 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 	while ((idx = vcn_v4_0_enc_find_ib_param(ib, RADEON_VCN_ENGINE_INFO, idx)) >= 0) {
 		val = amdgpu_ib_get_value(ib, idx + 2); /* RADEON_VCN_ENGINE_TYPE */
 		if (val == RADEON_VCN_ENGINE_TYPE_DECODE) {
-			decode_buffer = (struct amdgpu_vcn_decode_buffer *)&ib->ptr[idx + 6];
+			uint32_t valid_buf_flag = amdgpu_ib_get_value(ib, idx + 6);
+			uint64_t msg_buffer_addr;
 
-			if (!(decode_buffer->valid_buf_flag & 0x1))
+			if (!(valid_buf_flag & 0x1))
 				return 0;
 
-			addr = ((u64)decode_buffer->msg_buffer_address_hi) << 32 |
-				decode_buffer->msg_buffer_address_lo;
-			return vcn_v4_0_dec_msg(p, job, addr);
+			msg_buffer_addr = ((u64)amdgpu_ib_get_value(ib, idx + 7)) << 32 |
+				amdgpu_ib_get_value(ib, idx + 8);
+			return vcn_v4_0_dec_msg(p, job, msg_buffer_addr);
 		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
 			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
-			if (sidx >= 0 && ib->ptr[sidx + 2] == RENCODE_ENCODE_STANDARD_AV1)
+			if (sidx >= 0 &&
+			    amdgpu_ib_get_value(ib, sidx + 2) == RENCODE_ENCODE_STANDARD_AV1)
 				return vcn_v4_0_limit_sched(p, job);
 		}
-		idx += ib->ptr[idx] / 4;
+		idx += amdgpu_ib_get_value(ib, idx) / 4;
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 462a32abf720..f95bf6d95534 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/file.h>
+#include <linux/overflow.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -776,6 +777,9 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 		goto out_unlock;
 	}
 
+	if (args->num_of_nodes > kfd_topology_get_num_devices())
+		return -EINVAL;
+
 	/* Fill in process-aperture information for all available
 	 * nodes, but not more than args->num_of_nodes as that is
 	 * the amount of memory allocated by user
@@ -1356,7 +1360,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		peer_pdd = kfd_process_device_data_by_id(p, devices_arr[i]);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
-		kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(peer_pdd);
 	}
 	kfree(devices_arr);
 
@@ -1451,7 +1455,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
 		if (flush_tlb)
-			kfd_flush_tlb(peer_pdd, TLB_FLUSH_HEAVYWEIGHT);
+			kfd_flush_tlb(peer_pdd);
 
 		/* Remove dma mapping after tlb flush to avoid IO_PAGE_FAULT */
 		err = amdgpu_amdkfd_gpuvm_dmaunmap_mem(mem, peer_pdd->drm_priv);
@@ -1692,6 +1696,16 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
+static int kfd_ioctl_svm_validate(void *kdata, unsigned int usize)
+{
+	struct kfd_ioctl_svm_args *args = kdata;
+	size_t expected = struct_size(args, attrs, args->nattr);
+
+	if (expected == SIZE_MAX || usize < expected)
+		return -EINVAL;
+	return 0;
+}
+
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 
 static int kfd_ioctl_set_xnack_mode(struct file *filep,
@@ -3206,7 +3220,11 @@ static int kfd_ioctl_create_process(struct file *filep, struct kfd_process *p, v
 
 #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
 	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
-			    .cmd_drv = 0, .name = #ioctl}
+			    .validate = NULL, .cmd_drv = 0, .name = #ioctl}
+
+#define AMDKFD_IOCTL_DEF_V(ioctl, _func, _validate, _flags) \
+	[_IOC_NR(ioctl)] = {.cmd = ioctl, .func = _func, .flags = _flags, \
+			    .validate = _validate, .cmd_drv = 0, .name = #ioctl}
 
 /** Ioctl table */
 static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
@@ -3303,7 +3321,8 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SMI_EVENTS,
 			kfd_ioctl_smi_events, 0),
 
-	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SVM, kfd_ioctl_svm, 0),
+	AMDKFD_IOCTL_DEF_V(AMDKFD_IOC_SVM, kfd_ioctl_svm,
+			   kfd_ioctl_svm_validate, 0),
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_SET_XNACK_MODE,
 			kfd_ioctl_set_xnack_mode, 0),
@@ -3428,6 +3447,12 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		memset(kdata, 0, usize);
 	}
 
+	if (ioctl->validate) {
+		retcode = ioctl->validate(kdata, usize);
+		if (retcode)
+			goto err_i1;
+	}
+
 	retcode = func(filep, process, kdata);
 
 	if (cmd & IOC_OUT)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 3ddf06c755b5..c4cf595abca6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -572,7 +572,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd->vmid,
 			qpd->page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
+	kfd_flush_tlb(qpd_to_pdd(qpd));
 
 	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
 		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->adev,
@@ -610,7 +610,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			dev_err(dev, "Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
+	kfd_flush_tlb(qpd_to_pdd(qpd));
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
@@ -1284,7 +1284,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm->dev->adev,
 				qpd->vmid,
 				qpd->page_table_base);
-		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(pdd);
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 035687a17d89..c8a2a3eb46ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1047,10 +1047,13 @@ extern struct srcu_struct kfd_processes_srcu;
 typedef int amdkfd_ioctl_t(struct file *filep, struct kfd_process *p,
 				void *data);
 
+typedef int amdkfd_ioctl_validate_t(void *kdata, unsigned int usize);
+
 struct amdkfd_ioctl_desc {
 	unsigned int cmd;
 	int flags;
 	amdkfd_ioctl_t *func;
+	amdkfd_ioctl_validate_t *validate;
 	unsigned int cmd_drv;
 	const char *name;
 };
@@ -1191,6 +1194,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(struct amdgpu_device *adev,
 	return NULL;
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
+uint32_t kfd_topology_get_num_devices(void);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 uint32_t kfd_gpu_node_num(void);
 
@@ -1550,13 +1554,13 @@ void kfd_signal_reset_event(struct kfd_node *dev);
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
 void kfd_signal_process_terminate_event(struct kfd_process *p);
 
-static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
-				 enum TLB_FLUSH_TYPE type)
+static inline void kfd_flush_tlb(struct kfd_process_device *pdd)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
 	struct amdgpu_vm *vm = drm_priv_to_vm(pdd->drm_priv);
 
-	amdgpu_vm_flush_compute_tlb(adev, vm, type, pdd->dev->xcc_mask);
+	amdgpu_vm_flush_compute_tlb(adev, vm, TLB_FLUSH_HEAVYWEIGHT,
+				    pdd->dev->xcc_mask);
 }
 
 static inline bool kfd_flush_tlb_after_unmap(struct kfd_dev *dev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 080242f9981b..3d2c603f2085 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1415,7 +1415,7 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 			if (r)
 				break;
 		}
-		kfd_flush_tlb(pdd, TLB_FLUSH_HEAVYWEIGHT);
+		kfd_flush_tlb(pdd);
 	}
 
 	return r;
@@ -1557,7 +1557,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			}
 		}
 
-		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
+		kfd_flush_tlb(pdd);
 	}
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 995f2c2528a9..29dee26261ab 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2297,6 +2297,17 @@ int kfd_topology_remove_device(struct kfd_node *gpu)
 	return res;
 }
 
+uint32_t kfd_topology_get_num_devices(void)
+{
+	uint32_t num_devices;
+
+	down_read(&topology_lock);
+	num_devices = sys_props.num_devices;
+	up_read(&topology_lock);
+
+	return num_devices;
+}
+
 /* kfd_topology_enum_kfd_devices - Enumerate through all devices in KFD
  *	topology. If GPU device is found @idx, then valid kfd_dev pointer is
  *	returned through @kdev
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 03d125f794b0..896f4719cf7b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5049,7 +5049,7 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 			option = DITHER_OPTION_SPATIAL8;
 			break;
 		case COLOR_DEPTH_101010:
-			option = DITHER_OPTION_TRUN10;
+			option = DITHER_OPTION_SPATIAL10;
 			break;
 		default:
 			option = DITHER_OPTION_DISABLE;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c
index e17b5ceba447..dc5bc649f3ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_float_math.c
@@ -23,7 +23,7 @@ double math_mod(const double arg1, const double arg2)
 		return arg2;
 	if (isNaN(arg2))
 		return arg1;
-	return arg1 - arg1 * ((int)(arg1 / arg2));
+	return arg1 - arg2 * ((int)(arg1 / arg2));
 }
 
 double math_min2(const double arg1, const double arg2)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 62ebec1c6fe3..7d5df18db8d2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1326,12 +1326,13 @@ static int ci_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
 
 	dev_id = adev->pdev->device;
 
-	if ((dpm_table->mclk_table.count >= 2)
-		&& ((dev_id == 0x67B0) ||  (dev_id == 0x67B1))) {
-		smu_data->smc_state_table.MemoryLevel[1].MinVddci =
-				smu_data->smc_state_table.MemoryLevel[0].MinVddci;
-		smu_data->smc_state_table.MemoryLevel[1].MinMvdd =
-				smu_data->smc_state_table.MemoryLevel[0].MinMvdd;
+	if ((dpm_table->mclk_table.count >= 2) &&
+	    ((dev_id == 0x67B0) ||  (dev_id == 0x67B1)) &&
+	    (adev->pdev->revision == 0)) {
+		smu_data->smc_state_table.MemoryLevel[1].MinVddc =
+				smu_data->smc_state_table.MemoryLevel[0].MinVddc;
+		smu_data->smc_state_table.MemoryLevel[1].MinVddcPhases =
+				smu_data->smc_state_table.MemoryLevel[0].MinVddcPhases;
 	}
 	smu_data->smc_state_table.MemoryLevel[0].ActivityLevel = 0x1F;
 	CONVERT_FROM_HOST_TO_SMC_US(smu_data->smc_state_table.MemoryLevel[0].ActivityLevel);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index c3ebfac062a7..58d12073f7b7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2372,6 +2372,7 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		}
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
 		od_table->OverDriveTable.FanZeroRpmEnable =
@@ -2400,7 +2401,8 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 		od_table->OverDriveTable.FanMinimumPwm =
 					boot_overdrive_table->OverDriveTable.FanMinimumPwm;
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 	default:
 		dev_info(adev->dev, "Invalid table index: %ld\n", input);
@@ -2570,6 +2572,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FanLinearPwmPoints[input[0]] = input[2];
 		od_table->OverDriveTable.FanMode = FAN_MODE_MANUAL_LINEAR;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
 		break;
 
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
@@ -2639,7 +2642,7 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		break;
 
 	case PP_OD_EDIT_FAN_MINIMUM_PWM:
-		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_CURVE_BIT)) {
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_FAN_LEGACY_BIT)) {
 			dev_warn(adev->dev, "Fan curve setting not supported!\n");
 			return -ENOTSUPP;
 		}
@@ -2657,7 +2660,8 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 
 		od_table->OverDriveTable.FanMinimumPwm = input[0];
 		od_table->OverDriveTable.FanMode = FAN_MODE_AUTO;
-		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_FAN_LEGACY_BIT);
+		od_table->OverDriveTable.FeatureCtrlMask &= ~BIT(PP_OD_FEATURE_FAN_CURVE_BIT);
 		break;
 
 	case PP_OD_EDIT_FAN_ZERO_RPM_ENABLE:
diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index e636459d9185..f90b08869267 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -1697,7 +1697,7 @@ static const struct drm_bridge_funcs tda998x_bridge_funcs = {
 static int tda998x_get_audio_ports(struct tda998x_priv *priv,
 				   struct device_node *np)
 {
-	const u32 *port_data;
+	const __be32 *port_data;
 	u32 size;
 	int i;
 
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index f2cd2e25f009..ec7534227f66 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1569,6 +1569,7 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
 	const struct drm_crtc_state *old_crtc_state =
 		drm_atomic_get_old_crtc_state(state, crtc);
 	struct drm_plane *plane;
+	int ret;
 
 	WARN_ON(!drm_atomic_get_new_crtc_state(state, crtc));
 
@@ -1582,6 +1583,12 @@ drm_atomic_add_affected_planes(struct drm_atomic_state *state,
 
 		if (IS_ERR(plane_state))
 			return PTR_ERR(plane_state);
+
+		if (plane_state->color_pipeline) {
+			ret = drm_atomic_add_affected_colorops(state, plane);
+			if (ret)
+				return ret;
+		}
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 398cc81ae588..27139862b120 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -169,12 +169,8 @@ void drm_colorop_cleanup(struct drm_colorop *colorop)
 	list_del(&colorop->head);
 	config->num_colorop--;
 
-	if (colorop->state && colorop->state->data) {
-		drm_property_blob_put(colorop->state->data);
-		colorop->state->data = NULL;
-	}
-
-	kfree(colorop->state);
+	if (colorop->state)
+		drm_colorop_atomic_destroy_state(colorop, colorop->state);
 }
 EXPORT_SYMBOL(drm_colorop_cleanup);
 
@@ -441,8 +437,6 @@ static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colo
 
 	if (state->data)
 		drm_property_blob_get(state->data);
-
-	state->bypass = true;
 }
 
 struct drm_colorop_state *
@@ -460,9 +454,23 @@ drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop)
 	return state;
 }
 
+/**
+ * __drm_atomic_helper_colorop_destroy_state - release colorop state
+ * @state: colorop state object to release
+ *
+ * Releases all resources stored in the colorop state without actually freeing
+ * the memory of the colorop state. This is useful for drivers that subclass the
+ * colorop state.
+ */
+static void __drm_atomic_helper_colorop_destroy_state(struct drm_colorop_state *state)
+{
+	drm_property_blob_put(state->data);
+}
+
 void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
 				      struct drm_colorop_state *state)
 {
+	__drm_atomic_helper_colorop_destroy_state(state);
 	kfree(state);
 }
 
@@ -513,7 +521,9 @@ static void __drm_colorop_reset(struct drm_colorop *colorop,
 
 void drm_colorop_reset(struct drm_colorop *colorop)
 {
-	kfree(colorop->state);
+	if (colorop->state)
+		drm_colorop_atomic_destroy_state(colorop, colorop->state);
+
 	colorop->state = kzalloc_obj(*colorop->state);
 
 	if (colorop->state)
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 891c3bff5ae0..ebf21b403b11 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1001,7 +1001,7 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 				struct drm_file *file_priv)
 {
 	struct drm_gem_change_handle *args = data;
-	struct drm_gem_object *obj;
+	struct drm_gem_object *obj, *idrobj;
 	int handle, ret;
 
 	if (!drm_core_check_feature(dev, DRIVER_GEM))
@@ -1024,8 +1024,29 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	mutex_lock(&file_priv->prime.lock);
 
 	spin_lock(&file_priv->table_lock);
+
+       /* When create_tail allocs an obj idr, it needs to first alloc as NULL,
+	* then later replace with the correct object. This is not necessary
+	* here, because the only operations that could race are drm_prime
+	* bookkeeping, and we hold the prime lock.
+	*/
 	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
 			GFP_NOWAIT);
+
+       if (ret < 0) {
+	       spin_unlock(&file_priv->table_lock);
+	       goto out_unlock;
+       }
+
+       idrobj = idr_replace(&file_priv->object_idr, NULL, handle);
+       if (idrobj != obj) {
+	       idr_replace(&file_priv->object_idr, idrobj, handle);
+	       idr_remove(&file_priv->object_idr, args->new_handle);
+	       spin_unlock(&file_priv->table_lock);
+	       ret = -ENOENT;
+	       goto out_unlock;
+       }
+
 	spin_unlock(&file_priv->table_lock);
 
 	if (ret < 0)
@@ -1037,6 +1058,8 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
 			idr_remove(&file_priv->object_idr, handle);
+			idrobj = idr_replace(&file_priv->object_idr, obj, handle);
+			WARN_ON(idrobj != NULL);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
 		}
diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index 9166c353f131..88808e972cc1 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -172,8 +172,8 @@ int drm_gem_fb_init_with_funcs(struct drm_device *dev,
 	}
 
 	for (i = 0; i < info->num_planes; i++) {
-		unsigned int width = mode_cmd->width / (i ? info->hsub : 1);
-		unsigned int height = mode_cmd->height / (i ? info->vsub : 1);
+		unsigned int width = drm_format_info_plane_width(info, mode_cmd->width, i);
+		unsigned int height = drm_format_info_plane_height(info, mode_cmd->height, i);
 		unsigned int min_size;
 
 		objs[i] = drm_gem_object_lookup(file, mode_cmd->handles[i]);
diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 9ef9e52c0547..04bdc386c3fd 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1495,7 +1495,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 			}
 			zdd = page->zone_device_data;
 			if (pagemap != page_pgmap(page)) {
-				if (i > 0) {
+				if (pagemap) {
 					err = -EOPNOTSUPP;
 					goto err_unmap;
 				}
@@ -1572,6 +1572,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	return 0;
 
 err_unmap:
+	svm_pages->flags.has_dma_mapping = true;
 	__drm_gpusvm_unmap_pages(gpusvm, svm_pages, num_dma_mapped);
 	drm_gpusvm_notifier_unlock(gpusvm);
 err_free:
diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 29a8366513fa..e68c954ec3e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -423,7 +423,9 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	mic->bridge.of_node = dev->of_node;
 
-	drm_bridge_add(&mic->bridge);
+	ret = devm_drm_bridge_add(dev, &mic->bridge);
+	if (ret)
+		goto err;
 
 	pm_runtime_enable(dev);
 
@@ -443,12 +445,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 static void exynos_mic_remove(struct platform_device *pdev)
 {
-	struct exynos_mic *mic = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &exynos_mic_component_ops);
 	pm_runtime_disable(&pdev->dev);
-
-	drm_bridge_remove(&mic->bridge);
 }
 
 static const struct of_device_id exynos_mic_of_match[] = {
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 097e18c1adb2..8a7075c4a248 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2970,7 +2970,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		return ret;
 
 	do {
-		bool cursor_in_su_area;
+		bool cursor_in_su_area = false;
 
 		/*
 		 * Adjust su area to cover cursor fully as necessary
diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index 4ce772bc3cb3..a356f0b764cb 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -110,8 +110,7 @@ imx_pd_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 		output_fmt = imxpd->bus_format ? : MEDIA_BUS_FMT_RGB888_1X24;
 
 	/* Now make sure the requested output format is supported. */
-	if ((imxpd->bus_format && imxpd->bus_format != output_fmt) ||
-	    !imx_pd_format_supported(output_fmt)) {
+	if (!imx_pd_format_supported(output_fmt)) {
 		*num_input_fmts = 0;
 		return NULL;
 	}
@@ -121,7 +120,17 @@ imx_pd_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
 	if (!input_fmts)
 		return NULL;
 
-	input_fmts[0] = output_fmt;
+	/*
+	 * Prefer bus format set via legacy "interface-pix-fmt" DT property
+	 * over panel bus format. This is necessary to retain support for
+	 * DTs which configure the IPUv3 parallel output as 24bit, but
+	 * connect 18bit DPI panels to it with hardware swizzling.
+	 */
+	if (imxpd->bus_format && imxpd->bus_format != output_fmt)
+		input_fmts[0] = imxpd->bus_format;
+	else
+		input_fmts[0] = output_fmt;
+
 	return input_fmts;
 }
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 98cd490e7ab0..9b7012692ece 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -153,7 +153,7 @@ static int msm_hdmi_bridge_write_avi_infoframe(struct drm_bridge *bridge,
 	for (i = 0; i < ARRAY_SIZE(buf); i++)
 		hdmi_write(hdmi, REG_HDMI_AVI_INFO(i), buf[i]);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
+	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
 	val |= HDMI_INFOFRAME_CTRL0_AVI_SEND |
 		HDMI_INFOFRAME_CTRL0_AVI_CONT;
 	hdmi_write(hdmi, REG_HDMI_INFOFRAME_CTRL0, val);
@@ -193,7 +193,7 @@ static int msm_hdmi_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 		   buffer[9] << 16 |
 		   buffer[10] << 24);
 
-	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL1);
+	val = hdmi_read(hdmi, REG_HDMI_INFOFRAME_CTRL0);
 	val |= HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SEND |
 		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_CONT |
 		HDMI_INFOFRAME_CTRL0_AUDIO_INFO_SOURCE |
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index e5ab1e28851d..195f40e331e5 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -536,6 +536,11 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
 	len = msm_obj->metadata_size;
 	buf = kmemdup(msm_obj->metadata, len, GFP_KERNEL);
 
+	if (!buf) {
+		msm_gem_unlock(obj);
+		return -ENOMEM;
+	}
+
 	msm_gem_unlock(obj);
 
 	if (*metadata_size < len) {
@@ -548,7 +553,7 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
 
 	kfree(buf);
 
-	return 0;
+	return ret;
 }
 
 static int msm_ioctl_gem_info(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 84d6c7f50c8d..d178bb9b813a 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -546,32 +546,30 @@ static void recover_worker(struct kthread_work *work)
 		msm_update_fence(ring->fctx, fence);
 	}
 
-	if (msm_gpu_active(gpu)) {
-		/* retire completed submits, plus the one that hung: */
-		retire_submits(gpu);
+	/* retire completed submits, plus the one that hung: */
+	retire_submits(gpu);
 
-		gpu->funcs->recover(gpu);
+	gpu->funcs->recover(gpu);
 
-		/*
-		 * Replay all remaining submits starting with highest priority
-		 * ring
-		 */
-		for (i = 0; i < gpu->nr_rings; i++) {
-			struct msm_ringbuffer *ring = gpu->rb[i];
-			unsigned long flags;
+	/*
+	 * Replay all remaining submits starting with highest priority
+	 * ring
+	 */
+	for (i = 0; i < gpu->nr_rings; i++) {
+		struct msm_ringbuffer *ring = gpu->rb[i];
+		unsigned long flags;
 
-			spin_lock_irqsave(&ring->submit_lock, flags);
-			list_for_each_entry(submit, &ring->submits, node) {
-				/*
-				 * If the submit uses an unusable vm make sure
-				 * we don't actually run it
-				 */
-				if (to_msm_vm(submit->vm)->unusable)
-					submit->nr_cmds = 0;
-				gpu->funcs->submit(gpu, submit);
-			}
-			spin_unlock_irqrestore(&ring->submit_lock, flags);
+		spin_lock_irqsave(&ring->submit_lock, flags);
+		list_for_each_entry(submit, &ring->submits, node) {
+			/*
+			 * If the submit uses an unusable vm make sure
+			 * we don't actually run it
+			 */
+			if (to_msm_vm(submit->vm)->unusable)
+				submit->nr_cmds = 0;
+			gpu->funcs->submit(gpu, submit);
 		}
+		spin_unlock_irqrestore(&ring->submit_lock, flags);
 	}
 
 	pm_runtime_put(&gpu->pdev->dev);
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index d5fe105bdbdd..658ce64c71eb 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1324,6 +1324,8 @@ static int boe_panel_disable(struct drm_panel *panel)
 	mipi_dsi_dcs_set_display_off_multi(&ctx);
 	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
+	boe->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
 	mipi_dsi_msleep(&ctx, 150);
 
 	return ctx.accum_err;
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 1d3bb5dca559..5dfec2a958f7 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -850,6 +850,8 @@ static int hx83102_disable(struct drm_panel *panel)
 	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
+	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
 	mipi_dsi_msleep(&dsi_ctx, 150);
 
 	return dsi_ctx.accum_err;
diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 22321eb95b7d..703848fac189 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -2461,7 +2461,8 @@ static void ci_register_patching_mc_arb(struct radeon_device *rdev,
 
 	if (patch &&
 	    ((rdev->pdev->device == 0x67B0) ||
-	     (rdev->pdev->device == 0x67B1))) {
+	     (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		if ((memory_clock > 100000) && (memory_clock <= 125000)) {
 			tmp2 = (((0x31 * engine_clock) / 125000) - 1) & 0xff;
 			*dram_timimg2 &= ~0x00ff0000;
@@ -3304,7 +3305,8 @@ static int ci_populate_all_memory_levels(struct radeon_device *rdev)
 	pi->smc_state_table.MemoryLevel[0].EnabledForActivity = 1;
 
 	if ((dpm_table->mclk_table.count >= 2) &&
-	    ((rdev->pdev->device == 0x67B0) || (rdev->pdev->device == 0x67B1))) {
+	    ((rdev->pdev->device == 0x67B0) || (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		pi->smc_state_table.MemoryLevel[1].MinVddc =
 			pi->smc_state_table.MemoryLevel[0].MinVddc;
 		pi->smc_state_table.MemoryLevel[1].MinVddcPhases =
@@ -4493,7 +4495,8 @@ static int ci_register_patching_mc_seq(struct radeon_device *rdev,
 
 	if (patch &&
 	    ((rdev->pdev->device == 0x67B0) ||
-	     (rdev->pdev->device == 0x67B1))) {
+	     (rdev->pdev->device == 0x67B1)) &&
+	    (rdev->pdev->revision == 0)) {
 		for (i = 0; i < table->last; i++) {
 			if (table->last >= SMU7_DISCRETE_MC_REGISTER_ARRAY_SIZE)
 				return -EINVAL;
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index b7397827889c..360a88ca8f0c 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -741,6 +741,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct sti_hda *hda;
 	struct resource *res;
+	int ret;
 
 	DRM_INFO("%s\n", __func__);
 
@@ -779,7 +780,9 @@ static int sti_hda_probe(struct platform_device *pdev)
 		return PTR_ERR(hda->clk_hddac);
 	}
 
-	drm_bridge_add(&hda->bridge);
+	ret = devm_drm_bridge_add(dev, &hda->bridge);
+	if (ret)
+		return ret;
 
 	platform_set_drvdata(pdev, hda);
 
@@ -788,10 +791,7 @@ static int sti_hda_probe(struct platform_device *pdev)
 
 static void sti_hda_remove(struct platform_device *pdev)
 {
-	struct sti_hda *hda = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &sti_hda_ops);
-	drm_bridge_remove(&hda->bridge);
 }
 
 static const struct of_device_id hda_of_match[] = {
diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
index 3bae91d7eefe..278bb23fe4c8 100644
--- a/drivers/gpu/drm/tiny/appletbdrm.c
+++ b/drivers/gpu/drm/tiny/appletbdrm.c
@@ -353,7 +353,7 @@ static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
 		       frames_size +
 		       sizeof(struct appletbdrm_fb_request_footer), 16);
 
-	appletbdrm_state->request = kzalloc(request_size, GFP_KERNEL);
+	appletbdrm_state->request = kvzalloc(request_size, GFP_KERNEL);
 
 	if (!appletbdrm_state->request)
 		return -ENOMEM;
@@ -543,7 +543,7 @@ static void appletbdrm_primary_plane_destroy_state(struct drm_plane *plane,
 {
 	struct appletbdrm_plane_state *appletbdrm_state = to_appletbdrm_plane_state(state);
 
-	kfree(appletbdrm_state->request);
+	kvfree(appletbdrm_state->request);
 	kfree(appletbdrm_state->response);
 
 	__drm_gem_destroy_shadow_plane_state(&appletbdrm_state->base);
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 08a0e9480d70..17950fe3a0ec 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -285,13 +285,12 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
 	return unode->urb;
 }
 
-#define GET_URB_TIMEOUT	HZ
 struct urb *udl_get_urb(struct udl_device *udl)
 {
 	struct urb *urb;
 
 	spin_lock_irq(&udl->urbs.lock);
-	urb = udl_get_urb_locked(udl, GET_URB_TIMEOUT);
+	urb = udl_get_urb_locked(udl, HZ * 2);
 	spin_unlock_irq(&udl->urbs.lock);
 	return urb;
 }
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 231e829bd709..1ca073a4ecb2 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -21,6 +21,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
@@ -342,8 +343,10 @@ static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
 		return;
 
 	urb = udl_get_urb(udl);
-	if (!urb)
+	if (!urb) {
+		drm_err_ratelimited(dev, "get urb failed when enabling crtc\n");
 		goto out;
+	}
 
 	buf = (char *)urb->transfer_buffer;
 	buf = udl_vidreg_lock(buf);
diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_submit.c
index 18f2bf1fe89f..fc74351efad5 100644
--- a/drivers/gpu/drm/v3d/v3d_submit.c
+++ b/drivers/gpu/drm/v3d/v3d_submit.c
@@ -393,6 +393,11 @@ v3d_get_multisync_submit_deps(struct drm_file *file_priv,
 	if (multisync.pad)
 		return -EINVAL;
 
+	if (!multisync.in_sync_count && !multisync.out_sync_count) {
+		drm_dbg(&v3d->drm, "Empty multisync extension\n");
+		return -EINVAL;
+	}
+
 	ret = v3d_get_multisync_post_deps(file_priv, se, multisync.out_sync_count,
 					  multisync.out_syncs);
 	if (ret)
diff --git a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
index 29c72aa4b0d2..33494b86205d 100644
--- a/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
+++ b/drivers/gpu/drm/xe/display/xe_hdcp_gsc.c
@@ -37,9 +37,17 @@ static bool intel_hdcp_gsc_check_status(struct drm_device *drm)
 	struct xe_device *xe = to_xe_device(drm);
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
 	struct xe_gt *gt = tile->media_gt;
-	struct xe_gsc *gsc = &gt->uc.gsc;
+	struct xe_gsc *gsc;
+
+	if (!gt) {
+		drm_dbg_kms(&xe->drm,
+			    "not checking GSC status for HDCP2.x: media GT not present or disabled\n");
+		return false;
+	}
+
+	gsc = &gt->uc.gsc;
 
-	if (!gsc || !xe_uc_fw_is_available(&gsc->fw)) {
+	if (!xe_uc_fw_is_available(&gsc->fw)) {
 		drm_dbg_kms(&xe->drm,
 			    "GSC Components not ready for HDCP2.x\n");
 		return false;
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 29fffc81f240..8a182611ddad 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2154,8 +2154,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 	}
 
 	/* XE_BO_FLAG_GGTTx requires XE_BO_FLAG_GGTT also be set */
-	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT))
+	if ((flags & XE_BO_FLAG_GGTT_ALL) && !(flags & XE_BO_FLAG_GGTT)) {
+		xe_bo_free(bo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (flags & (XE_BO_FLAG_VRAM_MASK | XE_BO_FLAG_STOLEN) &&
 	    !(flags & XE_BO_FLAG_IGNORE_MIN_PAGE_SIZE) &&
@@ -2174,8 +2176,10 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *xe, struct xe_bo *bo,
 		alignment = SZ_4K >> PAGE_SHIFT;
 	}
 
-	if (type == ttm_bo_type_device && aligned_size != size)
+	if (type == ttm_bo_type_device && aligned_size != size) {
+		xe_bo_free(bo);
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (!bo) {
 		bo = xe_bo_alloc();
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 7c74a31d4486..19a8aba33085 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -238,6 +238,13 @@ struct dma_buf *xe_gem_prime_export(struct drm_gem_object *obj, int flags)
 	return buf;
 }
 
+/*
+ * Takes ownership of @storage: on success it is transferred to the returned
+ * drm_gem_object; on failure it is freed before returning the error.
+ * This matches the contract of xe_bo_init_locked() which frees @storage on
+ * its error paths, so callers need not (and must not) free @storage after
+ * this call.
+ */
 static struct drm_gem_object *
 xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 		    struct dma_buf *dma_buf)
@@ -251,8 +258,10 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 	int ret = 0;
 
 	dummy_obj = drm_gpuvm_resv_object_alloc(&xe->drm);
-	if (!dummy_obj)
+	if (!dummy_obj) {
+		xe_bo_free(storage);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	dummy_obj->resv = resv;
 	xe_validation_guard(&ctx, &xe->val, &exec, (struct xe_val_flags) {}, ret) {
@@ -261,6 +270,7 @@ xe_dma_buf_init_obj(struct drm_device *dev, struct xe_bo *storage,
 		if (ret)
 			break;
 
+		/* xe_bo_init_locked() frees storage on error */
 		bo = xe_bo_init_locked(xe, storage, NULL, resv, NULL, dma_buf->size,
 				       0, /* Will require 1way or 2way for vm_bind */
 				       ttm_bo_type_sg, XE_BO_FLAG_SYSTEM, &exec);
@@ -348,12 +358,15 @@ struct drm_gem_object *xe_gem_prime_import(struct drm_device *dev,
 		goto out_err;
 	}
 
-	/* Errors here will take care of freeing the bo. */
+	/*
+	 * xe_dma_buf_init_obj() takes ownership of bo on both success
+	 * and failure, so we must not touch bo after this call.
+	 */
 	obj = xe_dma_buf_init_obj(dev, bo, dma_buf);
-	if (IS_ERR(obj))
+	if (IS_ERR(obj)) {
+		dma_buf_detach(dma_buf, attach);
 		return obj;
-
-
+	}
 	get_dma_buf(dma_buf);
 	obj->import_attach = attach;
 	return obj;
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index b4086129a364..421224f89f57 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -357,6 +357,45 @@ static void xe_madvise_details_fini(struct xe_madvise_details *details)
 	drm_pagemap_put(details->dpagemap);
 }
 
+static bool check_pat_args_are_sane(struct xe_device *xe,
+				    struct xe_vmas_in_madvise_range *madvise_range,
+				    u16 pat_index)
+{
+	u16 coh_mode = xe_pat_index_get_coh_mode(xe, pat_index);
+	int i;
+
+	/*
+	 * Using coh_none with CPU cached buffers is not allowed on iGPU.
+	 * On iGPU the GPU shares the LLC with the CPU, so with coh_none
+	 * the GPU bypasses CPU caches and reads directly from DRAM,
+	 * potentially seeing stale sensitive data from previously freed
+	 * pages. On dGPU this restriction does not apply, because the
+	 * platform does not provide a non-coherent system memory access
+	 * path that would violate the DMA coherency contract.
+	 */
+	if (coh_mode != XE_COH_NONE || IS_DGFX(xe))
+		return true;
+
+	for (i = 0; i < madvise_range->num_vmas; i++) {
+		struct xe_vma *vma = madvise_range->vmas[i];
+		struct xe_bo *bo = xe_vma_bo(vma);
+
+		if (bo) {
+			/* BO with WB caching + COH_NONE is not allowed */
+			if (XE_IOCTL_DBG(xe, bo->cpu_caching == DRM_XE_GEM_CPU_CACHING_WB))
+				return false;
+			/* Imported dma-buf without caching info, assume cached */
+			if (XE_IOCTL_DBG(xe, !bo->cpu_caching))
+				return false;
+		} else if (XE_IOCTL_DBG(xe, xe_vma_is_cpu_addr_mirror(vma) ||
+					    xe_vma_is_userptr(vma)))
+			/* System memory (userptr/SVM) is always CPU cached */
+			return false;
+	}
+
+	return true;
+}
+
 static bool check_bo_args_are_sane(struct xe_vm *vm, struct xe_vma **vmas,
 				   int num_vmas, u32 atomic_val)
 {
@@ -454,6 +493,14 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	if (err || !madvise_range.num_vmas)
 		goto madv_fini;
 
+	if (args->type == DRM_XE_MEM_RANGE_ATTR_PAT) {
+		if (!check_pat_args_are_sane(xe, &madvise_range,
+					     args->pat_index.val)) {
+			err = -EINVAL;
+			goto free_vmas;
+		}
+	}
+
 	if (madvise_range.has_bo_vmas) {
 		if (args->type == DRM_XE_MEM_RANGE_ATTR_ATOMIC) {
 			if (!check_bo_args_are_sane(vm, madvise_range.vmas,
diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 0fdc0968b9ef..462010a75899 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -17,7 +17,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/backlight.h>
-#include <linux/timer.h>
+#include <linux/workqueue.h>
 #include <linux/input/sparse-keymap.h>
 
 #include "hid-ids.h"
@@ -62,7 +62,8 @@ struct appletb_kbd {
 	struct input_handle kbd_handle;
 	struct input_handle tpd_handle;
 	struct backlight_device *backlight_dev;
-	struct timer_list inactivity_timer;
+	struct delayed_work inactivity_work;
+	struct work_struct restore_brightness_work;
 	bool has_dimmed;
 	bool has_turned_off;
 	u8 saved_mode;
@@ -164,16 +165,18 @@ static int appletb_tb_key_to_slot(unsigned int code)
 	}
 }
 
-static void appletb_inactivity_timer(struct timer_list *t)
+static void appletb_inactivity_work(struct work_struct *work)
 {
-	struct appletb_kbd *kbd = timer_container_of(kbd, t, inactivity_timer);
+	struct appletb_kbd *kbd = container_of(to_delayed_work(work),
+					       struct appletb_kbd,
+					       inactivity_work);
 
 	if (kbd->backlight_dev && appletb_tb_autodim) {
 		if (!kbd->has_dimmed) {
 			backlight_device_set_brightness(kbd->backlight_dev, 1);
 			kbd->has_dimmed = true;
-			mod_timer(&kbd->inactivity_timer,
-				jiffies + secs_to_jiffies(appletb_tb_idle_timeout));
+			mod_delayed_work(system_wq, &kbd->inactivity_work,
+					 secs_to_jiffies(appletb_tb_idle_timeout));
 		} else if (!kbd->has_turned_off) {
 			backlight_device_set_brightness(kbd->backlight_dev, 0);
 			kbd->has_turned_off = true;
@@ -181,16 +184,25 @@ static void appletb_inactivity_timer(struct timer_list *t)
 	}
 }
 
+static void appletb_restore_brightness_work(struct work_struct *work)
+{
+	struct appletb_kbd *kbd = container_of(work, struct appletb_kbd,
+					       restore_brightness_work);
+
+	if (kbd->backlight_dev)
+		backlight_device_set_brightness(kbd->backlight_dev, 2);
+}
+
 static void reset_inactivity_timer(struct appletb_kbd *kbd)
 {
 	if (kbd->backlight_dev && appletb_tb_autodim) {
 		if (kbd->has_dimmed || kbd->has_turned_off) {
-			backlight_device_set_brightness(kbd->backlight_dev, 2);
 			kbd->has_dimmed = false;
 			kbd->has_turned_off = false;
+			schedule_work(&kbd->restore_brightness_work);
 		}
-		mod_timer(&kbd->inactivity_timer,
-			jiffies + secs_to_jiffies(appletb_tb_dim_timeout));
+		mod_delayed_work(system_wq, &kbd->inactivity_work,
+				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 }
 
@@ -408,9 +420,11 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 		dev_err_probe(dev, -ENODEV, "Failed to get backlight device\n");
 	} else {
 		backlight_device_set_brightness(kbd->backlight_dev, 2);
-		timer_setup(&kbd->inactivity_timer, appletb_inactivity_timer, 0);
-		mod_timer(&kbd->inactivity_timer,
-			jiffies + secs_to_jiffies(appletb_tb_dim_timeout));
+		INIT_DELAYED_WORK(&kbd->inactivity_work, appletb_inactivity_work);
+		INIT_WORK(&kbd->restore_brightness_work,
+			  appletb_restore_brightness_work);
+		mod_delayed_work(system_wq, &kbd->inactivity_work,
+				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 
 	kbd->inp_handler.event = appletb_kbd_inp_event;
@@ -440,13 +454,14 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 unregister_handler:
 	input_unregister_handler(&kbd->inp_handler);
 close_hw:
-	if (kbd->backlight_dev) {
-		put_device(&kbd->backlight_dev->dev);
-		timer_delete_sync(&kbd->inactivity_timer);
-	}
 	hid_hw_close(hdev);
 stop_hw:
 	hid_hw_stop(hdev);
+	if (kbd->backlight_dev) {
+		cancel_delayed_work_sync(&kbd->inactivity_work);
+		cancel_work_sync(&kbd->restore_brightness_work);
+		put_device(&kbd->backlight_dev->dev);
+	}
 	return ret;
 }
 
@@ -457,13 +472,14 @@ static void appletb_kbd_remove(struct hid_device *hdev)
 	appletb_kbd_set_mode(kbd, APPLETB_KBD_MODE_OFF);
 
 	input_unregister_handler(&kbd->inp_handler);
+	hid_hw_close(hdev);
+	hid_hw_stop(hdev);
+
 	if (kbd->backlight_dev) {
+		cancel_delayed_work_sync(&kbd->inactivity_work);
+		cancel_work_sync(&kbd->restore_brightness_work);
 		put_device(&kbd->backlight_dev->dev);
-		timer_delete_sync(&kbd->inactivity_timer);
 	}
-
-	hid_hw_close(hdev);
-	hid_hw_stop(hdev);
 }
 
 static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.c
index 3c0db8f93c82..8d06ddff356a 100644
--- a/drivers/hid/hid-playstation.c
+++ b/drivers/hid/hid-playstation.c
@@ -2378,7 +2378,8 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 			(struct dualshock4_input_report_usb *)data;
 
 		ds4_report = &usb->common;
-		num_touch_reports = usb->num_touch_reports;
+		num_touch_reports = min_t(u8, usb->num_touch_reports,
+					  ARRAY_SIZE(usb->touch_reports));
 		touch_reports = usb->touch_reports;
 	} else if (hdev->bus == BUS_BLUETOOTH && report->id == DS4_INPUT_REPORT_BT &&
 		   size == DS4_INPUT_REPORT_BT_SIZE) {
@@ -2392,7 +2393,8 @@ static int dualshock4_parse_report(struct ps_device *ps_dev, struct hid_report *
 		}
 
 		ds4_report = &bt->common;
-		num_touch_reports = bt->num_touch_reports;
+		num_touch_reports = min_t(u8, bt->num_touch_reports,
+					  ARRAY_SIZE(bt->touch_reports));
 		touch_reports = bt->touch_reports;
 	} else if (hdev->bus == BUS_BLUETOOTH &&
 		   report->id == DS4_INPUT_REPORT_BT_MINIMAL &&
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index fbf3dbc92e66..fad166ab21d6 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -11,6 +11,7 @@
 #include "hid-pidff.h"
 #include <linux/hid.h>
 #include <linux/input.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
 #include <linux/usb.h>
@@ -325,8 +326,10 @@ static s32 pidff_clamp(s32 i, struct hid_field *field)
  */
 static int pidff_rescale(int i, int max, struct hid_field *field)
 {
-	return i * (field->logical_maximum - field->logical_minimum) / max +
-	       field->logical_minimum;
+	/* 64 bits needed for big values during rescale */
+	s64 result = field->logical_maximum - field->logical_minimum;
+
+	return div_s64(result * i, max) + field->logical_minimum;
 }
 
 /*
diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
index 982021d547e5..b1d0695cda26 100644
--- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
+++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
@@ -345,6 +345,7 @@ static int vb2_dma_sg_mmap(void *buf_priv, struct vm_area_struct *vma)
 		return err;
 	}
 
+	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
 	/*
 	 * Use common vm_area operations to track buffer refcount.
 	 */
diff --git a/drivers/media/dvb-frontends/dib8000.c b/drivers/media/dvb-frontends/dib8000.c
index ebef27bcc989..d291113291e0 100644
--- a/drivers/media/dvb-frontends/dib8000.c
+++ b/drivers/media/dvb-frontends/dib8000.c
@@ -2695,7 +2695,7 @@ static void dib8000_viterbi_state(struct dib8000_state *state, u8 onoff)
 
 static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 {
-	s16 unit_khz_dds_val;
+	s32 unit_khz_dds_val;
 	u32 abs_offset_khz = abs(offset_khz);
 	u32 dds = state->cfg.pll->ifreq & 0x1ffffff;
 	u8 invert = !!(state->cfg.pll->ifreq & (1 << 25));
@@ -2716,7 +2716,7 @@ static void dib8000_set_dds(struct dib8000_state *state, s32 offset_khz)
 			dds = (1<<26) - dds;
 	} else {
 		ratio = 2;
-		unit_khz_dds_val = (u16) (67108864 / state->cfg.pll->internal);
+		unit_khz_dds_val = 67108864 / state->cfg.pll->internal;
 
 		if (offset_khz < 0)
 			unit_khz_dds_val *= -1;
diff --git a/drivers/media/i2c/imx283.c b/drivers/media/i2c/imx283.c
index 8ab63ad8f385..1be6164c2d15 100644
--- a/drivers/media/i2c/imx283.c
+++ b/drivers/media/i2c/imx283.c
@@ -129,7 +129,8 @@
 
 /* Master Mode Operation Control */
 #define IMX283_REG_XMSTA		CCI_REG8(0x3105)
-#define   IMX283_XMSTA			BIT(0)
+#define   IMX283_XMSTA_START		0
+#define   IMX283_XMSTA_STOP		BIT(0)
 
 #define IMX283_REG_SYNCDRV		CCI_REG8(0x3107)
 #define   IMX283_SYNCDRV_XHS_XVS	(0xa0 | 0x02)
@@ -1023,8 +1024,6 @@ static int imx283_standby_cancel(struct imx283 *imx283)
 	usleep_range(19000, 20000);
 
 	cci_write(imx283->cci, IMX283_REG_CLAMP, IMX283_CLPSQRST, &ret);
-	cci_write(imx283->cci, IMX283_REG_XMSTA, 0, &ret);
-	cci_write(imx283->cci, IMX283_REG_SYNCDRV, IMX283_SYNCDRV_XHS_XVS, &ret);
 
 	return ret;
 }
@@ -1117,6 +1116,10 @@ static int imx283_start_streaming(struct imx283 *imx283,
 	/* Apply customized values from controls (HMAX/VMAX/SHR) */
 	ret =  __v4l2_ctrl_handler_setup(imx283->sd.ctrl_handler);
 
+	/* Start master mode */
+	cci_write(imx283->cci, IMX283_REG_XMSTA, IMX283_XMSTA_START, &ret);
+	cci_write(imx283->cci, IMX283_REG_SYNCDRV, IMX283_SYNCDRV_XHS_XVS, &ret);
+
 	return ret;
 }
 
@@ -1153,12 +1156,14 @@ static int imx283_disable_streams(struct v4l2_subdev *sd,
 				  u64 streams_mask)
 {
 	struct imx283 *imx283 = to_imx283(sd);
-	int ret;
+	int ret = 0;
 
 	if (pad != IMAGE_PAD)
 		return -EINVAL;
 
-	ret = cci_write(imx283->cci, IMX283_REG_STANDBY, IMX283_STBLOGIC, NULL);
+	cci_write(imx283->cci, IMX283_REG_XMSTA, IMX283_XMSTA_STOP, &ret);
+	cci_write(imx283->cci, IMX283_REG_STANDBY, IMX283_STANDBY, &ret);
+
 	if (ret)
 		dev_err(imx283->dev, "Failed to stop stream\n");
 
diff --git a/drivers/media/i2c/imx412.c b/drivers/media/i2c/imx412.c
index b3826f803547..aa63dfc34918 100644
--- a/drivers/media/i2c/imx412.c
+++ b/drivers/media/i2c/imx412.c
@@ -925,7 +925,7 @@ static int imx412_parse_hw_config(struct imx412 *imx412)
 
 	/* Request optional reset pin */
 	imx412->reset_gpio = devm_gpiod_get_optional(imx412->dev, "reset",
-						     GPIOD_OUT_LOW);
+						     GPIOD_OUT_HIGH);
 	if (IS_ERR(imx412->reset_gpio)) {
 		dev_err(imx412->dev, "failed to get reset gpio %pe\n",
 			imx412->reset_gpio);
diff --git a/drivers/media/i2c/ov08d10.c b/drivers/media/i2c/ov08d10.c
index 43ec2a1f2fcf..5e1b8b58b3d6 100644
--- a/drivers/media/i2c/ov08d10.c
+++ b/drivers/media/i2c/ov08d10.c
@@ -217,7 +217,7 @@ static const struct ov08d10_reg lane_2_mode_3280x2460[] = {
 	{0x9a, 0x30},
 	{0xa8, 0x02},
 	{0xfd, 0x02},
-	{0xa1, 0x01},
+	{0xa1, 0x00},
 	{0xa2, 0x09},
 	{0xa3, 0x9c},
 	{0xa5, 0x00},
@@ -335,7 +335,7 @@ static const struct ov08d10_reg lane_2_mode_3264x2448[] = {
 	{0x9a, 0x30},
 	{0xa8, 0x02},
 	{0xfd, 0x02},
-	{0xa1, 0x09},
+	{0xa1, 0x08},
 	{0xa2, 0x09},
 	{0xa3, 0x90},
 	{0xa5, 0x08},
@@ -467,7 +467,7 @@ static const struct ov08d10_reg lane_2_mode_1632x1224[] = {
 	{0xaa, 0xd0},
 	{0xab, 0x06},
 	{0xac, 0x68},
-	{0xa1, 0x09},
+	{0xa1, 0x04},
 	{0xa2, 0x04},
 	{0xa3, 0xc8},
 	{0xa5, 0x04},
@@ -613,8 +613,8 @@ static const struct ov08d10_lane_cfg lane_cfg_2 = {
 static u32 ov08d10_get_format_code(struct ov08d10 *ov08d10)
 {
 	static const u32 codes[2][2] = {
-		{ MEDIA_BUS_FMT_SGRBG10_1X10, MEDIA_BUS_FMT_SRGGB10_1X10},
-		{ MEDIA_BUS_FMT_SBGGR10_1X10, MEDIA_BUS_FMT_SGBRG10_1X10},
+		{ MEDIA_BUS_FMT_SBGGR10_1X10, MEDIA_BUS_FMT_SGBRG10_1X10 },
+		{ MEDIA_BUS_FMT_SGRBG10_1X10, MEDIA_BUS_FMT_SRGGB10_1X10 },
 	};
 
 	return codes[ov08d10->vflip->val][ov08d10->hflip->val];
@@ -1430,6 +1430,9 @@ static int ov08d10_probe(struct i2c_client *client)
 		goto probe_error_v4l2_ctrl_handler_free;
 	}
 
+	pm_runtime_set_active(ov08d10->dev);
+	pm_runtime_enable(ov08d10->dev);
+
 	ret = v4l2_async_register_subdev_sensor(&ov08d10->sd);
 	if (ret < 0) {
 		dev_err(ov08d10->dev, "failed to register V4L2 subdev: %d",
@@ -1437,17 +1440,13 @@ static int ov08d10_probe(struct i2c_client *client)
 		goto probe_error_media_entity_cleanup;
 	}
 
-	/*
-	 * Device is already turned on by i2c-core with ACPI domain PM.
-	 * Enable runtime PM and turn off the device.
-	 */
-	pm_runtime_set_active(ov08d10->dev);
-	pm_runtime_enable(ov08d10->dev);
 	pm_runtime_idle(ov08d10->dev);
 
 	return 0;
 
 probe_error_media_entity_cleanup:
+	pm_runtime_disable(ov08d10->dev);
+	pm_runtime_set_suspended(ov08d10->dev);
 	media_entity_cleanup(&ov08d10->sd.entity);
 
 probe_error_v4l2_ctrl_handler_free:
diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 6a46ef7233ac..db9bd2892140 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -967,21 +967,21 @@ static int ov5647_s_ctrl(struct v4l2_ctrl *ctrl)
 		break;
 	case V4L2_CID_AUTOGAIN:
 		/* Non-zero turns on AGC by clearing bit 1.*/
-		return cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(1),
-				       ctrl->val ? 0 : BIT(1), NULL);
+		ret = cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(1),
+				      ctrl->val ? 0 : BIT(1), NULL);
 		break;
 	case V4L2_CID_EXPOSURE_AUTO:
 		/*
 		 * Everything except V4L2_EXPOSURE_MANUAL turns on AEC by
 		 * clearing bit 0.
 		 */
-		return cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(0),
-				       ctrl->val == V4L2_EXPOSURE_MANUAL ? BIT(0) : 0, NULL);
+		ret = cci_update_bits(sensor->regmap, OV5647_REG_AEC_AGC, BIT(0),
+				      ctrl->val == V4L2_EXPOSURE_MANUAL ? BIT(0) : 0, NULL);
 		break;
 	case V4L2_CID_ANALOGUE_GAIN:
 		/* 10 bits of gain, 2 in the high register. */
-		return cci_write(sensor->regmap, OV5647_REG_GAIN,
-				 ctrl->val & 0x3ff, NULL);
+		ret = cci_write(sensor->regmap, OV5647_REG_GAIN,
+				ctrl->val & 0x3ff, NULL);
 		break;
 	case V4L2_CID_EXPOSURE:
 		/*
diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
index e2998cfa0d18..dd01e1d515ff 100644
--- a/drivers/media/i2c/ov8856.c
+++ b/drivers/media/i2c/ov8856.c
@@ -1951,12 +1951,18 @@ static int ov8856_init_controls(struct ov8856 *ov8856)
 			  V4L2_CID_HFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(ctrl_hdlr, &ov8856_ctrl_ops,
 			  V4L2_CID_VFLIP, 0, 1, 1, 0);
-	if (ctrl_hdlr->error)
-		return ctrl_hdlr->error;
+	if (ctrl_hdlr->error) {
+		ret = ctrl_hdlr->error;
+		goto err_ctrl_handler_free;
+	}
 
 	ov8856->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
+
+err_ctrl_handler_free:
+	v4l2_ctrl_handler_free(ctrl_hdlr);
+	return ret;
 }
 
 static void ov8856_update_pad_format(struct ov8856 *ov8856,
diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/intel/ipu-bridge.c
index 32cc95a766b7..3028293eeb75 100644
--- a/drivers/media/pci/intel/ipu-bridge.c
+++ b/drivers/media/pci/intel/ipu-bridge.c
@@ -104,6 +104,13 @@ static const struct ipu_sensor_config ipu_supported_sensors[] = {
  * without reporting a rotation of 180° in neither the SSDB nor the _PLD.
  */
 static const struct dmi_system_id upside_down_sensor_dmi_ids[] = {
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 13 9340"),
+		},
+		.driver_data = "OVTI02C1",
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
@@ -111,6 +118,13 @@ static const struct dmi_system_id upside_down_sensor_dmi_ids[] = {
 		},
 		.driver_data = "OVTI02C1",
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 14 9440"),
+		},
+		.driver_data = "OVTI02C1",
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
diff --git a/drivers/media/pci/intel/ipu6/ipu6.c b/drivers/media/pci/intel/ipu6/ipu6.c
index 34f67f4f1bb5..d033d4618169 100644
--- a/drivers/media/pci/intel/ipu6/ipu6.c
+++ b/drivers/media/pci/intel/ipu6/ipu6.c
@@ -686,7 +686,7 @@ static int ipu6_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_ipu6_rpm_put:
 	pm_runtime_put_sync(&isp->psys->auxdev.dev);
 out_ipu6_bus_del_devices:
-	if (isp->psys) {
+	if (!IS_ERR_OR_NULL(isp->psys)) {
 		ipu6_cpd_free_pkg_dir(isp->psys);
 		ipu6_buttress_unmap_fw_image(isp->psys, &isp->psys->fw_sgt);
 	}
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 74406d5ea0a5..6bcde506adf5 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -888,6 +888,15 @@ static int get_resources(struct saa7164_dev *dev)
 	return -EBUSY;
 }
 
+static void release_resources(struct saa7164_dev *dev)
+{
+	release_mem_region(pci_resource_start(dev->pci, 0),
+			   pci_resource_len(dev->pci, 0));
+
+	release_mem_region(pci_resource_start(dev->pci, 2),
+			   pci_resource_len(dev->pci, 2));
+}
+
 static int saa7164_port_init(struct saa7164_dev *dev, int portnr)
 {
 	struct saa7164_port *port = NULL;
@@ -947,9 +956,9 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 
 	snprintf(dev->name, sizeof(dev->name), "saa7164[%d]", dev->nr);
 
-	mutex_lock(&devlist);
-	list_add_tail(&dev->devlist, &saa7164_devlist);
-	mutex_unlock(&devlist);
+	scoped_guard(mutex, &devlist) {
+		list_add_tail(&dev->devlist, &saa7164_devlist);
+	}
 
 	/* board config */
 	dev->board = UNSET;
@@ -996,11 +1005,17 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 	}
 
 	/* PCI/e allocations */
-	dev->lmmio = ioremap(pci_resource_start(dev->pci, 0),
-			     pci_resource_len(dev->pci, 0));
+	dev->lmmio = pci_ioremap_bar(dev->pci, 0);
+	if (!dev->lmmio) {
+		dev_err(&dev->pci->dev, "Failed to remap MMIO BAR 0\n");
+		goto err_ioremap_bar0;
+	}
 
-	dev->lmmio2 = ioremap(pci_resource_start(dev->pci, 2),
-			     pci_resource_len(dev->pci, 2));
+	dev->lmmio2 = pci_ioremap_bar(dev->pci, 2);
+	if (!dev->lmmio2) {
+		dev_err(&dev->pci->dev, "Failed to remap MMIO BAR 2\n");
+		goto err_ioremap_bar2;
+	}
 
 	dev->bmmio = (u8 __iomem *)dev->lmmio;
 	dev->bmmio2 = (u8 __iomem *)dev->lmmio2;
@@ -1019,17 +1034,25 @@ static int saa7164_dev_setup(struct saa7164_dev *dev)
 	saa7164_pci_quirks(dev);
 
 	return 0;
+
+err_ioremap_bar2:
+	iounmap(dev->lmmio);
+err_ioremap_bar0:
+	release_resources(dev);
+
+	scoped_guard(mutex, &devlist) {
+		list_del(&dev->devlist);
+	}
+	saa7164_devcount--;
+
+	return -ENODEV;
 }
 
 static void saa7164_dev_unregister(struct saa7164_dev *dev)
 {
 	dprintk(1, "%s()\n", __func__);
 
-	release_mem_region(pci_resource_start(dev->pci, 0),
-		pci_resource_len(dev->pci, 0));
-
-	release_mem_region(pci_resource_start(dev->pci, 2),
-		pci_resource_len(dev->pci, 2));
+	release_resources(dev);
 
 	if (!atomic_dec_and_test(&dev->refcount))
 		return;
diff --git a/drivers/media/pci/zoran/zoran_card.c b/drivers/media/pci/zoran/zoran_card.c
index d81facf735d9..f707bdc1fb0f 100644
--- a/drivers/media/pci/zoran/zoran_card.c
+++ b/drivers/media/pci/zoran/zoran_card.c
@@ -1373,7 +1373,7 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 		if (zr->codec->type != zr->card.video_codec) {
 			pci_err(pdev, "%s - wrong codec\n", __func__);
-			goto zr_unreg_videocodec;
+			goto zr_detach_codec;
 		}
 	}
 	if (zr->card.video_vfe != 0) {
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-common.h b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
index 31c1deaca146..13a3e9dc4243 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-common.h
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-common.h
@@ -306,5 +306,7 @@ bool mali_c55_pipeline_ready(struct mali_c55 *mali_c55);
 void mali_c55_stats_fill_buffer(struct mali_c55 *mali_c55,
 				enum mali_c55_config_spaces cfg_space);
 void mali_c55_params_write_config(struct mali_c55 *mali_c55);
+void mali_c55_params_init_isp_config(struct mali_c55 *mali_c55,
+				     const struct v4l2_subdev_state *state);
 
 #endif /* _MALI_C55_COMMON_H */
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-core.c b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
index 43b834459ccf..c1a562cd214e 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-core.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-core.c
@@ -663,41 +663,6 @@ static int mali_c55_init_context(struct mali_c55 *mali_c55,
 		      mali_c55->base + config_space_addrs[MALI_C55_CONFIG_PING],
 		      MALI_C55_CONFIG_SPACE_SIZE);
 
-	/*
-	 * Some features of the ISP need to be disabled by default and only
-	 * enabled at the same time as they're configured by a parameters buffer
-	 */
-
-	/* Bypass the sqrt and square compression and expansion modules */
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BYPASS_1,
-				 MALI_C55_REG_BYPASS_1_FE_SQRT,
-				 MALI_C55_REG_BYPASS_1_FE_SQRT);
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BYPASS_3,
-				 MALI_C55_REG_BYPASS_3_SQUARE_BE,
-				 MALI_C55_REG_BYPASS_3_SQUARE_BE);
-
-	/* Bypass the temper module */
-	mali_c55_ctx_write(mali_c55, MALI_C55_REG_BYPASS_2,
-			   MALI_C55_REG_BYPASS_2_TEMPER);
-
-	/* Disable the temper module's DMA read/write */
-	mali_c55_ctx_write(mali_c55, MALI_C55_REG_TEMPER_DMA_IO, 0x0);
-
-	/* Bypass the colour noise reduction  */
-	mali_c55_ctx_write(mali_c55, MALI_C55_REG_BYPASS_4,
-			   MALI_C55_REG_BYPASS_4_CNR);
-
-	/* Disable the sinter module */
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_SINTER_CONFIG,
-				 MALI_C55_SINTER_ENABLE_MASK, 0);
-
-	/* Disable the RGB Gamma module for each output */
-	mali_c55_ctx_write(mali_c55, MALI_C55_REG_FR_GAMMA_RGB_ENABLE, 0);
-	mali_c55_ctx_write(mali_c55, MALI_C55_REG_DS_GAMMA_RGB_ENABLE, 0);
-
-	/* Disable the colour correction matrix */
-	mali_c55_ctx_write(mali_c55, MALI_C55_REG_CCM_ENABLE, 0);
-
 	return 0;
 }
 
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
index 497f25fbdd13..4c0fd1ec741c 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-isp.c
@@ -112,9 +112,6 @@ static int mali_c55_isp_start(struct mali_c55 *mali_c55,
 			      const struct v4l2_subdev_state *state)
 {
 	struct mali_c55_context *ctx = mali_c55_get_active_context(mali_c55);
-	const struct mali_c55_isp_format_info *cfg;
-	const struct v4l2_mbus_framefmt *format;
-	const struct v4l2_rect *crop;
 	u32 val;
 	int ret;
 
@@ -122,35 +119,11 @@ static int mali_c55_isp_start(struct mali_c55 *mali_c55,
 			     MALI_C55_REG_MCU_CONFIG_WRITE_MASK,
 			     MALI_C55_REG_MCU_CONFIG_WRITE_PING);
 
-	/* Apply input windowing */
-	crop = v4l2_subdev_state_get_crop(state, MALI_C55_ISP_PAD_SINK_VIDEO);
-	format = v4l2_subdev_state_get_format(state,
-					      MALI_C55_ISP_PAD_SINK_VIDEO);
-	cfg = mali_c55_isp_get_mbus_config_by_code(format->code);
-
-	mali_c55_write(mali_c55, MALI_C55_REG_HC_START,
-		       MALI_C55_HC_START(crop->left));
-	mali_c55_write(mali_c55, MALI_C55_REG_HC_SIZE,
-		       MALI_C55_HC_SIZE(crop->width));
-	mali_c55_write(mali_c55, MALI_C55_REG_VC_START_SIZE,
-		       MALI_C55_VC_START(crop->top) |
-		       MALI_C55_VC_SIZE(crop->height));
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BASE_ADDR,
-				 MALI_C55_REG_ACTIVE_WIDTH_MASK, format->width);
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BASE_ADDR,
-				 MALI_C55_REG_ACTIVE_HEIGHT_MASK,
-				 format->height << 16);
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BAYER_ORDER,
-				 MALI_C55_BAYER_ORDER_MASK, cfg->order);
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_INPUT_WIDTH,
-				 MALI_C55_INPUT_WIDTH_MASK,
-				 MALI_C55_INPUT_WIDTH_20BIT);
-
-	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_ISP_RAW_BYPASS,
-				 MALI_C55_ISP_RAW_BYPASS_BYPASS_MASK,
-				 cfg->bypass ? MALI_C55_ISP_RAW_BYPASS_BYPASS_MASK :
-					     0x00);
-
+	/*
+	 * Apply default ISP configuration and the apply configurations from
+	 * the first available parameters buffer.
+	 */
+	mali_c55_params_init_isp_config(mali_c55, state);
 	mali_c55_params_write_config(mali_c55);
 	ret = mali_c55_config_write(ctx, MALI_C55_CONFIG_PING, true);
 	if (ret) {
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-params.c b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
index be0e909bcf29..f6f742a939c7 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-params.c
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-params.c
@@ -732,6 +732,128 @@ void mali_c55_params_write_config(struct mali_c55 *mali_c55)
 	vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_DONE);
 }
 
+void mali_c55_params_init_isp_config(struct mali_c55 *mali_c55,
+				     const struct v4l2_subdev_state *state)
+{
+	const struct mali_c55_isp_format_info *cfg;
+	const struct v4l2_mbus_framefmt *format;
+	const struct v4l2_rect *crop;
+
+	/* Apply input windowing */
+	crop = v4l2_subdev_state_get_crop(state, MALI_C55_ISP_PAD_SINK_VIDEO);
+	format = v4l2_subdev_state_get_format(state,
+					      MALI_C55_ISP_PAD_SINK_VIDEO);
+	cfg = mali_c55_isp_get_mbus_config_by_code(format->code);
+
+	mali_c55_write(mali_c55, MALI_C55_REG_HC_START,
+		       MALI_C55_HC_START(crop->left));
+	mali_c55_write(mali_c55, MALI_C55_REG_HC_SIZE,
+		       MALI_C55_HC_SIZE(crop->width));
+	mali_c55_write(mali_c55, MALI_C55_REG_VC_START_SIZE,
+		       MALI_C55_VC_START(crop->top) |
+		       MALI_C55_VC_SIZE(crop->height));
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BASE_ADDR,
+				 MALI_C55_REG_ACTIVE_WIDTH_MASK, format->width);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BASE_ADDR,
+				 MALI_C55_REG_ACTIVE_HEIGHT_MASK,
+				 format->height << 16);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BAYER_ORDER,
+				 MALI_C55_BAYER_ORDER_MASK, cfg->order);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_INPUT_WIDTH,
+				 MALI_C55_INPUT_WIDTH_MASK,
+				 MALI_C55_INPUT_WIDTH_20BIT);
+
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_ISP_RAW_BYPASS,
+				 MALI_C55_ISP_RAW_BYPASS_BYPASS_MASK,
+				 cfg->bypass ? MALI_C55_ISP_RAW_BYPASS_BYPASS_MASK :
+					     0x00);
+
+	/*
+	 * Some features of the ISP need to be disabled by default and only
+	 * enabled at the same time as they're configured by a parameters buffer
+	 */
+
+	/* Bypass the sqrt and square compression and expansion modules */
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BYPASS_1,
+				 MALI_C55_REG_BYPASS_1_FE_SQRT,
+				 MALI_C55_REG_BYPASS_1_FE_SQRT);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BYPASS_3,
+				 MALI_C55_REG_BYPASS_3_SQUARE_BE,
+				 MALI_C55_REG_BYPASS_3_SQUARE_BE);
+
+	/* Bypass the sensor offset correction (BLS) module */
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_BYPASS_3,
+		MALI_C55_REG_BYPASS_3_SENSOR_OFFSET_PRE_SH,
+		MALI_C55_REG_BYPASS_3_SENSOR_OFFSET_PRE_SH);
+
+	/* Configure 1x digital gain. */
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_DIGITAL_GAIN,
+				 MALI_C55_DIGITAL_GAIN_MASK, 256);
+
+	/* Set all AWB gains to 1x. at both AWB configuration points*/
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS1,
+				 MALI_C55_AWB_GAIN00_MASK, 256);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS1,
+				 MALI_C55_AWB_GAIN01_MASK,
+				 MALI_C55_AWB_GAIN01(256));
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS2,
+				 MALI_C55_AWB_GAIN10_MASK, 256);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS2,
+				 MALI_C55_AWB_GAIN11_MASK,
+				 MALI_C55_AWB_GAIN11(256));
+
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS1_AEXP,
+				 MALI_C55_AWB_GAIN00_MASK, 256);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS1_AEXP,
+				 MALI_C55_AWB_GAIN01_MASK,
+				 MALI_C55_AWB_GAIN01(256));
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS2_AEXP,
+				 MALI_C55_AWB_GAIN10_MASK, 256);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_AWB_GAINS2_AEXP,
+				 MALI_C55_AWB_GAIN11_MASK,
+				 MALI_C55_AWB_GAIN11(256));
+
+	/* Bypass mesh shading corrections (LSC). */
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_MESH_SHADING_CONFIG,
+				 MALI_C55_MESH_SHADING_ENABLE_MASK,
+				 false);
+
+	/* Bypass the temper module */
+	mali_c55_ctx_write(mali_c55, MALI_C55_REG_BYPASS_2,
+			   MALI_C55_REG_BYPASS_2_TEMPER);
+
+	/* Disable the temper module's DMA read/write */
+	mali_c55_ctx_write(mali_c55, MALI_C55_REG_TEMPER_DMA_IO, 0x0);
+
+	/* Bypass the colour noise reduction  */
+	mali_c55_ctx_write(mali_c55, MALI_C55_REG_BYPASS_4,
+			   MALI_C55_REG_BYPASS_4_CNR);
+
+	/* Disable the sinter module */
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_SINTER_CONFIG,
+				 MALI_C55_SINTER_ENABLE_MASK, 0);
+
+	/* Disable the RGB Gamma module for each output */
+	mali_c55_ctx_write(mali_c55, MALI_C55_REG_FR_GAMMA_RGB_ENABLE, 0);
+	mali_c55_ctx_write(mali_c55, MALI_C55_REG_DS_GAMMA_RGB_ENABLE, 0);
+
+	/* Disable the colour correction matrix */
+	mali_c55_ctx_write(mali_c55, MALI_C55_REG_CCM_ENABLE, 0);
+
+	/* Disable AWB stats. */
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_METERING_CONFIG,
+				 MALI_C55_AWB_DISABLE_MASK,
+				 MALI_C55_AWB_DISABLE_MASK);
+
+	/* Disable auto-exposure 1024-bin histograms at both tap points. */
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_METERING_CONFIG,
+				 MALI_C55_AEXP_HIST_DISABLE_MASK,
+				 MALI_C55_AEXP_HIST_DISABLE);
+	mali_c55_ctx_update_bits(mali_c55, MALI_C55_REG_METERING_CONFIG,
+				 MALI_C55_AEXP_IHIST_DISABLE_MASK,
+				 MALI_C55_AEXP_IHIST_DISABLE);
+}
+
 void mali_c55_unregister_params(struct mali_c55 *mali_c55)
 {
 	struct mali_c55_params *params = &mali_c55->params;
diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
index f5a148add1c8..f098effde7b4 100644
--- a/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
+++ b/drivers/media/platform/arm/mali-c55/mali-c55-registers.h
@@ -128,8 +128,8 @@ enum mali_c55_interrupts {
 #define MALI_C55_REG_BYPASS_3_SENSOR_OFFSET_PRE_SH	BIT(1)
 #define MALI_C55_REG_BYPASS_3_MESH_SHADING		BIT(3)
 #define MALI_C55_REG_BYPASS_3_WHITE_BALANCE		BIT(4)
-#define MALI_C55_REG_BYPASS_3_IRIDIX			BIT(5)
-#define MALI_C55_REG_BYPASS_3_IRIDIX_GAIN		BIT(6)
+#define MALI_C55_REG_BYPASS_3_IRIDIX_GAIN		BIT(5)
+#define MALI_C55_REG_BYPASS_3_IRIDIX			BIT(6)
 #define MALI_C55_REG_BYPASS_4				0x18ec0
 #define MALI_C55_REG_BYPASS_4_DEMOSAIC_RGB		BIT(1)
 #define MALI_C55_REG_BYPASS_4_PF_CORRECTION		BIT(3)
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vdi.c b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
index bb13267ced38..8f71920a8a35 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vdi.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vdi.c
@@ -49,6 +49,7 @@ int wave5_vdi_init(struct device *dev)
 
 	if (!PRODUCT_CODE_W_SERIES(vpu_dev->product_code)) {
 		WARN_ONCE(1, "unsupported product code: 0x%x\n", vpu_dev->product_code);
+		wave5_vdi_free_dma_memory(vpu_dev, &vpu_dev->common_mem);
 		return -EOPNOTSUPP;
 	}
 
diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
index 80e1831a42e0..d419076d7052 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
@@ -1303,13 +1303,17 @@ static void wave5_vpu_dec_buf_queue_dst(struct vb2_buffer *vb)
 
 	if (vb2_is_streaming(vb->vb2_queue) && v4l2_m2m_dst_buf_is_last(m2m_ctx)) {
 		unsigned int i;
+		unsigned long flags;
 
 		for (i = 0; i < vb->num_planes; i++)
 			vb2_set_plane_payload(vb, i, 0);
 
 		vbuf->field = V4L2_FIELD_NONE;
 
+		spin_lock_irqsave(&inst->state_spinlock, flags);
 		send_eos_event(inst);
+		spin_unlock_irqrestore(&inst->state_spinlock, flags);
+
 		v4l2_m2m_last_buffer_done(m2m_ctx, vbuf);
 	} else {
 		v4l2_m2m_buf_queue(m2m_ctx, vbuf);
@@ -1462,8 +1466,13 @@ static int streamoff_output(struct vb2_queue *q)
 	inst->codec_info->dec_info.stream_rd_ptr = new_rd_ptr;
 	inst->codec_info->dec_info.stream_wr_ptr = new_rd_ptr;
 
-	if (v4l2_m2m_has_stopped(m2m_ctx))
+	if (v4l2_m2m_has_stopped(m2m_ctx)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&inst->state_spinlock, flags);
 		send_eos_event(inst);
+		spin_unlock_irqrestore(&inst->state_spinlock, flags);
+	}
 
 	/* streamoff on output cancels any draining operation */
 	inst->eos = false;
@@ -1584,6 +1593,7 @@ static int initialize_sequence(struct vpu_instance *inst)
 {
 	struct dec_initial_info initial_info;
 	int ret = 0;
+	unsigned long flags;
 
 	memset(&initial_info, 0, sizeof(struct dec_initial_info));
 
@@ -1605,7 +1615,9 @@ static int initialize_sequence(struct vpu_instance *inst)
 		return ret;
 	}
 
+	spin_lock_irqsave(&inst->state_spinlock, flags);
 	handle_dynamic_resolution_change(inst);
+	spin_unlock_irqrestore(&inst->state_spinlock, flags);
 
 	return 0;
 }
diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
index 13682bf6e9f8..1be3a728f32f 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-video.c
@@ -1410,7 +1410,7 @@ int mxc_isi_video_register(struct mxc_isi_pipe *pipe,
 	q->mem_ops = &vb2_dma_contig_memops;
 	q->buf_struct_size = sizeof(struct mxc_isi_buffer);
 	q->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_MONOTONIC;
-	q->min_queued_buffers = 2;
+	q->min_queued_buffers = 0;
 	q->lock = &video->lock;
 	q->dev = pipe->isi->dev;
 
diff --git a/drivers/media/platform/qcom/camss/camss-csid-gen3.c b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
index 664245cf6eb0..bd059243790e 100644
--- a/drivers/media/platform/qcom/camss/camss-csid-gen3.c
+++ b/drivers/media/platform/qcom/camss/camss-csid-gen3.c
@@ -48,9 +48,9 @@
 #define IS_CSID_690(csid)	((csid->camss->res->version == CAMSS_8775P) \
 				 || (csid->camss->res->version == CAMSS_8300))
 #define CSID_BUF_DONE_IRQ_STATUS	0x8C
-#define BUF_DONE_IRQ_STATUS_RDI_OFFSET  (csid_is_lite(csid) ?\
-						1 : (IS_CSID_690(csid) ?\
-						13 : 14))
+#define BUF_DONE_IRQ_STATUS_RDI_OFFSET  (csid_is_lite(csid) ? \
+						((IS_CSID_690(csid) ? 0 : 1)) : \
+						((IS_CSID_690(csid) ? 13 : 14)))
 #define CSID_BUF_DONE_IRQ_MASK		0x90
 #define CSID_BUF_DONE_IRQ_CLEAR		0x94
 #define CSID_BUF_DONE_IRQ_SET		0x98
diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 00b87fd9afbd..9335636d7c4d 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -3598,12 +3598,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID2 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite0" },
 		.interrupt = { "csid_lite0" },
@@ -3617,12 +3615,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID3 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite1" },
 		.interrupt = { "csid_lite1" },
@@ -3636,12 +3632,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID4 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite2" },
 		.interrupt = { "csid_lite2" },
@@ -3655,12 +3649,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID5 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite3" },
 		.interrupt = { "csid_lite3" },
@@ -3674,12 +3666,10 @@ static const struct camss_subdev_resources csid_res_8775p[] = {
 	/* CSID6 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+		.clock = { "vfe_lite_csid", "vfe_lite_cphy_rx" },
 		.clock_rate = {
-			{ 0, 0, 400000000, 400000000, 0},
-			{ 0, 0, 400000000, 480000000, 0}
+			{ 400000000, 480000000 },
+			{ 400000000, 480000000 }
 		},
 		.reg = { "csid_lite4" },
 		.interrupt = { "csid_lite4" },
@@ -3752,15 +3742,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE2 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite0" },
 		.interrupt = { "vfe_lite0" },
@@ -3775,15 +3767,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE3 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite1" },
 		.interrupt = { "vfe_lite1" },
@@ -3798,15 +3792,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE4 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite2" },
 		.interrupt = { "vfe_lite2" },
@@ -3821,15 +3817,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE5 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite3" },
 		.interrupt = { "vfe_lite3" },
@@ -3844,15 +3842,17 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE6 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_vfe_lite", "vfe_lite_ahb",
+		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
 			   "vfe_lite_csid", "vfe_lite_cphy_rx",
-			   "vfe_lite"},
+			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
-			{ 0, 0, 0, 0  },
+			{ 0 },
+			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 400000000, 400000000, 400000000, 400000000 },
 			{ 480000000, 600000000, 600000000, 600000000 },
+			{ 400000000 },
 		},
 		.reg = { "vfe_lite4" },
 		.interrupt = { "vfe_lite4" },
diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index 3c803a05305a..5498f48362d1 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -3,7 +3,7 @@ config VIDEO_QCOM_IRIS
         depends on VIDEO_DEV
         depends on ARCH_QCOM || COMPILE_TEST
         select V4L2_MEM2MEM_DEV
-        select QCOM_MDT_LOADER if ARCH_QCOM
+        select QCOM_MDT_LOADER
         select QCOM_SCM
         select VIDEOBUF2_DMA_CONTIG
         help
diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index 9151f43bc6b9..1d53c7414b75 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -582,10 +582,12 @@ static int iris_release_internal_buffers(struct iris_inst *inst,
 			continue;
 		if (!(buffer->attr & BUF_ATTR_QUEUED))
 			continue;
+		buffer->attr |= BUF_ATTR_PENDING_RELEASE;
 		ret = hfi_ops->session_release_buf(inst, buffer);
-		if (ret)
+		if (ret) {
+			buffer->attr &= ~BUF_ATTR_PENDING_RELEASE;
 			return ret;
-		buffer->attr |= BUF_ATTR_PENDING_RELEASE;
+		}
 	}
 
 	return 0;
diff --git a/drivers/media/platform/qcom/iris/iris_core.c b/drivers/media/platform/qcom/iris/iris_core.c
index 8406c48d635b..dbaac01eb15a 100644
--- a/drivers/media/platform/qcom/iris/iris_core.c
+++ b/drivers/media/platform/qcom/iris/iris_core.c
@@ -75,6 +75,10 @@ int iris_core_init(struct iris_core *core)
 	if (ret)
 		goto error_unload_fw;
 
+	ret = iris_vpu_switch_to_hwmode(core);
+	if (ret)
+		goto error_unload_fw;
+
 	ret = iris_hfi_core_init(core);
 	if (ret)
 		goto error_unload_fw;
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_common.c b/drivers/media/platform/qcom/iris/iris_hfi_common.c
index 92112eb16c11..621c66593d88 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_common.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_common.c
@@ -159,6 +159,10 @@ int iris_hfi_pm_resume(struct iris_core *core)
 	if (ret)
 		goto err_suspend_hw;
 
+	ret = iris_vpu_switch_to_hwmode(core);
+	if (ret)
+		goto err_suspend_hw;
+
 	ret = ops->sys_interframe_powercollapse(core);
 	if (ret)
 		goto err_suspend_hw;
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_queue.c b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
index b3ed06297953..bf6db23b53e2 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_queue.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_queue.c
@@ -263,7 +263,7 @@ int iris_hfi_queues_init(struct iris_core *core)
 					  GFP_KERNEL, DMA_ATTR_WRITE_COMBINE);
 	if (!core->sfr_vaddr) {
 		dev_err(core->dev, "sfr alloc and map failed\n");
-		dma_free_attrs(core->dev, sizeof(*q_tbl_hdr), core->iface_q_table_vaddr,
+		dma_free_attrs(core->dev, queue_size, core->iface_q_table_vaddr,
 			       core->iface_q_table_daddr, DMA_ATTR_WRITE_COMBINE);
 		return -ENOMEM;
 	}
diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index 719217399a30..99d544e2af4f 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -61,12 +61,6 @@ int iris_vdec_inst_init(struct iris_inst *inst)
 	return iris_ctrls_init(inst);
 }
 
-void iris_vdec_inst_deinit(struct iris_inst *inst)
-{
-	kfree(inst->fmt_dst);
-	kfree(inst->fmt_src);
-}
-
 static const struct iris_fmt iris_vdec_formats_cap[] = {
 	[IRIS_FMT_NV12] = {
 		.pixfmt = V4L2_PIX_FMT_NV12,
diff --git a/drivers/media/platform/qcom/iris/iris_vdec.h b/drivers/media/platform/qcom/iris/iris_vdec.h
index ec1ce55d1375..5123d2a340e1 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.h
+++ b/drivers/media/platform/qcom/iris/iris_vdec.h
@@ -9,7 +9,6 @@
 struct iris_inst;
 
 int iris_vdec_inst_init(struct iris_inst *inst);
-void iris_vdec_inst_deinit(struct iris_inst *inst);
 int iris_vdec_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
 int iris_vdec_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int iris_vdec_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
diff --git a/drivers/media/platform/qcom/iris/iris_venc.c b/drivers/media/platform/qcom/iris/iris_venc.c
index aa27b22704eb..4d886769d958 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.c
+++ b/drivers/media/platform/qcom/iris/iris_venc.c
@@ -79,12 +79,6 @@ int iris_venc_inst_init(struct iris_inst *inst)
 	return iris_ctrls_init(inst);
 }
 
-void iris_venc_inst_deinit(struct iris_inst *inst)
-{
-	kfree(inst->fmt_dst);
-	kfree(inst->fmt_src);
-}
-
 static const struct iris_fmt iris_venc_formats_cap[] = {
 	[IRIS_FMT_H264] = {
 		.pixfmt = V4L2_PIX_FMT_H264,
diff --git a/drivers/media/platform/qcom/iris/iris_venc.h b/drivers/media/platform/qcom/iris/iris_venc.h
index c4db7433da53..00c1716b2747 100644
--- a/drivers/media/platform/qcom/iris/iris_venc.h
+++ b/drivers/media/platform/qcom/iris/iris_venc.h
@@ -9,7 +9,6 @@
 struct iris_inst;
 
 int iris_venc_inst_init(struct iris_inst *inst);
-void iris_venc_inst_deinit(struct iris_inst *inst);
 int iris_venc_enum_fmt(struct iris_inst *inst, struct v4l2_fmtdesc *f);
 int iris_venc_try_fmt(struct iris_inst *inst, struct v4l2_format *f);
 int iris_venc_s_fmt(struct iris_inst *inst, struct v4l2_format *f);
diff --git a/drivers/media/platform/qcom/iris/iris_vidc.c b/drivers/media/platform/qcom/iris/iris_vidc.c
index bd38d84c9cc7..5eb1786b0737 100644
--- a/drivers/media/platform/qcom/iris/iris_vidc.c
+++ b/drivers/media/platform/qcom/iris/iris_vidc.c
@@ -289,10 +289,6 @@ int iris_close(struct file *filp)
 	v4l2_m2m_ctx_release(inst->m2m_ctx);
 	v4l2_m2m_release(inst->m2m_dev);
 	mutex_lock(&inst->lock);
-	if (inst->domain == DECODER)
-		iris_vdec_inst_deinit(inst);
-	else if (inst->domain == ENCODER)
-		iris_venc_inst_deinit(inst);
 	iris_session_close(inst);
 	iris_inst_change_state(inst, IRIS_INST_DEINIT);
 	iris_v4l2_fh_deinit(inst, filp);
@@ -304,6 +300,8 @@ int iris_close(struct file *filp)
 	mutex_unlock(&inst->lock);
 	mutex_destroy(&inst->ctx_q_lock);
 	mutex_destroy(&inst->lock);
+	kfree(inst->fmt_src);
+	kfree(inst->fmt_dst);
 	kfree(inst);
 
 	return 0;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu2.c b/drivers/media/platform/qcom/iris/iris_vpu2.c
index 9c103a2e4e4e..01ef40f38957 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu2.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu2.c
@@ -44,4 +44,5 @@ const struct vpu_ops iris_vpu2_ops = {
 	.power_off_controller = iris_vpu_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu2_calc_freq,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index fe4423b951b1..3dad47be78b5 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -234,14 +234,8 @@ static int iris_vpu35_power_on_hw(struct iris_core *core)
 	if (ret)
 		goto err_disable_hw_free_clk;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
-	if (ret)
-		goto err_disable_hw_clk;
-
 	return 0;
 
-err_disable_hw_clk:
-	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
 err_disable_hw_free_clk:
 	iris_disable_unprepare_clock(core, IRIS_HW_FREERUN_CLK);
 err_disable_axi_clk:
@@ -266,6 +260,7 @@ const struct vpu_ops iris_vpu3_ops = {
 	.power_off_controller = iris_vpu_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
 
 const struct vpu_ops iris_vpu33_ops = {
@@ -274,6 +269,7 @@ const struct vpu_ops iris_vpu33_ops = {
 	.power_off_controller = iris_vpu33_power_off_controller,
 	.power_on_controller = iris_vpu_power_on_controller,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
 
 const struct vpu_ops iris_vpu35_ops = {
@@ -283,4 +279,5 @@ const struct vpu_ops iris_vpu35_ops = {
 	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
 	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu_set_hwmode,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu4x.c b/drivers/media/platform/qcom/iris/iris_vpu4x.c
index a8db02ce5c5e..02e100a4045f 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu4x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu4x.c
@@ -252,21 +252,10 @@ static int iris_vpu4x_power_on_hardware(struct iris_core *core)
 		ret = iris_vpu4x_power_on_apv(core);
 		if (ret)
 			goto disable_hw_clocks;
-
-		iris_vpu4x_ahb_sync_reset_apv(core);
 	}
 
-	iris_vpu4x_ahb_sync_reset_hardware(core);
-
-	ret = iris_vpu4x_genpd_set_hwmode(core, true, efuse_value);
-	if (ret)
-		goto disable_apv_power_domain;
-
 	return 0;
 
-disable_apv_power_domain:
-	if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
-		iris_vpu4x_power_off_apv(core);
 disable_hw_clocks:
 	iris_vpu4x_disable_hardware_clocks(core, efuse_value);
 disable_vpp1_power_domain:
@@ -359,6 +348,18 @@ static void iris_vpu4x_power_off_hardware(struct iris_core *core)
 	iris_disable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN]);
 }
 
+static int iris_vpu4x_set_hwmode(struct iris_core *core)
+{
+	u32 efuse_value = readl(core->reg_base + WRAPPER_EFUSE_MONITOR);
+
+	if (!(efuse_value & DISABLE_VIDEO_APV_BIT))
+		iris_vpu4x_ahb_sync_reset_apv(core);
+
+	iris_vpu4x_ahb_sync_reset_hardware(core);
+
+	return iris_vpu4x_genpd_set_hwmode(core, true, efuse_value);
+}
+
 const struct vpu_ops iris_vpu4x_ops = {
 	.power_off_hw = iris_vpu4x_power_off_hardware,
 	.power_on_hw = iris_vpu4x_power_on_hardware,
@@ -366,4 +367,5 @@ const struct vpu_ops iris_vpu4x_ops = {
 	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
 	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+	.set_hwmode = iris_vpu4x_set_hwmode,
 };
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.h b/drivers/media/platform/qcom/iris/iris_vpu_buffer.h
index 12640eb5ed8c..8c0d6b7b5de8 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.h
@@ -67,7 +67,7 @@ struct iris_inst;
 #define SIZE_DOLBY_RPU_METADATA (41 * 1024)
 #define H264_CABAC_HDR_RATIO_HD_TOT	1
 #define H264_CABAC_RES_RATIO_HD_TOT	3
-#define H265D_MAX_SLICE	1200
+#define H265D_MAX_SLICE	3600
 #define SIZE_H265D_HW_PIC_T SIZE_H264D_HW_PIC_T
 #define H265_CABAC_HDR_RATIO_HD_TOT 2
 #define H265_CABAC_RES_RATIO_HD_TOT 2
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index 548e5f1727fd..69e6126dc4d9 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -292,14 +292,8 @@ int iris_vpu_power_on_hw(struct iris_core *core)
 	if (ret && ret != -ENOENT)
 		goto err_disable_hw_clock;
 
-	ret = dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
-	if (ret)
-		goto err_disable_hw_ahb_clock;
-
 	return 0;
 
-err_disable_hw_ahb_clock:
-	iris_disable_unprepare_clock(core, IRIS_HW_AHB_CLK);
 err_disable_hw_clock:
 	iris_disable_unprepare_clock(core, IRIS_HW_CLK);
 err_disable_power:
@@ -308,6 +302,16 @@ int iris_vpu_power_on_hw(struct iris_core *core)
 	return ret;
 }
 
+int iris_vpu_set_hwmode(struct iris_core *core)
+{
+	return dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
+}
+
+int iris_vpu_switch_to_hwmode(struct iris_core *core)
+{
+	return core->iris_platform_data->vpu_ops->set_hwmode(core);
+}
+
 int iris_vpu35_vpu4x_power_off_controller(struct iris_core *core)
 {
 	u32 clk_rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index f6dffc613b82..dee3b1349c5e 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -21,6 +21,7 @@ struct vpu_ops {
 	int (*power_on_controller)(struct iris_core *core);
 	void (*program_bootup_registers)(struct iris_core *core);
 	u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
+	int (*set_hwmode)(struct iris_core *core);
 };
 
 int iris_vpu_boot_firmware(struct iris_core *core);
@@ -30,6 +31,8 @@ int iris_vpu_watchdog(struct iris_core *core, u32 intr_status);
 int iris_vpu_prepare_pc(struct iris_core *core);
 int iris_vpu_power_on_controller(struct iris_core *core);
 int iris_vpu_power_on_hw(struct iris_core *core);
+int iris_vpu_set_hwmode(struct iris_core *core);
+int iris_vpu_switch_to_hwmode(struct iris_core *core);
 int iris_vpu_power_on(struct iris_core *core);
 int iris_vpu_power_off_controller(struct iris_core *core);
 void iris_vpu_power_off_hw(struct iris_core *core);
diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
index ffb731ecd48c..63ee8c78dc6d 100644
--- a/drivers/media/platform/qcom/venus/Kconfig
+++ b/drivers/media/platform/qcom/venus/Kconfig
@@ -4,7 +4,7 @@ config VIDEO_QCOM_VENUS
 	depends on VIDEO_DEV && QCOM_SMEM
 	depends on (ARCH_QCOM && ARM64 && IOMMU_API) || COMPILE_TEST
 	select OF_DYNAMIC if ARCH_QCOM
-	select QCOM_MDT_LOADER if ARCH_QCOM
+	select QCOM_MDT_LOADER
 	select QCOM_SCM
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index b619d1436a41..f9af9177e02f 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -676,8 +676,30 @@ void rvin_crop_scale_comp(struct rvin_dev *vin)
 	if (vin->scaler)
 		vin->scaler(vin);
 
+	/*
+	 * VNIS_REG has four lowest bits always 0, i.e. the stride has to be
+	 * aligned to 16 bytes. This is done in rvin_format_bytesperline().
+	 */
+
 	fmt = rvin_format_from_pixel(vin, vin->format.pixelformat);
 	stride = vin->format.bytesperline / fmt->bpp;
+
+	/*
+	 * RAW8 format bpp is 1, but the hardware process RAW8 format in 2 pixel
+	 * units, so we need to divide the stride by 2.
+	 */
+	switch (vin->format.pixelformat) {
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_GREY:
+		stride /= 2;
+		break;
+	default:
+		break;
+	}
+
 	rvin_write(vin, stride, VNIS_REG);
 }
 
diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
index 079dbaf016c2..9d45e11898c1 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-v4l2.c
@@ -155,6 +155,18 @@ static u32 rvin_format_bytesperline(struct rvin_dev *vin,
 	case V4L2_PIX_FMT_NV16:
 		align = 0x20;
 		break;
+	case V4L2_PIX_FMT_SBGGR8:
+	case V4L2_PIX_FMT_SGBRG8:
+	case V4L2_PIX_FMT_SGRBG8:
+	case V4L2_PIX_FMT_SRGGB8:
+	case V4L2_PIX_FMT_GREY:
+		/*
+		 * RAW8 format bpp is 1, but the hardware process RAW8 format in
+		 * 2 pixel units, and we need to align to 32 bytes. See
+		 * rvin_crop_scale_comp().
+		 */
+		align = 0x20;
+		break;
 	default:
 		align = 0x10;
 		break;
diff --git a/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-video.c b/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-video.c
index bfe5b0c7045e..3580a57738a6 100644
--- a/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-video.c
+++ b/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc-video.c
@@ -149,24 +149,26 @@ static void rzv2h_ivc_transfer_buffer(struct work_struct *work)
 					     buffers.work);
 	struct rzv2h_ivc_buf *buf;
 
+	guard(spinlock_irqsave)(&ivc->spinlock);
+
+	if (ivc->vvalid_ifp)
+		return;
+
 	/* Setup buffers */
 	scoped_guard(spinlock_irqsave, &ivc->buffers.lock) {
 		buf = list_first_entry_or_null(&ivc->buffers.queue,
 					       struct rzv2h_ivc_buf, queue);
-	}
-
-	if (!buf)
-		return;
+		if (!buf)
+			return;
 
-	list_del(&buf->queue);
+		list_del(&buf->queue);
+		ivc->buffers.curr = buf;
+	}
 
-	ivc->buffers.curr = buf;
 	buf->addr = vb2_dma_contig_plane_dma_addr(&buf->vb.vb2_buf, 0);
 	rzv2h_ivc_write(ivc, RZV2H_IVC_REG_AXIRX_SADDL_P0, buf->addr);
 
-	scoped_guard(spinlock_irqsave, &ivc->spinlock) {
-		ivc->vvalid_ifp = 2;
-	}
+	ivc->vvalid_ifp = 2;
 	rzv2h_ivc_write(ivc, RZV2H_IVC_REG_FM_FRCON, 0x1);
 }
 
@@ -201,7 +203,7 @@ static void rzv2h_ivc_buf_queue(struct vb2_buffer *vb)
 	}
 
 	scoped_guard(spinlock_irq, &ivc->spinlock) {
-		if (vb2_is_streaming(vb->vb2_queue) && !ivc->vvalid_ifp)
+		if (vb2_is_streaming(vb->vb2_queue))
 			queue_work(ivc->buffers.async_wq, &ivc->buffers.work);
 	}
 }
@@ -215,10 +217,10 @@ static void rzv2h_ivc_format_configure(struct rzv2h_ivc *ivc)
 
 	/* Currently only CRU packed pixel formats are supported */
 	rzv2h_ivc_write(ivc, RZV2H_IVC_REG_AXIRX_PXFMT,
-			RZV2H_IVC_INPUT_FMT_CRU_PACKED);
-
-	rzv2h_ivc_update_bits(ivc, RZV2H_IVC_REG_AXIRX_PXFMT,
-			      RZV2H_IVC_PXFMT_DTYPE, fmt->dtype);
+			FIELD_PREP(RZV2H_IVC_AXIRX_PXFMT_FIELD_DTYPE,
+				   fmt->dtype) |
+			FIELD_PREP(RZV2H_IVC_AXIRX_PXFMT_FIELD_CLFMT,
+				   RZV2H_IVC_CLFMT_CRU_PACKED));
 
 	rzv2h_ivc_write(ivc, RZV2H_IVC_REG_AXIRX_HSIZE, pix->width);
 	rzv2h_ivc_write(ivc, RZV2H_IVC_REG_AXIRX_VSIZE, pix->height);
@@ -297,9 +299,10 @@ static void rzv2h_ivc_stop_streaming(struct vb2_queue *q)
 	struct rzv2h_ivc *ivc = vb2_get_drv_priv(q);
 	u32 val = 0;
 
-	rzv2h_ivc_write(ivc, RZV2H_IVC_REG_FM_STOP, 0x1);
+	rzv2h_ivc_write(ivc, RZV2H_IVC_REG_FM_STOP, RZV2H_IVC_REG_FM_STOP_FSTOP);
 	readl_poll_timeout(ivc->base + RZV2H_IVC_REG_FM_STOP,
-			   val, !val, 10 * USEC_PER_MSEC, 250 * USEC_PER_MSEC);
+			   val, !(val & RZV2H_IVC_REG_FM_STOP_FSTOP),
+			   10 * USEC_PER_MSEC, 250 * USEC_PER_MSEC);
 
 	rzv2h_ivc_return_buffers(ivc, VB2_BUF_STATE_ERROR);
 	video_device_pipeline_stop(&ivc->vdev.dev);
diff --git a/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc.h b/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc.h
index 4ef44c8b4656..049f223200e3 100644
--- a/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc.h
+++ b/drivers/media/platform/renesas/rzv2h-ivc/rzv2h-ivc.h
@@ -24,9 +24,10 @@
 #define RZV2H_IVC_ONE_EXPOSURE				0x00
 #define RZV2H_IVC_TWO_EXPOSURE				0x01
 #define RZV2H_IVC_REG_AXIRX_PXFMT			0x0004
-#define RZV2H_IVC_INPUT_FMT_MIPI			(0 << 16)
-#define RZV2H_IVC_INPUT_FMT_CRU_PACKED			BIT(16)
-#define RZV2H_IVC_PXFMT_DTYPE				GENMASK(7, 0)
+#define RZV2H_IVC_AXIRX_PXFMT_FIELD_CLFMT		GENMASK(17, 16)
+#define RZV2H_IVC_CLFMT_MIPI				0
+#define RZV2H_IVC_CLFMT_CRU_PACKED			1
+#define RZV2H_IVC_AXIRX_PXFMT_FIELD_DTYPE		GENMASK(7, 0)
 #define RZV2H_IVC_REG_AXIRX_SADDL_P0			0x0010
 #define RZV2H_IVC_REG_AXIRX_SADDH_P0			0x0014
 #define RZV2H_IVC_REG_AXIRX_SADDL_P1			0x0018
@@ -45,6 +46,7 @@
 #define RZV2H_IVC_REG_FM_MCON				0x0104
 #define RZV2H_IVC_REG_FM_FRCON				0x0108
 #define RZV2H_IVC_REG_FM_STOP				0x010c
+#define RZV2H_IVC_REG_FM_STOP_FSTOP			BIT(20)
 #define RZV2H_IVC_REG_FM_INT_EN				0x0120
 #define RZV2H_IVC_VVAL_IFPE				BIT(0)
 #define RZV2H_IVC_REG_FM_INT_STA			0x0124
diff --git a/drivers/media/platform/renesas/vsp1/vsp1_drv.c b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
index 2de515c497eb..627b5046fa80 100644
--- a/drivers/media/platform/renesas/vsp1/vsp1_drv.c
+++ b/drivers/media/platform/renesas/vsp1/vsp1_drv.c
@@ -240,8 +240,12 @@ static void vsp1_destroy_entities(struct vsp1_device *vsp1)
 		media_device_unregister(&vsp1->media_dev);
 	media_device_cleanup(&vsp1->media_dev);
 
-	if (!vsp1->info->uapi)
-		vsp1_drm_cleanup(vsp1);
+	if (!vsp1->info->uapi) {
+		if (vsp1->info->version == VI6_IP_VERSION_MODEL_VSPX_GEN4)
+			vsp1_vspx_cleanup(vsp1);
+		else
+			vsp1_drm_cleanup(vsp1);
+	}
 }
 
 static int vsp1_create_entities(struct vsp1_device *vsp1)
diff --git a/drivers/media/platform/rockchip/rkcif/rkcif-interface.c b/drivers/media/platform/rockchip/rkcif/rkcif-interface.c
index 523103872b7a..414a9980cf2e 100644
--- a/drivers/media/platform/rockchip/rkcif/rkcif-interface.c
+++ b/drivers/media/platform/rockchip/rkcif/rkcif-interface.c
@@ -378,7 +378,8 @@ int rkcif_interface_register(struct rkcif_device *rkcif,
 		snprintf(sd->name, sizeof(sd->name), "rkcif-mipi%d",
 			 interface->index - RKCIF_MIPI_BASE);
 
-	pads[RKCIF_IF_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
+	pads[RKCIF_IF_PAD_SINK].flags = MEDIA_PAD_FL_SINK |
+					MEDIA_PAD_FL_MUST_CONNECT;
 	pads[RKCIF_IF_PAD_SRC].flags = MEDIA_PAD_FL_SOURCE;
 	ret = media_entity_pads_init(&sd->entity, RKCIF_IF_PAD_MAX, pads);
 	if (ret)
diff --git a/drivers/media/platform/rockchip/rkcif/rkcif-stream.c b/drivers/media/platform/rockchip/rkcif/rkcif-stream.c
index f15bee4f7cd7..3130d420ad55 100644
--- a/drivers/media/platform/rockchip/rkcif/rkcif-stream.c
+++ b/drivers/media/platform/rockchip/rkcif/rkcif-stream.c
@@ -555,7 +555,7 @@ int rkcif_stream_register(struct rkcif_device *rkcif,
 	vdev->vfl_dir = VFL_DIR_RX;
 	video_set_drvdata(vdev, stream);
 
-	stream->pad.flags = MEDIA_PAD_FL_SINK;
+	stream->pad.flags = MEDIA_PAD_FL_SINK | MEDIA_PAD_FL_MUST_CONNECT;
 
 	stream->pix.height = CIF_MIN_HEIGHT;
 	stream->pix.width = CIF_MIN_WIDTH;
diff --git a/drivers/media/platform/ti/omap3isp/ispvideo.c b/drivers/media/platform/ti/omap3isp/ispvideo.c
index 64e76e3576a8..b946c8087c77 100644
--- a/drivers/media/platform/ti/omap3isp/ispvideo.c
+++ b/drivers/media/platform/ti/omap3isp/ispvideo.c
@@ -1403,6 +1403,7 @@ static int isp_video_open(struct file *file)
 
 	ret = vb2_queue_init(&handle->queue);
 	if (ret < 0) {
+		v4l2_pipeline_pm_put(&video->video.entity);
 		omap3isp_put(video->isp);
 		goto done;
 	}
diff --git a/drivers/media/platform/ti/vpe/vip.c b/drivers/media/platform/ti/vpe/vip.c
index a4b616a5ece7..0e91e87bda9b 100644
--- a/drivers/media/platform/ti/vpe/vip.c
+++ b/drivers/media/platform/ti/vpe/vip.c
@@ -3641,6 +3641,7 @@ static void vip_remove(struct platform_device *pdev)
 	}
 
 	v4l2_ctrl_handler_free(&shared->ctrl_handler);
+	v4l2_device_unregister(&shared->v4l2_dev);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/media/rc/streamzap.c b/drivers/media/rc/streamzap.c
index 5a18603f9a95..6587c64a9d93 100644
--- a/drivers/media/rc/streamzap.c
+++ b/drivers/media/rc/streamzap.c
@@ -219,9 +219,8 @@ static void streamzap_callback(struct urb *urb)
 	case -ESHUTDOWN:
 		/*
 		 * this urb is terminated, clean up.
-		 * sz might already be invalid at this point
 		 */
-		dev_err(sz->dev, "urb terminated, status: %d\n", urb->status);
+		dev_dbg(sz->dev, "urb terminated, status: %d\n", urb->status);
 		return;
 	default:
 		break;
@@ -358,11 +357,16 @@ static int streamzap_probe(struct usb_interface *intf,
 
 	usb_set_intfdata(intf, sz);
 
-	if (usb_submit_urb(sz->urb_in, GFP_ATOMIC))
+	retval = usb_submit_urb(sz->urb_in, GFP_ATOMIC);
+	if (retval < 0) {
 		dev_err(sz->dev, "urb submit failed\n");
+		goto rc_submit_fail;
+	}
 
 	return 0;
-
+rc_submit_fail:
+	rc_free_device(sz->rdev);
+	usb_set_intfdata(intf, NULL);
 rc_dev_fail:
 	usb_free_urb(sz->urb_in);
 free_buf_in:
diff --git a/drivers/media/rc/xbox_remote.c b/drivers/media/rc/xbox_remote.c
index 3e3da70cf8da..e2ed2e2c2723 100644
--- a/drivers/media/rc/xbox_remote.c
+++ b/drivers/media/rc/xbox_remote.c
@@ -55,7 +55,7 @@ struct xbox_remote {
 	struct usb_interface *interface;
 
 	struct urb *irq_urb;
-	unsigned char inbuf[DATA_BUFSIZE] __aligned(sizeof(u16));
+	u8 *inbuf;
 
 	char rc_name[NAME_BUFSIZE];
 	char rc_phys[NAME_BUFSIZE];
@@ -218,6 +218,10 @@ static int xbox_remote_probe(struct usb_interface *interface,
 	if (!xbox_remote || !rc_dev)
 		goto exit_free_dev_rdev;
 
+	xbox_remote->inbuf = kzalloc(DATA_BUFSIZE, GFP_KERNEL);
+	if (!xbox_remote->inbuf)
+		goto exit_free_inbuf;
+
 	/* Allocate URB buffer */
 	xbox_remote->irq_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xbox_remote->irq_urb)
@@ -262,6 +266,8 @@ static int xbox_remote_probe(struct usb_interface *interface,
 	usb_kill_urb(xbox_remote->irq_urb);
 exit_free_buffers:
 	usb_free_urb(xbox_remote->irq_urb);
+exit_free_inbuf:
+	kfree(xbox_remote->inbuf);
 exit_free_dev_rdev:
 	rc_free_device(rc_dev);
 	kfree(xbox_remote);
@@ -286,6 +292,7 @@ static void xbox_remote_disconnect(struct usb_interface *interface)
 	usb_kill_urb(xbox_remote->irq_urb);
 	rc_unregister_device(xbox_remote->rdev);
 	usb_free_urb(xbox_remote->irq_urb);
+	kfree(xbox_remote->inbuf);
 	kfree(xbox_remote);
 }
 
diff --git a/drivers/media/usb/uvc/uvc_queue.c b/drivers/media/usb/uvc/uvc_queue.c
index 8b8f44b4a045..0eddd4f872ca 100644
--- a/drivers/media/usb/uvc/uvc_queue.c
+++ b/drivers/media/usb/uvc/uvc_queue.c
@@ -243,7 +243,7 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type)
 	int ret;
 
 	queue->queue.type = type;
-	queue->queue.io_modes = VB2_MMAP | VB2_USERPTR;
+	queue->queue.io_modes = VB2_MMAP | VB2_USERPTR | VB2_DMABUF;
 	queue->queue.drv_priv = queue;
 	queue->queue.buf_struct_size = sizeof(struct uvc_buffer);
 	queue->queue.mem_ops = &vb2_vmalloc_memops;
@@ -256,7 +256,6 @@ int uvc_queue_init(struct uvc_video_queue *queue, enum v4l2_buf_type type)
 		queue->queue.ops = &uvc_meta_queue_qops;
 		break;
 	default:
-		queue->queue.io_modes |= VB2_DMABUF;
 		queue->queue.ops = &uvc_queue_qops;
 		break;
 	}
diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 988a0acc9622..62fd2fe0d8d0 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -399,6 +399,11 @@ static const struct key_entry hp_wmi_keymap[] = {
 	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
 	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
 	{ KE_KEY, 0x231b,  { KEY_HELP } },
+	{ KE_IGNORE, 0x21ab, }, /* FnLock on */
+	{ KE_IGNORE, 0x121ab, }, /* FnLock off */
+	{ KE_IGNORE, 0x30021aa, }, /* kbd backlight: level 2 -> off */
+	{ KE_IGNORE, 0x33221aa, }, /* kbd backlight: off -> level 1 */
+	{ KE_IGNORE, 0x36421aa, }, /* kbd backlight: level 1 -> level 2*/
 	{ KE_END, 0 }
 };
 
diff --git a/drivers/regulator/act8945a-regulator.c b/drivers/regulator/act8945a-regulator.c
index 24cbdd833863..5bbe2bce740e 100644
--- a/drivers/regulator/act8945a-regulator.c
+++ b/drivers/regulator/act8945a-regulator.c
@@ -302,8 +302,9 @@ static int act8945a_pmic_probe(struct platform_device *pdev)
 		num_regulators = ARRAY_SIZE(act8945a_regulators);
 	}
 
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
 	config.dev = &pdev->dev;
-	config.dev->of_node = pdev->dev.parent->of_node;
 	config.driver_data = act8945a;
 	for (i = 0; i < num_regulators; i++) {
 		rdev = devm_regulator_register(&pdev->dev, &regulators[i],
diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index 209beabb5c37..f4de24a281b1 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -287,8 +287,9 @@ static int bd9571mwv_regulator_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bdreg);
 
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
 	config.dev = &pdev->dev;
-	config.dev->of_node = pdev->dev.parent->of_node;
 	config.driver_data = bdreg;
 	config.regmap = bdreg->regmap;
 
diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index dab8f1ab4450..711dbe045383 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -142,8 +142,7 @@ static int bq257xx_regulator_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
 	if (!pdata)
diff --git a/drivers/regulator/max77650-regulator.c b/drivers/regulator/max77650-regulator.c
index a809264c77fc..11b04a13f889 100644
--- a/drivers/regulator/max77650-regulator.c
+++ b/drivers/regulator/max77650-regulator.c
@@ -337,7 +337,7 @@ static int max77650_regulator_probe(struct platform_device *pdev)
 	parent = dev->parent;
 
 	if (!dev->of_node)
-		dev->of_node = parent->of_node;
+		device_set_of_node_from_dev(dev, parent);
 
 	rdescs = devm_kcalloc(dev, MAX77650_REGULATOR_NUM_REGULATORS,
 			      sizeof(*rdescs), GFP_KERNEL);
diff --git a/drivers/regulator/mt6357-regulator.c b/drivers/regulator/mt6357-regulator.c
index 1eb69c7a6acb..09feb454ab6b 100644
--- a/drivers/regulator/mt6357-regulator.c
+++ b/drivers/regulator/mt6357-regulator.c
@@ -410,7 +410,7 @@ static int mt6357_regulator_probe(struct platform_device *pdev)
 	struct regulator_dev *rdev;
 	int i;
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	for (i = 0; i < MT6357_MAX_REGULATOR; i++) {
 		config.dev = &pdev->dev;
diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index e66408f23bb6..1e956153427e 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -2114,8 +2114,7 @@ static int rk808_regulator_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret, i, nregulators;
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!regmap)
diff --git a/drivers/regulator/s2dos05-regulator.c b/drivers/regulator/s2dos05-regulator.c
index 1463585c4565..a1c394ddbaff 100644
--- a/drivers/regulator/s2dos05-regulator.c
+++ b/drivers/regulator/s2dos05-regulator.c
@@ -126,7 +126,7 @@ static int s2dos05_pmic_probe(struct platform_device *pdev)
 	s2dos05->regmap = iodev->regmap_pmic;
 	s2dos05->dev = dev;
 	if (!dev->of_node)
-		dev->of_node = dev->parent->of_node;
+		device_set_of_node_from_dev(dev, dev->parent);
 
 	config.dev = dev;
 	config.driver_data = s2dos05;
diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 9d568e385f05..e15d7112bb55 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -800,7 +800,7 @@ static int aml_spisg_probe(struct platform_device *pdev)
 		goto out_clk;
 	}
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret) {
 		dev_err(&pdev->dev, "spi controller registration failed\n");
 		goto out_clk;
@@ -823,6 +823,8 @@ static void aml_spisg_remove(struct platform_device *pdev)
 {
 	struct spisg_device *spisg = platform_get_drvdata(pdev);
 
+	spi_unregister_controller(spisg->controller);
+
 	if (!pm_runtime_suspended(&pdev->dev)) {
 		pinctrl_pm_select_sleep_state(&spisg->pdev->dev);
 		clk_disable_unprepare(spisg->core);
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 9c286e534bf0..c21323e07d3c 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -972,7 +972,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	aspi = spi_controller_get_devdata(ctlr);
-	platform_set_drvdata(pdev, aspi);
+	platform_set_drvdata(pdev, ctlr);
 	aspi->data = data;
 	aspi->dev = dev;
 
@@ -1021,7 +1021,7 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret)
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
 
@@ -1030,7 +1030,10 @@ static int aspeed_spi_probe(struct platform_device *pdev)
 
 static void aspeed_spi_remove(struct platform_device *pdev)
 {
-	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct aspeed_spi *aspi = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
 
 	aspeed_spi_enable(aspi, false);
 }
diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index 76eb3ba75ab1..79edc1cd13c0 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -556,7 +556,7 @@ static int at91_usart_spi_probe(struct platform_device *pdev)
 	spin_lock_init(&aus->lock);
 	init_completion(&aus->xfer_completion);
 
-	ret = devm_spi_register_controller(&pdev->dev, controller);
+	ret = spi_register_controller(controller);
 	if (ret)
 		goto at91_usart_fail_register_controller;
 
@@ -634,8 +634,14 @@ static void at91_usart_spi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct at91_usart_spi *aus = spi_controller_get_devdata(ctlr);
 
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	at91_usart_spi_release_dma(ctlr);
 	clk_disable_unprepare(aus->clk);
+
+	spi_controller_put(ctlr);
 }
 
 static const struct dev_pm_ops at91_usart_spi_pm_ops = {
diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 445d645585bf..42db85d7ff8e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -1654,7 +1654,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_free_dma;
 
@@ -1688,8 +1688,12 @@ static void atmel_spi_remove(struct platform_device *pdev)
 	struct spi_controller	*host = platform_get_drvdata(pdev);
 	struct atmel_spi	*as = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(host);
+
 	/* reset the hardware and block queue progress */
 	if (as->use_dma) {
 		atmel_spi_stop_dma(host);
@@ -1716,6 +1720,8 @@ static void atmel_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static int atmel_spi_runtime_suspend(struct device *dev)
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 47266bb23a33..40cd7efc4b54 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -602,7 +602,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		goto out_clk_disable;
 
 	/* register and we are done */
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(dev, "spi register failed\n");
 		goto out_clk_disable;
@@ -625,11 +625,17 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcm63xx_spi *bs = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* reset spi block */
 	bcm_spi_writeb(bs, 0, SPI_INT_MASK);
 
 	/* HW shutdown */
 	clk_disable_unprepare(bs->clk);
+
+	spi_controller_put(host);
 }
 
 static int bcm63xx_spi_suspend(struct device *dev)
diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
index ece22260f570..4ea8cc784e9e 100644
--- a/drivers/spi/spi-bcmbca-hsspi.c
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -549,7 +549,7 @@ static int bcmbca_hsspi_probe(struct platform_device *pdev)
 	}
 
 	/* register and we are done */
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_sysgroup_disable;
 
@@ -571,6 +571,8 @@ static void bcmbca_hsspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct bcmbca_hsspi *bs = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	/* reset the hardware and block queue progress */
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
 	clk_disable_unprepare(bs->pll_clk);
diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2ead419e896e..1b0d6186c7ef 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1864,14 +1864,10 @@ static int cqspi_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENXIO;
 
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		return ret;
-
 	ret = clk_bulk_prepare_enable(CLK_QSPI_NUM, cqspi->clks);
 	if (ret) {
 		dev_err(dev, "Cannot enable QSPI clocks.\n");
-		goto disable_rpm;
+		return ret;
 	}
 
 	/* Obtain QSPI reset control */
@@ -1966,10 +1962,11 @@ static int cqspi_probe(struct platform_device *pdev)
 	cqspi->sclk = 0;
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_enable(dev);
 		pm_runtime_set_autosuspend_delay(dev, CQSPI_AUTOSUSPEND_TIMEOUT);
 		pm_runtime_use_autosuspend(dev);
 		pm_runtime_get_noresume(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
 	}
 
 	host->num_chipselect = cqspi->num_chipselect;
@@ -1981,7 +1978,7 @@ static int cqspi_probe(struct platform_device *pdev)
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER) {
 			dev_err_probe(&pdev->dev, ret, "Failed to request mmap DMA\n");
-			goto disable_controller;
+			goto disable_rpm;
 		}
 	}
 
@@ -1999,14 +1996,16 @@ static int cqspi_probe(struct platform_device *pdev)
 release_dma_chan:
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
-disable_controller:
-	cqspi_controller_enable(cqspi, 0);
-disable_clks:
-	if (pm_runtime_get_sync(&pdev->dev) >= 0)
-		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 disable_rpm:
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
 		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_put_noidle(dev);
+		pm_runtime_dont_use_autosuspend(dev);
+	}
+	cqspi_controller_enable(cqspi, 0);
+disable_clks:
+	clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
 
 	return ret;
 }
@@ -2020,28 +2019,29 @@ static void cqspi_remove(struct platform_device *pdev)
 
 	ddata = of_device_get_match_data(dev);
 
+	spi_unregister_controller(cqspi->host);
+
 	refcount_set(&cqspi->refcount, 0);
 
 	if (!refcount_dec_and_test(&cqspi->inflight_ops))
 		cqspi_wait_idle(cqspi);
 
-	spi_unregister_controller(cqspi->host);
-
 	if (cqspi->rx_chan)
 		dma_release_channel(cqspi->rx_chan);
 
-	cqspi_controller_enable(cqspi, 0);
-
-
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
 		ret = pm_runtime_get_sync(&pdev->dev);
 
-	if (ret >= 0)
+	if (ret >= 0) {
+		cqspi_controller_enable(cqspi, 0);
 		clk_bulk_disable_unprepare(CLK_QSPI_NUM, cqspi->clks);
+	}
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		pm_runtime_put_sync(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
+		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 }
 
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index caa7a57e6d27..891e2ba36958 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -741,7 +741,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		/* Set to default valid value */
 		ctlr->max_speed_hz = xspi->clk_rate / 4;
 		xspi->speed_hz = ctlr->max_speed_hz;
-		pm_runtime_put_autosuspend(&pdev->dev);
 	} else {
 		ctlr->mode_bits |= SPI_NO_CS;
 		ctlr->target_abort = cdns_target_abort;
@@ -752,12 +751,17 @@ static int cdns_spi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	if (!spi_controller_is_target(ctlr))
+		pm_runtime_put_autosuspend(&pdev->dev);
+
 	return ret;
 
 clk_dis_all:
 	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 remove_ctlr:
 	spi_controller_put(ctlr);
@@ -776,15 +780,26 @@ static void cdns_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct cdns_spi *xspi = spi_controller_get_devdata(ctlr);
+	int ret = 0;
 
-	cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
+	if (!spi_controller_is_target(ctlr))
+		ret = pm_runtime_get_sync(&pdev->dev);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
+	if (ret >= 0)
+		cdns_spi_write(xspi, CDNS_SPI_ER, CDNS_SPI_ER_DISABLE);
 
 	if (!spi_controller_is_target(ctlr)) {
 		pm_runtime_disable(&pdev->dev);
 		pm_runtime_set_suspended(&pdev->dev);
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_dont_use_autosuspend(&pdev->dev);
 	}
 
-	spi_unregister_controller(ctlr);
+	spi_controller_put(ctlr);
 }
 
 /**
diff --git a/drivers/spi/spi-cavium-octeon.c b/drivers/spi/spi-cavium-octeon.c
index 155085a053a1..b95bfa6a3013 100644
--- a/drivers/spi/spi-cavium-octeon.c
+++ b/drivers/spi/spi-cavium-octeon.c
@@ -54,7 +54,7 @@ static int octeon_spi_probe(struct platform_device *pdev)
 	host->bits_per_word_mask = SPI_BPW_MASK(8);
 	host->max_speed_hz = OCTEON_SPI_MAX_CLOCK_HZ;
 
-	err = devm_spi_register_controller(&pdev->dev, host);
+	err = spi_register_controller(host);
 	if (err) {
 		dev_err(&pdev->dev, "register host failed: %d\n", err);
 		goto fail;
@@ -73,8 +73,14 @@ static void octeon_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct octeon_spi *p = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Clear the CSENA* and put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id octeon_spi_match[] = {
diff --git a/drivers/spi/spi-cavium-thunderx.c b/drivers/spi/spi-cavium-thunderx.c
index 99aac40a1bba..f1a9aa696c87 100644
--- a/drivers/spi/spi-cavium-thunderx.c
+++ b/drivers/spi/spi-cavium-thunderx.c
@@ -70,7 +70,7 @@ static int thunderx_spi_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto error;
 
@@ -90,8 +90,14 @@ static void thunderx_spi_remove(struct pci_dev *pdev)
 	if (!p)
 		return;
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	/* Put everything in a known state. */
 	writeq(0, p->register_base + OCTEON_SPI_CFG(p));
+
+	spi_controller_put(host);
 }
 
 static const struct pci_device_id thunderx_spi_pci_id_table[] = {
diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
index ded093566260..3eaa8f176f63 100644
--- a/drivers/spi/spi-ch341.c
+++ b/drivers/spi/spi-ch341.c
@@ -152,7 +152,7 @@ static int ch341_probe(struct usb_interface *intf,
 	if (ret)
 		return ret;
 
-	ctrl = devm_spi_alloc_host(&udev->dev, sizeof(struct ch341_spi_dev));
+	ctrl = devm_spi_alloc_host(&intf->dev, sizeof(struct ch341_spi_dev));
 	if (!ctrl)
 		return -ENOMEM;
 
@@ -163,7 +163,7 @@ static int ch341_probe(struct usb_interface *intf,
 	ch341->read_pipe = usb_rcvbulkpipe(udev, usb_endpoint_num(in));
 
 	ch341->rx_len = usb_endpoint_maxp(in);
-	ch341->rx_buf = devm_kzalloc(&udev->dev, ch341->rx_len, GFP_KERNEL);
+	ch341->rx_buf = devm_kzalloc(&intf->dev, ch341->rx_len, GFP_KERNEL);
 	if (!ch341->rx_buf)
 		return -ENOMEM;
 
@@ -171,8 +171,7 @@ static int ch341_probe(struct usb_interface *intf,
 	if (!ch341->rx_urb)
 		return -ENOMEM;
 
-	ch341->tx_buf =
-		devm_kzalloc(&udev->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
+	ch341->tx_buf = devm_kzalloc(&intf->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
 	if (!ch341->tx_buf) {
 		ret = -ENOMEM;
 		goto err_free_urb;
diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index fdf37636cb9f..b45f44de85dc 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -410,9 +410,9 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, host);
 	pm_runtime_enable(&pdev->dev);
 
-	status = devm_spi_register_controller(&pdev->dev, host);
+	status = spi_register_controller(host);
 	if (status) {
-		dev_dbg(&pdev->dev, "devm_spi_register_controller failed\n");
+		dev_dbg(&pdev->dev, "failed to register controller\n");
 		goto fail1;
 	}
 
@@ -436,11 +436,17 @@ static void mcfqspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mcfqspi *mcfqspi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 	/* disable the hardware (set the baud rate to 0) */
 	mcfqspi_wr_qmr(mcfqspi, MCFQSPI_QMR_MSTR);
 
 	mcfqspi_cs_teardown(mcfqspi);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-dln2.c b/drivers/spi/spi-dln2.c
index d90282960ab6..392f0d05f508 100644
--- a/drivers/spi/spi-dln2.c
+++ b/drivers/spi/spi-dln2.c
@@ -758,7 +758,7 @@ static int dln2_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register host\n");
 		goto exit_register;
@@ -783,10 +783,16 @@ static void dln2_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct dln2_spi *dln2 = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 
 	if (dln2_spi_enable(dln2, false) < 0)
 		dev_err(&pdev->dev, "Failed to disable SPI module\n");
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 90d5f3ea6508..db50018050e5 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -689,7 +689,7 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	/* make sure that the hardware is disabled */
 	writel(0, espi->mmio + SSPCR1);
 
-	error = devm_spi_register_controller(&pdev->dev, host);
+	error = spi_register_controller(host);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register SPI host\n");
 		goto fail_free_dma;
@@ -713,7 +713,13 @@ static void ep93xx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct ep93xx_spi *espi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	ep93xx_spi_release_dma(espi);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id ep93xx_spi_of_ids[] = {
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 56270f8fdc17..45b9974ae911 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -718,7 +718,7 @@ static int fsl_espi_probe(struct device *dev, struct resource *mem,
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0)
 		goto err_pm;
 
@@ -782,7 +782,15 @@ static int of_fsl_espi_probe(struct platform_device *ofdev)
 
 static void of_fsl_espi_remove(struct platform_device *dev)
 {
+	struct spi_controller *host = platform_get_drvdata(dev);
+
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&dev->dev);
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bf3fc3ce0cc2..1252c41c206f 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -614,7 +614,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
 
 	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret < 0)
 		goto err_probe;
 
@@ -705,7 +705,13 @@ static void of_fsl_spi_remove(struct platform_device *ofdev)
 	struct spi_controller *host = platform_get_drvdata(ofdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 static struct platform_driver of_fsl_spi_driver = {
@@ -751,7 +757,13 @@ static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	fsl_spi_cpm_free(mpc8xxx_spi);
+
+	spi_controller_put(host);
 }
 
 MODULE_ALIAS("platform:mpc8xxx_spi");
diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 902fb64815c9..57625a3ce2f2 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -643,7 +643,7 @@ static int img_spfi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(spfi->dev);
 	pm_runtime_enable(spfi->dev);
 
-	ret = devm_spi_register_controller(spfi->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -669,6 +669,10 @@ static void img_spfi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct img_spfi *spfi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	if (spfi->tx_ch)
 		dma_release_channel(spfi->tx_ch);
 	if (spfi->rx_ch)
@@ -679,6 +683,8 @@ static void img_spfi_remove(struct platform_device *pdev)
 		clk_disable_unprepare(spfi->spfi_clk);
 		clk_disable_unprepare(spfi->sys_clk);
 	}
+
+	spi_controller_put(host);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index a8d90c86a8a1..164167b593ef 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -2384,6 +2384,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 out_runtime_pm_put:
 	pm_runtime_dont_use_autosuspend(spi_imx->dev);
 	pm_runtime_disable(spi_imx->dev);
+	pm_runtime_put_noidle(spi_imx->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
 	clk_disable_unprepare(spi_imx->clk_ipg);
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index f83cb63c9d0c..75b9af8cb5db 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -994,7 +994,7 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 		"Lantiq SSC SPI controller (Rev %i, TXFS %u, RXFS %u, DMA %u)\n",
 		revision, spi->tx_fifo_size, spi->rx_fifo_size, supports_dma);
 
-	err = devm_spi_register_controller(dev, host);
+	err = spi_register_controller(host);
 	if (err) {
 		dev_err(dev, "failed to register spi host\n");
 		goto err_wq_destroy;
@@ -1016,6 +1016,10 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 {
 	struct lantiq_ssc_spi *spi = platform_get_drvdata(pdev);
 
+	spi_controller_get(spi->host);
+
+	spi_unregister_controller(spi->host);
+
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_IRNEN);
 	lantiq_ssc_writel(spi, 0, LTQ_SPI_CLC);
 	rx_fifo_flush(spi);
@@ -1024,6 +1028,8 @@ static void lantiq_ssc_remove(struct platform_device *pdev)
 
 	destroy_workqueue(spi->wq);
 	clk_put(spi->fpi_clk);
+
+	spi_controller_put(spi->host);
 }
 
 static struct platform_driver lantiq_ssc_driver = {
diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 57768da3205d..b80f9f457b66 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -1081,7 +1081,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "spi registration failed\n");
 		goto out_host;
@@ -1099,8 +1099,14 @@ static void meson_spicc_remove(struct platform_device *pdev)
 {
 	struct meson_spicc_device *spicc = platform_get_drvdata(pdev);
 
+	spi_controller_get(spicc->host);
+
+	spi_unregister_controller(spicc->host);
+
 	/* Disable SPI */
 	writel(0, spicc->base + SPICC_CONREG);
+
+	spi_controller_put(spicc->host);
 }
 
 static const struct meson_spicc_data meson_spicc_gx_data = {
diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index 05bbd3795e7d..924d820448fb 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -498,6 +498,9 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 
  err_register:
 	dev_err(&ms->host->dev, "initialization failed\n");
+	free_irq(ms->irq0, ms);
+	free_irq(ms->irq1, ms);
+	cancel_work_sync(&ms->work);
  err_gpio:
 	while (i-- > 0)
 		gpiod_put(ms->gpio_cs[i]);
@@ -517,15 +520,17 @@ static void mpc52xx_spi_remove(struct platform_device *op)
 	struct mpc52xx_spi *ms = spi_controller_get_devdata(host);
 	int i;
 
-	cancel_work_sync(&ms->work);
+	spi_unregister_controller(host);
+
 	free_irq(ms->irq0, ms);
 	free_irq(ms->irq1, ms);
 
+	cancel_work_sync(&ms->work);
+
 	for (i = 0; i < ms->gpio_cs_count; i++)
 		gpiod_put(ms->gpio_cs[i]);
 
 	kfree(ms->gpio_cs);
-	spi_unregister_controller(host);
 	iounmap(ms->regs);
 	spi_controller_put(host);
 }
diff --git a/drivers/spi/spi-mpfs.c b/drivers/spi/spi-mpfs.c
index 64d15a6188ac..989a379b0700 100644
--- a/drivers/spi/spi-mpfs.c
+++ b/drivers/spi/spi-mpfs.c
@@ -574,7 +574,7 @@ static int mpfs_spi_probe(struct platform_device *pdev)
 
 	mpfs_spi_init(host, spi);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		mpfs_spi_disable_ints(spi);
 		mpfs_spi_disable(spi);
@@ -592,6 +592,8 @@ static void mpfs_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host  = platform_get_drvdata(pdev);
 	struct mpfs_spi *spi = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	mpfs_spi_disable_ints(spi);
 	mpfs_spi_disable(spi);
 }
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0368a26bca9a..96f8555be983 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -1325,7 +1325,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		pm_runtime_disable(dev);
 		return dev_err_probe(dev, ret, "failed to register host\n");
@@ -1340,6 +1340,8 @@ static void mtk_spi_remove(struct platform_device *pdev)
 	struct mtk_spi *mdata = spi_controller_get_devdata(host);
 	int ret;
 
+	spi_unregister_controller(host);
+
 	cpu_latency_qos_remove_request(&mdata->qos_request);
 	if (mdata->use_spimem && !completion_done(&mdata->spimem_done))
 		complete(&mdata->spimem_done);
diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 1e5ec0840174..74f34537b02c 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -913,7 +913,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_noresume(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0)
 		goto err_probe;
 
@@ -938,6 +938,8 @@ static void mtk_nor_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = dev_get_drvdata(&pdev->dev);
 	struct mtk_nor *sp = spi_controller_get_devdata(ctlr);
 
+	spi_unregister_controller(ctlr);
+
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_dont_use_autosuspend(&pdev->dev);
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f9369c69911c..b0e7fc828a50 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -832,9 +832,10 @@ static void mxic_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct mxic_spi *mxic = spi_controller_get_devdata(host);
 
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 	mxic_spi_mem_ecc_remove(mxic);
-	spi_unregister_controller(host);
 }
 
 static const struct of_device_id mxic_spi_of_ids[] = {
diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index b3301c69e2de..0164e04d59a1 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -619,7 +619,7 @@ static int mxs_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_pm_runtime_put;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Cannot register SPI host, %d\n", ret);
 		goto out_pm_runtime_put;
@@ -650,11 +650,17 @@ static void mxs_spi_remove(struct platform_device *pdev)
 	spi = spi_controller_get_devdata(host);
 	ssp = &spi->ssp;
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		mxs_spi_runtime_suspend(&pdev->dev);
 
 	dma_release_channel(ssp->dmach);
+
+	spi_controller_put(host);
 }
 
 static struct platform_driver mxs_spi_driver = {
diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index e60b3cc398ec..cffef0a5977d 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -413,7 +413,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	/* set to default clock rate */
 	npcm_pspi_set_baudrate(priv, NPCM_PSPI_DEFAULT_CLK);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_disable_clk;
 
@@ -434,8 +434,14 @@ static void npcm_pspi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct npcm_pspi *priv = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	npcm_pspi_reset_hw(priv);
 	clk_disable_unprepare(priv->clk);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id npcm_pspi_match[] = {
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 2207e05c9d06..cd6d9bf9eaa4 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1585,7 +1585,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto disable_pm;
 
-	status = devm_spi_register_controller(&pdev->dev, ctlr);
+	status = spi_register_controller(ctlr);
 	if (status < 0)
 		goto disable_pm;
 
@@ -1606,11 +1606,17 @@ static void omap2_mcspi_remove(struct platform_device *pdev)
 	struct spi_controller *ctlr = platform_get_drvdata(pdev);
 	struct omap2_mcspi *mcspi = spi_controller_get_devdata(ctlr);
 
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	omap2_mcspi_release_dma(ctlr);
 
 	pm_runtime_dont_use_autosuspend(mcspi->dev);
 	pm_runtime_put_sync(mcspi->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(ctlr);
 }
 
 /* work with hotplug and coldplug */
diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 7a2186b51b4c..a5ce970ff5a8 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -774,6 +774,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
+	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
 	status = orion_spi_reset(spi);
@@ -784,10 +785,15 @@ static int orion_spi_probe(struct platform_device *pdev)
 	if (status < 0)
 		goto out_rel_pm;
 
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return status;
 
 out_rel_pm:
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 out_rel_axi_clk:
 	clk_disable_unprepare(spi->axi_clk);
 out:
@@ -801,11 +807,19 @@ static void orion_spi_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct orion_spi *spi = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_get_sync(&pdev->dev);
 	clk_disable_unprepare(spi->axi_clk);
 
-	spi_unregister_controller(host);
+	spi_controller_put(host);
+
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 051590038895..41662992dbe5 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -642,7 +642,7 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	host->prepare_transfer_hardware	= pic32_sqi_prepare_hardware;
 	host->unprepare_transfer_hardware	= pic32_sqi_unprepare_hardware;
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&host->dev, "failed registering spi host\n");
 		free_irq(sqi->irq, sqi);
@@ -665,9 +665,15 @@ static void pic32_sqi_remove(struct platform_device *pdev)
 {
 	struct pic32_sqi *sqi = platform_get_drvdata(pdev);
 
+	spi_controller_get(sqi->host);
+
+	spi_unregister_controller(sqi->host);
+
 	/* release resources */
 	free_irq(sqi->irq, sqi);
 	ring_desc_ring_free(sqi);
+
+	spi_controller_put(sqi->host);
 }
 
 static const struct of_device_id pic32_sqi_of_ids[] = {
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 369850d14313..70427e529945 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -821,7 +821,7 @@ static int pic32_spi_probe(struct platform_device *pdev)
 	}
 
 	/* register host */
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&host->dev, "failed registering spi host\n");
 		goto err_bailout;
@@ -840,11 +840,16 @@ static int pic32_spi_probe(struct platform_device *pdev)
 
 static void pic32_spi_remove(struct platform_device *pdev)
 {
-	struct pic32_spi *pic32s;
+	struct pic32_spi *pic32s = platform_get_drvdata(pdev);
+
+	spi_controller_get(pic32s->host);
+
+	spi_unregister_controller(pic32s->host);
 
-	pic32s = platform_get_drvdata(pdev);
 	pic32_spi_disable(pic32s);
 	pic32_spi_dma_unprep(pic32s);
+
+	spi_controller_put(pic32s->host);
 }
 
 static const struct of_device_id pic32_spi_of_match[] = {
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index c82cc522776d..e97ffcd13c62 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -1956,7 +1956,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Register with the SPI framework */
 	amba_set_drvdata(adev, pl022);
-	status = devm_spi_register_controller(&adev->dev, host);
+	status = spi_register_controller(host);
 	if (status != 0) {
 		dev_err_probe(&adev->dev, status,
 			      "problem registering spi host\n");
@@ -1997,6 +1997,10 @@ pl022_remove(struct amba_device *adev)
 	if (!pl022)
 		return;
 
+	spi_controller_get(pl022->host);
+
+	spi_unregister_controller(pl022->host);
+
 	/*
 	 * undo pm_runtime_put() in probe.  I assume that we're not
 	 * accessing the primecell here.
@@ -2008,6 +2012,8 @@ pl022_remove(struct amba_device *adev)
 		pl022_dma_remove(pl022);
 
 	amba_release_regions(adev);
+
+	spi_controller_put(pl022->host);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 6cbdcd060e8c..45d9b4cb75e4 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1193,7 +1193,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
 
-	ret = devm_spi_register_controller(dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto disable_pm;
 
@@ -1320,6 +1320,10 @@ static void spi_qup_remove(struct platform_device *pdev)
 	struct spi_qup *controller = spi_controller_get_devdata(host);
 	int ret;
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	ret = pm_runtime_get_sync(&pdev->dev);
 
 	if (ret >= 0) {
@@ -1339,6 +1343,8 @@ static void spi_qup_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(host);
 }
 
 static const struct of_device_id spi_qup_dt_match[] = {
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index c739c1998b4c..a8180dece716 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1171,8 +1171,14 @@ static void rspi_remove(struct platform_device *pdev)
 {
 	struct rspi_data *rspi = platform_get_drvdata(pdev);
 
+	spi_controller_get(rspi->ctlr);
+
+	spi_unregister_controller(rspi->ctlr);
+
 	rspi_release_dma(rspi->ctlr);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(rspi->ctlr);
 }
 
 static const struct spi_ops rspi_ops = {
@@ -1376,9 +1382,9 @@ static int rspi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error3;
 	}
 
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 96f39b5ae9df..37176e557099 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1369,7 +1369,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	       S3C64XX_SPI_INT_TX_OVERRUN_EN | S3C64XX_SPI_INT_TX_UNDERRUN_EN,
 	       sdd->regs + S3C64XX_SPI_INT_EN);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret != 0) {
 		dev_err(&pdev->dev, "cannot register SPI host: %d\n", ret);
 		goto err_pm_put;
@@ -1399,6 +1399,8 @@ static void s3c64xx_spi_remove(struct platform_device *pdev)
 
 	pm_runtime_get_sync(&pdev->dev);
 
+	spi_unregister_controller(host);
+
 	writel(0, sdd->regs + S3C64XX_SPI_INT_EN);
 
 	pm_runtime_put_noidle(&pdev->dev);
diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index e03eaca1b1a7..1e3ca718ca73 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -257,9 +257,9 @@ static int hspi_probe(struct platform_device *pdev)
 	ctlr->transfer_one_message = hspi_transfer_one_message;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(&pdev->dev, "failed to register controller\n");
 		goto error2;
 	}
 
@@ -279,9 +279,15 @@ static void hspi_remove(struct platform_device *pdev)
 {
 	struct hspi_priv *hspi = platform_get_drvdata(pdev);
 
+	spi_controller_get(hspi->ctlr);
+
+	spi_unregister_controller(hspi->ctlr);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_put(hspi->clk);
+
+	spi_controller_put(hspi->ctlr);
 }
 
 static const struct of_device_id hspi_of_match[] = {
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 7f3e08810560..f114b6313f4f 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1289,9 +1289,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		dev_warn(dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	if (ret < 0) {
-		dev_err(dev, "devm_spi_register_controller error.\n");
+		dev_err(dev, "failed to register controller\n");
 		goto err2;
 	}
 
@@ -1309,8 +1309,14 @@ static void sh_msiof_spi_remove(struct platform_device *pdev)
 {
 	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
 
+	spi_controller_get(p->ctlr);
+
+	spi_unregister_controller(p->ctlr);
+
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(p->ctlr);
 }
 
 static const struct platform_device_id spi_driver_ids[] = {
diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index ce889cb33228..7aedeaa5889d 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -453,7 +453,7 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = spi_register_controller(ctlr);
 	clk_disable_unprepare(mdata->spi_clk);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -473,7 +473,15 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 static void mtk_spi_slave_remove(struct platform_device *pdev)
 {
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+
+	spi_controller_get(ctlr);
+
+	spi_unregister_controller(ctlr);
+
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(ctlr);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 0f9fc320363c..fd3fd0ce122c 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -977,7 +977,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 		goto err_rpm_put;
 	}
 
-	ret = devm_spi_register_controller(&pdev->dev, sctlr);
+	ret = spi_register_controller(sctlr);
 	if (ret)
 		goto err_rpm_put;
 
@@ -1008,7 +1008,9 @@ static void sprd_spi_remove(struct platform_device *pdev)
 	if (ret < 0)
 		dev_err(ss->dev, "failed to resume SPI controller\n");
 
-	spi_controller_suspend(sctlr);
+	spi_controller_get(sctlr);
+
+	spi_unregister_controller(sctlr);
 
 	if (ret >= 0) {
 		if (ss->dma.enable)
@@ -1017,6 +1019,8 @@ static void sprd_spi_remove(struct platform_device *pdev)
 	}
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+
+	spi_controller_put(sctlr);
 }
 
 static int __maybe_unused sprd_spi_runtime_suspend(struct device *dev)
diff --git a/drivers/spi/spi-st-ssc4.c b/drivers/spi/spi-st-ssc4.c
index b173ef70d77e..9c8099fe6e19 100644
--- a/drivers/spi/spi-st-ssc4.c
+++ b/drivers/spi/spi-st-ssc4.c
@@ -349,7 +349,7 @@ static int spi_st_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register host\n");
 		goto rpm_disable;
@@ -371,10 +371,16 @@ static void spi_st_remove(struct platform_device *pdev)
 	struct spi_controller *host = platform_get_drvdata(pdev);
 	struct spi_st *spi_st = spi_controller_get_devdata(host);
 
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
+
 	pm_runtime_disable(&pdev->dev);
 
 	clk_disable_unprepare(spi_st->clk);
 
+	spi_controller_put(host);
+
 	pinctrl_pm_select_sleep_state(&pdev->dev);
 }
 
diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 9e1d364a6198..eac6c3e8908b 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -666,28 +666,24 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	}
 	priv->base_dma_addr = res->start;
 
-	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
 		dev_err(&pdev->dev, "failed to get clock\n");
 		ret = PTR_ERR(priv->clk);
 		goto out_host_put;
 	}
 
-	ret = clk_prepare_enable(priv->clk);
-	if (ret)
-		goto out_host_put;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto out_disable_clk;
+		goto out_host_put;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, uniphier_spi_handler,
 			       0, "uniphier-spi", priv);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
-		goto out_disable_clk;
+		goto out_host_put;
 	}
 
 	init_completion(&priv->xfer_done);
@@ -716,7 +712,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 	if (IS_ERR_OR_NULL(host->dma_tx)) {
 		if (PTR_ERR(host->dma_tx) == -EPROBE_DEFER) {
 			ret = -EPROBE_DEFER;
-			goto out_disable_clk;
+			goto out_host_put;
 		}
 		host->dma_tx = NULL;
 		dma_tx_burst = INT_MAX;
@@ -750,7 +746,7 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	host->max_dma_len = min(dma_tx_burst, dma_rx_burst);
 
-	ret = devm_spi_register_controller(&pdev->dev, host);
+	ret = spi_register_controller(host);
 	if (ret)
 		goto out_release_dma;
 
@@ -766,9 +762,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 		host->dma_tx = NULL;
 	}
 
-out_disable_clk:
-	clk_disable_unprepare(priv->clk);
-
 out_host_put:
 	spi_controller_put(host);
 	return ret;
@@ -777,14 +770,17 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 static void uniphier_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *host = platform_get_drvdata(pdev);
-	struct uniphier_spi_priv *priv = spi_controller_get_devdata(host);
+
+	spi_controller_get(host);
+
+	spi_unregister_controller(host);
 
 	if (host->dma_tx)
 		dma_release_channel(host->dma_tx);
 	if (host->dma_rx)
 		dma_release_channel(host->dma_rx);
 
-	clk_disable_unprepare(priv->clk);
+	spi_controller_put(host);
 }
 
 static const struct of_device_id uniphier_spi_match[] = {
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index a7f22de1c889..50366bf10f32 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1356,6 +1356,10 @@ static int atomisp_s_parm(struct file *file, void *fh,
 static long atomisp_vidioc_default(struct file *file, void *fh,
 				   bool valid_prio, unsigned int cmd, void *arg)
 {
+	/* Disable all private IOCTLs for now! */
+	if (cmd)
+		return -EINVAL;
+
 	struct video_device *vdev = video_devdata(file);
 	struct atomisp_sub_device *asd = atomisp_to_video_pipe(vdev)->asd;
 	int err;
diff --git a/drivers/staging/media/imx/imx-media-csi.c b/drivers/staging/media/imx/imx-media-csi.c
index fd7e37d803e7..55a7d8f38465 100644
--- a/drivers/staging/media/imx/imx-media-csi.c
+++ b/drivers/staging/media/imx/imx-media-csi.c
@@ -97,9 +97,6 @@ struct csi_priv {
 	/* the mipi virtual channel number at link validate */
 	int vc_num;
 
-	/* media bus config of the upstream subdevice CSI is receiving from */
-	struct v4l2_mbus_config mbus_cfg;
-
 	spinlock_t irqlock; /* protect eof_irq handler */
 	struct timer_list eof_timeout_timer;
 	int eof_irq;
@@ -403,7 +400,8 @@ static void csi_idmac_unsetup_vb2_buf(struct csi_priv *priv,
 }
 
 /* init the SMFC IDMAC channel */
-static int csi_idmac_setup_channel(struct csi_priv *priv)
+static int csi_idmac_setup_channel(struct csi_priv *priv,
+				   struct v4l2_mbus_config *mbus_cfg)
 {
 	struct imx_media_video_dev *vdev = priv->vdev;
 	const struct imx_media_pixfmt *incc;
@@ -432,7 +430,7 @@ static int csi_idmac_setup_channel(struct csi_priv *priv)
 	image.phys0 = phys[0];
 	image.phys1 = phys[1];
 
-	passthrough = requires_passthrough(&priv->mbus_cfg, infmt, incc);
+	passthrough = requires_passthrough(mbus_cfg, infmt, incc);
 	passthrough_cycles = 1;
 
 	/*
@@ -572,11 +570,12 @@ static void csi_idmac_unsetup(struct csi_priv *priv,
 	csi_idmac_unsetup_vb2_buf(priv, state);
 }
 
-static int csi_idmac_setup(struct csi_priv *priv)
+static int csi_idmac_setup(struct csi_priv *priv,
+			   struct v4l2_mbus_config *mbus_cfg)
 {
 	int ret;
 
-	ret = csi_idmac_setup_channel(priv);
+	ret = csi_idmac_setup_channel(priv, mbus_cfg);
 	if (ret)
 		return ret;
 
@@ -595,7 +594,8 @@ static int csi_idmac_setup(struct csi_priv *priv)
 	return 0;
 }
 
-static int csi_idmac_start(struct csi_priv *priv)
+static int csi_idmac_start(struct csi_priv *priv,
+			   struct v4l2_mbus_config *mbus_cfg)
 {
 	struct imx_media_video_dev *vdev = priv->vdev;
 	int ret;
@@ -619,7 +619,7 @@ static int csi_idmac_start(struct csi_priv *priv)
 	priv->last_eof = false;
 	priv->nfb4eof = false;
 
-	ret = csi_idmac_setup(priv);
+	ret = csi_idmac_setup(priv, mbus_cfg);
 	if (ret) {
 		v4l2_err(&priv->sd, "csi_idmac_setup failed: %d\n", ret);
 		goto out_free_dma_buf;
@@ -701,7 +701,8 @@ static void csi_idmac_stop(struct csi_priv *priv)
 }
 
 /* Update the CSI whole sensor and active windows */
-static int csi_setup(struct csi_priv *priv)
+static int csi_setup(struct csi_priv *priv,
+		     struct v4l2_mbus_config *mbus_cfg)
 {
 	struct v4l2_mbus_framefmt *infmt, *outfmt;
 	const struct imx_media_pixfmt *incc;
@@ -719,7 +720,7 @@ static int csi_setup(struct csi_priv *priv)
 	 * if cycles is set, we need to handle this over multiple cycles as
 	 * generic/bayer data
 	 */
-	if (is_parallel_bus(&priv->mbus_cfg) && incc->cycles) {
+	if (is_parallel_bus(mbus_cfg) && incc->cycles) {
 		if_fmt.width *= incc->cycles;
 		crop.width *= incc->cycles;
 	}
@@ -730,7 +731,7 @@ static int csi_setup(struct csi_priv *priv)
 			     priv->crop.width == 2 * priv->compose.width,
 			     priv->crop.height == 2 * priv->compose.height);
 
-	ipu_csi_init_interface(priv->csi, &priv->mbus_cfg, &if_fmt, outfmt);
+	ipu_csi_init_interface(priv->csi, mbus_cfg, &if_fmt, outfmt);
 
 	ipu_csi_set_dest(priv->csi, priv->dest);
 
@@ -745,9 +746,17 @@ static int csi_setup(struct csi_priv *priv)
 
 static int csi_start(struct csi_priv *priv)
 {
+	struct v4l2_mbus_config mbus_cfg = { .type = 0 };
 	struct v4l2_fract *input_fi, *output_fi;
 	int ret;
 
+	ret = csi_get_upstream_mbus_config(priv, &mbus_cfg);
+	if (ret) {
+		v4l2_err(&priv->sd,
+			 "failed to get upstream media bus configuration\n");
+		return ret;
+	}
+
 	input_fi = &priv->frame_interval[CSI_SINK_PAD];
 	output_fi = &priv->frame_interval[priv->active_output_pad];
 
@@ -758,7 +767,7 @@ static int csi_start(struct csi_priv *priv)
 		return ret;
 
 	/* Skip first few frames from a BT.656 source */
-	if (priv->mbus_cfg.type == V4L2_MBUS_BT656) {
+	if (mbus_cfg.type == V4L2_MBUS_BT656) {
 		u32 delay_usec, bad_frames = 20;
 
 		delay_usec = DIV_ROUND_UP_ULL((u64)USEC_PER_SEC *
@@ -769,12 +778,12 @@ static int csi_start(struct csi_priv *priv)
 	}
 
 	if (priv->dest == IPU_CSI_DEST_IDMAC) {
-		ret = csi_idmac_start(priv);
+		ret = csi_idmac_start(priv, &mbus_cfg);
 		if (ret)
 			goto stop_upstream;
 	}
 
-	ret = csi_setup(priv);
+	ret = csi_setup(priv, &mbus_cfg);
 	if (ret)
 		goto idmac_stop;
 
@@ -1138,7 +1147,6 @@ static int csi_link_validate(struct v4l2_subdev *sd,
 
 	mutex_lock(&priv->lock);
 
-	priv->mbus_cfg = mbus_cfg;
 	is_csi2 = !is_parallel_bus(&mbus_cfg);
 	if (is_csi2) {
 		/*
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index a3b04f0608c1..7612a078bdd1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5539,6 +5539,8 @@ static void run_state_machine(struct tcpm_port *port)
 		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
 		port->partner_source_caps = NULL;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
+		port->vdm_sm_running = false;
+		port->explicit_contract = false;
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7f87399938fa..8e7afb5a5980 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -609,8 +609,8 @@ struct cgroup {
 	/* used to wait for offlining of csses */
 	wait_queue_head_t offline_waitq;
 
-	/* used by cgroup_rmdir() to wait for dying tasks to leave */
-	wait_queue_head_t dying_populated_waitq;
+	/* defers killing csses after removal until cgroup is depopulated */
+	struct work_struct finish_destroy_work;
 
 	/* used to schedule release agent */
 	struct work_struct release_agent_work;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0ceba2c86d9c..2d6d268a2798 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -4080,7 +4080,7 @@ static inline void mmap_action_ioremap_full(struct vm_area_desc *desc,
 
 int mmap_action_prepare(struct vm_area_desc *desc);
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action);
+			 struct mmap_action *action, bool is_compat);
 
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index af4b88e106ab..4eb08c832f0b 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -586,9 +586,10 @@ static void io_zcrx_return_niov_freelist(struct net_iov *niov)
 {
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
-	spin_lock_bh(&area->freelist_lock);
+	guard(spinlock_bh)(&area->freelist_lock);
+	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
+		return;
 	area->freelist[area->free_count++] = net_iov_idx(niov);
-	spin_unlock_bh(&area->freelist_lock);
 }
 
 static void io_zcrx_return_niov(struct net_iov *niov)
@@ -1029,7 +1030,8 @@ static void io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq)
 {
 	struct io_zcrx_area *area = ifq->area;
 
-	spin_lock_bh(&area->freelist_lock);
+	guard(spinlock_bh)(&area->freelist_lock);
+
 	while (area->free_count && pp->alloc.count < PP_ALLOC_CACHE_REFILL) {
 		struct net_iov *niov = __io_zcrx_get_free_niov(area);
 		netmem_ref netmem = net_iov_to_netmem(niov);
@@ -1038,7 +1040,6 @@ static void io_zcrx_refill_slow(struct page_pool *pp, struct io_zcrx_ifq *ifq)
 		io_zcrx_sync_for_device(pp, niov);
 		net_mp_netmem_place_in_cache(pp, netmem);
 	}
-	spin_unlock_bh(&area->freelist_lock);
 }
 
 static netmem_ref io_pp_zc_alloc_netmems(struct page_pool *pp, gfp_t gfp)
@@ -1264,10 +1265,10 @@ static struct net_iov *io_alloc_fallback_niov(struct io_zcrx_ifq *ifq)
 	if (area->mem.is_dmabuf)
 		return NULL;
 
-	spin_lock_bh(&area->freelist_lock);
-	if (area->free_count)
-		niov = __io_zcrx_get_free_niov(area);
-	spin_unlock_bh(&area->freelist_lock);
+	scoped_guard(spinlock_bh, &area->freelist_lock) {
+		if (area->free_count)
+			niov = __io_zcrx_get_free_niov(area);
+	}
 
 	if (niov)
 		page_pool_fragment_netmem(net_iov_to_netmem(niov), 1);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4ca3cb993da2..6b2ee75c63eb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -278,10 +278,12 @@ static void cgroup_finalize_control(struct cgroup *cgrp, int ret);
 static void css_task_iter_skip(struct css_task_iter *it,
 			       struct task_struct *task);
 static int cgroup_destroy_locked(struct cgroup *cgrp);
+static void cgroup_finish_destroy(struct cgroup *cgrp);
+static void kill_css_sync(struct cgroup_subsys_state *css);
+static void kill_css_finish(struct cgroup_subsys_state *css);
 static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss);
 static void css_release(struct percpu_ref *ref);
-static void kill_css(struct cgroup_subsys_state *css);
 static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add);
@@ -858,6 +860,16 @@ static void cgroup_update_populated(struct cgroup *cgrp, bool populated)
 		if (was_populated == cgroup_is_populated(cgrp))
 			break;
 
+		/*
+		 * Subtree just emptied below an offlined cgrp. Fire deferred
+		 * destroy. The transition is one-shot.
+		 */
+		if (was_populated && !css_is_online(&cgrp->self)) {
+			cgroup_get(cgrp);
+			WARN_ON_ONCE(!queue_work(cgroup_offline_wq,
+						 &cgrp->finish_destroy_work));
+		}
+
 		cgroup1_check_for_release(cgrp);
 		TRACE_CGROUP_PATH(notify_populated, cgrp,
 				  cgroup_is_populated(cgrp));
@@ -2100,6 +2112,16 @@ static int cgroup_reconfigure(struct fs_context *fc)
 	return 0;
 }
 
+static void cgroup_finish_destroy_work_fn(struct work_struct *work)
+{
+	struct cgroup *cgrp = container_of(work, struct cgroup, finish_destroy_work);
+
+	cgroup_lock();
+	cgroup_finish_destroy(cgrp);
+	cgroup_unlock();
+	cgroup_put(cgrp);
+}
+
 static void init_cgroup_housekeeping(struct cgroup *cgrp)
 {
 	struct cgroup_subsys *ss;
@@ -2126,7 +2148,7 @@ static void init_cgroup_housekeeping(struct cgroup *cgrp)
 #endif
 
 	init_waitqueue_head(&cgrp->offline_waitq);
-	init_waitqueue_head(&cgrp->dying_populated_waitq);
+	INIT_WORK(&cgrp->finish_destroy_work, cgroup_finish_destroy_work_fn);
 	INIT_WORK(&cgrp->release_agent_work, cgroup1_release_agent);
 }
 
@@ -3436,7 +3458,8 @@ static void cgroup_apply_control_disable(struct cgroup *cgrp)
 
 			if (css->parent &&
 			    !(cgroup_ss_mask(dsct) & (1 << ss->id))) {
-				kill_css(css);
+				kill_css_sync(css);
+				kill_css_finish(css);
 			} else if (!css_visible(css)) {
 				css_clear_dir(css);
 				if (ss->css_reset)
@@ -5558,7 +5581,7 @@ static struct cftype cgroup_psi_files[] = {
  * css destruction is four-stage process.
  *
  * 1. Destruction starts.  Killing of the percpu_ref is initiated.
- *    Implemented in kill_css().
+ *    Implemented in kill_css_finish().
  *
  * 2. When the percpu_ref is confirmed to be visible as killed on all CPUs
  *    and thus css_tryget_online() is guaranteed to fail, the css can be
@@ -5768,16 +5791,6 @@ static void offline_css(struct cgroup_subsys_state *css)
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
 
 	wake_up_all(&css->cgroup->offline_waitq);
-
-	css->cgroup->nr_dying_subsys[ss->id]++;
-	/*
-	 * Parent css and cgroup cannot be freed until after the freeing
-	 * of child css, see css_free_rwork_fn().
-	 */
-	while ((css = css->parent)) {
-		css->nr_descendants--;
-		css->cgroup->nr_dying_subsys[ss->id]++;
-	}
 }
 
 /**
@@ -6047,7 +6060,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 /*
  * This is called when the refcnt of a css is confirmed to be killed.
  * css_tryget_online() is now guaranteed to fail.  Tell the subsystem to
- * initiate destruction and put the css ref from kill_css().
+ * initiate destruction and put the css ref from kill_css_finish().
  */
 static void css_killed_work_fn(struct work_struct *work)
 {
@@ -6079,16 +6092,15 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 }
 
 /**
- * kill_css - destroy a css
- * @css: css to destroy
+ * kill_css_sync - synchronous half of css teardown
+ * @css: css being killed
  *
- * This function initiates destruction of @css by removing cgroup interface
- * files and putting its base reference.  ->css_offline() will be invoked
- * asynchronously once css_tryget_online() is guaranteed to fail and when
- * the reference count reaches zero, @css will be released.
+ * See cgroup_destroy_locked().
  */
-static void kill_css(struct cgroup_subsys_state *css)
+static void kill_css_sync(struct cgroup_subsys_state *css)
 {
+	struct cgroup_subsys *ss = css->ss;
+
 	lockdep_assert_held(&cgroup_mutex);
 
 	if (css->flags & CSS_DYING)
@@ -6108,64 +6120,100 @@ static void kill_css(struct cgroup_subsys_state *css)
 	 */
 	css_clear_dir(css);
 
+	css->cgroup->nr_dying_subsys[ss->id]++;
 	/*
-	 * Killing would put the base ref, but we need to keep it alive
-	 * until after ->css_offline().
+	 * Parent css and cgroup cannot be freed until after the freeing
+	 * of child css, see css_free_rwork_fn().
+	 */
+	while ((css = css->parent)) {
+		css->nr_descendants--;
+		css->cgroup->nr_dying_subsys[ss->id]++;
+	}
+}
+
+/**
+ * kill_css_finish - deferred half of css teardown
+ * @css: css being killed
+ *
+ * See cgroup_destroy_locked().
+ */
+static void kill_css_finish(struct cgroup_subsys_state *css)
+{
+	lockdep_assert_held(&cgroup_mutex);
+
+	/*
+	 * Skip on re-entry: cgroup_apply_control_disable() may have killed @css
+	 * earlier. cgroup_destroy_locked() can still walk it because
+	 * offline_css() (which NULLs cgrp->subsys[ssid]) runs async.
+	 */
+	if (percpu_ref_is_dying(&css->refcnt))
+		return;
+
+	/*
+	 * Killing would put the base ref, but we need to keep it alive until
+	 * after ->css_offline().
 	 */
 	css_get(css);
 
 	/*
-	 * cgroup core guarantees that, by the time ->css_offline() is
-	 * invoked, no new css reference will be given out via
-	 * css_tryget_online().  We can't simply call percpu_ref_kill() and
-	 * proceed to offlining css's because percpu_ref_kill() doesn't
-	 * guarantee that the ref is seen as killed on all CPUs on return.
+	 * cgroup core guarantees that, by the time ->css_offline() is invoked,
+	 * no new css reference will be given out via css_tryget_online(). We
+	 * can't simply call percpu_ref_kill() and proceed to offlining css's
+	 * because percpu_ref_kill() doesn't guarantee that the ref is seen as
+	 * killed on all CPUs on return.
 	 *
-	 * Use percpu_ref_kill_and_confirm() to get notifications as each
-	 * css is confirmed to be seen as killed on all CPUs.
+	 * Use percpu_ref_kill_and_confirm() to get notifications as each css is
+	 * confirmed to be seen as killed on all CPUs.
 	 */
 	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
 }
 
 /**
- * cgroup_destroy_locked - the first stage of cgroup destruction
+ * cgroup_destroy_locked - destroy @cgrp (called on rmdir)
  * @cgrp: cgroup to be destroyed
  *
- * css's make use of percpu refcnts whose killing latency shouldn't be
- * exposed to userland and are RCU protected.  Also, cgroup core needs to
- * guarantee that css_tryget_online() won't succeed by the time
- * ->css_offline() is invoked.  To satisfy all the requirements,
- * destruction is implemented in the following two steps.
- *
- * s1. Verify @cgrp can be destroyed and mark it dying.  Remove all
- *     userland visible parts and start killing the percpu refcnts of
- *     css's.  Set up so that the next stage will be kicked off once all
- *     the percpu refcnts are confirmed to be killed.
- *
- * s2. Invoke ->css_offline(), mark the cgroup dead and proceed with the
- *     rest of destruction.  Once all cgroup references are gone, the
- *     cgroup is RCU-freed.
- *
- * This function implements s1.  After this step, @cgrp is gone as far as
- * the userland is concerned and a new cgroup with the same name may be
- * created.  As cgroup doesn't care about the names internally, this
- * doesn't cause any problem.
+ * Tear down @cgrp on behalf of rmdir. Constraints:
+ *
+ * - Userspace: rmdir must succeed when cgroup.procs and friends are empty.
+ *
+ * - Kernel: subsystem ->css_offline() must not run while any task in @cgrp's
+ *   subtree is still doing kernel work. A task hidden from cgroup.procs (past
+ *   exit_signals() with signal->live cleared) can still schedule, allocate, and
+ *   consume resources until its final context switch. Dying descendants in the
+ *   subtree can host such tasks too.
+ *
+ * - Kernel: css_tryget_online() must fail by the time ->css_offline() runs.
+ *
+ * The destruction runs in three parts:
+ *
+ * - This function: synchronous user-visible state teardown plus kill_css_sync()
+ *   on each subsystem css.
+ *
+ * - cgroup_finish_destroy(): kicks the percpu_ref kill via kill_css_finish() on
+ *   each subsystem css. Fires once @cgrp's subtree is fully drained, either
+ *   inline here or from cgroup_update_populated().
+ *
+ * - The percpu_ref kill chain: css_killed_ref_fn -> css_killed_work_fn ->
+ *   ->css_offline() -> release/free.
+ *
+ * Return 0 on success, -EBUSY if a userspace-visible task or an online child
+ * remains.
  */
 static int cgroup_destroy_locked(struct cgroup *cgrp)
-	__releases(&cgroup_mutex) __acquires(&cgroup_mutex)
 {
 	struct cgroup *tcgrp, *parent = cgroup_parent(cgrp);
 	struct cgroup_subsys_state *css;
 	struct cgrp_cset_link *link;
+	struct css_task_iter it;
+	struct task_struct *task;
 	int ssid, ret;
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	/*
-	 * Only migration can raise populated from zero and we're already
-	 * holding cgroup_mutex.
-	 */
-	if (cgroup_is_populated(cgrp))
+	css_task_iter_start(&cgrp->self, 0, &it);
+	task = css_task_iter_next(&it);
+	css_task_iter_end(&it);
+	if (task)
 		return -EBUSY;
 
 	/*
@@ -6189,9 +6237,8 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 		link->cset->dead = true;
 	spin_unlock_irq(&css_set_lock);
 
-	/* initiate massacre of all css's */
 	for_each_css(css, ssid, cgrp)
-		kill_css(css);
+		kill_css_sync(css);
 
 	/* clear and remove @cgrp dir, @cgrp has an extra ref on its kn */
 	css_clear_dir(&cgrp->self);
@@ -6222,79 +6269,27 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	/* put the base reference */
 	percpu_ref_kill(&cgrp->self.refcnt);
 
+	if (!cgroup_is_populated(cgrp))
+		cgroup_finish_destroy(cgrp);
+
 	return 0;
 };
 
 /**
- * cgroup_drain_dying - wait for dying tasks to leave before rmdir
- * @cgrp: the cgroup being removed
- *
- * cgroup.procs and cgroup.threads use css_task_iter which filters out
- * PF_EXITING tasks so that userspace doesn't see tasks that have already been
- * reaped via waitpid(). However, cgroup_has_tasks() - which tests whether the
- * cgroup has non-empty css_sets - is only updated when dying tasks pass through
- * cgroup_task_dead() in finish_task_switch(). This creates a window where
- * cgroup.procs reads empty but cgroup_has_tasks() is still true, making rmdir
- * fail with -EBUSY from cgroup_destroy_locked() even though userspace sees no
- * tasks.
- *
- * This function aligns cgroup_has_tasks() with what userspace can observe. If
- * cgroup_has_tasks() but the task iterator sees nothing (all remaining tasks are
- * PF_EXITING), we wait for cgroup_task_dead() to finish processing them. As the
- * window between PF_EXITING and cgroup_task_dead() is short, the wait is brief.
- *
- * This function only concerns itself with this cgroup's own dying tasks.
- * Whether the cgroup has children is cgroup_destroy_locked()'s problem.
- *
- * Each cgroup_task_dead() kicks the waitqueue via cset->cgrp_links, and we
- * retry the full check from scratch.
+ * cgroup_finish_destroy - deferred half of @cgrp destruction
+ * @cgrp: cgroup whose subtree just became empty
  *
- * Must be called with cgroup_mutex held.
+ * See cgroup_destroy_locked() for the rationale.
  */
-static int cgroup_drain_dying(struct cgroup *cgrp)
-	__releases(&cgroup_mutex) __acquires(&cgroup_mutex)
+static void cgroup_finish_destroy(struct cgroup *cgrp)
 {
-	struct css_task_iter it;
-	struct task_struct *task;
-	DEFINE_WAIT(wait);
+	struct cgroup_subsys_state *css;
+	int ssid;
 
 	lockdep_assert_held(&cgroup_mutex);
-retry:
-	if (!cgroup_has_tasks(cgrp))
-		return 0;
 
-	/* Same iterator as cgroup.threads - if any task is visible, it's busy */
-	css_task_iter_start(&cgrp->self, 0, &it);
-	task = css_task_iter_next(&it);
-	css_task_iter_end(&it);
-
-	if (task)
-		return -EBUSY;
-
-	/*
-	 * All remaining tasks are PF_EXITING and will pass through
-	 * cgroup_task_dead() shortly. Wait for a kick and retry.
-	 *
-	 * cgroup_has_tasks() can't transition from false to true while we're
-	 * holding cgroup_mutex, but the true to false transition happens
-	 * under css_set_lock (via cgroup_task_dead()). We must retest and
-	 * prepare_to_wait() under css_set_lock. Otherwise, the transition
-	 * can happen between our first test and prepare_to_wait(), and we
-	 * sleep with no one to wake us.
-	 */
-	spin_lock_irq(&css_set_lock);
-	if (!cgroup_has_tasks(cgrp)) {
-		spin_unlock_irq(&css_set_lock);
-		return 0;
-	}
-	prepare_to_wait(&cgrp->dying_populated_waitq, &wait,
-			TASK_UNINTERRUPTIBLE);
-	spin_unlock_irq(&css_set_lock);
-	mutex_unlock(&cgroup_mutex);
-	schedule();
-	finish_wait(&cgrp->dying_populated_waitq, &wait);
-	mutex_lock(&cgroup_mutex);
-	goto retry;
+	for_each_css(css, ssid, cgrp)
+		kill_css_finish(css);
 }
 
 int cgroup_rmdir(struct kernfs_node *kn)
@@ -6306,12 +6301,9 @@ int cgroup_rmdir(struct kernfs_node *kn)
 	if (!cgrp)
 		return 0;
 
-	ret = cgroup_drain_dying(cgrp);
-	if (!ret) {
-		ret = cgroup_destroy_locked(cgrp);
-		if (!ret)
-			TRACE_CGROUP_PATH(rmdir, cgrp);
-	}
+	ret = cgroup_destroy_locked(cgrp);
+	if (!ret)
+		TRACE_CGROUP_PATH(rmdir, cgrp);
 
 	cgroup_kn_unlock(kn);
 	return ret;
@@ -7071,7 +7063,6 @@ void cgroup_task_exit(struct task_struct *tsk)
 
 static void do_cgroup_task_dead(struct task_struct *tsk)
 {
-	struct cgrp_cset_link *link;
 	struct css_set *cset;
 	unsigned long flags;
 
@@ -7085,11 +7076,6 @@ static void do_cgroup_task_dead(struct task_struct *tsk)
 	if (thread_group_leader(tsk) && atomic_read(&tsk->signal->live))
 		list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 
-	/* kick cgroup_drain_dying() waiters, see cgroup_rmdir() */
-	list_for_each_entry(link, &cset->cgrp_links, cgrp_link)
-		if (waitqueue_active(&link->cgrp->dying_populated_waitq))
-			wake_up(&link->cgrp->dying_populated_waitq);
-
 	if (dl_task(tsk))
 		dec_dl_tasks_cs(tsk);
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index cc68a3692905..479c42e08b74 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -757,13 +757,18 @@ int kho_add_subtree(const char *name, void *fdt)
 		goto out_pack;
 	}
 
-	err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
-			  &phys, sizeof(phys));
-	if (err < 0)
-		goto out_pack;
+	fdt_err = fdt_setprop(root_fdt, off, KHO_FDT_SUB_TREE_PROP_NAME,
+			      &phys, sizeof(phys));
+	if (fdt_err < 0)
+		goto out_del_node;
 
 	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, name, fdt, false));
 
+	err = 0;
+	goto out_pack;
+
+out_del_node:
+	fdt_del_node(root_fdt, off);
 out_pack:
 	fdt_pack(root_fdt);
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c07996aeb2f4..9c7ff5179e4f 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4010,6 +4010,15 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		if (cpumask_empty(donee_mask))
 			break;
 
+		/*
+		 * If an earlier pass placed @p on @donor_dsq from a different
+		 * CPU and the donee hasn't consumed it yet, @p is still on the
+		 * previous CPU and task_rq(@p) != @rq. @p can't be moved
+		 * without its rq locked. Skip.
+		 */
+		if (task_rq(p) != rq)
+			continue;
+
 		donee = cpumask_any_and_distribute(donee_mask, p->cpus_ptr);
 		if (donee >= nr_cpu_ids)
 			continue;
@@ -5331,8 +5340,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	static DEFINE_MUTEX(helper_mutex);
 	struct scx_enable_cmd cmd;
 
-	if (!cpumask_equal(housekeeping_cpumask(HK_TYPE_DOMAIN),
-			   cpu_possible_mask)) {
+	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
 		pr_err("sched_ext: Not compatible with \"isolcpus=\" domain isolation\n");
 		return -EINVAL;
 	}
diff --git a/mm/util.c b/mm/util.c
index e2a51e3cfb24..a14de66c9458 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1186,7 +1186,8 @@ int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 		return err;
 
 	set_vma_from_desc(vma, &desc);
-	err = mmap_action_complete(vma, &desc.action);
+	err = mmap_action_complete(vma, &desc.action,
+				   /*is_compat=*/true);
 	if (err) {
 		const size_t len = vma_pages(vma) << PAGE_SHIFT;
 
@@ -1277,28 +1278,31 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 }
 
 static int mmap_action_finish(struct vm_area_struct *vma,
-			      struct mmap_action *action, int err)
+			      struct mmap_action *action, int err,
+			      bool is_compat)
 {
+	if (!err && action->success_hook)
+		err = action->success_hook(vma);
+
+	/*
+	 * If this is invoked from the compatibility layer, post-mmap() hook
+	 * logic will handle cleanup for us.
+	 */
+	if (!err || is_compat)
+		return err;
+
 	/*
 	 * If an error occurs, unmap the VMA altogether and return an error. We
 	 * only clear the newly allocated VMA, since this function is only
 	 * invoked if we do NOT merge, so we only clean up the VMA we created.
 	 */
-	if (err) {
-		if (action->error_hook) {
-			/* We may want to filter the error. */
-			err = action->error_hook(err);
-
-			/* The caller should not clear the error. */
-			VM_WARN_ON_ONCE(!err);
-		}
-		return err;
+	if (action->error_hook) {
+		/* We may want to filter the error. */
+		err = action->error_hook(err);
+		/* The caller should not clear the error. */
+		VM_WARN_ON_ONCE(!err);
 	}
-
-	if (action->success_hook)
-		return action->success_hook(vma);
-
-	return 0;
+	return err;
 }
 
 #ifdef CONFIG_MMU
@@ -1329,14 +1333,16 @@ EXPORT_SYMBOL(mmap_action_prepare);
  * mmap_action_complete - Execute VMA descriptor action.
  * @vma: The VMA to perform the action upon.
  * @action: The action to perform.
+ * @is_compat: Is this being invoked from the compatibility layer?
  *
  * Similar to mmap_action_prepare().
  *
- * Return: 0 on success, or error, at which point the VMA will be unmapped.
+ * Return: 0 on success, or error, at which point the VMA will be unmapped if
+ * !@is_compat.
  */
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action)
-
+			 struct mmap_action *action,
+			 bool is_compat)
 {
 	int err = 0;
 
@@ -1353,7 +1359,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err);
+	return mmap_action_finish(vma, action, err, is_compat);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #else
@@ -1373,7 +1379,8 @@ int mmap_action_prepare(struct vm_area_desc *desc)
 EXPORT_SYMBOL(mmap_action_prepare);
 
 int mmap_action_complete(struct vm_area_struct *vma,
-			 struct mmap_action *action)
+			 struct mmap_action *action,
+			 bool is_compat)
 {
 	int err = 0;
 
@@ -1388,7 +1395,7 @@ int mmap_action_complete(struct vm_area_struct *vma,
 		break;
 	}
 
-	return mmap_action_finish(vma, action, err);
+	return mmap_action_finish(vma, action, err, is_compat);
 }
 EXPORT_SYMBOL(mmap_action_complete);
 #endif
diff --git a/mm/vma.c b/mm/vma.c
index 30e8a2d254b8..5cd80cdcf82f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2708,7 +2708,7 @@ static int call_action_complete(struct mmap_state *map,
 {
 	int err;
 
-	err = mmap_action_complete(vma, action);
+	err = mmap_action_complete(vma, action, /*is_compat=*/false);
 
 	/* If we held the file rmap we need to release it. */
 	if (map->hold_file_rmap_lock) {
@@ -2778,7 +2778,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	if (have_mmap_prepare && allocated_new) {
 		error = call_action_complete(&map, &desc.action, vma);
-
 		if (error)
 			return error;
 	}
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index f28e9cbf8ad5..74ef7dc2b2f9 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -173,19 +173,12 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr,
-			struct batadv_orig_node *orig_node,
-			struct batadv_orig_node *orig_neigh)
+			struct batadv_orig_node *orig_node)
 {
 	struct batadv_neigh_node *neigh_node;
 
 	neigh_node = batadv_neigh_node_get_or_create(orig_node,
 						     hard_iface, neigh_addr);
-	if (!neigh_node)
-		goto out;
-
-	neigh_node->orig_node = orig_neigh;
-
-out:
 	return neigh_node;
 }
 
@@ -335,7 +328,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
 	const char *fwd_str;
 	u8 packet_num;
-	s16 buff_pos;
+	int buff_pos;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct sk_buff *skb;
 	u8 *packet_pos;
@@ -906,6 +899,31 @@ static u8 batadv_iv_orig_ifinfo_sum(struct batadv_orig_node *orig_node,
 	return sum;
 }
 
+/**
+ * batadv_iv_ogm_neigh_ifinfo_sum() - Get bcast_own sum for a last-hop neighbor
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @neigh_node: last-hop neighbor of an originator
+ *
+ * Return: Number of replied (rebroadcasted) OGMs for the originator currently
+ * announced by the neighbor. Returns 0 if the neighbor's originator entry is
+ * not available anymore.
+ */
+static u8 batadv_iv_ogm_neigh_ifinfo_sum(struct batadv_priv *bat_priv,
+					 const struct batadv_neigh_node *neigh_node)
+{
+	struct batadv_orig_node *orig_neigh;
+	u8 sum;
+
+	orig_neigh = batadv_orig_hash_find(bat_priv, neigh_node->addr);
+	if (!orig_neigh)
+		return 0;
+
+	sum = batadv_iv_orig_ifinfo_sum(orig_neigh, neigh_node->if_incoming);
+	batadv_orig_node_put(orig_neigh);
+
+	return sum;
+}
+
 /**
  * batadv_iv_ogm_orig_update() - use OGM to update corresponding data in an
  *  originator
@@ -975,17 +993,9 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	}
 
 	if (!neigh_node) {
-		struct batadv_orig_node *orig_tmp;
-
-		orig_tmp = batadv_iv_ogm_orig_get(bat_priv, ethhdr->h_source);
-		if (!orig_tmp)
-			goto unlock;
-
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     ethhdr->h_source,
-						     orig_node, orig_tmp);
-
-		batadv_orig_node_put(orig_tmp);
+						     orig_node);
 		if (!neigh_node)
 			goto unlock;
 	} else {
@@ -1037,10 +1047,9 @@ batadv_iv_ogm_orig_update(struct batadv_priv *bat_priv,
 	 */
 	if (router_ifinfo &&
 	    neigh_ifinfo->bat_iv.tq_avg == router_ifinfo->bat_iv.tq_avg) {
-		sum_orig = batadv_iv_orig_ifinfo_sum(router->orig_node,
-						     router->if_incoming);
-		sum_neigh = batadv_iv_orig_ifinfo_sum(neigh_node->orig_node,
-						      neigh_node->if_incoming);
+		sum_orig = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv, router);
+		sum_neigh = batadv_iv_ogm_neigh_ifinfo_sum(bat_priv,
+							   neigh_node);
 		if (sum_orig >= sum_neigh)
 			goto out;
 	}
@@ -1106,7 +1115,6 @@ static bool batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	if (!neigh_node)
 		neigh_node = batadv_iv_ogm_neigh_new(if_incoming,
 						     orig_neigh_node->orig,
-						     orig_neigh_node,
 						     orig_neigh_node);
 
 	if (!neigh_node)
@@ -1302,6 +1310,32 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
 	return ret;
 }
 
+/**
+ * batadv_orig_to_direct_router() - get direct next hop neighbor to an orig address
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @orig_addr: the originator MAC address to search the best next hop router for
+ * @if_outgoing: the interface where the OGM should be sent to
+ *
+ * Return: A neighbor node which is the best router towards the given originator
+ * address. Bonding candidates are ignored.
+ */
+static struct batadv_neigh_node *
+batadv_orig_to_direct_router(struct batadv_priv *bat_priv, u8 *orig_addr,
+			     struct batadv_hard_iface *if_outgoing)
+{
+	struct batadv_neigh_node *neigh_node;
+	struct batadv_orig_node *orig_node;
+
+	orig_node = batadv_orig_hash_find(bat_priv, orig_addr);
+	if (!orig_node)
+		return NULL;
+
+	neigh_node = batadv_orig_router_get(orig_node, if_outgoing);
+	batadv_orig_node_put(orig_node);
+
+	return neigh_node;
+}
+
 /**
  * batadv_iv_ogm_process_per_outif() - process a batman iv OGM for an outgoing
  *  interface
@@ -1372,8 +1406,9 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
 	if (router) {
-		router_router = batadv_orig_router_get(router->orig_node,
-						       if_outgoing);
+		router_router = batadv_orig_to_direct_router(bat_priv,
+							     router->addr,
+							     if_outgoing);
 		router_ifinfo = batadv_neigh_ifinfo_get(router, if_outgoing);
 	}
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 51fe028b9088..cec11f1251d6 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -318,8 +318,8 @@ batadv_bla_del_backbone_claims(struct batadv_bla_backbone_gw *backbone_gw)
 			if (claim->backbone_gw != backbone_gw)
 				continue;
 
-			batadv_claim_put(claim);
 			hlist_del_rcu(&claim->hash_entry);
+			batadv_claim_put(claim);
 		}
 		spin_unlock_bh(list_lock);
 	}
@@ -723,6 +723,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 
 		if (unlikely(hash_added != 0)) {
 			/* only local changes happened. */
+			batadv_backbone_gw_put(backbone_gw);
 			kfree(claim);
 			return;
 		}
@@ -1288,6 +1289,13 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(claim, head, hash_entry) {
+			/* only purge claims not currently in the process of being released.
+			 * Such claims could otherwise have a NULL-ptr backbone_gw set because
+			 * they already went through batadv_claim_release()
+			 */
+			if (!kref_get_unless_zero(&claim->refcount))
+				continue;
+
 			backbone_gw = batadv_bla_claim_get_backbone_gw(claim);
 			if (now)
 				goto purge_now;
@@ -1313,6 +1321,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 					      claim->addr, claim->vid);
 skip:
 			batadv_backbone_gw_put(backbone_gw);
+			batadv_claim_put(claim);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3a35aadd8b41..a4d33ee0fda5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -249,6 +249,7 @@ void batadv_mesh_free(struct net_device *mesh_iface)
 	atomic_set(&bat_priv->mesh_state, BATADV_MESH_DEACTIVATING);
 
 	batadv_purge_outstanding_packets(bat_priv, NULL);
+	batadv_tp_stop_all(bat_priv);
 
 	batadv_gw_node_free(bat_priv);
 
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 2e42f6b348c8..066c76113fc4 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -12,6 +12,7 @@
 #include <linux/byteorder/generic.h>
 #include <linux/cache.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/etherdevice.h>
@@ -365,23 +366,38 @@ static void batadv_tp_vars_put(struct batadv_tp_vars *tp_vars)
 }
 
 /**
- * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
- * @bat_priv: the bat priv with all the mesh interface information
- * @tp_vars: the private data of the current TP meter session to cleanup
+ * batadv_tp_list_detach() - remove tp session from mesh session list once
+ * @tp_vars: the private data of the current TP meter session
  */
-static void batadv_tp_sender_cleanup(struct batadv_priv *bat_priv,
-				     struct batadv_tp_vars *tp_vars)
+static void batadv_tp_list_detach(struct batadv_tp_vars *tp_vars)
 {
-	cancel_delayed_work(&tp_vars->finish_work);
+	bool detached = false;
 
 	spin_lock_bh(&tp_vars->bat_priv->tp_list_lock);
-	hlist_del_rcu(&tp_vars->list);
+	if (!hlist_unhashed(&tp_vars->list)) {
+		hlist_del_init_rcu(&tp_vars->list);
+		detached = true;
+	}
 	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
 
+	if (!detached)
+		return;
+
+	atomic_dec(&tp_vars->bat_priv->tp_num);
+
 	/* drop list reference */
 	batadv_tp_vars_put(tp_vars);
+}
 
-	atomic_dec(&tp_vars->bat_priv->tp_num);
+/**
+ * batadv_tp_sender_cleanup() - cleanup sender data and drop and timer
+ * @tp_vars: the private data of the current TP meter session to cleanup
+ */
+static void batadv_tp_sender_cleanup(struct batadv_tp_vars *tp_vars)
+{
+	cancel_delayed_work_sync(&tp_vars->finish_work);
+
+	batadv_tp_list_detach(tp_vars);
 
 	/* kill the timer and remove its reference */
 	timer_delete_sync(&tp_vars->timer);
@@ -886,7 +902,8 @@ static int batadv_tp_send(void *arg)
 	batadv_orig_node_put(orig_node);
 
 	batadv_tp_sender_end(bat_priv, tp_vars);
-	batadv_tp_sender_cleanup(bat_priv, tp_vars);
+	batadv_tp_sender_cleanup(tp_vars);
+	complete(&tp_vars->finished);
 
 	batadv_tp_vars_put(tp_vars);
 
@@ -918,7 +935,8 @@ static void batadv_tp_start_kthread(struct batadv_tp_vars *tp_vars)
 		batadv_tp_vars_put(tp_vars);
 
 		/* cleanup of failed tp meter variables */
-		batadv_tp_sender_cleanup(bat_priv, tp_vars);
+		batadv_tp_sender_cleanup(tp_vars);
+		complete(&tp_vars->finished);
 		return;
 	}
 
@@ -947,6 +965,13 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	/* look for an already existing test towards this node */
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE) {
+		spin_unlock_bh(&bat_priv->tp_list_lock);
+		batadv_tp_batctl_error_notify(BATADV_TP_REASON_DST_UNREACHABLE,
+					      dst, bat_priv, session_cookie);
+		return;
+	}
+
 	tp_vars = batadv_tp_list_find(bat_priv, dst);
 	if (tp_vars) {
 		spin_unlock_bh(&bat_priv->tp_list_lock);
@@ -969,6 +994,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
 	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		spin_unlock_bh(&bat_priv->tp_list_lock);
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
 			   "Meter: %s cannot allocate list elements\n",
@@ -1017,6 +1043,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->start_time = jiffies;
 
 	init_waitqueue_head(&tp_vars->more_bytes);
+	init_completion(&tp_vars->finished);
 
 	spin_lock_init(&tp_vars->unacked_lock);
 	INIT_LIST_HEAD(&tp_vars->unacked_list);
@@ -1119,14 +1146,7 @@ static void batadv_tp_receiver_shutdown(struct timer_list *t)
 		   "Shutting down for inactivity (more than %dms) from %pM\n",
 		   BATADV_TP_RECV_TIMEOUT, tp_vars->other_end);
 
-	spin_lock_bh(&tp_vars->bat_priv->tp_list_lock);
-	hlist_del_rcu(&tp_vars->list);
-	spin_unlock_bh(&tp_vars->bat_priv->tp_list_lock);
-
-	/* drop list reference */
-	batadv_tp_vars_put(tp_vars);
-
-	atomic_dec(&bat_priv->tp_num);
+	batadv_tp_list_detach(tp_vars);
 
 	spin_lock_bh(&tp_vars->unacked_lock);
 	list_for_each_entry_safe(un, safe, &tp_vars->unacked_list, list) {
@@ -1329,9 +1349,12 @@ static struct batadv_tp_vars *
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
-	struct batadv_tp_vars *tp_vars;
+	struct batadv_tp_vars *tp_vars = NULL;
 
 	spin_lock_bh(&bat_priv->tp_list_lock);
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out_unlock;
+
 	tp_vars = batadv_tp_list_find_session(bat_priv, icmp->orig,
 					      icmp->session);
 	if (tp_vars)
@@ -1344,8 +1367,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	}
 
 	tp_vars = kmalloc_obj(*tp_vars, GFP_ATOMIC);
-	if (!tp_vars)
+	if (!tp_vars) {
+		atomic_dec(&bat_priv->tp_num);
 		goto out_unlock;
+	}
 
 	ether_addr_copy(tp_vars->other_end, icmp->orig);
 	tp_vars->role = BATADV_TP_RECEIVER;
@@ -1464,6 +1489,9 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 {
 	struct batadv_icmp_tp_packet *icmp;
 
+	if (atomic_read(&bat_priv->mesh_state) != BATADV_MESH_ACTIVE)
+		goto out;
+
 	icmp = (struct batadv_icmp_tp_packet *)skb->data;
 
 	switch (icmp->subtype) {
@@ -1478,9 +1506,57 @@ void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb)
 			   "Received unknown TP Metric packet type %u\n",
 			   icmp->subtype);
 	}
+
+out:
 	consume_skb(skb);
 }
 
+/**
+ * batadv_tp_stop_all() - stop all currently running tp meter sessions
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
+void batadv_tp_stop_all(struct batadv_priv *bat_priv)
+{
+	struct batadv_tp_vars *tp_vars[BATADV_TP_MAX_NUM];
+	struct batadv_tp_vars *tp_var;
+	size_t count = 0;
+	size_t i;
+
+	spin_lock_bh(&bat_priv->tp_list_lock);
+	hlist_for_each_entry(tp_var, &bat_priv->tp_list, list) {
+		if (WARN_ON_ONCE(count >= BATADV_TP_MAX_NUM))
+			break;
+
+		if (!kref_get_unless_zero(&tp_var->refcount))
+			continue;
+
+		tp_vars[count++] = tp_var;
+	}
+	spin_unlock_bh(&bat_priv->tp_list_lock);
+
+	for (i = 0; i < count; i++) {
+		tp_var = tp_vars[i];
+
+		switch (tp_var->role) {
+		case BATADV_TP_SENDER:
+			batadv_tp_sender_shutdown(tp_var,
+						  BATADV_TP_REASON_CANCEL);
+			wake_up(&tp_var->more_bytes);
+			wait_for_completion(&tp_var->finished);
+			break;
+		case BATADV_TP_RECEIVER:
+			batadv_tp_list_detach(tp_var);
+			if (timer_shutdown_sync(&tp_var->timer))
+				batadv_tp_vars_put(tp_var);
+			break;
+		}
+
+		batadv_tp_vars_put(tp_var);
+	}
+
+	synchronize_net();
+}
+
 /**
  * batadv_tp_meter_init() - initialize global tp_meter structures
  */
diff --git a/net/batman-adv/tp_meter.h b/net/batman-adv/tp_meter.h
index f0046d366eac..4e97cd10cd02 100644
--- a/net/batman-adv/tp_meter.h
+++ b/net/batman-adv/tp_meter.h
@@ -17,6 +17,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 		     u32 test_length, u32 *cookie);
 void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
 		    u8 return_value);
+void batadv_tp_stop_all(struct batadv_priv *bat_priv);
 void batadv_tp_meter_recv(struct batadv_priv *bat_priv, struct sk_buff *skb);
 
 #endif /* _NET_BATMAN_ADV_TP_METER_H_ */
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8fc5fe0e9b05..daa06f421154 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -14,6 +14,7 @@
 #include <linux/average.h>
 #include <linux/bitops.h>
 #include <linux/compiler.h>
+#include <linux/completion.h>
 #include <linux/if.h>
 #include <linux/if_ether.h>
 #include <linux/kref.h>
@@ -1328,6 +1329,9 @@ struct batadv_tp_vars {
 	/** @finish_work: work item for the finishing procedure */
 	struct delayed_work finish_work;
 
+	/** @finished: completion signaled when a sender thread exits */
+	struct completion finished;
+
 	/** @test_length: test length in milliseconds */
 	u32 test_length;
 
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 05fb00c9c335..48759da0a026 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1986,6 +1986,15 @@ static int sctp_sendmsg(struct sock *sk, struct msghdr *msg, size_t msg_len)
 				goto out_unlock;
 
 			iov_iter_revert(&msg->msg_iter, err);
+
+			/* sctp_sendmsg_to_asoc() may have released the socket
+			 * lock (sctp_wait_for_sndbuf), during which other
+			 * associations on ep->asocs could have been peeled
+			 * off or freed.  @asoc itself is revalidated by the
+			 * base.dead and base.sk checks in sctp_wait_for_sndbuf,
+			 * so re-derive the cached cursor from it.
+			 */
+			tmp = list_next_entry(asoc, asocs);
 		}
 
 		goto out_unlock;
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index d912ed2f012a..08f4dfb9782c 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1951,12 +1951,12 @@ static void vsock_update_buffer_size(struct vsock_sock *vsk,
 				     const struct vsock_transport *transport,
 				     u64 val)
 {
-	if (val > vsk->buffer_max_size)
-		val = vsk->buffer_max_size;
-
 	if (val < vsk->buffer_min_size)
 		val = vsk->buffer_min_size;
 
+	if (val > vsk->buffer_max_size)
+		val = vsk->buffer_max_size;
+
 	if (val != vsk->buffer_size &&
 	    transport && transport->notify_buffer_size)
 		transport->notify_buffer_size(vsk, &val);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 8a9fb23c6e85..6547e199ea5b 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -139,27 +139,6 @@ static void virtio_transport_init_hdr(struct sk_buff *skb,
 	hdr->fwd_cnt	= cpu_to_le32(0);
 }
 
-static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
-						void *dst,
-						size_t len)
-{
-	struct iov_iter iov_iter = { 0 };
-	struct kvec kvec;
-	size_t to_copy;
-
-	kvec.iov_base = dst;
-	kvec.iov_len = len;
-
-	iov_iter.iter_type = ITER_KVEC;
-	iov_iter.kvec = &kvec;
-	iov_iter.nr_segs = 1;
-
-	to_copy = min_t(size_t, len, skb->len);
-
-	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
-			       &iov_iter, to_copy);
-}
-
 /* Packet capture */
 static struct sk_buff *virtio_transport_build_skb(void *opaque)
 {
@@ -169,12 +148,12 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	struct sk_buff *skb;
 	size_t payload_len;
 
-	/* A packet could be split to fit the RX buffer, so we can retrieve
-	 * the payload length from the header and the buffer pointer taking
-	 * care of the offset in the original packet.
+	/* A packet could be split to fit the RX buffer, so we use
+	 * the payload length from the header, which has been updated
+	 * by the sender to reflect the fragment size.
 	 */
 	pkt_hdr = virtio_vsock_hdr(pkt);
-	payload_len = pkt->len;
+	payload_len = le32_to_cpu(pkt_hdr->len);
 
 	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
 			GFP_ATOMIC);
@@ -217,12 +196,18 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
 
 	if (payload_len) {
-		if (skb_is_nonlinear(pkt)) {
-			void *data = skb_put(skb, payload_len);
-
-			virtio_transport_copy_nonlinear_skb(pkt, data, payload_len);
-		} else {
-			skb_put_data(skb, pkt->data, payload_len);
+		struct iov_iter iov_iter;
+		struct kvec kvec;
+		void *data = skb_put(skb, payload_len);
+
+		kvec.iov_base = data;
+		kvec.iov_len = payload_len;
+		iov_iter_kvec(&iov_iter, ITER_DEST, &kvec, 1, payload_len);
+
+		if (skb_copy_datagram_iter(pkt, VIRTIO_VSOCK_SKB_CB(pkt)->offset,
+					   &iov_iter, payload_len)) {
+			kfree_skb(skb);
+			return NULL;
 		}
 	}
 
@@ -547,9 +532,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 
@@ -1560,8 +1544,6 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return -ENOMEM;
 	}
 
-	sk_acceptq_added(sk);
-
 	lock_sock_nested(child, SINGLE_DEPTH_NESTING);
 
 	child->sk_state = TCP_ESTABLISHED;
@@ -1583,6 +1565,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		return ret;
 	}
 
+	sk_acceptq_added(sk);
 	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index dc5f94862a3b..dc1df2d57ddc 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -211,10 +211,10 @@ ifneq ($(strip $(ORPHAN_FILES)),)
 
 # Message for $(call echo-cmd,rm). Generally cleaning files isn't part
 # of a build step.
-quiet_cmd_rm  = RM      $^
+quiet_cmd_rm = RM      ...$(words $^) orphan file(s)...
 
+# The list of files can be long. Use xargs to prevent issues.
 prune_orphans: $(ORPHAN_FILES)
-	# The list of files can be long. Use xargs to prevent issues.
 	$(Q)$(call echo-cmd,rm)echo "$^" | xargs rm -f
 
 JEVENTS_DEPS += prune_orphans
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index 6299c76c3b7d..79d34f448217 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1071,8 +1071,17 @@ static inline void vma_set_anonymous(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline int __compat_vma_mmap(const struct file_operations *f_op,
-		struct file *file, struct vm_area_struct *vma)
+static inline unsigned long vma_pages(struct vm_area_struct *vma)
+{
+	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
+}
+
+static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
+static inline int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
@@ -1082,14 +1091,14 @@ static inline int __compat_vma_mmap(const struct file_operations *f_op,
 
 		.pgoff = vma->vm_pgoff,
 		.vm_file = vma->vm_file,
-		.vm_flags = vma->vm_flags,
+		.vma_flags = vma->flags,
 		.page_prot = vma->vm_page_prot,
 
 		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
-	err = f_op->mmap_prepare(&desc);
+	err = vfs_mmap_prepare(file, &desc);
 	if (err)
 		return err;
 
@@ -1098,27 +1107,22 @@ static inline int __compat_vma_mmap(const struct file_operations *f_op,
 		return err;
 
 	set_vma_from_desc(vma, &desc);
-	return mmap_action_complete(vma, &desc.action);
-}
+	err = mmap_action_complete(vma, &desc.action,
+				   /*is_compat=*/true);
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
 
-static inline int compat_vma_mmap(struct file *file,
-		struct vm_area_struct *vma)
-{
-	return __compat_vma_mmap(file->f_op, file, vma);
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+	}
+	return err;
 }
 
-
 static inline void vma_iter_init(struct vma_iterator *vmi,
 		struct mm_struct *mm, unsigned long addr)
 {
 	mas_init(&vmi->mas, &mm->mm_mt, addr);
 }
 
-static inline unsigned long vma_pages(struct vm_area_struct *vma)
-{
-	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-}
-
 static inline void mmap_assert_locked(struct mm_struct *);
 static inline struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
 						unsigned long start_addr,
@@ -1309,11 +1313,6 @@ static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }
 
-static inline int vfs_mmap_prepare(struct file *file, struct vm_area_desc *desc)
-{
-	return file->f_op->mmap_prepare(desc);
-}
-
 static inline void vma_set_file(struct vm_area_struct *vma, struct file *file)
 {
 	/* Changing an anonymous vma with this is illegal */
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index 11192a6c6978..c56d96979d4d 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -87,7 +87,8 @@ static inline int mmap_action_prepare(struct vm_area_desc *desc)
 }
 
 static inline int mmap_action_complete(struct vm_area_struct *vma,
-				       struct mmap_action *action)
+				       struct mmap_action *action,
+				       bool is_compat)
 {
 	return 0;
 }

